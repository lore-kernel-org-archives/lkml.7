Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E3CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6B822C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mg9P8zts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390558AbfGYQlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:41:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53801 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389463AbfGYQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:41:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so45603636wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+R127HEVGHOO/AjJtJo08bSVN+XpGtu/IEcCAx9bvEA=;
        b=mg9P8ztsV3J8jlHD2Kv34wz/u0yngpFjS9qSe7JQJ6JwWAXqovIwpeXTMEN2dSwC2T
         HjQG2Hq5OdWIoCfBLWbhoA1UrtCHmMdcxdGM+wKVPG/Syo/ON0Kf4DpZ2zQlattrl2q8
         dCvGmaHaze78+9CPQvXX5osXwhVAagLGWZjvVjwog1r/0qJ0cRknxkuSjOQ8UE8Lhb02
         36DdncppVoWRiykG+KdkDSpWvnk6/HeBbKSHZ98fsCs2Tx/ysz7jdjWJ8beE0iie05t+
         UfSuKpUe3J/yP4PTGThKfge20Hz8vifLYbHaGQS+2088mZFP4q+WqAKd8hnyVLIz/D4Z
         Earw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+R127HEVGHOO/AjJtJo08bSVN+XpGtu/IEcCAx9bvEA=;
        b=KzLI2fYb/dQjopAFHfmWM55glDuGGcZZID4nEQ2i33e4qQxVR4hnYrgub8Nm+dQTIN
         eYGXbilfzhSPzYoGqAmikB4qOKrmz71AmTADqDx0RIQGOli+wMrFkd7bWLcXiick7mfb
         MoaIFVDKARFWzPKVz5OqLaydc4Q0gH8XxOluo7RPvZFdBetKNCYd4NKwBQMzSVmCa/MU
         RHdZ4GNBIH0pirZNXVmheeQgUHN8pBh61B0lHxleWHJtcA2tDILnhuOHlogau7oLjb6q
         p/BhYNhrpPa1wJzcNYCrKMtB2ccAQg3hJcORSBmIWsicA7SteaOmHDwWjr8yaQzam6KR
         fKFg==
X-Gm-Message-State: APjAAAWabXGCXCFUUPsXyK7oAFdQuc9ohgagW1pcrs4iNQGydDJH7Cqx
        mfw7iGJLPv6EPPpN5XZ+1ADQ3A==
X-Google-Smtp-Source: APXvYqyfJxkS4dKcjVM13upB85N+j79d3XoPdVFnRdmoBO/g2YeAGymDna0OxE9EPIN8wAZ7oUZhLA==
X-Received: by 2002:a1c:cb43:: with SMTP id b64mr79198139wmg.135.1564072905509;
        Thu, 25 Jul 2019 09:41:45 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id y16sm102488858wrg.85.2019.07.25.09.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:41:45 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 1/4] clk: meson: g12a-aoclk: migrate to the new parent description method
Date:   Thu, 25 Jul 2019 18:41:23 +0200
Message-Id: <20190725164126.27919-2-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725164126.27919-1-amergnat@baylibre.com>
References: <20190725164126.27919-1-amergnat@baylibre.com>
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

