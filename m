Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DCAC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F3F20645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sK80hHPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfFMSAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:00:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57098 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfFMSAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y2HBP4Suq4cb9acUey5TgY5ehjcUkDf2judRGou1cAw=; b=sK80hHPxTYIdRxZtA26Sm+wM6
        DPW6vJpYt7QVdrCYSs3qmMJz9tsGHzUkd4u8y5+qHNA7lpc5wcvhFYiAojZCtZxNT1UDzbnFiFKYg
        RND4ASdgud8UfdyIAGW4eNyXFCNjE9+PwIEElIrhw8bLJJFmmFsuYWQCYqKDGvg2AnjYfgkV9RaoW
        9xONLRy7uVoREwEFcOKhcVUwOvMOQDTgYRTt6N1unwvIrqWM5NN0XlXB3GkKvEmWtpI+Ikjac0mAL
        1WgdKIkUjkoIzf3YcW/av051DIoWiXZjvFBSL886OQ4q1tuF3I0osiw7xj32UOrXme8h60gaQAWS6
        NMhIZOHcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbU1X-0002TU-SW; Thu, 13 Jun 2019 18:00:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A81E7209CC9DD; Thu, 13 Jun 2019 20:00:29 +0200 (CEST)
Date:   Thu, 13 Jun 2019 20:00:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     David Howells <dhowells@redhat.com>, akiyks@gmail.com,
        andrea.parri@amarulasolutions.com, boqun.feng@gmail.com,
        dlustig@nvidia.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        npiggin@gmail.com, paulmck@linux.ibm.com, will.deacon@arm.com,
        paul.burton@mips.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v2 0/4] atomic: Fixes to smp_mb__{before,after}_atomic()
 and mips.
Message-ID: <20190613180029.GO3436@hirez.programming.kicks-ass.net>
References: <1674.1560435952@warthog.procyon.org.uk>
 <Pine.LNX.4.44L0.1906131253230.1307-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906131253230.1307-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:58:11PM -0400, Alan Stern wrote:
> On Thu, 13 Jun 2019, David Howells wrote:
> 
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Basically we fail for:
> > > 
> > > 	*x = 1;
> > > 	atomic_inc(u);
> > > 	smp_mb__after_atomic();
> > > 	r0 = *y;
> > > 
> > > Because, while the atomic_inc() implies memory order, it
> > > (surprisingly) does not provide a compiler barrier. This then allows
> > > the compiler to re-order like so:
> > 
> > To quote memory-barriers.txt:
> > 
> >  (*) smp_mb__before_atomic();
> >  (*) smp_mb__after_atomic();
> > 
> >      These are for use with atomic (such as add, subtract, increment and
> >      decrement) functions that don't return a value, especially when used for
> >      reference counting.  These functions do not imply memory barriers.
> > 
> > so it's entirely to be expected?
> 
> The text is perhaps ambiguous.  It means that the atomic functions
> which don't return values -- like atomic_inc() -- do not imply memory
> barriers.  It doesn't mean that smp_mb__before_atomic() and
> smp_mb__after_atomic() do not imply memory barriers.
> 
> The behavior Peter described is not to be expected.  The expectation is 
> that the smp_mb__after_atomic() in the example should force the "*x = 
> 1" store to execute before the "r0 = *y" load.  But on current x86 it 
> doesn't force this, for the reason explained in the description.

Indeed, thanks Alan.

The other other approach would be to upgrade smp_mb__{before,after}_mb()
to actual full memory barriers on x86, but that seems quite rediculous
since atomic_inc() already does all the expensive bits and is only
missing the compiler barrier.

That would result in code like:

	mov $1, x
	lock inc u
	lock addl $0, -4(%rsp) # aka smp_mb()
	mov y, %r

which is really quite silly.

And as noted in the Changelog, about half the non-value returning
atomics already implied the compiler barrier anyway.
