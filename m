Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149E0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5B42070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HTRpjIuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfDJSon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:44:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56702 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfDJSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3cswxi7180CVcnt7y0isIqEI2gx7W4zTBRu3Fv89dt0=; b=HTRpjIuGVczWQQu5uEITtXb/f
        vPSLXELWBTbcRHa9UNhUUZN+xF+1Ck8IJQX1kt3qTY/ifq9v0R9wkn8lm0+wrYWennfAQQpsQ9e6s
        SqTG/IzXVQ2jXZjXKdIDae1AfT4UsunQEVYl1mS8NjoyBQ9uhhYWUpjH74jwX8DWy8BXdvHiVJrm9
        ih+ptVAkTREx2ZtekoXih0tXTbIDeYa3SvMTc/NKPBATD3o0fKN3KyZBxTNoKHCZoeD5y9t9+2bnz
        7RN5Zz84CTnYj5PqXu3IzRMKwCvfGD2GayU7EyINpWbpTIkvdX/t7xUl7vGtFHOCS1Co4NnelhW3x
        VktqpSKIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEID2-0002lj-F9; Wed, 10 Apr 2019 18:44:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28EB129AAAA98; Wed, 10 Apr 2019 20:44:29 +0200 (CEST)
Date:   Wed, 10 Apr 2019 20:44:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip v2 02/12] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190410184429.GX4038@hirez.programming.kicks-ass.net>
References: <20190405192115.17416-1-longman@redhat.com>
 <20190405192115.17416-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405192115.17416-3-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 03:21:05PM -0400, Waiman Long wrote:
> Because of writer lock stealing, it is possible that a constant
> stream of incoming writers will cause a waiting writer or reader to
> wait indefinitely leading to lock starvation.
> 
> The mutex code has a lock handoff mechanism to prevent lock starvation.
> This patch implements a similar lock handoff mechanism to disable
> lock stealing and force lock handoff to the first waiter in the queue
> after at least a 5ms waiting period. The waiting period is used to
> avoid discouraging lock stealing too much to affect performance.

I would say the handoff it not at all similar to the mutex code. It is
in fact radically different.

> @@ -131,6 +138,15 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>  		adjustment = RWSEM_READER_BIAS;
>  		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
>  		if (unlikely(oldcount & RWSEM_WRITER_MASK)) {
> +			/*
> +			 * Initiate handoff to reader, if applicable.
> +			 */
> +			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
> +			    time_after(jiffies, waiter->timeout)) {
> +				adjustment -= RWSEM_FLAG_HANDOFF;
> +				lockevent_inc(rwsem_rlock_handoff);
> +			}
> +
>  			atomic_long_sub(adjustment, &sem->count);
>  			return;
>  		}

That confuses the heck out of me...

The above seems to rely on __rwsem_mark_wake() to be fully serialized
(and it is, by ->wait_lock, but that isn't spelled out anywhere) such
that we don't get double increment of FLAG_HANDOFF.

So there is NO __rwsem_mark_wake() vs __wesem_mark_wake() race like:

  CPU0					CPU1

  oldcount = atomic_long_fetch_add(adjustment, &sem->count)

					oldcount = atomic_long_fetch_add(adjustment, &sem->count)

  if (!(oldcount & HANDOFF))
    adjustment -= HANDOFF;

					if (!(oldcount & HANDOFF))
					  adjustment -= HANDOFF;
  atomic_long_sub(adjustment)
					atomic_long_sub(adjustment)


*whoops* double negative decrement of HANDOFF (aka double increment).


However there is another site that fiddles with the HANDOFF bit, namely
__rwsem_down_write_failed_common(), and that does:

+                               atomic_long_or(RWSEM_FLAG_HANDOFF, &sem->count);

_OUTSIDE_ of ->wait_lock, which would yield:

  CPU0					CPU1

  oldcount = atomic_long_fetch_add(adjustment, &sem->count)

					atomic_long_or(HANDOFF)

  if (!(oldcount & HANDOFF))
    adjustment -= HANDOFF;

  atomic_long_sub(adjustment)

*whoops*, incremented HANDOFF on HANDOFF.


And there's not a comment in sight that would elucidate if this is
possible or not.


Also:

+                               atomic_long_or(RWSEM_FLAG_HANDOFF, &sem->count);
+                               first++;
+
+                               /*
+                                * Make sure the handoff bit is seen by
+                                * others before proceeding.
+                                */
+                               smp_mb__after_atomic();

That comment is utter nonsense. smp_mb() doesn't (and cannot) 'make
visible'. There needs to be order between two memops on both sides.

