Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B978C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AF7233A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="koU5cSZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfHUMt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:49:58 -0400
Received: from mail-eopbgr30137.outbound.protection.outlook.com ([40.107.3.137]:55910
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727910AbfHUMt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:49:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDlZcG5SRcmOWa+Hy53BgPCW6RQcRIISwYa3XOFT2kp57osrw66ARg+EZcnLkOWb/orVSo8lAt6haptI/kSQ+iN07oKFW/4jeElu0Gna1UgGC0jTFNbKkxkWMPdYtTBNdH52GVvd9Km68JwPjsb1SqmnwlZ3+nFDkBwC64iF/Quf2sP1lDMZXNQvamSIxxW2fNz7dj4HwxqHe0nZ+PjNLKq5GFL/lyr+EDj9mfYJLfwzY8aSKZgG4aDVM2JpxETS89G3fj4xCUi8f/20XQubssf6v00nfh0bKGptFf5NmNPy98eNPrbRIYbgiP1kdozeKbV4XrGKR93MVsMDXQQ7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBU/aNPlPu+bOiP5JoPcF5QZ0GSgwalm882I31f6wtk=;
 b=Kfx2xHvzgh+r91M+9wBMuij3xF8xxNEWZypiLccNA+aZKOvlbgaaiM7Wyc0ItR0wqYqgsDfaGRbAE5xmXkIj3AFMzRSmrnG2IMaXiLarfi2CDGNhQSU8PTPx0AvdI2w1FnrpYErQKZsIo6r3D9p1uq+9M4hVFFPJsGGZKTPLiFuEP9jm7sg3bUzwk0Vg+V4+MR8D8Cg7E9Jszub4JrEchEDsjg0VV4dvP6+hGus0oTjwzTooy2u52itDhZBp5IPmXiJrcbHNfGZKU6OJQprlYzimDm+Dnl/YoCJ1h5oUlD73jmNWFRXD1BH5BYtvYjAq1vWxoozC22t6+B5Q2tSulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBU/aNPlPu+bOiP5JoPcF5QZ0GSgwalm882I31f6wtk=;
 b=koU5cSZyUIgUdwYZHEnPxsgugsnX5D0bBSGQDCflp+ehwWHW1fikWnIB5ji2StLuZHE7ROBX+bc0X3JkV3WU5Mh2MQPw9RphJrKM3ZRpu5NXSx4NruOzGFvcDaerIl4NahC59LO5gjV4umPoJDhDOHJmja7sprdrbjGEkjh/aDA=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3934.eurprd05.prod.outlook.com (52.134.6.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 12:49:50 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2178.018; Wed, 21 Aug 2019
 12:49:50 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v4 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Topic: [PATCH v4 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Index: AQHVURk5IAfU3hfTCUmCBg5Kg1vuIacCXYsAgAM+GIA=
Date:   Wed, 21 Aug 2019 12:49:50 +0000
Message-ID: <94652d0c26732e159221bcfbca08e50e9e1f5f41.camel@toradex.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
         <20190812142105.1995-8-philippe.schenker@toradex.com>
         <20190819111847.GQ5999@X250>
In-Reply-To: <20190819111847.GQ5999@X250>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03ca9955-26ec-499a-cc16-08d726360e45
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3934;
x-ms-traffictypediagnostic: VI1PR0502MB3934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3934100F26D40273A8D5DBF6F4AA0@VI1PR0502MB3934.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(5660300002)(86362001)(4326008)(2501003)(66066001)(99286004)(54906003)(14454004)(6246003)(53936002)(6116002)(3846002)(7416002)(25786009)(316002)(76176011)(71200400001)(71190400001)(186003)(102836004)(81156014)(2351001)(6506007)(1730700003)(6436002)(229853002)(486006)(44832011)(561944003)(76116006)(36756003)(478600001)(5640700003)(8676002)(305945005)(66476007)(91956017)(66446008)(66556008)(2616005)(64756008)(7736002)(11346002)(66946007)(118296001)(26005)(446003)(256004)(6512007)(81166006)(476003)(8936002)(6916009)(6486002)(2906002)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3934;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b4Hvlgy/jPOhvTlTR0Q9TAcYF7d4CZVZFTw+QHssH/UknTP7r876pRrLvxdtDTpeQ1kW/AFgCQ3VGlD8bmBX+DkEueu6GSIo0ngNcljLhxjup/ePDmVe8FTgrHly8bHslSyigocDZIv6VUcRlWZ5mIMp2mmDryndVHItxC5xk4z1njUMehQFutw9YV1+c3siuq/0mJL1K6yLjibWKZ78OmSDuSbBPQAdkwn0eL/HJRZNOEwiN36KVbhYFeliQYmVDs8VadF4LZ2xdL53l+h2iniGE7ht0Pyt+1BQlvHdpRnZMa7kY5ROx1p4Jfgr5W3j1M0vwgUG7etrRFX5I/HuC+JUsyNcVl8UIklew4PT/hxQRQOHfIHxu8WdIZQ10u6OuTutK9RaWqd8MZUx00gABIm0cNsBMt9Ego3den075cc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAD4D12799869A40AA8BE48071850D29@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ca9955-26ec-499a-cc16-08d726360e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 12:49:50.4589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/f+ViAN6W+OaR6l5FUDNtcmSpJlIvGcmsKvFmY2ky2MXjedCxuL1ZCwPQlQQF7Kcf+kmRLMawIvWwkSk/IYigKChBtrWsBvr9rkY+Am1zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTE5IGF0IDEzOjE4ICswMjAwLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9u
IE1vbiwgQXVnIDEyLCAyMDE5IGF0IDAyOjIxOjI1UE0gKzAwMDAsIFBoaWxpcHBlIFNjaGVua2Vy
IHdyb3RlOg0KPiA+IEZyb206IFN0ZWZhbiBBZ25lciA8c3RlZmFuLmFnbmVyQHRvcmFkZXguY29t
Pg0KPiA+IA0KPiA+IEFkZCBwaW5tdXhpbmcgYW5kIGRvIG5vdCBzcGVjaWZ5IHZvbHRhZ2UgcmVz
dHJpY3Rpb25zIGZvciB0aGUgdXNkaGMNCj4gPiBpbnN0YW5jZSBhdmFpbGFibGUgb24gdGhlIG1v
ZHVsZXMgZWRnZSBjb25uZWN0b3IuIFRoaXMgYWxsb3dzIHRvIHVzZQ0KPiA+IFNELWNhcmRzIHdp
dGggaGlnaGVyIHRyYW5zZmVyIG1vZGVzIGlmIHN1cHBvcnRlZCBieSB0aGUgY2Fycmllcg0KPiA+
IGJvYXJkLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBBZ25lciA8c3RlZmFuLmFn
bmVyQHRvcmFkZXguY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxw
aGlsaXBwZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCj4gPiBBY2tlZC1ieTogTWFyY2VsIFppc3dp
bGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gLS0tDQo+ID4gDQo+
ID4gQ2hhbmdlcyBpbiB2NDoNCj4gPiAtIEFkZCBNYXJjZWwgWmlzd2lsZXIncyBBY2sNCj4gPiAN
Cj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+IC0gQWRkIG5ldyBjb21taXQgbWVzc2FnZSBmcm9tIFN0
ZWZhbidzIHByb3Bvc2FsIG9uIE1MDQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2MjogTm9uZQ0KPiA+
IA0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaSB8IDIzICsrKysrKysr
KysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDctY29saWJyaS5kdHNpDQo+ID4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRz
aQ0KPiA+IGluZGV4IDUzNDdlZDM4YWNiMi4uYzU2M2JiODIxYjVlIDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14Ny1jb2xpYnJpLmR0c2kNCj4gPiBAQCAtMzI2LDcgKzMyNiw2IEBADQo+ID4g
ICZ1c2RoYzEgew0KPiA+ICAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiAgCXBpbmN0
cmwtMCA9IDwmcGluY3RybF91c2RoYzEgJnBpbmN0cmxfY2RfdXNkaGMxPjsNCj4gPiAtCW5vLTEt
OC12Ow0KPiA+ICAJY2QtZ3Bpb3MgPSA8JmdwaW8xIDAgR1BJT19BQ1RJVkVfTE9XPjsNCj4gPiAg
CWRpc2FibGUtd3A7DQo+ID4gIAl2cW1tYy1zdXBwbHkgPSA8JnJlZ19MRE8yPjsNCj4gPiBAQCAt
NjcxLDYgKzY3MCwyOCBAQA0KPiA+ICAJCT47DQo+ID4gIAl9Ow0KPiA+ICANCj4gPiArCXBpbmN0
cmxfdXNkaGMxXzEwMG1oejogdXNkaGMxZ3JwXzEwMG1oeiB7DQo+ID4gKwkJZnNsLHBpbnMgPSA8
DQo+ID4gKwkJCU1YN0RfUEFEX1NEMV9DTURfX1NEMV9DTUQJMHg1YQ0KPiA+ICsJCQlNWDdEX1BB
RF9TRDFfQ0xLX19TRDFfQ0xLCTB4MWENCj4gPiArCQkJTVg3RF9QQURfU0QxX0RBVEEwX19TRDFf
REFUQTAJMHg1YQ0KPiA+ICsJCQlNWDdEX1BBRF9TRDFfREFUQTFfX1NEMV9EQVRBMQkweDVhDQo+
ID4gKwkJCU1YN0RfUEFEX1NEMV9EQVRBMl9fU0QxX0RBVEEyCTB4NWENCj4gPiArCQkJTVg3RF9Q
QURfU0QxX0RBVEEzX19TRDFfREFUQTMJMHg1YQ0KPiA+ICsJCT47DQo+ID4gKwl9Ow0KPiA+ICsN
Cj4gPiArCXBpbmN0cmxfdXNkaGMxXzIwMG1oejogdXNkaGMxZ3JwXzIwMG1oeiB7DQo+IA0KPiBO
byByZWZlcmVuY2UgdG8gdGhlbSBmcm9tIHVzZGhjMSBub2RlPw0KPiANCj4gU2hhd24NCg0KTm8u
IEknZCBsaWtlIHRvIGhhdmUgdGhhdCBwaW5tdXhpbmcgcHJlcGFyZWQgZm9yIHNvbWVvbmUgdG8g
YWRkIFVIUw0Kc3VwcG9ydCB0byBTRC4gUHJpbWFyeSBmdW5jdGlvbmFsaXR5IG9mIHRoYXQgcGlu
cyBpcyBzb21ldGhpbmcgZWxzZSBzbw0KdGhpcyB3aWxsIGhhdmUgcHJpb3JpdHkuDQoNClBoaWxp
cHBlDQoNCj4gDQo+ID4gKwkJZnNsLHBpbnMgPSA8DQo+ID4gKwkJCU1YN0RfUEFEX1NEMV9DTURf
X1NEMV9DTUQJMHg1Yg0KPiA+ICsJCQlNWDdEX1BBRF9TRDFfQ0xLX19TRDFfQ0xLCTB4MWINCj4g
PiArCQkJTVg3RF9QQURfU0QxX0RBVEEwX19TRDFfREFUQTAJMHg1Yg0KPiA+ICsJCQlNWDdEX1BB
RF9TRDFfREFUQTFfX1NEMV9EQVRBMQkweDViDQo+ID4gKwkJCU1YN0RfUEFEX1NEMV9EQVRBMl9f
U0QxX0RBVEEyCTB4NWINCj4gPiArCQkJTVg3RF9QQURfU0QxX0RBVEEzX19TRDFfREFUQTMJMHg1
Yg0KPiA+ICsJCT47DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiAgCXBpbmN0cmxfdXNkaGMzOiB1c2Ro
YzNncnAgew0KPiA+ICAJCWZzbCxwaW5zID0gPA0KPiA+ICAJCQlNWDdEX1BBRF9TRDNfQ01EX19T
RDNfQ01ECQkweDU5DQo+ID4gLS0gDQo+ID4gMi4yMi4wDQo+ID4gDQo=
