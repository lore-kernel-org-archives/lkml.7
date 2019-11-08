Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC65FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38682206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfKHRf5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:35:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52303 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHRf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:35:56 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iT8Ar-000888-G8; Fri, 08 Nov 2019 18:35:53 +0100
Date:   Fri, 8 Nov 2019 18:35:53 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191108173553.lxsdic6wa4y3ifsr@linutronix.de>
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
 <20191107091319.6zf5tmdi54amtann@linutronix.de>
 <20191107161749.GA93945@dennisz-mbp>
 <20191107162842.2qgd3db2cjmmsxeh@linutronix.de>
 <20191107165519.GA99408@dennisz-mbp>
 <20191107172434.ylz4hyxw4rbmhre2@linutronix.de>
 <20191107173653.GA1242@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191107173653.GA1242@dennisz-mbp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revert of commit
   a4244454df129 ("percpu-refcount: use RCU-sched insted of normal RCU")

which claims the only reason for using RCU-sched is
   "rcu_read_[un]lock() … are slightly more expensive than preempt_disable/enable()"

and
    "As the RCU critical sections are extremely short, using sched-RCU
    shouldn't have any latency implications."

The problem with using RCU-sched here is that it disables preemption and
the release callback (called from percpu_ref_put_many()) must not
acquire any sleeping locks like spinlock_t. This breaks PREEMPT_RT
because some of the users acquire spinlock_t locks in their callbacks.

Using rcu_read_lock() on PREEMPTION=n kernels is not any different
compared to rcu_read_lock_sched(). On PREEMPTION=y kernels there are
already performance issues due to additional preemption points.
Looking at the code, the rcu_read_lock() is just an increment and unlock
is almost just a decrement unless there is something special to do. Both
are functions while disabling preemption is inlined.
Doing a small benchmark, the minimal amount of time required was mostly
the same. The average time required was higher due to the higher MAX
value (which could be preemption). With DEBUG_PREEMPT=y it is
rcu_read_lock_sched() that takes a little longer due to the additional
debug code.

Convert back to normal RCU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2019-11-07 12:36:53 [-0500], Dennis Zhou wrote:
> > some RCU section here invoke callbacks which acquire spinlock_t locks.
> > This does not work on RT with disabled preemption.
> > 
> 
> Yeah, so adding a bit in the commit message about why it's an issue for
> RT kernels with disabled preemption as I don't believe this is an issue
> for non-RT kernels.

I realized that I had partly in the commit message so I rewrote the
second chapter hopefully covering it all now more explicit.

v1…v2: Slightly rewriting the second paragraph regarding RT
implications.

 include/linux/percpu-refcount.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 7aef0abc194a2..390031e816dcd 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -186,14 +186,14 @@ static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
 {
 	unsigned long __percpu *percpu_count;
 
-	rcu_read_lock_sched();
+	rcu_read_lock();
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_add(*percpu_count, nr);
 	else
 		atomic_long_add(nr, &ref->count);
 
-	rcu_read_unlock_sched();
+	rcu_read_unlock();
 }
 
 /**
@@ -223,7 +223,7 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
 	unsigned long __percpu *percpu_count;
 	bool ret;
 
-	rcu_read_lock_sched();
+	rcu_read_lock();
 
 	if (__ref_is_percpu(ref, &percpu_count)) {
 		this_cpu_inc(*percpu_count);
@@ -232,7 +232,7 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
 		ret = atomic_long_inc_not_zero(&ref->count);
 	}
 
-	rcu_read_unlock_sched();
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -257,7 +257,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
 	unsigned long __percpu *percpu_count;
 	bool ret = false;
 
-	rcu_read_lock_sched();
+	rcu_read_lock();
 
 	if (__ref_is_percpu(ref, &percpu_count)) {
 		this_cpu_inc(*percpu_count);
@@ -266,7 +266,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
 		ret = atomic_long_inc_not_zero(&ref->count);
 	}
 
-	rcu_read_unlock_sched();
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -285,14 +285,14 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 {
 	unsigned long __percpu *percpu_count;
 
-	rcu_read_lock_sched();
+	rcu_read_lock();
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_sub(*percpu_count, nr);
 	else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
 		ref->release(ref);
 
-	rcu_read_unlock_sched();
+	rcu_read_unlock();
 }
 
 /**
-- 
2.24.0


