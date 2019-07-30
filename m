Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84921C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0DE20882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZR/Bh3PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfG3Fiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:38:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44268 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfG3Fit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:38:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so29432732pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 22:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p9fzvw+F1Ng+FQ2leFNUgxIDXf1pawYejl2LIvV90xg=;
        b=ZR/Bh3PEHfdglcBtXBpQHJ11dVkJlmkjyI0tfU6RX5q89AlydhhM2AElFQKH7tYVNO
         VL5blMaTyTK+8K2o+aFxYnOmpZpZfLBCk4xPjXWuvK0j66GlDM6nklEnggcJ8FE6gLhJ
         /SB4W/i/mm56nn7+pY+4Oodccjx6kkdSqAQl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p9fzvw+F1Ng+FQ2leFNUgxIDXf1pawYejl2LIvV90xg=;
        b=PDhyB7ld2hEQwly0zb0+uLvHFCHGKgxd27Vvo64ojSr1GVGyDyofMZetpnGAV2RoIB
         BUUWG1msaFNvdmS45ONmGp9F+ep0xEYo4GfLbMNsYS1FEk6FRQrxkWp1ZOupe1lNhSJ7
         J7z6YdcMUdSVNpUAUxGSZ55nrlX5RN8r3z3PH0nIZnUDBeZzV8qOC8hYiqcUW9/Xd4pS
         fWlQJb8gNVBrS/+ZjPgSEVLn6bcR/+d9Sr1JlL3CKbrq4Ppmg1EEv579vfgE5AWJ1wu1
         ot1g4/Z2BD189LfMkxw1CRX+i4swV3sKK3UAQxIWSCc2hMQ+JqtQTo29PXDVYAnwcjZY
         znRA==
X-Gm-Message-State: APjAAAUgELoBHVll87yJqdKRSwDAFv6amhJV+tlWaiyI9+TornYOGMaO
        MqH3PrBdbd8j+T9MRN+ZtzQPUg==
X-Google-Smtp-Source: APXvYqxAOi8Z/HuH63JWJitL36lo1T06HLC3K3Y3ZjxIexQxpZEYpO+ZQWEV2B6CNSbYi49PGA00nA==
X-Received: by 2002:a17:90a:ad89:: with SMTP id s9mr116562997pjq.41.1564465128380;
        Mon, 29 Jul 2019 22:38:48 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r1sm59306805pgv.70.2019.07.29.22.38.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 22:38:47 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 1/3] driver core: platform: Add an error message to platform_get_irq*()
Date:   Mon, 29 Jul 2019 22:38:43 -0700
Message-Id: <20190730053845.126834-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730053845.126834-1-swboyd@chromium.org>
References: <20190730053845.126834-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A grep of the kernel shows that many drivers print an error message if
they fail to get the irq they're looking for. Furthermore, those drivers
all decide to print the device name, or not, and the irq they were
requesting, or not, etc. Let's consolidate all these error messages into
the API itself, allowing us to get rid of the error messages in each
driver.

Cc: Rob Herring <robh@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/platform.c | 42 +++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 506a0175a5a7..55ecc3edf8a1 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -99,12 +99,7 @@ void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
 #endif /* CONFIG_HAS_IOMEM */
 
-/**
- * platform_get_irq - get an IRQ for a device
- * @dev: platform device
- * @num: IRQ number index
- */
-int platform_get_irq(struct platform_device *dev, unsigned int num)
+static int __platform_get_irq(struct platform_device *dev, unsigned int num)
 {
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
@@ -163,6 +158,33 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	return -ENXIO;
 #endif
 }
+
+/**
+ * platform_get_irq - get an IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ *
+ * Gets an IRQ for a platform device and prints an error message if finding the
+ * IRQ fails. Device drivers should check the return value for errors so as to
+ * not pass a negative integer value to the request_irq() APIs.
+ *
+ * Example:
+ *		int irq = platform_get_irq(pdev, 0);
+ *		if (irq < 0)
+ *			return irq;
+ *
+ * Return: IRQ number on success, negative error number on failure.
+ */
+int platform_get_irq(struct platform_device *dev, unsigned int num)
+{
+	int ret;
+
+	ret = __platform_get_irq(dev, num);
+	if (ret < 0 && ret != -EPROBE_DEFER)
+		dev_err(&dev->dev, "IRQ index %u not found\n", num);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
 /**
@@ -175,7 +197,7 @@ int platform_irq_count(struct platform_device *dev)
 {
 	int ret, nr = 0;
 
-	while ((ret = platform_get_irq(dev, nr)) >= 0)
+	while ((ret = __platform_get_irq(dev, nr)) >= 0)
 		nr++;
 
 	if (ret == -EPROBE_DEFER)
@@ -228,7 +250,11 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
 	}
 
 	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
+
+	dev_err(&dev->dev, "IRQ %s not found\n", name);
+	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(platform_get_irq_byname);
 
-- 
Sent by a computer through tubes

