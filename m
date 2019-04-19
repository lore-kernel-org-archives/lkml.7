Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A8FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9436205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfDSSeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:34:13 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60896 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728315AbfDSSeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:34:07 -0400
Received: (qmail 2588 invoked by uid 2102); 19 Apr 2019 10:34:06 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Apr 2019 10:34:06 -0400
Date:   Fri, 19 Apr 2019 10:34:06 -0400 (EDT)
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
In-Reply-To: <20190419124720.GU14111@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1904191032280.1406-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019, Paul E. McKenney wrote:

> On Fri, Apr 19, 2019 at 02:53:02AM +0200, Andrea Parri wrote:
> > > Are you saying that on x86, atomic_inc() acts as a full memory barrier 
> > > but not as a compiler barrier, and vice versa for 
> > > smp_mb__after_atomic()?  Or that neither atomic_inc() nor 
> > > smp_mb__after_atomic() implements a full memory barrier?
> > 
> > I'd say the former; AFAICT, these boil down to:
> > 
> >   https://elixir.bootlin.com/linux/v5.1-rc5/source/arch/x86/include/asm/atomic.h#L95
> >   https://elixir.bootlin.com/linux/v5.1-rc5/source/arch/x86/include/asm/barrier.h#L84
> 
> OK, how about the following?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 19d166dadc4e1bba4b248fb46d32ca4f2d10896b
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Fri Apr 19 05:20:30 2019 -0700
> 
>     tools/memory-model: Make smp_mb__{before,after}_atomic() match x86
>     
>     Read-modify-write atomic operations that do not return values need not
>     provide any ordering guarantees, and this means that both the compiler
>     and the CPU are free to reorder accesses across things like atomic_inc()
>     and atomic_dec().  The stronger systems such as x86 allow the compiler
>     to do the reordering, but prevent the CPU from so doing, and these
>     systems implement smp_mb__{before,after}_atomic() as compiler barriers.
>     The weaker systems such as Power allow both the compiler and the CPU
>     to reorder accesses across things like atomic_inc() and atomic_dec(),
>     and implement smp_mb__{before,after}_atomic() as full memory barriers.
>     
>     This means that smp_mb__before_atomic() only orders the atomic operation
>     itself with accesses preceding the smp_mb__before_atomic(), and does
>     not necessarily provide any ordering whatsoever against accesses
>     folowing the atomic operation.  Similarly, smp_mb__after_atomic()
>     only orders the atomic operation itself with accesses following the
>     smp_mb__after_atomic(), and does not necessarily provide any ordering
>     whatsoever against accesses preceding the atomic operation.  Full ordering
>     therefore requires both an smp_mb__before_atomic() before the atomic
>     operation and an smp_mb__after_atomic() after the atomic operation.
>     
>     Therefore, linux-kernel.cat's current model of Before-atomic
>     and After-atomic is too strong, as it guarantees ordering of
>     accesses on the other side of the atomic operation from the
>     smp_mb__{before,after}_atomic().  This commit therefore weakens
>     the guarantee to match the semantics called out above.
>     
>     Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
>     Suggested-by: Alan Stern <stern@rowland.harvard.edu>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 169d938c0b53..e5b97c3e8e39 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1888,7 +1888,37 @@ There are some more advanced barrier functions:
>  	atomic_dec(&obj->ref_count);
>  
>       This makes sure that the death mark on the object is perceived to be set
> -     *before* the reference counter is decremented.
> +     *before* the reference counter is decremented.  However, please note
> +     that smp_mb__before_atomic()'s ordering guarantee does not necessarily
> +     extend beyond the atomic operation.  For example:
> +
> +	obj->dead = 1;
> +	smp_mb__before_atomic();
> +	atomic_dec(&obj->ref_count);
> +	r1 = a;
> +
> +     Here the store to obj->dead is not guaranteed to be ordered with
> +     with the load from a.  This reordering can happen on x86 as follows:
> +     (1) The compiler can reorder the load from a to precede the
> +     atomic_dec(), (2) Because x86 smp_mb__before_atomic() is only a
> +     compiler barrier, the CPU can reorder the preceding store to
> +     obj->dead with the later load from a.
> +
> +     This could be avoided by using READ_ONCE(), which would prevent the
> +     compiler from reordering due to both atomic_dec() and READ_ONCE()
> +     being volatile accesses, and is usually preferable for loads from
> +     shared variables.  However, weakly ordered CPUs would still be
> +     free to reorder the atomic_dec() with the load from a, so a more
> +     readable option is to also use smp_mb__after_atomic() as follows:
> +
> +	WRITE_ONCE(obj->dead, 1);
> +	smp_mb__before_atomic();
> +	atomic_dec(&obj->ref_count);
> +	smp_mb__after_atomic();
> +	r1 = READ_ONCE(a);
> +
> +     This orders all three accesses against each other, and also makes
> +     the intent quite clear.
>  
>       See Documentation/atomic_{t,bitops}.txt for more information.
>  
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 8dcb37835b61..b6866f93abb8 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -28,8 +28,8 @@ include "lock.cat"
>  let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
>  let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
> -	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> -	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
> +	([M] ; fencerel(Before-atomic) ; [RMW]) |
> +	([RMW] ; fencerel(After-atomic) ; [M]) |
>  	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
>  	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
>  		fencerel(After-unlock-lock) ; [M])

Something like the following should also be applied, either as part of 
the same patch or immediately after.

Alan


Index: usb-devel/Documentation/atomic_t.txt
===================================================================
--- usb-devel.orig/Documentation/atomic_t.txt
+++ usb-devel/Documentation/atomic_t.txt
@@ -171,7 +171,10 @@ The barriers:
   smp_mb__{before,after}_atomic()
 
 only apply to the RMW ops and can be used to augment/upgrade the ordering
-inherent to the used atomic op. These barriers provide a full smp_mb().
+inherent to the used atomic op. Unlike normal smp_mb() barriers, they order
+only the RMW op itself against the instructions preceding the
+smp_mb__before_atomic() or following the smp_mb__after_atomic(); they do
+not order instructions on the other side of the RMW op at all.
 
 These helper barriers exist because architectures have varying implicit
 ordering on their SMP atomic primitives. For example our TSO architectures
@@ -195,7 +198,8 @@ Further, while something like:
   atomic_dec(&X);
 
 is a 'typical' RELEASE pattern, the barrier is strictly stronger than
-a RELEASE. Similarly for something like:
+a RELEASE because it orders preceding instructions against both the read
+and write parts of the atomic_dec(). Similarly, something like:
 
   atomic_inc(&X);
   smp_mb__after_atomic();
@@ -227,7 +231,8 @@ strictly stronger than ACQUIRE. As illus
 
 This should not happen; but a hypothetical atomic_inc_acquire() --
 (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
-since then:
+because it would not order the W part of the RMW against the following
+WRITE_ONCE.  Thus:
 
   P1			P2
 

