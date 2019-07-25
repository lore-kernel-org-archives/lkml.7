Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02F8C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA1C2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ouz1qI5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390875AbfGYQnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:43:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35173 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390822AbfGYQnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:43:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so45321582wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6R0NWQlnIAwKuRysvv9K9RxgnaCJkMi344ya2fVJ/bE=;
        b=Ouz1qI5MJvkTo1sbog542DgjZ5mugcBNBpmPDpVJGi6avKnXcG4x1Dh8khmEFQVGfy
         jYErrv6sVuW0Ih9p7SCS7eBASEaz1k9OHwZazbofeCa6ePYlTvztnfY7A2B9bvsi+U1B
         2HsqRntO3VoapBYTpv5HqflLS+Ye9h3L7kcsaglo8C7m/7ED1ah5+d4u0wNJrj7/5MnK
         98XqqHtzhSMrjU0UkOeWrJtqIkAni8zZZ69wnrUWSw185IRKjQwFWSDkS7Tt2Fp+KEIr
         cDuXRk1IgjFE733XbreVkBfJY5UUDtDeFMOCYJKCXPc25lb7OFkyVfZIXRTFzY9rjtPB
         bNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6R0NWQlnIAwKuRysvv9K9RxgnaCJkMi344ya2fVJ/bE=;
        b=QjTscjKxN+bWs1d8h4hRq47nmCBCaeoUTQJ4Kl8dlSnMgbmIPY7uon/eovBZ5XPiwf
         byO0ox5ujM+GeJBBCDe0kKWYNu9uHP3CVrdT7fVFy57vd83SY00/1ltaNLBhy5wm55Yu
         DuzP0quVfPUVqIHoW5kOeX99IvpRK1e4PdwIWHizWdbtxAzWYfHT5dnwes7W7yyVvbxx
         ll8XuF20Uwis5pvixhZE9+zqxQPc0LKKO+q4rQfDhNXE+X8JJMydut3w5SraKjQjq+0L
         M6SwPRbWnSVLQ+cxjRMF6exL/LjhDKa5d2X+wfIkgTZaBOtUW6rakvKJU5jpS9OlZ7it
         Hk2A==
X-Gm-Message-State: APjAAAWrMVdKOh7JmZfT2x8J4bd1YbHDXWaujVRRg7d8SFt+PMAaoCAq
        I/XPNu0VPr53gOhCQKI0Z9vXPQ==
X-Google-Smtp-Source: APXvYqweZQgiZ19UpOyj1veKPThi0ExhfIA30ndg5MwNDPxLTjtI8RR7mZjvtVIAtPnbfFTK4eKTog==
X-Received: by 2002:a1c:18a:: with SMTP id 132mr81363176wmb.15.1564072980971;
        Thu, 25 Jul 2019 09:43:00 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id 91sm103031727wrp.3.2019.07.25.09.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:43:00 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 4/8] clk: meson: axg: migrate to the new parent description method
Date:   Thu, 25 Jul 2019 18:42:34 +0200
Message-Id: <20190725164238.27991-5-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725164238.27991-1-amergnat@baylibre.com>
References: <20190725164238.27991-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock controller use the string comparison method to describe parent
relation between the clocks, which is not optimized.

Migrate to the new way by using .parent_hws where possible (ie. when
all clocks are local to the controller) and use .parent_data otherwise.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/clk/meson/axg.c | 204 ++++++++++++++++++++++++++++------------
 1 file changed, 144 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 3ddd0efc9ee0..7a3d795cc614 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -14,7 +14,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
-#include "clk-input.h"
 #include "clk-regmap.h"
 #include "clk-pll.h"
 #include "clk-mpll.h"
@@ -59,7 +58,9 @@ static struct clk_regmap axg_fixed_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
 		.num_parents = 1,
 	},
 };
@@ -74,7 +75,9 @@ static struct clk_regmap axg_fixed_pll = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_names = (const char *[]){ "fixed_pll_dco" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_fixed_pll_dco.hw
+		},
 		.num_parents = 1,
 		/*
 		 * This clock won't ever change at runtime so
@@ -114,7 +117,9 @@ static struct clk_regmap axg_sys_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
 		.num_parents = 1,
 	},
 };
@@ -129,7 +134,9 @@ static struct clk_regmap axg_sys_pll = {
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_names = (const char *[]){ "sys_pll_dco" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_sys_pll_dco.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -215,7 +222,9 @@ static struct clk_regmap axg_gp0_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
 		.num_parents = 1,
 	},
 };
@@ -230,7 +239,9 @@ static struct clk_regmap axg_gp0_pll = {
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll",
 		.ops = &clk_regmap_divider_ops,
-		.parent_names = (const char *[]){ "gp0_pll_dco" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_gp0_pll_dco.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -284,7 +295,9 @@ static struct clk_regmap axg_hifi_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "hifi_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
 		.num_parents = 1,
 	},
 };
@@ -299,7 +312,9 @@ static struct clk_regmap axg_hifi_pll = {
 	.hw.init = &(struct clk_init_data){
 		.name = "hifi_pll",
 		.ops = &clk_regmap_divider_ops,
-		.parent_names = (const char *[]){ "hifi_pll_dco" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_hifi_pll_dco.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -311,7 +326,7 @@ static struct clk_fixed_factor axg_fclk_div2_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fclk_div2_div",
 		.ops = &clk_fixed_factor_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_hws = (const struct clk_hw *[]) { &axg_fixed_pll.hw },
 		.num_parents = 1,
 	},
 };
@@ -324,7 +339,9 @@ static struct clk_regmap axg_fclk_div2 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fclk_div2",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "fclk_div2_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_fclk_div2_div.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_IS_CRITICAL,
 	},
@@ -336,7 +353,7 @@ static struct clk_fixed_factor axg_fclk_div3_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fclk_div3_div",
 		.ops = &clk_fixed_factor_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_hws = (const struct clk_hw *[]) { &axg_fixed_pll.hw },
 		.num_parents = 1,
 	},
 };
@@ -349,7 +366,9 @@ static struct clk_regmap axg_fclk_div3 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fclk_div3",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "fclk_div3_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_fclk_div3_div.hw
+		},
 		.num_parents = 1,
 		/*
 		 * FIXME:
@@ -372,7 +391,7 @@ static struct clk_fixed_factor axg_fclk_div4_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fclk_div4_div",
 		.ops = &clk_fixed_factor_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_hws = (const struct clk_hw *[]) { &axg_fixed_pll.hw },
 		.num_parents = 1,
 	},
 };
@@ -385,7 +404,9 @@ static struct clk_regmap axg_fclk_div4 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fclk_div4",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "fclk_div4_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_fclk_div4_div.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -396,7 +417,7 @@ static struct clk_fixed_factor axg_fclk_div5_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fclk_div5_div",
 		.ops = &clk_fixed_factor_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_hws = (const struct clk_hw *[]) { &axg_fixed_pll.hw },
 		.num_parents = 1,
 	},
 };
@@ -409,7 +430,9 @@ static struct clk_regmap axg_fclk_div5 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fclk_div5",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "fclk_div5_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_fclk_div5_div.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -420,7 +443,9 @@ static struct clk_fixed_factor axg_fclk_div7_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fclk_div7_div",
 		.ops = &clk_fixed_factor_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_fixed_pll.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -433,7 +458,9 @@ static struct clk_regmap axg_fclk_div7 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fclk_div7",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "fclk_div7_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_fclk_div7_div.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -447,7 +474,9 @@ static struct clk_regmap axg_mpll_prediv = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll_prediv",
 		.ops = &clk_regmap_divider_ro_ops,
-		.parent_names = (const char *[]){ "fixed_pll" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_fixed_pll.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -480,7 +509,9 @@ static struct clk_regmap axg_mpll0_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "mpll_prediv" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_mpll_prediv.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -493,7 +524,9 @@ static struct clk_regmap axg_mpll0 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "mpll0_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_mpll0_div.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -527,7 +560,9 @@ static struct clk_regmap axg_mpll1_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "mpll_prediv" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_mpll_prediv.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -540,7 +575,9 @@ static struct clk_regmap axg_mpll1 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "mpll1_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_mpll1_div.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -579,7 +616,9 @@ static struct clk_regmap axg_mpll2_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "mpll_prediv" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_mpll_prediv.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -592,7 +631,9 @@ static struct clk_regmap axg_mpll2 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "mpll2_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_mpll2_div.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -626,7 +667,9 @@ static struct clk_regmap axg_mpll3_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll3_div",
 		.ops = &meson_clk_mpll_ops,
-		.parent_names = (const char *[]){ "mpll_prediv" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_mpll_prediv.hw
+		},
 		.num_parents = 1,
 	},
 };
@@ -639,7 +682,9 @@ static struct clk_regmap axg_mpll3 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll3",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "mpll3_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_mpll3_div.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -702,7 +747,9 @@ static struct clk_regmap axg_pcie_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "pcie_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_names = (const char *[]){ IN_PREFIX "xtal" },
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
 		.num_parents = 1,
 	},
 };
@@ -717,7 +764,9 @@ static struct clk_regmap axg_pcie_pll_od = {
 	.hw.init = &(struct clk_init_data){
 		.name = "pcie_pll_od",
 		.ops = &clk_regmap_divider_ops,
-		.parent_names = (const char *[]){ "pcie_pll_dco" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_pcie_pll_dco.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -733,7 +782,9 @@ static struct clk_regmap axg_pcie_pll = {
 	.hw.init = &(struct clk_init_data){
 		.name = "pcie_pll",
 		.ops = &clk_regmap_divider_ops,
-		.parent_names = (const char *[]){ "pcie_pll_od" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_pcie_pll_od.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -750,7 +801,7 @@ static struct clk_regmap axg_pcie_mux = {
 	.hw.init = &(struct clk_init_data){
 		.name = "pcie_mux",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ "pcie_pll" },
+		.parent_hws = (const struct clk_hw *[]) { &axg_pcie_pll.hw },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -767,7 +818,7 @@ static struct clk_regmap axg_pcie_ref = {
 	.hw.init = &(struct clk_init_data){
 		.name = "pcie_ref",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = (const char *[]){ "pcie_mux" },
+		.parent_hws = (const struct clk_hw *[]) { &axg_pcie_mux.hw },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -781,7 +832,7 @@ static struct clk_regmap axg_pcie_cml_en0 = {
 	.hw.init = &(struct clk_init_data) {
 		.name = "pcie_cml_en0",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "pcie_ref" },
+		.parent_hws = (const struct clk_hw *[]) { &axg_pcie_ref.hw },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 
@@ -796,16 +847,21 @@ static struct clk_regmap axg_pcie_cml_en1 = {
 	.hw.init = &(struct clk_init_data) {
 		.name = "pcie_cml_en1",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "pcie_ref" },
+		.parent_hws = (const struct clk_hw *[]) { &axg_pcie_ref.hw },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
 static u32 mux_table_clk81[]	= { 0, 2, 3, 4, 5, 6, 7 };
-static const char * const clk81_parent_names[] = {
-	IN_PREFIX "xtal", "fclk_div7", "mpll1", "mpll2", "fclk_div4",
-	"fclk_div3", "fclk_div5"
+static const struct clk_parent_data clk81_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &axg_fclk_div7.hw },
+	{ .hw = &axg_mpll1.hw },
+	{ .hw = &axg_mpll2.hw },
+	{ .hw = &axg_fclk_div4.hw },
+	{ .hw = &axg_fclk_div3.hw },
+	{ .hw = &axg_fclk_div5.hw },
 };
 
 static struct clk_regmap axg_mpeg_clk_sel = {
@@ -818,8 +874,8 @@ static struct clk_regmap axg_mpeg_clk_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_sel",
 		.ops = &clk_regmap_mux_ro_ops,
-		.parent_names = clk81_parent_names,
-		.num_parents = ARRAY_SIZE(clk81_parent_names),
+		.parent_data = clk81_parent_data,
+		.num_parents = ARRAY_SIZE(clk81_parent_data),
 	},
 };
 
@@ -832,7 +888,9 @@ static struct clk_regmap axg_mpeg_clk_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_div",
 		.ops = &clk_regmap_divider_ops,
-		.parent_names = (const char *[]){ "mpeg_clk_sel" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_mpeg_clk_sel.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -846,15 +904,20 @@ static struct clk_regmap axg_clk81 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "clk81",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "mpeg_clk_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_mpeg_clk_div.hw
+		},
 		.num_parents = 1,
 		.flags = (CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
 	},
 };
 
-static const char * const axg_sd_emmc_clk0_parent_names[] = {
-	IN_PREFIX "xtal", "fclk_div2", "fclk_div3", "fclk_div5", "fclk_div7",
-
+static const struct clk_parent_data axg_sd_emmc_clk0_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &axg_fclk_div2.hw },
+	{ .hw = &axg_fclk_div3.hw },
+	{ .hw = &axg_fclk_div5.hw },
+	{ .hw = &axg_fclk_div7.hw },
 	/*
 	 * Following these parent clocks, we should also have had mpll2, mpll3
 	 * and gp0_pll but these clocks are too precious to be used here. All
@@ -873,8 +936,8 @@ static struct clk_regmap axg_sd_emmc_b_clk0_sel = {
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_b_clk0_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = axg_sd_emmc_clk0_parent_names,
-		.num_parents = ARRAY_SIZE(axg_sd_emmc_clk0_parent_names),
+		.parent_data = axg_sd_emmc_clk0_parent_data,
+		.num_parents = ARRAY_SIZE(axg_sd_emmc_clk0_parent_data),
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
@@ -889,7 +952,9 @@ static struct clk_regmap axg_sd_emmc_b_clk0_div = {
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_b_clk0_div",
 		.ops = &clk_regmap_divider_ops,
-		.parent_names = (const char *[]){ "sd_emmc_b_clk0_sel" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_sd_emmc_b_clk0_sel.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -903,7 +968,9 @@ static struct clk_regmap axg_sd_emmc_b_clk0 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_b_clk0",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "sd_emmc_b_clk0_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_sd_emmc_b_clk0_div.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -919,8 +986,8 @@ static struct clk_regmap axg_sd_emmc_c_clk0_sel = {
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_c_clk0_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = axg_sd_emmc_clk0_parent_names,
-		.num_parents = ARRAY_SIZE(axg_sd_emmc_clk0_parent_names),
+		.parent_data = axg_sd_emmc_clk0_parent_data,
+		.num_parents = ARRAY_SIZE(axg_sd_emmc_clk0_parent_data),
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
@@ -935,7 +1002,9 @@ static struct clk_regmap axg_sd_emmc_c_clk0_div = {
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_c_clk0_div",
 		.ops = &clk_regmap_divider_ops,
-		.parent_names = (const char *[]){ "sd_emmc_c_clk0_sel" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_sd_emmc_c_clk0_sel.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -949,7 +1018,9 @@ static struct clk_regmap axg_sd_emmc_c_clk0 = {
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_c_clk0",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "sd_emmc_c_clk0_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_sd_emmc_c_clk0_div.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -957,9 +1028,18 @@ static struct clk_regmap axg_sd_emmc_c_clk0 = {
 
 static u32 mux_table_gen_clk[]	= { 0, 4, 5, 6, 7, 8,
 				    9, 10, 11, 13, 14, };
-static const char * const gen_clk_parent_names[] = {
-	IN_PREFIX "xtal", "hifi_pll", "mpll0", "mpll1", "mpll2", "mpll3",
-	"fclk_div4", "fclk_div3", "fclk_div5", "fclk_div7", "gp0_pll",
+static const struct clk_parent_data gen_clk_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &axg_hifi_pll.hw },
+	{ .hw = &axg_mpll0.hw },
+	{ .hw = &axg_mpll1.hw },
+	{ .hw = &axg_mpll2.hw },
+	{ .hw = &axg_mpll3.hw },
+	{ .hw = &axg_fclk_div4.hw },
+	{ .hw = &axg_fclk_div3.hw },
+	{ .hw = &axg_fclk_div5.hw },
+	{ .hw = &axg_fclk_div7.hw },
+	{ .hw = &axg_gp0_pll.hw },
 };
 
 static struct clk_regmap axg_gen_clk_sel = {
@@ -978,8 +1058,8 @@ static struct clk_regmap axg_gen_clk_sel = {
 		 * hifi_pll, mpll0, mpll1, mpll2, mpll3, fdiv4,
 		 * fdiv3, fdiv5, [cts_msr_clk], fdiv7, gp0_pll
 		 */
-		.parent_names = gen_clk_parent_names,
-		.num_parents = ARRAY_SIZE(gen_clk_parent_names),
+		.parent_data = gen_clk_parent_data,
+		.num_parents = ARRAY_SIZE(gen_clk_parent_data),
 	},
 };
 
@@ -992,7 +1072,9 @@ static struct clk_regmap axg_gen_clk_div = {
 	.hw.init = &(struct clk_init_data){
 		.name = "gen_clk_div",
 		.ops = &clk_regmap_divider_ops,
-		.parent_names = (const char *[]){ "gen_clk_sel" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_gen_clk_sel.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
@@ -1006,7 +1088,9 @@ static struct clk_regmap axg_gen_clk = {
 	.hw.init = &(struct clk_init_data){
 		.name = "gen_clk",
 		.ops = &clk_regmap_gate_ops,
-		.parent_names = (const char *[]){ "gen_clk_div" },
+		.parent_hws = (const struct clk_hw *[]) {
+			&axg_gen_clk_div.hw
+		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
 	},
-- 
2.17.1

