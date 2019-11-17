Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C20C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733882084D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="uX3kkks5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfKQOAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 09:00:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35272 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfKQOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 09:00:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id 8so15870245wmo.0;
        Sun, 17 Nov 2019 05:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VK1JO8dp501rCEWUDhaKb+5p4cyh/6ctrMeXSGi6/vI=;
        b=uX3kkks5u09MSU6+9FB6NjV7WG1co9tZzINsNjFFrAuUPaeY/LpqjaxYBKw1rgs2ci
         AtRVoMgC/7mQXqQaxeNAjmEBgaq8AlfvbgG6GN17hSWOKG8XpuN9qVxgbaGXLMMjmWG9
         T9UlDdy5XnqdavAM+l6CY+nHHTMpTnCfwXb9P0s0kSycGW3T8J9W3ppong8i+YvXPvio
         9pu2FQpHTpOYG3YHJWhg37Pe5S9Ty03Z6WAz0fqMWszAFPYokzm1iqPTUWD9Jy1hBZx/
         F++OWtatB0jXOEZMXmS3MlK2rkhcjPH4o/LTvaHQko2TRMyVwf8QZcOgydXrTP90crJK
         X2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VK1JO8dp501rCEWUDhaKb+5p4cyh/6ctrMeXSGi6/vI=;
        b=VTqt8O9qFzx+EH+0E5EMJL/SE98F0+HtB8rgByIvDFkOEFHni5MSN0Q4Ee08/8WIBo
         LnTOX5T4jNltgYwyH88bo0SggpATU8mqxfy7MdN0oRKCfXJmJdVjSHp62BTpbWXKIFRP
         YiEEYqceY7HtxIoUHeqIs7ZhG1Q4jCX7wQOQmc2+uLcbQdDkQAI3mUn/bkfyP1P9eVSU
         AAE5VsuIjX3/Yj/MUfj7ifAOaMdFRiuCjiDBSGmAt1iZf9HWbwpmyoOVxNOTsd0E/vZH
         KJBRgOQeyy399P78v2L3DQuDRfsUL3fGZV+LjNV4GrLAke/P2w1ddQzxGpvr3gMUq+rk
         SjnQ==
X-Gm-Message-State: APjAAAW+n4ailROEncf2lgCHvw0UZsCbfGyMHJG9OIj2Am0NrvyES+QW
        QgnSx/M+djhRI2U05xhAd4s=
X-Google-Smtp-Source: APXvYqz2ho4QekV3NNoeQpC90s5YyGanfRKJwSw4FD4KLJzoleyj2nZK5zI9GOyuKLXdGsv2ZtMcOg==
X-Received: by 2002:a05:600c:21d5:: with SMTP id x21mr19273737wmj.162.1573999198652;
        Sun, 17 Nov 2019 05:59:58 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n65sm18004803wmf.28.2019.11.17.05.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 05:59:58 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 3/5] clk: meson: meson8b: change references to the XTAL clock to use [fw_]name
Date:   Sun, 17 Nov 2019 14:59:25 +0100
Message-Id: <20191117135927.135428-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
References: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
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
clk_parent_data's .fw_name and .name = "xtal" (along with index = -1).
This makes the common clock framework use the clock provided via OF and
if that's not available it falls back to getting the clock by it's name
(which is then the clk_fixed_rate which we register in our driver).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 78 +++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index d376f80e806d..f857a2c4d025 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -97,8 +97,10 @@ static struct clk_regmap meson8b_fixed_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+			.name = "xtal",
+			.index = -1,
 		},
 		.num_parents = 1,
 	},
@@ -162,8 +164,10 @@ static struct clk_regmap meson8b_hdmi_pll_dco = {
 		/* sometimes also called "HPLL" or "HPLL PLL" */
 		.name = "hdmi_pll_dco",
 		.ops = &meson_clk_pll_ro_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+			.name = "xtal",
+			.index = -1,
 		},
 		.num_parents = 1,
 	},
@@ -237,8 +241,10 @@ static struct clk_regmap meson8b_sys_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+			.name = "xtal",
+			.index = -1,
 		},
 		.num_parents = 1,
 	},
@@ -631,9 +637,9 @@ static struct clk_regmap meson8b_cpu_in_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_in_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw,
-			&meson8b_sys_pll.hw,
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .fw_name = "xtal", .name = "xtal", .index = -1, },
+			{ .hw = &meson8b_sys_pll.hw, },
 		},
 		.num_parents = 2,
 		.flags = (CLK_SET_RATE_PARENT |
@@ -736,9 +742,9 @@ static struct clk_regmap meson8b_cpu_clk = {
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_clk",
 		.ops = &clk_regmap_mux_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw,
-			&meson8b_cpu_scale_out_sel.hw,
+		.parent_data = (const struct clk_parent_data[]) {
+			{ .fw_name = "xtal", .name = "xtal", .index = -1, },
+			{ .hw = &meson8b_cpu_scale_out_sel.hw, },
 		},
 		.num_parents = 2,
 		.flags = (CLK_SET_RATE_PARENT |
@@ -758,12 +764,12 @@ static struct clk_regmap meson8b_nand_clk_sel = {
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
+			{ .fw_name = "xtal", .name = "xtal", .index = -1, },
 		},
 		.num_parents = 5,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1721,8 +1727,10 @@ static struct clk_regmap meson8b_hdmi_sys_sel = {
 		.name = "hdmi_sys_sel",
 		.ops = &clk_regmap_mux_ro_ops,
 		/* FIXME: all other parents are unknown */
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+			.name = "xtal",
+			.index = -1,
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_NO_REPARENT,
@@ -1767,14 +1775,14 @@ static struct clk_regmap meson8b_hdmi_sys = {
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
+	{ .fw_name = "xtal", .name = "xtal", .index = -1, },
+	{ .hw = &meson8b_mpll2.hw, },
+	{ .hw = &meson8b_mpll1.hw, },
+	{ .hw = &meson8b_fclk_div7.hw, },
+	{ .hw = &meson8b_fclk_div4.hw, },
+	{ .hw = &meson8b_fclk_div3.hw, },
+	{ .hw = &meson8b_fclk_div5.hw, },
 };
 
 static u32 meson8b_mali_0_1_mux_table[] = { 0, 2, 3, 4, 5, 6, 7 };
@@ -1789,8 +1797,8 @@ static struct clk_regmap meson8b_mali_0_sel = {
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
@@ -1844,8 +1852,8 @@ static struct clk_regmap meson8b_mali_1_sel = {
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
@@ -1944,8 +1952,10 @@ static struct clk_regmap meson8m2_gp_pll_dco = {
 	.hw.init = &(struct clk_init_data){
 		.name = "gp_pll_dco",
 		.ops = &meson_clk_pll_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&meson8b_xtal.hw
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+			.name = "xtal",
+			.index = -1,
 		},
 		.num_parents = 1,
 	},
-- 
2.24.0

