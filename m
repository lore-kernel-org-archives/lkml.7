Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD39320679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rcX6hmuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbfJVInb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:43:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46478 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388530AbfJVIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:43:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so6232527wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJJSojrxXdOtbucyV3DkzPFZIOLxdDReHk1T4+sRr4o=;
        b=rcX6hmuzm5jG5P1203qFyfAYA6TgsZ+s1aPTDCnCDxTzxs+nC/HKZAJCRbSpSL8IrM
         b7W2zeXAs2zBVVXcR8WEjIfaNdrd1bgkW1G1FMW1VjdWMPkuMwHEh3Dwk4rMxIPdO7V3
         UomhROYXddDsqve9wPNR7SmcrgoNXRdz8te+Q3LjGPfr1pwTwnpb5PrvYSGPtN8IAmlP
         zugc/07P+8jIJv2y5vzaPiy7dF1qRASKOKs6wWVvaJDg2yroY+AJ+5LyBAeUdANq6f3v
         XBTnVf9H832GAVGCYdW9uk9NdcZmkrOzQua96uljULpBFs3EVwpklKpSBuqmO953qgc2
         MOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJJSojrxXdOtbucyV3DkzPFZIOLxdDReHk1T4+sRr4o=;
        b=ET0Q8GuYHYlWBcbLYDH9NZE8R1OL6dfF1hLwp+738hzPGBr+Y++3zFUHPNAnoR412G
         /ul++uBtBxqLSNUOagUdOaOxI8OWkZs/W9Rhqi14tpvhCvcLDGXtrF+u45VlI/wBvXXE
         jc+eacCymad+NIFwkymrlgeqzOUkb5T4n9FN7q3FtR9s8dniwgJr06jMuuzeV3WVSxYI
         NwiYWF/bLMzw7LFgk5cVXEBJct4TGK0fWMR2ZX482cT5kJn5ZDIvtXdMmTZ4IdM3Sbnp
         0jhAcHhiBgx+RVnA3j6elVuDcdraha/2wQsKBIHb3jo6ZWrcx74AWfYYLCxF6VJmuVle
         RJUA==
X-Gm-Message-State: APjAAAVYSKWYODOEt/wPhKumDhCwM0P8QH5nM7QoPU3trs5LX0qBKoB5
        0I1PgZvVUW0kGYKsdtvMoGT7/Q==
X-Google-Smtp-Source: APXvYqxgpYoVLaj4PTRXGjR1tlAqQAUXu+5mgDnZ2dar9WhHzkR2S8ZBrtURUVmCfyd8eleOg3kdnw==
X-Received: by 2002:adf:c98b:: with SMTP id f11mr2505711wrh.274.1571733805339;
        Tue, 22 Oct 2019 01:43:25 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id q25sm477231wra.3.2019.10.22.01.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:43:24 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v3 2/8] lib: devres: prepare devm_ioremap_resource() for more variants
Date:   Tue, 22 Oct 2019 10:43:12 +0200
Message-Id: <20191022084318.22256-3-brgl@bgdev.pl>
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

We want to add the write-combined variant of devm_ioremap_resource().
Let's first implement __devm_ioremap_resource() which takes
an additional argument type. The types are the same as for
__devm_ioremap(). The existing devm_ioremap_resource() now simply
calls __devm_ioremap_resource() with regular DEVM_IOREMAP type.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
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

