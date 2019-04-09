Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39746C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E7920674
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfDIO5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:57:03 -0400
Received: from foss.arm.com ([217.140.101.70]:39432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfDIO5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:57:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7EB415AB;
        Tue,  9 Apr 2019 07:57:02 -0700 (PDT)
Received: from [10.37.12.144] (unknown [10.37.12.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ACF63F68F;
        Tue,  9 Apr 2019 07:57:00 -0700 (PDT)
Subject: Re: [PATCH] kvm: arm: Skip stage2 huge mappings for unaligned ipa
 backed by THP
To:     yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        zhengxiang9@huawei.com, andrew.murray@arm.com,
        wanghaibin.wang@huawei.com
References: <1554203176-3958-1-git-send-email-suzuki.poulose@arm.com>
 <2ea55b9c-09da-c3d0-3616-aa6be85b5a46@huawei.com>
 <a9c084fb-0c84-e632-a192-b361773a0bc8@arm.com>
 <44ffad26-a407-4603-0bb6-145f7290adbe@huawei.com>
 <730c25b4-dbc5-8d8b-514c-4ed8641701ce@arm.com>
 <1b398e29-e2d5-2a58-b4ca-c72979a170d8@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <520e277c-f096-a84b-8405-636b19e4cc46@arm.com>
Date:   Tue, 9 Apr 2019 15:59:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1b398e29-e2d5-2a58-b4ca-c72979a170d8@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui

On 04/09/2019 09:05 AM, Zenghui Yu wrote:
> 
> 
> On 2019/4/9 2:40, Suzuki K Poulose wrote:
>> Hi Zenhui,
>>
>> On 04/08/2019 04:11 PM, Zenghui Yu wrote:
>>> Hi Suzuki,
>>>
>>> Thanks for the reply.
>>>
>>
>> ...
>>
>>>>> Hi Suzuki,
>>>>>
>>>>> Why not making use of fault_supports_stage2_huge_mapping()?  Let it do
>>>>> some checks for us.
>>>>>
>>>>> fault_supports_stage2_huge_mapping() was intended to do a *two-step*
>>>>> check to tell us that can we create stage2 huge block mappings, and 
>>>>> this
>>>>> check is both for hugetlbfs and THP.  With commit a80868f398554842b14,
>>>>> we pass PAGE_SIZE as "map_size" for normal size pages (which turned 
>>>>> out
>>>>> to be almost meaningless), and unfortunately the THP check no longer
>>>>> works.
>>>>
>>>> Thats correct.
>>>>
>>>>>
>>>>> So we want to rework *THP* check process.  Your patch fixes the first
>>>>> checking-step, but the second is still missed, am I wrong?
>>>>
>>>> It fixes the step explicitly for the THP by making sure that the GPA 
>>>> and
>>>> the HVA are aligned to the map size.
>>>
>>> Yes, I understand how your patch had fixed the issue.  But what I'm
>>> really concerned about here is the *second* checking-step in
>>> fault_supports_stage2_huge_mapping().
>>>
>>> We have to check if we are mapping a non-block aligned or non-block
>>> sized memslot, if so, we can not create block mappings for the beginning
>>> and end of this memslot.  This is what the second part of
>>> fault_supports_stage2_huge_mapping() had done.
>>>
>>> I haven't seen this checking-step in your patch, did I miss something?
>>>
>>
>> I see.
>>
>>>> I don't think this calls for a VM_BUG_ON(). It is simply a case where
>>>> the GPA is not aligned to HVA, but for normal VMA that could be made 
>>>> THP.
>>>>
>>>> We had this VM_BUG_ON(), which would have never hit because we would
>>>> have set force_pte if they were not aligned.
>>>
>>> Yes, I agree.
>>>
>>>>>> +        /* Skip memslots with unaligned IPA and user address */
>>>>>> +        if ((gfn & mask) != (pfn & mask))
>>>>>> +            return false;
>>>>>>           if (pfn & mask) {
>>>>>>               *ipap &= PMD_MASK;
>>>>>>               kvm_release_pfn_clean(pfn);
>>>>>>
>>>>>
>>>>> ---8>---
>>>>>
>>>>> Rework fault_supports_stage2_huge_mapping(), let it check THP again.
>>>>>
>>>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>>>>> ---
>>>>>   virt/kvm/arm/mmu.c | 11 ++++++++++-
>>>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>>>> index 27c9583..5e1b258 100644
>>>>> --- a/virt/kvm/arm/mmu.c
>>>>> +++ b/virt/kvm/arm/mmu.c
>>>>> @@ -1632,6 +1632,15 @@ static bool 
>>>>> fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
>>>>>       uaddr_end = uaddr_start + size;
>>>>>
>>>>>       /*
>>>>> +     * If the memslot is _not_ backed by hugetlbfs, then check if it
>>>>> +     * can be backed by transparent hugepages.
>>>>> +     *
>>>>> +     * Currently only PMD_SIZE THPs are supported, revisit it later.
>>>>> +     */
>>>>> +    if (map_size == PAGE_SIZE)
>>>>> +        map_size = PMD_SIZE;
>>>>> +
>>>>
>>>> This looks hackish. What is we support PUD_SIZE huge page in the future
>>>> ?
>>>
>>> Yes, this might make the code a little difficult to understand. But by
>>> doing so, we follow the same logic before commit a80868f398554842b14,
>>> that said, we do the two-step checking for normal size pages in
>>> fault_supports_stage2_huge_mapping(), to decide if we can create THP
>>> mappings for these pages.
>>>
>>> As for PUD_SIZE THPs, to be honest, I have no idea now :(
>>
>> How about the following diff ?
>>
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index 97b5417..98e5cec 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1791,7 +1791,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, 
>> phys_addr_t fault_ipa,
>>            * currently supported. This code will need to be
>>            * updated to support other THP sizes.
>>            */
>> -        if (transparent_hugepage_adjust(&pfn, &fault_ipa))
>> +        if (fault_supports_stage2_huge_mappings(memslot, hva, 
>> PMD_SIZE) &&
>> +            transparent_hugepage_adjust(&pfn, &fault_ipa))
>>               vma_pagesize = PMD_SIZE;
>>       }
> 
> I think this is good enough for the issue.
> 
> (One minor concern: With this change, it seems that we no longer need
> "force_pte" and can just use "logging_active" instead. But this is not
> much related to what we're fixing.)

I would still leave the force_pte there to avoid checking for a THP case
in a situation where we forced to PTE level mapping on a hugepage backed
VMA. It would serve to avoid another check.

Cheers
Suzuki


> 
> 
> thanks.
> 
> 

