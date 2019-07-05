Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB699C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CBC218BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RZbnFG3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfGEHcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:32:51 -0400
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:43399
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfGEHcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9SbYqWKT8xzCa4XrH4nv/1VRvV7Qt7GV08Eu8ox6w4=;
 b=RZbnFG3am4nNiiyDUdpWpSfsA+ryNSMzTw5gu4n+6fYkzVz8s5XCcUgURTBMI3Z3/QdJpiDDJcFpfRbVhjPYMsFX29G+08T+6ZWidQR2IAganF/P39eXfUzX9vuFXUnxFAeth53CHZIyYJGsacyPARLALRMzQqALMGzR00RQ+V0=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB2767.eurprd04.prod.outlook.com (10.172.255.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 07:32:47 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::cddf:10d0:7cb3:c4cc]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::cddf:10d0:7cb3:c4cc%4]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 07:32:46 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
CC:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH nvmem 1/1] nvmem: imx: correct the fuse word
 index
Thread-Topic: [EXT] Re: [PATCH nvmem 1/1] nvmem: imx: correct the fuse word
 index
Thread-Index: AQHVMnTebEkQdGkfgE+cLXzkUFRHUqa6mimAgAAFbBCAAK/PoIAATbyAgAACa6A=
Date:   Fri, 5 Jul 2019 07:32:46 +0000
Message-ID: <VI1PR0402MB36002D8F896C5A5033A0DA4AFFF50@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190704142015.10701-1-fugang.duan@nxp.com>
        <20190704174543.194a0158@karo-electronics.de>
        <VI1PR0402MB3600D635FF12DC861FAD9BF6FFFA0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
        <VI1PR0402MB360040318C9FB6656B46C566FFF50@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <20190705091235.365b93cb@karo-electronics.de>
In-Reply-To: <20190705091235.365b93cb@karo-electronics.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27919343-8696-4e2a-dc35-08d7011af9e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2767;
x-ms-traffictypediagnostic: VI1PR0402MB2767:
x-microsoft-antispam-prvs: <VI1PR0402MB276747DE7CC7E90001896692FFF50@VI1PR0402MB2767.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(199004)(189003)(478600001)(76176011)(3846002)(6116002)(4326008)(6916009)(5660300002)(256004)(7696005)(86362001)(76116006)(66574012)(14454004)(25786009)(73956011)(102836004)(71200400001)(71190400001)(66476007)(66556008)(66446008)(6506007)(66946007)(64756008)(99286004)(186003)(8936002)(81156014)(81166006)(2906002)(8676002)(74316002)(26005)(7736002)(52536014)(229853002)(6246003)(486006)(54906003)(55016002)(476003)(53936002)(6436002)(68736007)(33656002)(316002)(305945005)(9686003)(11346002)(446003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2767;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HStEOap7jkmvowjQ04wlleAmefIxEpA++zFbvMIAJRaJ7s9ClIPpOYV+bJol27QMW01/zwPeHC6K9Nj+rAqj+tYOfU09HrxnHTwpKTSpQbW5l5a65QRvsb+RYv7lr99+E4yfG1fOS1h5B222dLk5LPLoK4waEiL5HI24xH8nJcJTXHYHnMtBeh36AQI+rHTDrEZj8rRxXLkKDBWUnfXK6mI+Ei58Y7f/uaR3QbVIxzGP7mhSQ/ZVHhjKfC5bKYfHWw+JLgAmOTvg/HBFVJC1Kb6GbBHMh1aXxa1hun/pbmKrVoEEGO+f6svFCmT0ROQv/NstGHzE9sVMOrBZ7ZseA4dR0ieo5SbzxXKFY7EzUPR5U23og/PE69hqpEnxYT9bA1bw24TPvCS97riAAiIEVYczzLprFUyS9AnuHrBkakk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27919343-8696-4e2a-dc35-08d7011af9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 07:32:46.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTG90aGFyIFdhw59tYW5uIDxMV0BLQVJPLWVsZWN0cm9uaWNzLmRlPiBTZW50OiBGcmlk
YXksIEp1bHkgNSwgMjAxOSAzOjEzIFBNDQo+IEhpLA0KPiANCj4gT24gRnJpLCA1IEp1bCAyMDE5
IDAyOjQ2OjMyICswMDAwIEFuZHkgRHVhbiB3cm90ZToNCj4gPiBGcm9tOiBBbmR5IER1YW4gU2Vu
dDogRnJpZGF5LCBKdWx5IDUsIDIwMTkgMTI6MDggQU0NCj4gPiA+IEZyb206IExvdGhhciBXYcOf
bWFubiA8TFdAS0FSTy1lbGVjdHJvbmljcy5kZT4gU2VudDogVGh1cnNkYXksIEp1bHkNCj4gPiA+
IDQsDQo+ID4gPiAyMDE5IDExOjQ2IFBNDQo+ID4gPiA+IEhpLA0KPiA+ID4gPg0KPiA+ID4gPiBP
biBUaHUsICA0IEp1bCAyMDE5IDIyOjIwOjE1ICswODAwIGZ1Z2FuZy5kdWFuQG54cC5jb20gd3Jv
dGU6DQo+ID4gPiA+ID4gRnJvbTogRnVnYW5nIER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBpTVg4IGZ1c2Ugd29yZCBpbmRleCByZXByZXNlbnQgYXMgb25l
IDQtYnl0ZXMgd29yZCwgaXQgc2hvdWxkDQo+ID4gPiA+ID4gbm90IGJlIGRpdmlkZWQgYnkgNC4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IEV4cDoNCj4gPiA+ID4gPiAtIE1BQzAgYWRkcmVzcyBsYXlv
dXQgaW4gZnVzZToNCj4gPiA+ID4gPiBvZmZzZXQgNzA4OiBNQUNbM10gTUFDWzJdIE1BQ1sxXSBN
QUNbMF0NCj4gPiA+ID4gPiBvZmZzZXQgNzA5OiBYWCAgICAgeHggICAgIE1BQ1s1XSBNQUNbNF0N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEZ1Z2FuZyBEdWFuIDxmdWdhbmcu
ZHVhbkBueHAuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL252bWVtL2lt
eC1vY290cC1zY3UuYyB8IDYgKysrLS0tDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAtc2N1LmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMv
bnZtZW0vaW14LW9jb3RwLXNjdS5jIGluZGV4IGQ5ZGM0ODIuLmJlMmY1ZjAgMTAwNjQ0DQo+ID4g
PiA+ID4gLS0tIGEvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAtc2N1LmMNCj4gPiA+ID4gPiArKysg
Yi9kcml2ZXJzL252bWVtL2lteC1vY290cC1zY3UuYw0KPiA+ID4gPiA+IEBAIC03MSw4ICs3MSw4
IEBAIHN0YXRpYyBpbnQgaW14X3NjdV9vY290cF9yZWFkKHZvaWQgKmNvbnRleHQsDQo+ID4gPiA+
ID4gdW5zaWduZWQNCj4gPiA+ID4gaW50IG9mZnNldCwNCj4gPiA+ID4gPiAgICAgICB2b2lkICpw
Ow0KPiA+ID4gPiA+ICAgICAgIGludCBpLCByZXQ7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAtICAg
ICBpbmRleCA9IG9mZnNldCA+PiAyOw0KPiA+ID4gPiA+IC0gICAgIG51bV9ieXRlcyA9IHJvdW5k
X3VwKChvZmZzZXQgJSA0KSArIGJ5dGVzLCA0KTsNCj4gPiA+ID4gPiArICAgICBpbmRleCA9IG9m
ZnNldDsNCj4gPiA+ID4gPiArICAgICBudW1fYnl0ZXMgPSByb3VuZF91cChieXRlcywgNCk7DQo+
ID4gPiA+ID4gICAgICAgY291bnQgPSBudW1fYnl0ZXMgPj4gMjsNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+ICAgICAgIGlmIChjb3VudCA+IChwcml2LT5kYXRhLT5ucmVncyAtIGluZGV4KSkgQEAgLTEw
MCw3ICsxMDAsNw0KPiA+ID4gPiA+IEBAIHN0YXRpYyBpbnQgaW14X3NjdV9vY290cF9yZWFkKHZv
aWQgKmNvbnRleHQsIHVuc2lnbmVkIGludCBvZmZzZXQsDQo+ID4gPiA+ID4gICAgICAgICAgICAg
ICBidWYrKzsNCj4gPiA+ID4gPiAgICAgICB9DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAtICAgICBt
ZW1jcHkodmFsLCAodTggKilwICsgb2Zmc2V0ICUgNCwgYnl0ZXMpOw0KPiA+ID4gPiA+ICsgICAg
IG1lbWNweSh2YWwsICh1OCAqKXAsIGJ5dGVzKTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICAg
IGtmcmVlKHApOw0KPiA+ID4gPiA+DQo+ID4gPiA+IFdpdGggdGhlc2UgY2hhbmdlcyB5b3UgY291
bGQgdXNlIHRoZSAndmFsJyBwb2ludGVyIGRpcmVjdGx5IGFzIHRoZQ0KPiA+ID4gPiBkZXN0aW5h
dGlvbiBmb3Igb2NvdHBfcmVhZCgpIHdpdGhvdXQgbmVlZCBmb3IgYW4gaW50ZXJtZWRpYXRlIGJ1
ZmZlci4NCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gTG90aGFyIFdhw59tYW5uDQo+ID4gPg0K
PiA+ID4gWW91IGFyZSByaWdodCwgaW4gZmFjdCwgd2UgY2FuIHJlbW92ZSAicCIgYW5kICJidWYi
IHBvaW50ZXIuDQo+ID4gPiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBJIHdpbGwgc2VuZCBvdXQg
dGhlIFYyLg0KPiA+DQo+ID4gSGkgTG90aGFyLA0KPiA+DQo+ID4gSXQgc3RpbGwgbmVlZCBpbnRl
cm1lZGlhdGUgYnVmZmVyIHRvIHJlYWQgb3V0IG4gd29yZHMgKG4gKiA0IGJ5dGVzKSBmcm9tDQo+
IGVGdXNlLg0KPiA+IEJlY2F1c2UgJ3ZhbCcgYnVmZmVyIHNpemUgaXMgcmVhbCBjb3VudCBwYXJz
ZWQgZnJvbSBEVCwgd2hpY2ggaXMgbm90IGFuIGludGVnZXINCj4gbXVsdGlwbGUgb2YgNC4NCj4g
Pg0KPiA+IEZvciBleGFtcGxlLCBjZWxsLT5ieXRlcyBpcyBwYXJzZWQgZnJvbSAicmVnIiBwcm9w
ZXJ0eSBhbmQgaXQgaXMgcmVhbCBjb3VudA0KPiBsaWtlIDYuDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgZmVjX21hYzA6IG1hY0AyYzQgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmVnID0gPDB4MmM0IDY+Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIH07
DQo+ID4NCj4gPiBTbyB3ZSBoYXZlIHRvIHVzZSBpbnRlcm1lZGlhdGUgYnVmZmVyIGhlcmUuDQo+
ID4NCj4gdmFsIGlzIGEgdTMyIHBvaW50ZXIsIHNvIGxlZ2FsbHkgaXQgY2Fubm90IHBvaW50IHRv
IGFueSBidWZmZXIgd2hvc2Ugc2l6ZSBpcyBub3QNCj4gZGl2aXNpYmxlIGJ5IGZvdXIhDQo+IA0K
WWVzLCB2YWwgaXMgYSB1MzIgcG9pbnRlciwgYXMgbXkgdW5kZXJzdGFuZCwgaXQgcG9pbnQgdG8g
dGhlICdidWYnIHdob3NlIHNpemUgaXMgY2VsbC0+Ynl0ZXMNCih0aGUgc2l6ZSBpcyBub3QgcGFy
c2VkIGZyb20gJ3JlZycgcHJvcGVydHkpDQoNClRoZSBwaWVjZSBvZiBjb2RlOiANCmJ1ZiA9IGt6
YWxsb2MoY2VsbC0+Ynl0ZXMsIEdGUF9LRVJORUwpOw0KbnZtZW1fcmVnX3JlYWQobnZtZW0sIGNl
bGwtPm9mZnNldCwgYnVmLCBjZWxsLT5ieXRlcyk7DQppbXhfc2N1X29jb3RwX3JlYWQodm9pZCAq
Y29udGV4dCwgdW5zaWduZWQgaW50IG9mZnNldCwgdm9pZCAqdmFsLCBzaXplX3QgYnl0ZXMpOw0K
DQpJZiBzbywgd2Ugc3RpbGwgbmVlZCBpbnRlcm1lZGlhdGUgYnVmZmVyIHRvIHJlYWQgb3V0IGVG
dXNlIHdvcmRzLCBhbmQgY29weSAnY2VsbC0+Ynl0ZXMnDQpieXRlcyB0byAndmFsJyBidWZmZXIu
IA0KTWF5IEkgdW5kZXJzdGFuZCB3cm9uZyA/IFRoYW5rcyB2ZXJ5IG11Y2ghDQo=
