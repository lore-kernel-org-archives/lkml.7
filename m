Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55F3C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3202082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R6q8HfJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfEPOJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:09:48 -0400
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:24949
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbfEPOJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgmtSz15BdrN864+ySfKrVOrIcKY6X33CqBjdBSUPV8=;
 b=R6q8HfJ7aNfa+gqeoJKJ5XB4g8g4+ko5w/BTUwON1/mfLYxF2RgEZbGowLefW4TRmbIlVgdnh3hh9oRFNOPn2u7tzfi9XzY3niwFrVwIsgrxGcNOiidFgMVk2WcL1pvHlC70gnl5+e9LWjcuY9XvydEAY09G91Xi6055C6wcQlc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6210.eurprd04.prod.outlook.com (20.179.33.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Thu, 16 May 2019 14:09:38 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 14:09:38 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/2] soc: imx: Add SCU SoC info driver support
Thread-Topic: [PATCH V3 1/2] soc: imx: Add SCU SoC info driver support
Thread-Index: AQHVC5bqk1P5MqRzRU2gqcSUyb18B6Ztk+uggAAPlSCAACR5gA==
Date:   Thu, 16 May 2019 14:09:38 +0000
Message-ID: <AM0PR04MB4211A9BAD4094499C0BB2B40800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1557976777-8304-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB42112F268CC39A2829836532800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB391665F27EC3726BCCED5E03F50A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391665F27EC3726BCCED5E03F50A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44582b15-47ab-4253-9ee5-08d6da082214
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6210;
x-ms-traffictypediagnostic: AM0PR04MB6210:
x-microsoft-antispam-prvs: <AM0PR04MB6210E0E4C03076F6BBC52454800A0@AM0PR04MB6210.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(54094003)(199004)(189003)(6246003)(71190400001)(71200400001)(53936002)(3846002)(316002)(6116002)(52536014)(99286004)(229853002)(5660300002)(55016002)(9686003)(4326008)(256004)(25786009)(6436002)(33656002)(486006)(102836004)(66066001)(66446008)(305945005)(66556008)(64756008)(476003)(73956011)(76116006)(14454004)(44832011)(2501003)(7696005)(11346002)(446003)(2906002)(6506007)(478600001)(7736002)(86362001)(186003)(81166006)(81156014)(110136005)(8676002)(7416002)(74316002)(76176011)(2201001)(66946007)(68736007)(8936002)(66476007)(26005)(21314003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6210;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FuAbtmHehbLoJ6Spwz1aCVC0P2sg7n3gjO1Yd7nMGVfZheE9tmz/pSjCQ/e2UD5qqhqHGkVHLsk93vBwaefYmZcqCBZf9mfJla2QfxJERLiPXrM5jVJ0zuUSI8vuvDTjmpUX62HKeJ203cd082nNLO1oUKjW3xBqbPllJjCYCd5mIRnBNK0Xg3zQnEYslvrOf91EBGcFgt19+eUuRdu5WFmNmcRx7PGATqbfF8jNs9oUWyLEaert94rgm2uJ09YcE0KfxqhP5cn7Zfj8Lk0tShFwBuJECqDqfAPDVKo+V2QaVjSBP7viLiyXEYwxB6wuZF+4W5NJlMalKUqtZUQ3ItomlVP8Xwwi/g/hOrEGUuDwa8cpaPLxhguAg2eiSaY2H63Lnt9KbJPOxHf4BG8ZtZKDm8v5wJiehLLQDekBh5g=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44582b15-47ab-4253-9ee5-08d6da082214
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 14:09:38.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDE2LCAyMDE5IDg6MDEg
UE0NCj4gPiA+DQo+ID4gPiBBZGQgaS5NWCBTQ1UgU29DIGluZm8gZHJpdmVyIHRvIHN1cHBvcnQg
aS5NWDhRWFAgU29DLCBpbnRyb2R1Y2UNCj4gPiA+IGRyaXZlciBkZXBlbmRlbmN5IGludG8gS2Nv
bmZpZyBhcyBDT05GSUdfSU1YX1NDVSBtdXN0IGJlIHNlbGVjdGVkIHRvDQo+ID4gPiBzdXBwb3J0
IGkuTVggU0NVIFNvQyBkcml2ZXIsIGFsc28gbmVlZCB0byB1c2UgcGxhdGZvcm0gZHJpdmVyIG1v
ZGVsDQo+ID4gPiB0byBtYWtlIHN1cmUgSU1YX1NDVSBkcml2ZXIgaXMgcHJvYmVkIGJlZm9yZSBp
Lk1YIFNDVSBTb0MgZHJpdmVyLg0KPiA+ID4NCj4gPiA+IFdpdGggdGhpcyBwYXRjaCwgU29DIGlu
Zm8gY2FuIGJlIHJlYWQgZnJvbSBzeXNmczoNCj4gPiA+DQo+ID4gPiBpLm14OHF4cC1tZWsjIGNh
dCAvc3lzL2RldmljZXMvc29jMC9mYW1pbHkgRnJlZXNjYWxlIGkuTVgNCj4gPiA+DQo+ID4gPiBp
Lm14OHF4cC1tZWsjIGNhdCAvc3lzL2RldmljZXMvc29jMC9zb2NfaWQgaS5NWDhRWFANCj4gPiA+
DQo+ID4gPiBpLm14OHF4cC1tZWsjIGNhdCAvc3lzL2RldmljZXMvc29jMC9tYWNoaW5lIEZyZWVz
Y2FsZSBpLk1YOFFYUCBNRUsNCj4gPiA+DQo+ID4gPiBpLm14OHF4cC1tZWsjIGNhdCAvc3lzL2Rl
dmljZXMvc29jMC9yZXZpc2lvbg0KPiA+ID4gMS4xDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IENo
YW5nZXMgc2luY2UgVjI6DQo+ID4gPiAJLSB1c2luZyBkZXZpY2VfaW5pdGNhbGwgaW5zdGVhZCBv
ZiBtb2R1bGVfaW5pdDsNCj4gPiA+IAktIGNoZWNrIG9mX21hdGNoX25vZGUgaW4gaW5pdCBmdW5j
dGlvbiBhbmQgT05MWSByZWdpc3RlciBwbGF0Zm9ybQ0KPiA+ID4gZHJpdmVyIHdoZW4gbWF0Y2hl
ZCwgdGhpcw0KPiA+ID4gCSAgaXMgdG8gYXZvaWQgdW5uZWNlc3NhcnkgcHJvYmUgZm9yIG5vbiBT
Q1UgYmFzZWQgaS5NWDggU29Dcy4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvc29jL2lteC9L
Y29uZmlnICAgICAgIHwgICA5ICsrKw0KPiA+ID4gIGRyaXZlcnMvc29jL2lteC9NYWtlZmlsZSAg
ICAgIHwgICAxICsNCj4gPiA+ICBkcml2ZXJzL3NvYy9pbXgvc29jLWlteC1zY3UuYyB8IDE3Mw0K
PiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAg
MyBmaWxlcyBjaGFuZ2VkLCAxODMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL3NvYy9pbXgvc29jLWlteC1zY3UuYw0KPiA+ID4NCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3NvYy9pbXgvS2NvbmZpZyBiL2RyaXZlcnMvc29jL2lteC9LY29uZmlnIGlu
ZGV4DQo+ID4gPiBkODBmODk5Li5jYmMxYTQxIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9z
b2MvaW14L0tjb25maWcNCj4gPiA+ICsrKyBiL2RyaXZlcnMvc29jL2lteC9LY29uZmlnDQo+ID4g
PiBAQCAtNyw0ICs3LDEzIEBAIGNvbmZpZyBJTVhfR1BDVjJfUE1fRE9NQUlOUw0KPiA+ID4gIAlz
ZWxlY3QgUE1fR0VORVJJQ19ET01BSU5TDQo+ID4gPiAgCWRlZmF1bHQgeSBpZiBTT0NfSU1YN0QN
Cj4gPiA+DQo+ID4gPiArY29uZmlnIElNWF9TQ1VfU09DDQo+ID4gPiArCWJvb2wgImkuTVggU3lz
dGVtIENvbnRyb2xsZXIgVW5pdCBTb0MgaW5mbyBzdXBwb3J0Ig0KPiA+ID4gKwlkZXBlbmRzIG9u
IElNWF9TQ1UNCj4gPiA+ICsJc2VsZWN0IFNPQ19CVVMNCj4gPiA+ICsJaGVscA0KPiA+ID4gKwkg
IElmIHlvdSBzYXkgeWVzIGhlcmUgeW91IGdldCBzdXBwb3J0IGZvciB0aGUgTlhQIGkuTVggU3lz
dGVtDQo+ID4gPiArCSAgQ29udHJvbGxlciBVbml0IFNvQyBpbmZvIG1vZHVsZSwgaXQgd2lsbCBw
cm92aWRlIHRoZSBTb0MgaW5mbw0KPiA+ID4gKwkgIGxpa2UgU29DIGZhbWlseSwgSUQgYW5kIHJl
dmlzaW9uIGV0Yy4NCj4gPiA+ICsNCj4gPiA+ICBlbmRtZW51DQo+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zb2MvaW14L01ha2VmaWxlIGIvZHJpdmVycy9zb2MvaW14L01ha2VmaWxlDQo+ID4g
PiBpbmRleCBkNmI1MjllMC4uZGRmMzQzZCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvc29j
L2lteC9NYWtlZmlsZQ0KPiA+ID4gKysrIGIvZHJpdmVycy9zb2MvaW14L01ha2VmaWxlDQo+ID4g
PiBAQCAtMSwzICsxLDQgQEANCj4gPiA+ICBvYmotJChDT05GSUdfSEFWRV9JTVhfR1BDKSArPSBn
cGMubw0KPiA+ID4gIG9iai0kKENPTkZJR19JTVhfR1BDVjJfUE1fRE9NQUlOUykgKz0gZ3BjdjIu
bw0KPiA+ID4gIG9iai0kKENPTkZJR19BUkNIX01YQykgKz0gc29jLWlteDgubw0KPiA+ID4gK29i
ai0kKENPTkZJR19JTVhfU0NVX1NPQykgKz0gc29jLWlteC1zY3Uubw0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvc29jL2lteC9zb2MtaW14LXNjdS5jDQo+ID4gPiBiL2RyaXZlcnMvc29jL2lt
eC9zb2MtaW14LXNjdS5jIG5ldyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4DQo+ID4gPiAwMDAwMDAw
Li4yNDNjNDE4DQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysgYi9kcml2ZXJzL3NvYy9p
bXgvc29jLWlteC1zY3UuYw0KPiA+ID4gQEAgLTAsMCArMSwxNzMgQEANCj4gPiA+ICsvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ID4gKy8qDQo+ID4gPiArICogQ29weXJp
Z2h0IDIwMTkgTlhQLg0KPiA+ID4gKyAqLw0KPiA+ID4gKw0KPiA+ID4gKyNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9maXJtd2FyZS9pbXgvcnNyYy5oPiAjaW5jbHVkZQ0KPiA+ID4gKzxsaW51eC9maXJt
d2FyZS9pbXgvc2NpLmg+ICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4gI2luY2x1ZGUNCj4gPiA+
ICs8bGludXgvc2xhYi5oPiAjaW5jbHVkZSA8bGludXgvc3lzX3NvYy5oPiAjaW5jbHVkZQ0KPiA+
ID4gKzxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4gI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4g
PiArDQo+ID4gPiArI2RlZmluZSBJTVhfU0NVX1NPQ19EUklWRVJfTkFNRQkJImlteC1zY3Utc29j
Ig0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyBzdHJ1Y3QgaW14X3NjX2lwYyAqc29jX2lwY19oYW5k
bGU7IHN0YXRpYyBzdHJ1Y3QNCj4gPiA+ICtwbGF0Zm9ybV9kZXZpY2UgKmlteF9zY3Vfc29jX3Bk
ZXY7DQo+ID4gPiArDQo+ID4gPiArc3RydWN0IGlteF9zY19tc2dfbWlzY19nZXRfc29jX2lkIHsN
Cj4gPiA+ICsJc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCj4gPiA+ICsJdW5pb24gew0KPiA+
ID4gKwkJc3RydWN0IHsNCj4gPiA+ICsJCQl1MzIgY29udHJvbDsNCj4gPiA+ICsJCQl1MTYgcmVz
b3VyY2U7DQo+ID4gPiArCQl9IHNlbmQ7DQo+ID4gPiArCQlzdHJ1Y3Qgew0KPiA+ID4gKwkJCXUz
MiBpZDsNCj4gPiA+ICsJCQl1MTYgcmVzZXJ2ZWQ7DQo+ID4gPiArCQl9IHJlc3A7DQo+ID4gPiAr
CX0gZGF0YTsNCj4gPiA+ICt9IF9fcGFja2VkOw0KPiA+ID4gKw0KPiA+ID4gK3N0cnVjdCBpbXhf
c2N1X3NvY19kYXRhIHsNCj4gPiA+ICsJY2hhciAqbmFtZTsNCj4gPiA+ICsJdTMyICgqc29jX3Jl
dmlzaW9uKSh2b2lkKTsNCj4gPiA+ICt9Ow0KPiA+ID4gKw0KPiA+ID4gK3N0YXRpYyB1MzIgaW14
OHF4cF9zb2NfcmV2aXNpb24odm9pZCkgew0KPiA+ID4gKwlzdHJ1Y3QgaW14X3NjX21zZ19taXNj
X2dldF9zb2NfaWQgbXNnOw0KPiA+ID4gKwlzdHJ1Y3QgaW14X3NjX3JwY19tc2cgKmhkciA9ICZt
c2cuaGRyOw0KPiA+ID4gKwl1MzIgcmV2Ow0KPiA+ID4gKwlpbnQgcmV0Ow0KPiA+ID4gKw0KPiA+
ID4gKwloZHItPnZlciA9IElNWF9TQ19SUENfVkVSU0lPTjsNCj4gPiA+ICsJaGRyLT5zdmMgPSBJ
TVhfU0NfUlBDX1NWQ19NSVNDOw0KPiA+ID4gKwloZHItPmZ1bmMgPSBJTVhfU0NfTUlTQ19GVU5D
X0dFVF9DT05UUk9MOw0KPiA+ID4gKwloZHItPnNpemUgPSAzOw0KPiA+ID4gKw0KPiA+ID4gKwlt
c2cuZGF0YS5zZW5kLmNvbnRyb2wgPSBJTVhfU0NfQ19JRDsNCj4gPiA+ICsJbXNnLmRhdGEuc2Vu
ZC5yZXNvdXJjZSA9IElNWF9TQ19SX1NZU1RFTTsNCj4gPiA+ICsNCj4gPiA+ICsJcmV0ID0gaW14
X3NjdV9jYWxsX3JwYyhzb2NfaXBjX2hhbmRsZSwgJm1zZywgdHJ1ZSk7DQo+ID4gPiArCWlmIChy
ZXQpIHsNCj4gPiA+ICsJCWRldl9lcnIoJmlteF9zY3Vfc29jX3BkZXYtPmRldiwNCj4gPiA+ICsJ
CQkiZ2V0IHNvYyBpbmZvIGZhaWxlZCwgcmV0ICVkXG4iLCByZXQpOw0KPiA+ID4gKwkJLyogcmV0
dXJuIDAgbWVhbnMgZ2V0dGluZyByZXZpc2lvbiBmYWlsZWQgKi8NCj4gPiA+ICsJCXJldHVybiAw
Ow0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCS8qIGZvcm1hdCByZXZpc2lvbiB2YWx1ZSBw
YXNzZWQgZnJvbSBTQ1UgZmlybXdhcmUgKi8NCj4gPiA+ICsJcmV2ID0gKG1zZy5kYXRhLnJlc3Au
aWQgPj4gNSkgJiAweGY7DQo+ID4gPiArCXJldiA9ICgoKHJldiA+PiAyKSArIDEpIDw8IDQpIHwg
KHJldiAmIDB4Myk7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiByZXY7DQo+ID4gPiArfQ0KPiA+
ID4gKw0KPiA+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X3NjdV9zb2NfZGF0YSBpbXg4cXhw
X3NvY19kYXRhID0gew0KPiA+ID4gKwkubmFtZSA9ICJpLk1YOFFYUCIsDQo+ID4gPiArCS5zb2Nf
cmV2aXNpb24gPSBpbXg4cXhwX3NvY19yZXZpc2lvbiwNCj4gPg0KPiA+IFRoaXMgaXMgc3RpbGwg
Zm9sbG93IGEgZ2VuZXJpYyBzb2MgZHJpdmVyIGRlc2lnbi4NCj4gPiBJIHdvbmRlciBpZiB0aGlz
IGlzIHN0aWxsIG5lZWRlZCBhZnRlciBzZXBhcmF0ZSBzY3Ugc29jIGRyaXZlciBmcm9tIGlteDht
Lg0KPiA+IElmIG5vdCBuZWVkZWQsIHRoaXMgZHJpdmVyIHByb2JhYmx5IGNvdWxkIGJlIHNpbXBs
aWVkIGEgbG90Lg0KPiANCj4gVXNpbmcgZ2VuZXJpYyBzb2MgZHJpdmVyIGlzIGp1c3QgdG8gcHJv
dmlkZSBkaWZmZXJlbnQgc29jIGRhdGEgZm9yIGRpZmZlcmVudCBTb0NzLA0KPiBOT1Qgc3VyZSBp
ZiB3ZSBjYW4gY292ZXIgYWxsIFNDVSBTb0NzIHVzaW5nIHNhbWUgc2V0dGluZ3MuIERpZmZlcmVu
dCBTb0NzIG1heQ0KPiBuZWVkIHNvbWUgZGlmZmVyZW50IG9wZXJhdGlvbnMgb3Igd29ya2Fyb3Vu
ZHMsIGxpa2UgaS5NWDhRTSBuZWVkcyBzb21lDQo+IHNwZWNpYWwgd29ya2Fyb3VuZCBzZXR0aW5n
cy4uLi4NCj4gDQoNCk14OHFtIHNlZW1zIGNhbiBmdWxseSByZS11c2UgaW14OHF4cF9zb2NfcmV2
aXNpb24oKS4NCkFuZCB0aGUgd29ya2Fyb3VuZCBpbiBsb2NhbCB0cmVlIHNlZW1zIG5vdCBuZWVk
IHRvIGJlIHB1dCB0aGVyZS4NClRoZW4gdGhlIGxlZnQgb25lIGlzIG9ubHkgc29jIG5hbWU/DQoN
Cj4gPg0KPiA+ID4gK307DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgaW14X3NjdV9zb2NfbWF0Y2hbXSA9IHsNCj4gPiA+ICsJeyAuY29tcGF0aWJsZSA9
ICJmc2wsaW14OHF4cCIsIC5kYXRhID0gJmlteDhxeHBfc29jX2RhdGEsIH0sDQo+ID4gPiArCXsg
fQ0KPiA+ID4gK307DQo+ID4gPiArDQo+ID4gPiArI2RlZmluZSBpbXhfc2N1X3JldmlzaW9uKHNv
Y19yZXYpIFwNCj4gPiA+ICsJc29jX3JldiA/IFwNCj4gPiA+ICsJa2FzcHJpbnRmKEdGUF9LRVJO
RUwsICIlZC4lZCIsIChzb2NfcmV2ID4+IDQpICYgMHhmLCAgc29jX3JldiAmDQo+ID4gMHhmKSA6
IFwNCj4gPiA+ICsJInVua25vd24iDQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGludCBpbXhfc2N1
X3NvY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ID4gPiArCXN0cnVj
dCBzb2NfZGV2aWNlX2F0dHJpYnV0ZSAqc29jX2Rldl9hdHRyOw0KPiA+ID4gKwljb25zdCBzdHJ1
Y3QgaW14X3NjdV9zb2NfZGF0YSAqZGF0YTsNCj4gPiA+ICsJY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCAqaWQ7DQo+ID4gPiArCXN0cnVjdCBzb2NfZGV2aWNlICpzb2NfZGV2Ow0KPiA+ID4gKwl1
MzIgc29jX3JldiA9IDA7DQo+ID4gPiArCWludCByZXQ7DQo+ID4gPiArDQo+ID4gPiArCS8qIHdh
aXQgaS5NWCBTQ1UgZHJpdmVyIHJlYWR5ICovDQo+ID4gPiArCXJldCA9IGlteF9zY3VfZ2V0X2hh
bmRsZSgmc29jX2lwY19oYW5kbGUpOw0KPiA+ID4gKwlpZiAocmV0KQ0KPiA+ID4gKwkJcmV0dXJu
IHJldDsNCj4gPiA+ICsNCj4gPiA+ICsJc29jX2Rldl9hdHRyID0gZGV2bV9remFsbG9jKCZwZGV2
LT5kZXYsIHNpemVvZigqc29jX2Rldl9hdHRyKSwNCj4gPiA+ICsJCQkJICAgIEdGUF9LRVJORUwp
Ow0KPiA+ID4gKwlpZiAoIXNvY19kZXZfYXR0cikNCj4gPiA+ICsJCXJldHVybiAtRU5PTUVNOw0K
PiA+ID4gKw0KPiA+ID4gKwlzb2NfZGV2X2F0dHItPmZhbWlseSA9ICJGcmVlc2NhbGUgaS5NWCI7
DQo+ID4gPiArDQo+ID4gPiArCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfc3RyaW5nKHBkZXYtPmRl
di5vZl9ub2RlLA0KPiA+ID4gKwkJCQkgICAgICAibW9kZWwiLA0KPiA+ID4gKwkJCQkgICAgICAm
c29jX2Rldl9hdHRyLT5tYWNoaW5lKTsNCj4gPiA+ICsJaWYgKHJldCkNCj4gPiA+ICsJCXJldHVy
biByZXQ7DQo+ID4gPiArDQo+ID4gPiArCWlkID0gb2ZfbWF0Y2hfbm9kZShpbXhfc2N1X3NvY19t
YXRjaCwgcGRldi0+ZGV2Lm9mX25vZGUpOw0KPiA+ID4gKwlkYXRhID0gaWQtPmRhdGE7DQo+ID4g
PiArCWlmIChkYXRhKSB7DQo+ID4gPiArCQlzb2NfZGV2X2F0dHItPnNvY19pZCA9IGRhdGEtPm5h
bWU7DQo+ID4gPiArCQlpZiAoZGF0YS0+c29jX3JldmlzaW9uKQ0KPiA+ID4gKwkJCXNvY19yZXYg
PSBkYXRhLT5zb2NfcmV2aXNpb24oKTsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlzb2Nf
ZGV2X2F0dHItPnJldmlzaW9uID0gaW14X3NjdV9yZXZpc2lvbihzb2NfcmV2KTsNCj4gPiA+ICsJ
aWYgKCFzb2NfZGV2X2F0dHItPnJldmlzaW9uKQ0KPiA+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+
ID4gPiArDQo+ID4gPiArCXNvY19kZXYgPSBzb2NfZGV2aWNlX3JlZ2lzdGVyKHNvY19kZXZfYXR0
cik7DQo+ID4gPiArCWlmIChJU19FUlIoc29jX2RldikpIHsNCj4gPiA+ICsJCWtmcmVlKHNvY19k
ZXZfYXR0ci0+cmV2aXNpb24pOw0KPiA+ID4gKwkJcmV0dXJuIFBUUl9FUlIoc29jX2Rldik7DQo+
ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gPiArfQ0KPiA+ID4gKw0K
PiA+ID4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGlteF9zY3Vfc29jX2RyaXZlciA9
IHsNCj4gPiA+ICsJLmRyaXZlciA9IHsNCj4gPiA+ICsJCS5uYW1lID0gSU1YX1NDVV9TT0NfRFJJ
VkVSX05BTUUsDQo+ID4gPiArCX0sDQo+ID4gPiArCS5wcm9iZSA9IGlteF9zY3Vfc29jX3Byb2Jl
LA0KPiA+ID4gK307DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGludCBfX2luaXQgaW14X3NjdV9z
b2NfaW5pdCh2b2lkKSB7DQo+ID4gPiArCWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKmlkOw0K
PiA+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKnJvb3Q7DQo+ID4gPiArCWludCByZXQ7DQo+ID4g
PiArDQo+ID4gPiArCXJvb3QgPSBvZl9maW5kX25vZGVfYnlfcGF0aCgiLyIpOw0KPiA+ID4gKwlp
ZCA9IG9mX21hdGNoX25vZGUoaW14X3NjdV9zb2NfbWF0Y2gsIHJvb3QpOw0KPiA+DQo+ID4gVXNl
IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlIGluc3RlYWQuDQo+ID4gVGhlbiB5b3UgcmVtb3ZlIHR3
byB1bm5lY2Vzc2FyeSBsb2NhbCB2YXJpYWJsZS4NCj4gDQo+IE9LLg0KPiANCj4gPg0KPiA+IEJU
VywgcHJvYmFibHkgYSBiZXR0ZXIgd2F5IGlzIHRvIG1hdGNoICJmc2wsaW14LXNjdSI/DQo+IA0K
PiAiZnNsLGlteC1zY3UiIGFscmVhZHkgdXNlZCBieSBzY3UgZmlybXdhcmUgZHJpdmVyLCB0aGF0
IHdpbGwgY2F1c2UgY29uZnVzaW9uIEkNCj4gdGhpbmssIGp1c3QgdXNpbmcgc29jJ3MgY29tcGF0
aWJsZSBzaG91bGQgYmUgZWFzaWVyIHRvIHVuZGVyc3RhbmQuDQo+IA0KDQpJdCBkb2VzIG5vdCBt
YXR0ZXIgYmVjYXVzZSB3ZSBvbmx5IHVzZSBpdCB0byBjaGVjayB3aGV0aGVyIHdlIG5lZWQgcmVn
aXN0ZXINCnRoaXMgc29jIGRyaXZlci4gQW5kIHdoYXQgSSBzdWdnZXN0IGlzIGJlY2F1c2UgdGhp
cyBkcml2ZSBhY3R1YWxseSBkZXBlbmRzIG9uDQoiZnNsLGlteC1zY3UiLCBub3Qgc29jIGNvbXBh
dGlibGUgc3RyaW5nLg0KQW5vdGhlciBiZW5lZml0IGlzIHlvdSBkbyBub3QgbmVlZCBhbm90aGVy
IGNvbXBhdGlibGUgc3RyaW5nIHdoZW4geW91DQpBZGQgaW14OHFtIHN1cHBvcnQuDQoNCj4gPg0K
PiA+ID4gKwlpZiAoIWlkKSB7DQo+ID4gPiArCQlvZl9ub2RlX3B1dChyb290KTsNCj4gPiA+ICsJ
CXJldHVybiAtRU5PREVWOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCXJldCA9IHBsYXRm
b3JtX2RyaXZlcl9yZWdpc3RlcigmaW14X3NjdV9zb2NfZHJpdmVyKTsNCj4gPiA+ICsJaWYgKHJl
dCkNCj4gPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gPiArDQo+ID4gPiArCWlteF9zY3Vfc29jX3Bk
ZXYgPQ0KPiA+ID4gKw0KPiA+IAlwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXJfc2ltcGxlKElNWF9T
Q1VfU09DX0RSSVZFUl9OQU1FLA0KPiA+ID4gKwkJCQkJCS0xLA0KPiA+ID4gKwkJCQkJCU5VTEws
DQo+ID4gPiArCQkJCQkJMCk7DQo+ID4gPiArCWlmIChJU19FUlIoaW14X3NjdV9zb2NfcGRldikp
IHsNCj4gPiA+ICsJCXJldCA9IFBUUl9FUlIoaW14X3NjdV9zb2NfcGRldik7DQo+ID4gPiArCQln
b3RvIHVucmVnX3BsYXRmb3JtX2RyaXZlcjsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlp
bXhfc2N1X3NvY19wZGV2LT5kZXYub2Zfbm9kZSA9IHJvb3Q7DQo+ID4NCj4gPiBQbGVhc2UgZG91
YmxlIGNoZWNrIGlmIHdlIHJlYWxseSBuZWVkIGEgZ2xvYmFsIGlteF9zY3Vfc29jX3BkZXYuDQo+
IA0KPiBHbG9iYWwgcGxhdGZvcm1fZGV2aWNlIHBvaW50ZXIgY2FuIGJlIHVzZWQgaW4gb3RoZXIg
ZnVuY3Rpb24ncyBtZXNzYWdlIG91dHB1dA0KPiB1c2luZyBkZXZfeHh4IGluc3RlYWQgb2YgcHJf
eHh4LCBhbmQgaXQgY291bGQgYmUgbmVlZGVkIGxhdGVyIGZvciBzb21lIG90aGVyDQo+IGZ1bmN0
aW9ucywgaWYgbm8gYmlnIGNvbmNlcm4gb2Yga2VlcGluZyBvbmUgZ2xvYmFsIHZhcmlhYmxlLCBJ
IHByZWZlciB0byBrZWVwIGl0Lg0KPiANCg0KSSBtZWFuIElmIHdlIHJlbW92ZSBzb2NfcmV2aXNp
b24oKSBjYWxsYmFjaywgd2UgbWF5IG5vdCBuZWVkIGl0Lg0KQW5kIGlteF9zY3Vfc29jX21hdGNo
IGFycmF5IGNvdWxkIGFsc28gYmUgcmVtb3ZlZC4gVGhlbiB0aGUgZHJpdmVyIGNvdWxkDQpCZSBz
aW1wbGlmaWVkIGEgbG90Lg0KDQpZb3UgY2FuIGNoZWNrIGlmIHdlIGNhbiBkbyB0aGF0Lg0KDQpS
ZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0KPiBUaGFua3MsDQo+IEFuc29uDQo+IA0KPiA+DQo+ID4g
UmVnYXJkcw0KPiA+IERvbmcgQWlzaGVuZw0KPiA+DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiAw
Ow0KPiA+ID4gKw0KPiA+ID4gK3VucmVnX3BsYXRmb3JtX2RyaXZlcjoNCj4gPiA+ICsJcGxhdGZv
cm1fZHJpdmVyX3VucmVnaXN0ZXIoJmlteF9zY3Vfc29jX2RyaXZlcik7DQo+ID4gPiArCXJldHVy
biByZXQ7DQo+ID4gPiArfQ0KPiA+ID4gK2RldmljZV9pbml0Y2FsbChpbXhfc2N1X3NvY19pbml0
KTsNCj4gPiA+IC0tDQo+ID4gPiAyLjcuNA0KDQo=
