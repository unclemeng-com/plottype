'Drop table bvfilemst;
CREATE TABLE bvfilemst
(
  id VARCHAR(10) NOT NULL,
  filename VARCHAR(150) NOT NULL,
  filetype VARCHAR(10) NOT NULL,
  PRIMARY KEY(id)
);
comment on table bvfilemst is '業務機能比較表・ファイル一覧';
comment on column bvfilemst.id is 'ファイル名・ID(3桁数字)';
comment on column bvfilemst.filename is '業務機能比較表ファイル名';
comment on column bvfilemst.filetype is '分野';
''''select * from bvspecmst order by id;

'Drop table bvspecmst;
CREATE TABLE bvspecmst
(
  id VARCHAR(10) NOT NULL,
  bvspec VARCHAR(20000) NOT NULL,
  row_no_strt int,
  row_no_end int,
  PRIMARY KEY(id)
);
comment on table bvspecmst is '業務機能比較表・BV仕様マスタ';
comment on column bvspecmst.id is 'BV仕様・ID';
comment on column bvspecmst.bvspec is 'BV仕様';
comment on column bvspecmst.row_no_strt is '行Start';
comment on column bvspecmst.row_no_end is '行End';

'select * from bvproperspecmst;
'Drop table bvproperspecmst;
create table "public".bvproperspecmst (
  id character varying(10) not null, 
  bvproperspec character varying(20000) not null,
  row_no_strt int,
  row_no_end int,
  primary key (id)
);
comment on table bvproperspecmst is '業務機能比較表・プロパー仕様マスタ';
comment on column bvproperspecmst.id is 'BVプロパー仕様・ID';
comment on column bvproperspecmst.bvproperspec is 'BVプロパー仕様';
comment on column bvproperspecmst.row_no_strt is '行Start';
comment on column bvproperspecmst.row_no_end is '行End';

'Drop table bvjasspecmst;
create table "public".bvjasspecmst (
  id character varying(10) not null, 
  bvjasspec character varying(20000) not null,
  row_no_strt int,
  row_no_end int,
  primary key (id)
);

comment on table bvjasspecmst is '業務機能比較表・JASTEM仕様マスタ';
comment on column bvjasspecmst.id is 'JASTEM仕様・ID';
comment on column bvjasspecmst.bvjasspec is 'JASTEM仕様';
comment on column bvjasspecmst.row_no_strt is '行Start';
comment on column bvjasspecmst.row_no_end is '行End';

'drop table bvanalysis;
create table "public".bvanalysis (
  id serial not null
  , bvfilemst_id character varying(10)
  , row_no_strt integer
  , row_no_end  integer
  , number character varying(10)
  , bvspecmst_id	character varying(10)
  , bvproperspecmst_id character varying(10)
  , bvjasspecmst_id character varying(10)
  , analysis character varying(10000)
  , devtype character varying(10)
  , devscale character varying(10)
  , biztranstype character varying(10)
  , biztransscale character varying(10)
  , opepolicy character varying(10)
  , opetype character varying(10)
  , pageinfo character varying(30000)
  , pageno character varying(500)
  , primary key (id)
  , foreign key (bvspecmst_id) references bvspecmst(id)
  , foreign key (bvproperspecmst_id) references bvproperspecmst(id)
  , foreign key (bvjasspecmst_id) references bvjasspecmst(id)
  , foreign key (bvfilemst_id) references bvfilemst(id)
);
comment on table bvanalysis is '業務機能比較表・分析結果一覧';
comment on column bvanalysis.id is '分析結果・ID';
comment on column bvanalysis.bvfilemst_id is 'ファイル名・ID(3桁数字)';
comment on column bvanalysis.row_no_strt is '行Start';
comment on column bvanalysis.row_no_end is '行End';
comment on column bvanalysis.number is '番号';
comment on column bvanalysis.bvspecmst_id is 'BV仕様・ID';
comment on column bvanalysis.bvproperspecmst_id is 'BVプロパー仕様・ID';
comment on column bvanalysis.bvjasspecmst_id is 'JASTEM仕様・ID';
comment on column bvanalysis.analysis is '分析';
comment on column bvanalysis.devtype is '開発区分';
comment on column bvanalysis.devscale is '開発規模';
comment on column bvanalysis.biztranstype is '事務移行対応区分';
comment on column bvanalysis.biztransscale is '影響顧客/口座数';
comment on column bvanalysis.opepolicy is '対応方針';
comment on column bvanalysis.opetype is '方針区分';
comment on column bvanalysis.pageinfo is '頁情報';
comment on column bvanalysis.pageno is '頁No';
drop table bvshape;
'drop table shape;
create table "public".bvshape (
  id serial not null
  , 	bvfilemst_id
 character varying(10)
  , position_top real
  , position_left real
  , shape_width real
  , shape_height real
  , shape_link character varying(200)
  , primary key (id)
  , foreign key (bvfilemst_id) references bvfilemst(id)
);
comment on table bvshape is '業務機能比較表・図表テーブル';
comment on column bvshape.id is '図表テーブル・ID';
comment on column bvshape.bvfilemst_id is 'ファイル名・ID(3桁数字)';
comment on column bvshape.position_top is 'Position Top';
comment on column bvshape.position_left is 'Position Left';
comment on column bvshape.shape_width is '図表幅';
comment on column bvshape.shape_height is '図表高';
comment on column bvshape.shape_link is '図表リンク';

'truncate table bvanalysis,bvspecmst,bvproperspecmst,bvjasspecmst;
'drop view show_all;
create view show_all
as
select an.id,an.bvfilemst_id,fl.filename,an.number,bv.bvspec,pr.bvproperspec,ja.bvjasspec,an.analysis,an.devtype,an.devscale,an.biztranstype,an.biztransscale,an.opepolicy,an.opetype,an.pageinfo,an.pageno
from bvanalysis as an
left join bvfilemst as fl on an.bvfilemst_id = fl.id
left join bvspecmst as bv on an.bvspecmst_id = bv.id
left join bvproperspecmst as pr on an.bvproperspecmst_id = pr.id
left join bvjasspecmst as ja on an.bvjasspecmst_id = ja.id
order by an.bvfilemst_id ASC,an.row_no_strt ASC
;
'select *  from show_all;
