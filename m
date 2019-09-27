Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F4FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE85217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGg+TwHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfI0R7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:59:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42255 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfI0R7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 13:59:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id q12so2002895pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmaYsyRcatgzXQsy0tcn1VuhcXwzjzV5wqW3owNkQCI=;
        b=OGg+TwHVpitznJ+6fsRfw+2/ZLEYfePM3aO42uWqzOSJqUb3CyecEISYJ+GK46A0L8
         ti0lV0hbEmE8VeN/gh/eAm6eTAwmA3CDfKZfsCeGhv5sJscyFhaaSL+GIJ6pK8UTt4GF
         +nOgcyUtYkF5sWmV+vgWDTdhRUwX7VKhheT4viYW9xUodXY+MsvcQYWg99m1WJ+V/vfq
         HVMrVtTD/KL3AtzQYCm6NvtoQFEcJXCEX6oy74wBITWu4XtcdgKOIDJyY0CBA6il5KZo
         ehyf3sTzM0FxXIoFN37tsak33QDEBqvHzcKMSFq6fvCAyAApX0vc2ITA+f6c3gCxb9R1
         cKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qmaYsyRcatgzXQsy0tcn1VuhcXwzjzV5wqW3owNkQCI=;
        b=EEm0uMW3uaMgxQod3NYyY20dP84HWEK7Z6dT+fAjKauDj7k3PIs4Q0ihyRXe1nJ1wz
         cXP7tMbi6D1khDqmkz3ZcM2AdfrGc2l0OyU5s1YT2ulJIHqOndgI/IapAefomF5UIBYd
         24b0leFCqR0h8TFfYmmwlBfa6pwXlm/VSamUTfPT/4WEWk0CgfQK6WlSVzYu80wjd8sy
         yOOervNR0wgoUtUDDmcpVKZ6hcnvNj8NRpFvkJWqCUtq5t7M11PCNTn1MvLBwLinELBX
         1ab2ZcAhMaAshMnUBIrl+7rTQb57ItUdU6O1JUnFtPuA3Z98dMuPjKWUE/XhSJ8Ycl6j
         9ong==
X-Gm-Message-State: APjAAAVNR6wY4F4aTEEHWS1V+T8jjIMo8Pe+z7wDCzg9m1ceVc81ZSLN
        /ncRcT5cju4IDxAAo9kqR/k=
X-Google-Smtp-Source: APXvYqyL6hQg8YCTJ/JWdhqO1gaWRVn4NASQyDC6NLWOACIuLkh7fCXxqhSPOvKGsxRX2KNYsPTm+A==
X-Received: by 2002:a62:190f:: with SMTP id 15mr5922269pfz.172.1569607184260;
        Fri, 27 Sep 2019 10:59:44 -0700 (PDT)
Received: from iclxps.lan (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.googlemail.com with ESMTPSA id z12sm3582206pfj.41.2019.09.27.10.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 10:59:43 -0700 (PDT)
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com, Tuowen Zhao <ztuowen@gmail.com>
Subject: [PATCH] mfd: intel-lpss: use devm_ioremap_uc for mmio
Date:   Fri, 27 Sep 2019 11:55:13 -0600
Message-Id: <20190927175513.31054-1-ztuowen@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write-combining BAR for intel-lpss-pci in MTRR causes system hangs
during boot.

This patch adds devm_ioremap_uc as a new managed wrapper to ioremap_uc
and with it forces the use of strongly uncachable mmio in intel-lpss.

This bahavior is seen on Dell XPS 13 7390 2-in-1:

[    0.001734]   5 base 4000000000 mask 6000000000 write-combining

4000000000-7fffffffff : PCI Bus 0000:00
  4000000000-400fffffff : 0000:00:02.0 (i915)
  4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
---
 drivers/mfd/intel-lpss.c |  2 +-
 include/linux/io.h       |  2 ++
 lib/devres.c             | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 277f48f1cc1c..06106c9320bb 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -395,7 +395,7 @@ int intel_lpss_probe(struct device *dev,
 	if (!lpss)
 		return -ENOMEM;
 
-	lpss->priv = devm_ioremap(dev, info->mem->start + LPSS_PRIV_OFFSET,
+	lpss->priv = devm_ioremap_uc(dev, info->mem->start + LPSS_PRIV_OFFSET,
 				  LPSS_PRIV_SIZE);
 	if (!lpss->priv)
 		return -ENOMEM;
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
index 6a0e9bd6524a..beb0a064b891 100644
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
+EXPORT_SYMBOL(devm_ioremap_uc);
+
 /**
  * devm_ioremap_nocache - Managed ioremap_nocache()
  * @dev: Generic device to remap IO address for
-- 
2.23.0

