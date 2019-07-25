Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A52BC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AB12238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bjuEcobo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390415AbfGYQlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:41:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44811 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389885AbfGYQlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:41:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so51461828wrf.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ookaJsEM1c9+mJiyULUo/W8hYZX1ldIWr6q0D9akHHk=;
        b=bjuEcoboV1HD+t1ArWKkoSGnenLwO0vKH/nMxcb8+46hqW9Cel+01K/H4EoaK+SClE
         GJKcj7jUP+hn5BOBXBsybjZwP5k6u+OPm/1lK5o3n8fFXUXQgciw9hsdjVbUh0TQC8Lx
         jw+3i42AwS8W3dMhuLSA9Pw/KeG1//LcKtv5rIrzQPXUNI+X5nZzMxetzVTW5E+mVzbk
         CE/Q+afbaO3QZiOQnKAbFFyZsWyNz4jHN1d3ekKh4Se757eyaMzgF+8lus0dcWSIBlQp
         ovr07Qy6WGmO9/cYvWhQMMYe/9cfeRUkDjO7lCzeEaWiRZwsVM4L2suMy1gT83AaRPbU
         QdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ookaJsEM1c9+mJiyULUo/W8hYZX1ldIWr6q0D9akHHk=;
        b=jm0I/ebZUQF8l3F9OZdd7oCj34tLPCG0K0q0bvscb53rDKIhvGuPShawDgpM8RoEaW
         qc0C5LkS3yQ09cK+3/bZbpYPHDSd/YoW7Pzaoo7P0Pex++qma1JLXaXFAVElAQRqzOcV
         A0x2gPdoA59RsOnc3igzg6gw7nv2vg35gkSEifv1VeBxdyFKkBtZpZgCvuGLe2c7Zz52
         Qc8zKz9KSb8EGEPQQ/H8nahAg5cg3lxAVdiXlmcpWrYvbXnAXPInm1Nj8bLXfJvvtLBI
         +2ZA0xiXL2pffooQ7SoPGlN5DUNqAHskbKaVl4HnWbsuZa97WwiB692KWz48yxR3ZBCm
         PnyA==
X-Gm-Message-State: APjAAAVTEjb43Axlo8NEvqcJNbVi0gO2J4SPepRaS8NusiRj64CQqTEz
        rv6G4Y52uQdeFD+Uz44I6q6+gQ==
X-Google-Smtp-Source: APXvYqyBR1WYCdm79WeDP3xb/aWV98npTC5HMV4Rc2LYR8W0pm63SwAFPuvQ39Uk9oIPpioTWzeogw==
X-Received: by 2002:adf:ec8e:: with SMTP id z14mr55137751wrn.269.1564072906709;
        Thu, 25 Jul 2019 09:41:46 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id y16sm102488858wrg.85.2019.07.25.09.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:41:46 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 2/4] clk: meson: gxbb-aoclk: migrate to the new parent description method
Date:   Thu, 25 Jul 2019 18:41:24 +0200
Message-Id: <20190725164126.27919-3-amergnat@baylibre.com>
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
 drivers/clk/meson/gxbb-aoclk.c | 55 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 449f6ac189d8..e940861a396b 100644
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
+			{ .name = "fixme", .index = -1, },
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

