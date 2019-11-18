Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2479AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D686722304
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKRXX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 18:23:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:53590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726787AbfKRXX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 18:23:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E38B4AC81;
        Mon, 18 Nov 2019 23:23:54 +0000 (UTC)
Date:   Mon, 18 Nov 2019 15:19:35 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, jack@suse.com
Subject: Re: [PATCH 5/5] locking/percpu-rwsem: Remove the embedded rwsem
Message-ID: <20191118231935.7wvkozof3ocubxej@linux-p48b>
References: <20191113102115.116470462@infradead.org>
 <20191113102855.925208237@infradead.org>
 <20191118195304.b3d6fg4jmmj7kmfh@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191118195304.b3d6fg4jmmj7kmfh@linux-p48b>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019, Davidlohr Bueso wrote:

>On Wed, 13 Nov 2019, Peter Zijlstra wrote:
3>>bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
>>{
>>	if (__percpu_down_read_trylock(sem))
>>@@ -89,20 +156,10 @@ bool __percpu_down_read(struct percpu_rw
>>	if (try)
>>		return false;
>>
>>-	/*
>>-	 * We either call schedule() in the wait, or we'll fall through
>>-	 * and reschedule on the preempt_enable() in percpu_down_read().
>>-	 */
>>-	preempt_enable_no_resched();
>>-
>>-	/*
>>-	 * Avoid lockdep for the down/up_read() we already have them.
>>-	 */
>>-	__down_read(&sem->rw_sem);
>>-	this_cpu_inc(*sem->read_count);
>>-	__up_read(&sem->rw_sem);
>>-
>>+	preempt_enable();
>>+	percpu_rwsem_wait(sem, /* .reader = */ true );
>>	preempt_disable();
>>+
>>	return true;
>>}
>>EXPORT_SYMBOL_GPL(__percpu_down_read);
>
>Do we really need to export symbol here? This function is only called
>from percpu-rwsem.h.

Similarly, afaict we can get rid of __percpu_up_read() and put the
slowpath all into percpu_up_read(). Also explicitly mention the
single task nature of the writer (which is a better comment for
the rcuwait_wake_up()).

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index f5ecf6a8a1dd..eda545f42fb8 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -43,7 +43,6 @@ is_static struct percpu_rw_semaphore name = {				\
 	__DEFINE_PERCPU_RWSEM(name, static)
 
 extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool);
-extern void __percpu_up_read(struct percpu_rw_semaphore *);
 
 static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 {
@@ -103,10 +102,23 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 	/*
 	 * Same as in percpu_down_read().
 	 */
-	if (likely(rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss))) {
 		__this_cpu_dec(*sem->read_count);
-	else
-		__percpu_up_read(sem); /* Unconditional memory barrier */
+		goto done;
+	}
+
+	/*
+	 * slowpath; reader will only ever wake a single blocked writer.
+	 */
+	smp_mb(); /* B matches C */
+	/*
+	 * In other words, if they see our decrement (presumably to
+	 * aggregate zero, as that is the only time it matters) they
+	 * will also see our critical section.
+	 */
+	__this_cpu_dec(*sem->read_count);
+	rcuwait_wake_up(&sem->writer);
+done:
 	preempt_enable();
 }
 
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 851038468efb..a5150a876626 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -164,21 +164,6 @@ bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 }
 EXPORT_SYMBOL_GPL(__percpu_down_read);
 
-void __percpu_up_read(struct percpu_rw_semaphore *sem)
-{
-	smp_mb(); /* B matches C */
-	/*
-	 * In other words, if they see our decrement (presumably to aggregate
-	 * zero, as that is the only time it matters) they will also see our
-	 * critical section.
-	 */
-	__this_cpu_dec(*sem->read_count);
-
-	/* Prod writer to re-evaluate readers_active_check() */
-	rcuwait_wake_up(&sem->writer);
-}
-EXPORT_SYMBOL_GPL(__percpu_up_read);
-
 #define per_cpu_sum(var)						\
 ({									\
 	typeof(var) __sum = 0;						\
