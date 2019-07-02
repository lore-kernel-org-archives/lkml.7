Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E37C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9938F21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGBMWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:22:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7687 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfGBMWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:22:50 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AC745EE7D815FCDD5B0E;
        Tue,  2 Jul 2019 20:22:46 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 20:22:41 +0800
Subject: Re: linux-next: Tree for Jul 2
To:     Will Deacon <will@kernel.org>, <joro@8bytes.org>
References: <20190702195158.79aa5517@canb.auug.org.au>
 <000f56ac-2abc-bc6a-e2db-5ae38779d276@hisilicon.com>
 <20190702120321.v3224ofd4aaxvytk@willie-the-truck>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Zhangshaokun <zhangshaokun@hisilicon.com>
Message-ID: <8a3bea20-fe65-35ea-43f1-d8f085a097e2@hisilicon.com>
Date:   Tue, 2 Jul 2019 20:22:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20190702120321.v3224ofd4aaxvytk@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2019/7/2 20:03, Will Deacon wrote:
> [+Joerg]
> 
> On Tue, Jul 02, 2019 at 06:40:45PM +0800, Zhangshaokun wrote:
>> +Cc: Will Deacon
>>
>> There is a compiler failure on arm64 platform, as follow:
>> In file included from ./include/linux/list.h:9:0,
>>                  from ./include/linux/kobject.h:19,
>>                  from ./include/linux/of.h:17,
>>                  from ./include/linux/irqdomain.h:35,
>>                  from ./include/linux/acpi.h:13,
>>                  from drivers/iommu/arm-smmu-v3.c:12:
>> drivers/iommu/arm-smmu-v3.c: In function ‘arm_smmu_device_hw_probe’:
>> drivers/iommu/arm-smmu-v3.c:194:40: error: ‘CONFIG_CMA_ALIGNMENT’ undeclared (first use in this function)
>>  #define Q_MAX_SZ_SHIFT   (PAGE_SHIFT + CONFIG_CMA_ALIGNMENT)
>>                                         ^
>> It's the commit <d25f6ead162e> ("iommu/arm-smmu-v3: Increase maximum size of queues")
> 
> Thanks for the report. I've provided a fix below.
> 

It works, thanks for the patch,
Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Thanks,
Shaokun

> Joerg -- please can you take this on top of the SMMUv3 patches queued
> for 5.3?
> 
> Cheers,
> 
> Will
> 
> --->8
> 
>>From e8f9d8229e3aaa4817bfb72752e804eec97a3d8d Mon Sep 17 00:00:00 2001
> From: Will Deacon <will@kernel.org>
> Date: Tue, 2 Jul 2019 12:53:18 +0100
> Subject: [PATCH] iommu/arm-smmu-v3: Fix compilation when CONFIG_CMA=n
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> When compiling a kernel without support for CMA, CONFIG_CMA_ALIGNMENT
> is not defined which results in the following build failure:
> 
> In file included from ./include/linux/list.h:9:0
>                  from ./include/linux/kobject.h:19,
>                  from ./include/linux/of.h:17
>                  from ./include/linux/irqdomain.h:35,
>                  from ./include/linux/acpi.h:13,
>                  from drivers/iommu/arm-smmu-v3.c:12:
> drivers/iommu/arm-smmu-v3.c: In function ‘arm_smmu_device_hw_probe’:
> drivers/iommu/arm-smmu-v3.c:194:40: error: ‘CONFIG_CMA_ALIGNMENT’ undeclared (first use in this function)
>  #define Q_MAX_SZ_SHIFT   (PAGE_SHIFT + CONFIG_CMA_ALIGNMENT)
> 
> Fix the breakage by capping the maximum queue size based on MAX_ORDER
> when CMA is not enabled.
> 
> Reported-by: Zhangshaokun <zhangshaokun@hisilicon.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 57fb4e080d6b..8e73a7615bf5 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -191,7 +191,13 @@
>  #define Q_BASE_RWA			(1UL << 62)
>  #define Q_BASE_ADDR_MASK		GENMASK_ULL(51, 5)
>  #define Q_BASE_LOG2SIZE			GENMASK(4, 0)
> +
> +/* Ensure DMA allocations are naturally aligned */
> +#ifdef CONFIG_CMA_ALIGNMENT
>  #define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + CONFIG_CMA_ALIGNMENT)
> +#else
> +#define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + MAX_ORDER - 1)
> +#endif
>  
>  /*
>   * Stream table.
> 

