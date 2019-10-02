Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1925DC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4650206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wl8pAqxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfJBQZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:25:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37165 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfJBQZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:25:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id i1so20411177wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/QUXmHdm9DT+DpI2JHLYwXEFgCyNsBxIYS9RvtuK78=;
        b=wl8pAqxoH7Xx5OAnjVcLMMcVwibOM/IvkSC94fzjorJ4B3vseoSQGYu0parhimLa55
         A0PuKmh0XvzYiW/PH3oXM56spuDbvofLhLuS4dbmVhx4AdDJ4/lyEaf6BzlToz/ETKhf
         pCtAs5EiI4JTWBFSdB33cWFYonT68WH5vS3a0ejiqMt+pVFJsY7t5ays/N7A96t+XAwP
         zv8fledYpTEXlADBEMueKWcjoFTc57/oh8aIVfdMMvqoZkUkH/UGVFu1LXf2dR7Qhj1M
         vxeqIjyzEYRUqYGGrNHtbSoeZeIvv3LTx+eS32KQJXDkgyjuMertdYBJC6Mg38InEEAe
         KGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/QUXmHdm9DT+DpI2JHLYwXEFgCyNsBxIYS9RvtuK78=;
        b=hu8rWrMWg4T1vPEQEisUNFvdi2cgwmytlXyTfkT/uq8uiNc1xJ1pRBkkocBh0a9R+x
         JIjnxZKpaunUXy7zhef/bOPxMFXNOXGODit9lAYW+7L0Bv5x47wp6ckANwXKFDRzT+pt
         PS49CWnbBNk2hfqABEN7iZJGwUF4f3sM2NFNIHmjvWknwhej0qy22Pla21ndRMLmRZFm
         UFD8Q/bUoWSs7KnRuyPuWcCitwFnRB0FEpGWQBMCQ1/tOUE4W2a2vrFSDQjUZfDJ8NrU
         UszIQHBTq/AGpNcLHXWNmfi79rSW4Aly1ErqMe3XIrEPmMUDATq7G3YcoJ/ifuLFRAx1
         wdvg==
X-Gm-Message-State: APjAAAUZ5lbSBuVcWdJSEXKAqs7PX83HgAGSkSV8liXL7od0MjEU9542
        LTtttvSbGy6Pjzf6zTIXbiiJ1g==
X-Google-Smtp-Source: APXvYqxGsPDOioHBzCv+eGZAAjmSO1/M4o23eUqwwd1tIWQbnQHRWKn4DqnnzmfWMrjx42tyjxOC9g==
X-Received: by 2002:a5d:52cd:: with SMTP id r13mr3301523wrv.376.1570033544143;
        Wed, 02 Oct 2019 09:25:44 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id w9sm3482067wrt.62.2019.10.02.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 09:25:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 4/5] drivers: platform: provide devm_platform_ioremap_resource_wc()
Date:   Wed,  2 Oct 2019 18:25:33 +0200
Message-Id: <20191002162534.3967-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002162534.3967-1-brgl@bgdev.pl>
References: <20191002162534.3967-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide a write-combined variant of devm_platform_ioremap_resource().

While at it: in order not to duplicate code - pass the resource
retrieved by platform_get_resource() directly to the appropriate
devm_ioremap_resource() variant.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/platform.c                       | 27 +++++++++++++++----
 include/linux/platform_device.h               |  3 +++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index e605bb9df6e1..480b78ca3871 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -318,6 +318,7 @@ IOMAP
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
   devm_ioremap_resource_wc()
   devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
+  devm_platform_ioremap_resource_wc()
   devm_iounmap()
   pcim_iomap()
   pcim_iomap_regions()	: do request_region() and iomap() on multiple BARs
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b6c6c7d97d5b..8fdf3eb23bda 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -60,6 +60,7 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
+#ifdef CONFIG_HAS_IOMEM
 /**
  * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
  *				    device
@@ -68,16 +69,32 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
  *        resource management
  * @index: resource index
  */
-#ifdef CONFIG_HAS_IOMEM
 void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 					     unsigned int index)
 {
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
-	return devm_ioremap_resource(&pdev->dev, res);
+	return devm_ioremap_resource(&pdev->dev,
+				     platform_get_resource(pdev,
+							   IORESOURCE_MEM,
+							   index));
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
+
+/**
+ * devm_platform_ioremap_resource_wc - write-combined variant of
+ *                                     devm_platform_ioremap_resource()
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource management
+ * @index: resource index
+ */
+void __iomem *devm_platform_ioremap_resource_wc(struct platform_device *pdev,
+						unsigned int index)
+{
+	return devm_ioremap_resource_wc(&pdev->dev,
+					platform_get_resource(pdev,
+							      IORESOURCE_MEM,
+							      index));
+}
 #endif /* CONFIG_HAS_IOMEM */
 
 static int __platform_get_irq(struct platform_device *dev, unsigned int num)
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 1b5cec067533..83930790c701 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -57,6 +57,9 @@ platform_find_device_by_driver(struct device *start,
 extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
+extern void __iomem *
+devm_platform_ioremap_resource_wc(struct platform_device *pdev,
+				  unsigned int index);
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_get_irq_optional(struct platform_device *, unsigned int);
 extern int platform_irq_count(struct platform_device *);
-- 
2.23.0

