Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793E6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390B82083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gZsx/MRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCAVoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:44:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCAVoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I9/CQcAMDAqcYCsl2DT89h8s6NYBhCyEInQQWC9dKTs=; b=gZsx/MRd9hanHUjfdTuQVYJ+C
        nMOzKwG7k5f3/hFIoZjl9bGK+TIAnhAdQ71G/l4JOONFkCLZfHCCas7fec/JZlay0d5cFRXtDG3U6
        94w1fdTGs6AEuu1MwMW36NKO9RId79VIBJ/u+14EAaOwGD2w09Wg/SgZYZobduenYb+RQhVD74cFt
        74k2UCTIAwt+Ev+aUYu+5QyyNfRHHln0h5YJkVJco0iIo61CxEfVINQh/n0iA/Y2eZT312XZ3TqKW
        s56s+Tey92hu5qTFTmyofQXF3P+/HJw61pPCUfXS538kj/aHcWe9zquT7hbdB3h74TI2vukxg1ABY
        eNhHwKY4w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzpww-00049o-JI; Fri, 01 Mar 2019 21:44:10 +0000
Date:   Fri, 1 Mar 2019 13:44:10 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugepages: fix "orig_pud" set but not used
Message-ID: <20190301214410.GO11592@bombadil.infradead.org>
References: <20190301004903.89514-1-cai@lca.pw>
 <20190301130951.67f419011da93265d36226cc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301130951.67f419011da93265d36226cc@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 01:09:51PM -0800, Andrew Morton wrote:
> On Thu, 28 Feb 2019 19:49:03 -0500 Qian Cai <cai@lca.pw> wrote:
> 
> > The commit a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent
> > hugepages") introduced pudp_huge_get_and_clear_full() but no one uses
> > its return code, so just make it void.
> > 
> > mm/huge_memory.c: In function 'zap_huge_pud':
> > mm/huge_memory.c:1982:8: warning: variable 'orig_pud' set but not used
> > [-Wunused-but-set-variable]
> >   pud_t orig_pud;
> >         ^~~~~~~~
> > 
> > ...
> >
> > --- a/include/asm-generic/pgtable.h
> > +++ b/include/asm-generic/pgtable.h
> > @@ -167,11 +167,11 @@ static inline pmd_t pmdp_huge_get_and_clear_full(struct mm_struct *mm,
> >  #endif
> >  
> >  #ifndef __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR_FULL
> > -static inline pud_t pudp_huge_get_and_clear_full(struct mm_struct *mm,
> > -					    unsigned long address, pud_t *pudp,
> > -					    int full)
> > +static inline void pudp_huge_get_and_clear_full(struct mm_struct *mm,
> > +						unsigned long address,
> > +						pud_t *pudp, int full)
> >  {
> > -	return pudp_huge_get_and_clear(mm, address, pudp);
> > +	pudp_huge_get_and_clear(mm, address, pudp);
> >  }
> 
> Not sure this is a good change.  Future callers might want that return
> value.
> 
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1979,7 +1979,6 @@ spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
> >  int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >  		 pud_t *pud, unsigned long addr)
> >  {
> > -	pud_t orig_pud;
> >  	spinlock_t *ptl;
> >  
> >  	ptl = __pud_trans_huge_lock(pud, vma);
> > @@ -1991,8 +1990,7 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >  	 * pgtable_trans_huge_withdraw after finishing pudp related
> >  	 * operations.
> >  	 */
> > -	orig_pud = pudp_huge_get_and_clear_full(tlb->mm, addr, pud,
> > -			tlb->fullmm);
> > +	pudp_huge_get_and_clear_full(tlb->mm, addr, pud, tlb->fullmm);
> 
> In fact this code perhaps should be passing orig_pud into
> pudp_huge_get_and_clear_full().  That could depend on what future
> per-arch implementations of pudp_huge_get_and_clear_full() choose to
> do.
> 
> Anyway, I'll await Matthew's feedback.

I'm not sure it's wise to diverge from pmdp_huge_get_and_clear_full()
which does return the orig_pud.  I agree we don't currently use it,
so maybe we should just change zap_huge_pud() to not assign the return
value from pudp_huge_get_and_clear_full()?
