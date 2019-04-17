Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96052C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59908206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gai/umrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbfDQIGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:06:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDQIGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wSQxgLC5Hy48gnSZgUERxB5HKeEI4hy3A6LfcwqNs7Q=; b=Gai/umrGbb4i8h2P4E1YcNJgE
        sHB7ZjWHi/WyZqmecdm1+rnhdbpf8Qii3Lkh7FuFheSxRO6YPB6Yrrfjnk4ZHa96cZfBTIVjN7otE
        2xlRLzi0YMEb0InNgFqVJs7s+RAzv3YswWJLH66gtR3EutrLiDBr2FU1tWLS/MP9SgrA+5AbVNWtI
        IN7lXEKdDoSmwsLxpQY69fIWyyBOHAqahrhdQ+vdklWO5Xo4sXBCRw+kh5xRITOiQYHGGdYm6hUwj
        EeLITIrbsSgtOw0RtFGB2fxIpkeiwPgVi4xB0in6oDWrVBj/HlohghCpqv4nQS9/IcTCcbB6UerYJ
        ujO05Xarg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGfZo-0006KG-B1; Wed, 17 Apr 2019 08:05:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9D2829B52932; Wed, 17 Apr 2019 10:05:49 +0200 (CEST)
Date:   Wed, 17 Apr 2019 10:05:49 +0200
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
Message-ID: <20190417080549.GA4038@hirez.programming.kicks-ass.net>
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

> >> @@ -608,56 +687,63 @@ __rwsem_down_write_failed_common(struct rw_semaphore *sem, int state)
> >>  	 */
> >>  	waiter.task = current;
> >>  	waiter.type = RWSEM_WAITING_FOR_WRITE;
> >> +	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
> >>  
> >>  	raw_spin_lock_irq(&sem->wait_lock);
> >>  
> >>  	/* account for this before adding a new element to the list */
> >> +	wstate = list_empty(&sem->wait_list) ? WRITER_FIRST : WRITER_NOT_FIRST;
> >>  
> >>  	list_add_tail(&waiter.list, &sem->wait_list);
> >>  
> >>  	/* we're now waiting on the lock */
> >> +	if (wstate == WRITER_NOT_FIRST) {
> >>  		count = atomic_long_read(&sem->count);
> >>  
> >>  		/*
> >> +		 * If there were already threads queued before us and:
> >> +		 *  1) there are no no active locks, wake the front
> >> +		 *     queued process(es) as the handoff bit might be set.
> >> +		 *  2) there are no active writers and some readers, the lock
> >> +		 *     must be read owned; so we try to wake any read lock
> >> +		 *     waiters that were queued ahead of us.
> >>  		 */
> >> +		if (!RWSEM_COUNT_LOCKED(count))
> >> +			__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
> >> +		else if (!(count & RWSEM_WRITER_MASK) &&
> >> +			  (count & RWSEM_READER_MASK))
> >>  			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);

> > Does the above want to be something like:
> >
> > 		if (!(count & RWSEM_WRITER_LOCKED)) {
> > 			__rwsem_mark_wake(sem, (count & RWSEM_READER_MASK) ?
> > 					       RWSEM_WAKE_READERS :
> > 					       RWSEM_WAKE_ANY, &wake_q);
> > 		}
> 
> Yes.
> 
> >> +		else
> >> +			goto wait;
> >>  
> >> +		/*
> >> +		 * The wakeup is normally called _after_ the wait_lock
> >> +		 * is released, but given that we are proactively waking
> >> +		 * readers we can deal with the wake_q overhead as it is
> >> +		 * similar to releasing and taking the wait_lock again
> >> +		 * for attempting rwsem_try_write_lock().
> >> +		 */
> >> +		wake_up_q(&wake_q);
> > Hurmph.. the reason we do wake_up_q() outside of wait_lock is such that
> > those tasks don't bounce on wait_lock. Also, it removes a great deal of
> > hold-time from wait_lock.
> >
> > So I'm not sure I buy your argument here.
> >
> 
> Actually, we don't want to release the wait_lock, do wake_up_q() and
> acquire the wait_lock again as the state would have been changed. I
> didn't change the comment on this patch, but will reword it to discuss that.

I don't understand, we've queued ourselves, we're on the list, we're not
first. How would dropping the lock to try and kick waiters before us be
a problem?

Sure, once we re-acquire the lock we have to re-avaluate @wstate to see
if we're first now or not, but we need to do that anyway.

So what is wrong with the below?

--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -51,6 +51,11 @@ static inline void wake_q_init(struct wa
 	head->lastp = &head->first;
 }
 
+static inline bool wake_q_empty(struct wake_q_head *head)
+{
+	return head->first == WAKE_Q_TAIL;
+}
+
 extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
 extern void wake_up_q(struct wake_q_head *head);
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -700,25 +700,22 @@ __rwsem_down_write_failed_common(struct
 		 *     must be read owned; so we try to wake any read lock
 		 *     waiters that were queued ahead of us.
 		 */
-		if (!(count & RWSEM_LOCKED_MASK))
-			__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
-		else if (!(count & RWSEM_WRITER_MASK) &&
-				(count & RWSEM_READER_MASK))
-			__rwsem_mark_wake(sem, RWSEM_WAKE_READERS, &wake_q);
-		else
+		if (count & RWSEM_WRITER_LOCKED)
 			goto wait;
-		/*
-		 * The wakeup is normally called _after_ the wait_lock
-		 * is released, but given that we are proactively waking
-		 * readers we can deal with the wake_q overhead as it is
-		 * similar to releasing and taking the wait_lock again
-		 * for attempting rwsem_try_write_lock().
-		 */
-		wake_up_q(&wake_q);
-		/*
-		 * Reinitialize wake_q after use.
-		 */
-		wake_q_init(&wake_q);
+
+		__rwsem_mark_wake(sem, (count & RWSEM_READER_MASK) ?
+				RWSEM_WAKE_READERS :
+				RWSEM_WAKE_ANY, &wake_q);
+
+		if (!wake_q_empty(&wake_q)) {
+			raw_spin_unlock_irq(&sem->wait_lock);
+			wake_up_q(&wake_q);
+			/* used again, reinit */
+			wake_q_init(&wake_q);
+			raw_spin_lock_irq(&sem->wait_lock);
+			if (rwsem_waiter_is_first(sem, &waiter))
+				wstate = WRITER_FIRST;
+		}
 	} else {
 		count = atomic_long_add_return(RWSEM_FLAG_WAITERS, &sem->count);
 	}
