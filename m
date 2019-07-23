Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6239C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70A720665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VW1GZfi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403774AbfGWSQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:16:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39316 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391283AbfGWSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:16:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so19815426pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KusoG9wwOCSjrYUKbVWPutl6P8kBIgNXIkH+8ESQrt0=;
        b=VW1GZfi4tsjyc/SjaZoCuQFWCfEcyVe7B0pCMj7pJskz/ayU39VxM1t/4dJYtHrdeQ
         o7wwC++6Pec5kGByKqPblpdgqoeNDqKlERQNFvxtkRhGEpvggiqfFUooD3X9kpZelkA5
         4IohPD5tCKO1uyL0XJdvxXoJCs+pdb6FAnQok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KusoG9wwOCSjrYUKbVWPutl6P8kBIgNXIkH+8ESQrt0=;
        b=WNWV+v+pxIYKNAZXC6oejzTo2kHS8jc4iebRlXkgWT9UHMVimhNgQAa1TFwE8LmsIR
         Rlsa3l3erXG6pNbey+xGVz16pq8QN92wKzFR0D3mDO191UV1tljwSU4/YcwiGwf/QrJp
         rk8G7l5N9FSaBUHhjwKeHq06f5V6UvSQkGBOK8heSzAG8YjxXIBVnq84JEFDjrGPw/Tb
         i7ueKYB3dc1vWSN/u0au7OD5B1AzqMaccXtqoJoU1lMPgLfRq/9wrO7E6w5tH4I1J1qG
         1OLBUeoQxpLe8yiySF0RGPWCZfOwvKZYsZkExIRcBGQ6I5GYpgTCrGZ5U3jaP7Xlj+uY
         Xdkw==
X-Gm-Message-State: APjAAAUWR9YDDTf9Ko+ZeyOGDDLeYrBgGbXtBXd1IDiOr5PEcNpd4b4h
        yh500gvvjBY3xTkStgvQ1nriXg==
X-Google-Smtp-Source: APXvYqyNtc9CVlVu8DZFyBegd4s9n1tx2rb7Z59PFW6Ge+WWsV4gxy+1eG6nGpgrSFmhQMeoOoH4Iw==
X-Received: by 2002:a62:754d:: with SMTP id q74mr6881935pfc.211.1563905786657;
        Tue, 23 Jul 2019 11:16:26 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k64sm24849104pge.65.2019.07.23.11.16.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 11:16:26 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 1/3] driver core: platform: Add an error message to platform_get_irq*()
Date:   Tue, 23 Jul 2019 11:16:22 -0700
Message-Id: <20190723181624.203864-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190723181624.203864-1-swboyd@chromium.org>
References: <20190723181624.203864-1-swboyd@chromium.org>
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
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/platform.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 506a0175a5a7..dbe1d8896bbc 100644
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
@@ -163,6 +158,22 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	return -ENXIO;
 #endif
 }
+
+/**
+ * platform_get_irq - get an IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
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
@@ -175,7 +186,7 @@ int platform_irq_count(struct platform_device *dev)
 {
 	int ret, nr = 0;
 
-	while ((ret = platform_get_irq(dev, nr)) >= 0)
+	while ((ret = __platform_get_irq(dev, nr)) >= 0)
 		nr++;
 
 	if (ret == -EPROBE_DEFER)
@@ -228,7 +239,11 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
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

