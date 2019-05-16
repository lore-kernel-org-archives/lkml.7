Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5760C04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7B520848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q2/3Q4AO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfEPJIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:08:24 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:64902
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfEPJIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfCK9G/1Ezfg0zT/8NPydmm92SdENJ4TgTU7Oayq1Xo=;
 b=q2/3Q4AOLTw8HqMsMsDzD0DGkK75BrC5d9yDLUby7TQPri7o0MYKmN2Q2BV3S3rqIkCQLX657Jyv5p6YhSjOdPA88JV0LCHBCBc+GlxOsdH191ngghtXcLpWrn2Ptl3OE8KiV6Jl5+dkyz8NgbdvLdWvFuupVBW4jKGzaz9W72s=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5443.eurprd04.prod.outlook.com (20.178.114.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 09:08:20 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1878.024; Thu, 16 May 2019
 09:08:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: imx8mm: fix int pll clk gate
Thread-Topic: [PATCH] clk: imx: imx8mm: fix int pll clk gate
Thread-Index: AQHVC8boYtBzxTxs20ifj5H/IzL5JA==
Date:   Thu, 16 May 2019 09:08:20 +0000
Message-ID: <20190516092157.29017-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:203:2f::34) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa28a1dd-adbb-4887-7581-08d6d9de0a6d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5443;
x-ms-traffictypediagnostic: AM0PR04MB5443:
x-microsoft-antispam-prvs: <AM0PR04MB5443677C3A1E167DE5000E94880A0@AM0PR04MB5443.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(6486002)(36756003)(53936002)(1076003)(2501003)(305945005)(8936002)(6512007)(4326008)(6436002)(2201001)(50226002)(3846002)(2906002)(81156014)(86362001)(71200400001)(71190400001)(25786009)(68736007)(81166006)(8676002)(66946007)(66556008)(73956011)(66446008)(64756008)(44832011)(66476007)(5660300002)(486006)(478600001)(316002)(2616005)(110136005)(26005)(386003)(99286004)(6506007)(14454004)(54906003)(7736002)(102836004)(256004)(66066001)(6116002)(476003)(186003)(52116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5443;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YyzOztaN0VDuYzlnWTDeXAp43KniXIxpaLmphPy8F+3Yc8jkvel9yyn7RBF8yew4PjZYMseF7M4A3E/zDU6MNEqU8qIPxKad/hmETQlWNCrcfOGmMSbnXpptm8EybJ7iHknd9Y+GZL9Idfpz58YmK+S1bFPtiKesfu030/cNuhrmdjTo+pBVyERzPSaSkxYZuRjCJRjY9b24JyIswYa33tlRPY4HiI+bAHawNmFIeS8nYOuQGdIy8OmGcczoibZOJE4N38vrPiN49MkOGU/XpIXkWXrnYBXNYa5pd6JpJl5DLbAHnT6VREm/ddWf53KP/Y2KSnQYDi0g5aedLFC/j04Qiij/y/9wmvOTGtoLgxEQHEAT+JlGI7Xl2SMQCjU1yBg8rCZifVAugYcs4n5qE1vK0kqLfU8j9y6w/0RVdWs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa28a1dd-adbb-4887-7581-08d6d9de0a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 09:08:20.4194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5443
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VG8gRnJhYyBwbGwsIHRoZSBnYXRlIHNoaWZ0IGlzIDEzLCBob3dldmVyIHRvIEludCBQTEwgdGhl
IGdhdGUgc2hpZnQNCmlzIDExLg0KDQpTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NClJldmlld2VkLWJ5OiBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+DQotLS0N
CiBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbS5jIHwgMTIgKysrKysrLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1tLmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDht
bS5jDQppbmRleCAxZWY4NDM4ZTNkNmQuLjEyMmE4MWFiOGU0OCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvY2xrL2lteC9jbGstaW14OG1tLmMNCisrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1t
LmMNCkBAIC00NDksMTIgKzQ0OSwxMiBAQCBzdGF0aWMgaW50IF9faW5pdCBpbXg4bW1fY2xvY2tz
X2luaXQoc3RydWN0IGRldmljZV9ub2RlICpjY21fbm9kZSkNCiAJY2xrc1tJTVg4TU1fQVVESU9f
UExMMl9PVVRdID0gaW14X2Nsa19nYXRlKCJhdWRpb19wbGwyX291dCIsICJhdWRpb19wbGwyX2J5
cGFzcyIsIGJhc2UgKyAweDE0LCAxMyk7DQogCWNsa3NbSU1YOE1NX1ZJREVPX1BMTDFfT1VUXSA9
IGlteF9jbGtfZ2F0ZSgidmlkZW9fcGxsMV9vdXQiLCAidmlkZW9fcGxsMV9ieXBhc3MiLCBiYXNl
ICsgMHgyOCwgMTMpOw0KIAljbGtzW0lNWDhNTV9EUkFNX1BMTF9PVVRdID0gaW14X2Nsa19nYXRl
KCJkcmFtX3BsbF9vdXQiLCAiZHJhbV9wbGxfYnlwYXNzIiwgYmFzZSArIDB4NTAsIDEzKTsNCi0J
Y2xrc1tJTVg4TU1fR1BVX1BMTF9PVVRdID0gaW14X2Nsa19nYXRlKCJncHVfcGxsX291dCIsICJn
cHVfcGxsX2J5cGFzcyIsIGJhc2UgKyAweDY0LCAxMyk7DQotCWNsa3NbSU1YOE1NX1ZQVV9QTExf
T1VUXSA9IGlteF9jbGtfZ2F0ZSgidnB1X3BsbF9vdXQiLCAidnB1X3BsbF9ieXBhc3MiLCBiYXNl
ICsgMHg3NCwgMTMpOw0KLQljbGtzW0lNWDhNTV9BUk1fUExMX09VVF0gPSBpbXhfY2xrX2dhdGUo
ImFybV9wbGxfb3V0IiwgImFybV9wbGxfYnlwYXNzIiwgYmFzZSArIDB4ODQsIDEzKTsNCi0JY2xr
c1tJTVg4TU1fU1lTX1BMTDFfT1VUXSA9IGlteF9jbGtfZ2F0ZSgic3lzX3BsbDFfb3V0IiwgInN5
c19wbGwxX2J5cGFzcyIsIGJhc2UgKyAweDk0LCAxMyk7DQotCWNsa3NbSU1YOE1NX1NZU19QTEwy
X09VVF0gPSBpbXhfY2xrX2dhdGUoInN5c19wbGwyX291dCIsICJzeXNfcGxsMl9ieXBhc3MiLCBi
YXNlICsgMHgxMDQsIDEzKTsNCi0JY2xrc1tJTVg4TU1fU1lTX1BMTDNfT1VUXSA9IGlteF9jbGtf
Z2F0ZSgic3lzX3BsbDNfb3V0IiwgInN5c19wbGwzX2J5cGFzcyIsIGJhc2UgKyAweDExNCwgMTMp
Ow0KKwljbGtzW0lNWDhNTV9HUFVfUExMX09VVF0gPSBpbXhfY2xrX2dhdGUoImdwdV9wbGxfb3V0
IiwgImdwdV9wbGxfYnlwYXNzIiwgYmFzZSArIDB4NjQsIDExKTsNCisJY2xrc1tJTVg4TU1fVlBV
X1BMTF9PVVRdID0gaW14X2Nsa19nYXRlKCJ2cHVfcGxsX291dCIsICJ2cHVfcGxsX2J5cGFzcyIs
IGJhc2UgKyAweDc0LCAxMSk7DQorCWNsa3NbSU1YOE1NX0FSTV9QTExfT1VUXSA9IGlteF9jbGtf
Z2F0ZSgiYXJtX3BsbF9vdXQiLCAiYXJtX3BsbF9ieXBhc3MiLCBiYXNlICsgMHg4NCwgMTEpOw0K
KwljbGtzW0lNWDhNTV9TWVNfUExMMV9PVVRdID0gaW14X2Nsa19nYXRlKCJzeXNfcGxsMV9vdXQi
LCAic3lzX3BsbDFfYnlwYXNzIiwgYmFzZSArIDB4OTQsIDExKTsNCisJY2xrc1tJTVg4TU1fU1lT
X1BMTDJfT1VUXSA9IGlteF9jbGtfZ2F0ZSgic3lzX3BsbDJfb3V0IiwgInN5c19wbGwyX2J5cGFz
cyIsIGJhc2UgKyAweDEwNCwgMTEpOw0KKwljbGtzW0lNWDhNTV9TWVNfUExMM19PVVRdID0gaW14
X2Nsa19nYXRlKCJzeXNfcGxsM19vdXQiLCAic3lzX3BsbDNfYnlwYXNzIiwgYmFzZSArIDB4MTE0
LCAxMSk7DQogDQogCS8qIFNZUyBQTEwgZml4ZWQgb3V0cHV0ICovDQogCWNsa3NbSU1YOE1NX1NZ
U19QTEwxXzQwTV0gPSBpbXhfY2xrX2ZpeGVkX2ZhY3Rvcigic3lzX3BsbDFfNDBtIiwgInN5c19w
bGwxX291dCIsIDEsIDIwKTsNCi0tIA0KMi4xNi40DQoNCg==
