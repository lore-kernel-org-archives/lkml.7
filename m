Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30D9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9A420672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKUQsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:48:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32907 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:48:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXpcm-0000Z7-EP; Thu, 21 Nov 2019 17:48:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1E1051C1A3F;
        Thu, 21 Nov 2019 17:48:08 +0100 (CET)
Date:   Thu, 21 Nov 2019 16:48:08 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/vtime: Bring up complete kcpustat accessor
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121024430.19938-3-frederic@kernel.org>
References: <20191121024430.19938-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157435488802.21853.12523186604595319317.tip-bot2@tip-bot2>
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

Commit-ID:     74722bb223d0f236303b60c9509ff924a9713780
Gitweb:        https://git.kernel.org/tip/74722bb223d0f236303b60c9509ff924a9713780
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 03:44:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Nov 2019 07:33:24 +01:00

sched/vtime: Bring up complete kcpustat accessor

Many callsites want to fetch the values of system, user, user_nice, guest
or guest_nice kcpustat fields altogether or at least a pair of these.

In that case calling kcpustat_field() for each requested field brings
unecessary overhead when we could fetch all of them in a row.

So provide kcpustat_cpu_fetch() that fetches the whole kcpustat array
in a vtime safe way under the same RCU and seqcount block.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Link: https://lkml.kernel.org/r/20191121024430.19938-3-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kernel_stat.h |   7 ++-
 kernel/sched/cputime.c      | 136 +++++++++++++++++++++++++++++------
 2 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 7978119..89f0745 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -81,12 +81,19 @@ static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 extern u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 			  enum cpu_usage_stat usage, int cpu);
+extern void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu);
 #else
 static inline u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 				 enum cpu_usage_stat usage, int cpu)
 {
 	return kcpustat->cpustat[usage];
 }
+
+static inline void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
+{
+	*dst = kcpustat_cpu(cpu);
+}
+
 #endif
 
 extern void account_user_time(struct task_struct *, u64);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 27b5406..d43318a 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -912,6 +912,30 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 }
 
+static int vtime_state_check(struct vtime *vtime, int cpu)
+{
+	/*
+	 * We raced against a context switch, fetch the
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
 
@@ -1025,4 +1032,93 @@ u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 	}
 }
 EXPORT_SYMBOL_GPL(kcpustat_field);
+
+static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
+				    const struct kernel_cpustat *src,
+				    struct task_struct *tsk, int cpu)
+{
+	struct vtime *vtime = &tsk->vtime;
+	unsigned int seq;
+	int err;
+
+	do {
+		u64 *cpustat;
+		u64 delta;
+
+		seq = read_seqcount_begin(&vtime->seqcount);
+
+		err = vtime_state_check(vtime, cpu);
+		if (err < 0)
+			return err;
+
+		*dst = *src;
+		cpustat = dst->cpustat;
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
+			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
+		} else if (vtime->state == VTIME_USER) {
+			if (task_nice(tsk) > 0)
+				cpustat[CPUTIME_NICE] += vtime->utime + delta;
+			else
+				cpustat[CPUTIME_USER] += vtime->utime + delta;
+		} else {
+			WARN_ON_ONCE(vtime->state != VTIME_GUEST);
+			if (task_nice(tsk) > 0) {
+				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
+				cpustat[CPUTIME_NICE] += vtime->gtime + delta;
+			} else {
+				cpustat[CPUTIME_GUEST] += vtime->gtime + delta;
+				cpustat[CPUTIME_USER] += vtime->gtime + delta;
+			}
+		}
+	} while (read_seqcount_retry(&vtime->seqcount, seq));
+
+	return err;
+}
+
+void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
+{
+	const struct kernel_cpustat *src = &kcpustat_cpu(cpu);
+	struct rq *rq;
+	int err;
+
+	if (!vtime_accounting_enabled_cpu(cpu)) {
+		*dst = *src;
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
+			*dst = *src;
+			return;
+		}
+
+		err = kcpustat_cpu_fetch_vtime(dst, src, curr, cpu);
+		rcu_read_unlock();
+
+		if (!err)
+			return;
+
+		cpu_relax();
+	}
+}
+EXPORT_SYMBOL_GPL(kcpustat_cpu_fetch);
+
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
