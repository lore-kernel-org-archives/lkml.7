Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F105C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E02520861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfFQLAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:00:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18586 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfFQLAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:00:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48F0D8A34246BE36988C;
        Mon, 17 Jun 2019 19:00:39 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Jun 2019
 19:00:35 +0800
Subject: Re: [PATCH v2] arm64/mm: Correct the cache line size warning with non
 coherent device
To:     Catalin Marinas <catalin.marinas@arm.com>
References: <20190614131141.4428-1-msys.mizuma@gmail.com>
 <aa445f8f-2576-4f78-a64e-1cde6a2f9593@hisilicon.com>
 <20190617104555.GA1367@arrakis.emea.arm.com>
CC:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        <linux-kernel@vger.kernel.org>,
        Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>
From:   Zhangshaokun <zhangshaokun@hisilicon.com>
Message-ID: <7e567399-6f3d-b416-6636-c9f2f37ea407@hisilicon.com>
Date:   Mon, 17 Jun 2019 19:00:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20190617104555.GA1367@arrakis.emea.arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 2019/6/17 18:45, Catalin Marinas wrote:
> On Sat, Jun 15, 2019 at 10:44:33AM +0800, Zhangshaokun wrote:
>> On 2019/6/14 21:11, Masayoshi Mizuma wrote:
>>> diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
>>> index 6eaf1c07aa4e..7fa6828bb488 100644
>>> --- a/arch/arm64/kernel/cacheinfo.c
>>> +++ b/arch/arm64/kernel/cacheinfo.c
>>> @@ -19,12 +19,10 @@
>>>  
>>>  int cache_line_size(void)
>>>  {
>>> -	u32 cwg = cache_type_cwg();
>>> -
>>>  	if (coherency_max_size != 0)
>>>  		return coherency_max_size;
>>>  
>>> -	return cwg ? 4 << cwg : ARCH_DMA_MINALIGN;
>>> +	return cache_line_size_of_cpu();
>>>  }
>>
>> How about simplify it as this?
>>
>> int cache_line_size(void)
>> {
>>         return coherency_max_size ? coherency_max_size :
>>                 cache_line_size_of_cpu();
>> }
> 
> I don't see this as a simplification, easier to read with explicit 'if'.
> 

Okay, I thought it can save some unnecessary lines :-).

>>>  EXPORT_SYMBOL_GPL(cache_line_size);
>>>  
>>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>>> index 1669618db08a..379589dc7113 100644
>>> --- a/arch/arm64/mm/dma-mapping.c
>>> +++ b/arch/arm64/mm/dma-mapping.c
>>> @@ -38,10 +38,6 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
>>>  
>>>  static int __init arm64_dma_init(void)
>>>  {
>>> -	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
>>> -		   TAINT_CPU_OUT_OF_SPEC,
>>> -		   "ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (%d < %d)",
>>> -		   ARCH_DMA_MINALIGN, cache_line_size());
>>>  	return dma_atomic_pool_init(GFP_DMA32, __pgprot(PROT_NORMAL_NC));
>>>  }
>>>  arch_initcall(arm64_dma_init);
>>> @@ -56,7 +52,17 @@ void arch_teardown_dma_ops(struct device *dev)
>>>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>>  			const struct iommu_ops *iommu, bool coherent)
>>>  {
>>> +	int cls = cache_line_size_of_cpu();
>>
>> whether we need this local variable, how about use cache_line_size_of_cpu
>> directly in WARN_TAINT just like before.
> 
> The reason being?
> 

Since it is inline function,  maybe it is unnecessary, it is trivial.

> Anyway, I'll queue v2 of this patch as is for 5.3. Thanks.
> 

It's fine.

Thanks,
Shaokun

