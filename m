Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51F2C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0B921743
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="rTHyDJ7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfHJMgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 08:36:39 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55526 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfHJMgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565440596; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=BEr5l4JPOZyPmVVF/LZABMpxhGWMLaTgTctoWoKASFs=;
        b=rTHyDJ7qGIsSXSF8NuJvA2RDAnWouonN8GllsfKG9Rgv5Rvo7iLvFJawUeFaiMrw9xEKOj
        0GZ29pNQvb2Pc7JwZfJIeOO1Hvl1qdTmeZkKwCEY0fePe3Rv870wjWVDe9utwEXqJJD30O
        xDsqyCQRY36yu7xcnu2r2FZ32B6yG7k=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2] clk: ingenic: Use CLK_OF_DECLARE_DRIVER macro
Date:   Sat, 10 Aug 2019 14:36:20 +0200
Message-Id: <20190810123620.27238-1-paul@crapouillou.net>
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

Notes:
    v2: Rebased on v5.3-rc3

 drivers/clk/ingenic/jz4725b-cgu.c | 2 +-
 drivers/clk/ingenic/jz4740-cgu.c  | 2 +-
 drivers/clk/ingenic/jz4770-cgu.c  | 2 +-
 drivers/clk/ingenic/jz4780-cgu.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 2642d36d1e2c..a3b4635f6278 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -257,4 +257,4 @@ static void __init jz4725b_cgu_init(struct device_node *np)
 
 	ingenic_cgu_register_syscore_ops(cgu);
 }
-CLK_OF_DECLARE(jz4725b_cgu, "ingenic,jz4725b-cgu", jz4725b_cgu_init);
+CLK_OF_DECLARE_DRIVER(jz4725b_cgu, "ingenic,jz4725b-cgu", jz4725b_cgu_init);
diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 4c0a20949c2c..dd86296fb8c1 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -241,4 +241,4 @@ static void __init jz4740_cgu_init(struct device_node *np)
 
 	ingenic_cgu_register_syscore_ops(cgu);
 }
-CLK_OF_DECLARE(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);
+CLK_OF_DECLARE_DRIVER(jz4740_cgu, "ingenic,jz4740-cgu", jz4740_cgu_init);
diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index eebc1bea3841..956dd653a43d 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -443,4 +443,4 @@ static void __init jz4770_cgu_init(struct device_node *np)
 }
 
 /* We only probe via devicetree, no need for a platform driver */
-CLK_OF_DECLARE(jz4770_cgu, "ingenic,jz4770-cgu", jz4770_cgu_init);
+CLK_OF_DECLARE_DRIVER(jz4770_cgu, "ingenic,jz4770-cgu", jz4770_cgu_init);
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 8c67f89df25e..ea905ff72bf0 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -725,4 +725,4 @@ static void __init jz4780_cgu_init(struct device_node *np)
 
 	ingenic_cgu_register_syscore_ops(cgu);
 }
-CLK_OF_DECLARE(jz4780_cgu, "ingenic,jz4780-cgu", jz4780_cgu_init);
+CLK_OF_DECLARE_DRIVER(jz4780_cgu, "ingenic,jz4780-cgu", jz4780_cgu_init);
-- 
2.21.0.593.g511ec345e18

