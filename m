Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACA8C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118B8222F3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qByAuhNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfCXPLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:11:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42800 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbfCXPLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:11:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so3805673wrx.9;
        Sun, 24 Mar 2019 08:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ar7cAn9hDC1xPWL9Z9bVqbAxA+mex7LR7lQweAYINmc=;
        b=qByAuhNcCKwBnf0KHqHKjnkhOwfRZpqkdNhN8RD5XCAZxxl6fggzr1uMe0sL0iCb8s
         sKvbKDsuP453SnssfliWDeYlKx7chUMMmDttDyufoMTeP/mCpEvb1Tqrd+mXSUt2xgTQ
         yWYFYdkHoSgaI3u1sjgrD6P1ts+VMEz4hd9qidg4LUnoC22LtHRfZVJrX7k1Rb/sP4+j
         vRpqpiad6RRCHgJTb8nbGSaom07HnZ0GeD1V8/6yBWE11O4c6fielot6UjRUpzbUDpq7
         rA27kM0AdjLZyHJOTYI6xl98vqSXVTXGktsv74M24sKeDv6tjDaNnxaFqXzDfMLyOwFT
         p6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ar7cAn9hDC1xPWL9Z9bVqbAxA+mex7LR7lQweAYINmc=;
        b=oXDwiflDzKDOfKHy7iHWdqk1i9jWjS5XfjBoDciWx33P284om9k9Rm3g2vV8J2+S2v
         F2kpxzcdvi7zHBkKOl67M2JUMlLab1y2Cea7uZMykdAZuzHIszpe+hsyJL1reEAJUD9k
         wfxVcYxxV05iGcRsaIjF5zDuaR8ZecFNNhE6ww5feN/IBocEocYyP7DyJ9VU2psZWHqs
         CtxTzSMLsPCrR+A2SxppNHw588rCBMts1QW8YIlBXoos3MEQXIY+vxlVpGa2I2/qpn1E
         BFjgDNHrpu6NbzVDp6hgj8v34pZudgy/Vd/XFYecuZUWMlgb/YomvEzhft7X/IeCHiJ3
         MdVA==
X-Gm-Message-State: APjAAAUTtV04fG25YIp7yFTR39rfzIhjsMLoTpaAnIzvX8PRGGFuhsmq
        4jWXHuC6CyQNwN6PHpZaqJ8p4QO7
X-Google-Smtp-Source: APXvYqzpSMdit6fmDzuQiSXBCg4xahlFfjsRmU0RWbUW1JC+u3abtDThpkJdnwOmuYuVT7w93xdemw==
X-Received: by 2002:a5d:6292:: with SMTP id k18mr13196803wru.303.1553440297902;
        Sun, 24 Mar 2019 08:11:37 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d739:9900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 66sm13697730wmd.3.2019.03.24.08.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 08:11:37 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/4] clk: meson: meson8b: add the VPU clock trees
Date:   Sun, 24 Mar 2019 16:11:04 +0100
Message-Id: <20190324151104.18397-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190324151104.18397-1-martin.blumenstingl@googlemail.com>
References: <20190324151104.18397-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VPU clock tree is slightly different on all three supported SoCs:

Meson8 only has an input mux (which chooses between "fclk_div4",
"fclk_div3", "fclk_div5" and "fclk_div7"), a divider and a gate.

Meson8b has two VPU clock trees, each with an input mux (using the same
parents as the input mux on Meson8), divider and a gates. The final VPU
clock is a glitch-free mux which chooses between VPU_1 and VPU_2.

Meson8m2 uses a similar clock tree as Meson8b but the last input clock
is different: instead of using "fclk_div7" as input Meson8m2 uses
"gp_pll". This was probably done in hardware to improve the accuracy of
the clock because fclk_div7 gives us 2550MHz / 7 = 364.286MHz while
GP_PLL can achieve 364.0MHz.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 167 ++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/meson8b.h |   9 +-
 2 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 0d08f1ef7af8..8e091c2d10e6 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1761,6 +1761,147 @@ static struct clk_regmap meson8m2_gp_pll = {
 	},
 };
 
+static const char * const mmeson8b_vpu_0_1_parent_names[] = {
+	"fclk_div4", "fclk_div3", "fclk_div5", "fclk_div7"
+};
+
+static const char * const mmeson8m2_vpu_0_1_parent_names[] = {
+	"fclk_div4", "fclk_div3", "fclk_div5", "gp_pll"
+};
+
+static struct clk_regmap meson8b_vpu_0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_0_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = mmeson8b_vpu_0_1_parent_names,
+		.num_parents = ARRAY_SIZE(mmeson8b_vpu_0_1_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8m2_vpu_0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_0_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = mmeson8m2_vpu_0_1_parent_names,
+		.num_parents = ARRAY_SIZE(mmeson8m2_vpu_0_1_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vpu_0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vpu_0_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vpu_0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vpu_0_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vpu_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_1_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = mmeson8b_vpu_0_1_parent_names,
+		.num_parents = ARRAY_SIZE(mmeson8b_vpu_0_1_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8m2_vpu_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_1_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = mmeson8m2_vpu_0_1_parent_names,
+		.num_parents = ARRAY_SIZE(mmeson8m2_vpu_0_1_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vpu_1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_1_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vpu_1_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vpu_1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vpu_1_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vpu = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.mask = 1,
+		.shift = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "vpu_0", "vpu_1" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
@@ -2024,6 +2165,9 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
 		[CLKID_MALI_0_SEL]	    = &meson8b_mali_0_sel.hw,
 		[CLKID_MALI_0_DIV]	    = &meson8b_mali_0_div.hw,
 		[CLKID_MALI]		    = &meson8b_mali_0.hw,
+		[CLKID_VPU_0_SEL]	    = &meson8b_vpu_0_sel.hw,
+		[CLKID_VPU_0_DIV]	    = &meson8b_vpu_0_div.hw,
+		[CLKID_VPU]		    = &meson8b_vpu_0.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2210,6 +2354,13 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_MALI_1_DIV]	    = &meson8b_mali_1_div.hw,
 		[CLKID_MALI_1]		    = &meson8b_mali_1.hw,
 		[CLKID_MALI]		    = &meson8b_mali.hw,
+		[CLKID_VPU_0_SEL]	    = &meson8b_vpu_0_sel.hw,
+		[CLKID_VPU_0_DIV]	    = &meson8b_vpu_0_div.hw,
+		[CLKID_VPU_0]		    = &meson8b_vpu_0.hw,
+		[CLKID_VPU_1_SEL]	    = &meson8b_vpu_1_sel.hw,
+		[CLKID_VPU_1_DIV]	    = &meson8b_vpu_1_div.hw,
+		[CLKID_VPU_1]		    = &meson8b_vpu_1.hw,
+		[CLKID_VPU]		    = &meson8b_vpu.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2398,6 +2549,13 @@ static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
 		[CLKID_MALI]		    = &meson8b_mali.hw,
 		[CLKID_GP_PLL_DCO]	    = &meson8m2_gp_pll_dco.hw,
 		[CLKID_GP_PLL]		    = &meson8m2_gp_pll.hw,
+		[CLKID_VPU_0_SEL]	    = &meson8m2_vpu_0_sel.hw,
+		[CLKID_VPU_0_DIV]	    = &meson8b_vpu_0_div.hw,
+		[CLKID_VPU_0]		    = &meson8b_vpu_0.hw,
+		[CLKID_VPU_1_SEL]	    = &meson8m2_vpu_1_sel.hw,
+		[CLKID_VPU_1_DIV]	    = &meson8b_vpu_1_div.hw,
+		[CLKID_VPU_1]		    = &meson8b_vpu_1.hw,
+		[CLKID_VPU]		    = &meson8b_vpu.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2562,6 +2720,15 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_mali,
 	&meson8m2_gp_pll_dco,
 	&meson8m2_gp_pll,
+	&meson8b_vpu_0_sel,
+	&meson8m2_vpu_0_sel,
+	&meson8b_vpu_0_div,
+	&meson8b_vpu_0,
+	&meson8b_vpu_1_sel,
+	&meson8m2_vpu_1_sel,
+	&meson8b_vpu_1_div,
+	&meson8b_vpu_1,
+	&meson8b_vpu,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index a45f7102c558..e775f91ccce9 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -35,6 +35,7 @@
 #define HHI_VID_DIVIDER_CNTL		0x198 /* 0x66 offset in data sheet */
 #define HHI_SYS_CPU_CLK_CNTL0		0x19c /* 0x67 offset in data sheet */
 #define HHI_MALI_CLK_CNTL		0x1b0 /* 0x6c offset in data sheet */
+#define HHI_VPU_CLK_CNTL		0x1bc /* 0x6f offset in data sheet */
 #define HHI_HDMI_CLK_CNTL		0x1cc /* 0x73 offset in data sheet */
 #define HHI_NAND_CLK_CNTL		0x25c /* 0x97 offset in data sheet */
 #define HHI_MPLL_CNTL			0x280 /* 0xa0 offset in data sheet */
@@ -149,8 +150,14 @@
 #define CLKID_MALI_1		180
 #define CLKID_GP_PLL_DCO	181
 #define CLKID_GP_PLL		182
+#define CLKID_VPU_0_SEL		183
+#define CLKID_VPU_0_DIV		184
+#define CLKID_VPU_0		185
+#define CLKID_VPU_1_SEL		186
+#define CLKID_VPU_1_DIV		187
+#define CLKID_VPU_1		189
 
-#define CLK_NR_CLKS		183
+#define CLK_NR_CLKS		191
 
 /*
  * include the CLKID and RESETID that have
-- 
2.21.0

