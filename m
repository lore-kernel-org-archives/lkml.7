Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F43BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA76B2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="w5w0Jz+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408419AbfITJDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:03:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37507 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405602AbfITJDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:03:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4so5692606edy.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7f7iIewityqCPGZx7dQm7jfBt0RvFj0GrtCbkpP6ccU=;
        b=w5w0Jz+jH7Pg37OdeijB29i5yxb9yKmdsDbkLFFQjznoGPwxm3fzMCgxsaIrfLCzzc
         OJnMMYN8y9lFwzlL1QUOoXOUiGTbq7EDPjgNs9UzQwaVMCpEnMCFO23sSonOWti0utit
         a/l4E+vlM5oP6rLPtk4qybkOL3h2nhd5AGyLli/SlFfI/h2fXpXvlE5GyE9WNrASaAR4
         Lh5BUwHfYLvfvjcgG9rSLWsvwbeYQoVOrfjl4DR+qRNG93dEZ1cVSZhoi5fu5U14VUdl
         fg3To7OKWvBt4fkNatKsyo+x0G8U/BbQBt9/cbVJ9LYelUYqtvjThZeOrKNVh35P3fpb
         mXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7f7iIewityqCPGZx7dQm7jfBt0RvFj0GrtCbkpP6ccU=;
        b=T+hOrbXbI66fmM0ZhudsplMQfaBEN8cUnqw4gmVabmnYz3oRUldHtDUuPvYB5/Jyu1
         HDOaucuPuFAQgHwpKxEr9sR1XHN4GRb+19oVbQpwk6/RUuhNevg1ra4meQtMsmzBvq+O
         iJnmNghRqSSstQxVr3QBH7bPAqjVoIc2pG6mDcY0sHmUAbFvn3i3cUsG6TleFxNggn0S
         Rad0RCv9M0maYYIJM6BPhQxbLP1rtUy36VKqN+oBpV1Jl5HNc8XQ3wkNHlbSPLRtOvZ7
         Uz+srXQOrpUdmxCczlUdIarMTmaCgyIM4SkO0C7Mbmr3Z6oW0KfcUX33wuSI9/86auPI
         /XdQ==
X-Gm-Message-State: APjAAAXnFtPVm35ybHaMgt2iBVK9EhbuA9adoapkrGYOFauiRFA345Q0
        MRh/TUNWlaxaF/Al5OSWb4No+g==
X-Google-Smtp-Source: APXvYqySJJLb2ToIjdZWEjdisjwCvQmt8kW2QvOzzR1Iyip5v/Cl1a++EDimj/ghAzYeSyWZlm2w9g==
X-Received: by 2002:a17:906:3110:: with SMTP id 16mr11058571ejx.306.1568970221772;
        Fri, 20 Sep 2019 02:03:41 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v4sm214627edy.54.2019.09.20.02.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 02:03:40 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D180310077B; Fri, 20 Sep 2019 12:03:40 +0300 (+03)
Date:   Fri, 20 Sep 2019 12:03:40 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v6 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190920090340.6emsac4s6gdd75sj@box>
References: <20190920022132.149467-1-justin.he@arm.com>
 <20190920022132.149467-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920022132.149467-4-justin.he@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 10:21:32AM +0800, Jia He wrote:
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
> Reported-by: Yibo Cai <Yibo.Cai@arm.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  mm/memory.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index e2bb51b6242e..7c38c1ce5440 100644
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
> @@ -2140,8 +2147,12 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
>  	return same;
>  }
>  
> -static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
> +static inline int cow_user_page(struct page *dst, struct page *src,
> +				struct vm_fault *vmf)
>  {
> +	struct vm_area_struct *vma = vmf->vma;
> +	unsigned long addr = vmf->address;
> +
>  	debug_dma_assert_idle(src);
>  
>  	/*
> @@ -2151,21 +2162,52 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
>  	 * fails, we just zero-fill it. Live with it.
>  	 */
>  	if (unlikely(!src)) {
> -		void *kaddr = kmap_atomic(dst);
> -		void __user *uaddr = (void __user *)(va & PAGE_MASK);
> +		void *kaddr;
> +		void __user *uaddr = (void __user *)(addr & PAGE_MASK);
> +		pte_t entry;
> +
> +		/* On architectures with software "accessed" bits, we would
> +		 * take a double page fault, so mark it accessed here.
> +		 */
> +		if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
> +			spin_lock(vmf->ptl);

It's probably okay for arm64, but for archs with highmem it will be
a problem.

Use pte_offset_map_lock() instead.

> +			if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
> +				entry = pte_mkyoung(vmf->orig_pte);
> +				if (ptep_set_access_flags(vma, addr,
> +							  vmf->pte, entry, 0))
> +					update_mmu_cache(vma, addr, vmf->pte);
> +			} else {
> +				/* Other thread has already handled the fault
> +				 * and we don't need to do anything. If it's
> +				 * not the case, the fault will be triggered
> +				 * again on the same address.
> +				 */
> +				spin_unlock(vmf->ptl);

And pte_unmap_unlock() here...

> +				return -1;
> +			}
> +			spin_unlock(vmf->ptl);

and here.

> +		}
>  
> +		kaddr = kmap_atomic(dst);
>  		/*
>  		 * This really shouldn't fail, because the page is there
>  		 * in the page tables. But it might just be unreadable,
>  		 * in which case we just give up and fill the result with
>  		 * zeroes.
>  		 */
> -		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
> +		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
> +			/* Give a warn in case there can be some obscure
> +			 * use-case
> +			 */
> +			WARN_ON_ONCE(1);
>  			clear_page(kaddr);
> +		}
>  		kunmap_atomic(kaddr);
>  		flush_dcache_page(dst);
>  	} else
> -		copy_user_highpage(dst, src, va, vma);
> +		copy_user_highpage(dst, src, addr, vma);
> +
> +	return 0;
>  }
>  
>  static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
> @@ -2318,7 +2360,16 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  				vmf->address);
>  		if (!new_page)
>  			goto oom;
> -		cow_user_page(new_page, old_page, vmf->address, vma);
> +
> +		if (cow_user_page(new_page, old_page, vmf)) {
> +			/* COW failed, if the fault was solved by other,
> +			 * it's fine. If not, userspace would re-fault on
> +			 * the same address and we will handle the fault
> +			 * from the second attempt.
> +			 */
> +			put_page(new_page);

I think you also need to give the reference on the old page back:

			if (old_page)
				put_page(old_page);

> +			goto normal;

I don't see much point in this goto. Just return 0.
> +		}
>  	}
>  
>  	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg, false))
> @@ -2420,6 +2471,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		}
>  		put_page(old_page);
>  	}
> +
> +normal:
>  	return page_copied ? VM_FAULT_WRITE : 0;
>  oom_free_new:
>  	put_page(new_page);
> -- 
> 2.17.1
> 
> 

-- 
 Kirill A. Shutemov
