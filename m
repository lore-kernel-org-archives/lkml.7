Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C4AECE58A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6700521D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 16:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rj/pFi5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfJBQZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 12:25:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46842 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfJBQZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:25:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so20351429wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgzlAIhkpsVrchDajp8SP2c8jH/gUd2pLHbFdDZ/+4w=;
        b=rj/pFi5y42gXuBc2reywE/vv9N+NlhLhh6dxYz3dGRbBLvrOJ+HNY0NSp6fFHFPnOT
         ZywphOUVoLz8FF3kDke4Z02b3LNXBfYmf6OaFT+o40fbJixcWEqjKqGmd2NIKTR1sfGI
         uShoww26y0NVJS4qDMrPzGtnLltP5Wxbl0ugWEr4oxQd7SqtCyfh/qpCSEla7ca6qP8W
         0SawL8akDCnOLGv2S/kb9evf9aP8aVeUt0oZNj7PP+OUiTyC4IhgBTvdCFPPHiA9KVDZ
         Dwqm52GZHeu7Aq/JrmcetXup6T7hDtc3CDDTOpWzjFg9nTu1jCUysVJH4g0KsexcApQU
         s4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgzlAIhkpsVrchDajp8SP2c8jH/gUd2pLHbFdDZ/+4w=;
        b=tbncUJh/VvOYkEXu7taAVIh+BbA4n1DdnAvnQoCWX8NCrENSSmet5Ip7tzgVuShGcH
         aMCwZaIG4uX2f7ESz+fvZ0DqitFRovTdgchh89ojyNocNP+Khu7D7PndaOltMPQenxsd
         laUerz+ySOk9oSrytMSLiJJcXUWMoMQCrQdrwmjVRkCdJTL1AcMVD42Sc+ljhwqdGe5o
         6BC0yyKe1Uf52BkoC9Dmlvly2OGXsAsObi9/G9yRA2U3JmoIVgp6MMqMDJb68VHEjZHc
         0d6zttw0BdukCtGy/dUB6tX9zcFxW/RTIIj9Woz82GrTOORJ0Pnb8ji5zKtmDFo8LYJz
         b3Dg==
X-Gm-Message-State: APjAAAXkpPTx0TEDX+RylLkbJNdnuzC4udETFgjQvYWW3J3fL+jWe8Pg
        pxUp/bclbTk1eeVv/5dDMvaj8w==
X-Google-Smtp-Source: APXvYqxGANMEEdeKC02WKKofKLKYgv+DAhXRhE7z2cymoECM9/1hazaegjLD/8AlEfCaR12AR9ChUw==
X-Received: by 2002:adf:fa90:: with SMTP id h16mr3341621wrr.52.1570033542440;
        Wed, 02 Oct 2019 09:25:42 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id w9sm3482067wrt.62.2019.10.02.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 09:25:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/5] lib: devres: provide devm_ioremap_resource_wc()
Date:   Wed,  2 Oct 2019 18:25:32 +0200
Message-Id: <20191002162534.3967-4-brgl@bgdev.pl>
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

Provide a variant of devm_ioremap_resource() for write-combined ioremap.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

