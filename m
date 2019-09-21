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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75F9C4CEC4
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D074217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cH05sPvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438208AbfIUPS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:18:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39601 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392043AbfIUPSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:18:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so9614381wrj.6;
        Sat, 21 Sep 2019 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MgeOWr52J0AbeRdfS/blsOSLs4diI31K6bmRntAvmGc=;
        b=cH05sPvRnyjjP4kqZ62tz5buGh4I6wiRdSZ73thccq3BH6hMZ/efZjpv/k0ukN1j6o
         I7ZPU9kRKbOMbsE3D6vjGOKpngSxeRVR8P+HTYqmPZXOIQO4Yfl95X3gNhQk7hvYghRY
         0YG09bEXuXWi4js1VASxO8rD+1pHiB7L4da3a56wWljAt0HIpN00+zwF2zg+YSTq8r+U
         IjmZZs6AcM5nQ8IS4k1D/ZvwCObfssmRcIgxSmNPTcn28/WxpNQBe0/mlluLGd10wXrF
         41YzrSpx6DKRfthRXUurdMqNtq+g9wzy2rgIVSnjyrkV2S3fh8BudveJtu5+9jce4TO3
         akpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MgeOWr52J0AbeRdfS/blsOSLs4diI31K6bmRntAvmGc=;
        b=eC6aOuX+V3D7Q54Z41RkcpzPWK2ZeSJaLK7Qya4IvF9SFhjhhJwuXOt9SYBElmUWlS
         505IOmcRt1Ch4x9DZrSLoaeAbvO8oXwLM+n9v56oXS0z4PZWIT1cWiZpYO/x3huu5Pkj
         HhdxaVSFl9HwOez1NMWx5LKekwwMvf6rHDUDRUzRBxDg9JyEvDOcMc5vPj57hDX1fzdx
         AuIN15EiMF+7Y2ku3LgKtLLhCgx8amyraeBbjI9ssfZUWUGitsK0yNvE+CL7uaolYQ6l
         drjoefoQGQFBnzfIMI3g+U+Bfv6Akpp1pNJ6Yo1h8DgQuCvmJIYSqQPjVltWFFx1UgUL
         udlA==
X-Gm-Message-State: APjAAAV/L52eYfiUlbMHMEyLX0O7TM6BXKsNaKpOIYK0eIVw406O+A8b
        vO+lbG5tQUEYlSrDqGPG3d8=
X-Google-Smtp-Source: APXvYqzFKXhBjZTODvaRaYjnssgMU/qh93dWuwrlF1daSaR72oohtXpNNgFalCsExTd4cIdV4rv50A==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr15047963wrp.290.1569079132443;
        Sat, 21 Sep 2019 08:18:52 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id c6sm6003120wrb.60.2019.09.21.08.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:18:51 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/6] clk: meson: meson8b: add the ddr_pll input for the audio clocks
Date:   Sat, 21 Sep 2019 17:18:33 +0200
Message-Id: <20190921151835.770263-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190921151835.770263-1-martin.blumenstingl@googlemail.com>
References: <20190921151835.770263-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two audio muxes cts_amclk_sel and cts_mclk_i958_sel use ddr_pll as
input at index 0. Update the muxes to use clk_parent_data and add
"ddr_pll" as input using clk_parent_data.fw_name because the DDR clock
controller is actually separate from the main clock controller.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index fefb4b7185d0..3987f4ea7378 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2429,28 +2429,25 @@ static struct clk_regmap meson8b_vdec_hevc = {
 	},
 };
 
-/* TODO: the clock at index 0 is "DDR_PLL" which we don't support yet */
-static const struct clk_hw *meson8b_cts_amclk_parent_hws[] = {
-	&meson8b_mpll0.hw,
-	&meson8b_mpll1.hw,
-	&meson8b_mpll2.hw
+static const struct clk_parent_data meson8b_cts_amclk_parent_data[] = {
+	{ .fw_name = "ddr_pll", },
+	{ .hw = &meson8b_mpll0.hw, },
+	{ .hw = &meson8b_mpll1.hw, },
+	{ .hw = &meson8b_mpll2.hw, },
 };
 
-static u32 meson8b_cts_amclk_mux_table[] = { 1, 2, 3 };
-
 static struct clk_regmap meson8b_cts_amclk_sel = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = HHI_AUD_CLK_CNTL,
 		.mask = 0x3,
 		.shift = 9,
-		.table = meson8b_cts_amclk_mux_table,
 		.flags = CLK_MUX_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_amclk_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_hws = meson8b_cts_amclk_parent_hws,
-		.num_parents = ARRAY_SIZE(meson8b_cts_amclk_parent_hws),
+		.parent_data = meson8b_cts_amclk_parent_data,
+		.num_parents = ARRAY_SIZE(meson8b_cts_amclk_parent_data),
 	},
 };
 
@@ -2488,28 +2485,25 @@ static struct clk_regmap meson8b_cts_amclk = {
 	},
 };
 
-/* TODO: the clock at index 0 is "DDR_PLL" which we don't support yet */
-static const struct clk_hw *meson8b_cts_mclk_i958_parent_hws[] = {
-	&meson8b_mpll0.hw,
-	&meson8b_mpll1.hw,
-	&meson8b_mpll2.hw
+static const struct clk_parent_data meson8b_cts_mclk_i958_parent_data[] = {
+	{ .fw_name = "ddr_pll", },
+	{ .hw = &meson8b_mpll0.hw, },
+	{ .hw = &meson8b_mpll1.hw, },
+	{ .hw = &meson8b_mpll2.hw, },
 };
 
-static u32 meson8b_cts_mclk_i958_mux_table[] = { 1, 2, 3 };
-
 static struct clk_regmap meson8b_cts_mclk_i958_sel = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = HHI_AUD_CLK_CNTL2,
 		.mask = 0x3,
 		.shift = 25,
-		.table = meson8b_cts_mclk_i958_mux_table,
 		.flags = CLK_MUX_ROUND_CLOSEST,
 	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "cts_mclk_i958_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_hws = meson8b_cts_mclk_i958_parent_hws,
-		.num_parents = ARRAY_SIZE(meson8b_cts_mclk_i958_parent_hws),
+		.parent_data = meson8b_cts_mclk_i958_parent_data,
+		.num_parents = ARRAY_SIZE(meson8b_cts_mclk_i958_parent_data),
 	},
 };
 
-- 
2.23.0

