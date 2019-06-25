Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3677FC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76A22146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LpEaxbU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfFYIdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:33:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55279 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfFYIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:33:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8WDW33531042
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:32:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8WDW33531042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451535;
        bh=wnXkUdkLEJUuivj6nOOtn1xZSEAs4nCXd38d8/gMKW0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=LpEaxbU6obNpl8yoaJzn3SfuZd00ESjkRZ8VXbspVoPPaKDySQQhCFsgiT5BMc8Pe
         8mKPZOMvEgCQnz9aSvlGIWfADpe7iIxL1l82TMoMmOiPuMBEphYaPV/nL1v/e8aH1e
         PpB3AqKfq0do6zaSqccjjFDKfnovibCvzV6YrreQW9hAAIZIZ0avnYQXE5eLV7OI1N
         UkGnQ5tVEA19+iR6VI/bs8BgmQzDXvQesD3Qu7odudy6S6jb7yXvMfz0WP5maqjoK8
         LuPkygxhNUG/MZAQ0NjrxzAWPhYITMUG0uJhm5T4Y2xtL21SzkhtI+fBI/e1T3HHGf
         bGpivQ5vFL3DQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8WDOO3531039;
        Tue, 25 Jun 2019 01:32:13 -0700
Date:   Tue, 25 Jun 2019 01:32:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-e8f14172c6b11e9a86c65532497087f8eb0f91b1@git.kernel.org>
Cc:     smuckle@google.com, juri.lelli@redhat.com, joelaf@google.com,
        balsini@android.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, tglx@linutronix.de,
        dietmar.eggemann@arm.com, surenb@google.com,
        vincent.guittot@linaro.org, rafael.j.wysocki@intel.com,
        tkjos@google.com, peterz@infradead.org, quentin.perret@arm.com,
        patrick.bellasi@arm.com, hpa@zytor.com, mingo@kernel.org,
        torvalds@linux-foundation.org, morten.rasmussen@arm.com,
        pjt@google.com
Reply-To: torvalds@linux-foundation.org, morten.rasmussen@arm.com,
          hpa@zytor.com, mingo@kernel.org, quentin.perret@arm.com,
          patrick.bellasi@arm.com, peterz@infradead.org,
          rafael.j.wysocki@intel.com, tkjos@google.com, pjt@google.com,
          joelaf@google.com, juri.lelli@redhat.com, smuckle@google.com,
          surenb@google.com, vincent.guittot@linaro.org,
          viresh.kumar@linaro.org, tglx@linutronix.de,
          dietmar.eggemann@arm.com, balsini@android.com, tj@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190621084217.8167-5-patrick.bellasi@arm.com>
References: <20190621084217.8167-5-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/uclamp: Add system default clamps
Git-Commit-ID: e8f14172c6b11e9a86c65532497087f8eb0f91b1
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

Commit-ID:  e8f14172c6b11e9a86c65532497087f8eb0f91b1
Gitweb:     https://git.kernel.org/tip/e8f14172c6b11e9a86c65532497087f8eb0f91b1
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 21 Jun 2019 09:42:05 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:45 +0200

sched/uclamp: Add system default clamps

Tasks without a user-defined clamp value are considered not clamped
and by default their utilization can have any value in the
[0..SCHED_CAPACITY_SCALE] range.

Tasks with a user-defined clamp value are allowed to request any value
in that range, and the required clamp is unconditionally enforced.
However, a "System Management Software" could be interested in limiting
the range of clamp values allowed for all tasks.

Add a privileged interface to define a system default configuration via:

  /proc/sys/kernel/sched_uclamp_util_{min,max}

which works as an unconditional clamp range restriction for all tasks.

With the default configuration, the full SCHED_CAPACITY_SCALE range of
values is allowed for each clamp index. Otherwise, the task-specific
clamp is capped by the corresponding system default value.

Do that by tracking, for each task, the "effective" clamp value and
bucket the task has been refcounted in at enqueue time. This
allows to lazy aggregate "requested" and "system default" values at
enqueue time and simplifies refcounting updates at dequeue time.

The cached bucket ids are used to avoid (relatively) more expensive
integer divisions every time a task is enqueued.

An active flag is used to report when the "effective" value is valid and
thus the task is actually refcounted in the corresponding rq's bucket.

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
Link: https://lkml.kernel.org/r/20190621084217.8167-5-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h        | 10 +++++
 include/linux/sched/sysctl.h | 11 +++++
 kernel/sched/core.c          | 99 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/sysctl.c              | 16 +++++++
 4 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 80235bcd05f2..5485f411e8e1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -586,14 +586,21 @@ struct sched_dl_entity {
  * Utilization clamp for a scheduling entity
  * @value:		clamp value "assigned" to a se
  * @bucket_id:		bucket index corresponding to the "assigned" value
+ * @active:		the se is currently refcounted in a rq's bucket
  *
  * The bucket_id is the index of the clamp bucket matching the clamp value
  * which is pre-computed and stored to avoid expensive integer divisions from
  * the fast path.
+ *
+ * The active bit is set whenever a task has got an "effective" value assigned,
+ * which can be different from the clamp value "requested" from user-space.
+ * This allows to know a task is refcounted in the rq's bucket corresponding
+ * to the "effective" bucket_id.
  */
 struct uclamp_se {
 	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
 	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
+	unsigned int active		: 1;
 };
 #endif /* CONFIG_UCLAMP_TASK */
 
@@ -678,6 +685,9 @@ struct task_struct {
 	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_UCLAMP_TASK
+	/* Clamp values requested for a scheduling entity */
+	struct uclamp_se		uclamp_req[UCLAMP_CNT];
+	/* Effective clamp values used for a scheduling entity */
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 99ce6d728df7..d4f6215ee03f 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -56,6 +56,11 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
 extern unsigned int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 
+#ifdef CONFIG_UCLAMP_TASK
+extern unsigned int sysctl_sched_uclamp_util_min;
+extern unsigned int sysctl_sched_uclamp_util_max;
+#endif
+
 #ifdef CONFIG_CFS_BANDWIDTH
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
 #endif
@@ -75,6 +80,12 @@ extern int sched_rt_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos);
 
+#ifdef CONFIG_UCLAMP_TASK
+extern int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
+				       void __user *buffer, size_t *lenp,
+				       loff_t *ppos);
+#endif
+
 extern int sysctl_numa_balancing(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp,
 				 loff_t *ppos);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2dde735635ec..b74de86b68c7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -773,6 +773,14 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 }
 
 #ifdef CONFIG_UCLAMP_TASK
+/* Max allowed minimum utilization */
+unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
+
+/* Max allowed maximum utilization */
+unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
+
+/* All clamps are required to be less or equal than these values */
+static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
 /* Integer rounded range for each bucket */
 #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
@@ -851,6 +859,25 @@ unsigned int uclamp_rq_max_value(struct rq *rq, unsigned int clamp_id,
 	return uclamp_idle_value(rq, clamp_id, clamp_value);
 }
 
+/*
+ * The effective clamp bucket index of a task depends on, by increasing
+ * priority:
+ * - the task specific clamp value, when explicitly requested from userspace
+ * - the system default clamp value, defined by the sysadmin
+ */
+static inline struct uclamp_se
+uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
+{
+	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
+	struct uclamp_se uc_max = uclamp_default[clamp_id];
+
+	/* System default restrictions always apply */
+	if (unlikely(uc_req.value > uc_max.value))
+		return uc_max;
+
+	return uc_req;
+}
+
 /*
  * When a task is enqueued on a rq, the clamp bucket currently defined by the
  * task's uclamp::bucket_id is refcounted on that rq. This also immediately
@@ -870,8 +897,12 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 
 	lockdep_assert_held(&rq->lock);
 
+	/* Update task effective clamp */
+	p->uclamp[clamp_id] = uclamp_eff_get(p, clamp_id);
+
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
 	bucket->tasks++;
+	uc_se->active = true;
 
 	uclamp_idle_reset(rq, clamp_id, uc_se->value);
 
@@ -910,6 +941,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	SCHED_WARN_ON(!bucket->tasks);
 	if (likely(bucket->tasks))
 		bucket->tasks--;
+	uc_se->active = false;
 
 	/*
 	 * Keep "local max aggregation" simple and accept to (possibly)
@@ -958,8 +990,65 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
 
+int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp,
+				loff_t *ppos)
+{
+	int old_min, old_max;
+	static DEFINE_MUTEX(mutex);
+	int result;
+
+	mutex_lock(&mutex);
+	old_min = sysctl_sched_uclamp_util_min;
+	old_max = sysctl_sched_uclamp_util_max;
+
+	result = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (result)
+		goto undo;
+	if (!write)
+		goto done;
+
+	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
+	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
+		result = -EINVAL;
+		goto undo;
+	}
+
+	if (old_min != sysctl_sched_uclamp_util_min) {
+		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
+			      sysctl_sched_uclamp_util_min);
+	}
+	if (old_max != sysctl_sched_uclamp_util_max) {
+		uclamp_se_set(&uclamp_default[UCLAMP_MAX],
+			      sysctl_sched_uclamp_util_max);
+	}
+
+	/*
+	 * Updating all the RUNNABLE task is expensive, keep it simple and do
+	 * just a lazy update at each next enqueue time.
+	 */
+	goto done;
+
+undo:
+	sysctl_sched_uclamp_util_min = old_min;
+	sysctl_sched_uclamp_util_max = old_max;
+done:
+	mutex_unlock(&mutex);
+
+	return result;
+}
+
+static void uclamp_fork(struct task_struct *p)
+{
+	unsigned int clamp_id;
+
+	for_each_clamp_id(clamp_id)
+		p->uclamp[clamp_id].active = false;
+}
+
 static void __init init_uclamp(void)
 {
+	struct uclamp_se uc_max = {};
 	unsigned int clamp_id;
 	int cpu;
 
@@ -969,14 +1058,20 @@ static void __init init_uclamp(void)
 	}
 
 	for_each_clamp_id(clamp_id) {
-		uclamp_se_set(&init_task.uclamp[clamp_id],
+		uclamp_se_set(&init_task.uclamp_req[clamp_id],
 			      uclamp_none(clamp_id));
 	}
+
+	/* System defaults allow max clamp values for both indexes */
+	uclamp_se_set(&uc_max, uclamp_none(UCLAMP_MAX));
+	for_each_clamp_id(clamp_id)
+		uclamp_default[clamp_id] = uc_max;
 }
 
 #else /* CONFIG_UCLAMP_TASK */
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
+static inline void uclamp_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
 
@@ -2545,6 +2640,8 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 */
 	p->prio = current->normal_prio;
 
+	uclamp_fork(p);
+
 	/*
 	 * Revert to default priority/policy on fork if requested.
 	 */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1beca96fb625..1c1ad1e14f21 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -452,6 +452,22 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sched_rr_handler,
 	},
+#ifdef CONFIG_UCLAMP_TASK
+	{
+		.procname	= "sched_util_clamp_min",
+		.data		= &sysctl_sched_uclamp_util_min,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sched_uclamp_handler,
+	},
+	{
+		.procname	= "sched_util_clamp_max",
+		.data		= &sysctl_sched_uclamp_util_max,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sysctl_sched_uclamp_handler,
+	},
+#endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{
 		.procname	= "sched_autogroup_enabled",
