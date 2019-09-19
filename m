Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB64C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A1620882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbfISQmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:42:12 -0400
Received: from foss.arm.com ([217.140.110.172]:33950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732225AbfISQmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:42:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FF0B28;
        Thu, 19 Sep 2019 09:42:11 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A4983F575;
        Thu, 19 Sep 2019 09:42:08 -0700 (PDT)
Date:   Thu, 19 Sep 2019 17:42:06 +0100
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
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v5 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190919164206.GE6472@arrakis.emea.arm.com>
References: <20190919161204.142796-1-justin.he@arm.com>
 <20190919161204.142796-4-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919161204.142796-4-justin.he@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 12:12:04AM +0800, Jia He wrote:
> @@ -2152,7 +2163,29 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
>  	 */
>  	if (unlikely(!src)) {
>  		void *kaddr = kmap_atomic(dst);
> -		void __user *uaddr = (void __user *)(va & PAGE_MASK);
> +		void __user *uaddr = (void __user *)(addr & PAGE_MASK);
> +		pte_t entry;
> +
> +		/* On architectures with software "accessed" bits, we would
> +		 * take a double page fault, so mark it accessed here.
> +		 */
> +		if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
> +			spin_lock(vmf->ptl);
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
> +				return -1;
> +			}
> +			spin_unlock(vmf->ptl);

Returning with the spinlock held doesn't normally go very well ;).

-- 
Catalin
