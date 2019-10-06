Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F194FC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB0320867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jbQ1gKgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfJFFkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 01:40:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38485 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfJFFjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 01:39:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so6159682pgi.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 22:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRmxyW6c4jZvegWmtv0/j3K1hka1Pqi8q1i3mKVygkc=;
        b=jbQ1gKgw22F/1GI1mKx0szJ3PQBdnnyjYurbR0OfaON9d8MTsux6+RQzrdV1g1ngsA
         JxQuREcFPf2eVIEpysTTF69OVwqH1mq50Vz7gwzdfq+bgZGOcd8+gS4F5WyoIyJvO6E7
         nKkaBZWwcjVT7ebCd/9BWR7StPHfTefzxnMcl8B7kjzBkEjH5Ec/6l2xGROlqN0HGWTG
         iMmse4HIXHGZV2KmcB8rA+1Oce936OiXmTLVa3qOlKMFqqjKJGOrd12jen+qDD4Xn+Op
         GZVUBILALe9BVAmzsKWlvynkH+MYB9J7nRPt8NWYjGRZJeysylY70S6JN6Imwty4ZZbf
         GdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRmxyW6c4jZvegWmtv0/j3K1hka1Pqi8q1i3mKVygkc=;
        b=AQCoG5izR+ygthvyQcXhSLFUtY3+cNzlbLB2XCMnY1vHChfS+JhyajNvWFQqsYuSEA
         tr9rAXzO4bFsIuagTy6HqgjRby53BW8wpSsfbezoBRdPG4ijAjvTwG0C5tTPfiVVK0xF
         n2wGCcuokdSmrhgTeVBdtjRkPaaMZr7O4PPPJFCu6VHcqS9bIQ3kOx9UwaSAe/hJjzyh
         LtJnFSWvy/TIvidWyW4ldZ1wx3RJqKqDUytQKXv8qTYYfClKof1AG8wci8wPiqs67sAN
         7vWoHG1bNbxd7DibPgQEYpwhrqX2Pb+TIfCvEZssYOXPQEy6RoEADNZSXLSAu5H1+vaW
         Jmvg==
X-Gm-Message-State: APjAAAV7WFMN71J5JsEQTwhp74rF6ZyRGAN372UlBvEzDdMZTN6mnLjD
        d2iuWxqqxPCVGhBk6vA71p4ahg==
X-Google-Smtp-Source: APXvYqzhQDilSgm6A6fsKvUxBl3qxPj9N51TnqxqUIqRoYByrw7u0vp1taAL7bRHykgFi81mFKB2Kg==
X-Received: by 2002:a63:5652:: with SMTP id g18mr23396329pgm.283.1570340381619;
        Sat, 05 Oct 2019 22:39:41 -0700 (PDT)
Received: from debian-brgl.local (50-255-47-209-static.hfc.comcastbusiness.net. [50.255.47.209])
        by smtp.gmail.com with ESMTPSA id q30sm10019320pja.18.2019.10.05.22.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 22:39:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 4/8] drivers: platform: provide devm_platform_ioremap_resource_wc()
Date:   Sun,  6 Oct 2019 07:39:12 +0200
Message-Id: <20191006053916.8849-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006053916.8849-1-brgl@bgdev.pl>
References: <20191006053916.8849-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide a write-combined variant of devm_platform_ioremap_resource().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/platform.c                       | 19 ++++++++++++++++++-
 include/linux/platform_device.h               |  3 +++
 3 files changed, 22 insertions(+), 1 deletion(-)

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
index b6c6c7d97d5b..d481b8a7d4fc 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -60,6 +60,7 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
+#ifdef CONFIG_HAS_IOMEM
 /**
  * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
  *				    device
@@ -68,7 +69,6 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
  *        resource management
  * @index: resource index
  */
-#ifdef CONFIG_HAS_IOMEM
 void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 					     unsigned int index)
 {
@@ -78,6 +78,23 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 	return devm_ioremap_resource(&pdev->dev, res);
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
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	return devm_ioremap_resource_wc(&pdev->dev, res);
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

