Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4608BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33B2217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IDJLNf7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfCSWAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:00:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36167 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfCSWAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:00:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so9635622wml.1;
        Tue, 19 Mar 2019 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2XSCB6pbSoqCmk4AB1xIf/wFsjrxIhmtQekLeAUKQc=;
        b=IDJLNf7yznk8cQ3EKrwA3kC4rNOJVZBqpLFy5kwI5qOKzhx6uOuFNesVj0kayMOqOp
         Plz93HqxYFgp1HKmZPNcYq7qpklQ8Zo9/rRBSmkTPfWS08ZdWcZw3ENBr23Di8YT2O3P
         em3XlM+T5i1Xn2y+b493yqknLltC4LNSI2BV+G1G2gBljEp1EHk8alsxJxl7sck93P51
         xkHmnFjQ0C0bU524MaGmT3yT8Ov1d74wVqs4K8U3rwmdLlxFUuFLxA6YN+GLQIfhis5g
         ubEeh0orxCU3BSqYuwFwF9Lv5emvofP2UTVey5QAFanfN00XfYu6cw3vptOO6q43U5AU
         naow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2XSCB6pbSoqCmk4AB1xIf/wFsjrxIhmtQekLeAUKQc=;
        b=DwKAm0Wl355n+kjf2MdmQcTSPzMZNHeJG2Y6goRItIMWXLM7ENNLUL4OTxCM2uvFuL
         e4G5p5Nb+EW+XiN1iUAQ1uqvYUVEtOcX5cxOVVZMbT8JkCdbzIDeddKD+5NAQ/+umq2H
         pdv23A7bhm3S3H7agsC7FldEZ+m6v6xZ/6sxCZjvUtmSHWhRR41XwzHyQbi43EFESNHB
         NglV9epPF+ejwffxjJbiVuCmFl1PRG1bYbmZCet80r/qhMddu59u0aeiy3VM/pfnzDzX
         mnjQgq8uDS4Se1uaL01XZa6zKklD1oYTcH3FJ/huXALm8oKi8v1fg6oev+sK6rpa4TOo
         WycQ==
X-Gm-Message-State: APjAAAWGO8BIkJs5tyYeD28bZZki2l2eQgdm8OwcPfh4kWAnDsaug3nk
        jiHNl+09tfEjBCy1Xt2fmRg=
X-Google-Smtp-Source: APXvYqxOo5gv0+NQjUBZIf71kaGq0EtpUIGemhebsJklSR+dQXXrTnkve7P5b3rg1v2k+LjlXsVVbw==
X-Received: by 2002:a7b:c382:: with SMTP id s2mr5298026wmj.56.1553032819373;
        Tue, 19 Mar 2019 15:00:19 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD739990039EE738515149D3E.dip0.t-ipconnect.de. [2003:dc:d739:9900:39ee:7385:1514:9d3e])
        by smtp.googlemail.com with ESMTPSA id t2sm188762wra.9.2019.03.19.15.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 15:00:18 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, mjourdan@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] clk: meson: meson8b: add the video decoder clock trees
Date:   Tue, 19 Mar 2019 23:00:12 +0100
Message-Id: <20190319220012.31065-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319220012.31065-1-martin.blumenstingl@googlemail.com>
References: <20190319220012.31065-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the four video decoder clock trees.

VDEC_1 is split into two paths on Meson8b and Meson8m2:
- input mux called "vdec_1_sel"
- two dividers ("vdec_1_1_div" and "vdec_1_2_div") and gates ("vdec_1_1"
  and "vdec_1_2")
- and an output mux (probably glitch-free) called "vdec_1"
On Meson8 the VDEC_1 tree is simpler because there's only one path:
- input mux called "vdec_1_sel"
- divider ("vdec_1_1_div") and gate ("vdec_1_1")
- (the gate is used as output directly, there's no mux)

The VDEC_HCODEC and VDEC_2 clocks are simple composite clocks each
consisting of an input mux, divider and a gate.

The VDEC_HEVC clock seems to have two paths similar to the VDEC_1 clock.
However, the register offsets of the second clock path is not known.
Amlogic's 3.10 kernel (which is used as reference) sets
HHI_VDEC2_CLK_CNTL[31] to 1 before changing the VDEC_HEVC clock and back
to 0 afterwards. For now, leave a TODO comment and only add the first
path.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 312 ++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/meson8b.h |  17 +-
 2 files changed, 328 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 8e091c2d10e6..37cf0f01bb5d 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1902,6 +1902,257 @@ static struct clk_regmap meson8b_vpu = {
 	},
 };
 
+static const char * const meson8b_vdec_parent_names[] = {
+	"fclk_div4", "fclk_div3", "fclk_div5", "fclk_div7", "mpll2", "mpll1"
+};
+
+static struct clk_regmap meson8b_vdec_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_1_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = meson8b_vdec_parent_names,
+		.num_parents = ARRAY_SIZE(meson8b_vdec_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_1_1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_1_1_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vdec_1_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_1_1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_1_1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vdec_1_1_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_1_2_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VDEC3_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_1_2_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vdec_1_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_1_2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VDEC3_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_1_2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vdec_1_2_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_1 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VDEC3_CLK_CNTL,
+		.mask = 0x1,
+		.shift = 15,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_1",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "vdec_1_1", "vdec_1_2" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_hcodec_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 25,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_hcodec_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = meson8b_vdec_parent_names,
+		.num_parents = ARRAY_SIZE(meson8b_vdec_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_hcodec_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.shift = 16,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_hcodec_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vdec_hcodec_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_hcodec = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VDEC_CLK_CNTL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_hcodec",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vdec_hcodec_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_2_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_2_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = meson8b_vdec_parent_names,
+		.num_parents = ARRAY_SIZE(meson8b_vdec_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_2_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_2_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vdec_2_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vdec_2_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_hevc_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 25,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_hevc_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = meson8b_vdec_parent_names,
+		.num_parents = ARRAY_SIZE(meson8b_vdec_parent_names),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_hevc_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.shift = 16,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_hevc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "vdec_hevc_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_hevc_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_hevc_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "vdec_hevc_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap meson8b_vdec_hevc = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VDEC2_CLK_CNTL,
+		.mask = 0x1,
+		.shift = 31,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_hevc",
+		.ops = &clk_regmap_mux_ops,
+		/* TODO: The second parent is currently unknown */
+		.parent_names = (const char *[]){ "vdec_hevc_en" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
@@ -2168,6 +2419,19 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
 		[CLKID_VPU_0_SEL]	    = &meson8b_vpu_0_sel.hw,
 		[CLKID_VPU_0_DIV]	    = &meson8b_vpu_0_div.hw,
 		[CLKID_VPU]		    = &meson8b_vpu_0.hw,
+		[CLKID_VDEC_1_SEL]	    = &meson8b_vdec_1_sel.hw,
+		[CLKID_VDEC_1_1_DIV]	    = &meson8b_vdec_1_1_div.hw,
+		[CLKID_VDEC_1]	   	    = &meson8b_vdec_1_1.hw,
+		[CLKID_VDEC_HCODEC_SEL]	    = &meson8b_vdec_hcodec_sel.hw,
+		[CLKID_VDEC_HCODEC_DIV]	    = &meson8b_vdec_hcodec_div.hw,
+		[CLKID_VDEC_HCODEC]	    = &meson8b_vdec_hcodec.hw,
+		[CLKID_VDEC_2_SEL]	    = &meson8b_vdec_2_sel.hw,
+		[CLKID_VDEC_2_DIV]	    = &meson8b_vdec_2_div.hw,
+		[CLKID_VDEC_2]	    	    = &meson8b_vdec_2.hw,
+		[CLKID_VDEC_HEVC_SEL]	    = &meson8b_vdec_hevc_sel.hw,
+		[CLKID_VDEC_HEVC_DIV]	    = &meson8b_vdec_hevc_div.hw,
+		[CLKID_VDEC_HEVC_EN]	    = &meson8b_vdec_hevc_en.hw,
+		[CLKID_VDEC_HEVC]	    = &meson8b_vdec_hevc.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2361,6 +2625,22 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_VPU_1_DIV]	    = &meson8b_vpu_1_div.hw,
 		[CLKID_VPU_1]		    = &meson8b_vpu_1.hw,
 		[CLKID_VPU]		    = &meson8b_vpu.hw,
+		[CLKID_VDEC_1_SEL]	    = &meson8b_vdec_1_sel.hw,
+		[CLKID_VDEC_1_1_DIV]	    = &meson8b_vdec_1_1_div.hw,
+		[CLKID_VDEC_1_1]	    = &meson8b_vdec_1_1.hw,
+		[CLKID_VDEC_1_2_DIV]	    = &meson8b_vdec_1_2_div.hw,
+		[CLKID_VDEC_1_2]	    = &meson8b_vdec_1_2.hw,
+		[CLKID_VDEC_1]	    	    = &meson8b_vdec_1.hw,
+		[CLKID_VDEC_HCODEC_SEL]	    = &meson8b_vdec_hcodec_sel.hw,
+		[CLKID_VDEC_HCODEC_DIV]	    = &meson8b_vdec_hcodec_div.hw,
+		[CLKID_VDEC_HCODEC]	    = &meson8b_vdec_hcodec.hw,
+		[CLKID_VDEC_2_SEL]	    = &meson8b_vdec_2_sel.hw,
+		[CLKID_VDEC_2_DIV]	    = &meson8b_vdec_2_div.hw,
+		[CLKID_VDEC_2]	    	    = &meson8b_vdec_2.hw,
+		[CLKID_VDEC_HEVC_SEL]	    = &meson8b_vdec_hevc_sel.hw,
+		[CLKID_VDEC_HEVC_DIV]	    = &meson8b_vdec_hevc_div.hw,
+		[CLKID_VDEC_HEVC_EN]	    = &meson8b_vdec_hevc_en.hw,
+		[CLKID_VDEC_HEVC]	    = &meson8b_vdec_hevc.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2556,6 +2836,22 @@ static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
 		[CLKID_VPU_1_DIV]	    = &meson8b_vpu_1_div.hw,
 		[CLKID_VPU_1]		    = &meson8b_vpu_1.hw,
 		[CLKID_VPU]		    = &meson8b_vpu.hw,
+		[CLKID_VDEC_1_SEL]	    = &meson8b_vdec_1_sel.hw,
+		[CLKID_VDEC_1_1_DIV]	    = &meson8b_vdec_1_1_div.hw,
+		[CLKID_VDEC_1_1]	    = &meson8b_vdec_1_1.hw,
+		[CLKID_VDEC_1_2_DIV]	    = &meson8b_vdec_1_2_div.hw,
+		[CLKID_VDEC_1_2]	    = &meson8b_vdec_1_2.hw,
+		[CLKID_VDEC_1]	    	    = &meson8b_vdec_1.hw,
+		[CLKID_VDEC_HCODEC_SEL]	    = &meson8b_vdec_hcodec_sel.hw,
+		[CLKID_VDEC_HCODEC_DIV]	    = &meson8b_vdec_hcodec_div.hw,
+		[CLKID_VDEC_HCODEC]	    = &meson8b_vdec_hcodec.hw,
+		[CLKID_VDEC_2_SEL]	    = &meson8b_vdec_2_sel.hw,
+		[CLKID_VDEC_2_DIV]	    = &meson8b_vdec_2_div.hw,
+		[CLKID_VDEC_2]	    	    = &meson8b_vdec_2.hw,
+		[CLKID_VDEC_HEVC_SEL]	    = &meson8b_vdec_hevc_sel.hw,
+		[CLKID_VDEC_HEVC_DIV]	    = &meson8b_vdec_hevc_div.hw,
+		[CLKID_VDEC_HEVC_EN]	    = &meson8b_vdec_hevc_en.hw,
+		[CLKID_VDEC_HEVC]	    = &meson8b_vdec_hevc.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2729,6 +3025,22 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_vpu_1_div,
 	&meson8b_vpu_1,
 	&meson8b_vpu,
+	&meson8b_vdec_1_sel,
+	&meson8b_vdec_1_1_div,
+	&meson8b_vdec_1_1,
+	&meson8b_vdec_1_2_div,
+	&meson8b_vdec_1_2,
+	&meson8b_vdec_1,
+	&meson8b_vdec_hcodec_sel,
+	&meson8b_vdec_hcodec_div,
+	&meson8b_vdec_hcodec,
+	&meson8b_vdec_2_sel,
+	&meson8b_vdec_2_div,
+	&meson8b_vdec_2,
+	&meson8b_vdec_hevc_sel,
+	&meson8b_vdec_hevc_div,
+	&meson8b_vdec_hevc_en,
+	&meson8b_vdec_hevc,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index e775f91ccce9..ed37196187e6 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -37,6 +37,9 @@
 #define HHI_MALI_CLK_CNTL		0x1b0 /* 0x6c offset in data sheet */
 #define HHI_VPU_CLK_CNTL		0x1bc /* 0x6f offset in data sheet */
 #define HHI_HDMI_CLK_CNTL		0x1cc /* 0x73 offset in data sheet */
+#define HHI_VDEC_CLK_CNTL		0x1e0 /* 0x78 offset in data sheet */
+#define HHI_VDEC2_CLK_CNTL		0x1e4 /* 0x79 offset in data sheet */
+#define HHI_VDEC3_CLK_CNTL		0x1e8 /* 0x7a offset in data sheet */
 #define HHI_NAND_CLK_CNTL		0x25c /* 0x97 offset in data sheet */
 #define HHI_MPLL_CNTL			0x280 /* 0xa0 offset in data sheet */
 #define HHI_SYS_PLL_CNTL		0x300 /* 0xc0 offset in data sheet */
@@ -156,8 +159,20 @@
 #define CLKID_VPU_1_SEL		186
 #define CLKID_VPU_1_DIV		187
 #define CLKID_VPU_1		189
+#define CLKID_VDEC_1_SEL	191
+#define CLKID_VDEC_1_1_DIV	192
+#define CLKID_VDEC_1_1		193
+#define CLKID_VDEC_1_2_DIV	194
+#define CLKID_VDEC_1_2		195
+#define CLKID_VDEC_HCODEC_SEL	197
+#define CLKID_VDEC_HCODEC_DIV	198
+#define CLKID_VDEC_2_SEL	200
+#define CLKID_VDEC_2_DIV	201
+#define CLKID_VDEC_HEVC_SEL	203
+#define CLKID_VDEC_HEVC_DIV	204
+#define CLKID_VDEC_HEVC_EN	205
 
-#define CLK_NR_CLKS		191
+#define CLK_NR_CLKS		207
 
 /*
  * include the CLKID and RESETID that have
-- 
2.21.0

