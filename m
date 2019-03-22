Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A46C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8515C21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfCVOnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:43:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727719AbfCVOnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:43:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A877160326F883332D7C;
        Fri, 22 Mar 2019 22:43:14 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:43:03 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/1] iommu: Add config option to set lazy mode as default
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190322141121.18428-1-thunder.leizhen@huawei.com>
CC:     Hanjun Guo <guohanjun@huawei.com>
Message-ID: <8cf20613-7a9a-d4a1-b52e-4b526f2c7ff2@huawei.com>
Date:   Fri, 22 Mar 2019 14:42:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190322141121.18428-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2019 14:11, Zhen Lei wrote:

> This allows the default behaviour to be controlled by a kernel config
> option instead of changing the command line for the kernel to include
> "iommu.strict=0" on ARM64 where this is desired.
>
> This is similar to CONFIG_IOMMU_DEFAULT_PASSTHROUGH
>
> Note: At present, intel_iommu, amd_iommu and s390_iommu use lazy mode as
> defalut, so there is no need to add code for them.

/s/defalut/default/

>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/Kconfig | 14 ++++++++++++++
>  drivers/iommu/iommu.c |  5 +++++

Do we need to update kernel-parameters.txt for iommu.strict?

>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6f07f3b21816c64..5ec9780f564eaf8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -85,6 +85,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
>
>  	  If unsure, say N here.
>
> +config IOMMU_LAZY_MODE

maybe should add "DMA" to the name, and even "DEFAULT"

> +	bool "IOMMU use lazy mode to flush IOTLB and free IOVA"
> +	depends on IOMMU_API
> +	help
> +	  For every IOMMU unmap operation, the flush operation of IOTLB and the free
> +	  operation of IOVA are deferred.

This is a bit unclear, as there is no context. I think that you need to 
say something like, "Support lazy mode, where for every IOMMU DMA unmap 
operation, the flush operation of IOTLB and the free operation of IOVA 
are deferred. "


They are only guaranteed to be done before
> +	  the related IOVA will be reused. Removing the need to pass in iommu.strict=0
> +	  through command line on ARM64(Now, intel_iommu, amd_iommu, s390_iommu use
> +	  lazy mode as deault).

prone to going out-of-date

  If this is enabled, you can still disable with kernel
> +	  parameters, such as iommu.strict=1, intel_iommu=strict, amd_iommu=fullflush
> +	  or s390_iommu=strict depending on the architecture.
> +
> +	  If unsure, say N here.
> +
>  config OF_IOMMU
>         def_bool y
>         depends on OF && IOMMU_API
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 33a982e33716369..e307d70d1578b3b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -43,7 +43,12 @@
>  #else
>  static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>  #endif
> +
> +#ifdef CONFIG_IOMMU_LAZY_MODE
> +static bool iommu_dma_strict __read_mostly;
> +#else
>  static bool iommu_dma_strict __read_mostly = true;
> +#endif
>
>  struct iommu_callback_data {
>  	const struct iommu_ops *ops;
> --
> 1.8.3
>
>
>

Cheers



