Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEAAC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2BE21655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="kzEdrK5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504756AbfIXL7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:59:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37801 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388614AbfIXL7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:59:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4so1577689edy.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 04:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yfQkKYdmCnwP8GQDgvukKfhrIz/ARlVTMjl+vdxLN6c=;
        b=kzEdrK5KGIj08/JrZaz8ci6yj9t/++4d8rPavj45ueJFdJnWlcvcyYaB9yXFzNq1s7
         0dklLEr6JucXgsFCgpSAkAFPz41EaQevI/b4nzl96v3QRXNPxXKHHI0SkRwaJpLnksee
         El9UuJAKUOUVmCIdYXeenQzTr7JEFbSV8qfF3gAS/OyomlySVvlHsAzBeJYGrqKy8QN0
         yDF44Ru/+H0sXp/w9OjFg4+EFTjuB1AwthMG1aoT3+fEN6PN5uuTIkT0ThZJWnpms4XM
         qHSyTHNQi9831Ltqc0s3+HNvEtr0x8iU7FlXykNOVwZ25p8Qnp++bxWaTBo7dm4VRZuB
         HtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yfQkKYdmCnwP8GQDgvukKfhrIz/ARlVTMjl+vdxLN6c=;
        b=DvckHdwERKoXT6hLYtLTZHGbHxzZnuo9hx5j4z/xkNmWzUY1E4F+WKY3vdbrag4d8A
         MxslLp9CfhcQSw9H1VtQWisFVqgqyj6xqe8URTtCzn2RPFEhqhGTVas9xTM6CPrgfjwU
         gIAxVSKCwJaJfKgpCuDWxjqOXixbWv6FIHVbADr+GIGJkVk1o8XuheoQhf3zScTKfNQ/
         u9j2sIfrspfPjkGL3s6G+XnvMlaObn4NBjw0N0u3OmCiVVqFF9s9rPkGC9Wtr8GeEkEA
         0u1WRDizU0DKEJpsYEAyALpsiCr2v5bd93r2U3TVI7xKc82ufEt1ZuK3H5TG2hxOOEdE
         RsZw==
X-Gm-Message-State: APjAAAUEcLMwt8vVwoYkZJ9zF4wqhSrMSkNXy16FC2UsPMe+a6PBLwyE
        QjwtES8hPCkC+vGyQatYDfrs1A==
X-Google-Smtp-Source: APXvYqywWn8dGPH0MFvcwZjCOlr8PR0mjKnlZh5uuaMJO79gEAj4kKuFC9SRjmQzB0N/ONkPZRk9KQ==
X-Received: by 2002:a17:906:860d:: with SMTP id o13mr2037274ejx.284.1569326353237;
        Tue, 24 Sep 2019 04:59:13 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id ci8sm188286ejb.71.2019.09.24.04.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 04:59:12 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id AD8A41022A6; Tue, 24 Sep 2019 14:59:13 +0300 (+03)
Date:   Tue, 24 Sep 2019 14:59:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v8 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Message-ID: <20190924115913.ju67nr4gcdbzbeva@box>
References: <20190921135054.142360-1-justin.he@arm.com>
 <20190921135054.142360-4-justin.he@arm.com>
 <20190923170433.GE10192@arrakis.emea.arm.com>
 <DB7PR08MB3082BC38536AE16B056AEA05F7840@DB7PR08MB3082.eurprd08.prod.outlook.com>
 <20190924103324.GB41214@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924103324.GB41214@arrakis.emea.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:33:25AM +0100, Catalin Marinas wrote:
> On Tue, Sep 24, 2019 at 06:43:06AM +0000, Justin He (Arm Technology China) wrote:
> > Catalin Marinas wrote:
> > > On Sat, Sep 21, 2019 at 09:50:54PM +0800, Jia He wrote:
> > > > @@ -2151,21 +2163,53 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
> > > >  	 * fails, we just zero-fill it. Live with it.
> > > >  	 */
> > > >  	if (unlikely(!src)) {
> > > > -		void *kaddr = kmap_atomic(dst);
> > > > -		void __user *uaddr = (void __user *)(va & PAGE_MASK);
> > > > +		void *kaddr;
> > > > +		pte_t entry;
> > > > +		void __user *uaddr = (void __user *)(addr & PAGE_MASK);
> > > >
> > > > +		/* On architectures with software "accessed" bits, we would
> > > > +		 * take a double page fault, so mark it accessed here.
> > > > +		 */
> [...]
> > > > +		if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
> > > > +			vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr,
> > > > +						       &vmf->ptl);
> > > > +			if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
> > > > +				entry = pte_mkyoung(vmf->orig_pte);
> > > > +				if (ptep_set_access_flags(vma, addr,
> > > > +							  vmf->pte, entry, 0))
> > > > +					update_mmu_cache(vma, addr, vmf->pte);
> > > > +			} else {
> > > > +				/* Other thread has already handled the fault
> > > > +				 * and we don't need to do anything. If it's
> > > > +				 * not the case, the fault will be triggered
> > > > +				 * again on the same address.
> > > > +				 */
> > > > +				pte_unmap_unlock(vmf->pte, vmf->ptl);
> > > > +				return false;
> > > > +			}
> > > > +			pte_unmap_unlock(vmf->pte, vmf->ptl);
> > > > +		}
> [...]
> > > > +
> > > > +		kaddr = kmap_atomic(dst);
> > > 
> > > Since you moved the kmap_atomic() here, could the above
> > > arch_faults_on_old_pte() run in a preemptible context? I suggested to
> > > add a WARN_ON in patch 2 to be sure.
> > 
> > Should I move kmap_atomic back to the original line? Thus, we can make sure
> > that arch_faults_on_old_pte() is in the context of preempt_disabled?
> > Otherwise, arch_faults_on_old_pte() may cause plenty of warning if I add
> > a WARN_ON in arch_faults_on_old_pte.  I tested it when I enable the PREEMPT=y
> > on a ThunderX2 qemu guest.
> 
> So we have two options here:
> 
> 1. Change arch_faults_on_old_pte() scope to the whole system rather than
>    just the current CPU. You'd have to wire up a new arm64 capability
>    for the access flag but this way we don't care whether it's
>    preemptible or not.
> 
> 2. Keep the arch_faults_on_old_pte() per-CPU but make sure we are not
>    preempted here. The kmap_atomic() move would do but you'd have to
>    kunmap_atomic() before the return.
> 
> I think the answer to my question below also has some implication on
> which option to pick:
> 
> > > >  		/*
> > > >  		 * This really shouldn't fail, because the page is there
> > > >  		 * in the page tables. But it might just be unreadable,
> > > >  		 * in which case we just give up and fill the result with
> > > >  		 * zeroes.
> > > >  		 */
> > > > -		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
> > > > +		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
> > > > +			/* Give a warn in case there can be some obscure
> > > > +			 * use-case
> > > > +			 */
> > > > +			WARN_ON_ONCE(1);
> > > 
> > > That's more of a question for the mm guys: at this point we do the
> > > copying with the ptl released; is there anything else that could have
> > > made the pte old in the meantime? I think unuse_pte() is only called on
> > > anonymous vmas, so it shouldn't be the case here.
> 
> If we need to hold the ptl here, you could as well have an enclosing
> kmap/kunmap_atomic (option 2) with some goto instead of "return false".

Yeah, look like we need to hold ptl for longer. There is nothing I see
that would prevent clearing young bit under us otherwise.

-- 
 Kirill A. Shutemov
