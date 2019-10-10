Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4170C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95114206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxuwaMLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfJJDEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:04:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38352 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfJJDEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:04:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so2042552plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0QC7T52/F6wJ/QdV0gsoEGwjoy//AVS0nn5suh34AUU=;
        b=QxuwaMLHzeZpL80Subx5AX7yuYwQRa6FXo+Qw7O4vwRj7rQfluZTPy/43TzxRyOJlE
         5SBRtRl7IKeJk1LLXoNH4tn9ubVbSoSzIiWPm5y97OVdvg3pBt0FjPia1E7BB1K3gPls
         7okkWd9Xbaw2PexqtRyBWdI+h7LdZ8fcfTvc/JZYukcPLcB17oxa3pVpUnj7fv3A96gC
         bSH3Fug2tUin25aA3QUBZKyzob2GQtNvkHty1GthXwg8Iaqgxrg66z3IyAPrKtZHcnp+
         AmAGmH2AFDc5zXvYksK0BR/JoCc5ZsZ41XG2NGMjbMWei4FQjsDokAcTXZlfA9VCusfu
         B+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0QC7T52/F6wJ/QdV0gsoEGwjoy//AVS0nn5suh34AUU=;
        b=dwBNvTH1N8zAnMd9NEHj+k9+RKaUJIuvJ6oqwRZClNKbZK17amOKJ3UbtTIavBSMS1
         8559fwVlofG+cekrRN75eLHxtU8EKfU2uiG+1kO+InS4NU5p3tao/yjt7b9sPuWyJmZY
         IXglzvpgydfnWHHxfMZHiBnHCubExw8Ikip4d3PEcGyvtYxt3CTAoV9e5w0q4cE6uROi
         +cDlZGI4TJhLZU6gXYdzR0ILaOsikMk+6sR7YLUfIuHgH805Padhy+pbTHmKnstgieL5
         IbmjgIJScHvyoM1OXqYbgRv3w0uVy4V22phe5f0koSuIoTYoRP7moZJeBYKo5QFw+e7G
         M9nA==
X-Gm-Message-State: APjAAAWUhfGNnV5ahtMglucJwdgeZKNMpNtt2d3ZRIcjy6UfyAo1HCIH
        4Sb1HPysSWK2pJcvA8f97+wSjRHflsACIQ==
X-Google-Smtp-Source: APXvYqyWNUnGrNc9Z/I4+YqPOiI5sniGdJftCRwE8DWTYs28LumaJSDVcCxjVY9f//k89fl3Npz51A==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr6289871plr.298.1570676670227;
        Wed, 09 Oct 2019 20:04:30 -0700 (PDT)
Received: from localhost.localdomain (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.googlemail.com with ESMTPSA id l192sm6310379pga.92.2019.10.09.20.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 20:04:29 -0700 (PDT)
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com, mcgrof@kernel.org,
        Tuowen Zhao <ztuowen@gmail.com>
Subject: [PATCH v3 1/2] lib: devres: add a helper function for ioremap_uc
Date:   Wed,  9 Oct 2019 21:03:34 -0600
Message-Id: <20191010030335.204974-1-ztuowen@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a resource managed strongly uncachable ioremap function.

Tested-by: AceLan Kao <acelan.kao@canonical.com>
Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes from previous version:

  * Split the patch in 2
  * Use GPL export for devm_ioremap_uc
  * Add entry to devres doc

 .../driver-api/driver-model/devres.rst        |  1 +
 include/linux/io.h                            |  2 ++
 lib/devres.c                                  | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index a100bef54952..92628fdc2f11 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -314,6 +314,7 @@ IOMAP
   devm_ioport_unmap()
   devm_ioremap()
   devm_ioremap_nocache()
+  devm_ioremap_uc()
   devm_ioremap_wc()
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
   devm_iounmap()
diff --git a/include/linux/io.h b/include/linux/io.h
index accac822336a..a59834bc0a11 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -64,6 +64,8 @@ static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
 
 void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 			   resource_size_t size);
+void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
+				   resource_size_t size);
 void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
 void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
diff --git a/lib/devres.c b/lib/devres.c
index 6a0e9bd6524a..17624d35e82d 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -9,6 +9,7 @@
 enum devm_ioremap_type {
 	DEVM_IOREMAP = 0,
 	DEVM_IOREMAP_NC,
+	DEVM_IOREMAP_UC,
 	DEVM_IOREMAP_WC,
 };
 
@@ -39,6 +40,9 @@ static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
 	case DEVM_IOREMAP_NC:
 		addr = ioremap_nocache(offset, size);
 		break;
+	case DEVM_IOREMAP_UC:
+		addr = ioremap_uc(offset, size);
+		break;
 	case DEVM_IOREMAP_WC:
 		addr = ioremap_wc(offset, size);
 		break;
@@ -68,6 +72,21 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 }
 EXPORT_SYMBOL(devm_ioremap);
 
+/**
+ * devm_ioremap_uc - Managed ioremap_uc()
+ * @dev: Generic device to remap IO address for
+ * @offset: Resource address to map
+ * @size: Size of map
+ *
+ * Managed ioremap_uc().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap_uc(struct device *dev, resource_size_t offset,
+			      resource_size_t size)
+{
+	return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_UC);
+}
+EXPORT_SYMBOL_GPL(devm_ioremap_uc);
+
 /**
  * devm_ioremap_nocache - Managed ioremap_nocache()
  * @dev: Generic device to remap IO address for
-- 
2.23.0

