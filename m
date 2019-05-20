Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0347C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B134120863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="buBCL3E2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfETUDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:03:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52948 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfETUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:03:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so595650wmm.2;
        Mon, 20 May 2019 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLXKcquZu+aVrTNlY+uDoKerdJmaoxc+CHk+wGkwZvA=;
        b=buBCL3E26Hq+Re61P//BTXlsKczFg+dMIiqF4D9VQMazw31IdlPU393GS8io7OyUv5
         dQWx9I0vPHKFErYlvl/9Xhlp6BQvmvms0tLx5j/SeyJo0f1eLaL6RNARf36bEqofZwPO
         soIQAwzI1xfnrqNZV5dlEo5Y/IFjHM3DGGCLMuYi5MIZv+IpLkACDXw/7Ezhilsz39eT
         Mb/H93eXkvZmczg9Ezteuv3FOLj2KG/kBSSVjDM7oi1jbJ06HhaBIjcAhCLnnU3pEMJk
         5ckK/MWlW41msUrr5PtvxJlSDhLCI/orOuUQjb5/Zr/pSwgyhKgGzJ9A2dvsnnIzYcdk
         Zz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLXKcquZu+aVrTNlY+uDoKerdJmaoxc+CHk+wGkwZvA=;
        b=Xw4BZTbmUEA0E4FrL4RYjYjrkbP6Z9k/5vc8DMap4PSYgIxnphsbkTP6JNtp+39wse
         oZaSMopJWnNf+qHmBu4MAKw/jKpL9ILrC+HEDe6g8i25gmG7aikHN2ElKZBaqwScZWGC
         WiZ4loUJJhouVjyFkxRY3dZWKN4UiPDveofIBDnZWl+hypjv1i3Od3lYuRi5zhaz7ECb
         cf5xpwggyx85QFXs0lTpIKtwvQik841aznWhLgunG+Kq5UBFhenQNtFAC96uGEc6JBwG
         QAz8sx2BbTKesvLE+S5nMUOWHjA53gw5CmkF8ajEaPW8ttNSgjLrEgwvFwiWKngFLGzi
         hytg==
X-Gm-Message-State: APjAAAXw3ejgCMDvyGXFIGaqVltYvHzrNwgUJ92+77d/BcxpIu9YLQ6y
        yb2dxIktD26yQHinseUQ2HM=
X-Google-Smtp-Source: APXvYqxoxXW3d+qwj9JuiVIShzKwfZs9av0Uz0mGHl4ZnmOu8ScvXBBl4tHDB57OwHUoQ4legiLwLg==
X-Received: by 2002:a1c:be0b:: with SMTP id o11mr622654wmf.63.1558382610669;
        Mon, 20 May 2019 13:03:30 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id t7sm23583379wrq.76.2019.05.20.13.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 13:03:30 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/4] clk: meson: meson8b: add the cts_amclk clocks
Date:   Mon, 20 May 2019 22:03:17 +0200
Message-Id: <20190520200319.9265-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520200319.9265-1-martin.blumenstingl@googlemail.com>
References: <20190520200319.9265-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the I2S master clock also referred as cts_amclk. The setup for this
clock is identical to GXBB, so this ports commit 4087bd4b21702d ("clk:
meson: gxbb: add cts_amclk") to the Meson8/Meson8b/Meson8m2 clock
driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 65 +++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/meson8b.h |  5 ++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 62cd3a7f1f65..e00f42e7fc46 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2153,6 +2153,59 @@ static struct clk_regmap meson8b_vdec_hevc = {
 	},
 };
 
+/* TODO: the clock at index 0 is "DDR_PLL" which we don't support yet */
+static const char * const meson8b_cts_amclk_parent_names[] = {
+	"mpll0", "mpll1", "mpll2"
+};
+
+static u32 meson8b_cts_amclk_mux_table[] = { 1, 2, 3 };
+
+static struct clk_regmap meson8b_cts_amclk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_AUD_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+		.table = meson8b_cts_amclk_mux_table,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_amclk_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = meson8b_cts_amclk_parent_names,
+		.num_parents = ARRAY_SIZE(meson8b_cts_amclk_parent_names),
+	},
+};
+
+static struct clk_regmap meson8b_cts_amclk_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = HHI_AUD_CLK_CNTL,
+		.shift = 0,
+		.width = 8,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_amclk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "cts_amclk_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_cts_amclk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_AUD_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_amclk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cts_amclk_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
@@ -2432,6 +2485,9 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
 		[CLKID_VDEC_HEVC_DIV]	    = &meson8b_vdec_hevc_div.hw,
 		[CLKID_VDEC_HEVC_EN]	    = &meson8b_vdec_hevc_en.hw,
 		[CLKID_VDEC_HEVC]	    = &meson8b_vdec_hevc.hw,
+		[CLKID_CTS_AMCLK_SEL]	    = &meson8b_cts_amclk_sel.hw,
+		[CLKID_CTS_AMCLK_DIV]	    = &meson8b_cts_amclk_div.hw,
+		[CLKID_CTS_AMCLK]	    = &meson8b_cts_amclk.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2641,6 +2697,9 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_VDEC_HEVC_DIV]	    = &meson8b_vdec_hevc_div.hw,
 		[CLKID_VDEC_HEVC_EN]	    = &meson8b_vdec_hevc_en.hw,
 		[CLKID_VDEC_HEVC]	    = &meson8b_vdec_hevc.hw,
+		[CLKID_CTS_AMCLK_SEL]	    = &meson8b_cts_amclk_sel.hw,
+		[CLKID_CTS_AMCLK_DIV]	    = &meson8b_cts_amclk_div.hw,
+		[CLKID_CTS_AMCLK]	    = &meson8b_cts_amclk.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2852,6 +2911,9 @@ static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
 		[CLKID_VDEC_HEVC_DIV]	    = &meson8b_vdec_hevc_div.hw,
 		[CLKID_VDEC_HEVC_EN]	    = &meson8b_vdec_hevc_en.hw,
 		[CLKID_VDEC_HEVC]	    = &meson8b_vdec_hevc.hw,
+		[CLKID_CTS_AMCLK_SEL]	    = &meson8b_cts_amclk_sel.hw,
+		[CLKID_CTS_AMCLK_DIV]	    = &meson8b_cts_amclk_div.hw,
+		[CLKID_CTS_AMCLK]	    = &meson8b_cts_amclk.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -3041,6 +3103,9 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_vdec_hevc_div,
 	&meson8b_vdec_hevc_en,
 	&meson8b_vdec_hevc,
+	&meson8b_cts_amclk,
+	&meson8b_cts_amclk_sel,
+	&meson8b_cts_amclk_div,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index ed37196187e6..03efa47e800f 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -30,6 +30,7 @@
 #define HHI_SYS_CPU_CLK_CNTL1		0x15c /* 0x57 offset in data sheet */
 #define HHI_VID_CLK_DIV			0x164 /* 0x59 offset in data sheet */
 #define HHI_MPEG_CLK_CNTL		0x174 /* 0x5d offset in data sheet */
+#define HHI_AUD_CLK_CNTL		0x178 /* 0x5e offset in data sheet */
 #define HHI_VID_CLK_CNTL		0x17c /* 0x5f offset in data sheet */
 #define HHI_VID_CLK_CNTL2		0x194 /* 0x65 offset in data sheet */
 #define HHI_VID_DIVIDER_CNTL		0x198 /* 0x66 offset in data sheet */
@@ -171,8 +172,10 @@
 #define CLKID_VDEC_HEVC_SEL	203
 #define CLKID_VDEC_HEVC_DIV	204
 #define CLKID_VDEC_HEVC_EN	205
+#define CLKID_CTS_AMCLK_SEL	207
+#define CLKID_CTS_AMCLK_DIV	208
 
-#define CLK_NR_CLKS		207
+#define CLK_NR_CLKS		210
 
 /*
  * include the CLKID and RESETID that have
-- 
2.21.0

