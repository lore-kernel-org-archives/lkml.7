Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DDEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D0B206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="RJnvt1Sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbfGaOwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:52:44 -0400
Received: from mail-eopbgr20119.outbound.protection.outlook.com ([40.107.2.119]:22131
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388005AbfGaOwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:52:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2xYlTMktl4GIl7rG6HR7vv4yJkvvzpL9ePlRp6JjpR1G4MiSAcw6cn5V3+CiqZTxNFGnh8HMV1+lmEczQnqzwE2cbn6Jcmxk5uSaBxGDwuCIp0bqkZdxdnNozKzNoBr47s9EOxihdOpO+ziF/zwzIE/9YdDbH5d55B5FyWkIX1r3+Xj/95wn42keqCn/KzwAVzSlydUG08wS90pMVP8rM/fUz490Tb7pRArl8c8DoeNi7vDCmAhMg4cwZ6eFyoqvQcoq4cbqh9+J9J4c1e7Yrx6sWMWQHJ03+u1Ja+xOATdf2vnuirHq7VhPGXg2Qj29wXtKjhqmnsqwbBRfRQ1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ORMET1RPCNjvG2XhCPxaX8kXsItbBKmpPdA++mFv4w=;
 b=OUp4I3M3GLDRl3f4wPNBywyn8yPeT0eQfWomKcEfJ7XXCObcm4Y4xS1a6ZNTxP0TZT2UX3ylu4WjJ2uZKzWLUYr5V+HeK74ePMQ2VTem4y2CQ0GTkSH1b7Z6MDdgMlwxfOxmwZAvZsQBMcVHRsivfqlvx9hJEWQ9fW3SwmbSXMNFFes3escRB5dDQrTViS+Df1wWEcXuI/t/rYxCjuaYvORAg5O/riSnyyIvj7YvlEOsNnO3Mb2LuXKJXlehDnRrtY0CJrMUF7+JUP/0vn7qNPiuvK7AiYrllYyHH8ZKpi4HHLKud2dknyqLCi9lucUrvgSXCV3btXXwegm+8g+HFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ORMET1RPCNjvG2XhCPxaX8kXsItbBKmpPdA++mFv4w=;
 b=RJnvt1SmS/7ynnveuiE0VJmuYCoFwsEBmLmq73XxWZYx2AmnS4y0f9gQ3hRCkWkz6k+iYIiMfLfh3qoen0BS7qAhO5eY90DtcOssV1IKxtkG+/Id2k7zC7LZiei/XWE6RWwfo5TP6W6T38wPm+zeA9MBoDo7w2wmNG6L1Zf+I1A=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3936.eurprd05.prod.outlook.com (52.134.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Wed, 31 Jul 2019 14:52:37 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 14:52:37 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 07/20] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Topic: [PATCH v2 07/20] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Index: AQHVR5zQtB0dzN8FYEudcspMVKQYmabkr2aAgAAgjgA=
Date:   Wed, 31 Jul 2019 14:52:37 +0000
Message-ID: <723f191c5893984c8fbe711163524dc7ebf09a5b.camel@toradex.com>
References: <20190731123750.25670-1-philippe.schenker@toradex.com>
         <20190731123750.25670-8-philippe.schenker@toradex.com>
         <CAOMZO5B5HnqpLrDjyGtqSQpVXmcoZuGLvCzKVUhwLb-_ZO_Xog@mail.gmail.com>
In-Reply-To: <CAOMZO5B5HnqpLrDjyGtqSQpVXmcoZuGLvCzKVUhwLb-_ZO_Xog@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: effa45ee-9c8e-4238-d864-08d715c6bac0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3936;
x-ms-traffictypediagnostic: VI1PR0502MB3936:
x-microsoft-antispam-prvs: <VI1PR0502MB3936C3CD81E1D57FB49DB90FF4DF0@VI1PR0502MB3936.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39850400004)(136003)(396003)(366004)(189003)(199004)(14444005)(256004)(6436002)(76176011)(3846002)(6512007)(305945005)(6506007)(53546011)(1730700003)(102836004)(6116002)(8676002)(2351001)(68736007)(81156014)(86362001)(36756003)(26005)(2501003)(53936002)(1361003)(186003)(81166006)(99286004)(5660300002)(8936002)(54906003)(5640700003)(7736002)(6486002)(71200400001)(6246003)(44832011)(6916009)(2616005)(446003)(11346002)(76116006)(66476007)(66446008)(64756008)(66556008)(66066001)(2906002)(316002)(478600001)(66946007)(71190400001)(91956017)(118296001)(14454004)(4326008)(1411001)(7416002)(476003)(486006)(25786009)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3936;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Oofm0IHX8xNo4dyhQEDz9XJjHqjGXWFX4cAbMZXhXnU/f8nA8EWYa8wk+AcpD5Lu69I2goHKQWkREGn4lGzycWdZUTE0Jxw2ZXaWxElwLcG03CESOGLc7Vmgh4LxnwhA6NnaGVRLJN4lAdIYFpTMdTFI6cjToYnms2cG5Tti7u8IKV8V43HEdYP1ASXgWO3Yg+Vb4gtY0KTOwxZx73HL8ZBhHTltNp2Poyx3KACLBY0PoBAwpxSO/EQQGgsgpXD197HXQQhaqPNxKctyyFSqbAgqsXIJYjvWCAjthnyBO5BYjdwziVEFcWXMWcEmIWfZqbQogRPMBw3ar85LMYVcs0u4ryTFp67piGRr4x7ZOsqxOrOBmAc4CvCYuw+5OWNzjS5+Pike4WtNcQlmlk2XQ58kweolpkYmGUQo0KV1t7o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <610B7D62A336A340949661311748418C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effa45ee-9c8e-4238-d864-08d715c6bac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 14:52:37.5553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTMxIGF0IDA5OjU2IC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBPbiBXZWQsIEp1bCAzMSwgMjAxOSBhdCA5OjM4IEFNIFBoaWxpcHBlIFNjaGVua2VyDQo+IDxw
aGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4gd3JvdGU6DQo+ID4gRnJvbTogU3RlZmFuIEFn
bmVyIDxzdGVmYW4uYWduZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gQWRkIHBpbm11eGluZyBh
bmQgZG8gbm90IHNwZWNpZnkgdm9sdGFnZSByZXN0cmljdGlvbnMgaW4gdGhlDQo+ID4gbW9kdWxl
IGxldmVsIGRldmljZSB0cmVlLg0KPiANCj4gSXQgd291bGQgYmUgbmljZSB0byBleHBsYWluIHRo
ZSByZWFzb24gZm9yIGRvaW5nIHRoaXMuDQoNClRoaXMgY29tbWl0IGlzIGluIHByZXBhcmF0aW9u
IG9mIGFub3RoZXIgcGF0Y2ggdGhhdCBkaWRuJ3QgbWFkZSBpbnRvIHRoaXMNCnBhdGNoc2V0IChk
b3duc3RyZWFtIHN0dWZmIGluIHRoZXJlKS4gQnV0IEkgd2lsbCBkbyBhbm90aGVyIHBhdGNoIG9u
IHRvcCB0aGF0DQp3aWxsIHVzZSB0aGlzIHBhdGNoIGhlcmUuIFRoYXQgc2hvdWxkIGFueXdheSBi
ZSBpbiBtYWlubGluZS4NCg0KUGhpbGlwcGUNCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gQWduZXIgPHN0ZWZhbi5hZ25lckB0b3JhZGV4LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
aGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+ID4gLS0t
DQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2MjogTm9uZQ0KPiA+IA0KPiA+ICBhcmNoL2FybS9ib290
L2R0cy9pbXg3LWNvbGlicmkuZHRzaSB8IDIzICsrKysrKysrKysrKysrKysrKysrKystDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpIGIvYXJj
aC9hcm0vYm9vdC9kdHMvaW14Ny0NCj4gPiBjb2xpYnJpLmR0c2kNCj4gPiBpbmRleCAxNmQxYTFl
ZDFhZmYuLjY3ZjVlMGM4N2ZkYyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9p
bXg3LWNvbGlicmkuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJy
aS5kdHNpDQo+ID4gQEAgLTMyNiw3ICszMjYsNiBAQA0KPiA+ICAmdXNkaGMxIHsNCj4gPiAgICAg
ICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gICAgICAgICBwaW5jdHJsLTAgPSA8
JnBpbmN0cmxfdXNkaGMxICZwaW5jdHJsX2NkX3VzZGhjMT47DQo+ID4gLSAgICAgICBuby0xLTgt
djsNCj4gPiAgICAgICAgIGNkLWdwaW9zID0gPCZncGlvMSAwIEdQSU9fQUNUSVZFX0xPVz47DQo+
ID4gICAgICAgICBkaXNhYmxlLXdwOw0KPiA+ICAgICAgICAgdnFtbWMtc3VwcGx5ID0gPCZyZWdf
TERPMj47DQo+ID4gQEAgLTY3MSw2ICs2NzAsMjggQEANCj4gPiAgICAgICAgICAgICAgICAgPjsN
Cj4gPiAgICAgICAgIH07DQo+ID4gDQo+ID4gKyAgICAgICBwaW5jdHJsX3VzZGhjMV8xMDBtaHo6
IHVzZGhjMWdycF8xMDBtaHogew0KPiA+ICsgICAgICAgICAgICAgICBmc2wscGlucyA9IDwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFfQ01EX19TRDFfQ01EICAgICAg
IDB4NWENCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFfQ0xLX19TRDFf
Q0xLICAgICAgIDB4MWENCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFf
REFUQTBfX1NEMV9EQVRBMCAgIDB4NWENCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBNWDdE
X1BBRF9TRDFfREFUQTFfX1NEMV9EQVRBMSAgIDB4NWENCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBNWDdEX1BBRF9TRDFfREFUQTJfX1NEMV9EQVRBMiAgIDB4NWENCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFfREFUQTNfX1NEMV9EQVRBMyAgIDB4NWENCj4gPiAr
ICAgICAgICAgICAgICAgPjsNCj4gPiArICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgcGlu
Y3RybF91c2RoYzFfMjAwbWh6OiB1c2RoYzFncnBfMjAwbWh6IHsNCj4gPiArICAgICAgICAgICAg
ICAgZnNsLHBpbnMgPSA8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTVg3RF9QQURfU0Qx
X0NNRF9fU0QxX0NNRCAgICAgICAweDViDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTVg3
RF9QQURfU0QxX0NMS19fU0QxX0NMSyAgICAgICAweDFiDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgTVg3RF9QQURfU0QxX0RBVEEwX19TRDFfREFUQTAgICAweDViDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgTVg3RF9QQURfU0QxX0RBVEExX19TRDFfREFUQTEgICAweDViDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgTVg3RF9QQURfU0QxX0RBVEEyX19TRDFfREFUQTIgICAw
eDViDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTVg3RF9QQURfU0QxX0RBVEEzX19TRDFf
REFUQTMgICAweDViDQo+ID4gKyAgICAgICAgICAgICAgID47DQo+ID4gKyAgICAgICB9Ow0KPiAN
Cj4gWW91IGFkZCB0aGUgZW50cmllcyBmb3IgMTAwTUh6IGFuZCAyMDBNSHosIGJ1dCBJIGRvbid0
IHNlZSB0aGVtIGJlaW5nDQo+IHJlZmVyZW5jZWQgYW55d2hlcmUuDQo=
