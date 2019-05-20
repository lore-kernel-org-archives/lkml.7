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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92488C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617922173B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KJFzMSWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfETUDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:03:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38425 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfETUDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:03:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so15983468wrs.5;
        Mon, 20 May 2019 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QQEWFaKOfrbORxHzOKdVjgIQUsHfT25oNZs4Yqx/FkM=;
        b=KJFzMSWh2cIQNFSJdUCU0nuU+/GUgdCA6sEdeqwMvanTcXc/REVb/x6G5Xr4pdMvkx
         7eGo5ipth/sUOzLEjza7zN9g7BAPGqnoyMUDe3MGRqDM/yhgM5Wn/pZYWwi82ncTWe2v
         1z5ccZQfrGfCHBS0nMcQCfpugx4FwLTs55ja3DjQaN3QHB0Y8q+rIdD9cyVhGoNfCv94
         G73nqG8x3FqKmKtvokPJmDtsbdYa24Fq9qC2b+JPnkLdCxVuHEd9gHgzr7LLeHSwTWuI
         LHamhvFmxCMsQ/MdOHV6vtTeVb/vESyaKmV/7npOSNYf7hyr1PicWNGuzd2/2FJah4/9
         bGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QQEWFaKOfrbORxHzOKdVjgIQUsHfT25oNZs4Yqx/FkM=;
        b=q3yVuLpF2ZwX6HulWeMAwGdg4+dMGeOIq6ideUuSCH6xrxv2X5MYpKlQK3VbDSElog
         vNTJdIYxNoauyynxxcdJcto2sGEyULcXK+8KxPhg6B6RbsppcTAnYa7cHxRA1YLZVE+8
         2LAjEhjuUaGGdNhS1yRZyYYmu556V3O2HRZcT6UqmBF4nAwfIHA0Qfs+t0KIbTi5LiXn
         tOzPROdeujc+AXLEorAePts6UelNDp0vXjcz9EGLcNq5YDrzwVL2+0KkxDwtvaVvUWYf
         y8i9vF71myxyBmejIDLNwzvdHsM7Z5uxyAmNVfIMv9fPRhbTlG/r19v3cWUY7y8KoRlE
         1fyg==
X-Gm-Message-State: APjAAAUK7Wu9qSfNyJ6P5XgVrZhhoue1gAAyGJCJQYz86mF9FLIaHuKv
        8OE2xE6x2NC/ErBiZgQzz5o=
X-Google-Smtp-Source: APXvYqyvZjwm7oAgYaaB/R0+9iOVDbGrMUs0Madc7vxHYanOE9pqG4mpy2xeBDW9DZL7JLwGOLn4sQ==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr9569827wru.35.1558382611949;
        Mon, 20 May 2019 13:03:31 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id t7sm23583379wrq.76.2019.05.20.13.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 13:03:31 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/4] clk: meson: meson8b: add the cts_mclk_i958 clocks
Date:   Mon, 20 May 2019 22:03:18 +0200
Message-Id: <20190520200319.9265-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520200319.9265-1-martin.blumenstingl@googlemail.com>
References: <20190520200319.9265-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPDIF master clock also referred as cts_mclk_i958. The setup for
this clock is identical to GXBB, so this ports commit 3c277c247eabeb
("clk: meson: gxbb: add cts_mclk_i958") to the Meson8/Meson8b/Meson8m2
clock driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 65 +++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/meson8b.h |  5 ++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index e00f42e7fc46..13ce1783eead 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2206,6 +2206,59 @@ static struct clk_regmap meson8b_cts_amclk = {
 	},
 };
 
+/* TODO: the clock at index 0 is "DDR_PLL" which we don't support yet */
+static const char * const meson8b_cts_mclk_i958_parent_names[] = {
+	"mpll0", "mpll1", "mpll2"
+};
+
+static u32 meson8b_cts_mclk_i958_mux_table[] = { 1, 2, 3 };
+
+static struct clk_regmap meson8b_cts_mclk_i958_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_AUD_CLK_CNTL2,
+		.mask = 0x3,
+		.shift = 25,
+		.table = meson8b_cts_mclk_i958_mux_table,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cts_mclk_i958_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = meson8b_cts_mclk_i958_parent_names,
+		.num_parents = ARRAY_SIZE(meson8b_cts_mclk_i958_parent_names),
+	},
+};
+
+static struct clk_regmap meson8b_cts_mclk_i958_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_AUD_CLK_CNTL2,
+		.shift = 16,
+		.width = 8,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cts_mclk_i958_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "cts_mclk_i958_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_cts_mclk_i958 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_AUD_CLK_CNTL2,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_mclk_i958",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "cts_mclk_i958_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
@@ -2488,6 +2541,9 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
 		[CLKID_CTS_AMCLK_SEL]	    = &meson8b_cts_amclk_sel.hw,
 		[CLKID_CTS_AMCLK_DIV]	    = &meson8b_cts_amclk_div.hw,
 		[CLKID_CTS_AMCLK]	    = &meson8b_cts_amclk.hw,
+		[CLKID_CTS_MCLK_I958_SEL]   = &meson8b_cts_mclk_i958_sel.hw,
+		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
+		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2700,6 +2756,9 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_CTS_AMCLK_SEL]	    = &meson8b_cts_amclk_sel.hw,
 		[CLKID_CTS_AMCLK_DIV]	    = &meson8b_cts_amclk_div.hw,
 		[CLKID_CTS_AMCLK]	    = &meson8b_cts_amclk.hw,
+		[CLKID_CTS_MCLK_I958_SEL]   = &meson8b_cts_mclk_i958_sel.hw,
+		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
+		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2914,6 +2973,9 @@ static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
 		[CLKID_CTS_AMCLK_SEL]	    = &meson8b_cts_amclk_sel.hw,
 		[CLKID_CTS_AMCLK_DIV]	    = &meson8b_cts_amclk_div.hw,
 		[CLKID_CTS_AMCLK]	    = &meson8b_cts_amclk.hw,
+		[CLKID_CTS_MCLK_I958_SEL]   = &meson8b_cts_mclk_i958_sel.hw,
+		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
+		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -3106,6 +3168,9 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_cts_amclk,
 	&meson8b_cts_amclk_sel,
 	&meson8b_cts_amclk_div,
+	&meson8b_cts_mclk_i958_sel,
+	&meson8b_cts_mclk_i958_div,
+	&meson8b_cts_mclk_i958,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index 03efa47e800f..c3787418088e 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -32,6 +32,7 @@
 #define HHI_MPEG_CLK_CNTL		0x174 /* 0x5d offset in data sheet */
 #define HHI_AUD_CLK_CNTL		0x178 /* 0x5e offset in data sheet */
 #define HHI_VID_CLK_CNTL		0x17c /* 0x5f offset in data sheet */
+#define HHI_AUD_CLK_CNTL2		0x190 /* 0x64 offset in data sheet */
 #define HHI_VID_CLK_CNTL2		0x194 /* 0x65 offset in data sheet */
 #define HHI_VID_DIVIDER_CNTL		0x198 /* 0x66 offset in data sheet */
 #define HHI_SYS_CPU_CLK_CNTL0		0x19c /* 0x67 offset in data sheet */
@@ -174,8 +175,10 @@
 #define CLKID_VDEC_HEVC_EN	205
 #define CLKID_CTS_AMCLK_SEL	207
 #define CLKID_CTS_AMCLK_DIV	208
+#define CLKID_CTS_MCLK_I958_SEL	210
+#define CLKID_CTS_MCLK_I958_DIV	211
 
-#define CLK_NR_CLKS		210
+#define CLK_NR_CLKS		213
 
 /*
  * include the CLKID and RESETID that have
-- 
2.21.0

