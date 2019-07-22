Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5D9C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B4D2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nxu3lMmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfGVJvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:51:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34087 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbfGVJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:51:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so38751483wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 02:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sj01xNA3JDbqGaNRoQKoEUQ2dvTES//llJmhdN8V66g=;
        b=nxu3lMmrk72CK/+w0rnU4/OOChM7fNLBdi4s7gL3jXjrmfkB4SeAgwYgcx2IMaSw0m
         +Jw1IpCoi0CghezgySeiKJ5ZqwLhneVpvvJvlPZLTPoiO3r6vx2ujr3QEiL2vRXstAEG
         wa5hhtZGs61z6l98/KZfyfuQsHWKh5z7zH5GaZpqhpcsXLp4qricwjE/s4bhldCVkSty
         OKBP1XhjlxKCQehX0Pi+xc7/hBpniogweFHf6agwILNglO2J8bCShR05Z6hBM5twEYEU
         8lZiLTlltiiX8iRcIoMo2aN5f5ASdkm1Tqi21j0zEkX28+nflB1zSI0vo54+fJS2GnGJ
         8FLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sj01xNA3JDbqGaNRoQKoEUQ2dvTES//llJmhdN8V66g=;
        b=QT2YfVxMFH5dnK6Wk6wNl/ZmmeseZsj1dX/bgbQwB6Z3I5f5S1Ta417bLMYiOXQiNb
         nhM5HI9oBhFZbi9wPnM9OhB4q5x+8GbQ27q+J+/izu8jd0rO70tipED+dTPkfaD5ZemW
         xPZCx2V9j5ubP0F2TcdVx8oT0muLflnYcIe6OiYUdFWMWiTb1VDmz1ntECvFEoLAglR7
         klh4lTCSWg42sqIruvEaH9ZaZ6z3RoZCbmi3BB9UCaoshu5lR69TpG55bdOh8Q7bt5vi
         vrjU2uc/a2moMLndRLHxr3elKrEje2oQaaPgU07IEbZf0LrKeIvTYxD/KB9BihiV8hZX
         5FmA==
X-Gm-Message-State: APjAAAUPjHp9on/owp3NrJHuLrbPhm8q6HyuZ1biEUkQYBTioRO2Xzbh
        gdE2hkycaNfpHHD8eULP537Ncw==
X-Google-Smtp-Source: APXvYqyagKCOYpuHJzadGy/aFJFz5VgjxUDN6lNdXeNVb76F8TIZAegKWScV+mLzD7WpKFkzkAa8PA==
X-Received: by 2002:adf:f544:: with SMTP id j4mr74537236wrp.150.1563789062766;
        Mon, 22 Jul 2019 02:51:02 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o3sm31050738wrs.59.2019.07.22.02.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 02:51:02 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 2/4] clk: meson: gxbb-aoclk: migrate to the new parent description method
Date:   Mon, 22 Jul 2019 11:50:51 +0200
Message-Id: <20190722095053.14104-3-amergnat@baylibre.com>
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
 drivers/clk/meson/gxbb-aoclk.c | 55 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 449f6ac189d8..32490e8062e9 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -11,8 +11,6 @@
 #include "clk-regmap.h"
 #include "clk-dualdiv.h"
 
-#define IN_PREFIX "ao-in-"
-
 /* AO Configuration Clock registers offsets */
 #define AO_RTI_PWR_CNTL_REG1	0x0c
 #define AO_RTI_PWR_CNTL_REG0	0x10
@@ -31,7 +29,9 @@ static struct clk_regmap _name##_ao = {					\
 	.hw.init = &(struct clk_init_data) {				\
 		.name = #_name "_ao",					\
 		.ops = &clk_regmap_gate_ops,				\
-		.parent_names = (const char *[]){ IN_PREFIX "mpeg-clk" }, \
+		.parent_data = &(const struct clk_parent_data) {	\
+			.fw_name = "mpeg-clk",				\
+		},							\
 		.num_parents = 1,					\
 		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
@@ -52,7 +52,9 @@ static struct clk_regmap ao_cts_oscin = {
 	.hw.init = &(struct clk_init_data){
 		.name = "ao_cts_oscin",
 		.ops = &clk_regmap_gate_ro_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
 		.num_parents = 1,
 	},
 };
@@ -65,7 +67,7 @@ static struct clk_regmap ao_32k_pre = {
 	.hw.init = &(struct clk_init_data){
 		.name = "ao_32k_pre",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "ao_cts_oscin" },
+		.parent_hws = (const struct clk_hw *[]) { &ao_cts_oscin.hw },
 		.num_parents = 1,
 	},
 };
@@ -112,7 +114,7 @@ static struct clk_regmap ao_32k_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "ao_32k_div",
 		.ops = &meson_clk_dualdiv_ops,
-		.parent_names = (const char *[]){ "ao_32k_pre" },
+		.parent_hws = (const struct clk_hw *[]) { &ao_32k_pre.hw },
 		.num_parents = 1,
 	},
 };
@@ -127,8 +129,10 @@ static struct clk_regmap ao_32k_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "ao_32k_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ "ao_32k_div",
-						  "ao_32k_pre" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&ao_32k_div.hw,
+			&ao_32k_pre.hw
+		},
 		.num_parents = 2,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -142,7 +146,7 @@ static struct clk_regmap ao_32k = {
 	.hw.init = &(struct clk_init_data){
 		.name = "ao_32k",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "ao_32k_sel" },
+		.parent_hws = (const struct clk_hw *[]) { &ao_32k_sel.hw },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -159,10 +163,12 @@ static struct clk_regmap ao_cts_rtc_oscin = {
 	.hw.init = &(struct clk_init_data){
 		.name = "ao_cts_rtc_oscin",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "ext-32k-0",
-						  IN_PREFIX "ext-32k-1",
-						  IN_PREFIX "ext-32k-2",
-						  "ao_32k" },
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "ext-32k-0", },
+			{ .fw_name = "ext-32k-1", },
+			{ .fw_name = "ext-32k-2", },
+			{ .hw = &ao_32k.hw },
+		},
 		.num_parents = 4,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -178,8 +184,10 @@ static struct clk_regmap ao_clk81 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "ao_clk81",
 		.ops = &clk_regmap_mux_ro_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "mpeg-clk",
-						  "ao_cts_rtc_oscin" },
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "mpeg-clk", },
+			{ .hw = &ao_cts_rtc_oscin.hw },
+		},
 		.num_parents = 2,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -208,8 +216,10 @@ static struct clk_regmap ao_cts_cec = {
 		 * Until CCF gets fixed, adding this fake parent that won't
 		 * ever be registered should work around the problem
 		 */
-		.parent_names = (const char *[]){ "fixme",
-						  "ao_cts_rtc_oscin" },
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "fixme", },
+			{ .hw = &ao_cts_rtc_oscin.hw },
+		},
 		.num_parents = 2,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -261,14 +271,6 @@ static const struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
 	.num = NR_CLKS,
 };
 
-static const struct meson_aoclk_input gxbb_aoclk_inputs[] = {
-	{ .name = "xtal",	.required = true,  },
-	{ .name = "mpeg-clk",	.required = true,  },
-	{. name = "ext-32k-0",	.required = false, },
-	{. name = "ext-32k-1",	.required = false, },
-	{. name = "ext-32k-2",	.required = false, },
-};
-
 static const struct meson_aoclk_data gxbb_aoclkc_data = {
 	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
 	.num_reset	= ARRAY_SIZE(gxbb_aoclk_reset),
@@ -276,9 +278,6 @@ static const struct meson_aoclk_data gxbb_aoclkc_data = {
 	.num_clks	= ARRAY_SIZE(gxbb_aoclk),
 	.clks		= gxbb_aoclk,
 	.hw_data	= &gxbb_aoclk_onecell_data,
-	.inputs		= gxbb_aoclk_inputs,
-	.num_inputs	= ARRAY_SIZE(gxbb_aoclk_inputs),
-	.input_prefix	= IN_PREFIX,
 };
 
 static const struct of_device_id gxbb_aoclkc_match_table[] = {
-- 
2.17.1

