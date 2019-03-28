Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA67C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEA320811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfC1GS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:18:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41040 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725813AbfC1GS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:18:58 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 80E7F37A6EFC8D49742D;
        Thu, 28 Mar 2019 14:18:56 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Thu, 28 Mar 2019
 14:18:49 +0800
Subject: Re: [PATCH v2 1/1] iommu: Add config option to set lazy mode as
 default
To:     Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        "Will Deacon" <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190327150030.11112-1-thunder.leizhen@huawei.com>
 <c80863a8-8ffa-473d-7c5c-3172cb8045de@arm.com>
CC:     Hanjun Guo <guohanjun@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5C9C6748.8050103@huawei.com>
Date:   Thu, 28 Mar 2019 14:18:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <c80863a8-8ffa-473d-7c5c-3172cb8045de@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/28 3:18, Robin Murphy wrote:
> On 27/03/2019 15:00, Zhen Lei wrote:
>> This allows the default behaviour to be controlled by a kernel config
>> option instead of changing the command line for the kernel to include
>> "iommu.strict=0" on ARM64 where this is desired.
>>
>> This is similar to CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>>
>> Note: At present, intel_iommu, amd_iommu and s390_iommu use lazy mode as
>> default, so there is no need to add code for them.
> 
> That seems a bit self-contradictory - if there's a real need for TLB flush behaviour to be statically configurable and not command-line-based then why should users of other architectures be exempt?
Yes，you're right. I will make this configuration to be effective for other architectures.

BTW, can you give some opinion about below patches?
https://patchwork.kernel.org/patch/10857601/

> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/Kconfig | 14 ++++++++++++++
>>   drivers/iommu/iommu.c |  5 +++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index 6f07f3b21816c64..5daa110d0e83a07 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -85,6 +85,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
>>
>>         If unsure, say N here.
>>
>> +config IOMMU_DMA_DEFAULT_LAZY_MODE
>> +    bool "IOMMU DMA use lazy mode to flush IOTLB and free IOVA"
>> +    depends on IOMMU_API
>> +    help
>> +      Support lazy mode, where for every IOMMU DMA unmap operation, the
>> +      flush operation of IOTLB and the free operation of IOVA are deferred.
>> +      They are only guaranteed to be done before the related IOVA will be
>> +      reused. Removing the need to pass in kernel parameters through
>> +      command line. For example, iommu.strict=0 on ARM64. If this is
>> +      enabled, you can still disable with kernel parameters, such as
>> +      iommu.strict=1 depending on the architecture.
>> +
>> +      If unsure, say N here.
>> +
>>   config OF_IOMMU
>>          def_bool y
>>          depends on OF && IOMMU_API
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 33a982e33716369..5acb98e79b5b32d 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -43,7 +43,12 @@
>>   #else
>>   static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
>>   #endif
>> +
>> +#ifdef CONFIG_IOMMU_DMA_DEFAULT_LAZY_MODE
>> +static bool iommu_dma_strict __read_mostly;
>> +#else
>>   static bool iommu_dma_strict __read_mostly = true;
>> +#endif
> 
> For a straightforward boolean, you can simply do:
> 
>     static bool foo = IS_ENABLED(CONFIG_FOO);
> 
> but that said, I'm still not particularly convinced that there are a significant number of users in a position to build and install a custom kernel but not edit /etc/default/grub, and who really value the combination of less performance than passthrough with less isolation than strict.
> 
> It's also not necessarily obvious to the user how this interacts with IOMMU_DEFAULT_PASSTHROUGH, so if we really do go down this route, maybe it would be better to refactor the whole lot into a single selection of something like IOMMU_DEFAULT_MODE anyway.
> 
> Robin.
> 
>>
>>   struct iommu_callback_data {
>>       const struct iommu_ops *ops;
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

-- 
Thanks!
BestRegards

