Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F36C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF782053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfICIcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:32:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59210 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfICIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:31:56 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54Dm-0002eV-0y; Tue, 03 Sep 2019 10:31:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7A61F1C0DDE;
        Tue,  3 Sep 2019 10:31:25 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:25 -0000
From:   "tip-bot2 for Patrick Bellasi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Extend CPU's cgroup controller
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michal Koutny <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>,
        Alessio Balsini <balsini@android.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190822132811.31294-2-patrick.bellasi@arm.com>
References: <20190822132811.31294-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Message-ID: <156749948535.12878.5714807135770901163.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2480c093130f64ac3a410504fa8b3db1fc4b87ce
Gitweb:        https://git.kernel.org/tip/2480c093130f64ac3a410504fa8b3db1fc4b87ce
Author:        Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate:    Thu, 22 Aug 2019 14:28:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:17:37 +02:00

sched/uclamp: Extend CPU's cgroup controller

The cgroup CPU bandwidth controller allows to assign a specified
(maximum) bandwidth to the tasks of a group. However this bandwidth is
defined and enforced only on a temporal base, without considering the
actual frequency a CPU is running on. Thus, the amount of computation
completed by a task within an allocated bandwidth can be very different
depending on the actual frequency the CPU is running that task.
The amount of computation can be affected also by the specific CPU a
task is running on, especially when running on asymmetric capacity
systems like Arm's big.LITTLE.

With the availability of schedutil, the scheduler is now able
to drive frequency selections based on actual task utilization.
Moreover, the utilization clamping support provides a mechanism to
bias the frequency selection operated by schedutil depending on
constraints assigned to the tasks currently RUNNABLE on a CPU.

Giving the mechanisms described above, it is now possible to extend the
cpu controller to specify the minimum (or maximum) utilization which
should be considered for tasks RUNNABLE on a cpu.
This makes it possible to better defined the actual computational
power assigned to task groups, thus improving the cgroup CPU bandwidth
controller which is currently based just on time constraints.

Extend the CPU controller with a couple of new attributes uclamp.{min,max}
which allow to enforce utilization boosting and capping for all the
tasks in a group.

Specifically:

- uclamp.min: defines the minimum utilization which should be considered
	      i.e. the RUNNABLE tasks of this group will run at least at a
	      minimum frequency which corresponds to the uclamp.min
	      utilization

- uclamp.max: defines the maximum utilization which should be considered
	      i.e. the RUNNABLE tasks of this group will run up to a
	      maximum frequency which corresponds to the uclamp.max
	      utilization

These attributes:

a) are available only for non-root nodes, both on default and legacy
   hierarchies, while system wide clamps are defined by a generic
   interface which does not depends on cgroups. This system wide
   interface enforces constraints on tasks in the root node.

b) enforce effective constraints at each level of the hierarchy which
   are a restriction of the group requests considering its parent's
   effective constraints. Root group effective constraints are defined
   by the system wide interface.
   This mechanism allows each (non-root) level of the hierarchy to:
   - request whatever clamp values it would like to get
   - effectively get only up to the maximum amount allowed by its parent

c) have higher priority than task-specific clamps, defined via
   sched_setattr(), thus allowing to control and restrict task requests.

Add two new attributes to the cpu controller to collect "requested"
clamp values. Allow that at each non-root level of the hierarchy.
Keep it simple by not caring now about "effective" values computation
and propagation along the hierarchy.

Update sysctl_sched_uclamp_handler() to use the newly introduced
uclamp_mutex so that we serialize system default updates with cgroup
relate updates.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michal Koutny <mkoutny@suse.com>
Acked-by: Tejun Heo <tj@kernel.org>
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20190822132811.31294-2-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  34 ++++-
 init/Kconfig                            |  22 +++-
 kernel/sched/core.c                     | 193 ++++++++++++++++++++++-
 kernel/sched/sched.h                    |   8 +-
 4 files changed, 253 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3b29005..5f1c266 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -951,6 +951,13 @@ controller implements weight and absolute bandwidth limit models for
 normal scheduling policy and absolute bandwidth allocation model for
 realtime scheduling policy.
 
+In all the above models, cycles distribution is defined only on a temporal
+base and it does not account for the frequency at which tasks are executed.
+The (optional) utilization clamping support allows to hint the schedutil
+cpufreq governor about the minimum desired frequency which should always be
+provided by a CPU, as well as the maximum desired frequency, which should not
+be exceeded by a CPU.
+
 WARNING: cgroup2 doesn't yet support control of realtime processes and
 the cpu controller can only be enabled when all RT processes are in
 the root cgroup.  Be aware that system management software may already
@@ -1016,6 +1023,33 @@ All time durations are in microseconds.
 	Shows pressure stall information for CPU. See
 	Documentation/accounting/psi.rst for details.
 
+  cpu.uclamp.min
+        A read-write single value file which exists on non-root cgroups.
+        The default is "0", i.e. no utilization boosting.
+
+        The requested minimum utilization (protection) as a percentage
+        rational number, e.g. 12.34 for 12.34%.
+
+        This interface allows reading and setting minimum utilization clamp
+        values similar to the sched_setattr(2). This minimum utilization
+        value is used to clamp the task specific minimum utilization clamp.
+
+        The requested minimum utilization (protection) is always capped by
+        the current value for the maximum utilization (limit), i.e.
+        `cpu.uclamp.max`.
+
+  cpu.uclamp.max
+        A read-write single value file which exists on non-root cgroups.
+        The default is "max". i.e. no utilization capping
+
+        The requested maximum utilization (limit) as a percentage rational
+        number, e.g. 98.76 for 98.76%.
+
+        This interface allows reading and setting maximum utilization clamp
+        values similar to the sched_setattr(2). This maximum utilization
+        value is used to clamp the task specific maximum utilization clamp.
+
+
 
 Memory
 ------
diff --git a/init/Kconfig b/init/Kconfig
index bd7d650..ac285cf 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -928,6 +928,28 @@ config RT_GROUP_SCHED
 
 endif #CGROUP_SCHED
 
+config UCLAMP_TASK_GROUP
+	bool "Utilization clamping per group of tasks"
+	depends on CGROUP_SCHED
+	depends on UCLAMP_TASK
+	default n
+	help
+	  This feature enables the scheduler to track the clamped utilization
+	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
+
+	  When this option is enabled, the user can specify a min and max
+	  CPU bandwidth which is allowed for each single task in a group.
+	  The max bandwidth allows to clamp the maximum frequency a task
+	  can use, while the min bandwidth allows to define a minimum
+	  frequency a task will always use.
+
+	  When task group based utilization clamping is enabled, an eventually
+	  specified task-specific clamp value is constrained by the cgroup
+	  specified clamp value. Both minimum and maximum task clamping cannot
+	  be bigger than the corresponding clamping defined at task group level.
+
+	  If in doubt, say N.
+
 config CGROUP_PIDS
 	bool "PIDs controller"
 	help
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a666185..c186abe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -773,6 +773,18 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 }
 
 #ifdef CONFIG_UCLAMP_TASK
+/*
+ * Serializes updates of utilization clamp values
+ *
+ * The (slow-path) user-space triggers utilization clamp value updates which
+ * can require updates on (fast-path) scheduler's data structures used to
+ * support enqueue/dequeue operations.
+ * While the per-CPU rq lock protects fast-path update operations, user-space
+ * requests are serialized using a mutex to reduce the risk of conflicting
+ * updates or API abuses.
+ */
+static DEFINE_MUTEX(uclamp_mutex);
+
 /* Max allowed minimum utilization */
 unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
 
@@ -1010,10 +1022,9 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				loff_t *ppos)
 {
 	int old_min, old_max;
-	static DEFINE_MUTEX(mutex);
 	int result;
 
-	mutex_lock(&mutex);
+	mutex_lock(&uclamp_mutex);
 	old_min = sysctl_sched_uclamp_util_min;
 	old_max = sysctl_sched_uclamp_util_max;
 
@@ -1048,7 +1059,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	sysctl_sched_uclamp_util_min = old_min;
 	sysctl_sched_uclamp_util_max = old_max;
 done:
-	mutex_unlock(&mutex);
+	mutex_unlock(&uclamp_mutex);
 
 	return result;
 }
@@ -1137,6 +1148,8 @@ static void __init init_uclamp(void)
 	unsigned int clamp_id;
 	int cpu;
 
+	mutex_init(&uclamp_mutex);
+
 	for_each_possible_cpu(cpu) {
 		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
 		cpu_rq(cpu)->uclamp_flags = 0;
@@ -1149,8 +1162,12 @@ static void __init init_uclamp(void)
 
 	/* System defaults allow max clamp values for both indexes */
 	uclamp_se_set(&uc_max, uclamp_none(UCLAMP_MAX), false);
-	for_each_clamp_id(clamp_id)
+	for_each_clamp_id(clamp_id) {
 		uclamp_default[clamp_id] = uc_max;
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+		root_task_group.uclamp_req[clamp_id] = uc_max;
+#endif
+	}
 }
 
 #else /* CONFIG_UCLAMP_TASK */
@@ -6798,6 +6815,19 @@ void ia64_set_curr_task(int cpu, struct task_struct *p)
 /* task_group_lock serializes the addition/removal of task groups */
 static DEFINE_SPINLOCK(task_group_lock);
 
+static inline void alloc_uclamp_sched_group(struct task_group *tg,
+					    struct task_group *parent)
+{
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	int clamp_id;
+
+	for_each_clamp_id(clamp_id) {
+		uclamp_se_set(&tg->uclamp_req[clamp_id],
+			      uclamp_none(clamp_id), false);
+	}
+#endif
+}
+
 static void sched_free_group(struct task_group *tg)
 {
 	free_fair_sched_group(tg);
@@ -6821,6 +6851,8 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	alloc_uclamp_sched_group(tg, parent);
+
 	return tg;
 
 err:
@@ -7037,6 +7069,131 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 		sched_move_task(task);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+
+/*
+ * Integer 10^N with a given N exponent by casting to integer the literal "1eN"
+ * C expression. Since there is no way to convert a macro argument (N) into a
+ * character constant, use two levels of macros.
+ */
+#define _POW10(exp) ((unsigned int)1e##exp)
+#define POW10(exp) _POW10(exp)
+
+struct uclamp_request {
+#define UCLAMP_PERCENT_SHIFT	2
+#define UCLAMP_PERCENT_SCALE	(100 * POW10(UCLAMP_PERCENT_SHIFT))
+	s64 percent;
+	u64 util;
+	int ret;
+};
+
+static inline struct uclamp_request
+capacity_from_percent(char *buf)
+{
+	struct uclamp_request req = {
+		.percent = UCLAMP_PERCENT_SCALE,
+		.util = SCHED_CAPACITY_SCALE,
+		.ret = 0,
+	};
+
+	buf = strim(buf);
+	if (strcmp(buf, "max")) {
+		req.ret = cgroup_parse_float(buf, UCLAMP_PERCENT_SHIFT,
+					     &req.percent);
+		if (req.ret)
+			return req;
+		if (req.percent > UCLAMP_PERCENT_SCALE) {
+			req.ret = -ERANGE;
+			return req;
+		}
+
+		req.util = req.percent << SCHED_CAPACITY_SHIFT;
+		req.util = DIV_ROUND_CLOSEST_ULL(req.util, UCLAMP_PERCENT_SCALE);
+	}
+
+	return req;
+}
+
+static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
+				size_t nbytes, loff_t off,
+				enum uclamp_id clamp_id)
+{
+	struct uclamp_request req;
+	struct task_group *tg;
+
+	req = capacity_from_percent(buf);
+	if (req.ret)
+		return req.ret;
+
+	mutex_lock(&uclamp_mutex);
+	rcu_read_lock();
+
+	tg = css_tg(of_css(of));
+	if (tg->uclamp_req[clamp_id].value != req.util)
+		uclamp_se_set(&tg->uclamp_req[clamp_id], req.util, false);
+
+	/*
+	 * Because of not recoverable conversion rounding we keep track of the
+	 * exact requested value
+	 */
+	tg->uclamp_pct[clamp_id] = req.percent;
+
+	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
+
+	return nbytes;
+}
+
+static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
+				    char *buf, size_t nbytes,
+				    loff_t off)
+{
+	return cpu_uclamp_write(of, buf, nbytes, off, UCLAMP_MIN);
+}
+
+static ssize_t cpu_uclamp_max_write(struct kernfs_open_file *of,
+				    char *buf, size_t nbytes,
+				    loff_t off)
+{
+	return cpu_uclamp_write(of, buf, nbytes, off, UCLAMP_MAX);
+}
+
+static inline void cpu_uclamp_print(struct seq_file *sf,
+				    enum uclamp_id clamp_id)
+{
+	struct task_group *tg;
+	u64 util_clamp;
+	u64 percent;
+	u32 rem;
+
+	rcu_read_lock();
+	tg = css_tg(seq_css(sf));
+	util_clamp = tg->uclamp_req[clamp_id].value;
+	rcu_read_unlock();
+
+	if (util_clamp == SCHED_CAPACITY_SCALE) {
+		seq_puts(sf, "max\n");
+		return;
+	}
+
+	percent = tg->uclamp_pct[clamp_id];
+	percent = div_u64_rem(percent, POW10(UCLAMP_PERCENT_SHIFT), &rem);
+	seq_printf(sf, "%llu.%0*u\n", percent, UCLAMP_PERCENT_SHIFT, rem);
+}
+
+static int cpu_uclamp_min_show(struct seq_file *sf, void *v)
+{
+	cpu_uclamp_print(sf, UCLAMP_MIN);
+	return 0;
+}
+
+static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
+{
+	cpu_uclamp_print(sf, UCLAMP_MAX);
+	return 0;
+}
+#endif /* CONFIG_UCLAMP_TASK_GROUP */
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
@@ -7382,6 +7539,20 @@ static struct cftype cpu_legacy_files[] = {
 		.write_u64 = cpu_rt_period_write_uint,
 	},
 #endif
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	{
+		.name = "uclamp.min",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_uclamp_min_show,
+		.write = cpu_uclamp_min_write,
+	},
+	{
+		.name = "uclamp.max",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_uclamp_max_show,
+		.write = cpu_uclamp_max_write,
+	},
+#endif
 	{ }	/* Terminate */
 };
 
@@ -7549,6 +7720,20 @@ static struct cftype cpu_files[] = {
 		.write = cpu_max_write,
 	},
 #endif
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	{
+		.name = "uclamp.min",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_uclamp_min_show,
+		.write = cpu_uclamp_min_write,
+	},
+	{
+		.name = "uclamp.max",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_uclamp_max_show,
+		.write = cpu_uclamp_max_write,
+	},
+#endif
 	{ }	/* terminate */
 };
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7111e3a..ae1be61 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -391,6 +391,14 @@ struct task_group {
 #endif
 
 	struct cfs_bandwidth	cfs_bandwidth;
+
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	/* The two decimal precision [%] value requested from user-space */
+	unsigned int		uclamp_pct[UCLAMP_CNT];
+	/* Clamp values requested for a task group */
+	struct uclamp_se	uclamp_req[UCLAMP_CNT];
+#endif
+
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
