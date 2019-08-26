Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17500C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D498620874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qOa+iavI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfHZHZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:25:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39849 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbfHZHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:25:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so14245140wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 00:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aIZ4MUENKnk/vwYuwNvpf/YizEZ4hKgP/FjIWOQe6Qs=;
        b=qOa+iavIMdAd6axtgUsheALHFHtKaJgULn8OuIemZ7Eu1GKbwW8e/7Ili/IaSb27Ht
         cLAQBejNfZl/g4FVzDKXcVwge7f+pe2oyqq5FH26fhKvMlk7+QWwWkGgiJjodfI3ppHN
         og4mpXAcDN8eZOPjltnNO/6FEOdZXja2yhBA4odV4OId17vV9XAeqGsc3cJWdXtzD5t+
         qG7gvx/q65q2m7isgCFJn7Q5aAQq5+oWbHtcawWrG25yMjQiMiyWQc2KrPceC0J9r4bQ
         C7ybs90pmew2aw3Yv47Nv9JtQg6FYJyXX8lZq/GTkPVi5W8hnJyJ1ghStZ4ce6dSl4on
         Izig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aIZ4MUENKnk/vwYuwNvpf/YizEZ4hKgP/FjIWOQe6Qs=;
        b=iBwvgrI+RpuNnGyyM7zaF56WQua79gSa2/rSmSrITVmRflYQ9ra31rQss+ItX+YyyZ
         LiQiSdcyXBp+t2/IGYQaKyUW3UoDUq/uaZvXwqzW04H06X6FbAS63uVziQHyNowaFrgJ
         sku6GoeozfF52FLnzX6gQvqv5kAgx+SJwrt6CwJlWA4p32raWqlPdLOm2gT5ZWFzKjLd
         D0CV75YUJq4PXs1seMrxLWwMpDSCngnm5/O+2/nQox2ak5h/T/k4MsM8l204IlhDinkT
         l1pGnkAmg5V7wAHs2vw27dUClp1zcHhBStwesq06HKyMc/lg6e9tOeHcWBFvDmvw//yf
         Iqcg==
X-Gm-Message-State: APjAAAVnqHHQhmYv0YDpYdjnJjJzBj0RaS4HkClzVbnBGilUQ4Jtw+bB
        nA82wBWd1PlQO/DQQSHgL7sE4w==
X-Google-Smtp-Source: APXvYqyzN/OGkL9P1BrTuY33ggl0eCy+5f+de1nLbCAFaS9ESop/tWzeWsUl1mGSMXtVcyMsMnaK+Q==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr20954395wrp.103.1566804346029;
        Mon, 26 Aug 2019 00:25:46 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm10821324wmg.45.2019.08.26.00.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:25:45 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] clk: meson: g12a: add support for SM1 DynamIQ Shared Unit clock
Date:   Mon, 26 Aug 2019 09:25:37 +0200
Message-Id: <20190826072539.27725-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826072539.27725-1-narmstrong@baylibre.com>
References: <20190826072539.27725-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic SM1 DynamIQ Shared Unit has a dedicated clock tree similar to the
CPU clock tree with a supplementaty mux to select the CPU0 clock instead.

Leave this as read-only since it's set up by the early boot stages.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 184 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |  15 +++-
 2 files changed, 198 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 34dfac4b4dc6..e00df17f800a 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -676,6 +676,172 @@ static struct clk_regmap g12b_cpub_clk = {
 	},
 };
 
+static struct clk_regmap sm1_gp1_pll;
+
+/* Datasheet names this field as "premux0" */
+static struct clk_regmap sm1_dsu_clk_premux0 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL5,
+		.mask = 0x3,
+		.shift = 0,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dsu_clk_dyn0_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .hw = &g12a_fclk_div2.hw },
+			{ .hw = &g12a_fclk_div3.hw },
+			{ .hw = &sm1_gp1_pll.hw },
+		},
+		.num_parents = 4,
+	},
+};
+
+/* Datasheet names this field as "premux1" */
+static struct clk_regmap sm1_dsu_clk_premux1 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL5,
+		.mask = 0x3,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dsu_clk_dyn1_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .hw = &g12a_fclk_div2.hw },
+			{ .hw = &g12a_fclk_div3.hw },
+			{ .hw = &sm1_gp1_pll.hw },
+		},
+		.num_parents = 4,
+	},
+};
+
+/* Datasheet names this field as "Mux0_divn_tcnt" */
+static struct clk_regmap sm1_dsu_clk_mux0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL5,
+		.shift = 4,
+		.width = 6,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dsu_clk_dyn0_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sm1_dsu_clk_premux0.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+/* Datasheet names this field as "postmux0" */
+static struct clk_regmap sm1_dsu_clk_postmux0 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL5,
+		.mask = 0x1,
+		.shift = 2,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dsu_clk_dyn0",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sm1_dsu_clk_premux0.hw,
+			&sm1_dsu_clk_mux0_div.hw,
+		},
+		.num_parents = 2,
+	},
+};
+
+/* Datasheet names this field as "Mux1_divn_tcnt" */
+static struct clk_regmap sm1_dsu_clk_mux1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL5,
+		.shift = 20,
+		.width = 6,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dsu_clk_dyn1_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sm1_dsu_clk_premux1.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+/* Datasheet names this field as "postmux1" */
+static struct clk_regmap sm1_dsu_clk_postmux1 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL5,
+		.mask = 0x1,
+		.shift = 18,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dsu_clk_dyn1",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sm1_dsu_clk_premux1.hw,
+			&sm1_dsu_clk_mux1_div.hw,
+		},
+		.num_parents = 2,
+	},
+};
+
+/* Datasheet names this field as "Final_dyn_mux_sel" */
+static struct clk_regmap sm1_dsu_clk_dyn = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL5,
+		.mask = 0x1,
+		.shift = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dsu_clk_dyn",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sm1_dsu_clk_postmux0.hw,
+			&sm1_dsu_clk_postmux1.hw,
+		},
+		.num_parents = 2,
+	},
+};
+
+/* Datasheet names this field as "Final_mux_sel" */
+static struct clk_regmap sm1_dsu_final_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL5,
+		.mask = 0x1,
+		.shift = 11,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dsu_clk_final",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&sm1_dsu_clk_dyn.hw,
+			&g12a_sys_pll.hw,
+		},
+		.num_parents = 2,
+	},
+};
+
+/* Datasheet names this field as "Cpu_clk_sync_mux_sel" bit 4 */
+static struct clk_regmap sm1_dsu_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL6,
+		.mask = 0x1,
+		.shift = 27,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "dsu_clk",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_cpu_clk.hw,
+			&sm1_dsu_final_clk.hw,
+		},
+		.num_parents = 2,
+	},
+};
+
 static int g12a_cpu_clk_mux_notifier_cb(struct notifier_block *nb,
 					unsigned long event, void *data)
 {
@@ -4401,6 +4567,15 @@ static struct clk_hw_onecell_data sm1_hw_onecell_data = {
 		[CLKID_TS]			= &g12a_ts.hw,
 		[CLKID_GP1_PLL_DCO]		= &sm1_gp1_pll_dco.hw,
 		[CLKID_GP1_PLL]			= &sm1_gp1_pll.hw,
+		[CLKID_DSU_CLK_DYN0_SEL]	= &sm1_dsu_clk_premux0.hw,
+		[CLKID_DSU_CLK_DYN0_DIV]	= &sm1_dsu_clk_premux1.hw,
+		[CLKID_DSU_CLK_DYN0]		= &sm1_dsu_clk_mux0_div.hw,
+		[CLKID_DSU_CLK_DYN1_SEL]	= &sm1_dsu_clk_postmux0.hw,
+		[CLKID_DSU_CLK_DYN1_DIV]	= &sm1_dsu_clk_mux1_div.hw,
+		[CLKID_DSU_CLK_DYN1]		= &sm1_dsu_clk_postmux1.hw,
+		[CLKID_DSU_CLK_DYN]		= &sm1_dsu_clk_dyn.hw,
+		[CLKID_DSU_CLK_FINAL]		= &sm1_dsu_final_clk.hw,
+		[CLKID_DSU_CLK]			= &sm1_dsu_clk.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -4623,6 +4798,15 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12b_cpub_clk_trace,
 	&sm1_gp1_pll_dco,
 	&sm1_gp1_pll,
+	&sm1_dsu_clk_premux0,
+	&sm1_dsu_clk_premux1,
+	&sm1_dsu_clk_mux0_div,
+	&sm1_dsu_clk_postmux0,
+	&sm1_dsu_clk_mux1_div,
+	&sm1_dsu_clk_postmux1,
+	&sm1_dsu_clk_dyn,
+	&sm1_dsu_final_clk,
+	&sm1_dsu_clk,
 };
 
 static const struct reg_sequence g12a_init_regs[] = {
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index e426b4121b7a..6804fcced6b5 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -80,6 +80,11 @@
 #define HHI_SYS_CPUB_CLK_CNTL1		0x200
 #define HHI_SYS_CPUB_CLK_CNTL		0x208
 #define HHI_VPU_CLKB_CNTL		0x20C
+#define HHI_SYS_CPU_CLK_CNTL2		0x210
+#define HHI_SYS_CPU_CLK_CNTL3		0x214
+#define HHI_SYS_CPU_CLK_CNTL4		0x218
+#define HHI_SYS_CPU_CLK_CNTL5		0x21c
+#define HHI_SYS_CPU_CLK_CNTL6		0x220
 #define HHI_GEN_CLK_CNTL		0x228
 #define HHI_VDIN_MEAS_CLK_CNTL		0x250
 #define HHI_MIPIDSI_PHY_CLK_CNTL	0x254
@@ -242,8 +247,16 @@
 #define CLKID_CPUB_CLK_TRACE_SEL		240
 #define CLKID_CPUB_CLK_TRACE			241
 #define CLKID_GP1_PLL_DCO			242
+#define CLKID_DSU_CLK_DYN0_SEL			244
+#define CLKID_DSU_CLK_DYN0_DIV			245
+#define CLKID_DSU_CLK_DYN0			246
+#define CLKID_DSU_CLK_DYN1_SEL			247
+#define CLKID_DSU_CLK_DYN1_DIV			248
+#define CLKID_DSU_CLK_DYN1			249
+#define CLKID_DSU_CLK_DYN			250
+#define CLKID_DSU_CLK_FINAL			251
 
-#define NR_CLKS					244
+#define NR_CLKS					253
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
-- 
2.22.0

