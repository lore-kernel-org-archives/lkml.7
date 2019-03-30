Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9DDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 10:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E97D218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 10:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfC3Kn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 06:43:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730372AbfC3Kn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 06:43:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0776732697C53D56B0E6;
        Sat, 30 Mar 2019 18:43:24 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Sat, 30 Mar 2019
 18:43:16 +0800
Subject: Re: [PATCH v3 1/1] iommu: Add config option to set lazy mode as
 default
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190329025423.15484-1-thunder.leizhen@huawei.com>
CC:     S390 <linux-s390@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5C9F4843.9010307@huawei.com>
Date:   Sat, 30 Mar 2019 18:43:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190329025423.15484-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/29 10:54, Zhen Lei wrote:
> This allows the default behaviour to be controlled by a kernel config
> option instead of changing the command line for the kernel to include
> "iommu.strict=0" on ARM64 where this is desired.
> 
> This is similar to CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/s390/pci/pci_dma.c        |  4 ++++
>  drivers/iommu/Kconfig          | 15 +++++++++++++++
>  drivers/iommu/amd_iommu_init.c |  6 +++++-
>  drivers/iommu/intel-iommu.c    |  4 ++++
>  drivers/iommu/iommu.c          |  5 +++++
>  5 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
> index 9e52d1527f71495..d05e8c3820793c5 100644
> --- a/arch/s390/pci/pci_dma.c
> +++ b/arch/s390/pci/pci_dma.c
> @@ -17,7 +17,11 @@
>  
>  static struct kmem_cache *dma_region_table_cache;
>  static struct kmem_cache *dma_page_table_cache;
> +#ifdef CONFIG_IOMMU_DMA_DEFAULT_LAZY_MODE
>  static int s390_iommu_strict;
> +#else
> +static int s390_iommu_strict = 1;
> +#endif
>  
>  static int zpci_refresh_global(struct zpci_dev *zdev)
>  {
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6f07f3b21816c64..ed5206a2d316599 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -85,6 +85,21 @@ config IOMMU_DEFAULT_PASSTHROUGH
>  
>  	  If unsure, say N here.
>  
> +config IOMMU_DMA_DEFAULT_LAZY_MODE
> +	bool "IOMMU DMA use lazy mode to flush IOTLB and free IOVA"
> +	depends on IOMMU_API
> +	default y
Hi Robin：

   Should I change to:
+  default y if !(ARM_SMMU || ARM_SMMU_V3)

> +	help
> +	  Support lazy mode, where for every IOMMU DMA unmap operation, the
> +	  flush operation of IOTLB and the free operation of IOVA are deferred.
> +	  They are only guaranteed to be done before the related IOVA will be
> +	  reused. Removing the need to pass in kernel parameters through
> +	  command line. For example, iommu.strict=0 on ARM64. If this is
> +	  enabled, you can still disable with kernel parameters, such as
> +	  iommu.strict=1 depending on the architecture.
> +
> +	  If unsure, say N here.
> +
>  config OF_IOMMU
>         def_bool y
>         depends on OF && IOMMU_API
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index f773792d77fd533..a30805c2f77199c 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -166,7 +166,11 @@ struct ivmd_header {
>  					   to handle */
>  LIST_HEAD(amd_iommu_unity_map);		/* a list of required unity mappings
>  					   we find in ACPI */
> -bool amd_iommu_unmap_flush;		/* if true, flush on every unmap */
> +#ifdef CONFIG_IOMMU_DMA_DEFAULT_LAZY_MODE
> +bool amd_iommu_unmap_flush;
> +#else
> +bool amd_iommu_unmap_flush = true;	/* flush on every unmap */
> +#endif
>  
>  LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
>  					   system */
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 28cb713d728ceef..560191a9342b2b8 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -362,7 +362,11 @@ static int domain_detach_iommu(struct dmar_domain *domain,
>  
>  static int dmar_map_gfx = 1;
>  static int dmar_forcedac;
> +#ifdef CONFIG_IOMMU_DMA_DEFAULT_LAZY_MODE
>  static int intel_iommu_strict;
> +#else
> +static int intel_iommu_strict = 1;
> +#endif
>  static int intel_iommu_superpage = 1;
>  static int intel_iommu_sm;
>  static int iommu_identity_mapping;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 33a982e33716369..5acb98e79b5b32d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -43,7 +43,12 @@
>  #else
>  static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>  #endif
> +
> +#ifdef CONFIG_IOMMU_DMA_DEFAULT_LAZY_MODE
> +static bool iommu_dma_strict __read_mostly;
> +#else
>  static bool iommu_dma_strict __read_mostly = true;
> +#endif
>  
>  struct iommu_callback_data {
>  	const struct iommu_ops *ops;
> 

-- 
Thanks!
BestRegards

