library(tidyverse)

# Cargo Datos
Nombre_salario <- read_csv("dat/Nombre_salario.csv")
genero <- read_csv("dat/genero.csv")


# Wrangling

## Nombres
Nombre_salario <- Nombre_salario %>% 
    rename("Salario_Promedio" = `Salario Promedio`)
colnames(Nombre_salario) <- toupper( colnames(Nombre_salario) )


genero <- genero %>%
    rename("Nombre" = Nombres)
colnames(genero) <- toupper( colnames(genero) )


## Casos Duplicados
Nombre_salario <- Nombre_salario %>% 
    filter( ! duplicated(Nombre_salario) )

genero <- genero %>% 
    filter( ! duplicated(genero) )


## Indice
Nombre_salario <- Nombre_salario %>% 
    mutate( indice_Nombre_salario = (1:n()) )

genero <- genero %>% 
    mutate( indice_genero = (1:n()) )



# Joins

datos <- Nombre_salario %>% 
    left_join(genero, by = c("NOMBRE", "EDAD") )


# Reordenar

Individuos <- datos %>% 
    select(NOMBRE, EDAD, genero, CARRERA)

Carrera <- datos %>% 
    select(CARRERA, SALARIO_PROMEDIO)
Carrera <- Carrera %>% 
    filter( ! duplicated(Carrera) )

# Crear IDs
Individuos <- Individuos %>% 
    mutate( ID_ind = (1:n()) )

Individuos


# Corregir datos Errones
Carrera$SALARIO_PROMEDIO[Carrera$CARRERA=="Sociología"] <- 40000



# Guardar

write_csv(Carrera, "dat/Carrera.csv")
write_csv(Individuos, "dat/Individuos.csv")

