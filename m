Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43747C282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244AC21848
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfEYFsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:48:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfEYFst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:48:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:48:49 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:48:47 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 01/15] iommu: Add API to request DMA domain for device
Date:   Sat, 25 May 2019 13:41:22 +0800
Message-Id: <20190525054136.27810-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally during iommu probing a device, a default doamin will
be allocated and attached to the device. The domain type of
the default domain is statically defined, which results in a
situation where the allocated default domain isn't suitable
for the device due to some limitations. We already have API
iommu_request_dm_for_dev() to replace a DMA domain with an
identity one. This adds iommu_request_dma_domain_for_dev()
to request a dma domain if an allocated identity domain isn't
suitable for the device in question.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 36 +++++++++++++++++++++++++-----------
 include/linux/iommu.h |  6 ++++++
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c09d60401778..03ba8406d1e4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1910,10 +1910,10 @@ struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 	return region;
 }
 
-/* Request that a device is direct mapped by the IOMMU */
-int iommu_request_dm_for_dev(struct device *dev)
+static int
+request_default_domain_for_dev(struct device *dev, unsigned long type)
 {
-	struct iommu_domain *dm_domain;
+	struct iommu_domain *domain;
 	struct iommu_group *group;
 	int ret;
 
@@ -1926,8 +1926,7 @@ int iommu_request_dm_for_dev(struct device *dev)
 
 	/* Check if the default domain is already direct mapped */
 	ret = 0;
-	if (group->default_domain &&
-	    group->default_domain->type == IOMMU_DOMAIN_IDENTITY)
+	if (group->default_domain && group->default_domain->type == type)
 		goto out;
 
 	/* Don't change mappings of existing devices */
@@ -1937,23 +1936,26 @@ int iommu_request_dm_for_dev(struct device *dev)
 
 	/* Allocate a direct mapped domain */
 	ret = -ENOMEM;
-	dm_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_IDENTITY);
-	if (!dm_domain)
+	domain = __iommu_domain_alloc(dev->bus, type);
+	if (!domain)
 		goto out;
 
 	/* Attach the device to the domain */
-	ret = __iommu_attach_group(dm_domain, group);
+	ret = __iommu_attach_group(domain, group);
 	if (ret) {
-		iommu_domain_free(dm_domain);
+		iommu_domain_free(domain);
 		goto out;
 	}
 
+	iommu_group_create_direct_mappings(group, dev);
+
 	/* Make the direct mapped domain the default for this group */
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
-	group->default_domain = dm_domain;
+	group->default_domain = domain;
 
-	dev_info(dev, "Using iommu direct mapping\n");
+	dev_info(dev, "Using iommu %s mapping\n",
+		 type == IOMMU_DOMAIN_DMA ? "dma" : "direct");
 
 	ret = 0;
 out:
@@ -1963,6 +1965,18 @@ int iommu_request_dm_for_dev(struct device *dev)
 	return ret;
 }
 
+/* Request that a device is direct mapped by the IOMMU */
+int iommu_request_dm_for_dev(struct device *dev)
+{
+	return request_default_domain_for_dev(dev, IOMMU_DOMAIN_IDENTITY);
+}
+
+/* Request that a device can't be direct mapped by the IOMMU */
+int iommu_request_dma_domain_for_dev(struct device *dev)
+{
+	return request_default_domain_for_dev(dev, IOMMU_DOMAIN_DMA);
+}
+
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 {
 	const struct iommu_ops *ops = NULL;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 14a521f85f14..593a3411d860 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -368,6 +368,7 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern int iommu_request_dm_for_dev(struct device *dev);
+extern int iommu_request_dma_domain_for_dev(struct device *dev);
 extern struct iommu_resv_region *
 iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot,
 			enum iommu_resv_type type, gfp_t flags);
@@ -632,6 +633,11 @@ static inline int iommu_request_dm_for_dev(struct device *dev)
 	return -ENODEV;
 }
 
+static inline int iommu_request_dma_domain_for_dev(struct device *dev)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_attach_group(struct iommu_domain *domain,
 				     struct iommu_group *group)
 {
-- 
2.17.1

