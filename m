Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6973EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425E020869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbfDRUTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:19:31 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48976 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2388389AbfDRUTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:19:30 -0400
Received: (qmail 13948 invoked by uid 2102); 18 Apr 2019 16:19:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Apr 2019 16:19:29 -0400
Date:   Thu, 18 Apr 2019 16:19:29 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
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
In-Reply-To: <20190418183919.GO14111@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1904181608400.1303-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, Paul E. McKenney wrote:

> > Are you saying that on x86, atomic_inc() acts as a full memory barrier 
> > but not as a compiler barrier, and vice versa for 
> > smp_mb__after_atomic()?  Or that neither atomic_inc() nor 
> > smp_mb__after_atomic() implements a full memory barrier?
> > 
> > Either one seems like a very dangerous situation indeed.
> 
> If I am following the macro-name breadcrumb trails correctly, x86's
> atomic_inc() does have a compiler barrier.  But this is an accident
> of implementation -- from what I can see, it is not required to do so.
> 
> So smb_mb__after_atomic() is only guaranteed to order the atomic_inc()
> before B, not A.  To order A before B in the above example, an
> smp_mb__before_atomic() is also needed.

Are you certain?

> But now that I look, LKMM looks to be stating a stronger guarantee:
> 
> 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> 		fencerel(After-unlock-lock) ; [M])
> 
> Maybe something like this?
> 
> 	([M] ; fencerel(Before-atomic) ; [RMW] ; fencerel(After-atomic) ; [M]) |
> 	([M] ; fencerel(Before-atomic) ; [RMW] |
> 	( [RMW] ; fencerel(After-atomic) ; [M]) |
> 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
> 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
> 		fencerel(After-unlock-lock) ; [M])

The first line you wrote is redundant; it follows from the second and 
third lines.

Aside from that, while this proposal may be correct and may express
what smb_mb__{before|after}_atomic really are intended to do, it
contradicts Documentation/atomic_t.txt.  That file says:

	These barriers provide a full smp_mb().

And of course, a full smp_mb() would order everything before it against 
everything after it.  If we update the model then we should also update 
that file.

In addition, it's noteworthy that smp_mb__after_spinlock and 
smp_mb__after_unlock_lock do not behave in this way.

Alan

