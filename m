Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1748D2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="fZZJhvlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEBVZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:25:28 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53144 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfEBVZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1556832323; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUM2A5W/bGgbUS0YQyoPZqv2IlJxshahRHZvInXfmRk=;
        b=fZZJhvluowrhUeNvx5a/sWvSLImn8ceGAtpBtrvu82lbn0PvXA8R32V/FYTIb8QCOFMn+B
        RAZnuTubLViBU4YmGX9TNrJV7UfzWwZNofmyPkFYjA/F8Zvb7Tg8T5dDRJ55H7kQYa2wdR
        AS6sY8LuQnXqxFSA5We052BGbJCbzkw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/5] clk: ingenic/jz4725b: Fix incorrect dividers for main clocks
Date:   Thu,  2 May 2019 23:25:01 +0200
Message-Id: <20190502212502.24330-4-paul@crapouillou.net>
In-Reply-To: <20190502212502.24330-1-paul@crapouillou.net>
References: <20190502212502.24330-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main clocks (cclk, hclk, pclk, mclk, ipu) were using
incorrect dividers, and thus reported an incorrect rate.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4725b-cgu.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 8901ea0295b7..31325dd40a0f 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -33,6 +33,10 @@ static const s8 pll_od_encoding[4] = {
 	0x0, 0x1, -1, 0x3,
 };
 
+static const u8 jz4725b_cgu_cpccr_div_table[] = {
+	1, 2, 3, 4, 6, 8,
+};
+
 static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 
 	/* External clocks */
@@ -72,31 +76,46 @@ static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 	[JZ4725B_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1,
+			jz4725b_cgu_cpccr_div_table,
+		},
 	},
 
 	[JZ4725B_CLK_HCLK] = {
 		"hclk", CGU_CLK_DIV,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1,
+			jz4725b_cgu_cpccr_div_table,
+		},
 	},
 
 	[JZ4725B_CLK_PCLK] = {
 		"pclk", CGU_CLK_DIV,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1,
+			jz4725b_cgu_cpccr_div_table,
+		},
 	},
 
 	[JZ4725B_CLK_MCLK] = {
 		"mclk", CGU_CLK_DIV,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1,
+			jz4725b_cgu_cpccr_div_table,
+		},
 	},
 
 	[JZ4725B_CLK_IPU] = {
 		"ipu", CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1,
+			jz4725b_cgu_cpccr_div_table,
+		},
 		.gate = { CGU_REG_CLKGR, 13 },
 	},
 
-- 
2.21.0.593.g511ec345e18

