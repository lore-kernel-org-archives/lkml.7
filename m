Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4E9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C30520652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U47CDhuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfLJUb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:31:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34333 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfLJUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:31:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so9450157pgf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AXdgRPOupq8mpOVW9fDaoE7i0os1nP349i6MmUYJbLw=;
        b=U47CDhuz0r/IRPYg0nOXL/3oQEygnoHNuYbU416HhjOKsXQBiAh+ym1mFxz/CLQKm5
         PAVLw4SDABvaWmZ6bDTz999xnkwov7EtfUtskkLSFlFlTOTXZ48HnONY5r+XacqxAKbd
         e4orxhyQU+VQR1rtMO9s9kf40rm/F46gVN2XfWisUUBCx5FZAv2/cKL9APa/XGbuMcLj
         YrBY7CV0GV3tSsguNm5eZkG6axi5HxyKGuXGYLQtKtZxVp4Hx/n7cWGME6g5Zwul9k3A
         zU0r7xiXBLYg6HK48jJ/YaRswjyf0ppp2QCqkioiri5++NRLEcL34BqwDMkr+uoLZ7GT
         AM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AXdgRPOupq8mpOVW9fDaoE7i0os1nP349i6MmUYJbLw=;
        b=Uz+4+G54Zov7uFEThAMpoJCeQVbJubwvzQCLr7wf5jZghEvb1+5AAAK3v9OX6S4SZX
         qUhWrI4jpOjAmFw38oVMQSjTrbLikHu73CI2ucdlZL5f846/RyOxTKU+Hoq1o8sodukW
         M7uIdLVhNZ7/AAOvIIIPkydnDtGfcsXPP+LxWbu3KM0PaTPqzuyBt+us8eCWLr7jHu2/
         5FBu62ShNtjasQfNPyykLuo63XGfyobSn3/9TJdX1UNbp/WkO2zUZLx6VOhZU26WQXYu
         SwGUZ0pov/qdFdaOO8eMEJokJHan7/aU6z8Je0Xl0fkHflrZ79oVVLqTvb1l0bNMavwh
         8bCA==
X-Gm-Message-State: APjAAAVPaUWXqDVRZm0i8SQe3vs2lEIbQtVquGW1700l7Ea7v3Eb32GQ
        Jaeq1dA4Qa7Rvo7KK+/qPEw=
X-Google-Smtp-Source: APXvYqxPRg90G2e3ms8KufWeN+ZC2r3Ex2vY+OO9rQ98PC7ykiMNV67F2VhmRn+uvjDiPQaOrmxL8A==
X-Received: by 2002:aa7:8b55:: with SMTP id i21mr37408207pfd.249.1576009916862;
        Tue, 10 Dec 2019 12:31:56 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id b21sm4604086pfp.0.2019.12.10.12.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 12:31:56 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        srinivas.kandagatla@linaro.org, vz@mleia.com, khilman@baylibre.com,
        mripard@kernel.org, wens@csie.org,
        andriy.shevchenko@linux.intel.com, mchehab+samsung@kernel.org,
        mans@mansr.com, treding@nvidia.com, suzuki.poulose@arm.com,
        bgolaszewski@baylibre.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] drivers: add devm_platform_ioremap_resource_byname() helper
Date:   Tue, 10 Dec 2019 20:31:45 +0000
Message-Id: <20191210203149.7115-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently 300+ instances of using platform_get_resource_byname()
and devm_ioremap_resource() together in the kernel tree.

This patch wraps these two calls in a single helper.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/platform.c         | 22 +++++++++++++++++++++-
 include/linux/platform_device.h |  3 +++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b6c6c7d97d5b..9c4f5e229600 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -60,6 +60,7 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
+#ifdef CONFIG_HAS_IOMEM
 /**
  * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
  *				    device
@@ -68,7 +69,7 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
  *        resource management
  * @index: resource index
  */
-#ifdef CONFIG_HAS_IOMEM
+
 void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 					     unsigned int index)
 {
@@ -78,6 +79,25 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 	return devm_ioremap_resource(&pdev->dev, res);
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
+
+/**
+ * devm_platform_ioremap_resource_byname - call devm_ioremap_resource() for
+ *					   a platform device
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource managemend
+ * @name: resource name
+ */
+void __iomem *
+devm_platform_ioremap_resource_byname(struct platform_device *pdev,
+				      const char *name)
+{
+	struct resource *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	return devm_ioremap_resource(&pdev->dev, res);
+}
+EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
 #endif /* CONFIG_HAS_IOMEM */
 
 static int __platform_get_irq(struct platform_device *dev, unsigned int num)
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 1b5cec067533..24ff5da9c532 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -63,6 +63,9 @@ extern int platform_irq_count(struct platform_device *);
 extern struct resource *platform_get_resource_byname(struct platform_device *,
 						     unsigned int,
 						     const char *);
+extern void __iomem *
+devm_platform_ioremap_resource_byname(struct platform_device *pdev,
+				      const char *name);
 extern int platform_get_irq_byname(struct platform_device *, const char *);
 extern int platform_add_devices(struct platform_device **, int);
 
-- 
2.17.1

