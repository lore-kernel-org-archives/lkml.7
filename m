Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B07CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E0A21929
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qH2CAu8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbfJVIna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:43:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38004 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388537AbfJVIn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:43:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so15295710wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LeSB/4bF65zoMxpAcYcnsp5xsFlG1B0B3u0kHWM+LWg=;
        b=qH2CAu8des/92pR3N1BWVGNqxXxQSA2khx932U2zJK+ScVl/NLYxY/49EqPo0W5QLD
         ML/KfrzmtLXsCbhchT6YRrHpqST3TqLDp3PyRnLgy1G8w+AthSQFllMjAYGnQz6kMri8
         yPiFHJ4IsYf614rjYyHSdbr3XhL8UGxjHk7Mcr0gn+UoW36ZgkQ8neWdF1huZfVQBesi
         ZERrZLxZ7+YziZAT6vp0Z7Ywt7GGuCerQyVoU/UuIGti/JbxeihEM2tjMS+XsAmHX9CO
         rHqGzO4rVCxPAOL+3YfQ6WjBwx3xK7sLDHW4ELbhU3lgnjHsJwweCvnAAg9xwSjZndHL
         bK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeSB/4bF65zoMxpAcYcnsp5xsFlG1B0B3u0kHWM+LWg=;
        b=YyDYLlXDx3qSnkMjslVD7JGyxiNudDyFzEGHiRP/OazUIKLri27cgQyaUK3lzGGSAe
         KvByYn6G+rm67eZ9j0pZLtyMMQIPMEAPKxuxMhIno3EmAk9DcvfQQ3u0VY7TtSiNcyO/
         J1MYjgHex4Gn1Bx1eN370FXoudU+EZWismI3J8PyCltjkDLBA6TNHu+oLiPY8UDtMV+L
         UXAnSox/58FEdQC5XBPnjSiXEKyhXBcKOsj5QqCo+K7doTIC0lEGdCarIHsQWiaQGIlk
         7jAG56I9y/C/QkLzPE55kRe4GzPtOu5Oyy8BTNJ7BryTLcCIgy2l5uFB392LFNxsibqn
         1eVg==
X-Gm-Message-State: APjAAAXOfy79LwZuwcwZYaUqA/+CV+5BDFZZhpMv9WU+TXvtxholoq1b
        0RM06SDIMe/n63vh4iHzWUYIqg==
X-Google-Smtp-Source: APXvYqz3gMedbJyFFsWr/N2Dw76GIV0/hBsg8cKjnLzgTwfiQQiMZAnNf4bqXHRdHSC4acCzlkFMhQ==
X-Received: by 2002:a05:600c:54e:: with SMTP id k14mr2013621wmc.9.1571733806296;
        Tue, 22 Oct 2019 01:43:26 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id q25sm477231wra.3.2019.10.22.01.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:43:25 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v3 3/8] lib: devres: provide devm_ioremap_resource_wc()
Date:   Tue, 22 Oct 2019 10:43:13 +0200
Message-Id: <20191022084318.22256-4-brgl@bgdev.pl>
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

Provide a variant of devm_ioremap_resource() for write-combined ioremap.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/driver-api/driver-model/devres.rst |  1 +
 include/linux/device.h                           |  2 ++
 lib/devres.c                                     | 15 +++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 8e3087662daf..e605bb9df6e1 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -316,6 +316,7 @@ IOMAP
   devm_ioremap_nocache()
   devm_ioremap_wc()
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
+  devm_ioremap_resource_wc()
   devm_platform_ioremap_resource() : calls devm_ioremap_resource() for platform device
   devm_iounmap()
   pcim_iomap()
diff --git a/include/linux/device.h b/include/linux/device.h
index 297239a08bb7..1f4aaf2d4b2a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -946,6 +946,8 @@ extern void devm_free_pages(struct device *dev, unsigned long addr);
 
 void __iomem *devm_ioremap_resource(struct device *dev,
 				    const struct resource *res);
+void __iomem *devm_ioremap_resource_wc(struct device *dev,
+				       const struct resource *res);
 
 void __iomem *devm_of_iomap(struct device *dev,
 			    struct device_node *node, int index,
diff --git a/lib/devres.c b/lib/devres.c
index a14c727128c1..97fb44e5b4d6 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -169,6 +169,21 @@ void __iomem *devm_ioremap_resource(struct device *dev,
 }
 EXPORT_SYMBOL(devm_ioremap_resource);
 
+/**
+ * devm_ioremap_resource_wc() - write-combined variant of
+ *				devm_ioremap_resource()
+ * @dev: generic device to handle the resource for
+ * @res: resource to be handled
+ *
+ * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure. Usage example:
+ */
+void __iomem *devm_ioremap_resource_wc(struct device *dev,
+				       const struct resource *res)
+{
+	return __devm_ioremap_resource(dev, res, DEVM_IOREMAP_WC);
+}
+
 /*
  * devm_of_iomap - Requests a resource and maps the memory mapped IO
  *		   for a given device_node managed by a given device
-- 
2.23.0

