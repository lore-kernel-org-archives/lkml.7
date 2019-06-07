Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F98C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955A320657
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ijs4Q/Ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfFGQCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:02:44 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38038 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbfFGQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559923362; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=zrjX+l5PeyKLlwgC655C0foBZhkNjJeOz8J5di0UnrI=;
        b=ijs4Q/Ek+i8vGOKkh0aUWY6sygKgckbDWaGyu7zHlO7vNHemPqLSYE7UvCs6JsJP2RVaH/
        XUiGLr99rSFwnkxgWzAcqgvS40xifWm7X/rBss1JEPa9styFktxNMbyoO0xwfnvPoYefVc
        KprUyBUI/K80kbW8NYHrIT74ByUv2UQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     od@zcrc.me, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/2] mtd/rawnand: ingenic-ecc: Make probe function __init_or_module
Date:   Fri,  7 Jun 2019 18:01:59 +0200
Message-Id: <20190607160200.16052-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 2 +-
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h | 3 ++-
 drivers/mtd/nand/raw/ingenic/jz4780_bch.c  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
index d3e085c5685a..74eff8fb5d32 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
@@ -124,7 +124,7 @@ void ingenic_ecc_release(struct ingenic_ecc *ecc)
 }
 EXPORT_SYMBOL(ingenic_ecc_release);
 
-int ingenic_ecc_probe(struct platform_device *pdev)
+int __init_or_module ingenic_ecc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ingenic_ecc *ecc;
diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
index 2cda439b5e11..535eb8f29df6 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
@@ -4,6 +4,7 @@
 
 #include <linux/compiler_types.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 #include <uapi/asm-generic/errno-base.h>
@@ -78,6 +79,6 @@ struct ingenic_ecc {
 	struct mutex lock;
 };
 
-int ingenic_ecc_probe(struct platform_device *pdev);
+int __init_or_module ingenic_ecc_probe(struct platform_device *pdev);
 
 #endif /* __DRIVERS_MTD_NAND_INGENIC_ECC_INTERNAL_H__ */
diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
index 079266a0d6cf..cc0656ac505d 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
@@ -229,7 +229,7 @@ static int jz4780_correct(struct ingenic_ecc *bch,
 	return ret;
 }
 
-static int jz4780_bch_probe(struct platform_device *pdev)
+static int __init_or_module jz4780_bch_probe(struct platform_device *pdev)
 {
 	struct ingenic_ecc *bch;
 	int ret;
-- 
2.21.0.593.g511ec345e18

