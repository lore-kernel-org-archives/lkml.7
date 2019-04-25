Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEA2C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DD420878
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H/uyS6d9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfDYJJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:09:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48610 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfDYJJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zHDL3XgeFP+UgvKNuurkNTqVQKRA8z02sR+WpE/7+yU=; b=H/uyS6d98uq3t6icRLEOzRWB5
        GhFJYVijA7q6VatoGLVnQK0O7dbzvfhJug0o37Ht3OwvZNLTDQHk7+sD9fsVnGAO2HWZSc+NkmUug
        El4W3QvaUMQJT9KivB5r5DHnh9Ke22X+CPcEuejOUKgKWn6YU2iKJWM1L/WTWJMMtJpYQAp16fkJL
        qF1pQKERcz+gT7Lnvy1KVr+DP8t1Kxs7dgEYs9DjC9MYq8wFNOoURQbMw8J4tKrJgJn16FASiXAu7
        LHrF0EKke2X87yfEfUzu3h686C4NNgfSejBfqkCospwphF1AdaAzeDVRzYCK0n7Nii+FkP/u5NOqx
        R3oEu+UeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJaNT-0001fo-D6; Thu, 25 Apr 2019 09:09:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6AE329BC31D8; Thu, 25 Apr 2019 11:09:07 +0200 (CEST)
Date:   Thu, 25 Apr 2019 11:09:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     huangpei@loongson.cn
Cc:     Paul Burton <paul.burton@mips.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
Message-ID: <20190425090907.GB14281@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
 <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
 <20190425073348.GV11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425073348.GV11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 09:33:48AM +0200, Peter Zijlstra wrote:

> > Let me explain the bug more specific:
> > 
> > the bug ONLY matters in following situation:
> > 
> > #. more than one cpu (assume cpu A and B) doing ll/sc on same shared
> > var V
> > 
> > #. speculative memory access from A cause A erroneously succeed sc
> > operation, since the erroneously successful sc operation violate the
> > coherence protocol. (here coherence protocol means the rules that CPU
> > follow to implement ll/sc right)
> > 
> > #. B succeed sc operation too, but this sc operation is right both
> > logically and follow the coherence protocol, and makes A's sc wrong
> > logically since only ONE sc operation can succeed.
> 
> (I know your coherence protocol is probably more complicated than MESI,
> but bear with me)
> 
> So A speculatively gets V's line in Exclusive mode, speculates the Lock
> flag is still there and completes the Store. This speculative store then
> leaks out and violates MESI because there _should_ only be one Exclusive
> owner of a line (B).
> 
> Something like that?

So B gets E (from LL), does I on A, then SC succeeds and get M.  A got
I, speculates E, speculates M and lets the M escape.

That gets us with 2 competing Ms (which is of course completely
insane), one wins one looses (at random I presume).

And this violates atomic guarantees because one operation got lost.

> > If it is not LL/SC but other memory access from B on V, A's ll/sc can
> > follow the atomic semantics even if A violate the coherence protocol
> > in the same situation.
> 
> *shudder*...
> 
>   C atomic-set
> 
>   {
> 	  atomic_set(v, 1);
>   }
> 
>   P1(atomic_t *v)
>   {
> 	  atomic_add_unless(v, 1, 0);
>   }
> 
>   P2(atomic_t *v)
>   {
> 	  atomic_set(v, 0);
>   }
> 
>   exists
>   (v=2)
> 
> So that one will still work? (that is, v=2 is forbidden)

But then in this case, P1 has E from LL, P2 does M from the STORE, which
should cause I on P1. P1 speculates E, speculates M and lets M escape.

We again have two competing Ms, one wins at random, and v==2 if P1
wins. This again violates the atomic guarantees and would invalidate
your claim of it only mattering for competing LL/SC.

Or am I missing something? (quite likely, I always get confused with
these things)
