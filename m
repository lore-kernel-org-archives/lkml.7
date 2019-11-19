Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4402EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1077522463
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574205757;
	bh=AKcwRzH4TgveT6g3oTNB2ZueA/+QcdjFZeuwHsg7rKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gYREFF69HCWJWxWM4tpl+ps5tiiwRDlzAAJQ2btBbqqB5ia1WfqmH6j1M8SNw+R/y
	 5JOOMM7RBYYjS1lwh5wjjnKLZt1miuGizrAfVWVXknRFsYlLKpcog9nMzT3nkjKmWi
	 7StHSPXEBl3pQk80KVIiiocO8sDzKT02g0aCzVwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKSXWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:22:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfKSXWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 18:22:33 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B13B22460;
        Tue, 19 Nov 2019 23:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574205752;
        bh=AKcwRzH4TgveT6g3oTNB2ZueA/+QcdjFZeuwHsg7rKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZ3KB8OscaJLdx0zb5cCdA1+QAn5rYLZfGMW1kor+cBKt9j2rjkrk4I1bkYBkBoXQ
         yFYaj30zpFCwrzeE91H3h3jyzxPbVHjnhFYRvbghEsrRoEzqY5MRPfpZo5jkxBHN6y
         ajAauzo2wDtFcIrcWpUiCIhp//AnzNdFudJiSMSo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/6] sched/vtime: Bring all-in-one kcpustat accessor for vtime fields
Date:   Wed, 20 Nov 2019 00:22:14 +0100
Message-Id: <20191119232218.4206-3-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191119232218.4206-1-frederic@kernel.org>
References: <20191119232218.4206-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many callsites want to fetch the values of system, user, user_nice, guest
or guest_nice kcpustat fields altogether or at least a pair of these.

In that case calling kcpustat_field() for each requested field brings
unecessary overhead when we could fetch all of them in a row.

So provide kcpustat_cputime() that fetches all vtime sensitive fields
under the same RCU and seqcount block.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kernel_stat.h |  23 ++++++
 kernel/sched/cputime.c      | 139 ++++++++++++++++++++++++++++++------
 2 files changed, 142 insertions(+), 20 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 79781196eb25..6bd70e464c61 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -78,15 +78,38 @@ static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
 	return kstat_cpu(cpu).irqs_sum;
 }
 
+
+static inline void kcpustat_cputime_raw(u64 *cpustat, u64 *user, u64 *nice,
+					u64 *system, u64 *guest, u64 *guest_nice)
+{
+	*user = cpustat[CPUTIME_USER];
+	*nice = cpustat[CPUTIME_NICE];
+	*system = cpustat[CPUTIME_SYSTEM];
+	*guest = cpustat[CPUTIME_GUEST];
+	*guest_nice = cpustat[CPUTIME_GUEST_NICE];
+}
+
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 extern u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 			  enum cpu_usage_stat usage, int cpu);
+extern void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
+			     u64 *user, u64 *nice, u64 *system,
+			     u64 *guest, u64 *guest_nice);
 #else
 static inline u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 				 enum cpu_usage_stat usage, int cpu)
 {
 	return kcpustat->cpustat[usage];
 }
+
+static inline void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
+				    u64 *user, u64 *nice, u64 *system,
+				    u64 *guest, u64 *guest_nice)
+{
+	kcpustat_cputime_raw(kcpustat->cpustat, user, nice,
+			     system, guest, guest_nice);
+}
+
 #endif
 
 extern void account_user_time(struct task_struct *, u64);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index b2cf544e2109..f576bbb1f4ee 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -912,6 +912,30 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 }
 
+static int vtime_state_check(struct vtime *vtime, int cpu)
+{
+	/*
+	 * We raced against context switch, fetch the
+	 * kcpustat task again.
+	 */
+	if (vtime->cpu != cpu && vtime->cpu != -1)
+		return -EAGAIN;
+
+	/*
+	 * Two possible things here:
+	 * 1) We are seeing the scheduling out task (prev) or any past one.
+	 * 2) We are seeing the scheduling in task (next) but it hasn't
+	 *    passed though vtime_task_switch() yet so the pending
+	 *    cputime of the prev task may not be flushed yet.
+	 *
+	 * Case 1) is ok but 2) is not. So wait for a safe VTIME state.
+	 */
+	if (vtime->state == VTIME_INACTIVE)
+		return -EAGAIN;
+
+	return 0;
+}
+
 static u64 kcpustat_user_vtime(struct vtime *vtime)
 {
 	if (vtime->state == VTIME_USER)
@@ -933,26 +957,9 @@ static int kcpustat_field_vtime(u64 *cpustat,
 	do {
 		seq = read_seqcount_begin(&vtime->seqcount);
 
-		/*
-		 * We raced against context switch, fetch the
-		 * kcpustat task again.
-		 */
-		if (vtime->cpu != cpu && vtime->cpu != -1)
-			return -EAGAIN;
-
-		/*
-		 * Two possible things here:
-		 * 1) We are seeing the scheduling out task (prev) or any past one.
-		 * 2) We are seeing the scheduling in task (next) but it hasn't
-		 *    passed though vtime_task_switch() yet so the pending
-		 *    cputime of the prev task may not be flushed yet.
-		 *
-		 * Case 1) is ok but 2) is not. So wait for a safe VTIME state.
-		 */
-		if (vtime->state == VTIME_INACTIVE)
-			return -EAGAIN;
-
-		err = 0;
+		err = vtime_state_check(vtime, cpu);
+		if (err < 0)
+			return err;
 
 		*val = cpustat[usage];
 
@@ -1024,4 +1031,96 @@ u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 	}
 }
 EXPORT_SYMBOL_GPL(kcpustat_field);
+
+static int kcpustat_cputime_vtime(u64 *cpustat, struct task_struct *tsk,
+				  int cpu, u64 *user, u64 *nice,
+				  u64 *system, u64 *guest, u64 *guest_nice)
+{
+	struct vtime *vtime = &tsk->vtime;
+	unsigned int seq;
+	u64 delta;
+	int err;
+
+	do {
+		seq = read_seqcount_begin(&vtime->seqcount);
+
+		err = vtime_state_check(vtime, cpu);
+		if (err < 0)
+			return err;
+
+		kcpustat_cputime_raw(cpustat, user, nice,
+				     system, guest, guest_nice);
+
+		/* Task is sleeping, dead or idle, nothing to add */
+		if (vtime->state < VTIME_SYS)
+			continue;
+
+		delta = vtime_delta(vtime);
+
+		/*
+		 * Task runs either in user (including guest) or kernel space,
+		 * add pending nohz time to the right place.
+		 */
+		if (vtime->state == VTIME_SYS) {
+			*system += vtime->stime + delta;
+		} else if (vtime->state == VTIME_USER) {
+			if (task_nice(tsk) > 0)
+				*nice += vtime->utime + delta;
+			else
+				*user += vtime->utime + delta;
+		} else {
+			WARN_ON_ONCE(vtime->state != VTIME_GUEST);
+			if (task_nice(tsk) > 0) {
+				*guest_nice += vtime->gtime + delta;
+				*nice += vtime->gtime + delta;
+			} else {
+				*guest += vtime->gtime + delta;
+				*user += vtime->gtime + delta;
+			}
+		}
+	} while (read_seqcount_retry(&vtime->seqcount, seq));
+
+	return err;
+}
+
+void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
+		      u64 *user, u64 *nice, u64 *system,
+		      u64 *guest, u64 *guest_nice)
+{
+	u64 *cpustat = kcpustat->cpustat;
+	struct rq *rq;
+	int err;
+
+	if (!vtime_accounting_enabled_cpu(cpu)) {
+		kcpustat_cputime_raw(cpustat, user, nice,
+				     system, guest, guest_nice);
+		return;
+	}
+
+	rq = cpu_rq(cpu);
+
+	for (;;) {
+		struct task_struct *curr;
+
+		rcu_read_lock();
+		curr = rcu_dereference(rq->curr);
+		if (WARN_ON_ONCE(!curr)) {
+			rcu_read_unlock();
+			kcpustat_cputime_raw(cpustat, user, nice,
+					     system, guest, guest_nice);
+			return;
+		}
+
+		err = kcpustat_cputime_vtime(cpustat, curr, cpu, user,
+					     nice, system, guest, guest_nice);
+		rcu_read_unlock();
+
+		if (!err)
+			return;
+
+		cpu_relax();
+	}
+}
+EXPORT_SYMBOL_GPL(kcpustat_cputime);
+
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
-- 
2.23.0

