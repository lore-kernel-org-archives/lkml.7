Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D05C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFC721743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="UWTC4U1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388117AbfGPRIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:08:13 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:42408 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPRIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563296891; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=Au5wD0iSXHqvvfoteUAXzESR9OKNxOhCxGZ4sRNOnkY=;
        b=UWTC4U1VfEsF9GJwvrnGMlLYM0sJaluIWWrpGtuS5pAl/9S1xFlFBPfh0yjoJpj5CF8O3D
        wDG62y6HTr7Yr3P1gG2ob3zjyTX+kd2OWXMcyB/JcFU2M7wEeLCVPzKaj80+buwVCmsF7W
        rs8GlqvGEsTmLslondiX+0Fe/gwih/g=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] clk: ingenic: Use CLK_OF_DECLARE_DRIVER macro
Date:   Tue, 16 Jul 2019 13:08:00 -0400
Message-Id: <20190716170800.23668-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using CLK_OF_DECLARE_DRIVER instead of the CLK_OF_DECLARE macro, we
allow the driver to probe also as a platform driver.

While this driver does not have code to probe as a platform driver, this
is still useful for probing children devices in the case where the
device node is compatible with "simple-mfd".

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4725b-cgu.c | 2 +-
 drivers/clk/ingenic/jz4740-cgu.c  | 2 +-
 drivers/clk/ingenic/jz4770-cgu.c  | 2 +-
 drivers/clk/ingenic/jz4780-cgu.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 47287956824b..5fd2e4e6da2d 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -254,4 +254,4 @@ static void __init jz4725b_cgu_init(struct device_node *np)
 	if (retval)
 		pr_err("%s: failed to register CGU Clocks\n", __func__);
 }
-CLK_OF_DECLARE(jz4725b_cgu, "ingenic,jz4725b-cgu", jz4725b_cgu_init);
+CLK_OF_DECLARE_DRIVER(jz4725b_cgu, "ingenic,jz4725b-cgu", jz4725b_cgu_init);
diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 0957ba4a40a5..a002a2d8db6f 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -246,7 +246,7 @@ static void __init jz4740_cgu_init(struct device_node *np)
 	if (retval)
 		pr_err("%s: failed to register CGU Clocks\n", __func__);
 }
-CLK_OF_DECLARE(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);
+CLK_OF_DECLARE_DRIVER(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);
 
 void jz4740_clock_set_wait_mode(enum jz4740_wait_mode mode)
 {
diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index 2a29da442a8e..e00d22b175ec 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -472,4 +472,4 @@ static void __init jz4770_cgu_init(struct device_node *np)
 }
 
 /* We only probe via devicetree, no need for a platform driver */
-CLK_OF_DECLARE(jz4770_cgu, "ingenic,jz4770-cgu", jz4770_cgu_init);
+CLK_OF_DECLARE_DRIVER(jz4770_cgu, "ingenic,jz4770-cgu", jz4770_cgu_init);
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 2464fc4032af..f964c4aa6cac 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -722,4 +722,4 @@ static void __init jz4780_cgu_init(struct device_node *np)
 		return;
 	}
 }
-CLK_OF_DECLARE(jz4780_cgu, "ingenic,jz4780-cgu", jz4780_cgu_init);
+CLK_OF_DECLARE_DRIVER(jz4780_cgu, "ingenic,jz4780-cgu", jz4780_cgu_init);
-- 
2.21.0.593.g511ec345e18

