
### Temizlenmis veri setinin cagirilmasi 
########################################

#install.packages("googledrive")
#install.packages("dplyr")

########
# library(googledrive)
# library(dplyr)
# drive_deauth()
# temp = tempfile(fileext = ".csv")
# fileFromDrive = drive_download(as_id("1gf3_b_1qxT46GegUEKjnAerKNdgBDRim"), path = temp, overwrite = TRUE)
# 
# cleanedDataFile = read.csv(temp,header = T, sep = ",", dec = ".", stringsAsFactors = T)
# summary(cleanedDataFile)
########

cleanedDataFile = read.csv(file = "./veri-on-isleme/genel-temizlik.csv", header = T, sep = ",", dec = ".", stringsAsFactors = T)
cleanedDataFile<-cleanedDataFile[,-1]
cleanedDataFile = na.omit(cleanedDataFile)
summary(cleanedDataFile)

cleanedDataFile$age_60_and_above = as.factor(cleanedDataFile$age_60_and_above)
cleanedDataFile$gender = as.factor(cleanedDataFile$gender)
cleanedDataFile$test_indication = as.factor(cleanedDataFile$test_indication)
cleanedDataFile$cough = as.factor(cleanedDataFile$cough)
cleanedDataFile$fever = as.factor(cleanedDataFile$fever)
cleanedDataFile$sore_throat = as.factor(cleanedDataFile$sore_throat)
cleanedDataFile$shortness_of_breath = as.factor(cleanedDataFile$shortness_of_breath)
cleanedDataFile$head_ache = as.factor(cleanedDataFile$head_ache)
cleanedDataFile$corona_result = as.factor(cleanedDataFile$corona_result)

l1= as.data.frame(cleanedDataFile$corona_result[cleanedDataFile$corona_result=="negative"])
l2=as.data.frame(cleanedDataFile$corona_result[cleanedDataFile$corona_result=="positive"])
fark=nrow(l1)-nrow(l2)

summary(cleanedDataFile)
set.seed(1) 
samp = sample(which(cleanedDataFile$corona_result=="negative"), size = fark)
cleanedDataFile = cleanedDataFile[-samp, ]
summary(cleanedDataFile)


# ek <- c(0,0,0,0,0,"negative","Yes","female","Abroad")
# ek1 <- c(0,0,0,0,0,"negative","Yes","male","Abroad")
# ek2 <- c(0,0,0,0,0,"negative","No","female","Abroad")
# ek3 <- c(0,0,0,0,0,"negative","No","male","Abroad")

# cleanedDataFile <-rbind(cleanedDataFile,ek,ek1,ek2,ek3)
# tail(cleanedDataFile)

### Eksiklerin silinmesi
########################

# cleanedDataFile = filter(cleanedDataFile, age_60_and_above != "NA")
# cleanedDataFile = filter(cleanedDataFile, gender != "NA")
# cleanedDataFile<-cleanedDataFile[,-1]
# nrow(cleanedDataFile[duplicated(cleanedDataFile)==TRUE,]) 
#write.csv(cleanedDataFile, "ekstra-temizlenmis-veri-seti.csv", row.names = TRUE)


#Hold Out

library(caret) 
set.seed(10) 
egitimIndisleri <- createDataPartition(y = cleanedDataFile$corona_result, p = .70, list = FALSE)  

dengeliEgitim <- cleanedDataFile[egitimIndisleri,] 
dengeliTest <- cleanedDataFile[-egitimIndisleri,] 
table(dengeliEgitim$corona_result)
table(dengeliTest$corona_result)


write.csv(dengeliEgitim, "./veri-on-isleme/1-2_na-silme/random_dengeleme_egitim.csv")
write.csv(dengeliTest, "./veri-on-isleme/1-2_na-silme/random_dengeleme_test.csv")


### OverSampling
################



# library(ROSE) 
# over_norws <-nrow(EgitimDengesiz[EgitimDengesiz$corona_result=="positive",])*2
# EgitimDengli <- EgitimDengesiz
# EgitimDengli <- ovun.sample(corona_result ~ ., data = EgitimDengli, method="over",N=over_norws)$data
# 
# summary(EgitimDengli)
# str(EgitimDengli)
# table(EgitimDengli$corona_result)
# write.csv(EgitimDengli, "eksikleri_silindi_egitim_dengeli.csv")
