Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52239C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DFB2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QHv/C1Zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfCSKL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:11:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34027 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfCSKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:11:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id o10so16307129wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=My8ASarnpw2B62d9qiE1akdMtnJMYlnHeiI3/dBbjIo=;
        b=QHv/C1ZhzO0Qd7Xf5ev2t286jsI9+TByfKUHUcFOrC+T39Cz0+FWhfY2+hZcUBeUsL
         yG0R/BU+87PNQJkE3LrhMV1B9/pez4t0LH6Luf+v0biuMWtbPrJhQzziJznf9AndFLOU
         XXGolcV2kmCZcG4xCm2kg3OJINnK6V5dhr8jYIidQFSdpD/6sbGQu8MR0gbw6okmNjG0
         FEnzaAaJ10vxORd2OPRvCuyn7sm5ORsUvLku57W8Y9vAxxCEaJRy5aYbZlXHYSe680LA
         tv//cjKlJESNK7GRqI4yH8KXlJfCY1bszMK8lTcuaAH3GH2/RrmWdOnBw5k8Q5nbHjdl
         LEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=My8ASarnpw2B62d9qiE1akdMtnJMYlnHeiI3/dBbjIo=;
        b=XXOiAoOGXDiDXAc70ApJuz0CYcleXyWPwRUEmNU9oiRDxtotSXSeE1fHqM2+G4Es86
         seCQeh9PddZ555bDOiNKqS+X/scscn6w3Xh/gWl4E7lHJrpK/xVevLthgap43nw6eOMC
         egEMu4aK5I6PgNS2uaSEpl/aFrubjR0vkxQZ3NM5T36jarD+Ru4kQI8nORtPm0IxF2lS
         h122+NGYu2plfy13RXX58lKmfHkD8sfuvs3AUa6kOY0VTJs/lkuJUqLDqJbbtTewY+NF
         Ozju6HtufNYuJKQ20noblzHYDnS/l9I+v9FlVckFT3+4/Txtxa/SmUGnivf3Cvyy73MU
         mQxg==
X-Gm-Message-State: APjAAAV+wN9LzJIc0WyNPKP7NzR5eTKxvCvZVxO3XBqhyQFgPUHt10VE
        X1fVpcMY7+E3DnNras4+63+6fA==
X-Google-Smtp-Source: APXvYqx2hGwUdqmMih+I2PLfVexMx5FpNZim3pJM0gM9QmW3oQG5DtDIQqQ/zbIiuxZDqmmUY/O4TQ==
X-Received: by 2002:a7b:c34e:: with SMTP id l14mr3024778wmj.68.1552990312067;
        Tue, 19 Mar 2019 03:11:52 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id h10sm3911245wmf.2.2019.03.19.03.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:11:51 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: meson-g12a: add video decoder clocks
Date:   Tue, 19 Mar 2019 11:11:38 +0100
Message-Id: <20190319101138.27520-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319101138.27520-1-mjourdan@baylibre.com>
References: <20190319101138.27520-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the necessary clock parts for:

 - VDEC_1: used to feed VDEC_1
 - VDEC_HEVC: the "back" part of the VDEC_HEVC block
 - VDEC_HEVCF: the "front" part of the VDEC_HEVC block

In previous SoC generations (GXL, GXBB), there was only one VDEC_HEVC
clock, which got split in two parts for G12A.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/clk/meson/g12a.c | 163 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |   8 +-
 2 files changed, 170 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 3a3134976534..6c762a8b32b9 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -1495,6 +1495,151 @@ static struct clk_regmap g12a_vpu = {
 	},
 };
 
+/* VDEC clocks */
+
+static const char * const g12a_vdec_parent_names[] = {
+	"fclk_div2p5", "fclk_div3", "fclk_div4", "fclk_div5", "fclk_div7",
+	"hifi_pll", "gp0_pll",
+};
+
+static struct clk_regmap g12a_vdec_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_1_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = g12a_vdec_parent_names,
+		.num_parents = ARRAY_SIZE(g12a_vdec_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_vdec_1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_1_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vdec_1_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_vdec_1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vdec_1_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_vdec_hevcf_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_hevcf_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = g12a_vdec_parent_names,
+		.num_parents = ARRAY_SIZE(g12a_vdec_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_vdec_hevcf_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_hevcf_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vdec_hevcf_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_vdec_hevcf = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_hevcf",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vdec_hevcf_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_vdec_hevc_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 25,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_hevc_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = g12a_vdec_parent_names,
+		.num_parents = ARRAY_SIZE(g12a_vdec_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_vdec_hevc_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.shift = 16,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_hevc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vdec_hevc_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap g12a_vdec_hevc = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_hevc",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vdec_hevc_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* VAPB Clock */
 
 static const char * const g12a_vapb_parent_names[] = {
@@ -2615,6 +2760,15 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
 		[CLKID_PCIE_PLL_DCO_DIV2]	= &g12a_pcie_pll_dco_div2.hw,
 		[CLKID_PCIE_PLL_OD]		= &g12a_pcie_pll_od.hw,
 		[CLKID_PCIE_PLL]		= &g12a_pcie_pll.hw,
+		[CLKID_VDEC_1_SEL]		= &g12a_vdec_1_sel.hw,
+		[CLKID_VDEC_1_DIV]		= &g12a_vdec_1_div.hw,
+		[CLKID_VDEC_1]			= &g12a_vdec_1.hw,
+		[CLKID_VDEC_HEVC_SEL]		= &g12a_vdec_hevc_sel.hw,
+		[CLKID_VDEC_HEVC_DIV]		= &g12a_vdec_hevc_div.hw,
+		[CLKID_VDEC_HEVC]		= &g12a_vdec_hevc.hw,
+		[CLKID_VDEC_HEVCF_SEL]		= &g12a_vdec_hevcf_sel.hw,
+		[CLKID_VDEC_HEVCF_DIV]		= &g12a_vdec_hevcf_div.hw,
+		[CLKID_VDEC_HEVCF]		= &g12a_vdec_hevcf.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -2803,6 +2957,15 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&g12a_cpu_clk_trace,
 	&g12a_pcie_pll_od,
 	&g12a_pcie_pll_dco,
+	&g12a_vdec_1_sel,
+	&g12a_vdec_1_div,
+	&g12a_vdec_1,
+	&g12a_vdec_hevc_sel,
+	&g12a_vdec_hevc_div,
+	&g12a_vdec_hevc,
+	&g12a_vdec_hevcf_sel,
+	&g12a_vdec_hevcf_div,
+	&g12a_vdec_hevcf,
 };
 
 static const struct meson_eeclkc_data g12a_clkc_data = {
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index 1393a09730a6..39c41af70804 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -189,8 +189,14 @@
 #define CLKID_PCIE_PLL_DCO			198
 #define CLKID_PCIE_PLL_DCO_DIV2			199
 #define CLKID_PCIE_PLL_OD			200
+#define CLKID_VDEC_1_SEL			202
+#define CLKID_VDEC_1_DIV			203
+#define CLKID_VDEC_HEVC_SEL			205
+#define CLKID_VDEC_HEVC_DIV			206
+#define CLKID_VDEC_HEVCF_SEL			208
+#define CLKID_VDEC_HEVCF_DIV			209
 
-#define NR_CLKS					202
+#define NR_CLKS					211
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
-- 
2.21.0

