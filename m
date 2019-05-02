Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5350C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913762081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wOyIHhTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfEBVZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:25:24 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:53092 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBVZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1556832321; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a+dDXdpbuMWeKYt/05l9iGJCU7CR63y3+TCDIA7QuVQ=;
        b=wOyIHhTwFZbhn5wHICZDlzFrlBUMMGVW20KKSdYpStVAdcciEw6AnqmRXk2S6ijYFyeaMp
        XfNUCT9EarA6qDHYuZdgAIls+TVQ5CfbJ062JuGxx5og/XH9HtJTRceNHAgvTNeIm63ObD
        WQcQ2pUSVCC5SnZ55+ZyPLJuC4ulvec=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/5] clk: ingenic/jz4770: Fix incorrect dividers for main clocks
Date:   Thu,  2 May 2019 23:25:00 +0200
Message-Id: <20190502212502.24330-3-paul@crapouillou.net>
In-Reply-To: <20190502212502.24330-1-paul@crapouillou.net>
References: <20190502212502.24330-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main clocks (cclk, h0clk, h1clk, h2clk, c1clk, pclk) were using
incorrect dividers, and thus reported an incorrect rate.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4770-cgu.c | 34 ++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index bf46a0df2004..3479ad30b040 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -86,6 +86,10 @@ static const s8 pll_od_encoding[8] = {
 	0x0, 0x1, -1, 0x2, -1, -1, -1, 0x3,
 };
 
+static const u8 jz4770_cgu_cpccr_div_table[] = {
+	1, 2, 3, 4, 6, 8, 12,
+};
+
 static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 
 	/* External clocks */
@@ -143,34 +147,52 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 	[JZ4770_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
 		.parents = { JZ4770_CLK_PLL0, },
-		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1,
+			jz4770_cgu_cpccr_div_table,
+		},
 	},
 	[JZ4770_CLK_H0CLK] = {
 		"h0clk", CGU_CLK_DIV,
 		.parents = { JZ4770_CLK_PLL0, },
-		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1,
+			jz4770_cgu_cpccr_div_table,
+		},
 	},
 	[JZ4770_CLK_H1CLK] = {
 		"h1clk", CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { JZ4770_CLK_PLL0, },
-		.div = { CGU_REG_CPCCR, 24, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 24, 1, 4, 22, -1, -1,
+			jz4770_cgu_cpccr_div_table,
+		},
 		.gate = { CGU_REG_CLKGR1, 7 },
 	},
 	[JZ4770_CLK_H2CLK] = {
 		"h2clk", CGU_CLK_DIV,
 		.parents = { JZ4770_CLK_PLL0, },
-		.div = { CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1,
+			jz4770_cgu_cpccr_div_table,
+		},
 	},
 	[JZ4770_CLK_C1CLK] = {
 		"c1clk", CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { JZ4770_CLK_PLL0, },
-		.div = { CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1,
+			jz4770_cgu_cpccr_div_table,
+		},
 		.gate = { CGU_REG_OPCR, 31, true }, // disable CCLK stop on idle
 	},
 	[JZ4770_CLK_PCLK] = {
 		"pclk", CGU_CLK_DIV,
 		.parents = { JZ4770_CLK_PLL0, },
-		.div = { CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1 },
+		.div = {
+			CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1,
+			jz4770_cgu_cpccr_div_table,
+		},
 	},
 
 	/* Those divided clocks can connect to PLL0 or PLL1 */
-- 
2.21.0.593.g511ec345e18

