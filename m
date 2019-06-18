Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C84C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF6F2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WvXG+EfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfFRKtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:49:22 -0400
Received: from mail-eopbgr130041.outbound.protection.outlook.com ([40.107.13.41]:29386
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729336AbfFRKtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBiB4EsQD203gdYqqnnrq8RynbLpMtdF88nAFrAA3Zg=;
 b=WvXG+EfAjwGR/bfr1gXm85w1r5q6w/nTN5cjxaASR5/RnyesB/g6i5HhBErJaR5ycgKYePfiNK4/2uUVhOJGKd8KavE2rfK4ATY1dj5ZHfZnk4pTzzTAsyLywZlWDE7TJJicfHN97g1pEGMqVnQJ2Up4hI6VUVijb+9sthEUw+4=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB5344.eurprd04.prod.outlook.com (52.134.123.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 10:48:38 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 10:48:38 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Fredrik Noring <noring@nocrew.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: RE: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Thread-Topic: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Thread-Index: AQHVFglQh61utyy7REWzlg711VXbgaaNpCgAgAjj+YCAAEGFAIAAGw2AgALKX4CAAAPKAIAAG/oAgAAqUQCAB1inIA==
Date:   Tue, 18 Jun 2019 10:48:38 +0000
Message-ID: <VI1PR04MB51346AA0043FEB5E08E058C5ECEA0@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-4-laurentiu.tudor@nxp.com>
 <20190605214622.GA22254@roeck-us.net> <20190611133223.GA30054@roeck-us.net>
 <20190611172654.GA2602@sx9> <20190611190343.GA18459@roeck-us.net>
 <20190613134033.GA2489@sx9>
 <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net>
 <20190613153414.GA909@sx9>
 <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net>
In-Reply-To: <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6969ef7c-df52-40bc-97ff-08d6f3da8527
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5344;
x-ms-traffictypediagnostic: VI1PR04MB5344:
x-microsoft-antispam-prvs: <VI1PR04MB534487A1240683188E73B296ECEA0@VI1PR04MB5344.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(51914003)(13464003)(7416002)(4326008)(66446008)(305945005)(7736002)(66556008)(66946007)(66476007)(64756008)(478600001)(73956011)(9686003)(14454004)(76116006)(316002)(26005)(486006)(14444005)(6116002)(71190400001)(5024004)(66066001)(186003)(3846002)(476003)(68736007)(256004)(11346002)(446003)(71200400001)(5660300002)(25786009)(81156014)(33656002)(6436002)(102836004)(110136005)(53936002)(53546011)(86362001)(6506007)(52536014)(81166006)(76176011)(6246003)(229853002)(2906002)(7696005)(55016002)(99286004)(8936002)(74316002)(44832011)(54906003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5344;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pmg/R0gHqMzdzw5rHVaX7Th10iokaUCG5B717HPrr6Flfdn3trLejkhxGHH54s7F6pEeJ/TZvbmBGK6SkeU0MrEAHgPOsEq7DPVch3sb3h95dtwK0CQLd1/PnPCW56kfZCDN6ZpXNLHN+Bi8RoANY479iCA2r20AFgEQ/0s+N4OOwA5KMyZhU87VOQaUlA36ewP4G776/y9Hgqk9R3KSr3SBBOlUHdlazOn+XfX8HTcSOju5JBCe4+ccNklvuB6aAVYieDbKvq/thpCyQdf1/lZFv3Y092WetOG6q6VvkvCtSPXd960m3/yq1Sw29W8jnkpWzD3jHdF3lxmAjGd8VvGqToevDhZ3uOObCYpSzswoesUE/Iw0whl5YMXUHmO6DCvMWkNUvWsbgAedcQr5AtxEWau0oL7CN0tHFFZnKq4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6969ef7c-df52-40bc-97ff-08d6f3da8527
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 10:48:38.0969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laurentiu.tudor@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBS
b2VjayA8Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNl
bnQ6IFRodXJzZGF5LCBKdW5lIDEzLCAyMDE5IDk6MDYgUE0NCj4gDQo+IE9uIDYvMTMvMTkgODoz
NCBBTSwgRnJlZHJpayBOb3Jpbmcgd3JvdGU6DQo+ID4gSGkgR3VlbnRlciwNCj4gPg0KPiA+PiBU
aGFua3MgZm9yIHRoZSBjb25maXJtYXRpb24uIERvIHlvdSBzZWUgdGhlIHByb2JsZW0gb25seSB3
aXRoIHRoZQ0KPiA+PiBvaGNpLXNtNTAxIGRyaXZlciBvciBhbHNvIHdpdGggb3RoZXJzID8NCj4g
Pg0KPiA+IEFsbCBhcmUgbGlrZWx5IGFmZmVjdGVkLCBidXQgaXQgZGVwZW5kcywgYmVjYXVzZSBJ
IGJlbGlldmUgdGhlIHByb2JsZW0NCj4gaXMNCj4gPiB0aGF0IHRoZSBVU0Igc3Vic3lzdGVtIHJ1
bnMgb3V0IG9mIG1lbW9yeS4gUGxlYXNlIHRyeSB0aGUgYXR0YWNoZWQgcGF0Y2ghDQo+ID4NCj4g
PiBUaGUgcG9vbCBhc3N1bWVkIDQwOTYgYnl0ZSBwYWdlIGFsaWdubWVudCBmb3IgZXZlcnkgYWxs
b2NhdGlvbiwgd2hpY2ggaXMNCj4gPiBleGNlc3NpdmUgZ2l2ZW4gdGhhdCBtYW55IHJlcXVlc3Rz
IGFyZSBmb3IgMTYgYW5kIDMyIGJ5dGVzLiBJbiB0aGUgcGF0Y2gNCj4gPiBiZWxvdywgSSBoYXZl
IHR1cm5lZCBkb3duIHRoZSBvcmRlciB0byA1LCB3aGljaCBpcyBnb29kIGVub3VnaCBmb3IgdGhl
DQo+IEVEDQo+ID4gYW5kIFREIHN0cnVjdHVyZXMgb2YgdGhlIE9IQ0ksIGJ1dCBub3QgZW5vdWdo
IGZvciB0aGUgSENDQSB0aGF0IG5lZWRzDQo+IDI1Ng0KPiA+IGJ5dGUgYWxpZ25tZW50LiBXaXRo
IHNvbWUgbHVjaywgdGhlIFdBUk5fT05fT05DRSB3aWxsIG5vdCB0cmlnZ2VyIGluDQo+IHlvdXIN
Cj4gPiB0ZXN0LCB0aG91Z2guIElmIGl0IGRvZXMsIHlvdSBtYXkgdHJ5IHRvIGluY3JlYXNlIHRo
ZSBvcmRlciBmcm9tIDUgdG8gOC4NCj4gPg0KPiANCj4gWW91IGFyZSByaWdodCwgdGhlIHBhdGNo
IGJlbG93IGZpeGVzIHRoZSBwcm9ibGVtLiBJIGRpZCBub3QgZ2V0IHRoZQ0KPiB3YXJuaW5nDQo+
IHdpdGggb3JkZXI9PTUuIE5ldmVydGhlbGVzcywgSSBhbHNvIHRlc3RlZCB3aXRoIG9yZGVyPT04
OyB0aGF0IHdvcmtzIGFzDQo+IHdlbGwuDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseSwgSSB3
YXMgT09PIGZvciBwYXN0IHdlZWsrIGFuZCBtYW55IHRoYW5rcyBmb3IgdGFraW5nIGEgbG9vayBh
dCB0aGlzLg0KU28gaWYgbXkgdW5kZXJzdGFuZGluZyBpcyBjb3JyZWN0LCBhbiBvcmRlciBvZiBQ
QUdFX1NISUZUIGlzIHRvbyBsYXJnZSBhbmQgbGVhZHMgdG8gd2FzdGUgb2YgbWVtb3J5IGFuZCBp
biB0aGUgZW5kIHRvIGFuIG91dCBvZiBtZW1vcnkgY29uZGl0aW9uLiBUaGlzIGxlYXZlcyBtZSB3
b25kZXJpbmcgd2hhdCBhIHNhZmUgb3JkZXIgdmFsdWUgd291bGQgYmUuDQpJJ2xsIHRyeSB0byBs
b29rIGludG8gdGhlIGxlZ2FjeSBkbWEgY29oZXJlbnQgYWxsb2NhdGlvbiBjb2RlIG1heWJlIEkg
Y2FuIGdhdGhlciBzb21lIGluZm8gb24gdGhlIHN1YmplY3QuDQoNCi0tLQ0KQmVzdCBSZWdhcmRz
LCBMYXVyZW50aXUNCg0KPiANCj4gPiBJIGhhdmUgb2JzZXJ2ZWQgc3RyYW5nZSB0aGluZ3MgaGFw
cGVuIHdoZW4gdGhlIFVTQiBzdWJzeXN0ZW0gcnVucyBvdXQgb2YNCj4gPiBtZW1vcnkuIFRoZSBt
YXNzIHN0b3JhZ2UgZHJpdmVycyBvZnRlbiBzZWVtIHRvIGJ1c3ktd2FpdCBvbiAtRU5PTUVNLA0K
PiA+IGNvbnN1bWluZyBhIGxvdCBvZiBwcm9jZXNzb3IgcmVzb3VyY2VzLiBJdCB3b3VsZCBiZSBt
dWNoIG1vcmUgZWZmaWNpZW50DQo+ID4gdG8gc2xlZXAgd2FpdGluZyBmb3IgbWVtb3J5IHRvIGJl
Y29tZSBhdmFpbGFibGUuDQo+ID4NCj4gPiBJbiB5b3VyIGNhc2UgSSBzdXNwZWN0IHRoYXQgYWxs
b2NhdGlvbiBmYWlsdXJlcyBhcmUgbm90IGNvcnJlY3RseQ0KPiA+IGF0dHJpYnV0ZWQuIENlcnRh
aW4ga2luZHMgb2YgdGVtcG9yYXJ5IGZyZWV6ZXMgbWF5IGFsc28gb2NjdXIsIGFzIHRoZQ0KPiA+
IHZhcmlvdXMgZGV2aWNlcyBhcmUgcmVzZXQgZHVlIHRvIGhvc3QgbWVtb3J5IGFsbG9jYXRpb24g
ZXJyb3JzLg0KPiA+ICA+IEZyZWRyaWsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9jb3JlL2hjZC5jIGIvZHJpdmVycy91c2IvY29yZS9oY2QuYw0KPiA+IC0tLSBhL2RyaXZlcnMv
dXNiL2NvcmUvaGNkLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9jb3JlL2hjZC5jDQo+ID4gQEAg
LTMwMTEsNyArMzAxMSw3IEBAIGludCB1c2JfaGNkX3NldHVwX2xvY2FsX21lbShzdHJ1Y3QgdXNi
X2hjZCAqaGNkLA0KPiBwaHlzX2FkZHJfdCBwaHlzX2FkZHIsDQo+ID4gICAJaW50IGVycjsNCj4g
PiAgIAl2b2lkIF9faW9tZW0gKmxvY2FsX21lbTsNCj4gPg0KPiA+IC0JaGNkLT5sb2NhbG1lbV9w
b29sID0gZGV2bV9nZW5fcG9vbF9jcmVhdGUoaGNkLT5zZWxmLnN5c2RldiwNCj4gUEFHRV9TSElG
VCwNCj4gPiArCWhjZC0+bG9jYWxtZW1fcG9vbCA9IGRldm1fZ2VuX3Bvb2xfY3JlYXRlKGhjZC0+
c2VsZi5zeXNkZXYsIDUsDQo+ID4gICAJCQkJCQkgIGRldl90b19ub2RlKGhjZC0+c2VsZi5zeXNk
ZXYpLA0KPiA+ICAgCQkJCQkJICBkZXZfbmFtZShoY2QtPnNlbGYuc3lzZGV2KSk7DQo+ID4gICAJ
aWYgKElTX0VSUihoY2QtPmxvY2FsbWVtX3Bvb2wpKQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9ob3N0L29oY2ktaGNkLmMgYi9kcml2ZXJzL3VzYi9ob3N0L29oY2ktaGNkLmMNCj4gPiAt
LS0gYS9kcml2ZXJzL3VzYi9ob3N0L29oY2ktaGNkLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9o
b3N0L29oY2ktaGNkLmMNCj4gPiBAQCAtNTE3LDYgKzUxNyw3IEBAIHN0YXRpYyBpbnQgb2hjaV9p
bml0IChzdHJ1Y3Qgb2hjaV9oY2QgKm9oY2kpDQo+ID4gICAJCQkJCQlHRlBfS0VSTkVMKTsNCj4g
PiAgIAlpZiAoIW9oY2ktPmhjY2EpDQo+ID4gICAJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsJV0FS
Tl9PTl9PTkNFKG9oY2ktPmhjY2FfZG1hICYgMHhmZik7DQo+ID4NCj4gPiAgIAlpZiAoKHJldCA9
IG9oY2lfbWVtX2luaXQgKG9oY2kpKSA8IDApDQo+ID4gICAJCW9oY2lfc3RvcCAoaGNkKTsNCj4g
Pg0KDQo=
