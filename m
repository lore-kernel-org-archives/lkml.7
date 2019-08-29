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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5C5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BFC20674
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK7F3ESU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfH2LR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:17:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45724 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2LR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:17:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id x19so3589630eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 04:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWFDdsSRIYNKrRBdDSN7KSj6FUeTwnbHluq8rixbTiU=;
        b=QK7F3ESU41SJHkKfAxVhUhnoObCMRcjDeVy8XBXAejYxpeOt+AeNnLB5DhxnGzPZTP
         2SVCtoiYV0imTE3QaoiCdK93Uwz0ghTmT7C4bje7vpBjSbEj461Af+y8MbSZYrnR6OJc
         90jH6lwG2R68n8P70gZi9ZMrBnrrvn3X/lr7gT8ZcpnVRJWvoUB3IsrVky/rmi5AEBSW
         uWKkPfVSMlrHQs78MPEAgySdqXX9uf6SRW4UXQWzrh58WYWx7THUHN3dpksbqXawdh+D
         SVcbZtPGdWRnNhIS7772iNUia2YtTK4d3vb0INvBEj7VNgQecAAkl7abEQ0zMCnH3ec2
         RGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWFDdsSRIYNKrRBdDSN7KSj6FUeTwnbHluq8rixbTiU=;
        b=LZ7KK78cwJPMvntQ8a4ZJwhq+iMDoSNfvnEqY9j3GjaEYh9VYr16qJpK0lYAcJ0VFO
         sB5+HyggJZ22lW8yTHy/GgO+4r6APGnKNvsjIwBIHw6hvi5DXZHTPwW1UQHm1siYAGHZ
         HhwoyfqC7HSjJgooOeJa8yY3ryCjTnU9qEOEqpk24qfEFuDx3Mx2KlqIEYG9YOPCchpt
         FQp6+4CoSmRNIupg3sVHxOlvzK7U0bxKoX2drWs4bpIzoQ8fpnsXWPIQZ7Jw816E4efs
         up/x3R71O1+O7BhRLFzZIhy0FKqtf8NG1kqUK3TOkmYNlypzb6urkCfZa4laOWJBSok5
         3mtw==
X-Gm-Message-State: APjAAAUN8pN7+3dYu7RP1uzE/Z6qywnpitdU0z8nevJHJ3jvPTX420wD
        dTc+0A0r2laJaXWJAwuKQ0c=
X-Google-Smtp-Source: APXvYqwUQQWr7opeC82ffN614dN4qfpRwQm9wEqpQ2QRcIIdZGIO8kDGPJZeUP/x70eq+7DhXC+pxw==
X-Received: by 2002:a50:c19a:: with SMTP id m26mr9023066edf.184.1567077476308;
        Thu, 29 Aug 2019 04:17:56 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id a16sm341890ejr.10.2019.08.29.04.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:17:54 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] iommu: Implement iommu_put_resv_regions_simple()
Date:   Thu, 29 Aug 2019 13:17:48 +0200
Message-Id: <20190829111752.17513-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829111752.17513-1-thierry.reding@gmail.com>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Implement a generic function for removing reserved regions. This can be
used by drivers that don't do anything fancy with these regions other
than allocating memory for them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++++++++++
 include/linux/iommu.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0f585b614657..73a2a6b13507 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2170,6 +2170,25 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 		ops->put_resv_regions(dev, list);
 }
 
+/**
+ * iommu_put_resv_regions_simple - Reserved region driver helper
+ * @dev: device for which to free reserved regions
+ * @list: reserved region list for device
+ *
+ * IOMMU drivers can use this to implement their .put_resv_regions() callback
+ * for simple reservations. Memory allocated for each reserved region will be
+ * freed. If an IOMMU driver allocates additional resources per region, it is
+ * going to have to implement a custom callback.
+ */
+void iommu_put_resv_regions_simple(struct device *dev, struct list_head *list)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, list, list)
+		kfree(entry);
+}
+EXPORT_SYMBOL(iommu_put_resv_regions_simple);
+
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 						  size_t length, int prot,
 						  enum iommu_resv_type type)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 29bac5345563..d9c91e37ac2e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -434,6 +434,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
+extern void iommu_put_resv_regions_simple(struct device *dev,
+					  struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
 extern int iommu_request_dma_domain_for_dev(struct device *dev);
 extern void iommu_set_default_passthrough(bool cmd_line);
-- 
2.22.0

