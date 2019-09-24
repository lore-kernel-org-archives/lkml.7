Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98814C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4472146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jTeTNKav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbfIXPpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:45:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388223AbfIXPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jOfR9f04JOdM45K4qEfyjOiS102zGBwkqhbp9cILr54=; b=jTeTNKavnzWQmuz8rP0rGwEdF
        +y4XPaqQc9k8kMo4jiHGsbF63UCJsAKGtjbqcRCYyHuJ2wi8bHMsCKFMhsev2a3tibjtKH2g7GGuP
        GyBrxiaVFTLjMIV3R82zC1YOkkqcgFWPmbcy/FKqmLNsWzeWIqtQG9tmHssSN/lZdT2ciOsDJs3TV
        cSUSUWfUXeU6sfMEIjVdEOzib431n5HZeR/JUaxp2tT2p5XwJU0mfDp6INWj+TAeg8/ByM/SnIllx
        tdWoYf0qvTys70NsMosJkvgGIDdjiHIpVrCcD0N+PmbegflbquPV6qmihfj/1E9zbSPJZMlk73xoQ
        LFhP/JxwA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCn0A-0007Gx-R2; Tue, 24 Sep 2019 15:45:18 +0000
Date:   Tue, 24 Sep 2019 08:45:18 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Marty McFadden <mcfadden8@llnl.gov>, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 05/10] mm: Return faster for non-fatal signals in user
 mode faults
Message-ID: <20190924154518.GG1855@bombadil.infradead.org>
References: <20190923042523.10027-1-peterx@redhat.com>
 <20190923042523.10027-6-peterx@redhat.com>
 <CAHk-=wiNGtUaXtRv1wniw3hfxFnU7SO7ZuisFSVg0btvROcW6w@mail.gmail.com>
 <20190924024721.GD28074@xz-x1>
 <20190924025447.GE1855@bombadil.infradead.org>
 <20190924031908.GF28074@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924031908.GF28074@xz-x1>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 11:19:08AM +0800, Peter Xu wrote:
> On Mon, Sep 23, 2019 at 07:54:47PM -0700, Matthew Wilcox wrote:
> > On Tue, Sep 24, 2019 at 10:47:21AM +0800, Peter Xu wrote:
> > > On Mon, Sep 23, 2019 at 11:03:49AM -0700, Linus Torvalds wrote:
> > > > On Sun, Sep 22, 2019 at 9:26 PM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > This patch is a preparation of removing that special path by allowing
> > > > > the page fault to return even faster if we were interrupted by a
> > > > > non-fatal signal during a user-mode page fault handling routine.
> > > > 
> > > > So I really wish saome other vm person would also review these things,
> > > > but looking over this series once more, this is the patch I probably
> > > > like the least.
> > > > 
> > > > And the reason I like it the least is that I have a hard time
> > > > explaining to myself what the code does and why, and why it's so full
> > > > of this pattern:
> > > > 
> > > > > -       if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> > > > > +       if ((fault & VM_FAULT_RETRY) &&
> > > > > +           fault_should_check_signal(user_mode(regs)))
> > > > >                 return;
> > > > 
> > > > which isn't all that pretty.
> > > > 
> > > > Why isn't this just
> > > > 
> > > >   static bool fault_signal_pending(unsigned int fault_flags, struct
> > > > pt_regs *regs)
> > > >   {
> > > >         return (fault_flags & VM_FAULT_RETRY) &&
> > > >                 (fatal_signal_pending(current) ||
> > > >                  (user_mode(regs) && signal_pending(current)));
> > > >   }
> > > > 
> > > > and then most of the users would be something like
> > > > 
> > > >         if (fault_signal_pending(fault, regs))
> > > >                 return;
> > > > 
> > > > and the exceptions could do their own thing.
> > > > 
> > > > Now the code is prettier and more understandable, I feel.
> > > > 
> > > > And if something doesn't follow this pattern, maybe it either _should_
> > > > follow that pattern or it should just not use the helper but explain
> > > > why it has an unusual pattern.
> > 
> > > +++ b/arch/alpha/mm/fault.c
> > > @@ -150,7 +150,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
> > >  	   the fault.  */
> > >  	fault = handle_mm_fault(vma, address, flags);
> > >  
> > > -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> > > +	if (fault_signal_pending(fault, regs))
> > >  		return;
> > >  
> > >  	if (unlikely(fault & VM_FAULT_ERROR)) {
> > 
> > > +++ b/arch/arm/mm/fault.c
> > > @@ -301,6 +301,11 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> > >  		return 0;
> > >  	}
> > >  
> > > +	/* Fast path to handle user mode signals */
> > > +	if ((fault & VM_FAULT_RETRY) && user_mode(regs) &&
> > > +	    signal_pending(current))
> > > +		return 0;
> > 
> > But _why_ are they different?  This is a good opportunity to make more
> > code the same between architectures.
> 
> (Thanks for joining the discussion)
> 
> I'd like to do these - my only worry is that I can't really test them
> well simply because I don't have all the hardwares.  For now the
> changes are mostly straightforward so I'm relatively confident (not to
> mention the code needs proper reviews too, and of course I would
> appreciate much if anyone wants to smoke test it).  If I change it in
> a drastic way, I won't be that confident without some tests at least
> on multiple archs (not to mention that even smoke testing across major
> archs will be a huge amount of work...).  So IMHO those might be more
> suitable as follow-up for per-arch developers if we can at least reach
> a consensus on the whole idea of this patchset.

I think the way to do this is to introduce fault_signal_pending(),
converting the architectures to it that match that pattern.  Then one
patch per architecture to convert the ones which use a different pattern
to the same pattern.

Oh, and while you're looking at the callers of handle_mm_fault(), a
lot of them don't check conditions in the right order.  x86, at least,
handles FAULT_RETRY before handling FAULT_ERROR, which is clearly wrong.

Kirill and I recently discussed it here:
https://lore.kernel.org/linux-mm/20190911152338.gqqgxrmqycodfocb@box/T/
