Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE274CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4AC222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442378AbfJRJvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:51:10 -0400
Received: from [217.140.110.172] ([217.140.110.172]:60222 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1730808AbfJRJvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:51:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3540A492;
        Fri, 18 Oct 2019 02:50:45 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 235593F6C4;
        Fri, 18 Oct 2019 02:50:43 -0700 (PDT)
Subject: Re: [PATCH] iommu/amd: Pass gfp flags to iommu_map_page() in
 amd_iommu_map()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
References: <20191018090736.18819-1-joro@8bytes.org>
 <20191018092750.GK21344@kadam>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <31ba66a3-2435-2fb1-3fc6-782a2f583bf2@arm.com>
Date:   Fri, 18 Oct 2019 10:50:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191018092750.GK21344@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-18 10:27 am, Dan Carpenter wrote:
> Did you get a chance to look at iommu_dma_alloc_remap() as well?
> 
> drivers/iommu/dma-iommu.c
>     584  static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
>     585                  dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>                                                  ^^^^^^^^^
>     586  {
>     587          struct iommu_domain *domain = iommu_get_dma_domain(dev);
>     588          struct iommu_dma_cookie *cookie = domain->iova_cookie;
>     589          struct iova_domain *iovad = &cookie->iovad;
>     590          bool coherent = dev_is_dma_coherent(dev);
>     591          int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
>     592          pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
>     593          unsigned int count, min_size, alloc_sizes = domain->pgsize_bitmap;
>     594          struct page **pages;
>     595          struct sg_table sgt;
>     596          dma_addr_t iova;
>     597          void *vaddr;
>     598
>     599          *dma_handle = DMA_MAPPING_ERROR;
>     600
>     601          if (unlikely(iommu_dma_deferred_attach(dev, domain)))
>     602                  return NULL;
>     603
>     604          min_size = alloc_sizes & -alloc_sizes;
>     605          if (min_size < PAGE_SIZE) {
>     606                  min_size = PAGE_SIZE;
>     607                  alloc_sizes |= PAGE_SIZE;
>     608          } else {
>     609                  size = ALIGN(size, min_size);
>     610          }
>     611          if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
>     612                  alloc_sizes = min_size;
>     613
>     614          count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>     615          pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
>     616                                          gfp);
>     617          if (!pages)
>     618                  return NULL;
>     619
>     620          size = iova_align(iovad, size);
>     621          iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
>     622          if (!iova)
>     623                  goto out_free_pages;
>     624
>     625          if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
>                                                                             ^^^^^^^^^^
> gfp here instead of GFP_KERNEL?

This is, from what I remember, intentional - it's a temporary allocation 
which doesn't need to have the same restrictions as the actual buffer 
being allocated (e.g. GFP_DMA32 etc.). We don't need to worry about 
GFP_ATOMIC since the whole thing is only ever called in sleeping contexts.

Robin.

> 
>     626                  goto out_free_iova;
>     627
>     628          if (!(ioprot & IOMMU_CACHE)) {
> 
> regards,
> dan carpenter
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
