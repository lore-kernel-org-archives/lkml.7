Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B92C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766D620659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573009789;
	bh=Qy/XaexPF/i2ioTbEv08n8CiEnEfRWikGiHU8rWFKd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BcSaMlq9WpTjcBrmUT9ixz9BiNhrV36U64NJxbu4gY2/uj+xKBiiYyUj5YKYfa+xQ
	 ut+/c0ARAsCyhXpNXPGJWa/If24RS3FgV40ste2EarD004cCVkUIuvu3L9Rw5pMbsr
	 9Zsy701vErkG6eHtbQLqRYQ+XvFHhCxAazKxdiMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbfKFDIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388264AbfKFDI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:26 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B96222C6;
        Wed,  6 Nov 2019 03:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573009705;
        bh=Qy/XaexPF/i2ioTbEv08n8CiEnEfRWikGiHU8rWFKd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdtOmTwKhIDyNID7Vw0EZd674/ZVGzv/E+r4XsnU0Tc1qcUGFkRCiqUlsmXt8tBVE
         i+Cm+73geg+wvzJOVOK8g1FVs+arBzg3KeeMlbFVMAdn41BnqYTuPQylTqxND0mI3/
         gLC1/iazTxTaOl2lTmQAC3LX3mOEoivl5ZjUB2Mk=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 3/9] sched/vtime: Handle nice updates under vtime
Date:   Wed,  6 Nov 2019 04:08:01 +0100
Message-Id: <20191106030807.31091-4-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030807.31091-1-frederic@kernel.org>
References: <20191106030807.31091-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cputime niceness is determined while checking the target's nice value
at cputime accounting time. Under vtime this happens on context switches,
user exit and guest exit. But nice value updates while the target is
running are not taken into account.

So if a task runs tickless for 10 seconds in userspace but it has been
reniced after 5 seconds from -1 (not nice) to 1 (nice), on user exit
vtime will account the whole 10 seconds as CPUTIME_NICE because it only
sees the latest nice value at accounting time which is 1 here. Yet it's
wrong, 5 seconds should be accounted as CPUTIME_USER and 5 seconds as
CPUTIME_NICE.

In order to solve this, we now cover nice updates withing three cases:

* If the nice updater is the current task, although we are in kernel
  mode there can be pending user or guest time in the cache to flush
  under the prior nice state. Account these if any. Also toggle the
  vtime nice flag for further user/guest cputime accounting.

* If the target runs on a different CPU, we interrupt it with an IPI to
  update the vtime state in place. If the task is running in user or
  guest, the pending cputime is accounted under the prior nice state.
  Then the vtime nice flag is toggled for further user/guest cputime
  accounting.

* When a task's nice value gets updated while it is sleeping, the next
  context switch takes into account the new nice value in order to
  later record the vtime delta to the appropriate kcpustat index.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h  |   1 +
 include/linux/vtime.h  |   2 +
 kernel/sched/core.c    |  16 +++--
 kernel/sched/cputime.c | 136 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h   |  18 ++++++
 5 files changed, 159 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 988c4da00c31..44552b74bd44 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -262,6 +262,7 @@ enum vtime_state {
 struct vtime {
 	seqcount_t		seqcount;
 	unsigned long long	starttime;
+	int			nice;
 	enum vtime_state	state;
 	unsigned int		cpu;
 	u64			utime;
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 2cdeca062db3..eb2fa3c00f3e 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -9,6 +9,7 @@
 
 
 struct task_struct;
+struct rq;
 
 /*
  * vtime_accounting_enabled_this_cpu() definitions/declarations
@@ -74,6 +75,7 @@ extern void vtime_user_exit(struct task_struct *tsk);
 extern void vtime_guest_enter(struct task_struct *tsk);
 extern void vtime_guest_exit(struct task_struct *tsk);
 extern void vtime_init_idle(struct task_struct *tsk, int cpu);
+extern void __vtime_set_nice(struct rq *rq, struct task_struct *tsk, int old_prio);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_GEN  */
 static inline void vtime_user_enter(struct task_struct *tsk) { }
 static inline void vtime_user_exit(struct task_struct *tsk) { }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7880f4f64d0e..fa56a1bdd5d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4488,6 +4488,7 @@ void set_user_nice(struct task_struct *p, long nice)
 	int old_prio, delta;
 	struct rq_flags rf;
 	struct rq *rq;
+	int old_static;
 
 	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
 		return;
@@ -4498,6 +4499,8 @@ void set_user_nice(struct task_struct *p, long nice)
 	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
+	old_static = p->static_prio;
+
 	/*
 	 * The RT priorities are set via sched_setscheduler(), but we still
 	 * allow the 'normal' nice value to be set - but as expected
@@ -4532,7 +4535,9 @@ void set_user_nice(struct task_struct *p, long nice)
 	}
 	if (running)
 		set_next_task(rq, p);
+
 out_unlock:
+	vtime_set_nice(rq, p, old_static);
 	task_rq_unlock(rq, p, &rf);
 }
 EXPORT_SYMBOL(set_user_nice);
@@ -4668,8 +4673,8 @@ static struct task_struct *find_process_by_pid(pid_t pid)
  */
 #define SETPARAM_POLICY	-1
 
-static void __setscheduler_params(struct task_struct *p,
-		const struct sched_attr *attr)
+static void __setscheduler_params(struct rq *rq, struct task_struct *p,
+				  const struct sched_attr *attr)
 {
 	int policy = attr->sched_policy;
 
@@ -4680,8 +4685,11 @@ static void __setscheduler_params(struct task_struct *p,
 
 	if (dl_policy(policy))
 		__setparam_dl(p, attr);
-	else if (fair_policy(policy))
+	else if (fair_policy(policy)) {
+		int old_prio = p->static_prio;
 		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
+		vtime_set_nice(rq, p, old_prio);
+	}
 
 	/*
 	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
@@ -4704,7 +4712,7 @@ static void __setscheduler(struct rq *rq, struct task_struct *p,
 	if (attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)
 		return;
 
-	__setscheduler_params(p, attr);
+	__setscheduler_params(rq, p, attr);
 
 	/*
 	 * Keep a potential priority boosting if called from
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 687b8684e480..e09194415c35 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -733,16 +733,60 @@ static void vtime_account_system(struct task_struct *tsk,
 	}
 }
 
+static void vtime_account_guest_delta(struct task_struct *tsk,
+				      struct vtime *vtime,
+				      u64 delta, u64 thresh)
+{
+	enum cpu_usage_stat index;
+
+	vtime->gtime += delta;
+
+	if (vtime->gtime < thresh)
+		return;
+
+	if (vtime->nice)
+		index = CPUTIME_GUEST_NICE;
+	else
+		index = CPUTIME_GUEST;
+
+	account_guest_time_index(tsk, vtime->gtime, index);
+	vtime->gtime = 0;
+}
+
 static void vtime_account_guest(struct task_struct *tsk,
 				struct vtime *vtime)
 {
-	vtime->gtime += get_vtime_delta(vtime);
-	if (vtime->gtime >= TICK_NSEC) {
-		account_guest_time(tsk, vtime->gtime);
-		vtime->gtime = 0;
-	}
+	vtime_account_guest_delta(tsk, vtime, get_vtime_delta(vtime), TICK_NSEC);
 }
 
+static void vtime_account_user_delta(struct task_struct *tsk,
+				     struct vtime *vtime,
+				     u64 delta, u64 thresh)
+{
+	enum cpu_usage_stat index;
+
+	vtime->utime += delta;
+
+	if (vtime->utime < thresh)
+		return;
+
+	if (vtime->nice)
+		index = CPUTIME_NICE;
+	else
+		index = CPUTIME_USER;
+
+	account_user_time_index(tsk, vtime->utime, index);
+	vtime->utime = 0;
+
+}
+
+static void vtime_account_user(struct task_struct *tsk,
+			       struct vtime *vtime)
+{
+	vtime_account_user_delta(tsk, vtime, get_vtime_delta(vtime), TICK_NSEC);
+}
+
+
 static void __vtime_account_kernel(struct task_struct *tsk,
 				   struct vtime *vtime)
 {
@@ -780,11 +824,7 @@ void vtime_user_exit(struct task_struct *tsk)
 	struct vtime *vtime = &tsk->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	vtime->utime += get_vtime_delta(vtime);
-	if (vtime->utime >= TICK_NSEC) {
-		account_user_time(tsk, vtime->utime);
-		vtime->utime = 0;
-	}
+	vtime_account_user(tsk, vtime);
 	vtime->state = VTIME_SYS;
 	write_seqcount_end(&vtime->seqcount);
 }
@@ -848,6 +888,7 @@ void vtime_task_switch_generic(struct task_struct *prev)
 		vtime->state = VTIME_SYS;
 	vtime->starttime = sched_clock();
 	vtime->cpu = smp_processor_id();
+	vtime->nice = (task_nice(current) > 0) ? 1 : 0;
 	write_seqcount_end(&vtime->seqcount);
 }
 
@@ -865,6 +906,81 @@ void vtime_init_idle(struct task_struct *t, int cpu)
 	local_irq_restore(flags);
 }
 
+static void vtime_set_nice_local(void)
+{
+	struct task_struct *t = current;
+	struct vtime *vtime = &t->vtime;
+	u64 utime = 0, gtime = 0;
+
+	write_seqcount_begin(&vtime->seqcount);
+
+	if (vtime->state == VTIME_USER)
+		utime += get_vtime_delta(vtime);
+	else if (vtime->state == VTIME_GUEST)
+		gtime += get_vtime_delta(vtime);
+
+	vtime_account_user_delta(t, vtime, utime, 1);
+	vtime_account_guest_delta(t, vtime, gtime, 1);
+	vtime->nice = (task_nice(t) > 0) ? 1 : 0;
+	write_seqcount_end(&vtime->seqcount);
+}
+
+static void vtime_set_nice_remote(struct irq_work *work)
+{
+	struct vtime *vtime = &current->vtime;
+	int nice = task_nice(current);
+	/*
+	 * Make sure nice state actually toggled. We might have raced in
+	 * 2 ways:
+	 *
+	 * - Reniced Task has scheduled out before the IPI reached out,
+	 *   vtime->nice will be evaluated next time it schedules in.
+	 *
+	 * - Another nice update happened before the IPI reached out
+	 *   that cancelled the need for an update. We don't care if a
+	 *   few nanoseconds of cputime are misaccounted.
+	 */
+	if (nice > 0 && vtime->nice)
+		return;
+	if (nice <= 0 && !vtime->nice)
+		return;
+
+	vtime_set_nice_local();
+}
+
+static DEFINE_PER_CPU(struct irq_work, vtime_set_nice_work) = {
+	.func = vtime_set_nice_remote,
+};
+
+void __vtime_set_nice(struct rq *rq, struct task_struct *p, int old_prio)
+{
+	int nice, old_nice = PRIO_TO_NICE(old_prio);
+	int cpu = cpu_of(rq);
+
+	lockdep_assert_held(&rq->lock);
+	/*
+	 * Task not running, nice update will be seen by vtime on its
+	 * next context switch.
+	 */
+	if (!task_current(rq, p))
+		return;
+
+	nice = task_nice(p);
+
+	/* Task stays nice, still accounted as nice in kcpustat */
+	if (old_nice > 0 && nice > 0)
+		return;
+
+	/* Task stays rude, still accounted as non-nice in kcpustat */
+	if (old_nice <= 0 && nice <= 0)
+		return;
+
+	if (p == current)
+		vtime_set_nice_local();
+	else
+		irq_work_queue_on(&per_cpu(vtime_set_nice_work, cpu), cpu);
+}
+
 u64 task_gtime(struct task_struct *t)
 {
 	struct vtime *vtime = &t->vtime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0db2c1b3361e..b870042e65ae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1895,6 +1895,24 @@ static inline int sched_tick_offload_init(void) { return 0; }
 static inline void sched_update_tick_dependency(struct rq *rq) { }
 #endif
 
+static inline void vtime_set_nice(struct rq *rq,
+				  struct task_struct *p, int old_prio)
+{
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
+	int cpu;
+
+	if (!vtime_accounting_enabled())
+		return;
+
+	cpu = cpu_of(rq);
+
+	if (!vtime_accounting_enabled_cpu(cpu))
+		return;
+
+	__vtime_set_nice(rq, p, old_prio);
+#endif
+}
+
 static inline void add_nr_running(struct rq *rq, unsigned count)
 {
 	unsigned prev_nr = rq->nr_running;
-- 
2.23.0

