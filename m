Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D2CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E16206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BIuTc9yI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLSPUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:20:31 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51832 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfLSPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:20:30 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBJFK6F4034293;
        Thu, 19 Dec 2019 09:20:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576768806;
        bh=Ka8A++Wgy2YG9+bGEyPwISxJzp8LG98T3zLMp5VZCyw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BIuTc9yIXXTO1iWg42njFB8qnw4gOT/0VVKdEOwmJy0r1HDP8HHL+dIfDBmiX28gG
         w1L33R3jdG1f8d+ORIiPvTvkZphvehQI7dW+kir6SVQEln04TDK0EBAM2lM/M7EHQb
         nl+vk+8sehSds9IlmkXIoPKZQcJZ0iYsuCs4/BlM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBJFK66H089478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Dec 2019 09:20:06 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Dec 2019 09:20:05 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Dec 2019 09:20:05 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBJFK3Ek064843;
        Thu, 19 Dec 2019 09:20:04 -0600
Subject: Re: [PATCH 2/2] arm: use swiotlb for bounce buffer on LPAE configs
To:     Christoph Hellwig <hch@lst.de>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Roger Quadros <rogerq@ti.com>
References: <20190709142011.24984-1-hch@lst.de>
 <20190709142011.24984-3-hch@lst.de>
 <9bbd87c2-5b6c-069c-dd22-5105dc827428@ti.com> <20191219150259.GA3003@lst.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <20106a84-8247-fa78-2381-2c94fad9cb6a@ti.com>
Date:   Thu, 19 Dec 2019 17:20:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191219150259.GA3003@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 19/12/2019 17.02, Christoph Hellwig wrote:
> Hi Peter,
> 
> can you try the patch below (it will need to be split into two):

Thank you!

Unfortunately it does not help:
[    0.596208] edma: probe of 2700000.edma failed with error -5
[    0.596626] edma: probe of 2728000.edma failed with error -5
...
[    2.108602] sdhci-omap 23000000.mmc: Got CD GPIO
[    2.113899] mmc0: Failed to set 32-bit DMA mask.
[    2.118592] mmc0: No suitable DMA available - falling back to PIO
[    2.159038] mmc0: SDHCI controller on 23000000.mmc [23000000.mmc]
using PIO
[    2.167531] mmc1: Failed to set 32-bit DMA mask.
[    2.172192] mmc1: No suitable DMA available - falling back to PIO
[    2.213841] mmc1: SDHCI controller on 23100000.mmc [23100000.mmc]
using PIO

- Péter


> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index e822af0d9219..30b9c6786ce3 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -221,7 +221,8 @@ EXPORT_SYMBOL(arm_coherent_dma_ops);
>  
>  static int __dma_supported(struct device *dev, u64 mask, bool warn)
>  {
> -	unsigned long max_dma_pfn = min(max_pfn, arm_dma_pfn_limit);
> +	unsigned long max_dma_pfn =
> +		min_t(unsigned long, max_pfn, zone_dma_limit >> PAGE_SHIFT);
>  
>  	/*
>  	 * Translate the device's DMA mask to a PFN limit.  This
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 3ef204137e73..dd0e169a1bb1 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -19,6 +19,7 @@
>  #include <linux/gfp.h>
>  #include <linux/memblock.h>
>  #include <linux/dma-contiguous.h>
> +#include <linux/dma-direct.h>
>  #include <linux/sizes.h>
>  #include <linux/stop_machine.h>
>  #include <linux/swiotlb.h>
> @@ -84,15 +85,6 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
>  phys_addr_t arm_dma_zone_size __read_mostly;
>  EXPORT_SYMBOL(arm_dma_zone_size);
>  
> -/*
> - * The DMA mask corresponding to the maximum bus address allocatable
> - * using GFP_DMA.  The default here places no restriction on DMA
> - * allocations.  This must be the smallest DMA mask in the system,
> - * so a successful GFP_DMA allocation will always satisfy this.
> - */
> -phys_addr_t arm_dma_limit;
> -unsigned long arm_dma_pfn_limit;
> -
>  static void __init arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
>  	unsigned long dma_size)
>  {
> @@ -108,14 +100,14 @@ static void __init arm_adjust_dma_zone(unsigned long *size, unsigned long *hole,
>  
>  void __init setup_dma_zone(const struct machine_desc *mdesc)
>  {
> -#ifdef CONFIG_ZONE_DMA
> -	if (mdesc->dma_zone_size) {
> +	if (!IS_ENABLED(CONFIG_ZONE_DMA)) {
> +		zone_dma_limit = ((phys_addr_t)~0);
> +	} else if (mdesc->dma_zone_size) {
>  		arm_dma_zone_size = mdesc->dma_zone_size;
> -		arm_dma_limit = PHYS_OFFSET + arm_dma_zone_size - 1;
> -	} else
> -		arm_dma_limit = 0xffffffff;
> -	arm_dma_pfn_limit = arm_dma_limit >> PAGE_SHIFT;
> -#endif
> +		zone_dma_limit = PHYS_OFFSET + arm_dma_zone_size - 1;
> +	} else {
> +		zone_dma_limit = 0xffffffff;
> +	}
>  }
>  
>  static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
> @@ -279,7 +271,7 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
>  	early_init_fdt_scan_reserved_mem();
>  
>  	/* reserve memory for DMA contiguous allocations */
> -	dma_contiguous_reserve(arm_dma_limit);
> +	dma_contiguous_reserve(zone_dma_limit);
>  
>  	arm_memblock_steal_permitted = false;
>  	memblock_dump_all();
> diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
> index 88c121ac14b3..7dbd77554273 100644
> --- a/arch/arm/mm/mm.h
> +++ b/arch/arm/mm/mm.h
> @@ -82,14 +82,6 @@ extern __init void add_static_vm_early(struct static_vm *svm);
>  
>  #endif
>  
> -#ifdef CONFIG_ZONE_DMA
> -extern phys_addr_t arm_dma_limit;
> -extern unsigned long arm_dma_pfn_limit;
> -#else
> -#define arm_dma_limit ((phys_addr_t)~0)
> -#define arm_dma_pfn_limit (~0ul >> PAGE_SHIFT)
> -#endif
> -
>  extern phys_addr_t arm_lowmem_limit;
>  
>  void __init bootmem_init(void);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index b65dffdfb201..7a7501acd763 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -441,7 +441,7 @@ void __init arm64_memblock_init(void)
>  	early_init_fdt_scan_reserved_mem();
>  
>  	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> -		zone_dma_bits = ARM64_ZONE_DMA_BITS;
> +		zone_dma_limit = DMA_BIT_MASK(ARM64_ZONE_DMA_BITS);
>  		arm64_dma_phys_limit = max_zone_phys(ARM64_ZONE_DMA_BITS);
>  	}
>  
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 9488b63dfc87..337ace03d3f0 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -223,7 +223,7 @@ static int __init mark_nonram_nosave(void)
>   * everything else. GFP_DMA32 page allocations automatically fall back to
>   * ZONE_DMA.
>   *
> - * By using 31-bit unconditionally, we can exploit zone_dma_bits to inform the
> + * By using 31-bit unconditionally, we can exploit zone_dma_limit to inform the
>   * generic DMA mapping code.  32-bit only devices (if not handled by an IOMMU
>   * anyway) will take a first dip into ZONE_NORMAL and get otherwise served by
>   * ZONE_DMA.
> @@ -257,18 +257,20 @@ void __init paging_init(void)
>  	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
>  	       (long int)((top_of_ram - total_ram) >> 20));
>  
> +#ifdef CONFIG_ZONE_DMA
>  	/*
>  	 * Allow 30-bit DMA for very limited Broadcom wifi chips on many
>  	 * powerbooks.
>  	 */
> -	if (IS_ENABLED(CONFIG_PPC32))
> -		zone_dma_bits = 30;
> -	else
> -		zone_dma_bits = 31;
> -
> -#ifdef CONFIG_ZONE_DMA
> -	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
> -				      1UL << (zone_dma_bits - PAGE_SHIFT));
> +	if (IS_ENABLED(CONFIG_PPC32)) {
> +		zone_dma_limit = DMA_BIT_MASK(30);
> +		max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
> +					      1UL << (30 - PAGE_SHIFT));
> +	} else {
> +		zone_dma_limit = DMA_BIT_MASK(31);
> +		max_zone_pfns[ZONE_DMA]	= min(max_low_pfn,
> +					      1UL << (31 - PAGE_SHIFT));
> +	}
>  #endif
>  	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
>  #ifdef CONFIG_HIGHMEM
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index f0ce22220565..c403f61cb56b 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -118,7 +118,7 @@ void __init paging_init(void)
>  
>  	sparse_memory_present_with_active_regions(MAX_NUMNODES);
>  	sparse_init();
> -	zone_dma_bits = 31;
> +	zone_dma_limit = DMA_BIT_MASK(31);
>  	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(MAX_DMA_ADDRESS);
>  	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 24b8684aa21d..20d56d597506 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -6,7 +6,7 @@
>  #include <linux/memblock.h> /* for min_low_pfn */
>  #include <linux/mem_encrypt.h>
>  
> -extern unsigned int zone_dma_bits;
> +extern phys_addr_t zone_dma_limit;
>  
>  #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>  #include <asm/dma-direct.h>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 6af7ae83c4ad..5ea1bed2ba6f 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -21,7 +21,7 @@
>   * it for entirely different regions. In that case the arch code needs to
>   * override the variable below for dma-direct to work properly.
>   */
> -unsigned int zone_dma_bits __ro_after_init = 24;
> +phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>  
>  static void report_addr(struct device *dev, dma_addr_t dma_addr, size_t size)
>  {
> @@ -74,7 +74,7 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
>  	 * Note that GFP_DMA32 and GFP_DMA are no ops without the corresponding
>  	 * zones.
>  	 */
> -	if (*phys_limit <= DMA_BIT_MASK(zone_dma_bits))
> +	if (*phys_limit <= zone_dma_limit)
>  		return GFP_DMA;
>  	if (*phys_limit <= DMA_BIT_MASK(32))
>  		return GFP_DMA32;
> @@ -483,7 +483,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>  	u64 min_mask;
>  
>  	if (IS_ENABLED(CONFIG_ZONE_DMA))
> -		min_mask = DMA_BIT_MASK(zone_dma_bits);
> +		min_mask = zone_dma_limit;
>  	else
>  		min_mask = DMA_BIT_MASK(32);
>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
