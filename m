Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC47FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CD72082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jSfRhIZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436619AbfFLDxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 23:53:13 -0400
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:61414
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407169AbfFLDxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 23:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=080bmkbMkOSS8t2VzyYcZlQUy78lnN3zRz2xSOgXKI8=;
 b=jSfRhIZ+ERsokX1MYmjp6Rcu2LC5VNVXMo5itWgsvL+dmTyu+oiyBXend29blUthigsjivCnxoTFITdjihcbZpH0KotSH7yBMaXHydiGHiiNHaFex4gHynfDOoMiV0CVhsdU96MAsKXoGt0Axr+GSGXTVwu/LLA2BfVdOYQvWSs=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5188.eurprd04.prod.outlook.com (20.177.42.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 12 Jun 2019 03:53:08 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::11e1:3bb9:156b:a3e4%3]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 03:53:08 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] soc: imx8: Fix potential kernel dump in error path
Thread-Topic: [PATCH 1/2] soc: imx8: Fix potential kernel dump in error path
Thread-Index: AQHVIM/CBiCldgc28kaHaTOtZzLmMaaXYqxw
Date:   Wed, 12 Jun 2019 03:53:08 +0000
Message-ID: <AM0PR04MB42111004D6D8DDA48172E8D280EC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190612033620.3556-1-Anson.Huang@nxp.com>
In-Reply-To: <20190612033620.3556-1-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c568771d-ee2a-4046-dc51-08d6eee97b6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5188;
x-ms-traffictypediagnostic: AM0PR04MB5188:
x-microsoft-antispam-prvs: <AM0PR04MB5188E58154E2BB43F239D3F880EC0@AM0PR04MB5188.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:207;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(189003)(199004)(2906002)(7736002)(71190400001)(186003)(71200400001)(25786009)(53936002)(229853002)(110136005)(6436002)(74316002)(44832011)(3846002)(6116002)(4326008)(316002)(8936002)(476003)(52536014)(446003)(11346002)(81166006)(2201001)(256004)(486006)(81156014)(6246003)(99286004)(68736007)(7696005)(86362001)(305945005)(2501003)(66066001)(76176011)(26005)(8676002)(33656002)(45080400002)(6506007)(14454004)(478600001)(9686003)(5660300002)(55016002)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(73956011)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5188;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gs23x2F+FyAtg1dFQfIrBCLq5NC362uFruLVNhVBMIZqjTgBW/A/wk9c4gnq93Oyl9gp7e6dIaX2Ksj9opY1LABIQ631RnJ2vZ4kEn7G/27FYo5tGMlPmDxzZ6tZGGpNASop42cHNtYi1bradEhGIJ3EWONE0vloIP9AE+5KixMk1gXIZ5BiOeO3Xbh2H2m47vfBjCWTaR19iJcTi97ev8zldMrM73uyVycnR9QI2wtt/68MIbJy9k+xBR02PLwwPNzhMJruPlMr+xG8EPvalPukjQLiM/JdMjeJj7XpH0GcceKiH5L1z2MwHBBeWQD86mB+ifI1gnx8bkuuLaZTyRoYEiZsiSyOGw/au3XeOGlctLCwJcPJKfWTr+ztC27P/nZbxIfTU4BLu5pM+fD/r85BU/XquvWhXZpQ7mt+0iA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c568771d-ee2a-4046-dc51-08d6eee97b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 03:53:08.3891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aisheng.dong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29tIFttYWlsdG86QW5zb24uSHVhbmdAbnhwLmNvbV0N
Cj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDEyLCAyMDE5IDExOjM2IEFNDQo+ID4gDQo+IFdoZW4g
U29DJ3MgcmV2aXNpb24gdmFsdWUgaXMgMCwgU29DIGRyaXZlciB3aWxsIHByaW50IG91dCAidW5r
bm93biIgaW4gc3lzZnMncw0KPiByZXZpc2lvbiBub2RlLCB0aGlzICJ1bmtub3duIiBpcyBhIHN0
YXRpYyBzdHJpbmcgd2hpY2ggY2FuIE5PVCBiZSBmcmVlZCwgdGhpcw0KPiB3aWxsIGNhdXNlZCBi
ZWxvdyBrZXJuZWwgZHVtcCBpbiBsYXRlciBlcnJvciBwYXRoIHdoaWNoIGNhbGxzIGtmcmVlOg0K
PiANCj4ga2VybmVsIEJVRyBhdCBtbS9zbHViLmM6Mzk0MiENCj4gSW50ZXJuYWwgZXJyb3I6IE9v
cHMgLSBCVUc6IDAgWyMxXSBQUkVFTVBUIFNNUCBNb2R1bGVzIGxpbmtlZCBpbjoNCj4gQ1BVOiAy
IFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQNCj4gNS4yLjAtcmM0LW5leHQtMjAx
OTA2MTEtMDAwMjMtZzcwNTE0NmMtZGlydHkgIzIxOTcgSGFyZHdhcmUgbmFtZTogTlhQDQo+IGku
TVg4TVEgRVZLIChEVCkNCj4gcHN0YXRlOiA2MDAwMDAwNSAoblpDdiBkYWlmIC1QQU4gLVVBTykN
Cj4gcGMgOiBrZnJlZSsweDE3MC8weDFiMA0KPiBsciA6IGlteDhfc29jX2luaXQrMHhjMC8weGU0
DQo+IHNwIDogZmZmZjAwMDAxMDAzYmQxMA0KPiB4Mjk6IGZmZmYwMDAwMTAwM2JkMTAgeDI4OiBm
ZmZmMDAwMDExMjFlMGEwDQo+IHgyNzogZmZmZjAwMDAxMTQ4MjAwMCB4MjY6IGZmZmYwMDAwMTEx
NzA2OGMNCj4geDI1OiBmZmZmMDAwMDExMjFlMTAwIHgyNDogZmZmZjAwMDAxMTQ4MjAwMA0KPiB4
MjM6IGZmZmYwMDAwMTBmZTJiNTggeDIyOiBmZmZmMDAwMDExMWI5YWIwDQo+IHgyMTogZmZmZjgw
MDBiZDlkZmJhMCB4MjA6IGZmZmYwMDAwMTExYjliNzANCj4geDE5OiBmZmZmN2UwMDAwNDNmODgw
IHgxODogMDAwMDAwMDAwMDAwMTAwMA0KPiB4MTc6IGZmZmYwMDAwMTBkMDVmYTAgeDE2OiBmZmZm
MDAwMDEyMmUwMDAwDQo+IHgxNTogMDE0MDAwMDAwMDAwMDAwMCB4MTQ6IDAwMDAwMDAwMzAzNjAw
MDANCj4geDEzOiBmZmZmODAwMGI5NGI1YmIwIHgxMjogMDAwMDAwMDAwMDAwMDAzOA0KPiB4MTE6
IGZmZmZmZmZmZmZmZmZmZmYgeDEwOiBmZmZmZmZmZmZmZmZmZmZmDQo+IHg5IDogMDAwMDAwMDAw
MDAwMDAwMyB4OCA6IGZmZmY4MDAwYjk0ODgxNDcNCj4geDcgOiBmZmZmMDAwMDEwMDNiYzAwIHg2
IDogMDAwMDAwMDAwMDAwMDAwMA0KPiB4NSA6IDAwMDAwMDAwMDAwMDAwMDMgeDQgOiAwMDAwMDAw
MDAwMDAwMDAzDQo+IHgzIDogMDAwMDAwMDAwMDAwMDAwMyB4MiA6IGI4NzkzYWNkNjA0ZWRmMDAN
Cj4geDEgOiBmZmZmN2UwMDAwNDNmODgwIHgwIDogZmZmZjdlMDAwMDQzZjg4OCBDYWxsIHRyYWNl
Og0KPiAga2ZyZWUrMHgxNzAvMHgxYjANCj4gIGlteDhfc29jX2luaXQrMHhjMC8weGU0DQo+ICBk
b19vbmVfaW5pdGNhbGwrMHg1OC8weDFiOA0KPiAga2VybmVsX2luaXRfZnJlZWFibGUrMHgxY2Mv
MHgyODgNCj4gIGtlcm5lbF9pbml0KzB4MTAvMHgxMDANCj4gIHJldF9mcm9tX2ZvcmsrMHgxMC8w
eDE4DQo+IA0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoaXMgcG90ZW50aWFsIGtlcm5lbCBkdW1wIHdo
ZW4gYSBjaGlwJ3MgcmV2aXNpb24gaXMgInVua25vd24iLA0KPiBpdCBpcyBkb25lIGJ5IGFsd2F5
cyBwcmludGluZyBvdXQgdGhlIHJldmlzaW9uIHZhbHVlLg0KPiANCj4gRml4ZXM6IGE3ZTI2ZjM1
NmNhMSAoInNvYzogaW14OiBBZGQgZ2VuZXJpYyBpLk1YOCBTb0MgZHJpdmVyIikNCj4gU2lnbmVk
LW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9zb2MvaW14L3NvYy1pbXg4LmMgfCAxMCArKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc29jL2lteC9zb2MtaW14OC5jIGIvZHJpdmVycy9zb2MvaW14L3NvYy1pbXg4LmMgaW5k
ZXgNCj4gMDIzMDlhMi4uODZiOTI1YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvaW14L3Nv
Yy1pbXg4LmMNCj4gKysrIGIvZHJpdmVycy9zb2MvaW14L3NvYy1pbXg4LmMNCj4gQEAgLTk2LDEx
ICs5Niw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteDhfc29jX21hdGNo
W10gPSB7DQo+ICAJeyB9DQo+ICB9Ow0KPiANCj4gLSNkZWZpbmUgaW14OF9yZXZpc2lvbihzb2Nf
cmV2KSBcDQo+IC0Jc29jX3JldiA/IFwNCj4gLQlrYXNwcmludGYoR0ZQX0tFUk5FTCwgIiVkLiVk
IiwgKHNvY19yZXYgPj4gNCkgJiAweGYsICBzb2NfcmV2ICYgMHhmKSA6IFwNCj4gLQkidW5rbm93
biINCj4gLQ0KPiAgc3RhdGljIGludCBfX2luaXQgaW14OF9zb2NfaW5pdCh2b2lkKQ0KPiAgew0K
PiAgCXN0cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0ZSAqc29jX2Rldl9hdHRyOyBAQCAtMTM1LDcg
KzEzMCwxMCBAQA0KPiBzdGF0aWMgaW50IF9faW5pdCBpbXg4X3NvY19pbml0KHZvaWQpDQo+ICAJ
CQlzb2NfcmV2ID0gZGF0YS0+c29jX3JldmlzaW9uKCk7DQo+ICAJfQ0KPiANCj4gLQlzb2NfZGV2
X2F0dHItPnJldmlzaW9uID0gaW14OF9yZXZpc2lvbihzb2NfcmV2KTsNCj4gKwlzb2NfZGV2X2F0
dHItPnJldmlzaW9uID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsDQo+ICsJCQkJCSAgICIlZC4lZCIs
DQo+ICsJCQkJCSAgIChzb2NfcmV2ID4+IDQpICYgMHhmLA0KPiArCQkJCQkgICBzb2NfcmV2ICYg
MHhmKTsNCg0KVGhlIHJldmlzaW9uICIwLjAiIGlzIGNvbmZ1c2luZy4NCkkgbWlnaHQgcHJlZmVy
IHRvIGNoZWNrICJ1bmtub3duIiBiZWZvcmUgZnJlZS4NCg0KUmVnYXJkcw0KRG9uZyBBaXNoZW5n
DQoNCj4gIAlpZiAoIXNvY19kZXZfYXR0ci0+cmV2aXNpb24pIHsNCj4gIAkJcmV0ID0gLUVOT01F
TTsNCj4gIAkJZ290byBmcmVlX3NvYzsNCj4gLS0NCj4gMi43LjQNCg0K
