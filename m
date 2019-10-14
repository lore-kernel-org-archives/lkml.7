Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B491C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F32B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbfJNPze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:55:34 -0400
Received: from foss.arm.com ([217.140.110.172]:47642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbfJNPze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:55:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B6F328;
        Mon, 14 Oct 2019 08:55:33 -0700 (PDT)
Received: from [10.1.194.43] (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66EC33F718;
        Mon, 14 Oct 2019 08:55:32 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: DMA map all pages shared with the GPU
To:     Robin Murphy <robin.murphy@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20191014151616.14099-1-steven.price@arm.com>
 <99f279c5-e93d-ade6-cd97-56b3078da755@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <8f8bd089-102f-9b8b-335b-6be06687d0ac@arm.com>
Date:   Mon, 14 Oct 2019 16:55:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <99f279c5-e93d-ade6-cd97-56b3078da755@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2019 16:46, Robin Murphy wrote:
> On 14/10/2019 16:16, Steven Price wrote:
>> Pages shared with the GPU are (often) not cache coherent with the CPU so
>> cache maintenance is required to flush the CPU's caches. This was
>> already done when mapping pages on fault, but wasn't previously done
>> when mapping a freshly allocated page.
>>
>> Fix this by moving the call to dma_map_sg() into mmu_map_sg() ensuring
>> that it is always called when pages are mapped onto the GPU. Since
>> mmu_map_sg() can now fail the code also now has to handle an error
>> return.
>>
>> Not performing this cache maintenance can cause errors in the GPU output
>> (CPU caches are later flushed and overwrite the GPU output). In theory
>> it also allows the GPU (and by extension user space) to observe the
>> memory contents prior to sanitization.
> 
> For the non-heap case, aren't the pages already supposed to be mapped by
> drm_gem_shmem_get_pages_sgt()?

Hmm, well yes - it looks like it *should* work - but I was definitely
seeing cache artefacts until I did this change... let me do some more
testing. It's possible that this is actually only affecting buffers
imported from another driver. Perhaps it's
drm_gem_shmem_prime_import_sg_table() that needs fixing.

> (Hmm, maybe I should try hooking up the GPU SMMU on my Juno to serve as
> a cheeky DMA-API-mishap detector...)

Yes I was wondering about that - it would certainly give some confidence
there's no missing cases.

Steve

> Robin.
> 
>> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_mmu.c | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> index bdd990568476..0495e48c238d 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> @@ -248,6 +248,9 @@ static int mmu_map_sg(struct panfrost_device
>> *pfdev, struct panfrost_mmu *mmu,
>>       struct io_pgtable_ops *ops = mmu->pgtbl_ops;
>>       u64 start_iova = iova;
>>   +    if (!dma_map_sg(pfdev->dev, sgt->sgl, sgt->nents,
>> DMA_BIDIRECTIONAL))
>> +        return -EINVAL;
>> +
>>       for_each_sg(sgt->sgl, sgl, sgt->nents, count) {
>>           unsigned long paddr = sg_dma_address(sgl);
>>           size_t len = sg_dma_len(sgl);
>> @@ -275,6 +278,7 @@ int panfrost_mmu_map(struct panfrost_gem_object *bo)
>>       struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
>>       struct sg_table *sgt;
>>       int prot = IOMMU_READ | IOMMU_WRITE;
>> +    int ret;
>>         if (WARN_ON(bo->is_mapped))
>>           return 0;
>> @@ -286,10 +290,12 @@ int panfrost_mmu_map(struct panfrost_gem_object
>> *bo)
>>       if (WARN_ON(IS_ERR(sgt)))
>>           return PTR_ERR(sgt);
>>   -    mmu_map_sg(pfdev, bo->mmu, bo->node.start << PAGE_SHIFT, prot,
>> sgt);
>> -    bo->is_mapped = true;
>> +    ret = mmu_map_sg(pfdev, bo->mmu, bo->node.start << PAGE_SHIFT,
>> +             prot, sgt);
>> +    if (ret == 0)
>> +        bo->is_mapped = true;
>>   -    return 0;
>> +    return ret;
>>   }
>>     void panfrost_mmu_unmap(struct panfrost_gem_object *bo)
>> @@ -503,12 +509,10 @@ int panfrost_mmu_map_fault_addr(struct
>> panfrost_device *pfdev, int as, u64 addr)
>>       if (ret)
>>           goto err_pages;
>>   -    if (!dma_map_sg(pfdev->dev, sgt->sgl, sgt->nents,
>> DMA_BIDIRECTIONAL)) {
>> -        ret = -EINVAL;
>> +    ret = mmu_map_sg(pfdev, bo->mmu, addr,
>> +             IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
>> +    if (ret)
>>           goto err_map;
>> -    }
>> -
>> -    mmu_map_sg(pfdev, bo->mmu, addr, IOMMU_WRITE | IOMMU_READ |
>> IOMMU_NOEXEC, sgt);
>>         bo->is_mapped = true;
>>  
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

