Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0605C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA79D213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCLSS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:18:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47922 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfCLSS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:18:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B19A9A78;
        Tue, 12 Mar 2019 11:18:26 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97BC13F59C;
        Tue, 12 Mar 2019 11:18:24 -0700 (PDT)
Subject: Re: [RFC] Question about TLB flush while set Stage-2 huge pages
To:     Zheng Xiang <zhengxiang9@huawei.com>, christoffer.dall@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        suzuki.poulose@arm.com, james.morse@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Wang Haibin <wanghaibin.wang@huawei.com>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        lious.lilei@hisilicon.com, lishuo1@hisilicon.com
References: <5f712cc6-0874-adbe-add6-46f5de24f36f@huawei.com>
 <e2a94937-c324-e2d6-7e61-3f998e6e6e22@arm.com>
 <1c0e07b9-73f0-efa4-c1b7-ad81789b42c5@huawei.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <5188e3b9-5b5a-a6a7-7ef0-09b7b4f06af6@arm.com>
Date:   Tue, 12 Mar 2019 18:18:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1c0e07b9-73f0-efa4-c1b7-ad81789b42c5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

On 12/03/2019 15:30, Zheng Xiang wrote:
> Hi Marc,
> 
> On 2019/3/12 19:32, Marc Zyngier wrote:
>> Hi Zheng,
>>
>> On 11/03/2019 16:31, Zheng Xiang wrote:
>>> Hi all,
>>>
>>> While a page is merged into a transparent huge page, KVM will invalidate Stage-2 for
>>> the base address of the huge page and the whole of Stage-1.
>>> However, this just only invalidates the first page within the huge page and the other
>>> pages are not invalidated, see bellow:
>>>
>>>     +---------------+--------------+
>>>     |abcde       2MB-Page          |
>>>     +---------------+--------------+
>>>
>>>     TLB before setting new pmd:
>>>     +---------------+--------------+
>>>     |      VA       |    PAGESIZE  |
>>>     +---------------+--------------+
>>>     |      a        |      4KB     |
>>>     +---------------+--------------+
>>>     |      b        |      4KB     |
>>>     +---------------+--------------+
>>>     |      c        |      4KB     |
>>>     +---------------+--------------+
>>>     |      d        |      4KB     |
>>>     +---------------+--------------+
>>>
>>>     TLB after setting new pmd:
>>>     +---------------+--------------+
>>>     |      VA       |    PAGESIZE  |
>>>     +---------------+--------------+
>>>     |      a        |      2MB     |
>>>     +---------------+--------------+
>>>     |      b        |      4KB     |
>>>     +---------------+--------------+
>>>     |      c        |      4KB     |
>>>     +---------------+--------------+
>>>     |      d        |      4KB     |
>>>     +---------------+--------------+
>>>
>>> When VM access *b* address, it will hit the TLB and result in TLB conflict aborts or other potential exceptions.
>>
>> That's really bad. I can only imagine two scenarios:
>>
>> 1) We fail to unmap a,b,c,d (and potentially another 508 PTEs), loosing
>> the PTE table in the process, and place the PMD instead. I can't see
>> this happening.
>>
>> 2) We fail to invalidate on unmap, and that slightly less bad (but still
>> quite bad).
>>
>> Which of the two cases are you seeing?
>>
>>> For example, we need to keep tracking of the VM memory dirty pages when VM is in live migration.
>>> KVM will set the memslot READONLY and split the huge pages.
>>> After live migration is canceled and abort, the pages will be merged into THP.
>>> The later access to these pages which are READONLY will cause level-3 Permission Fault until they are invalidated.
>>>
>>> So should we invalidate the tlb entries for all relative pages(e.g a,b,c,d), like __flush_tlb_range()?
>>> Or we can call __kvm_tlb_flush_vmid() to invalidate all tlb entries.
>>
>> We should perform an invalidate on each unmap. unmap_stage2_range seems
>> to do the right thing. __flush_tlb_range only caters for Stage1
>> mappings, and __kvm_tlb_flush_vmid() is too big a hammer, as it nukes
>> TLBs for the whole VM.
>>
>> I'd really like to understand what you're seeing, and how to reproduce
>> it. Do you have a minimal example I could run on my own HW?
> 
> When I start the live migration for a VM, qemu then begins to log and count dirty pages.
> During the live migration, KVM set the pages READONLY so that we can count how many pages
> would be wrote afterwards.
> 
> Anything is OK until I cancel the live migration and qemu stop logging. Later the VM gets hang.
> The trace log shows repeatedly level-3 permission fault caused by a write on a same IPA. After
> analyzing the source code, I find KVM always return from the bellow *if* statement in
> stage2_set_pmd_huge() even if we only have a single VCPU:
> 
>         /*
>          * Multiple vcpus faulting on the same PMD entry, can
>          * lead to them sequentially updating the PMD with the
>          * same value. Following the break-before-make
>          * (pmd_clear() followed by tlb_flush()) process can
>          * hinder forward progress due to refaults generated
>          * on missing translations.
>          *
>          * Skip updating the page table if the entry is
>          * unchanged.
>          */
>         if (pmd_val(old_pmd) == pmd_val(*new_pmd))
>             return 0;
> 
> The PMD has already set the PMD_S2_RDWR bit. I doubt kvm_tlb_flush_vmid_ipa() does not invalidate
> Stage-2 for the subpages of the PMD(except the first PTE of this PMD). Finally I add some debug
> code to flush tlb for all subpages of the PMD, as shown bellow:
> 
>         /*
>          * Mapping in huge pages should only happen through a
>          * fault.  If a page is merged into a transparent huge
>          * page, the individual subpages of that huge page
>          * should be unmapped through MMU notifiers before we
>          * get here.
>          *
>          * Merging of CompoundPages is not supported; they
>          * should become splitting first, unmapped, merged,
>          * and mapped back in on-demand.
>          */
>         VM_BUG_ON(pmd_pfn(old_pmd) != pmd_pfn(*new_pmd));
> 
>         pmd_clear(pmd);
>         for (cnt = 0; cnt < 512; cnt++)
>             kvm_tlb_flush_vmid_ipa(kvm, addr + cnt*PAGE_SIZE);
> 
> Then the problem no longer reproduce.

This makes very little sense. We shouldn't be able to enter this path
for anything else but a permission update, otherwise the VM_BUG_ON
should fire.

Can you either turn this VM_BUG_ON into a simple BUG_ON, or enable
CONFIG_DEBUG_VM please? If what you're describing is indeed correct (and
I have no reason to doubt you), it should fire.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
