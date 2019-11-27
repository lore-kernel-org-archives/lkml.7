Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EDFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEA32068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Lb+W6WYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfK0E7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 23:59:44 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11633 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfK0E7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:59:41 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dde02b60000>; Tue, 26 Nov 2019 20:59:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Nov 2019 20:59:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Nov 2019 20:59:40 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 04:59:39 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Nov 2019 04:59:40 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.149]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dde02ba0000>; Tue, 26 Nov 2019 20:59:39 -0800
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
Subject: [PATCH v2 04/11] soc: pmc: Add blink output clock registration to Tegra PMC
Date:   Tue, 26 Nov 2019 20:59:26 -0800
Message-ID: <1574830773-14892-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574830774; bh=TfKgyWZTASSf3asbrgZ64d0Y0naAlv7IzlVo3FtKWEM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Lb+W6WYMF26WIM0HfNJOjz23PMLCgISnBYndOMRaV38YqVb+ZSzS7CRiWKnldY1zA
         SxPLIYSCmPTHh0hhcmAM78vSlr/kCd0Cxpc2WgDu7Sfn3V9RKu3148YYFbQF34l4X/
         MoKP4Qt8r01BE6+R5a33Fw32uPOHMYkNd33I2ldqucEdxbNMmb/ERCnpaV8jnsnEC2
         y+nmxXsdJju/12NCr7v/vNy9dpz1Ezyewxm3fi/tn2ExT39tGwJ2+DMH5EM+44XWMX
         4s6GI1A4AZvNbhZgYHhzSgvNxAoiYeP3Mj/2ra+A6wj+oyZz9pGUu7FHqthnbhyhpa
         vi/ItFvk74NkQ==
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
 drivers/soc/tegra/pmc.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index a353f6d0a832..1cfb7797dbd5 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -61,12 +61,15 @@
 #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
 #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
 #define  PMC_CNTRL_PWRREQ_POLARITY	BIT(8)
+#define  PMC_CNTRL_BLINK_EN		BIT(7)
 #define  PMC_CNTRL_MAIN_RST		BIT(4)
 
 #define PMC_WAKE_MASK			0x0c
 #define PMC_WAKE_LEVEL			0x10
 #define PMC_WAKE_STATUS			0x14
 #define PMC_SW_WAKE_STATUS		0x18
+#define PMC_DPD_PADS_ORIDE		0x1c
+#define  PMC_DPD_PADS_ORIDE_BLINK	BIT(20)
 
 #define DPD_SAMPLE			0x020
 #define  DPD_SAMPLE_ENABLE		BIT(0)
@@ -79,6 +82,7 @@
 
 #define PWRGATE_STATUS			0x38
 
+#define TEGRA210_PMC_BLINK_TIMER	0x40
 #define PMC_IMPL_E_33V_PWR		0x40
 
 #define PMC_PWR_DET			0x48
@@ -347,6 +351,8 @@ struct tegra_pmc_soc {
 
 	struct pmc_clk_init_data *pmc_clks_data;
 	unsigned int num_pmc_clks;
+	bool has_blink_output;
+	bool blink_init_state;
 };
 
 static const char * const tegra186_reset_sources[] = {
@@ -2396,6 +2402,9 @@ static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
 	/* each pmc clock output has a mux and a gate */
 	num_clks = pmc->soc->num_pmc_clks * 2;
 
+	if (pmc->soc->has_blink_output)
+		num_clks += 1;
+
 	if (!num_clks)
 		return;
 
@@ -2468,6 +2477,34 @@ static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
 		}
 	}
 
+	if (pmc->soc->has_blink_output) {
+		tegra_pmc_writel(pmc, 0x0, TEGRA210_PMC_BLINK_TIMER);
+		clk = tegra_pmc_clk_gate_register("blink_override",
+						  "clk_32k", 0,
+						  PMC_DPD_PADS_ORIDE,
+						  PMC_DPD_PADS_ORIDE_BLINK);
+		if (IS_ERR(clk))
+			goto free_clks;
+
+		clk = tegra_pmc_clk_gate_register("blink",
+						  "blink_override", 0,
+						  PMC_CNTRL,
+						  PMC_CNTRL_BLINK_EN);
+		if (IS_ERR(clk))
+			goto free_clks;
+
+		clk_data->clks[TEGRA_PMC_CLK_BLINK] = clk;
+		clk_register_clkdev(clk, "blink", NULL);
+
+		if (pmc->soc->blink_init_state) {
+			if (clk_prepare_enable(clk)) {
+				pr_err("%s: Failed to enable %s\n", __func__,
+				       __clk_get_name(clk));
+				WARN_ON(1);
+			}
+		}
+	}
+
 	of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
 
 	return;
@@ -2740,6 +2777,8 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
+	.has_blink_output = true,
+	.blink_init_state = true,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -2789,6 +2828,8 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
+	.blink_init_state = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -2842,6 +2883,8 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
+	.blink_init_state = false,
 };
 
 static const char * const tegra124_powergates[] = {
@@ -2955,6 +2998,8 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.num_reset_levels = 0,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
+	.blink_init_state = false,
 };
 
 static const char * const tegra210_powergates[] = {
@@ -3071,6 +3116,8 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.wake_events = tegra210_wake_events,
 	.pmc_clks_data = tegra_pmc_clks_data,
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
+	.has_blink_output = true,
+	.blink_init_state = false,
 };
 
 #define TEGRA186_IO_PAD_TABLE(_pad)					     \
@@ -3202,6 +3249,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.wake_events = tegra186_wake_events,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
+	.has_blink_output = false,
 };
 
 static const struct tegra_io_pad_soc tegra194_io_pads[] = {
@@ -3321,6 +3369,7 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.wake_events = tegra194_wake_events,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
+	.has_blink_output = false,
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
-- 
2.7.4

