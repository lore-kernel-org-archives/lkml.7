Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990DDC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6139F22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="lZsIr7AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfHUNQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:16:02 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com ([40.107.7.115]:23108
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbfHUNQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:16:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpiiokpI5merFZw/vkPf7SMOzVB2Op5c+6geXEL6wBmrwM/PQRCkxuzdT3xyeGPTkJpZ1b4wbrsPTpDcylfbAzrWFWZ4TZclGLJYj5FTo/C7XVLR8PuF72tHTY/BZ8K0SzPOrvWgCf3AeqTeYlS2Efk3KAEsuRanIt76ypq+Qygc8P+xGdKkyTi/Cq7P4r8xnBID5nSbCYC7rEK1vGt7KHyugN8oiqZuAOGHo5QDHSRBDDDChRrPKE1u4Ud6tZzkxjZcFn5lK5D8vI+RuQDqjA4pPzdW5uOu185kzWuW13PfYi+9lXS55ka3hQlas+we2p146zfZ3jVxi+2bY9aVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XvvoYtczd3wCcNvyHVjlYmdeqsfygsQqs3FFBwWScI=;
 b=CdU0giYWR3zGpp99wFMdMlJ7+QWHEMkLmd8/dsAgC8oGLf8qdzxnlvs6nxdvyd1+9Q2Mhwb61cpzktzqGg8/9tGn+LEkN/5UIbQnrqFobe3VWs2vXs1oYwhxATM+7+rHwg1vMaqX7x80JVD2yhI7xVvN5jIOYdj6ol5KLY6zpvDVmLt/QMbBhOT7e/VaSFyWsz3EXjGlaxEUw2J4FIrYC3CUhaqcEh2JPFkQbXmYKRdk8gGckT5Hds6mayGYm+DW0BIehy3f1kphzsLgHynpmjmfaJud2+kGbfbvT98ONpmOBYtZdeHRo8yDEwyLe4gonm7p9jE34zw73cAjF5XC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XvvoYtczd3wCcNvyHVjlYmdeqsfygsQqs3FFBwWScI=;
 b=lZsIr7ALJhX4Cb9L4i4vjhxstAhivtaraZ5sp5brhDW99798QAzGNXAqis/WfrR3u8HliBAKz7jGAjmUavB64KtlHNOufKwQ54kZkzCJubl42hltAp0ztmg4V+wwfQy3fVuTQ3InHGsyiz93ZVY3EehcrzVQCQnXhG66byu+Auk=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB4048.eurprd05.prod.outlook.com (52.134.18.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Wed, 21 Aug 2019 13:15:54 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 13:15:54 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v4 11/21] ARM: dts: imx6qdl-apalis: Add sleep state to can
 interfaces
Thread-Topic: [PATCH v4 11/21] ARM: dts: imx6qdl-apalis: Add sleep state to
 can interfaces
Thread-Index: AQHVURk8tkL06lEcYEKQgOqHfUf7lKcCYBeAgANC1IA=
Date:   Wed, 21 Aug 2019 13:15:53 +0000
Message-ID: <4c318f310babcf655be8db79abcfce547daea284.camel@toradex.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
         <20190812142105.1995-12-philippe.schenker@toradex.com>
         <20190819112754.GU5999@X250>
In-Reply-To: <20190819112754.GU5999@X250>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d32ebc35-d871-47ce-8129-08d72639b22f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0502MB4048;
x-ms-traffictypediagnostic: VI1PR0502MB4048:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB4048BF548A2D00EABE5B4504F4AA0@VI1PR0502MB4048.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(396003)(39850400004)(136003)(366004)(199004)(189003)(6116002)(7416002)(229853002)(6436002)(2616005)(476003)(5640700003)(76116006)(66476007)(66446008)(91956017)(64756008)(66946007)(14454004)(2906002)(316002)(6246003)(486006)(4326008)(66556008)(2351001)(11346002)(118296001)(44832011)(6506007)(25786009)(7736002)(6486002)(102836004)(36756003)(54906003)(478600001)(3846002)(186003)(256004)(5660300002)(2501003)(14444005)(76176011)(8676002)(81166006)(6916009)(305945005)(8936002)(1730700003)(53936002)(446003)(86362001)(6512007)(99286004)(71200400001)(26005)(81156014)(66066001)(71190400001)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB4048;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sKa/N/Q97pty9rchz4rfUYKsL6u6vvnD0OMcWf+wd+Wab+oVDu0AsorM3zppzCKKccNkSvz9c0ct1fT9+M8WEWU5YqPkGv9oE/AsVVEw4z1/aSBjnHJQfN2ILbJ8U/ZT14sxKmGChyrX471Q36ArSZMvMIx8C8iMV+/9x7c6aQQeQ/qfXvydocg6VcNUFWMkpha6EzuFWnkFORz7GgYxzi9uuA5jgfBhxWuii2IxMDz+MAi9L0Ukz/d4nGi4+5DZJc1Cu2GL1ZWH0N+EQpH+32H+MXL/oV0j0Fg5XRRR2kgR0sx0GovMbkRPsmRKyoEk3wIYV9InUwCwfCSrJqzCCXIU9WURTpxo/PA2lokJ54AdRBfIwYLLZJcPG3NsAjoKKu08Qwphu7VXtP5MGMLTM7NxnTXRfXvdBYMqqTccyeQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59B0EF509A0A674089D3E25AC9E6EBF7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32ebc35-d871-47ce-8129-08d72639b22f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 13:15:53.8754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoKNDGqgZiVuEBQ4TYCJJRBiC2cV+a3m7l6cvom93mOY2W9/o7F1pwzgS0lboJJX8P8LqIemx+U5XM89OhonCzrgHc7GtAGIB9Wa1xLYta0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTE5IGF0IDEzOjI3ICswMjAwLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9u
IE1vbiwgQXVnIDEyLCAyMDE5IGF0IDAyOjIxOjMxUE0gKzAwMDAsIFBoaWxpcHBlIFNjaGVua2Vy
IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggcHJlcGFyZXMgdGhlIGRldmljZXRyZWUgZm9yIHRoZSBu
ZXcgSXhvcmEgVjEuMiB3aGVyZSB3ZQ0KPiA+IGFyZQ0KPiA+IGFibGUgdG8gdHVybiBvZmYgdGhl
IHN1cHBseSBvZiB0aGUgY2FuIHRyYW5zY2VpdmVyLiBUaGlzIGltcGxpZXMgdG8NCj4gPiB1c2UN
Cj4gPiBhIHNsZWVwIHN0YXRlIG9uIHRyYW5zbWlzc2lvbiBwaW5zIGluIG9yZGVyIHRvIHByZXZl
bnQgYmFja2ZlZWRpbmcuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5r
ZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KPiA+IEFja2VkLWJ5OiBNYXJjZWwg
Wmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gPiANCj4gPiAtLS0NCj4g
PiANCj4gPiBDaGFuZ2VzIGluIHY0Og0KPiA+IC0gQWRkIE1hcmNlbCBaaXN3aWxlcidzIEFjaw0K
PiA+IA0KPiA+IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0g
Q2hhbmdlZCBjb21taXQgdGl0bGUgdG8gJy4uLmlteDZxZGwtYXBhbGlzOi4uLicNCj4gPiANCj4g
PiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1hcGFsaXMuZHRzaSB8IDI3ICsrKysrKysrKysr
KysrKysrKysrKy0tLQ0KPiA+IC0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnFkbC1hcGFsaXMuZHRzaQ0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFk
bC1hcGFsaXMuZHRzaQ0KPiA+IGluZGV4IDdjNGFkNTQxYzNmNS4uNTllZDJlNGExZmQxIDEwMDY0
NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtYXBhbGlzLmR0c2kNCj4gPiAr
KysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWFwYWxpcy5kdHNpDQo+ID4gQEAgLTE0OCwx
NCArMTQ4LDE2IEBADQo+ID4gIH07DQo+ID4gIA0KPiA+ICAmY2FuMSB7DQo+ID4gLQlwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiOw0KPiA+IC0JcGluY3RybC0wID0gPCZwaW5jdHJsX2ZsZXhjYW4x
PjsNCj4gDQo+IFRoaXMgbGluZSBkb2Vzbid0IG5lZWQgdG8gYmUgY2hhbmdlZC4NCg0KWW91J3Jl
IHJpZ2h0LCBidXQgYnkgYWRkaW5nIHBpbmN0cmxfZmxleGNhbjFfc2xlZXAgaGVyZSwgSSdkIGxp
a2UgdG8NCmVtcGhhc2l6ZSBiZXR3ZWVuICJkZWZhdWx0IiBhbmQgInNsZWVwIiBhbmQgY2hhbmdl
IHRoYXQuDQoNClNpbmNlIGl0J3Mgb25seSB1c2VkIGluIHRoaXMgZmlsZSBJIGRvbid0IHNlZSBh
bnkgcHJvYmxlbXMuDQoNClBoaWxpcHBlDQo+IA0KPiA+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IiwgInNsZWVwIjsNCj4gPiArCXBpbmN0cmwtMCA9IDwmcGluY3RybF9mbGV4Y2FuMV9kZWZh
dWx0PjsNCj4gPiArCXBpbmN0cmwtMSA9IDwmcGluY3RybF9mbGV4Y2FuMV9zbGVlcD47DQo+ID4g
IAlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgJmNhbjIgew0KPiA+
IC0JcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiAtCXBpbmN0cmwtMCA9IDwmcGluY3Ry
bF9mbGV4Y2FuMj47DQo+ID4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAic2xlZXAiOw0K
PiA+ICsJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZsZXhjYW4yX2RlZmF1bHQ+Ow0KPiA+ICsJcGlu
Y3RybC0xID0gPCZwaW5jdHJsX2ZsZXhjYW4yX3NsZWVwPjsNCj4gPiAgCXN0YXR1cyA9ICJkaXNh
YmxlZCI7DQo+ID4gIH07DQo+ID4gIA0KPiA+IEBAIC01OTksMTkgKzYwMSwzMiBAQA0KPiA+ICAJ
CT47DQo+ID4gIAl9Ow0KPiA+ICANCj4gPiAtCXBpbmN0cmxfZmxleGNhbjE6IGZsZXhjYW4xZ3Jw
IHsNCj4gDQo+IERpdHRvLiAgSSB0YWtlIHRoZW0gYXMgdW5uZWNlc3NhcnkgY2hhbmdlcy4NCj4g
DQo+IFNoYXduDQo+IA0KPiA+ICsJcGluY3RybF9mbGV4Y2FuMV9kZWZhdWx0OiBmbGV4Y2FuMWRl
ZmdycCB7DQo+ID4gIAkJZnNsLHBpbnMgPSA8DQo+ID4gIAkJCU1YNlFETF9QQURfR1BJT183X19G
TEVYQ0FOMV9UWCAweDFiMGIwDQo+ID4gIAkJCU1YNlFETF9QQURfR1BJT184X19GTEVYQ0FOMV9S
WCAweDFiMGIwDQo+ID4gIAkJPjsNCj4gPiAgCX07DQo+ID4gIA0KPiA+IC0JcGluY3RybF9mbGV4
Y2FuMjogZmxleGNhbjJncnAgew0KPiA+ICsJcGluY3RybF9mbGV4Y2FuMV9zbGVlcDogZmxleGNh
bjFzbHBncnAgew0KPiA+ICsJCWZzbCxwaW5zID0gPA0KPiA+ICsJCQlNWDZRRExfUEFEX0dQSU9f
N19fR1BJTzFfSU8wNyAweDANCj4gPiArCQkJTVg2UURMX1BBRF9HUElPXzhfX0dQSU8xX0lPMDgg
MHgwDQo+ID4gKwkJPjsNCj4gPiArCX07DQo+ID4gKw0KPiA+ICsJcGluY3RybF9mbGV4Y2FuMl9k
ZWZhdWx0OiBmbGV4Y2FuMmRlZmdycCB7DQo+ID4gIAkJZnNsLHBpbnMgPSA8DQo+ID4gIAkJCU1Y
NlFETF9QQURfS0VZX0NPTDRfX0ZMRVhDQU4yX1RYIDB4MWIwYjANCj4gPiAgCQkJTVg2UURMX1BB
RF9LRVlfUk9XNF9fRkxFWENBTjJfUlggMHgxYjBiMA0KPiA+ICAJCT47DQo+ID4gIAl9Ow0KPiA+
ICsJcGluY3RybF9mbGV4Y2FuMl9zbGVlcDogZmxleGNhbjJzbHBncnAgew0KPiA+ICsJCWZzbCxw
aW5zID0gPA0KPiA+ICsJCQlNWDZRRExfUEFEX0tFWV9DT0w0X19HUElPNF9JTzE0IDB4MA0KPiA+
ICsJCQlNWDZRRExfUEFEX0tFWV9ST1c0X19HUElPNF9JTzE1IDB4MA0KPiA+ICsJCT47DQo+ID4g
Kwl9Ow0KPiA+ICANCj4gPiAgCXBpbmN0cmxfZ3Bpb19ibF9vbjogZ3Bpb2Jsb24gew0KPiA+ICAJ
CWZzbCxwaW5zID0gPA0KPiA+IC0tIA0KPiA+IDIuMjIuMA0KPiA+IA0K
