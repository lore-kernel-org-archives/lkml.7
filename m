Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F16BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D128F218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zr7PbJD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfLSNKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:10:18 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33400 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfLSNKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:10:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJD9qoB119219;
        Thu, 19 Dec 2019 07:09:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576760992;
        bh=KPTaXXChfGBr8xeIZyTJTzwL0VMjgUoCfi9xmVb1/QQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Zr7PbJD0v5nO6UIOrFxPn4K/g2xlUgJrKdWMY4RiXc7AJffkOo/7BnMxkJntVI7gc
         NduzKu+KiLjOxdZze5UG3WPykLx9Gsg12dnSWffU7GANZ7G5vbdMs6eRw5xC/SgTwX
         L9D0EzprnKdontG2ksaAAw9G6zfxJPz+hQv3u9zI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBJD9qM8016350
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Dec 2019 07:09:52 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 07:09:52 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 07:09:52 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJD9nhP078884;
        Thu, 19 Dec 2019 07:09:50 -0600
Subject: Re: [PATCH 2/2] arm: use swiotlb for bounce buffer on LPAE configs
To:     Christoph Hellwig <hch@lst.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20190709142011.24984-1-hch@lst.de>
 <20190709142011.24984-3-hch@lst.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <9bbd87c2-5b6c-069c-dd22-5105dc827428@ti.com>
Date:   Thu, 19 Dec 2019 15:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190709142011.24984-3-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/07/2019 17.20, Christoph Hellwig wrote:
> The DMA API requires that 32-bit DMA masks are always supported, but on
> arm LPAE configs they do not currently work when memory is present
> above 4GB.  Wire up the swiotlb code like for all other architectures
> to provide the bounce buffering in that case.

bisect pointed me to this commit as the reason why EDMA fails to probe and sdhci is falling back to PIO mode (not using it's built in DMA).

In both cases the reason is that
dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
fails, because dma_direct_supported() is returning false.


Prints inside dma_direct_supported():
sdhci-omap 23000000.mmc: max_pfn: 880000
sdhci-omap 23000000.mmc: min_mask #1: ffffff
sdhci-omap 23000000.mmc: min_mask #2: ffffff
sdhci-omap 23000000.mmc: dev->dma_pfn_offset: 780000
sdhci-omap 23000000.mmc: PAGE_SHIFT: 12
sdhci-omap 23000000.mmc: __phys_to_dma(dev, min_mask): ff880ffffff
sdhci-omap 23000000.mmc: mask: ffffffff

Print in dma_supported() after returning from dma_direct_supported():
sdhci-omap 23000000.mmc: dma_is_direct, ret = 0

sdhci-omap 23100000.mmc: DMA is not supported for the device

keystone-k2g have this in soc0 node:
dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;

DDR starts at 0x8 0000 0000 (8G) and 2G is aliased at 0x8000 0000.

This gives the 0x780000 for dma_pfn_offset for all devices underneath it.

The DMA_BIT_MASK(24) is passed to __phys_to_dma() because CONFIG_ZONE_DMA is enabled.

SWIOTLB is enabled in kconfig.

I'm not sure how to correctly fix it, but the following patch makes things working:

From b682a61776f0861755c9d54e5ebccf8471d85bfd Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 19 Dec 2019 15:07:25 +0200
Subject: [PATCH] arm: mm: dma-mapping: Fix dma_supported() when
 dev->dma_pfn_offset is not 0

We can only use direct mapping when LPAE is enabled if the dma_pfn_offset
is 0, otherwise valid dma_masks will be rejected and the DMA support is
going to be denied for peripherals, or DMA drivers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mm/dma-mapping.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7d042d5c43e3..bf199b1e82bd 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1100,15 +1100,6 @@ int arm_dma_supported(struct device *dev, u64 mask)
 
 static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 {
-	/*
-	 * When CONFIG_ARM_LPAE is set, physical address can extend above
-	 * 32-bits, which then can't be addressed by devices that only support
-	 * 32-bit DMA.
-	 * Use the generic dma-direct / swiotlb ops code in that case, as that
-	 * handles bounce buffering for us.
-	 */
-	if (IS_ENABLED(CONFIG_ARM_LPAE))
-		return NULL;
 	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
 }
 
@@ -2309,6 +2300,15 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
 		dma_ops = arm_get_iommu_dma_map_ops(coherent);
+	else if (IS_ENABLED(CONFIG_ARM_LPAE) && !dev->dma_pfn_offset)
+		/*
+		 * When CONFIG_ARM_LPAE is set, physical address can extend
+		 * above * 32-bits, which then can't be addressed by devices
+		 * that only support 32-bit DMA.
+		 * Use the generic dma-direct / swiotlb ops code in that case,
+		 * as that handles bounce buffering for us.
+		 */
+		dma_ops = NULL;
 	else
 		dma_ops = arm_get_dma_map_ops(coherent);
 
-- 
- Péter

> Fixes: 21e07dba9fb11 ("scsi: reduce use of block bounce buffers").
> Reported-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/include/asm/dma-mapping.h |  4 +-
>  arch/arm/mm/Kconfig                |  5 +++
>  arch/arm/mm/dma-mapping.c          | 61 ++++++++++++++++++++++++++++++
>  arch/arm/mm/init.c                 |  5 +++
>  4 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 03ba90ffc0f8..054119cd7757 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -18,7 +18,9 @@ extern const struct dma_map_ops arm_coherent_dma_ops;
>  
>  static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>  {
> -	return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : NULL;
> +	if (IS_ENABLED(CONFIG_MMU) && !IS_ENABLED(CONFIG_ARM_LPAE))
> +		return &arm_dma_ops;
> +	return NULL;
>  }
>  
>  #ifdef __arch_page_to_dma
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index b169e580bf82..2dd36183d0e6 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -663,6 +663,11 @@ config ARM_LPAE
>  	depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
>  		!CPU_32v4 && !CPU_32v3
>  	select PHYS_ADDR_T_64BIT
> +	select SWIOTLB
> +	select ARCH_HAS_DMA_COHERENT_TO_PFN
> +	select ARCH_HAS_DMA_MMAP_PGPROT
> +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +	select ARCH_HAS_SYNC_DMA_FOR_CPU
>  	help
>  	  Say Y if you have an ARMv7 processor supporting the LPAE page
>  	  table format and you would like to access memory beyond the
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index bdf0d236aaee..01a5b96d76a7 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma-noncoherent.h>
>  #include <linux/dma-contiguous.h>
>  #include <linux/highmem.h>
>  #include <linux/memblock.h>
> @@ -1129,6 +1130,19 @@ int arm_dma_supported(struct device *dev, u64 mask)
>  
>  static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
>  {
> +	/*
> +	 * When CONFIG_ARM_LPAE is set, physical address can extend above
> +	 * 32-bits, which then can't be addressed by devices that only support
> +	 * 32-bit DMA.
> +	 * Use the generic dma-direct / swiotlb ops code in that case, as that
> +	 * handles bounce buffering for us.
> +	 *
> +	 * Note: this checks CONFIG_ARM_LPAE instead of CONFIG_SWIOTLB as the
> +	 * latter is also selected by the Xen code, but that code for now relies
> +	 * on non-NULL dev_dma_ops.  To be cleaned up later.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM_LPAE))
> +		return NULL;
>  	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
>  }
>  
> @@ -2333,6 +2347,9 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	const struct dma_map_ops *dma_ops;
>  
>  	dev->archdata.dma_coherent = coherent;
> +#ifdef CONFIG_SWIOTLB
> +	dev->dma_coherent = coherent;
> +#endif
>  
>  	/*
>  	 * Don't override the dma_ops if they have already been set. Ideally
> @@ -2367,3 +2384,47 @@ void arch_teardown_dma_ops(struct device *dev)
>  	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
>  	set_dma_ops(dev, NULL);
>  }
> +
> +#ifdef CONFIG_SWIOTLB
> +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> +		size_t size, enum dma_data_direction dir)
> +{
> +	__dma_page_cpu_to_dev(phys_to_page(paddr), paddr & (PAGE_SIZE - 1),
> +			      size, dir);
> +}
> +
> +void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
> +		size_t size, enum dma_data_direction dir)
> +{
> +	__dma_page_dev_to_cpu(phys_to_page(paddr), paddr & (PAGE_SIZE - 1),
> +			      size, dir);
> +}
> +
> +long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
> +		dma_addr_t dma_addr)
> +{
> +	return dma_to_pfn(dev, dma_addr);
> +}
> +
> +pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
> +		unsigned long attrs)
> +{
> +	if (!dev_is_dma_coherent(dev))
> +		return __get_dma_pgprot(attrs, prot);
> +	return prot;
> +}
> +
> +void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> +		gfp_t gfp, unsigned long attrs)
> +{
> +	return __dma_alloc(dev, size, dma_handle, gfp,
> +			   __get_dma_pgprot(attrs, PAGE_KERNEL), false,
> +			   attrs, __builtin_return_address(0));
> +}
> +
> +void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
> +		dma_addr_t dma_handle, unsigned long attrs)
> +{
> +	__arm_dma_free(dev, size, cpu_addr, dma_handle, attrs, false);
> +}
> +#endif /* CONFIG_SWIOTLB */
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index be0b42937888..64541be15d43 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -24,6 +24,7 @@
>  #include <linux/dma-contiguous.h>
>  #include <linux/sizes.h>
>  #include <linux/stop_machine.h>
> +#include <linux/swiotlb.h>
>  
>  #include <asm/cp15.h>
>  #include <asm/mach-types.h>
> @@ -456,6 +457,10 @@ void __init mem_init(void)
>  	extern u32 itcm_end;
>  #endif
>  
> +#ifdef CONFIG_ARM_LPAE
> +	swiotlb_init(1);
> +#endif
> +
>  	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
>  
>  	/* this will put all unused low memory onto the freelists */
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
