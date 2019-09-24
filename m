Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4FCC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC657207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RqRYQMPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408818AbfIXCyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:54:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408143AbfIXCyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/DJNNX8am+OPFrfhRWv8QK+73Tkk4zg/UVywTKFicBE=; b=RqRYQMPAOnZ/5zeYU+pgnLf8v
        WPsErvbclrAM0RhdNKnbhFY/qvPgBEZhw3SNqT4knMFlfm6KJxbjbluGS7hnhV7JB3EwXZdHqbUMt
        A6naj4Q9dspz3KN/oM4DVKPhENnGvXvjm7JMpJz/Jrgt6RIhrUGSgahci+Bw+91NFhl/HMCHh7Ygu
        8yCEc+Ext1uobv/KB3kjRYBfCEbP0SNb04QsfBqhmNvLADSUgjHIS4bAGdxDoeI9JwfLXJnaT0/2J
        hWyRy61evmLeldRUm3IODMCIbdQpu0tcmdcvPX3g7htkxlR+htGn/K/dzaN9sRTDlQAtXKHPJcPCr
        Q1Ezm/hKw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCayV-0005bB-Tm; Tue, 24 Sep 2019 02:54:47 +0000
Date:   Mon, 23 Sep 2019 19:54:47 -0700
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
Message-ID: <20190924025447.GE1855@bombadil.infradead.org>
References: <20190923042523.10027-1-peterx@redhat.com>
 <20190923042523.10027-6-peterx@redhat.com>
 <CAHk-=wiNGtUaXtRv1wniw3hfxFnU7SO7ZuisFSVg0btvROcW6w@mail.gmail.com>
 <20190924024721.GD28074@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924024721.GD28074@xz-x1>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:47:21AM +0800, Peter Xu wrote:
> On Mon, Sep 23, 2019 at 11:03:49AM -0700, Linus Torvalds wrote:
> > On Sun, Sep 22, 2019 at 9:26 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > This patch is a preparation of removing that special path by allowing
> > > the page fault to return even faster if we were interrupted by a
> > > non-fatal signal during a user-mode page fault handling routine.
> > 
> > So I really wish saome other vm person would also review these things,
> > but looking over this series once more, this is the patch I probably
> > like the least.
> > 
> > And the reason I like it the least is that I have a hard time
> > explaining to myself what the code does and why, and why it's so full
> > of this pattern:
> > 
> > > -       if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> > > +       if ((fault & VM_FAULT_RETRY) &&
> > > +           fault_should_check_signal(user_mode(regs)))
> > >                 return;
> > 
> > which isn't all that pretty.
> > 
> > Why isn't this just
> > 
> >   static bool fault_signal_pending(unsigned int fault_flags, struct
> > pt_regs *regs)
> >   {
> >         return (fault_flags & VM_FAULT_RETRY) &&
> >                 (fatal_signal_pending(current) ||
> >                  (user_mode(regs) && signal_pending(current)));
> >   }
> > 
> > and then most of the users would be something like
> > 
> >         if (fault_signal_pending(fault, regs))
> >                 return;
> > 
> > and the exceptions could do their own thing.
> > 
> > Now the code is prettier and more understandable, I feel.
> > 
> > And if something doesn't follow this pattern, maybe it either _should_
> > follow that pattern or it should just not use the helper but explain
> > why it has an unusual pattern.

> +++ b/arch/alpha/mm/fault.c
> @@ -150,7 +150,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
>  	   the fault.  */
>  	fault = handle_mm_fault(vma, address, flags);
>  
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +	if (fault_signal_pending(fault, regs))
>  		return;
>  
>  	if (unlikely(fault & VM_FAULT_ERROR)) {

> +++ b/arch/arm/mm/fault.c
> @@ -301,6 +301,11 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  		return 0;
>  	}
>  
> +	/* Fast path to handle user mode signals */
> +	if ((fault & VM_FAULT_RETRY) && user_mode(regs) &&
> +	    signal_pending(current))
> +		return 0;

But _why_ are they different?  This is a good opportunity to make more
code the same between architectures.

