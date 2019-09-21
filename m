Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20331C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A7C217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tSf36BVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438165AbfIUPNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:13:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33145 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438061AbfIUPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:12:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so9642010wrs.0;
        Sat, 21 Sep 2019 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ELKKDirjp0oZPBJ44VpnYEwyvsV3MSi9kYfRjT4vis=;
        b=tSf36BVWvtXx+VPiJbvevWv9xlJ1MUcJK4nZLS1qWGYNLxNoHdV/7xgWGIod4J18ne
         9bpfamIpQ6rlDAewCfWEch+b3DIMg12XG5ZiLs5/C2Cx4Z4YXWyux/iDi3msAT3US/ry
         Pko0MtDG5LmeNd2zARa2loDVGhCAdgexNmZIFqU/PEPNVQoAX3MRPpvpkC28NZvuzL4c
         kXztKPpRiaAru9syL6RcQ0CwNAiCFbJsDJw0PD9/k3hWR9kV34MPf2RssSYirgiJeucn
         TGFOqWe5OeaVg9FWH83tY5HoV0MCZYvjWWXH6jLnsZbeeTEcrI6HCBFonKgTt96aczaY
         T4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ELKKDirjp0oZPBJ44VpnYEwyvsV3MSi9kYfRjT4vis=;
        b=kQ7tOER15cvrpQpUHTS5XbBnOFzjp91uGjPE1qkmJR28fue4avOngDHXisov5fCWD4
         d7Sx/XCXmfafvARu13bR1bYZIiYiazh947pvkV08RCUMlzKCk3Mw90ej1GGiXT+oTyka
         m1UvlN+oWyBEDrA16Gub2b8hVi+sBhElS2vw/wa7SPeS1J8aD9N+RyuaRObYoLlC0UMh
         ZCMS2xoxZkjibwxIFABqf+NZ0Gbm8akzS1qWoUAHi8oDsqSzA7GkF34C0hubYWGyiW4S
         5YQfBcazXzNv/xV8v0LqKcgZgKH7S75jXN5lH1GPbYjhXFwuRVQc1HZqRyPUPg8ZTto7
         YQMQ==
X-Gm-Message-State: APjAAAUGPtAtAge7kQIqqbkyonHb99GXMDGYScAz3mpGCFQoBS8vlnqi
        yacBIszEqxbz5Fhk2eOliqo=
X-Google-Smtp-Source: APXvYqwx45owz2FGuyA/qiPoL6+BJkR2g+Q1oinww/HO5IBtLhd+znAWfPtMJt/w4Y6dclBVZlf0Og==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr15302198wrv.338.1569078767754;
        Sat, 21 Sep 2019 08:12:47 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id y186sm10712491wmb.41.2019.09.21.08.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:12:46 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/5] clk: meson: meson8b: change references to the XTAL clock to use the name
Date:   Sat, 21 Sep 2019 17:12:21 +0200
Message-Id: <20190921151223.768842-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
References: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XTAL clock is an actual crystal which is mounted on the PCB. Thus
the meson8b clock controller driver should not provide the XTAL clock.

The meson8b clock controller driver must not use references to
the meson8b_xtal clock anymore before we can provide the XTAL clock
via OF. Replace the references to the meson8b_xtal.hw by using
clk_parent_data.name = "xtal" (along with index = -1) because this works
regardless how the XTAL clock is registered (either as fixed-clock in
the .dtb or - if missing - when registered in the meson8b clock
controller driver).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 73 ++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index d376f80e806d..b785b67baf2b 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -97,8 +97,9 @@ static struct clk_regmap meson8b_fixed_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "xtal",
+			.index = -1,
 		},
 		.num_parents = 1,
 	},
@@ -162,8 +163,9 @@ static struct clk_regmap meson8b_hdmi_pll_dco = {
 		/* sometimes also called "HPLL" or "HPLL PLL" */
 		.name = "hdmi_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "xtal",
+			.index = -1,
 		},
 		.num_parents = 1,
 	},
@@ -237,8 +239,9 @@ static struct clk_regmap meson8b_sys_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "xtal",
+			.index = -1,
 		},
 		.num_parents = 1,
 	},
@@ -631,9 +634,9 @@ static struct clk_regmap meson8b_cpu_in_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_in_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw,
-			&meson8b_sys_pll.hw,
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .name = "xtal", .index = -1, },
+			{ .hw = &meson8b_sys_pll.hw, },
 		},
 		.num_parents = 2,
 		.flags = (CLK_SET_RATE_PARENT |
@@ -736,9 +739,9 @@ static struct clk_regmap meson8b_cpu_clk = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk",
 		.ops = &clk_regmap_mux_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw,
-			&meson8b_cpu_scale_out_sel.hw,
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .name = "xtal", .index = -1, },
+			{ .hw = &meson8b_cpu_scale_out_sel.hw, },
 		},
 		.num_parents = 2,
 		.flags = (CLK_SET_RATE_PARENT |
@@ -758,12 +761,12 @@ static struct clk_regmap meson8b_nand_clk_sel = {
 		.name = "nand_clk_sel",
 		.ops = &clk_regmap_mux_ops,
 		/* FIXME all other parents are unknown: */
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_fclk_div4.hw,
-			&meson8b_fclk_div3.hw,
-			&meson8b_fclk_div5.hw,
-			&meson8b_fclk_div7.hw,
-			&meson8b_xtal.hw,
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .hw = &meson8b_fclk_div4.hw, },
+			{ .hw = &meson8b_fclk_div3.hw, },
+			{ .hw = &meson8b_fclk_div5.hw, },
+			{ .hw = &meson8b_fclk_div7.hw, },
+			{ .name = "xtal", .index = -1, },
 		},
 		.num_parents = 5,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1721,8 +1724,9 @@ static struct clk_regmap meson8b_hdmi_sys_sel = {
 		.name = "hdmi_sys_sel",
 		.ops = &clk_regmap_mux_ro_ops,
 		/* FIXME: all other parents are unknown */
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "xtal",
+			.index = -1,
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_NO_REPARENT,
@@ -1767,14 +1771,14 @@ static struct clk_regmap meson8b_hdmi_sys = {
  * muxed by a glitch-free switch on Meson8b and Meson8m2. Meson8 only
  * has mali_0 and no glitch-free mux.
  */
-static const struct clk_hw *meson8b_mali_0_1_parent_hws[] = {
-	&meson8b_xtal.hw,
-	&meson8b_mpll2.hw,
-	&meson8b_mpll1.hw,
-	&meson8b_fclk_div7.hw,
-	&meson8b_fclk_div4.hw,
-	&meson8b_fclk_div3.hw,
-	&meson8b_fclk_div5.hw,
+static const struct clk_parent_data meson8b_mali_0_1_parent_data[] = {
+	{ .name = "xtal", .index = -1, },
+	{ .hw = &meson8b_mpll2.hw, },
+	{ .hw = &meson8b_mpll1.hw, },
+	{ .hw = &meson8b_fclk_div7.hw, },
+	{ .hw = &meson8b_fclk_div4.hw, },
+	{ .hw = &meson8b_fclk_div3.hw, },
+	{ .hw = &meson8b_fclk_div5.hw, },
 };
 
 static u32 meson8b_mali_0_1_mux_table[] = { 0, 2, 3, 4, 5, 6, 7 };
@@ -1789,8 +1793,8 @@ static struct clk_regmap meson8b_mali_0_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_0_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_hws = meson8b_mali_0_1_parent_hws,
-		.num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_hws),
+		.parent_data = meson8b_mali_0_1_parent_data,
+		.num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_data),
 		/*
 		 * Don't propagate rate changes up because the only changeable
 		 * parents are mpll1 and mpll2 but we need those for audio and
@@ -1844,8 +1848,8 @@ static struct clk_regmap meson8b_mali_1_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_1_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_hws = meson8b_mali_0_1_parent_hws,
-		.num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_hws),
+		.parent_data = meson8b_mali_0_1_parent_data,
+		.num_parents = ARRAY_SIZE(meson8b_mali_0_1_parent_data),
 		/*
 		 * Don't propagate rate changes up because the only changeable
 		 * parents are mpll1 and mpll2 but we need those for audio and
@@ -1944,8 +1948,9 @@ static struct clk_regmap meson8m2_gp_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "gp_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw
+		.parent_data = &(const struct clk_parent_data) {
+			.name = "xtal",
+			.index = -1,
 		},
 		.num_parents = 1,
 	},
-- 
2.23.0

