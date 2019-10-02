Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2A1C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DFB222BE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Ay0ZPUGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfJBQZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:25:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34738 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfJBQZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:25:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so20426547wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Td3fuKxaZXUNRUL4lHP0H/YwhwCuhVUYKfFBUtY39ao=;
        b=Ay0ZPUGU4ZMuvmp9AyeuEwZTd3EVG77yxr4isL6WCseFvl5N8rSYOs9PbBjgrpAn/O
         DaiC1gg/PpSLu3QGHHvMRWorvxWLg+ZDdZpN3/u6+5c23deK3BOqWmMXNl8TgOs9Njct
         bNubYsbtdLra8byI1N9hZzwz9NrJQZnoU46GANhZZYBf5FyfFSkJEYIiSxVh6qjm+nW9
         g0bInSX21U/YnQxiXzrvJgBf9B4B6p1O/0J6QdjA5wDRGFSVTDhzG2L9BZPg3Hm0PuMl
         nXjou1VnEvFGjQmK8xOyAGYl3NejzLv7WuLXRNg8jUZn4QQezxI9HDQOtDGV+Ld28Izo
         Fe7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Td3fuKxaZXUNRUL4lHP0H/YwhwCuhVUYKfFBUtY39ao=;
        b=qYv6OuR2h1gyRECcP26isXL2iojBj3pPGOuq3VSyqGoALSTtigFpFs8erBQA7YbAhw
         UERUQBM78dQBM8ANsNgBvqjR4OcccT6DcVAv2l4pDKqMh8kHgBiah+4S3/71aZSwqFB8
         OXJoAcvw29+FRUdTyJpBTsyGtl71mjj5rh490K3uY2jV6f1nsIaqFN5ysehWW1haZLZI
         2k9iwv07mXhCwBiWNCCJb6cSi7ngQujARdu8wywnzmTB/AICOzFCp3K9LZpcGGFPkdB9
         s5iAmrxSKKDjYwq2faTd8mPmf6jllDjBqxdktLJ4Kl3eHKQkALS1Nuw5h3/6ZqJXQPuz
         VVQw==
X-Gm-Message-State: APjAAAXVvVDim1RddeeDn/mnxMvQ/YhyQ5kSMQONyuvhYYjg7WHvJ5Bw
        0/iFh0haR2/9XbHl2O0sT2wb2A==
X-Google-Smtp-Source: APXvYqx6Nn0iW9tzH/XcC+9LObbv1X3qcSHbAAR/1v/u4exu00qknLkpqXwAY+tpNzIaNSaDS+1+Vg==
X-Received: by 2002:a5d:4985:: with SMTP id r5mr3093803wrq.139.1570033541315;
        Wed, 02 Oct 2019 09:25:41 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id w9sm3482067wrt.62.2019.10.02.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 09:25:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/5] lib: devres: prepare devm_ioremap_resource() for more variants
Date:   Wed,  2 Oct 2019 18:25:31 +0200
Message-Id: <20191002162534.3967-3-brgl@bgdev.pl>
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

We want to add the write-combined variant of devm_ioremap_resource().
Let's first implement __devm_ioremap_resource() which takes
an additional argument type. The types are the same as for
__devm_ioremap(). The existing devm_ioremap_resource() now simply
calls __devm_ioremap_resource() with regular DEVM_IOREMAP type.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 lib/devres.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index 6a0e9bd6524a..a14c727128c1 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -114,25 +114,9 @@ void devm_iounmap(struct device *dev, void __iomem *addr)
 }
 EXPORT_SYMBOL(devm_iounmap);
 
-/**
- * devm_ioremap_resource() - check, request region, and ioremap resource
- * @dev: generic device to handle the resource for
- * @res: resource to be handled
- *
- * Checks that a resource is a valid memory region, requests the memory
- * region and ioremaps it. All operations are managed and will be undone
- * on driver detach.
- *
- * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
- * on failure. Usage example:
- *
- *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
- *	base = devm_ioremap_resource(&pdev->dev, res);
- *	if (IS_ERR(base))
- *		return PTR_ERR(base);
- */
-void __iomem *devm_ioremap_resource(struct device *dev,
-				    const struct resource *res)
+static void __iomem *
+__devm_ioremap_resource(struct device *dev, const struct resource *res,
+			enum devm_ioremap_type type)
 {
 	resource_size_t size;
 	void __iomem *dest_ptr;
@@ -151,7 +135,7 @@ void __iomem *devm_ioremap_resource(struct device *dev,
 		return IOMEM_ERR_PTR(-EBUSY);
 	}
 
-	dest_ptr = devm_ioremap(dev, res->start, size);
+	dest_ptr = __devm_ioremap(dev, res->start, size, type);
 	if (!dest_ptr) {
 		dev_err(dev, "ioremap failed for resource %pR\n", res);
 		devm_release_mem_region(dev, res->start, size);
@@ -160,6 +144,29 @@ void __iomem *devm_ioremap_resource(struct device *dev,
 
 	return dest_ptr;
 }
+
+/**
+ * devm_ioremap_resource() - check, request region, and ioremap resource
+ * @dev: generic device to handle the resource for
+ * @res: resource to be handled
+ *
+ * Checks that a resource is a valid memory region, requests the memory
+ * region and ioremaps it. All operations are managed and will be undone
+ * on driver detach.
+ *
+ * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure. Usage example:
+ *
+ *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+ *	base = devm_ioremap_resource(&pdev->dev, res);
+ *	if (IS_ERR(base))
+ *		return PTR_ERR(base);
+ */
+void __iomem *devm_ioremap_resource(struct device *dev,
+				    const struct resource *res)
+{
+	return __devm_ioremap_resource(dev, res, DEVM_IOREMAP);
+}
 EXPORT_SYMBOL(devm_ioremap_resource);
 
 /*
-- 
2.23.0

