Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2440AC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6725206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="hb1mxq7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfIPKlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:41:08 -0400
Received: from mail-eopbgr790087.outbound.protection.outlook.com ([40.107.79.87]:50760
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726055AbfIPKlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:41:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfRpUne7iwOQNX2FvXScaLnl5bzdkKKMQuYSlVGS6TR4CbBknjYW5mOhZmsZ9Er4VlFroV1bxro6HjD7/peJl24CCsuyMuf+LNjcPU9Sjcs7/qPymHW6eya+ov3VmBM0pjcxPVSLuexBgU1px3sVJOvOpTwwfiLZFgtIDTxiRwX+EHgnXNQ/5Eo2Zx1hf6sXu4exPstXThzlfeGSvmBYl/ZNy6gp1woa5mnFgGp7FPHq0JTzyfLklzsbQvjqW0BeSjXy/daMe6GhxAYBVsko9qTgQvph05abENMU7Q9c8UJtAZ9S8exNKqV1ItnPbO5nbcHMQxNtPQ9zIGYeXV42CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwJJjVvIMDny3dAvbWLYDliSdZZ76q9xw98dxkSO6U4=;
 b=LeE8ZmBOThDa6JqFZhJkSNnf+Gxkxc/cMxUfaujotvbS7D9B6ulrRjRINg8XgRR2Qubh6pkwAzHIdG/23ZibOnkNNgAmkGlQ6eM8IB9gDqgvXsfsznhSEHhP1fCuQ1VS+I/h+JDmXRb/DRtNJu6x88mbanHz8mxfw3oe/jziNKIuWA8OjGMW2/oczO/VT/h6vSJTQRnEkqUezJYYMIkHUzngSlVwF3w1bsmYBOsLQbSLJ/WE21nGaL6QK7ctrXNGu45hEtxoM9Chi83E4xWlmV94fEYbkYbgGVPBEfSR/KZnxXxmTxz7cpw4fQafsE+0TUkmCgjfXzs5h5mGzH6U/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwJJjVvIMDny3dAvbWLYDliSdZZ76q9xw98dxkSO6U4=;
 b=hb1mxq7yDxJNnOKDfPVcsWw5smY86ed4hxt3rFyO0GyLnzt9IjYsFwgugmjJO/+Px0gowHLn1pz7MnfgdJ3qVFNM554uwAJifNuVXMTvOopnTyX6HFRgOW9x8sr0e92Y6g233s+MnNkAq1OlClUmsYt2ktQ+Hnw9vGJnPXY0898=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB6365.namprd08.prod.outlook.com (52.132.171.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 16 Sep 2019 10:41:03 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::598d:b74:761e:ea0f]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::598d:b74:761e:ea0f%7]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 10:41:03 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: RE: [EXT] Re: [PATCH 6/8] mtd: spinand: micron: Turn driver
 implementation generic
Thread-Topic: [EXT] Re: [PATCH 6/8] mtd: spinand: micron: Turn driver
 implementation generic
Thread-Index: AQHVTQd5zjmLJBbahk2JUzVOEzo15qcCPhuwgAAGMACALBdfwA==
Date:   Mon, 16 Sep 2019 10:41:03 +0000
Message-ID: <MN2PR08MB59513B3C82894BCF23D761B2B88C0@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
        <20190722055621.23526-7-sshivamurthy@micron.com>
        <20190807120408.031b8d1b@xps13>
        <MN2PR08MB5951F13BC1D1D111681CCB4BB8A80@MN2PR08MB5951.namprd08.prod.outlook.com>
 <20190819111918.6be79570@xps13>
In-Reply-To: <20190819111918.6be79570@xps13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc3NoaXZhbXVydGh5XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzg4ODI5MWYtZDg2ZS0xMWU5LWIxZGItOTgzYjhmNzQ1MjUxXGFtZS10ZXN0XDc4ODgyOTIxLWQ4NmUtMTFlOS1iMWRiLTk4M2I4Zjc0NTI1MWJvZHkudHh0IiBzej0iNDQ2NyIgdD0iMTMyMTMxMDQwNjAxODYxNjg4IiBoPSJNUlMvb3BqeUsrbDRkMjJ5NHJ2SFg0SEwyZjA9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbd99133-c38d-4efd-5deb-08d73a925f57
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR08MB6365;
x-ms-traffictypediagnostic: MN2PR08MB6365:|MN2PR08MB6365:|MN2PR08MB6365:
x-microsoft-antispam-prvs: <MN2PR08MB6365B1C26E1F4C00464AB3ABB88C0@MN2PR08MB6365.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(316002)(74316002)(7416002)(76176011)(229853002)(6436002)(6506007)(14454004)(6116002)(7696005)(3846002)(99286004)(25786009)(8676002)(81156014)(2906002)(55236004)(81166006)(6916009)(71190400001)(71200400001)(8936002)(66946007)(66476007)(66556008)(64756008)(52536014)(66446008)(76116006)(66066001)(5660300002)(305945005)(7736002)(66574012)(478600001)(102836004)(53936002)(186003)(9686003)(4326008)(11346002)(14444005)(26005)(54906003)(476003)(486006)(446003)(55016002)(6246003)(86362001)(256004)(33656002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB6365;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xcv/OzRLaPl73sTD0uODPoTVrSA1Kidw8en9gpQvfNC6xbc7/KNZhel1WNWptecgTdvcwDb3x6NumjqvKKTrq3XBnjwBx7biJjIYvedkeBJtJQu9C01Xa5dqEHBQ7IpmTJj3EKmRZh3AueALG/wYPOrO4oeLAIAcbxfkJ3TUZQ2SERxHKSLiV3fc77iHIpUQPdBJWO14HL8FnKwNnJ6Rif3QIpmcJyes8VDP22eribgGpDH17auLb99YN8ut4sEZ8Cq9lN1hGsMx2BHA/z6KpdTYn1snVSLD8KjQ8R3Slp74dpNPi7+fyV2uj5szQg9TaxXZFenzxwC/YknQAaMjPpM18OEloysaDM3NxS+9xhIyE0R36SLvIpvgxC3Z4JWFhf77pRyivquF2MYkeqdT10h1OAZovSzxM2Xw3Htgx5E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd99133-c38d-4efd-5deb-08d73a925f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 10:41:03.3622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkljWrrNy/gNBueHd1XLOMQlGyYwPsigVW8kErEjUfWDd5sNT4Wf2fzT3zHFh4nixXqbIYXYHEyccAIey7IRyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB6365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTWlxdWVsICYgQm9yaXMsDQoNCkp1c3QgYSBnZW50bGUgcmVtaW5kZXIgdGhhdCBJJ2Qg
bGlrZSBzb21lIGZlZWRiYWNrLg0KDQpUaGFua3MsDQpTaGl2YQ0KDQo+IA0KPiBIaSBCb3JpcywN
Cj4gDQo+IEkgbmVlZCB5b3VyIG9waW5pb24gb24gdGhlIHF1ZXN0aW9uIGJlbG93Lg0KPiANCj4g
IlNoaXZhbXVydGh5IFNoYXN0cmkgKHNzaGl2YW11cnRoeSkiIDxzc2hpdmFtdXJ0aHlAbWljcm9u
LmNvbT4gd3JvdGUNCj4gb24NCj4gTW9uLCAxOSBBdWcgMjAxOSAwOTowMzozOCArMDAwMDoNCj4g
DQo+ID4gSGkgTWlxdWVsLA0KPiA+DQo+ID4gPg0KPiA+ID4gSGkgU2hpdmEsDQo+ID4gPg0KPiA+
ID4gc2hpdmEubGludXh3b3Jrc0BnbWFpbC5jb20gd3JvdGUgb24gTW9uLCAyMiBKdWwgMjAxOSAw
Nzo1NjoxOSArMDIwMDoNCj4gPiA+DQo+ID4gPiA+IEZyb206IFNoaXZhbXVydGh5IFNoYXN0cmkg
PHNzaGl2YW11cnRoeUBtaWNyb24uY29tPg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEkgYW0gbm90
IHN1cmUgdGhlICJ0dXJuIGltcGxlbWVuYXRhdGlvbiBnZW5lcmljIiB0aXRsZSBkZXNjcmliZXMg
d2hhdA0KPiA+ID4geW91IGRvLg0KPiA+ID4NCj4gPiA+ID4gRHJpdmVyIGlzIHJlZGVzaWduZWQg
dXNpbmcgcGFyYW1ldGVyIHBhZ2UgdG8gc3VwcG9ydCBNaWNyb24gU1BJIE5BTkQNCj4gPiA+ID4g
Zmxhc2hlcy4NCj4gPiA+DQo+ID4gPiBSZWRlc2lnbmVkIGlzIHBlcmhhcHMgYSBiaXQgdG9vIG11
Y2guDQo+ID4gPg0KPiA+ID4gIg0KPiA+ID4gPiBUaGUgcmVhc29uIHdoeSBzcGluYW5kX3NlbGVj
dF9vcF92YXJpYW50IGdsb2JhbGl6ZWQgaXMgdGhhdCB0aGUNCj4gTWljcm9uDQo+ID4gPiA+IGRy
aXZlciBubyBsb25nZXIgY2FsbGluZyBzcGluYW5kX21hdGNoX2FuZF9pbml0Lg0KPiA+ID4gPg0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaGl2YW11cnRoeSBTaGFzdHJpIDxzc2hpdmFtdXJ0aHlA
bWljcm9uLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL3NwaS9j
b3JlLmMgICB8ICAyICstDQo+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL3NwaS9taWNyb24uYyB8
IDYxICsrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAtLS0tLQ0KPiA+ID4gLS0tDQo+ID4g
PiA+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGluYW5kLmggICB8ICA0ICsrKw0KPiA+ID4gPiAgMyBm
aWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gPiA+ID4N
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYyBiL2RyaXZl
cnMvbXRkL25hbmQvc3BpL2NvcmUuYw0KPiA+ID4gPiBpbmRleCA3YWU3NmRhYjkxNDEuLmFhZTcx
NWQzODhiNyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9zcGkvY29yZS5j
DQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYw0KPiA+ID4gPiBAQCAt
OTIwLDcgKzkyMCw3IEBAIHN0YXRpYyB2b2lkDQo+IHNwaW5hbmRfbWFudWZhY3R1cmVyX2NsZWFu
dXAoc3RydWN0DQo+ID4gPiBzcGluYW5kX2RldmljZSAqc3BpbmFuZCkNCj4gPiA+ID4gIAkJcmV0
dXJuIHNwaW5hbmQtPm1hbnVmYWN0dXJlci0+b3BzLT5jbGVhbnVwKHNwaW5hbmQpOw0KPiA+ID4g
PiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICoN
Cj4gPiA+ID4gK2NvbnN0IHN0cnVjdCBzcGlfbWVtX29wICoNCj4gPiA+ID4gIHNwaW5hbmRfc2Vs
ZWN0X29wX3ZhcmlhbnQoc3RydWN0IHNwaW5hbmRfZGV2aWNlICpzcGluYW5kLA0KPiA+ID4gPiAg
CQkJICBjb25zdCBzdHJ1Y3Qgc3BpbmFuZF9vcF92YXJpYW50cyAqdmFyaWFudHMpDQo+ID4gPiA+
ICB7DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3NwaS9taWNyb24uYw0K
PiA+ID4gYi9kcml2ZXJzL210ZC9uYW5kL3NwaS9taWNyb24uYw0KPiA+ID4gPiBpbmRleCA5NWJj
NTI2NGViYzEuLjZmZGU5M2VjMjNhMSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9tdGQv
bmFuZC9zcGkvbWljcm9uLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9zcGkvbWlj
cm9uLmMNCj4gPiA+ID4gQEAgLTkwLDIyICs5MCwxMCBAQCBzdGF0aWMgaW50IG1pY3Jvbl9lY2Nf
Z2V0X3N0YXR1cyhzdHJ1Y3QNCj4gPiA+IHNwaW5hbmRfZGV2aWNlICpzcGluYW5kLA0KPiA+ID4g
PiAgCXJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAtc3RhdGlj
IGNvbnN0IHN0cnVjdCBzcGluYW5kX2luZm8gbWljcm9uX3NwaW5hbmRfdGFibGVbXSA9IHsNCj4g
PiA+ID4gLQlTUElOQU5EX0lORk8oIk1UMjlGMkcwMUFCQUdEIiwgMHgyNCwNCj4gPiA+ID4gLQkJ
ICAgICBOQU5EX01FTU9SRygxLCAyMDQ4LCAxMjgsIDY0LCAyMDQ4LCA0MCwgMiwgMSwgMSksDQo+
ID4gPiA+IC0JCSAgICAgTkFORF9FQ0NSRVEoOCwgNTEyKSwNCj4gPiA+ID4gLQkJICAgICBTUElO
QU5EX0lORk9fT1BfVkFSSUFOVFMoJnJlYWRfY2FjaGVfdmFyaWFudHMsDQo+ID4gPiA+IC0JCQkJ
CSAgICAgICZ3cml0ZV9jYWNoZV92YXJpYW50cywNCj4gPiA+ID4gLQkJCQkJICAgICAgJnVwZGF0
ZV9jYWNoZV92YXJpYW50cyksDQo+ID4gPiA+IC0JCSAgICAgMCwNCj4gPiA+ID4gLQkJICAgICBT
UElOQU5EX0VDQ0lORk8oJm1pY3Jvbl9vb2JsYXlvdXRfb3BzLA0KPiA+ID4gPiAtCQkJCSAgICAg
bWljcm9uX2VjY19nZXRfc3RhdHVzKSksDQo+ID4gPiA+IC19Ow0KPiA+ID4gPiAtDQo+ID4gPg0K
PiA+ID4gSSBkb24ndCBrbm93IGlmIGl0IGlzIHdpc2UgdG8gZHJvcCB0aGlzIHN0cnVjdHVyZS4N
Cj4gPiA+DQo+ID4gPiA+ICBzdGF0aWMgaW50IG1pY3Jvbl9zcGluYW5kX2RldGVjdChzdHJ1Y3Qg
c3BpbmFuZF9kZXZpY2UgKnNwaW5hbmQpDQo+ID4gPiA+ICB7DQo+ID4gPiA+ICsJY29uc3Qgc3Ry
dWN0IHNwaV9tZW1fb3AgKm9wOw0KPiA+ID4gPiAgCXU4ICppZCA9IHNwaW5hbmQtPmlkLmRhdGE7
DQo+ID4gPiA+IC0JaW50IHJldDsNCj4gPiA+ID4NCj4gPiA+ID4gIAkvKg0KPiA+ID4gPiAgCSAq
IE1pY3JvbiBTUEkgTkFORCByZWFkIElEIG5lZWQgYSBkdW1teSBieXRlLA0KPiA+ID4gPiBAQCAt
MTE0LDE2ICsxMDIsNTUgQEAgc3RhdGljIGludCBtaWNyb25fc3BpbmFuZF9kZXRlY3Qoc3RydWN0
DQo+ID4gPiBzcGluYW5kX2RldmljZSAqc3BpbmFuZCkNCj4gPiA+ID4gIAlpZiAoaWRbMV0gIT0g
U1BJTkFORF9NRlJfTUlDUk9OKQ0KPiA+ID4gPiAgCQlyZXR1cm4gMDsNCj4gPiA+ID4NCj4gPiA+
ID4gLQlyZXQgPSBzcGluYW5kX21hdGNoX2FuZF9pbml0KHNwaW5hbmQsIG1pY3Jvbl9zcGluYW5k
X3RhYmxlLA0KPiA+ID4gPiAtCQkJCSAgICAgQVJSQVlfU0laRShtaWNyb25fc3BpbmFuZF90YWJs
ZSksDQo+ID4gPiBpZFsyXSk7DQo+ID4gPg0KPiA+ID4gSSBhbSBub3Qgc3VyZSB0aGlzIGlzIHRo
ZSByaWdodCBzb2x1dGlvbi4gSSB3b3VsZCBrZWVwIHRoaXMgY2FsbCBhbmQNCj4gPiA+IG92ZXJ3
cml0ZSB3aGF0IHlvdSBuZWVkIHRvIG92ZXJ3cml0ZSB3aXRoIHRoZSBmaXh1cCBob29rLg0KPiA+
ID4NCj4gPg0KPiA+IFRoZW4sIEkgd2lsbCBoYXZlIGR1bW15IHN0cnVjdHVyZSBsaWtlIGJlbG93
Lg0KPiA+DQo+ID4gc3RhdGljIGNvbnN0IHN0cnVjdCBzcGluYW5kX2luZm8gbWljcm9uX3NwaW5h
bmRfdGFibGVbXSA9IHsNCj4gPiAgICAgICAgIFNQSU5BTkRfSU5GTyhOVUxMLCAwLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgIE5BTkRfTUVNT1JHKDAsIDAsIDAsIDAsIDAsIDAsIDAsIDAsIDAp
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgIE5BTkRfRUNDUkVRKDAsIDApLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgIFNQSU5BTkRfSU5GT19PUF9WQVJJQU5UUygmcmVhZF9jYWNoZV92YXJp
YW50cywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
JndyaXRlX2NhY2hlX3ZhcmlhbnRzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmdXBkYXRlX2NhY2hlX3ZhcmlhbnRzKSwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAwLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgIFNQSU5BTkRfRUNDSU5GTygm
bWljcm9uX29vYmxheW91dF9vcHMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG1pY3Jvbl9lY2NfZ2V0X3N0YXR1cykpLA0KPiA+IH07DQo+ID4NCj4gPiBMZXQgbWUg
a25vdyBpZiB5b3UgYXJlIHRoaW5raW5nIGZvciBkaWZmZXJlbnQgYXBwcm9hY2guDQo+ID4NCj4g
DQo+IFRoYW5rcywNCj4gTWlxdcOobA0K
