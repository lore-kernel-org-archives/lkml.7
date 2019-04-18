Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A24C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B0020656
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbfDRRoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:44:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48642 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1733067AbfDRRoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:44:37 -0400
Received: (qmail 2544 invoked by uid 2102); 18 Apr 2019 13:44:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2019 13:44:36 -0400
Date:   Thu, 18 Apr 2019 13:44:36 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Kroening <kroening@cs.ox.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Adding plain accesses and detecting data races in the LKMM
In-Reply-To: <20190418125412.GA10817@andrea>
Message-ID: <Pine.LNX.4.44L0.1904181324420.1303-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, Andrea Parri wrote:

> > Another question is "should the kernel permit smp_mb__{before,after}*()
> > anywhere other than immediately before or after the primitive being
> > strengthened?"
> 
> Mmh, I do think that keeping these barriers "immediately before or after
> the primitive being strengthened" is a good practice (readability, and
> all that), if this is what you're suggesting.
> 
> However, a first auditing of the callsites showed that this practice is
> in fact not always applied, notably... ;-)
> 
> 	kernel/rcu/tree_exp.h:sync_exp_work_done
> 	kernel/sched/cpupri.c:cpupri_set
> 
> So there appear, at least, to be some exceptions/reasons for not always
> following it?  Thoughts?
> 
> BTW, while auditing these callsites, I've stumbled across the following
> snippet (from kernel/futex.c):
> 
> 	*futex = newval;
> 	sys_futex(WAKE, futex);
>           futex_wake(futex);
>           smp_mb(); (B)
> 	  if (waiters)
> 	    ...
> 
> where B is actually (c.f., futex_get_mm()):
> 
> 	atomic_inc(...->mm_count);
> 	smp_mb__after_atomic();
> 
> It seems worth mentioning the fact that, AFAICT, this sequence does not
> necessarily provide ordering when plain accesses are involved: consider,
> e.g., the following variant of the snippet:
> 
> 	A:*x = 1;
> 	/*
> 	 * I've "ignored" the syscall, which should provide
> 	 * (at least) a compiler barrier...
> 	 */
> 	atomic_inc(u);
> 	smp_mb__after_atomic();
> 	B:r0 = *y;
> 
> On x86, AFAICT, the compiler can do this:
> 
> 	atomic_inc(u);
> 	A:*x = 1;
> 	smp_mb__after_atomic();
> 	B:r0 = *y;
> 
> (the implementation of atomic_inc() contains no compiler barrier), then
> the CPU can "reorder" A and B (smp_mb__after_atomic() being #defined to
> a compiler barrier).

Are you saying that on x86, atomic_inc() acts as a full memory barrier 
but not as a compiler barrier, and vice versa for 
smp_mb__after_atomic()?  Or that neither atomic_inc() nor 
smp_mb__after_atomic() implements a full memory barrier?

Either one seems like a very dangerous situation indeed.

Alan

> The mips implementation seems also affected by such "reorderings": I am
> not familiar with this implementation but, AFAICT, it does not enforce
> ordering from A to B in the following snippet:
> 
> 	A:*x = 1;
> 	atomic_inc(u);
> 	smp_mb__after_atomic();
> 	B:WRITE_ONCE(*y, 1);
> 
> when CONFIG_WEAK_ORDERING=y, CONFIG_WEAK_REORDERING_BEYOND_LLSC=n.
> 
> Do these observations make sense to you?  Thoughts?
> 
>   Andrea

