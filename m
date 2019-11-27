Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A75C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF262068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AOwTIak2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfK0E7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 23:59:46 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11618 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfK0E7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:59:40 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dde02b40001>; Tue, 26 Nov 2019 20:59:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Nov 2019 20:59:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Nov 2019 20:59:38 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 04:59:38 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 04:59:37 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Nov 2019 04:59:37 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.149]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dde02b80000>; Tue, 26 Nov 2019 20:59:37 -0800
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
Subject: [PATCH v2 02/11] soc: tegra: Add Tegra PMC clock registrations into PMC driver
Date:   Tue, 26 Nov 2019 20:59:24 -0800
Message-ID: <1574830773-14892-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574830772; bh=hvgoGV9z/vXG8iOxptXNdTH+UZWkNWCN5fhxSYzRSzM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=AOwTIak2LJviJP8/IP7/0OJ7d2GLfBSGk83evBtDWlJ9/tOLQ51NO5lPYzs7n9pzU
         UJyFBJbcKvJkMH9tIH2jYbeXsrjWr1RkhEXiNZXrpVD9oHcf4PqylcxlI4+p4UX1b7
         P/04//KQ92z1A+P6b4CCRtDPWvNae5jxgwFMoJkbo3BaAdG0C3yTUci+cyrfUUGkxy
         IabtiPFxevFthbU7zgVrgqUu5x/7CjdQ6K4Y+wJt6/suBHKwbIbiGaoxnKWzkCI8n5
         rE9g6qusRhoG4YaKDcNZmz+1M99rB/S6SWOxrPAfnSSzrH7JExk2pqPnHeu0ZXjSjV
         o05tx2obblh2Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out_3 with
mux and gate for each of these clocks.

Currently these PMC clocks are registered by Tegra clock driver using
clk_register_mux and clk_register_gate by passing PMC base address
and register offsets and PMC programming for these clocks happens
through direct PMC access by the clock driver.

With this, when PMC is in secure mode any direct PMC access from the
non-secure world does not go through and these clocks will not be
functional.

This patch adds these clocks registration with PMC as a clock provider
for these clocks. clk_ops callback implementations for these clocks
uses tegra_pmc_readl and tegra_pmc_writel which supports PMC programming
in secure mode and non-secure mode.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 330 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 330 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ea0e11a09c12..a353f6d0a832 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -13,6 +13,9 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/clk-conf.h>
 #include <linux/clk/tegra.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -48,6 +51,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
 #include <dt-bindings/gpio/tegra186-gpio.h>
 #include <dt-bindings/gpio/tegra194-gpio.h>
+#include <dt-bindings/soc/tegra-pmc.h>
 
 #define PMC_CNTRL			0x0
 #define  PMC_CNTRL_INTR_POLARITY	BIT(17) /* inverts INTR polarity */
@@ -100,6 +104,7 @@
 #define PMC_WAKE2_STATUS		0x168
 #define PMC_SW_WAKE2_STATUS		0x16c
 
+#define PMC_CLK_OUT_CNTRL		0x1a8
 #define PMC_SENSOR_CTRL			0x1b0
 #define  PMC_SENSOR_CTRL_SCRATCH_WRITE	BIT(2)
 #define  PMC_SENSOR_CTRL_ENABLE_RST	BIT(1)
@@ -155,6 +160,91 @@
 #define  TEGRA_SMC_PMC_READ	0xaa
 #define  TEGRA_SMC_PMC_WRITE	0xbb
 
+struct pmc_clk_mux {
+	struct clk_hw	hw;
+	unsigned long	offs;
+	u32		mask;
+	u32		shift;
+};
+
+#define to_pmc_clk_mux(_hw) container_of(_hw, struct pmc_clk_mux, hw)
+
+struct pmc_clk_gate {
+	struct clk_hw	hw;
+	unsigned long	offs;
+	u32		shift;
+};
+
+#define to_pmc_clk_gate(_hw) container_of(_hw, struct pmc_clk_gate, hw)
+
+struct pmc_clk_init_data {
+	char *mux_name;
+	char *gate_name;
+	const char **parents;
+	int num_parents;
+	int mux_id;
+	int gate_id;
+	char *dev_name;
+	u8 mux_shift;
+	u8 gate_shift;
+	u8 init_parent_index;
+	int init_state;
+};
+
+static const char *clk_out1_parents[] = { "clk_m", "clk_m_div2",
+	"clk_m_div4", "extern1",
+};
+
+static const char *clk_out2_parents[] = { "clk_m", "clk_m_div2",
+	"clk_m_div4", "extern2",
+};
+
+static const char *clk_out3_parents[] = { "clk_m", "clk_m_div2",
+	"clk_m_div4", "extern3",
+};
+
+static struct pmc_clk_init_data tegra_pmc_clks_data[] = {
+	{
+		.mux_name = "clk_out_1_mux",
+		.gate_name = "clk_out_1",
+		.parents = clk_out1_parents,
+		.num_parents = ARRAY_SIZE(clk_out1_parents),
+		.mux_id = TEGRA_PMC_CLK_OUT_1_MUX,
+		.gate_id = TEGRA_PMC_CLK_OUT_1,
+		.dev_name = "extern1",
+		.mux_shift = 6,
+		.gate_shift = 2,
+		.init_parent_index = 3,
+		.init_state = 1,
+	},
+	{
+		.mux_name = "clk_out_2_mux",
+		.gate_name = "clk_out_2",
+		.parents = clk_out2_parents,
+		.num_parents = ARRAY_SIZE(clk_out2_parents),
+		.mux_id = TEGRA_PMC_CLK_OUT_2_MUX,
+		.gate_id = TEGRA_PMC_CLK_OUT_2,
+		.dev_name = "extern2",
+		.mux_shift = 14,
+		.gate_shift = 10,
+		.init_parent_index = 0,
+		.init_state = 0,
+	},
+	{
+		.mux_name = "clk_out_3_mux",
+		.gate_name = "clk_out_3",
+		.parents = clk_out3_parents,
+		.num_parents = ARRAY_SIZE(clk_out3_parents),
+		.mux_id = TEGRA_PMC_CLK_OUT_3_MUX,
+		.gate_id = TEGRA_PMC_CLK_OUT_3,
+		.dev_name = "extern3",
+		.mux_shift = 22,
+		.gate_shift = 18,
+		.init_parent_index = 0,
+		.init_state = 0,
+	},
+};
+
 struct tegra_powergate {
 	struct generic_pm_domain genpd;
 	struct tegra_pmc *pmc;
@@ -254,6 +344,9 @@ struct tegra_pmc_soc {
 	 */
 	const struct tegra_wake_event *wake_events;
 	unsigned int num_wake_events;
+
+	struct pmc_clk_init_data *pmc_clks_data;
+	unsigned int num_pmc_clks;
 };
 
 static const char * const tegra186_reset_sources[] = {
@@ -2163,6 +2256,228 @@ static int tegra_pmc_clk_notify_cb(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static void pmc_clk_fence_udelay(u32 offset)
+{
+	tegra_pmc_readl(pmc, offset);
+	/* pmc clk propagation delay 2 us */
+	udelay(2);
+}
+
+static u8 pmc_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct pmc_clk_mux *mux = to_pmc_clk_mux(hw);
+	int num_parents = clk_hw_get_num_parents(hw);
+	u32 val;
+
+	val = tegra_pmc_readl(pmc, mux->offs) >> mux->shift;
+	val &= mux->mask;
+
+	if (val >= num_parents)
+		return -EINVAL;
+
+	return val;
+}
+
+static int pmc_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct pmc_clk_mux *mux = to_pmc_clk_mux(hw);
+	u32 val;
+
+	val = tegra_pmc_readl(pmc, mux->offs);
+	val &= ~(mux->mask << mux->shift);
+	val |= index << mux->shift;
+	tegra_pmc_writel(pmc, val, mux->offs);
+	pmc_clk_fence_udelay(mux->offs);
+
+	return 0;
+}
+
+static const struct clk_ops pmc_clk_mux_ops = {
+	.get_parent = pmc_clk_mux_get_parent,
+	.set_parent = pmc_clk_mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+
+static struct clk *
+tegra_pmc_clk_mux_register(const char *name, const char * const *parent_names,
+			   int num_parents, unsigned long flags,
+			   unsigned long offset, u32 shift, u32 mask)
+{
+	struct clk_init_data init;
+	struct pmc_clk_mux *mux;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &pmc_clk_mux_ops;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.flags = flags;
+
+	mux->hw.init = &init;
+	mux->offs = offset;
+	mux->mask = mask;
+	mux->shift = shift;
+
+	return clk_register(NULL, &mux->hw);
+}
+
+static int pmc_clk_is_enabled(struct clk_hw *hw)
+{
+	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
+
+	return tegra_pmc_readl(pmc, gate->offs) & BIT(gate->shift) ? 1 : 0;
+}
+
+static void pmc_clk_set_state(struct clk_hw *hw, int state)
+{
+	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
+	u32 val;
+
+	val = tegra_pmc_readl(pmc, gate->offs);
+	val = state ? (val | BIT(gate->shift)) : (val & ~BIT(gate->shift));
+	tegra_pmc_writel(pmc, val, gate->offs);
+	pmc_clk_fence_udelay(gate->offs);
+}
+
+static int pmc_clk_enable(struct clk_hw *hw)
+{
+	pmc_clk_set_state(hw, 1);
+
+	return 0;
+}
+
+static void pmc_clk_disable(struct clk_hw *hw)
+{
+	pmc_clk_set_state(hw, 0);
+}
+
+static const struct clk_ops pmc_clk_gate_ops = {
+	.is_enabled = pmc_clk_is_enabled,
+	.enable = pmc_clk_enable,
+	.disable = pmc_clk_disable,
+};
+
+static struct clk *
+tegra_pmc_clk_gate_register(const char *name, const char *parent_name,
+			    unsigned long flags, unsigned long offset,
+			    u32 shift)
+{
+	struct clk_init_data init;
+	struct pmc_clk_gate *gate;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &pmc_clk_gate_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = flags;
+
+	gate->hw.init = &init;
+	gate->offs = offset;
+	gate->shift = shift;
+
+	return clk_register(NULL, &gate->hw);
+}
+
+static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
+				     struct device_node *np)
+{
+	struct clk *clkmux, *clk, *parent;
+	struct clk_onecell_data *clk_data;
+	unsigned int num_clks;
+	int i, ret;
+
+	/* each pmc clock output has a mux and a gate */
+	num_clks = pmc->soc->num_pmc_clks * 2;
+
+	if (!num_clks)
+		return;
+
+	clk_data = kmalloc(sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->clks = kcalloc(TEGRA_PMC_CLK_MAX, sizeof(*clk_data->clks),
+				 GFP_KERNEL);
+	if (!clk_data->clks)
+		goto free_clkdata;
+
+	clk_data->clk_num = num_clks;
+
+	for (i = 0; i < pmc->soc->num_pmc_clks; i++) {
+		struct pmc_clk_init_data *data;
+
+		data = pmc->soc->pmc_clks_data + i;
+
+		clkmux = tegra_pmc_clk_mux_register(data->mux_name,
+						    data->parents,
+						    data->num_parents,
+						    CLK_SET_RATE_NO_REPARENT |
+						    CLK_SET_RATE_PARENT,
+						    PMC_CLK_OUT_CNTRL,
+						    data->mux_shift, 3);
+		if (IS_ERR(clkmux))
+			goto free_clks;
+
+		clk_data->clks[data->mux_id] = clkmux;
+
+		clk = tegra_pmc_clk_gate_register(data->gate_name,
+						  data->mux_name,
+						  CLK_SET_RATE_PARENT,
+						  PMC_CLK_OUT_CNTRL,
+						  data->gate_shift);
+		if (IS_ERR(clk))
+			goto free_clks;
+
+		clk_data->clks[data->gate_id] = clk;
+
+		ret = clk_set_parent(clk, clkmux);
+		if (ret < 0) {
+			pr_err("failed to set parent of %s to %s\n",
+			       __func__, __clk_get_name(clk),
+			       __clk_get_name(clkmux));
+		}
+
+		clk_register_clkdev(clk, data->dev_name, data->gate_name);
+
+		/* configure initial clock parent and state */
+		parent = clk_get_sys(data->gate_name,
+				     data->parents[data->init_parent_index]);
+		if (!IS_ERR(parent)) {
+			ret = clk_set_parent(clkmux, parent);
+			if (ret < 0) {
+				pr_err("failed to set parent of %s to %s\n",
+				       __func__, __clk_get_name(clkmux),
+				       __clk_get_name(parent));
+				WARN_ON(1);
+			}
+		}
+
+		if (data->init_state) {
+			if (clk_prepare_enable(clk)) {
+				pr_err("failed to enable %s\n", __func__,
+				       __clk_get_name(clk));
+				WARN_ON(1);
+			}
+		}
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
+
+	return;
+
+free_clks:
+	kfree(clk_data->clks);
+free_clkdata:
+	kfree(clk_data);
+}
+
 static int tegra_pmc_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -2281,6 +2596,7 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	pmc->base = base;
 	mutex_unlock(&pmc->powergates_lock);
 
+	tegra_pmc_clock_register(pmc, pdev->dev.of_node);
 	platform_set_drvdata(pdev, pmc);
 
 	return 0;
@@ -2422,6 +2738,8 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.num_reset_sources = 0,
 	.reset_levels = NULL,
 	.num_reset_levels = 0,
+	.pmc_clks_data = NULL,
+	.num_pmc_clks = 0,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -2469,6 +2787,8 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.num_reset_sources = ARRAY_SIZE(tegra30_reset_sources),
 	.reset_levels = NULL,
 	.num_reset_levels = 0,
+	.pmc_clks_data = tegra_pmc_clks_data,
+	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 };
 
 static const char * const tegra114_powergates[] = {
@@ -2520,6 +2840,8 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.num_reset_sources = ARRAY_SIZE(tegra30_reset_sources),
 	.reset_levels = NULL,
 	.num_reset_levels = 0,
+	.pmc_clks_data = tegra_pmc_clks_data,
+	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 };
 
 static const char * const tegra124_powergates[] = {
@@ -2631,6 +2953,8 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.num_reset_sources = ARRAY_SIZE(tegra30_reset_sources),
 	.reset_levels = NULL,
 	.num_reset_levels = 0,
+	.pmc_clks_data = tegra_pmc_clks_data,
+	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 };
 
 static const char * const tegra210_powergates[] = {
@@ -2745,6 +3069,8 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.num_reset_levels = 0,
 	.num_wake_events = ARRAY_SIZE(tegra210_wake_events),
 	.wake_events = tegra210_wake_events,
+	.pmc_clks_data = tegra_pmc_clks_data,
+	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 };
 
 #define TEGRA186_IO_PAD_TABLE(_pad)					     \
@@ -2874,6 +3200,8 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.num_reset_levels = ARRAY_SIZE(tegra186_reset_levels),
 	.num_wake_events = ARRAY_SIZE(tegra186_wake_events),
 	.wake_events = tegra186_wake_events,
+	.pmc_clks_data = NULL,
+	.num_pmc_clks = 0,
 };
 
 static const struct tegra_io_pad_soc tegra194_io_pads[] = {
@@ -2991,6 +3319,8 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.num_reset_levels = ARRAY_SIZE(tegra186_reset_levels),
 	.num_wake_events = ARRAY_SIZE(tegra194_wake_events),
 	.wake_events = tegra194_wake_events,
+	.pmc_clks_data = NULL,
+	.num_pmc_clks = 0,
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
-- 
2.7.4

