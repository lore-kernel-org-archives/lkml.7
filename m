Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC87C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D674C2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfG2MNA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:13:00 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33103 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbfG2MNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:13:00 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6CF1177BEB65B21DC160;
        Mon, 29 Jul 2019 13:12:58 +0100 (IST)
Received: from LHREML524-MBB.china.huawei.com ([169.254.3.194]) by
 LHREML711-CAH.china.huawei.com ([10.201.108.34]) with mapi id 14.03.0415.000;
 Mon, 29 Jul 2019 13:12:48 +0100
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
CC:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: RE: [PATCH 07/24] iommu/dma: Move domain lookup into
 __iommu_dma_{map,      unmap}
Thread-Topic: [PATCH 07/24] iommu/dma: Move domain lookup into
 __iommu_dma_{map,      unmap}
Thread-Index: AQHVDt4W3gOYMtyd7EGom44w8Atw56bh634g
Date:   Mon, 29 Jul 2019 12:12:48 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F328FAB@lhreml524-mbb.china.huawei.com>
References: <20190520072948.11412-1-hch@lst.de>
 <20190520072948.11412-8-hch@lst.de>
In-Reply-To: <20190520072948.11412-8-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

> -----Original Message-----
> From: iommu-bounces@lists.linux-foundation.org
> [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf Of Christoph
> Hellwig
> Sent: 20 May 2019 08:30
> To: Robin Murphy <robin.murphy@arm.com>
> Cc: Tom Murphy <tmurphy@arista.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Will Deacon <will.deacon@arm.com>;
> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> linux-arm-kernel@lists.infradead.org
> Subject: [PATCH 07/24] iommu/dma: Move domain lookup into
> __iommu_dma_{map, unmap}
> 
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Most of the callers don't care, and the couple that do already have the
> domain to hand for other reasons are in slow paths where the (trivial)
> overhead of a repeated lookup will be utterly immaterial.

On a Hisilicon ARM64 platform with 5.3-rc1, a F_TRANSALTION error from
smmuv3 is reported when an attempt is made to assign a ixgbe vf dev to a
Guest. 

[  196.747107] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x10 received:
[  196.747109] arm-smmu-v3 arm-smmu-v3.0.auto: 0x00000180 00000010
[  196.747110] arm-smmu-v3 arm-smmu-v3.0.auto: 0x0000020100000000
[  196.747111] arm-smmu-v3 arm-smmu-v3.0.auto: 0x00000000ffffe040
[  196.747113] arm-smmu-v3 arm-smmu-v3.0.auto: 0x00000000ffffe000

Git bisect points to this patch.

Please see below.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [hch: dropped the hunk touching iommu_dma_get_msi_page to avoid a
>  conflict with another series]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/dma-iommu.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c406abe3be01..6ece8f477fc8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -448,9 +448,10 @@ static void iommu_dma_free_iova(struct
> iommu_dma_cookie *cookie,
>  				size >> iova_shift(iovad));
>  }
> 
> -static void __iommu_dma_unmap(struct iommu_domain *domain,
> dma_addr_t dma_addr,
> +static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
>  		size_t size)
>  {
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iova_domain *iovad = &cookie->iovad;
>  	size_t iova_off = iova_offset(iovad, dma_addr);
> @@ -465,8 +466,9 @@ static void __iommu_dma_unmap(struct
> iommu_domain *domain, dma_addr_t dma_addr,
>  }
> 
>  static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> -		size_t size, int prot, struct iommu_domain *domain)
> +		size_t size, int prot)
>  {
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	size_t iova_off = 0;
>  	dma_addr_t iova;
> @@ -565,7 +567,7 @@ static struct page
> **__iommu_dma_alloc_pages(struct device *dev,
>  static void __iommu_dma_free(struct device *dev, struct page **pages,
>  		size_t size, dma_addr_t *handle)
>  {
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), *handle, size);
> +	__iommu_dma_unmap(dev, *handle, size);
>  	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
>  	*handle = DMA_MAPPING_ERROR;
>  }
> @@ -718,14 +720,13 @@ static void iommu_dma_sync_sg_for_device(struct
> device *dev,
>  static dma_addr_t __iommu_dma_map_page(struct device *dev, struct page
> *page,
>  		unsigned long offset, size_t size, int prot)
>  {
> -	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot,
> -			iommu_get_dma_domain(dev));
> +	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot);
>  }
> 
>  static void __iommu_dma_unmap_page(struct device *dev, dma_addr_t
> handle,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
> +	__iommu_dma_unmap(dev, handle, size);
>  }
> 
>  static dma_addr_t iommu_dma_map_page(struct device *dev, struct page
> *page,
> @@ -734,11 +735,10 @@ static dma_addr_t iommu_dma_map_page(struct
> device *dev, struct page *page,
>  {
>  	phys_addr_t phys = page_to_phys(page) + offset;
>  	bool coherent = dev_is_dma_coherent(dev);
> +	int prot = dma_info_to_prot(dir, coherent, attrs);
>  	dma_addr_t dma_handle;
> 
> -	dma_handle =__iommu_dma_map(dev, phys, size,
> -			dma_info_to_prot(dir, coherent, attrs),
> -			iommu_get_dma_domain(dev));
> +	dma_handle =__iommu_dma_map(dev, phys, size, prot);
>  	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>  	    dma_handle != DMA_MAPPING_ERROR)
>  		arch_sync_dma_for_device(dev, phys, size, dir);
> @@ -750,7 +750,7 @@ static void iommu_dma_unmap_page(struct device
> *dev, dma_addr_t dma_handle,
>  {
>  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>  		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), dma_handle,
> size);
> +	__iommu_dma_unmap(dev, dma_handle, size);
>  }
> 
>  /*
> @@ -931,21 +931,20 @@ static void iommu_dma_unmap_sg(struct device
> *dev, struct scatterlist *sg,
>  		sg = tmp;
>  	}
>  	end = sg_dma_address(sg) + sg_dma_len(sg);
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), start, end - start);
> +	__iommu_dma_unmap(dev, start, end - start);
>  }
> 
>  static dma_addr_t iommu_dma_map_resource(struct device *dev,
> phys_addr_t phys,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
>  	return __iommu_dma_map(dev, phys, size,
> -			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
> -			iommu_get_dma_domain(dev));
> +			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
>  }
> 
>  static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t
> handle,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> -	__iommu_dma_unmap(iommu_get_dma_domain(dev), handle, size);
> +	__iommu_dma_unmap(dev, handle, size);
>  }
> 
>  static void *iommu_dma_alloc(struct device *dev, size_t size,
> @@ -1222,7 +1221,7 @@ static struct iommu_dma_msi_page
> *iommu_dma_get_msi_page(struct device *dev,
>  	if (!msi_page)
>  		return NULL;
> 
> -	iova = __iommu_dma_map(dev, msi_addr, size, prot, domain);
> +	iova = __iommu_dma_map(dev, msi_addr, size, prot);

I think the domain here is retrieved using iommu_get_domain_for_dev()
which may not be the default domain returned by iommu_get_dma_domain().

Please check and let me know.

Thanks,
Shameer

>  	if (iova == DMA_MAPPING_ERROR)
>  		goto out_free_page;
> --
> 2.20.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
