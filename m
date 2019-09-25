Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB152C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCF821D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437994AbfIYOmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:42:15 -0400
Received: from foss.arm.com ([217.140.110.172]:51280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437125AbfIYOmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:42:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B9AC1000;
        Wed, 25 Sep 2019 07:42:14 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBB273F59C;
        Wed, 25 Sep 2019 07:42:11 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:42:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jia He <justin.he@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com
Subject: Re: [PATCH v9 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190925144209.GG7042@arrakis.emea.arm.com>
References: <20190925025922.176362-1-justin.he@arm.com>
 <20190925025922.176362-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925025922.176362-4-justin.he@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:59:22AM +0800, Jia He wrote:
> When we tested pmdk unit test [1] vmmalloc_fork TEST1 in arm64 guest, there
> will be a double page fault in __copy_from_user_inatomic of cow_user_page.
> 
> Below call trace is from arm64 do_page_fault for debugging purpose
> [  110.016195] Call trace:
> [  110.016826]  do_page_fault+0x5a4/0x690
> [  110.017812]  do_mem_abort+0x50/0xb0
> [  110.018726]  el1_da+0x20/0xc4
> [  110.019492]  __arch_copy_from_user+0x180/0x280
> [  110.020646]  do_wp_page+0xb0/0x860
> [  110.021517]  __handle_mm_fault+0x994/0x1338
> [  110.022606]  handle_mm_fault+0xe8/0x180
> [  110.023584]  do_page_fault+0x240/0x690
> [  110.024535]  do_mem_abort+0x50/0xb0
> [  110.025423]  el0_da+0x20/0x24
> 
> The pte info before __copy_from_user_inatomic is (PTE_AF is cleared):
> [ffff9b007000] pgd=000000023d4f8003, pud=000000023da9b003, pmd=000000023d4b3003, pte=360000298607bd3
> 
> As told by Catalin: "On arm64 without hardware Access Flag, copying from
> user will fail because the pte is old and cannot be marked young. So we
> always end up with zeroed page after fork() + CoW for pfn mappings. we
> don't always have a hardware-managed access flag on arm64."
> 
> This patch fix it by calling pte_mkyoung. Also, the parameter is
> changed because vmf should be passed to cow_user_page()
> 
> Add a WARN_ON_ONCE when __copy_from_user_inatomic() returns error
> in case there can be some obscure use-case.(by Kirill)
> 
> [1] https://github.com/pmem/pmdk/tree/master/src/test/vmmalloc_fork
> 
> Signed-off-by: Jia He <justin.he@arm.com>
> Reported-by: Yibo Cai <Yibo.Cai@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

>  mm/memory.c | 99 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 84 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e2bb51b6242e..a0a381b36ff2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -118,6 +118,13 @@ int randomize_va_space __read_mostly =
>  					2;
>  #endif
>  
> +#ifndef arch_faults_on_old_pte
> +static inline bool arch_faults_on_old_pte(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  static int __init disable_randmaps(char *s)
>  {
>  	randomize_va_space = 0;
> @@ -2140,32 +2147,82 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
>  	return same;
>  }
>  
> -static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
> +static inline bool cow_user_page(struct page *dst, struct page *src,
> +				 struct vm_fault *vmf)
>  {
> +	bool ret;
> +	void *kaddr;
> +	void __user *uaddr;
> +	bool force_mkyoung;
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct mm_struct *mm = vma->vm_mm;
> +	unsigned long addr = vmf->address;
> +
>  	debug_dma_assert_idle(src);
>  
> +	if (likely(src)) {
> +		copy_user_highpage(dst, src, addr, vma);
> +		return true;
> +	}
> +
>  	/*
>  	 * If the source page was a PFN mapping, we don't have
>  	 * a "struct page" for it. We do a best-effort copy by
>  	 * just copying from the original user address. If that
>  	 * fails, we just zero-fill it. Live with it.
>  	 */
> -	if (unlikely(!src)) {
> -		void *kaddr = kmap_atomic(dst);
> -		void __user *uaddr = (void __user *)(va & PAGE_MASK);
> +	kaddr = kmap_atomic(dst);
> +	uaddr = (void __user *)(addr & PAGE_MASK);
> +
> +	/*
> +	 * On architectures with software "accessed" bits, we would
> +	 * take a double page fault, so mark it accessed here.
> +	 */
> +	force_mkyoung = arch_faults_on_old_pte() && !pte_young(vmf->orig_pte);
> +	if (force_mkyoung) {
> +		pte_t entry;
> +
> +		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
> +		if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
> +			/*
> +			 * Other thread has already handled the fault
> +			 * and we don't need to do anything. If it's
> +			 * not the case, the fault will be triggered
> +			 * again on the same address.
> +			 */
> +			ret = false;
> +			goto pte_unlock;
> +		}
> +
> +		entry = pte_mkyoung(vmf->orig_pte);
> +		if (ptep_set_access_flags(vma, addr, vmf->pte, entry, 0))
> +			update_mmu_cache(vma, addr, vmf->pte);
> +	}
>  
> +	/*
> +	 * This really shouldn't fail, because the page is there
> +	 * in the page tables. But it might just be unreadable,
> +	 * in which case we just give up and fill the result with
> +	 * zeroes.
> +	 */
> +	if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
>  		/*
> -		 * This really shouldn't fail, because the page is there
> -		 * in the page tables. But it might just be unreadable,
> -		 * in which case we just give up and fill the result with
> -		 * zeroes.
> +		 * Give a warn in case there can be some obscure
> +		 * use-case
>  		 */
> -		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
> -			clear_page(kaddr);
> -		kunmap_atomic(kaddr);
> -		flush_dcache_page(dst);
> -	} else
> -		copy_user_highpage(dst, src, va, vma);
> +		WARN_ON_ONCE(1);
> +		clear_page(kaddr);
> +	}
> +
> +	ret = true;
> +
> +pte_unlock:
> +	if (force_mkyoung)
> +		pte_unmap_unlock(vmf->pte, vmf->ptl);
> +	kunmap_atomic(kaddr);
> +	flush_dcache_page(dst);
> +
> +	return ret;
>  }
>  
>  static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
> @@ -2318,7 +2375,19 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  				vmf->address);
>  		if (!new_page)
>  			goto oom;
> -		cow_user_page(new_page, old_page, vmf->address, vma);
> +
> +		if (!cow_user_page(new_page, old_page, vmf)) {
> +			/*
> +			 * COW failed, if the fault was solved by other,
> +			 * it's fine. If not, userspace would re-fault on
> +			 * the same address and we will handle the fault
> +			 * from the second attempt.
> +			 */
> +			put_page(new_page);
> +			if (old_page)
> +				put_page(old_page);
> +			return 0;
> +		}
>  	}
>  
>  	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg, false))
> -- 
> 2.17.1
> 

-- 
Catalin
