Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B32C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56DD2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7LR6/KS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404554AbfIFJea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:34:30 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:53034 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392931AbfIFJe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:34:29 -0400
Received: by mail-vs1-f73.google.com with SMTP id x21so637830vsx.19
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=sLLDi7v7pAN3DNFmAbZ7OjhlXKvEVie9nHatva3Nu6g=;
        b=U7LR6/KSWcfWppOYC3O36I12tqfK6mRu35R+5pjc5baOBaMUgiMW2lpSxDr5u/ZIhz
         z+PjdnREvKJJwSvU233bAE0oZ7sECDTZGhI2gI6Ol2rW0b/U55IIuNCKHLJW/9PULouz
         WViuNQDVz/XL1WfSXpm34bc9SYrFlRxnSuvKCn9IuRjRrx5YArU/Lax+7Uxa69wvw4a6
         RuYncG14MYJKoQlEenmYz5Yy8ODKbZ2jq4q0ldH2S3+vF9/6Ies7fT6JXzeaLiI+mVsa
         VCG7sLN9Kg4Wo3mwp6RpJKqQErREmjWPtS7ti+ZlkKE8As5gyt8PVfMnN3rMUjfXjLkS
         /2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=sLLDi7v7pAN3DNFmAbZ7OjhlXKvEVie9nHatva3Nu6g=;
        b=eEaUhV7A6gbH8BVhuFzUwZlHwpM6ml9TpKEqokAzVizMi4YgP7lho0fW+muTA/J4t1
         zkbYPdZ97ypQYyhXKV2AYxOYqG5q/nLPO2vsnGPqRBk/awkPWD5yiHb8cOoSRKfXQUR1
         ecAizTxkJKyHG4aAYsdi6NQkLXao97/qSuhnY9znA01X6BItreYyvj20YDinbMMYYNr+
         XFs/a7a7Wa3LKfAQ+qZiV0VVkXFGOPYNt9lk+6zMzrUPr6C9ae8EE2a1czGPypUpV8wD
         ObfiSO1pLmDpljiXXnV6mDiGidGmBY0wLa2pqhA7G+T4gRSiw5uYHNeMNt9w2OJv9EwN
         pdpw==
X-Gm-Message-State: APjAAAUsXsk7bULhhKE7CSCoEG/S69x5Wo0tAilx+MN/MNE9pfIdhHJ3
        VYLRqwj19HA+lN+iOiuccHaiNaSgDLhx2/rAFrqBm61QZmQjW8TyQP0hUp0f7PW5YvrkdiCci+B
        AUdtTOrqzJdAHC9zBMz0nwjLVrfZpSnQ0UWA2l+AR2SP1a9TariRgeespD4oBCA==
X-Google-Smtp-Source: APXvYqzn/UT8tpqC6eN57wHCP4/1Odlqtaeiq5SdieAQg2ZiBZykwkTJJf9EEFI0984QZXBv1kLlHC8=
X-Received: by 2002:ab0:63d6:: with SMTP id i22mr3815463uap.134.1567762466656;
 Fri, 06 Sep 2019 02:34:26 -0700 (PDT)
Date:   Fri,  6 Sep 2019 02:34:12 -0700
In-Reply-To: <20190906093412.233463-1-xii@google.com>
Message-Id: <20190906093412.233463-2-xii@google.com>
Mime-Version: 1.0
References: <20190906093412.233463-1-xii@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH 1/1] sched: Add micro quanta scheduling class
From:   Xi Wang <xii@google.com>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        linux-doc@vger.kernel.org, Xi Wang <xii@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Micro quanta is a lightweight scheduling class designed for
microsecond level scheduling intervals. It provides a more flexible
way to share cores between highly latency sensitive tasks with other
tasks - limiting the cpu share of latency sensitive tasks and
maintaining low scheduling latency at the same time.

The scheduling policy is similar to real-time group scheduling period
and runtime. There is no group support but more frequent context
switching is possible. Tasks running with 2us scheduling period and
1us runtime has been demonstrated. The practical range of microq
scheduling period is expected to be 10us ~ 1000us.

Cc: Paul Turner <pjt@google.com>
Cc: Ben Segall <bsegall@google.com>'
Signed-off-by: Xi Wang <xii@google.com>
---
 Documentation/scheduler/sched-microq.txt |  72 +++
 include/linux/sched.h                    |  12 +
 include/linux/sched/sysctl.h             |  12 +
 include/uapi/linux/sched.h               |   1 +
 init/Kconfig                             |  13 +
 kernel/sched/Makefile                    |   1 +
 kernel/sched/core.c                      | 138 ++++-
 kernel/sched/debug.c                     |  28 +
 kernel/sched/fair.c                      |   4 +-
 kernel/sched/microq.c                    | 750 +++++++++++++++++++++++
 kernel/sched/pelt.c                      |  30 +-
 kernel/sched/pelt.h                      |   6 +
 kernel/sched/rt.c                        |   6 +-
 kernel/sched/sched.h                     |  63 +-
 kernel/sysctl.c                          |  23 +
 15 files changed, 1135 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/scheduler/sched-microq.txt
 create mode 100644 kernel/sched/microq.c

diff --git a/Documentation/scheduler/sched-microq.txt b/Documentation/sched=
uler/sched-microq.txt
new file mode 100644
index 000000000000..b3deefdc265f
--- /dev/null
+++ b/Documentation/scheduler/sched-microq.txt
@@ -0,0 +1,72 @@
+Micro Quanta Scheduling
+
+Micro quanta (microq) is a lightweight scheduling class for microsecond le=
vel
+scheduling intervals. It can simultaneously provide low scheduling latency=
 for
+real time tasks while causing no starvation or excessive latency for norma=
l
+tasks. It is a safe (avoiding many of the priority inversion problems etc.=
) and
+high performance way to share a cpu.
+
+Main characteristics:
+
+ - A sample configuration is one microq task configured to run with 16us
+runtime and 20us period. Most of the time the microq task won=E2=80=99t wa=
it for more
+than 20 - 16 =3D 4us. kworker and ksoftirqd tasks under cfs can still get =
4us
+every 20us.
+
+ - The scheduling policy between microq class and cfs class is weighted fa=
ir
+queuing with latency guarantees for microq.
+
+ - No priority among microq tasks. Multiple microq tasks on the same cpu w=
ill
+round robin at tick interval.
+
+ - The microq class is work conserving. If no other task is running on a c=
pu, a
+microq task can take all cpu cycles regardless of runtime/period bandwidth
+allocation.
+
+ - Simple push load balancing only.
+
+ - No cgroup support.
+
+ - Driven by per cpu hrtimers.
+
+There are similarities between microq and rt group scheduling or between m=
icroq
+and SCHED_DEADLINE. Below is a quick comparison:
+
+ - rt group scheduling uses both tick and a global hrtimer for bandwidth
+control, which doesn=E2=80=99t work well for below tick interval. If rt ta=
sks are
+throttled on many cpus the global hrtimer becomes a bottleneck. SCHED_DEAD=
LINE
+appears to have similar behaviors. microq uses per cpu hrtimers.
+
+ - microq is based on fair queuing (or somewhat equivalent to SCHED_DEADLI=
NE
+with period =3D=3D deadline), not fixed scheduling intervals. A blocked ta=
sk can
+accumulate credit similar to cfs or SCHED_DEADLINE, but different from fix=
ed
+intervals of rt group scheduling.
+
+ - No priority among microq threads.
+
+ - microq is work conserving. rt group scheduling has fixed bandwidth
+allocation.
+
+ - Compared to SCHED_DEADLINE, microq is a lightweight scheduling class wi=
th a
+very limited feature set, but also with less restrictions, e.g. no admissi=
on
+control or cpu affinity requirements.
+
+
+Usage and expected behaviors:
+
+microq bandwidth can be controlled with either global or per task bandwidt=
h
+parameters. If none of the microq tasks on a cpu specifies the bandwidth
+parameters, global parameters take effect.
+
+When there are multiple microq tasks on a run queue, the bandwidth paramet=
ers
+of the task with shortest period takes effect. (Note runtime in effect is =
not
+the sum of microq tasks, it is exactly the runtime requested by one microq
+task.)
+
+When there are multiple microq tasks on the same cpu, they will round-robi=
n at
+tick interval. The microq scheduling period is likely shorter than the tic=
k
+interval, thus the scheduler can switch between one microq task and a cfs =
task
+several times before switching to another microq task. The scheduling late=
ncy
+of a microq tasks is well shielded from cfs tasks but not from another mic=
roq
+task. Cooperative multitasking might be an option for some applications if
+multiple microq tasks on the same cpu is needed.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8dc1811487f5..3c741225d057 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -578,6 +578,15 @@ struct sched_dl_entity {
 	struct hrtimer inactive_timer;
 };
=20
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+struct sched_microq_entity {
+	struct list_head run_list;
+	int sched_period;
+	int sched_runtime;
+	unsigned int time_slice;
+};
+#endif
+
 #ifdef CONFIG_UCLAMP_TASK
 /* Number of utilization clamp buckets (shorter alias) */
 #define UCLAMP_BUCKETS CONFIG_UCLAMP_BUCKETS_COUNT
@@ -688,6 +697,9 @@ struct task_struct {
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+	struct sched_microq_entity microq;
+#endif
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
 #endif
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index d4f6215ee03f..f1b8a0a23504 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -56,6 +56,13 @@ int sched_proc_update_handler(struct ctl_table *table, i=
nt write,
 extern unsigned int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
=20
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+/* micro quanta period and runtime */
+extern int sysctl_sched_microq_period;
+extern int sysctl_sched_microq_runtime;
+extern int sched_microq_timeslice;
+#endif
+
 #ifdef CONFIG_UCLAMP_TASK
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
@@ -101,4 +108,9 @@ extern int sched_energy_aware_handler(struct ctl_table =
*table, int write,
 				 loff_t *ppos);
 #endif
=20
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+extern int sched_microq_proc_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *lenp, loff_t *ppos);
+#endif
+
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index b3105ac1381a..71b4af023f17 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -57,6 +57,7 @@ struct clone_args {
 /* SCHED_ISO: reserved but not implemented yet */
 #define SCHED_IDLE		5
 #define SCHED_DEADLINE		6
+#define SCHED_MICROQ		7
=20
 /* Can be ORed in to make sure the process is reverted back to SCHED_NORMA=
L on fork */
 #define SCHED_RESET_ON_FORK     0x40000000
diff --git a/init/Kconfig b/init/Kconfig
index d3ad48272924..f544c2d6ded9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2126,6 +2126,19 @@ config PADATA
 	depends on SMP
 	bool
=20
+config SCHED_CLASS_MICROQ
+	bool "Micro Quanta scheduling class"
+	default y
+	help
+	  Micro quanta is a lightweight scheduling class designed for
+	  microsecond level scheduling intervals. It provides a more flexible
+	  way to share cores between highly latency sensitive tasks with other
+	  tasks - limiting the cpu share of latency sensitive tasks and
+	  maintaining low scheduling latency at the same time. The scheduling
+	  policy is similar to real-time group scheduling period and runtime.
+	  There is no group support but more frequent context switching
+	  is possible.
+
 config ASN1
 	tristate
 	help
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 21fb5a5662b5..76255ef8636c 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) +=3D cpufreq_schedut=
il.o
 obj-$(CONFIG_MEMBARRIER) +=3D membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) +=3D isolation.o
 obj-$(CONFIG_PSI) +=3D psi.o
+obj-$(CONFIG_SCHED_CLASS_MICROQ) +=3D microq.o
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa43ce3962e7..c8556169043c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1236,7 +1236,7 @@ static inline int normal_prio(struct task_struct *p)
=20
 	if (task_has_dl_policy(p))
 		prio =3D MAX_DL_PRIO-1;
-	else if (task_has_rt_policy(p))
+	else if (task_has_rt_fiforr_policy(p))
 		prio =3D MAX_RT_PRIO-1 - p->rt_priority;
 	else
 		prio =3D __normal_prio(p);
@@ -4475,6 +4475,36 @@ static struct task_struct *find_process_by_pid(pid_t=
 pid)
  */
 #define SETPARAM_POLICY	-1
=20
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+
+void microq_adjust_bandwidth(struct task_struct *p);
+
+static inline int microq_period_from_attr(const struct sched_attr *attr)
+{
+	int period =3D (unsigned int)attr->sched_priority >> 16;
+	 /* ffff means undefined, otherwise convert from us to ns */
+	return period =3D=3D 0xffff ? MICROQ_BANDWIDTH_UNDEFINED : period * 1000;
+}
+
+static inline int microq_runtime_from_attr(const struct sched_attr *attr)
+{
+	int runtime =3D (unsigned int)attr->sched_priority & 0xffff;
+	/* ffff means undefined, otherwise convert from us to ns */
+	return runtime =3D=3D 0xffff ? MICROQ_BANDWIDTH_UNDEFINED : runtime * 100=
0;
+}
+
+static inline int microq_pack_bandwidth(const struct task_struct *p)
+{
+	int period =3D p->microq.sched_period;
+	int runtime =3D p->microq.sched_runtime;
+
+	period =3D (period =3D=3D -1) ? 0xffff : period / 1000;
+	runtime =3D (runtime =3D=3D -1) ? 0xffff : runtime / 1000;
+	return (period << 16) | runtime;
+}
+
+#endif
+
 static void __setscheduler_params(struct task_struct *p,
 		const struct sched_attr *attr)
 {
@@ -4485,6 +4515,17 @@ static void __setscheduler_params(struct task_struct=
 *p,
=20
 	p->policy =3D policy;
=20
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+	if (microq_policy(policy)) {
+		p->microq.sched_period =3D microq_period_from_attr(attr);
+		p->microq.sched_runtime =3D microq_runtime_from_attr(attr);
+		p->rt_priority =3D DEFAULT_MICROQ_RT_PRIORITY;
+		p->normal_prio =3D normal_prio(p);
+		set_load_weight(p, true);
+		return;
+	}
+#endif
+
 	if (dl_policy(policy))
 		__setparam_dl(p, attr);
 	else if (fair_policy(policy))
@@ -4521,6 +4562,13 @@ static void __setscheduler(struct rq *rq, struct tas=
k_struct *p,
 	if (keep_boost)
 		p->prio =3D rt_effective_prio(p, p->prio);
=20
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+	if (microq_policy(attr->sched_policy)) {
+		p->sched_class =3D &microq_sched_class;
+		return;
+	}
+#endif
+
 	if (dl_prio(p->prio))
 		p->sched_class =3D &dl_sched_class;
 	else if (rt_prio(p->prio))
@@ -4576,17 +4624,35 @@ static int __sched_setscheduler(struct task_struct =
*p,
 	if (attr->sched_flags & ~(SCHED_FLAG_ALL | SCHED_FLAG_SUGOV))
 		return -EINVAL;
=20
-	/*
-	 * Valid priorities for SCHED_FIFO and SCHED_RR are
-	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL,
-	 * SCHED_BATCH and SCHED_IDLE is 0.
-	 */
-	if ((p->mm && attr->sched_priority > MAX_USER_RT_PRIO-1) ||
-	    (!p->mm && attr->sched_priority > MAX_RT_PRIO-1))
-		return -EINVAL;
-	if ((dl_policy(policy) && !__checkparam_dl(attr)) ||
-	    (rt_policy(policy) !=3D (attr->sched_priority !=3D 0)))
-		return -EINVAL;
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+	if (microq_policy(policy)) {
+		int period =3D microq_period_from_attr(attr);
+		int runtime =3D microq_runtime_from_attr(attr);
+
+		if (period =3D=3D MICROQ_BANDWIDTH_UNDEFINED) {
+			if (runtime !=3D MICROQ_BANDWIDTH_UNDEFINED)
+				return -EINVAL;
+		} else if (period < MICROQ_MIN_PERIOD) {
+			return -EINVAL;
+		} else if (runtime < MICROQ_MIN_RUNTIME &&
+		    runtime !=3D MICROQ_BANDWIDTH_UNDEFINED) {
+			return -EINVAL;
+		}
+	} else
+#endif
+	{
+		/*
+		 * Valid priorities for SCHED_FIFO and SCHED_RR are
+		 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL,
+		 * SCHED_BATCH and SCHED_IDLE is 0.
+		 */
+		if ((p->mm && attr->sched_priority > MAX_USER_RT_PRIO-1) ||
+		    (!p->mm && attr->sched_priority > MAX_RT_PRIO-1))
+			return -EINVAL;
+		if ((dl_policy(policy) && !__checkparam_dl(attr)) ||
+		    (rt_fiforr_policy(policy) !=3D (attr->sched_priority !=3D 0)))
+			return -EINVAL;
+	}
=20
 	/*
 	 * Allow unprivileged RT tasks to decrease priority:
@@ -4598,7 +4664,7 @@ static int __sched_setscheduler(struct task_struct *p=
,
 				return -EPERM;
 		}
=20
-		if (rt_policy(policy)) {
+		if (rt_fiforr_policy(policy)) {
 			unsigned long rlim_rtprio =3D
 					task_rlimit(p, RLIMIT_RTPRIO);
=20
@@ -4621,6 +4687,11 @@ static int __sched_setscheduler(struct task_struct *=
p,
 		if (dl_policy(policy))
 			return -EPERM;
=20
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+		if (microq_policy(policy))
+			return -EPERM;
+#endif
+
 		/*
 		 * Treat SCHED_IDLE as nice 20. Only allow a switch to
 		 * SCHED_NORMAL if the RLIMIT_NICE would normally permit it.
@@ -4680,13 +4751,20 @@ static int __sched_setscheduler(struct task_struct =
*p,
 	if (unlikely(policy =3D=3D p->policy)) {
 		if (fair_policy(policy) && attr->sched_nice !=3D task_nice(p))
 			goto change;
-		if (rt_policy(policy) && attr->sched_priority !=3D p->rt_priority)
+		if (rt_fiforr_policy(policy) && attr->sched_priority !=3D p->rt_priority=
)
 			goto change;
 		if (dl_policy(policy) && dl_param_changed(p, attr))
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
=20
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+		if (microq_policy(policy)) {
+			__setscheduler_params(p, attr);
+			microq_adjust_bandwidth(p);
+		}
+#endif
+
 		p->sched_reset_on_fork =3D reset_on_fork;
 		task_rq_unlock(rq, p, &rf);
 		return 0;
@@ -4699,7 +4777,7 @@ static int __sched_setscheduler(struct task_struct *p=
,
 		 * Do not allow realtime tasks into groups that have no runtime
 		 * assigned.
 		 */
-		if (rt_bandwidth_enabled() && rt_policy(policy) &&
+		if (rt_bandwidth_enabled() && rt_fiforr_policy(policy) &&
 				task_group(p)->rt_bandwidth.rt_runtime =3D=3D 0 &&
 				!task_group_is_autogroup(task_group(p))) {
 			task_rq_unlock(rq, p, &rf);
@@ -4754,7 +4832,21 @@ static int __sched_setscheduler(struct task_struct *=
p,
 		 * itself.
 		 */
 		new_effective_prio =3D rt_effective_prio(p, newprio);
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+		/*
+		 * A microq task overloads priorities and pretends to be a cfs task. We =
need
+		 * a stronger check here.
+		 *
+		 * Priorities has no effect on microq tasks, but the microq class still =
needs to
+		 * function as a priority inheritance passthrough, thus we cannot simply=
 turn
+		 * off all pi code.
+		 */
+
+		if (!microq_policy(policy) && !microq_policy(oldpolicy) &&
+		    new_effective_prio =3D=3D oldprio)
+#else
 		if (new_effective_prio =3D=3D oldprio)
+#endif
 			queue_flags &=3D ~DEQUEUE_MOVE;
 	}
=20
@@ -5084,8 +5176,13 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct s=
ched_param __user *, param)
 	if (retval)
 		goto out_unlock;
=20
-	if (task_has_rt_policy(p))
+	if (task_has_rt_fiforr_policy(p))
 		lp.sched_priority =3D p->rt_priority;
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+	else if (microq_policy(p->policy))
+		lp.sched_priority =3D microq_pack_bandwidth(p);
+#endif
+
 	rcu_read_unlock();
=20
 	/*
@@ -5171,8 +5268,12 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sc=
hed_attr __user *, uattr,
 		attr.sched_flags |=3D SCHED_FLAG_RESET_ON_FORK;
 	if (task_has_dl_policy(p))
 		__getparam_dl(p, &attr);
-	else if (task_has_rt_policy(p))
+	else if (task_has_rt_fiforr_policy(p))
 		attr.sched_priority =3D p->rt_priority;
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+	else if (microq_policy(p->policy))
+		attr.sched_priority =3D microq_pack_bandwidth(p);
+#endif
 	else
 		attr.sched_nice =3D task_nice(p);
=20
@@ -6441,6 +6542,9 @@ void __init sched_init(void)
 		init_cfs_rq(&rq->cfs);
 		init_rt_rq(&rq->rt);
 		init_dl_rq(&rq->dl);
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+		init_microq_rq(&rq->microq);
+#endif
 #ifdef CONFIG_FAIR_GROUP_SCHED
 		root_task_group.shares =3D ROOT_TASK_GROUP_LOAD;
 		INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..9bfd4b106b7e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -611,6 +611,31 @@ void print_dl_rq(struct seq_file *m, int cpu, struct d=
l_rq *dl_rq)
 #undef PU
 }
=20
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+void print_microq_rq(struct seq_file *m, int cpu, struct microq_rq *microq=
_rq)
+{
+	SEQ_printf(m, "\nmicroq_rq[%d]:\n", cpu);
+
+#define P(x) \
+	SEQ_printf(m, "  .%-30s: %Ld\n", #x, (long long)(microq_rq->x))
+#define PN(x) \
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", #x, SPLIT_NS(microq_rq->x))
+
+	P(microq_nr_running);
+	P(microq_throttled);
+	PN(microq_time);
+	PN(microq_target_time);
+	P(microq_runtime);
+	P(microq_period);
+	P(last_push_failed);
+	PN(quanta_start);
+	P(delta_exec_uncharged);
+
+#undef PN
+#undef P
+}
+#endif
+
 static void print_cpu(struct seq_file *m, int cpu)
 {
 	struct rq *rq =3D cpu_rq(cpu);
@@ -670,6 +695,9 @@ do {									\
 	print_cfs_stats(m, cpu);
 	print_rt_stats(m, cpu);
 	print_dl_stats(m, cpu);
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+	print_microq_stats(m, cpu);
+#endif
=20
 	print_rq(m, rq, cpu);
 	spin_unlock_irqrestore(&sched_debug_lock, flags);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 036be95a87e9..31f3f058cec1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7556,7 +7556,7 @@ static void update_blocked_averages(int cpu)
 	}
=20
 	curr_class =3D rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &rt_sched_=
class);
+	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &rt_sched_=
class || curr_class =3D=3D &microq_sched_class);
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &dl_sched_=
class);
 	update_irq_load_avg(rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
@@ -7626,7 +7626,7 @@ static inline void update_blocked_averages(int cpu)
 	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
=20
 	curr_class =3D rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &rt_sched_=
class);
+	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &rt_sched_=
class || curr_class =3D=3D &microq_sched_class);
 	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class =3D=3D &dl_sched_=
class);
 	update_irq_load_avg(rq, 0);
 	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_=
blocked(rq));
diff --git a/kernel/sched/microq.c b/kernel/sched/microq.c
new file mode 100644
index 000000000000..575499950f18
--- /dev/null
+++ b/kernel/sched/microq.c
@@ -0,0 +1,750 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Micro Quanta Scheduling Class
+ *
+ * Micro quanta is a lightweight scheduling class designed for microsecond
+ * level scheduling intervals. It provides a flexible way to share cores
+ * between latency sensitive tasks and other tasks - limiting the cpu shar=
e
+ * of latency sensitive tasks and maintaining low scheduling latency at th=
e
+ * same time
+ *
+ * See sched-microq.txt for more details.
+ */
+
+#include "sched.h"
+#include "pelt.h"
+#include <linux/slab.h>
+
+/*
+ * Global micro quanta period and runtime in ns.
+ * Can be overridden by per task parameters.
+ */
+int sysctl_sched_microq_period =3D 40000;
+int sysctl_sched_microq_runtime =3D 20000;
+
+int sched_microq_timeslice =3D 1;
+
+static DEFINE_PER_CPU(struct callback_head, microq_push_head);
+
+static enum hrtimer_restart sched_microq_period_timer(struct hrtimer *time=
r);
+static void __task_tick_microq(struct rq *rq, struct task_struct *p, int q=
ueued);
+static void push_one_microq_task(struct rq *rq);
+static void push_microq_tasks(struct rq *rq);
+
+static inline u64 u_saturation_sub(u64 a, u64 b)
+{
+	return a > b ? a - b : 0;
+}
+
+static inline struct task_struct *microq_task_of(struct sched_microq_entit=
y *microq_se)
+{
+	return container_of(microq_se, struct task_struct, microq);
+}
+
+static inline struct rq *rq_of_microq_rq(struct microq_rq *microq_rq)
+{
+	return container_of(microq_rq, struct rq, microq);
+}
+
+static inline struct microq_rq *microq_rq_of_se(struct sched_microq_entity=
 *microq_se)
+{
+	struct task_struct *p =3D microq_task_of(microq_se);
+	struct rq *rq =3D task_rq(p);
+
+	return &rq->microq;
+}
+
+static inline int on_microq_rq(struct sched_microq_entity *microq_se)
+{
+	return !list_empty(&microq_se->run_list);
+}
+
+int microq_task(struct task_struct *p)
+{
+	return p->sched_class =3D=3D &microq_sched_class;
+}
+
+/*
+ * microq bandwidth can be controlled with either global or per task bandw=
idth
+ * parameters. If none of the microq tasks on a cpu specifies the bandwidt=
h
+ * parameters, global parameters take effect.
+ *
+ * When there are multiple microq tasks on a run queue, the bandwidth
+ * parameters of the task with shortest period takes effect. (Note runtime=
 in
+ * effect is *not* the sum of microq tasks, it is exactly the runtime requ=
ested
+ * by one microq task.)
+ *
+ * See also sched-microq.txt
+ */
+static inline void get_microq_bandwidth(struct microq_rq *microq_rq, int *=
period, int *runtime)
+{
+	if (microq_rq->microq_period !=3D MICROQ_BANDWIDTH_UNDEFINED) {
+		*period =3D microq_rq->microq_period;
+		*runtime =3D microq_rq->microq_runtime;
+	} else {
+		*period =3D READ_ONCE(sysctl_sched_microq_period);
+		*runtime =3D READ_ONCE(sysctl_sched_microq_runtime);
+		*period =3D max(MICROQ_MIN_PERIOD, *period);
+		if (*runtime !=3D MICROQ_BANDWIDTH_UNDEFINED) /* if runtime !=3D unlimit=
ed */
+			*runtime =3D max(MICROQ_MIN_RUNTIME, *runtime);
+	}
+}
+
+static inline int microq_timer_needed(struct microq_rq *microq_rq)
+{
+	struct rq *rq =3D rq_of_microq_rq(microq_rq);
+	int period, runtime;
+
+	get_microq_bandwidth(microq_rq, &period, &runtime);
+	return runtime !=3D MICROQ_BANDWIDTH_UNDEFINED && rq->microq.microq_nr_ru=
nning &&
+	    rq->nr_running > rq->microq.microq_nr_running;
+}
+
+void init_microq_rq(struct microq_rq *microq_rq)
+{
+	INIT_LIST_HEAD(&microq_rq->tasks);
+
+	microq_rq->microq_period =3D MICROQ_BANDWIDTH_UNDEFINED;
+	microq_rq->microq_runtime =3D MICROQ_BANDWIDTH_UNDEFINED;
+	microq_rq->microq_time =3D 0;
+	microq_rq->microq_target_time =3D 0;
+	microq_rq->microq_throttled =3D 0;
+
+	hrtimer_init(&microq_rq->microq_period_timer, CLOCK_MONOTONIC, HRTIMER_MO=
DE_REL);
+	microq_rq->microq_period_timer.function =3D sched_microq_period_timer;
+	microq_rq->quanta_start =3D 0;
+	microq_rq->delta_exec_uncharged =3D 0;
+	microq_rq->delta_exec_total =3D 0;
+}
+
+static void account_microq_bandwidth(struct rq *rq)
+{
+	s64 delta;
+	int period;
+	int runtime;
+	struct microq_rq *microq_rq =3D &rq->microq;
+
+	delta =3D sched_clock_cpu(cpu_of(rq)) - microq_rq->quanta_start;
+	microq_rq->quanta_start +=3D delta;
+	delta =3D max(0LL, delta);
+
+	get_microq_bandwidth(microq_rq, &period, &runtime);
+	if (microq_task(rq->curr)) {
+		microq_rq->microq_time +=3D delta;
+		microq_rq->delta_exec_uncharged +=3D delta;
+	}
+	microq_rq->delta_exec_total +=3D delta;
+	microq_rq->microq_target_time +=3D delta*runtime/period;
+	microq_rq->microq_time =3D clamp(microq_rq->microq_time,
+	    u_saturation_sub(microq_rq->microq_target_time, period*2),
+	    microq_rq->microq_target_time + period*2);
+}
+
+static void check_microq_timer(struct rq *rq)
+{
+	struct microq_rq *microq_rq =3D &rq->microq;
+	int period, runtime, expire;
+
+	if (hrtimer_active(&microq_rq->microq_period_timer))
+		return;
+
+	get_microq_bandwidth(microq_rq, &period, &runtime);
+	account_microq_bandwidth(rq);
+	if (microq_rq->microq_time < microq_rq->microq_target_time) {
+		microq_rq->microq_throttled =3D 0;
+		expire =3D microq_rq->microq_target_time - microq_rq->microq_time;
+		expire =3D max(runtime, expire);
+	} else {
+		microq_rq->microq_throttled =3D 1;
+		expire =3D microq_rq->microq_time - microq_rq->microq_target_time;
+		expire =3D max(expire, period - runtime);
+	}
+	microq_rq->period_count =3D 0;
+	microq_rq->periods_to_jiffies =3D (jiffies_to_usecs(1) * 1000) / period;
+	microq_rq->periods_to_jiffies =3D max(1U, microq_rq->periods_to_jiffies);
+
+	hrtimer_start_range_ns(&microq_rq->microq_period_timer, ns_to_ktime(expir=
e), 0,
+			 HRTIMER_MODE_REL_PINNED);
+}
+
+void microq_adjust_bandwidth(struct task_struct *p)
+{
+	struct microq_rq *microq_rq =3D &task_rq(p)->microq;
+	struct sched_microq_entity *microq_se;
+
+	microq_rq->microq_period =3D MICROQ_BANDWIDTH_UNDEFINED;
+	microq_rq->microq_runtime =3D MICROQ_BANDWIDTH_UNDEFINED;
+	list_for_each_entry(microq_se, &microq_rq->tasks, run_list) {
+		if (microq_se->sched_period >=3D 0 &&
+		    microq_se->sched_runtime >=3D MICROQ_BANDWIDTH_UNDEFINED &&
+		    (microq_rq->microq_period =3D=3D MICROQ_BANDWIDTH_UNDEFINED ||
+		    microq_se->sched_period <=3D microq_rq->microq_period)) {
+			microq_rq->microq_period =3D microq_se->sched_period;
+			microq_rq->microq_runtime =3D microq_se->sched_runtime;
+		}
+	}
+
+}
+
+static void microq_update_load_avg_ratio(struct rq *rq)
+{
+	struct microq_rq *microq_rq =3D &rq->microq;
+	int period;
+	int runtime;
+	u64 contrib_ratio;
+
+	/*
+	 * For cpu_power accounting (SCHED_POWER_SCALE)
+	 *
+	 * Note micro's contribution to rt_avg is capped at elapsed_time*runtime/=
period for
+	 * the desired load balancing behavior. We allow microq to go over its ba=
ndwidth limit
+	 * when there are free cpu cycles. However if we don't cap the rt_avg con=
tribution
+	 * the cpu running microq can report cpu_power of 0, such that no cfs tas=
k can be
+	 * moved to it by load balancer.
+	 */
+	get_microq_bandwidth(microq_rq, &period, &runtime);
+	if (microq_rq->delta_exec_uncharged * period > microq_rq->delta_exec_tota=
l * runtime)
+		contrib_ratio =3D runtime * SCHED_FIXEDPOINT_SCALE / period;
+
+	else
+		contrib_ratio =3D SCHED_FIXEDPOINT_SCALE;
+	update_rt_rq_load_avg_ratio(rq_clock_pelt(rq), contrib_ratio, rq, 1);
+}
+
+static void update_curr_microq(struct rq *rq)
+{
+	struct task_struct *curr =3D rq->curr;
+	struct microq_rq *microq_rq =3D &rq->microq;
+
+	if (!microq_task(curr))
+		return;
+
+	account_microq_bandwidth(rq);
+
+	schedstat_set(curr->se.statistics.exec_max,
+		      max(curr->se.statistics.exec_max, microq_rq->delta_exec_uncharged)=
);
+
+	curr->se.sum_exec_runtime +=3D microq_rq->delta_exec_uncharged;
+	account_group_exec_runtime(curr, microq_rq->delta_exec_uncharged);
+
+	curr->se.exec_start =3D rq_clock_task(rq);
+	cpuacct_charge(curr, microq_rq->delta_exec_uncharged);
+
+	microq_update_load_avg_ratio(rq),
+
+	microq_rq->delta_exec_uncharged =3D 0;
+	microq_rq->delta_exec_total =3D 0;
+}
+
+static enum hrtimer_restart sched_microq_period_timer(struct hrtimer *time=
r)
+{
+	int period;
+	int runtime;
+	struct microq_rq *microq_rq;
+	struct rq *rq;
+	ktime_t nextslice =3D {0};
+	u64 ns;
+
+	microq_rq =3D container_of(timer, struct microq_rq, microq_period_timer);
+	rq =3D rq_of_microq_rq(microq_rq);
+	get_microq_bandwidth(microq_rq, &period, &runtime);
+	nextslice =3D ns_to_ktime(period);
+
+	raw_spin_lock(&rq->lock);
+
+	account_microq_bandwidth(rq);
+	if (microq_timer_needed(microq_rq)) {
+		if (microq_rq->microq_throttled) {
+			microq_rq->microq_throttled =3D 0;
+			ns =3D u_saturation_sub(microq_rq->microq_target_time,
+				microq_rq->microq_time);
+			nextslice =3D ns_to_ktime(max(ns, (u64)runtime));
+		} else {
+			microq_rq->microq_throttled =3D 1;
+			ns =3D u_saturation_sub(microq_rq->microq_time,
+				microq_rq->microq_target_time);
+			/*
+			 * The exact time lower class tasks need to run to maintain the bandwid=
th
+			 * ratio
+			 */
+			ns =3D ns*period/runtime;
+			/*
+			 * Don't want to make the next time slice too short for lower class tas=
ks or
+			 * microq tasks. Also don't want the time slice for lower class tasks t=
o
+			 * last too long as microq tasks are latency sensitive. The time slice =
is
+			 * not limited in this function for microq tasks (but difference betwee=
n
+			 * microq_time and microq_target_time is clamped).
+			 */
+			ns =3D clamp_val(ns, u_saturation_sub(period, runtime),
+				u_saturation_sub(period, runtime/2));
+			nextslice =3D ns_to_ktime(ns);
+
+			if (++microq_rq->period_count >=3D microq_rq->periods_to_jiffies) {
+				microq_rq->period_count =3D 0;
+				microq_rq->periods_to_jiffies =3D (jiffies_to_usecs(1) * 1000) / perio=
d;
+				microq_rq->periods_to_jiffies =3D max(1U, microq_rq->periods_to_jiffie=
s);
+				update_rq_clock(rq);
+				__task_tick_microq(rq, rq->curr, 0);
+			}
+		}
+
+		resched_curr(rq);
+		hrtimer_set_expires(timer,
+		    ktime_add(hrtimer_cb_get_time(&microq_rq->microq_period_timer), next=
slice));
+		raw_spin_unlock(&rq->lock);
+		return HRTIMER_RESTART;
+	} else {
+		microq_rq->microq_throttled =3D 0;
+		raw_spin_unlock(&rq->lock);
+		return HRTIMER_NORESTART;
+	}
+}
+
+static void dequeue_microq_entity(struct sched_microq_entity *microq_se)
+{
+	struct microq_rq *microq_rq =3D microq_rq_of_se(microq_se);
+
+	list_del_init(&microq_se->run_list);
+	BUG_ON(!microq_rq->microq_nr_running);
+	microq_rq->microq_nr_running--;
+}
+
+static void enqueue_microq_entity(struct sched_microq_entity *microq_se)
+{
+	struct microq_rq *microq_rq =3D microq_rq_of_se(microq_se);
+
+	list_add_tail(&microq_se->run_list, &microq_rq->tasks);
+	microq_rq->microq_nr_running++;
+	microq_rq->last_push_failed =3D 0;
+}
+
+static void
+enqueue_task_microq(struct rq *rq, struct task_struct *p, int flags)
+{
+	struct sched_microq_entity *microq_se =3D &p->microq;
+	struct microq_rq *microq_rq =3D microq_rq_of_se(microq_se);
+
+	/*
+	 * microq keeps uncharged runtime stats internally. Need to mark the end =
of non mircoq task
+	 * execution here so their runtime won't be counted as microq.
+	 */
+	account_microq_bandwidth(rq);
+
+	enqueue_microq_entity(microq_se);
+	add_nr_running(rq, 1);
+
+	/* The parameters of the task with shortest period takes effect, see get_=
microq_bandwidth */
+	if (microq_se->sched_period >=3D 0 &&
+	    microq_se->sched_runtime >=3D MICROQ_BANDWIDTH_UNDEFINED &&
+	    (microq_rq->microq_period =3D=3D MICROQ_BANDWIDTH_UNDEFINED ||
+	    microq_se->sched_period <=3D microq_rq->microq_period)) {
+		microq_rq->microq_period =3D microq_se->sched_period;
+		microq_rq->microq_runtime =3D microq_se->sched_runtime;
+	}
+}
+
+static void dequeue_task_microq(struct rq *rq, struct task_struct *p, int =
flags)
+{
+	struct sched_microq_entity *microq_se =3D &p->microq;
+
+	update_curr_microq(rq);
+	dequeue_microq_entity(microq_se);
+	sub_nr_running(rq, 1);
+
+	microq_adjust_bandwidth(p);
+}
+
+/*
+ * Put task to the head or the end of the run list without the overhead of
+ * dequeue followed by enqueue.
+ */
+static void
+requeue_microq_entity(struct microq_rq *microq_rq, struct sched_microq_ent=
ity *microq_se)
+{
+	if (on_microq_rq(microq_se))
+		list_move_tail(&microq_se->run_list, &microq_rq->tasks);
+}
+
+static void requeue_task_microq(struct rq *rq, struct task_struct *p)
+{
+	struct sched_microq_entity *microq_se =3D &p->microq;
+	struct microq_rq *microq_rq;
+
+	microq_rq =3D microq_rq_of_se(microq_se);
+	requeue_microq_entity(microq_rq, microq_se);
+}
+
+static void yield_task_microq(struct rq *rq)
+{
+	requeue_task_microq(rq, rq->curr);
+}
+
+static void check_preempt_curr_microq(struct rq *rq, struct task_struct *p=
, int flags)
+{
+}
+
+static struct task_struct *pick_next_task_microq(struct rq *rq, struct tas=
k_struct *prev,
+  struct rq_flags *rf)
+{
+	struct sched_microq_entity *microq_se;
+	struct task_struct *p;
+	struct microq_rq *microq_rq =3D &rq->microq;
+
+	if (!microq_rq->microq_nr_running)
+		return NULL;
+
+	if (microq_timer_needed(microq_rq)) {
+		check_microq_timer(rq);
+		if (microq_rq->microq_throttled)
+			return NULL;
+	} else {
+		microq_rq->microq_throttled =3D 0;
+	}
+
+	put_prev_task(rq, prev);
+
+	microq_se =3D list_entry(microq_rq->tasks.next, struct sched_microq_entit=
y, run_list);
+	BUG_ON(!microq_se);
+
+	p =3D microq_task_of(microq_se);
+
+#ifdef CONFIG_SMP
+	if (rq->microq.microq_nr_running > 1 && !rq->microq.last_push_failed)
+		queue_balance_callback(rq, &per_cpu(microq_push_head, rq->cpu),
+		    push_one_microq_task);
+#endif
+
+	if (rq->curr->sched_class !=3D &rt_sched_class && rq->curr->sched_class !=
=3D &microq_sched_class)
+		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+
+	return p;
+}
+
+static void put_prev_task_microq(struct rq *rq, struct task_struct *p)
+{
+	microq_update_load_avg_ratio(rq);
+}
+
+#ifdef CONFIG_SMP
+
+static int microq_find_rq(struct task_struct *p)
+{
+	int pcpu =3D task_cpu(p);
+	int cpu, tcpu;
+	struct rq *rq;
+	int idle_ht =3D -1;
+	int lowprio_cpu =3D -1;
+	int low_nmicroq_cpu =3D -1;
+	unsigned int low_nmicroq =3D task_rq(p)->microq.microq_nr_running;
+
+	if (!cpumask_test_cpu(pcpu, p->cpus_ptr))
+		pcpu =3D cpumask_first(p->cpus_ptr);
+
+	for (cpu =3D pcpu;;) {
+		/* search from current cpu to avoid crowding lower numbered cpus */
+		cpu =3D cpumask_next(cpu, p->cpus_ptr);
+		if (cpu >=3D nr_cpu_ids)
+			cpu =3D cpumask_first(p->cpus_ptr);
+		if (cpu =3D=3D pcpu)
+			break;
+
+		for_each_cpu(tcpu, topology_sibling_cpumask(cpu)) {
+			if (!available_idle_cpu(tcpu))
+				break;
+		}
+		if (tcpu >=3D nr_cpu_ids)
+			return cpu;
+
+		if (idle_ht =3D=3D -1) {
+			rq =3D cpu_rq(cpu);
+			if (idle_cpu(cpu)) {
+				idle_ht =3D cpu;
+			} else if (lowprio_cpu =3D=3D -1) {
+				if (rq->nr_running =3D=3D rq->cfs.h_nr_running) {
+					lowprio_cpu =3D cpu;
+				} else if (rq->microq.microq_nr_running + 1 < low_nmicroq) {
+					low_nmicroq_cpu =3D cpu;
+					low_nmicroq =3D rq->microq.microq_nr_running;
+				}
+			}
+		}
+	}
+	if (idle_ht !=3D -1)
+		return idle_ht;
+	if (lowprio_cpu !=3D -1)
+		return lowprio_cpu;
+	return low_nmicroq_cpu;
+}
+
+/* Will lock the rq it finds */
+static struct rq *microq_find_potential_rq(struct task_struct *task, struc=
t rq *rq)
+{
+	struct rq *t_rq =3D NULL;
+	int cpu;
+
+	cpu =3D microq_find_rq(task);
+
+	if (cpu =3D=3D -1)
+		return NULL;
+
+	t_rq =3D cpu_rq(cpu);
+
+	if (double_lock_balance(rq, t_rq)) {
+		/*
+		 * We had to unlock the run queue. In
+		 * the mean time, task could have
+		 * migrated already or had its affinity changed.
+		 * Also make sure that it wasn't scheduled on its rq.
+		 */
+		if (unlikely(task_rq(task) !=3D rq ||
+			     !cpumask_test_cpu(t_rq->cpu,
+					       task->cpus_ptr) ||
+			     task_running(rq, task) ||
+			     !task->on_rq)) {
+
+			double_unlock_balance(rq, t_rq);
+			t_rq =3D NULL;
+		}
+	}
+
+	return t_rq;
+}
+
+/*
+ * If the current CPU has more than one microq task, see if a non
+ * running task can be kicked out.
+ */
+static int __push_microq_task(struct rq *rq)
+{
+	struct microq_rq *microq_rq =3D &rq->microq;
+	struct task_struct *next_task =3D NULL;
+	struct sched_microq_entity *microq_se;
+	struct rq *t_rq;
+	int ret =3D 0;
+
+	if (microq_rq->microq_nr_running <=3D 1 || microq_rq->last_push_failed)
+		return 0;
+
+	list_for_each_entry(microq_se, &rq->microq.tasks, run_list) {
+		struct task_struct *p =3D microq_task_of(microq_se);
+
+		if (!task_running(rq, p) && p->nr_cpus_allowed > 1) {
+			next_task =3D p;
+			break;
+		}
+	}
+	if (!next_task)
+		goto out;
+
+	BUG_ON(rq->cpu !=3D task_cpu(next_task));
+	BUG_ON(!next_task->on_rq);
+
+	/* We might release rq lock */
+	get_task_struct(next_task);
+
+	/* find_lock_rq locks the rq if found */
+	t_rq =3D microq_find_potential_rq(next_task, rq);
+
+	if (t_rq) {
+		deactivate_task(rq, next_task, 0);
+		set_task_cpu(next_task, t_rq->cpu);
+		activate_task(t_rq, next_task, 0);
+		resched_curr(t_rq);
+		double_unlock_balance(rq, t_rq);
+		ret =3D 1;
+	}
+
+	put_task_struct(next_task);
+
+out:
+	if (!ret)
+		microq_rq->last_push_failed =3D 1;
+	return ret;
+}
+
+static void push_one_microq_task(struct rq *rq)
+{
+	__push_microq_task(rq);
+}
+
+static void push_microq_tasks(struct rq *rq)
+{
+	while (__push_microq_task(rq)) {}
+}
+
+/*
+ * If we are not running and we are not going to reschedule soon, we shoul=
d
+ * try to push tasks away now
+ */
+static void task_woken_microq(struct rq *rq, struct task_struct *p)
+{
+	if (!test_tsk_need_resched(rq->curr) &&
+	    p->nr_cpus_allowed > 1 &&
+	    rq->microq.microq_nr_running)
+		push_microq_tasks(rq);
+}
+
+/* Assumes rq->lock is held */
+static void rq_online_microq(struct rq *rq)
+{
+	struct microq_rq *microq_rq =3D &rq->microq;
+
+	microq_rq->microq_period =3D MICROQ_BANDWIDTH_UNDEFINED;
+	microq_rq->microq_runtime =3D MICROQ_BANDWIDTH_UNDEFINED;
+	microq_rq->microq_time =3D 0;
+	microq_rq->microq_target_time =3D 0;
+	microq_rq->microq_throttled =3D 0;
+	microq_rq->quanta_start =3D 0;
+	microq_rq->delta_exec_uncharged =3D 0;
+	microq_rq->delta_exec_total =3D 0;
+}
+
+static int select_task_rq_microq(struct task_struct *p, int cpu, int sd_fl=
ag, int flags)
+{
+	struct task_struct *curr;
+	struct rq *rq;
+
+	if (p->nr_cpus_allowed =3D=3D 1)
+		goto out;
+
+	/* For anything but wake ups, just return the task_cpu */
+	if (sd_flag !=3D SD_BALANCE_WAKE && sd_flag !=3D SD_BALANCE_FORK)
+		goto out;
+
+	rq =3D cpu_rq(cpu);
+
+	rcu_read_lock();
+	curr =3D READ_ONCE(rq->curr); /* unlocked access */
+
+	/* Try to push the incoming microq task if the current rq is busy */
+	if (unlikely(rq->microq.microq_nr_running) && (p->nr_cpus_allowed > 1)) {
+		int target =3D microq_find_rq(p);
+
+		if (target !=3D -1)
+			cpu =3D target;
+	}
+	rcu_read_unlock();
+
+out:
+	return cpu;
+}
+
+#endif /* CONFIG_SMP */
+
+static void switched_to_microq(struct rq *rq, struct task_struct *p)
+{
+#ifdef CONFIG_SMP
+	if (p->on_rq && rq->curr !=3D p) {
+		rq->microq.last_push_failed =3D 0;
+		if (rq->microq.microq_nr_running > 1)
+			queue_balance_callback(rq, &per_cpu(microq_push_head, rq->cpu),
+			    push_one_microq_task);
+	}
+#endif
+}
+
+static void prio_changed_microq(struct rq *rq, struct task_struct *p, int =
oldprio)
+{
+}
+
+static void __task_tick_microq(struct rq *rq, struct task_struct *p, int q=
ueued)
+{
+	struct sched_microq_entity *microq_se =3D &p->microq;
+
+	if (microq_timer_needed(&rq->microq))
+		check_microq_timer(rq);
+
+	update_curr_microq(rq);
+
+	if (p->microq.time_slice--)
+		return;
+	p->microq.time_slice =3D sched_microq_timeslice;
+	if (microq_se->run_list.prev !=3D microq_se->run_list.next) {
+		requeue_task_microq(rq, p);
+		resched_curr(rq);
+		return;
+	}
+}
+
+static void task_tick_microq(struct rq *rq, struct task_struct *p, int que=
ued)
+{
+
+	if (hrtimer_active(&rq->microq.microq_period_timer))
+		return;
+
+	__task_tick_microq(rq, p, queued);
+}
+
+static void set_curr_task_microq(struct rq *rq)
+{
+	struct task_struct *p =3D rq->curr;
+
+	p->se.exec_start =3D rq_clock_task(rq);
+}
+
+static unsigned int get_rr_interval_microq(struct rq *rq, struct task_stru=
ct *task)
+{
+	return sched_microq_timeslice;
+}
+
+const struct sched_class microq_sched_class =3D {
+	.next			=3D &fair_sched_class,
+	.enqueue_task		=3D enqueue_task_microq,
+	.dequeue_task		=3D dequeue_task_microq,
+	.yield_task		=3D yield_task_microq,
+	.check_preempt_curr	=3D check_preempt_curr_microq,
+	.pick_next_task		=3D pick_next_task_microq,
+	.put_prev_task		=3D put_prev_task_microq,
+#ifdef CONFIG_SMP
+	.select_task_rq		=3D select_task_rq_microq,
+	.set_cpus_allowed	=3D set_cpus_allowed_common,
+	.rq_online              =3D rq_online_microq,
+	.task_woken		=3D task_woken_microq,
+#endif
+	.set_curr_task          =3D set_curr_task_microq,
+	.task_tick		=3D task_tick_microq,
+	.get_rr_interval	=3D get_rr_interval_microq,
+	.prio_changed		=3D prio_changed_microq,
+	.switched_to		=3D switched_to_microq,
+	.update_curr		=3D update_curr_microq,
+};
+
+int sched_microq_proc_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+	int old_period, old_runtime;
+	static DEFINE_MUTEX(mutex);
+
+	mutex_lock(&mutex);
+	old_period =3D sysctl_sched_microq_period;
+	old_runtime =3D sysctl_sched_microq_runtime;
+
+	ret =3D proc_dointvec(table, write, buffer, lenp, ppos);
+
+	if (!ret && write) {
+		if (sysctl_sched_microq_period < MICROQ_MIN_PERIOD) {
+			sysctl_sched_microq_period =3D old_period;
+			ret =3D -EINVAL;
+		}
+		if (sysctl_sched_microq_runtime < MICROQ_MIN_RUNTIME &&
+		    sysctl_sched_microq_runtime !=3D MICROQ_BANDWIDTH_UNDEFINED) {
+			sysctl_sched_microq_runtime =3D old_runtime;
+			ret =3D -EINVAL;
+		}
+	}
+
+	mutex_unlock(&mutex);
+	return ret;
+}
+
+#ifdef CONFIG_SCHED_DEBUG
+extern void print_microq_rq(struct seq_file *m, int cpu, struct microq_rq =
*microq_rq);
+
+void print_microq_stats(struct seq_file *m, int cpu)
+{
+	rcu_read_lock();
+	print_microq_rq(m, cpu, &cpu_rq(cpu)->microq);
+	rcu_read_unlock();
+}
+#endif /* CONFIG_SCHED_DEBUG */
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a96db50d40e0..486bf7e6ee31 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -107,7 +107,7 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 =
d1, u32 d3)
  *                     n=3D1
  */
 static __always_inline u32
-accumulate_sum(u64 delta, struct sched_avg *sa,
+accumulate_sum(u64 delta, u64 contrib_ratio, struct sched_avg *sa,
 	       unsigned long load, unsigned long runnable, int running)
 {
 	u32 contrib =3D (u32)delta; /* p =3D=3D 0 -> delta < 1024 */
@@ -134,6 +134,7 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 	}
 	sa->period_contrib =3D delta;
=20
+	contrib =3D contrib * contrib_ratio / SCHED_FIXEDPOINT_SCALE;
 	if (load)
 		sa->load_sum +=3D load * contrib;
 	if (runnable)
@@ -173,7 +174,7 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
  *            =3D u_0 + u_1*y + u_2*y^2 + ... [re-labeling u_i --> u_{i+1}=
]
  */
 static __always_inline int
-___update_load_sum(u64 now, struct sched_avg *sa,
+___update_load_sum_ratio(u64 now, u64 contrib_ratio, struct sched_avg *sa,
 		  unsigned long load, unsigned long runnable, int running)
 {
 	u64 delta;
@@ -217,12 +218,20 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, sa, load, runnable, running))
+	if (!accumulate_sum(delta, contrib_ratio, sa, load, runnable, running))
 		return 0;
=20
 	return 1;
 }
=20
+static __always_inline int
+___update_load_sum(u64 now, struct sched_avg *sa,
+		  unsigned long load, unsigned long runnable, int running)
+{
+	return ___update_load_sum_ratio(now, SCHED_FIXEDPOINT_SCALE, sa, load, ru=
nnable, running);
+}
+
+
 static __always_inline void
 ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long=
 runnable)
 {
@@ -329,6 +338,21 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int =
running)
 	return 0;
 }
=20
+int update_rt_rq_load_avg_ratio(u64 now, u64 contrib_ratio, struct rq *rq,=
 int running)
+{
+	if (___update_load_sum_ratio(now, contrib_ratio, &rq->avg_rt,
+				running,
+				running,
+				running)) {
+
+		___update_load_avg(&rq->avg_rt, 1, 1);
+		trace_pelt_rt_tp(rq);
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * dl_rq:
  *
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index afff644da065..52840dbb02ab 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -5,6 +5,7 @@ int __update_load_avg_blocked_se(u64 now, struct sched_enti=
ty *se);
 int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_enti=
ty *se);
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
+int update_rt_rq_load_avg_ratio(u64 now, u64 contrib_ratio, struct rq *rq,=
 int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
=20
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
@@ -152,6 +153,11 @@ update_rt_rq_load_avg(u64 now, struct rq *rq, int runn=
ing)
 	return 0;
 }
=20
+int update_rt_rq_load_avg_ratio(u64 now, u64 contrib_ratio, struct rq *rq,=
 int running)
+{
+	return 0;
+}
+
 static inline int
 update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 {
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a532558a5176..a50afb692ce1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1586,7 +1586,7 @@ pick_next_task_rt(struct rq *rq, struct task_struct *=
prev, struct rq_flags *rf)
 	 * utilization. We only care of the case where we start to schedule a
 	 * rt task
 	 */
-	if (rq->curr->sched_class !=3D &rt_sched_class)
+	if (rq->curr->sched_class !=3D &rt_sched_class && rq->curr->sched_class !=
=3D &microq_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
=20
 	return p;
@@ -2371,7 +2371,11 @@ static unsigned int get_rr_interval_rt(struct rq *rq=
, struct task_struct *task)
 }
=20
 const struct sched_class rt_sched_class =3D {
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+	.next			=3D &microq_sched_class,
+#else
 	.next			=3D &fair_sched_class,
+#endif
 	.enqueue_task		=3D enqueue_task_rt,
 	.dequeue_task		=3D dequeue_task_rt,
 	.yield_task		=3D yield_task_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3405f2..7e3beb49ad39 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -159,7 +159,23 @@ static inline int fair_policy(int policy)
=20
 static inline int rt_policy(int policy)
 {
-	return policy =3D=3D SCHED_FIFO || policy =3D=3D SCHED_RR;
+	if (policy =3D=3D SCHED_FIFO || policy =3D=3D SCHED_RR || policy =3D=3D S=
CHED_MICROQ)
+		return 1;
+	return 0;
+}
+
+static inline int rt_fiforr_policy(int policy)
+{
+	if (policy =3D=3D SCHED_FIFO || policy =3D=3D SCHED_RR)
+		return 1;
+	return 0;
+}
+
+static inline int microq_policy(int policy)
+{
+	if (policy =3D=3D SCHED_MICROQ)
+		return 1;
+	return 0;
 }
=20
 static inline int dl_policy(int policy)
@@ -182,6 +198,11 @@ static inline int task_has_rt_policy(struct task_struc=
t *p)
 	return rt_policy(p->policy);
 }
=20
+static inline int task_has_rt_fiforr_policy(struct task_struct *p)
+{
+	return rt_fiforr_policy(p->policy);
+}
+
 static inline int task_has_dl_policy(struct task_struct *p)
 {
 	return dl_policy(p->policy);
@@ -685,6 +706,37 @@ struct dl_rq {
 #define entity_is_task(se)	1
 #endif
=20
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+
+/*
+ * If combined with a valid period, runtime =3D=3D MICROQ_BANDWIDTH_UNDEFI=
NED also
+ * indicates unlimited runtime
+ */
+#define MICROQ_BANDWIDTH_UNDEFINED (-1)
+#define MICROQ_MIN_RUNTIME (1000)
+#define MICROQ_MIN_PERIOD (2000)
+
+#define DEFAULT_MICROQ_RT_PRIORITY (0)
+
+/* Micro Quanta class */
+struct microq_rq {
+	struct list_head tasks;
+	unsigned int microq_nr_running;
+	int last_push_failed;
+	int microq_runtime;
+	int microq_period;
+	int microq_throttled;
+	u64 microq_time;
+	u64 microq_target_time;
+	struct hrtimer microq_period_timer; /* Nests inside the rq lock */
+	u64 quanta_start;
+	u64 delta_exec_uncharged;
+	u64 delta_exec_total;
+	unsigned int period_count;
+	unsigned int periods_to_jiffies;
+};
+#endif
+
 #ifdef CONFIG_SMP
 /*
  * XXX we want to get rid of these helpers and use the full load resolutio=
n.
@@ -877,6 +929,9 @@ struct rq {
 	struct cfs_rq		cfs;
 	struct rt_rq		rt;
 	struct dl_rq		dl;
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+	struct microq_rq	microq;
+#endif
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
@@ -1773,6 +1828,7 @@ static inline void set_curr_task(struct rq *rq, struc=
t task_struct *curr)
=20
 extern const struct sched_class stop_sched_class;
 extern const struct sched_class dl_sched_class;
+extern const struct sched_class microq_sched_class;
 extern const struct sched_class rt_sched_class;
 extern const struct sched_class fair_sched_class;
 extern const struct sched_class idle_sched_class;
@@ -2151,6 +2207,11 @@ extern void init_cfs_rq(struct cfs_rq *cfs_rq);
 extern void init_rt_rq(struct rt_rq *rt_rq);
 extern void init_dl_rq(struct dl_rq *dl_rq);
=20
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+extern void print_microq_stats(struct seq_file *m, int cpu);
+extern void init_microq_rq(struct microq_rq *microq_rq);
+#endif
+
 extern void cfs_bandwidth_usage_inc(void);
 extern void cfs_bandwidth_usage_dec(void);
=20
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1c1ad1e14f21..aba857c78c2d 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -452,6 +452,29 @@ static struct ctl_table kern_table[] =3D {
 		.mode		=3D 0644,
 		.proc_handler	=3D sched_rr_handler,
 	},
+#ifdef CONFIG_SCHED_CLASS_MICROQ
+	{
+		.procname	=3D "sched_microq_period_ns",
+		.data		=3D &sysctl_sched_microq_period,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D sched_microq_proc_handler,
+	},
+	{
+		.procname	=3D "sched_microq_runtime_ns",
+		.data		=3D &sysctl_sched_microq_runtime,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D sched_microq_proc_handler,
+	},
+	{
+		.procname	=3D "sched_microq_timeslice",
+		.data		=3D &sched_microq_timeslice,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec,
+	},
+#endif
 #ifdef CONFIG_UCLAMP_TASK
 	{
 		.procname	=3D "sched_util_clamp_min",
--=20
2.23.0.187.g17f5b7556c-goog

