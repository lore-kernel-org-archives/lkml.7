Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA7AC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EDE2168B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439949AbfIWREk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:04:40 -0400
Received: from foss.arm.com ([217.140.110.172]:45666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732522AbfIWREk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:04:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EBAE1000;
        Mon, 23 Sep 2019 10:04:39 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E0523F67D;
        Mon, 23 Sep 2019 10:04:36 -0700 (PDT)
Date:   Mon, 23 Sep 2019 18:04:34 +0100
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
Subject: Re: [PATCH v8 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190923170433.GE10192@arrakis.emea.arm.com>
References: <20190921135054.142360-1-justin.he@arm.com>
 <20190921135054.142360-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190921135054.142360-4-justin.he@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 09:50:54PM +0800, Jia He wrote:
> @@ -2151,21 +2163,53 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
>  	 * fails, we just zero-fill it. Live with it.
>  	 */
>  	if (unlikely(!src)) {
> -		void *kaddr = kmap_atomic(dst);
> -		void __user *uaddr = (void __user *)(va & PAGE_MASK);
> +		void *kaddr;
> +		pte_t entry;
> +		void __user *uaddr = (void __user *)(addr & PAGE_MASK);
>  
> +		/* On architectures with software "accessed" bits, we would
> +		 * take a double page fault, so mark it accessed here.
> +		 */

Nitpick: please follow the kernel coding style for multi-line comments
(above and the for the rest of the patch):

		/*
		 * Your multi-line comment.
		 */

> +		if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
> +			vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr,
> +						       &vmf->ptl);
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
> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
> +				return false;
> +			}
> +			pte_unmap_unlock(vmf->pte, vmf->ptl);
> +		}

Another nit, you could rewrite this block slightly to avoid too much
indentation. Something like (untested):

		if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
			vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr,
						       &vmf->ptl);
			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
				/*
				 * Other thread has already handled the fault
				 * and we don't need to do anything. If it's
				 * not the case, the fault will be triggered
				 * again on the same address.
				 */
				pte_unmap_unlock(vmf->pte, vmf->ptl);
				return false;
			}
			entry = pte_mkyoung(vmf->orig_pte);
			if (ptep_set_access_flags(vma, addr,
						  vmf->pte, entry, 0))
				update_mmu_cache(vma, addr, vmf->pte);
			pte_unmap_unlock(vmf->pte, vmf->ptl);
		}

> +
> +		kaddr = kmap_atomic(dst);

Since you moved the kmap_atomic() here, could the above
arch_faults_on_old_pte() run in a preemptible context? I suggested to
add a WARN_ON in patch 2 to be sure.

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

That's more of a question for the mm guys: at this point we do the
copying with the ptl released; is there anything else that could have
made the pte old in the meantime? I think unuse_pte() is only called on
anonymous vmas, so it shouldn't be the case here.

>  			clear_page(kaddr);
> +		}
>  		kunmap_atomic(kaddr);
>  		flush_dcache_page(dst);
>  	} else
> -		copy_user_highpage(dst, src, va, vma);
> +		copy_user_highpage(dst, src, addr, vma);
> +
> +	return true;
>  }

-- 
Catalin
