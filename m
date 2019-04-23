Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFA8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F7A20643
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 02:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfDWCJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 22:09:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:63899 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbfDWCJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 22:09:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 19:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,384,1549958400"; 
   d="scan'208";a="339872623"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2019 19:04:28 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
To:     Christoph Hellwig <hch@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
 <20190421011719.14909-3-baolu.lu@linux.intel.com>
 <20190422164555.GA31181@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com>
Date:   Tue, 23 Apr 2019 09:58:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422164555.GA31181@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thanks for reviewing my patches.

On 4/23/19 12:45 AM, Christoph Hellwig wrote:
> I looked over your swiotlb modification and I don't think we really need
> them.  The only thing we really need is to split the size parameter to
> swiotlb_tbl_map_single and swiotlb_tbl_unmap_single into an alloc_size
> and a mapping_size paramter, where the latter one is rounded up to the
> iommu page size.  Below is an untested patch on top of your series to
> show what I mean. 

Good suggestion. The only problem as far as I can see is:

442 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
443                 dma_addr_t tbl_dma_addr, phys_addr_t orig_addr,
444                 size_t mapping_size, size_t alloc_size,
445                 enum dma_data_direction dir, unsigned long attrs)
446 {
447         unsigned long flags;
448         phys_addr_t tlb_addr;
449         unsigned int nslots, stride, index, wrap;
450         int i;
451         unsigned long mask;
452         unsigned long offset_slots;
453         unsigned long max_slots;

[--->o<----]

545 found:
546         io_tlb_used += nslots;
547         spin_unlock_irqrestore(&io_tlb_lock, flags);
548
549         /*
550          * Save away the mapping from the original address to the 
DMA address.
551          * This is needed when we sync the memory.  Then we sync the 
buffer if
552          * needed.
553          */
554         for (i = 0; i < nslots; i++)
555                 io_tlb_orig_addr[index+i] = orig_addr + (i << 
IO_TLB_SHIFT);

Could the tlb orig address set to PAGE_ALIGN_DOWN(orig_addr)? We
couldn't assume the bounce buffer just starts from the beginning of the
slot. Or anything I missed?


556         if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
557             (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
558                 swiotlb_bounce(orig_addr, tlb_addr, mapping_size,
559                                 DMA_TO_DEVICE);

Same here. We should sync from the place where the bounce buffer starts
from.


560
561         return tlb_addr;
562 }


> That being said - both the current series and the one
> with my patch will still leak the content of the swiotlb buffer
> allocated but not used to the untrusted external device.  Is that
> acceptable?  If not we need to clear that part, at which point you don't
> need swiotlb changes.

Good catch. I think the allocated buffer should be cleared, otherwise,
the untrusted device still has a chance to access the data belonging to
other swiotlb consumers.

>  Another implication is that for untrusted devices
> the size of the dma coherent allocations needs to be rounded up to the
> iommu page size (if that can ever be larger than the host page size).

Agreed.

Intel iommu driver has already aligned the dma coherent allocation size
to PAGE_SIZE. And alloc_coherent is equal to alloc plus map. Hence, it
eventually goes into bounce_map().

Best regards,
Lu Baolu

> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8c4a078fb041..eb5c32ad4443 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2151,10 +2151,13 @@ static int bounce_map(struct device *dev, struct iommu_domain *domain,
>   		      void *data)
>   {
>   	const struct iommu_ops *ops = domain->ops;
> +	unsigned long page_size = domain_minimal_pgsize(domain);
>   	phys_addr_t tlb_addr;
>   	int prot = 0;
>   	int ret;
>   
> +	if (WARN_ON_ONCE(size > page_size))
> +		return -EINVAL;
>   	if (unlikely(!ops->map || domain->pgsize_bitmap == 0UL))
>   		return -ENODEV;
>   
> @@ -2164,16 +2167,16 @@ static int bounce_map(struct device *dev, struct iommu_domain *domain,
>   	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
>   		prot |= IOMMU_WRITE;
>   
> -	tlb_addr = phys_to_dma(dev, paddr);
> -	if (!swiotlb_map(dev, &paddr, &tlb_addr, size,
> -			 dir, attrs | DMA_ATTR_BOUNCE_PAGE))
> +	tlb_addr = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
> +			paddr, size, page_size, dir, attrs);
> +	if (tlb_addr == DMA_MAPPING_ERROR)
>   		return -ENOMEM;
>   
>   	ret = ops->map(domain, addr, tlb_addr, size, prot);
> -	if (ret)
> -		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
> -					 dir, attrs | DMA_ATTR_BOUNCE_PAGE);
> -
> +	if (ret) {
> +		swiotlb_tbl_unmap_single(dev, tlb_addr, size, page_size,
> +					 dir, attrs);
> +	}
>   	return ret;
>   }
>   
> @@ -2194,11 +2197,12 @@ static int bounce_unmap(struct device *dev, struct iommu_domain *domain,
>   
>   	if (unlikely(!ops->unmap))
>   		return -ENODEV;
> -	ops->unmap(domain, ALIGN_DOWN(addr, page_size), page_size);
> +	ops->unmap(domain, addr, page_size);
>   
> -	if (tlb_addr)
> -		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
> -					 dir, attrs | DMA_ATTR_BOUNCE_PAGE);
> +	if (tlb_addr) {
> +		swiotlb_tbl_unmap_single(dev, tlb_addr, size, page_size,
> +					 dir, attrs);
> +	}
>   
>   	return 0;
>   }
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 877baf2a94f4..3b6ce643bffa 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -404,7 +404,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>   	 */
>   	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
>   
> -	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
> +	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, size, dir,
>   				     attrs);
>   	if (map == DMA_MAPPING_ERROR)
>   		return DMA_MAPPING_ERROR;
> @@ -420,7 +420,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>   		return dev_addr;
>   
>   	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> -	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
> +	swiotlb_tbl_unmap_single(dev, map, size, size, dir, attrs);
>   
>   	return DMA_MAPPING_ERROR;
>   }
> @@ -445,7 +445,7 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
>   
>   	/* NOTE: We use dev_addr here, not paddr! */
>   	if (is_xen_swiotlb_buffer(dev_addr))
> -		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
> +		swiotlb_tbl_unmap_single(hwdev, paddr, size, size, dir, attrs);
>   }
>   
>   static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
> @@ -556,6 +556,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
>   								 start_dma_addr,
>   								 sg_phys(sg),
>   								 sg->length,
> +								 sg->length,
>   								 dir, attrs);
>   			if (map == DMA_MAPPING_ERROR) {
>   				dev_warn(hwdev, "swiotlb buffer is full\n");
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 26e506e5b04c..75e60be91e5f 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -70,12 +70,6 @@
>    */
>   #define DMA_ATTR_PRIVILEGED		(1UL << 9)
>   
> -/*
> - * DMA_ATTR_BOUNCE_PAGE: used by the IOMMU sub-system to indicate that
> - * the buffer is used as a bounce page in the DMA remapping page table.
> - */
> -#define DMA_ATTR_BOUNCE_PAGE		(1UL << 10)
> -
>   /*
>    * A dma_addr_t can hold any valid DMA or bus address for the platform.
>    * It can be given to a device to use as a DMA source or target.  A CPU cannot
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 361f62bb4a8e..e1c738eb5baf 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -44,16 +44,13 @@ enum dma_sync_target {
>   	SYNC_FOR_DEVICE = 1,
>   };
>   
> -extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> -					  dma_addr_t tbl_dma_addr,
> -					  phys_addr_t phys, size_t size,
> -					  enum dma_data_direction dir,
> -					  unsigned long attrs);
> -
> -extern void swiotlb_tbl_unmap_single(struct device *hwdev,
> -				     phys_addr_t tlb_addr,
> -				     size_t size, enum dma_data_direction dir,
> -				     unsigned long attrs);
> +phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> +		dma_addr_t tbl_dma_addr, phys_addr_t phys, size_t mapping_size,
> +		size_t alloc_size, enum dma_data_direction dir,
> +		unsigned long attrs);
> +void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
> +		size_t mapping_size, size_t alloc_size,
> +		enum dma_data_direction dir, unsigned long attrs);
>   
>   extern void swiotlb_tbl_sync_single(struct device *hwdev,
>   				    phys_addr_t tlb_addr,
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index fcdb23e8d2fc..0edc0bf80207 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -290,7 +290,7 @@ void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
>   		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
>   
>   	if (unlikely(is_swiotlb_buffer(phys)))
> -		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> +		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
>   }
>   EXPORT_SYMBOL(dma_direct_unmap_page);
>   
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 96b87a11dee1..feec87196cc8 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -34,7 +34,6 @@
>   #include <linux/scatterlist.h>
>   #include <linux/mem_encrypt.h>
>   #include <linux/set_memory.h>
> -#include <linux/iommu.h>
>   #ifdef CONFIG_DEBUG_FS
>   #include <linux/debugfs.h>
>   #endif
> @@ -440,9 +439,10 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
>   	}
>   }
>   
> -static phys_addr_t
> -swiotlb_tbl_alloc_tlb(struct device *hwdev, dma_addr_t tbl_dma_addr,
> -		      phys_addr_t orig_addr, size_t size)
> +phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> +		dma_addr_t tbl_dma_addr, phys_addr_t orig_addr,
> +		size_t mapping_size, size_t alloc_size,
> +		enum dma_data_direction dir, unsigned long attrs)
>   {
>   	unsigned long flags;
>   	phys_addr_t tlb_addr;
> @@ -476,8 +476,8 @@ swiotlb_tbl_alloc_tlb(struct device *hwdev, dma_addr_t tbl_dma_addr,
>   	 * For mappings greater than or equal to a page, we limit the stride
>   	 * (and hence alignment) to a page size.
>   	 */
> -	nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> -	if (size >= PAGE_SIZE)
> +	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> +	if (alloc_size >= PAGE_SIZE)
>   		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
>   	else
>   		stride = 1;
> @@ -538,6 +538,9 @@ swiotlb_tbl_alloc_tlb(struct device *hwdev, dma_addr_t tbl_dma_addr,
>   
>   not_found:
>   	spin_unlock_irqrestore(&io_tlb_lock, flags);
> +	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
> +		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n",
> +				alloc_size);
>   	return DMA_MAPPING_ERROR;
>   found:
>   	io_tlb_used += nslots;
> @@ -550,21 +553,34 @@ swiotlb_tbl_alloc_tlb(struct device *hwdev, dma_addr_t tbl_dma_addr,
>   	 */
>   	for (i = 0; i < nslots; i++)
>   		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> +	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
> +		swiotlb_bounce(orig_addr, tlb_addr, mapping_size,
> +				DMA_TO_DEVICE);
>   
>   	return tlb_addr;
>   }
>   
> -static void
> -swiotlb_tbl_free_tlb(struct device *hwdev, phys_addr_t tlb_addr, size_t size)
> +/*
> + * tlb_addr is the physical address of the bounce buffer to unmap.
> + */
> +void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
> +		size_t mapping_size, size_t alloc_size,
> +		enum dma_data_direction dir, unsigned long attrs)
>   {
>   	unsigned long flags;
> -	int i, count, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
> +	int i, count, nslots;
>   	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
> +	phys_addr_t orig_addr = io_tlb_orig_addr[index];
>   
> -	/* Return directly if the tlb address is out of slot pool. */
> -	if (tlb_addr < io_tlb_start || tlb_addr + size > io_tlb_end) {
> -		dev_warn(hwdev, "invalid tlb address\n");
> -		return;
> +	/*
> +	 * First, sync the memory before unmapping the entry
> +	 */
> +	if (orig_addr != INVALID_PHYS_ADDR &&
> +	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> +	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)) {
> +		swiotlb_bounce(orig_addr, tlb_addr, mapping_size,
> +				DMA_FROM_DEVICE);
>   	}
>   
>   	/*
> @@ -573,6 +589,7 @@ swiotlb_tbl_free_tlb(struct device *hwdev, phys_addr_t tlb_addr, size_t size)
>   	 * While returning the entries to the free list, we merge the entries
>   	 * with slots below and above the pool being returned.
>   	 */
> +	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
>   	spin_lock_irqsave(&io_tlb_lock, flags);
>   	{
>   		count = ((index + nslots) < ALIGN(index + 1, IO_TLB_SEGSIZE) ?
> @@ -597,88 +614,6 @@ swiotlb_tbl_free_tlb(struct device *hwdev, phys_addr_t tlb_addr, size_t size)
>   	spin_unlock_irqrestore(&io_tlb_lock, flags);
>   }
>   
> -static unsigned long
> -get_iommu_pgsize(struct device *dev, phys_addr_t phys, size_t size)
> -{
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -
> -	return domain_minimal_pgsize(domain);
> -}
> -
> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> -				   dma_addr_t tbl_dma_addr,
> -				   phys_addr_t orig_addr, size_t size,
> -				   enum dma_data_direction dir,
> -				   unsigned long attrs)
> -{
> -	phys_addr_t tlb_addr;
> -	unsigned long offset = 0;
> -
> -	if (attrs & DMA_ATTR_BOUNCE_PAGE) {
> -		unsigned long pgsize = get_iommu_pgsize(hwdev, orig_addr, size);
> -
> -		offset = orig_addr & (pgsize - 1);
> -
> -		/* Don't allow the buffer to cross page boundary. */
> -		if (offset + size > pgsize)
> -			return DMA_MAPPING_ERROR;
> -
> -		tlb_addr = swiotlb_tbl_alloc_tlb(hwdev,
> -				__phys_to_dma(hwdev, io_tlb_start),
> -				ALIGN_DOWN(orig_addr, pgsize), pgsize);
> -	} else {
> -		tlb_addr = swiotlb_tbl_alloc_tlb(hwdev,
> -				tbl_dma_addr, orig_addr, size);
> -	}
> -
> -	if (tlb_addr == DMA_MAPPING_ERROR) {
> -		if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
> -			dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n",
> -				 size);
> -		return DMA_MAPPING_ERROR;
> -	}
> -
> -	tlb_addr += offset;
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> -	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
> -		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
> -
> -	return tlb_addr;
> -}
> -
> -/*
> - * tlb_addr is the physical address of the bounce buffer to unmap.
> - */
> -void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
> -			      size_t size, enum dma_data_direction dir,
> -			      unsigned long attrs)
> -{
> -	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
> -	phys_addr_t orig_addr = io_tlb_orig_addr[index];
> -	unsigned long offset = 0;
> -
> -	if (attrs & DMA_ATTR_BOUNCE_PAGE)
> -		offset = tlb_addr & ((1 << IO_TLB_SHIFT) - 1);
> -
> -	/*
> -	 * First, sync the memory before unmapping the entry
> -	 */
> -	if (orig_addr != INVALID_PHYS_ADDR &&
> -	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> -	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
> -		swiotlb_bounce(orig_addr + offset,
> -			       tlb_addr, size, DMA_FROM_DEVICE);
> -
> -	if (attrs & DMA_ATTR_BOUNCE_PAGE) {
> -		unsigned long pgsize = get_iommu_pgsize(hwdev, tlb_addr, size);
> -
> -		swiotlb_tbl_free_tlb(hwdev,
> -				     ALIGN_DOWN(tlb_addr, pgsize), pgsize);
> -	} else {
> -		swiotlb_tbl_free_tlb(hwdev, tlb_addr, size);
> -	}
> -}
> -
>   void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
>   			     size_t size, enum dma_data_direction dir,
>   			     enum dma_sync_target target)
> @@ -727,14 +662,14 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
>   
>   	/* Oh well, have to allocate and map a bounce buffer. */
>   	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
> -			*phys, size, dir, attrs);
> +			*phys, size, size, dir, attrs);
>   	if (*phys == DMA_MAPPING_ERROR)
>   		return false;
>   
>   	/* Ensure that the address returned is DMA'ble */
>   	*dma_addr = __phys_to_dma(dev, *phys);
>   	if (unlikely(!dma_capable(dev, *dma_addr, size))) {
> -		swiotlb_tbl_unmap_single(dev, *phys, size, dir,
> +		swiotlb_tbl_unmap_single(dev, *phys, size, size, dir,
>   			attrs | DMA_ATTR_SKIP_CPU_SYNC);
>   		return false;
>   	}
> 
