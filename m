Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B73C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7A5216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfGIOUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:20:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45194 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfGIOUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:20:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 228EC1A05E2;
        Tue,  9 Jul 2019 16:20:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 15F7A1A05DF;
        Tue,  9 Jul 2019 16:20:13 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 89D9220630;
        Tue,  9 Jul 2019 16:20:12 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2] clk: imx8mm: Switch to platform driver
Date:   Tue,  9 Jul 2019 17:20:03 +0300
Message-Id: <1562682003-20951-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no strong reason for this to use CLK_OF_DECLARE instead
of being a platform driver. Plus, this will now be aligned with the
other i.MX8M clock drivers which are platform drivers.

In order to make the clock provider a platform driver
all the data and code needs to be outside of .init section.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v1:
 * Switched to platform driver memory mapping API
 * Removed extra newline
 * Added an explanation of why this change is done
   in the commit message

 drivers/clk/imx/clk-imx8mm.c | 57 ++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 6b8e75d..7a8e713 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -68,43 +68,43 @@ static const struct imx_pll14xx_rate_table imx8mm_drampll_tbl[] = {
 	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
 };
 
-static struct imx_pll14xx_clk imx8mm_audio_pll __initdata = {
+static struct imx_pll14xx_clk imx8mm_audio_pll = {
 		.type = PLL_1443X,
 		.rate_table = imx8mm_audiopll_tbl,
 		.rate_count = ARRAY_SIZE(imx8mm_audiopll_tbl),
 };
 
-static struct imx_pll14xx_clk imx8mm_video_pll __initdata = {
+static struct imx_pll14xx_clk imx8mm_video_pll = {
 		.type = PLL_1443X,
 		.rate_table = imx8mm_videopll_tbl,
 		.rate_count = ARRAY_SIZE(imx8mm_videopll_tbl),
 };
 
-static struct imx_pll14xx_clk imx8mm_dram_pll __initdata = {
+static struct imx_pll14xx_clk imx8mm_dram_pll = {
 		.type = PLL_1443X,
 		.rate_table = imx8mm_drampll_tbl,
 		.rate_count = ARRAY_SIZE(imx8mm_drampll_tbl),
 };
 
-static struct imx_pll14xx_clk imx8mm_arm_pll __initdata = {
+static struct imx_pll14xx_clk imx8mm_arm_pll = {
 		.type = PLL_1416X,
 		.rate_table = imx8mm_pll1416x_tbl,
 		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
 };
 
-static struct imx_pll14xx_clk imx8mm_gpu_pll __initdata = {
+static struct imx_pll14xx_clk imx8mm_gpu_pll = {
 		.type = PLL_1416X,
 		.rate_table = imx8mm_pll1416x_tbl,
 		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
 };
 
-static struct imx_pll14xx_clk imx8mm_vpu_pll __initdata = {
+static struct imx_pll14xx_clk imx8mm_vpu_pll = {
 		.type = PLL_1416X,
 		.rate_table = imx8mm_pll1416x_tbl,
 		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
 };
 
-static struct imx_pll14xx_clk imx8mm_sys_pll __initdata = {
+static struct imx_pll14xx_clk imx8mm_sys_pll = {
 		.type = PLL_1416X,
 		.rate_table = imx8mm_pll1416x_tbl,
 		.rate_count = ARRAY_SIZE(imx8mm_pll1416x_tbl),
@@ -374,7 +374,7 @@ static const char *imx8mm_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "osc_27m",
 static struct clk *clks[IMX8MM_CLK_END];
 static struct clk_onecell_data clk_data;
 
-static struct clk ** const uart_clks[] __initconst = {
+static struct clk ** const uart_clks[] = {
 	&clks[IMX8MM_CLK_UART1_ROOT],
 	&clks[IMX8MM_CLK_UART2_ROOT],
 	&clks[IMX8MM_CLK_UART3_ROOT],
@@ -382,19 +382,20 @@ static struct clk ** const uart_clks[] __initconst = {
 	NULL
 };
 
-static int __init imx8mm_clocks_init(struct device_node *ccm_node)
+static int imx8mm_clocks_probe(struct platform_device *pdev)
 {
-	struct device_node *np;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	void __iomem *base;
 	int ret;
 
 	clks[IMX8MM_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
-	clks[IMX8MM_CLK_24M] = of_clk_get_by_name(ccm_node, "osc_24m");
-	clks[IMX8MM_CLK_32K] = of_clk_get_by_name(ccm_node, "osc_32k");
-	clks[IMX8MM_CLK_EXT1] = of_clk_get_by_name(ccm_node, "clk_ext1");
-	clks[IMX8MM_CLK_EXT2] = of_clk_get_by_name(ccm_node, "clk_ext2");
-	clks[IMX8MM_CLK_EXT3] = of_clk_get_by_name(ccm_node, "clk_ext3");
-	clks[IMX8MM_CLK_EXT4] = of_clk_get_by_name(ccm_node, "clk_ext4");
+	clks[IMX8MM_CLK_24M] = of_clk_get_by_name(np, "osc_24m");
+	clks[IMX8MM_CLK_32K] = of_clk_get_by_name(np, "osc_32k");
+	clks[IMX8MM_CLK_EXT1] = of_clk_get_by_name(np, "clk_ext1");
+	clks[IMX8MM_CLK_EXT2] = of_clk_get_by_name(np, "clk_ext2");
+	clks[IMX8MM_CLK_EXT3] = of_clk_get_by_name(np, "clk_ext3");
+	clks[IMX8MM_CLK_EXT4] = of_clk_get_by_name(np, "clk_ext4");
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
 	base = of_iomap(np, 0);
@@ -480,10 +481,10 @@ static int __init imx8mm_clocks_init(struct device_node *ccm_node)
 	clks[IMX8MM_SYS_PLL2_500M] = imx_clk_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2);
 	clks[IMX8MM_SYS_PLL2_1000M] = imx_clk_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
 
-	np = ccm_node;
-	base = of_iomap(np, 0);
-	if (WARN_ON(!base))
-		return -ENOMEM;
+	np = dev->of_node;
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (WARN_ON(IS_ERR(base)))
+		return PTR_ERR(base);
 
 	/* Core Slice */
 	clks[IMX8MM_CLK_A53_SRC] = imx_clk_mux2("arm_a53_src", base + 0x8000, 24, 3, imx8mm_a53_sels, ARRAY_SIZE(imx8mm_a53_sels));
@@ -682,4 +683,18 @@ static int __init imx8mm_clocks_init(struct device_node *ccm_node)
 
 	return 0;
 }
-CLK_OF_DECLARE_DRIVER(imx8mm, "fsl,imx8mm-ccm", imx8mm_clocks_init);
+
+static const struct of_device_id imx8mm_clk_of_match[] = {
+	{ .compatible = "fsl,imx8mm-ccm" },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx8mm_clk_of_match);
+
+static struct platform_driver imx8mm_clk_driver = {
+	.probe = imx8mm_clocks_probe,
+	.driver = {
+		.name = "imx8mm-ccm",
+		.of_match_table = of_match_ptr(imx8mm_clk_of_match),
+	},
+};
+module_platform_driver(imx8mm_clk_driver);
-- 
2.7.4

