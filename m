Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EBAC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20C620674
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyVxhn1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfH2LOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:14:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54550 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfH2LON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:14:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id k2so1855626wmj.4;
        Thu, 29 Aug 2019 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzIsnpxQuz9YX1kqGKTaTkxIwYDrTVUOK7AFA/KbySo=;
        b=EyVxhn1yfX/q2DKiYzciqwNfssXXz1f02i8ww1KwQg3uDdR1UcCgo7p5DmYJXlMfog
         qQgSBvESAI5DtwKOfoc3GNDEeL2N9urzDswtxWavbQPL8w9mu97UB18u52uPARVxKuDK
         W6mPJ8vlDyXjImwntQPsJZ3JneJUrIm/gV84RPn9QA7+oYT8GXM5L6iy9WjE/BTA0S9Q
         HpAi0VxbKs7WJxsPjyuY9/MxRn6lvWxnMfkQuDRDtHJ0HG/z4zFrjIUQ0yXUgBSLveID
         LDzVyXVurPZo/096Zwk+4vDzaXDEjq2hySFHqtzND5e0hq6Zw6U1NoLbzU3MUvDdT6Fk
         IujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzIsnpxQuz9YX1kqGKTaTkxIwYDrTVUOK7AFA/KbySo=;
        b=hat7MCstGvuxZP/Po4x4sN8z7K2/cTWpjNESNTYHtbd1JiwBeqlaJUO6gqPzrlkweB
         BufIh12EK0uA6GamDkeRf7uJbPyOv6i8Sg2OEU85VKCOeQ9lRE7acrromkK2NDNovMnc
         q3rNMBtaO4GrSzDZSaHuNYFFBfdUbRXIn7qOxG/7D4OtNSVhx/4yGr0q3UfCs8MfOQdX
         gaE1ZSgiGYsVLqAKLoTB7FTOOGtM3UgxBhPdYAEPQGM9KYWeFmnceaqzibxSJhPxtyFC
         eHShsXl/AxKvV75CCuqZKeEP1ZEf3JKqiiv/Vqj8KrTUsl5/E7UEP3+V7F0Q9wcWyF/7
         43wA==
X-Gm-Message-State: APjAAAXt6IF2iD0ple9Jmrvhq4NcF2/foSMajJyYpBRp4UzDPAm78FtX
        6zc4zjmHop7XYQbl8tqCvuM=
X-Google-Smtp-Source: APXvYqxt6RKEcJcAlx9UVPTtD2loTuq+iCY8co/AI5ZQxjgul6DNK+oETLhywDY0GVj8JXB7cg8J9g==
X-Received: by 2002:a1c:238d:: with SMTP id j135mr11268342wmj.39.1567077251078;
        Thu, 29 Aug 2019 04:14:11 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id f6sm4339290wrh.30.2019.08.29.04.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:14:10 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu: Implement of_iommu_get_resv_regions()
Date:   Thu, 29 Aug 2019 13:14:06 +0200
Message-Id: <20190829111407.17191-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829111407.17191-1-thierry.reding@gmail.com>
References: <20190829111407.17191-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

This is an implementation that IOMMU drivers can use to obtain reserved
memory regions from a device tree node. It uses the reserved-memory DT
bindings to find the regions associated with a given device. These
regions will be used to create 1:1 mappings in the IOMMU domain that
the devices will be attached to.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/of_iommu.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h |  8 ++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 614a93aa5305..0d47f626b854 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -9,6 +9,7 @@
 #include <linux/iommu.h>
 #include <linux/limits.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
@@ -225,3 +226,41 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 	return ops;
 }
+
+/**
+ * of_iommu_get_resv_regions - reserved region driver helper for device tree
+ * @dev: device for which to get reserved regions
+ * @list: reserved region list
+ *
+ * IOMMU drivers can use this to implement their .get_resv_regions() callback
+ * for memory regions attached to a device tree node. See the reserved-memory
+ * device tree bindings on how to use these:
+ *
+ *   Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+ */
+void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
+{
+	struct of_phandle_iterator it;
+	int err;
+
+	of_for_each_phandle(&it, err, dev->of_node, "memory-region", NULL, 0) {
+		struct iommu_resv_region *region;
+		struct resource res;
+
+		err = of_address_to_resource(it.node, 0, &res);
+		if (err < 0) {
+			dev_err(dev, "failed to parse memory region %pOF: %d\n",
+				it.node, err);
+			continue;
+		}
+
+		region = iommu_alloc_resv_region(res.start, resource_size(&res),
+						 IOMMU_READ | IOMMU_WRITE,
+						 IOMMU_RESV_DIRECT_RELAXABLE);
+		if (!region)
+			continue;
+
+		list_add_tail(&region->list, list);
+	}
+}
+EXPORT_SYMBOL(of_iommu_get_resv_regions);
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index f3d40dd7bb66..fa16b26f55bc 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -15,6 +15,9 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np);
 
+extern void of_iommu_get_resv_regions(struct device *dev,
+				      struct list_head *list);
+
 #else
 
 static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -30,6 +33,11 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 	return NULL;
 }
 
+static inline void of_iommu_get_resv_regions(struct device *dev,
+					     struct list_head *list)
+{
+}
+
 #endif	/* CONFIG_OF_IOMMU */
 
 #endif /* __OF_IOMMU_H */
-- 
2.22.0

