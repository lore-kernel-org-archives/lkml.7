Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F069C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC0720862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BQ5Zffl+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404036AbfFJPzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:55:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49910 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404005AbfFJPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:55:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AFmuiO169598;
        Mon, 10 Jun 2019 15:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=n55ozwFz00A2KXGo1PAw80PdY3qKDI+uXTKqCoomPkY=;
 b=BQ5Zffl+TUiRH63AoxY92oX/Nzh4tQGsrw5TSYg5FlwSnXdLuIKfqq849q7/25mdFYde
 hAN/yDutH24429pk+UzaCsUwqkBOsUtKKLao3W//sIL0kLuyH8vEQcF4vjcwLq/uzL5B
 I/Jjor3ZeUiMKNhF7g+imOX1kY2rpJS4TXZk27rQC0KKm/k3aN8TK3foNy8KP9HZMaIx
 bzenZVap8QoggkT8mvMfUAH8ldOmuBBm7706wje0EmeKdsASWiiGXFGCiMRl5b4oyiFI
 GyaiM8bQGD6RjN0JiuAGOr8nj4b0grq1YJXN8C4ZAV5WIenqjLkScTXYn7L1Fe+/cy3z 4g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t04etft6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 15:54:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AFsjhj185210;
        Mon, 10 Jun 2019 15:54:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t1jpgxq6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 15:54:56 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5AFsrD1000784;
        Mon, 10 Jun 2019 15:54:53 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 08:54:52 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 1C7CE6A00FC; Mon, 10 Jun 2019 11:56:15 -0400 (EDT)
Date:   Mon, 10 Jun 2019 11:56:15 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH v4 4/9] iommu: Add bounce page APIs
Message-ID: <20190610155614.GV28796@char.us.oracle.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
 <20190603011620.31999-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603011620.31999-5-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:16:15AM +0800, Lu Baolu wrote:
> IOMMU hardware always use paging for DMA remapping.  The
> minimum mapped window is a page size. The device drivers
> may map buffers not filling whole IOMMU window. It allows
> device to access to possibly unrelated memory and various
> malicious devices can exploit this to perform DMA attack.
> 
> This introduces the bouce buffer mechanism for DMA buffers
> which doesn't fill a minimal IOMMU page. It could be used
> by various vendor specific IOMMU drivers as long as the
> DMA domain is managed by the generic IOMMU layer. Below
> APIs are added:
> 
> * iommu_bounce_map(dev, addr, paddr, size, dir, attrs)
>   - Map a buffer start at DMA address @addr in bounce page
>     manner. For buffer parts that doesn't cross a whole
>     minimal IOMMU page, the bounce page policy is applied.
>     A bounce page mapped by swiotlb will be used as the DMA
>     target in the IOMMU page table. Otherwise, the physical
>     address @paddr is mapped instead.
> 
> * iommu_bounce_unmap(dev, addr, size, dir, attrs)
>   - Unmap the buffer mapped with iommu_bounce_map(). The bounce
>     page will be torn down after the bounced data get synced.
> 
> * iommu_bounce_sync(dev, addr, size, dir, target)
>   - Synce the bounced data in case the bounce mapped buffer is
>     reused.
> 
> The whole APIs are included within a kernel option IOMMU_BOUNCE_PAGE.
> It's useful for cases where bounce page doesn't needed, for example,
> embedded cases.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/Kconfig |  14 +++++
>  drivers/iommu/iommu.c | 119 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h |  35 +++++++++++++
>  3 files changed, 168 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 83664db5221d..d837ec3f359b 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -86,6 +86,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
>  
>  	  If unsure, say N here.
>  
> +config IOMMU_BOUNCE_PAGE
> +	bool "Use bounce page for untrusted devices"
> +	depends on IOMMU_API
> +	select SWIOTLB

I think you want:
	depends on IOMMU_API && SWIOTLB

As people may want to have IOMMU and SWIOTLB, and not IOMMU_BOUNCE_PAGE enabled.

> +	help
> +	  IOMMU hardware always use paging for DMA remapping. The minimum
> +	  mapped window is a page size. The device drivers may map buffers
> +	  not filling whole IOMMU window. This allows device to access to
> +	  possibly unrelated memory and malicious device can exploit this
> +	  to perform a DMA attack. Select this to use a bounce page for the
> +	  buffer which doesn't fill a whole IOMU page.
> +
> +	  If unsure, say N here.
> +
>  config OF_IOMMU
>         def_bool y
>         depends on OF && IOMMU_API
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 2a906386bb8e..fa44f681a82b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2246,3 +2246,122 @@ int iommu_sva_get_pasid(struct iommu_sva *handle)
>  	return ops->sva_get_pasid(handle);
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> +
> +#ifdef CONFIG_IOMMU_BOUNCE_PAGE
> +
> +/*
> + * Bounce buffer support for external devices:
> + *
> + * IOMMU hardware always use paging for DMA remapping. The minimum mapped
> + * window is a page size. The device drivers may map buffers not filling
> + * whole IOMMU window. This allows device to access to possibly unrelated
> + * memory and malicious device can exploit this to perform a DMA attack.
> + * Use bounce pages for the buffer which doesn't fill whole IOMMU pages.
> + */
> +
> +static inline size_t
> +get_aligned_size(struct iommu_domain *domain, dma_addr_t addr, size_t size)
> +{
> +	unsigned long page_size = 1 << __ffs(domain->pgsize_bitmap);
> +	unsigned long offset = page_size - 1;
> +
> +	return ALIGN((addr & offset) + size, page_size);
> +}
> +
> +dma_addr_t iommu_bounce_map(struct device *dev, dma_addr_t iova,
> +			    phys_addr_t paddr, size_t size,
> +			    enum dma_data_direction dir,
> +			    unsigned long attrs)
> +{
> +	struct iommu_domain *domain;
> +	unsigned int min_pagesz;
> +	phys_addr_t tlb_addr;
> +	size_t aligned_size;
> +	int prot = 0;
> +	int ret;
> +
> +	domain = iommu_get_dma_domain(dev);
> +	if (!domain)
> +		return DMA_MAPPING_ERROR;
> +
> +	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
> +		prot |= IOMMU_READ;
> +	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
> +		prot |= IOMMU_WRITE;
> +
> +	aligned_size = get_aligned_size(domain, paddr, size);
> +	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
> +
> +	/*
> +	 * If both the physical buffer start address and size are
> +	 * page aligned, we don't need to use a bounce page.
> +	 */
> +	if (!IS_ALIGNED(paddr | size, min_pagesz)) {
> +		tlb_addr = swiotlb_tbl_map_single(dev,
> +				__phys_to_dma(dev, io_tlb_start),
> +				paddr, size, aligned_size, dir, attrs);
> +		if (tlb_addr == DMA_MAPPING_ERROR)
> +			return DMA_MAPPING_ERROR;
> +	} else {
> +		tlb_addr = paddr;
> +	}
> +
> +	ret = iommu_map(domain, iova, tlb_addr, aligned_size, prot);
> +	if (ret) {
> +		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
> +					 aligned_size, dir, attrs);
> +		return DMA_MAPPING_ERROR;
> +	}
> +
> +	return iova;
> +}
> +EXPORT_SYMBOL_GPL(iommu_bounce_map);
> +
> +static inline phys_addr_t
> +iova_to_tlb_addr(struct iommu_domain *domain, dma_addr_t addr)
> +{
> +	if (unlikely(!domain->ops || !domain->ops->iova_to_phys))
> +		return 0;
> +
> +	return domain->ops->iova_to_phys(domain, addr);
> +}
> +
> +void iommu_bounce_unmap(struct device *dev, dma_addr_t iova, size_t size,
> +			enum dma_data_direction dir, unsigned long attrs)
> +{
> +	struct iommu_domain *domain;
> +	phys_addr_t tlb_addr;
> +	size_t aligned_size;
> +
> +	domain = iommu_get_dma_domain(dev);
> +	if (WARN_ON(!domain))
> +		return;
> +
> +	aligned_size = get_aligned_size(domain, iova, size);
> +	tlb_addr = iova_to_tlb_addr(domain, iova);
> +	if (WARN_ON(!tlb_addr))
> +		return;
> +
> +	iommu_unmap(domain, iova, aligned_size);
> +	if (is_swiotlb_buffer(tlb_addr))
> +		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
> +					 aligned_size, dir, attrs);
> +}
> +EXPORT_SYMBOL_GPL(iommu_bounce_unmap);
> +
> +void iommu_bounce_sync(struct device *dev, dma_addr_t addr, size_t size,
> +		       enum dma_data_direction dir, enum dma_sync_target target)
> +{
> +	struct iommu_domain *domain;
> +	phys_addr_t tlb_addr;
> +
> +	domain = iommu_get_dma_domain(dev);
> +	if (WARN_ON(!domain))
> +		return;
> +
> +	tlb_addr = iova_to_tlb_addr(domain, addr);
> +	if (is_swiotlb_buffer(tlb_addr))
> +		swiotlb_tbl_sync_single(dev, tlb_addr, size, dir, target);
> +}
> +EXPORT_SYMBOL_GPL(iommu_bounce_sync);
> +#endif /* CONFIG_IOMMU_BOUNCE_PAGE */
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 91af22a344e2..814c0da64692 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -25,6 +25,8 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <linux/swiotlb.h>
> +#include <linux/dma-direct.h>
>  
>  #define IOMMU_READ	(1 << 0)
>  #define IOMMU_WRITE	(1 << 1)
> @@ -499,6 +501,39 @@ int iommu_sva_set_ops(struct iommu_sva *handle,
>  		      const struct iommu_sva_ops *ops);
>  int iommu_sva_get_pasid(struct iommu_sva *handle);
>  
> +#ifdef CONFIG_IOMMU_BOUNCE_PAGE
> +dma_addr_t iommu_bounce_map(struct device *dev, dma_addr_t iova,
> +			    phys_addr_t paddr, size_t size,
> +			    enum dma_data_direction dir,
> +			    unsigned long attrs);
> +void iommu_bounce_unmap(struct device *dev, dma_addr_t iova, size_t size,
> +			enum dma_data_direction dir, unsigned long attrs);
> +void iommu_bounce_sync(struct device *dev, dma_addr_t addr, size_t size,
> +		       enum dma_data_direction dir,
> +		       enum dma_sync_target target);
> +#else
> +static inline
> +dma_addr_t iommu_bounce_map(struct device *dev, dma_addr_t iova,
> +			    phys_addr_t paddr, size_t size,
> +			    enum dma_data_direction dir,
> +			    unsigned long attrs)
> +{
> +	return DMA_MAPPING_ERROR;
> +}
> +
> +static inline
> +void iommu_bounce_unmap(struct device *dev, dma_addr_t iova, size_t size,
> +			enum dma_data_direction dir, unsigned long attrs)
> +{
> +}
> +
> +static inline
> +void iommu_bounce_sync(struct device *dev, dma_addr_t addr, size_t size,
> +		       enum dma_data_direction dir, enum dma_sync_target target)
> +{
> +}
> +#endif /* CONFIG_IOMMU_BOUNCE_PAGE */
> +
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> -- 
> 2.17.1
> 
