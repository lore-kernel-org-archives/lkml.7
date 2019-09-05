Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990F9C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D66020870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfIELnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:43:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728072AbfIELnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:43:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F75BAD07;
        Thu,  5 Sep 2019 11:43:42 +0000 (UTC)
Date:   Thu, 5 Sep 2019 13:43:39 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     hch@lst.de, iommu@lists.linux-foundation.org,
        don.brace@microsemi.com, esc.storagedev@microsemi.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/amd: fix a race in increase_address_space()
Message-ID: <20190905114339.GC5457@suse.de>
References: <1567632262-21284-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567632262-21284-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Wed, Sep 04, 2019 at 05:24:22PM -0400, Qian Cai wrote:
> 	if (domain->mode == PAGE_MODE_6_LEVEL)
> 		/* address space already 64 bit large */
> 		return false;
> 
> This gives a clue that there must be a race between multiple concurrent
> threads in increase_address_space().

Thanks for tracking this down, there is a race indeed.

> +	mutex_lock(&domain->api_lock);
>  	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
>  				 size, DMA_BIDIRECTIONAL, dma_mask);
> +	mutex_unlock(&domain->api_lock);
>  
>  	if (*dma_addr == DMA_MAPPING_ERROR)
>  		goto out_free;
> @@ -2696,7 +2698,9 @@ static void free_coherent(struct device *dev, size_t size,
>  
>  	dma_dom = to_dma_ops_domain(domain);
>  
> +	mutex_lock(&domain->api_lock);
>  	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
> +	mutex_unlock(&domain->api_lock);

But I think the right fix is to lock the operation in
increase_address_space() directly, and not the calls around it, like in
the diff below. It is untested, so can you please try it and report back
if it fixes your issue?

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b607a92791d3..1ff705f16239 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1424,18 +1424,21 @@ static void free_pagetable(struct protection_domain *domain)
  * another level increases the size of the address space by 9 bits to a size up
  * to 64 bits.
  */
-static bool increase_address_space(struct protection_domain *domain,
+static void increase_address_space(struct protection_domain *domain,
 				   gfp_t gfp)
 {
+	unsigned long flags;
 	u64 *pte;
 
-	if (domain->mode == PAGE_MODE_6_LEVEL)
+	spin_lock_irqsave(&domain->lock, flags);
+
+	if (WARN_ON_ONCE(domain->mode == PAGE_MODE_6_LEVEL))
 		/* address space already 64 bit large */
-		return false;
+		goto out;
 
 	pte = (void *)get_zeroed_page(gfp);
 	if (!pte)
-		return false;
+		goto out;
 
 	*pte             = PM_LEVEL_PDE(domain->mode,
 					iommu_virt_to_phys(domain->pt_root));
@@ -1443,7 +1446,10 @@ static bool increase_address_space(struct protection_domain *domain,
 	domain->mode    += 1;
 	domain->updated  = true;
 
-	return true;
+out:
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	return;
 }
 
 static u64 *alloc_pte(struct protection_domain *domain,
