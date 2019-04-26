Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01058C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00132084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfDZNRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:17:05 -0400
Received: from 8bytes.org ([81.169.241.247]:37590 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbfDZNRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:17:05 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C951E447; Fri, 26 Apr 2019 15:17:03 +0200 (CEST)
Date:   Fri, 26 Apr 2019 15:16:58 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Murphy <tmurphy@arista.com>
Cc:     iommu@lists.linux-foundation.org, dima@arista.com,
        jamessewart@arista.com, murphyt7@tcd.ie,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Add allocated domain to global list earlier
Message-ID: <20190426131658.GA24576@8bytes.org>
References: <20190415180556.5018-1-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415180556.5018-1-tmurphy@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Mon, Apr 15, 2019 at 07:05:56PM +0100, Tom Murphy wrote:
> dma_ops_domain_free() expects domain to be in a global list.
> Arguably, could be called before protection_domain_init().

This could in theory create new races because a not fully initialized
domain becomes visible in the global list. In practice this never
happens because that global list is unused by now.

So it is better to remove this global list like the attached diff does.
I'll send out a patch separatly and put it into the iommu-tree.

Regards,

	Joerg

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
