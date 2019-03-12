Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D60C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9760D2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfCLPbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:31:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfCLPbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:31:23 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5D1F6C7195CD7E649E36;
        Tue, 12 Mar 2019 23:31:09 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.32) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 12 Mar 2019
 23:31:03 +0800
Subject: Re: [RFC] Question about TLB flush while set Stage-2 huge pages
To:     Marc Zyngier <marc.zyngier@arm.com>, <christoffer.dall@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <suzuki.poulose@arm.com>, <james.morse@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Wang Haibin <wanghaibin.wang@huawei.com>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        <lious.lilei@hisilicon.com>, <lishuo1@hisilicon.com>
References: <5f712cc6-0874-adbe-add6-46f5de24f36f@huawei.com>
 <e2a94937-c324-e2d6-7e61-3f998e6e6e22@arm.com>
From:   Zheng Xiang <zhengxiang9@huawei.com>
Message-ID: <1c0e07b9-73f0-efa4-c1b7-ad81789b42c5@huawei.com>
Date:   Tue, 12 Mar 2019 23:30:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <e2a94937-c324-e2d6-7e61-3f998e6e6e22@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/3/12 19:32, Marc Zyngier wrote:
> Hi Zheng,
> 
> On 11/03/2019 16:31, Zheng Xiang wrote:
>> Hi all,
>>
>> While a page is merged into a transparent huge page, KVM will invalidate Stage-2 for
>> the base address of the huge page and the whole of Stage-1.
>> However, this just only invalidates the first page within the huge page and the other
>> pages are not invalidated, see bellow:
>>
>>     +---------------+--------------+
>>     |abcde       2MB-Page          |
>>     +---------------+--------------+
>>
>>     TLB before setting new pmd:
>>     +---------------+--------------+
>>     |      VA       |    PAGESIZE  |
>>     +---------------+--------------+
>>     |      a        |      4KB     |
>>     +---------------+--------------+
>>     |      b        |      4KB     |
>>     +---------------+--------------+
>>     |      c        |      4KB     |
>>     +---------------+--------------+
>>     |      d        |      4KB     |
>>     +---------------+--------------+
>>
>>     TLB after setting new pmd:
>>     +---------------+--------------+
>>     |      VA       |    PAGESIZE  |
>>     +---------------+--------------+
>>     |      a        |      2MB     |
>>     +---------------+--------------+
>>     |      b        |      4KB     |
>>     +---------------+--------------+
>>     |      c        |      4KB     |
>>     +---------------+--------------+
>>     |      d        |      4KB     |
>>     +---------------+--------------+
>>
>> When VM access *b* address, it will hit the TLB and result in TLB conflict aborts or other potential exceptions.
> 
> That's really bad. I can only imagine two scenarios:
> 
> 1) We fail to unmap a,b,c,d (and potentially another 508 PTEs), loosing
> the PTE table in the process, and place the PMD instead. I can't see
> this happening.
> 
> 2) We fail to invalidate on unmap, and that slightly less bad (but still
> quite bad).
> 
> Which of the two cases are you seeing?
> 
>> For example, we need to keep tracking of the VM memory dirty pages when VM is in live migration.
>> KVM will set the memslot READONLY and split the huge pages.
>> After live migration is canceled and abort, the pages will be merged into THP.
>> The later access to these pages which are READONLY will cause level-3 Permission Fault until they are invalidated.
>>
>> So should we invalidate the tlb entries for all relative pages(e.g a,b,c,d), like __flush_tlb_range()?
>> Or we can call __kvm_tlb_flush_vmid() to invalidate all tlb entries.
> 
> We should perform an invalidate on each unmap. unmap_stage2_range seems
> to do the right thing. __flush_tlb_range only caters for Stage1
> mappings, and __kvm_tlb_flush_vmid() is too big a hammer, as it nukes
> TLBs for the whole VM.
> 
> I'd really like to understand what you're seeing, and how to reproduce
> it. Do you have a minimal example I could run on my own HW?

When I start the live migration for a VM, qemu then begins to log and count dirty pages.
During the live migration, KVM set the pages READONLY so that we can count how many pages
would be wrote afterwards.

Anything is OK until I cancel the live migration and qemu stop logging. Later the VM gets hang.
The trace log shows repeatedly level-3 permission fault caused by a write on a same IPA. After
analyzing the source code, I find KVM always return from the bellow *if* statement in
stage2_set_pmd_huge() even if we only have a single VCPU:

        /*
         * Multiple vcpus faulting on the same PMD entry, can
         * lead to them sequentially updating the PMD with the
         * same value. Following the break-before-make
         * (pmd_clear() followed by tlb_flush()) process can
         * hinder forward progress due to refaults generated
         * on missing translations.
         *
         * Skip updating the page table if the entry is
         * unchanged.
         */
        if (pmd_val(old_pmd) == pmd_val(*new_pmd))
            return 0;

The PMD has already set the PMD_S2_RDWR bit. I doubt kvm_tlb_flush_vmid_ipa() does not invalidate
Stage-2 for the subpages of the PMD(except the first PTE of this PMD). Finally I add some debug
code to flush tlb for all subpages of the PMD, as shown bellow:

        /*
         * Mapping in huge pages should only happen through a
         * fault.  If a page is merged into a transparent huge
         * page, the individual subpages of that huge page
         * should be unmapped through MMU notifiers before we
         * get here.
         *
         * Merging of CompoundPages is not supported; they
         * should become splitting first, unmapped, merged,
         * and mapped back in on-demand.
         */
        VM_BUG_ON(pmd_pfn(old_pmd) != pmd_pfn(*new_pmd));

        pmd_clear(pmd);
        for (cnt = 0; cnt < 512; cnt++)
            kvm_tlb_flush_vmid_ipa(kvm, addr + cnt*PAGE_SIZE);

Then the problem no longer reproduce.


-- 

Thanks,
Xiang


