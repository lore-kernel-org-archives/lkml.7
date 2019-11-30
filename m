Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21CCC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED4E2075C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.onmicrosoft.com header.i=@siemens.onmicrosoft.com header.b="cu3Yex6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfK3Gmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 01:42:35 -0500
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:44160
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfK3Gmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 01:42:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUPpmgkHOOe6LRCIu4ldBfeKkJORT1MJeMr6i4ItQCP6ILxVbqOgNPNuA3AtWka77Dvz3ax8rXLVCSNY18DVID++7nUrfJ49F9Vrq0f2Vn2y5A4ablwcbvAHYwSzRAklScohpyCDq+ZORR8ktFYgUoARZ2Efco+VyFG1nJzfpR7N6j9lFiwWW7IZnMMGvtt9C9vlJlLJRcVZswsCBM6d6OJU+uPYKPQycEDRr9INPvxnJe/RYmZR6ElUi64TpISs66jqG/WAt0yyJ6KLCmhEA+xrAJyENVUUivKCacN1cFpYADb88EoVDPWRrjWrBQsEK8uynUJJvS16xQtxS+qzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU0TKHSEdympLeQWR1MURV60kYalftAY/8PA7bByUoA=;
 b=V63zJ9Opk9g+WiazrBofjlM6u1UKOfP1ZlZ/RUvokSOQBe7SeOFlHfNZDtZ8fjqrfjhLJdHzfRdHdNuwQTd/OtULFbRCEebPQGy9Bb2oTqC292fG8MjvroAYNkTXOm6LMHLTIW1pEjjaj6SUYhW6yqxuUztNgq0HuHq2vshn60BtQkM4jRWnuURGFCMsdu3anJEGoyMsHuWekDXmNw9rMf4KD895yASEkuIDNjC33Pfi9AWRU7cNkwLYnlXmtmPIj274LTz8k/hVjeRK5I2qlLYkok+gznsUaHEG+D2XEngTVXp2Mq/13zOSJFa7eHutRMTKoMhy75ELlBhXMo0a2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siemens.onmicrosoft.com; s=selector1-siemens-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU0TKHSEdympLeQWR1MURV60kYalftAY/8PA7bByUoA=;
 b=cu3Yex6rL28DFRHZ6ZOSemhEdx/fu8CvBYqlIhtlQ/MMC0YUJcSSj1dzqmaRKrJgBmvb5jaMFCJxrZSnSmoSoTjUdBtthb5lHt4FK5WmYXIRqlsAXyz8U2MAoNjPlF5Bl5zis4rh3eo6z/ifg1ZRHBoZsWNuydm8AxYa5qr5lPA=
Received: from VI1PR10MB2558.EURPRD10.PROD.OUTLOOK.COM (20.178.124.145) by
 VI1PR10MB1917.EURPRD10.PROD.OUTLOOK.COM (52.134.29.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Sat, 30 Nov 2019 06:41:29 +0000
Received: from VI1PR10MB2558.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9026:b718:fb6e:e010]) by VI1PR10MB2558.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9026:b718:fb6e:e010%7]) with mapi id 15.20.2495.014; Sat, 30 Nov 2019
 06:41:29 +0000
From:   "Haener, Michael" <michael.haener@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: pmc_atom: Add Siemens CONNECT X300 to
 critclk_systems DMI table
Thread-Topic: [PATCH] platform/x86: pmc_atom: Add Siemens CONNECT X300 to
 critclk_systems DMI table
Thread-Index: AQHVppYmpDAJrqf6n0qoW48+gDTgvKeh7rgAgAFMVSA=
Date:   Sat, 30 Nov 2019 06:41:29 +0000
Message-ID: <VI1PR10MB25580BD5E67CF718E6D06B1083410@VI1PR10MB2558.EURPRD10.PROD.OUTLOOK.COM>
References: <20191129091650.4765-1-michael.haener@siemens.com>
 <CAHp75Vc5A8pX1az+vH1E-d_4awKnyh60=KUYFbyT2ahEsQTkGQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc5A8pX1az+vH1E-d_4awKnyh60=KUYFbyT2ahEsQTkGQ@mail.gmail.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-document-confidentiality: NotClassified
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michael.haener@siemens.com; 
x-originating-ip: [165.225.72.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 016fa959-7038-4a4f-6184-08d775605480
x-ms-traffictypediagnostic: VI1PR10MB1917:
x-microsoft-antispam-prvs: <VI1PR10MB1917153F7993A6F720754DAF83410@VI1PR10MB1917.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02379661A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(189003)(199004)(54906003)(14454004)(6916009)(74316002)(26005)(6246003)(478600001)(316002)(99286004)(25786009)(7736002)(2906002)(102836004)(4326008)(55236004)(53546011)(6506007)(186003)(446003)(7696005)(66946007)(66446008)(8676002)(256004)(14444005)(86362001)(9686003)(305945005)(71200400001)(66476007)(76116006)(66556008)(55016002)(76176011)(71190400001)(81156014)(85202003)(81166006)(85182001)(229853002)(8936002)(64756008)(3846002)(6116002)(66574012)(5660300002)(52536014)(11346002)(6436002)(66066001)(33656002)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1917;H:VI1PR10MB2558.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: siemens.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s5IUdC/oopWdFTzwEP7Sp7Rkd+0wiBKMT0/u9DPl+lNxuE1ZmBNcWbkwQqtUJ4ZzUQf1+neGQDfS9JYtpJgtx5seo+jlrtT+TOUgwaAkvBkJ5JLU5nvFsrj9RwQlfJAMmY0u/x6EYOsiGGBpCiyA+z8MdWFDR64p7PqfKcRvyEwW2HeZ3FBlD0sAeody5prIaVi2UK+s6ja/wBAhayZriJCOWElmIzv7ajplU09PTIgn4nVzlFPvKFP+82l751lYi4AQkprN2sSumCxrbQVNaoUwkJwlMZ7blTnP+l5DPGMaXy0ZyCM2eTUFaUSS47tNYahjgmk6/hV9Cm3SnfxzbTPWmlVOul/j07V0fA0Z14PM3aajhAezLmAiP8F2vmzGAL2cNor03w/9mVkBT6s8ifr+33wv1UrExPCvoePMTYuC1NEpmBq2PaJZGrZn6Wv4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016fa959-7038-4a4f-6184-08d775605480
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2019 06:41:29.0674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Aut+Rza+DYd68xUCS1jkthTU/R5J+ZGGuqLAwWQV4ihrF54Us3ziVDflCoES6pCMnZxVp257tyLTlYINybmm0RYwD7S1wiiLQVKFoyjSVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1917
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4g
U2VudDogRnJlaXRhZywgMjkuIE5vdmVtYmVyIDIwMTkgMTE6MTYNCj4gVG86IEjDpG5lciwgTWlj
aGFlbCAoU0kgQlAgUiZEIFpHIEZXIENDUCkgPG1pY2hhZWwuaGFlbmVyQHNpZW1lbnMuY29tPg0K
PiBDYzogQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGluZnJhZGVhZC5vcmc+OyBEYXJyZW4gSGFydA0K
PiA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+OyBQbGF0Zm9ybSBEcml2ZXIgPHBsYXRmb3JtLWRyaXZl
ci0NCj4geDg2QHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBw
bGF0Zm9ybS94ODY6IHBtY19hdG9tOiBBZGQgU2llbWVucyBDT05ORUNUIFgzMDANCj4gdG8gY3Jp
dGNsa19zeXN0ZW1zIERNSSB0YWJsZQ0KPiANCj4gT24gRnJpLCBOb3YgMjksIDIwMTkgYXQgMTE6
MTkgQU0gTWljaGFlbCBIYWVuZXINCj4gPG1pY2hhZWwuaGFlbmVyQHNpZW1lbnMuY29tPiB3cm90
ZToNCj4gPg0KPiA+IFRoZSBDT05ORUNUIFgzMDAgdXNlcyB0aGUgUE1DIGNsb2NrIGZvciBvbi1i
b2FyZCBjb21wb25lbnRzIGFuZCBnZXRzDQo+ID4gc3R1Y2sgZHVyaW5nIGJvb3QgaWYgdGhlIGNs
b2NrIGlzIGRpc2FibGVkLiBUaGVyZWZvcmUsIGFkZCB0aGlzDQo+ID4gZGV2aWNlIHRvIHRoZSBj
cml0aWNhbCBzeXN0ZW1zIGxpc3QuDQo+ID4gVGVzdGVkIG9uIENPTk5FQ1QgWDMwMC4NCj4gDQo+
IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaCENCj4gQ2FuIHlvdSBiZSBtb3JlIHNwZWNpZmljIGFi
b3V0IHRoZSBjbG9jayAod2hpY2ggb25lPyBGb3IgZXhhbXBsZSBwbHQyKQ0KPiBhbmQgaWYgcG9z
c2libGUgdHlwZSBvZiBoYXJkd2FyZSBJUCB3aGljaCBpcyBjb25uZWN0ZWQgdG8gaXQgKGZvcg0K
PiBleGFtcGxlLCBSZWFsdGVrIEV0aGVybmV0KT8NCg0KSSdtIHNvcnJ5LCBJIGRvbid0IGhhdmUg
bW9yZSBkZXRhaWxlZCBpbmZvcm1hdGlvbi4gSSBvbmx5IGlkZW50aWZpZWQgdGhlIGJ1ZyANCmJ5
IGdpdCBiaXNlY3QuDQoNCj4gDQo+ID4gRml4ZXM6IDY0OGU5MjE4ODhhZCAoImNsazogeDg2OiBT
dG9wIG1hcmtpbmcgY2xvY2tzIGFzIENMS19JU19DUklUSUNBTCIpDQo+ID4gU2lnbmVkLW9mZi1i
eTogTWljaGFlbCBIYWVuZXIgPG1pY2hhZWwuaGFlbmVyQHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9wbWNfYXRvbS5jIHwgOCArKysrKysrKw0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wbGF0Zm9ybS94ODYvcG1jX2F0b20uYw0KPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L3Bt
Y19hdG9tLmMNCj4gPiBpbmRleCAwN2QxYjkxMWU3MmYuLjU3ZjA2Y2ExMTRhNiAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9wbWNfYXRvbS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9wbGF0Zm9ybS94ODYvcG1jX2F0b20uYw0KPiA+IEBAIC00MjksNiArNDI5LDE0IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBjcml0Y2xrX3N5c3RlbXNbXQ0KPiA9IHsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICBETUlfTUFUQ0goRE1JX1BST0RVQ1RfVkVSU0lPTiwg
IjZBVjc4ODItMCIpLA0KPiA+ICAgICAgICAgICAgICAgICB9LA0KPiA+ICAgICAgICAgfSwNCj4g
PiArICAgICAgIHsNCj4gPiArICAgICAgICAgICAgICAgLmlkZW50ID0gIkNPTk5FQ1QgWDMwMCIs
DQo+ID4gKyAgICAgICAgICAgICAgIC5tYXRjaGVzID0gew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIERNSV9NQVRDSChETUlfU1lTX1ZFTkRPUiwgIlNJRU1FTlMgQUciKSwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBETUlfTUFUQ0goRE1JX1BST0RVQ1RfVkVSU0lPTiwgIkE1RTQ1
MDc0NTg4IikNCj4gPiArICAgICAgICAgICAgICAgfSwNCj4gPiArICAgICAgIH0sDQo+ID4gKw0K
PiA+ICAgICAgICAgeyAvKnNlbnRpbmVsKi8gfQ0KPiA+ICB9Ow0KPiA+DQo+ID4gLS0NCj4gPiAy
LjExLjANCj4gPg0KPiANCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNo
ZXZjaGVua28NCldpdGggQmVzdCBSZWdhcmRzLA0KTWljaGFlbCBIYWVuZXINCg==
