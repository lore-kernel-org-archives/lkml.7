Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BBEC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305F020645
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eEie/PY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfEPLNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:13:01 -0400
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:22403
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbfEPLNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3ID3lzOTglsQ6RPKDshAWcI1X94VHl+5Xfu51tG3TU=;
 b=eEie/PY1IGR5Rd0P1VxRPQj5vdzn458i45kJWwjlSqV16dHf7uZkK6K4B5PC+rGo8PbvIa01Th4k+io/B23vkDueOrFWyiga0myMxm2Fi8S/gFd66YUS7EOUc7jQU+CB2EfX+sB6zBPsNjw/AmzHcfrAY49ao/1Imq7WR6ztTlA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4274.eurprd04.prod.outlook.com (52.134.124.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Thu, 16 May 2019 11:12:54 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c415:3cab:a042:2e13%6]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 11:12:54 +0000
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
Thread-Index: AQHVC5bqk1P5MqRzRU2gqcSUyb18B6Ztk+ug
Date:   Thu, 16 May 2019 11:12:54 +0000
Message-ID: <AM0PR04MB42112F268CC39A2829836532800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1557976777-8304-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557976777-8304-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 005e116c-8d7a-471a-db8e-08d6d9ef717d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4274;
x-ms-traffictypediagnostic: AM0PR04MB4274:
x-microsoft-antispam-prvs: <AM0PR04MB42743E388619DBBE4AD2CE26800A0@AM0PR04MB4274.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39860400002)(346002)(136003)(189003)(199004)(54094003)(2501003)(8936002)(71200400001)(7416002)(52536014)(66066001)(6506007)(11346002)(6246003)(2201001)(476003)(102836004)(6436002)(110136005)(9686003)(81166006)(81156014)(4326008)(86362001)(74316002)(71190400001)(486006)(53936002)(2906002)(55016002)(68736007)(256004)(66946007)(64756008)(446003)(305945005)(14454004)(7696005)(99286004)(3846002)(25786009)(478600001)(76176011)(33656002)(66446008)(8676002)(66556008)(6116002)(7736002)(44832011)(26005)(5660300002)(316002)(73956011)(66476007)(76116006)(186003)(229853002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4274;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IpRwqpoGLtOOnQ0NyvcrqOD0xkztFs42BBZgp8XBBVmaofh8SZ8+gl1DHxmrjyyKMQ0b3avy5f4DSR2+MlElLgdzpKczQ/Ur45nUoxJ8hPL3xiXdmXGewT0Iw6ywpzlSpJ1XOYZNAja09JCgt4mKGYCQ1v3VACKe8sQmxGCpO8WY27jdftlm04e7NLAA+3sTeBJ2dno6StQAt/gJFlG65e7CIkWaVDUvEnckYs7ZOvc4Su4UFh+NCoyMV0diStbKZwtjalUmOgQqgHe2EnOSp6H5cX3wSJPqBB/2kkzX3o1q0VvnQxw9TVNs8r5UYtysKhBpy8XN3EYQqcL1+lsqZQ2GK5h/CKJ1ugzA6D6UQQV+ztaCgY1FXQCbqp/zt+DkXmz3PzNXuXTatyG0cu7zbuEO7CwGN4wx8+PLPrOqsyc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005e116c-8d7a-471a-db8e-08d6d9ef717d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:12:54.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDE2LCAyMDE5IDExOjI1
IEFNDQo+IA0KPiBBZGQgaS5NWCBTQ1UgU29DIGluZm8gZHJpdmVyIHRvIHN1cHBvcnQgaS5NWDhR
WFAgU29DLCBpbnRyb2R1Y2UgZHJpdmVyDQo+IGRlcGVuZGVuY3kgaW50byBLY29uZmlnIGFzIENP
TkZJR19JTVhfU0NVIG11c3QgYmUgc2VsZWN0ZWQgdG8gc3VwcG9ydA0KPiBpLk1YIFNDVSBTb0Mg
ZHJpdmVyLCBhbHNvIG5lZWQgdG8gdXNlIHBsYXRmb3JtIGRyaXZlciBtb2RlbCB0byBtYWtlIHN1
cmUNCj4gSU1YX1NDVSBkcml2ZXIgaXMgcHJvYmVkIGJlZm9yZSBpLk1YIFNDVSBTb0MgZHJpdmVy
Lg0KPiANCj4gV2l0aCB0aGlzIHBhdGNoLCBTb0MgaW5mbyBjYW4gYmUgcmVhZCBmcm9tIHN5c2Zz
Og0KPiANCj4gaS5teDhxeHAtbWVrIyBjYXQgL3N5cy9kZXZpY2VzL3NvYzAvZmFtaWx5IEZyZWVz
Y2FsZSBpLk1YDQo+IA0KPiBpLm14OHF4cC1tZWsjIGNhdCAvc3lzL2RldmljZXMvc29jMC9zb2Nf
aWQgaS5NWDhRWFANCj4gDQo+IGkubXg4cXhwLW1layMgY2F0IC9zeXMvZGV2aWNlcy9zb2MwL21h
Y2hpbmUgRnJlZXNjYWxlIGkuTVg4UVhQIE1FSw0KPiANCj4gaS5teDhxeHAtbWVrIyBjYXQgL3N5
cy9kZXZpY2VzL3NvYzAvcmV2aXNpb24NCj4gMS4xDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNv
biBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgc2luY2UgVjI6
DQo+IAktIHVzaW5nIGRldmljZV9pbml0Y2FsbCBpbnN0ZWFkIG9mIG1vZHVsZV9pbml0Ow0KPiAJ
LSBjaGVjayBvZl9tYXRjaF9ub2RlIGluIGluaXQgZnVuY3Rpb24gYW5kIE9OTFkgcmVnaXN0ZXIg
cGxhdGZvcm0gZHJpdmVyDQo+IHdoZW4gbWF0Y2hlZCwgdGhpcw0KPiAJICBpcyB0byBhdm9pZCB1
bm5lY2Vzc2FyeSBwcm9iZSBmb3Igbm9uIFNDVSBiYXNlZCBpLk1YOCBTb0NzLg0KPiAtLS0NCj4g
IGRyaXZlcnMvc29jL2lteC9LY29uZmlnICAgICAgIHwgICA5ICsrKw0KPiAgZHJpdmVycy9zb2Mv
aW14L01ha2VmaWxlICAgICAgfCAgIDEgKw0KPiAgZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2N1
LmMgfCAxNzMNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ICAzIGZpbGVzIGNoYW5nZWQsIDE4MyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9zb2MvaW14L3NvYy1pbXgtc2N1LmMNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3NvYy9pbXgvS2NvbmZpZyBiL2RyaXZlcnMvc29jL2lteC9LY29uZmlnIGluZGV4DQo+IGQ4
MGY4OTkuLmNiYzFhNDEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL2lteC9LY29uZmlnDQo+
ICsrKyBiL2RyaXZlcnMvc29jL2lteC9LY29uZmlnDQo+IEBAIC03LDQgKzcsMTMgQEAgY29uZmln
IElNWF9HUENWMl9QTV9ET01BSU5TDQo+ICAJc2VsZWN0IFBNX0dFTkVSSUNfRE9NQUlOUw0KPiAg
CWRlZmF1bHQgeSBpZiBTT0NfSU1YN0QNCj4gDQo+ICtjb25maWcgSU1YX1NDVV9TT0MNCj4gKwli
b29sICJpLk1YIFN5c3RlbSBDb250cm9sbGVyIFVuaXQgU29DIGluZm8gc3VwcG9ydCINCj4gKwlk
ZXBlbmRzIG9uIElNWF9TQ1UNCj4gKwlzZWxlY3QgU09DX0JVUw0KPiArCWhlbHANCj4gKwkgIElm
IHlvdSBzYXkgeWVzIGhlcmUgeW91IGdldCBzdXBwb3J0IGZvciB0aGUgTlhQIGkuTVggU3lzdGVt
DQo+ICsJICBDb250cm9sbGVyIFVuaXQgU29DIGluZm8gbW9kdWxlLCBpdCB3aWxsIHByb3ZpZGUg
dGhlIFNvQyBpbmZvDQo+ICsJICBsaWtlIFNvQyBmYW1pbHksIElEIGFuZCByZXZpc2lvbiBldGMu
DQo+ICsNCj4gIGVuZG1lbnUNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9NYWtlZmls
ZSBiL2RyaXZlcnMvc29jL2lteC9NYWtlZmlsZSBpbmRleA0KPiBkNmI1MjllMC4uZGRmMzQzZCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvaW14L01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMv
c29jL2lteC9NYWtlZmlsZQ0KPiBAQCAtMSwzICsxLDQgQEANCj4gIG9iai0kKENPTkZJR19IQVZF
X0lNWF9HUEMpICs9IGdwYy5vDQo+ICBvYmotJChDT05GSUdfSU1YX0dQQ1YyX1BNX0RPTUFJTlMp
ICs9IGdwY3YyLm8NCj4gIG9iai0kKENPTkZJR19BUkNIX01YQykgKz0gc29jLWlteDgubw0KPiAr
b2JqLSQoQ09ORklHX0lNWF9TQ1VfU09DKSArPSBzb2MtaW14LXNjdS5vDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3NvYy9pbXgvc29jLWlteC1zY3UuYyBiL2RyaXZlcnMvc29jL2lteC9zb2MtaW14
LXNjdS5jIG5ldw0KPiBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAuLjI0M2M0MTgNCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL3NvYy9pbXgvc29jLWlteC1zY3UuYw0KPiBA
QCAtMCwwICsxLDE3MyBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gKy8qDQo+ICsgKiBDb3B5cmlnaHQgMjAxOSBOWFAuDQo+ICsgKi8NCj4gKw0KPiArI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL2Zpcm13YXJlL2lteC9yc3JjLmg+ICNpbmNsdWRlDQo+ICs8bGludXgv
ZmlybXdhcmUvaW14L3NjaS5oPiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+ICNpbmNsdWRlDQo+
ICs8bGludXgvc2xhYi5oPiAjaW5jbHVkZSA8bGludXgvc3lzX3NvYy5oPiAjaW5jbHVkZQ0KPiAr
PGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPiAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gKw0KPiAr
I2RlZmluZSBJTVhfU0NVX1NPQ19EUklWRVJfTkFNRQkJImlteC1zY3Utc29jIg0KPiArDQo+ICtz
dGF0aWMgc3RydWN0IGlteF9zY19pcGMgKnNvY19pcGNfaGFuZGxlOyBzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RldmljZQ0KPiArKmlteF9zY3Vfc29jX3BkZXY7DQo+ICsNCj4gK3N0cnVjdCBpbXhf
c2NfbXNnX21pc2NfZ2V0X3NvY19pZCB7DQo+ICsJc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsN
Cj4gKwl1bmlvbiB7DQo+ICsJCXN0cnVjdCB7DQo+ICsJCQl1MzIgY29udHJvbDsNCj4gKwkJCXUx
NiByZXNvdXJjZTsNCj4gKwkJfSBzZW5kOw0KPiArCQlzdHJ1Y3Qgew0KPiArCQkJdTMyIGlkOw0K
PiArCQkJdTE2IHJlc2VydmVkOw0KPiArCQl9IHJlc3A7DQo+ICsJfSBkYXRhOw0KPiArfSBfX3Bh
Y2tlZDsNCj4gKw0KPiArc3RydWN0IGlteF9zY3Vfc29jX2RhdGEgew0KPiArCWNoYXIgKm5hbWU7
DQo+ICsJdTMyICgqc29jX3JldmlzaW9uKSh2b2lkKTsNCj4gK307DQo+ICsNCj4gK3N0YXRpYyB1
MzIgaW14OHF4cF9zb2NfcmV2aXNpb24odm9pZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgaW14X3NjX21z
Z19taXNjX2dldF9zb2NfaWQgbXNnOw0KPiArCXN0cnVjdCBpbXhfc2NfcnBjX21zZyAqaGRyID0g
Jm1zZy5oZHI7DQo+ICsJdTMyIHJldjsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJaGRyLT52ZXIg
PSBJTVhfU0NfUlBDX1ZFUlNJT047DQo+ICsJaGRyLT5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVND
Ow0KPiArCWhkci0+ZnVuYyA9IElNWF9TQ19NSVNDX0ZVTkNfR0VUX0NPTlRST0w7DQo+ICsJaGRy
LT5zaXplID0gMzsNCj4gKw0KPiArCW1zZy5kYXRhLnNlbmQuY29udHJvbCA9IElNWF9TQ19DX0lE
Ow0KPiArCW1zZy5kYXRhLnNlbmQucmVzb3VyY2UgPSBJTVhfU0NfUl9TWVNURU07DQo+ICsNCj4g
KwlyZXQgPSBpbXhfc2N1X2NhbGxfcnBjKHNvY19pcGNfaGFuZGxlLCAmbXNnLCB0cnVlKTsNCj4g
KwlpZiAocmV0KSB7DQo+ICsJCWRldl9lcnIoJmlteF9zY3Vfc29jX3BkZXYtPmRldiwNCj4gKwkJ
CSJnZXQgc29jIGluZm8gZmFpbGVkLCByZXQgJWRcbiIsIHJldCk7DQo+ICsJCS8qIHJldHVybiAw
IG1lYW5zIGdldHRpbmcgcmV2aXNpb24gZmFpbGVkICovDQo+ICsJCXJldHVybiAwOw0KPiArCX0N
Cj4gKw0KPiArCS8qIGZvcm1hdCByZXZpc2lvbiB2YWx1ZSBwYXNzZWQgZnJvbSBTQ1UgZmlybXdh
cmUgKi8NCj4gKwlyZXYgPSAobXNnLmRhdGEucmVzcC5pZCA+PiA1KSAmIDB4ZjsNCj4gKwlyZXYg
PSAoKChyZXYgPj4gMikgKyAxKSA8PCA0KSB8IChyZXYgJiAweDMpOw0KPiArDQo+ICsJcmV0dXJu
IHJldjsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfc2N1X3NvY19kYXRh
IGlteDhxeHBfc29jX2RhdGEgPSB7DQo+ICsJLm5hbWUgPSAiaS5NWDhRWFAiLA0KPiArCS5zb2Nf
cmV2aXNpb24gPSBpbXg4cXhwX3NvY19yZXZpc2lvbiwNCg0KVGhpcyBpcyBzdGlsbCBmb2xsb3cg
YSBnZW5lcmljIHNvYyBkcml2ZXIgZGVzaWduLg0KSSB3b25kZXIgaWYgdGhpcyBpcyBzdGlsbCBu
ZWVkZWQgYWZ0ZXIgc2VwYXJhdGUgc2N1IHNvYyBkcml2ZXIgZnJvbSBpbXg4bS4NCklmIG5vdCBu
ZWVkZWQsIHRoaXMgZHJpdmVyIHByb2JhYmx5IGNvdWxkIGJlIHNpbXBsaWVkIGEgbG90Lg0KDQo+
ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbXhfc2N1X3Nv
Y19tYXRjaFtdID0gew0KPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAiLCAuZGF0YSA9
ICZpbXg4cXhwX3NvY19kYXRhLCB9LA0KPiArCXsgfQ0KPiArfTsNCj4gKw0KPiArI2RlZmluZSBp
bXhfc2N1X3JldmlzaW9uKHNvY19yZXYpIFwNCj4gKwlzb2NfcmV2ID8gXA0KPiArCWthc3ByaW50
ZihHRlBfS0VSTkVMLCAiJWQuJWQiLCAoc29jX3JldiA+PiA0KSAmIDB4ZiwgIHNvY19yZXYgJiAw
eGYpIDogXA0KPiArCSJ1bmtub3duIg0KPiArDQo+ICtzdGF0aWMgaW50IGlteF9zY3Vfc29jX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gKwlzdHJ1Y3Qgc29jX2Rldmlj
ZV9hdHRyaWJ1dGUgKnNvY19kZXZfYXR0cjsNCj4gKwljb25zdCBzdHJ1Y3QgaW14X3NjdV9zb2Nf
ZGF0YSAqZGF0YTsNCj4gKwljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICppZDsNCj4gKwlzdHJ1
Y3Qgc29jX2RldmljZSAqc29jX2RldjsNCj4gKwl1MzIgc29jX3JldiA9IDA7DQo+ICsJaW50IHJl
dDsNCj4gKw0KPiArCS8qIHdhaXQgaS5NWCBTQ1UgZHJpdmVyIHJlYWR5ICovDQo+ICsJcmV0ID0g
aW14X3NjdV9nZXRfaGFuZGxlKCZzb2NfaXBjX2hhbmRsZSk7DQo+ICsJaWYgKHJldCkNCj4gKwkJ
cmV0dXJuIHJldDsNCj4gKw0KPiArCXNvY19kZXZfYXR0ciA9IGRldm1fa3phbGxvYygmcGRldi0+
ZGV2LCBzaXplb2YoKnNvY19kZXZfYXR0ciksDQo+ICsJCQkJICAgIEdGUF9LRVJORUwpOw0KPiAr
CWlmICghc29jX2Rldl9hdHRyKQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCXNvY19k
ZXZfYXR0ci0+ZmFtaWx5ID0gIkZyZWVzY2FsZSBpLk1YIjsNCj4gKw0KPiArCXJldCA9IG9mX3By
b3BlcnR5X3JlYWRfc3RyaW5nKHBkZXYtPmRldi5vZl9ub2RlLA0KPiArCQkJCSAgICAgICJtb2Rl
bCIsDQo+ICsJCQkJICAgICAgJnNvY19kZXZfYXR0ci0+bWFjaGluZSk7DQo+ICsJaWYgKHJldCkN
Cj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCWlkID0gb2ZfbWF0Y2hfbm9kZShpbXhfc2N1X3Nv
Y19tYXRjaCwgcGRldi0+ZGV2Lm9mX25vZGUpOw0KPiArCWRhdGEgPSBpZC0+ZGF0YTsNCj4gKwlp
ZiAoZGF0YSkgew0KPiArCQlzb2NfZGV2X2F0dHItPnNvY19pZCA9IGRhdGEtPm5hbWU7DQo+ICsJ
CWlmIChkYXRhLT5zb2NfcmV2aXNpb24pDQo+ICsJCQlzb2NfcmV2ID0gZGF0YS0+c29jX3Jldmlz
aW9uKCk7DQo+ICsJfQ0KPiArDQo+ICsJc29jX2Rldl9hdHRyLT5yZXZpc2lvbiA9IGlteF9zY3Vf
cmV2aXNpb24oc29jX3Jldik7DQo+ICsJaWYgKCFzb2NfZGV2X2F0dHItPnJldmlzaW9uKQ0KPiAr
CQlyZXR1cm4gLUVOT0RFVjsNCj4gKw0KPiArCXNvY19kZXYgPSBzb2NfZGV2aWNlX3JlZ2lzdGVy
KHNvY19kZXZfYXR0cik7DQo+ICsJaWYgKElTX0VSUihzb2NfZGV2KSkgew0KPiArCQlrZnJlZShz
b2NfZGV2X2F0dHItPnJldmlzaW9uKTsNCj4gKwkJcmV0dXJuIFBUUl9FUlIoc29jX2Rldik7DQo+
ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgcGxh
dGZvcm1fZHJpdmVyIGlteF9zY3Vfc29jX2RyaXZlciA9IHsNCj4gKwkuZHJpdmVyID0gew0KPiAr
CQkubmFtZSA9IElNWF9TQ1VfU09DX0RSSVZFUl9OQU1FLA0KPiArCX0sDQo+ICsJLnByb2JlID0g
aW14X3NjdV9zb2NfcHJvYmUsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgaW50IF9faW5pdCBpbXhf
c2N1X3NvY19pbml0KHZvaWQpIHsNCj4gKwljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICppZDsN
Cj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKnJvb3Q7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXJv
b3QgPSBvZl9maW5kX25vZGVfYnlfcGF0aCgiLyIpOw0KPiArCWlkID0gb2ZfbWF0Y2hfbm9kZShp
bXhfc2N1X3NvY19tYXRjaCwgcm9vdCk7DQoNClVzZSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZSBp
bnN0ZWFkLg0KVGhlbiB5b3UgcmVtb3ZlIHR3byB1bm5lY2Vzc2FyeSBsb2NhbCB2YXJpYWJsZS4N
Cg0KQlRXLCBwcm9iYWJseSBhIGJldHRlciB3YXkgaXMgdG8gbWF0Y2ggImZzbCxpbXgtc2N1Ij8N
Cg0KPiArCWlmICghaWQpIHsNCj4gKwkJb2Zfbm9kZV9wdXQocm9vdCk7DQo+ICsJCXJldHVybiAt
RU5PREVWOw0KPiArCX0NCj4gKw0KPiArCXJldCA9IHBsYXRmb3JtX2RyaXZlcl9yZWdpc3Rlcigm
aW14X3NjdV9zb2NfZHJpdmVyKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiAr
DQo+ICsJaW14X3NjdV9zb2NfcGRldiA9DQo+ICsJCXBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9z
aW1wbGUoSU1YX1NDVV9TT0NfRFJJVkVSX05BTUUsDQo+ICsJCQkJCQktMSwNCj4gKwkJCQkJCU5V
TEwsDQo+ICsJCQkJCQkwKTsNCj4gKwlpZiAoSVNfRVJSKGlteF9zY3Vfc29jX3BkZXYpKSB7DQo+
ICsJCXJldCA9IFBUUl9FUlIoaW14X3NjdV9zb2NfcGRldik7DQo+ICsJCWdvdG8gdW5yZWdfcGxh
dGZvcm1fZHJpdmVyOw0KPiArCX0NCj4gKw0KPiArCWlteF9zY3Vfc29jX3BkZXYtPmRldi5vZl9u
b2RlID0gcm9vdDsNCg0KUGxlYXNlIGRvdWJsZSBjaGVjayBpZiB3ZSByZWFsbHkgbmVlZCBhIGds
b2JhbCBpbXhfc2N1X3NvY19wZGV2Lg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg0KPiArDQo+
ICsJcmV0dXJuIDA7DQo+ICsNCj4gK3VucmVnX3BsYXRmb3JtX2RyaXZlcjoNCj4gKwlwbGF0Zm9y
bV9kcml2ZXJfdW5yZWdpc3RlcigmaW14X3NjdV9zb2NfZHJpdmVyKTsNCj4gKwlyZXR1cm4gcmV0
Ow0KPiArfQ0KPiArZGV2aWNlX2luaXRjYWxsKGlteF9zY3Vfc29jX2luaXQpOw0KPiAtLQ0KPiAy
LjcuNA0KDQo=
