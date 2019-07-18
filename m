Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB18FC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7702173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0PoI4l+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfGRK60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:58:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43134 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfGRK60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DUOq/3SMkHRFH7pCDz16pVDKxVcqlqA7oOtqGf98JfU=; b=0PoI4l+KKzgwe++GkxpbrtSal
        9G0ypdABB5g7Sy2yAY832aIOTh+LcpbWKbKOhIVJbUuDmYeVq7Rj6fP5QwUQtHT20bcxEBXB4sRED
        AZ5AnpKFO8BuVK87KgQD+Wdy0MYHti35ssxeye9KlChX8DlNiEm1GCoc2T5QdiAx8aTEOA5hJqGVs
        g7EzRRaVX0gNJ3qM4lfQLb/FM2OmJu2M5fzRw9TxsTwffRcAS3iD/Ltxo3/kFLwhIq40rcixn517U
        +iUMKlv2ci/ZKdrRRvGDOfHknffGxgMQZwQA7oRXhB0Yw+I/KiMBz3igdrb4QYuLQpNnztW/ylUk5
        67LBapWGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ho475-00031O-BY; Thu, 18 Jul 2019 10:58:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4F29203EA584; Thu, 18 Jul 2019 12:58:12 +0200 (CEST)
Date:   Thu, 18 Jul 2019 12:58:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Jan Stancek <jstancek@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        dbueso@suse.de, mingo@redhat.com, jade.alglave@arm.com,
        paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v2] locking/rwsem: add acquire barrier to read_slowpath
 exit when queue is empty
Message-ID: <20190718105812.GB3419@hirez.programming.kicks-ass.net>
References: <20190716185807.GJ3402@hirez.programming.kicks-ass.net>
 <a524cf95ab0dbdd1eb65e9decb9283e73d416b1d.1563352912.git.jstancek@redhat.com>
 <20190717131335.b2ry43t2ov7ba4t4@willie-the-truck>
 <21ff5905-198b-6ea5-6c2a-9fb10cb48ea7@redhat.com>
 <20190717192200.GA17687@dustball.usersys.redhat.com>
 <20190718092640.52oliw3sid7gxyh6@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718092640.52oliw3sid7gxyh6@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 10:26:41AM +0100, Will Deacon wrote:

> /*
>  * We need to ensure ACQUIRE semantics when reading sem->count so that
>  * we pair with the RELEASE store performed by an unlocking/downgrading
>  * writer.
>  *
>  * P0 (writer)			P1 (reader)
>  *
>  * down_write(sem);
>  * <write shared data>
>  * downgrade_write(sem);
>  * -> fetch_add_release(&sem->count)
>  *
>  *				down_read_slowpath(sem);
>  *				-> atomic_read(&sem->count)
>  *				   <ctrl dep>
>  *				   smp_acquire__after_ctrl_dep()
>  *				<read shared data>
>  */

So I'm thinking all this is excessive; the simple rule is: lock acquire
should imply ACQUIRE, we all know why.

> In writing this, I also noticed that we don't have any explicit ordering
> at the end of the reader slowpath when we wait on the queue but get woken
> immediately:
> 
> 	if (!waiter.task)
> 		break;
> 
> Am I missing something?

Ha!, I ran into the very same one. I keep confusing myself, but I think
you're right and that needs to be smp_load_acquire() to match the
smp_store_release() in rwsem_mark_wake().

(the actual race there is _tiny_ due to the smp_mb() right before it,
but I cannot convince myself that is indeed sufficient)

The signal_pending_state() case is also fun, but I think wait_lock there
is sufficient (even under RCpc).

I've ended up with this..

---
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 37524a47f002..9eb630904a17 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1000,6 +1000,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
 	adjustment = 0;
 	if (rwsem_optimistic_spin(sem, false)) {
+		/* rwsem_optimistic_spin() implies ACQUIRE through rwsem_*trylock() */
 		/*
 		 * Wake up other readers in the wait list if the front
 		 * waiter is a reader.
@@ -1014,6 +1015,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 		}
 		return sem;
 	} else if (rwsem_reader_phase_trylock(sem, waiter.last_rowner)) {
+		/* rwsem_reader_phase_trylock() implies ACQUIRE */
 		return sem;
 	}
 
@@ -1032,6 +1034,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 		 */
 		if (adjustment && !(atomic_long_read(&sem->count) &
 		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
+			/* Provide lock ACQUIRE */
+			smp_acquire__after_ctrl_dep();
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
 			lockevent_inc(rwsem_rlock_fast);
@@ -1065,15 +1069,25 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	wake_up_q(&wake_q);
 
 	/* wait to be given the lock */
-	while (true) {
+	for (;;) {
 		set_current_state(state);
-		if (!waiter.task)
+		if (!smp_load_acquire(&waiter.task)) {
+			/*
+			 * Matches rwsem_mark_wake()'s smp_store_release() and ensures
+			 * we're ordered against its sem->count operations.
+			 */
 			break;
+		}
 		if (signal_pending_state(state, current)) {
 			raw_spin_lock_irq(&sem->wait_lock);
 			if (waiter.task)
 				goto out_nolock;
 			raw_spin_unlock_irq(&sem->wait_lock);
+			/*
+			 * Ordered by sem->wait_lock against rwsem_mark_wake(), if we
+			 * see its waiter.task store, we must also see its sem->count
+			 * changes.
+			 */
 			break;
 		}
 		schedule();
@@ -1083,6 +1097,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock);
 	return sem;
+
 out_nolock:
 	list_del(&waiter.list);
 	if (list_empty(&sem->wait_list)) {

