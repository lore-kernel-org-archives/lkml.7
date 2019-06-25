Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A5CC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95422146E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HX/UF+Sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfFYIe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:34:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38141 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:34:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8XbLP3531433
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:33:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8XbLP3531433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451619;
        bh=lzniPep40cX/gbv81Iha4mkB835iJDVuAcR5GCLZCYw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HX/UF+SdKm5vHDHdavXwWe0mxvz9N/aENPHYANFgTKM2g7xYMKYu4lb/rMNtkxxIq
         IXCweus6LobPun3nsH40HNUXN4ospjw210lbY5aI1Nit9xPSDTtgk8OzQgcmh3drqh
         KunDTCA7UnKG/Mrk53m8Fn42CnrYZHfGhNJstuqnqXvEioc/vH6kf9+vbPOYTnd6wY
         I1UkUZUL7gn57QOteRemdXwQrvpy5a4mlYpdEqWjEoxs9LmIz/7m4IQv6RRFnb1VLw
         3frvEE19gG6q7uhlXZYaQ3Vqx4kZdDwmajeE9ACb/Vj+2Ka2am571noU37FK+ZhvMW
         VMO0li55qrzww==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8Xb2W3531430;
        Tue, 25 Jun 2019 01:33:37 -0700
Date:   Tue, 25 Jun 2019 01:33:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-a509a7cd79747074a2c018a45bbbc52d1f4aed44@git.kernel.org>
Cc:     morten.rasmussen@arm.com, joelaf@google.com, tglx@linutronix.de,
        vincent.guittot@linaro.org, pjt@google.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, quentin.perret@arm.com,
        peterz@infradead.org, surenb@google.com,
        rafael.j.wysocki@intel.com, smuckle@google.com,
        dietmar.eggemann@arm.com, torvalds@linux-foundation.org,
        juri.lelli@redhat.com, balsini@android.com,
        viresh.kumar@linaro.org, patrick.bellasi@arm.com, tkjos@google.com,
        hpa@zytor.com, tj@kernel.org
Reply-To: quentin.perret@arm.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, pjt@google.com, rafael.j.wysocki@intel.com,
          surenb@google.com, peterz@infradead.org, joelaf@google.com,
          morten.rasmussen@arm.com, vincent.guittot@linaro.org,
          tglx@linutronix.de, juri.lelli@redhat.com,
          dietmar.eggemann@arm.com, smuckle@google.com,
          torvalds@linux-foundation.org, viresh.kumar@linaro.org,
          balsini@android.com, tj@kernel.org, patrick.bellasi@arm.com,
          hpa@zytor.com, tkjos@google.com
In-Reply-To: <20190621084217.8167-7-patrick.bellasi@arm.com>
References: <20190621084217.8167-7-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/uclamp: Extend sched_setattr() to support
 utilization clamping
Git-Commit-ID: a509a7cd79747074a2c018a45bbbc52d1f4aed44
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

Commit-ID:  a509a7cd79747074a2c018a45bbbc52d1f4aed44
Gitweb:     https://git.kernel.org/tip/a509a7cd79747074a2c018a45bbbc52d1f4aed44
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 21 Jun 2019 09:42:07 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:46 +0200

sched/uclamp: Extend sched_setattr() to support utilization clamping

The SCHED_DEADLINE scheduling class provides an advanced and formal
model to define tasks requirements that can translate into proper
decisions for both task placements and frequencies selections. Other
classes have a more simplified model based on the POSIX concept of
priorities.

Such a simple priority based model however does not allow to exploit
most advanced features of the Linux scheduler like, for example, driving
frequencies selection via the schedutil cpufreq governor. However, also
for non SCHED_DEADLINE tasks, it's still interesting to define tasks
properties to support scheduler decisions.

Utilization clamping exposes to user-space a new set of per-task
attributes the scheduler can use as hints about the expected/required
utilization for a task. This allows to implement a "proactive" per-task
frequency control policy, a more advanced policy than the current one
based just on "passive" measured task utilization. For example, it's
possible to boost interactive tasks (e.g. to get better performance) or
cap background tasks (e.g. to be more energy/thermal efficient).

Introduce a new API to set utilization clamping values for a specified
task by extending sched_setattr(), a syscall which already allows to
define task specific properties for different scheduling classes. A new
pair of attributes allows to specify a minimum and maximum utilization
the scheduler can consider for a task.

Do that by validating the required clamp values before and then applying
the required changes using _the_ same pattern already in use for
__setscheduler(). This ensures that the task is re-enqueued with the new
clamp values.

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
Link: https://lkml.kernel.org/r/20190621084217.8167-7-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h            |  9 ++++
 include/uapi/linux/sched.h       | 12 +++++-
 include/uapi/linux/sched/types.h | 66 +++++++++++++++++++++++++----
 kernel/sched/core.c              | 91 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 161 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5485f411e8e1..1113dd4706ae 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -587,6 +587,7 @@ struct sched_dl_entity {
  * @value:		clamp value "assigned" to a se
  * @bucket_id:		bucket index corresponding to the "assigned" value
  * @active:		the se is currently refcounted in a rq's bucket
+ * @user_defined:	the requested clamp value comes from user-space
  *
  * The bucket_id is the index of the clamp bucket matching the clamp value
  * which is pre-computed and stored to avoid expensive integer divisions from
@@ -596,11 +597,19 @@ struct sched_dl_entity {
  * which can be different from the clamp value "requested" from user-space.
  * This allows to know a task is refcounted in the rq's bucket corresponding
  * to the "effective" bucket_id.
+ *
+ * The user_defined bit is set whenever a task has got a task-specific clamp
+ * value requested from userspace, i.e. the system defaults apply to this task
+ * just as a restriction. This allows to relax default clamps when a less
+ * restrictive task-specific value has been requested, thus allowing to
+ * implement a "nice" semantic. For example, a task running with a 20%
+ * default boost can still drop its own boosting to 0%.
  */
 struct uclamp_se {
 	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
 	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
 	unsigned int active		: 1;
+	unsigned int user_defined	: 1;
 };
 #endif /* CONFIG_UCLAMP_TASK */
 
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 58b2368d3634..617bb59aa8ba 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -52,10 +52,20 @@
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
 #define SCHED_FLAG_KEEP_POLICY		0x08
+#define SCHED_FLAG_KEEP_PARAMS		0x10
+#define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
+#define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+
+#define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
+				 SCHED_FLAG_KEEP_PARAMS)
+
+#define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
+				 SCHED_FLAG_UTIL_CLAMP_MAX)
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
-			 SCHED_FLAG_KEEP_POLICY)
+			 SCHED_FLAG_KEEP_ALL		| \
+			 SCHED_FLAG_UTIL_CLAMP)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index 10fbb8031930..c852153ddb0d 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -9,6 +9,7 @@ struct sched_param {
 };
 
 #define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
+#define SCHED_ATTR_SIZE_VER1	56	/* add: util_{min,max} */
 
 /*
  * Extended scheduling parameters data structure.
@@ -21,8 +22,33 @@ struct sched_param {
  * the tasks may be useful for a wide variety of application fields, e.g.,
  * multimedia, streaming, automation and control, and many others.
  *
- * This variant (sched_attr) is meant at describing a so-called
- * sporadic time-constrained task. In such model a task is specified by:
+ * This variant (sched_attr) allows to define additional attributes to
+ * improve the scheduler knowledge about task requirements.
+ *
+ * Scheduling Class Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes specifies the
+ * scheduling policy and relative POSIX attributes:
+ *
+ *  @size		size of the structure, for fwd/bwd compat.
+ *
+ *  @sched_policy	task's scheduling policy
+ *  @sched_nice		task's nice value      (SCHED_NORMAL/BATCH)
+ *  @sched_priority	task's static priority (SCHED_FIFO/RR)
+ *
+ * Certain more advanced scheduling features can be controlled by a
+ * predefined set of flags via the attribute:
+ *
+ *  @sched_flags	for customizing the scheduler behaviour
+ *
+ * Sporadic Time-Constrained Task Attributes
+ * =========================================
+ *
+ * A subset of sched_attr attributes allows to describe a so-called
+ * sporadic time-constrained task.
+ *
+ * In such a model a task is specified by:
  *  - the activation period or minimum instance inter-arrival time;
  *  - the maximum (or average, depending on the actual scheduling
  *    discipline) computation time of all instances, a.k.a. runtime;
@@ -34,14 +60,8 @@ struct sched_param {
  * than the runtime and must be completed by time instant t equal to
  * the instance activation time + the deadline.
  *
- * This is reflected by the actual fields of the sched_attr structure:
+ * This is reflected by the following fields of the sched_attr structure:
  *
- *  @size		size of the structure, for fwd/bwd compat.
- *
- *  @sched_policy	task's scheduling policy
- *  @sched_flags	for customizing the scheduler behaviour
- *  @sched_nice		task's nice value      (SCHED_NORMAL/BATCH)
- *  @sched_priority	task's static priority (SCHED_FIFO/RR)
  *  @sched_deadline	representative of the task's deadline
  *  @sched_runtime	representative of the task's runtime
  *  @sched_period	representative of the task's period
@@ -53,6 +73,29 @@ struct sched_param {
  * As of now, the SCHED_DEADLINE policy (sched_dl scheduling class) is the
  * only user of this new interface. More information about the algorithm
  * available in the scheduling class file or in Documentation/.
+ *
+ * Task Utilization Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes allows to specify the utilization
+ * expected for a task. These attributes allow to inform the scheduler about
+ * the utilization boundaries within which it should schedule the task. These
+ * boundaries are valuable hints to support scheduler decisions on both task
+ * placement and frequency selection.
+ *
+ *  @sched_util_min	represents the minimum utilization
+ *  @sched_util_max	represents the maximum utilization
+ *
+ * Utilization is a value in the range [0..SCHED_CAPACITY_SCALE]. It
+ * represents the percentage of CPU time used by a task when running at the
+ * maximum frequency on the highest capacity CPU of the system. For example, a
+ * 20% utilization task is a task running for 2ms every 10ms at maximum
+ * frequency.
+ *
+ * A task with a min utilization value bigger than 0 is more likely scheduled
+ * on a CPU with a capacity big enough to fit the specified value.
+ * A task with a max utilization value smaller than 1024 is more likely
+ * scheduled on a CPU with no more capacity than the specified value.
  */
 struct sched_attr {
 	__u32 size;
@@ -70,6 +113,11 @@ struct sched_attr {
 	__u64 sched_runtime;
 	__u64 sched_deadline;
 	__u64 sched_period;
+
+	/* Utilization hints */
+	__u32 sched_util_min;
+	__u32 sched_util_max;
+
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6d519f3f9789..e9a669266fa9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -805,10 +805,12 @@ static inline unsigned int uclamp_none(int clamp_id)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline void uclamp_se_set(struct uclamp_se *uc_se, unsigned int value)
+static inline void uclamp_se_set(struct uclamp_se *uc_se,
+				 unsigned int value, bool user_defined)
 {
 	uc_se->value = value;
 	uc_se->bucket_id = uclamp_bucket_id(value);
+	uc_se->user_defined = user_defined;
 }
 
 static inline unsigned int
@@ -1016,11 +1018,11 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 
 	if (old_min != sysctl_sched_uclamp_util_min) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MIN],
-			      sysctl_sched_uclamp_util_min);
+			      sysctl_sched_uclamp_util_min, false);
 	}
 	if (old_max != sysctl_sched_uclamp_util_max) {
 		uclamp_se_set(&uclamp_default[UCLAMP_MAX],
-			      sysctl_sched_uclamp_util_max);
+			      sysctl_sched_uclamp_util_max, false);
 	}
 
 	/*
@@ -1038,6 +1040,42 @@ done:
 	return result;
 }
 
+static int uclamp_validate(struct task_struct *p,
+			   const struct sched_attr *attr)
+{
+	unsigned int lower_bound = p->uclamp_req[UCLAMP_MIN].value;
+	unsigned int upper_bound = p->uclamp_req[UCLAMP_MAX].value;
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
+		lower_bound = attr->sched_util_min;
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
+		upper_bound = attr->sched_util_max;
+
+	if (lower_bound > upper_bound)
+		return -EINVAL;
+	if (upper_bound > SCHED_CAPACITY_SCALE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void __setscheduler_uclamp(struct task_struct *p,
+				  const struct sched_attr *attr)
+{
+	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
+		return;
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
+		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
+			      attr->sched_util_min, true);
+	}
+
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
+			      attr->sched_util_max, true);
+	}
+}
+
 static void uclamp_fork(struct task_struct *p)
 {
 	unsigned int clamp_id;
@@ -1059,11 +1097,11 @@ static void __init init_uclamp(void)
 
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&init_task.uclamp_req[clamp_id],
-			      uclamp_none(clamp_id));
+			      uclamp_none(clamp_id), false);
 	}
 
 	/* System defaults allow max clamp values for both indexes */
-	uclamp_se_set(&uc_max, uclamp_none(UCLAMP_MAX));
+	uclamp_se_set(&uc_max, uclamp_none(UCLAMP_MAX), false);
 	for_each_clamp_id(clamp_id)
 		uclamp_default[clamp_id] = uc_max;
 }
@@ -1071,6 +1109,13 @@ static void __init init_uclamp(void)
 #else /* CONFIG_UCLAMP_TASK */
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
+static inline int uclamp_validate(struct task_struct *p,
+				  const struct sched_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+static void __setscheduler_uclamp(struct task_struct *p,
+				  const struct sched_attr *attr) { }
 static inline void uclamp_fork(struct task_struct *p) { }
 static inline void init_uclamp(void) { }
 #endif /* CONFIG_UCLAMP_TASK */
@@ -4412,6 +4457,13 @@ static void __setscheduler_params(struct task_struct *p,
 static void __setscheduler(struct rq *rq, struct task_struct *p,
 			   const struct sched_attr *attr, bool keep_boost)
 {
+	/*
+	 * If params can't change scheduling class changes aren't allowed
+	 * either.
+	 */
+	if (attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)
+		return;
+
 	__setscheduler_params(p, attr);
 
 	/*
@@ -4549,6 +4601,13 @@ recheck:
 			return retval;
 	}
 
+	/* Update task specific "requested" clamps */
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
+		retval = uclamp_validate(p, attr);
+		if (retval)
+			return retval;
+	}
+
 	/*
 	 * Make sure no PI-waiters arrive (or leave) while we are
 	 * changing the priority of the task:
@@ -4578,6 +4637,8 @@ recheck:
 			goto change;
 		if (dl_policy(policy) && dl_param_changed(p, attr))
 			goto change;
+		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
+			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
 		task_rq_unlock(rq, p, &rf);
@@ -4658,7 +4719,9 @@ change:
 		put_prev_task(rq, p);
 
 	prev_class = p->sched_class;
+
 	__setscheduler(rq, p, attr, pi);
+	__setscheduler_uclamp(p, attr);
 
 	if (queued) {
 		/*
@@ -4834,6 +4897,10 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	if (ret)
 		return -EFAULT;
 
+	if ((attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) &&
+	    size < SCHED_ATTR_SIZE_VER1)
+		return -EINVAL;
+
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
@@ -4903,10 +4970,15 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 	rcu_read_lock();
 	retval = -ESRCH;
 	p = find_process_by_pid(pid);
-	if (p != NULL)
-		retval = sched_setattr(p, &attr);
+	if (likely(p))
+		get_task_struct(p);
 	rcu_read_unlock();
 
+	if (likely(p)) {
+		retval = sched_setattr(p, &attr);
+		put_task_struct(p);
+	}
+
 	return retval;
 }
 
@@ -5057,6 +5129,11 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	else
 		attr.sched_nice = task_nice(p);
 
+#ifdef CONFIG_UCLAMP_TASK
+	attr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
+	attr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
+#endif
+
 	rcu_read_unlock();
 
 	retval = sched_read_attr(uattr, &attr, size);
