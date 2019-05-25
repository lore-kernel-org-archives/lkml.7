Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E54C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71A92133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfEYFth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:49:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfEYFtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:49:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:49:01 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:48:58 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 07/15] iommu/vt-d: Delegate the dma domain to upper layer
Date:   Sat, 25 May 2019 13:41:28 +0800
Message-Id: <20190525054136.27810-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the iommu generic layer to allocate a dma domain and
attach it to a device through the iommu api's. With all types of
domains being delegated to upper layer, we can remove an internal
flag which was used to distinguish domains mananged internally or
externally.

Signed-off-by: James Sewart <jamessewart@arista.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 71 ++++++++++---------------------------
 1 file changed, 18 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 907f9323921d..d246b4a9ac1d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -302,14 +302,8 @@ static inline void context_clear_entry(struct context_entry *context)
 static struct dmar_domain *si_domain;
 static int hw_pass_through = 1;
 
-/*
- * Domain represents a virtual machine, more than one devices
- * across iommus may be owned in one domain, e.g. kvm guest.
- */
-#define DOMAIN_FLAG_VIRTUAL_MACHINE	(1 << 0)
-
 /* si_domain contains mulitple devices */
-#define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
+#define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
 
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx = 0; idx < g_num_of_iommus; idx++)		\
@@ -543,22 +537,11 @@ static inline void free_devinfo_mem(void *vaddr)
 	kmem_cache_free(iommu_devinfo_cache, vaddr);
 }
 
-static inline int domain_type_is_vm(struct dmar_domain *domain)
-{
-	return domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE;
-}
-
 static inline int domain_type_is_si(struct dmar_domain *domain)
 {
 	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
 }
 
-static inline int domain_type_is_vm_or_si(struct dmar_domain *domain)
-{
-	return domain->flags & (DOMAIN_FLAG_VIRTUAL_MACHINE |
-				DOMAIN_FLAG_STATIC_IDENTITY);
-}
-
 static inline int domain_pfn_supported(struct dmar_domain *domain,
 				       unsigned long pfn)
 {
@@ -606,7 +589,9 @@ struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
 	int iommu_id;
 
 	/* si_domain and vm domain should not get here. */
-	BUG_ON(domain_type_is_vm_or_si(domain));
+	if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
+		return NULL;
+
 	for_each_domain_iommu(iommu_id, domain)
 		break;
 
@@ -1675,7 +1660,6 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 	if (!iommu->domains || !iommu->domain_ids)
 		return;
 
-again:
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
 		struct dmar_domain *domain;
@@ -1689,18 +1673,6 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 		domain = info->domain;
 
 		__dmar_remove_one_dev_info(info);
-
-		if (!domain_type_is_vm_or_si(domain)) {
-			/*
-			 * The domain_exit() function  can't be called under
-			 * device_domain_lock, as it takes this lock itself.
-			 * So release the lock here and re-run the loop
-			 * afterwards.
-			 */
-			spin_unlock_irqrestore(&device_domain_lock, flags);
-			domain_exit(domain);
-			goto again;
-		}
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
@@ -2365,7 +2337,7 @@ static int domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 			  struct scatterlist *sg, unsigned long phys_pfn,
 			  unsigned long nr_pages, int prot)
 {
-	int ret;
+	int iommu_id, ret;
 	struct intel_iommu *iommu;
 
 	/* Do the real mapping first */
@@ -2373,18 +2345,8 @@ static int domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	if (ret)
 		return ret;
 
-	/* Notify about the new mapping */
-	if (domain_type_is_vm(domain)) {
-		/* VM typed domains can have more than one IOMMUs */
-		int iommu_id;
-
-		for_each_domain_iommu(iommu_id, domain) {
-			iommu = g_iommus[iommu_id];
-			__mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
-		}
-	} else {
-		/* General domains only have one IOMMU */
-		iommu = domain_get_iommu(domain);
+	for_each_domain_iommu(iommu_id, domain) {
+		iommu = g_iommus[iommu_id];
 		__mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
 	}
 
@@ -4619,9 +4581,6 @@ static int device_notifier(struct notifier_block *nb,
 			return 0;
 
 		dmar_remove_one_dev_info(dev);
-		if (!domain_type_is_vm_or_si(domain) &&
-		    list_empty(&domain->devices))
-			domain_exit(domain);
 	} else if (action == BUS_NOTIFY_ADD_DEVICE) {
 		if (iommu_should_identity_map(dev, 1))
 			domain_add_dev_info(si_domain, dev);
@@ -5090,8 +5049,10 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	struct iommu_domain *domain;
 
 	switch (type) {
+	case IOMMU_DOMAIN_DMA:
+	/* fallthrough */
 	case IOMMU_DOMAIN_UNMANAGED:
-		dmar_domain = alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
+		dmar_domain = alloc_domain(0);
 		if (!dmar_domain) {
 			pr_err("Can't allocate dmar_domain\n");
 			return NULL;
@@ -5101,6 +5062,14 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 			domain_exit(dmar_domain);
 			return NULL;
 		}
+
+		if (type == IOMMU_DOMAIN_DMA &&
+		    init_iova_flush_queue(&dmar_domain->iovad,
+					  iommu_flush_iova, iova_entry_free)) {
+			pr_warn("iova flush queue initialization failed\n");
+			intel_iommu_strict = 1;
+		}
+
 		domain_update_iommu_cap(dmar_domain);
 
 		domain = &dmar_domain->domain;
@@ -5315,10 +5284,6 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 			rcu_read_lock();
 			dmar_remove_one_dev_info(dev);
 			rcu_read_unlock();
-
-			if (!domain_type_is_vm_or_si(old_domain) &&
-			    list_empty(&old_domain->devices))
-				domain_exit(old_domain);
 		}
 	}
 
-- 
2.17.1

