Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5431CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75E820856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f+PAdXAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437841AbfJXG5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 02:57:31 -0400
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:21382
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727635AbfJXG5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 02:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbTzIpJPgCPzwWaj5d6QfbRm5ybBZj4cGqvhmBkvFBL2kIw3XIN2qiVLszWAHagnR/6gVCCb11S98fDdYsNNvorB19Ft5H2M2IFZIaZkDQo0KwpF+xuo2NUcMi4zA5kKlzj5OP39nGbd7hpEYDvon368MyfGbdc8w0pDMh5KAY8w41eINuG5b2uQcV1mtF/PSuW8wYKcwITHOBUBfAkGCdptvtuyx5Z4OSNzxmdZIrE8voSPoPmTPDkr8VuZcQlbrKxDKey1xT5w0a7qr8jNRAnGLste3EDgGNTyqZo6ua/p52wBOkBsE8spp8G27thnA2qcKIk0E+kK5yw9AhuTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBNbdBmQd80Nq0sFIlcM9kti+3TltWFC2IUOP6UrCsk=;
 b=IR3Mp07twlxzuofgXiOq3/aOte3KvZY6UNELYC8DuiQmmAZLQsJ0+dJSHcc/Fd9Ou6gvSpJpo6Xoz+eiyZ2n70Uc0BFJt/O+Ea/QvTgtEOOaFLOqHxhSQvFUXgaVqi5ulVZUeZSyaCI0y0jPsTXMIM22mJhSiKeck0djOB7/6KJQBboFMHDR42DKAcASovORTVh8cL6oPjjmSHbDzLdAfCe5RkPjimzl7Gerg4Idp4vyTC55ULmeyniOlpuMjQcT1rqRy7ZQqo99RUiPrIrh+lehUXiaji//gBcst93Q7OkO7I0GE0uboEwPBvBOLTkQxYDO3/0rgDxJN1ftLQy7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBNbdBmQd80Nq0sFIlcM9kti+3TltWFC2IUOP6UrCsk=;
 b=f+PAdXAA1FStvkD1DovyNUYzjN6pqT89+C0M9uOuZUHD8iKMoxD8ka9z4MIcRkkN6fNkUDfPDBbQ1IYtHDnGI59rKU8ZHPdR5nFZzWh0+80UmSs70HT+FyDcy7rmGQYZkFpJ05FSp4Fv97d9beIS0FsaiqUaWrFACcpPoRJsQ/g=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB4683.eurprd04.prod.outlook.com (52.135.139.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 06:57:22 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::7804:558a:eef9:cc11]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::7804:558a:eef9:cc11%7]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 06:57:22 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: imx8mq: fix sys2/3_pll_out_sels
Thread-Topic: [PATCH] clk: imx: imx8mq: fix sys2/3_pll_out_sels
Thread-Index: AQHVijhIlRv5T5+Fgk+U/4a62CwQtw==
Date:   Thu, 24 Oct 2019 06:57:21 +0000
Message-ID: <1571900044-22079-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::34) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74b9ff3e-2dd2-4bba-cb6a-08d7584f6af6
x-ms-traffictypediagnostic: DB7PR04MB4683:|DB7PR04MB4683:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB468387F4E144DA8682EFC7C3886A0@DB7PR04MB4683.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(199004)(189003)(81156014)(6486002)(256004)(54906003)(52116002)(476003)(2616005)(102836004)(66066001)(186003)(6512007)(6506007)(110136005)(6436002)(5660300002)(316002)(99286004)(7736002)(71190400001)(71200400001)(2201001)(14444005)(66556008)(2906002)(66476007)(305945005)(26005)(386003)(86362001)(66446008)(50226002)(3846002)(2501003)(64756008)(6636002)(44832011)(4326008)(478600001)(8676002)(25786009)(14454004)(81166006)(486006)(66946007)(8936002)(36756003)(6116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4683;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o59luhHqYaavQTq53VNA7uOIeVVzprn4gnTwA++qWGvJ4rCBMH1l6cC7tDg6G3AWA7GfjCk93bt/iKY6l+Bl8NkyTzv17hBYnFsv6DkERoiStMwWfegMHXtj7SBEc6nhmVSkWagtv5X3YXoGWVq4ij0IGJELE83HUkrJjPlAt8YO7CtgJ6frlG52T8a6p1ImBgzFsbu+tgSvGUMDZs1BPu/Y6FdcNc3hGcf0AI34iIztu+1YQA3rBZF76+ek2oYPNh3OQzKEIrJXmAOZtHg2ZIOdey8bkPidrb21W+xx4bFWK34vMsqayUiQwljAkWfmRJfxNozeX/52XUEXNcc0j1rS7oh2PjQ55WSTFss/ugW/O17jNv0I2iX7axRCnBlro3TYNwvN2sJ40h43w57ahHHvxM391AZacnK1Dp+7gMKJ3Dp0FJfECQ6e5cUmdEL4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b9ff3e-2dd2-4bba-cb6a-08d7584f6af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 06:57:21.8372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPbdvGXamzeFsaUfZbYWWOAkpXDjfeL3aODRpAmyb2vA50v8M/hzqYrAI+Hoat1zYs6lKwaMcHHP9IRrxwsj2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4683
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The current clk tree shows:
 osc_25m                              9       11        0    25000000      =
    0     0  50000
    sys2_pll1_ref_sel                 1        1        0    25000000      =
    0     0  50000
       sys3_pll_out                   1        1        0    25000000      =
    0     0  50000
    sys1_pll1_ref_sel                 2        2        0    25000000      =
    0     0  50000
       sys2_pll_out                   6        6        0  1000000000      =
    0     0  50000

It is not correct that sys3_pll_out use sys2_pll1_ref_sel as parent,
sys2_pll_out use sys1_pll1_ref_sel as parent.

According to the current imx_clk_sccg_pll design, it uses both
bypass1/2, however set bypass2 as 1 is not correct, because it will
make sys[x]_pll_out use wrong parent and might access wrong registers.

So correct bypass2 to 0 and fix sys2/3_pll_out_sels.

After fix, the tree shows:
 osc_25m                             10       12        0    25000000      =
    0     0  50000
    sys3_pll1_ref_sel                 1        1        0    25000000      =
    0     0  50000
       sys3_pll_out                   1        1        0    25000000      =
    0     0  50000
    sys2_pll1_ref_sel                 1        1        0    25000000      =
    0     0  50000
       sys2_pll_out                   6        6        0  1000000000      =
    0     0  50000
    sys1_pll1_ref_sel                 1        1        0    25000000      =
    0     0  50000
       sys1_pll_out                   5        5        0   800000000      =
    0     0  50000

Fixes: e9dda4af685f ("clk: imx: Refactor entire sccg pll clk")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 05ece7b5da54..e17f0ebfacb0 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -35,8 +35,8 @@ static const char * const audio_pll2_bypass_sels[] =3D {"=
audio_pll2", "audio_pll2_
 static const char * const video_pll1_bypass_sels[] =3D {"video_pll1", "vid=
eo_pll1_ref_sel", };
=20
 static const char * const sys1_pll_out_sels[] =3D {"sys1_pll1_ref_sel", };
-static const char * const sys2_pll_out_sels[] =3D {"sys1_pll1_ref_sel", "s=
ys2_pll1_ref_sel", };
-static const char * const sys3_pll_out_sels[] =3D {"sys3_pll1_ref_sel", "s=
ys2_pll1_ref_sel", };
+static const char * const sys2_pll_out_sels[] =3D {"sys2_pll1_ref_sel", };
+static const char * const sys3_pll_out_sels[] =3D {"sys3_pll1_ref_sel", };
 static const char * const dram_pll_out_sels[] =3D {"dram_pll1_ref_sel", };
 static const char * const video2_pll_out_sels[] =3D {"video2_pll1_ref_sel"=
, };
=20
@@ -345,8 +345,8 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MQ_VIDEO_PLL1_OUT] =3D imx_clk_gate("video_pll1_out", "video_pll=
1_bypass", base + 0x10, 21);
=20
 	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_sccg_pll("sys1_pll_out", sys1_pll_o=
ut_sels, ARRAY_SIZE(sys1_pll_out_sels), 0, 0, 0, base + 0x30, CLK_IS_CRITIC=
AL);
-	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_sccg_pll("sys2_pll_out", sys2_pll_o=
ut_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 1, base + 0x3c, CLK_IS_CRITIC=
AL);
-	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out", sys3_pll_o=
ut_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 1, base + 0x48, CLK_IS_CRITIC=
AL);
+	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_sccg_pll("sys2_pll_out", sys2_pll_o=
ut_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 0, base + 0x3c, CLK_IS_CRITIC=
AL);
+	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out", sys3_pll_o=
ut_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 0, base + 0x48, CLK_IS_CRITIC=
AL);
 	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sccg_pll("dram_pll_out", dram_pll_o=
ut_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CRITIC=
AL);
 	clks[IMX8MQ_VIDEO2_PLL_OUT] =3D imx_clk_sccg_pll("video2_pll_out", video2=
_pll_out_sels, ARRAY_SIZE(video2_pll_out_sels), 0, 0, 0, base + 0x54, 0);
=20
--=20
2.16.4

