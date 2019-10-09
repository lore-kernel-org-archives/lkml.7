Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DA7C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87AB21721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KF+3/wip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfJIJ6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:58:20 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:42751
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbfJIJ6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:58:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7aBDtWXa2byhqRAYxd0GyuUg90TIXFMbJIJU2WsNkttTdGnwLnsYr83ndFAM7zFL48DgvcSIGXsL4+U7qXj1hTWaf0COPHC+dFQUjpcH2LNiYMRef68nwXjd8vr0LMmZvBVKXCNpdPFdE6xVBF7qfmCFmLh4i5Q5JBCJNUhPGQFJ1JI2vOVbeEIadbkd5IynbVuUpX951mCZfha9FUNVMzg2Et1v9LVi8ebg7+qxKV0ICSBnafyFJ9zIVZWvvMaVxiBnIbqzLbfFgV/QBK1oxPpMYYpyCCNO9dvm0DxbDb4sF/wSSY2TMTn50KgiRkkFmpxkcvoZGTptbIXGTHQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNmzcr8h+Dq14in4E/+/TuCB5UrxIML6sZiCudY2ohk=;
 b=Rwq7vJR0beCX2Djv/wu9GbrxWO4VVk3IfluXDknf9gzoukdppiOQ8gJotFdyQSFdz/ZDvo8n38C4jX/Fap/+5TcxYy2YQftNrllP8XAgB7zvqqLRAYk0VCyItfL3kxLSgwKHZjBP92z8K7zHecr7Mz1T3JVIcA+IZukDRKWqnICIa/jyPsxXEz4DXVTKWLdkLY2CvK8g5s0B02zuthlH8+pn18bagOcP5Uu17mC4nXbG2++/NpL+707EGixqR3X5TgTwVVwHA/w2aOXM6g1AzhFogY4SWv8973DmRh+t4t19TM8eSkOqSmyZJFoh9m5VbbCI6NJZb6XhcHtuaOIlvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNmzcr8h+Dq14in4E/+/TuCB5UrxIML6sZiCudY2ohk=;
 b=KF+3/wiphDrtw5iE9JhFEGnyC7jfP1lEg+S3WQ3gsmyhu4K1LHO8KZ/jqOkTbQnAuT2NcMKXk1oJvwS1dep+/uiLCzSwfQrX/ffCOHBtohrFEFI3RY/WFr84Bd92jKuRc2FnJKTHOICQi7QDwo6oa4OfuvhMGHXBrwW/tEs8U1w=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4177.eurprd04.prod.outlook.com (52.134.92.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 09:58:15 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 09:58:15 +0000
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
Subject: [PATCH 1/3] clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
Thread-Topic: [PATCH 1/3] clk: imx: imx8mm: mark sys_pll1/2 as fixed clock
Thread-Index: AQHVfogREXMSqkErfE+B9jsiOEYyjg==
Date:   Wed, 9 Oct 2019 09:58:14 +0000
Message-ID: <1570614940-17239-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::19) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7358983f-3931-4223-1bb2-08d74c9f3395
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR04MB4177:|AM0PR04MB4177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB41778850B19CEDDD702D5EDC88950@AM0PR04MB4177.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(476003)(64756008)(478600001)(8676002)(14454004)(81166006)(81156014)(4326008)(5660300002)(66556008)(2906002)(36756003)(66446008)(66476007)(256004)(3846002)(186003)(66946007)(486006)(26005)(6116002)(6486002)(2616005)(305945005)(25786009)(7736002)(316002)(110136005)(66066001)(54906003)(2201001)(6436002)(52116002)(99286004)(6512007)(44832011)(50226002)(102836004)(71190400001)(71200400001)(8936002)(2501003)(86362001)(386003)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4177;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qVoZZG9qfb0pC7AlSFNfPd5nLEQoDd6UHTuroCOC60N7AMzdXtZfdJuJHP9ldveoYg4BhmzUYSqxS8w4W+kR8m2BB25wdWtVxqrtSJTSYt7Uy/qs+MC5U6u6K3C9EqjRWoF9EG3xTFKeiTPf6DH75hmtBjKBG3DISjd7r2xJMo2IoNautdX1CBiFabPS3FfMmIm3VFiWk1efaeEjmTwL30WKSGL6KLxXCFOishdJ/fyMsBW9AQZMHb9i4rZ0UONeAVKK+djsukLK6NWoRYh2HwymOahh8iIHywphMd2OR7D7eQnWzrEPfgeFseiyI4Zo1eF410bH2FkT4k5f/HXgvwy5zm7vnF3LAPoWkzn+BV9KdnVRgjEAo5H70jfy86gjTC8Uv5GO8e927psUIpESBkPSD+3ZwXpkjcVa3LfMJ4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7358983f-3931-4223-1bb2-08d74c9f3395
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 09:58:14.8763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0zcoTYdvTYkivrYuDz9eDlTFfI48PZLPNRX6WXcQLGkuRJuwblg7YMu8x2bfXlMlgXJcVGEe+NzNKiFwH80oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According Architecture definition guide, SYS_PLL1 is fixed at
800MHz, SYS_PLL2 is fixed at 1000MHz, so let's use imx_clk_fixed
to register the clocks and drop code that could change the rate.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 04876ec66127..ae7321ab7837 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -34,8 +34,6 @@ static const char *dram_pll_bypass_sels[] =3D {"dram_pll"=
, "dram_pll_ref_sel", };
 static const char *gpu_pll_bypass_sels[] =3D {"gpu_pll", "gpu_pll_ref_sel"=
, };
 static const char *vpu_pll_bypass_sels[] =3D {"vpu_pll", "vpu_pll_ref_sel"=
, };
 static const char *arm_pll_bypass_sels[] =3D {"arm_pll", "arm_pll_ref_sel"=
, };
-static const char *sys_pll1_bypass_sels[] =3D {"sys_pll1", "sys_pll1_ref_s=
el", };
-static const char *sys_pll2_bypass_sels[] =3D {"sys_pll2", "sys_pll2_ref_s=
el", };
 static const char *sys_pll3_bypass_sels[] =3D {"sys_pll3", "sys_pll3_ref_s=
el", };
=20
 /* CCM ROOT */
@@ -325,8 +323,6 @@ static int imx8mm_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MM_GPU_PLL_REF_SEL] =3D imx_clk_mux("gpu_pll_ref_sel", base + 0x=
64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MM_VPU_PLL_REF_SEL] =3D imx_clk_mux("vpu_pll_ref_sel", base + 0x=
74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MM_ARM_PLL_REF_SEL] =3D imx_clk_mux("arm_pll_ref_sel", base + 0x=
84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MM_SYS_PLL1_REF_SEL] =3D imx_clk_mux("sys_pll1_ref_sel", base + =
0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MM_SYS_PLL2_REF_SEL] =3D imx_clk_mux("sys_pll2_ref_sel", base + =
0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MM_SYS_PLL3_REF_SEL] =3D imx_clk_mux("sys_pll3_ref_sel", base + =
0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
=20
 	clks[IMX8MM_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1", "audio_pll1_ref=
_sel", base, &imx_1443x_pll);
@@ -336,8 +332,8 @@ static int imx8mm_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MM_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", ba=
se + 0x64, &imx_1416x_pll);
 	clks[IMX8MM_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", ba=
se + 0x74, &imx_1416x_pll);
 	clks[IMX8MM_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", ba=
se + 0x84, &imx_1416x_pll);
-	clks[IMX8MM_SYS_PLL1] =3D imx_clk_pll14xx("sys_pll1", "sys_pll1_ref_sel",=
 base + 0x94, &imx_1416x_pll);
-	clks[IMX8MM_SYS_PLL2] =3D imx_clk_pll14xx("sys_pll2", "sys_pll2_ref_sel",=
 base + 0x104, &imx_1416x_pll);
+	clks[IMX8MM_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);
+	clks[IMX8MM_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000);
 	clks[IMX8MM_SYS_PLL3] =3D imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel",=
 base + 0x114, &imx_1416x_pll);
=20
 	/* PLL bypass out */
@@ -348,8 +344,6 @@ static int imx8mm_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MM_GPU_PLL_BYPASS] =3D imx_clk_mux_flags("gpu_pll_bypass", base =
+ 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
 	clks[IMX8MM_VPU_PLL_BYPASS] =3D imx_clk_mux_flags("vpu_pll_bypass", base =
+ 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
 	clks[IMX8MM_ARM_PLL_BYPASS] =3D imx_clk_mux_flags("arm_pll_bypass", base =
+ 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
-	clks[IMX8MM_SYS_PLL1_BYPASS] =3D imx_clk_mux_flags("sys_pll1_bypass", bas=
e + 0x94, 28, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CL=
K_SET_RATE_PARENT);
-	clks[IMX8MM_SYS_PLL2_BYPASS] =3D imx_clk_mux_flags("sys_pll2_bypass", bas=
e + 0x104, 28, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), C=
LK_SET_RATE_PARENT);
 	clks[IMX8MM_SYS_PLL3_BYPASS] =3D imx_clk_mux_flags("sys_pll3_bypass", bas=
e + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), C=
LK_SET_RATE_PARENT);
=20
 	/* PLL out gate */
@@ -360,8 +354,8 @@ static int imx8mm_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MM_GPU_PLL_OUT] =3D imx_clk_gate("gpu_pll_out", "gpu_pll_bypass"=
, base + 0x64, 11);
 	clks[IMX8MM_VPU_PLL_OUT] =3D imx_clk_gate("vpu_pll_out", "vpu_pll_bypass"=
, base + 0x74, 11);
 	clks[IMX8MM_ARM_PLL_OUT] =3D imx_clk_gate("arm_pll_out", "arm_pll_bypass"=
, base + 0x84, 11);
-	clks[IMX8MM_SYS_PLL1_OUT] =3D imx_clk_gate("sys_pll1_out", "sys_pll1_bypa=
ss", base + 0x94, 11);
-	clks[IMX8MM_SYS_PLL2_OUT] =3D imx_clk_gate("sys_pll2_out", "sys_pll2_bypa=
ss", base + 0x104, 11);
+	clks[IMX8MM_SYS_PLL1_OUT] =3D imx_clk_gate("sys_pll1_out", "sys_pll1", ba=
se + 0x94, 11);
+	clks[IMX8MM_SYS_PLL2_OUT] =3D imx_clk_gate("sys_pll2_out", "sys_pll2", ba=
se + 0x104, 11);
 	clks[IMX8MM_SYS_PLL3_OUT] =3D imx_clk_gate("sys_pll3_out", "sys_pll3_bypa=
ss", base + 0x114, 11);
=20
 	/* SYS PLL fixed output */
--=20
2.16.4

