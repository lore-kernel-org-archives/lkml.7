Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E00FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC972087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfCQOCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 10:02:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5265 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbfCQOCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 10:02:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F0911A9936BDD7847668;
        Sun, 17 Mar 2019 22:02:31 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Sun, 17 Mar 2019
 22:02:23 +0800
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
Message-ID: <0fce42bd-1295-45a4-46b6-81b128ee343e@huawei.com>
Date:   Sun, 17 Mar 2019 21:55:12 +0800
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
>>
>> It seems that kvm decreases the _refcount of the page twice in 
>> transparent_hugepage_adjust()
>> and unmap_stage2_range().
> 
> But I thought we should be doing that on the head_page already, as this 
> is THP.
> I will take a look and get back to you on this. Btw, is it possible for you
> to turn on CONFIG_DEBUG_VM and re-run with the above patch ?

And for detailed debugging info:

I've turned on CONFIG_DEBUG_VM and re-run with your patch -- Run a guest
with stage2 PUD hugepage, enable then disable the dirty logging, and
then shutdown this guest. The result is: Host hit a kernel BUG with the
below log (when shutdown-ing guest):


[  486.997640] kernel BUG at ./include/linux/mm.h:547!
[  487.005524] Internal error: Oops - BUG: 0 [#1] SMP
[  487.013455] Modules linked in: ...
[  487.104072] CPU: 14 PID: 60747 Comm: qemu-kvm Kdump: loaded Tainted: 
G        W         5.0.0+ #2
[  487.117150] ...
[  487.135433] pstate: 40400009 (nZcv daif +PAN -UAO)
[  487.144849] pc : unmap_stage2_puds+0x480/0x6e0
[  487.153756] lr : unmap_stage2_puds+0x480/0x6e0
[  487.162507] sp : ffff00002c72bb10
[  487.179630] x27: 0000000041a00000 x26: ffff8027bbb56060
[  487.183465] openvswitch: netlink: Tunnel attr 5 has unexpected len 1 
expected 0
[  487.189184] x25: ffff802769cbe008 x24: ffff7e0000000000
[  487.189185] x23: ffff802769cbe008 x22: ffff00004b0af000
[  487.189186] x21: ffff80279da06060 x20: 00400027332007fd
[  487.189188] x19: 0000000080000000 x18: 0000000000000010
[  487.189189] x17: 0000000000000000 x16: 0000000000000000
[  487.189190] x15: ffff00001182d708 x14: 3030303030303030
[  487.189191] x13: 3030303030302066 x12: ffff000011857000
[  487.189192] x11: 0000000000000000 x10: ffff000011a48000
[  487.189193] x9 : 0000000000000000 x8 : 0000000000000003
[  487.189194] x7 : 000000000000095b x6 : 0000000212557560
[  487.189196] x3 : ffff802fc0b08260 x2 : b2513adc3568f800
[  487.189197] x1 : 0000000000000000 x0 : 000000000000003e
[  487.189200] Process qemu-kvm (pid: 60747, stack limit = 
0x000000004342b298)
[  487.189201] Call trace:
[  487.189203]  unmap_stage2_puds+0x480/0x6e0
[  487.189205]  unmap_stage2_range+0xa4/0x190
[  487.189208]  kvm_free_stage2_pgd+0x64/0x100
[  487.363897]  kvm_arch_flush_shadow_all+0x20/0x30
[  487.372095]  kvm_mmu_notifier_release+0x3c/0x80
[  487.380092]  __mmu_notifier_release+0x50/0x100
[  487.387914]  exit_mmap+0x170/0x178
[  487.394567]  mmput+0x70/0x180
[  487.400653]  do_exit+0x2b4/0x5c8
[  487.406849]  do_group_exit+0x3c/0xe0
--[ end trace 55c414a329c80b63 ]---
[  487.454174] Kernel panic - not syncing: Fatal exception
[  487.461967] SMP: stopping secondary CPUs
[  487.468473] Kernel Offset: disabled
[  487.474520] CPU features: 0x002,22208a38
[  487.481008] Memory Limit: none
[  487.489095] Starting crashdump kernel...
[  487.495457] Bye!


> 
> Kind regards
> Suzuki
> 
> 
> 
> .

