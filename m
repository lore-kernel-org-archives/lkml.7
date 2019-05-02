Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F0AC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD502081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="W9P9cxNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfEBVZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:25:20 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52912 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBVZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1556832318; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdt3tlRdRDdELKQiFYlbSJ7Gl5xHGd3LofHxFVVvckM=;
        b=W9P9cxNj1+AsQhMQgA4Zm0CHdBm5QbAoedxElycG2YMybnJ1MH6sQTwQ7HmYsYiSZdZXFZ
        yQ5jWUPGPA1klbgNEzFFqfsBZ+4uFhjLpA15xD3w69Cqlvs/XU3sMO0/K6TIDbSPq7RtQC
        y3AI2c5+V0DVY8ZU1ysLrlzsR4UzaCM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/5] clk: ingenic/jz4740: Fix incorrect dividers for main clocks
Date:   Thu,  2 May 2019 23:24:59 +0200
Message-Id: <20190502212502.24330-2-paul@crapouillou.net>
In-Reply-To: <20190502212502.24330-1-paul@crapouillou.net>
References: <20190502212502.24330-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main clocks (cclk, hclk, pclk, mclk, lcd) were using
incorrect dividers, and thus reported an incorrect rate.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4740-cgu.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index b86edd328249..ec6c71806687 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -57,6 +57,10 @@ static const s8 pll_od_encoding[4] = {
 	0x0, 0x1, -1, 0x3,
 };
 
+static const u8 jz4740_cgu_cpccr_div_table[] = {
+	1, 2, 3, 4, 6, 8, 12, 16, 24, 32,
+};
+
 static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 
 	/* External clocks */
@@ -96,31 +100,46 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 	[JZ4740_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1,
+			jz4740_cgu_cpccr_div_table,
+		},
 	},
 
 	[JZ4740_CLK_HCLK] = {
 		"hclk", CGU_CLK_DIV,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1,
+			jz4740_cgu_cpccr_div_table,
+		},
 	},
 
 	[JZ4740_CLK_PCLK] = {
 		"pclk", CGU_CLK_DIV,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1,
+			jz4740_cgu_cpccr_div_table,
+		},
 	},
 
 	[JZ4740_CLK_MCLK] = {
 		"mclk", CGU_CLK_DIV,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1,
+			jz4740_cgu_cpccr_div_table,
+		},
 	},
 
 	[JZ4740_CLK_LCD] = {
 		"lcd", CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { JZ4740_CLK_PLL_HALF, -1, -1, -1 },
-		.div = { CGU_REG_CPCCR, 16, 1, 5, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 16, 1, 5, 22, -1, -1,
+			jz4740_cgu_cpccr_div_table,
+		},
 		.gate = { CGU_REG_CLKGR, 10 },
 	},
 
-- 
2.21.0.593.g511ec345e18

