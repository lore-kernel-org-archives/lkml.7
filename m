Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42790C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4B12064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 03:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394781AbfIXDTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 23:19:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389152AbfIXDTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 23:19:22 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DABA2A09D8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 03:19:22 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id i187so492913pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 20:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uePRz+zBUInRiBudQ8Q8EZdu0505xUFOoco9XYwCcgc=;
        b=appDA7N/9lDYgJRNYLvjnUcraDMkTZw8KS+LH+9N9QSDStMe4WJMYQm+Bx9CPx6asm
         o6+LLO4mWp2UBY8hSQyY40GisGtgqJSd5Sd62UFypN3HgyhNMdL7SB2LOwRWsj9uDRhC
         iH7JwL6+yVc7K0J5GfDVkQ/UXevde2qbOVojnKFO7cP8BiKYJKcAZnXMIVYvqJwtDTBh
         GGQSpxRrF4Qu/ttAKhuOKgQGjjkqtprBX8D3PVrhpO/WI474ywfSWB4DDhtgnj0Rex4X
         LXYKRQCG5gy3wldct3KrLzetxVf8YmOiIzDoAbQ+R+ZmLMUgB/yc8Hn4z3U5BRSpvjW3
         DbRA==
X-Gm-Message-State: APjAAAWrhaVKt/gURjhPDUcE0wzMT0FzEgWMpw9U5bW2AKDE29R4MCki
        nj8b/ghMVGH8nw/OzQUCKkI57fc6kq/IJZMsbrJdnohbGWhevDiVTRMKxDhp0pzADc8yJHHevlX
        JTsCbjvJVOdk7xy9RN34TfqLQ
X-Received: by 2002:a62:1516:: with SMTP id 22mr810669pfv.87.1569295162073;
        Mon, 23 Sep 2019 20:19:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzvvwc9qmVDzQ+3G7Oq/DsoKfd5QfwPt3k9ug8jmIgqi79JZwmDUqYomKmQbUA8CTqPKchZvw==
X-Received: by 2002:a62:1516:: with SMTP id 22mr810652pfv.87.1569295161835;
        Mon, 23 Sep 2019 20:19:21 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b20sm243572pff.158.2019.09.23.20.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 20:19:21 -0700 (PDT)
Date:   Tue, 24 Sep 2019 11:19:08 +0800
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
Message-ID: <20190924031908.GF28074@xz-x1>
References: <20190923042523.10027-1-peterx@redhat.com>
 <20190923042523.10027-6-peterx@redhat.com>
 <CAHk-=wiNGtUaXtRv1wniw3hfxFnU7SO7ZuisFSVg0btvROcW6w@mail.gmail.com>
 <20190924024721.GD28074@xz-x1>
 <20190924025447.GE1855@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924025447.GE1855@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 07:54:47PM -0700, Matthew Wilcox wrote:
> On Tue, Sep 24, 2019 at 10:47:21AM +0800, Peter Xu wrote:
> > On Mon, Sep 23, 2019 at 11:03:49AM -0700, Linus Torvalds wrote:
> > > On Sun, Sep 22, 2019 at 9:26 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > This patch is a preparation of removing that special path by allowing
> > > > the page fault to return even faster if we were interrupted by a
> > > > non-fatal signal during a user-mode page fault handling routine.
> > > 
> > > So I really wish saome other vm person would also review these things,
> > > but looking over this series once more, this is the patch I probably
> > > like the least.
> > > 
> > > And the reason I like it the least is that I have a hard time
> > > explaining to myself what the code does and why, and why it's so full
> > > of this pattern:
> > > 
> > > > -       if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> > > > +       if ((fault & VM_FAULT_RETRY) &&
> > > > +           fault_should_check_signal(user_mode(regs)))
> > > >                 return;
> > > 
> > > which isn't all that pretty.
> > > 
> > > Why isn't this just
> > > 
> > >   static bool fault_signal_pending(unsigned int fault_flags, struct
> > > pt_regs *regs)
> > >   {
> > >         return (fault_flags & VM_FAULT_RETRY) &&
> > >                 (fatal_signal_pending(current) ||
> > >                  (user_mode(regs) && signal_pending(current)));
> > >   }
> > > 
> > > and then most of the users would be something like
> > > 
> > >         if (fault_signal_pending(fault, regs))
> > >                 return;
> > > 
> > > and the exceptions could do their own thing.
> > > 
> > > Now the code is prettier and more understandable, I feel.
> > > 
> > > And if something doesn't follow this pattern, maybe it either _should_
> > > follow that pattern or it should just not use the helper but explain
> > > why it has an unusual pattern.
> 
> > +++ b/arch/alpha/mm/fault.c
> > @@ -150,7 +150,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
> >  	   the fault.  */
> >  	fault = handle_mm_fault(vma, address, flags);
> >  
> > -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> > +	if (fault_signal_pending(fault, regs))
> >  		return;
> >  
> >  	if (unlikely(fault & VM_FAULT_ERROR)) {
> 
> > +++ b/arch/arm/mm/fault.c
> > @@ -301,6 +301,11 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> >  		return 0;
> >  	}
> >  
> > +	/* Fast path to handle user mode signals */
> > +	if ((fault & VM_FAULT_RETRY) && user_mode(regs) &&
> > +	    signal_pending(current))
> > +		return 0;
> 
> But _why_ are they different?  This is a good opportunity to make more
> code the same between architectures.

(Thanks for joining the discussion)

I'd like to do these - my only worry is that I can't really test them
well simply because I don't have all the hardwares.  For now the
changes are mostly straightforward so I'm relatively confident (not to
mention the code needs proper reviews too, and of course I would
appreciate much if anyone wants to smoke test it).  If I change it in
a drastic way, I won't be that confident without some tests at least
on multiple archs (not to mention that even smoke testing across major
archs will be a huge amount of work...).  So IMHO those might be more
suitable as follow-up for per-arch developers if we can at least reach
a consensus on the whole idea of this patchset.

Thanks,

-- 
Peter Xu
