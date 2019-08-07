Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EBBC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A173C21E73
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="oPxGf7IU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388484AbfHGNl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:41:26 -0400
Received: from mail-eopbgr150124.outbound.protection.outlook.com ([40.107.15.124]:34057
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388437AbfHGNlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M04KJ/HAppecvmHpMihXHJkC+L15rT3e8To3TJSu/iVw3SiFCf/yK56NrVdVqzlTbx/Yvb19qqnm+Y7KzRk53zLYQUUfV9IChFUzWhbjCSy/99mSIUw+JV36NUU6TJVHyP1fyIHubjIzd5xaj03oUnZjVJnFuFcwLY3BkGaDpl3FSDbsbX5DKyy90/RVSblw/Bxcou6Q5ta27kpDFwJGrOkrXZMjyuKwX8q4g843BG8wsV+9ok9DoXuOPVYmytPJalemS4AdLYizL/KWzxA1S9DhgvT0oARWr54Ger4FsUT9cvfiiN2kAtO8J3AEqLv3FIBM8mgjCRJas/C7dp/dzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSrgkygSBfizoEWlqMcBr/DkR9kQvp6fVRU5CLumxcs=;
 b=nYJEWGbbJrXEWaNjagS5U+UbZ35t2jGRQ7dJ0z6iVoFqjIwpA1T+3pbmnuuGQEKW0SavLsSXidD3pRBX0j+DthZCTbqrlQmAKo+9Q1JyTq66U06qBwpWNYbLWV/SwK7ieiJ5wuDVMfx3vR3qfoxo34mfc+FPoRzWmIJxdBpIBoxitMBKnCGZr4VbyQA9uSdbny9F6H6Y7GFgjtTdriKtkLd+xPfw0tYa78vzYPl2s6nQ1PwOEH4rpIfjaW4jm0FBvkFoEekdGNhbg/TRjoQO/ZHfPLzKcYY1+ZqOshTuKrUzNpVTtP7x4K7eRaEgdSR5MZO4IlNJfM5kc1OeZg+qxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSrgkygSBfizoEWlqMcBr/DkR9kQvp6fVRU5CLumxcs=;
 b=oPxGf7IUb5bBICXqorYQpfRaJ5Lx/dUUT1RrsvB6WdukhS22FvVdMFDAXrY8H7XHN75YnAOSqFVsSFq9ozU9LDs8QrBgw2FdCHZaNmccbQAkf3tySxF1BGqf1fPY1RJEH0LlKD01H6k4uQdvM4bS8r8vhTjJ//XFgoIFqlLinaE=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3935.eurprd05.prod.outlook.com (52.134.6.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 7 Aug 2019 13:41:12 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 13:41:12 +0000
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
Subject: Re: [PATCH v3 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Topic: [PATCH v3 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Index: AQHVTPnJFwE/N2EWdUa4MifpBqKEzKbvie6AgAAnqoA=
Date:   Wed, 7 Aug 2019 13:41:12 +0000
Message-ID: <9f05bcbad4b56d0b7c4f90b53b99c07833f68bb2.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-8-philippe.schenker@toradex.com>
         <CAOMZO5CdWmVKXmNSLdbsmnU6_ZKwbeVArtOQzuTg_gtqTUnVag@mail.gmail.com>
In-Reply-To: <CAOMZO5CdWmVKXmNSLdbsmnU6_ZKwbeVArtOQzuTg_gtqTUnVag@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b06d9002-3298-4f11-25fc-08d71b3ce960
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3935;
x-ms-traffictypediagnostic: VI1PR0502MB3935:
x-microsoft-antispam-prvs: <VI1PR0502MB3935A8B8AB92570255736DEBF4D40@VI1PR0502MB3935.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(346002)(39850400004)(396003)(376002)(189003)(199004)(68736007)(1730700003)(476003)(229853002)(7416002)(1411001)(3846002)(11346002)(5640700003)(446003)(1361003)(478600001)(2351001)(36756003)(256004)(6916009)(14444005)(66066001)(486006)(66946007)(305945005)(6512007)(561944003)(81156014)(6116002)(44832011)(118296001)(81166006)(2616005)(5660300002)(76116006)(2501003)(99286004)(26005)(8936002)(86362001)(7736002)(8676002)(316002)(4326008)(186003)(66476007)(71200400001)(6506007)(53546011)(71190400001)(66446008)(64756008)(76176011)(66556008)(6436002)(6486002)(91956017)(53936002)(2906002)(25786009)(14454004)(6246003)(102836004)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3935;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SC0lY6Aq6ZQEgVNVLvSb74wfpdAI0wrZSEDJth/k5+e9UqqK2nRx9pvyOgFqL5JKQloVoEwLEMnCnA9xNbpcSoZP9O02XDbrJVk4Bl4AfXCznR4IKyX/IQFELeF+7iEsqwR2CYKS7wz7r1XeaqSVlXu6FjnMxk0FNRzz0y0wqZh3OYb6OTvBjM4hOtfHY4yPzqdJGB+V6G2v9RMS1tticcjt/UOd+Be6QPbEFmIS2GFaaJD+XjxKr+9FX4IkNWmb+fGHZu11X5IeLUN/xjDe8i070eTHXBiok2KMPXb0/NGGEOcNIf/W9116pVoX+7JhmZ/svfp1vUliC0gPOrqlKZazjwizr6ot/I1jXD90rL2ICxJzxFQO/8J3R4usFrAtFqETrkVuVu06NZlx2KZOxGzhpX7I7dJjXD2ESVdROm4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84D9259A9961C34FA2F02A5D7E80D047@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06d9002-3298-4f11-25fc-08d71b3ce960
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 13:41:12.1046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LDjA0mTS4CsnJ1yb8Z/HrAEPdYySm/9DHB86PzTVW4WyFErT1wwxg2hEFR4purViwT2VpUwA/axOkfJ78BsdMncWa2rnyVpihDTt8t1Sr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjE5IC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBIaSBQaGlsaXBwZSwNCj4gDQo+IE9uIFdlZCwgQXVnIDcsIDIwMTkgYXQgNToyNiBBTSBQaGls
aXBwZSBTY2hlbmtlcg0KPiA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+IHdyb3RlOg0K
PiA+IEZyb206IFN0ZWZhbiBBZ25lciA8c3RlZmFuLmFnbmVyQHRvcmFkZXguY29tPg0KPiA+IA0K
PiA+IEFkZCBwaW5tdXhpbmcgYW5kIGRvIG5vdCBzcGVjaWZ5IHZvbHRhZ2UgcmVzdHJpY3Rpb25z
IGZvciB0aGUgdXNkaGMNCj4gPiBpbnN0YW5jZSBhdmFpbGFibGUgb24gdGhlIG1vZHVsZXMgZWRn
ZSBjb25uZWN0b3IuIFRoaXMgYWxsb3dzIHRvIHVzZQ0KPiA+IFNELWNhcmRzIHdpdGggaGlnaGVy
IHRyYW5zZmVyIG1vZGVzIGlmIHN1cHBvcnRlZCBieSB0aGUgY2Fycmllcg0KPiA+IGJvYXJkLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBBZ25lciA8c3RlZmFuLmFnbmVyQHRvcmFk
ZXguY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5z
Y2hlbmtlckB0b3JhZGV4LmNvbT4NCj4gPiANCj4gPiAtLS0NCj4gPiANCj4gPiBDaGFuZ2VzIGlu
IHYzOg0KPiA+IC0gQWRkIG5ldyBjb21taXQgbWVzc2FnZSBmcm9tIFN0ZWZhbidzIHByb3Bvc2Fs
IG9uIE1MDQo+IA0KPiBUaGUgY29tbWl0IG1lc3NhZ2UgaGFzIGJlZW4gaW1wcm92ZWQsIGJ1dCB0
aGVyZSBpcyBhbHNvIGFub3RoZXIgcG9pbnQNCj4gSSBtZW50aW9uZWQgZWFybGllcjoNCj4gDQo+
ID4gQ2hhbmdlcyBpbiB2MjogTm9uZQ0KPiA+IA0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9pbXg3
LWNvbGlicmkuZHRzaSB8IDIzICsrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpDQo+ID4gYi9hcmNoL2Fy
bS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaQ0KPiA+IGluZGV4IDE2ZDFhMWVkMWFmZi4uNjdm
NWUwYzg3ZmRjIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJy
aS5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kNCj4g
PiBAQCAtMzI2LDcgKzMyNiw2IEBADQo+ID4gICZ1c2RoYzEgew0KPiA+ICAgICAgICAgcGluY3Ry
bC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiAgICAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF91
c2RoYzEgJnBpbmN0cmxfY2RfdXNkaGMxPjsNCj4gPiAtICAgICAgIG5vLTEtOC12Ow0KPiA+ICAg
ICAgICAgY2QtZ3Bpb3MgPSA8JmdwaW8xIDAgR1BJT19BQ1RJVkVfTE9XPjsNCj4gPiAgICAgICAg
IGRpc2FibGUtd3A7DQo+ID4gICAgICAgICB2cW1tYy1zdXBwbHkgPSA8JnJlZ19MRE8yPjsNCj4g
PiBAQCAtNjcxLDYgKzY3MCwyOCBAQA0KPiA+ICAgICAgICAgICAgICAgICA+Ow0KPiA+ICAgICAg
ICAgfTsNCj4gPiANCj4gPiArICAgICAgIHBpbmN0cmxfdXNkaGMxXzEwMG1oejogdXNkaGMxZ3Jw
XzEwMG1oeiB7DQo+IA0KPiBUaGlzIG5ldyBlbnRyeSBoYXMgYmVlbiBhZGRlZCBhbmQgaXQgaXMg
bm90IHJlZmVyZW5jZWQuDQoNClNvcnJ5LCBJIHByb2JhYmx5IGNvdWxkIGhhdmUgbWVudGlvbmVk
IHRoYXQgaW4gdGhpcyBjb21taXQuIEkgd2FudCwgaWYNCnBvc3NpYmxlLCB0byBsZXQgdGhpcyBj
b21tbWl0IGFzIGlzLiBUaGF0J3Mgd2h5IEkgYWRkZWQgYW5vdGhlciBvbiB0b3ANCm9mIHRoaXMg
cGF0Y2hzZXQuIFBsZWFzZSBzZWUgcGF0Y2ggMjEvMjEgdGhhdCBtYWtlcyB1c2Ugb2YgdGhpcyBj
aGFuZ2UuDQo+IA0KPiA+ICsgICAgICAgICAgICAgICBmc2wscGlucyA9IDwNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFfQ01EX19TRDFfQ01EICAgICAgIDB4NWENCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFfQ0xLX19TRDFfQ0xLICAgICAg
IDB4MWENCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFfREFUQTBfX1NE
MV9EQVRBMCAgIDB4NWENCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBNWDdEX1BBRF9TRDFf
REFUQTFfX1NEMV9EQVRBMSAgIDB4NWENCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBNWDdE
X1BBRF9TRDFfREFUQTJfX1NEMV9EQVRBMiAgIDB4NWENCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBNWDdEX1BBRF9TRDFfREFUQTNfX1NEMV9EQVRBMyAgIDB4NWENCj4gPiArICAgICAgICAg
ICAgICAgPjsNCj4gPiArICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgcGluY3RybF91c2Ro
YzFfMjAwbWh6OiB1c2RoYzFncnBfMjAwbWh6IHsNCj4gDQo+IFNhbWUgaGVyZS4NCg==
