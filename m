Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62BDC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9344421951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nvW5oTHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390803AbfGYQm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:42:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42007 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390744AbfGYQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:42:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so1581240wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cIceYeZmXLnDB8KmyjeQxrFIl+tdDqzy/AgzjLz1uyc=;
        b=nvW5oTHj4gQvGHo7lcJTswmWZ60wi/xYBHu7DlVCK3SgRT9tDHv3cwNDKYa1vMRMJ2
         wjRTerLSX8BtgER/mmzHTwkN99x+hXleNLtcmj5lahZqo+eJPKQ/JUXizGP8keAVr55f
         IkhsJjfKA85qwvXy8beI/7YsfkpurbaHSJBglWN3ykH4v4khuYs897QILrSOJVkugP3x
         oObQA3uwYz+KXwjghszb9SuyMOJJGoIDqiXjPOdv4KLMS55aA0LiZfughhBuEdRzB1lc
         1V9TfEMwzVsamOPwSovxsw3dfs2wS6If5Nwj0IdhlDe2O/u9+FJZsMHAjVSWdv1kR+hk
         waiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cIceYeZmXLnDB8KmyjeQxrFIl+tdDqzy/AgzjLz1uyc=;
        b=PjnK3ML3bQuWUfgAxd8ZUVLlRi0BiLueS5dxbZpuT2F0UWJbv0YBQAYt6RUBZ7GdI9
         0cZAzA2kfzM05LcqGCt4pkmjy0xfLNJf26DfxmqkXXB/eyFezFhu8ECuW+RiHA++BBPD
         QNGNgmKxDtneOQS3yP0BHq41oZabiHUqEfbqsYti5zkQVwsp0VsAOsc0TCJ9teMmEOBl
         z1hnX+35d66Nz4mtl5OAKeHjzbHWAF1yIYgMDKurIvCiX3WpTNHQZR9307PzxcnkYjZt
         danMavxjSNUKdzxTYD5ptlMamT4DZLCk7RkdjkkNmgYnJzxmbzt/R9btKtocc2wWLfDn
         8BTw==
X-Gm-Message-State: APjAAAVzOvSGs8lakWVDS/V8wn+jn9M68l5zIJf4qVM2pdQ5SdKcPpZZ
        0CdzKvEWX+uao+eaAsZyGL54K7EjNIY=
X-Google-Smtp-Source: APXvYqyQZGlsKFWD/sDLe1hv4n9haHqDBHhVsDzbHoc0AZ36ZoPvsaEYl81aAQ8BA1KiwCsC3cR0RQ==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr41077814wru.288.1564072973815;
        Thu, 25 Jul 2019 09:42:53 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id 91sm103031727wrp.3.2019.07.25.09.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:42:53 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 1/8] clk: meson: g12a: move clock declaration to dependency order
Date:   Thu, 25 Jul 2019 18:42:31 +0200
Message-Id: <20190725164238.27991-2-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725164238.27991-1-amergnat@baylibre.com>
References: <20190725164238.27991-1-amergnat@baylibre.com>
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

