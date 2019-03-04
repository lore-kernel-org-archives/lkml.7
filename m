Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B50C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C2E2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1KlfT9in"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfCDNLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:11:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43964 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfCDNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:11:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id d17so5475226wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 05:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ii8eJGdsN8bfQAaCMmEW83TuFvrl71fjU1+jEsXisP4=;
        b=1KlfT9innVh5mZ8sXhma++gzXCQUEzuyzpgMy3dB0/RWYk3gAHNqqoPsyEhAiyH+0u
         gKpX9cPQJu2MaMpAFhpHZn/6Cn6+aRCPPqUrmPEcIh45ljbzJuitOtyAgNLXhMDq+tnS
         0miiC6u9jXR4xLLlzP+O5HJyFKA2nlPuv0KMH/cjF4fjREHgpRm1iAVdIIqQ7O1elvdK
         nFvjtjZR3ol/6ZJPvUhipp1JNYSjf/22yvWWYSH0ZlfXwrWcGv55+y6l9sMmcMVuEYab
         PLtzufwGZG/YYFf5B1gJPnPaXJS5A8mToEZ8cK4cjoFZo0ZPMtvbrTIetppo+H9zL+O8
         BZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ii8eJGdsN8bfQAaCMmEW83TuFvrl71fjU1+jEsXisP4=;
        b=VgEFvYAK+vJxxKnNKSTJrKGLekUBW/E1y5XsG6bFTHUSNfDJeu8PFCpd0stu5AdbiW
         1IjbE25FLZYfgqFK4rEypOF/ak+U8VXidBU/jbnEYrRODDRvCTtMrFK9+Apu340XAK8A
         Epdp7dzfJX5Oocaj8UoH1S4ZIUKxBEo5o/S6W4xa4a6U7jflvjWH2CPGrkyLqMBOrds5
         Xz7a/Fs5WMVX+pVDyTnLT3zLY5SNHq1ijqD2L6ZyaavSb1Tm1+FjpvPweLnXJPL6Ymav
         T0UKQkty6mw3nPDlQ64yDjHD2d8XvZqxLJHpOGDzaVxF0+Sg+7z42hb2OLHJbvtJRTPR
         TbHw==
X-Gm-Message-State: APjAAAVrJ9GFmnO+tbhavUZ5sZpo/JIfClWG7k9Ml1TIJ4hs37r0d76X
        PXItl53BOhF4fEPxYXrkMwXpxw==
X-Google-Smtp-Source: APXvYqxMTVf5FE8CzmjRp+IamQeUY0+29Bwtp7KgilF+O05dDXhV/uncjNVx2gS/YvNFXsNJRQZZzQ==
X-Received: by 2002:a5d:4887:: with SMTP id g7mr12684452wrq.51.1551705094675;
        Mon, 04 Mar 2019 05:11:34 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a8sm11695624wmh.26.2019.03.04.05.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 05:11:33 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: meson: g12a: add cpu clocks
Date:   Mon,  4 Mar 2019 14:11:29 +0100
Message-Id: <20190304131129.7762-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304131129.7762-1-narmstrong@baylibre.com>
References: <20190304131129.7762-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Amlogic G12A Family CPU Clock tree in read/only for now.

The CPU clock can either use the SYS_PLL for > 1GHz frequencies or
use a couple of div+mux from 1GHz/667MHz/24MHz source with 2 non-glitch
muxes.

Proper DVFS support will come in a second time.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 350 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |  22 ++-
 2 files changed, 371 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 0e1ce8c03259..80a7172df2a6 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -150,6 +150,318 @@ static struct clk_regmap g12a_sys_pll = {
 	},
 };
 
+static struct clk_regmap g12a_sys_pll_div16_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sys_pll_div16_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "sys_pll" },
+		.num_parents = 1,
+		/*
+		 * This clock is used to debug the sys_pll range
+		 * Linux should not change it at runtime
+		 */
+	},
+};
+
+static struct clk_fixed_factor g12a_sys_pll_div16 = {
+	.mult = 1,
+	.div = 16,
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_pll_div16",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "sys_pll_div16_en" },
+		.num_parents = 1,
+	},
+};
+
+/* Datasheet names this field as "premux0" */
+static struct clk_regmap g12a_cpu_clk_dyn0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.mask = 0x3,
+		.shift = 0,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_dyn0_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ IN_PREFIX "xtal",
+						  "fclk_div2",
+						  "fclk_div3" },
+		.num_parents = 3,
+	},
+};
+
+/* Datasheet names this field as "mux0_divn_tcnt" */
+static struct clk_regmap g12a_cpu_clk_dyn0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.shift = 4,
+		.width = 6,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_dyn0_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk_dyn0_sel" },
+		.num_parents = 1,
+	},
+};
+
+/* Datasheet names this field as "postmux0" */
+static struct clk_regmap g12a_cpu_clk_dyn0 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.mask = 0x1,
+		.shift = 2,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_dyn0",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk_dyn0_sel",
+						  "cpu_clk_dyn0_div" },
+		.num_parents = 2,
+	},
+};
+
+/* Datasheet names this field as "premux1" */
+static struct clk_regmap g12a_cpu_clk_dyn1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.mask = 0x3,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_dyn1_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ IN_PREFIX "xtal",
+						  "fclk_div2",
+						  "fclk_div3" },
+		.num_parents = 3,
+	},
+};
+
+/* Datasheet names this field as "Mux1_divn_tcnt" */
+static struct clk_regmap g12a_cpu_clk_dyn1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.shift = 20,
+		.width = 6,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_dyn1_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk_dyn1_sel" },
+		.num_parents = 1,
+	},
+};
+
+/* Datasheet names this field as "postmux1" */
+static struct clk_regmap g12a_cpu_clk_dyn1 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.mask = 0x1,
+		.shift = 18,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_dyn1",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk_dyn1_sel",
+						  "cpu_clk_dyn1_div" },
+		.num_parents = 2,
+	},
+};
+
+/* Datasheet names this field as "Final_dyn_mux_sel" */
+static struct clk_regmap g12a_cpu_clk_dyn = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.mask = 0x1,
+		.shift = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_dyn",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk_dyn0",
+						  "cpu_clk_dyn1" },
+		.num_parents = 2,
+	},
+};
+
+/* Datasheet names this field as "Final_mux_sel" */
+static struct clk_regmap g12a_cpu_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.mask = 0x1,
+		.shift = 11,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk_dyn",
+						  "sys_pll" },
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap g12a_cpu_clk_div16_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_clk_div16_en",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+		/*
+		 * This clock is used to debug the cpu_clk range
+		 * Linux should not change it at runtime
+		 */
+	},
+};
+
+static struct clk_fixed_factor g12a_cpu_clk_div16 = {
+	.mult = 1,
+	.div = 16,
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_div16",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "cpu_clk_div16_en" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_cpu_clk_apb_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.shift = 3,
+		.width = 3,
+		.flags = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_apb_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_cpu_clk_apb = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_clk_apb",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk_apb_div" },
+		.num_parents = 1,
+		/*
+		 * This clock is set by the ROM monitor code,
+		 * Linux should not change it at runtime
+		 */
+	},
+};
+
+static struct clk_regmap g12a_cpu_clk_atb_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.shift = 6,
+		.width = 3,
+		.flags = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_atb_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_cpu_clk_atb = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 17,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_clk_atb",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk_atb_div" },
+		.num_parents = 1,
+		/*
+		 * This clock is set by the ROM monitor code,
+		 * Linux should not change it at runtime
+		 */
+	},
+};
+
+static struct clk_regmap g12a_cpu_clk_axi_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.shift = 9,
+		.width = 3,
+		.flags = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_axi_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_cpu_clk_axi = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 18,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_clk_axi",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk_axi_div" },
+		.num_parents = 1,
+		/*
+		 * This clock is set by the ROM monitor code,
+		 * Linux should not change it at runtime
+		 */
+	},
+};
+
+static struct clk_regmap g12a_cpu_clk_trace_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.shift = 20,
+		.width = 3,
+		.flags = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk_trace_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_cpu_clk_trace = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 23,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cpu_clk_trace",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_names = (const char *[]){ "cpu_clk_trace_div" },
+		.num_parents = 1,
+		/*
+		 * This clock is set by the ROM monitor code,
+		 * Linux should not change it at runtime
+		 */
+	},
+};
+
 static const struct pll_mult_range g12a_gp0_pll_mult_range = {
 	.min = 55,
 	.max = 255,
@@ -2167,6 +2479,26 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
 		[CLKID_MALI]			= &g12a_mali.hw,
 		[CLKID_MPLL_5OM_DIV]		= &g12a_mpll_50m_div.hw,
 		[CLKID_MPLL_5OM]		= &g12a_mpll_50m.hw,
+		[CLKID_SYS_PLL_DIV16_EN]	= &g12a_sys_pll_div16_en.hw,
+		[CLKID_SYS_PLL_DIV16]		= &g12a_sys_pll_div16.hw,
+		[CLKID_CPU_CLK_DYN0_SEL]	= &g12a_cpu_clk_dyn0_sel.hw,
+		[CLKID_CPU_CLK_DYN0_DIV]	= &g12a_cpu_clk_dyn0_div.hw,
+		[CLKID_CPU_CLK_DYN0]		= &g12a_cpu_clk_dyn0.hw,
+		[CLKID_CPU_CLK_DYN1_SEL]	= &g12a_cpu_clk_dyn1_sel.hw,
+		[CLKID_CPU_CLK_DYN1_DIV]	= &g12a_cpu_clk_dyn1_div.hw,
+		[CLKID_CPU_CLK_DYN1]		= &g12a_cpu_clk_dyn1.hw,
+		[CLKID_CPU_CLK_DYN]		= &g12a_cpu_clk_dyn.hw,
+		[CLKID_CPU_CLK]			= &g12a_cpu_clk.hw,
+		[CLKID_CPU_CLK_DIV16_EN]	= &g12a_cpu_clk_div16_en.hw,
+		[CLKID_CPU_CLK_DIV16]		= &g12a_cpu_clk_div16.hw,
+		[CLKID_CPU_CLK_APB_DIV]		= &g12a_cpu_clk_apb_div.hw,
+		[CLKID_CPU_CLK_APB]		= &g12a_cpu_clk_apb.hw,
+		[CLKID_CPU_CLK_ATB_DIV]		= &g12a_cpu_clk_atb_div.hw,
+		[CLKID_CPU_CLK_ATB]		= &g12a_cpu_clk_atb.hw,
+		[CLKID_CPU_CLK_AXI_DIV]		= &g12a_cpu_clk_axi_div.hw,
+		[CLKID_CPU_CLK_AXI]		= &g12a_cpu_clk_axi.hw,
+		[CLKID_CPU_CLK_TRACE_DIV]	= &g12a_cpu_clk_trace_div.hw,
+		[CLKID_CPU_CLK_TRACE]		= &g12a_cpu_clk_trace.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -2335,6 +2667,24 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_mali_1,
 	&g12a_mali,
 	&g12a_mpll_50m,
+	&g12a_sys_pll_div16_en,
+	&g12a_cpu_clk_dyn0_sel,
+	&g12a_cpu_clk_dyn0_div,
+	&g12a_cpu_clk_dyn0,
+	&g12a_cpu_clk_dyn1_sel,
+	&g12a_cpu_clk_dyn1_div,
+	&g12a_cpu_clk_dyn1,
+	&g12a_cpu_clk_dyn,
+	&g12a_cpu_clk,
+	&g12a_cpu_clk_div16_en,
+	&g12a_cpu_clk_apb_div,
+	&g12a_cpu_clk_apb,
+	&g12a_cpu_clk_atb_div,
+	&g12a_cpu_clk_atb,
+	&g12a_cpu_clk_axi_div,
+	&g12a_cpu_clk_axi,
+	&g12a_cpu_clk_trace_div,
+	&g12a_cpu_clk_trace,
 };
 
 static const struct meson_eeclkc_data g12a_clkc_data = {
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index f399dfe1401c..70aa469ca1cf 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -50,6 +50,7 @@
 #define HHI_GCLK_MPEG2			0x148
 #define HHI_GCLK_OTHER			0x150
 #define HHI_GCLK_OTHER2			0x154
+#define HHI_SYS_CPU_CLK_CNTL1		0x15c
 #define HHI_VID_CLK_DIV			0x164
 #define HHI_MPEG_CLK_CNTL		0x174
 #define HHI_AUD_CLK_CNTL		0x178
@@ -166,8 +167,27 @@
 #define CLKID_MALI_0_DIV			170
 #define CLKID_MALI_1_DIV			173
 #define CLKID_MPLL_5OM_DIV			176
+#define CLKID_SYS_PLL_DIV16_EN			178
+#define CLKID_SYS_PLL_DIV16			179
+#define CLKID_CPU_CLK_DYN0_SEL			180
+#define CLKID_CPU_CLK_DYN0_DIV			181
+#define CLKID_CPU_CLK_DYN0			182
+#define CLKID_CPU_CLK_DYN1_SEL			183
+#define CLKID_CPU_CLK_DYN1_DIV			184
+#define CLKID_CPU_CLK_DYN1			185
+#define CLKID_CPU_CLK_DYN			186
+#define CLKID_CPU_CLK_DIV16_EN			188
+#define CLKID_CPU_CLK_DIV16			189
+#define CLKID_CPU_CLK_APB_DIV			190
+#define CLKID_CPU_CLK_APB			191
+#define CLKID_CPU_CLK_ATB_DIV			192
+#define CLKID_CPU_CLK_ATB			193
+#define CLKID_CPU_CLK_AXI_DIV			194
+#define CLKID_CPU_CLK_AXI			195
+#define CLKID_CPU_CLK_TRACE_DIV			196
+#define CLKID_CPU_CLK_TRACE			197
 
-#define NR_CLKS					178
+#define NR_CLKS					198
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
-- 
2.20.1

