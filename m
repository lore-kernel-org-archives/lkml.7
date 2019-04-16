Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6356BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32ACD20449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Shbst0wP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfDPScZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:32:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48976 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=206h0/9hPA4lvpNEgZ78QSxcM/D41aVlr4WnnQxt/0E=; b=Shbst0wP7VG8Lyk0C7d9p+SJY
        zTMZ3F+eAxj5Qk35dHvxXOD/i8JPpo2Y3+fv0ui+oJt5lvwCHIZSNyCSmWJb+LkmJr9WRDYRCz9vT
        8IxbzckqXtcwl1cNhMFlzpW62x5K279g5tuHAsjW9qR6o0De8vdLuvcnQqFy2hS/AstFBesKx1wTb
        Whs2RilIWKthfL7BcdHURjmuepTlGCE0Q8kw6YoWNYON8e2ZU4wzMtnnCmc1pmYv7KTrXbH1hf/dh
        54e1budAGM9RyygCm6+LVlV1g+AWwpbEtrVeMR4vE8/TB1NHMLz02QRSvN/cpFfdSZogSc8ZfT/Nm
        fZr36SHgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSsT-0005PZ-Ah; Tue, 16 Apr 2019 18:32:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D53A238A887D; Tue, 16 Apr 2019 20:32:16 +0200 (CEST)
Date:   Tue, 16 Apr 2019 20:32:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 07/16] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190416183216.GV4038@hirez.programming.kicks-ass.net>
References: <20190413172259.2740-1-longman@redhat.com>
 <20190413172259.2740-8-longman@redhat.com>
 <20190416154937.GL12232@hirez.programming.kicks-ass.net>
 <d10586ae-cd86-2992-766b-1ba4a4807b6a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d10586ae-cd86-2992-766b-1ba4a4807b6a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:16:11PM -0400, Waiman Long wrote:

> >> @@ -665,9 +751,34 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
> >>  			lockevent_inc(rwsem_sleep_writer);
> >>  			set_current_state(state);
> >>  			count = atomic_long_read(&sem->count);
> >> +
> >> +			if ((wstate == WRITER_NOT_FIRST) &&
> >> +			    rwsem_waiter_is_first(sem, &waiter))
> >> +				wstate = WRITER_FIRST;
> >> +
> >> +			if (!RWSEM_COUNT_LOCKED(count))
> >> +				break;
> >> +
> >> +			/*
> >> +			 * An RT task sets the HANDOFF bit immediately.
> >> +			 * Non-RT task will wait a while before doing so.
> > Again, this describes what we already read the code to do; but doesn't
> > add anything.
> 
> Will remove that.
> 
> >> +			 *
> >> +			 * The setting of the handoff bit is deferred
> >> +			 * until rwsem_try_write_lock() is called.
> >> +			 */
> >> +			if ((wstate == WRITER_FIRST) && (rt_task(current) ||
> >> +			    time_after(jiffies, waiter.timeout))) {
> >> +				wstate = WRITER_HANDOFF;
> >> +				lockevent_inc(rwsem_wlock_handoff);
> >> +				/*
> >> +				 * Break out to call rwsem_try_write_lock().
> >> +				 */
> > Another exceedingly useful comment.
> >
> >> +				break;
> >> +			}
> >> +		}
> >>  
> >>  		raw_spin_lock_irq(&sem->wait_lock);
> >> +		count = atomic_long_read(&sem->count);
> >>  	}
> >>  	__set_current_state(TASK_RUNNING);
> >>  	list_del(&waiter.list);
> >> @@ -680,6 +791,12 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
> >>  	__set_current_state(TASK_RUNNING);
> >>  	raw_spin_lock_irq(&sem->wait_lock);
> >>  	list_del(&waiter.list);
> >> +	/*
> >> +	 * If handoff bit has been set by this waiter, make sure that the
> >> +	 * clearing of it is seen by others before proceeding.
> >> +	 */
> >> +	if (unlikely(wstate == WRITER_HANDOFF))
> >> +		atomic_long_add_return(-RWSEM_FLAG_HANDOFF,  &sem->count);
> > _AGAIN_ no explanation what so ff'ing ever.
> >
> > And why add_return() if you ignore the return value.
> >
> 
> OK, will remove those.

I'm not saying to remove them, although for at least the break one that
is fine. But do try and write comments that _add_ something to the code,
explain _why_ instead of state what (which we can trivially see from the
code).

Locking code in general is tricky enough, and comments are good, and
more comments are more good, but only if they explain why.
