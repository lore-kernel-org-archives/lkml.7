Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3261AC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D285121019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 03:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r4Hhedmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfEWDWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 23:22:14 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:63653
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728237AbfEWDWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 23:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jc8QAdLka3+vwh4GMWsw6caF7o2j9HwB0Tql23UazI=;
 b=r4HhedmdiXk2KMCl+PfQNhoLKmRchKdOo2vMXKnyaGLrdURNLXCl+zEgs/AGIijU3jbaxOg69frhqLicZfA6GHk5Dp0sA+8cB8ZW1N2ucofm91BApScVz3RwYJ813WA7YZSzjgbaLIA0h1RRFh9OuRg7hIc1YsyC89PYmY5j++Y=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6676.eurprd04.prod.outlook.com (20.179.255.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 23 May 2019 03:22:05 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1900.020; Thu, 23 May 2019
 03:22:05 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V5 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V5 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVEGbg2QLbsVO1oE+jxvonbRb8fqZ4AO3w
Date:   Thu, 23 May 2019 03:22:05 +0000
Message-ID: <AM0PR04MB42116AFDCE2229C24E9D57D780010@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1558505898-722-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1558505898-722-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5995e7a-242e-43b1-b7a1-08d6df2dd49e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6676;
x-ms-traffictypediagnostic: AM0PR04MB6676:
x-microsoft-antispam-prvs: <AM0PR04MB6676DDA904233993A1ACDDBC80010@AM0PR04MB6676.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:318;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(186003)(44832011)(305945005)(8936002)(5660300002)(81156014)(7736002)(8676002)(25786009)(71200400001)(2201001)(71190400001)(74316002)(55016002)(81166006)(229853002)(316002)(26005)(11346002)(33656002)(446003)(256004)(66946007)(73956011)(4326008)(3846002)(76116006)(6116002)(52536014)(2501003)(476003)(66066001)(2906002)(486006)(66556008)(64756008)(66446008)(66476007)(14454004)(6246003)(9686003)(110136005)(6506007)(99286004)(478600001)(6436002)(68736007)(7696005)(53936002)(102836004)(86362001)(76176011)(7416002)(921003)(21314003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6676;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a78pPlRjg+iT5TzN3qaf3zFnUlE5G8VDiRrSUWug3jP7r1q8IKpXbTuLWcXIcz/2LdULmPqZBAeOGT9yWWCBRToh/W+qPotXPM1NuIY6SFnZuZNaomYAlN1RGBYAXK6lVFSARgFp4qk8uzFtp0xKlBOlnKrNlBs1S0LCfjBAdbNgJWrtQXT13Aq832cP/y++HwZC66d6JW8DpmnySuLJJ+WyH+v36iv6w/F0wH9tff00s8kD6lp2d1CvUnGQjmnlk9/sJYKwvmVnE543b/ShuxxLtZ05IMHdLEbr401hxKFFSxA+w3QTFhC4VSfc1W2kO9CVv71ztCHI6+t082n+Dp2EcdODCvaSmyvzsym8B6YWUlBgu0VV+Wg1o+KDTXHrGQxkVfzire1jqjUUq/DjD1QfceaE+e1BAw/skeMpVKc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5995e7a-242e-43b1-b7a1-08d6df2dd49e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 03:22:05.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAyMiwgMjAxOSAyOjI0
IFBNDQo+IA0KPiBBZGQgaS5NWCBTQ1UgU29DIGluZm8gZHJpdmVyIHRvIHN1cHBvcnQgaS5NWDhR
WFAgU29DLCBpbnRyb2R1Y2UgZHJpdmVyDQo+IGRlcGVuZGVuY3kgaW50byBLY29uZmlnIGFzIENP
TkZJR19JTVhfU0NVIG11c3QgYmUgc2VsZWN0ZWQgdG8gc3VwcG9ydA0KPiBpLk1YIFNDVSBTb0Mg
ZHJpdmVyLCBhbHNvIG5lZWQgdG8gdXNlIHBsYXRmb3JtIGRyaXZlciBtb2RlbCB0byBtYWtlIHN1
cmUNCj4gSU1YX1NDVSBkcml2ZXIgaXMgcHJvYmVkIGJlZm9yZSBpLk1YIFNDVSBTb0MgZHJpdmVy
Lg0KPiANCj4gV2l0aCB0aGlzIHBhdGNoLCBTb0MgaW5mbyBjYW4gYmUgcmVhZCBmcm9tIHN5c2Zz
Og0KPiANCj4gaS5teDhxeHAtbWVrIyBjYXQgL3N5cy9kZXZpY2VzL3NvYzAvZmFtaWx5IEZyZWVz
Y2FsZSBpLk1YDQo+IA0KPiBpLm14OHF4cC1tZWsjIGNhdCAvc3lzL2RldmljZXMvc29jMC9zb2Nf
aWQNCj4gMHgyDQo+IA0KPiBpLm14OHF4cC1tZWsjIGNhdCAvc3lzL2RldmljZXMvc29jMC9tYWNo
aW5lIEZyZWVzY2FsZSBpLk1YOFFYUCBNRUsNCj4gDQo+IGkubXg4cXhwLW1layMgY2F0IC9zeXMv
ZGV2aWNlcy9zb2MwL3JldmlzaW9uDQo+IDEuMQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNCkEgZmV3IG1pbm9yIGNvbW1lbnRzIGJlbG93
LA0KT3RoZXJ3aXNlOg0KRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KPiAt
LS0NCj4gQ2hhbmdlcyBzaW5jZSBWNDoNCj4gCS0gdXNpbmcgZXh0ZXJuIHN0cnVjdCBvZl9yb290
IGluc3RlYWQgb2Ygc2VhcmNoaW5nIGl0IGFnYWluIGZyb20gRFQ7DQo+IAktIGFkZCBvZl9ub2Rl
X3B1dCgpIGFmdGVyICJmc2wsaW14LXNjdSIgaXMgZm91bmQuDQo+IC0tLQ0KPiAgZHJpdmVycy9z
b2MvaW14L0tjb25maWcgICAgICAgfCAgIDkgKysrDQo+ICBkcml2ZXJzL3NvYy9pbXgvTWFrZWZp
bGUgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL3NvYy9pbXgvc29jLWlteC1zY3UuYyB8IDE1NQ0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMTY1IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L3NvYy9pbXgvc29jLWlteC1zY3UuYw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lt
eC9LY29uZmlnIGIvZHJpdmVycy9zb2MvaW14L0tjb25maWcgaW5kZXgNCj4gZDgwZjg5OS4uY2Jj
MWE0MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvaW14L0tjb25maWcNCj4gKysrIGIvZHJp
dmVycy9zb2MvaW14L0tjb25maWcNCj4gQEAgLTcsNCArNywxMyBAQCBjb25maWcgSU1YX0dQQ1Yy
X1BNX0RPTUFJTlMNCj4gIAlzZWxlY3QgUE1fR0VORVJJQ19ET01BSU5TDQo+ICAJZGVmYXVsdCB5
IGlmIFNPQ19JTVg3RA0KPiANCj4gK2NvbmZpZyBJTVhfU0NVX1NPQw0KPiArCWJvb2wgImkuTVgg
U3lzdGVtIENvbnRyb2xsZXIgVW5pdCBTb0MgaW5mbyBzdXBwb3J0Ig0KPiArCWRlcGVuZHMgb24g
SU1YX1NDVQ0KPiArCXNlbGVjdCBTT0NfQlVTDQo+ICsJaGVscA0KPiArCSAgSWYgeW91IHNheSB5
ZXMgaGVyZSB5b3UgZ2V0IHN1cHBvcnQgZm9yIHRoZSBOWFAgaS5NWCBTeXN0ZW0NCj4gKwkgIENv
bnRyb2xsZXIgVW5pdCBTb0MgaW5mbyBtb2R1bGUsIGl0IHdpbGwgcHJvdmlkZSB0aGUgU29DIGlu
Zm8NCj4gKwkgIGxpa2UgU29DIGZhbWlseSwgSUQgYW5kIHJldmlzaW9uIGV0Yy4NCj4gKw0KPiAg
ZW5kbWVudQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvaW14L01ha2VmaWxlIGIvZHJpdmVy
cy9zb2MvaW14L01ha2VmaWxlIGluZGV4DQo+IGQ2YjUyOWUwLi5kZGYzNDNkIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3NvYy9pbXgvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9zb2MvaW14L01h
a2VmaWxlDQo+IEBAIC0xLDMgKzEsNCBAQA0KPiAgb2JqLSQoQ09ORklHX0hBVkVfSU1YX0dQQykg
Kz0gZ3BjLm8NCj4gIG9iai0kKENPTkZJR19JTVhfR1BDVjJfUE1fRE9NQUlOUykgKz0gZ3BjdjIu
bw0KPiAgb2JqLSQoQ09ORklHX0FSQ0hfTVhDKSArPSBzb2MtaW14OC5vDQo+ICtvYmotJChDT05G
SUdfSU1YX1NDVV9TT0MpICs9IHNvYy1pbXgtc2N1Lm8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c29jL2lteC9zb2MtaW14LXNjdS5jIGIvZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2N1LmMgbmV3
DQo+IGZpbGUgbW9kZSAxMDA2NDQgaW5kZXggMDAwMDAwMC4uMTdkZWI0ZQ0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL2RyaXZlcnMvc29jL2lteC9zb2MtaW14LXNjdS5jDQo+IEBAIC0wLDAgKzEs
MTU1IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyoNCj4g
KyAqIENvcHlyaWdodCAyMDE5IE5YUC4NCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvZmlybXdhcmUvaW14L3JzcmMuaD4gI2luY2x1ZGUNCj4gKzxsaW51eC9maXJtd2FyZS9p
bXgvc2NpLmg+ICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+ICNpbmNsdWRlDQo+ICs8bGludXgvc3lz
X3NvYy5oPiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+ICNpbmNsdWRlDQo+ICs8
bGludXgvb2YuaD4NCj4gKw0KPiArI2RlZmluZSBJTVhfU0NVX1NPQ19EUklWRVJfTkFNRQkJImlt
eC1zY3Utc29jIg0KPiArDQo+ICtzdGF0aWMgc3RydWN0IGlteF9zY19pcGMgKnNvY19pcGNfaGFu
ZGxlOw0KPiArDQo+ICtzdHJ1Y3QgaW14X3NjX21zZ19taXNjX2dldF9zb2NfaWQgew0KPiArCXN0
cnVjdCBpbXhfc2NfcnBjX21zZyBoZHI7DQo+ICsJdW5pb24gew0KPiArCQlzdHJ1Y3Qgew0KPiAr
CQkJdTMyIGNvbnRyb2w7DQo+ICsJCQl1MTYgcmVzb3VyY2U7DQo+ICsJCX0gc2VuZDsNCg0KUGxl
YXNlIGZvbGxvdyB0aGUgZXhpc3QgbmFtaW5nIGNvbnZlcnNpb24gdG8gYXZvaWQgYSBkaXZlcmdl
IGlmIG5vIHNwZWNpZmljIHJlYXNvbnMuDQpzL3NlbmQvcmVxDQoNCkJUVywgc3ViIHN0cnVjdHVy
ZXMgYWxzbyBuZWVkcyBwYWNrZWQgYW5kIGJldHRlciBhZGQgYW4gZXhwbGljaXQgX19wYWNrZWQN
CkFzIEknbSBub3Qgc3VyZSB3aGV0aGVyIEdDQyB3aWxsIGFsd2F5cyBnZW5lcmF0ZSBubyBwYWRk
aW5nIGZvciBBUk02NCBwbGF0Zm9ybXMNCkZvciBhYm92ZSBzdHJ1Y3R1cmVzLg0KDQo+ICsJCXN0
cnVjdCB7DQo+ICsJCQl1MzIgaWQ7DQo+ICsJCQl1MTYgcmVzZXJ2ZWQ7DQoNCldoYXQncyByZXNl
cnZlZCBtZW1iZXIgZm9yPw0KDQo+ICsJCX0gcmVzcDsNCj4gKwl9IGRhdGE7DQo+ICt9IF9fcGFj
a2VkOw0KPiArDQo+ICtzdGF0aWMgdTMyIGlteF9zY3Vfc29jX2lkKHZvaWQpDQo+ICt7DQo+ICsJ
c3RydWN0IGlteF9zY19tc2dfbWlzY19nZXRfc29jX2lkIG1zZzsNCj4gKwlzdHJ1Y3QgaW14X3Nj
X3JwY19tc2cgKmhkciA9ICZtc2cuaGRyOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwloZHItPnZl
ciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCj4gKwloZHItPnN2YyA9IElNWF9TQ19SUENfU1ZDX01J
U0M7DQo+ICsJaGRyLT5mdW5jID0gSU1YX1NDX01JU0NfRlVOQ19HRVRfQ09OVFJPTDsNCj4gKwlo
ZHItPnNpemUgPSAzOw0KPiArDQo+ICsJbXNnLmRhdGEuc2VuZC5jb250cm9sID0gSU1YX1NDX0Nf
SUQ7DQo+ICsJbXNnLmRhdGEuc2VuZC5yZXNvdXJjZSA9IElNWF9TQ19SX1NZU1RFTTsNCj4gKw0K
PiArCXJldCA9IGlteF9zY3VfY2FsbF9ycGMoc29jX2lwY19oYW5kbGUsICZtc2csIHRydWUpOw0K
PiArCWlmIChyZXQpIHsNCj4gKwkJcHJfZXJyKCIlczogZ2V0IHNvYyBpbmZvIGZhaWxlZCwgcmV0
ICVkXG4iLCBfX2Z1bmNfXywgcmV0KTsNCj4gKwkJLyogcmV0dXJuIDAgbWVhbnMgZ2V0dGluZyBy
ZXZpc2lvbiBmYWlsZWQgKi8NCj4gKwkJcmV0dXJuIDA7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJu
IG1zZy5kYXRhLnJlc3AuaWQ7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgaW14X3NjdV9zb2Nf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiArCXN0cnVjdCBzb2NfZGV2
aWNlX2F0dHJpYnV0ZSAqc29jX2Rldl9hdHRyOw0KPiArCXN0cnVjdCBzb2NfZGV2aWNlICpzb2Nf
ZGV2Ow0KPiArCXUzMiBpZCwgdmFsOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwkvKiB3YWl0IGku
TVggU0NVIGRyaXZlciByZWFkeSAqLw0KDQpOaXRwaWNrOiByZW1vdmUgdGhpcyB1bm5lY2Vzc2Fy
eSBsaW5lDQoNCj4gKwlyZXQgPSBpbXhfc2N1X2dldF9oYW5kbGUoJnNvY19pcGNfaGFuZGxlKTsN
Cj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJc29jX2Rldl9hdHRyID0g
ZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqc29jX2Rldl9hdHRyKSwNCj4gKwkJCQkg
ICAgR0ZQX0tFUk5FTCk7DQo+ICsJaWYgKCFzb2NfZGV2X2F0dHIpDQo+ICsJCXJldHVybiAtRU5P
TUVNOw0KPiArDQo+ICsJc29jX2Rldl9hdHRyLT5mYW1pbHkgPSAiRnJlZXNjYWxlIGkuTVgiOw0K
PiArDQo+ICsJcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF9zdHJpbmcob2Zfcm9vdCwNCj4gKwkJCQkg
ICAgICAibW9kZWwiLA0KPiArCQkJCSAgICAgICZzb2NfZGV2X2F0dHItPm1hY2hpbmUpOw0KPiAr
CWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwlpZCA9IGlteF9zY3Vfc29jX2lk
KCk7DQo+ICsNCj4gKwkvKiBmb3JtYXQgc29jX2lkIHZhbHVlIHBhc3NlZCBmcm9tIFNDVSBmaXJt
d2FyZSAqLw0KPiArCXZhbCA9IGlkICYgMHgxZjsNCj4gKwlzb2NfZGV2X2F0dHItPnNvY19pZCA9
IHZhbCA/IGthc3ByaW50ZihHRlBfS0VSTkVMLCAiMHgleCIsIHZhbCkNCj4gKwkJCSAgICAgICA6
ICJ1bmtub3duIjsNCj4gKwlpZiAoIXNvY19kZXZfYXR0ci0+c29jX2lkKQ0KPiArCQlyZXR1cm4g
LUVOT01FTTsNCj4gKw0KPiArCS8qIGZvcm1hdCByZXZpc2lvbiB2YWx1ZSBwYXNzZWQgZnJvbSBT
Q1UgZmlybXdhcmUgKi8NCj4gKwl2YWwgPSAoaWQgPj4gNSkgJiAweGY7DQo+ICsJdmFsID0gKCgo
dmFsID4+IDIpICsgMSkgPDwgNCkgfCAodmFsICYgMHgzKTsNCj4gKwlzb2NfZGV2X2F0dHItPnJl
dmlzaW9uID0gdmFsID8ga2FzcHJpbnRmKEdGUF9LRVJORUwsDQo+ICsJCQkJCQkgIiVkLiVkIiwN
Cj4gKwkJCQkJCSAodmFsID4+IDQpICYgMHhmLA0KPiArCQkJCQkJIHZhbCAmIDB4ZikgOiAidW5r
bm93biI7DQo+ICsJaWYgKCFzb2NfZGV2X2F0dHItPnJldmlzaW9uKSB7DQo+ICsJCXJldCA9IC1F
Tk9NRU07DQo+ICsJCWdvdG8gZnJlZV9zb2NfaWQ7DQo+ICsJfQ0KPiArDQo+ICsJc29jX2RldiA9
IHNvY19kZXZpY2VfcmVnaXN0ZXIoc29jX2Rldl9hdHRyKTsNCj4gKwlpZiAoSVNfRVJSKHNvY19k
ZXYpKSB7DQo+ICsJCXJldCA9IFBUUl9FUlIoc29jX2Rldik7DQo+ICsJCWdvdG8gZnJlZV9yZXZp
c2lvbjsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gKw0KPiArZnJlZV9yZXZpc2lvbjoN
Cj4gKwlrZnJlZShzb2NfZGV2X2F0dHItPnJldmlzaW9uKTsNCj4gK2ZyZWVfc29jX2lkOg0KPiAr
CWtmcmVlKHNvY19kZXZfYXR0ci0+c29jX2lkKTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBpbXhfc2N1X3NvY19kcml2ZXIgPSB7
DQo+ICsJLmRyaXZlciA9IHsNCj4gKwkJLm5hbWUgPSBJTVhfU0NVX1NPQ19EUklWRVJfTkFNRSwN
Cj4gKwl9LA0KPiArCS5wcm9iZSA9IGlteF9zY3Vfc29jX3Byb2JlLA0KPiArfTsNCj4gKw0KPiAr
c3RhdGljIGludCBfX2luaXQgaW14X3NjdV9zb2NfaW5pdCh2b2lkKSB7DQo+ICsJc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqaW14X3NjdV9zb2NfcGRldjsNCj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5wOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2Rl
KE5VTEwsIE5VTEwsICJmc2wsaW14LXNjdSIpOw0KPiArCWlmICghbnApDQo+ICsJCXJldHVybiAt
RU5PREVWOw0KPiArDQo+ICsJb2Zfbm9kZV9wdXQobnApOw0KPiArDQo+ICsJcmV0ID0gcGxhdGZv
cm1fZHJpdmVyX3JlZ2lzdGVyKCZpbXhfc2N1X3NvY19kcml2ZXIpOw0KPiArCWlmIChyZXQpDQo+
ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwlpbXhfc2N1X3NvY19wZGV2ID0NCj4gKwkJcGxhdGZv
cm1fZGV2aWNlX3JlZ2lzdGVyX3NpbXBsZShJTVhfU0NVX1NPQ19EUklWRVJfTkFNRSwNCj4gKwkJ
CQkJCS0xLA0KPiArCQkJCQkJTlVMTCwNCj4gKwkJCQkJCTApOw0KDQpbLi4uXQ0KDQo+ICsJaWYg
KElTX0VSUihpbXhfc2N1X3NvY19wZGV2KSkgew0KPiArCQlyZXQgPSBQVFJfRVJSKGlteF9zY3Vf
c29jX3BkZXYpOw0KPiArCQlnb3RvIHVucmVnX3BsYXRmb3JtX2RyaXZlcjsNCj4gKwl9DQo+ICsN
Cj4gKwlyZXR1cm4gMDsNCj4gKw0KPiArdW5yZWdfcGxhdGZvcm1fZHJpdmVyOg0KPiArCXBsYXRm
b3JtX2RyaXZlcl91bnJlZ2lzdGVyKCZpbXhfc2N1X3NvY19kcml2ZXIpOw0KPiArCXJldHVybiBy
ZXQ7DQo+ICt9DQoNClRoaXMgY291bGQgYmUgc2ltcGxpZWQgd2l0aCAzIGxpbmVzOg0KSWYgKElT
X0VSUihwZGV2KSkNCglQbGF0Zm9ybV9kcml2ZXJfdW5yZWdzaXRlcih4eHgpDQoNClJldHVybiBQ
VFJfRVJSX09SX1pFUk8ocGRldikNCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5nDQoNCj4gK2Rldmlj
ZV9pbml0Y2FsbChpbXhfc2N1X3NvY19pbml0KTsNCj4gLS0NCj4gMi43LjQNCg0K
