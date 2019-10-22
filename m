Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC4ECA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C95D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DZOLMbbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbfJVInc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:43:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52018 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388522AbfJVInb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:43:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id q70so9002632wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZPH7ezKf53/QBMw5BxZ096M4gSklQo/Sa/IUAzrHtk=;
        b=DZOLMbbWoSzuUITLHQgA1LWlfomVlIuZYFkL4f0ogePF721BvXMWzLC2KLDfCOSMQX
         07qFmvF+kn0YAlG6RYk54w1luE8PD5W0RYri3EiHp5bTYkyVhJ/Q7Jkj/wKdw4aThGAC
         cmQcYzemSHsXxF3hRvUxQfcK5wUKBhs9k6nH5HzR52D4XagKAErSiPqZ/kD/hYgmKuUJ
         /3RoAMML78OadDGsiF8BJ5Ffme8j8U6folglUeM8rYqVDSOhqgHh3giHvm1gkMHYuV1x
         XOGkVfQVH2+2wD0Lt9k5UwwIO3hbpBNUy2t5KD9eib2RwqmJHf7wY6dAaNT+29bbBe/2
         wQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZPH7ezKf53/QBMw5BxZ096M4gSklQo/Sa/IUAzrHtk=;
        b=koI4gc2sFVD83+XIfB3+E+yqqZukoukwL6/bOm0rQV0Id+24ltU6ObU0fxXd5S7sl1
         A2MW5jyni7skYAqR52ecmHOh2uNIRmmeqUJsqxF7EMkqnLSFn86oSuxxCI3nHqbcjmGk
         iQa8ALdCETXhF8fYtOHn+YERK8G/wEQ8NKSPZmw8f67GuPZtYpsxA85PrEvarhvxRLRK
         mlWxgWZUBgszJa6clR/LN5PfE6Gt28cTeWXJ/okvbj0SfO5CixXHpY7jTLKj87GbYXjG
         D2IpKkGrtPHkmPMogA8HnSN5eJ2BBWjd86/ZotY0h3ftWXt6FjKSaSQYZI6d1O+5QVBG
         tupA==
X-Gm-Message-State: APjAAAUKKy+A63C57idP0IkEYaEtDFrJ67VFUd9w4Tju7v3j9Ogfn20P
        pXQtYC2dR1j3ufJg2dfFrjZ9eg==
X-Google-Smtp-Source: APXvYqypXQIXucGUA5pJLdWx/haak2b2SxfPC52Zaw+ESaa0qFsAO8OKx29Ka6dpUstCBehaWxg85w==
X-Received: by 2002:a1c:4e:: with SMTP id 75mr1981857wma.104.1571733809364;
        Tue, 22 Oct 2019 01:43:29 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id q25sm477231wra.3.2019.10.22.01.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:43:28 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v3 6/8] drivers: provide devm_platform_ioremap_resource_byname()
Date:   Tue, 22 Oct 2019 10:43:16 +0200
Message-Id: <20191022084318.22256-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191022084318.22256-1-brgl@bgdev.pl>
References: <20191022084318.22256-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide a variant of devm_platform_ioremap_resource() that allows to
lookup resources from platform devices by name rather than by index.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/platform.c                       | 20 +++++++++++++++++++
 include/linux/platform_device.h               |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 480b78ca3871..4ab193319d8c 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -319,6 +319,7 @@ IOMAP
   devm_ioremap_resource_wc()
   devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
   devm_platform_ioremap_resource_wc()
+  devm_platform_ioremap_resource_byname()
   devm_iounmap()
   pcim_iomap()
   pcim_iomap_regions()	: do request_region() and iomap() on multiple BARs
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 177010c27516..5cdd72a9e186 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -95,6 +95,26 @@ void __iomem *devm_platform_ioremap_resource_wc(struct platform_device *pdev,
 	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
 	return devm_ioremap_resource_wc(&pdev->dev, res);
 }
+
+/**
+ * devm_platform_ioremap_resource_byname - call devm_ioremap_resource for
+ *					   a platform device, retrieve the
+ *					   resource by name
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *	  resource management
+ * @name: name of the resource
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
index 74cecb919e5c..43fe441a98ea 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -60,6 +60,9 @@ devm_platform_ioremap_resource(struct platform_device *pdev,
 extern void __iomem *
 devm_platform_ioremap_resource_wc(struct platform_device *pdev,
 				  unsigned int index);
+extern void __iomem *
+devm_platform_ioremap_resource_byname(struct platform_device *pdev,
+				      const char *name);
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_get_irq_optional(struct platform_device *, unsigned int);
 extern int platform_irq_count(struct platform_device *);
-- 
2.23.0

