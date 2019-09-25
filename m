Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55108C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B545217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 03:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411610AbfIYDqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 23:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405131AbfIYDqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 23:46:44 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 894D786662
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 03:46:43 +0000 (UTC)
Received: by mail-pg1-f198.google.com with SMTP id 6so2710579pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 20:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MVVdJVVftHCK7lBNfTgeBJYp8/OUkMMp5X/iUBYMtxE=;
        b=AYyu1zsd+7VBgYbVTOCcMpr7bU38GTGo7ks/QDRQUEp7KSereg9uFJMLiTko9Ovida
         dcuDlTMTBYlq9hsC9wgLhcpLa1h80e+NtSo3bTVcykBIWitlWzIU1cs+AjiApT4XdJCl
         N7+QjkdHNE7Ugu2jQV9DfJRw1Rzw8KfarVHVKW9Ww4SFRfLkuy3U1OtO7MjDrq5I4K0A
         CAJ9DT2E8Md6bDtIquBaXKEnHRItbFaEhidiBxsvgV8tL4DFszn8ySRjXhyoHYVNlWXk
         3ctS/1FccsivuKMSWM1VZqnBhX4bEBRqgy7EzP/tu5fJM2OKgqoH4u1lExoozrYZhpx2
         RKLQ==
X-Gm-Message-State: APjAAAXgSaHz3B+S2xWWSX1jkcuwcnkzShmYoZiRvyQmE70hG+3fDeqT
        OQcL0s6uxlwdO0hwyaf6z/nshmCKMr0zjmChd22yGTpQUdMU/H5CYB0+nfOuHTpmGpKXxGkTgRM
        KqLExL5qCes5DP0FR96mrx/j4
X-Received: by 2002:a63:2744:: with SMTP id n65mr6586799pgn.277.1569383202805;
        Tue, 24 Sep 2019 20:46:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIAoer1/fF643SnCVRXDSCcwTnNAOlUkBOXqYTaOmYVTNLsYcP2U8hVB/xV0Vz8t9hxSFGbA==
X-Received: by 2002:a63:2744:: with SMTP id n65mr6586777pgn.277.1569383202521;
        Tue, 24 Sep 2019 20:46:42 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g5sm7399135pgd.82.2019.09.24.20.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 20:46:41 -0700 (PDT)
Date:   Wed, 25 Sep 2019 11:46:27 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20190925034627.GJ28074@xz-x1>
References: <20190923042523.10027-1-peterx@redhat.com>
 <20190923042523.10027-6-peterx@redhat.com>
 <CAHk-=wiNGtUaXtRv1wniw3hfxFnU7SO7ZuisFSVg0btvROcW6w@mail.gmail.com>
 <20190924024721.GD28074@xz-x1>
 <20190924025447.GE1855@bombadil.infradead.org>
 <20190924031908.GF28074@xz-x1>
 <20190924154518.GG1855@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924154518.GG1855@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 08:45:18AM -0700, Matthew Wilcox wrote:
> On Tue, Sep 24, 2019 at 11:19:08AM +0800, Peter Xu wrote:
> > On Mon, Sep 23, 2019 at 07:54:47PM -0700, Matthew Wilcox wrote:
> > > On Tue, Sep 24, 2019 at 10:47:21AM +0800, Peter Xu wrote:
> > > > On Mon, Sep 23, 2019 at 11:03:49AM -0700, Linus Torvalds wrote:
> > > > > On Sun, Sep 22, 2019 at 9:26 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > This patch is a preparation of removing that special path by allowing
> > > > > > the page fault to return even faster if we were interrupted by a
> > > > > > non-fatal signal during a user-mode page fault handling routine.
> > > > > 
> > > > > So I really wish saome other vm person would also review these things,
> > > > > but looking over this series once more, this is the patch I probably
> > > > > like the least.
> > > > > 
> > > > > And the reason I like it the least is that I have a hard time
> > > > > explaining to myself what the code does and why, and why it's so full
> > > > > of this pattern:
> > > > > 
> > > > > > -       if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> > > > > > +       if ((fault & VM_FAULT_RETRY) &&
> > > > > > +           fault_should_check_signal(user_mode(regs)))
> > > > > >                 return;
> > > > > 
> > > > > which isn't all that pretty.
> > > > > 
> > > > > Why isn't this just
> > > > > 
> > > > >   static bool fault_signal_pending(unsigned int fault_flags, struct
> > > > > pt_regs *regs)
> > > > >   {
> > > > >         return (fault_flags & VM_FAULT_RETRY) &&
> > > > >                 (fatal_signal_pending(current) ||
> > > > >                  (user_mode(regs) && signal_pending(current)));
> > > > >   }
> > > > > 
> > > > > and then most of the users would be something like
> > > > > 
> > > > >         if (fault_signal_pending(fault, regs))
> > > > >                 return;
> > > > > 
> > > > > and the exceptions could do their own thing.
> > > > > 
> > > > > Now the code is prettier and more understandable, I feel.
> > > > > 
> > > > > And if something doesn't follow this pattern, maybe it either _should_
> > > > > follow that pattern or it should just not use the helper but explain
> > > > > why it has an unusual pattern.
> > > 
> > > > +++ b/arch/alpha/mm/fault.c
> > > > @@ -150,7 +150,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
> > > >  	   the fault.  */
> > > >  	fault = handle_mm_fault(vma, address, flags);
> > > >  
> > > > -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> > > > +	if (fault_signal_pending(fault, regs))
> > > >  		return;
> > > >  
> > > >  	if (unlikely(fault & VM_FAULT_ERROR)) {
> > > 
> > > > +++ b/arch/arm/mm/fault.c
> > > > @@ -301,6 +301,11 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> > > >  		return 0;
> > > >  	}
> > > >  
> > > > +	/* Fast path to handle user mode signals */
> > > > +	if ((fault & VM_FAULT_RETRY) && user_mode(regs) &&
> > > > +	    signal_pending(current))
> > > > +		return 0;
> > > 
> > > But _why_ are they different?  This is a good opportunity to make more
> > > code the same between architectures.
> > 
> > (Thanks for joining the discussion)
> > 
> > I'd like to do these - my only worry is that I can't really test them
> > well simply because I don't have all the hardwares.  For now the
> > changes are mostly straightforward so I'm relatively confident (not to
> > mention the code needs proper reviews too, and of course I would
> > appreciate much if anyone wants to smoke test it).  If I change it in
> > a drastic way, I won't be that confident without some tests at least
> > on multiple archs (not to mention that even smoke testing across major
> > archs will be a huge amount of work...).  So IMHO those might be more
> > suitable as follow-up for per-arch developers if we can at least reach
> > a consensus on the whole idea of this patchset.
> 
> I think the way to do this is to introduce fault_signal_pending(),
> converting the architectures to it that match that pattern.  Then one
> patch per architecture to convert the ones which use a different pattern
> to the same pattern.

Fair enough.  I can start with a fault_signal_pending() only keeps the
sigkill handling just like before, then convert all the archs, with
the last patch to only touch fault_signal_pending() for non-fatal
signals.

> 
> Oh, and while you're looking at the callers of handle_mm_fault(), a
> lot of them don't check conditions in the right order.  x86, at least,
> handles FAULT_RETRY before handling FAULT_ERROR, which is clearly wrong.
> 
> Kirill and I recently discussed it here:
> https://lore.kernel.org/linux-mm/20190911152338.gqqgxrmqycodfocb@box/T/

Hmm sure.  These sound very reasonable.

I must admit that I am not brave enough to continue grow my patchset
on my own.  The condition I'm facing right now is that I can't really
find enough reviewers for this series (Linus helped me quite a lot, I
really, really, appreciated that), while it's still growing.  I hope
the started discussion means that you'll be at least another potential
reviewer (oh, should I count Kirill in as well? :) at least to the
coming patches for the things mentioned above.

Thanks,

-- 
Peter Xu
