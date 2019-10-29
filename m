Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D73CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9326120717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbfJ2Jwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:52:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47785 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730883AbfJ2Jwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAl-0004NT-VX; Tue, 29 Oct 2019 10:52:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 964421C0073;
        Tue, 29 Oct 2019 10:52:19 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:19 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/kcpustat: Introduce vtime-aware kcpustat
 accessor for CPUTIME_SYSTEM
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191025020303.19342-1-frederic@kernel.org>
References: <20191025020303.19342-1-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157234273931.29376.8892610322143430578.tip-bot2@tip-bot2>
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

Commit-ID:     64eea63c19a2c386a96638f4e54a1355510709e3
Gitweb:        https://git.kernel.org/tip/64eea63c19a2c386a96638f4e54a1355510709e3
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 25 Oct 2019 04:03:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:17 +01:00

sched/kcpustat: Introduce vtime-aware kcpustat accessor for CPUTIME_SYSTEM

Kcpustat is not correctly supported on nohz_full CPUs. The tick doesn't
fire and the cputime therefore doesn't move forward. The issue has shown
up after the vanishing of the remaining 1Hz which has made the stall
visible.

We are solving that with checking the task running on a CPU through RCU
and reading its vtime delta that we add to the raw kcpustat values.

We make sure that we fetch a coherent raw-kcpustat/vtime-delta couple
sequence while checking that the CPU referred by the target vtime is the
correct one, under the locked vtime seqcount.

Only CPUTIME_SYSTEM is handled here as a start because it's the trivial
case. User and guest time will require more preparation work to
correctly handle niceness.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wanpeng Li <wanpengli@tencent.com>
Link: https://lkml.kernel.org/r/20191025020303.19342-1-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kernel_stat.h | 11 +++++-
 kernel/sched/cputime.c      | 82 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 7ee2bb4..7978119 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -78,6 +78,17 @@ static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
 	return kstat_cpu(cpu).irqs_sum;
 }
 
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
+extern u64 kcpustat_field(struct kernel_cpustat *kcpustat,
+			  enum cpu_usage_stat usage, int cpu);
+#else
+static inline u64 kcpustat_field(struct kernel_cpustat *kcpustat,
+				 enum cpu_usage_stat usage, int cpu)
+{
+	return kcpustat->cpustat[usage];
+}
+#endif
+
 extern void account_user_time(struct task_struct *, u64);
 extern void account_guest_time(struct task_struct *, u64);
 extern void account_system_time(struct task_struct *, int, u64);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index b931a19..e0cd206 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -911,4 +911,86 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 			*utime += vtime->utime + delta;
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 }
+
+static int kcpustat_field_vtime(u64 *cpustat,
+				struct vtime *vtime,
+				enum cpu_usage_stat usage,
+				int cpu, u64 *val)
+{
+	unsigned int seq;
+	int err;
+
+	do {
+		seq = read_seqcount_begin(&vtime->seqcount);
+
+		/*
+		 * We raced against context switch, fetch the
+		 * kcpustat task again.
+		 */
+		if (vtime->cpu != cpu && vtime->cpu != -1)
+			return -EAGAIN;
+
+		/*
+		 * Two possible things here:
+		 * 1) We are seeing the scheduling out task (prev) or any past one.
+		 * 2) We are seeing the scheduling in task (next) but it hasn't
+		 *    passed though vtime_task_switch() yet so the pending
+		 *    cputime of the prev task may not be flushed yet.
+		 *
+		 * Case 1) is ok but 2) is not. So wait for a safe VTIME state.
+		 */
+		if (vtime->state == VTIME_INACTIVE)
+			return -EAGAIN;
+
+		err = 0;
+
+		*val = cpustat[usage];
+
+		if (vtime->state == VTIME_SYS)
+			*val += vtime->stime + vtime_delta(vtime);
+
+	} while (read_seqcount_retry(&vtime->seqcount, seq));
+
+	return 0;
+}
+
+u64 kcpustat_field(struct kernel_cpustat *kcpustat,
+		   enum cpu_usage_stat usage, int cpu)
+{
+	u64 *cpustat = kcpustat->cpustat;
+	struct rq *rq;
+	u64 val;
+	int err;
+
+	if (!vtime_accounting_enabled_cpu(cpu))
+		return cpustat[usage];
+
+	/* Only support sys vtime for now */
+	if (usage != CPUTIME_SYSTEM)
+		return cpustat[usage];
+
+	rq = cpu_rq(cpu);
+
+	for (;;) {
+		struct task_struct *curr;
+		struct vtime *vtime;
+
+		rcu_read_lock();
+		curr = rcu_dereference(rq->curr);
+		if (WARN_ON_ONCE(!curr)) {
+			rcu_read_unlock();
+			return cpustat[usage];
+		}
+
+		vtime = &curr->vtime;
+		err = kcpustat_field_vtime(cpustat, vtime, usage, cpu, &val);
+		rcu_read_unlock();
+
+		if (!err)
+			return val;
+
+		cpu_relax();
+	}
+}
+EXPORT_SYMBOL_GPL(kcpustat_field);
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
