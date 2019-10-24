Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB91CCA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DDD21D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C+qMiVvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408135AbfJXB6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:58:51 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:33668
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbfJXB6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSkvhFZxwVBoTziRquSPUxzuh8hX8DBd2Qs3L9f89pMf0NapbaZ3yZZCECllZUS1wlLcsrXFiqoWVKgeNdxEdnVqaZLPqUGOXUftxYLmLDgyDQdgh8mSSVha0KMSbNEysq4xu3iWXYlwPzvDm175fBbaEWdwmxV5VRwLlN/waOwfztfjU+hYYKor6fxDqxUmAghjmEmg8QFpHhaZmAdQ9uma+QF9b1/PK0d1bvInAHOnpcIvo11Nmc9bP8JALftZ9v502mzkfntvAYXh0tVkk7FJ5DGm8DRn/KfusXv0VpVkO7QxhDutAaoV1gxTKMO0+sBouIR/tXxG2nvQ4q/iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQz0GtdNX3b9bVLpwODx8TvJMZ7muHIGuiZQYs5VuNE=;
 b=NGEV4AEyz7CURu29ziaUxpe4F1Jn/Zawu0gWyFFN8DD7pmOayr4ZN/vnTFF04rr3UX8/U2zrk3vjJs7hFtjbNqGUePqEu+k9DamedZmILKyGadYExYfBPK7QnAzYNvYYM/mXPnEbzY7NUHs3/mSBGC7R23JNVU5filtx4eIBG4cXPo2G9ejutXMpKq1DLBrV1nozhQRg0swPdarsfLu4x2O1v1MBvphR96AUNiac1/wZxK9rMTPd65eHV3vg2xF6llzBf/3srwmGwy3h+O7IngUSfV+6pzHFPXy+hTC6mxukKZWwKK1SbWWBVbLQg4roPo7F7Mp947mXtHA6dUnp8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQz0GtdNX3b9bVLpwODx8TvJMZ7muHIGuiZQYs5VuNE=;
 b=C+qMiVvByCqzk9ZmAt7r+V2YPpsz/c5eVaNIub9MdKhPTbP65I+VCa74N8N3NyuJ+jnM1R/LrkuQ9Ya6pPgX2FfGglo7vEWtyRwaOhVYdZeerRgf6k5bO4swPp+VR4m6rzkJnjtwpaPD5JNSHF/3cJ3sXG+NXZEFc6WReKGKPYY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5988.eurprd04.prod.outlook.com (20.178.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 01:58:47 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 01:58:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/3] clk: imx: imx8mq: mark sys1/2_pll as fixed clock
Thread-Topic: [PATCH V2 3/3] clk: imx: imx8mq: mark sys1/2_pll as fixed clock
Thread-Index: AQHVig6SL+3mgqkYJUGuVBtzt4qM8Q==
Date:   Thu, 24 Oct 2019 01:58:47 +0000
Message-ID: <1571882110-10191-4-git-send-email-peng.fan@nxp.com>
References: <1571882110-10191-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1571882110-10191-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0082.apcprd04.prod.outlook.com
 (2603:1096:202:15::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e30789b6-1676-4f6e-595f-08d75825b535
x-ms-traffictypediagnostic: AM0PR04MB5988:|AM0PR04MB5988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5988EF454718435567F66FDE886A0@AM0PR04MB5988.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(189003)(186003)(26005)(316002)(4326008)(64756008)(6116002)(71190400001)(6512007)(6436002)(2201001)(76176011)(305945005)(25786009)(36756003)(14454004)(54906003)(71200400001)(478600001)(110136005)(2501003)(5660300002)(7736002)(52116002)(66556008)(2616005)(99286004)(6486002)(476003)(446003)(8936002)(256004)(44832011)(386003)(86362001)(50226002)(6506007)(486006)(102836004)(2906002)(11346002)(66946007)(81156014)(81166006)(66066001)(66476007)(8676002)(66446008)(3846002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5988;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SA+hOrohLdfjQmsuBp+Ucs6cSufmrptjEJhuyP66kph8MFWlqUAfPlgooWwmTHAXWqrpcPTOSFHuE5a3RkEdhqJ5yISGavJJjKAPuvdLIAd6xT7AXEutBw50xCuHmnfumdswKmns4F84TNMUgp6/sF1WBWoAG9LweO/PFVWZbMsMYoaUA2g5hRo4jVHnNlAZqtjCruKxkAlilUOX9NW/Nod9t16FdbxTmQM4CBN3EijZnf4SIqxIbjsguZpwv1lKnKK4nBJgrQUiu4B3DeTSMfmkiw4hpbSGt5rEjOGFOOYdf2/R9evkxPzVIRC2EYKHOtR0hf4kaAD99L+n5vvjs6A+yNCMHOHllTjEB1mIr0OXO7akfNW2O/Oobz8j3mR9Rr6BxFqrKPfccd7i7kAuD2bgEh2C7TCAqE+t+aAjWphd5m6w+qUhAlVJVZA+wWSd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30789b6-1676-4f6e-595f-08d75825b535
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 01:58:47.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbMAr3V5yphimEMkTLyOupnlMfmfLGDYF8AGoz2ax8Wgl8KljqhGJzdB+7FVxq362/9DFWo+iUkEzTy9K3GM2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5988
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According Architecture definition guide, SYS1_PLL is fixed at
800MHz, SYS2_PLL is fixed at 1000MHz, so let's use imx_clk_fixed
to register the clocks and drop code that could change the rate.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 43af92525efb..4a5dbc4366a5 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -34,8 +34,6 @@ static const char * const audio_pll1_bypass_sels[] =3D {"=
audio_pll1", "audio_pll1_
 static const char * const audio_pll2_bypass_sels[] =3D {"audio_pll2", "aud=
io_pll2_ref_sel", };
 static const char * const video_pll1_bypass_sels[] =3D {"video_pll1", "vid=
eo_pll1_ref_sel", };
=20
-static const char * const sys1_pll_out_sels[] =3D {"sys1_pll1_ref_sel", };
-static const char * const sys2_pll_out_sels[] =3D {"sys1_pll1_ref_sel", "s=
ys2_pll1_ref_sel", };
 static const char * const sys3_pll_out_sels[] =3D {"sys3_pll1_ref_sel", "s=
ys2_pll1_ref_sel", };
 static const char * const dram_pll_out_sels[] =3D {"dram_pll1_ref_sel", };
 static const char * const video2_pll_out_sels[] =3D {"video2_pll1_ref_sel"=
, };
@@ -308,8 +306,6 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MQ_AUDIO_PLL1_REF_SEL] =3D imx_clk_mux("audio_pll1_ref_sel", bas=
e + 0x0, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MQ_AUDIO_PLL2_REF_SEL] =3D imx_clk_mux("audio_pll2_ref_sel", bas=
e + 0x8, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MQ_VIDEO_PLL1_REF_SEL] =3D imx_clk_mux("video_pll1_ref_sel", bas=
e + 0x10, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MQ_SYS1_PLL1_REF_SEL]	=3D imx_clk_mux("sys1_pll1_ref_sel", base =
+ 0x30, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MQ_SYS2_PLL1_REF_SEL]	=3D imx_clk_mux("sys2_pll1_ref_sel", base =
+ 0x3c, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MQ_SYS3_PLL1_REF_SEL]	=3D imx_clk_mux("sys3_pll1_ref_sel", base =
+ 0x48, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MQ_DRAM_PLL1_REF_SEL]	=3D imx_clk_mux("dram_pll1_ref_sel", base =
+ 0x60, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MQ_VIDEO2_PLL1_REF_SEL] =3D imx_clk_mux("video2_pll1_ref_sel", b=
ase + 0x54, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
@@ -344,8 +340,8 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MQ_AUDIO_PLL2_OUT] =3D imx_clk_gate("audio_pll2_out", "audio_pll=
2_bypass", base + 0x8, 21);
 	clks[IMX8MQ_VIDEO_PLL1_OUT] =3D imx_clk_gate("video_pll1_out", "video_pll=
1_bypass", base + 0x10, 21);
=20
-	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_sccg_pll("sys1_pll_out", sys1_pll_o=
ut_sels, ARRAY_SIZE(sys1_pll_out_sels), 0, 0, 0, base + 0x30, CLK_IS_CRITIC=
AL);
-	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_sccg_pll("sys2_pll_out", sys2_pll_o=
ut_sels, ARRAY_SIZE(sys2_pll_out_sels), 0, 0, 1, base + 0x3c, CLK_IS_CRITIC=
AL);
+	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_fixed("sys1_pll_out", 800000000);
+	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_fixed("sys2_pll_out", 1000000000);
 	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_sccg_pll("sys3_pll_out", sys3_pll_o=
ut_sels, ARRAY_SIZE(sys3_pll_out_sels), 0, 0, 1, base + 0x48, CLK_IS_CRITIC=
AL);
 	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_sccg_pll("dram_pll_out", dram_pll_o=
ut_sels, ARRAY_SIZE(dram_pll_out_sels), 0, 0, 0, base + 0x60, CLK_IS_CRITIC=
AL);
 	clks[IMX8MQ_VIDEO2_PLL_OUT] =3D imx_clk_sccg_pll("video2_pll_out", video2=
_pll_out_sels, ARRAY_SIZE(video2_pll_out_sels), 0, 0, 0, base + 0x54, 0);
--=20
2.16.4

