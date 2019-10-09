Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A97DC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD7020673
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfJIJjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:39:21 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:45520 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfJIJjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:39:21 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 48CE07E9236; Wed,  9 Oct 2019 11:39:18 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: simplify definitions of platform_get_irq*
Date:   Wed,  9 Oct 2019 11:37:46 +0200
Message-Id: <20191009093746.12095-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190828083411.2496-1-thierry.reding@gmail.com>
References: <20190828083411.2496-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq_optional is just a wrapper for __platform_get_irq. So
rename __platform_get_irq to platform_get_irq_optional and drop
platform_get_irq_optional's previous implementation. This way there is
one function and one indirection less without loss of functionality.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/base/platform.c | 47 ++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b6c6c7d97d5b..60ff536b46f1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -80,7 +80,24 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
 #endif /* CONFIG_HAS_IOMEM */
 
-static int __platform_get_irq(struct platform_device *dev, unsigned int num)
+/**
+ * platform_get_irq_optional - get an optional IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ *
+ * Gets an IRQ for a platform device. Device drivers should check the return
+ * value for errors so as to not pass a negative integer value to the
+ * request_irq() APIs. This is the same as platform_get_irq(), except that it
+ * does not print an error message if an IRQ can not be obtained.
+ *
+ * Example:
+ *		int irq = platform_get_irq_optional(pdev, 0);
+ *		if (irq < 0)
+ *			return irq;
+ *
+ * Return: IRQ number on success, negative error number on failure.
+ */
+int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
 {
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
@@ -144,6 +161,7 @@ static int __platform_get_irq(struct platform_device *dev, unsigned int num)
 	return -ENXIO;
 #endif
 }
+EXPORT_SYMBOL_GPL(platform_get_irq_optional);
 
 /**
  * platform_get_irq - get an IRQ for a device
@@ -165,7 +183,7 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 {
 	int ret;
 
-	ret = __platform_get_irq(dev, num);
+	ret = platform_get_irq_optional(dev, num);
 	if (ret < 0 && ret != -EPROBE_DEFER)
 		dev_err(&dev->dev, "IRQ index %u not found\n", num);
 
@@ -173,29 +191,6 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
-/**
- * platform_get_irq_optional - get an optional IRQ for a device
- * @dev: platform device
- * @num: IRQ number index
- *
- * Gets an IRQ for a platform device. Device drivers should check the return
- * value for errors so as to not pass a negative integer value to the
- * request_irq() APIs. This is the same as platform_get_irq(), except that it
- * does not print an error message if an IRQ can not be obtained.
- *
- * Example:
- *		int irq = platform_get_irq_optional(pdev, 0);
- *		if (irq < 0)
- *			return irq;
- *
- * Return: IRQ number on success, negative error number on failure.
- */
-int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
-{
-	return __platform_get_irq(dev, num);
-}
-EXPORT_SYMBOL_GPL(platform_get_irq_optional);
-
 /**
  * platform_irq_count - Count the number of IRQs a platform device uses
  * @dev: platform device
@@ -206,7 +201,7 @@ int platform_irq_count(struct platform_device *dev)
 {
 	int ret, nr = 0;
 
-	while ((ret = __platform_get_irq(dev, nr)) >= 0)
+	while ((ret = platform_get_irq_optional(dev, nr)) >= 0)
 		nr++;
 
 	if (ret == -EPROBE_DEFER)
-- 
2.23.0

