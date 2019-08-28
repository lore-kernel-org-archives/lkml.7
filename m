Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0441CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF08214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qdOLAeTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfH1BsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:48:21 -0400
Received: from mail-eopbgr150041.outbound.protection.outlook.com ([40.107.15.41]:19742
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbfH1BsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:48:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGvYCXbKRmhZu7dUOmXaeIJqQcF9kqzvDsMNBdEJGVY6rBzCfQHNs6IiOg/30UxDflKHB4YaGLrhaJme6og6fHRT4djsTuYbdyfNuuDzIoEvVaRoRQWoQYH2Sl5Bz7alywiIlP7nzIoMeCFOVuWOCn/QQSh2bpl/k2yrz8chRtA7YzX7IcVOp5/RudbJeD7ntdmpI57BCP3+SYb8GqivBTROIshbC41W1ufYCTbNoHX46KjMTlzE8X3dzzq/Miyi2xFagGZNZ9sPwr1Sz8WiswyCcJB9FXPNYaE29IM3JYPyH0A9EpLF9ZDUB/u7AHKYUgziGI/plJc/qBWVMVvMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB1ctoAauEct+yvK04W06MWvXhpMKF606kLZW0/mdL0=;
 b=SrgxD3Gb8Da1JnVkiaZU8yxUw1Yjqu74lBlv2a348Bp2oCwYKgMxK/Vxb4CbT/4/nTCnOifgIlgHQNrSnsBnd5Nb90CDpoYm7PYNMhasoL+fWaS4SgSEJtRudFnTYW7gRsyKx3t8NjQZNoFK2rQwjDLDztpYOe7cpu9uKJqXNSrrVmp0TNgy5qJ264A674+8CLES7yCgdN/qiqJ4NUlBcdSMNxGsxv9qdPnFe1l/bfP/0NS1mrmxwR9AWe54PyqGRfrlb4RFBKDkhr9gyZsuP+dpb870OwuQXraPx+kDvhF9oERKbrKYGmwbB1vEs/PjVWOBSvQ0Ihp+pfyStbSmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB1ctoAauEct+yvK04W06MWvXhpMKF606kLZW0/mdL0=;
 b=qdOLAeTyFWLJRtJ65N6F+hzvHT3hpP9IaIcC9ja02gk8Gi+vuj9BBd3eICUEZSiAoWeL2jJfIbFzvdeKmsyjQFXNHdifG25YrLr/7rDgWcGArIuXFiz3c2KYZ2HPvHAKwfKIoTzPfmGuocN4h10vl3KjIo/pnsIdyI/X6sC4r24=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5939.eurprd04.prod.outlook.com (20.178.112.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 01:48:16 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.023; Wed, 28 Aug 2019
 01:48:16 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
Thread-Topic: [PATCH] arm: xen: mm: use __GPF_DMA32 for arm64
Thread-Index: AQHVNi9zmpVhxJk2Z0aPUBEkePn3c6cPOA8AgADZ48A=
Date:   Wed, 28 Aug 2019 01:48:16 +0000
Message-ID: <AM0PR04MB4481386D2C54AEA6987E1B1588A30@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190709083729.11135-1-peng.fan@nxp.com>
 <d70b3a5c-647c-2147-99be-4572f76e898b@arm.com>
In-Reply-To: <d70b3a5c-647c-2147-99be-4572f76e898b@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9d8318e-890e-49e7-0e03-08d72b59cb9d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5939;
x-ms-traffictypediagnostic: AM0PR04MB5939:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5939F39C505E5EE10A983D5588A30@AM0PR04MB5939.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(71190400001)(316002)(54906003)(14444005)(305945005)(256004)(25786009)(4326008)(7736002)(2501003)(8936002)(2201001)(5660300002)(14454004)(33656002)(8676002)(110136005)(81156014)(81166006)(966005)(6506007)(45080400002)(6246003)(53546011)(102836004)(74316002)(53936002)(6436002)(476003)(44832011)(478600001)(71200400001)(99286004)(76176011)(7696005)(86362001)(446003)(6116002)(229853002)(3846002)(26005)(186003)(2906002)(76116006)(66446008)(64756008)(66556008)(66946007)(52536014)(66066001)(55016002)(11346002)(6306002)(486006)(9686003)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5939;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 74kF1JAvjmPg0usNrBqwQJEJGR4MN/7DUnmZFjedZIUCl1NoN5nh1lxL53uQkOPAdMqbB/zayJQC6Uh9GrvYwQ8YcvCcjpyn13r//lrtqpIpisD0WydxRHNDrqhwTIzK1xn6Lb3yIYKg7Q4zVMxjTdhd/I/QKFZCnF+QG727XvRf9TT4DSKFNhWqWLFThxpAUgq0KCdwmU6iYgjAQKurYppg7RhTZV1jMX9dqDRBnzVAfwWfgSaj230iiTRalcbNTWzsceoCH4JDjQbyKEqRgIPuAkOBFo8uXKAA5VgDfwtpUJB33exgjXLeHQbB10ioA0pCLgGYVVQzM3YKV6LvbeQseo7tVymJgWh5wRRf0EE+mQ9X/hiPLikpzAkI9qkCdYsQaSZsPUK8dMusDsgYGm7a2+d5diCg//W6Ib4jA1M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d8318e-890e-49e7-0e03-08d72b59cb9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 01:48:16.3386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JstgMBsE/0HwpivwhntAsKO2AtoYmJ4FooRgWzaV/CMkcUUMbbPtuz8QuYbOVr1GFh3LUkRa96aqzkrBD6Bi5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJtOiB4ZW46IG1tOiB1c2UgX19H
UEZfRE1BMzIgZm9yIGFybTY0DQo+IA0KPiBPbiAwOS8wNy8yMDE5IDA5OjIyLCBQZW5nIEZhbiB3
cm90ZToNCj4gPiBhcm02NCBzaGFyZXMgc29tZSBjb2RlIHVuZGVyIGFyY2gvYXJtL3hlbiwgaW5j
bHVkaW5nIG1tLmMuDQo+ID4gSG93ZXZlciBaT05FX0RNQSBpcyByZW1vdmVkIGJ5IGNvbW1pdA0K
PiA+IGFkNjdmNWE2NTQ1KCJhcm02NDogcmVwbGFjZSBaT05FX0RNQSB3aXRoIFpPTkVfRE1BMzIi
KS4NCj4gPiBTbyB0byBBUk02NCwgbmVlZCB1c2UgX19HRlBfRE1BMzIuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFy
Y2gvYXJtL3hlbi9tbS5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0veGVuL21t
LmMgYi9hcmNoL2FybS94ZW4vbW0uYyBpbmRleA0KPiA+IGUxZDQ0YjkwM2RmYy4uYTk1ZTc2ZDE4
YmY5IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL3hlbi9tbS5jDQo+ID4gKysrIGIvYXJjaC9h
cm0veGVuL21tLmMNCj4gPiBAQCAtMjcsNyArMjcsNyBAQCB1bnNpZ25lZCBsb25nIHhlbl9nZXRf
c3dpb3RsYl9mcmVlX3BhZ2VzKHVuc2lnbmVkDQo+ID4gaW50IG9yZGVyKQ0KPiA+DQo+ID4gICAJ
Zm9yX2VhY2hfbWVtYmxvY2sobWVtb3J5LCByZWcpIHsNCj4gPiAgIAkJaWYgKHJlZy0+YmFzZSA8
IChwaHlzX2FkZHJfdCkweGZmZmZmZmZmKSB7DQo+ID4gLQkJCWZsYWdzIHw9IF9fR0ZQX0RNQTsN
Cj4gPiArCQkJZmxhZ3MgfD0gX19HRlBfRE1BIHwgX19HRlBfRE1BMzI7DQo+IA0KPiBHaXZlbiB0
aGUgZGVmaW5pdGlvbiBvZiBHRlBfWk9ORV9CQUQsIEknbSBub3Qgc3VyZSB0aGlzIGNvbWJpbmF0
aW9uIG9mIGZsYWdzDQo+IGlzIHN0cmljdGx5IHZhbGlkLCBidXQgcmF0aGVyIGlzIGltcGxpY2l0
bHkgcmVsaWFudCBvbiBvbmx5IG9uZSBvZiB0aG9zZSB6b25lcyBldmVyDQo+IGFjdHVhbGx5IGV4
aXN0aW5nLiBBcyBzdWNoLCBpdCBzZWVtcyBsaWFibGUgdG8gYmxvdyB1cCBpZiB0aGUgcGxhbnMg
dG8gYWRkDQo+IFpPTkVfRE1BIHRvIGFybTY0WzFdIGdvIGFoZWFkLg0KDQpIb3cgYWJvdXQgdGhp
cywgb3IgZG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zPw0KZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L3hlbi9tbS5jIGIvYXJjaC9hcm0veGVuL21tLmMNCmluZGV4IGQzM2I3N2U5YWRkMy4uZjYxYzI5
YTQ0MzBmIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0veGVuL21tLmMNCisrKyBiL2FyY2gvYXJtL3hl
bi9tbS5jDQpAQCAtMjgsNyArMjgsMTEgQEAgdW5zaWduZWQgbG9uZyB4ZW5fZ2V0X3N3aW90bGJf
ZnJlZV9wYWdlcyh1bnNpZ25lZCBpbnQgb3JkZXIpDQoNCiAgICAgICAgZm9yX2VhY2hfbWVtYmxv
Y2sobWVtb3J5LCByZWcpIHsNCiAgICAgICAgICAgICAgICBpZiAocmVnLT5iYXNlIDwgKHBoeXNf
YWRkcl90KTB4ZmZmZmZmZmYpIHsNCisjaWZkZWYgQ09ORklHX0FSTTY0DQorICAgICAgICAgICAg
ICAgICAgICAgICBmbGFncyB8PSBfX0dGUF9ETUEzMjsNCisjZWxzZQ0KICAgICAgICAgICAgICAg
ICAgICAgICAgZmxhZ3MgfD0gX19HRlBfRE1BOw0KKyNlbmRpZg0KICAgICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7DQogICAgICAgICAgICAgICAgfQ0KICAgICAgICB9DQoNClRoYW5rcywNClBl
bmcuDQoNCj4gDQo+IFJvYmluLg0KPiANCj4gWzFdDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2UNCj4gcm5l
bC5vcmclMkZsaW51eC1hcm0ta2VybmVsJTJGMjAxOTA4MjAxNDU4MjEuMjcyMTQtMS1uc2Flbnpq
dWxpZW5uZSUNCj4gNDBzdXNlLmRlJTJGJmFtcDtkYXRhPTAyJTdDMDElN0NwZW5nLmZhbiU0MG54
cC5jb20lN0M1ZDJhNjQxYjENCj4gZTNmNDQ5NTYyZjkwOGQ3MmFlOTVkODUlN0M2ODZlYTFkM2Jj
MmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzANCj4gJTdDMCU3QzYzNzAyNTA1NDE2OTg1OTAzNSZh
bXA7c2RhdGE9MVpQR0gwZ1pudmdtbE1wWDdWcmpVTk1FDQo+IFhiRWppdjQlMkZaOXBZd1RRVFd4
WSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiANCj4gPiAgIAkJCWJyZWFrOw0KPiA+ICAgCQl9DQo+ID4g
ICAJfQ0KPiA+DQo=
