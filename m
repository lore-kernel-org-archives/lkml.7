Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D70C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747FC2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="g1AWuEEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfGVJvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:51:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42929 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbfGVJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:51:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so23706691wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+R127HEVGHOO/AjJtJo08bSVN+XpGtu/IEcCAx9bvEA=;
        b=g1AWuEEij9EHzIHvQEjI2Kvd+ut1J4vnElQ/c7QfCyOkp9smdLRWz/tIWFTiBfDHCa
         UfWjTeH/PQzQrzA/42yOEn9c1A8mNQV/39npov39m8SQb6j/31MMjy1ravTY7ggZ+Afd
         +HVkk6Ae2bTGXtRPif1Nt+2rRGCIa5qdL5szvPPpXP3ZBwYUAf8pQeSeSn0YJGmGdsQU
         MD3lVz01ga7ZztyQfTOCgM8XbPTwujDCGZkzAagOoZ/d41F1BS4pVGswcnH2/AbHUSk9
         Lj5GlWxL5pqN4RJUB1uV0UnLcZgPa+hmgAvnILsPKPmOIgxV+iHXdckRO7AuTG9Y1jOt
         FbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+R127HEVGHOO/AjJtJo08bSVN+XpGtu/IEcCAx9bvEA=;
        b=ldG9/spcCrNjOxHM3aMpFKBeXbmTGGHIHFNUaosief92+5H7r3VZxxtLxaSq+445Ey
         3p8wdQG2B5fYf6xVpOQEF297gKkxV54gCgRB3Xn9PKa2C+uOg+kFqfN/2RvSjCILx4IM
         DdvV/yS/52kXGdgVC9g8gfh8VQSWtd1VQFLSJH5P8VVJXDIF8HRnhsGUVvFm4+Ja69X4
         YaY1W+8dMMfIkiWe/Mxfx86+SodexAMmC7xMsG+Z/LTCZWwbzngMi3NwpK+8+D/hN0js
         CvVAnxLaaqcpaiRKZxx3eflV1GUmbLzTF82W+Y/yW4IpNCjMtkxZ4K+lRj41N6WcKd46
         UWpw==
X-Gm-Message-State: APjAAAUU9sJvWY0u7M/XUOy7C/gaqK9LGn3T8uAcvr/k3o4LvMgG9VNd
        /Fnmp0r6Ts+PBSth8folUZaAug==
X-Google-Smtp-Source: APXvYqwpM9cb5mnyH0Jx9bxsUNNqtjlQWgH0gGJWSuufCyFipIztjrkVgQZF/mPapfDWvpXq4YAVNA==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr76314945wrs.88.1563789061859;
        Mon, 22 Jul 2019 02:51:01 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o3sm31050738wrs.59.2019.07.22.02.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 02:51:01 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 1/4] clk: meson: g12a-aoclk: migrate to the new parent description method
Date:   Mon, 22 Jul 2019 11:50:50 +0200
Message-Id: <20190722095053.14104-2-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722095053.14104-1-amergnat@baylibre.com>
References: <20190722095053.14104-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock controller use the string comparison method to describe parent
relation between the clocks, which is not optimized.

Migrate to the new way by using .parent_hws where possible (when parent
clocks are localy declared in the controller) and use .parent_data
otherwise.

Remove clk input helper and all bypass clocks (declared in probe function)
which are no longer used since we are able to use device-tree clock name
directly.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/clk/meson/g12a-aoclk.c | 81 +++++++++++++++++++++-------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
index 1994e735396b..62499563e4f5 100644
--- a/drivers/clk/meson/g12a-aoclk.c
+++ b/drivers/clk/meson/g12a-aoclk.c
@@ -18,8 +18,6 @@
 #include "clk-regmap.h"
 #include "clk-dualdiv.h"
 
-#define IN_PREFIX "ao-in-"
-
 /*
  * AO Configuration Clock registers offsets
  * Register offsets from the data sheet must be multiplied by 4.
@@ -51,7 +49,9 @@ static struct clk_regmap g12a_aoclk_##_name = {				\
 	.hw.init = &(struct clk_init_data) {				\
 		.name =  "g12a_ao_" #_name,				\
 		.ops = &clk_regmap_gate_ops,				\
-		.parent_names = (const char *[]){ IN_PREFIX "mpeg-clk" }, \
+		.parent_data = &(const struct clk_parent_data) {	\
+			.fw_name = "mpeg-clk",				\
+		},							\
 		.num_parents = 1,					\
 		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
@@ -81,7 +81,9 @@ static struct clk_regmap g12a_aoclk_cts_oscin = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_oscin",
 		.ops = &clk_regmap_gate_ro_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
 		.num_parents = 1,
 	},
 };
@@ -106,7 +108,9 @@ static struct clk_regmap g12a_aoclk_32k_by_oscin_pre = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_32k_by_oscin_pre",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "cts_oscin" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_aoclk_cts_oscin.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -143,7 +147,9 @@ static struct clk_regmap g12a_aoclk_32k_by_oscin_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_32k_by_oscin_div",
 		.ops = &meson_clk_dualdiv_ops,
-		.parent_names = (const char *[]){ "g12a_ao_32k_by_oscin_pre" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_aoclk_32k_by_oscin_pre.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -158,8 +164,10 @@ static struct clk_regmap g12a_aoclk_32k_by_oscin_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_32k_by_oscin_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ "g12a_ao_32k_by_oscin_div",
-						  "g12a_ao_32k_by_oscin_pre" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_aoclk_32k_by_oscin_div.hw,
+			&g12a_aoclk_32k_by_oscin_pre.hw,
+		},
 		.num_parents = 2,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -173,7 +181,9 @@ static struct clk_regmap g12a_aoclk_32k_by_oscin = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_32k_by_oscin",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "g12a_ao_32k_by_oscin_sel" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_aoclk_32k_by_oscin_sel.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -189,7 +199,9 @@ static struct clk_regmap g12a_aoclk_cec_pre = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_cec_pre",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "cts_oscin" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_aoclk_cts_oscin.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -226,7 +238,9 @@ static struct clk_regmap g12a_aoclk_cec_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_cec_div",
 		.ops = &meson_clk_dualdiv_ops,
-		.parent_names = (const char *[]){ "g12a_ao_cec_pre" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_aoclk_cec_pre.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -241,8 +255,10 @@ static struct clk_regmap g12a_aoclk_cec_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_cec_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ "g12a_ao_cec_div",
-						  "g12a_ao_cec_pre" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_aoclk_cec_div.hw,
+			&g12a_aoclk_cec_pre.hw,
+		},
 		.num_parents = 2,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -256,7 +272,9 @@ static struct clk_regmap g12a_aoclk_cec = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_cec",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "g12a_ao_cec_sel" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_aoclk_cec_sel.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -272,8 +290,10 @@ static struct clk_regmap g12a_aoclk_cts_rtc_oscin = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_cts_rtc_oscin",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ "g12a_ao_32k_by_oscin",
-						  IN_PREFIX "ext_32k-0" },
+		.parent_data = (const struct clk_parent_data []) {
+			{ .hw = &g12a_aoclk_32k_by_oscin.hw },
+			{ .fw_name = "ext-32k-0", },
+		},
 		.num_parents = 2,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -289,8 +309,10 @@ static struct clk_regmap g12a_aoclk_clk81 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_clk81",
 		.ops = &clk_regmap_mux_ro_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "mpeg-clk",
-						  "g12a_ao_cts_rtc_oscin"},
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "mpeg-clk", },
+			{ .hw = &g12a_aoclk_cts_rtc_oscin.hw },
+		},
 		.num_parents = 2,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -305,8 +327,10 @@ static struct clk_regmap g12a_aoclk_saradc_mux = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_saradc_mux",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "xtal",
-						  "g12a_ao_clk81" },
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .hw = &g12a_aoclk_clk81.hw },
+		},
 		.num_parents = 2,
 	},
 };
@@ -320,7 +344,9 @@ static struct clk_regmap g12a_aoclk_saradc_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_saradc_div",
 		.ops = &clk_regmap_divider_ops,
-		.parent_names = (const char *[]){ "g12a_ao_saradc_mux" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_aoclk_saradc_mux.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -334,7 +360,9 @@ static struct clk_regmap g12a_aoclk_saradc_gate = {
 	.hw.init = &(struct clk_init_data){
 		.name = "g12a_ao_saradc_gate",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "g12a_ao_saradc_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_aoclk_saradc_div.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -417,12 +445,6 @@ static const struct clk_hw_onecell_data g12a_aoclk_onecell_data = {
 	.num = NR_CLKS,
 };
 
-static const struct meson_aoclk_input g12a_aoclk_inputs[] = {
-	{ .name = "xtal",	.required = true  },
-	{ .name = "mpeg-clk",	.required = true  },
-	{ .name = "ext-32k-0",	.required = false },
-};
-
 static const struct meson_aoclk_data g12a_aoclkc_data = {
 	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
 	.num_reset	= ARRAY_SIZE(g12a_aoclk_reset),
@@ -430,9 +452,6 @@ static const struct meson_aoclk_data g12a_aoclkc_data = {
 	.num_clks	= ARRAY_SIZE(g12a_aoclk_regmap),
 	.clks		= g12a_aoclk_regmap,
 	.hw_data	= &g12a_aoclk_onecell_data,
-	.inputs		= g12a_aoclk_inputs,
-	.num_inputs	= ARRAY_SIZE(g12a_aoclk_inputs),
-	.input_prefix	= IN_PREFIX,
 };
 
 static const struct of_device_id g12a_aoclkc_match_table[] = {
-- 
2.17.1

