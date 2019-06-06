Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C9AC28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 03:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755FC20866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 03:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JfFzytL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfFFDfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 23:35:18 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:52611
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbfFFDfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 23:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGscsX3OIJbzAHdAqp82TDK6y2DtFAkBLBWlJZig1Cw=;
 b=JfFzytL+Sxbtz8d2mnvrcXVu6vnbmolPuMslZAJBmy4AxjFeoqu9wXwt3uNobiIBkectreyfixMk77Kj/Ldw2e2Go38+jp+f1xR9UN7lvwHdQHHYyxU1BhSiCqzoQyi4ZjiTG612n2P0rDSOS2VMOGje0hUiR0nwSKNVA248clE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4050.eurprd04.prod.outlook.com (52.134.91.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 03:35:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6090:1f0b:b85b:8015]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6090:1f0b:b85b:8015%3]) with mapi id 15.20.1943.023; Thu, 6 Jun 2019
 03:35:11 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Topic: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
Thread-Index: AQHVGeZUO66GnquMY06cfK/cKOI4kaaKICEAgAPbFNA=
Date:   Thu, 6 Jun 2019 03:35:11 +0000
Message-ID: <AM0PR04MB44816AA83C8B817F8E6DF6EB88170@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-3-peng.fan@nxp.com>
 <866db682-785a-e0a6-b394-bb65c7a694c6@gmail.com>
In-Reply-To: <866db682-785a-e0a6-b394-bb65c7a694c6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a89990ef-3fdf-409a-c846-08d6ea2ffb37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4050;
x-ms-traffictypediagnostic: AM0PR04MB4050:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB405072379E522B3D22FB5F0B88170@AM0PR04MB4050.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(14454004)(498600001)(68736007)(45080400002)(44832011)(6436002)(99286004)(52536014)(7736002)(476003)(229853002)(7696005)(55016002)(6116002)(86362001)(76176011)(54906003)(6306002)(110136005)(9686003)(3846002)(102836004)(53546011)(6506007)(2201001)(2906002)(66066001)(64756008)(8936002)(7416002)(966005)(5660300002)(71190400001)(74316002)(66556008)(8676002)(26005)(81156014)(81166006)(486006)(305945005)(76116006)(11346002)(446003)(71200400001)(186003)(73956011)(2501003)(6246003)(256004)(25786009)(33656002)(4326008)(53936002)(15650500001)(66946007)(66476007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4050;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yYd6AnxcBZLYnfJ73CeBX+2xmIdZI3Q749meM8xfJGORQb+Z3I1Hy7HLTIubd+uOjqXgVD7a86RMyVTlpJCmUrd/CruFgqZ+BN61YHstOqy7HgOZxZ1ZWgaJf4GzkWRzKJKT+kZXNHYpJ5U6j1DFhNUf9zM1KvXXHjIPO7MKcUGzAjG2hJtdyJg9FGEKCwUPPWZuV/mMjZXzGJ0AcLo1Ctu/0bfcGRx+/qrqjciVR1KCCnxW29f+TLJ+OITVUIKD7Bys+rQ3FjynfPOcL3gcKBpT+kr2u5EwAXS8nJe0RyE+k9qRdn2tvpSMJHxLtQtwkAg540ImlLG2XYyDu8timfT7nxCuEMMRMEtuFqTifYsfj4CIRQLhlbZnjZfzfTC0rmfKDZU53zPbojjirNQbAl9SurToL3G7EmXFfXifw5I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89990ef-3fdf-409a-c846-08d6ea2ffb37
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 03:35:11.7703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDIvMl0gbWFpbGJveDogaW50cm9kdWNlIEFSTSBTTUMg
YmFzZWQgbWFpbGJveA0KPiANCj4gT24gNi8zLzE5IDE6MzAgQU0sIHBlbmcuZmFuQG54cC5jb20g
d3JvdGU6DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBU
aGlzIG1haWxib3ggZHJpdmVyIGltcGxlbWVudHMgYSBtYWlsYm94IHdoaWNoIHNpZ25hbHMgdHJh
bnNtaXR0ZWQNCj4gPiBkYXRhIHZpYSBhbiBBUk0gc21jIChzZWN1cmUgbW9uaXRvciBjYWxsKSBp
bnN0cnVjdGlvbi4gVGhlIG1haWxib3gNCj4gPiByZWNlaXZlciBpcyBpbXBsZW1lbnRlZCBpbiBm
aXJtd2FyZSBhbmQgY2FuIHN5bmNocm9ub3VzbHkgcmV0dXJuIGRhdGENCj4gPiB3aGVuIGl0IHJl
dHVybnMgZXhlY3V0aW9uIHRvIHRoZSBub24tc2VjdXJlIHdvcmxkIGFnYWluLg0KPiA+IEFuIGFz
eW5jaHJvbm91cyByZWNlaXZlIHBhdGggaXMgbm90IGltcGxlbWVudGVkLg0KPiA+IFRoaXMgYWxs
b3dzIHRoZSB1c2FnZSBvZiBhIG1haWxib3ggdG8gdHJpZ2dlciBmaXJtd2FyZSBhY3Rpb25zIG9u
IFNvQ3MNCj4gPiB3aGljaCBlaXRoZXIgZG9uJ3QgaGF2ZSBhIHNlcGFyYXRlIG1hbmFnZW1lbnQg
cHJvY2Vzc29yIG9yIG9uIHdoaWNoDQo+ID4gc3VjaCBhIGNvcmUgaXMgbm90IGF2YWlsYWJsZS4g
QSB1c2VyIG9mIHRoaXMgbWFpbGJveCBjb3VsZCBiZSB0aGUgU0NQDQo+ID4gaW50ZXJmYWNlLg0K
PiA+DQo+ID4gTW9kaWZpZWQgZnJvbSBBbmRyZSBQcnp5d2FyYSdzIHYyIHBhdGNoDQo+ID4gaHR0
cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNB
JTJGJTJGbG9yZQ0KPiA+IC5rZXJuZWwub3JnJTJGcGF0Y2h3b3JrJTJGcGF0Y2glMkY4MTI5OTkl
MkYmYW1wO2RhdGE9MDIlN0MwMSU3DQo+IENwZW5nLmZhDQo+ID4NCj4gbiU0MG54cC5jb20lN0Nh
YTM5NmJhMTFiYTI0NDExMWZlNDA4ZDZlODQxMWZiYSU3QzY4NmVhMWQzYmMyYjQNCj4gYzZmYTky
Y2QNCj4gPg0KPiA5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2OTUxNzYzNzM4NTQ4NjIxJmFtcDtz
ZGF0YT1VbE5FU05nN0k3DQo+IDRUTTl4cCUyRg0KPiA+IFZNY2U0Q1NiTXVKOTVsaDY4Y1F3JTJG
blFNT3clM0QmYW1wO3Jlc2VydmVkPTANCj4gPg0KPiA+IENjOiBBbmRyZSBQcnp5d2FyYSA8YW5k
cmUucHJ6eXdhcmFAYXJtLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFtzbmlwXQ0KPiANCj4gKyNkZWZpbmUgQVJNX1NN
Q19NQk9YX1VTQl9JUlEJQklUKDEpDQo+IA0KPiBUaGF0IGZsYWcgYXBwZWFycyB1bnVzZWQuDQoN
CkknbGwgcmVtb3ZlIHRoaXMgaW4gVjMuDQoNCj4gDQo+ID4gK3N0YXRpYyBpbnQgYXJtX3NtY19t
Ym94X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiArCXN0cnVjdCBk
ZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlzdHJ1Y3QgbWJveF9jb250cm9sbGVyICpt
Ym94Ow0KPiA+ICsJc3RydWN0IGFybV9zbWNfY2hhbl9kYXRhICpjaGFuX2RhdGE7DQo+ID4gKwlj
b25zdCBjaGFyICptZXRob2Q7DQo+ID4gKwlib29sIHVzZV9odmMgPSBmYWxzZTsNCj4gPiArCWlu
dCByZXQsIGlycV9jb3VudCwgaTsNCj4gPiArCXUzMiB2YWw7DQo+ID4gKw0KPiA+ICsJaWYgKCFv
Zl9wcm9wZXJ0eV9yZWFkX3UzMihkZXYtPm9mX25vZGUsICJhcm0sbnVtLWNoYW5zIiwgJnZhbCkp
IHsNCj4gPiArCQlpZiAodmFsIDwgMSB8fCB2YWwgPiBJTlRfTUFYKSB7DQo+ID4gKwkJCWRldl9l
cnIoZGV2LCAiaW52YWxpZCBhcm0sbnVtLWNoYW5zIHZhbHVlICV1IG9mICVwT0ZuXG4iLA0KPiB2
YWwsIHBkZXYtPmRldi5vZl9ub2RlKTsNCj4gPiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwkJ
fQ0KPiA+ICsJfQ0KPiANCj4gU2hvdWxkIG5vdCB0aGUgdXBwZXIgYm91bmQgY2hlY2sgYmUgZG9u
ZSBhZ2FpbnN0IFVJTlRfTUFYIHNpbmNlIHZhbCBpcyBhbg0KPiB1bnNpZ25lZCBpbnQ/DQoNCkZp
eCBpbiBWMy4NCg0KPiANCj4gPiArDQo+ID4gKwlpcnFfY291bnQgPSBwbGF0Zm9ybV9pcnFfY291
bnQocGRldik7DQo+ID4gKwlpZiAoaXJxX2NvdW50ID09IC1FUFJPQkVfREVGRVIpDQo+ID4gKwkJ
cmV0dXJuIGlycV9jb3VudDsNCj4gPiArDQo+ID4gKwlpZiAoaXJxX2NvdW50ICYmIGlycV9jb3Vu
dCAhPSB2YWwpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgIkludGVycnVwdHMgbm90IG1hdGNoIG51
bS1jaGFuc1xuIik7DQo+IA0KPiBJbnRlcnJ1cHRzIHByb3BlcnR5IGRvZXMgbm90IG1hdGNoIFwi
YXJtLG51bS1jaGFuc1wiIHdvdWxkIGJlIG1vcmUNCj4gY29ycmVjdC4NCg0KRml4IGluIFYzLg0K
DQo+IA0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmICgh
b2ZfcHJvcGVydHlfcmVhZF9zdHJpbmcoZGV2LT5vZl9ub2RlLCAibWV0aG9kIiwgJm1ldGhvZCkp
IHsNCj4gPiArCQlpZiAoIXN0cmNtcCgiaHZjIiwgbWV0aG9kKSkgew0KPiA+ICsJCQl1c2VfaHZj
ID0gdHJ1ZTsNCj4gPiArCQl9IGVsc2UgaWYgKCFzdHJjbXAoInNtYyIsIG1ldGhvZCkpIHsNCj4g
PiArCQkJdXNlX2h2YyA9IGZhbHNlOw0KPiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJCWRldl93YXJu
KGRldiwgImludmFsaWQgXCJtZXRob2RcIiBwcm9wZXJ0eTogJXNcbiIsDQo+ID4gKwkJCQkgbWV0
aG9kKTsNCj4gPiArDQo+ID4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsJCX0NCj4gDQo+IEhh
dmluZyBhdCBsZWFzdCBvbmUgbWV0aG9kIHNwZWNpZmllZCBkb2VzIG5vdCBzZWVtIHRvIGJlIGNo
ZWNrZWQgbGF0ZXIgb24gaW4NCj4gdGhlIGNvZGUsIHNvIGlmIEkgb21pdHRlZCB0byBzcGVjaWZ5
IHRoYXQgcHJvcGVydHksIHdlIHdvdWxkIHN0aWxsIHJlZ2lzdGVyIHRoZQ0KPiBtYWlsYm94IGFu
ZCBkZWZhdWx0IHRvIHVzZSAic21jIiBzaW5jZSB0aGUgQVJNX1NNQ19NQk9YX1VTRV9IVkMgZmxh
Zw0KPiB3b3VsZCBub3QgYmUgc2V0LCB3b3VsZCBub3Qgd2Ugd2FudCB0byBtYWtlIHN1cmUgdGhh
dCB3ZSBkbyBoYXZlIGluIGZhY3QgYQ0KPiB2YWxpZCBtZXRob2Qgc3BlY2lmaWVkIGdpdmVuIHRo
ZSBiaW5kaW5nIGRvY3VtZW50cyB0aGF0IHByb3BlcnR5IGFzDQo+IG1hbmRhdG9yeT8NCg0KV2hl
biBhcm1fc21jX3NlbmRfZGF0YSwgaXQgd2lsbCBjaGVjayBBUk1fU01DX01CT1hfVVNFX0hWQywN
CnlvdSBtZWFuIHRoZXJlIGFyZSBvdGhlciBwbGFjZXMgbmVlZHMgdGhpcyBmbGFnIGNoZWNrPw0K
DQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gKwltYm94LT50eGRvbmVfcG9sbCA9IGZhbHNlOw0KPiA+
ICsJbWJveC0+dHhkb25lX2lycSA9IGZhbHNlOw0KPiA+ICsJbWJveC0+b3BzID0gJmFybV9zbWNf
bWJveF9jaGFuX29wczsNCj4gPiArCW1ib3gtPmRldiA9IGRldjsNCj4gPiArDQo+ID4gKwlyZXQg
PSBtYm94X2NvbnRyb2xsZXJfcmVnaXN0ZXIobWJveCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJ
CXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgbWJv
eCk7DQo+IA0KPiBJIHdvdWxkIG1vdmUgdGhpcyBhYm92ZSBtYm94X2NvbnRyb2xsZXJfcmVnaXN0
ZXIoKSB0aGF0IHdheSB0aGVyZSBpcyBubyByb29tDQo+IGZvciByYWNlIGNvbmRpdGlvbnMgaW4g
Y2FzZSBhbm90aGVyIHBhcnQgb2YgdGhlIGRyaXZlciBleHBlY3RzIHRvIGhhdmUNCj4gcGRldi0+
ZGV2LmRydmRhdGEgc2V0IGJlZm9yZSB0aGUgbWJveCBjb250cm9sbGVyIGlzIHJlZ2lzdGVyZWQu
DQoNClJpZ2h0Lg0KDQo+IFNpbmNlIHlvdSB1c2UgZGV2bV8qIGZ1bmN0aW9ucyBmb3IgZXZlcnl0
aGluZywgeW91IG1heSBldmVuIHJlbW92ZSB0aGF0DQo+IGNhbGwuDQoNCllvdSBtZWFuIHJlbW92
ZSAiIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIG1ib3gpOyIgPw0KDQo+IA0KPiBbc25pcF0N
Cj4gDQo+ID4gKyNpZm5kZWYgX0xJTlVYX0FSTV9TTUNfTUFJTEJPWF9IXw0KPiA+ICsjZGVmaW5l
IF9MSU5VWF9BUk1fU01DX01BSUxCT1hfSF8NCj4gPiArDQo+ID4gK3N0cnVjdCBhcm1fc21jY2Nf
bWJveF9jbWQgew0KPiA+ICsJdW5zaWduZWQgbG9uZyBhMCwgYTEsIGEyLCBhMywgYTQsIGE1LCBh
NiwgYTc7IH07DQo+IA0KPiBEbyB5b3UgZXhwZWN0IHRoaXMgdG8gYmUgdXNlZCBieSBvdGhlciBp
bi1rZXJuZWwgdXNlcnM/IElmIHNvLCBpdCBtaWdodCBiZSBnb29kDQo+IHRvIGRvY3VtZW50IGhv
dyBhMCBjYW4gaGF2ZSBhIHNwZWNpYWwgbWVhbmluZyBhbmQgYmUgdXNlZCBhcyBhIHN1YnN0aXR1
dGUNCj4gZm9yIHRoZSBmdW5jdGlvbl9pZD8NCg0KVGhpcyB3YXMgdG8gYWRkcmVzcyBjb21tZW50
cyBoZXJlOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzgxMjk5OS8j
MTAxMDQzMw0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IC0tDQo+IEZsb3JpYW4NCg==
