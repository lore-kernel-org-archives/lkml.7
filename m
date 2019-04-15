Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E2EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EB1206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kwae56LU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfDOQOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:14:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35348 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfDOQOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8qX7lMV5ZLJfVM93dzSu7Tm9Urf60WLVZEZIANFnhCY=; b=Kwae56LUiJtR71D0lsNMAkCfn
        C7azt1tS2aNClYxrT3Y0hRjaFDb7RF/AbbhJKmu1whRFKA03LHJ2okb/XZqpDSq+Q+BzwLBNY0X71
        /r0uSUwwet5oXd3CrmqQNdoR/EVlC/UQPlk2W5EAahWCXu5MwRkLod4NP+TZKofwLbgmV8GSZHIkG
        UXBNp2jHoewRcBfrFvlK6apWk2N4IJESNlvhbfhUF35MeSEFj2BhgwYwXskI4V8wa9ZFEswBNmlFG
        X4OAl0Yt0OvThDtJTRH0xgjbeqxzY5mulzi9zx6jQzB39VUYF8X5weRkRBM1zw74jEIdYwjXFg3kb
        Df1SSDjgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG4FB-0002vx-IR; Mon, 15 Apr 2019 16:14:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BDE628B6D259; Mon, 15 Apr 2019 18:14:04 +0200 (CEST)
Date:   Mon, 15 Apr 2019 18:14:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v2] x86: mm: Do not use set_{pud,pmd}_safe when splitting
 the large page
Message-ID: <20190415161404.GL4038@hirez.programming.kicks-ass.net>
References: <20190415145515.13559-1-brijesh.singh@amd.com>
 <1aec4241-09c0-5295-7bb7-235e9a494d2c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aec4241-09c0-5295-7bb7-235e9a494d2c@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:58:52AM -0700, Dave Hansen wrote:
> On 4/15/19 7:55 AM, Singh, Brijesh wrote:
> >  static unsigned long __meminit
> >  phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
> > -	      pgprot_t prot)
> > +	      pgprot_t prot, bool safe)
> >  {
> >  	unsigned long pages = 0, paddr_next;
> >  	unsigned long paddr_last = paddr_end;
> > @@ -432,7 +463,7 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
> >  					     E820_TYPE_RAM) &&
> >  			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
> >  					     E820_TYPE_RESERVED_KERN))
> > -				set_pte_safe(pte, __pte(0));
> > +				__set_pte(pte, __pte(0), safe);
> >  			continue;
> >  		}
> 
> The changelog is great, btw.
> 
> But, I'm not a big fan of propagating the 'safe' nomenclature.  Could
> we, at least, call it 'overwrite_safe' or something if we're going to
> have a variable name?  Or even, 'new_entries_only' or something that
> actually conveys meaning?
> 
> Because, just reading it, I always wonder "why do we have an unsafe
> variant, that's stupid" every time. :)

s/safe/init/ on the whole thing?

And maybe even back on the initial _safe functions? Because all of this
is about initializing page-tables, which is a TLB *safe* operation I
suppose :-)

> > +#define DEFINE_ENTRY(type1, type2, safe)			\
> > +static inline void __set_##type1(type1##_t *arg1,		\
> > +			type2##_t arg2, bool safe)		\
> > +{								\
> > +	if (safe)						\
> > +		set_##type1##_safe(arg1, arg2);			\
> > +	else							\
> > +		set_##type1(arg1, arg2);			\
> > +}
> 
> While I appreciate the brevity that these macros allow, I detest their
> ability to thwart cscope and grep.  I guess it's just one file, but it
> does make me grumble a bit.

There is scripts/tags.sh where you can add to regex_c to teach
cscope/ctags about magic macros.

> Also, can we do better than "__"?  Aren't these specific to
> initialization, and only for the kernel?  Maybe we should call them
> meminit_set_pte() or kern_set_pte() or something so make it totally
> clear to the reader that they're new.

set_*_init() and set_*() I suppose.

> 
> > -		kernel_physical_mapping_init(__pa(vaddr & pmask),
> > -					     __pa((vaddr_end & pmask) + psize),
> > -					     split_page_size_mask);
> > +		kernel_physical_mapping_change(__pa(vaddr & pmask),
> > +					       __pa((vaddr_end & pmask) + psize),
> > +					       split_page_size_mask);
> 
> BTW, this hunk is really nice the way that the new naming makes it more
> intuitive what's going on.  My only nit w9uld be that we now have two
> very similarly-named functions with different TLB-flushing requirements.
> 
> Could we please include a comment at this site that reminds us that we
> owe a TLB flush after this?

Right, a comment would be good. I think my initial proposal had the TLB
flushing inside, but I see the usage is in a loop, so I appreciate the
desire to keep the TLB flushing outside.
