Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7E4C282DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C107206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="OOlQWuJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfDQLYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:24:38 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41902 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbfDQLYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1555500274; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=bBLUV/8+xs9wh0KVpINpVvkpUIXdMJUyfgoeOW2vPiI=;
        b=OOlQWuJL7yLKJiCe+i1UxNuxOpafHCo5RGm+lsHWRLasiI9lDNGVAdWa/h5+JifgcVsjYO
        zfjztxgNSWJwKCGsK6EkQVaQuUoHZ+7U3d7hCQ6VfwJ0sNigH2sVfZxANT7ApGC7PRb8ub
        5bRs+s6KzqeKY688W+TRDFrDPUSM1XU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org
Subject: [PATCH] clk: ingenic/jz4725b: Fix parent of pixel clock
Date:   Wed, 17 Apr 2019 13:24:20 +0200
Message-Id: <20190417112420.3034-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pixel clock is directly connected to the output of the PLL, and not
to the /2 divider.

Cc: stable@vger.kernel.org
Fixes: 226dfa4726eb ("clk: Add Ingenic jz4725b CGU driver")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4725b-cgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 8901ea0295b7..76793b3d2ef8 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -102,7 +102,7 @@ static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 
 	[JZ4725B_CLK_LCD] = {
 		"lcd", CGU_CLK_DIV | CGU_CLK_GATE,
-		.parents = { JZ4725B_CLK_PLL_HALF, -1, -1, -1 },
+		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
 		.div = { CGU_REG_LPCDR, 0, 1, 11, -1, -1, -1 },
 		.gate = { CGU_REG_CLKGR, 9 },
 	},
-- 
2.21.0.593.g511ec345e18

