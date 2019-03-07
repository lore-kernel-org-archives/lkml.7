Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC45C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77AA20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZUspskAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCGOPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:15:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53983 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfCGOPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:15:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id e74so9412733wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h5CtO0ucQaulmciUoQ1fe7VqyscuYbd4ACXEONNNHhk=;
        b=ZUspskAcoOBQ9Zw+aOrkAlKFkDg3Ol2NeiZeR/1Ts9nXbRT1nanWnblrfX3dxDtcnJ
         ZU94YcCc3LFQaOjiUgBBJ6s9rOiir13pQGpTeFp/hjFmDBZ4lFUOjx99Zd6p65JbMqSH
         sEo5p6uryHipH3S1c/T7lxhlEjsyKJ5zGjuDNyOz7pjP8xivbVdcx2HFe4aE9uorYL8Z
         enA7HuqLYRqn5DHivGj8IuY2SNB1cY6teTtjbANhRB0WbEy4keJqOXVpg2jiHw/Y1rUg
         5LAnRBl3UU6iEnKNPu85lgyxDjDaT1rlys0+HFVtsFz2h/cVrvb2nZ00Zirea94YKcez
         TmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h5CtO0ucQaulmciUoQ1fe7VqyscuYbd4ACXEONNNHhk=;
        b=pzny7s3aqrY0g5EzX90r3fy9EsXAbAr/ZVXZHvMXjanmtK23Ydgm1MukmlCiogtTIK
         zLfbd+IFg5RyjNBMFEvmGvgq/FYc7IICHMpI6BzXaSgIojfyOLOvfXf+lNy9JG4S8Toq
         k0MkPdNr4hgkKUoXyv08d6NgvedC/SKih3GwO4JsdiB4ZhCG3ZPAIGfL3GeNDfonQ9HN
         aQ1/vgGh+wWQiFp3DJ13GHz7UaeBYKhQ0LDgrvPKEiGNz2y06NE5L6EHed7B1Tloljyy
         bKj7sW9vDQ9a1IDXPqnMbyEjMuQU6F1OptQg3TNc2/CU0cm412rDSKIrH6r8YS4f+MFC
         yXZw==
X-Gm-Message-State: APjAAAUn9QkahXB1aUXb21VuhGbbCo1LzOROX24aGTs3K0gl+aQDvw4I
        jW5f5V4NjZjD1FgZ2pY0HbYWmA==
X-Google-Smtp-Source: APXvYqx47eIbcTjMk6Nn35k9CidruU+6YKtfm6BsPjVMrD06M9mHbte9SBUh+BRyTVETzrfS4KZpPg==
X-Received: by 2002:a1c:39d5:: with SMTP id g204mr6128818wma.17.1551968100586;
        Thu, 07 Mar 2019 06:15:00 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h9sm9679304wrv.11.2019.03.07.06.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 06:15:00 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] clk: meson-g12a: add PCIE PLL clocks
Date:   Thu,  7 Mar 2019 15:14:55 +0100
Message-Id: <20190307141455.23879-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307141455.23879-1-narmstrong@baylibre.com>
References: <20190307141455.23879-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PCIe reference clock feeding the USB3 + PCIE combo PHY.

This PLL needs a very precise register sequence to permit to be locked,
thus using the specific clk-pll pcie ops.

The PLL is then followed by :
- a fixed /2 divider
- a 5-bit 1-based divider
- a final /2 divider

This reference clock is fixed to 100MHz, thus only a single PLL setup
is added.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 118 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |   5 +-
 2 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 80a7172df2a6..d382c21a29e5 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -614,6 +614,118 @@ static struct clk_regmap g12a_hifi_pll = {
 	},
 };
 
+/*
+ * The Meson G12A PCIE PLL is fined tuned to deliver a very precise
+ * 100MHz reference clock for the PCIe Analog PHY, and thus requires
+ * a strict register sequence to enable the PLL.
+ */
+static const struct reg_sequence g12a_pcie_pll_init_regs[] = {
+	{ .reg = HHI_PCIE_PLL_CNTL0,	.def = 0x20090496 },
+	{ .reg = HHI_PCIE_PLL_CNTL0,	.def = 0x30090496 },
+	{ .reg = HHI_PCIE_PLL_CNTL1,	.def = 0x00000000 },
+	{ .reg = HHI_PCIE_PLL_CNTL2,	.def = 0x00001100 },
+	{ .reg = HHI_PCIE_PLL_CNTL3,	.def = 0x10058e00 },
+	{ .reg = HHI_PCIE_PLL_CNTL4,	.def = 0x000100c0 },
+	{ .reg = HHI_PCIE_PLL_CNTL5,	.def = 0x68000048 },
+	{ .reg = HHI_PCIE_PLL_CNTL5,	.def = 0x68000068, .delay_us = 20 },
+	{ .reg = HHI_PCIE_PLL_CNTL4,	.def = 0x008100c0, .delay_us = 10 },
+	{ .reg = HHI_PCIE_PLL_CNTL0,	.def = 0x34090496 },
+	{ .reg = HHI_PCIE_PLL_CNTL0,	.def = 0x14090496, .delay_us = 10 },
+	{ .reg = HHI_PCIE_PLL_CNTL2,	.def = 0x00001000 },
+};
+
+/* Keep a single entry table for recalc/round_rate() ops */
+static const struct pll_params_table g12a_pcie_pll_table[] = {
+	PLL_PARAMS(150, 1),
+	{0, 0},
+};
+
+static struct clk_regmap g12a_pcie_pll_dco = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_PCIE_PLL_CNTL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = HHI_PCIE_PLL_CNTL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.n = {
+			.reg_off = HHI_PCIE_PLL_CNTL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = HHI_PCIE_PLL_CNTL1,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.l = {
+			.reg_off = HHI_PCIE_PLL_CNTL0,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_PCIE_PLL_CNTL0,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.table = g12a_pcie_pll_table,
+		.init_regs = g12a_pcie_pll_init_regs,
+		.init_count = ARRAY_SIZE(g12a_pcie_pll_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pcie_pll_dco",
+		.ops = &meson_clk_pcie_pll_ops,
+		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor g12a_pcie_pll_dco_div2 = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "pcie_pll_dco_div2",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "pcie_pll_dco" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_pcie_pll_od = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_PCIE_PLL_CNTL0,
+		.shift = 16,
+		.width = 5,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST |
+			 CLK_DIVIDER_ONE_BASED |
+			 CLK_DIVIDER_ALLOW_ZERO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pcie_pll_od",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "pcie_pll_dco_div2" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor g12a_pcie_pll = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "pcie_pll_pll",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "pcie_pll_od" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static struct clk_regmap g12a_hdmi_pll_dco = {
 	.data = &(struct meson_clk_pll_data){
 		.en = {
@@ -2499,6 +2611,10 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
 		[CLKID_CPU_CLK_AXI]		= &g12a_cpu_clk_axi.hw,
 		[CLKID_CPU_CLK_TRACE_DIV]	= &g12a_cpu_clk_trace_div.hw,
 		[CLKID_CPU_CLK_TRACE]		= &g12a_cpu_clk_trace.hw,
+		[CLKID_PCIE_PLL_DCO]		= &g12a_pcie_pll_dco.hw,
+		[CLKID_PCIE_PLL_DCO_DIV2]	= &g12a_pcie_pll_dco_div2.hw,
+		[CLKID_PCIE_PLL_OD]		= &g12a_pcie_pll_od.hw,
+		[CLKID_PCIE_PLL]		= &g12a_pcie_pll.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -2685,6 +2801,8 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_cpu_clk_axi,
 	&g12a_cpu_clk_trace_div,
 	&g12a_cpu_clk_trace,
+	&g12a_pcie_pll_od,
+	&g12a_pcie_pll_dco,
 };
 
 static const struct meson_eeclkc_data g12a_clkc_data = {
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index 70aa469ca1cf..1393a09730a6 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -186,8 +186,11 @@
 #define CLKID_CPU_CLK_AXI			195
 #define CLKID_CPU_CLK_TRACE_DIV			196
 #define CLKID_CPU_CLK_TRACE			197
+#define CLKID_PCIE_PLL_DCO			198
+#define CLKID_PCIE_PLL_DCO_DIV2			199
+#define CLKID_PCIE_PLL_OD			200
 
-#define NR_CLKS					198
+#define NR_CLKS					202
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
-- 
2.20.1

