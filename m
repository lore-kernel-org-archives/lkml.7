Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40679C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF22521655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SfLXjyD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfG2NRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:17:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37613 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfG2NRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:17:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so53425910wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n59MsecaBkqw2qE8/Yo+ygx1q7wUZOVhBnJAz2Z56ms=;
        b=SfLXjyD78vy3/Wft2Llbajum/zAVMypCCAD22eABsyzEHO1nPjC0b1tzzOYKoFEybB
         khXnPEc/oQzYGw65QXt9E2TaATSAD/u/F6TVaNHmMxlcsMJ+dgCkqUTXuNFiXyOXIARs
         ME39fhZU5bDEZcg67h6nWvtylweXUwgaJ7g3OKPeHLcSyyQWDUSOnbdDwupMKRrX8y6e
         6eIolzWSW48mhMdH+tBy2Xpi5OS4pAG6xlOCw9Yw+W1b9vWkRpdCqX6kbVEcqqcdN0Pe
         c5/mXvk5KjCtnX+Om2QgP5QTu6d3yRvUbiO0jgV9150kbrBK4IZFLfEV/FkGdMCPnCQ2
         yDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n59MsecaBkqw2qE8/Yo+ygx1q7wUZOVhBnJAz2Z56ms=;
        b=eFCSFlNAoDNeGUlBWwRzPNN5WIr/Ize9O5uKUPixkd55E8OuDlvGg8eD5jJdOfPH76
         X9VQHcjTojjfRabTPSUaICFCQacMR+aojSSYlZIrowoLob3EELXbCG/JLQ25vrZp5xPZ
         HThmTdIo/AgkJhUR0+gSL/eEHsGuHJAWh9ihwkPUPqskZ/xetcieKekcZ7ByVDhTT4h/
         PrG0+/D7hfGso9xQYhFpSWTuTNo6B0cUi3yPasWxqsY3W0ZiLgh1CgpWGM9d1MMJ0qLg
         EPKG1rLY8Aa6Vqhoj43Xq14CFsvKYrtEKYqbcZT2tb/lGBBf4Vu+mndmpUscldN7bU00
         ahiA==
X-Gm-Message-State: APjAAAVlq9rsuuTcTYD8b9CGpnV90aKegvt1tnQn5qLWSspwU3KlbTEs
        enS0SAXaNYpssnvOQWb1oI5tVg==
X-Google-Smtp-Source: APXvYqwq5uhv7avmu1uL7fbVQbxKgv7vFCXAeuxl5e5ex811pcC3YXCQ/pxi30XYlDsy5yuOJmoD5g==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr103880602wmj.13.1564406221462;
        Mon, 29 Jul 2019 06:17:01 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b5sm52520490wru.69.2019.07.29.06.17.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:17:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] clk: meson: g12a: add notifiers to handle cpu clock change
Date:   Mon, 29 Jul 2019 15:16:55 +0200
Message-Id: <20190729131656.7308-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729131656.7308-1-narmstrong@baylibre.com>
References: <20190729131656.7308-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to implement clock switching for the CLKID_CPU_CLK and
CLKID_CPUB_CLK, notifiers are added on specific points of the
clock tree :

cpu_clk / cpub_clk
|   \- cpu_clk_dyn
|      |  \- cpu_clk_premux0
|      |        |- cpu_clk_postmux0
|      |        |    |- cpu_clk_dyn0_div
|      |        |    \- xtal/fclk_div2/fclk_div3
|      |        \- xtal/fclk_div2/fclk_div3
|      \- cpu_clk_premux1
|            |- cpu_clk_postmux1
|            |    |- cpu_clk_dyn1_div
|            |    \- xtal/fclk_div2/fclk_div3
|            \- xtal/fclk_div2/fclk_div3
\ sys_pll / sys1_pll

This for each cluster, a single one for G12A, two for G12B.

Each cpu_clk_premux1 tree is marked as read-only and CLK_SET_RATE_NO_REPARENT,
to be used as "parking" clock in a safe clock frequency.

A notifier is added on each cpu_clk_premux0 to detech when CCF want to
change the frequency of the cpu_clk_dyn tree.
In this notifier, the cpu_clk_premux1 tree is configured to use the xtal
clock and then the cpu_clk_dyn is switch to cpu_clk_premux1 while CCF
updates the cpu_clk_premux0 tree.

A notifier is added on each sys_pll/sys1_pll to detect when CCF wants to
change the PLL clock source of the cpu_clk.
In this notifier, the cpu_clk is switched to cpu_clk_dyn while CCF
updates the sys_pll/sys1_pll frequency.

A third small notifier is added on each cpu_clk / cpub_clk and cpu_clk_dyn,
add a small delay at PRE_RATE_CHANGE/POST_RATE_CHANGE to let the other
notofiers change propagate before changing the cpu_clk_premux0 and sys_pll
clock trees.

This notifier set permits switching the cpu_clk / cpub_clk without any
glitches and using a safe parking clock while switching between sub-GHz
clocks using the cpu_clk_dyn tree.

This setup has been tested and validated on the Amlogic G12A and G12B
SoCs running the arm64 cpuburn at [1] and cycling between all the possible
cpufreq translations of each cluster and checking the final frequency using
the clock-measurer, script at [2].

[1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
[2] https://gist.github.com/superna9999/d4de964dbc0f84b7d527e1df2ddea25f
---
 drivers/clk/meson/g12a.c | 567 +++++++++++++++++++++++++++++++++++----
 1 file changed, 521 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index e4957fd9f91f..23162310c7ee 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 
 #include "clk-mpll.h"
 #include "clk-pll.h"
@@ -88,16 +89,9 @@ static struct clk_regmap g12a_fixed_pll = {
 	},
 };
 
-/*
- * Internal sys pll emulation configuration parameters
- */
-static const struct reg_sequence g12a_sys_init_regs[] = {
-	{ .reg = HHI_SYS_PLL_CNTL1,	.def = 0x00000000 },
-	{ .reg = HHI_SYS_PLL_CNTL2,	.def = 0x00000000 },
-	{ .reg = HHI_SYS_PLL_CNTL3,	.def = 0x48681c00 },
-	{ .reg = HHI_SYS_PLL_CNTL4,	.def = 0x88770290 },
-	{ .reg = HHI_SYS_PLL_CNTL5,	.def = 0x39272000 },
-	{ .reg = HHI_SYS_PLL_CNTL6,	.def = 0x56540000 },
+static const struct pll_mult_range g12a_sys_pll_mult_range = {
+	.min = 128,
+	.max = 250,
 };
 
 static struct clk_regmap g12a_sys_pll_dco = {
@@ -127,16 +121,17 @@ static struct clk_regmap g12a_sys_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.init_regs = g12a_sys_init_regs,
-		.init_count = ARRAY_SIZE(g12a_sys_init_regs),
+		.range = &g12a_sys_pll_mult_range,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll_dco",
-		.ops = &meson_clk_pll_ro_ops,
+		.ops = &meson_clk_pll_ops,
 		.parent_data = &(const struct clk_parent_data) {
 			.fw_name = "xtal",
 		},
 		.num_parents = 1,
+		/* This clock feeds the CPU, avoid disabling it */
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
@@ -149,11 +144,12 @@ static struct clk_regmap g12a_sys_pll = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12a_sys_pll_dco.hw
 		},
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -184,14 +180,17 @@ static struct clk_regmap g12b_sys1_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
+		.range = &g12a_sys_pll_mult_range,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys1_pll_dco",
-		.ops = &meson_clk_pll_ro_ops,
+		.ops = &meson_clk_pll_ops,
 		.parent_data = &(const struct clk_parent_data) {
 			.fw_name = "xtal",
 		},
 		.num_parents = 1,
+		/* This clock feeds the CPU, avoid disabling it */
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
@@ -204,11 +203,12 @@ static struct clk_regmap g12b_sys1_pll = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys1_pll",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12b_sys1_pll_dco.hw
 		},
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -345,13 +345,15 @@ static struct clk_regmap g12a_cpu_clk_premux0 = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_dyn0_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_data = (const struct clk_parent_data []) {
 			{ .fw_name = "xtal", },
 			{ .hw = &g12a_fclk_div2.hw },
 			{ .hw = &g12a_fclk_div3.hw },
 		},
 		.num_parents = 3,
+		/* This sub-tree is used a parking clock */
+		.flags = CLK_SET_RATE_NO_REPARENT,
 	},
 };
 
@@ -364,16 +366,50 @@ static struct clk_regmap g12a_cpu_clk_premux1 = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_dyn1_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_data = (const struct clk_parent_data []) {
 			{ .fw_name = "xtal", },
 			{ .hw = &g12a_fclk_div2.hw },
 			{ .hw = &g12a_fclk_div3.hw },
 		},
 		.num_parents = 3,
+		/* This sub-tree is used a parking clock */
+		.flags = CLK_SET_RATE_NO_REPARENT
 	},
 };
 
+#define SYS_CPU_DYN_ENABLE	BIT(26)
+
+/* This divider uses bit 26 to take change in account */
+static int g12a_cpu_clk_mux0_div_set_rate(struct clk_hw *hw, unsigned long rate,
+					  unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
+	unsigned int val;
+	int ret;
+
+	ret = divider_get_val(rate, parent_rate, div->table, div->width,
+			      div->flags);
+	if (ret < 0)
+		return ret;
+
+	val = (unsigned int)ret << div->shift;
+
+	regmap_update_bits(clk->map, HHI_SYS_CPU_CLK_CNTL0,
+			   SYS_CPU_DYN_ENABLE, SYS_CPU_DYN_ENABLE);
+
+	return regmap_update_bits(clk->map, div->offset,
+				  clk_div_mask(div->width) << div->shift |
+				  SYS_CPU_DYN_ENABLE, val);
+};
+
+const struct clk_ops g12a_cpu_clk_mux0_div_ops = {
+	.recalc_rate = clk_regmap_div_recalc_rate,
+	.round_rate = clk_regmap_div_round_rate,
+	.set_rate = g12a_cpu_clk_mux0_div_set_rate,
+};
+
 /* Datasheet names this field as "mux0_divn_tcnt" */
 static struct clk_regmap g12a_cpu_clk_mux0_div = {
 	.data = &(struct clk_regmap_div_data){
@@ -383,11 +419,12 @@ static struct clk_regmap g12a_cpu_clk_mux0_div = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_dyn0_div",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &g12a_cpu_clk_mux0_div_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12a_cpu_clk_premux0.hw
 		},
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -400,12 +437,13 @@ static struct clk_regmap g12a_cpu_clk_postmux0 = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_dyn0",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12a_cpu_clk_premux0.hw,
 			&g12a_cpu_clk_mux0_div.hw,
 		},
 		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -435,12 +473,14 @@ static struct clk_regmap g12a_cpu_clk_postmux1 = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_dyn1",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12a_cpu_clk_premux1.hw,
 			&g12a_cpu_clk_mux1_div.hw,
 		},
 		.num_parents = 2,
+		/* This sub-tree is used a parking clock */
+		.flags = CLK_SET_RATE_NO_REPARENT,
 	},
 };
 
@@ -453,12 +493,13 @@ static struct clk_regmap g12a_cpu_clk_dyn = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk_dyn",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12a_cpu_clk_postmux0.hw,
 			&g12a_cpu_clk_postmux1.hw,
 		},
 		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -471,12 +512,13 @@ static struct clk_regmap g12a_cpu_clk = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12a_cpu_clk_dyn.hw,
 			&g12a_sys_pll.hw,
 		},
 		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -489,12 +531,13 @@ static struct clk_regmap g12b_cpu_clk = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12a_cpu_clk_dyn.hw,
 			&g12b_sys1_pll.hw
 		},
 		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -507,7 +550,7 @@ static struct clk_regmap g12b_cpub_clk_premux0 = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpub_clk_dyn0_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_data = (const struct clk_parent_data []) {
 			{ .fw_name = "xtal", },
 			{ .hw = &g12a_fclk_div2.hw },
@@ -517,6 +560,37 @@ static struct clk_regmap g12b_cpub_clk_premux0 = {
 	},
 };
 
+/* This divider uses bit 26 to take change in account */
+static int g12b_cpub_clk_mux0_div_set_rate(struct clk_hw *hw,
+					   unsigned long rate,
+					   unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
+	unsigned int val;
+	int ret;
+
+	ret = divider_get_val(rate, parent_rate, div->table, div->width,
+			      div->flags);
+	if (ret < 0)
+		return ret;
+
+	val = (unsigned int)ret << div->shift;
+
+	regmap_update_bits(clk->map, HHI_SYS_CPUB_CLK_CNTL,
+			   SYS_CPU_DYN_ENABLE, SYS_CPU_DYN_ENABLE);
+
+	return regmap_update_bits(clk->map, div->offset,
+				  clk_div_mask(div->width) << div->shift |
+				  SYS_CPU_DYN_ENABLE, val);
+};
+
+static const struct clk_ops g12b_cpub_clk_mux0_div_ops = {
+	.recalc_rate = clk_regmap_div_recalc_rate,
+	.round_rate = clk_regmap_div_round_rate,
+	.set_rate = g12b_cpub_clk_mux0_div_set_rate,
+};
+
 /* Datasheet names this field as "mux0_divn_tcnt" */
 static struct clk_regmap g12b_cpub_clk_mux0_div = {
 	.data = &(struct clk_regmap_div_data){
@@ -526,11 +600,12 @@ static struct clk_regmap g12b_cpub_clk_mux0_div = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpub_clk_dyn0_div",
-		.ops = &clk_regmap_divider_ro_ops,
+		.ops = &g12b_cpub_clk_mux0_div_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12b_cpub_clk_premux0.hw
 		},
 		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -543,12 +618,13 @@ static struct clk_regmap g12b_cpub_clk_postmux0 = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpub_clk_dyn0",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12b_cpub_clk_premux0.hw,
 			&g12b_cpub_clk_mux0_div.hw
 		},
 		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -561,13 +637,15 @@ static struct clk_regmap g12b_cpub_clk_premux1 = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpub_clk_dyn1_sel",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_data = (const struct clk_parent_data []) {
 			{ .fw_name = "xtal", },
 			{ .hw = &g12a_fclk_div2.hw },
 			{ .hw = &g12a_fclk_div3.hw },
 		},
 		.num_parents = 3,
+		/* This sub-tree is used a parking clock */
+		.flags = CLK_SET_RATE_NO_REPARENT,
 	},
 };
 
@@ -597,12 +675,14 @@ static struct clk_regmap g12b_cpub_clk_postmux1 = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpub_clk_dyn1",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12b_cpub_clk_premux1.hw,
 			&g12b_cpub_clk_mux1_div.hw
 		},
 		.num_parents = 2,
+		/* This sub-tree is used a parking clock */
+		.flags = CLK_SET_RATE_NO_REPARENT,
 	},
 };
 
@@ -615,12 +695,13 @@ static struct clk_regmap g12b_cpub_clk_dyn = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpub_clk_dyn",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12b_cpub_clk_postmux0.hw,
 			&g12b_cpub_clk_postmux1.hw
 		},
 		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -633,15 +714,227 @@ static struct clk_regmap g12b_cpub_clk = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpub_clk",
-		.ops = &clk_regmap_mux_ro_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_hws = (const struct clk_hw *[]) {
 			&g12b_cpub_clk_dyn.hw,
 			&g12a_sys_pll.hw
 		},
 		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
+static int g12a_cpu_clk_mux_notifier_cb(struct notifier_block *nb,
+					unsigned long event, void *data)
+{
+	if (event == POST_RATE_CHANGE || event == PRE_RATE_CHANGE) {
+		/* Wait for clock propagation before/after changing the mux */
+		udelay(100);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block g12a_cpu_clk_mux_nb = {
+	.notifier_call = g12a_cpu_clk_mux_notifier_cb,
+};
+
+struct g12a_cpu_clk_postmux_nb_data {
+	struct notifier_block nb;
+	struct clk_hw *xtal;
+	struct clk_hw *cpu_clk_dyn;
+	struct clk_hw *cpu_clk_postmux0;
+	struct clk_hw *cpu_clk_postmux1;
+	struct clk_hw *cpu_clk_premux1;
+};
+
+static int g12a_cpu_clk_postmux_notifier_cb(struct notifier_block *nb,
+					    unsigned long event, void *data)
+{
+	struct g12a_cpu_clk_postmux_nb_data *nb_data =
+		container_of(nb, struct g12a_cpu_clk_postmux_nb_data, nb);
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		/*
+		 * This notifier means cpu_clk_postmux0 clock will be changed
+		 * to feed cpu_clk, this is the current path :
+		 * cpu_clk
+		 *    \- cpu_clk_dyn
+		 *          \- cpu_clk_postmux0
+		 *                \- cpu_clk_muxX_div
+		 *                      \- cpu_clk_premux0
+		 *				\- fclk_div3 or fclk_div2
+		 *		OR
+		 *                \- cpu_clk_premux0
+		 *			\- fclk_div3 or fclk_div2
+		 */
+
+		/* Setup cpu_clk_premux1 to xtal */
+		clk_hw_set_parent(nb_data->cpu_clk_premux1,
+				  nb_data->xtal);
+
+		/* Setup cpu_clk_postmux1 to bypass divider */
+		clk_hw_set_parent(nb_data->cpu_clk_postmux1,
+				  nb_data->cpu_clk_premux1);
+
+		/* Switch to parking clk on cpu_clk_postmux1 */
+		clk_hw_set_parent(nb_data->cpu_clk_dyn,
+				  nb_data->cpu_clk_postmux1);
+
+		/*
+		 * Now, cpu_clk is 24MHz in the current path :
+		 * cpu_clk
+		 *    \- cpu_clk_dyn
+		 *          \- cpu_clk_postmux1
+		 *                \- cpu_clk_premux1
+		 *                      \- xtal
+		 */
+
+		udelay(100);
+
+		return NOTIFY_OK;
+
+	case POST_RATE_CHANGE:
+		/*
+		 * The cpu_clk_postmux0 has ben updated, now switch back
+		 * cpu_clk_dyn to cpu_clk_postmux0 and take the changes
+		 * in account.
+		 */
+
+		/* Configure cpu_clk_dyn back to cpu_clk_postmux0 */
+		clk_hw_set_parent(nb_data->cpu_clk_dyn,
+				  nb_data->cpu_clk_postmux0);
+
+		/*
+		 * new path :
+		 * cpu_clk
+		 *    \- cpu_clk_dyn
+		 *          \- cpu_clk_postmux0
+		 *                \- cpu_clk_muxX_div
+		 *                      \- cpu_clk_premux0
+		 *				\- fclk_div3 or fclk_div2
+		 *		OR
+		 *                \- cpu_clk_premux0
+		 *			\- fclk_div3 or fclk_div2
+		 */
+
+		udelay(100);
+
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct g12a_cpu_clk_postmux_nb_data g12a_cpu_clk_postmux0_nb_data = {
+	.cpu_clk_dyn = &g12a_cpu_clk_dyn.hw,
+	.cpu_clk_postmux0 = &g12a_cpu_clk_postmux0.hw,
+	.cpu_clk_postmux1 = &g12a_cpu_clk_postmux1.hw,
+	.cpu_clk_premux1 = &g12a_cpu_clk_premux1.hw,
+	.nb.notifier_call = g12a_cpu_clk_postmux_notifier_cb,
+};
+
+static struct g12a_cpu_clk_postmux_nb_data g12b_cpub_clk_postmux0_nb_data = {
+	.cpu_clk_dyn = &g12b_cpub_clk_dyn.hw,
+	.cpu_clk_postmux0 = &g12b_cpub_clk_postmux0.hw,
+	.cpu_clk_postmux1 = &g12b_cpub_clk_postmux1.hw,
+	.cpu_clk_premux1 = &g12b_cpub_clk_premux1.hw,
+	.nb.notifier_call = g12a_cpu_clk_postmux_notifier_cb,
+};
+
+struct g12a_sys_pll_nb_data {
+	struct notifier_block nb;
+	struct clk_hw *sys_pll;
+	struct clk_hw *cpu_clk;
+	struct clk_hw *cpu_clk_dyn;
+};
+
+static int g12a_sys_pll_notifier_cb(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct g12a_sys_pll_nb_data *nb_data =
+		container_of(nb, struct g12a_sys_pll_nb_data, nb);
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		/*
+		 * This notifier means sys_pll clock will be changed
+		 * to feed cpu_clk, this the current path :
+		 * cpu_clk
+		 *    \- sys_pll
+		 *          \- sys_pll_dco
+		 */
+
+		/* Configure cpu_clk to use cpu_clk_dyn */
+		clk_hw_set_parent(nb_data->cpu_clk,
+				  nb_data->cpu_clk_dyn);
+
+		/*
+		 * Now, cpu_clk uses the dyn path
+		 * cpu_clk
+		 *    \- cpu_clk_dyn
+		 *          \- cpu_clk_dynX
+		 *                \- cpu_clk_dynX_sel
+		 *		     \- cpu_clk_dynX_div
+		 *                      \- xtal/fclk_div2/fclk_div3
+		 *                   \- xtal/fclk_div2/fclk_div3
+		 */
+
+		udelay(100);
+
+		return NOTIFY_OK;
+
+	case POST_RATE_CHANGE:
+		/*
+		 * The sys_pll has ben updated, now switch back cpu_clk to
+		 * sys_pll
+		 */
+
+		/* Configure cpu_clk to use sys_pll */
+		clk_hw_set_parent(nb_data->cpu_clk,
+				  nb_data->sys_pll);
+
+		udelay(100);
+
+		/* new path :
+		 * cpu_clk
+		 *    \- sys_pll
+		 *          \- sys_pll_dco
+		 */
+
+		return NOTIFY_OK;
+
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct g12a_sys_pll_nb_data g12a_sys_pll_nb_data = {
+	.sys_pll = &g12a_sys_pll.hw,
+	.cpu_clk = &g12a_cpu_clk.hw,
+	.cpu_clk_dyn = &g12a_cpu_clk_dyn.hw,
+	.nb.notifier_call = g12a_sys_pll_notifier_cb,
+};
+
+/* G12B first CPU cluster uses sys1_pll */
+static struct g12a_sys_pll_nb_data g12b_cpu_clk_sys1_pll_nb_data = {
+	.sys_pll = &g12b_sys1_pll.hw,
+	.cpu_clk = &g12b_cpu_clk.hw,
+	.cpu_clk_dyn = &g12a_cpu_clk_dyn.hw,
+	.nb.notifier_call = g12a_sys_pll_notifier_cb,
+};
+
+/* G12B second CPU cluster uses sys_pll */
+static struct g12a_sys_pll_nb_data g12b_cpub_clk_sys_pll_nb_data = {
+	.sys_pll = &g12a_sys_pll.hw,
+	.cpu_clk = &g12b_cpub_clk.hw,
+	.cpu_clk_dyn = &g12b_cpub_clk_dyn.hw,
+	.nb.notifier_call = g12a_sys_pll_notifier_cb,
+};
+
 static struct clk_regmap g12a_cpu_clk_div16_en = {
 	.data = &(struct clk_regmap_gate_data){
 		.offset = HHI_SYS_CPU_CLK_CNTL1,
@@ -4097,28 +4390,210 @@ static const struct reg_sequence g12a_init_regs[] = {
 	{ .reg = HHI_MPLL_CNTL0,	.def = 0x00000543 },
 };
 
-static const struct meson_eeclkc_data g12a_clkc_data = {
-	.regmap_clks = g12a_clk_regmaps,
-	.regmap_clk_num = ARRAY_SIZE(g12a_clk_regmaps),
-	.hw_onecell_data = &g12a_hw_onecell_data,
-	.init_regs = g12a_init_regs,
-	.init_count = ARRAY_SIZE(g12a_init_regs),
-};
-
-static const struct meson_eeclkc_data g12b_clkc_data = {
-	.regmap_clks = g12a_clk_regmaps,
-	.regmap_clk_num = ARRAY_SIZE(g12a_clk_regmaps),
-	.hw_onecell_data = &g12b_hw_onecell_data
+static int meson_g12a_dvfs_setup_common(struct platform_device *pdev,
+					struct clk_hw **hws)
+{
+	const char *notifier_clk_name;
+	struct clk *notifier_clk;
+	struct clk_hw *xtal;
+	int ret;
+
+	xtal = clk_hw_get_parent_by_index(hws[CLKID_CPU_CLK_DYN1_SEL], 0);
+
+	/* Setup clock notifier for cpu_clk_postmux0 */
+	g12a_cpu_clk_postmux0_nb_data.xtal = xtal;
+	notifier_clk_name = clk_hw_get_name(&g12a_cpu_clk_postmux0.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk,
+				    &g12a_cpu_clk_postmux0_nb_data.nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register the cpu_clk_postmux0 notifier\n");
+		return ret;
+	}
+
+	/* Setup clock notifier for cpu_clk_dyn mux */
+	notifier_clk_name = clk_hw_get_name(&g12a_cpu_clk_dyn.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register the cpu_clk_dyn notifier\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int meson_g12b_dvfs_setup(struct platform_device *pdev)
+{
+	struct clk_hw **hws = g12b_hw_onecell_data.hws;
+	const char *notifier_clk_name;
+	struct clk *notifier_clk;
+	struct clk_hw *xtal;
+	int ret;
+
+	ret = meson_g12a_dvfs_setup_common(pdev, hws);
+	if (ret)
+		return ret;
+
+	xtal = clk_hw_get_parent_by_index(hws[CLKID_CPU_CLK_DYN1_SEL], 0);
+
+	/* Setup clock notifier for cpu_clk mux */
+	notifier_clk_name = clk_hw_get_name(&g12b_cpu_clk.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register the cpu_clk notifier\n");
+		return ret;
+	}
+
+	/* Setup clock notifier for sys1_pll */
+	notifier_clk_name = clk_hw_get_name(&g12b_sys1_pll.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk,
+				    &g12b_cpu_clk_sys1_pll_nb_data.nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register the sys1_pll notifier\n");
+		return ret;
+	}
+
+	/* Add notifiers for the second CPU cluster */
+
+	/* Setup clock notifier for cpub_clk_postmux0 */
+	g12b_cpub_clk_postmux0_nb_data.xtal = xtal;
+	notifier_clk_name = clk_hw_get_name(&g12b_cpub_clk_postmux0.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk,
+				    &g12b_cpub_clk_postmux0_nb_data.nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register the cpub_clk_postmux0 notifier\n");
+		return ret;
+	}
+
+	/* Setup clock notifier for cpub_clk_dyn mux */
+	notifier_clk_name = clk_hw_get_name(&g12b_cpub_clk_dyn.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register the cpub_clk_dyn notifier\n");
+		return ret;
+	}
+
+	/* Setup clock notifier for cpub_clk mux */
+	notifier_clk_name = clk_hw_get_name(&g12b_cpub_clk.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register the cpub_clk notifier\n");
+		return ret;
+	}
+
+	/* Setup clock notifier for sys_pll */
+	notifier_clk_name = clk_hw_get_name(&g12a_sys_pll.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk,
+				    &g12b_cpub_clk_sys_pll_nb_data.nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register the sys_pll notifier\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int meson_g12a_dvfs_setup(struct platform_device *pdev)
+{
+	struct clk_hw **hws = g12a_hw_onecell_data.hws;
+	const char *notifier_clk_name;
+	struct clk *notifier_clk;
+	int ret;
+
+	ret = meson_g12a_dvfs_setup_common(pdev, hws);
+	if (ret)
+		return ret;
+
+	/* Setup clock notifier for cpu_clk mux */
+	notifier_clk_name = clk_hw_get_name(&g12a_cpu_clk.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register the cpu_clk notifier\n");
+		return ret;
+	}
+
+	/* Setup clock notifier for sys_pll */
+	notifier_clk_name = clk_hw_get_name(&g12a_sys_pll.hw);
+	notifier_clk = __clk_lookup(notifier_clk_name);
+	ret = clk_notifier_register(notifier_clk, &g12a_sys_pll_nb_data.nb);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register the sys_pll notifier\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+struct meson_g12a_data {
+	const struct meson_eeclkc_data eeclkc_data;
+	int (*dvfs_setup)(struct platform_device *pdev);
+};
+
+static int meson_g12a_probe(struct platform_device *pdev)
+{
+	const struct meson_eeclkc_data *eeclkc_data;
+	const struct meson_g12a_data *g12a_data;
+	int ret;
+
+	eeclkc_data = of_device_get_match_data(&pdev->dev);
+	if (!eeclkc_data)
+		return -EINVAL;
+
+	ret = meson_eeclkc_probe(pdev);
+	if (ret)
+		return ret;
+
+	g12a_data = container_of(eeclkc_data, struct meson_g12a_data,
+				 eeclkc_data);
+
+	if (g12a_data->dvfs_setup)
+		return g12a_data->dvfs_setup(pdev);
+
+	return 0;
+}
+
+static const struct meson_g12a_data g12a_clkc_data = {
+	.eeclkc_data = {
+		.regmap_clks = g12a_clk_regmaps,
+		.regmap_clk_num = ARRAY_SIZE(g12a_clk_regmaps),
+		.hw_onecell_data = &g12a_hw_onecell_data,
+		.init_regs = g12a_init_regs,
+		.init_count = ARRAY_SIZE(g12a_init_regs),
+	},
+	.dvfs_setup = meson_g12a_dvfs_setup,
+};
+
+static const struct meson_g12a_data g12b_clkc_data = {
+	.eeclkc_data = {
+		.regmap_clks = g12a_clk_regmaps,
+		.regmap_clk_num = ARRAY_SIZE(g12a_clk_regmaps),
+		.hw_onecell_data = &g12b_hw_onecell_data,
+	},
+	.dvfs_setup = meson_g12b_dvfs_setup,
 };
 
 static const struct of_device_id clkc_match_table[] = {
-	{ .compatible = "amlogic,g12a-clkc", .data = &g12a_clkc_data },
-	{ .compatible = "amlogic,g12b-clkc", .data = &g12b_clkc_data },
+	{
+		.compatible = "amlogic,g12a-clkc",
+		.data = &g12a_clkc_data.eeclkc_data
+	},
+	{
+		.compatible = "amlogic,g12b-clkc",
+		.data = &g12b_clkc_data.eeclkc_data
+	},
 	{}
 };
 
 static struct platform_driver g12a_driver = {
-	.probe		= meson_eeclkc_probe,
+	.probe		= meson_g12a_probe,
 	.driver		= {
 		.name	= "g12a-clkc",
 		.of_match_table = clkc_match_table,
-- 
2.22.0

