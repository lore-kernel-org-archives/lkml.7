Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967F8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4962087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="j3PmYTiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbfCAKVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:21:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38485 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfCAKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:21:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id a188so4704131wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 02:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yglNkdvCNb7epF0w/eZdYBFFH4ZCU9rEHYjFCz+yf4c=;
        b=j3PmYTiT291RG5ptAwcJDS2cHj4MZRIyFQNENJuy3qZIoU9XomW/iAtHhfyarkeDFu
         NXLN3Ie1vkNcIH/7oH3DTDo1Ah0MpWN+bKVylu5AeepG18msHkMYl56XO6cp5JYfm1Sw
         Cnr46Ab0FmjokVv0U8zn5PpDlTOJtBIZu4DUKCCf/lq6IRfblBa9zwaoky1ko5zlHKIj
         DZNzacGMGX6m4MzBZzFQZNCZhN6hcx4aIiNpkxCDB4qFZ7Piv5SUhxOUI8wHHB5np+ni
         P1KRq30iiyP8wsmfUJsn2RChcpKhRAwwmM6ECqa690Rxzgr2ResBsl80QMi84cBVcvCC
         eAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yglNkdvCNb7epF0w/eZdYBFFH4ZCU9rEHYjFCz+yf4c=;
        b=X4xAxJ970pJa+K6Z7NFSFu5nxim77A+tPcC6A/N76d/FuGJrNJ+z2doSjrEE24sqLz
         nvDFYaqar2/gJhv7IGBYgrvvpEMxm+yWpLRnkaJuxdMCYxKBfXepmmygGklnw3qQy69F
         YcI8kaetD2IdbdxjCjUb7e11voPfPr5FxM48UxBewShk8Y/M0P9i7pTavFc9ROVVxfpw
         vl3eua7TX9kq6BrTtH5aUhKXPirzf8Xyt0za/hbLhu2XeDaZ2gj29u37dUE5etUfBvOd
         lwHl8HRcvPeKkIRMzS1jYTMpQm1dmREtPALW+MvbB6L6+IDrAmW9WQZrtj/qRuOhL2kX
         me4g==
X-Gm-Message-State: AHQUAuYrOLPnltq+JdAgDwTqF9JxvDpWlozcM6Pnuh3oyV5KQ7x2l7Iw
        tf8P247Jv+ab8U9iMddmC7f3wg==
X-Google-Smtp-Source: APXvYqw2TmTaJFQ3h8sin/JoN8nOTV218AZv4yHTCzJ6hpnnTmkFKlzZv7cjV/JHQf0IDo1Jc96sbQ==
X-Received: by 2002:a1c:9d92:: with SMTP id g140mr2642459wme.35.1551435705632;
        Fri, 01 Mar 2019 02:21:45 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f68sm14446626wmg.5.2019.03.01.02.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Mar 2019 02:21:45 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: meson: g12a: add cpu clocks
Date:   Fri,  1 Mar 2019 11:21:40 +0100
Message-Id: <20190301102140.7181-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301102140.7181-1-narmstrong@baylibre.com>
References: <20190301102140.7181-1-narmstrong@baylibre.com>
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
 drivers/clk/meson/g12a.c | 348 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |   1 +
 2 files changed, 349 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 0e1ce8c03259..4c938f1b8421 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -150,6 +150,316 @@ static struct clk_regmap g12a_sys_pll = {
 	},
 };
 
+static struct clk_regmap g12a_sys_pll_div16_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL1,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sys_pll_div16_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "sys_pll" },
+		.num_parents = 1,
+		/*
+		 * This clock is used to debug the sys_pll range
+		 * Linux should not change it at runtime
+		 */
+		.flags = CLK_IGNORE_UNUSED,
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
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cpu_clk" },
+		.num_parents = 1,
+		/*
+		 * This clock is used to debug the cpu_clk range
+		 * Linux should not change it at runtime
+		 */
+		.flags = CLK_IGNORE_UNUSED,
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
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cpu_clk_apb_div" },
+		.num_parents = 1,
+		/*
+		 * This clock is set by the ROM monitor code,
+		 * Linux should not change it at runtime
+		 */
+		.flags = CLK_IGNORE_UNUSED,
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
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cpu_clk_atb_div" },
+		.num_parents = 1,
+		/*
+		 * This clock is set by the ROM monitor code,
+		 * Linux should not change it at runtime
+		 */
+		.flags = CLK_IGNORE_UNUSED,
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
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cpu_clk_axi_div" },
+		.num_parents = 1,
+		/*
+		 * This clock is set by the ROM monitor code,
+		 * Linux should not change it at runtime
+		 */
+		.flags = CLK_IGNORE_UNUSED,
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
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cpu_clk_trace_div" },
+		.num_parents = 1,
+		/*
+		 * This clock is set by the ROM monitor code,
+		 * Linux should not change it at runtime
+		 */
+		.flags = CLK_IGNORE_UNUSED,
+	},
+};
+
 static const struct pll_mult_range g12a_gp0_pll_mult_range = {
 	.min = 55,
 	.max = 255,
@@ -2167,6 +2477,26 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
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
@@ -2335,6 +2665,24 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
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
index 4854750df902..0ba3bfe4d46d 100644
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
-- 
2.20.1

