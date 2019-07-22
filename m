Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC069C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833492199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="09eZ7CUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfGVJye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:54:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39207 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbfGVJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:54:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so38679137wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 02:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cIceYeZmXLnDB8KmyjeQxrFIl+tdDqzy/AgzjLz1uyc=;
        b=09eZ7CUQJWjEDPknM+glm7nGARL3191dfdnzDoDTIcXUf2VN/coQPKSBZPFyz9NNfC
         GEpjW3GMEewKb1ip9yr6C+f0EGNH+oJMtSnZh4o4fmfolLpJYq0qj5qoRXtmoLrSMamp
         nUc+JDRBop0pxkonQ1UlKoFZoohi6DPwc8SiO9p5MW2Qs9Fyk68m5bmzKtfpJdJe+5sx
         E1SspGW/gU3dRoQRjzUmh6F7t40J6L8GQph5JtuYVKFiYXGuDpGmx/sRuMOnRlALG4rS
         kWCmtJw73zCURV1MhJEG/rSXxW8fgPTIc1eu0Uogi/W6QdiGka/jpW2NiCDfN9FqAR2+
         YRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cIceYeZmXLnDB8KmyjeQxrFIl+tdDqzy/AgzjLz1uyc=;
        b=hDCdasab6TN4VvuxS05l9/wRxuA8fnF1GRDzWPRgKTYeqNJQzkc1XkCqrRm+37DH3/
         fbJ0vTHYDwFKYJ2Gii1gEg7tIfwkb1bUWRj0u8Oz6XeDT5yFEnfPAoaNSi/HD7I7liWu
         vkVc6j++yAk7m3TK12cQoKFM1Ljfb6Ryc3otLd0a72GDpuyi7K4d92inBlTsSCmbxYaf
         ob0mq41Ek6pbf5etnX3HthdIcWCunsl1g11kY2z5cG+LaXCAxOk/BXz3mZzrsX+XtCmg
         VepCFiPP3hFwzTBUB1Lntnk9dFo2WVJo0HOF3RpjB0TdJBLyu7TuglzTzqU0TrskT7do
         bwmg==
X-Gm-Message-State: APjAAAVS3PTk5xdycKDA0gDcvo6JrRUkZ3NcVTqL/GMOfcuKD5R+CMT6
        YwGeczTGXYBLhBjx0h6tsrN/lA==
X-Google-Smtp-Source: APXvYqzLxOM30MoA/Cs6XJMrso0FW9Y4DTwH7k8jtslzDTkT8KdRK3RB5BI+8Zi1/XhsuvNPDS2TMA==
X-Received: by 2002:a5d:4090:: with SMTP id o16mr22577752wrp.292.1563789269259;
        Mon, 22 Jul 2019 02:54:29 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 91sm83158469wrp.3.2019.07.22.02.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 02:54:28 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 1/8] clk: meson: g12a: move clock declaration to dependency order
Date:   Mon, 22 Jul 2019 11:54:18 +0200
Message-Id: <20190722095425.14193-2-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722095425.14193-1-amergnat@baylibre.com>
References: <20190722095425.14193-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock controller use the string comparison method to describe parent
relation between the clocks.

In order to migrate to clk_hw pointers, it is easier if the parent is
declared before being used. This patch just move the declaration to
facilitate the review of migration to the parent description method.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/clk/meson/g12a.c | 270 +++++++++++++++++++--------------------
 1 file changed, 135 insertions(+), 135 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 7bc5566b66f7..cbd56b2e05d0 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -257,6 +257,64 @@ static struct clk_fixed_factor g12b_sys1_pll_div16 = {
 	},
 };
 
+static struct clk_fixed_factor g12a_fclk_div2_div = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_fclk_div2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_FIX_PLL_CNTL1,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div2_div" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor g12a_fclk_div3_div = {
+	.mult = 1,
+	.div = 3,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div3_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "fixed_pll" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap g12a_fclk_div3 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_FIX_PLL_CNTL1,
+		.bit_idx = 20,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div3",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "fclk_div3_div" },
+		.num_parents = 1,
+		/*
+		 * This clock is used by the resident firmware and is required
+		 * by the platform to operate correctly.
+		 * Until the following condition are met, we need this clock to
+		 * be marked as critical:
+		 * a) Mark the clock used by a firmware resource, if possible
+		 * b) CCF has a clock hand-off mechanism to make the sure the
+		 *    clock stays on until the proper driver comes along
+		 */
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
 /* Datasheet names this field as "premux0" */
 static struct clk_regmap g12a_cpu_clk_premux0 = {
 	.data = &(struct clk_regmap_mux_data){
@@ -274,6 +332,23 @@ static struct clk_regmap g12a_cpu_clk_premux0 = {
 	},
 };
 
+/* Datasheet names this field as "premux1" */
+static struct clk_regmap g12a_cpu_clk_premux1 = {
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
 /* Datasheet names this field as "mux0_divn_tcnt" */
 static struct clk_regmap g12a_cpu_clk_mux0_div = {
 	.data = &(struct clk_regmap_div_data){
@@ -305,23 +380,6 @@ static struct clk_regmap g12a_cpu_clk_postmux0 = {
 	},
 };
 
-/* Datasheet names this field as "premux1" */
-static struct clk_regmap g12a_cpu_clk_premux1 = {
-	.data = &(struct clk_regmap_mux_data){
-		.offset = HHI_SYS_CPU_CLK_CNTL0,
-		.mask = 0x3,
-		.shift = 16,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "cpu_clk_dyn1_sel",
-		.ops = &clk_regmap_mux_ro_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "xtal",
-						  "fclk_div2",
-						  "fclk_div3" },
-		.num_parents = 3,
-	},
-};
-
 /* Datasheet names this field as "Mux1_divn_tcnt" */
 static struct clk_regmap g12a_cpu_clk_mux1_div = {
 	.data = &(struct clk_regmap_div_data){
@@ -1305,64 +1363,6 @@ static struct clk_regmap g12a_hdmi_pll = {
 	},
 };
 
-static struct clk_fixed_factor g12a_fclk_div2_div = {
-	.mult = 1,
-	.div = 2,
-	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div2_div",
-		.ops = &clk_fixed_factor_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
-		.num_parents = 1,
-	},
-};
-
-static struct clk_regmap g12a_fclk_div2 = {
-	.data = &(struct clk_regmap_gate_data){
-		.offset = HHI_FIX_PLL_CNTL1,
-		.bit_idx = 24,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div2",
-		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "fclk_div2_div" },
-		.num_parents = 1,
-	},
-};
-
-static struct clk_fixed_factor g12a_fclk_div3_div = {
-	.mult = 1,
-	.div = 3,
-	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div3_div",
-		.ops = &clk_fixed_factor_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
-		.num_parents = 1,
-	},
-};
-
-static struct clk_regmap g12a_fclk_div3 = {
-	.data = &(struct clk_regmap_gate_data){
-		.offset = HHI_FIX_PLL_CNTL1,
-		.bit_idx = 20,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "fclk_div3",
-		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "fclk_div3_div" },
-		.num_parents = 1,
-		/*
-		 * This clock is used by the resident firmware and is required
-		 * by the platform to operate correctly.
-		 * Until the following condition are met, we need this clock to
-		 * be marked as critical:
-		 * a) Mark the clock used by a firmware resource, if possible
-		 * b) CCF has a clock hand-off mechanism to make the sure the
-		 *    clock stays on until the proper driver comes along
-		 */
-		.flags = CLK_IS_CRITICAL,
-	},
-};
-
 static struct clk_fixed_factor g12a_fclk_div4_div = {
 	.mult = 1,
 	.div = 4,
@@ -1900,6 +1900,66 @@ static struct clk_regmap g12a_sd_emmc_c_clk0 = {
 	},
 };
 
+/* Video Clocks */
+
+static struct clk_regmap g12a_vid_pll_div = {
+	.data = &(struct meson_vid_pll_div_data){
+		.val = {
+			.reg_off = HHI_VID_PLL_CLK_DIV,
+			.shift   = 0,
+			.width   = 15,
+		},
+		.sel = {
+			.reg_off = HHI_VID_PLL_CLK_DIV,
+			.shift   = 16,
+			.width   = 2,
+		},
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vid_pll_div",
+		.ops = &meson_vid_pll_div_ro_ops,
+		.parent_names = (const char *[]){ "hdmi_pll" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static const char * const g12a_vid_pll_parent_names[] = { "vid_pll_div",
+							  "hdmi_pll" };
+
+static struct clk_regmap g12a_vid_pll_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VID_PLL_CLK_DIV,
+		.mask = 0x1,
+		.shift = 18,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vid_pll_sel",
+		.ops = &clk_regmap_mux_ops,
+		/*
+		 * bit 18 selects from 2 possible parents:
+		 * vid_pll_div or hdmi_pll
+		 */
+		.parent_names = g12a_vid_pll_parent_names,
+		.num_parents = ARRAY_SIZE(g12a_vid_pll_parent_names),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap g12a_vid_pll = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VID_PLL_CLK_DIV,
+		.bit_idx = 19,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vid_pll",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vid_pll_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
 /* VPU Clock */
 
 static const char * const g12a_vpu_parent_names[] = {
@@ -2287,66 +2347,6 @@ static struct clk_regmap g12a_vapb = {
 	},
 };
 
-/* Video Clocks */
-
-static struct clk_regmap g12a_vid_pll_div = {
-	.data = &(struct meson_vid_pll_div_data){
-		.val = {
-			.reg_off = HHI_VID_PLL_CLK_DIV,
-			.shift   = 0,
-			.width   = 15,
-		},
-		.sel = {
-			.reg_off = HHI_VID_PLL_CLK_DIV,
-			.shift   = 16,
-			.width   = 2,
-		},
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vid_pll_div",
-		.ops = &meson_vid_pll_div_ro_ops,
-		.parent_names = (const char *[]){ "hdmi_pll" },
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
-	},
-};
-
-static const char * const g12a_vid_pll_parent_names[] = { "vid_pll_div",
-							  "hdmi_pll" };
-
-static struct clk_regmap g12a_vid_pll_sel = {
-	.data = &(struct clk_regmap_mux_data){
-		.offset = HHI_VID_PLL_CLK_DIV,
-		.mask = 0x1,
-		.shift = 18,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "vid_pll_sel",
-		.ops = &clk_regmap_mux_ops,
-		/*
-		 * bit 18 selects from 2 possible parents:
-		 * vid_pll_div or hdmi_pll
-		 */
-		.parent_names = g12a_vid_pll_parent_names,
-		.num_parents = ARRAY_SIZE(g12a_vid_pll_parent_names),
-		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
-	},
-};
-
-static struct clk_regmap g12a_vid_pll = {
-	.data = &(struct clk_regmap_gate_data){
-		.offset = HHI_VID_PLL_CLK_DIV,
-		.bit_idx = 19,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vid_pll",
-		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "vid_pll_sel" },
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
-	},
-};
-
 static const char * const g12a_vclk_parent_names[] = {
 	"vid_pll", "gp0_pll", "hifi_pll", "mpll1", "fclk_div3", "fclk_div4",
 	"fclk_div5", "fclk_div7"
-- 
2.17.1

