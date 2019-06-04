Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09084C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52C7245C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ptqdkyup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfFDIxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:53:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34054 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfFDIxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1+roFI1LTutUa2nnj4FjSsN9h8+OYYtCkAaKCsM63A0=; b=Ptqdkyup7y9RWMBq3RYU+raqs
        l0dvw8bphckKX200JwjeVOtFwGQ5cku8Hx6R/SysXN//M0+jpKJPAFN+y95snltcASslMkoPKZK3X
        DN9WP/4KgHVnu7QMeZncQlJf2bHGbqvDyCsvvk7J6rtFAESaGC8GUXy1rNKP0DGcZwKEdgaz4nB+j
        zEd6VoDQu7syb9MKTLNKSpApQUt8Vv8KiOWd4rGSVphdlSMIQNyuy+nEVL796ZD50ij2gf5I6P/y9
        v1aezeCSLKQQwBBK0JlSkjzdENa3S5/IRPQ9PAbg5R5wOR1xhSGb0IijhhrNRg9d7dtuflK8dh72u
        gh60fLvtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY5BQ-0002sZ-Pc; Tue, 04 Jun 2019 08:52:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23E122083F71A; Tue,  4 Jun 2019 10:52:38 +0200 (CEST)
Date:   Tue, 4 Jun 2019 10:52:38 +0200
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
Subject: Re: [PATCH v8 13/19] locking/rwsem: Make rwsem->owner an
 atomic_long_t
Message-ID: <20190604085238.GF3402@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-14-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520205918.22251-14-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:59:12PM -0400, Waiman Long wrote:
> +static inline struct task_struct *rwsem_read_owner(struct rw_semaphore *sem)
> +{
> +	return (struct task_struct *)(atomic_long_read(&sem->owner) &
> +					~RWSEM_OWNER_FLAGS_MASK);
> +}
> +
> +/*
> + * Return the real task structure pointer of the owner and the embedded
> + * flags in the owner. pflags must be non-NULL.
> + */
> +static inline struct task_struct *
> +rwsem_read_owner_flags(struct rw_semaphore *sem, long *pflags)
> +{
> +	long owner = atomic_long_read(&sem->owner);
> +
> +	*pflags = owner & RWSEM_OWNER_FLAGS_MASK;
> +	return (struct task_struct *)(owner & ~RWSEM_OWNER_FLAGS_MASK);
> +}

I got confused by the 'read' part in those nanes, I initially thought
they paired with rwsem_set_reader_owned().

So I've done 's/rwsem_read_owner/rwsem_owner/g on it.

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -194,10 +194,10 @@ static inline void rwsem_clear_reader_ow
 /*
  * Return just the real task structure pointer of the owner
  */
-static inline struct task_struct *rwsem_read_owner(struct rw_semaphore *sem)
+static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
 {
-	return (struct task_struct *)(atomic_long_read(&sem->owner) &
-					~RWSEM_OWNER_FLAGS_MASK);
+	return (struct task_struct *)
+		(atomic_long_read(&sem->owner) & ~RWSEM_OWNER_FLAGS_MASK);
 }
 
 /*
@@ -205,7 +205,7 @@ static inline struct task_struct *rwsem_
  * flags in the owner. pflags must be non-NULL.
  */
 static inline struct task_struct *
-rwsem_read_owner_flags(struct rw_semaphore *sem, long *pflags)
+rwsem_owner_flags(struct rw_semaphore *sem, long *pflags)
 {
 	long owner = atomic_long_read(&sem->owner);
 
@@ -561,7 +561,7 @@ static inline bool rwsem_can_spin_on_own
 
 	preempt_disable();
 	rcu_read_lock();
-	owner = rwsem_read_owner_flags(sem, &flags);
+	owner = rwsem_owner_flags(sem, &flags);
 	if ((flags & RWSEM_NONSPINNABLE) || (owner && !owner_on_cpu(owner)))
 		ret = false;
 	rcu_read_unlock();
@@ -590,8 +590,8 @@ enum owner_state {
 };
 #define OWNER_SPINNABLE		(OWNER_NULL | OWNER_WRITER)
 
-static inline enum owner_state rwsem_owner_state(struct task_struct *owner,
-						 long flags)
+static inline enum owner_state
+rwsem_owner_state(struct task_struct *owner, long flags)
 {
 	if (flags & RWSEM_NONSPINNABLE)
 		return OWNER_NONSPINNABLE;
@@ -608,7 +608,7 @@ static noinline enum owner_state rwsem_s
 	long flags, new_flags;
 	enum owner_state state;
 
-	owner = rwsem_read_owner_flags(sem, &flags);
+	owner = rwsem_owner_flags(sem, &flags);
 	state = rwsem_owner_state(owner, flags);
 	if (state != OWNER_WRITER)
 		return state;
@@ -620,7 +620,7 @@ static noinline enum owner_state rwsem_s
 			break;
 		}
 
-		new = rwsem_read_owner_flags(sem, &new_flags);
+		new = rwsem_owner_flags(sem, &new_flags);
 		if ((new != owner) || (new_flags != flags)) {
 			state = rwsem_owner_state(new, new_flags);
 			break;
@@ -1139,7 +1139,7 @@ static inline void __up_write(struct rw_
 	 * sem->owner may differ from current if the ownership is transferred
 	 * to an anonymous writer by setting the RWSEM_NONSPINNABLE bits.
 	 */
-	DEBUG_RWSEMS_WARN_ON((rwsem_read_owner(sem) != current) &&
+	DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
 			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
@@ -1161,7 +1161,7 @@ static inline void __downgrade_write(str
 	 * read-locked region is ok to be re-ordered into the
 	 * write side. As such, rely on RELEASE semantics.
 	 */
-	DEBUG_RWSEMS_WARN_ON(rwsem_read_owner(sem) != current, sem);
+	DEBUG_RWSEMS_WARN_ON(rwsem_owner(sem) != current, sem);
 	tmp = atomic_long_fetch_add_release(
 		-RWSEM_WRITER_LOCKED+RWSEM_READER_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
