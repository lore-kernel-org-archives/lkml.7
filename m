Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D934EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A119D2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Onxo86XI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390808AbfFKN2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:28:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54714 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfFKN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ig7vOGjp2bXduPak6oXR9rPbR4RLk/FdDFwnelnoD7U=; b=Onxo86XIdhFxUT1ts3zIqC8cQ
        8rqbMXTAiArDGPZSVMusGkL/Ql20EMCRnd/V/EQs1APjoM0j96c6Vh8COMWB7oGR+AHhqyrU61xft
        LIE5t2lJjwCuAThQJQME6TZllTc+gktHaN/auNJmjYRAU19hY+WAs/y7IVfGz3/lXmfDAvRz3G43j
        MNsqHVDxLgSwKXH+AiaIWoha6oCa+4GwAnNbNwEgirrM/rgBHOoQn0BM7Q11T0U2b2F7Xxmg0Omad
        nRGTwd7+pb7ZdYCTZTLSyVX54qcbCQfN2/cAzs6JZtaOkWOSIXKW/L6vd4K01dH9GDGLWdHbo5VMk
        C9P9szI/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hago2-0004l6-1t; Tue, 11 Jun 2019 13:27:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6FC020234FAF; Tue, 11 Jun 2019 15:27:15 +0200 (CEST)
Date:   Tue, 11 Jun 2019 15:27:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v8 16/19] locking/rwsem: Guard against making count
 negative
Message-ID: <20190611132715.GJ3463@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-17-longman@redhat.com>
 <20190611131131.GG3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611131131.GG3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 03:11:31PM +0200, Peter Zijlstra wrote:
> On Mon, May 20, 2019 at 04:59:15PM -0400, Waiman Long wrote:
> 
> > +static inline long rwsem_read_trylock(struct rw_semaphore *sem, long *cnt)
> > +{
> > +	long adjustment = -RWSEM_READER_BIAS;
> > +
> > +	*cnt = atomic_long_fetch_add_acquire(RWSEM_READER_BIAS, &sem->count);
> 
> I'm thinking we'd actually want add_return_acquire() here.
> 
> > +	if (unlikely(*cnt < 0)) {
> > +		atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> > +		adjustment = 0;
> > +	}
> > +	return adjustment;
> > +}
> 
> > @@ -1271,9 +1332,10 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
> >   */
> >  inline void __down_read(struct rw_semaphore *sem)
> >  {
> > +	long tmp, adjustment = rwsem_read_trylock(sem, &tmp);
> > +
> > +	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
> > +		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE, adjustment);
> >  		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
> >  	} else {
> >  		rwsem_set_reader_owned(sem);
> > @@ -1282,9 +1344,11 @@ inline void __down_read(struct rw_semaphore *sem)
> >  
> >  static inline int __down_read_killable(struct rw_semaphore *sem)
> >  {
> > +	long tmp, adjustment = rwsem_read_trylock(sem, &tmp);
> > +
> > +	if (unlikely(tmp & RWSEM_READ_FAILED_MASK)) {
> > +		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE,
> > +						    adjustment)))
> >  			return -EINTR;
> >  		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
> >  	} else {
> 
> I'm confused by the need for @tmp; isn't that returning the exact same
> state !adjustment is?

Argh.. READ_FAILED_MASK isn't just the MSB. Bah, this is confusing.

Maybe something like so?

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -116,13 +116,28 @@
 #endif
 
 /*
- * The definition of the atomic counter in the semaphore:
+ * On 64-bit architectures, the bit definitions of the count are:
  *
- * Bit  0   - writer locked bit
- * Bit  1   - waiters present bit
- * Bit  2   - lock handoff bit
- * Bits 3-7 - reserved
- * Bits 8-X - 24-bit (32-bit) or 56-bit reader count
+ * Bit  0    - writer locked bit
+ * Bit  1    - waiters present bit
+ * Bit  2    - lock handoff bit
+ * Bits 3-7  - reserved
+ * Bits 8-62 - 55-bit reader count
+ * Bit  63   - read fail bit
+ *
+ * On 32-bit architectures, the bit definitions of the count are:
+ *
+ * Bit  0    - writer locked bit
+ * Bit  1    - waiters present bit
+ * Bit  2    - lock handoff bit
+ * Bits 3-7  - reserved
+ * Bits 8-30 - 23-bit reader count
+ * Bit  31   - read fail bit
+ *
+ * It is not likely that the most significant bit (read fail bit) will ever
+ * be set. This guard bit is still checked anyway in the down_read() fastpath
+ * just in case we need to use up more of the reader bits for other purpose
+ * in the future.
  *
  * atomic_long_fetch_add() is used to obtain reader lock, whereas
  * atomic_long_cmpxchg() will be used to obtain writer lock.
@@ -139,6 +154,7 @@
 #define RWSEM_WRITER_LOCKED	(1UL << 0)
 #define RWSEM_FLAG_WAITERS	(1UL << 1)
 #define RWSEM_FLAG_HANDOFF	(1UL << 2)
+#define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
 
 #define RWSEM_READER_SHIFT	8
 #define RWSEM_READER_BIAS	(1UL << RWSEM_READER_SHIFT)
@@ -146,7 +162,7 @@
 #define RWSEM_WRITER_MASK	RWSEM_WRITER_LOCKED
 #define RWSEM_LOCK_MASK		(RWSEM_WRITER_MASK|RWSEM_READER_MASK)
 #define RWSEM_READ_FAILED_MASK	(RWSEM_WRITER_MASK|RWSEM_FLAG_WAITERS|\
-				 RWSEM_FLAG_HANDOFF)
+				 RWSEM_FLAG_HANDOFF|RWSEM_FLAG_READFAIL)
 
 /*
  * All writes to owner are protected by WRITE_ONCE() to make sure that
@@ -254,6 +270,14 @@ static inline void rwsem_set_nonspinnabl
 					  owner | RWSEM_NONSPINNABLE));
 }
 
+static inline bool rwsem_read_trylock(struct rw_semaphore *sem)
+{
+	unsigned long cnt = atomic_long_add_return_acquire(RWSEM_READER_BIAS, &sem->count);
+	WARN_ON_ONCE(cnt < 0);
+	return !(cnt & RWSEM_READ_FAILED_MASK);
+
+}
+
 /*
  * Return just the real task structure pointer of the owner
  */
@@ -403,6 +427,12 @@ static void rwsem_mark_wake(struct rw_se
 	}
 
 	/*
+	 * No reader wakeup if there are too many of them already.
+	 */
+	if (unlikely(atomic_long_read(&sem->count) < 0))
+		return;
+
+	/*
 	 * Writers might steal the lock before we grant it to the next reader.
 	 * We prefer to do the first reader grant before counting readers
 	 * so we can bail out early if a writer stole the lock.
@@ -949,9 +979,9 @@ static struct rw_semaphore __sched *
 rwsem_down_read_slowpath(struct rw_semaphore *sem, int state)
 {
 	long count, adjustment = -RWSEM_READER_BIAS;
-	bool wake = false;
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
+	bool wake = false;
 
 	/*
 	 * Save the current read-owner of rwsem, if available, and the
@@ -1270,8 +1300,7 @@ static struct rw_semaphore *rwsem_downgr
  */
 inline void __down_read(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
+	if (!rwsem_read_trylock(sem)) {
 		rwsem_down_read_slowpath(sem, TASK_UNINTERRUPTIBLE);
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
@@ -1281,9 +1310,8 @@ inline void __down_read(struct rw_semaph
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_fetch_add_acquire(RWSEM_READER_BIAS,
-			&sem->count) & RWSEM_READ_FAILED_MASK)) {
-		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE)))
+	if (!rwsem_read_trylock(sem)) {
+		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_KILLABLE));
 			return -EINTR;
 		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	} else {
@@ -1359,6 +1387,7 @@ inline void __up_read(struct rw_semaphor
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_add_return_release(-RWSEM_READER_BIAS, &sem->count);
+	DEBUG_RWSEMS_WARN_ON(tmp < 0, sem);
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
 		      RWSEM_FLAG_WAITERS)) {
 		clear_wr_nonspinnable(sem);
