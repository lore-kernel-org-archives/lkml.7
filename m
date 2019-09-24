Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895F9C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EE820872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390185AbfIXQfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:35:48 -0400
Received: from foss.arm.com ([217.140.110.172]:33480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388942AbfIXQfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:35:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5589A142F;
        Tue, 24 Sep 2019 09:35:47 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A49143F694;
        Tue, 24 Sep 2019 09:35:44 -0700 (PDT)
Date:   Tue, 24 Sep 2019 17:35:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jia He <hejianet@gmail.com>
Cc:     "Justin He (Arm Technology China)" <Justin.He@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v8 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190924163542.GI41214@arrakis.emea.arm.com>
References: <20190921135054.142360-1-justin.he@arm.com>
 <20190921135054.142360-4-justin.he@arm.com>
 <20190923170433.GE10192@arrakis.emea.arm.com>
 <DB7PR08MB3082BC38536AE16B056AEA05F7840@DB7PR08MB3082.eurprd08.prod.outlook.com>
 <20190924103324.GB41214@arrakis.emea.arm.com>
 <6267b685-5162-85ac-087f-112303bb7035@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6267b685-5162-85ac-087f-112303bb7035@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:29:07PM +0800, Jia He wrote:
> On 2019/9/24 18:33, Catalin Marinas wrote:
> > On Tue, Sep 24, 2019 at 06:43:06AM +0000, Justin He (Arm Technology China) wrote:
> > > Catalin Marinas wrote:
> > > > On Sat, Sep 21, 2019 at 09:50:54PM +0800, Jia He wrote:
> > > > >   		/*
> > > > >   		 * This really shouldn't fail, because the page is there
> > > > >   		 * in the page tables. But it might just be unreadable,
> > > > >   		 * in which case we just give up and fill the result with
> > > > >   		 * zeroes.
> > > > >   		 */
> > > > > -		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
> > > > > +		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
> > > > > +			/* Give a warn in case there can be some obscure
> > > > > +			 * use-case
> > > > > +			 */
> > > > > +			WARN_ON_ONCE(1);
> > > > That's more of a question for the mm guys: at this point we do the
> > > > copying with the ptl released; is there anything else that could have
> > > > made the pte old in the meantime? I think unuse_pte() is only called on
> > > > anonymous vmas, so it shouldn't be the case here.
> >
> > If we need to hold the ptl here, you could as well have an enclosing
> > kmap/kunmap_atomic (option 2) with some goto instead of "return false".
> 
> I am not 100% sure that I understand your suggestion well, so I
> drafted the patch

Well, however you think the code is cleaner really.

The copy/paste didn't work well, tabs disappeared (or rather the
Exchange server corrupting outgoing emails) but I'll try to comment
below:

> -static inline void cow_user_page(struct page *dst, struct page *src,
>   unsigned long va, struct vm_area_struct *vma)
> +static inline bool cow_user_page(struct page *dst, struct page *src,
> +                 struct vm_fault *vmf)
>  {
> +    struct vm_area_struct *vma = vmf->vma;
> +    struct mm_struct *mm = vma->vm_mm;
> +    unsigned long addr = vmf->address;
> +    bool ret;
> +    pte_t entry;
> +    void *kaddr;
> +    void __user *uaddr;
> +
>      debug_dma_assert_idle(src);
> 
> +    if (likely(src)) {
> +        copy_user_highpage(dst, src, addr, vma);
> +        return true;
> +    }
> +
>      /*
>       * If the source page was a PFN mapping, we don't have
>       * a "struct page" for it. We do a best-effort copy by
>       * just copying from the original user address. If that
>       * fails, we just zero-fill it. Live with it.
>       */
> -    if (unlikely(!src)) {
> -        void *kaddr = kmap_atomic(dst);
> -        void __user *uaddr = (void __user *)(va & PAGE_MASK);
> +    kaddr = kmap_atomic(dst);
> +    uaddr = (void __user *)(addr & PAGE_MASK);
> +
> +    /*
> +     * On architectures with software "accessed" bits, we would
> +     * take a double page fault, so mark it accessed here.
> +     */
> +    vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
> +    if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {

I'd move the pte_offset_map_lock() inside the 'if' block as we don't
want to affect architectures that handle old ptes automatically.

> +        if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
> +            /*
> +             * Other thread has already handled the fault
> +             * and we don't need to do anything. If it's
> +             * not the case, the fault will be triggered
> +             * again on the same address.
> +             */
> +            ret = false;
> +            goto pte_unlock;
> +        }
> +
> +        entry = pte_mkyoung(vmf->orig_pte);
> +        if (ptep_set_access_flags(vma, addr, vmf->pte, entry, 0))
> +            update_mmu_cache(vma, addr, vmf->pte);
> +    }
> 
> +    /*
> +     * This really shouldn't fail, because the page is there
> +     * in the page tables. But it might just be unreadable,
> +     * in which case we just give up and fill the result with
> +     * zeroes.
> +     */
> +    if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
>          /*
> -         * This really shouldn't fail, because the page is there
> -         * in the page tables. But it might just be unreadable,
> -         * in which case we just give up and fill the result with
> -         * zeroes.
> +         * Give a warn in case there can be some obscure
> +         * use-case
>           */
> -        if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
> -            clear_page(kaddr);
> -        kunmap_atomic(kaddr);
> -        flush_dcache_page(dst);
> -    } else
> -        copy_user_highpage(dst, src, va, vma);
> +        WARN_ON_ONCE(1);
> +        clear_page(kaddr);
> +    }
> +
> +    ret = true;
> +
> +pte_unlock:
> +    pte_unmap_unlock(vmf->pte, vmf->ptl);

Since the locking would be moved in the 'if' block above, we need
another check here before unlocking:

	if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte))
		pte_unmap_unlock(vmf->pte, vmf->ptl);

You could probably replace the two calls to arch_faults_on_old_pte()
with a single bool variable initialisation, something like:

	force_mkyoung = arch_faults_on_old_pte() &&
		!pte_young(vmf->orig_pte)

and only check for "if (force_mkyoung)" in both cases.

> +    kunmap_atomic(kaddr);
> +    flush_dcache_page(dst);
> +
> +    return ret;
>  }

-- 
Catalin
