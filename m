Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D42C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8362133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfF1OQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:16:59 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37675 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfF1OQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:16:58 -0400
X-Originating-IP: 86.250.200.211
Received: from mc-bl-xps13.lan (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 56A001BF205;
        Fri, 28 Jun 2019 14:16:48 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        David Miller <davem@davemloft.net>, brian.brooks@linaro.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        nadavh@marvell.com, stefanc@marvell.com,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] driver core: platform: Allow using a dedicated dma_mask for platform_device
Date:   Fri, 28 Jun 2019 16:15:50 +0200
Message-Id: <20190628141550.22938-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch attempts to solve a long standing situation where
dev->dma_mask is a pointer to dev->dma_coherent_mask, meaning that any
change to the coherent mask will affect the streaming mask.

The API allows to use different values for both masks, but for now
platform_device built from DT will simply make the dma_mask point to the
coherent mask.

This is a problem on a least one driver, the PPv2 network driver, which
needs different streaming and coherent masks to overcome a HW
limitation. In this case, the issue is a performance degradation since
the streaming mask isn't as big as it ought to be, causing a lot of
buffer bounces.

There were previous attempts to fix this issue. One of them by Brian
Brooks, where the dma_mask is reallocated in the driver itself,
which wasn't considered to be the best approach :

https://lore.kernel.org/netdev/20180820024730.9147-1-brian.brooks@linaro.org/

This lead to a discussion pointing to another attempt to solve the issue,
by Christoph Hellwig :

https://lore.kernel.org/lkml/20180829062401.8701-2-hch@lst.de/

This more generic approach ended-up causing regressions on some mfd
drivers (the sm501 was one of the reports).

The current patch tries to be a bit less generic, and allows setting-up
the dma_mask for platform devices using a dedicated helper. In this case,
the dma_mask is allocated in struct platform_object, as suggested by
Russell King.

This helper is then used in platform_device creation code from the DT.

Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Hi everyone,

This patch, if suitable, would require a lot of testing to detect
drivers that rely on the streaming mask being the same as the coherent
mask.

Thanks,

Maxime

 drivers/base/platform.c         | 17 +++++++++++++++++
 drivers/of/platform.c           |  7 +++++--
 include/linux/platform_device.h |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4d1729853d1a..35e7bdb8576c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -256,9 +256,26 @@ EXPORT_SYMBOL_GPL(platform_add_devices);
 
 struct platform_object {
 	struct platform_device pdev;
+	u64 dma_mask;
 	char name[];
 };
 
+/**
+ * platform_device_setup_dma_mask - Sets the dma_mask pointer
+ * @pdev: platform device to configure the device's mask
+ *
+ * Sets the dma_mask of the underlying device to point to a dedicated region,
+ * that belongs to the platform_device.
+ */
+void platform_device_setup_dma_mask(struct platform_device *pdev)
+{
+	struct platform_object *pa = container_of(pdev, struct platform_object,
+						  pdev);
+
+	pa->pdev.dev.dma_mask = &pa->dma_mask;
+}
+EXPORT_SYMBOL_GPL(platform_device_setup_dma_mask);
+
 /**
  * platform_device_put - destroy a platform device
  * @pdev: platform device to free
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 04ad312fd85b..4a6980e3356c 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -186,8 +186,11 @@ static struct platform_device *of_platform_device_create_pdata(
 		goto err_clear_flag;
 
 	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	if (!dev->dev.dma_mask)
-		dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+	if (!dev->dev.dma_mask) {
+		platform_device_setup_dma_mask(dev);
+		*dev->dev.dma_mask = dev->dev.coherent_dma_mask;
+	}
+
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
 	of_msi_configure(&dev->dev, dev->dev.of_node);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index cc464850b71e..a95c2d224de9 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -181,6 +181,7 @@ extern int platform_device_add_properties(struct platform_device *pdev,
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
+extern void platform_device_setup_dma_mask(struct platform_device *pdev);
 
 struct platform_driver {
 	int (*probe)(struct platform_device *);
-- 
2.20.1

