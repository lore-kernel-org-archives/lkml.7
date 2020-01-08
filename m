Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE03C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9DD2070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eCYVu+aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgAHE0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:26:45 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10278 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgAHEZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:25:28 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1559870000>; Tue, 07 Jan 2020 20:24:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 20:25:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Jan 2020 20:25:27 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 04:25:27 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 8 Jan 2020 04:25:26 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.162.131]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1559b50000>; Tue, 07 Jan 2020 20:25:26 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 04/21] clk: tegra: Add Tegra OSC to clock lookup
Date:   Tue, 7 Jan 2020 20:24:58 -0800
Message-ID: <1578457515-3477-5-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578457479; bh=GKPxhjaKJ2CxomnsrG8DSoIgQUhEXD4NQLXXH2lZWU8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=eCYVu+aJAUdfv6gqpE3eug68uDdb79remRyflDNqXe5skbj42tPqLSnY2Fny9AeTB
         QlVyNaRDx3zhFMa8TSByMpaapzj6IrzOp46tZGkGDPUtiV4yADhLfgnl+bbHc29tET
         6y3F2x6QZ8virBV57QQRdPuemLhqXEjkpu9MeEss8WaHh/ou/dBIFyYXUpfXL2rJFO
         1QaX4PzQeTR092BVMBlQlqpRBXtGEtw8a5+dvzVm+cprhlMQReWxCR0ASRqrReD/tf
         NkpO16mdk1b1nEJOOljbk1NDbi478rMWpO9NWThG01P1QlJX6BDLDP5qmYkbixTwaw
         b7OYuWORIxa9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OSC is one of the parent for Tegra clocks clk_out_1, clk_out_2,
and clk_out_3.

So, this patch adds Tegra OSC to clock lookup.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-id.h          | 1 +
 drivers/clk/tegra/clk-tegra-fixed.c | 5 +++++
 drivers/clk/tegra/clk-tegra114.c    | 2 ++
 drivers/clk/tegra/clk-tegra124.c    | 2 ++
 drivers/clk/tegra/clk-tegra210.c    | 2 ++
 drivers/clk/tegra/clk-tegra30.c     | 2 ++
 6 files changed, 14 insertions(+)

diff --git a/drivers/clk/tegra/clk-id.h b/drivers/clk/tegra/clk-id.h
index 1bf21766d3e8..cf42e5995794 100644
--- a/drivers/clk/tegra/clk-id.h
+++ b/drivers/clk/tegra/clk-id.h
@@ -44,6 +44,7 @@ enum clk_id {
 	tegra_clk_clk72Mhz,
 	tegra_clk_clk72Mhz_8,
 	tegra_clk_clk_m,
+	tegra_clk_osc,
 	tegra_clk_osc_div2,
 	tegra_clk_osc_div4,
 	tegra_clk_clk_out_1,
diff --git a/drivers/clk/tegra/clk-tegra-fixed.c b/drivers/clk/tegra/clk-tegra-fixed.c
index 8304f8cf9dd2..205d1a6d3e77 100644
--- a/drivers/clk/tegra/clk-tegra-fixed.c
+++ b/drivers/clk/tegra/clk-tegra-fixed.c
@@ -46,7 +46,12 @@ int __init tegra_osc_clk_init(void __iomem *clk_base, struct tegra_clk *clks,
 		return -EINVAL;
 	}
 
+	dt_clk = tegra_lookup_dt_id(tegra_clk_osc, clks);
+	if (!dt_clk)
+		return 0;
+
 	osc = clk_register_fixed_rate(NULL, "osc", NULL, 0, *osc_freq);
+	*dt_clk = osc;
 
 	dt_clk = tegra_lookup_dt_id(tegra_clk_clk_m, clks);
 	if (!dt_clk)
diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 9d2ca387114c..180ddc2abfd2 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -735,6 +735,7 @@ static struct tegra_clk tegra114_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_fuse_burn] = { .dt_id = TEGRA114_CLK_FUSE_BURN, .present = true },
 	[tegra_clk_clk_32k] = { .dt_id = TEGRA114_CLK_CLK_32K, .present = true },
 	[tegra_clk_clk_m] = { .dt_id = TEGRA114_CLK_CLK_M, .present = true },
+	[tegra_clk_osc] = { .dt_id = TEGRA114_CLK_OSC, .present = true },
 	[tegra_clk_osc_div2] = { .dt_id = TEGRA114_CLK_OSC_DIV2, .present = true },
 	[tegra_clk_osc_div4] = { .dt_id = TEGRA114_CLK_OSC_DIV4, .present = true },
 	[tegra_clk_pll_ref] = { .dt_id = TEGRA114_CLK_PLL_REF, .present = true },
@@ -815,6 +816,7 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "clk_m", .dt_id = TEGRA114_CLK_CLK_M },
 	{ .con_id = "pll_ref", .dt_id = TEGRA114_CLK_PLL_REF },
 	{ .con_id = "clk_32k", .dt_id = TEGRA114_CLK_CLK_32K },
+	{ .con_id = "osc", .dt_id = TEGRA114_CLK_OSC },
 	{ .con_id = "osc_div2", .dt_id = TEGRA114_CLK_OSC_DIV2 },
 	{ .con_id = "osc_div4", .dt_id = TEGRA114_CLK_OSC_DIV4 },
 	{ .con_id = "pll_c", .dt_id = TEGRA114_CLK_PLL_C },
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 15f42718f4cb..7a16e50eb20f 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -860,6 +860,7 @@ static struct tegra_clk tegra124_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_fuse_burn] = { .dt_id = TEGRA124_CLK_FUSE_BURN, .present = true },
 	[tegra_clk_clk_32k] = { .dt_id = TEGRA124_CLK_CLK_32K, .present = true },
 	[tegra_clk_clk_m] = { .dt_id = TEGRA124_CLK_CLK_M, .present = true },
+	[tegra_clk_osc] = { .dt_id = TEGRA124_CLK_OSC, .present = true },
 	[tegra_clk_osc_div2] = { .dt_id = TEGRA124_CLK_OSC_DIV2, .present = true },
 	[tegra_clk_osc_div4] = { .dt_id = TEGRA124_CLK_OSC_DIV4, .present = true },
 	[tegra_clk_pll_ref] = { .dt_id = TEGRA124_CLK_PLL_REF, .present = true },
@@ -941,6 +942,7 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "clk_m", .dt_id = TEGRA124_CLK_CLK_M },
 	{ .con_id = "pll_ref", .dt_id = TEGRA124_CLK_PLL_REF },
 	{ .con_id = "clk_32k", .dt_id = TEGRA124_CLK_CLK_32K },
+	{ .con_id = "osc", .dt_id = TEGRA124_CLK_OSC },
 	{ .con_id = "osc_div2", .dt_id = TEGRA124_CLK_OSC_DIV2 },
 	{ .con_id = "osc_div4", .dt_id = TEGRA124_CLK_OSC_DIV4 },
 	{ .con_id = "pll_c", .dt_id = TEGRA124_CLK_PLL_C },
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index 5687fcda620e..45d54ead30bc 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -2371,6 +2371,7 @@ static struct tegra_clk tegra210_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_fuse_burn] = { .dt_id = TEGRA210_CLK_FUSE_BURN, .present = true },
 	[tegra_clk_clk_32k] = { .dt_id = TEGRA210_CLK_CLK_32K, .present = true },
 	[tegra_clk_clk_m] = { .dt_id = TEGRA210_CLK_CLK_M, .present = true },
+	[tegra_clk_osc] = { .dt_id = TEGRA210_CLK_OSC, .present = true },
 	[tegra_clk_osc_div2] = { .dt_id = TEGRA210_CLK_OSC_DIV2, .present = true },
 	[tegra_clk_osc_div4] = { .dt_id = TEGRA210_CLK_OSC_DIV4, .present = true },
 	[tegra_clk_pll_ref] = { .dt_id = TEGRA210_CLK_PLL_REF, .present = true },
@@ -2497,6 +2498,7 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "clk_m", .dt_id = TEGRA210_CLK_CLK_M },
 	{ .con_id = "pll_ref", .dt_id = TEGRA210_CLK_PLL_REF },
 	{ .con_id = "clk_32k", .dt_id = TEGRA210_CLK_CLK_32K },
+	{ .con_id = "osc", .dt_id = TEGRA210_CLK_OSC },
 	{ .con_id = "osc_div2", .dt_id = TEGRA210_CLK_OSC_DIV2 },
 	{ .con_id = "osc_div4", .dt_id = TEGRA210_CLK_OSC_DIV4 },
 	{ .con_id = "pll_c", .dt_id = TEGRA210_CLK_PLL_C },
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 1322188edb72..ddc5ab66d09e 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -581,6 +581,7 @@ static struct tegra_devclk devclks[] __initdata = {
 	{ .con_id = "twd", .dt_id = TEGRA30_CLK_TWD },
 	{ .con_id = "emc", .dt_id = TEGRA30_CLK_EMC },
 	{ .con_id = "clk_32k", .dt_id = TEGRA30_CLK_CLK_32K },
+	{ .con_id = "osc", .dt_id = TEGRA30_CLK_OSC },
 	{ .con_id = "osc_div2", .dt_id = TEGRA30_CLK_OSC_DIV2 },
 	{ .con_id = "osc_div4", .dt_id = TEGRA30_CLK_OSC_DIV4 },
 	{ .con_id = "cml0", .dt_id = TEGRA30_CLK_CML0 },
@@ -683,6 +684,7 @@ static struct tegra_devclk devclks[] __initdata = {
 static struct tegra_clk tegra30_clks[tegra_clk_max] __initdata = {
 	[tegra_clk_clk_32k] = { .dt_id = TEGRA30_CLK_CLK_32K, .present = true },
 	[tegra_clk_clk_m] = { .dt_id = TEGRA30_CLK_CLK_M, .present = true },
+	[tegra_clk_osc] = { .dt_id = TEGRA30_CLK_OSC, .present = true },
 	[tegra_clk_osc_div2] = { .dt_id = TEGRA30_CLK_OSC_DIV2, .present = true },
 	[tegra_clk_osc_div4] = { .dt_id = TEGRA30_CLK_OSC_DIV4, .present = true },
 	[tegra_clk_pll_ref] = { .dt_id = TEGRA30_CLK_PLL_REF, .present = true },
-- 
2.7.4

