Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16A3C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66588205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UTrfSgpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfFYIbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:31:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37527 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:30:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8U1KF3530618
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:30:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8U1KF3530618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451403;
        bh=9qi7IEMet66mVG+aMqpw39hpou6ZGHsy7zPvYFSKqQU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UTrfSgpamVFk+uWoE5J2xfubUB+9Vm+z9cd+YC0ysyYXAcNNdteqn0LRcfv9ZYk08
         6NaVVvUPYILGQe8OFpu1SOILCRnanpd1WQB7IXm4XmgB/p055IYxFbYiIlcB0og23u
         4HjKLBpg7XFUsWplS8hkU8MUHaLY3hPQM2/g081QinpyS9oUe3XfcKbwvwkoM/ZLC6
         O0VUR8EEj/e56aoKhQbuucM0EXGLlGdZvmKpc0meGe+SrE0N3yTYPkfXP6G0dkQE8B
         uUhlXrxnKxb9Hs2m1qro5+sbd/Iag/7Xqn+xEeADcpmSxwnytoBzGZkMMwEbMjx3v9
         iE1grWRtf9H+w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8U1bu3530544;
        Tue, 25 Jun 2019 01:30:01 -0700
Date:   Tue, 25 Jun 2019 01:30:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-69842cba9ace84849bb9b8edcdf2cefccd97901c@git.kernel.org>
Cc:     torvalds@linux-foundation.org, rafael.j.wysocki@intel.com,
        linux-kernel@vger.kernel.org, quentin.perret@arm.com,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        dietmar.eggemann@arm.com, tkjos@google.com, surenb@google.com,
        pjt@google.com, hpa@zytor.com, patrick.bellasi@arm.com,
        viresh.kumar@linaro.org, juri.lelli@redhat.com, mingo@kernel.org,
        joelaf@google.com, tglx@linutronix.de, smuckle@google.com,
        balsini@android.com, tj@kernel.org, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, rafael.j.wysocki@intel.com,
          linux-kernel@vger.kernel.org, quentin.perret@arm.com,
          morten.rasmussen@arm.com, vincent.guittot@linaro.org,
          dietmar.eggemann@arm.com, tkjos@google.com, surenb@google.com,
          pjt@google.com, hpa@zytor.com, patrick.bellasi@arm.com,
          viresh.kumar@linaro.org, juri.lelli@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, joelaf@google.com, smuckle@google.com,
          balsini@android.com, tj@kernel.org, peterz@infradead.org
In-Reply-To: <20190621084217.8167-2-patrick.bellasi@arm.com>
References: <20190621084217.8167-2-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/uclamp: Add CPU's clamp buckets refcounting
Git-Commit-ID: 69842cba9ace84849bb9b8edcdf2cefccd97901c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  69842cba9ace84849bb9b8edcdf2cefccd97901c
Gitweb:     https://git.kernel.org/tip/69842cba9ace84849bb9b8edcdf2cefccd97901c
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 21 Jun 2019 09:42:02 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:44 +0200

sched/uclamp: Add CPU's clamp buckets refcounting

Utilization clamping allows to clamp the CPU's utilization within a
[util_min, util_max] range, depending on the set of RUNNABLE tasks on
that CPU. Each task references two "clamp buckets" defining its minimum
and maximum (util_{min,max}) utilization "clamp values". A CPU's clamp
bucket is active if there is at least one RUNNABLE tasks enqueued on
that CPU and refcounting that bucket.

When a task is {en,de}queued {on,from} a rq, the set of active clamp
buckets on that CPU can change. If the set of active clamp buckets
changes for a CPU a new "aggregated" clamp value is computed for that
CPU. This is because each clamp bucket enforces a different utilization
clamp value.

Clamp values are always MAX aggregated for both util_min and util_max.
This ensures that no task can affect the performance of other
co-scheduled tasks which are more boosted (i.e. with higher util_min
clamp) or less capped (i.e. with higher util_max clamp).

A task has:
   task_struct::uclamp[clamp_id]::bucket_id
to track the "bucket index" of the CPU's clamp bucket it refcounts while
enqueued, for each clamp index (clamp_id).

A runqueue has:
   rq::uclamp[clamp_id]::bucket[bucket_id].tasks
to track how many RUNNABLE tasks on that CPU refcount each
clamp bucket (bucket_id) of a clamp index (clamp_id).
It also has a:
   rq::uclamp[clamp_id]::bucket[bucket_id].value
to track the clamp value of each clamp bucket (bucket_id) of a clamp
index (clamp_id).

The rq::uclamp::bucket[clamp_id][] array is scanned every time it's
needed to find a new MAX aggregated clamp value for a clamp_id. This
operation is required only when it's dequeued the last task of a clamp
bucket tracking the current MAX aggregated clamp value. In this case,
the CPU is either entering IDLE or going to schedule a less boosted or
more clamped task.
The expected number of different clamp values configured at build time
is small enough to fit the full unordered array into a single cache
line, for configurations of up to 7 buckets.

Add to struct rq the basic data structures required to refcount the
number of RUNNABLE tasks for each clamp bucket. Add also the max
aggregation required to update the rq's clamp value at each
enqueue/dequeue event.

Use a simple linear mapping of clamp values into clamp buckets.
Pre-compute and cache bucket_id to avoid integer divisions at
enqueue/dequeue time.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alessio Balsini <balsini@android.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20190621084217.8167-2-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/log2.h           |  34 +++++++++
 include/linux/sched.h          |  39 ++++++++++
 include/linux/sched/topology.h |   6 --
 init/Kconfig                   |  53 +++++++++++++
 kernel/sched/core.c            | 166 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h           |  51 +++++++++++++
 6 files changed, 343 insertions(+), 6 deletions(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index 1aec01365ed4..83a4a3ca3e8a 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -220,4 +220,38 @@ int __order_base_2(unsigned long n)
 		ilog2((n) - 1) + 1) :		\
 	__order_base_2(n)			\
 )
+
+static inline __attribute__((const))
+int __bits_per(unsigned long n)
+{
+	if (n < 2)
+		return 1;
+	if (is_power_of_2(n))
+		return order_base_2(n) + 1;
+	return order_base_2(n);
+}
+
+/**
+ * bits_per - calculate the number of bits required for the argument
+ * @n: parameter
+ *
+ * This is constant-capable and can be used for compile time
+ * initializations, e.g bitfields.
+ *
+ * The first few values calculated by this routine:
+ * bf(0) = 1
+ * bf(1) = 1
+ * bf(2) = 2
+ * bf(3) = 2
+ * bf(4) = 3
+ * ... and so on.
+ */
+#define bits_per(n)				\
+(						\
+	__builtin_constant_p(n) ? (		\
+		((n) == 0 || (n) == 1)		\
+			? 1 : ilog2(n) + 1	\
+	) :					\
+	__bits_per(n)				\
+)
 #endif /* _LINUX_LOG2_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 044c023875e8..80235bcd05f2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -283,6 +283,18 @@ struct vtime {
 	u64			gtime;
 };
 
+/*
+ * Utilization clamp constraints.
+ * @UCLAMP_MIN:	Minimum utilization
+ * @UCLAMP_MAX:	Maximum utilization
+ * @UCLAMP_CNT:	Utilization clamp constraints count
+ */
+enum uclamp_id {
+	UCLAMP_MIN = 0,
+	UCLAMP_MAX,
+	UCLAMP_CNT
+};
+
 struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
@@ -314,6 +326,10 @@ struct sched_info {
 # define SCHED_FIXEDPOINT_SHIFT		10
 # define SCHED_FIXEDPOINT_SCALE		(1L << SCHED_FIXEDPOINT_SHIFT)
 
+/* Increase resolution of cpu_capacity calculations */
+# define SCHED_CAPACITY_SHIFT		SCHED_FIXEDPOINT_SHIFT
+# define SCHED_CAPACITY_SCALE		(1L << SCHED_CAPACITY_SHIFT)
+
 struct load_weight {
 	unsigned long			weight;
 	u32				inv_weight;
@@ -562,6 +578,25 @@ struct sched_dl_entity {
 	struct hrtimer inactive_timer;
 };
 
+#ifdef CONFIG_UCLAMP_TASK
+/* Number of utilization clamp buckets (shorter alias) */
+#define UCLAMP_BUCKETS CONFIG_UCLAMP_BUCKETS_COUNT
+
+/*
+ * Utilization clamp for a scheduling entity
+ * @value:		clamp value "assigned" to a se
+ * @bucket_id:		bucket index corresponding to the "assigned" value
+ *
+ * The bucket_id is the index of the clamp bucket matching the clamp value
+ * which is pre-computed and stored to avoid expensive integer divisions from
+ * the fast path.
+ */
+struct uclamp_se {
+	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
+	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
+};
+#endif /* CONFIG_UCLAMP_TASK */
+
 union rcu_special {
 	struct {
 		u8			blocked;
@@ -642,6 +677,10 @@ struct task_struct {
 #endif
 	struct sched_dl_entity		dl;
 
+#ifdef CONFIG_UCLAMP_TASK
+	struct uclamp_se		uclamp[UCLAMP_CNT];
+#endif
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
 	struct hlist_head		preempt_notifiers;
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index e445d3767cdd..7863bb62d2ab 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -6,12 +6,6 @@
 
 #include <linux/sched/idle.h>
 
-/*
- * Increase resolution of cpu_capacity calculations
- */
-#define SCHED_CAPACITY_SHIFT	SCHED_FIXEDPOINT_SHIFT
-#define SCHED_CAPACITY_SCALE	(1L << SCHED_CAPACITY_SHIFT)
-
 /*
  * sched-domains (multiprocessor balancing) declarations:
  */
diff --git a/init/Kconfig b/init/Kconfig
index 0e2344389501..c88289c18d59 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -677,6 +677,59 @@ config HAVE_UNSTABLE_SCHED_CLOCK
 config GENERIC_SCHED_CLOCK
 	bool
 
+menu "Scheduler features"
+
+config UCLAMP_TASK
+	bool "Enable utilization clamping for RT/FAIR tasks"
+	depends on CPU_FREQ_GOV_SCHEDUTIL
+	help
+	  This feature enables the scheduler to track the clamped utilization
+	  of each CPU based on RUNNABLE tasks scheduled on that CPU.
+
+	  With this option, the user can specify the min and max CPU
+	  utilization allowed for RUNNABLE tasks. The max utilization defines
+	  the maximum frequency a task should use while the min utilization
+	  defines the minimum frequency it should use.
+
+	  Both min and max utilization clamp values are hints to the scheduler,
+	  aiming at improving its frequency selection policy, but they do not
+	  enforce or grant any specific bandwidth for tasks.
+
+	  If in doubt, say N.
+
+config UCLAMP_BUCKETS_COUNT
+	int "Number of supported utilization clamp buckets"
+	range 5 20
+	default 5
+	depends on UCLAMP_TASK
+	help
+	  Defines the number of clamp buckets to use. The range of each bucket
+	  will be SCHED_CAPACITY_SCALE/UCLAMP_BUCKETS_COUNT. The higher the
+	  number of clamp buckets the finer their granularity and the higher
+	  the precision of clamping aggregation and tracking at run-time.
+
+	  For example, with the minimum configuration value we will have 5
+	  clamp buckets tracking 20% utilization each. A 25% boosted tasks will
+	  be refcounted in the [20..39]% bucket and will set the bucket clamp
+	  effective value to 25%.
+	  If a second 30% boosted task should be co-scheduled on the same CPU,
+	  that task will be refcounted in the same bucket of the first task and
+	  it will boost the bucket clamp effective value to 30%.
+	  The clamp effective value of a bucket is reset to its nominal value
+	  (20% in the example above) when there are no more tasks refcounted in
+	  that bucket.
+
+	  An additional boost/capping margin can be added to some tasks. In the
+	  example above the 25% task will be boosted to 30% until it exits the
+	  CPU. If that should be considered not acceptable on certain systems,
+	  it's always possible to reduce the margin by increasing the number of
+	  clamp buckets to trade off used memory for run-time tracking
+	  precision.
+
+	  If in doubt, use the default value.
+
+endmenu
+
 #
 # For architectures that want to enable the support for NUMA-affine scheduler
 # balancing logic:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e5e02d23e693..d8c1e67afd82 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -772,6 +772,168 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	}
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+
+/* Integer rounded range for each bucket */
+#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
+
+#define for_each_clamp_id(clamp_id) \
+	for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
+
+static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
+{
+	return clamp_value / UCLAMP_BUCKET_DELTA;
+}
+
+static inline unsigned int uclamp_none(int clamp_id)
+{
+	if (clamp_id == UCLAMP_MIN)
+		return 0;
+	return SCHED_CAPACITY_SCALE;
+}
+
+static inline void uclamp_se_set(struct uclamp_se *uc_se, unsigned int value)
+{
+	uc_se->value = value;
+	uc_se->bucket_id = uclamp_bucket_id(value);
+}
+
+static inline
+unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id)
+{
+	struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
+	int bucket_id = UCLAMP_BUCKETS - 1;
+
+	/*
+	 * Since both min and max clamps are max aggregated, find the
+	 * top most bucket with tasks in.
+	 */
+	for ( ; bucket_id >= 0; bucket_id--) {
+		if (!bucket[bucket_id].tasks)
+			continue;
+		return bucket[bucket_id].value;
+	}
+
+	/* No tasks -- default clamp values */
+	return uclamp_none(clamp_id);
+}
+
+/*
+ * When a task is enqueued on a rq, the clamp bucket currently defined by the
+ * task's uclamp::bucket_id is refcounted on that rq. This also immediately
+ * updates the rq's clamp value if required.
+ */
+static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
+				    unsigned int clamp_id)
+{
+	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
+	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
+	struct uclamp_bucket *bucket;
+
+	lockdep_assert_held(&rq->lock);
+
+	bucket = &uc_rq->bucket[uc_se->bucket_id];
+	bucket->tasks++;
+
+	if (uc_se->value > READ_ONCE(uc_rq->value))
+		WRITE_ONCE(uc_rq->value, bucket->value);
+}
+
+/*
+ * When a task is dequeued from a rq, the clamp bucket refcounted by the task
+ * is released. If this is the last task reference counting the rq's max
+ * active clamp value, then the rq's clamp value is updated.
+ *
+ * Both refcounted tasks and rq's cached clamp values are expected to be
+ * always valid. If it's detected they are not, as defensive programming,
+ * enforce the expected state and warn.
+ */
+static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
+				    unsigned int clamp_id)
+{
+	struct uclamp_rq *uc_rq = &rq->uclamp[clamp_id];
+	struct uclamp_se *uc_se = &p->uclamp[clamp_id];
+	struct uclamp_bucket *bucket;
+	unsigned int rq_clamp;
+
+	lockdep_assert_held(&rq->lock);
+
+	bucket = &uc_rq->bucket[uc_se->bucket_id];
+	SCHED_WARN_ON(!bucket->tasks);
+	if (likely(bucket->tasks))
+		bucket->tasks--;
+
+	if (likely(bucket->tasks))
+		return;
+
+	rq_clamp = READ_ONCE(uc_rq->value);
+	/*
+	 * Defensive programming: this should never happen. If it happens,
+	 * e.g. due to future modification, warn and fixup the expected value.
+	 */
+	SCHED_WARN_ON(bucket->value > rq_clamp);
+	if (bucket->value >= rq_clamp)
+		WRITE_ONCE(uc_rq->value, uclamp_rq_max_value(rq, clamp_id));
+}
+
+static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
+{
+	unsigned int clamp_id;
+
+	if (unlikely(!p->sched_class->uclamp_enabled))
+		return;
+
+	for_each_clamp_id(clamp_id)
+		uclamp_rq_inc_id(rq, p, clamp_id);
+}
+
+static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
+{
+	unsigned int clamp_id;
+
+	if (unlikely(!p->sched_class->uclamp_enabled))
+		return;
+
+	for_each_clamp_id(clamp_id)
+		uclamp_rq_dec_id(rq, p, clamp_id);
+}
+
+static void __init init_uclamp(void)
+{
+	unsigned int clamp_id;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct uclamp_bucket *bucket;
+		struct uclamp_rq *uc_rq;
+		unsigned int bucket_id;
+
+		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+
+		for_each_clamp_id(clamp_id) {
+			uc_rq = &cpu_rq(cpu)->uclamp[clamp_id];
+
+			bucket_id = 1;
+			while (bucket_id < UCLAMP_BUCKETS) {
+				bucket = &uc_rq->bucket[bucket_id];
+				bucket->value = bucket_id * UCLAMP_BUCKET_DELTA;
+				++bucket_id;
+			}
+		}
+	}
+
+	for_each_clamp_id(clamp_id) {
+		uclamp_se_set(&init_task.uclamp[clamp_id],
+			      uclamp_none(clamp_id));
+	}
+}
+
+#else /* CONFIG_UCLAMP_TASK */
+static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
+static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
+static inline void init_uclamp(void) { }
+#endif /* CONFIG_UCLAMP_TASK */
+
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (!(flags & ENQUEUE_NOCLOCK))
@@ -782,6 +944,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_enqueue(p, flags & ENQUEUE_WAKEUP);
 	}
 
+	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
 }
 
@@ -795,6 +958,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_dequeue(p, flags & DEQUEUE_SLEEP);
 	}
 
+	uclamp_rq_dec(rq, p);
 	p->sched_class->dequeue_task(rq, p, flags);
 }
 
@@ -6093,6 +6257,8 @@ void __init sched_init(void)
 
 	psi_init();
 
+	init_uclamp();
+
 	scheduler_running = 1;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58ab597ec88..cecc6baaba93 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -791,6 +791,48 @@ extern void rto_push_irq_work_func(struct irq_work *work);
 #endif
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_UCLAMP_TASK
+/*
+ * struct uclamp_bucket - Utilization clamp bucket
+ * @value: utilization clamp value for tasks on this clamp bucket
+ * @tasks: number of RUNNABLE tasks on this clamp bucket
+ *
+ * Keep track of how many tasks are RUNNABLE for a given utilization
+ * clamp value.
+ */
+struct uclamp_bucket {
+	unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
+	unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
+};
+
+/*
+ * struct uclamp_rq - rq's utilization clamp
+ * @value: currently active clamp values for a rq
+ * @bucket: utilization clamp buckets affecting a rq
+ *
+ * Keep track of RUNNABLE tasks on a rq to aggregate their clamp values.
+ * A clamp value is affecting a rq when there is at least one task RUNNABLE
+ * (or actually running) with that value.
+ *
+ * There are up to UCLAMP_CNT possible different clamp values, currently there
+ * are only two: minimum utilization and maximum utilization.
+ *
+ * All utilization clamping values are MAX aggregated, since:
+ * - for util_min: we want to run the CPU at least at the max of the minimum
+ *   utilization required by its currently RUNNABLE tasks.
+ * - for util_max: we want to allow the CPU to run up to the max of the
+ *   maximum utilization allowed by its currently RUNNABLE tasks.
+ *
+ * Since on each system we expect only a limited number of different
+ * utilization clamp values (UCLAMP_BUCKETS), use a simple array to track
+ * the metrics required to compute all the per-rq utilization clamp values.
+ */
+struct uclamp_rq {
+	unsigned int value;
+	struct uclamp_bucket bucket[UCLAMP_BUCKETS];
+};
+#endif /* CONFIG_UCLAMP_TASK */
+
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -825,6 +867,11 @@ struct rq {
 	unsigned long		nr_load_updates;
 	u64			nr_switches;
 
+#ifdef CONFIG_UCLAMP_TASK
+	/* Utilization clamp values based on CPU's RUNNABLE tasks */
+	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
+#endif
+
 	struct cfs_rq		cfs;
 	struct rt_rq		rt;
 	struct dl_rq		dl;
@@ -1639,6 +1686,10 @@ extern const u32		sched_prio_to_wmult[40];
 struct sched_class {
 	const struct sched_class *next;
 
+#ifdef CONFIG_UCLAMP_TASK
+	int uclamp_enabled;
+#endif
+
 	void (*enqueue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*dequeue_task) (struct rq *rq, struct task_struct *p, int flags);
 	void (*yield_task)   (struct rq *rq);
