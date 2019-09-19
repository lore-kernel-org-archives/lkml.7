Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82798C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8A5208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391447AbfISPvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:51:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:60486 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390134AbfISPvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:51:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 08:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,524,1559545200"; 
   d="scan'208";a="178091248"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2019 08:51:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 61703BD; Thu, 19 Sep 2019 18:51:24 +0300 (EEST)
Date:   Thu, 19 Sep 2019 18:51:24 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v4 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190919155124.56ps5vsd5al6g7hm@black.fi.intel.com>
References: <20190918131914.38081-1-justin.he@arm.com>
 <20190918131914.38081-4-justin.he@arm.com>
 <20190918140027.ckj32xnryyyesc23@box>
 <20190918180029.GB20601@iMac.local>
 <20190919150007.k7scjplcya53j7r4@box>
 <20190919154143.GA6472@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919154143.GA6472@arrakis.emea.arm.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 03:41:43PM +0000, Catalin Marinas wrote:
> On Thu, Sep 19, 2019 at 06:00:07PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Sep 18, 2019 at 07:00:30PM +0100, Catalin Marinas wrote:
> > > On Wed, Sep 18, 2019 at 05:00:27PM +0300, Kirill A. Shutemov wrote:
> > > > On Wed, Sep 18, 2019 at 09:19:14PM +0800, Jia He wrote:
> > > > > @@ -2152,20 +2163,34 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
> > > > >  	 */
> > > > >  	if (unlikely(!src)) {
> > > > >  		void *kaddr = kmap_atomic(dst);
> > > > > -		void __user *uaddr = (void __user *)(va & PAGE_MASK);
> > > > > +		void __user *uaddr = (void __user *)(addr & PAGE_MASK);
> > > > > +		pte_t entry;
> > > > >  
> > > > >  		/*
> > > > >  		 * This really shouldn't fail, because the page is there
> > > > >  		 * in the page tables. But it might just be unreadable,
> > > > >  		 * in which case we just give up and fill the result with
> > > > > -		 * zeroes.
> > > > > +		 * zeroes. On architectures with software "accessed" bits,
> > > > > +		 * we would take a double page fault here, so mark it
> > > > > +		 * accessed here.
> > > > >  		 */
> > > > > +		if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
> > > > > +			spin_lock(vmf->ptl);
> > > > > +			if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
> > > > > +				entry = pte_mkyoung(vmf->orig_pte);
> > > > > +				if (ptep_set_access_flags(vma, addr,
> > > > > +							  vmf->pte, entry, 0))
> > > > > +					update_mmu_cache(vma, addr, vmf->pte);
> > > > > +			}
> > > > 
> > > > I don't follow.
> > > > 
> > > > So if pte has changed under you, you don't set the accessed bit, but never
> > > > the less copy from the user.
> > > > 
> > > > What makes you think it will not trigger the same problem?
> > > > 
> > > > I think we need to make cow_user_page() fail in this case and caller --
> > > > wp_page_copy() -- return zero. If the fault was solved by other thread, we
> > > > are fine. If not userspace would re-fault on the same address and we will
> > > > handle the fault from the second attempt.
> > > 
> > > It would be nice to clarify the semantics of this function and do as
> > > you suggest but the current comment is slightly confusing:
> > > 
> > > 	/*
> > > 	 * If the source page was a PFN mapping, we don't have
> > > 	 * a "struct page" for it. We do a best-effort copy by
> > > 	 * just copying from the original user address. If that
> > > 	 * fails, we just zero-fill it. Live with it.
> > > 	 */
> > > 
> > > Would any user-space rely on getting a zero-filled page here instead of
> > > a recursive fault?
> > 
> > I don't see the point in zero-filled page in this case. SIGBUS sounds like
> > more appropriate response, no?
> 
> I think misunderstood your comment. So, if !pte_same(), we should let
> userspace re-fault. This wouldn't be a user ABI change and it is
> bounded, can't end up in an infinite re-fault loop.

Right. !pte_same() can only happen if we raced with somebody else.
I cannot imagine situation when the race will happen more than few times
in a row.

> In case of a __copy_from_user_inatomic() error, SIGBUS would make more
> sense but it changes the current behaviour (zero-filling the page). This
> can be left for a separate patch, doesn't affect the arm64 case here.

I think it's safer to leave it as is. Maybe put WARN_ON_ONCE() or
something. There can be some obscure use-case that I don't see.

-- 
 Kirill A. Shutemov
