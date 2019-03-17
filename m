Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25486C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 13:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E277020896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 13:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfCQNiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 09:38:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726927AbfCQNiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 09:38:04 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 33C0F348BBF1B99C3B46;
        Sun, 17 Mar 2019 21:37:59 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Sun, 17 Mar 2019
 21:37:50 +0800
Subject: Re: [RFC] Question about TLB flush while set Stage-2 huge pages
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, <zhengxiang9@huawei.com>
CC:     <marc.zyngier@arm.com>, <christoffer.dall@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, <lious.lilei@hisilicon.com>,
        <lishuo1@hisilicon.com>
References: <5f712cc6-0874-adbe-add6-46f5de24f36f@huawei.com>
 <e2a94937-c324-e2d6-7e61-3f998e6e6e22@arm.com>
 <1c0e07b9-73f0-efa4-c1b7-ad81789b42c5@huawei.com>
 <5188e3b9-5b5a-a6a7-7ef0-09b7b4f06af6@arm.com>
 <348d0b3b-c74b-7b39-ec30-85905c077c38@huawei.com>
 <20190314105537.GA15323@en101>
 <368bd218-ac1d-19b2-6e92-960b91afee8b@huawei.com>
 <d322e126-4da2-6dfd-a86d-088dfb3bf0f4@huawei.com>
 <6aea4049-7860-7144-a7be-14f856cdc789@arm.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f6639daa-cfba-c65a-7320-c9dcc1ef8377@huawei.com>
Date:   Sun, 17 Mar 2019 21:34:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <6aea4049-7860-7144-a7be-14f856cdc789@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 2019/3/15 22:56, Suzuki K Poulose wrote:
> Hi Zhengui,

s/Zhengui/Zheng/

(I think you must wanted to say "Hi" to Zheng :-) )


I have looked into your patch and the kernel log, and I believe that
your patch had already addressed this issue. But I think we can do it
a little better - two more points need to be handled with caution.

Take PMD hugepage (PMD_SIZE == 2M) for example:

> 
> On 15/03/2019 08:21, Zheng Xiang wrote:
>> Hi Suzuki,
>>
>> I have tested this patch, VM doesn't hang and we get expected WARNING 
>> log:
> 
> Thanks for the quick testing !
> 
>> However, we also get the following unexpected log:
>>
>> [  908.329900] BUG: Bad page state in process qemu-kvm  pfn:a2fb41cf
>> [  908.339415] page:ffff7e28bed073c0 count:-4 mapcount:0 
>> mapping:0000000000000000 index:0x0
>> [  908.339416] flags: 0x4ffffe0000000000()
>> [  908.339418] raw: 4ffffe0000000000 dead000000000100 dead000000000200 
>> 0000000000000000
>> [  908.339419] raw: 0000000000000000 0000000000000000 fffffffcffffffff 
>> 0000000000000000
>> [  908.339420] page dumped because: nonzero _refcount
>> [  908.339437] CPU: 32 PID: 72599 Comm: qemu-kvm Kdump: loaded 
>> Tainted: G    B  W        5.0.0+ #1
>> [  908.339438] Call trace:
>> [  908.339439]  dump_backtrace+0x0/0x188
>> [  908.339441]  show_stack+0x24/0x30
>> [  908.339442]  dump_stack+0xa8/0xcc
>> [  908.339443]  bad_page+0xf0/0x150
>> [  908.339445]  free_pages_check_bad+0x84/0xa0
>> [  908.339446]  free_pcppages_bulk+0x4b8/0x750
>> [  908.339448]  free_unref_page_commit+0x13c/0x198
>> [  908.339449]  free_unref_page+0x84/0xa0
>> [  908.339451]  __free_pages+0x58/0x68
>> [  908.339452]  zap_huge_pmd+0x290/0x2d8
>> [  908.339454]  unmap_page_range+0x2b4/0x470
>> [  908.339455]  unmap_single_vma+0x94/0xe8
>> [  908.339457]  unmap_vmas+0x8c/0x108
>> [  908.339458]  exit_mmap+0xd4/0x178
>> [  908.339459]  mmput+0x74/0x180
>> [  908.339460]  do_exit+0x2b4/0x5b0
>> [  908.339462]  do_group_exit+0x3c/0xe0
>> [  908.339463]  __arm64_sys_exit_group+0x24/0x28
>> [  908.339465]  el0_svc_common+0xa0/0x180
>> [  908.339466]  el0_svc_handler+0x38/0x78
>> [  908.339467]  el0_svc+0x8/0xc
> 
> Thats bad, we seem to be making upto 4 unbalanced put_page().
> 
>>>> ---
>>>>    virt/kvm/arm/mmu.c | 51 
>>>> +++++++++++++++++++++++++++++++++++----------------
>>>>    1 file changed, 35 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>>> index 66e0fbb5..04b0f9b 100644
>>>> --- a/virt/kvm/arm/mmu.c
>>>> +++ b/virt/kvm/arm/mmu.c
>>>> @@ -1076,24 +1076,38 @@ static int stage2_set_pmd_huge(struct kvm 
>>>> *kvm, struct kvm_mmu_memory_cache
>>>>             * Skip updating the page table if the entry is
>>>>             * unchanged.
>>>>             */
>>>> -        if (pmd_val(old_pmd) == pmd_val(*new_pmd))
>>>> +        if (pmd_val(old_pmd) == pmd_val(*new_pmd)) {
>>>>                return 0;
>>>> -
>>>> +        } else if (WARN_ON_ONCE(!pmd_thp_or_huge(old_pmd))) {
>>>>            /*
>>>> -         * Mapping in huge pages should only happen through a
>>>> -         * fault.  If a page is merged into a transparent huge
>>>> -         * page, the individual subpages of that huge page
>>>> -         * should be unmapped through MMU notifiers before we
>>>> -         * get here.
>>>> -         *
>>>> -         * Merging of CompoundPages is not supported; they
>>>> -         * should become splitting first, unmapped, merged,
>>>> -         * and mapped back in on-demand.
>>>> +         * If we have PTE level mapping for this block,
>>>> +         * we must unmap it to avoid inconsistent TLB
>>>> +         * state. We could end up in this situation if
>>>> +         * the memory slot was marked for dirty logging
>>>> +         * and was reverted, leaving PTE level mappings
>>>> +         * for the pages accessed during the period.
>>>> +         * Normal THP split/merge follows mmu_notifier
>>>> +         * callbacks and do get handled accordingly.
>>>>             */
>>>> -        VM_BUG_ON(pmd_pfn(old_pmd) != pmd_pfn(*new_pmd));
>>>> +            unmap_stage2_range(kvm, (addr & S2_PMD_MASK), 
>>>> S2_PMD_SIZE);

First, using unmap_stage2_range() here is not quite appropriate. Suppose
we've only accessed one 2M page in HPA [x, x+1]Gib range, with other
pages unaccessed.  What will happen if unmap_stage2_range(this_2M_page)?
We'll unexpectedly reach clear_stage2_pud_entry(), and things are going
to get really bad.  So we'd better use unmap_stage2_ptes() here since we
only want to unmap a 2M range.


Second, consider below function stack:

   unmap_stage2_ptes()
     clear_stage2_pmd_entry()
       put_page(virt_to_page(pmd))

It seems that we have one "redundant" put_page() here, (thus comes the
bad kernel log ... ,) but actually we do not.  By stage2_set_pmd_huge(),
the PMD table entry will then point to a 2M block (originally pointed
to a PTE table), the _refcount of this PMD-level table page should _not_
change after unmap_stage2_ptes().  So what we really should do is adding
a get_page() after unmapping to keep the _refcount a balance!


thoughts ? A simple patch below (based on yours) for details.


thanks,

zenghui


>>
>> It seems that kvm decreases the _refcount of the page twice in 
>> transparent_hugepage_adjust()
>> and unmap_stage2_range().
> 
> But I thought we should be doing that on the head_page already, as this 
> is THP.
> I will take a look and get back to you on this. Btw, is it possible for you
> to turn on CONFIG_DEBUG_VM and re-run with the above patch ?
> 
> Kind regards
> Suzuki
> 

---8<---

test: kvm: arm: Maybe two more fixes

Applied based on Suzuki's patch.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
  virt/kvm/arm/mmu.c | 8 ++++++--
  1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 05765df..ccd5d5d 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1089,7 +1089,9 @@ static int stage2_set_pmd_huge(struct kvm *kvm, 
struct kvm_mmu_memory_cache
  		 * Normal THP split/merge follows mmu_notifier
  		 * callbacks and do get handled accordingly.
  		 */
-			unmap_stage2_range(kvm, (addr & S2_PMD_MASK), S2_PMD_SIZE);
+			addr &= S2_PMD_MASK;
+			unmap_stage2_ptes(kvm, pmd, addr, addr + S2_PMD_SIZE);
+			get_page(virt_to_page(pmd));
  		} else {

  			/*
@@ -1138,7 +1140,9 @@ static int stage2_set_pud_huge(struct kvm *kvm, 
struct kvm_mmu_memory_cache *cac
  	if (stage2_pud_present(kvm, old_pud)) {
  		/* If we have PTE level mapping, unmap the entire range */
  		if (WARN_ON_ONCE(!stage2_pud_huge(kvm, old_pud))) {
-			unmap_stage2_range(kvm, addr & S2_PUD_MASK, S2_PUD_SIZE);
+			addr &= S2_PUD_MASK;
+			unmap_stage2_pmds(kvm, pudp, addr, addr + S2_PUD_SIZE);
+			get_page(virt_to_page(pudp));
  		} else {
  			stage2_pud_clear(kvm, pudp);
  			kvm_tlb_flush_vmid_ipa(kvm, addr);
-- 
1.8.3.1





