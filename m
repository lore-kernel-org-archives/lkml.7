Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5CAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7781020850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a0Gq4Tgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfDJFbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:31:06 -0400
Received: from mail-eopbgr680075.outbound.protection.outlook.com ([40.107.68.75]:40883
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbfDJFbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 01:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVkbYz/KxAuUm7RA37cXaKC78pHE+r80bqwW+aYkd+o=;
 b=a0Gq4TgveKmet0CE26260JjpejzrcxYG7fsg8kjSQgD20g1IMwDNmvOr+R6+njunX7ByAuQgpDNkwiigvHZ9BJ3dDRJkMCSVTMP+AKNTHEjm3sh1erBH6wpdRv3YDwDc7rvTVJ7xz3lN3Wh2OrVe82+weaijA99/lZ+6PBKkYik=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3216.namprd02.prod.outlook.com (10.164.133.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Wed, 10 Apr 2019 05:31:01 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e%6]) with mapi id 15.20.1792.016; Wed, 10 Apr 2019
 05:31:01 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: RE: [PATCH] spi: spi-mem: Fix build error without CONFIG_SPI_MEM
Thread-Topic: [PATCH] spi: spi-mem: Fix build error without CONFIG_SPI_MEM
Thread-Index: AQHU7hkPUMzsjr5B2kO6vbCHNEpRsqY0BtWAgAC5RYCAABiTUIAAB/0w
Date:   Wed, 10 Apr 2019 05:31:00 +0000
Message-ID: <MWHPR02MB2623958571F4CB10C22E90D7AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20190408143949.10688-1-yuehaibing@huawei.com>
 <4c9cb550-e0b6-8f66-979d-ab8237e28166@ti.com>
 <f377a323-c490-1185-e471-d5292ab59291@huawei.com>
 <MWHPR02MB2623080FD8E525B2590CF7B4AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB2623080FD8E525B2590CF7B4AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d95594d3-5c02-4d1d-9e2c-08d6bd75b7b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MWHPR02MB3216;
x-ms-traffictypediagnostic: MWHPR02MB3216:
x-microsoft-antispam-prvs: <MWHPR02MB321646D466EABF3713749F7AAF2E0@MWHPR02MB3216.namprd02.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(13464003)(102836004)(52536014)(97736004)(53546011)(66066001)(2501003)(25786009)(2940100002)(7736002)(55016002)(26005)(74316002)(86362001)(93156006)(478600001)(256004)(14454004)(6506007)(9686003)(305945005)(3846002)(186003)(68736007)(316002)(14444005)(93886005)(8676002)(81166006)(33656002)(81156014)(11346002)(486006)(76176011)(6116002)(446003)(476003)(105586002)(6436002)(2906002)(106356001)(110136005)(229853002)(99286004)(6246003)(8936002)(71190400001)(71200400001)(5660300002)(54906003)(53936002)(7696005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3216;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E2hcxnRN26/cd1DAHekzRV6VUY/2eLTtAVCKlhBP0ZMogc49jum6ihdrnOtneFAu536X6DrSdkaApmS3mlt74DpJzSmQ6A4of7ndNsOAxBatWW00hL1rs1qLqmJwwZLrdCbV2uTvY9hAZM7qevAZgc0EQ76RKX+JTQzlNQ0yM2m3/LQIFP0IyqY4yMPjosyPY1CBk+hk6ocjY0MHej4/4bkU8kG4Fej/VZz8bA9qw7fl7cOoGQxv2wq8LiEHN04B5kXb9RZ5kAu/x7uIXXqRdEjM1/9/4rWbMbBe6wF2NVB0tZ9y7qp9sXYT9FvNPV1DN8WdbZN5gR751DxCaw4tKcdUU8l3vUJSQK7aS+NtlgpHVlCxA4NV7j7EzYmbliyM4LXYaiO6W2ZoAKqIb7tHbE1A+x+q+qdkj+14y1l/XpM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95594d3-5c02-4d1d-9e2c-08d6bd75b7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 05:31:00.9138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51
eC1zcGktb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1zcGktb3duZXJAdmdlci5rZXJuZWwu
b3JnPiBPbiBCZWhhbGYgT2YNCj4gTmFnYSBTdXJlc2hrdW1hciBSZWxsaQ0KPiBTZW50OiBXZWRu
ZXNkYXksIEFwcmlsIDEwLCAyMDE5IDEwOjUzIEFNDQo+IFRvOiBZdWVIYWliaW5nIDx5dWVoYWli
aW5nQGh1YXdlaS5jb20+OyBWaWduZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+Ow0K
PiBicm9vbmllQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gc3BpOiBz
cGktbWVtOiBGaXggYnVpbGQgZXJyb3Igd2l0aG91dCBDT05GSUdfU1BJX01FTQ0KPiANCj4gSGkg
VmlnbmVzaCwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBs
aW51eC1zcGktb3duZXJAdmdlci5rZXJuZWwub3JnDQo+ID4gPGxpbnV4LXNwaS1vd25lckB2Z2Vy
Lmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBZdWVIYWliaW5nDQo+ID4gU2VudDogV2VkbmVzZGF5
LCBBcHJpbCAxMCwgMjAxOSA5OjAzIEFNDQo+ID4gVG86IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZp
Z25lc2hyQHRpLmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsgTmFnYQ0KPiA+IFN1cmVzaGt1bWFy
IFJlbGxpIDxuYWdhc3VyZUB4aWxpbnguY29tPg0KPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnDQo+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gc3BpOiBzcGktbWVtOiBGaXggYnVpbGQgZXJyb3Igd2l0aG91dA0KPiA+IENPTkZJR19T
UElfTUVNDQo+ID4NCj4gPiBPbiAyMDE5LzQvMTAgMDozMCwgVmlnbmVzaCBSYWdoYXZlbmRyYSB3
cm90ZToNCj4gPiA+IE9uIDA4LzA0LzE5IDg6MDkgUE0sIFl1ZSBIYWliaW5nIHdyb3RlOg0KPiA+
ID4+IEZyb206IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCj4gPiA+Pg0KPiA+
ID4+IFdoZW4gYnVpbGRpbmcgd2l0aCBDT05GSUdfU1BJX01FTSBpcyBub3Qgc2V0IGdjIHdhcm5z
IHRoaXM6DQo+ID4gPj4NCj4gPiA+PiBkcml2ZXJzL3NwaS9zcGktenlucS1xc3BpLm86IEluIGZ1
bmN0aW9uIGB6eW5xX3FzcGlfc3VwcG9ydHNfb3AnOg0KPiA+ID4+IHNwaS16eW5xLXFzcGkuYzoo
LnRleHQrMHgxZGEpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBzcGlfbWVtX2RlZmF1bHRfc3Vw
cG9ydHNfb3AnDQo+ID4gPj4NCj4gPiA+PiBGaXhlczogNjdkY2E1ZTU4MGYxICgic3BpOiBzcGkt
bWVtOiBBZGQgc3VwcG9ydCBmb3IgWnlucSBRU1BJDQo+ID4gPj4gY29udHJvbGxlciIpDQo+ID4g
Pj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiA+
ID4+IC0tLQ0KPiA+ID4+ICBpbmNsdWRlL2xpbnV4L3NwaS9zcGktbWVtLmggfCAxNCArKysrKysr
KysrKy0tLQ0KPiA+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gPiA+Pg0KPiA+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NwaS9z
cGktbWVtLmgNCj4gPiA+PiBiL2luY2x1ZGUvbGludXgvc3BpL3NwaS1tZW0uaCBpbmRleCBjODQ1
Y2Q2Li4xOTQxYjg0IDEwMDY0NA0KPiA+ID4+IC0tLSBhL2luY2x1ZGUvbGludXgvc3BpL3NwaS1t
ZW0uaA0KPiA+ID4+ICsrKyBiL2luY2x1ZGUvbGludXgvc3BpL3NwaS1tZW0uaA0KPiA+ID4+IEBA
IC0yOTUsNiArMjk1LDEwIEBAIGludCBzcGlfY29udHJvbGxlcl9kbWFfbWFwX21lbV9vcF9kYXRh
KHN0cnVjdA0KPiA+ID4+IHNwaV9jb250cm9sbGVyICpjdGxyLCAgdm9pZA0KPiA+ID4+IHNwaV9j
b250cm9sbGVyX2RtYV91bm1hcF9tZW1fb3BfZGF0YShzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXINCj4g
PiAqY3RsciwNCj4gPiA+PiAgCQkJCQkgIGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCwNCj4g
PiA+PiAgCQkJCQkgIHN0cnVjdCBzZ190YWJsZSAqc2cpOw0KPiA+ID4+ICsNCj4gPiA+PiArYm9v
bCBzcGlfbWVtX2RlZmF1bHRfc3VwcG9ydHNfb3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwNCj4gPiA+
PiArCQkJCSBjb25zdCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3ApOw0KPiA+ID4+ICsNCj4gPiA+PiAg
I2Vsc2UNCj4gPiA+PiAgc3RhdGljIGlubGluZSBpbnQNCj4gPiA+PiAgc3BpX2NvbnRyb2xsZXJf
ZG1hX21hcF9tZW1fb3BfZGF0YShzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHIsIEBADQo+ID4g
Pj4gLTMxMCw2ICszMTQsMTMgQEAgc3BpX2NvbnRyb2xsZXJfZG1hX3VubWFwX21lbV9vcF9kYXRh
KHN0cnVjdCBzcGlfY29udHJvbGxlcg0KPiAqY3RsciwNCj4gPiA+PiAgCQkJCSAgICAgc3RydWN0
IHNnX3RhYmxlICpzZykNCj4gPiA+PiAgew0KPiA+ID4+ICB9DQo+ID4gPj4gKw0KPiA+ID4+ICti
b29sIHNwaV9tZW1fZGVmYXVsdF9zdXBwb3J0c19vcChzdHJ1Y3Qgc3BpX21lbSAqbWVtLA0KPiA+
ID4+ICsJCQkJIGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCkNCj4gPiA+DQo+ID4gPiBUaGlz
IG5lZWRzIHRvIGJlIGRlY2xhcmVkIHN0YXRpYyBpbmxpbmUgdG8gYXZvaWQgbXVsdGlwbGUgZGVm
aW5pdGlvbnMuDQo+ID4gPiBSaWdodD8NCj4gPg0KPiA+IEluZGVlZCwgdGhhbmtzIQ0KUGxlYXNl
IGlnbm9yZSB0aGlzLiBJIGRpZCBtaXN0YWtlIGluIGRlY2xhcmluZy4NCkl0IGNvbXBpbGVkIHdp
dGggb3V0IGFueSBpc3N1ZXMgdXNpbmcgc3RhdGljIGlubGluZS4NCg0KVGhhbmtzLA0KTmFnYSBT
dXJlc2hrdW1hciBSZWxsaQ0KDQo+IElmIHdlIGRlY2xhcmUgdGhpcyBhcyBzdGF0aWMgaW5saW5l
LCB0aGVuIHdlIGNhbid0IGFjY2VzcyB0aGF0IGluIHp5bnEtcXNwaSBkcml2ZXIuDQo+IFRoaXMg
aXMgdGhlIGVycm9yIEkgYW0gZ2V0dGluZy4NCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZl
cnMvc3BpL3NwaS16eW5xLXFzcGkuYzoxOTowOg0KPiAuL2luY2x1ZGUvbGludXgvc3BpL3NwaS1t
ZW0uaDoyOTg6MjA6IHdhcm5pbmc6IOKAmHNwaV9tZW1fZGVmYXVsdF9zdXBwb3J0c19vcOKAmSB1
c2VkIGJ1dA0KPiBuZXZlciBkZWZpbmVkICBzdGF0aWMgaW5saW5lIGJvb2wgc3BpX21lbV9kZWZh
dWx0X3N1cHBvcnRzX29wKHN0cnVjdCBzcGlfbWVtICptZW0sDQo+ICAgICAgICAgICAgICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IGRyaXZlcnMvc3BpL3NwaS16eW5xLXFz
cGkuYzogSW4gZnVuY3Rpb24g4oCYenlucV9xc3BpX3N1cHBvcnRzX29w4oCZOg0KPiAuL2luY2x1
ZGUvbGludXgvc3BpL3NwaS1tZW0uaDoyOTg6MjA6IGVycm9yOiBpbmxpbmluZyBmYWlsZWQgaW4g
Y2FsbCB0byBhbHdheXNfaW5saW5lDQo+IOKAmHNwaV9tZW1fZGVmYXVsdF9zdXBwb3J0c19vcOKA
mTogZnVuY3Rpb24gYm9keSBub3QgYXZhaWxhYmxlDQo+IGRyaXZlcnMvc3BpL3NwaS16eW5xLXFz
cGkuYzoyMjM6Nzogbm90ZTogY2FsbGVkIGZyb20gaGVyZQ0KPiAgIGlmICghc3BpX21lbV9kZWZh
dWx0X3N1cHBvcnRzX29wKG1lbSwgb3ApKQ0KPiANCj4gVGhhbmtzLA0KPiBOYWdhIFN1cmVzaGt1
bWFyIFJlbGxpDQo+ID4NCj4gPiA+DQo+ID4gPj4gK3sNCj4gPiA+PiArCXJldHVybiBmYWxzZTsN
Cj4gPiA+PiArfQ0KPiA+ID4+ICsNCj4gPiA+PiAgI2VuZGlmIC8qIENPTkZJR19TUElfTUVNICov
DQo+ID4gPj4NCj4gPiA+PiAgaW50IHNwaV9tZW1fYWRqdXN0X29wX3NpemUoc3RydWN0IHNwaV9t
ZW0gKm1lbSwgc3RydWN0IHNwaV9tZW1fb3ANCj4gPiA+PiAqb3ApOyBAQCAtMzQxLDkgKzM1Miw2
IEBAIGludA0KPiA+ID4+IHNwaV9tZW1fZHJpdmVyX3JlZ2lzdGVyX3dpdGhfb3duZXIoc3RydWN0
IHNwaV9tZW1fZHJpdmVyICpkcnYsDQo+ID4gPj4NCj4gPiA+PiAgdm9pZCBzcGlfbWVtX2RyaXZl
cl91bnJlZ2lzdGVyKHN0cnVjdCBzcGlfbWVtX2RyaXZlciAqZHJ2KTsNCj4gPiA+Pg0KPiA+ID4+
IC1ib29sIHNwaV9tZW1fZGVmYXVsdF9zdXBwb3J0c19vcChzdHJ1Y3Qgc3BpX21lbSAqbWVtLA0K
PiA+ID4+IC0JCQkJIGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCk7DQo+ID4gPj4gLQ0KPiA+
ID4+ICAjZGVmaW5lIHNwaV9tZW1fZHJpdmVyX3JlZ2lzdGVyKF9fZHJ2KSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcDQo+ID4gPj4gIAlzcGlfbWVtX2RyaXZlcl9yZWdpc3Rlcl93
aXRoX293bmVyKF9fZHJ2LCBUSElTX01PRFVMRSkNCj4gPiA+Pg0KPiA+ID4+DQo+ID4gPg0KDQo=
