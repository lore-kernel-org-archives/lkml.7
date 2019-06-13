Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3620C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722E120665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393054AbfFMQ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:58:17 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60482 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2393126AbfFMQ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:58:12 -0400
Received: (qmail 4098 invoked by uid 2102); 13 Jun 2019 12:58:11 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Jun 2019 12:58:11 -0400
Date:   Thu, 13 Jun 2019 12:58:11 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     David Howells <dhowells@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>, <akiyks@gmail.com>,
        <andrea.parri@amarulasolutions.com>, <boqun.feng@gmail.com>,
        <dlustig@nvidia.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <npiggin@gmail.com>,
        <paulmck@linux.ibm.com>, <will.deacon@arm.com>,
        <paul.burton@mips.com>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/4] atomic: Fixes to smp_mb__{before,after}_atomic()
 and mips.
In-Reply-To: <1674.1560435952@warthog.procyon.org.uk>
Message-ID: <Pine.LNX.4.44L0.1906131253230.1307-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019, David Howells wrote:

> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Basically we fail for:
> > 
> > 	*x = 1;
> > 	atomic_inc(u);
> > 	smp_mb__after_atomic();
> > 	r0 = *y;
> > 
> > Because, while the atomic_inc() implies memory order, it
> > (surprisingly) does not provide a compiler barrier. This then allows
> > the compiler to re-order like so:
> 
> To quote memory-barriers.txt:
> 
>  (*) smp_mb__before_atomic();
>  (*) smp_mb__after_atomic();
> 
>      These are for use with atomic (such as add, subtract, increment and
>      decrement) functions that don't return a value, especially when used for
>      reference counting.  These functions do not imply memory barriers.
> 
> so it's entirely to be expected?

The text is perhaps ambiguous.  It means that the atomic functions
which don't return values -- like atomic_inc() -- do not imply memory
barriers.  It doesn't mean that smp_mb__before_atomic() and
smp_mb__after_atomic() do not imply memory barriers.

The behavior Peter described is not to be expected.  The expectation is 
that the smp_mb__after_atomic() in the example should force the "*x = 
1" store to execute before the "r0 = *y" load.  But on current x86 it 
doesn't force this, for the reason explained in the description.

Alan

