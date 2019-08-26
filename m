Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B1CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9602053B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wK6kuh/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbfHZOOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:14:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54942 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfHZOOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KrZHA7DgzQxsl8BC7v6q355hjL5O6G66lfaie1YYwug=; b=wK6kuh/mhTFINiSaxSnskiXz9
        R0lxBB60xtaJl8wl1egiJLDZga2cdDBmweRAoI6HwhVjFd62hKRJ3a9Qba4FUukJQfU6J0FdudmOx
        Y+UbCnWZzP84JGHVUSN3wXC2hXntHVxMutDKb8ooyZghSj4VuLQSw/tJIzLN3v6FguOrmLKzi0HNN
        0OiV+4+qSKwzx9gr2X/kGMtwFH4ZbSnutY+zSsI2YzQqAnGOsawWX/cjiXcEkJyQSFGrPalbiBQ8n
        ahQ4zr59HM3q0TwmwPjc51zNElNeDaArcB678mbgSzPH9j8xJfDsvvcAzQjtP8dY8GVb7dxGJB9qi
        KIZw6yQNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2FlW-0000Nx-U2; Mon, 26 Aug 2019 14:14:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9894301FF9;
        Mon, 26 Aug 2019 16:14:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C2142059DEAE; Mon, 26 Aug 2019 16:14:36 +0200 (CEST)
Date:   Mon, 26 Aug 2019 16:14:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Satendra Singh Thakur <sst2005@gmail.com>
Cc:     satendrasingh.thakur@hcl.com, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] [semaphore] Removed redundant code from semaphore's
 down family of function
Message-ID: <20190826141436.GE2332@hirez.programming.kicks-ass.net>
References: <20190822155112.GU2369@hirez.programming.kicks-ass.net>
 <20190824035100.7969-1-sst2005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824035100.7969-1-sst2005@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 09:20:59AM +0530, Satendra Singh Thakur wrote:
> On Thu, 22 Aug 2019 17:51:12 +0200, Peter Zijlstra wrote:
> > On Mon, Aug 12, 2019 at 07:18:59PM +0530, Satendra Singh Thakur wrote:
> > > -The semaphore code has four funcs
> > > down,
> > > down_interruptible,
> > > down_killable,
> > > down_timeout
> > > -These four funcs have almost similar code except that
> > > they all call lower level function __down_xyz.
> > > -This lower level func in-turn call inline func
> > > __down_common with appropriate arguments.
> > > -This patch creates a common macro for above family of funcs
> > > so that duplicate code is eliminated.
> > > -Also, __down_common has been made noinline so that code is
> > > functionally similar to previous one
> > > -For example, earlier down_killable would call __down_killable
> > > , which in-turn would call inline func __down_common
> > > Now, down_killable calls noinline __down_common directly
> > > through a macro
> > > -The funcs __down_interruptible, __down_killable etc have been
> > > removed as they were just wrapper to __down_common
> >
> > The above is unreadable and seems to lack a reason for this change.
> Hi Mr Peter,
> Thanks for the comments.
> I will try to explain it further:
> 
> The semaphore has four functions named down*.
> The call flow of the functions is
> 
> down* ----> __down* ----> inline __down_common
> 
> The code of down* and __down* is redundant/duplicate except that
> the __down_common is called with different arguments from __down*
> functions.
> 
> This patch defines a macro down_common which contain this common
> code of all down* functions.
> 
> new call flow is
> 
> down* ----> noinline __down_common (through a macro down_common).
> 
> > AFAICT from the actual patch, you're destroying the explicit
> > instantiation of the __down*() functions
> > through constant propagation into __down_common().
> Intead of instantiation of __down* functions, we are instaintiating
> __down_common, is it a problem ?

Then you loose the constant propagation into __down_common and you'll
not DCE the signal and/or timeout code. The function even has a comment
on explaining that. That said; the timeout DCE seems suboptimal.

Also; I'm thinking you can do it without that ugly CPP.

---
Subject: locking/semaphore: Simplify code flow

Ever since we got rid of the per arch assembly the structure of the
semaphore code is more complicated than it needs to be.

Specifically, the slow path calling convention is no more. With that,
Satendara noted that all functions calling __down_common() (aka the slow
path) were basically the same.

Fold the lot.

(XXX, we should probably move the schedule_timeout() thing into its own
patch)

Suggested-by: Satendra Singh Thakur <sst2005@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h      |  13 +++++-
 kernel/locking/semaphore.c | 105 +++++++++++++--------------------------------
 kernel/time/timer.c        |  44 +++++++------------
 3 files changed, 58 insertions(+), 104 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f0edee94834a..8f09e8cebe5a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -214,7 +214,18 @@ extern void scheduler_tick(void);
 
 #define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
 
-extern long schedule_timeout(long timeout);
+extern long __schedule_timeout(long timeout);
+
+static inline long schedule_timeout(long timeout)
+{
+	if (timeout == MAX_SCHEDULE_TIMEOUT) {
+		schedule();
+		return timeout;
+	}
+
+	return __schedule_timeout(timeout);
+}
+
 extern long schedule_timeout_interruptible(long timeout);
 extern long schedule_timeout_killable(long timeout);
 extern long schedule_timeout_uninterruptible(long timeout);
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index d9dd94defc0a..4585fa3a0984 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -33,11 +33,24 @@
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
 
-static noinline void __down(struct semaphore *sem);
-static noinline int __down_interruptible(struct semaphore *sem);
-static noinline int __down_killable(struct semaphore *sem);
-static noinline int __down_timeout(struct semaphore *sem, long timeout);
-static noinline void __up(struct semaphore *sem);
+static inline int
+__sched __down_slow(struct semaphore *sem, long state, long timeout);
+static void __up(struct semaphore *sem);
+
+static inline int __down(struct semaphore *sem, long state, long timeout)
+{
+	unsigned long flags;
+	int result = 0;
+
+	raw_spin_lock_irqsave(&sem->lock, flags);
+	if (likely(sem->count > 0))
+		sem->count--;
+	else
+		result = __down_slow(sem, state, timeout);
+	raw_spin_unlock_irqrestore(&sem->lock, flags);
+
+	return result;
+}
 
 /**
  * down - acquire the semaphore
@@ -52,14 +65,7 @@ static noinline void __up(struct semaphore *sem);
  */
 void down(struct semaphore *sem)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&sem->lock, flags);
-	if (likely(sem->count > 0))
-		sem->count--;
-	else
-		__down(sem);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	__down(sem, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(down);
 
@@ -74,17 +80,7 @@ EXPORT_SYMBOL(down);
  */
 int down_interruptible(struct semaphore *sem)
 {
-	unsigned long flags;
-	int result = 0;
-
-	raw_spin_lock_irqsave(&sem->lock, flags);
-	if (likely(sem->count > 0))
-		sem->count--;
-	else
-		result = __down_interruptible(sem);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
-
-	return result;
+	return __down(sem, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(down_interruptible);
 
@@ -100,17 +96,7 @@ EXPORT_SYMBOL(down_interruptible);
  */
 int down_killable(struct semaphore *sem)
 {
-	unsigned long flags;
-	int result = 0;
-
-	raw_spin_lock_irqsave(&sem->lock, flags);
-	if (likely(sem->count > 0))
-		sem->count--;
-	else
-		result = __down_killable(sem);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
-
-	return result;
+	return __down(sem, TASK_KILLABLE, MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(down_killable);
 
@@ -154,17 +140,7 @@ EXPORT_SYMBOL(down_trylock);
  */
 int down_timeout(struct semaphore *sem, long timeout)
 {
-	unsigned long flags;
-	int result = 0;
-
-	raw_spin_lock_irqsave(&sem->lock, flags);
-	if (likely(sem->count > 0))
-		sem->count--;
-	else
-		result = __down_timeout(sem, timeout);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
-
-	return result;
+	return __down(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
 EXPORT_SYMBOL(down_timeout);
 
@@ -201,14 +177,15 @@ struct semaphore_waiter {
  * constant, and thus optimised away by the compiler.  Likewise the
  * 'timeout' parameter for the cases without timeouts.
  */
-static inline int __sched __down_common(struct semaphore *sem, long state,
-								long timeout)
+static inline int 
+__sched __down_slow(struct semaphore *sem, long state, long timeout)
 {
-	struct semaphore_waiter waiter;
+	struct semaphore_waiter waiter = {
+		.task = current,
+		.up = false,
+	};
 
 	list_add_tail(&waiter.list, &sem->wait_list);
-	waiter.task = current;
-	waiter.up = false;
 
 	for (;;) {
 		if (signal_pending_state(state, current))
@@ -223,36 +200,16 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 			return 0;
 	}
 
- timed_out:
+timed_out:
 	list_del(&waiter.list);
 	return -ETIME;
 
- interrupted:
+interrupted:
 	list_del(&waiter.list);
 	return -EINTR;
 }
 
-static noinline void __sched __down(struct semaphore *sem)
-{
-	__down_common(sem, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
-}
-
-static noinline int __sched __down_interruptible(struct semaphore *sem)
-{
-	return __down_common(sem, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
-}
-
-static noinline int __sched __down_killable(struct semaphore *sem)
-{
-	return __down_common(sem, TASK_KILLABLE, MAX_SCHEDULE_TIMEOUT);
-}
-
-static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
-{
-	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
-}
-
-static noinline void __sched __up(struct semaphore *sem)
+static void __up(struct semaphore *sem)
 {
 	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
 						struct semaphore_waiter, list);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0e315a2e77ae..13240dcea3e9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1851,38 +1851,24 @@ static void process_timeout(struct timer_list *t)
  * jiffies will be returned.  In all cases the return value is guaranteed
  * to be non-negative.
  */
-signed long __sched schedule_timeout(signed long timeout)
+signed long __sched __schedule_timeout(signed long timeout)
 {
 	struct process_timer timer;
 	unsigned long expire;
 
-	switch (timeout)
-	{
-	case MAX_SCHEDULE_TIMEOUT:
-		/*
-		 * These two special cases are useful to be comfortable
-		 * in the caller. Nothing more. We could take
-		 * MAX_SCHEDULE_TIMEOUT from one of the negative value
-		 * but I' d like to return a valid offset (>=0) to allow
-		 * the caller to do everything it want with the retval.
-		 */
-		schedule();
-		goto out;
-	default:
-		/*
-		 * Another bit of PARANOID. Note that the retval will be
-		 * 0 since no piece of kernel is supposed to do a check
-		 * for a negative retval of schedule_timeout() (since it
-		 * should never happens anyway). You just have the printk()
-		 * that will tell you if something is gone wrong and where.
-		 */
-		if (timeout < 0) {
-			printk(KERN_ERR "schedule_timeout: wrong timeout "
+	/*
+	 * Another bit of PARANOID. Note that the retval will be
+	 * 0 since no piece of kernel is supposed to do a check
+	 * for a negative retval of schedule_timeout() (since it
+	 * should never happens anyway). You just have the printk()
+	 * that will tell you if something is gone wrong and where.
+	 */
+	if (timeout < 0) {
+		printk(KERN_ERR "schedule_timeout: wrong timeout "
 				"value %lx\n", timeout);
-			dump_stack();
-			current->state = TASK_RUNNING;
-			goto out;
-		}
+		dump_stack();
+		current->state = TASK_RUNNING;
+		goto out;
 	}
 
 	expire = timeout + jiffies;
@@ -1898,10 +1884,10 @@ signed long __sched schedule_timeout(signed long timeout)
 
 	timeout = expire - jiffies;
 
- out:
+out:
 	return timeout < 0 ? 0 : timeout;
 }
-EXPORT_SYMBOL(schedule_timeout);
+EXPORT_SYMBOL(__schedule_timeout);
 
 /*
  * We can use __set_current_state() here because schedule_timeout() calls
