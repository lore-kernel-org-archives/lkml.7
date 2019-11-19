Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC80C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6C12082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V9dSSzPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfKSJFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:05:17 -0500
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:44126
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727216AbfKSJFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:05:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXUjptOmuL5BGyKwr6NNBNaDRPiU6oL2wPwARJOuPjczsVy1xMCrIBAlPUwDsGS7WBXmODyUMKV4NqHEKk25/rAcN/nGug3ulpONDTASZo5orP+mDFaLXrp5GowhHjVIWudMpIpI/Zv+C88Ms2BpWNnwKxMUYPhVwpPZgR38uKr29KBWS46pHWTn46r/+tAeLQ/7xktkMcEnCRpTsMcrpXSm/Km8sKO47lqyCX94RwXhB/Clb3h4G4dt5/NvTl1dIH79HddWpQ5zHYRWYiy2T73kJjSgfj59fLFAmYWjkZnj552gJ5SuHcksXBt0txBCcnVOpmWKWA4/KX+k2dUXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMyGdnNvf0okwFPFna02XDfVU5au8Leo76RVUuybF00=;
 b=eFn2w+YmLFz6M8yr1bbasyT1zMCF04G6W7EmXBkTI43ZPYkiLBW7dxbdQmBrsQ1wgm0Z3B98R+9fApOz10drGo5OMyEISYJp0M3ufiOl36ixHIhRIGez2aWrsg3muwZcnTVl5NZaveou+kPHDtNfBFyjSac4mDgwsiDoa9Hiaq+BiLA3HsHG0PQhDRJXRESoQ1Va+WAxXIFWH6LvoIcu5IbohMgGK5RqNm/IBFBVNmu0mZjPSecOn+sME4vPD3IUkP7XM89CQzgOoIs2BbDcw3A/Ui43j4sy5tvAkY+xd3wJ3imr5EdmLs0y5UNpWfMErqFcPP67yXkW/64K4P3PWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMyGdnNvf0okwFPFna02XDfVU5au8Leo76RVUuybF00=;
 b=V9dSSzPVd5FOSzrvNocHI1EWyMRx2O8seyCxKkgydTWeNKOUa110JQCu2K0+nPY35fE4odRFJU9acMNAUKOBZWIgJH44I14E4uvyFFt+Pr9hGmH0F2lKoi0UyrJeMmi5m6+sc5+IRf+/LPcMliZcnxw55pVl9ZwxUPKF94WBUhE=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4259.eurprd04.prod.outlook.com (52.134.126.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Tue, 19 Nov 2019 09:05:00 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 09:05:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/4] clk: imx: imx8mm: Switch to clk_hw based API
Thread-Topic: [PATCH V3 3/4] clk: imx: imx8mm: Switch to clk_hw based API
Thread-Index: AQHVnrhsrNobIU1jiEaf/vLDbTQxjg==
Date:   Tue, 19 Nov 2019 09:05:00 +0000
Message-ID: <1574154146-8818-4-git-send-email-peng.fan@nxp.com>
References: <1574154146-8818-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1574154146-8818-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:203:52::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f06f3f26-39bf-402c-f510-08d76ccf8ec3
x-ms-traffictypediagnostic: AM0PR04MB4259:|AM0PR04MB4259:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4259D04EF0388F8E63473264884C0@AM0PR04MB4259.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(486006)(76176011)(54906003)(36756003)(6512007)(6486002)(52116002)(6506007)(2201001)(64756008)(66556008)(66476007)(476003)(66446008)(386003)(25786009)(50226002)(2501003)(110136005)(4326008)(2906002)(316002)(6116002)(3846002)(44832011)(8936002)(6436002)(66066001)(71190400001)(71200400001)(11346002)(446003)(99286004)(256004)(186003)(30864003)(14454004)(305945005)(86362001)(7736002)(2616005)(478600001)(5660300002)(8676002)(81166006)(81156014)(6636002)(102836004)(66946007)(26005)(32563001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4259;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kEt0seHyGHcLTowks71U93l68e4tCZYIVf+aDZ6NI2LYrfpjXSZoFWgnVPBpvDdUqG3NaewyefQUgH2BzBO8NhhEFZ+Zy+U9BIuZREenb5XH9msZCySVgi3P6rmiO9DhWSdiLIpApCGaIN0OO+q0uFoYZDEsoRsFO0374CCnJ2vF1i/1WCNGuocQKW6sSaWTGHYjOLC8nryfyYk7OwodP6B67a9L4lsbaR7gC11gHKEmfhP4+1mdMhgMtQNS7YeCzLcZiI4lGSk2QF00pMm6fMKooexbCrfQ2AulGydHeNC17NYN2Eo5Mdw7unwi4SEX97k7RpsHb//asTVE4hZzuBRZKq2znnGFyd20hsNtXo7jAT0Qo0D9zRXe0kx892Zyk3qtxERnMnwvCB6tIKjNK1CSQEcbf18arBUdCTiPUVSQ5fQoOXl8jZJ3qYKB0zSv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06f3f26-39bf-402c-f510-08d76ccf8ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 09:05:00.7880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDYOK3IuXROdhGeSMJOyRXL8y/M6b8NOqE/kG09TTiQECdCFi8zk1Odp1PdWvvm2Gqg2Y7iHglawTt1mSTnsbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Switch the entire clk-imx8mm driver to clk_hw based API.
This allows us to move closer to a clear split between
consumer and provider clk APIs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 550 ++++++++++++++++++++++-----------------=
----
 1 file changed, 282 insertions(+), 268 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 030b15d7c0ce..63bf188ad4fe 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/types.h>
=20
 #include "clk.h"
@@ -285,118 +286,127 @@ static const char *imx8mm_dram_core_sels[] =3D {"dr=
am_pll_out", "dram_alt_root", }
 static const char *imx8mm_clko1_sels[] =3D {"osc_24m", "sys_pll1_800m", "o=
sc_27m", "sys_pll1_200m", "audio_pll2_out",
 					 "vpu_pll", "sys_pll1_80m", };
=20
-static struct clk *clks[IMX8MM_CLK_END];
-static struct clk_onecell_data clk_data;
+static struct clk_hw_onecell_data *clk_hw_data;
+static struct clk_hw **clks;
=20
-static struct clk ** const uart_clks[] =3D {
-	&clks[IMX8MM_CLK_UART1_ROOT],
-	&clks[IMX8MM_CLK_UART2_ROOT],
-	&clks[IMX8MM_CLK_UART3_ROOT],
-	&clks[IMX8MM_CLK_UART4_ROOT],
-	NULL
+static const int uart_clk_ids[] =3D {
+	IMX8MM_CLK_UART1_ROOT,
+	IMX8MM_CLK_UART2_ROOT,
+	IMX8MM_CLK_UART3_ROOT,
+	IMX8MM_CLK_UART4_ROOT,
 };
=20
+static struct clk **uart_clks[ARRAY_SIZE(uart_clk_ids) + 1];
+
 static int imx8mm_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
 	struct device_node *np =3D dev->of_node;
 	void __iomem *base;
-	int ret;
+	int ret, i;
+
+	clk_hw_data =3D kzalloc(struct_size(clk_hw_data, hws,
+					  IMX8MM_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
+		return -ENOMEM;
+
+	clk_hw_data->num =3D IMX8MM_CLK_END;
+	clks =3D clk_hw_data->hws;
=20
-	clks[IMX8MM_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
-	clks[IMX8MM_CLK_24M] =3D of_clk_get_by_name(np, "osc_24m");
-	clks[IMX8MM_CLK_32K] =3D of_clk_get_by_name(np, "osc_32k");
-	clks[IMX8MM_CLK_EXT1] =3D of_clk_get_by_name(np, "clk_ext1");
-	clks[IMX8MM_CLK_EXT2] =3D of_clk_get_by_name(np, "clk_ext2");
-	clks[IMX8MM_CLK_EXT3] =3D of_clk_get_by_name(np, "clk_ext3");
-	clks[IMX8MM_CLK_EXT4] =3D of_clk_get_by_name(np, "clk_ext4");
+	clks[IMX8MM_CLK_DUMMY] =3D imx_clk_hw_fixed("dummy", 0);
+	clks[IMX8MM_CLK_24M] =3D imx_obtain_fixed_clk_hw(np, "osc_24m");
+	clks[IMX8MM_CLK_32K] =3D imx_obtain_fixed_clk_hw(np, "osc_32k");
+	clks[IMX8MM_CLK_EXT1] =3D imx_obtain_fixed_clk_hw(np, "clk_ext1");
+	clks[IMX8MM_CLK_EXT2] =3D imx_obtain_fixed_clk_hw(np, "clk_ext2");
+	clks[IMX8MM_CLK_EXT3] =3D imx_obtain_fixed_clk_hw(np, "clk_ext3");
+	clks[IMX8MM_CLK_EXT4] =3D imx_obtain_fixed_clk_hw(np, "clk_ext4");
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
 	base =3D of_iomap(np, 0);
 	if (WARN_ON(!base))
 		return -ENOMEM;
=20
-	clks[IMX8MM_AUDIO_PLL1_REF_SEL] =3D imx_clk_mux("audio_pll1_ref_sel", bas=
e + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MM_AUDIO_PLL2_REF_SEL] =3D imx_clk_mux("audio_pll2_ref_sel", bas=
e + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MM_VIDEO_PLL1_REF_SEL] =3D imx_clk_mux("video_pll1_ref_sel", bas=
e + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MM_DRAM_PLL_REF_SEL] =3D imx_clk_mux("dram_pll_ref_sel", base + =
0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MM_GPU_PLL_REF_SEL] =3D imx_clk_mux("gpu_pll_ref_sel", base + 0x=
64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MM_VPU_PLL_REF_SEL] =3D imx_clk_mux("vpu_pll_ref_sel", base + 0x=
74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MM_ARM_PLL_REF_SEL] =3D imx_clk_mux("arm_pll_ref_sel", base + 0x=
84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-	clks[IMX8MM_SYS_PLL3_REF_SEL] =3D imx_clk_mux("sys_pll3_ref_sel", base + =
0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
-
-	clks[IMX8MM_AUDIO_PLL1] =3D imx_clk_pll14xx("audio_pll1", "audio_pll1_ref=
_sel", base, &imx_1443x_pll);
-	clks[IMX8MM_AUDIO_PLL2] =3D imx_clk_pll14xx("audio_pll2", "audio_pll2_ref=
_sel", base + 0x14, &imx_1443x_pll);
-	clks[IMX8MM_VIDEO_PLL1] =3D imx_clk_pll14xx("video_pll1", "video_pll1_ref=
_sel", base + 0x28, &imx_1443x_pll);
-	clks[IMX8MM_DRAM_PLL] =3D imx_clk_pll14xx("dram_pll", "dram_pll_ref_sel",=
 base + 0x50, &imx_1443x_pll);
-	clks[IMX8MM_GPU_PLL] =3D imx_clk_pll14xx("gpu_pll", "gpu_pll_ref_sel", ba=
se + 0x64, &imx_1416x_pll);
-	clks[IMX8MM_VPU_PLL] =3D imx_clk_pll14xx("vpu_pll", "vpu_pll_ref_sel", ba=
se + 0x74, &imx_1416x_pll);
-	clks[IMX8MM_ARM_PLL] =3D imx_clk_pll14xx("arm_pll", "arm_pll_ref_sel", ba=
se + 0x84, &imx_1416x_pll);
-	clks[IMX8MM_SYS_PLL1] =3D imx_clk_fixed("sys_pll1", 800000000);
-	clks[IMX8MM_SYS_PLL2] =3D imx_clk_fixed("sys_pll2", 1000000000);
-	clks[IMX8MM_SYS_PLL3] =3D imx_clk_pll14xx("sys_pll3", "sys_pll3_ref_sel",=
 base + 0x114, &imx_1416x_pll);
+	clks[IMX8MM_AUDIO_PLL1_REF_SEL] =3D imx_clk_hw_mux("audio_pll1_ref_sel", =
base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MM_AUDIO_PLL2_REF_SEL] =3D imx_clk_hw_mux("audio_pll2_ref_sel", =
base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MM_VIDEO_PLL1_REF_SEL] =3D imx_clk_hw_mux("video_pll1_ref_sel", =
base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MM_DRAM_PLL_REF_SEL] =3D imx_clk_hw_mux("dram_pll_ref_sel", base=
 + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MM_GPU_PLL_REF_SEL] =3D imx_clk_hw_mux("gpu_pll_ref_sel", base +=
 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MM_VPU_PLL_REF_SEL] =3D imx_clk_hw_mux("vpu_pll_ref_sel", base +=
 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MM_ARM_PLL_REF_SEL] =3D imx_clk_hw_mux("arm_pll_ref_sel", base +=
 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MM_SYS_PLL3_REF_SEL] =3D imx_clk_hw_mux("sys_pll3_ref_sel", base=
 + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+
+	clks[IMX8MM_AUDIO_PLL1] =3D imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_=
ref_sel", base, &imx_1443x_pll);
+	clks[IMX8MM_AUDIO_PLL2] =3D imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_=
ref_sel", base + 0x14, &imx_1443x_pll);
+	clks[IMX8MM_VIDEO_PLL1] =3D imx_clk_hw_pll14xx("video_pll1", "video_pll1_=
ref_sel", base + 0x28, &imx_1443x_pll);
+	clks[IMX8MM_DRAM_PLL] =3D imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_se=
l", base + 0x50, &imx_1443x_pll);
+	clks[IMX8MM_GPU_PLL] =3D imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel",=
 base + 0x64, &imx_1416x_pll);
+	clks[IMX8MM_VPU_PLL] =3D imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel",=
 base + 0x74, &imx_1416x_pll);
+	clks[IMX8MM_ARM_PLL] =3D imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel",=
 base + 0x84, &imx_1416x_pll);
+	clks[IMX8MM_SYS_PLL1] =3D imx_clk_hw_fixed("sys_pll1", 800000000);
+	clks[IMX8MM_SYS_PLL2] =3D imx_clk_hw_fixed("sys_pll2", 1000000000);
+	clks[IMX8MM_SYS_PLL3] =3D imx_clk_hw_pll14xx("sys_pll3", "sys_pll3_ref_se=
l", base + 0x114, &imx_1416x_pll);
=20
 	/* PLL bypass out */
-	clks[IMX8MM_AUDIO_PLL1_BYPASS] =3D imx_clk_mux_flags("audio_pll1_bypass",=
 base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), C=
LK_SET_RATE_PARENT);
-	clks[IMX8MM_AUDIO_PLL2_BYPASS] =3D imx_clk_mux_flags("audio_pll2_bypass",=
 base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_s=
els), CLK_SET_RATE_PARENT);
-	clks[IMX8MM_VIDEO_PLL1_BYPASS] =3D imx_clk_mux_flags("video_pll1_bypass",=
 base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_s=
els), CLK_SET_RATE_PARENT);
-	clks[IMX8MM_DRAM_PLL_BYPASS] =3D imx_clk_mux_flags("dram_pll_bypass", bas=
e + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CL=
K_SET_RATE_PARENT);
-	clks[IMX8MM_GPU_PLL_BYPASS] =3D imx_clk_mux_flags("gpu_pll_bypass", base =
+ 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
-	clks[IMX8MM_VPU_PLL_BYPASS] =3D imx_clk_mux_flags("vpu_pll_bypass", base =
+ 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
-	clks[IMX8MM_ARM_PLL_BYPASS] =3D imx_clk_mux_flags("arm_pll_bypass", base =
+ 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
-	clks[IMX8MM_SYS_PLL3_BYPASS] =3D imx_clk_mux_flags("sys_pll3_bypass", bas=
e + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), C=
LK_SET_RATE_PARENT);
+	clks[IMX8MM_AUDIO_PLL1_BYPASS] =3D imx_clk_hw_mux_flags("audio_pll1_bypas=
s", base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels)=
, CLK_SET_RATE_PARENT);
+	clks[IMX8MM_AUDIO_PLL2_BYPASS] =3D imx_clk_hw_mux_flags("audio_pll2_bypas=
s", base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypas=
s_sels), CLK_SET_RATE_PARENT);
+	clks[IMX8MM_VIDEO_PLL1_BYPASS] =3D imx_clk_hw_mux_flags("video_pll1_bypas=
s", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypas=
s_sels), CLK_SET_RATE_PARENT);
+	clks[IMX8MM_DRAM_PLL_BYPASS] =3D imx_clk_hw_mux_flags("dram_pll_bypass", =
base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels),=
 CLK_SET_RATE_PARENT);
+	clks[IMX8MM_GPU_PLL_BYPASS] =3D imx_clk_hw_mux_flags("gpu_pll_bypass", ba=
se + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK=
_SET_RATE_PARENT);
+	clks[IMX8MM_VPU_PLL_BYPASS] =3D imx_clk_hw_mux_flags("vpu_pll_bypass", ba=
se + 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK=
_SET_RATE_PARENT);
+	clks[IMX8MM_ARM_PLL_BYPASS] =3D imx_clk_hw_mux_flags("arm_pll_bypass", ba=
se + 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK=
_SET_RATE_PARENT);
+	clks[IMX8MM_SYS_PLL3_BYPASS] =3D imx_clk_hw_mux_flags("sys_pll3_bypass", =
base + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels)=
, CLK_SET_RATE_PARENT);
=20
 	/* PLL out gate */
-	clks[IMX8MM_AUDIO_PLL1_OUT] =3D imx_clk_gate("audio_pll1_out", "audio_pll=
1_bypass", base, 13);
-	clks[IMX8MM_AUDIO_PLL2_OUT] =3D imx_clk_gate("audio_pll2_out", "audio_pll=
2_bypass", base + 0x14, 13);
-	clks[IMX8MM_VIDEO_PLL1_OUT] =3D imx_clk_gate("video_pll1_out", "video_pll=
1_bypass", base + 0x28, 13);
-	clks[IMX8MM_DRAM_PLL_OUT] =3D imx_clk_gate("dram_pll_out", "dram_pll_bypa=
ss", base + 0x50, 13);
-	clks[IMX8MM_GPU_PLL_OUT] =3D imx_clk_gate("gpu_pll_out", "gpu_pll_bypass"=
, base + 0x64, 11);
-	clks[IMX8MM_VPU_PLL_OUT] =3D imx_clk_gate("vpu_pll_out", "vpu_pll_bypass"=
, base + 0x74, 11);
-	clks[IMX8MM_ARM_PLL_OUT] =3D imx_clk_gate("arm_pll_out", "arm_pll_bypass"=
, base + 0x84, 11);
-	clks[IMX8MM_SYS_PLL3_OUT] =3D imx_clk_gate("sys_pll3_out", "sys_pll3_bypa=
ss", base + 0x114, 11);
+	clks[IMX8MM_AUDIO_PLL1_OUT] =3D imx_clk_hw_gate("audio_pll1_out", "audio_=
pll1_bypass", base, 13);
+	clks[IMX8MM_AUDIO_PLL2_OUT] =3D imx_clk_hw_gate("audio_pll2_out", "audio_=
pll2_bypass", base + 0x14, 13);
+	clks[IMX8MM_VIDEO_PLL1_OUT] =3D imx_clk_hw_gate("video_pll1_out", "video_=
pll1_bypass", base + 0x28, 13);
+	clks[IMX8MM_DRAM_PLL_OUT] =3D imx_clk_hw_gate("dram_pll_out", "dram_pll_b=
ypass", base + 0x50, 13);
+	clks[IMX8MM_GPU_PLL_OUT] =3D imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypa=
ss", base + 0x64, 11);
+	clks[IMX8MM_VPU_PLL_OUT] =3D imx_clk_hw_gate("vpu_pll_out", "vpu_pll_bypa=
ss", base + 0x74, 11);
+	clks[IMX8MM_ARM_PLL_OUT] =3D imx_clk_hw_gate("arm_pll_out", "arm_pll_bypa=
ss", base + 0x84, 11);
+	clks[IMX8MM_SYS_PLL3_OUT] =3D imx_clk_hw_gate("sys_pll3_out", "sys_pll3_b=
ypass", base + 0x114, 11);
=20
 	/* SYS PLL1 fixed output */
-	clks[IMX8MM_SYS_PLL1_40M_CG] =3D imx_clk_gate("sys_pll1_40m_cg", "sys_pll=
1", base + 0x94, 27);
-	clks[IMX8MM_SYS_PLL1_80M_CG] =3D imx_clk_gate("sys_pll1_80m_cg", "sys_pll=
1", base + 0x94, 25);
-	clks[IMX8MM_SYS_PLL1_100M_CG] =3D imx_clk_gate("sys_pll1_100m_cg", "sys_p=
ll1", base + 0x94, 23);
-	clks[IMX8MM_SYS_PLL1_133M_CG] =3D imx_clk_gate("sys_pll1_133m_cg", "sys_p=
ll1", base + 0x94, 21);
-	clks[IMX8MM_SYS_PLL1_160M_CG] =3D imx_clk_gate("sys_pll1_160m_cg", "sys_p=
ll1", base + 0x94, 19);
-	clks[IMX8MM_SYS_PLL1_200M_CG] =3D imx_clk_gate("sys_pll1_200m_cg", "sys_p=
ll1", base + 0x94, 17);
-	clks[IMX8MM_SYS_PLL1_266M_CG] =3D imx_clk_gate("sys_pll1_266m_cg", "sys_p=
ll1", base + 0x94, 15);
-	clks[IMX8MM_SYS_PLL1_400M_CG] =3D imx_clk_gate("sys_pll1_400m_cg", "sys_p=
ll1", base + 0x94, 13);
-	clks[IMX8MM_SYS_PLL1_OUT] =3D imx_clk_gate("sys_pll1_out", "sys_pll1", ba=
se + 0x94, 11);
-
-	clks[IMX8MM_SYS_PLL1_40M] =3D imx_clk_fixed_factor("sys_pll1_40m", "sys_p=
ll1_40m_cg", 1, 20);
-	clks[IMX8MM_SYS_PLL1_80M] =3D imx_clk_fixed_factor("sys_pll1_80m", "sys_p=
ll1_80m_cg", 1, 10);
-	clks[IMX8MM_SYS_PLL1_100M] =3D imx_clk_fixed_factor("sys_pll1_100m", "sys=
_pll1_100m_cg", 1, 8);
-	clks[IMX8MM_SYS_PLL1_133M] =3D imx_clk_fixed_factor("sys_pll1_133m", "sys=
_pll1_133m_cg", 1, 6);
-	clks[IMX8MM_SYS_PLL1_160M] =3D imx_clk_fixed_factor("sys_pll1_160m", "sys=
_pll1_160m_cg", 1, 5);
-	clks[IMX8MM_SYS_PLL1_200M] =3D imx_clk_fixed_factor("sys_pll1_200m", "sys=
_pll1_200m_cg", 1, 4);
-	clks[IMX8MM_SYS_PLL1_266M] =3D imx_clk_fixed_factor("sys_pll1_266m", "sys=
_pll1_266m_cg", 1, 3);
-	clks[IMX8MM_SYS_PLL1_400M] =3D imx_clk_fixed_factor("sys_pll1_400m", "sys=
_pll1_400m_cg", 1, 2);
-	clks[IMX8MM_SYS_PLL1_800M] =3D imx_clk_fixed_factor("sys_pll1_800m", "sys=
_pll1_out", 1, 1);
+	clks[IMX8MM_SYS_PLL1_40M_CG] =3D imx_clk_hw_gate("sys_pll1_40m_cg", "sys_=
pll1", base + 0x94, 27);
+	clks[IMX8MM_SYS_PLL1_80M_CG] =3D imx_clk_hw_gate("sys_pll1_80m_cg", "sys_=
pll1", base + 0x94, 25);
+	clks[IMX8MM_SYS_PLL1_100M_CG] =3D imx_clk_hw_gate("sys_pll1_100m_cg", "sy=
s_pll1", base + 0x94, 23);
+	clks[IMX8MM_SYS_PLL1_133M_CG] =3D imx_clk_hw_gate("sys_pll1_133m_cg", "sy=
s_pll1", base + 0x94, 21);
+	clks[IMX8MM_SYS_PLL1_160M_CG] =3D imx_clk_hw_gate("sys_pll1_160m_cg", "sy=
s_pll1", base + 0x94, 19);
+	clks[IMX8MM_SYS_PLL1_200M_CG] =3D imx_clk_hw_gate("sys_pll1_200m_cg", "sy=
s_pll1", base + 0x94, 17);
+	clks[IMX8MM_SYS_PLL1_266M_CG] =3D imx_clk_hw_gate("sys_pll1_266m_cg", "sy=
s_pll1", base + 0x94, 15);
+	clks[IMX8MM_SYS_PLL1_400M_CG] =3D imx_clk_hw_gate("sys_pll1_400m_cg", "sy=
s_pll1", base + 0x94, 13);
+	clks[IMX8MM_SYS_PLL1_OUT] =3D imx_clk_hw_gate("sys_pll1_out", "sys_pll1",=
 base + 0x94, 11);
+
+	clks[IMX8MM_SYS_PLL1_40M] =3D imx_clk_hw_fixed_factor("sys_pll1_40m", "sy=
s_pll1_40m_cg", 1, 20);
+	clks[IMX8MM_SYS_PLL1_80M] =3D imx_clk_hw_fixed_factor("sys_pll1_80m", "sy=
s_pll1_80m_cg", 1, 10);
+	clks[IMX8MM_SYS_PLL1_100M] =3D imx_clk_hw_fixed_factor("sys_pll1_100m", "=
sys_pll1_100m_cg", 1, 8);
+	clks[IMX8MM_SYS_PLL1_133M] =3D imx_clk_hw_fixed_factor("sys_pll1_133m", "=
sys_pll1_133m_cg", 1, 6);
+	clks[IMX8MM_SYS_PLL1_160M] =3D imx_clk_hw_fixed_factor("sys_pll1_160m", "=
sys_pll1_160m_cg", 1, 5);
+	clks[IMX8MM_SYS_PLL1_200M] =3D imx_clk_hw_fixed_factor("sys_pll1_200m", "=
sys_pll1_200m_cg", 1, 4);
+	clks[IMX8MM_SYS_PLL1_266M] =3D imx_clk_hw_fixed_factor("sys_pll1_266m", "=
sys_pll1_266m_cg", 1, 3);
+	clks[IMX8MM_SYS_PLL1_400M] =3D imx_clk_hw_fixed_factor("sys_pll1_400m", "=
sys_pll1_400m_cg", 1, 2);
+	clks[IMX8MM_SYS_PLL1_800M] =3D imx_clk_hw_fixed_factor("sys_pll1_800m", "=
sys_pll1_out", 1, 1);
=20
 	/* SYS PLL2 fixed output */
-	clks[IMX8MM_SYS_PLL2_50M_CG] =3D imx_clk_gate("sys_pll2_50m_cg", "sys_pll=
2", base + 0x104, 27);
-	clks[IMX8MM_SYS_PLL2_100M_CG] =3D imx_clk_gate("sys_pll2_100m_cg", "sys_p=
ll2", base + 0x104, 25);
-	clks[IMX8MM_SYS_PLL2_125M_CG] =3D imx_clk_gate("sys_pll2_125m_cg", "sys_p=
ll2", base + 0x104, 23);
-	clks[IMX8MM_SYS_PLL2_166M_CG] =3D imx_clk_gate("sys_pll2_166m_cg", "sys_p=
ll2", base + 0x104, 21);
-	clks[IMX8MM_SYS_PLL2_200M_CG] =3D imx_clk_gate("sys_pll2_200m_cg", "sys_p=
ll2", base + 0x104, 19);
-	clks[IMX8MM_SYS_PLL2_250M_CG] =3D imx_clk_gate("sys_pll2_250m_cg", "sys_p=
ll2", base + 0x104, 17);
-	clks[IMX8MM_SYS_PLL2_333M_CG] =3D imx_clk_gate("sys_pll2_333m_cg", "sys_p=
ll2", base + 0x104, 15);
-	clks[IMX8MM_SYS_PLL2_500M_CG] =3D imx_clk_gate("sys_pll2_500m_cg", "sys_p=
ll2", base + 0x104, 13);
-	clks[IMX8MM_SYS_PLL2_OUT] =3D imx_clk_gate("sys_pll2_out", "sys_pll2", ba=
se + 0x104, 11);
-
-	clks[IMX8MM_SYS_PLL2_50M] =3D imx_clk_fixed_factor("sys_pll2_50m", "sys_p=
ll2_50m_cg", 1, 20);
-	clks[IMX8MM_SYS_PLL2_100M] =3D imx_clk_fixed_factor("sys_pll2_100m", "sys=
_pll2_100m_cg", 1, 10);
-	clks[IMX8MM_SYS_PLL2_125M] =3D imx_clk_fixed_factor("sys_pll2_125m", "sys=
_pll2_125m_cg", 1, 8);
-	clks[IMX8MM_SYS_PLL2_166M] =3D imx_clk_fixed_factor("sys_pll2_166m", "sys=
_pll2_166m_cg", 1, 6);
-	clks[IMX8MM_SYS_PLL2_200M] =3D imx_clk_fixed_factor("sys_pll2_200m", "sys=
_pll2_200m_cg", 1, 5);
-	clks[IMX8MM_SYS_PLL2_250M] =3D imx_clk_fixed_factor("sys_pll2_250m", "sys=
_pll2_250m_cg", 1, 4);
-	clks[IMX8MM_SYS_PLL2_333M] =3D imx_clk_fixed_factor("sys_pll2_333m", "sys=
_pll2_333m_cg", 1, 3);
-	clks[IMX8MM_SYS_PLL2_500M] =3D imx_clk_fixed_factor("sys_pll2_500m", "sys=
_pll2_500m_cg", 1, 2);
-	clks[IMX8MM_SYS_PLL2_1000M] =3D imx_clk_fixed_factor("sys_pll2_1000m", "s=
ys_pll2_out", 1, 1);
+	clks[IMX8MM_SYS_PLL2_50M_CG] =3D imx_clk_hw_gate("sys_pll2_50m_cg", "sys_=
pll2", base + 0x104, 27);
+	clks[IMX8MM_SYS_PLL2_100M_CG] =3D imx_clk_hw_gate("sys_pll2_100m_cg", "sy=
s_pll2", base + 0x104, 25);
+	clks[IMX8MM_SYS_PLL2_125M_CG] =3D imx_clk_hw_gate("sys_pll2_125m_cg", "sy=
s_pll2", base + 0x104, 23);
+	clks[IMX8MM_SYS_PLL2_166M_CG] =3D imx_clk_hw_gate("sys_pll2_166m_cg", "sy=
s_pll2", base + 0x104, 21);
+	clks[IMX8MM_SYS_PLL2_200M_CG] =3D imx_clk_hw_gate("sys_pll2_200m_cg", "sy=
s_pll2", base + 0x104, 19);
+	clks[IMX8MM_SYS_PLL2_250M_CG] =3D imx_clk_hw_gate("sys_pll2_250m_cg", "sy=
s_pll2", base + 0x104, 17);
+	clks[IMX8MM_SYS_PLL2_333M_CG] =3D imx_clk_hw_gate("sys_pll2_333m_cg", "sy=
s_pll2", base + 0x104, 15);
+	clks[IMX8MM_SYS_PLL2_500M_CG] =3D imx_clk_hw_gate("sys_pll2_500m_cg", "sy=
s_pll2", base + 0x104, 13);
+	clks[IMX8MM_SYS_PLL2_OUT] =3D imx_clk_hw_gate("sys_pll2_out", "sys_pll2",=
 base + 0x104, 11);
+
+	clks[IMX8MM_SYS_PLL2_50M] =3D imx_clk_hw_fixed_factor("sys_pll2_50m", "sy=
s_pll2_50m_cg", 1, 20);
+	clks[IMX8MM_SYS_PLL2_100M] =3D imx_clk_hw_fixed_factor("sys_pll2_100m", "=
sys_pll2_100m_cg", 1, 10);
+	clks[IMX8MM_SYS_PLL2_125M] =3D imx_clk_hw_fixed_factor("sys_pll2_125m", "=
sys_pll2_125m_cg", 1, 8);
+	clks[IMX8MM_SYS_PLL2_166M] =3D imx_clk_hw_fixed_factor("sys_pll2_166m", "=
sys_pll2_166m_cg", 1, 6);
+	clks[IMX8MM_SYS_PLL2_200M] =3D imx_clk_hw_fixed_factor("sys_pll2_200m", "=
sys_pll2_200m_cg", 1, 5);
+	clks[IMX8MM_SYS_PLL2_250M] =3D imx_clk_hw_fixed_factor("sys_pll2_250m", "=
sys_pll2_250m_cg", 1, 4);
+	clks[IMX8MM_SYS_PLL2_333M] =3D imx_clk_hw_fixed_factor("sys_pll2_333m", "=
sys_pll2_333m_cg", 1, 3);
+	clks[IMX8MM_SYS_PLL2_500M] =3D imx_clk_hw_fixed_factor("sys_pll2_500m", "=
sys_pll2_500m_cg", 1, 2);
+	clks[IMX8MM_SYS_PLL2_1000M] =3D imx_clk_hw_fixed_factor("sys_pll2_1000m",=
 "sys_pll2_out", 1, 1);
=20
 	np =3D dev->of_node;
 	base =3D devm_platform_ioremap_resource(pdev, 0);
@@ -404,204 +414,208 @@ static int imx8mm_clocks_probe(struct platform_devi=
ce *pdev)
 		return PTR_ERR(base);
=20
 	/* Core Slice */
-	clks[IMX8MM_CLK_A53_SRC] =3D imx_clk_mux2("arm_a53_src", base + 0x8000, 2=
4, 3, imx8mm_a53_sels, ARRAY_SIZE(imx8mm_a53_sels));
-	clks[IMX8MM_CLK_M4_SRC] =3D imx_clk_mux2("arm_m4_src", base + 0x8080, 24,=
 3, imx8mm_m4_sels, ARRAY_SIZE(imx8mm_m4_sels));
-	clks[IMX8MM_CLK_VPU_SRC] =3D imx_clk_mux2("vpu_src", base + 0x8100, 24, 3=
, imx8mm_vpu_sels, ARRAY_SIZE(imx8mm_vpu_sels));
-	clks[IMX8MM_CLK_GPU3D_SRC] =3D imx_clk_mux2("gpu3d_src", base + 0x8180, 2=
4, 3,  imx8mm_gpu3d_sels, ARRAY_SIZE(imx8mm_gpu3d_sels));
-	clks[IMX8MM_CLK_GPU2D_SRC] =3D imx_clk_mux2("gpu2d_src", base + 0x8200, 2=
4, 3, imx8mm_gpu2d_sels,  ARRAY_SIZE(imx8mm_gpu2d_sels));
-	clks[IMX8MM_CLK_A53_CG] =3D imx_clk_gate3("arm_a53_cg", "arm_a53_src", ba=
se + 0x8000, 28);
-	clks[IMX8MM_CLK_M4_CG] =3D imx_clk_gate3("arm_m4_cg", "arm_m4_src", base =
+ 0x8080, 28);
-	clks[IMX8MM_CLK_VPU_CG] =3D imx_clk_gate3("vpu_cg", "vpu_src", base + 0x8=
100, 28);
-	clks[IMX8MM_CLK_GPU3D_CG] =3D imx_clk_gate3("gpu3d_cg", "gpu3d_src", base=
 + 0x8180, 28);
-	clks[IMX8MM_CLK_GPU2D_CG] =3D imx_clk_gate3("gpu2d_cg", "gpu2d_src", base=
 + 0x8200, 28);
-	clks[IMX8MM_CLK_A53_DIV] =3D imx_clk_divider2("arm_a53_div", "arm_a53_cg"=
, base + 0x8000, 0, 3);
-	clks[IMX8MM_CLK_M4_DIV] =3D imx_clk_divider2("arm_m4_div", "arm_m4_cg", b=
ase + 0x8080, 0, 3);
-	clks[IMX8MM_CLK_VPU_DIV] =3D imx_clk_divider2("vpu_div", "vpu_cg", base +=
 0x8100, 0, 3);
-	clks[IMX8MM_CLK_GPU3D_DIV] =3D imx_clk_divider2("gpu3d_div", "gpu3d_cg", =
base + 0x8180, 0, 3);
-	clks[IMX8MM_CLK_GPU2D_DIV] =3D imx_clk_divider2("gpu2d_div", "gpu2d_cg", =
base + 0x8200, 0, 3);
+	clks[IMX8MM_CLK_A53_SRC] =3D imx_clk_hw_mux2("arm_a53_src", base + 0x8000=
, 24, 3, imx8mm_a53_sels, ARRAY_SIZE(imx8mm_a53_sels));
+	clks[IMX8MM_CLK_M4_SRC] =3D imx_clk_hw_mux2("arm_m4_src", base + 0x8080, =
24, 3, imx8mm_m4_sels, ARRAY_SIZE(imx8mm_m4_sels));
+	clks[IMX8MM_CLK_VPU_SRC] =3D imx_clk_hw_mux2("vpu_src", base + 0x8100, 24=
, 3, imx8mm_vpu_sels, ARRAY_SIZE(imx8mm_vpu_sels));
+	clks[IMX8MM_CLK_GPU3D_SRC] =3D imx_clk_hw_mux2("gpu3d_src", base + 0x8180=
, 24, 3,  imx8mm_gpu3d_sels, ARRAY_SIZE(imx8mm_gpu3d_sels));
+	clks[IMX8MM_CLK_GPU2D_SRC] =3D imx_clk_hw_mux2("gpu2d_src", base + 0x8200=
, 24, 3, imx8mm_gpu2d_sels,  ARRAY_SIZE(imx8mm_gpu2d_sels));
+	clks[IMX8MM_CLK_A53_CG] =3D imx_clk_hw_gate3("arm_a53_cg", "arm_a53_src",=
 base + 0x8000, 28);
+	clks[IMX8MM_CLK_M4_CG] =3D imx_clk_hw_gate3("arm_m4_cg", "arm_m4_src", ba=
se + 0x8080, 28);
+	clks[IMX8MM_CLK_VPU_CG] =3D imx_clk_hw_gate3("vpu_cg", "vpu_src", base + =
0x8100, 28);
+	clks[IMX8MM_CLK_GPU3D_CG] =3D imx_clk_hw_gate3("gpu3d_cg", "gpu3d_src", b=
ase + 0x8180, 28);
+	clks[IMX8MM_CLK_GPU2D_CG] =3D imx_clk_hw_gate3("gpu2d_cg", "gpu2d_src", b=
ase + 0x8200, 28);
+	clks[IMX8MM_CLK_A53_DIV] =3D imx_clk_hw_divider2("arm_a53_div", "arm_a53_=
cg", base + 0x8000, 0, 3);
+	clks[IMX8MM_CLK_M4_DIV] =3D imx_clk_hw_divider2("arm_m4_div", "arm_m4_cg"=
, base + 0x8080, 0, 3);
+	clks[IMX8MM_CLK_VPU_DIV] =3D imx_clk_hw_divider2("vpu_div", "vpu_cg", bas=
e + 0x8100, 0, 3);
+	clks[IMX8MM_CLK_GPU3D_DIV] =3D imx_clk_hw_divider2("gpu3d_div", "gpu3d_cg=
", base + 0x8180, 0, 3);
+	clks[IMX8MM_CLK_GPU2D_DIV] =3D imx_clk_hw_divider2("gpu2d_div", "gpu2d_cg=
", base + 0x8200, 0, 3);
=20
 	/* BUS */
-	clks[IMX8MM_CLK_MAIN_AXI] =3D imx8m_clk_composite_critical("main_axi",  i=
mx8mm_main_axi_sels, base + 0x8800);
-	clks[IMX8MM_CLK_ENET_AXI] =3D imx8m_clk_composite("enet_axi", imx8mm_enet=
_axi_sels, base + 0x8880);
-	clks[IMX8MM_CLK_NAND_USDHC_BUS] =3D imx8m_clk_composite_critical("nand_us=
dhc_bus", imx8mm_nand_usdhc_sels, base + 0x8900);
-	clks[IMX8MM_CLK_VPU_BUS] =3D imx8m_clk_composite("vpu_bus", imx8mm_vpu_bu=
s_sels, base + 0x8980);
-	clks[IMX8MM_CLK_DISP_AXI] =3D imx8m_clk_composite("disp_axi", imx8mm_disp=
_axi_sels, base + 0x8a00);
-	clks[IMX8MM_CLK_DISP_APB] =3D imx8m_clk_composite("disp_apb", imx8mm_disp=
_apb_sels, base + 0x8a80);
-	clks[IMX8MM_CLK_DISP_RTRM] =3D imx8m_clk_composite("disp_rtrm", imx8mm_di=
sp_rtrm_sels, base + 0x8b00);
-	clks[IMX8MM_CLK_USB_BUS] =3D imx8m_clk_composite("usb_bus", imx8mm_usb_bu=
s_sels, base + 0x8b80);
-	clks[IMX8MM_CLK_GPU_AXI] =3D imx8m_clk_composite("gpu_axi", imx8mm_gpu_ax=
i_sels, base + 0x8c00);
-	clks[IMX8MM_CLK_GPU_AHB] =3D imx8m_clk_composite("gpu_ahb", imx8mm_gpu_ah=
b_sels, base + 0x8c80);
-	clks[IMX8MM_CLK_NOC] =3D imx8m_clk_composite_critical("noc", imx8mm_noc_s=
els, base + 0x8d00);
-	clks[IMX8MM_CLK_NOC_APB] =3D imx8m_clk_composite_critical("noc_apb", imx8=
mm_noc_apb_sels, base + 0x8d80);
+	clks[IMX8MM_CLK_MAIN_AXI] =3D imx8m_clk_hw_composite_critical("main_axi",=
  imx8mm_main_axi_sels, base + 0x8800);
+	clks[IMX8MM_CLK_ENET_AXI] =3D imx8m_clk_hw_composite("enet_axi", imx8mm_e=
net_axi_sels, base + 0x8880);
+	clks[IMX8MM_CLK_NAND_USDHC_BUS] =3D imx8m_clk_hw_composite_critical("nand=
_usdhc_bus", imx8mm_nand_usdhc_sels, base + 0x8900);
+	clks[IMX8MM_CLK_VPU_BUS] =3D imx8m_clk_hw_composite("vpu_bus", imx8mm_vpu=
_bus_sels, base + 0x8980);
+	clks[IMX8MM_CLK_DISP_AXI] =3D imx8m_clk_hw_composite("disp_axi", imx8mm_d=
isp_axi_sels, base + 0x8a00);
+	clks[IMX8MM_CLK_DISP_APB] =3D imx8m_clk_hw_composite("disp_apb", imx8mm_d=
isp_apb_sels, base + 0x8a80);
+	clks[IMX8MM_CLK_DISP_RTRM] =3D imx8m_clk_hw_composite("disp_rtrm", imx8mm=
_disp_rtrm_sels, base + 0x8b00);
+	clks[IMX8MM_CLK_USB_BUS] =3D imx8m_clk_hw_composite("usb_bus", imx8mm_usb=
_bus_sels, base + 0x8b80);
+	clks[IMX8MM_CLK_GPU_AXI] =3D imx8m_clk_hw_composite("gpu_axi", imx8mm_gpu=
_axi_sels, base + 0x8c00);
+	clks[IMX8MM_CLK_GPU_AHB] =3D imx8m_clk_hw_composite("gpu_ahb", imx8mm_gpu=
_ahb_sels, base + 0x8c80);
+	clks[IMX8MM_CLK_NOC] =3D imx8m_clk_hw_composite_critical("noc", imx8mm_no=
c_sels, base + 0x8d00);
+	clks[IMX8MM_CLK_NOC_APB] =3D imx8m_clk_hw_composite_critical("noc_apb", i=
mx8mm_noc_apb_sels, base + 0x8d80);
=20
 	/* AHB */
-	clks[IMX8MM_CLK_AHB] =3D imx8m_clk_composite_critical("ahb", imx8mm_ahb_s=
els, base + 0x9000);
-	clks[IMX8MM_CLK_AUDIO_AHB] =3D imx8m_clk_composite("audio_ahb", imx8mm_au=
dio_ahb_sels, base + 0x9100);
+	clks[IMX8MM_CLK_AHB] =3D imx8m_clk_hw_composite_critical("ahb", imx8mm_ah=
b_sels, base + 0x9000);
+	clks[IMX8MM_CLK_AUDIO_AHB] =3D imx8m_clk_hw_composite("audio_ahb", imx8mm=
_audio_ahb_sels, base + 0x9100);
=20
 	/* IPG */
-	clks[IMX8MM_CLK_IPG_ROOT] =3D imx_clk_divider2("ipg_root", "ahb", base + =
0x9080, 0, 1);
-	clks[IMX8MM_CLK_IPG_AUDIO_ROOT] =3D imx_clk_divider2("ipg_audio_root", "a=
udio_ahb", base + 0x9180, 0, 1);
+	clks[IMX8MM_CLK_IPG_ROOT] =3D imx_clk_hw_divider2("ipg_root", "ahb", base=
 + 0x9080, 0, 1);
+	clks[IMX8MM_CLK_IPG_AUDIO_ROOT] =3D imx_clk_hw_divider2("ipg_audio_root",=
 "audio_ahb", base + 0x9180, 0, 1);
=20
 	/* IP */
-	clks[IMX8MM_CLK_DRAM_ALT] =3D imx8m_clk_composite("dram_alt", imx8mm_dram=
_alt_sels, base + 0xa000);
-	clks[IMX8MM_CLK_DRAM_APB] =3D imx8m_clk_composite_critical("dram_apb", im=
x8mm_dram_apb_sels, base + 0xa080);
-	clks[IMX8MM_CLK_VPU_G1] =3D imx8m_clk_composite("vpu_g1", imx8mm_vpu_g1_s=
els, base + 0xa100);
-	clks[IMX8MM_CLK_VPU_G2] =3D imx8m_clk_composite("vpu_g2", imx8mm_vpu_g2_s=
els, base + 0xa180);
-	clks[IMX8MM_CLK_DISP_DTRC] =3D imx8m_clk_composite("disp_dtrc", imx8mm_di=
sp_dtrc_sels, base + 0xa200);
-	clks[IMX8MM_CLK_DISP_DC8000] =3D imx8m_clk_composite("disp_dc8000", imx8m=
m_disp_dc8000_sels, base + 0xa280);
-	clks[IMX8MM_CLK_PCIE1_CTRL] =3D imx8m_clk_composite("pcie1_ctrl", imx8mm_=
pcie1_ctrl_sels, base + 0xa300);
-	clks[IMX8MM_CLK_PCIE1_PHY] =3D imx8m_clk_composite("pcie1_phy", imx8mm_pc=
ie1_phy_sels, base + 0xa380);
-	clks[IMX8MM_CLK_PCIE1_AUX] =3D imx8m_clk_composite("pcie1_aux", imx8mm_pc=
ie1_aux_sels, base + 0xa400);
-	clks[IMX8MM_CLK_DC_PIXEL] =3D imx8m_clk_composite("dc_pixel", imx8mm_dc_p=
ixel_sels, base + 0xa480);
-	clks[IMX8MM_CLK_LCDIF_PIXEL] =3D imx8m_clk_composite("lcdif_pixel", imx8m=
m_lcdif_pixel_sels, base + 0xa500);
-	clks[IMX8MM_CLK_SAI1] =3D imx8m_clk_composite("sai1", imx8mm_sai1_sels, b=
ase + 0xa580);
-	clks[IMX8MM_CLK_SAI2] =3D imx8m_clk_composite("sai2", imx8mm_sai2_sels, b=
ase + 0xa600);
-	clks[IMX8MM_CLK_SAI3] =3D imx8m_clk_composite("sai3", imx8mm_sai3_sels, b=
ase + 0xa680);
-	clks[IMX8MM_CLK_SAI4] =3D imx8m_clk_composite("sai4", imx8mm_sai4_sels, b=
ase + 0xa700);
-	clks[IMX8MM_CLK_SAI5] =3D imx8m_clk_composite("sai5", imx8mm_sai5_sels, b=
ase + 0xa780);
-	clks[IMX8MM_CLK_SAI6] =3D imx8m_clk_composite("sai6", imx8mm_sai6_sels, b=
ase + 0xa800);
-	clks[IMX8MM_CLK_SPDIF1] =3D imx8m_clk_composite("spdif1", imx8mm_spdif1_s=
els, base + 0xa880);
-	clks[IMX8MM_CLK_SPDIF2] =3D imx8m_clk_composite("spdif2", imx8mm_spdif2_s=
els, base + 0xa900);
-	clks[IMX8MM_CLK_ENET_REF] =3D imx8m_clk_composite("enet_ref", imx8mm_enet=
_ref_sels, base + 0xa980);
-	clks[IMX8MM_CLK_ENET_TIMER] =3D imx8m_clk_composite("enet_timer", imx8mm_=
enet_timer_sels, base + 0xaa00);
-	clks[IMX8MM_CLK_ENET_PHY_REF] =3D imx8m_clk_composite("enet_phy", imx8mm_=
enet_phy_sels, base + 0xaa80);
-	clks[IMX8MM_CLK_NAND] =3D imx8m_clk_composite("nand", imx8mm_nand_sels, b=
ase + 0xab00);
-	clks[IMX8MM_CLK_QSPI] =3D imx8m_clk_composite("qspi", imx8mm_qspi_sels, b=
ase + 0xab80);
-	clks[IMX8MM_CLK_USDHC1] =3D imx8m_clk_composite("usdhc1", imx8mm_usdhc1_s=
els, base + 0xac00);
-	clks[IMX8MM_CLK_USDHC2] =3D imx8m_clk_composite("usdhc2", imx8mm_usdhc2_s=
els, base + 0xac80);
-	clks[IMX8MM_CLK_I2C1] =3D imx8m_clk_composite("i2c1", imx8mm_i2c1_sels, b=
ase + 0xad00);
-	clks[IMX8MM_CLK_I2C2] =3D imx8m_clk_composite("i2c2", imx8mm_i2c2_sels, b=
ase + 0xad80);
-	clks[IMX8MM_CLK_I2C3] =3D imx8m_clk_composite("i2c3", imx8mm_i2c3_sels, b=
ase + 0xae00);
-	clks[IMX8MM_CLK_I2C4] =3D imx8m_clk_composite("i2c4", imx8mm_i2c4_sels, b=
ase + 0xae80);
-	clks[IMX8MM_CLK_UART1] =3D imx8m_clk_composite("uart1", imx8mm_uart1_sels=
, base + 0xaf00);
-	clks[IMX8MM_CLK_UART2] =3D imx8m_clk_composite("uart2", imx8mm_uart2_sels=
, base + 0xaf80);
-	clks[IMX8MM_CLK_UART3] =3D imx8m_clk_composite("uart3", imx8mm_uart3_sels=
, base + 0xb000);
-	clks[IMX8MM_CLK_UART4] =3D imx8m_clk_composite("uart4", imx8mm_uart4_sels=
, base + 0xb080);
-	clks[IMX8MM_CLK_USB_CORE_REF] =3D imx8m_clk_composite("usb_core_ref", imx=
8mm_usb_core_sels, base + 0xb100);
-	clks[IMX8MM_CLK_USB_PHY_REF] =3D imx8m_clk_composite("usb_phy_ref", imx8m=
m_usb_phy_sels, base + 0xb180);
-	clks[IMX8MM_CLK_GIC] =3D imx8m_clk_composite_critical("gic", imx8mm_gic_s=
els, base + 0xb200);
-	clks[IMX8MM_CLK_ECSPI1] =3D imx8m_clk_composite("ecspi1", imx8mm_ecspi1_s=
els, base + 0xb280);
-	clks[IMX8MM_CLK_ECSPI2] =3D imx8m_clk_composite("ecspi2", imx8mm_ecspi2_s=
els, base + 0xb300);
-	clks[IMX8MM_CLK_PWM1] =3D imx8m_clk_composite("pwm1", imx8mm_pwm1_sels, b=
ase + 0xb380);
-	clks[IMX8MM_CLK_PWM2] =3D imx8m_clk_composite("pwm2", imx8mm_pwm2_sels, b=
ase + 0xb400);
-	clks[IMX8MM_CLK_PWM3] =3D imx8m_clk_composite("pwm3", imx8mm_pwm3_sels, b=
ase + 0xb480);
-	clks[IMX8MM_CLK_PWM4] =3D imx8m_clk_composite("pwm4", imx8mm_pwm4_sels, b=
ase + 0xb500);
-	clks[IMX8MM_CLK_GPT1] =3D imx8m_clk_composite("gpt1", imx8mm_gpt1_sels, b=
ase + 0xb580);
-	clks[IMX8MM_CLK_WDOG] =3D imx8m_clk_composite("wdog", imx8mm_wdog_sels, b=
ase + 0xb900);
-	clks[IMX8MM_CLK_WRCLK] =3D imx8m_clk_composite("wrclk", imx8mm_wrclk_sels=
, base + 0xb980);
-	clks[IMX8MM_CLK_CLKO1] =3D imx8m_clk_composite("clko1", imx8mm_clko1_sels=
, base + 0xba00);
-	clks[IMX8MM_CLK_DSI_CORE] =3D imx8m_clk_composite("dsi_core", imx8mm_dsi_=
core_sels, base + 0xbb00);
-	clks[IMX8MM_CLK_DSI_PHY_REF] =3D imx8m_clk_composite("dsi_phy_ref", imx8m=
m_dsi_phy_sels, base + 0xbb80);
-	clks[IMX8MM_CLK_DSI_DBI] =3D imx8m_clk_composite("dsi_dbi", imx8mm_dsi_db=
i_sels, base + 0xbc00);
-	clks[IMX8MM_CLK_USDHC3] =3D imx8m_clk_composite("usdhc3", imx8mm_usdhc3_s=
els, base + 0xbc80);
-	clks[IMX8MM_CLK_CSI1_CORE] =3D imx8m_clk_composite("csi1_core", imx8mm_cs=
i1_core_sels, base + 0xbd00);
-	clks[IMX8MM_CLK_CSI1_PHY_REF] =3D imx8m_clk_composite("csi1_phy_ref", imx=
8mm_csi1_phy_sels, base + 0xbd80);
-	clks[IMX8MM_CLK_CSI1_ESC] =3D imx8m_clk_composite("csi1_esc", imx8mm_csi1=
_esc_sels, base + 0xbe00);
-	clks[IMX8MM_CLK_CSI2_CORE] =3D imx8m_clk_composite("csi2_core", imx8mm_cs=
i2_core_sels, base + 0xbe80);
-	clks[IMX8MM_CLK_CSI2_PHY_REF] =3D imx8m_clk_composite("csi2_phy_ref", imx=
8mm_csi2_phy_sels, base + 0xbf00);
-	clks[IMX8MM_CLK_CSI2_ESC] =3D imx8m_clk_composite("csi2_esc", imx8mm_csi2=
_esc_sels, base + 0xbf80);
-	clks[IMX8MM_CLK_PCIE2_CTRL] =3D imx8m_clk_composite("pcie2_ctrl", imx8mm_=
pcie2_ctrl_sels, base + 0xc000);
-	clks[IMX8MM_CLK_PCIE2_PHY] =3D imx8m_clk_composite("pcie2_phy", imx8mm_pc=
ie2_phy_sels, base + 0xc080);
-	clks[IMX8MM_CLK_PCIE2_AUX] =3D imx8m_clk_composite("pcie2_aux", imx8mm_pc=
ie2_aux_sels, base + 0xc100);
-	clks[IMX8MM_CLK_ECSPI3] =3D imx8m_clk_composite("ecspi3", imx8mm_ecspi3_s=
els, base + 0xc180);
-	clks[IMX8MM_CLK_PDM] =3D imx8m_clk_composite("pdm", imx8mm_pdm_sels, base=
 + 0xc200);
-	clks[IMX8MM_CLK_VPU_H1] =3D imx8m_clk_composite("vpu_h1", imx8mm_vpu_h1_s=
els, base + 0xc280);
+	clks[IMX8MM_CLK_DRAM_ALT] =3D imx8m_clk_hw_composite("dram_alt", imx8mm_d=
ram_alt_sels, base + 0xa000);
+	clks[IMX8MM_CLK_DRAM_APB] =3D imx8m_clk_hw_composite_critical("dram_apb",=
 imx8mm_dram_apb_sels, base + 0xa080);
+	clks[IMX8MM_CLK_VPU_G1] =3D imx8m_clk_hw_composite("vpu_g1", imx8mm_vpu_g=
1_sels, base + 0xa100);
+	clks[IMX8MM_CLK_VPU_G2] =3D imx8m_clk_hw_composite("vpu_g2", imx8mm_vpu_g=
2_sels, base + 0xa180);
+	clks[IMX8MM_CLK_DISP_DTRC] =3D imx8m_clk_hw_composite("disp_dtrc", imx8mm=
_disp_dtrc_sels, base + 0xa200);
+	clks[IMX8MM_CLK_DISP_DC8000] =3D imx8m_clk_hw_composite("disp_dc8000", im=
x8mm_disp_dc8000_sels, base + 0xa280);
+	clks[IMX8MM_CLK_PCIE1_CTRL] =3D imx8m_clk_hw_composite("pcie1_ctrl", imx8=
mm_pcie1_ctrl_sels, base + 0xa300);
+	clks[IMX8MM_CLK_PCIE1_PHY] =3D imx8m_clk_hw_composite("pcie1_phy", imx8mm=
_pcie1_phy_sels, base + 0xa380);
+	clks[IMX8MM_CLK_PCIE1_AUX] =3D imx8m_clk_hw_composite("pcie1_aux", imx8mm=
_pcie1_aux_sels, base + 0xa400);
+	clks[IMX8MM_CLK_DC_PIXEL] =3D imx8m_clk_hw_composite("dc_pixel", imx8mm_d=
c_pixel_sels, base + 0xa480);
+	clks[IMX8MM_CLK_LCDIF_PIXEL] =3D imx8m_clk_hw_composite("lcdif_pixel", im=
x8mm_lcdif_pixel_sels, base + 0xa500);
+	clks[IMX8MM_CLK_SAI1] =3D imx8m_clk_hw_composite("sai1", imx8mm_sai1_sels=
, base + 0xa580);
+	clks[IMX8MM_CLK_SAI2] =3D imx8m_clk_hw_composite("sai2", imx8mm_sai2_sels=
, base + 0xa600);
+	clks[IMX8MM_CLK_SAI3] =3D imx8m_clk_hw_composite("sai3", imx8mm_sai3_sels=
, base + 0xa680);
+	clks[IMX8MM_CLK_SAI4] =3D imx8m_clk_hw_composite("sai4", imx8mm_sai4_sels=
, base + 0xa700);
+	clks[IMX8MM_CLK_SAI5] =3D imx8m_clk_hw_composite("sai5", imx8mm_sai5_sels=
, base + 0xa780);
+	clks[IMX8MM_CLK_SAI6] =3D imx8m_clk_hw_composite("sai6", imx8mm_sai6_sels=
, base + 0xa800);
+	clks[IMX8MM_CLK_SPDIF1] =3D imx8m_clk_hw_composite("spdif1", imx8mm_spdif=
1_sels, base + 0xa880);
+	clks[IMX8MM_CLK_SPDIF2] =3D imx8m_clk_hw_composite("spdif2", imx8mm_spdif=
2_sels, base + 0xa900);
+	clks[IMX8MM_CLK_ENET_REF] =3D imx8m_clk_hw_composite("enet_ref", imx8mm_e=
net_ref_sels, base + 0xa980);
+	clks[IMX8MM_CLK_ENET_TIMER] =3D imx8m_clk_hw_composite("enet_timer", imx8=
mm_enet_timer_sels, base + 0xaa00);
+	clks[IMX8MM_CLK_ENET_PHY_REF] =3D imx8m_clk_hw_composite("enet_phy", imx8=
mm_enet_phy_sels, base + 0xaa80);
+	clks[IMX8MM_CLK_NAND] =3D imx8m_clk_hw_composite("nand", imx8mm_nand_sels=
, base + 0xab00);
+	clks[IMX8MM_CLK_QSPI] =3D imx8m_clk_hw_composite("qspi", imx8mm_qspi_sels=
, base + 0xab80);
+	clks[IMX8MM_CLK_USDHC1] =3D imx8m_clk_hw_composite("usdhc1", imx8mm_usdhc=
1_sels, base + 0xac00);
+	clks[IMX8MM_CLK_USDHC2] =3D imx8m_clk_hw_composite("usdhc2", imx8mm_usdhc=
2_sels, base + 0xac80);
+	clks[IMX8MM_CLK_I2C1] =3D imx8m_clk_hw_composite("i2c1", imx8mm_i2c1_sels=
, base + 0xad00);
+	clks[IMX8MM_CLK_I2C2] =3D imx8m_clk_hw_composite("i2c2", imx8mm_i2c2_sels=
, base + 0xad80);
+	clks[IMX8MM_CLK_I2C3] =3D imx8m_clk_hw_composite("i2c3", imx8mm_i2c3_sels=
, base + 0xae00);
+	clks[IMX8MM_CLK_I2C4] =3D imx8m_clk_hw_composite("i2c4", imx8mm_i2c4_sels=
, base + 0xae80);
+	clks[IMX8MM_CLK_UART1] =3D imx8m_clk_hw_composite("uart1", imx8mm_uart1_s=
els, base + 0xaf00);
+	clks[IMX8MM_CLK_UART2] =3D imx8m_clk_hw_composite("uart2", imx8mm_uart2_s=
els, base + 0xaf80);
+	clks[IMX8MM_CLK_UART3] =3D imx8m_clk_hw_composite("uart3", imx8mm_uart3_s=
els, base + 0xb000);
+	clks[IMX8MM_CLK_UART4] =3D imx8m_clk_hw_composite("uart4", imx8mm_uart4_s=
els, base + 0xb080);
+	clks[IMX8MM_CLK_USB_CORE_REF] =3D imx8m_clk_hw_composite("usb_core_ref", =
imx8mm_usb_core_sels, base + 0xb100);
+	clks[IMX8MM_CLK_USB_PHY_REF] =3D imx8m_clk_hw_composite("usb_phy_ref", im=
x8mm_usb_phy_sels, base + 0xb180);
+	clks[IMX8MM_CLK_GIC] =3D imx8m_clk_hw_composite_critical("gic", imx8mm_gi=
c_sels, base + 0xb200);
+	clks[IMX8MM_CLK_ECSPI1] =3D imx8m_clk_hw_composite("ecspi1", imx8mm_ecspi=
1_sels, base + 0xb280);
+	clks[IMX8MM_CLK_ECSPI2] =3D imx8m_clk_hw_composite("ecspi2", imx8mm_ecspi=
2_sels, base + 0xb300);
+	clks[IMX8MM_CLK_PWM1] =3D imx8m_clk_hw_composite("pwm1", imx8mm_pwm1_sels=
, base + 0xb380);
+	clks[IMX8MM_CLK_PWM2] =3D imx8m_clk_hw_composite("pwm2", imx8mm_pwm2_sels=
, base + 0xb400);
+	clks[IMX8MM_CLK_PWM3] =3D imx8m_clk_hw_composite("pwm3", imx8mm_pwm3_sels=
, base + 0xb480);
+	clks[IMX8MM_CLK_PWM4] =3D imx8m_clk_hw_composite("pwm4", imx8mm_pwm4_sels=
, base + 0xb500);
+	clks[IMX8MM_CLK_GPT1] =3D imx8m_clk_hw_composite("gpt1", imx8mm_gpt1_sels=
, base + 0xb580);
+	clks[IMX8MM_CLK_WDOG] =3D imx8m_clk_hw_composite("wdog", imx8mm_wdog_sels=
, base + 0xb900);
+	clks[IMX8MM_CLK_WRCLK] =3D imx8m_clk_hw_composite("wrclk", imx8mm_wrclk_s=
els, base + 0xb980);
+	clks[IMX8MM_CLK_CLKO1] =3D imx8m_clk_hw_composite("clko1", imx8mm_clko1_s=
els, base + 0xba00);
+	clks[IMX8MM_CLK_DSI_CORE] =3D imx8m_clk_hw_composite("dsi_core", imx8mm_d=
si_core_sels, base + 0xbb00);
+	clks[IMX8MM_CLK_DSI_PHY_REF] =3D imx8m_clk_hw_composite("dsi_phy_ref", im=
x8mm_dsi_phy_sels, base + 0xbb80);
+	clks[IMX8MM_CLK_DSI_DBI] =3D imx8m_clk_hw_composite("dsi_dbi", imx8mm_dsi=
_dbi_sels, base + 0xbc00);
+	clks[IMX8MM_CLK_USDHC3] =3D imx8m_clk_hw_composite("usdhc3", imx8mm_usdhc=
3_sels, base + 0xbc80);
+	clks[IMX8MM_CLK_CSI1_CORE] =3D imx8m_clk_hw_composite("csi1_core", imx8mm=
_csi1_core_sels, base + 0xbd00);
+	clks[IMX8MM_CLK_CSI1_PHY_REF] =3D imx8m_clk_hw_composite("csi1_phy_ref", =
imx8mm_csi1_phy_sels, base + 0xbd80);
+	clks[IMX8MM_CLK_CSI1_ESC] =3D imx8m_clk_hw_composite("csi1_esc", imx8mm_c=
si1_esc_sels, base + 0xbe00);
+	clks[IMX8MM_CLK_CSI2_CORE] =3D imx8m_clk_hw_composite("csi2_core", imx8mm=
_csi2_core_sels, base + 0xbe80);
+	clks[IMX8MM_CLK_CSI2_PHY_REF] =3D imx8m_clk_hw_composite("csi2_phy_ref", =
imx8mm_csi2_phy_sels, base + 0xbf00);
+	clks[IMX8MM_CLK_CSI2_ESC] =3D imx8m_clk_hw_composite("csi2_esc", imx8mm_c=
si2_esc_sels, base + 0xbf80);
+	clks[IMX8MM_CLK_PCIE2_CTRL] =3D imx8m_clk_hw_composite("pcie2_ctrl", imx8=
mm_pcie2_ctrl_sels, base + 0xc000);
+	clks[IMX8MM_CLK_PCIE2_PHY] =3D imx8m_clk_hw_composite("pcie2_phy", imx8mm=
_pcie2_phy_sels, base + 0xc080);
+	clks[IMX8MM_CLK_PCIE2_AUX] =3D imx8m_clk_hw_composite("pcie2_aux", imx8mm=
_pcie2_aux_sels, base + 0xc100);
+	clks[IMX8MM_CLK_ECSPI3] =3D imx8m_clk_hw_composite("ecspi3", imx8mm_ecspi=
3_sels, base + 0xc180);
+	clks[IMX8MM_CLK_PDM] =3D imx8m_clk_hw_composite("pdm", imx8mm_pdm_sels, b=
ase + 0xc200);
+	clks[IMX8MM_CLK_VPU_H1] =3D imx8m_clk_hw_composite("vpu_h1", imx8mm_vpu_h=
1_sels, base + 0xc280);
=20
 	/* CCGR */
-	clks[IMX8MM_CLK_ECSPI1_ROOT] =3D imx_clk_gate4("ecspi1_root_clk", "ecspi1=
", base + 0x4070, 0);
-	clks[IMX8MM_CLK_ECSPI2_ROOT] =3D imx_clk_gate4("ecspi2_root_clk", "ecspi2=
", base + 0x4080, 0);
-	clks[IMX8MM_CLK_ECSPI3_ROOT] =3D imx_clk_gate4("ecspi3_root_clk", "ecspi3=
", base + 0x4090, 0);
-	clks[IMX8MM_CLK_ENET1_ROOT] =3D imx_clk_gate4("enet1_root_clk", "enet_axi=
", base + 0x40a0, 0);
-	clks[IMX8MM_CLK_GPIO1_ROOT] =3D imx_clk_gate4("gpio1_root_clk", "ipg_root=
", base + 0x40b0, 0);
-	clks[IMX8MM_CLK_GPIO2_ROOT] =3D imx_clk_gate4("gpio2_root_clk", "ipg_root=
", base + 0x40c0, 0);
-	clks[IMX8MM_CLK_GPIO3_ROOT] =3D imx_clk_gate4("gpio3_root_clk", "ipg_root=
", base + 0x40d0, 0);
-	clks[IMX8MM_CLK_GPIO4_ROOT] =3D imx_clk_gate4("gpio4_root_clk", "ipg_root=
", base + 0x40e0, 0);
-	clks[IMX8MM_CLK_GPIO5_ROOT] =3D imx_clk_gate4("gpio5_root_clk", "ipg_root=
", base + 0x40f0, 0);
-	clks[IMX8MM_CLK_GPT1_ROOT] =3D imx_clk_gate4("gpt1_root_clk", "gpt1", bas=
e + 0x4100, 0);
-	clks[IMX8MM_CLK_I2C1_ROOT] =3D imx_clk_gate4("i2c1_root_clk", "i2c1", bas=
e + 0x4170, 0);
-	clks[IMX8MM_CLK_I2C2_ROOT] =3D imx_clk_gate4("i2c2_root_clk", "i2c2", bas=
e + 0x4180, 0);
-	clks[IMX8MM_CLK_I2C3_ROOT] =3D imx_clk_gate4("i2c3_root_clk", "i2c3", bas=
e + 0x4190, 0);
-	clks[IMX8MM_CLK_I2C4_ROOT] =3D imx_clk_gate4("i2c4_root_clk", "i2c4", bas=
e + 0x41a0, 0);
-	clks[IMX8MM_CLK_MU_ROOT] =3D imx_clk_gate4("mu_root_clk", "ipg_root", bas=
e + 0x4210, 0);
-	clks[IMX8MM_CLK_OCOTP_ROOT] =3D imx_clk_gate4("ocotp_root_clk", "ipg_root=
", base + 0x4220, 0);
-	clks[IMX8MM_CLK_PCIE1_ROOT] =3D imx_clk_gate4("pcie1_root_clk", "pcie1_ct=
rl", base + 0x4250, 0);
-	clks[IMX8MM_CLK_PWM1_ROOT] =3D imx_clk_gate4("pwm1_root_clk", "pwm1", bas=
e + 0x4280, 0);
-	clks[IMX8MM_CLK_PWM2_ROOT] =3D imx_clk_gate4("pwm2_root_clk", "pwm2", bas=
e + 0x4290, 0);
-	clks[IMX8MM_CLK_PWM3_ROOT] =3D imx_clk_gate4("pwm3_root_clk", "pwm3", bas=
e + 0x42a0, 0);
-	clks[IMX8MM_CLK_PWM4_ROOT] =3D imx_clk_gate4("pwm4_root_clk", "pwm4", bas=
e + 0x42b0, 0);
-	clks[IMX8MM_CLK_QSPI_ROOT] =3D imx_clk_gate4("qspi_root_clk", "qspi", bas=
e + 0x42f0, 0);
-	clks[IMX8MM_CLK_NAND_ROOT] =3D imx_clk_gate2_shared2("nand_root_clk", "na=
nd", base + 0x4300, 0, &share_count_nand);
-	clks[IMX8MM_CLK_NAND_USDHC_BUS_RAWNAND_CLK] =3D imx_clk_gate2_shared2("na=
nd_usdhc_rawnand_clk", "nand_usdhc_bus", base + 0x4300, 0, &share_count_nan=
d);
-	clks[IMX8MM_CLK_SAI1_ROOT] =3D imx_clk_gate2_shared2("sai1_root_clk", "sa=
i1", base + 0x4330, 0, &share_count_sai1);
-	clks[IMX8MM_CLK_SAI1_IPG] =3D imx_clk_gate2_shared2("sai1_ipg_clk", "ipg_=
audio_root", base + 0x4330, 0, &share_count_sai1);
-	clks[IMX8MM_CLK_SAI2_ROOT] =3D imx_clk_gate2_shared2("sai2_root_clk", "sa=
i2", base + 0x4340, 0, &share_count_sai2);
-	clks[IMX8MM_CLK_SAI2_IPG] =3D imx_clk_gate2_shared2("sai2_ipg_clk", "ipg_=
audio_root", base + 0x4340, 0, &share_count_sai2);
-	clks[IMX8MM_CLK_SAI3_ROOT] =3D imx_clk_gate2_shared2("sai3_root_clk", "sa=
i3", base + 0x4350, 0, &share_count_sai3);
-	clks[IMX8MM_CLK_SAI3_IPG] =3D imx_clk_gate2_shared2("sai3_ipg_clk", "ipg_=
audio_root", base + 0x4350, 0, &share_count_sai3);
-	clks[IMX8MM_CLK_SAI4_ROOT] =3D imx_clk_gate2_shared2("sai4_root_clk", "sa=
i4", base + 0x4360, 0, &share_count_sai4);
-	clks[IMX8MM_CLK_SAI4_IPG] =3D imx_clk_gate2_shared2("sai4_ipg_clk", "ipg_=
audio_root", base + 0x4360, 0, &share_count_sai4);
-	clks[IMX8MM_CLK_SAI5_ROOT] =3D imx_clk_gate2_shared2("sai5_root_clk", "sa=
i5", base + 0x4370, 0, &share_count_sai5);
-	clks[IMX8MM_CLK_SAI5_IPG] =3D imx_clk_gate2_shared2("sai5_ipg_clk", "ipg_=
audio_root", base + 0x4370, 0, &share_count_sai5);
-	clks[IMX8MM_CLK_SAI6_ROOT] =3D imx_clk_gate2_shared2("sai6_root_clk", "sa=
i6", base + 0x4380, 0, &share_count_sai6);
-	clks[IMX8MM_CLK_SAI6_IPG] =3D imx_clk_gate2_shared2("sai6_ipg_clk", "ipg_=
audio_root", base + 0x4380, 0, &share_count_sai6);
-	clks[IMX8MM_CLK_SNVS_ROOT] =3D imx_clk_gate4("snvs_root_clk", "ipg_root",=
 base + 0x4470, 0);
-	clks[IMX8MM_CLK_UART1_ROOT] =3D imx_clk_gate4("uart1_root_clk", "uart1", =
base + 0x4490, 0);
-	clks[IMX8MM_CLK_UART2_ROOT] =3D imx_clk_gate4("uart2_root_clk", "uart2", =
base + 0x44a0, 0);
-	clks[IMX8MM_CLK_UART3_ROOT] =3D imx_clk_gate4("uart3_root_clk", "uart3", =
base + 0x44b0, 0);
-	clks[IMX8MM_CLK_UART4_ROOT] =3D imx_clk_gate4("uart4_root_clk", "uart4", =
base + 0x44c0, 0);
-	clks[IMX8MM_CLK_USB1_CTRL_ROOT] =3D imx_clk_gate4("usb1_ctrl_root_clk", "=
usb_bus", base + 0x44d0, 0);
-	clks[IMX8MM_CLK_GPU3D_ROOT] =3D imx_clk_gate4("gpu3d_root_clk", "gpu3d_di=
v", base + 0x44f0, 0);
-	clks[IMX8MM_CLK_USDHC1_ROOT] =3D imx_clk_gate4("usdhc1_root_clk", "usdhc1=
", base + 0x4510, 0);
-	clks[IMX8MM_CLK_USDHC2_ROOT] =3D imx_clk_gate4("usdhc2_root_clk", "usdhc2=
", base + 0x4520, 0);
-	clks[IMX8MM_CLK_WDOG1_ROOT] =3D imx_clk_gate4("wdog1_root_clk", "wdog", b=
ase + 0x4530, 0);
-	clks[IMX8MM_CLK_WDOG2_ROOT] =3D imx_clk_gate4("wdog2_root_clk", "wdog", b=
ase + 0x4540, 0);
-	clks[IMX8MM_CLK_WDOG3_ROOT] =3D imx_clk_gate4("wdog3_root_clk", "wdog", b=
ase + 0x4550, 0);
-	clks[IMX8MM_CLK_VPU_G1_ROOT] =3D imx_clk_gate4("vpu_g1_root_clk", "vpu_g1=
", base + 0x4560, 0);
-	clks[IMX8MM_CLK_GPU_BUS_ROOT] =3D imx_clk_gate4("gpu_root_clk", "gpu_axi"=
, base + 0x4570, 0);
-	clks[IMX8MM_CLK_VPU_H1_ROOT] =3D imx_clk_gate4("vpu_h1_root_clk", "vpu_h1=
", base + 0x4590, 0);
-	clks[IMX8MM_CLK_VPU_G2_ROOT] =3D imx_clk_gate4("vpu_g2_root_clk", "vpu_g2=
", base + 0x45a0, 0);
-	clks[IMX8MM_CLK_PDM_ROOT] =3D imx_clk_gate2_shared2("pdm_root_clk", "pdm"=
, base + 0x45b0, 0, &share_count_pdm);
-	clks[IMX8MM_CLK_PDM_IPG]  =3D imx_clk_gate2_shared2("pdm_ipg_clk", "ipg_a=
udio_root", base + 0x45b0, 0, &share_count_pdm);
-	clks[IMX8MM_CLK_DISP_ROOT] =3D imx_clk_gate2_shared2("disp_root_clk", "di=
sp_dc8000", base + 0x45d0, 0, &share_count_disp);
-	clks[IMX8MM_CLK_DISP_AXI_ROOT]  =3D imx_clk_gate2_shared2("disp_axi_root_=
clk", "disp_axi", base + 0x45d0, 0, &share_count_disp);
-	clks[IMX8MM_CLK_DISP_APB_ROOT]  =3D imx_clk_gate2_shared2("disp_apb_root_=
clk", "disp_apb", base + 0x45d0, 0, &share_count_disp);
-	clks[IMX8MM_CLK_DISP_RTRM_ROOT] =3D imx_clk_gate2_shared2("disp_rtrm_root=
_clk", "disp_rtrm", base + 0x45d0, 0, &share_count_disp);
-	clks[IMX8MM_CLK_USDHC3_ROOT] =3D imx_clk_gate4("usdhc3_root_clk", "usdhc3=
", base + 0x45e0, 0);
-	clks[IMX8MM_CLK_TMU_ROOT] =3D imx_clk_gate4("tmu_root_clk", "ipg_root", b=
ase + 0x4620, 0);
-	clks[IMX8MM_CLK_VPU_DEC_ROOT] =3D imx_clk_gate4("vpu_dec_root_clk", "vpu_=
bus", base + 0x4630, 0);
-	clks[IMX8MM_CLK_SDMA1_ROOT] =3D imx_clk_gate4("sdma1_clk", "ipg_root", ba=
se + 0x43a0, 0);
-	clks[IMX8MM_CLK_SDMA2_ROOT] =3D imx_clk_gate4("sdma2_clk", "ipg_audio_roo=
t", base + 0x43b0, 0);
-	clks[IMX8MM_CLK_SDMA3_ROOT] =3D imx_clk_gate4("sdma3_clk", "ipg_audio_roo=
t", base + 0x45f0, 0);
-	clks[IMX8MM_CLK_GPU2D_ROOT] =3D imx_clk_gate4("gpu2d_root_clk", "gpu2d_di=
v", base + 0x4660, 0);
-	clks[IMX8MM_CLK_CSI1_ROOT] =3D imx_clk_gate4("csi1_root_clk", "csi1_core"=
, base + 0x4650, 0);
-
-	clks[IMX8MM_CLK_GPT_3M] =3D imx_clk_fixed_factor("gpt_3m", "osc_24m", 1, =
8);
-
-	clks[IMX8MM_CLK_DRAM_ALT_ROOT] =3D imx_clk_fixed_factor("dram_alt_root", =
"dram_alt", 1, 4);
-	clks[IMX8MM_CLK_DRAM_CORE] =3D imx_clk_mux2_flags("dram_core_clk", base +=
 0x9800, 24, 1, imx8mm_dram_core_sels, ARRAY_SIZE(imx8mm_dram_core_sels), C=
LK_IS_CRITICAL);
-
-	clks[IMX8MM_CLK_ARM] =3D imx_clk_cpu("arm", "arm_a53_div",
-					   clks[IMX8MM_CLK_A53_DIV],
-					   clks[IMX8MM_CLK_A53_SRC],
-					   clks[IMX8MM_ARM_PLL_OUT],
-					   clks[IMX8MM_SYS_PLL1_800M]);
-
-	imx_check_clocks(clks, ARRAY_SIZE(clks));
-
-	clk_data.clks =3D clks;
-	clk_data.clk_num =3D ARRAY_SIZE(clks);
-	ret =3D of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+	clks[IMX8MM_CLK_ECSPI1_ROOT] =3D imx_clk_hw_gate4("ecspi1_root_clk", "ecs=
pi1", base + 0x4070, 0);
+	clks[IMX8MM_CLK_ECSPI2_ROOT] =3D imx_clk_hw_gate4("ecspi2_root_clk", "ecs=
pi2", base + 0x4080, 0);
+	clks[IMX8MM_CLK_ECSPI3_ROOT] =3D imx_clk_hw_gate4("ecspi3_root_clk", "ecs=
pi3", base + 0x4090, 0);
+	clks[IMX8MM_CLK_ENET1_ROOT] =3D imx_clk_hw_gate4("enet1_root_clk", "enet_=
axi", base + 0x40a0, 0);
+	clks[IMX8MM_CLK_GPIO1_ROOT] =3D imx_clk_hw_gate4("gpio1_root_clk", "ipg_r=
oot", base + 0x40b0, 0);
+	clks[IMX8MM_CLK_GPIO2_ROOT] =3D imx_clk_hw_gate4("gpio2_root_clk", "ipg_r=
oot", base + 0x40c0, 0);
+	clks[IMX8MM_CLK_GPIO3_ROOT] =3D imx_clk_hw_gate4("gpio3_root_clk", "ipg_r=
oot", base + 0x40d0, 0);
+	clks[IMX8MM_CLK_GPIO4_ROOT] =3D imx_clk_hw_gate4("gpio4_root_clk", "ipg_r=
oot", base + 0x40e0, 0);
+	clks[IMX8MM_CLK_GPIO5_ROOT] =3D imx_clk_hw_gate4("gpio5_root_clk", "ipg_r=
oot", base + 0x40f0, 0);
+	clks[IMX8MM_CLK_GPT1_ROOT] =3D imx_clk_hw_gate4("gpt1_root_clk", "gpt1", =
base + 0x4100, 0);
+	clks[IMX8MM_CLK_I2C1_ROOT] =3D imx_clk_hw_gate4("i2c1_root_clk", "i2c1", =
base + 0x4170, 0);
+	clks[IMX8MM_CLK_I2C2_ROOT] =3D imx_clk_hw_gate4("i2c2_root_clk", "i2c2", =
base + 0x4180, 0);
+	clks[IMX8MM_CLK_I2C3_ROOT] =3D imx_clk_hw_gate4("i2c3_root_clk", "i2c3", =
base + 0x4190, 0);
+	clks[IMX8MM_CLK_I2C4_ROOT] =3D imx_clk_hw_gate4("i2c4_root_clk", "i2c4", =
base + 0x41a0, 0);
+	clks[IMX8MM_CLK_MU_ROOT] =3D imx_clk_hw_gate4("mu_root_clk", "ipg_root", =
base + 0x4210, 0);
+	clks[IMX8MM_CLK_OCOTP_ROOT] =3D imx_clk_hw_gate4("ocotp_root_clk", "ipg_r=
oot", base + 0x4220, 0);
+	clks[IMX8MM_CLK_PCIE1_ROOT] =3D imx_clk_hw_gate4("pcie1_root_clk", "pcie1=
_ctrl", base + 0x4250, 0);
+	clks[IMX8MM_CLK_PWM1_ROOT] =3D imx_clk_hw_gate4("pwm1_root_clk", "pwm1", =
base + 0x4280, 0);
+	clks[IMX8MM_CLK_PWM2_ROOT] =3D imx_clk_hw_gate4("pwm2_root_clk", "pwm2", =
base + 0x4290, 0);
+	clks[IMX8MM_CLK_PWM3_ROOT] =3D imx_clk_hw_gate4("pwm3_root_clk", "pwm3", =
base + 0x42a0, 0);
+	clks[IMX8MM_CLK_PWM4_ROOT] =3D imx_clk_hw_gate4("pwm4_root_clk", "pwm4", =
base + 0x42b0, 0);
+	clks[IMX8MM_CLK_QSPI_ROOT] =3D imx_clk_hw_gate4("qspi_root_clk", "qspi", =
base + 0x42f0, 0);
+	clks[IMX8MM_CLK_NAND_ROOT] =3D imx_clk_hw_gate2_shared2("nand_root_clk", =
"nand", base + 0x4300, 0, &share_count_nand);
+	clks[IMX8MM_CLK_NAND_USDHC_BUS_RAWNAND_CLK] =3D imx_clk_hw_gate2_shared2(=
"nand_usdhc_rawnand_clk", "nand_usdhc_bus", base + 0x4300, 0, &share_count_=
nand);
+	clks[IMX8MM_CLK_SAI1_ROOT] =3D imx_clk_hw_gate2_shared2("sai1_root_clk", =
"sai1", base + 0x4330, 0, &share_count_sai1);
+	clks[IMX8MM_CLK_SAI1_IPG] =3D imx_clk_hw_gate2_shared2("sai1_ipg_clk", "i=
pg_audio_root", base + 0x4330, 0, &share_count_sai1);
+	clks[IMX8MM_CLK_SAI2_ROOT] =3D imx_clk_hw_gate2_shared2("sai2_root_clk", =
"sai2", base + 0x4340, 0, &share_count_sai2);
+	clks[IMX8MM_CLK_SAI2_IPG] =3D imx_clk_hw_gate2_shared2("sai2_ipg_clk", "i=
pg_audio_root", base + 0x4340, 0, &share_count_sai2);
+	clks[IMX8MM_CLK_SAI3_ROOT] =3D imx_clk_hw_gate2_shared2("sai3_root_clk", =
"sai3", base + 0x4350, 0, &share_count_sai3);
+	clks[IMX8MM_CLK_SAI3_IPG] =3D imx_clk_hw_gate2_shared2("sai3_ipg_clk", "i=
pg_audio_root", base + 0x4350, 0, &share_count_sai3);
+	clks[IMX8MM_CLK_SAI4_ROOT] =3D imx_clk_hw_gate2_shared2("sai4_root_clk", =
"sai4", base + 0x4360, 0, &share_count_sai4);
+	clks[IMX8MM_CLK_SAI4_IPG] =3D imx_clk_hw_gate2_shared2("sai4_ipg_clk", "i=
pg_audio_root", base + 0x4360, 0, &share_count_sai4);
+	clks[IMX8MM_CLK_SAI5_ROOT] =3D imx_clk_hw_gate2_shared2("sai5_root_clk", =
"sai5", base + 0x4370, 0, &share_count_sai5);
+	clks[IMX8MM_CLK_SAI5_IPG] =3D imx_clk_hw_gate2_shared2("sai5_ipg_clk", "i=
pg_audio_root", base + 0x4370, 0, &share_count_sai5);
+	clks[IMX8MM_CLK_SAI6_ROOT] =3D imx_clk_hw_gate2_shared2("sai6_root_clk", =
"sai6", base + 0x4380, 0, &share_count_sai6);
+	clks[IMX8MM_CLK_SAI6_IPG] =3D imx_clk_hw_gate2_shared2("sai6_ipg_clk", "i=
pg_audio_root", base + 0x4380, 0, &share_count_sai6);
+	clks[IMX8MM_CLK_SNVS_ROOT] =3D imx_clk_hw_gate4("snvs_root_clk", "ipg_roo=
t", base + 0x4470, 0);
+	clks[IMX8MM_CLK_UART1_ROOT] =3D imx_clk_hw_gate4("uart1_root_clk", "uart1=
", base + 0x4490, 0);
+	clks[IMX8MM_CLK_UART2_ROOT] =3D imx_clk_hw_gate4("uart2_root_clk", "uart2=
", base + 0x44a0, 0);
+	clks[IMX8MM_CLK_UART3_ROOT] =3D imx_clk_hw_gate4("uart3_root_clk", "uart3=
", base + 0x44b0, 0);
+	clks[IMX8MM_CLK_UART4_ROOT] =3D imx_clk_hw_gate4("uart4_root_clk", "uart4=
", base + 0x44c0, 0);
+	clks[IMX8MM_CLK_USB1_CTRL_ROOT] =3D imx_clk_hw_gate4("usb1_ctrl_root_clk"=
, "usb_bus", base + 0x44d0, 0);
+	clks[IMX8MM_CLK_GPU3D_ROOT] =3D imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d=
_div", base + 0x44f0, 0);
+	clks[IMX8MM_CLK_USDHC1_ROOT] =3D imx_clk_hw_gate4("usdhc1_root_clk", "usd=
hc1", base + 0x4510, 0);
+	clks[IMX8MM_CLK_USDHC2_ROOT] =3D imx_clk_hw_gate4("usdhc2_root_clk", "usd=
hc2", base + 0x4520, 0);
+	clks[IMX8MM_CLK_WDOG1_ROOT] =3D imx_clk_hw_gate4("wdog1_root_clk", "wdog"=
, base + 0x4530, 0);
+	clks[IMX8MM_CLK_WDOG2_ROOT] =3D imx_clk_hw_gate4("wdog2_root_clk", "wdog"=
, base + 0x4540, 0);
+	clks[IMX8MM_CLK_WDOG3_ROOT] =3D imx_clk_hw_gate4("wdog3_root_clk", "wdog"=
, base + 0x4550, 0);
+	clks[IMX8MM_CLK_VPU_G1_ROOT] =3D imx_clk_hw_gate4("vpu_g1_root_clk", "vpu=
_g1", base + 0x4560, 0);
+	clks[IMX8MM_CLK_GPU_BUS_ROOT] =3D imx_clk_hw_gate4("gpu_root_clk", "gpu_a=
xi", base + 0x4570, 0);
+	clks[IMX8MM_CLK_VPU_H1_ROOT] =3D imx_clk_hw_gate4("vpu_h1_root_clk", "vpu=
_h1", base + 0x4590, 0);
+	clks[IMX8MM_CLK_VPU_G2_ROOT] =3D imx_clk_hw_gate4("vpu_g2_root_clk", "vpu=
_g2", base + 0x45a0, 0);
+	clks[IMX8MM_CLK_PDM_ROOT] =3D imx_clk_hw_gate2_shared2("pdm_root_clk", "p=
dm", base + 0x45b0, 0, &share_count_pdm);
+	clks[IMX8MM_CLK_PDM_IPG]  =3D imx_clk_hw_gate2_shared2("pdm_ipg_clk", "ip=
g_audio_root", base + 0x45b0, 0, &share_count_pdm);
+	clks[IMX8MM_CLK_DISP_ROOT] =3D imx_clk_hw_gate2_shared2("disp_root_clk", =
"disp_dc8000", base + 0x45d0, 0, &share_count_disp);
+	clks[IMX8MM_CLK_DISP_AXI_ROOT]  =3D imx_clk_hw_gate2_shared2("disp_axi_ro=
ot_clk", "disp_axi", base + 0x45d0, 0, &share_count_disp);
+	clks[IMX8MM_CLK_DISP_APB_ROOT]  =3D imx_clk_hw_gate2_shared2("disp_apb_ro=
ot_clk", "disp_apb", base + 0x45d0, 0, &share_count_disp);
+	clks[IMX8MM_CLK_DISP_RTRM_ROOT] =3D imx_clk_hw_gate2_shared2("disp_rtrm_r=
oot_clk", "disp_rtrm", base + 0x45d0, 0, &share_count_disp);
+	clks[IMX8MM_CLK_USDHC3_ROOT] =3D imx_clk_hw_gate4("usdhc3_root_clk", "usd=
hc3", base + 0x45e0, 0);
+	clks[IMX8MM_CLK_TMU_ROOT] =3D imx_clk_hw_gate4("tmu_root_clk", "ipg_root"=
, base + 0x4620, 0);
+	clks[IMX8MM_CLK_VPU_DEC_ROOT] =3D imx_clk_hw_gate4("vpu_dec_root_clk", "v=
pu_bus", base + 0x4630, 0);
+	clks[IMX8MM_CLK_SDMA1_ROOT] =3D imx_clk_hw_gate4("sdma1_clk", "ipg_root",=
 base + 0x43a0, 0);
+	clks[IMX8MM_CLK_SDMA2_ROOT] =3D imx_clk_hw_gate4("sdma2_clk", "ipg_audio_=
root", base + 0x43b0, 0);
+	clks[IMX8MM_CLK_SDMA3_ROOT] =3D imx_clk_hw_gate4("sdma3_clk", "ipg_audio_=
root", base + 0x45f0, 0);
+	clks[IMX8MM_CLK_GPU2D_ROOT] =3D imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d=
_div", base + 0x4660, 0);
+	clks[IMX8MM_CLK_CSI1_ROOT] =3D imx_clk_hw_gate4("csi1_root_clk", "csi1_co=
re", base + 0x4650, 0);
+
+	clks[IMX8MM_CLK_GPT_3M] =3D imx_clk_hw_fixed_factor("gpt_3m", "osc_24m", =
1, 8);
+
+	clks[IMX8MM_CLK_DRAM_ALT_ROOT] =3D imx_clk_hw_fixed_factor("dram_alt_root=
", "dram_alt", 1, 4);
+	clks[IMX8MM_CLK_DRAM_CORE] =3D imx_clk_hw_mux2_flags("dram_core_clk", bas=
e + 0x9800, 24, 1, imx8mm_dram_core_sels, ARRAY_SIZE(imx8mm_dram_core_sels)=
, CLK_IS_CRITICAL);
+
+	clks[IMX8MM_CLK_ARM] =3D imx_clk_hw_cpu("arm", "arm_a53_div",
+					      clks[IMX8MM_CLK_A53_DIV]->clk,
+					      clks[IMX8MM_CLK_A53_SRC]->clk,
+					      clks[IMX8MM_ARM_PLL_OUT]->clk,
+					      clks[IMX8MM_SYS_PLL1_800M]->clk);
+
+	imx_check_clk_hws(clks, IMX8MM_CLK_END);
+
+	ret =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 	if (ret < 0) {
-		pr_err("failed to register clks for i.MX8MM\n");
+		dev_err(dev, "failed to register clks for i.MX8MM\n");
 		goto unregister_clks;
 	}
=20
+	for (i =3D 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
+		int index =3D uart_clk_ids[i];
+
+		uart_clks[i] =3D &clks[index]->clk;
+	}
+
 	imx_register_uart_clocks(uart_clks);
=20
 	return 0;
=20
 unregister_clks:
-	imx_unregister_clocks(clks, ARRAY_SIZE(clks));
+	imx_unregister_hw_clocks(clks, IMX8MM_CLK_END);
=20
 	return ret;
 }
--=20
2.16.4

