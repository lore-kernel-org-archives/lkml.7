Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AEEC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F162133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="fdNdUy/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbfFGQCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:02:48 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38078 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729965AbfFGQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559923363; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVwrMcOcSydsdoB2Vv8m9KiILY45YMjy1Ki46blBbCg=;
        b=fdNdUy/Y1risixnQhQvkBHePcQaIwgehM6qcOgDx1M2IwZdalgo6yQHnBIY+L6xpYqX4R5
        b/yRV+3CRlark93gHlvidve0mEKWEPLb095TBxRda7LfRj0WDxIk7QKfYkjDyaY9N60LH/
        lq9/Hduqj21qiSlmQj+Kd2a2s9DO9OQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     od@zcrc.me, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] mtd/rawnand: ingenic-nand: Make probe function __init_or_module
Date:   Fri,  7 Jun 2019 18:02:00 +0200
Message-Id: <20190607160200.16052-2-paul@crapouillou.net>
In-Reply-To: <20190607160200.16052-1-paul@crapouillou.net>
References: <20190607160200.16052-1-paul@crapouillou.net>
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
 drivers/mtd/nand/raw/ingenic/ingenic_nand.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
index d7b7c0f13909..b7f2facb4b37 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
@@ -302,7 +302,7 @@ static const struct nand_controller_ops ingenic_nand_controller_ops = {
 	.attach_chip = ingenic_nand_attach_chip,
 };
 
-static int ingenic_nand_init_chip(struct platform_device *pdev,
+static int __init_or_module ingenic_nand_init_chip(struct platform_device *pdev,
 				  struct ingenic_nfc *nfc,
 				  struct device_node *np,
 				  unsigned int chipnr)
@@ -399,7 +399,7 @@ static void ingenic_nand_cleanup_chips(struct ingenic_nfc *nfc)
 	}
 }
 
-static int ingenic_nand_init_chips(struct ingenic_nfc *nfc,
+static int __init_or_module ingenic_nand_init_chips(struct ingenic_nfc *nfc,
 				   struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -427,7 +427,7 @@ static int ingenic_nand_init_chips(struct ingenic_nfc *nfc,
 	return 0;
 }
 
-static int ingenic_nand_probe(struct platform_device *pdev)
+static int __init_or_module ingenic_nand_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	unsigned int num_banks;
@@ -473,7 +473,7 @@ static int ingenic_nand_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ingenic_nand_remove(struct platform_device *pdev)
+static int __exit ingenic_nand_remove(struct platform_device *pdev)
 {
 	struct ingenic_nfc *nfc = platform_get_drvdata(pdev);
 
-- 
2.21.0.593.g511ec345e18

