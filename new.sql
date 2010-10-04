-- Database: "TP1"

-- DROP DATABASE "TP1";

CREATE DATABASE "TP1"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'French, Canada'
       LC_CTYPE = 'French, Canada'
       CONNECTION LIMIT = -1;
/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     2009-01-07 12:18:32                          */
/*==============================================================*/


/*==============================================================*/
/* Table: arbitre                                               */
/*==============================================================*/
create table arbitre (
   arbitreid            INT4                 not null,
   arbitrenom           VARCHAR(64)          not null,
   arbitreprenom        VARCHAR(64)          not null,
   constraint pk_arbitre primary key (arbitreid)
);

/*==============================================================*/
/* Index: arbitre_pk                                            */
/*==============================================================*/
create unique index arbitre_pk on arbitre (
arbitreid
);

/*==============================================================*/
/* Table: arbitrer                                              */
/*==============================================================*/
create table arbitrer (
   arbitreid            INT4                 not null,
   matchid              INT4                 not null,
   constraint pk_arbitrer primary key (arbitreid, matchid)
);

/*==============================================================*/
/* Index: arbitrer_pk                                           */
/*==============================================================*/
create unique index arbitrer_pk on arbitrer (
arbitreid,
matchid
);

/*==============================================================*/
/* Table: equipe                                                */
/*==============================================================*/
create table equipe (
   equipeid             INT4                 not null,
   terrainid            INT4                 null,
   equipenom            VARCHAR(64)          not null,
   constraint pk_equipe primary key (equipeid)
);

/*==============================================================*/
/* Index: equipe_pk                                             */
/*==============================================================*/
create unique index equipe_pk on equipe (
equipeid
);

/*==============================================================*/
/* Table: faitpartie                                            */
/*==============================================================*/
create table faitpartie (
   joueurid             INT4                 not null,
   equipeid             INT4                 not null,
   numero               INT4                 not null,
   datedebut            DATE                 not null,
   datefin              DATE                 null,
   constraint pk_faitpartie primary key (joueurid, equipeid)
);

/*==============================================================*/
/* Index: faitpartie_pk                                         */
/*==============================================================*/
create unique index faitpartie_pk on faitpartie (
joueurid,
equipeid
);

/*==============================================================*/
/* Table: joueur                                                */
/*==============================================================*/
create table joueur (
   joueurid             INT4                 not null,
   joueurnom            VARCHAR(64)          not null,
   joueurprenom         VARCHAR(64)          not null,
   constraint pk_joueur primary key (joueurid)
);

/*==============================================================*/
/* Index: joueur_pk                                             */
/*==============================================================*/
create unique index joueur_pk on joueur (
joueurid
);

/*==============================================================*/
/* Table: match                                                 */
/*==============================================================*/
create table match (
   matchid              INT4                 not null,
   equipelocal          INT4                 null,
   equipevisiteur       INT4                 null,
   terrainid            INT4                 null,
   matchdate            DATE                 null,
   matchheure           TIME                 null,
   pointslocal          INT4                 null,
   pointsvisiteur       INT4                 null,
   constraint pk_match primary key (matchid)
);

/*==============================================================*/
/* Index: match_pk                                              */
/*==============================================================*/
create unique index match_pk on match (
matchid
);

/*==============================================================*/
/* Table: participe                                             */
/*==============================================================*/
create table participe (
   joueurid             INT4                 not null,
   matchid              INT4                 not null,
   commentaireperformance VARCHAR(128)         null,
   constraint pk_participe primary key (joueurid, matchid)
);

/*==============================================================*/
/* Index: participe_pk                                          */
/*==============================================================*/
create unique index participe_pk on participe (
joueurid,
matchid
);

/*==============================================================*/
/* Table: terrain                                               */
/*==============================================================*/
create table terrain (
   terrainid            INT4                 not null,
   terrainnom           VARCHAR(64)          not null,
   terrainadresse       VARCHAR(128)         not null,
   constraint pk_terrain primary key (terrainid)
);

/*==============================================================*/
/* Index: terrain_pk                                            */
/*==============================================================*/
create unique index terrain_pk on terrain (
terrainid
);

alter table arbitrer
   add constraint fk_arbitrer_arbitrer_arbitre foreign key (arbitreid)
      references arbitre (arbitreid)
      on delete restrict on update restrict;

alter table arbitrer
   add constraint fk_arbitrer_arbitrer2_match foreign key (matchid)
      references match (matchid)
      on delete restrict on update restrict;

alter table equipe
   add constraint fk_equipe_estequipe_terrain foreign key (terrainid)
      references terrain (terrainid)
      on delete restrict on update restrict;

alter table faitpartie
   add constraint fk_faitpart_faitparti_joueur foreign key (joueurid)
      references joueur (joueurid)
      on delete restrict on update restrict;

alter table faitpartie
   add constraint fk_faitpart_faitparti_equipe foreign key (equipeid)
      references equipe (equipeid)
      on delete restrict on update restrict;

alter table match
   add constraint fk_match_equipeloc_equipe foreign key (equipelocal)
      references equipe (equipeid)
      on delete restrict on update restrict;

alter table match
   add constraint fk_match_equipevis_equipe foreign key (equipevisiteur)
      references equipe (equipeid)
      on delete restrict on update restrict;

alter table match
   add constraint fk_match_estjoue_terrain foreign key (terrainid)
      references terrain (terrainid)
      on delete restrict on update restrict;

alter table participe
   add constraint fk_particip_participe_joueur foreign key (joueurid)
      references joueur (joueurid)
      on delete restrict on update restrict;

alter table participe
   add constraint fk_particip_participe_match foreign key (matchid)
      references match (matchid)
      on delete restrict on update restrict;

