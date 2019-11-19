Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C39C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A3C222A5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UHUl/RQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfKSGvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:51:17 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10825 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfKSGvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:51:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd390dd0003>; Mon, 18 Nov 2019 22:51:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 22:51:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 22:51:07 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 06:51:06 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 Nov 2019 06:51:06 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.254]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd390d90000>; Mon, 18 Nov 2019 22:51:06 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 10/17] clk: tegra: Remove tegra_pmc_clk_init along with clk ids
Date:   Mon, 18 Nov 2019 22:50:27 -0800
Message-ID: <1574146234-3871-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574146270; bh=rBiP7uD3h3EG53q/znPVnCV4T+UpUuXCuIvSqGDsx94=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=UHUl/RQcETS4SNAxoKxNyDMRGmWid/I25CtUAXCAxtgFt07mwrjfJwSs/0kNh8UYG
         PHPpVE5rBhdCjqumBVE1K8eIXUcPAC4ZEjsAlIB5tY2pgpkaHDnODrzHfP39LKgVSF
         gzTXek8NO8FB6yTb5Q0jGWoztYMTVg82oVQQN/OGnmHLV496mxEcwZIxXHnPcZGe0q
         LlychYBAIXBpWT4tcj5VtUTI/2vjmjzSxy/hxHGXv5LknbPxPBraByjRuPO0YYmNQy
         PlKLutH4IxBUjdobx3x7tXBsEOfmjNb8CxNqBWQRxc2z4kQ3XB+OI9jjsR8OE+rUWX
         kpKq+y39vM1ug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current Tegra clock driver registers PMC clocks clk_out_1, clk_out_2,
clk_out_3 and blink output in tegra_pmc_init() which does direct Tegra
PMC access during clk_ops and these PMC register read and write access
will not happen when PMC is in secure mode.

Any direct PMC register access from non-secure world will not go
through and all the PMC clocks and blink control are done in Tegra PMC
driver with PMC as clock provider.

This patch removes tegra_pmc_clk_init along with corresponding clk ids
from Tegra clock driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/Makefile       |  1 -
 drivers/clk/tegra/clk-id.h       |  7 -------
 drivers/clk/tegra/clk-tegra114.c | 33 ------------------------------
 drivers/clk/tegra/clk-tegra124.c | 44 +++++-----------------------------------
 drivers/clk/tegra/clk-tegra20.c  | 24 ----------------------
 drivers/clk/tegra/clk-tegra210.c | 32 -----------------------------
 drivers/clk/tegra/clk-tegra30.c  | 32 -----------------------------
 drivers/clk/tegra/clk.h          |  1 -
 8 files changed, 5 insertions(+), 169 deletions(-)

diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index df966ca06788..1f7c30f87ece 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -12,7 +12,6 @@ obj-y					+= clk-sdmmc-mux.o
 obj-y					+= clk-super.o
 obj-y					+= clk-tegra-audio.o
 obj-y					+= clk-tegra-periph.o
-obj-y					+= clk-tegra-pmc.o
 obj-y					+= clk-tegra-fixed.o
 obj-y					+= clk-tegra-super-gen4.o
 obj-$(CONFIG_TEGRA_CLK_EMC)		+= clk-emc.o
diff --git a/drivers/clk/tegra/clk-id.h b/drivers/clk/tegra/clk-id.h
index c4faebd32760..5913357a8000 100644
--- a/drivers/clk/tegra/clk-id.h
+++ b/drivers/clk/tegra/clk-id.h
@@ -32,7 +32,6 @@ enum clk_id {
 	tegra_clk_audio4,
 	tegra_clk_audio4_2x,
 	tegra_clk_audio4_mux,
-	tegra_clk_blink,
 	tegra_clk_bsea,
 	tegra_clk_bsev,
 	tegra_clk_cclk_g,
@@ -46,12 +45,6 @@ enum clk_id {
 	tegra_clk_clk_m,
 	tegra_clk_clk_m_div2,
 	tegra_clk_clk_m_div4,
-	tegra_clk_clk_out_1,
-	tegra_clk_clk_out_1_mux,
-	tegra_clk_clk_out_2,
-	tegra_clk_clk_out_2_mux,
-	tegra_clk_clk_out_3,
-	tegra_clk_clk_out_3_mux,
 	tegra_clk_cml0,
 	tegra_clk_cml1,
 	tegra_clk_csi,
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index e7c4af928da3..e125c1c50b3a 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -124,7 +124,6 @@ static struct cpu_clk_suspend_context {
 #endif
 
 static void __iomem *clk_base;
-static void __iomem *pmc_base;
 
 static DEFINE_SPINLOCK(pll_d_lock);
 static DEFINE_SPINLOCK(pll_d2_lock);
@@ -769,10 +768,6 @@ static struct tegra_clk tegra114_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_audio3] = { .dt_id = TEGRA114_CLK_AUDIO3, .present = true },
 	[tegra_clk_audio4] = { .dt_id = TEGRA114_CLK_AUDIO4, .present = true },
 	[tegra_clk_spdif] = { .dt_id = TEGRA114_CLK_SPDIF, .present = true },
-	[tegra_clk_clk_out_1] = { .dt_id = TEGRA114_CLK_CLK_OUT_1, .present = true },
-	[tegra_clk_clk_out_2] = { .dt_id = TEGRA114_CLK_CLK_OUT_2, .present = true },
-	[tegra_clk_clk_out_3] = { .dt_id = TEGRA114_CLK_CLK_OUT_3, .present = true },
-	[tegra_clk_blink] = { .dt_id = TEGRA114_CLK_BLINK, .present = true },
 	[tegra_clk_xusb_host_src] = { .dt_id = TEGRA114_CLK_XUSB_HOST_SRC, .present = true },
 	[tegra_clk_xusb_falcon_src] = { .dt_id = TEGRA114_CLK_XUSB_FALCON_SRC, .present = true },
 	[tegra_clk_xusb_fs_src] = { .dt_id = TEGRA114_CLK_XUSB_FS_SRC, .present = true },
@@ -794,9 +789,6 @@ static struct tegra_clk tegra114_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_audio3_mux] = { .dt_id = TEGRA114_CLK_AUDIO3_MUX, .present = true },
 	[tegra_clk_audio4_mux] = { .dt_id = TEGRA114_CLK_AUDIO4_MUX, .present = true },
 	[tegra_clk_spdif_mux] = { .dt_id = TEGRA114_CLK_SPDIF_MUX, .present = true },
-	[tegra_clk_clk_out_1_mux] = { .dt_id = TEGRA114_CLK_CLK_OUT_1_MUX, .present = true },
-	[tegra_clk_clk_out_2_mux] = { .dt_id = TEGRA114_CLK_CLK_OUT_2_MUX, .present = true },
-	[tegra_clk_clk_out_3_mux] = { .dt_id = TEGRA114_CLK_CLK_OUT_3_MUX, .present = true },
 	[tegra_clk_dsia_mux] = { .dt_id = TEGRA114_CLK_DSIA_MUX, .present = true },
 	[tegra_clk_dsib_mux] = { .dt_id = TEGRA114_CLK_DSIB_MUX, .present = true },
 	[tegra_clk_cec] = { .dt_id = TEGRA114_CLK_CEC, .present = true },
@@ -857,7 +849,6 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "extern1", .dev_id = "clk_out_1", .dt_id = TEGRA114_CLK_EXTERN1 },
 	{ .con_id = "extern2", .dev_id = "clk_out_2", .dt_id = TEGRA114_CLK_EXTERN2 },
 	{ .con_id = "extern3", .dev_id = "clk_out_3", .dt_id = TEGRA114_CLK_EXTERN3 },
-	{ .con_id = "blink", .dt_id = TEGRA114_CLK_BLINK },
 	{ .con_id = "cclk_g", .dt_id = TEGRA114_CLK_CCLK_G },
 	{ .con_id = "cclk_lp", .dt_id = TEGRA114_CLK_CCLK_LP },
 	{ .con_id = "sclk", .dt_id = TEGRA114_CLK_SCLK },
@@ -1127,11 +1118,6 @@ static struct tegra_cpu_car_ops tegra114_cpu_car_ops = {
 #endif
 };
 
-static const struct of_device_id pmc_match[] __initconst = {
-	{ .compatible = "nvidia,tegra114-pmc" },
-	{ },
-};
-
 /*
  * dfll_soc/dfll_ref apparently must be kept enabled, otherwise I2C5
  * breaks
@@ -1144,8 +1130,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA114_CLK_PLL_A, TEGRA114_CLK_CLK_MAX, 564480000, 1 },
 	{ TEGRA114_CLK_PLL_A_OUT0, TEGRA114_CLK_CLK_MAX, 11289600, 1 },
 	{ TEGRA114_CLK_EXTERN1, TEGRA114_CLK_PLL_A_OUT0, 0, 1 },
-	{ TEGRA114_CLK_CLK_OUT_1_MUX, TEGRA114_CLK_EXTERN1, 0, 1 },
-	{ TEGRA114_CLK_CLK_OUT_1, TEGRA114_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA114_CLK_I2S0, TEGRA114_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA114_CLK_I2S1, TEGRA114_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA114_CLK_I2S2, TEGRA114_CLK_PLL_A_OUT0, 11289600, 0 },
@@ -1309,28 +1293,12 @@ EXPORT_SYMBOL(tegra114_clock_deassert_dfll_dvco_reset);
 
 static void __init tegra114_clock_init(struct device_node *np)
 {
-	struct device_node *node;
-
 	clk_base = of_iomap(np, 0);
 	if (!clk_base) {
 		pr_err("ioremap tegra114 CAR failed\n");
 		return;
 	}
 
-	node = of_find_matching_node(NULL, pmc_match);
-	if (!node) {
-		pr_err("Failed to find pmc node\n");
-		WARN_ON(1);
-		return;
-	}
-
-	pmc_base = of_iomap(node, 0);
-	if (!pmc_base) {
-		pr_err("Can't map pmc registers\n");
-		WARN_ON(1);
-		return;
-	}
-
 	clks = tegra_clk_init(clk_base, TEGRA114_CLK_CLK_MAX,
 				TEGRA114_CLK_PERIPH_BANKS);
 	if (!clks)
@@ -1346,7 +1314,6 @@ static void __init tegra114_clock_init(struct device_node *np)
 	tegra114_periph_clk_init(clk_base);
 	tegra_audio_clk_init(clk_base, tegra114_clks, tegra114_audio_plls,
 			     ARRAY_SIZE(tegra114_audio_plls), 24000000);
-	tegra_pmc_clk_init(pmc_base, tegra114_clks);
 	tegra_super_clk_gen4_init(clk_base, tegra114_clks, &pll_x_params);
 
 	tegra_add_of_provider(np, of_clk_src_onecell_get);
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 0b7532857a58..ff2ec0dcdefa 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -114,7 +114,6 @@ static struct cpu_clk_suspend_context {
 #endif
 
 static void __iomem *clk_base;
-static void __iomem *pmc_base;
 
 static unsigned long osc_freq;
 static unsigned long pll_ref_freq;
@@ -894,10 +893,6 @@ static struct tegra_clk tegra124_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_audio3] = { .dt_id = TEGRA124_CLK_AUDIO3, .present = true },
 	[tegra_clk_audio4] = { .dt_id = TEGRA124_CLK_AUDIO4, .present = true },
 	[tegra_clk_spdif] = { .dt_id = TEGRA124_CLK_SPDIF, .present = true },
-	[tegra_clk_clk_out_1] = { .dt_id = TEGRA124_CLK_CLK_OUT_1, .present = true },
-	[tegra_clk_clk_out_2] = { .dt_id = TEGRA124_CLK_CLK_OUT_2, .present = true },
-	[tegra_clk_clk_out_3] = { .dt_id = TEGRA124_CLK_CLK_OUT_3, .present = true },
-	[tegra_clk_blink] = { .dt_id = TEGRA124_CLK_BLINK, .present = true },
 	[tegra_clk_xusb_host_src] = { .dt_id = TEGRA124_CLK_XUSB_HOST_SRC, .present = true },
 	[tegra_clk_xusb_falcon_src] = { .dt_id = TEGRA124_CLK_XUSB_FALCON_SRC, .present = true },
 	[tegra_clk_xusb_fs_src] = { .dt_id = TEGRA124_CLK_XUSB_FS_SRC, .present = true },
@@ -923,9 +918,6 @@ static struct tegra_clk tegra124_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_audio3_mux] = { .dt_id = TEGRA124_CLK_AUDIO3_MUX, .present = true },
 	[tegra_clk_audio4_mux] = { .dt_id = TEGRA124_CLK_AUDIO4_MUX, .present = true },
 	[tegra_clk_spdif_mux] = { .dt_id = TEGRA124_CLK_SPDIF_MUX, .present = true },
-	[tegra_clk_clk_out_1_mux] = { .dt_id = TEGRA124_CLK_CLK_OUT_1_MUX, .present = true },
-	[tegra_clk_clk_out_2_mux] = { .dt_id = TEGRA124_CLK_CLK_OUT_2_MUX, .present = true },
-	[tegra_clk_clk_out_3_mux] = { .dt_id = TEGRA124_CLK_CLK_OUT_3_MUX, .present = true },
 	[tegra_clk_cec] = { .dt_id = TEGRA124_CLK_CEC, .present = true },
 };
 
@@ -983,7 +975,6 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "extern1", .dev_id = "clk_out_1", .dt_id = TEGRA124_CLK_EXTERN1 },
 	{ .con_id = "extern2", .dev_id = "clk_out_2", .dt_id = TEGRA124_CLK_EXTERN2 },
 	{ .con_id = "extern3", .dev_id = "clk_out_3", .dt_id = TEGRA124_CLK_EXTERN3 },
-	{ .con_id = "blink", .dt_id = TEGRA124_CLK_BLINK },
 	{ .con_id = "cclk_g", .dt_id = TEGRA124_CLK_CCLK_G },
 	{ .con_id = "cclk_lp", .dt_id = TEGRA124_CLK_CCLK_LP },
 	{ .con_id = "sclk", .dt_id = TEGRA124_CLK_SCLK },
@@ -1278,11 +1269,6 @@ static struct tegra_cpu_car_ops tegra124_cpu_car_ops = {
 #endif
 };
 
-static const struct of_device_id pmc_match[] __initconst = {
-	{ .compatible = "nvidia,tegra124-pmc" },
-	{ },
-};
-
 static struct tegra_clk_init_table common_init_table[] __initdata = {
 	{ TEGRA124_CLK_UARTA, TEGRA124_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA124_CLK_UARTB, TEGRA124_CLK_PLL_P, 408000000, 0 },
@@ -1291,8 +1277,6 @@ static struct tegra_clk_init_table common_init_table[] __initdata = {
 	{ TEGRA124_CLK_PLL_A, TEGRA124_CLK_CLK_MAX, 564480000, 1 },
 	{ TEGRA124_CLK_PLL_A_OUT0, TEGRA124_CLK_CLK_MAX, 11289600, 1 },
 	{ TEGRA124_CLK_EXTERN1, TEGRA124_CLK_PLL_A_OUT0, 0, 1 },
-	{ TEGRA124_CLK_CLK_OUT_1_MUX, TEGRA124_CLK_EXTERN1, 0, 1 },
-	{ TEGRA124_CLK_CLK_OUT_1, TEGRA124_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA124_CLK_I2S0, TEGRA124_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA124_CLK_I2S1, TEGRA124_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA124_CLK_I2S2, TEGRA124_CLK_PLL_A_OUT0, 11289600, 0 },
@@ -1447,15 +1431,12 @@ static void __init tegra132_clock_apply_init_table(void)
  * tegra124_132_clock_init_pre - clock initialization preamble for T124/T132
  * @np: struct device_node * of the DT node for the SoC CAR IP block
  *
- * Register most of the clocks controlled by the CAR IP block, along
- * with a few clocks controlled by the PMC IP block.  Everything in
- * this function should be common to Tegra124 and Tegra132.  XXX The
- * PMC clock initialization should probably be moved to PMC-specific
- * driver code.  No return value.
+ * Register most of the clocks controlled by the CAR IP block.
+ * Everything in this function should be common to Tegra124 and Tegra132.
+ * No return value.
  */
 static void __init tegra124_132_clock_init_pre(struct device_node *np)
 {
-	struct device_node *node;
 	u32 plld_base;
 
 	clk_base = of_iomap(np, 0);
@@ -1464,20 +1445,6 @@ static void __init tegra124_132_clock_init_pre(struct device_node *np)
 		return;
 	}
 
-	node = of_find_matching_node(NULL, pmc_match);
-	if (!node) {
-		pr_err("Failed to find pmc node\n");
-		WARN_ON(1);
-		return;
-	}
-
-	pmc_base = of_iomap(node, 0);
-	if (!pmc_base) {
-		pr_err("Can't map pmc registers\n");
-		WARN_ON(1);
-		return;
-	}
-
 	clks = tegra_clk_init(clk_base, TEGRA124_CLK_CLK_MAX,
 			      TEGRA124_CAR_BANK_COUNT);
 	if (!clks)
@@ -1493,7 +1460,6 @@ static void __init tegra124_132_clock_init_pre(struct device_node *np)
 	tegra124_periph_clk_init(clk_base);
 	tegra_audio_clk_init(clk_base, tegra124_clks, tegra124_audio_plls,
 			     ARRAY_SIZE(tegra124_audio_plls), 24576000);
-	tegra_pmc_clk_init(pmc_base, tegra124_clks);
 
 	/* For Tegra124 & Tegra132, PLLD is the only source for DSIA & DSIB */
 	plld_base = readl(clk_base + PLLD_BASE);
@@ -1505,8 +1471,8 @@ static void __init tegra124_132_clock_init_pre(struct device_node *np)
  * tegra124_132_clock_init_post - clock initialization postamble for T124/T132
  * @np: struct device_node * of the DT node for the SoC CAR IP block
  *
- * Register most of the along with a few clocks controlled by the PMC
- * IP block.  Everything in this function should be common to Tegra124
+ * Register most of the clocks controlled by the CAR IP block.
+ * Everything in this function should be common to Tegra124
  * and Tegra132.  This function must be called after
  * tegra124_132_clock_init_pre(), otherwise clk_base will not be set.
  * No return value.
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 5cf33c99976d..585ceabd1ea7 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -128,7 +128,6 @@ static struct cpu_clk_suspend_context {
 #endif
 
 static void __iomem *clk_base;
-static void __iomem *pmc_base;
 
 #define TEGRA_INIT_DATA_MUX(_name, _parents, _offset,	\
 			    _clk_num, _gate_flags, _clk_id)	\
@@ -458,7 +457,6 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "cdev1", .dt_id = TEGRA20_CLK_CDEV1 },
 	{ .con_id = "cdev2", .dt_id = TEGRA20_CLK_CDEV2 },
 	{ .con_id = "clk_32k", .dt_id = TEGRA20_CLK_CLK_32K },
-	{ .con_id = "blink", .dt_id = TEGRA20_CLK_BLINK },
 	{ .con_id = "clk_m", .dt_id = TEGRA20_CLK_CLK_M },
 	{ .con_id = "pll_ref", .dt_id = TEGRA20_CLK_PLL_REF },
 	{ .dev_id = "tegra20-i2s.0", .dt_id = TEGRA20_CLK_I2S1 },
@@ -537,7 +535,6 @@ static struct tegra_clk tegra20_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_csi] = { .dt_id = TEGRA20_CLK_CSI, .present = true },
 	[tegra_clk_isp] = { .dt_id = TEGRA20_CLK_ISP, .present = true },
 	[tegra_clk_clk_32k] = { .dt_id = TEGRA20_CLK_CLK_32K, .present = true },
-	[tegra_clk_blink] = { .dt_id = TEGRA20_CLK_BLINK, .present = true },
 	[tegra_clk_hclk] = { .dt_id = TEGRA20_CLK_HCLK, .present = true },
 	[tegra_clk_pclk] = { .dt_id = TEGRA20_CLK_PCLK, .present = true },
 	[tegra_clk_pll_p_out1] = { .dt_id = TEGRA20_CLK_PLL_P_OUT1, .present = true },
@@ -1034,7 +1031,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA20_CLK_PLL_A, TEGRA20_CLK_CLK_MAX, 56448000, 1 },
 	{ TEGRA20_CLK_PLL_A_OUT0, TEGRA20_CLK_CLK_MAX, 11289600, 1 },
 	{ TEGRA20_CLK_CDEV1, TEGRA20_CLK_CLK_MAX, 0, 1 },
-	{ TEGRA20_CLK_BLINK, TEGRA20_CLK_CLK_MAX, 32768, 1 },
 	{ TEGRA20_CLK_I2S1, TEGRA20_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA20_CLK_I2S2, TEGRA20_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA20_CLK_SDMMC1, TEGRA20_CLK_PLL_P, 48000000, 0 },
@@ -1074,11 +1070,6 @@ static struct tegra_clk_duplicate tegra_clk_duplicates[] = {
 	TEGRA_CLK_DUPLICATE(TEGRA20_CLK_CLK_MAX, NULL,            NULL),
 };
 
-static const struct of_device_id pmc_match[] __initconst = {
-	{ .compatible = "nvidia,tegra20-pmc" },
-	{ },
-};
-
 static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
 					       void *data)
 {
@@ -1116,26 +1107,12 @@ static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
 
 static void __init tegra20_clock_init(struct device_node *np)
 {
-	struct device_node *node;
-
 	clk_base = of_iomap(np, 0);
 	if (!clk_base) {
 		pr_err("Can't map CAR registers\n");
 		BUG();
 	}
 
-	node = of_find_matching_node(NULL, pmc_match);
-	if (!node) {
-		pr_err("Failed to find pmc node\n");
-		BUG();
-	}
-
-	pmc_base = of_iomap(node, 0);
-	if (!pmc_base) {
-		pr_err("Can't map pmc registers\n");
-		BUG();
-	}
-
 	clks = tegra_clk_init(clk_base, TEGRA20_CLK_CLK_MAX,
 				TEGRA20_CLK_PERIPH_BANKS);
 	if (!clks)
@@ -1148,7 +1125,6 @@ static void __init tegra20_clock_init(struct device_node *np)
 	tegra_super_clk_gen4_init(clk_base, tegra20_clks, NULL);
 	tegra20_periph_clk_init();
 	tegra20_audio_clk_init();
-	tegra_pmc_clk_init(pmc_base, tegra20_clks);
 
 	tegra_init_dup_clks(tegra_clk_duplicates, clks, TEGRA20_CLK_CLK_MAX);
 
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 86d0b847be0d..71f29cf8d13e 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -288,7 +288,6 @@ struct tegra210_domain_mbist_war {
 static struct clk **clks;
 
 static void __iomem *clk_base;
-static void __iomem *pmc_base;
 static void __iomem *ahub_base;
 static void __iomem *dispa_base;
 static void __iomem *vic_base;
@@ -2409,10 +2408,6 @@ static struct tegra_clk tegra210_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_audio3] = { .dt_id = TEGRA210_CLK_AUDIO3, .present = true },
 	[tegra_clk_audio4] = { .dt_id = TEGRA210_CLK_AUDIO4, .present = true },
 	[tegra_clk_spdif] = { .dt_id = TEGRA210_CLK_SPDIF, .present = true },
-	[tegra_clk_clk_out_1] = { .dt_id = TEGRA210_CLK_CLK_OUT_1, .present = true },
-	[tegra_clk_clk_out_2] = { .dt_id = TEGRA210_CLK_CLK_OUT_2, .present = true },
-	[tegra_clk_clk_out_3] = { .dt_id = TEGRA210_CLK_CLK_OUT_3, .present = true },
-	[tegra_clk_blink] = { .dt_id = TEGRA210_CLK_BLINK, .present = true },
 	[tegra_clk_xusb_gate] = { .dt_id = TEGRA210_CLK_XUSB_GATE, .present = true },
 	[tegra_clk_xusb_host_src_8] = { .dt_id = TEGRA210_CLK_XUSB_HOST_SRC, .present = true },
 	[tegra_clk_xusb_falcon_src_8] = { .dt_id = TEGRA210_CLK_XUSB_FALCON_SRC, .present = true },
@@ -2444,9 +2439,6 @@ static struct tegra_clk tegra210_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_audio3_mux] = { .dt_id = TEGRA210_CLK_AUDIO3_MUX, .present = true },
 	[tegra_clk_audio4_mux] = { .dt_id = TEGRA210_CLK_AUDIO4_MUX, .present = true },
 	[tegra_clk_spdif_mux] = { .dt_id = TEGRA210_CLK_SPDIF_MUX, .present = true },
-	[tegra_clk_clk_out_1_mux] = { .dt_id = TEGRA210_CLK_CLK_OUT_1_MUX, .present = true },
-	[tegra_clk_clk_out_2_mux] = { .dt_id = TEGRA210_CLK_CLK_OUT_2_MUX, .present = true },
-	[tegra_clk_clk_out_3_mux] = { .dt_id = TEGRA210_CLK_CLK_OUT_3_MUX, .present = true },
 	[tegra_clk_maud] = { .dt_id = TEGRA210_CLK_MAUD, .present = true },
 	[tegra_clk_mipibif] = { .dt_id = TEGRA210_CLK_MIPIBIF, .present = true },
 	[tegra_clk_qspi] = { .dt_id = TEGRA210_CLK_QSPI, .present = true },
@@ -2535,7 +2527,6 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "extern1", .dev_id = "clk_out_1", .dt_id = TEGRA210_CLK_EXTERN1 },
 	{ .con_id = "extern2", .dev_id = "clk_out_2", .dt_id = TEGRA210_CLK_EXTERN2 },
 	{ .con_id = "extern3", .dev_id = "clk_out_3", .dt_id = TEGRA210_CLK_EXTERN3 },
-	{ .con_id = "blink", .dt_id = TEGRA210_CLK_BLINK },
 	{ .con_id = "cclk_g", .dt_id = TEGRA210_CLK_CCLK_G },
 	{ .con_id = "cclk_lp", .dt_id = TEGRA210_CLK_CCLK_LP },
 	{ .con_id = "sclk", .dt_id = TEGRA210_CLK_SCLK },
@@ -3428,11 +3419,6 @@ static struct tegra_cpu_car_ops tegra210_cpu_car_ops = {
 #endif
 };
 
-static const struct of_device_id pmc_match[] __initconst = {
-	{ .compatible = "nvidia,tegra210-pmc" },
-	{ },
-};
-
 static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA210_CLK_UARTA, TEGRA210_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA210_CLK_UARTB, TEGRA210_CLK_PLL_P, 408000000, 0 },
@@ -3441,8 +3427,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA210_CLK_PLL_A, TEGRA210_CLK_CLK_MAX, 564480000, 1 },
 	{ TEGRA210_CLK_PLL_A_OUT0, TEGRA210_CLK_CLK_MAX, 11289600, 1 },
 	{ TEGRA210_CLK_EXTERN1, TEGRA210_CLK_PLL_A_OUT0, 0, 1 },
-	{ TEGRA210_CLK_CLK_OUT_1_MUX, TEGRA210_CLK_EXTERN1, 0, 1 },
-	{ TEGRA210_CLK_CLK_OUT_1, TEGRA210_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA210_CLK_I2S0, TEGRA210_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA210_CLK_I2S1, TEGRA210_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA210_CLK_I2S2, TEGRA210_CLK_PLL_A_OUT0, 11289600, 0 },
@@ -3623,7 +3607,6 @@ static void tegra210_mbist_clk_init(void)
  */
 static void __init tegra210_clock_init(struct device_node *np)
 {
-	struct device_node *node;
 	u32 value, clk_m_div;
 
 	clk_base = of_iomap(np, 0);
@@ -3632,20 +3615,6 @@ static void __init tegra210_clock_init(struct device_node *np)
 		return;
 	}
 
-	node = of_find_matching_node(NULL, pmc_match);
-	if (!node) {
-		pr_err("Failed to find pmc node\n");
-		WARN_ON(1);
-		return;
-	}
-
-	pmc_base = of_iomap(node, 0);
-	if (!pmc_base) {
-		pr_err("Can't map pmc registers\n");
-		WARN_ON(1);
-		return;
-	}
-
 	ahub_base = ioremap(TEGRA210_AHUB_BASE, SZ_64K);
 	if (!ahub_base) {
 		pr_err("ioremap tegra210 APE failed\n");
@@ -3682,7 +3651,6 @@ static void __init tegra210_clock_init(struct device_node *np)
 	tegra210_periph_clk_init(clk_base);
 	tegra_audio_clk_init(clk_base, tegra210_clks, tegra210_audio_plls,
 			     ARRAY_SIZE(tegra210_audio_plls), 24576000);
-	tegra_pmc_clk_init(pmc_base, tegra210_clks);
 
 	/* For Tegra210, PLLD is the only source for DSIA & DSIB */
 	value = readl(clk_base + PLLD_BASE);
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index d65e7edf0cfd..02a8c21ac52c 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -143,7 +143,6 @@ static struct cpu_clk_suspend_context {
 #endif
 
 static void __iomem *clk_base;
-static void __iomem *pmc_base;
 static unsigned long input_freq;
 
 static DEFINE_SPINLOCK(cml_lock);
@@ -564,7 +563,6 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "extern1", .dev_id = "clk_out_1", .dt_id = TEGRA30_CLK_EXTERN1 },
 	{ .con_id = "extern2", .dev_id = "clk_out_2", .dt_id = TEGRA30_CLK_EXTERN2 },
 	{ .con_id = "extern3", .dev_id = "clk_out_3", .dt_id = TEGRA30_CLK_EXTERN3 },
-	{ .con_id = "blink", .dt_id = TEGRA30_CLK_BLINK },
 	{ .con_id = "cclk_g", .dt_id = TEGRA30_CLK_CCLK_G },
 	{ .con_id = "cclk_lp", .dt_id = TEGRA30_CLK_CCLK_LP },
 	{ .con_id = "sclk", .dt_id = TEGRA30_CLK_SCLK },
@@ -703,13 +701,6 @@ static struct tegra_clk tegra30_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_audio3_2x] = { .dt_id = TEGRA30_CLK_AUDIO3_2X, .present = true },
 	[tegra_clk_audio4_2x] = { .dt_id = TEGRA30_CLK_AUDIO4_2X, .present = true },
 	[tegra_clk_spdif_2x] = { .dt_id = TEGRA30_CLK_SPDIF_2X, .present = true },
-	[tegra_clk_clk_out_1] = { .dt_id = TEGRA30_CLK_CLK_OUT_1, .present = true },
-	[tegra_clk_clk_out_2] = { .dt_id = TEGRA30_CLK_CLK_OUT_2, .present = true },
-	[tegra_clk_clk_out_3] = { .dt_id = TEGRA30_CLK_CLK_OUT_3, .present = true },
-	[tegra_clk_blink] = { .dt_id = TEGRA30_CLK_BLINK, .present = true },
-	[tegra_clk_clk_out_1_mux] = { .dt_id = TEGRA30_CLK_CLK_OUT_1_MUX, .present = true },
-	[tegra_clk_clk_out_2_mux] = { .dt_id = TEGRA30_CLK_CLK_OUT_2_MUX, .present = true },
-	[tegra_clk_clk_out_3_mux] = { .dt_id = TEGRA30_CLK_CLK_OUT_3_MUX, .present = true },
 	[tegra_clk_hclk] = { .dt_id = TEGRA30_CLK_HCLK, .present = true },
 	[tegra_clk_pclk] = { .dt_id = TEGRA30_CLK_PCLK, .present = true },
 	[tegra_clk_i2s0] = { .dt_id = TEGRA30_CLK_I2S0, .present = true },
@@ -1222,9 +1213,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 1 },
 	{ TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 1 },
 	{ TEGRA30_CLK_EXTERN1, TEGRA30_CLK_PLL_A_OUT0, 0, 1 },
-	{ TEGRA30_CLK_CLK_OUT_1_MUX, TEGRA30_CLK_EXTERN1, 0, 0 },
-	{ TEGRA30_CLK_CLK_OUT_1, TEGRA30_CLK_CLK_MAX, 0, 1 },
-	{ TEGRA30_CLK_BLINK, TEGRA30_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA30_CLK_I2S0, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA30_CLK_I2S1, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA30_CLK_I2S2, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
@@ -1288,11 +1276,6 @@ static struct tegra_clk_duplicate tegra_clk_duplicates[] = {
 	TEGRA_CLK_DUPLICATE(TEGRA30_CLK_CLK_MAX, NULL, NULL),
 };
 
-static const struct of_device_id pmc_match[] __initconst = {
-	{ .compatible = "nvidia,tegra30-pmc" },
-	{ },
-};
-
 static struct tegra_audio_clk_info tegra30_audio_plls[] = {
 	{ "pll_a", &pll_a_params, tegra_clk_pll_a, "pll_p_out1" },
 };
@@ -1319,26 +1302,12 @@ static struct clk *tegra30_clk_src_onecell_get(struct of_phandle_args *clkspec,
 
 static void __init tegra30_clock_init(struct device_node *np)
 {
-	struct device_node *node;
-
 	clk_base = of_iomap(np, 0);
 	if (!clk_base) {
 		pr_err("ioremap tegra30 CAR failed\n");
 		return;
 	}
 
-	node = of_find_matching_node(NULL, pmc_match);
-	if (!node) {
-		pr_err("Failed to find pmc node\n");
-		BUG();
-	}
-
-	pmc_base = of_iomap(node, 0);
-	if (!pmc_base) {
-		pr_err("Can't map pmc registers\n");
-		BUG();
-	}
-
 	clks = tegra_clk_init(clk_base, TEGRA30_CLK_CLK_MAX,
 				TEGRA30_CLK_PERIPH_BANKS);
 	if (!clks)
@@ -1355,7 +1324,6 @@ static void __init tegra30_clock_init(struct device_node *np)
 	tegra30_periph_clk_init();
 	tegra_audio_clk_init(clk_base, tegra30_clks, tegra30_audio_plls,
 			     ARRAY_SIZE(tegra30_audio_plls), 24000000);
-	tegra_pmc_clk_init(pmc_base, tegra30_clks);
 
 	tegra_init_dup_clks(tegra_clk_duplicates, clks, TEGRA30_CLK_CLK_MAX);
 
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index cd79b7fc4e5e..88236ae9e33d 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -837,7 +837,6 @@ void tegra_periph_clk_init(void __iomem *clk_base,
 			struct tegra_clk *tegra_clks,
 			struct tegra_clk_pll_params *pll_params);
 
-void tegra_pmc_clk_init(void __iomem *pmc_base, struct tegra_clk *tegra_clks);
 void tegra_fixed_clk_init(struct tegra_clk *tegra_clks);
 int tegra_osc_clk_init(void __iomem *clk_base, struct tegra_clk *clks,
 		       unsigned long *input_freqs, unsigned int num,
-- 
2.7.4

