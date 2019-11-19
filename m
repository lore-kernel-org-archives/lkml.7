Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A085DC43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F905222DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ETrMki8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfKSGvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:51:11 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14257 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfKSGvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:51:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd390d30000>; Mon, 18 Nov 2019 22:50:59 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 22:51:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 22:51:02 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 06:51:01 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 Nov 2019 06:51:01 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.254]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd390d40000>; Mon, 18 Nov 2019 22:51:01 -0800
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
Subject: [PATCH v1 07/17] clk: tegra: Use Tegra PMC helper functions for PLLM overrides
Date:   Mon, 18 Nov 2019 22:50:24 -0800
Message-ID: <1574146234-3871-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574146259; bh=KopjE34Xj7+TWn9ZI63saI1VLaHAj1SNg7oTBUBXy18=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ETrMki8MVjx4coCzppEngz3C3Y9vke4MbiAYZ4a78Oj3ssE3/NuAqYbBkdaADjeuk
         ILYaujZKuBUSTMFbsMl/E5FTJ5ZOl/dNXYOjLntIL2iXSqh66+Cjp3Y05MSDD2NYIa
         bVyFQk5Sz58gUtWnOXrWf2lgEXbKXVEuodL9tzxAUJ+wdOCoPTH2dFfZi9lbZBYL0D
         D0DLgp9wVo6UpPfMX3X19zPAG2BUDRLXIEQozsrChOTuiDsdFy2dmtPX9g3h7s3cmT
         Z4sUZv+MaCJ6ucYN/r9V3l0pxkTt8wFtI9CEnb2g94HhA6dTQFCvaORlPBaru7Pje6
         fQP+3Bvb80pkg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has PLLM override registers to override PLLM clock
dividers and enable state programmed by Tegra CAR PLLM registers
to have PLLM enabled during warmboot.

Currently Tegra clock driver programs these overrides by direct
PMC access. With this, when PMC is in secure mode any direct access
from non-secure world does not go through and these overrides from
clock driver will not be set.

Tegra PMC helper functions for PLLM overrides happen thru
tegra_pmc_writel and tegra_pmc_readl which supports both secure mode
and non-secure mode access.

This patch updates Tegra clock driver to use Tegra PMC helper
functions for programming these overrides.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-pll.c      | 56 ++++++++++------------------------------
 drivers/clk/tegra/clk-tegra114.c |  9 -------
 drivers/clk/tegra/clk-tegra124.c |  8 ------
 drivers/clk/tegra/clk-tegra210.c |  8 ------
 drivers/clk/tegra/clk-tegra30.c  |  8 ------
 drivers/clk/tegra/clk.h          | 10 -------
 6 files changed, 13 insertions(+), 86 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 531c2b3d814e..f3c0a637174f 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <soc/tegra/pmc.h>
 
 #include "clk.h"
 
@@ -38,10 +39,6 @@
 
 #define OUT_OF_TABLE_CPCON 8
 
-#define PMC_PLLP_WB0_OVERRIDE 0xf8
-#define PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE BIT(12)
-#define PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE BIT(11)
-
 #define PLL_POST_LOCK_DELAY 50
 
 #define PLLDU_LFCON_SET_DIVN 600
@@ -230,14 +227,12 @@
 #define pll_readl(offset, p) readl_relaxed(p->clk_base + offset)
 #define pll_readl_base(p) pll_readl(p->params->base_reg, p)
 #define pll_readl_misc(p) pll_readl(p->params->misc_reg, p)
-#define pll_override_readl(offset, p) readl_relaxed(p->pmc + offset)
 #define pll_readl_sdm_din(p) pll_readl(p->params->sdm_din_reg, p)
 #define pll_readl_sdm_ctrl(p) pll_readl(p->params->sdm_ctrl_reg, p)
 
 #define pll_writel(val, offset, p) writel_relaxed(val, p->clk_base + offset)
 #define pll_writel_base(val, p) pll_writel(val, p->params->base_reg, p)
 #define pll_writel_misc(val, p) pll_writel(val, p->params->misc_reg, p)
-#define pll_override_writel(val, offset, p) writel(val, p->pmc + offset)
 #define pll_writel_sdm_din(val, p) pll_writel(val, p->params->sdm_din_reg, p)
 #define pll_writel_sdm_ctrl(val, p) pll_writel(val, p->params->sdm_ctrl_reg, p)
 
@@ -332,11 +327,9 @@ static int clk_pll_is_enabled(struct clk_hw *hw)
 	struct tegra_clk_pll *pll = to_clk_pll(hw);
 	u32 val;
 
-	if (pll->params->flags & TEGRA_PLLM) {
-		val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
-		if (val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE)
-			return val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE ? 1 : 0;
-	}
+	if ((pll->params->flags & TEGRA_PLLM) &&
+	    tegra_pmc_is_pllm_wb0_override_enabled())
+		return tegra_pmc_is_pllm_wb0_enabled();
 
 	val = pll_readl_base(pll);
 
@@ -369,11 +362,8 @@ static void _clk_pll_enable(struct clk_hw *hw)
 	val |= PLL_BASE_ENABLE;
 	pll_writel_base(val, pll);
 
-	if (pll->params->flags & TEGRA_PLLM) {
-		val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
-		val |= PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE;
-		writel_relaxed(val, pll->pmc + PMC_PLLP_WB0_OVERRIDE);
-	}
+	if (pll->params->flags & TEGRA_PLLM)
+		tegra_pmc_set_pllm_wb0_enable(true);
 }
 
 static void _clk_pll_disable(struct clk_hw *hw)
@@ -387,11 +377,8 @@ static void _clk_pll_disable(struct clk_hw *hw)
 	val &= ~PLL_BASE_ENABLE;
 	pll_writel_base(val, pll);
 
-	if (pll->params->flags & TEGRA_PLLM) {
-		val = readl_relaxed(pll->pmc + PMC_PLLP_WB0_OVERRIDE);
-		val &= ~PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE;
-		writel_relaxed(val, pll->pmc + PMC_PLLP_WB0_OVERRIDE);
-	}
+	if (pll->params->flags & TEGRA_PLLM)
+		tegra_pmc_set_pllm_wb0_enable(false);
 
 	if (pll->params->reset_reg) {
 		val = pll_readl(pll->params->reset_reg, pll);
@@ -644,22 +631,10 @@ static void _update_pll_mnp(struct tegra_clk_pll *pll,
 {
 	u32 val;
 	struct tegra_clk_pll_params *params = pll->params;
-	struct div_nmp *div_nmp = params->div_nmp;
 
 	if ((params->flags & (TEGRA_PLLM | TEGRA_PLLMB)) &&
-		(pll_override_readl(PMC_PLLP_WB0_OVERRIDE, pll) &
-			PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE)) {
-		val = pll_override_readl(params->pmc_divp_reg, pll);
-		val &= ~(divp_mask(pll) << div_nmp->override_divp_shift);
-		val |= cfg->p << div_nmp->override_divp_shift;
-		pll_override_writel(val, params->pmc_divp_reg, pll);
-
-		val = pll_override_readl(params->pmc_divnm_reg, pll);
-		val &= ~((divm_mask(pll) << div_nmp->override_divm_shift) |
-			(divn_mask(pll) << div_nmp->override_divn_shift));
-		val |= (cfg->m << div_nmp->override_divm_shift) |
-			(cfg->n << div_nmp->override_divn_shift);
-		pll_override_writel(val, params->pmc_divnm_reg, pll);
+	    tegra_pmc_is_pllm_wb0_override_enabled()) {
+		tegra_pmc_set_pllm_wb0_mnp_overrides(cfg->m, cfg->n, cfg->p);
 	} else {
 		val = pll_readl_base(pll);
 
@@ -686,14 +661,9 @@ static void _get_pll_mnp(struct tegra_clk_pll *pll,
 	*cfg = (struct tegra_clk_pll_freq_table) { };
 
 	if ((params->flags & (TEGRA_PLLM | TEGRA_PLLMB)) &&
-		(pll_override_readl(PMC_PLLP_WB0_OVERRIDE, pll) &
-			PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE)) {
-		val = pll_override_readl(params->pmc_divp_reg, pll);
-		cfg->p = (val >> div_nmp->override_divp_shift) & divp_mask(pll);
-
-		val = pll_override_readl(params->pmc_divnm_reg, pll);
-		cfg->m = (val >> div_nmp->override_divm_shift) & divm_mask(pll);
-		cfg->n = (val >> div_nmp->override_divn_shift) & divn_mask(pll);
+	    tegra_pmc_is_pllm_wb0_override_enabled()) {
+		tegra_pmc_get_pllm_wb0_mnp_overrides(&cfg->m, &cfg->n,
+						     &cfg->p);
 	}  else {
 		val = pll_readl_base(pll);
 
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 4efcaaf51b3a..77904334b6f0 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -105,10 +105,6 @@
 #define CLK_SOURCE_CSITE 0x1d4
 #define CLK_SOURCE_EMC 0x19c
 
-/* PLLM override registers */
-#define PMC_PLLM_WB0_OVERRIDE 0x1dc
-#define PMC_PLLM_WB0_OVERRIDE_2 0x2b0
-
 /* Tegra CPU clock and reset control regs */
 #define CLK_RST_CONTROLLER_CPU_CMPLX_STATUS	0x470
 
@@ -272,13 +268,10 @@ static struct tegra_clk_pll_params pll_c3_params = {
 static struct div_nmp pllm_nmp = {
 	.divm_shift = 0,
 	.divm_width = 8,
-	.override_divm_shift = 0,
 	.divn_shift = 8,
 	.divn_width = 8,
-	.override_divn_shift = 8,
 	.divp_shift = 20,
 	.divp_width = 1,
-	.override_divp_shift = 27,
 };
 
 static const struct pdiv_map pllm_p[] = {
@@ -311,8 +304,6 @@ static struct tegra_clk_pll_params pll_m_params = {
 	.max_p = 2,
 	.pdiv_tohw = pllm_p,
 	.div_nmp = &pllm_nmp,
-	.pmc_divnm_reg = PMC_PLLM_WB0_OVERRIDE,
-	.pmc_divp_reg = PMC_PLLM_WB0_OVERRIDE_2,
 	.freq_table = pll_m_freq_table,
 	.flags = TEGRA_PLL_USE_LOCK | TEGRA_PLL_HAS_LOCK_ENABLE |
 		 TEGRA_PLL_FIXED,
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index b3110d5b5a6c..010daac53ea7 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -84,9 +84,6 @@
 
 #define PLLXC_SW_MAX_P 6
 
-#define PMC_PLLM_WB0_OVERRIDE 0x1dc
-#define PMC_PLLM_WB0_OVERRIDE_2 0x2b0
-
 #define CCLKG_BURST_POLICY 0x368
 
 /* Tegra CPU clock and reset control regs */
@@ -401,13 +398,10 @@ static struct tegra_clk_pll_freq_table pll_m_freq_table[] = {
 static struct div_nmp pllm_nmp = {
 	.divm_shift = 0,
 	.divm_width = 8,
-	.override_divm_shift = 0,
 	.divn_shift = 8,
 	.divn_width = 8,
-	.override_divn_shift = 8,
 	.divp_shift = 20,
 	.divp_width = 1,
-	.override_divp_shift = 27,
 };
 
 static struct tegra_clk_pll_params pll_m_params = {
@@ -424,8 +418,6 @@ static struct tegra_clk_pll_params pll_m_params = {
 	.max_p = 5,
 	.pdiv_tohw = pllm_p,
 	.div_nmp = &pllm_nmp,
-	.pmc_divnm_reg = PMC_PLLM_WB0_OVERRIDE,
-	.pmc_divp_reg = PMC_PLLM_WB0_OVERRIDE_2,
 	.freq_table = pll_m_freq_table,
 	.flags = TEGRA_PLL_USE_LOCK,
 };
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 762cd186f714..63f8a778821f 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -151,9 +151,6 @@
 #define PLLDP_SS_CTRL1	0x59c
 #define PLLDP_SS_CTRL2	0x5a0
 
-#define PMC_PLLM_WB0_OVERRIDE 0x1dc
-#define PMC_PLLM_WB0_OVERRIDE_2 0x2b0
-
 #define UTMIP_PLL_CFG2 0x488
 #define UTMIP_PLL_CFG2_STABLE_COUNT(x) (((x) & 0xfff) << 6)
 #define UTMIP_PLL_CFG2_ACTIVE_DLY_COUNT(x) (((x) & 0x3f) << 18)
@@ -1809,13 +1806,10 @@ static struct tegra_clk_pll_freq_table pll_m_freq_table[] = {
 static struct div_nmp pllm_nmp = {
 	.divm_shift = 0,
 	.divm_width = 8,
-	.override_divm_shift = 0,
 	.divn_shift = 8,
 	.divn_width = 8,
-	.override_divn_shift = 8,
 	.divp_shift = 20,
 	.divp_width = 5,
-	.override_divp_shift = 27,
 };
 
 static struct tegra_clk_pll_params pll_m_params = {
@@ -1838,8 +1832,6 @@ static struct tegra_clk_pll_params pll_m_params = {
 	.round_p_to_pdiv = pll_qlin_p_to_pdiv,
 	.pdiv_tohw = pll_qlin_pdiv_to_hw,
 	.div_nmp = &pllm_nmp,
-	.pmc_divnm_reg = PMC_PLLM_WB0_OVERRIDE,
-	.pmc_divp_reg = PMC_PLLM_WB0_OVERRIDE_2,
 	.freq_table = pll_m_freq_table,
 	.flags = TEGRA_PLL_USE_LOCK | TEGRA_PLL_HAS_LOCK_ENABLE,
 	.calc_rate = tegra210_pll_fixed_mdiv_cfg,
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index c8bc18e4d7e5..e3b64c66acdc 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -131,9 +131,6 @@
 #define CLK_RESET_CCLK_RUN_POLICY		2
 #define CLK_RESET_CCLK_BURST_POLICY_PLLX	8
 
-/* PLLM override registers */
-#define PMC_PLLM_WB0_OVERRIDE 0x1dc
-
 #ifdef CONFIG_PM_SLEEP
 static struct cpu_clk_suspend_context {
 	u32 pllx_misc;
@@ -367,13 +364,10 @@ static struct tegra_clk_pll_params pll_c_params __ro_after_init = {
 static struct div_nmp pllm_nmp = {
 	.divn_shift = 8,
 	.divn_width = 10,
-	.override_divn_shift = 5,
 	.divm_shift = 0,
 	.divm_width = 5,
-	.override_divm_shift = 0,
 	.divp_shift = 20,
 	.divp_width = 3,
-	.override_divp_shift = 15,
 };
 
 static struct tegra_clk_pll_params pll_m_params __ro_after_init = {
@@ -389,8 +383,6 @@ static struct tegra_clk_pll_params pll_m_params __ro_after_init = {
 	.lock_enable_bit_idx = PLL_MISC_LOCK_ENABLE,
 	.lock_delay = 300,
 	.div_nmp = &pllm_nmp,
-	.pmc_divnm_reg = PMC_PLLM_WB0_OVERRIDE,
-	.pmc_divp_reg = PMC_PLLM_WB0_OVERRIDE,
 	.freq_table = pll_m_freq_table,
 	.flags = TEGRA_PLLM | TEGRA_PLL_HAS_CPCON |
 		 TEGRA_PLL_SET_DCCON | TEGRA_PLL_USE_LOCK |
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 416a6b09f6a3..9a4473f94fe0 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -191,9 +191,6 @@ struct pdiv_map {
  * @divm_width:	width of the input divider bit field
  * @divp_shift:	shift to the post divider bit field
  * @divp_width:	width of the post divider bit field
- * @override_divn_shift: shift to the feedback divider bitfield in override reg
- * @override_divm_shift: shift to the input divider bitfield in override reg
- * @override_divp_shift: shift to the post divider bitfield in override reg
  */
 struct div_nmp {
 	u8		divn_shift;
@@ -202,9 +199,6 @@ struct div_nmp {
 	u8		divm_width;
 	u8		divp_shift;
 	u8		divp_width;
-	u8		override_divn_shift;
-	u8		override_divm_shift;
-	u8		override_divp_shift;
 };
 
 #define MAX_PLL_MISC_REG_COUNT	6
@@ -238,8 +232,6 @@ struct tegra_clk_pll;
  * @aux_reg:			AUX register offset
  * @dyn_ramp_reg:		Dynamic ramp control register offset
  * @ext_misc_reg:		Miscellaneous control register offsets
- * @pmc_divnm_reg:		n, m divider PMC override register offset (PLLM)
- * @pmc_divp_reg:		p divider PMC override register offset (PLLM)
  * @flags:			PLL flags
  * @stepa_shift:		Dynamic ramp step A field shift
  * @stepb_shift:		Dynamic ramp step B field shift
@@ -319,8 +311,6 @@ struct tegra_clk_pll_params {
 	u32		aux_reg;
 	u32		dyn_ramp_reg;
 	u32		ext_misc_reg[MAX_PLL_MISC_REG_COUNT];
-	u32		pmc_divnm_reg;
-	u32		pmc_divp_reg;
 	u32		flags;
 	int		stepa_shift;
 	int		stepb_shift;
-- 
2.7.4

