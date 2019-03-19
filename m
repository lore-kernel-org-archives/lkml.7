Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FC8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4BA20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q4aJ07IP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCSIvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:51:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43209 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfCSIu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:50:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so20009560wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gf72ZmXlmqyXLuvApTF83s8RrJ6agdJoOCHA3jp5SbQ=;
        b=Q4aJ07IPwy8bvxdm74BHj4ulAtlWJQmIDQehcs7jnHnjhGM4FqLpEsM01meRYGwcBr
         QwF5g4Mcqu8/b/9wjf2zjZlfCpbeTjudVBgbQTmfntS0hVzdBGkMgWNMe78uw3CYzAxf
         dyBwLLBTT6n08oO8b4Wy03gcUccSvZjrKH4O4W8zXzAt1m5pdAZpqonZDHf9vUCzNFy/
         uHQ69UDhbn8vk2hoFsts6C2Rfk2ARRv+jc1bNBIfXBqXi9cqW1yt53J/UTdIBzMjwCe5
         NVI1hOGqFgHe7fOHMdthLVyQwmHoIRpyhhZIO5vCOq73KhVcQW3LeUlVjZ89xjeWWUko
         wqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gf72ZmXlmqyXLuvApTF83s8RrJ6agdJoOCHA3jp5SbQ=;
        b=BwFxc1m8psrxO1HzQ1f+2QuiR9eq1FGQYsgyAdbSjqYoWjfjps0j1XTwoTvKiU8rud
         ZY5uKEFsAYrYEZeG0qvSz7cGYFIjTt86qWDh/hVLyJGUuWvX0z8uREH6nbUxoilAUcfV
         WXOlqL3i5pB+SSKK4SSA50AAq5tgxtAUZqd9DJLvRNjqLWjSrAU8S5AT+DhHXJ/8FqG1
         XPmBOQk/dF1UiXySqYuGkgAbGORpavdPeOZqLjXm4LAxJv4fDo6eAMR90VwutHFpfJmX
         DvY4OkaufYyEKP4WNCA0Ds440E8AnRGWKxi/ZGLTXKx8+ZUZYgLm8md6r0pWnRQEnyma
         bcwA==
X-Gm-Message-State: APjAAAXl+825NxASAS/g4YqEHTwRHlpHvCNE5/EQKNav/yIIRw37cNDG
        V3wFlsRW+bk/ou6v+Py3Vn1y4osJ0DU=
X-Google-Smtp-Source: APXvYqx/7t5grdSDpDYvOILI7Edw+w3pkGcR+XzTJQOlmDcDhBJ+dZ/uOumBdpO46981UECl7uUrNA==
X-Received: by 2002:adf:a147:: with SMTP id r7mr15213268wrr.5.1552985454569;
        Tue, 19 Mar 2019 01:50:54 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id n4sm9411047wrx.39.2019.03.19.01.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 01:50:54 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: meson-g12a: add video decoder clocks
Date:   Tue, 19 Mar 2019 09:50:44 +0100
Message-Id: <20190319085044.8581-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319085044.8581-1-mjourdan@baylibre.com>
References: <20190319085044.8581-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly like meson-gx, except that the VDEC_HEVC clock is now split in two:
HEVC and HEVCF.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/clk/meson/g12a.c | 160 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |   8 +-
 2 files changed, 167 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 3a3134976534..cfb91df884cb 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -1495,6 +1495,148 @@ static struct clk_regmap g12a_vpu = {
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
@@ -2615,6 +2757,15 @@ static struct clk_hw_onecell_data g12a_hw_onecell_data = {
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
@@ -2803,6 +2954,15 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
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

