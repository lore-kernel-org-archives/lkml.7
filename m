Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1033AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B9C20716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jDnc7oMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfLQUFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:05:17 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15592 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfLQUES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:04:18 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df934b80000>; Tue, 17 Dec 2019 12:04:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 17 Dec 2019 12:04:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 17 Dec 2019 12:04:17 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 20:04:16 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 17 Dec 2019 20:04:16 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.174.101]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df934bf0002>; Tue, 17 Dec 2019 12:04:16 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/19] soc: tegra: Add support for 32KHz blink clock
Date:   Tue, 17 Dec 2019 12:03:55 -0800
Message-ID: <1576613046-17159-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576613048; bh=LLlbrfVZjV1fE08jfbhvB5XVDbn3b1OsXdteB84cLTA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=jDnc7oMge9Gnjmrn+noaAceC86hrtqv3CqoKO1SCvsBJigvrTb/cKkrcS34+03EE1
         25+il5Ku4/uuqOFtBYmXsT6AnORs4Ism+9x2UanubNsiWu2NwIpk22DiUmrXfc0c1g
         xIbaG5zKNQw2Y47c5ctb7Qf59aXeFUAUdhpJuHF3u+/ExWHMnKpH9g9W5/hIFTC6xY
         Nj3kQCGpZ9h8gPkT2ZfXBiajOBziN+NQk/qINLl+hQwXy/oKdjjihViC5GAdoWgbd8
         5hM0TwGnWE+JNXcE6BnGZ00tw91RiVO7CUhrHK+szoxKSmEKplPRdT1rPHC9cTmE7e
         MasXMOGTWFdlw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has blink control to output 32 Khz clock out to Tegra
blink pin. Blink pad DPD state and enable controls are part of
Tegra PMC register space.

Currently Tegra clock driver registers blink control by passing
PMC address and register offset to clk_register_gate which performs
direct PMC access during clk_ops and with this when PMC is in secure
mode, any access from non-secure world does not go through.

This patch adds blink control registration to the Tegra PMC driver
using PMC specific clock gate operations that use tegra_pmc_readl
and tegra_pmc_writel to support both secure mode and non-secure
mode PMC register access.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 6d65194a6e71..19996c21c60d 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -61,12 +61,15 @@
 #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
 #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
 #define  PMC_CNTRL_PWRREQ_POLARITY	BIT(8)
+#define  PMC_CNTRL_BLINK_EN		7
 #define  PMC_CNTRL_MAIN_RST		BIT(4)
 
 #define PMC_WAKE_MASK			0x0c
 #define PMC_WAKE_LEVEL			0x10
 #define PMC_WAKE_STATUS			0x14
 #define PMC_SW_WAKE_STATUS		0x18
+#define PMC_DPD_PADS_ORIDE		0x1c
+#define  PMC_DPD_PADS_ORIDE_BLINK	20
 
 #define DPD_SAMPLE			0x020
 #define  DPD_SAMPLE_ENABLE		BIT(0)
@@ -79,6 +82,7 @@
 
 #define PWRGATE_STATUS			0x38
 
+#define PMC_BLINK_TIMER			0x40
 #define PMC_IMPL_E_33V_PWR		0x40
 
 #define PMC_PWR_DET			0x48
@@ -170,6 +174,14 @@ struct pmc_clk {
 
 #define to_pmc_clk(_hw) container_of(_hw, struct pmc_clk, hw)
 
+struct pmc_clk_gate {
+	struct clk_hw	hw;
+	unsigned long	offs;
+	u32		shift;
+};
+
+#define to_pmc_clk_gate(_hw) container_of(_hw, struct pmc_clk_gate, hw)
+
 struct pmc_clk_init_data {
 	char *name;
 	const char *const *parents;
@@ -320,6 +332,7 @@ struct tegra_pmc_soc {
 
 	const struct pmc_clk_init_data *pmc_clks_data;
 	unsigned int num_pmc_clks;
+	bool has_blink_output;
 };
 
 static const char * const tegra186_reset_sources[] = {
@@ -2330,6 +2343,60 @@ tegra_pmc_clk_out_register(const struct pmc_clk_init_data *data,
 	return clk_register(NULL, &pmc_clk->hw);
 }
 
+static int pmc_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
+
+	return tegra_pmc_readl(pmc, gate->offs) & BIT(gate->shift) ? 1 : 0;
+}
+
+static int pmc_clk_gate_enable(struct clk_hw *hw)
+{
+	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
+
+	pmc_clk_set_state(gate->offs, gate->shift, 1);
+
+	return 0;
+}
+
+static void pmc_clk_gate_disable(struct clk_hw *hw)
+{
+	struct pmc_clk_gate *gate = to_pmc_clk_gate(hw);
+
+	pmc_clk_set_state(gate->offs, gate->shift, 0);
+}
+
+static const struct clk_ops pmc_clk_gate_ops = {
+	.is_enabled = pmc_clk_gate_is_enabled,
+	.enable = pmc_clk_gate_enable,
+	.disable = pmc_clk_gate_disable,
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
 static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
 				     struct device_node *np)
 {
@@ -2339,6 +2406,8 @@ static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
 	int i, err = -ENOMEM;
 
 	num_clks = pmc->soc->num_pmc_clks;
+	if (pmc->soc->has_blink_output)
+		num_clks += 1;
 
 	if (!num_clks)
 		return;
@@ -2380,6 +2449,37 @@ static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
 		}
 	}
 
+	if (pmc->soc->has_blink_output) {
+		tegra_pmc_writel(pmc, 0x0, PMC_BLINK_TIMER);
+		clk = tegra_pmc_clk_gate_register("blink_override",
+						  "clk_32k", 0,
+						  PMC_DPD_PADS_ORIDE,
+						  PMC_DPD_PADS_ORIDE_BLINK);
+		if (IS_ERR(clk)) {
+			dev_err(pmc->dev, "unable to register blink_override\n");
+			err = PTR_ERR(clk);
+			goto free_clks;
+		}
+
+		clk = tegra_pmc_clk_gate_register("blink",
+						  "blink_override", 0,
+						  PMC_CNTRL,
+						  PMC_CNTRL_BLINK_EN);
+		if (IS_ERR(clk)) {
+			dev_err(pmc->dev, "unable to register blink\n");
+			err = PTR_ERR(clk);
+			goto free_clks;
+		}
+
+		clk_data->clks[TEGRA_PMC_CLK_BLINK] = clk;
+		err = clk_register_clkdev(clk, "blink", NULL);
+		if (err) {
+			dev_err(pmc->dev,
+				"unable to register blink clock lookup\n");
+			goto free_clks;
+		}
+	}
+
 	err = of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
 	if (err) {
 		dev_err(pmc->dev, "failed to add pmc clk provider\n");
@@ -2658,6 +2758,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
+	.has_blink_output = true,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -2707,6 +2808,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -2760,6 +2862,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
 };
 
 static const char * const tegra124_powergates[] = {
@@ -2873,6 +2976,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
 };
 
 static const char * const tegra210_powergates[] = {
@@ -2989,6 +3093,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.wake_events = tegra210_wake_events,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
 };
 
 #define TEGRA186_IO_PAD_TABLE(_pad)					     \
@@ -3120,6 +3225,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.wake_events = tegra186_wake_events,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
+	.has_blink_output = false,
 };
 
 static const struct tegra_io_pad_soc tegra194_io_pads[] = {
@@ -3239,6 +3345,7 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.wake_events = tegra194_wake_events,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
+	.has_blink_output = false,
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
-- 
2.7.4

