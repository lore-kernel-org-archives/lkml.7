Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F0DC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BB5222EC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eEFLWcKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfCXPLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:11:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51508 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfCXPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:11:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so6411540wmf.1;
        Sun, 24 Mar 2019 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vomKsk1OS7A0VQq9nJvd2dYJLMcTA82WAv8bCNnSFlg=;
        b=eEFLWcKsl05N7+VlQdko/vBjiBdVrHGf9kwzEd21YWRZ0ixHdkIBLqmwkLZlxt4bf6
         s7eFkgJo1niS3EQalRIn+K8lwtfIxjUvun2sPtKvacWq5Zu4iL7YBk6kzLg2pCU0NxkQ
         qu9w9i3EX+y2+bsXgFFhrJNHzA0QrMTWdZNj9WWfn7EV76sCREmWHytVl+W35VNCJJFQ
         e/QnY2mJL4K6wwsyMwhJlqT6wk6C3Hi5rNp+Smjzo3istVX39u+jzYVpf7GbOY5eFXWC
         BGjL803y+aZrmfhYb11OoUrs/2m1OrPuhhr0hFFPBDExdSBXd12zl0DafTJM4TnNl49n
         TyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vomKsk1OS7A0VQq9nJvd2dYJLMcTA82WAv8bCNnSFlg=;
        b=s4ZbYcJn2B+Sf+mMJ0LeDqMdMp1MQFvRospqQM0MYpUnmQ+VI+Dv4ucEIpq7B+SsVe
         CIQSYMKhatAdM1AwmVvl5y/5H4lXLSqY9MTUuXS3QCfnXWqNep9V9MXo39/DptZaXadb
         r/I2c1ONxSRuY6ywume7d3sv0NEwrtrcOLJWye4VHdLvXOv+3MAmWaRzJEtU5u6g6CQa
         pyRvS52lI2nsoIUcGaS4xMWRpkaqJVqUluExyjjETzrp4xlGr9rGsybUCn3dBhw/LB47
         udIiNBGGVCHVt9tDYuH/TVR5QcRpJvi+UajBzwRaJK0fb0n3jXCVY+L1A5lVxIXzhpw/
         5PIA==
X-Gm-Message-State: APjAAAVpUq3eLPBxBCPrYr1IHEJie8o4vFXRswh4C10ygKjxsleQu9YJ
        kLgfThqDaf5ZivsLvMa+cAXSVNso
X-Google-Smtp-Source: APXvYqwqr3meWONkkJowfTWsjPUlWlfAFL6LVyBXzt8Ou5EdMVhmx/Y+ScQHXRDhNMquzeFX3x4w+Q==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr9360682wmh.9.1553440296742;
        Sun, 24 Mar 2019 08:11:36 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d739:9900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 66sm13697730wmd.3.2019.03.24.08.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 08:11:36 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/4] clk: meson: meson8b: add support for the GP_PLL clock on Meson8m2
Date:   Sun, 24 Mar 2019 16:11:03 +0100
Message-Id: <20190324151104.18397-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190324151104.18397-1-martin.blumenstingl@googlemail.com>
References: <20190324151104.18397-1-martin.blumenstingl@googlemail.com>
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
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

