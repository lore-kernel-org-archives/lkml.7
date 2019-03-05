Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB844C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CB9206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfCELvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:51:17 -0500
Received: from foss.arm.com ([217.140.101.70]:47414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfCELvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:51:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50A85A78;
        Tue,  5 Mar 2019 03:51:16 -0800 (PST)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 805AA3F71D;
        Tue,  5 Mar 2019 03:51:14 -0800 (PST)
Subject: Re: [RFC PATCH] KVM: arm64: Force a PTE mapping when logging is
 enabled
To:     Zenghui Yu <yuzenghui@huawei.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Zenghui Yu <zenghuiyu96@gmail.com>
Cc:     christoffer.dall@arm.com, Punit Agrawal <punit.agrawal@arm.com>,
        julien.thierry@arm.com, LKML <linux-kernel@vger.kernel.org>,
        james.morse@arm.com, wanghaibin.wang@huawei.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <1551497728-12576-1-git-send-email-yuzenghui@huawei.com>
 <CAKcZhuWa4UcsoFPRkZg=M3WeUJibX8T0_R+JHS3=cyd51N9cgQ@mail.gmail.com>
 <20190304171320.GA3984@en101> <32f302eb-ef89-7de4-36b4-3c3df907c732@arm.com>
 <865b8b0b-e42e-fe03-e3b4-ae2cc5b1b424@huawei.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <30821cab-7a8c-e65a-4ea4-15c0b808e874@arm.com>
Date:   Tue, 5 Mar 2019 11:51:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <865b8b0b-e42e-fe03-e3b4-ae2cc5b1b424@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2019 11:09, Zenghui Yu wrote:
> Hi Marc, Suzuki,
> 
> On 2019/3/5 1:34, Marc Zyngier wrote:
>> Hi Zenghui, Suzuki,
>>
>> On 04/03/2019 17:13, Suzuki K Poulose wrote:
>>> Hi Zenghui,
>>>
>>> On Sun, Mar 03, 2019 at 11:14:38PM +0800, Zenghui Yu wrote:
>>>> I think there're still some problems in this patch... Details below.
>>>>
>>>> On Sat, Mar 2, 2019 at 11:39 AM Zenghui Yu <yuzenghui@huawei.com> wrote:
>>>>>
>>>>> The idea behind this is: we don't want to keep tracking of huge pages when
>>>>> logging_active is true, which will result in performance degradation.  We
>>>>> still need to set vma_pagesize to PAGE_SIZE, so that we can make use of it
>>>>> to force a PTE mapping.
>>>
>>> Yes, you're right. We are indeed ignoring the force_pte flag.
>>>
>>>>>
>>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>> Cc: Punit Agrawal <punit.agrawal@arm.com>
>>>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>>>>>
>>>>> ---
>>>>> Atfer looking into https://patchwork.codeaurora.org/patch/647985/ , the
>>>>> "vma_pagesize = PAGE_SIZE" logic was not intended to be deleted. As far
>>>>> as I can tell, we used to have "hugetlb" to force the PTE mapping, but
>>>>> we have "vma_pagesize" currently instead. We should set it properly for
>>>>> performance reasons (e.g, in VM migration). Did I miss something important?
>>>>>
>>>>> ---
>>>>>   virt/kvm/arm/mmu.c | 7 +++++++
>>>>>   1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>>>> index 30251e2..7d41b16 100644
>>>>> --- a/virt/kvm/arm/mmu.c
>>>>> +++ b/virt/kvm/arm/mmu.c
>>>>> @@ -1705,6 +1705,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>>>               (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
>>>>>              !force_pte) {
>>>>>                  gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
>>>>> +       } else {
>>>>> +               /*
>>>>> +                * Fallback to PTE if it's not one of the stage2
>>>>> +                * supported hugepage sizes or the corresponding level
>>>>> +                * doesn't exist, or logging is enabled.
>>>>
>>>> First, Instead of "logging is enabled", it should be "force_pte is true",
>>>> since "force_pte" will be true when:
>>>>
>>>>          1) fault_supports_stage2_pmd_mappings() return false; or
>>>>          2) "logging is enabled" (e.g, in VM migration).
>>>>
>>>> Second, fallback some unsupported hugepage sizes (e.g, 64K hugepage with
>>>> 4K pages) to PTE is somewhat strange. And it will then _unexpectedly_
>>>> reach transparent_hugepage_adjust(), though no real adjustment will happen
>>>> since commit fd2ef358282c ("KVM: arm/arm64: Ensure only THP is candidate
>>>> for adjustment"). Keeping "vma_pagesize" there as it is will be better,
>>>> right?
>>>>
>>>> So I'd just simplify the logic like:
>>>
>>> We could fix this right in the beginning. See patch below:
>>>
>>>>
>>>>          } else if (force_pte) {
>>>>                  vma_pagesize = PAGE_SIZE;
>>>>          }
>>>>
>>>>
>>>> Will send a V2 later and waiting for your comments :)
>>>
>>>
>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>> index 30251e2..529331e 100644
>>> --- a/virt/kvm/arm/mmu.c
>>> +++ b/virt/kvm/arm/mmu.c
>>> @@ -1693,7 +1693,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>   		return -EFAULT;
>>>   	}
>>>   
>>> -	vma_pagesize = vma_kernel_pagesize(vma);
>>> +	/* If we are forced to map at page granularity, force the pagesize here */
>>> +	vma_pagesize = force_pte ? PAGE_SIZE : vma_kernel_pagesize(vma);
>>> +
>>>   	/*
>>>   	 * The stage2 has a minimum of 2 level table (For arm64 see
>>>   	 * kvm_arm_setup_stage2()). Hence, we are guaranteed that we can
>>> @@ -1701,11 +1703,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>   	 * As for PUD huge maps, we must make sure that we have at least
>>>   	 * 3 levels, i.e, PMD is not folded.
>>>   	 */
>>> -	if ((vma_pagesize == PMD_SIZE ||
>>> -	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
>>> -	    !force_pte) {
>>> +	if (vma_pagesize == PMD_SIZE ||
>>> +	    (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm)))
>>>   		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
>>> -	}
>>> +
>>>   	up_read(&current->mm->mmap_sem);
>>>   
>>>   	/* We need minimum second+third level pages */
> 
> A nicer implementation and easier to understand, thanks!
> 
>> That's pretty interesting, because this is almost what we already have
>> in the NV code:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/tree/virt/kvm/arm/mmu.c?h=kvm-arm64/nv-wip-v5.0-rc7#n1752
>>
>> (note that force_pte is gone in that branch).
> 
> haha :-) sorry about that. I haven't looked into the NV code yet, so ...
> 
> But I'm still wondering: should we fix this wrong mapping size problem 
> before NV is introduced? Since this problem has not much to do with NV, 
> and 5.0 has already been released with this problem (and 5.1 will 
> without fix ...).
> 
> Just a personal idea, ignore it if unnecessary.

We definitely want to fix it now, and have the fix backported to older
versions. I can always rebase the NV branch on top of the current state
of mainline.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
