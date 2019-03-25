Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0513C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9B620863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="r3pB7Xyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfCYLM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:12:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50400 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbfCYLMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:12:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so8495747wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSTs5pvYtXziAiN+RG5xFnEp9XYC2fpG75vZzF22hfs=;
        b=r3pB7Xygzu97DmUwohN4so1YlPfsLTJ88ye6r8Q2iVezfT/WFu9hwCEU1PXM1tjKII
         PxuYgGCi4bDjes2TRQ4hQQHItbg62/GmXe9EKrvRDG1PArBeWJaO7zjKj4AyUao8kS2o
         wkdmW4+IaPU1bd8yO74i685YPAtjkUqGMBwqDwNCHtKDFtvbKsmZ0OfmlWU8bNx025Md
         G0IFYc1IrmdqROt6L2exGp7vHh1pHrosX/x7TGxpWzh+AOWsCWXlN5n2Oz9b3HqKNLOm
         ltljs3l5jY4xRBTlvZiWcD+AVvy0QMgnAl1+aP34cu+46Qkn6UUH4H6lUw1yILBgWxCG
         OlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSTs5pvYtXziAiN+RG5xFnEp9XYC2fpG75vZzF22hfs=;
        b=kMKVKHUijZ6h1GXT+MJ/OS74/K5Ffdyng3utRPJOSdfGhhZmKU1rPUC6B5FN1zYnRw
         o/tp10Rt4OhgNGqZXQC4mxlz0m48CTCyBfR130OgQe6zJMgi8YoyGK8oWQY6LOfYz7da
         3UXtoQSAWpb92XgQCM9osxUV8yAadwXP7t6qyhbqcqn/EI1p5PHbHm//FWQCsudhBorH
         1f6FvEOTx2rlEpxrKlziTK44ByT83lhgGCZcGxl7nNKUthQp69rKBvVboxj09gcivL/s
         /AwsqJmo8/S73m53zrIpNn3lLgdAvCpDDY/fBcczm/91bs7/0ZYrdOVk6x7vxTYyKXBX
         pZXA==
X-Gm-Message-State: APjAAAU/24YUq60lBNtrpkQCG0v9vZtjfXX10sKfUvjFyEiarng0S29B
        mErFpgTT4HJgy0HvdjdX4vvw8g==
X-Google-Smtp-Source: APXvYqwbT8APELDi6g2qSkQz94txZgo1z92evuBUYL68fQZejF9n6rSg43J6ivlL4CwiNuv+RYquIA==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr5392149wmj.31.1553512330909;
        Mon, 25 Mar 2019 04:12:10 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id n188sm15134301wme.13.2019.03.25.04.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 04:12:10 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] clk: meson: g12a: add mpll register init sequences
Date:   Mon, 25 Mar 2019 12:11:58 +0100
Message-Id: <20190325111200.15940-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190325111200.15940-1-jbrunet@baylibre.com>
References: <20190325111200.15940-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required init of each MPLL of the g12a.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/g12a.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index d3f53a9b97dc..6a01f8fd8114 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -577,6 +577,10 @@ static struct clk_fixed_factor g12a_mpll_prediv = {
 	},
 };
 
+static const struct reg_sequence g12a_mpll0_init_regs[] = {
+	{ .reg = HHI_MPLL_CNTL2,	.def = 0x40000033 },
+};
+
 static struct clk_regmap g12a_mpll0_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
@@ -600,6 +604,8 @@ static struct clk_regmap g12a_mpll0_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.init_regs = g12a_mpll0_init_regs,
+		.init_count = ARRAY_SIZE(g12a_mpll0_init_regs),
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0_div",
@@ -623,6 +629,10 @@ static struct clk_regmap g12a_mpll0 = {
 	},
 };
 
+static const struct reg_sequence g12a_mpll1_init_regs[] = {
+	{ .reg = HHI_MPLL_CNTL4,	.def = 0x40000033 },
+};
+
 static struct clk_regmap g12a_mpll1_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
@@ -646,6 +656,8 @@ static struct clk_regmap g12a_mpll1_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.init_regs = g12a_mpll1_init_regs,
+		.init_count = ARRAY_SIZE(g12a_mpll1_init_regs),
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1_div",
@@ -669,6 +681,10 @@ static struct clk_regmap g12a_mpll1 = {
 	},
 };
 
+static const struct reg_sequence g12a_mpll2_init_regs[] = {
+	{ .reg = HHI_MPLL_CNTL6,	.def = 0x40000033 },
+};
+
 static struct clk_regmap g12a_mpll2_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
@@ -692,6 +708,8 @@ static struct clk_regmap g12a_mpll2_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.init_regs = g12a_mpll2_init_regs,
+		.init_count = ARRAY_SIZE(g12a_mpll2_init_regs),
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2_div",
@@ -715,6 +733,10 @@ static struct clk_regmap g12a_mpll2 = {
 	},
 };
 
+static const struct reg_sequence g12a_mpll3_init_regs[] = {
+	{ .reg = HHI_MPLL_CNTL8,	.def = 0x40000033 },
+};
+
 static struct clk_regmap g12a_mpll3_div = {
 	.data = &(struct meson_clk_mpll_data){
 		.sdm = {
@@ -738,6 +760,8 @@ static struct clk_regmap g12a_mpll3_div = {
 			.width	 = 1,
 		},
 		.lock = &meson_clk_lock,
+		.init_regs = g12a_mpll3_init_regs,
+		.init_count = ARRAY_SIZE(g12a_mpll3_init_regs),
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll3_div",
-- 
2.20.1

