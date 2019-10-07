Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8E2ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29854206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="odoQ7M8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfJGSLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:11:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45354 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGSLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:11:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so20502330qtj.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C57iBY/lvItZ8Dqp104KcV48DHmLXeJ/LePjUooFql4=;
        b=odoQ7M8lZTXPwtj2RJPv2C8GWiSQ45ucrBmbyh0P2/mlbgsNcJUIwzaa7xEwsEmuWe
         VoAXrW5x9cKaMLoIIkJilzd90Mk1JXXHSbPj7ov9vndjFMp8ADFphm+nCyh+SUsCm6WC
         Y40nYduS+oPDc+jPEf1lzHng3lYe55Cx0SNWM0Xf5ctYIJioYMkKCRdq8eWqAwt8XMZY
         NBdrzvC1OYY1866f4zNS4PgTcy/My02fgMqlKqCjvMbd6+jFPph8UmPP99sJoRWqhnH1
         BCIokZu+eebMIm5PhJcv7SGkEHQbOPaGItz1ogvWFvGa9EB7UuVFfDG9lQhQuDam/P1Z
         mk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C57iBY/lvItZ8Dqp104KcV48DHmLXeJ/LePjUooFql4=;
        b=G2992uDcXKNKL+wFW1BvLIy3ubQLGMPWxPR5tEHUsaiEFFupFGUhOz217G/3G+KC2C
         On5Ml5YclvzwdcZ8QV9x2LuRHLTut8DVqfNxSkpJEeX5cMVqY/fZ4Z/d+PtWCHBGaIyw
         dTlg0ZdbKBc7FuAXh4YHc2qWpP4Akdap2pNFltXjDbYY6XP1RXAQsIJBsYamonmt96Xi
         easaivjZ1Z9W7BwybIAgYAmdoPCQ1hqITERhhQWE7ZI6viUHUqzmxjvnzPh3VAWMlzBL
         iqrmirwO8tVq2nEOLL0Y8dkRZ3VoRI6lB29wIg7AjNUv9zRjh5fy2h5K26Ug0bCl1nCB
         F/cg==
X-Gm-Message-State: APjAAAXtoBs4kl5B/mLENUyzSR/xR857hyZqrlf9H+fTc9y/NO3wMiWO
        cOy4F9nh70J2SuMrEnXAV//ENA==
X-Google-Smtp-Source: APXvYqzfloaIHtCD4grmgryCyyJiy1Vl45sjxwGuBPDO16urH8mhT+QtavoYJkIRRAEqLiwuwRR7Cg==
X-Received: by 2002:ac8:2d2c:: with SMTP id n41mr31355650qta.335.1570471875205;
        Mon, 07 Oct 2019 11:11:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id s17sm7755821qkg.79.2019.10.07.11.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 11:11:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iHXTV-0007lh-Lt; Mon, 07 Oct 2019 15:11:13 -0300
Date:   Mon, 7 Oct 2019 15:11:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Steven Price <steven.price@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v11 14/22] mm: pagewalk: Add 'depth' parameter to pte_hole
Message-ID: <20191007181113.GC13229@ziepe.ca>
References: <20191007153822.16518-1-steven.price@arm.com>
 <20191007153822.16518-15-steven.price@arm.com>
 <20191007161049.GA13229@ziepe.ca>
 <6e570d6d-b29f-f4cb-1eb9-6ff6cab15a2e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e570d6d-b29f-f4cb-1eb9-6ff6cab15a2e@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 05:20:30PM +0100, Steven Price wrote:
> On 07/10/2019 17:10, Jason Gunthorpe wrote:
> > On Mon, Oct 07, 2019 at 04:38:14PM +0100, Steven Price wrote:
> >> diff --git a/mm/hmm.c b/mm/hmm.c
> >> index 902f5fa6bf93..34fe904dd417 100644
> >> +++ b/mm/hmm.c
> >> @@ -376,7 +376,7 @@ static void hmm_range_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
> >>  }
> >>  
> >>  static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
> >> -			     struct mm_walk *walk)
> >> +			     __always_unused int depth, struct mm_walk *walk)
> > 
> > It this __always_unused on function arguments something we are doing
> > now?
> 
> $ git grep __always_unused | wc -l
> 191
> 
> It's elsewhere in the kernel tree. It seems like a good way of both
> documenting and silencing compiler warnings. But I'm open to other
> suggestions.

The normal kernel build doesn't generate warnings for unused function
parameters because there are alot of false positives, IIRC. So, seems
weird to see things like this.

> > Can we have negative depth? Should it be unsigned?
> 
> As per the documentation added in this patch:
> 
>  * @pte_hole:	if set, called for each hole at all levels,
>  *		depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD
>  *		4:PTE. Any folded depths (where PTRS_PER_P?D is equal
>  *		to 1) are skipped.
> 
> So it's signed to allow "-1" in the cases where pte_hole is called
> without knowing the actual depth. This is used in the function
> walk_page_test() because it don't walk the actual page tables, but is
> called on a VMA instead. This means that there may not be a single depth
> for the range provided.

So are the depth values below OK? I would have expected -1 by this
definition

> >>  {
> >>  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
> >>  	struct hmm_range *range = hmm_vma_walk->range;
> >> @@ -564,7 +564,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
> >>  again:
> >>  	pmd = READ_ONCE(*pmdp);
> >>  	if (pmd_none(pmd))
> >> -		return hmm_vma_walk_hole(start, end, walk);
> >> +		return hmm_vma_walk_hole(start, end, 0, walk);
> >>  
> >>  	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
> >>  		bool fault, write_fault;
> >> @@ -666,7 +666,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
> >>  again:
> >>  	pud = READ_ONCE(*pudp);
> >>  	if (pud_none(pud))
> >> -		return hmm_vma_walk_hole(start, end, walk);
> >> +		return hmm_vma_walk_hole(start, end, 0, walk);
> >>  
> >>  	if (pud_huge(pud) && pud_devmap(pud)) {
> >>  		unsigned long i, npages, pfn;
> >> @@ -674,7 +674,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
> >>  		bool fault, write_fault;
> >>  
> >>  		if (!pud_present(pud))
> >> -			return hmm_vma_walk_hole(start, end, walk);
> >> +			return hmm_vma_walk_hole(start, end, 0, walk);
> >>  
> >>  		i = (addr - range->start) >> PAGE_SHIFT;
> >>  		npages = (end - addr) >> PAGE_SHIFT;
