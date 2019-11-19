Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10EDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB93A222ED
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gvKE6cpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfKSGu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:50:58 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8258 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfKSGu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:50:57 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd390cd0000>; Mon, 18 Nov 2019 22:50:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 22:50:52 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 18 Nov 2019 22:50:52 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 06:50:52 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 Nov 2019 06:50:52 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.254]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd390ca0000>; Mon, 18 Nov 2019 22:50:52 -0800
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
Subject: [PATCH v1 01/17] soc: tegra: pmc: Add helper functions for PLLM overrides
Date:   Mon, 18 Nov 2019 22:50:18 -0800
Message-ID: <1574146234-3871-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574146253; bh=aYLT69VtdnonP0/6NiRoSJeOl8Z7k0Z+9NSLDbOu+9U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=gvKE6cpQs9YilgSywmwxvaLsUlUWVKCBaUkg4b88EKLxOSu3dvBKY1PLVu8xv48zc
         T9r50EUxAVZsmJM6f6gEpE317iv9GovZ0lkWJVtRcIppPmjG2qHI54tRuAy7kjkHB+
         rHcO6eyZdewxOBZhrtpf2RNcSNP6jpdHemWMqaT2HM8XSDJGB8uL7zC9kw7o/jZrYh
         BjGaindU2sRB74wivDAlH7NO6qKI2n7RFah+xg6XMiUETnyEMoySO0nNVFTuzjwZDm
         niAASNPN/unMQmNLM1TJidoWuGH8NKeR0qU+kyTEYOQ/NF6kymTNruPx5Ud9oNJeTD
         2RmisPVNwBKJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has an option to override the CAR PLLM configuration during
the warmboot.

PLLM dividers and enable overrides from Tegra PMC are applicable only
when PLLM_OVERRIDE bit in PMC_PLLP_WB0_OVERRIDE register is set by Tegra
the bootloader. During warmboot based on this override enable, PLLM
divider and enable configuration from overrides in PMC or from CAR
module are used.

Currently PLLM overrides in Tegra PMC are directly programmed by the Tegra
clock driver and with this when PMC is in secure mode, any direct PMC
register access from non-secure world will not go through.

This patch adds helper functions for use by the Tegra clock driver to
configure these PLLM overrides during PLLM clock rate and state changes.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/soc/tegra/pmc.h |   5 ++
 2 files changed, 205 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 8db63cfba833..224e7cf8dc00 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -79,6 +79,14 @@
 
 #define PMC_PWR_DET			0x48
 
+#define TEGRA186_PMC_PLLP_WB0_OVERRIDE	0x4c
+#define PMC_PLLP_WB0_OVERRIDE		0xf8
+#define  PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE BIT(12)
+#define  PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE BIT(11)
+
+#define TEGRA186_PMC_PLLM_WB0_OVERRIDE_FREQ	0x50
+#define TEGRA186_PMC_PLLM_WB0_OVERRIDE_2	0x54
+
 #define PMC_SCRATCH0_MODE_RECOVERY	BIT(31)
 #define PMC_SCRATCH0_MODE_BOOTLOADER	BIT(30)
 #define PMC_SCRATCH0_MODE_RCM		BIT(1)
@@ -122,6 +130,9 @@
 #define IO_DPD2_STATUS			0x1c4
 #define SEL_DPD_TIM			0x1c8
 
+#define PMC_PLLM_WB0_OVERRIDE_FREQ	0x1dc
+#define PMC_PLLM_WB0_OVERRIDE_2		0x2b0
+
 #define PMC_SCRATCH54			0x258
 #define  PMC_SCRATCH54_DATA_SHIFT	8
 #define  PMC_SCRATCH54_ADDR_SHIFT	0
@@ -182,6 +193,15 @@ struct tegra_pmc_regs {
 	unsigned int rst_source_mask;
 	unsigned int rst_level_shift;
 	unsigned int rst_level_mask;
+	unsigned int pllp_wb0_override;
+	unsigned int pllm_wb0_override_freq;
+	unsigned int pllm_wb0_override_2;
+	unsigned int override_divm_shift;
+	unsigned int override_divm_mask;
+	unsigned int override_divn_shift;
+	unsigned int override_divn_mask;
+	unsigned int override_divp_shift;
+	unsigned int override_divp_mask;
 };
 
 struct tegra_wake_event {
@@ -227,6 +247,7 @@ struct tegra_pmc_soc {
 	bool needs_mbist_war;
 	bool has_impl_33v_pwr;
 	bool maybe_tz_only;
+	bool has_pllm_wb0_override;
 
 	const struct tegra_io_pad_soc *io_pads;
 	unsigned int num_io_pads;
@@ -1156,6 +1177,99 @@ static void tegra_powergate_remove_all(struct device_node *parent)
 	of_node_put(np);
 }
 
+bool tegra_pmc_is_pllm_wb0_override_enabled(void)
+{
+	u32 val;
+
+	if (pmc->soc->has_pllm_wb0_override) {
+		val = tegra_pmc_readl(pmc, pmc->soc->regs->pllp_wb0_override);
+		return (val & PMC_PLLP_WB0_OVERRIDE_PLLM_OVERRIDE) ? 1 : 0;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_pmc_is_pllm_wb0_override_enabled);
+
+bool tegra_pmc_is_pllm_wb0_enabled(void)
+{
+	u32 val;
+
+	if (pmc->soc->has_pllm_wb0_override) {
+		val = tegra_pmc_readl(pmc, pmc->soc->regs->pllp_wb0_override);
+		return (val & PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE) ? 1 : 0;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_pmc_is_pllm_wb0_enabled);
+
+void tegra_pmc_set_pllm_wb0_enable(bool enable)
+{
+	u32 val;
+
+	if (pmc->soc->has_pllm_wb0_override) {
+		val = tegra_pmc_readl(pmc, pmc->soc->regs->pllp_wb0_override);
+		if (enable)
+			val |= PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE;
+		else
+			val &= ~PMC_PLLP_WB0_OVERRIDE_PLLM_ENABLE;
+		tegra_pmc_writel(pmc, val, pmc->soc->regs->pllp_wb0_override);
+	}
+}
+EXPORT_SYMBOL(tegra_pmc_set_pllm_wb0_enable);
+
+void tegra_pmc_get_pllm_wb0_mnp_overrides(u32 *divm, u32 *divn, u8 *divp)
+{
+	u32 val;
+	unsigned int divnm_reg, divp_reg;
+
+	if (pmc->soc->has_pllm_wb0_override) {
+		divnm_reg = pmc->soc->regs->pllm_wb0_override_freq;
+		divp_reg = pmc->soc->regs->pllm_wb0_override_2;
+
+		if (tegra_pmc_is_pllm_wb0_override_enabled()) {
+			val = tegra_pmc_readl(pmc, divnm_reg);
+			*divm = (val >> pmc->soc->regs->override_divm_shift) &
+				pmc->soc->regs->override_divm_mask;
+			*divn = (val >> pmc->soc->regs->override_divn_shift) &
+				pmc->soc->regs->override_divn_mask;
+			val = tegra_pmc_readl(pmc, divp_reg);
+			*divp = (val >> pmc->soc->regs->override_divp_shift) &
+				pmc->soc->regs->override_divp_mask;
+		}
+	}
+}
+EXPORT_SYMBOL(tegra_pmc_get_pllm_wb0_mnp_overrides);
+
+void tegra_pmc_set_pllm_wb0_mnp_overrides(u32 divm, u32 divn, u8 divp)
+{
+	u32 val;
+	unsigned int divnm_reg, divp_reg;
+
+	if (pmc->soc->has_pllm_wb0_override) {
+		divnm_reg = pmc->soc->regs->pllm_wb0_override_freq;
+		divp_reg = pmc->soc->regs->pllm_wb0_override_2;
+
+		if (tegra_pmc_is_pllm_wb0_override_enabled()) {
+			val = tegra_pmc_readl(pmc, divp_reg);
+			val &= ~(pmc->soc->regs->override_divp_mask <<
+				 pmc->soc->regs->override_divp_shift);
+			val |= (divp << pmc->soc->regs->override_divp_shift);
+			tegra_pmc_writel(pmc, val, divp_reg);
+
+			val = tegra_pmc_readl(pmc, divnm_reg);
+			val &= ~(pmc->soc->regs->override_divm_mask <<
+				 pmc->soc->regs->override_divm_shift);
+			val |= divm << pmc->soc->regs->override_divm_shift;
+			val &= ~(pmc->soc->regs->override_divn_mask <<
+				 pmc->soc->regs->override_divn_shift);
+			val |= divn << pmc->soc->regs->override_divn_shift;
+			tegra_pmc_writel(pmc, val, divnm_reg);
+		}
+	}
+}
+EXPORT_SYMBOL(tegra_pmc_set_pllm_wb0_mnp_overrides);
+
 static const struct tegra_io_pad_soc *
 tegra_io_pad_find(struct tegra_pmc *pmc, enum tegra_io_pad id)
 {
@@ -2345,6 +2459,72 @@ static const struct tegra_pmc_regs tegra20_pmc_regs = {
 	.rst_level_mask = 0x0,
 };
 
+static const struct tegra_pmc_regs tegra30_pmc_regs = {
+	.scratch0 = 0x50,
+	.dpd_req = 0x1b8,
+	.dpd_status = 0x1bc,
+	.dpd2_req = 0x1c0,
+	.dpd2_status = 0x1c4,
+	.rst_status = 0x1b4,
+	.rst_source_shift = 0x0,
+	.rst_source_mask = 0x7,
+	.rst_level_shift = 0x0,
+	.rst_level_mask = 0x0,
+	.pllp_wb0_override = PMC_PLLP_WB0_OVERRIDE,
+	.pllm_wb0_override_freq = PMC_PLLM_WB0_OVERRIDE_FREQ,
+	.pllm_wb0_override_2 = PMC_PLLM_WB0_OVERRIDE_FREQ,
+	.override_divm_shift = 0,
+	.override_divm_mask = 0x1f,
+	.override_divn_shift = 5,
+	.override_divn_mask = 0x3ff,
+	.override_divp_shift = 15,
+	.override_divp_mask = 0x7,
+};
+
+static const struct tegra_pmc_regs tegra114_pmc_regs = {
+	.scratch0 = 0x50,
+	.dpd_req = 0x1b8,
+	.dpd_status = 0x1bc,
+	.dpd2_req = 0x1c0,
+	.dpd2_status = 0x1c4,
+	.rst_status = 0x1b4,
+	.rst_source_shift = 0x0,
+	.rst_source_mask = 0x7,
+	.rst_level_shift = 0x0,
+	.rst_level_mask = 0x0,
+	.pllp_wb0_override = PMC_PLLP_WB0_OVERRIDE,
+	.pllm_wb0_override_freq = PMC_PLLM_WB0_OVERRIDE_FREQ,
+	.pllm_wb0_override_2 = PMC_PLLM_WB0_OVERRIDE_2,
+	.override_divm_shift = 0,
+	.override_divm_mask = 0xff,
+	.override_divn_shift = 8,
+	.override_divn_mask = 0xff,
+	.override_divp_shift = 27,
+	.override_divp_mask = 0x1,
+};
+
+static const struct tegra_pmc_regs tegra210_pmc_regs = {
+	.scratch0 = 0x50,
+	.dpd_req = 0x1b8,
+	.dpd_status = 0x1bc,
+	.dpd2_req = 0x1c0,
+	.dpd2_status = 0x1c4,
+	.rst_status = 0x1b4,
+	.rst_source_shift = 0x0,
+	.rst_source_mask = 0x7,
+	.rst_level_shift = 0x0,
+	.rst_level_mask = 0x0,
+	.pllp_wb0_override = PMC_PLLP_WB0_OVERRIDE,
+	.pllm_wb0_override_freq = PMC_PLLM_WB0_OVERRIDE_FREQ,
+	.pllm_wb0_override_2 = PMC_PLLM_WB0_OVERRIDE_2,
+	.override_divm_shift = 0,
+	.override_divm_mask = 0xff,
+	.override_divn_shift = 8,
+	.override_divn_mask = 0xff,
+	.override_divp_shift = 27,
+	.override_divp_mask = 0x1f,
+};
+
 static void tegra20_pmc_init(struct tegra_pmc *pmc)
 {
 	u32 value, osc, pmu, off;
@@ -2411,6 +2591,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.needs_mbist_war = false,
 	.has_impl_33v_pwr = false,
 	.maybe_tz_only = false,
+	.has_pllm_wb0_override = false,
 	.num_io_pads = 0,
 	.io_pads = NULL,
 	.num_pin_descs = 0,
@@ -2458,11 +2639,12 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.needs_mbist_war = false,
 	.has_impl_33v_pwr = false,
 	.maybe_tz_only = false,
+	.has_pllm_wb0_override = true,
 	.num_io_pads = 0,
 	.io_pads = NULL,
 	.num_pin_descs = 0,
 	.pin_descs = NULL,
-	.regs = &tegra20_pmc_regs,
+	.regs = &tegra30_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
 	.reset_sources = tegra30_reset_sources,
@@ -2509,11 +2691,12 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.needs_mbist_war = false,
 	.has_impl_33v_pwr = false,
 	.maybe_tz_only = false,
+	.has_pllm_wb0_override = true,
 	.num_io_pads = 0,
 	.io_pads = NULL,
 	.num_pin_descs = 0,
 	.pin_descs = NULL,
-	.regs = &tegra20_pmc_regs,
+	.regs = &tegra114_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
 	.reset_sources = tegra30_reset_sources,
@@ -2620,11 +2803,12 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.needs_mbist_war = false,
 	.has_impl_33v_pwr = false,
 	.maybe_tz_only = false,
+	.has_pllm_wb0_override = true,
 	.num_io_pads = ARRAY_SIZE(tegra124_io_pads),
 	.io_pads = tegra124_io_pads,
 	.num_pin_descs = ARRAY_SIZE(tegra124_pin_descs),
 	.pin_descs = tegra124_pin_descs,
-	.regs = &tegra20_pmc_regs,
+	.regs = &tegra114_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
 	.reset_sources = tegra30_reset_sources,
@@ -2730,11 +2914,12 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.needs_mbist_war = true,
 	.has_impl_33v_pwr = false,
 	.maybe_tz_only = true,
+	.has_pllm_wb0_override = true,
 	.num_io_pads = ARRAY_SIZE(tegra210_io_pads),
 	.io_pads = tegra210_io_pads,
 	.num_pin_descs = ARRAY_SIZE(tegra210_pin_descs),
 	.pin_descs = tegra210_pin_descs,
-	.regs = &tegra20_pmc_regs,
+	.regs = &tegra210_pmc_regs,
 	.init = tegra20_pmc_init,
 	.setup_irq_polarity = tegra20_pmc_setup_irq_polarity,
 	.irq_set_wake = tegra210_pmc_irq_set_wake,
@@ -2807,6 +2992,15 @@ static const struct tegra_pmc_regs tegra186_pmc_regs = {
 	.rst_source_mask = 0x3C,
 	.rst_level_shift = 0x0,
 	.rst_level_mask = 0x3,
+	.pllp_wb0_override = TEGRA186_PMC_PLLP_WB0_OVERRIDE,
+	.pllm_wb0_override_freq = TEGRA186_PMC_PLLM_WB0_OVERRIDE_FREQ,
+	.pllm_wb0_override_2 = TEGRA186_PMC_PLLM_WB0_OVERRIDE_2,
+	.override_divm_shift = 0,
+	.override_divm_mask = 0xff,
+	.override_divn_shift = 8,
+	.override_divn_mask = 0xff,
+	.override_divp_shift = 27,
+	.override_divp_mask = 0x1f,
 };
 
 static void tegra186_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
@@ -2859,6 +3053,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.needs_mbist_war = false,
 	.has_impl_33v_pwr = true,
 	.maybe_tz_only = false,
+	.has_pllm_wb0_override = true,
 	.num_io_pads = ARRAY_SIZE(tegra186_io_pads),
 	.io_pads = tegra186_io_pads,
 	.num_pin_descs = ARRAY_SIZE(tegra186_pin_descs),
@@ -2941,6 +3136,7 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.needs_mbist_war = false,
 	.has_impl_33v_pwr = false,
 	.maybe_tz_only = false,
+	.has_pllm_wb0_override = false,
 	.num_io_pads = ARRAY_SIZE(tegra194_io_pads),
 	.io_pads = tegra194_io_pads,
 	.regs = &tegra186_pmc_regs,
diff --git a/include/soc/tegra/pmc.h b/include/soc/tegra/pmc.h
index 57e58faf660b..cbf23e0d3c55 100644
--- a/include/soc/tegra/pmc.h
+++ b/include/soc/tegra/pmc.h
@@ -20,6 +20,11 @@ struct reset_control;
 bool tegra_pmc_cpu_is_powered(unsigned int cpuid);
 int tegra_pmc_cpu_power_on(unsigned int cpuid);
 int tegra_pmc_cpu_remove_clamping(unsigned int cpuid);
+bool tegra_pmc_is_pllm_wb0_override_enabled(void);
+bool tegra_pmc_is_pllm_wb0_enabled(void);
+void tegra_pmc_set_pllm_wb0_enable(bool enable);
+void tegra_pmc_get_pllm_wb0_mnp_overrides(u32 *divm, u32 *divn, u8 *divp);
+void tegra_pmc_set_pllm_wb0_mnp_overrides(u32 divm, u32 divn, u8 divp);
 
 /*
  * powergate and I/O rail APIs
-- 
2.7.4

