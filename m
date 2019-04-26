Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CFDC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E838D2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDZNWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:22:13 -0400
Received: from 8bytes.org ([81.169.241.247]:37600 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfDZNWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:22:13 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8710C447; Fri, 26 Apr 2019 15:22:11 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>, Tom Murphy <tmurphy@arista.com>
Subject: [PATCH] iommu/amd: Remove amd_iommu_pd_list
Date:   Fri, 26 Apr 2019 15:22:02 +0200
Message-Id: <20190426132202.11096-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This variable hold a global list of allocated protection
domains in the AMD IOMMU driver. By now this list is never
traversed anymore, so the list and the lock protecting it
can be removed.

Cc: Tom Murphy <tmurphy@arista.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c       | 33 ---------------------------------
 drivers/iommu/amd_iommu_init.c  |  8 --------
 drivers/iommu/amd_iommu_types.h |  6 ------
 3 files changed, 47 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f467cc4b498e..3e0696cf965c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1723,31 +1723,6 @@ static void dma_ops_free_iova(struct dma_ops_domain *dma_dom,
  *
  ****************************************************************************/
 
-/*
- * This function adds a protection domain to the global protection domain list
- */
-static void add_domain_to_list(struct protection_domain *domain)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&amd_iommu_pd_lock, flags);
-	list_add(&domain->list, &amd_iommu_pd_list);
-	spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
-}
-
-/*
- * This function removes a protection domain to the global
- * protection domain list
- */
-static void del_domain_from_list(struct protection_domain *domain)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&amd_iommu_pd_lock, flags);
-	list_del(&domain->list);
-	spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
-}
-
 static u16 domain_id_alloc(void)
 {
 	int id;
@@ -1838,8 +1813,6 @@ static void dma_ops_domain_free(struct dma_ops_domain *dom)
 	if (!dom)
 		return;
 
-	del_domain_from_list(&dom->domain);
-
 	put_iova_domain(&dom->iovad);
 
 	free_pagetable(&dom->domain);
@@ -1880,8 +1853,6 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	/* Initialize reserved ranges */
 	copy_reserved_iova(&reserved_iova_ranges, &dma_dom->iovad);
 
-	add_domain_to_list(&dma_dom->domain);
-
 	return dma_dom;
 
 free_dma_dom:
@@ -2834,8 +2805,6 @@ static void protection_domain_free(struct protection_domain *domain)
 	if (!domain)
 		return;
 
-	del_domain_from_list(domain);
-
 	if (domain->id)
 		domain_id_free(domain->id);
 
@@ -2865,8 +2834,6 @@ static struct protection_domain *protection_domain_alloc(void)
 	if (protection_domain_init(domain))
 		goto out_err;
 
-	add_domain_to_list(domain);
-
 	return domain;
 
 out_err:
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 1b1378619fc9..4497c6bb9e70 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -188,12 +188,6 @@ static bool amd_iommu_pc_present __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
-/*
- * List of protection domains - used during resume
- */
-LIST_HEAD(amd_iommu_pd_list);
-spinlock_t amd_iommu_pd_lock;
-
 /*
  * Pointer to the device table which is shared by all AMD IOMMUs
  * it is indexed by the PCI device id or the HT unit id and contains
@@ -2526,8 +2520,6 @@ static int __init early_amd_iommu_init(void)
 	 */
 	__set_bit(0, amd_iommu_pd_alloc_bitmap);
 
-	spin_lock_init(&amd_iommu_pd_lock);
-
 	/*
 	 * now the data structures are allocated and basically initialized
 	 * start the real acpi table scan
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 87965e4d9647..85c488b8daea 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -674,12 +674,6 @@ extern struct list_head amd_iommu_list;
  */
 extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
 
-/*
- * Declarations for the global list of all protection domains
- */
-extern spinlock_t amd_iommu_pd_lock;
-extern struct list_head amd_iommu_pd_list;
-
 /*
  * Structure defining one entry in the device table
  */
-- 
2.16.4

