Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D7FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DB52184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qMHYHAq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDEFZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:25:50 -0400
Received: from mail-eopbgr800083.outbound.protection.outlook.com ([40.107.80.83]:19536
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbfDEFZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiEkkyIJJ6qHw0yRPjHxD3lG3xO92t52LVW1jVvl3pw=;
 b=qMHYHAq1fNHcS5ez3Q1aLzis8D+E4Bdvrl2EAHTWSIB2IwbN+/lBBmNzGO2noPJrA9FpdwMvdcuctcA9iQblAKhgssUstCSryykyhSxIsQwWmBcV5U1vlr23dBOaQQzRbK0ZD5CmG168HbciSleIpCkDCYisHpx5t/MYUDH3gIo=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3166.namprd02.prod.outlook.com (10.164.204.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Fri, 5 Apr 2019 05:25:41 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e%6]) with mapi id 15.20.1771.016; Fri, 5 Apr 2019
 05:25:41 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
Subject: RE: [LINUX PATCH v2 3/3] spi: spi-mem: Add support for Zynq QSPI
 controller
Thread-Topic: [LINUX PATCH v2 3/3] spi: spi-mem: Add support for Zynq QSPI
 controller
Thread-Index: AQHU6GDoVyYcIUsosU+lZrvEQXMozqYtA4SAgAAIwOA=
Date:   Fri, 5 Apr 2019 05:25:40 +0000
Message-ID: <MWHPR02MB2623EDDF4207C7CA8F97B5D4AF510@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1554105553-20207-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <c8f73eab-99eb-ddbc-9776-ea6b3a3ecf0f@ti.com>
In-Reply-To: <c8f73eab-99eb-ddbc-9776-ea6b3a3ecf0f@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a04a48e-c126-4b2b-5e92-08d6b98724e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MWHPR02MB3166;
x-ms-traffictypediagnostic: MWHPR02MB3166:
x-microsoft-antispam-prvs: <MWHPR02MB316688F574C6F27E51784C34AF510@MWHPR02MB3166.namprd02.prod.outlook.com>
x-forefront-prvs: 0998671D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(366004)(136003)(13464003)(199004)(189003)(51914003)(2906002)(8676002)(71190400001)(53936002)(7416002)(99286004)(256004)(66066001)(68736007)(486006)(476003)(4326008)(33656002)(478600001)(74316002)(71200400001)(14454004)(55016002)(446003)(9686003)(11346002)(305945005)(7736002)(6246003)(54906003)(6116002)(2501003)(3846002)(25786009)(229853002)(52536014)(81156014)(5660300002)(76176011)(53546011)(110136005)(97736004)(7696005)(102836004)(26005)(6506007)(86362001)(105586002)(186003)(316002)(8936002)(106356001)(6436002)(81166006)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3166;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YT1+jB/8+ae9M5FPkQ2TX4eiFbgWmcQ0pX6GtFCcBZVuNlOmoMovAlZiKD2JV4uoB7V51qc/brdOjkH1omcxug5rkpNmqfxdt43PbEfE5xMtR2E3pSzf9uP/R/CDyAg7MKrTabZn+onja6ac8lPIzMn1Dnhf3parMgNNb/3xnCgVRX671b7YNr8Pv7XI9hYVJDKYhaEl7psESq6XS9ZSY/4Y6g6+2lIoG1ZvCmT6PYJxTzp7JgSqXU5eQAs0ywG2WnKuDOOLgGKS9HrgO1keltAr13h2fQzjaNWAcJDbSJBcFFV+E9EasA2jgoMGx6unUJbctDot2Gt+DN+cVJB5oh8EYd8hcRtZ4vfFDE0sQ6g3YXjlnvbC8Wh6T2H0ve2PeWZGjlGmCDOWsvWX4bkniaJUjtzJJVH+FKW6RRVszrQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a04a48e-c126-4b2b-5e92-08d6b98724e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2019 05:25:40.9334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRpLmNv
bT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCA1LCAyMDE5IDEwOjE0IEFNDQo+IFRvOiBOYWdhIFN1
cmVzaGt1bWFyIFJlbGxpIDxuYWdhc3VyZUB4aWxpbnguY29tPjsgYnJvb25pZUBrZXJuZWwub3Jn
Ow0KPiBiYnJlemlsbG9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5v
cmc7IGR3bXcyQGluZnJhZGVhZC5vcmc7IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsNCj4gcmljaGFy
ZEBub2QuYXQ7IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbHNAeGlsaW54LmNvbT47IG5hZ2Fz
dXJlc2gxMkBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtMSU5VWCBQQVRDSCB2MiAzLzNdIHNw
aTogc3BpLW1lbTogQWRkIHN1cHBvcnQgZm9yIFp5bnEgUVNQSSBjb250cm9sbGVyDQo+IA0KPiAN
Cj4gDQo+IE9uIDAxLzA0LzE5IDE6MjkgUE0sIE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgd3JvdGU6
DQo+ID4gKy8qKg0KPiA+ICsgKiB6eW5xX3FzcGlfY29uZmlnX29wIC0gQ29uZmlndXJlIFFTUEkg
Y29udHJvbGxlciBmb3Igc3BlY2lmaWVkIHRyYW5zZmVyDQo+ID4gKyAqIEB4cXNwaToJUG9pbnRl
ciB0byB0aGUgenlucV9xc3BpIHN0cnVjdHVyZQ0KPiA+ICsgKiBAcXNwaToJUG9pbnRlciB0byB0
aGUgc3BpX2RldmljZSBzdHJ1Y3R1cmUNCj4gPiArICoNCj4gPiArICogU2V0cyB0aGUgb3BlcmF0
aW9uYWwgbW9kZSBvZiBRU1BJIGNvbnRyb2xsZXIgZm9yIHRoZSBuZXh0IFFTUEkNCj4gPiArdHJh
bnNmZXIgYW5kDQo+ID4gKyAqIHNldHMgdGhlIHJlcXVlc3RlZCBjbG9jayBmcmVxdWVuY3kuDQo+
ID4gKyAqDQo+ID4gKyAqIFJldHVybjoJMCBvbiBzdWNjZXNzIGFuZCAtRUlOVkFMIG9uIGludmFs
aWQgaW5wdXQgcGFyYW1ldGVyDQo+ID4gKyAqDQo+ID4gKyAqIE5vdGU6IElmIHRoZSByZXF1ZXN0
ZWQgZnJlcXVlbmN5IGlzIG5vdCBhbiBleGFjdCBtYXRjaCB3aXRoIHdoYXQNCj4gPiArY2FuIGJl
DQo+ID4gKyAqIG9idGFpbmVkIHVzaW5nIHRoZSBwcmVzY2FsYXIgdmFsdWUsIHRoZSBkcml2ZXIg
c2V0cyB0aGUgY2xvY2sNCj4gPiArZnJlcXVlbmN5IHdoaWNoDQo+ID4gKyAqIGlzIGxvd2VyIHRo
YW4gdGhlIHJlcXVlc3RlZCBmcmVxdWVuY3kgKG1heGltdW0gbG93ZXIpIGZvciB0aGUNCj4gPiAr
dHJhbnNmZXIuIElmDQo+ID4gKyAqIHRoZSByZXF1ZXN0ZWQgZnJlcXVlbmN5IGlzIGhpZ2hlciBv
ciBsb3dlciB0aGFuIHRoYXQgaXMgc3VwcG9ydGVkDQo+ID4gK2J5IHRoZSBRU1BJDQo+ID4gKyAq
IGNvbnRyb2xsZXIgdGhlIGRyaXZlciB3aWxsIHNldCB0aGUgaGlnaGVzdCBvciBsb3dlc3QgZnJl
cXVlbmN5DQo+ID4gK3N1cHBvcnRlZCBieQ0KPiA+ICsgKiBjb250cm9sbGVyLg0KPiA+ICsgKi8N
Cj4gPiArc3RhdGljIGludCB6eW5xX3FzcGlfY29uZmlnX29wKHN0cnVjdCB6eW5xX3FzcGkgKnhx
c3BpLCBzdHJ1Y3QNCj4gPiArc3BpX2RldmljZSAqc3BpKSB7DQo+ID4gKwl1MzIgY29uZmlnX3Jl
ZywgYmF1ZF9yYXRlX3ZhbCA9IDA7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIFNldCB0aGUg
Y2xvY2sgZnJlcXVlbmN5DQo+ID4gKwkgKiBUaGUgYmF1ZCByYXRlIGRpdmlzb3IgaXMgbm90IGEg
ZGlyZWN0IG1hcHBpbmcgdG8gdGhlIHZhbHVlIHdyaXR0ZW4NCj4gPiArCSAqIGludG8gdGhlIGNv
bmZpZ3VyYXRpb24gcmVnaXN0ZXIgKGNvbmZpZ19yZWdbNTozXSkNCj4gPiArCSAqIGkuZS4gMDAw
IC0gZGl2aWRlIGJ5IDINCj4gPiArCSAqICAgICAgMDAxIC0gZGl2aWRlIGJ5IDQNCj4gPiArCSAq
ICAgICAgLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsJICogICAgICAxMTEgLSBkaXZpZGUgYnkgMjU2
DQo+ID4gKwkgKi8NCj4gPiArCXdoaWxlICgoYmF1ZF9yYXRlX3ZhbCA8IFpZTlFfUVNQSV9CQVVE
X0RJVl9NQVgpICAmJg0KPiA+ICsJICAgICAgIChjbGtfZ2V0X3JhdGUoeHFzcGktPnJlZmNsaykg
LyAoMiA8PCBiYXVkX3JhdGVfdmFsKSkgPg0KPiA+ICsJCXNwaS0+bWF4X3NwZWVkX2h6KQ0KPiA+
ICsJCWJhdWRfcmF0ZV92YWwrKzsNCj4gPiArDQo+IA0KPiBJbnN0ZWFkIHVzZSBESVZfUk9VTkRf
VVAsIHNvbWV0aGluZyBsaWtlIGJlbG93IHNob3VsZCB3b3JrKHVudGVzdGVkKToNCj4gDQo+IAl1
bnNpZ25lZCBsb25nIHJlZmNsa19yYXRlID0gY2xrX2dldF9yYXRlKHhxc3BpLT5yZWZjbGspOw0K
PiAJdTMyIGJhdWRfcmF0ZV92YWwgPSBESVZfUk9VTkRfVVAocmVmY2xrX3JhdGUsIHNwaS0+bWF4
X3NwZWVkX2h6KSAtIDE7DQo+IA0KVGhpcyBpcyBub3QganVzdCBkaXJlY3QgY2FsY3VsYXRpb24u
DQppLmUuIGZvciBleGFtcGxlDQpyZWZjbGtfcmF0ZSA9IDIwME1IeiBhbmQgbWF4X3NwZWVkX2h4
ID0gMTAwTUh6Lg0KdGhlbiBESVZfUk9VTkRfVVAgZ2l2ZXMgYSB2YWx1ZSBvZiAyLg0KQnV0IHdy
aXRpbmcgYSB2YWx1ZSBvZiAyIHRvIGNvbmZpZyByZWdpc3RlcnMgbWVhbnMsIGRpdmlkZSBieSA4
LiBCdXQgd2Ugc2hvdWxkIHdyaXRlIGRpdmlkZSBieSAyICh2YWx1ZSBvZiB6ZXJvKS4NClRoYXTi
gJlzIHdoeSB3ZSBpbXBsZW1lbnRlZCB0aGUgYWJvdmUgY2FsY3VsYXRpb24uDQoNCjAwMDogZGl2
aWRlIGJ5IDIuDQowMDE6IGRpdmlkZSBieSA0DQowMTA6IGRpdmlkZSBieSA4DQowMTE6IGRpdmlk
ZSBieSAxNg0KMTAwOiBkaXZpZGUgYnkgMzINCjEwMTogZGl2aWRlIGJ5IDY0DQoxMTA6IGRpdmlk
ZSBieSAxMjgNCjExMTogZGl2aWRlIGJ5IDI1Ng0KDQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1bWFy
IFJlbGxpDQo+IAlpZiAoYmF1ZF9yYXRlX3ZhbCA+IFpZTlFfUVNQSV9CQVVEX0RJVl9NQVgpDQo+
IAkJYmF1ZF9yYXRlX3ZhbCA9IFpZTlFfUVNQSV9CQVVEX0RJVl9NQVg7DQo+IA0KPiA+ICsJY29u
ZmlnX3JlZyA9IHp5bnFfcXNwaV9yZWFkKHhxc3BpLCBaWU5RX1FTUElfQ09ORklHX09GRlNFVCk7
DQo+ID4gKw0KPiA+ICsJLyogU2V0IHRoZSBRU1BJIGNsb2NrIHBoYXNlIGFuZCBjbG9jayBwb2xh
cml0eSAqLw0KPiA+ICsJY29uZmlnX3JlZyAmPSAoflpZTlFfUVNQSV9DT05GSUdfQ1BIQV9NQVNL
KSAmDQo+ID4gKwkJICAgICAgKH5aWU5RX1FTUElfQ09ORklHX0NQT0xfTUFTSyk7DQo+ID4gKwlp
ZiAoc3BpLT5tb2RlICYgU1BJX0NQSEEpDQo+ID4gKwkJY29uZmlnX3JlZyB8PSBaWU5RX1FTUElf
Q09ORklHX0NQSEFfTUFTSzsNCj4gPiArCWlmIChzcGktPm1vZGUgJiBTUElfQ1BPTCkNCj4gPiAr
CQljb25maWdfcmVnIHw9IFpZTlFfUVNQSV9DT05GSUdfQ1BPTF9NQVNLOw0KPiA+ICsNCj4gPiAr
CWNvbmZpZ19yZWcgJj0gflpZTlFfUVNQSV9DT05GSUdfQkRSQVRFX01BU0s7DQo+ID4gKwljb25m
aWdfcmVnIHw9IChiYXVkX3JhdGVfdmFsIDw8IFpZTlFfUVNQSV9CQVVEX0RJVl9TSElGVCk7DQo+
ID4gKwl6eW5xX3FzcGlfd3JpdGUoeHFzcGksIFpZTlFfUVNQSV9DT05GSUdfT0ZGU0VULCBjb25m
aWdfcmVnKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IC0t
DQo+IFJlZ2FyZHMNCj4gVmlnbmVzaA0K
