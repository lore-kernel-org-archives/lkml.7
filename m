Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D23C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1466C2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbfC0TS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:18:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34010 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388275AbfC0TSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:18:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BCC6374;
        Wed, 27 Mar 2019 12:18:54 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11E143F557;
        Wed, 27 Mar 2019 12:18:52 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] iommu: Add config option to set lazy mode as
 default
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Hanjun Guo <guohanjun@huawei.com>
References: <20190327150030.11112-1-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c80863a8-8ffa-473d-7c5c-3172cb8045de@arm.com>
Date:   Wed, 27 Mar 2019 19:18:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190327150030.11112-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 15:00, Zhen Lei wrote:
> This allows the default behaviour to be controlled by a kernel config
> option instead of changing the command line for the kernel to include
> "iommu.strict=0" on ARM64 where this is desired.
> 
> This is similar to CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
> 
> Note: At present, intel_iommu, amd_iommu and s390_iommu use lazy mode as
> default, so there is no need to add code for them.

That seems a bit self-contradictory - if there's a real need for TLB 
flush behaviour to be statically configurable and not command-line-based 
then why should users of other architectures be exempt?

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/Kconfig | 14 ++++++++++++++
>   drivers/iommu/iommu.c |  5 +++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6f07f3b21816c64..5daa110d0e83a07 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -85,6 +85,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
> 
>   	  If unsure, say N here.
> 
> +config IOMMU_DMA_DEFAULT_LAZY_MODE
> +	bool "IOMMU DMA use lazy mode to flush IOTLB and free IOVA"
> +	depends on IOMMU_API
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
>   config OF_IOMMU
>          def_bool y
>          depends on OF && IOMMU_API
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 33a982e33716369..5acb98e79b5b32d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -43,7 +43,12 @@
>   #else
>   static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>   #endif
> +
> +#ifdef CONFIG_IOMMU_DMA_DEFAULT_LAZY_MODE
> +static bool iommu_dma_strict __read_mostly;
> +#else
>   static bool iommu_dma_strict __read_mostly = true;
> +#endif

For a straightforward boolean, you can simply do:

	static bool foo = IS_ENABLED(CONFIG_FOO);

but that said, I'm still not particularly convinced that there are a 
significant number of users in a position to build and install a custom 
kernel but not edit /etc/default/grub, and who really value the 
combination of less performance than passthrough with less isolation 
than strict.

It's also not necessarily obvious to the user how this interacts with 
IOMMU_DEFAULT_PASSTHROUGH, so if we really do go down this route, maybe 
it would be better to refactor the whole lot into a single selection of 
something like IOMMU_DEFAULT_MODE anyway.

Robin.

> 
>   struct iommu_callback_data {
>   	const struct iommu_ops *ops;
> --
> 1.8.3
> 
> 
