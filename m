Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719E2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D60A217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oX2nR8K0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfCSVwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:52:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37781 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfCSVwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:52:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so9521018wmf.2;
        Tue, 19 Mar 2019 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZojoNzAlcbGl8fHjoNsnhIbGqEAojM71YZRXsvbN/s=;
        b=oX2nR8K02oy813R++d7xdIIKjkjXX4fX7XwtTSmh6E46KH/NeeTB+d0W5lf8UQIaGt
         6xPkd9hk9VNbAR7i5AIcps1PyzOWRy5G2wMUELls+KnrRckZVWnXvUG6nF97zWlfD7z3
         WjU0lkMAsA3ojHVIOAabfZtqbiBlsSUCCvBCCm9kU0MyRB1isuMbvNT1k01gbPadDYRs
         2hMYCaItzE8F3EGBdBGgVuzhHxumYVrCxFCd76PjLehqNXcveoCvqdvpq1UyqWwoQTUa
         bbYkgBtCaGTDuOIJZ/5ijO7CJunWcOEfN2n/Wf+t1EueqG100/jom/xVSLqbB2cZpixP
         O5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZojoNzAlcbGl8fHjoNsnhIbGqEAojM71YZRXsvbN/s=;
        b=OQfjIp2qj84Zi7gbKGslMc5FCAO5C8ZTChcV/de96ST7U/b4ShJ76e3QKsXllkGzz7
         7NJiSUuAzZJ1RaI1OH45bQxUGTC6BIdFRrrLlyXGTd4QkhT5suN2pqkf2v7L2lc0uKjK
         4YYyF+w78y6qRetJtcJXYDxo/o6C1BZmZ+2xQapSCrtSPHkIIKaOfEIEXmxsJRZ3mQUX
         bzIq9/3ifMh81HO8nKMAfaXY6c83saiJUSen5c5vd1KJm9edq8BieEvNAuS8i7/nY3PH
         0XCY7AQo/xyJiflpgMForh5WIqCzkkFbBg8l2l4WfnX5ghCaFTTQZN0V8APY+jlbQQN6
         G9vQ==
X-Gm-Message-State: APjAAAXxXAdvzismxKcl9zsw8cJCstvRqnjQY779U5IItpnyL0Zp4a4q
        V8h/oT7mrs/idX+o18iML/63emvR
X-Google-Smtp-Source: APXvYqyJnrozWxcQ4hOs3D+ZQ5sbgpg+Fs5ZxNC63GBqouuwdxKZNOKkKZoFqZkQuuySDEpG0tmjUw==
X-Received: by 2002:a1c:99d2:: with SMTP id b201mr5285665wme.90.1553032324145;
        Tue, 19 Mar 2019 14:52:04 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD739990039EE738515149D3E.dip0.t-ipconnect.de. [2003:dc:d739:9900:39ee:7385:1514:9d3e])
        by smtp.googlemail.com with ESMTPSA id c8sm56050wrx.6.2019.03.19.14.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 14:52:03 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/4] clk: meson: meson8b: add support for the GP_PLL clock on Meson8m2
Date:   Tue, 19 Mar 2019 22:51:20 +0100
Message-Id: <20190319215121.29340-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319215121.29340-1-martin.blumenstingl@googlemail.com>
References: <20190319215121.29340-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Meson8m2 has a GP_PLL clock (similar to GP0_PLL on GXBB/GXL/GXM) which
is used as input for the VPU clocks.
The only supported frequency (based on Amlogic's vendor kernel sources)
is 364MHz which is achieved using the following parameters:
- input: XTAL (24MHz)
- M = 182
- N = 3
- OD = 2 ^ 2

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 62 +++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/meson8b.h |  5 ++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index c9e6ec67d649..0d08f1ef7af8 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1703,6 +1703,64 @@ static struct clk_regmap meson8b_mali = {
 	},
 };
 
+static const struct pll_params_table meson8m2_gp_pll_params_table[] = {
+	PLL_PARAMS(182, 3),
+	{ /* sentinel */ },
+};
+
+static struct clk_regmap meson8m2_gp_pll_dco = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = HHI_GP_PLL_CNTL,
+			.shift   = 30,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = HHI_GP_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_GP_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.l = {
+			.reg_off = HHI_GP_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_GP_PLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.table = meson8m2_gp_pll_params_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "gp_pll_dco",
+		.ops = &meson_clk_pll_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap meson8m2_gp_pll = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_GP_PLL_CNTL,
+		.shift = 16,
+		.width = 2,
+		.flags = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "gp_pll",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "gp_pll_dco" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
@@ -2338,6 +2396,8 @@ static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
 		[CLKID_MALI_1_DIV]	    = &meson8b_mali_1_div.hw,
 		[CLKID_MALI_1]		    = &meson8b_mali_1.hw,
 		[CLKID_MALI]		    = &meson8b_mali.hw,
+		[CLKID_GP_PLL_DCO]	    = &meson8m2_gp_pll_dco.hw,
+		[CLKID_GP_PLL]		    = &meson8m2_gp_pll.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2500,6 +2560,8 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_mali_1_div,
 	&meson8b_mali_1,
 	&meson8b_mali,
+	&meson8m2_gp_pll_dco,
+	&meson8m2_gp_pll,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index b8c58faeae52..a45f7102c558 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -19,6 +19,7 @@
  *
  * [0] http://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
  */
+#define HHI_GP_PLL_CNTL			0x40  /* 0x10 offset in data sheet */
 #define HHI_VIID_CLK_DIV		0x128 /* 0x4a offset in data sheet */
 #define HHI_VIID_CLK_CNTL		0x12c /* 0x4b offset in data sheet */
 #define HHI_GCLK_MPEG0			0x140 /* 0x50 offset in data sheet */
@@ -146,8 +147,10 @@
 #define CLKID_MALI_1_SEL	178
 #define CLKID_MALI_1_DIV	179
 #define CLKID_MALI_1		180
+#define CLKID_GP_PLL_DCO	181
+#define CLKID_GP_PLL		182
 
-#define CLK_NR_CLKS		181
+#define CLK_NR_CLKS		183
 
 /*
  * include the CLKID and RESETID that have
-- 
2.21.0

