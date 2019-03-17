Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C57C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B342087F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfCQMey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 08:34:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbfCQMey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 08:34:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 38F05DCEC73DB19DA2F0;
        Sun, 17 Mar 2019 20:34:50 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Sun, 17 Mar 2019
 20:34:43 +0800
Subject: Re: [PATCH] kvm: arm: Enforce PTE mappings at stage2 when needed
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <kvmarm@lists.cs.columbia.edu>, <james.morse@arm.com>,
        <julien.thierry@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>
References: <1552384371-10772-1-git-send-email-suzuki.poulose@arm.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <902e339c-fcbd-b44d-6549-9770b15e050a@huawei.com>
Date:   Sun, 17 Mar 2019 20:33:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <1552384371-10772-1-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 2019/3/12 17:52, Suzuki K Poulose wrote:
> commit 6794ad5443a2118 ("KVM: arm/arm64: Fix unintended stage 2 PMD mappings")
> made the checks to skip huge mappings, stricter. However it introduced
> a bug where we still use huge mappings, ignoring the flag to
> use PTE mappings, by not reseting the vma_pagesize to PAGE_SIZE.
> 
> Also, the checks do not cover the PUD huge pages, that was
> under review during the same period. This patch fixes both
> the issues.
> 
> Fixes : 6794ad5443a2118 ("KVM: arm/arm64: Fix unintended stage 2 PMD mappings")
> Reported-by: Zenghui Yu <yuzenghui@huawei.com>
> Cc: Zenghui Yu <yuzenghui@huawei.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---

Thanks for Cc-ing me. It works fine now!


zenghui

>   virt/kvm/arm/mmu.c | 43 +++++++++++++++++++++----------------------
>   1 file changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 30251e2..66e0fbb5 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1595,8 +1595,9 @@ static void kvm_send_hwpoison_signal(unsigned long address,
>   	send_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, current);
>   }
>   
> -static bool fault_supports_stage2_pmd_mappings(struct kvm_memory_slot *memslot,
> -					       unsigned long hva)
> +static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
> +					       unsigned long hva,
> +					       unsigned long map_size)
>   {
>   	gpa_t gpa_start, gpa_end;
>   	hva_t uaddr_start, uaddr_end;
> @@ -1612,34 +1613,34 @@ static bool fault_supports_stage2_pmd_mappings(struct kvm_memory_slot *memslot,
>   
>   	/*
>   	 * Pages belonging to memslots that don't have the same alignment
> -	 * within a PMD for userspace and IPA cannot be mapped with stage-2
> -	 * PMD entries, because we'll end up mapping the wrong pages.
> +	 * within a PMD/PUD for userspace and IPA cannot be mapped with stage-2
> +	 * PMD/PUD entries, because we'll end up mapping the wrong pages.
>   	 *
>   	 * Consider a layout like the following:
>   	 *
>   	 *    memslot->userspace_addr:
>   	 *    +-----+--------------------+--------------------+---+
> -	 *    |abcde|fgh  Stage-1 PMD    |    Stage-1 PMD   tv|xyz|
> +	 *    |abcde|fgh  Stage-1 block  |    Stage-1 block tv|xyz|
>   	 *    +-----+--------------------+--------------------+---+
>   	 *
>   	 *    memslot->base_gfn << PAGE_SIZE:
>   	 *      +---+--------------------+--------------------+-----+
> -	 *      |abc|def  Stage-2 PMD    |    Stage-2 PMD     |tvxyz|
> +	 *      |abc|def  Stage-2 block  |    Stage-2 block   |tvxyz|
>   	 *      +---+--------------------+--------------------+-----+
>   	 *
> -	 * If we create those stage-2 PMDs, we'll end up with this incorrect
> +	 * If we create those stage-2 blocks, we'll end up with this incorrect
>   	 * mapping:
>   	 *   d -> f
>   	 *   e -> g
>   	 *   f -> h
>   	 */
> -	if ((gpa_start & ~S2_PMD_MASK) != (uaddr_start & ~S2_PMD_MASK))
> +	if ((gpa_start & (map_size - 1)) != (uaddr_start & (map_size - 1)))
>   		return false;
>   
>   	/*
>   	 * Next, let's make sure we're not trying to map anything not covered
> -	 * by the memslot. This means we have to prohibit PMD size mappings
> -	 * for the beginning and end of a non-PMD aligned and non-PMD sized
> +	 * by the memslot. This means we have to prohibit block size mappings
> +	 * for the beginning and end of a non-block aligned and non-block sized
>   	 * memory slot (illustrated by the head and tail parts of the
>   	 * userspace view above containing pages 'abcde' and 'xyz',
>   	 * respectively).
> @@ -1648,8 +1649,8 @@ static bool fault_supports_stage2_pmd_mappings(struct kvm_memory_slot *memslot,
>   	 * userspace_addr or the base_gfn, as both are equally aligned (per
>   	 * the check above) and equally sized.
>   	 */
> -	return (hva & S2_PMD_MASK) >= uaddr_start &&
> -	       (hva & S2_PMD_MASK) + S2_PMD_SIZE <= uaddr_end;
> +	return (hva & ~(map_size - 1)) >= uaddr_start &&
> +	       (hva & ~(map_size - 1)) + map_size <= uaddr_end;
>   }
>   
>   static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> @@ -1678,12 +1679,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>   		return -EFAULT;
>   	}
>   
> -	if (!fault_supports_stage2_pmd_mappings(memslot, hva))
> -		force_pte = true;
> -
> -	if (logging_active)
> -		force_pte = true;
> -
>   	/* Let's check if we will get back a huge page backed by hugetlbfs */
>   	down_read(&current->mm->mmap_sem);
>   	vma = find_vma_intersection(current->mm, hva, hva + 1);
> @@ -1694,6 +1689,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>   	}
>   
>   	vma_pagesize = vma_kernel_pagesize(vma);
> +	if (logging_active ||
> +	    !fault_supports_stage2_huge_mapping(memslot, hva, vma_pagesize)) {
> +		force_pte = true;
> +		vma_pagesize = PAGE_SIZE;
> +	}
> +
>   	/*
>   	 * The stage2 has a minimum of 2 level table (For arm64 see
>   	 * kvm_arm_setup_stage2()). Hence, we are guaranteed that we can
> @@ -1701,11 +1702,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>   	 * As for PUD huge maps, we must make sure that we have at least
>   	 * 3 levels, i.e, PMD is not folded.
>   	 */
> -	if ((vma_pagesize == PMD_SIZE ||
> -	     (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm))) &&
> -	    !force_pte) {
> +	if (vma_pagesize == PMD_SIZE ||
> +	    (vma_pagesize == PUD_SIZE && kvm_stage2_has_pmd(kvm)))
>   		gfn = (fault_ipa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
> -	}
>   	up_read(&current->mm->mmap_sem);
>   
>   	/* We need minimum second+third level pages */
> 

