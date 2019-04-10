Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89EEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E342083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SIVDI+TN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfDJFXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:23:13 -0400
Received: from mail-eopbgr690079.outbound.protection.outlook.com ([40.107.69.79]:53366
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfDJFXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 01:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC0a5O9TnFFDcbTDWRr/QWR/76kDVUp0T7zGRjIVXMU=;
 b=SIVDI+TNNRVyjHgE5C0T7kiJhXdJ2zRABs8aegeaROlRJb+3nt/fLYzxNiUfr+OJDeF3GAlu5yQaiJJ+6Xm8tDO1AbSjbL39pozhRvidEn3xtiQxKVXRM3qFaPwwBK+q7sflWjRyLsw+Apmqg0ew4DB2L/Cu1KN/hf6sYFWoMBg=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2415.namprd02.prod.outlook.com (10.168.244.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Wed, 10 Apr 2019 05:23:09 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e%6]) with mapi id 15.20.1792.016; Wed, 10 Apr 2019
 05:23:09 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH] spi: spi-mem: Fix build error without CONFIG_SPI_MEM
Thread-Topic: [PATCH] spi: spi-mem: Fix build error without CONFIG_SPI_MEM
Thread-Index: AQHU7hkPUMzsjr5B2kO6vbCHNEpRsqY0BtWAgAC5RYCAABiTUA==
Date:   Wed, 10 Apr 2019 05:23:09 +0000
Message-ID: <MWHPR02MB2623080FD8E525B2590CF7B4AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20190408143949.10688-1-yuehaibing@huawei.com>
 <4c9cb550-e0b6-8f66-979d-ab8237e28166@ti.com>
 <f377a323-c490-1185-e471-d5292ab59291@huawei.com>
In-Reply-To: <f377a323-c490-1185-e471-d5292ab59291@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ac0359f-9379-4179-3412-08d6bd749ea3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MWHPR02MB2415;
x-ms-traffictypediagnostic: MWHPR02MB2415:
x-microsoft-antispam-prvs: <MWHPR02MB24152E0F258C4B9F8F8F5280AF2E0@MWHPR02MB2415.namprd02.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(13464003)(199004)(189003)(6246003)(7736002)(7696005)(486006)(105586002)(446003)(106356001)(66066001)(53936002)(6436002)(229853002)(305945005)(86362001)(55016002)(9686003)(476003)(186003)(33656002)(74316002)(110136005)(25786009)(54906003)(4326008)(99286004)(316002)(5660300002)(52536014)(11346002)(53546011)(14444005)(81156014)(81166006)(2501003)(478600001)(8676002)(26005)(8936002)(71200400001)(71190400001)(256004)(6116002)(3846002)(102836004)(2906002)(6506007)(14454004)(68736007)(76176011)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2415;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6bgast5QlPVuGC4q/hzfvr4F4p7G6526tNTZ6jQjjYClOIiAbrvFtIWjEYJb3isIlOKxIgWbOrZQnetPqZ7xEqK1uBWPqWj+ls5oh3rTY7aW9DIVk1ugPeOHqd7yrwnnbVPIjvfVM1UJgk/NtQyc4dW/5K4ob8DG6hWLlFif+GVIQpLcJSMBiQRzaTsJePaWX2Yme4SBVq+2xRlnBPK8XAhWf0ODDx8VRYiioDBFwCZw1J66MhzWQQpdw+1ycWGVDbfQpItANBUxBphDrlguuMwdJgGmb2zRq6azg3u1Eec9/yEqWrN3t6IK2JUe/a2ZUWhlLwYFsihQ1xmifAjV4jMfHHdlpo2RBtPust1e1aYQlo5uRcur8k28v6Xs23x34xKltJKnVwCGIbbh9p6Xk2eSZdPy+8PnYj9OcfmZpeM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac0359f-9379-4179-3412-08d6bd749ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 05:23:09.3034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51
eC1zcGktb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1zcGktb3duZXJAdmdlci5rZXJuZWwu
b3JnPiBPbiBCZWhhbGYgT2YNCj4gWXVlSGFpYmluZw0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmls
IDEwLCAyMDE5IDk6MDMgQU0NCj4gVG86IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRp
LmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsgTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KPiA8bmFn
YXN1cmVAeGlsaW54LmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gc3BpOiBzcGkt
bWVtOiBGaXggYnVpbGQgZXJyb3Igd2l0aG91dCBDT05GSUdfU1BJX01FTQ0KPiANCj4gT24gMjAx
OS80LzEwIDA6MzAsIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+ID4gT24gMDgvMDQvMTkg
ODowOSBQTSwgWXVlIEhhaWJpbmcgd3JvdGU6DQo+ID4+IEZyb206IFl1ZUhhaWJpbmcgPHl1ZWhh
aWJpbmdAaHVhd2VpLmNvbT4NCj4gPj4NCj4gPj4gV2hlbiBidWlsZGluZyB3aXRoIENPTkZJR19T
UElfTUVNIGlzIG5vdCBzZXQgZ2Mgd2FybnMgdGhpczoNCj4gPj4NCj4gPj4gZHJpdmVycy9zcGkv
c3BpLXp5bnEtcXNwaS5vOiBJbiBmdW5jdGlvbiBgenlucV9xc3BpX3N1cHBvcnRzX29wJzoNCj4g
Pj4gc3BpLXp5bnEtcXNwaS5jOigudGV4dCsweDFkYSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YHNwaV9tZW1fZGVmYXVsdF9zdXBwb3J0c19vcCcNCj4gPj4NCj4gPj4gRml4ZXM6IDY3ZGNhNWU1
ODBmMSAoInNwaTogc3BpLW1lbTogQWRkIHN1cHBvcnQgZm9yIFp5bnEgUVNQSQ0KPiA+PiBjb250
cm9sbGVyIikNCj4gPj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3
ZWkuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGluY2x1ZGUvbGludXgvc3BpL3NwaS1tZW0uaCB8IDE0
ICsrKysrKysrKysrLS0tDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3Bp
L3NwaS1tZW0uaA0KPiA+PiBiL2luY2x1ZGUvbGludXgvc3BpL3NwaS1tZW0uaCBpbmRleCBjODQ1
Y2Q2Li4xOTQxYjg0IDEwMDY0NA0KPiA+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NwaS9zcGktbWVt
LmgNCj4gPj4gKysrIGIvaW5jbHVkZS9saW51eC9zcGkvc3BpLW1lbS5oDQo+ID4+IEBAIC0yOTUs
NiArMjk1LDEwIEBAIGludCBzcGlfY29udHJvbGxlcl9kbWFfbWFwX21lbV9vcF9kYXRhKHN0cnVj
dA0KPiA+PiBzcGlfY29udHJvbGxlciAqY3RsciwgIHZvaWQgc3BpX2NvbnRyb2xsZXJfZG1hX3Vu
bWFwX21lbV9vcF9kYXRhKHN0cnVjdCBzcGlfY29udHJvbGxlcg0KPiAqY3RsciwNCj4gPj4gIAkJ
CQkJICBjb25zdCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3AsDQo+ID4+ICAJCQkJCSAgc3RydWN0IHNn
X3RhYmxlICpzZyk7DQo+ID4+ICsNCj4gPj4gK2Jvb2wgc3BpX21lbV9kZWZhdWx0X3N1cHBvcnRz
X29wKHN0cnVjdCBzcGlfbWVtICptZW0sDQo+ID4+ICsJCQkJIGNvbnN0IHN0cnVjdCBzcGlfbWVt
X29wICpvcCk7DQo+ID4+ICsNCj4gPj4gICNlbHNlDQo+ID4+ICBzdGF0aWMgaW5saW5lIGludA0K
PiA+PiAgc3BpX2NvbnRyb2xsZXJfZG1hX21hcF9tZW1fb3BfZGF0YShzdHJ1Y3Qgc3BpX2NvbnRy
b2xsZXIgKmN0bHIsIEBADQo+ID4+IC0zMTAsNiArMzE0LDEzIEBAIHNwaV9jb250cm9sbGVyX2Rt
YV91bm1hcF9tZW1fb3BfZGF0YShzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsDQo+ID4+ICAJ
CQkJICAgICBzdHJ1Y3Qgc2dfdGFibGUgKnNnKQ0KPiA+PiAgew0KPiA+PiAgfQ0KPiA+PiArDQo+
ID4+ICtib29sIHNwaV9tZW1fZGVmYXVsdF9zdXBwb3J0c19vcChzdHJ1Y3Qgc3BpX21lbSAqbWVt
LA0KPiA+PiArCQkJCSBjb25zdCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApDQo+ID4NCj4gPiBUaGlz
IG5lZWRzIHRvIGJlIGRlY2xhcmVkIHN0YXRpYyBpbmxpbmUgdG8gYXZvaWQgbXVsdGlwbGUgZGVm
aW5pdGlvbnMuDQo+ID4gUmlnaHQ/DQo+IA0KPiBJbmRlZWQsIHRoYW5rcyENCklmIHdlIGRlY2xh
cmUgdGhpcyBhcyBzdGF0aWMgaW5saW5lLCB0aGVuIHdlIGNhbid0IGFjY2VzcyB0aGF0IGluIHp5
bnEtcXNwaSBkcml2ZXIuDQpUaGlzIGlzIHRoZSBlcnJvciBJIGFtIGdldHRpbmcuDQpJbiBmaWxl
IGluY2x1ZGVkIGZyb20gZHJpdmVycy9zcGkvc3BpLXp5bnEtcXNwaS5jOjE5OjA6DQouL2luY2x1
ZGUvbGludXgvc3BpL3NwaS1tZW0uaDoyOTg6MjA6IHdhcm5pbmc6IOKAmHNwaV9tZW1fZGVmYXVs
dF9zdXBwb3J0c19vcOKAmSB1c2VkIGJ1dCBuZXZlciBkZWZpbmVkDQogc3RhdGljIGlubGluZSBi
b29sIHNwaV9tZW1fZGVmYXVsdF9zdXBwb3J0c19vcChzdHJ1Y3Qgc3BpX21lbSAqbWVtLA0KICAg
ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCmRyaXZlcnMvc3Bp
L3NwaS16eW5xLXFzcGkuYzogSW4gZnVuY3Rpb24g4oCYenlucV9xc3BpX3N1cHBvcnRzX29w4oCZ
Og0KLi9pbmNsdWRlL2xpbnV4L3NwaS9zcGktbWVtLmg6Mjk4OjIwOiBlcnJvcjogaW5saW5pbmcg
ZmFpbGVkIGluIGNhbGwgdG8gYWx3YXlzX2lubGluZSDigJhzcGlfbWVtX2RlZmF1bHRfc3VwcG9y
dHNfb3DigJk6IGZ1bmN0aW9uIGJvZHkgbm90IGF2YWlsYWJsZQ0KZHJpdmVycy9zcGkvc3BpLXp5
bnEtcXNwaS5jOjIyMzo3OiBub3RlOiBjYWxsZWQgZnJvbSBoZXJlDQogIGlmICghc3BpX21lbV9k
ZWZhdWx0X3N1cHBvcnRzX29wKG1lbSwgb3ApKQ0KDQpUaGFua3MsDQpOYWdhIFN1cmVzaGt1bWFy
IFJlbGxpDQo+IA0KPiA+DQo+ID4+ICt7DQo+ID4+ICsJcmV0dXJuIGZhbHNlOw0KPiA+PiArfQ0K
PiA+PiArDQo+ID4+ICAjZW5kaWYgLyogQ09ORklHX1NQSV9NRU0gKi8NCj4gPj4NCj4gPj4gIGlu
dCBzcGlfbWVtX2FkanVzdF9vcF9zaXplKHN0cnVjdCBzcGlfbWVtICptZW0sIHN0cnVjdCBzcGlf
bWVtX29wDQo+ID4+ICpvcCk7IEBAIC0zNDEsOSArMzUyLDYgQEAgaW50DQo+ID4+IHNwaV9tZW1f
ZHJpdmVyX3JlZ2lzdGVyX3dpdGhfb3duZXIoc3RydWN0IHNwaV9tZW1fZHJpdmVyICpkcnYsDQo+
ID4+DQo+ID4+ICB2b2lkIHNwaV9tZW1fZHJpdmVyX3VucmVnaXN0ZXIoc3RydWN0IHNwaV9tZW1f
ZHJpdmVyICpkcnYpOw0KPiA+Pg0KPiA+PiAtYm9vbCBzcGlfbWVtX2RlZmF1bHRfc3VwcG9ydHNf
b3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwNCj4gPj4gLQkJCQkgY29uc3Qgc3RydWN0IHNwaV9tZW1f
b3AgKm9wKTsNCj4gPj4gLQ0KPiA+PiAgI2RlZmluZSBzcGlfbWVtX2RyaXZlcl9yZWdpc3Rlcihf
X2RydikgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+PiAgCXNwaV9tZW1f
ZHJpdmVyX3JlZ2lzdGVyX3dpdGhfb3duZXIoX19kcnYsIFRISVNfTU9EVUxFKQ0KPiA+Pg0KPiA+
Pg0KPiA+DQoNCg==
