Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E13C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A6B20895
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574304287;
	bh=Ue1B0LLPG3CxGJuFT54MuyKwfQ0rwUv5ZkF2IWs0GyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hqNpC+Xl/U1XycPWSlgP+f2RAPcPAsCSBawVGjM1qrpKkqrtLnLvFFSsWsmjrYSoj
	 W3g/nrXCCp0Lnn6fw61aQy5GSaoDV6RBUgEUPp+hxlcwOGyU6nVhpsoXLKojbhS2ii
	 6MlSgVVE91hDoC5oXxbbh3IX1K9nezHDruRMVWNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKUCop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:44:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfKUCon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:44:43 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62BA20885;
        Thu, 21 Nov 2019 02:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574304282;
        bh=Ue1B0LLPG3CxGJuFT54MuyKwfQ0rwUv5ZkF2IWs0GyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wIOZuAtRntu96iK2XmiK7ELzMp9Yvj3x6ZN2zZAhjgPDwrilPGrTN9PndqNA09Dqj
         R7xcVdy1JPJahNtlWwQQCLv+vc/7b5ieOT+0IVLi7rUeDc9BxbzvllKje88sy/qZrB
         hdosbSy4wnEfgE21RZDp2nrcz+KKnIrUjb+4c1tQ=
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
Subject: [PATCH 2/6] sched/vtime: Bring up complete kcpustat accessor
Date:   Thu, 21 Nov 2019 03:44:26 +0100
Message-Id: <20191121024430.19938-3-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121024430.19938-1-frederic@kernel.org>
References: <20191121024430.19938-1-frederic@kernel.org>
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

So provide kcpustat_cpu_fetch() that fetches the whole kcpustat array
in a vtime safe way under the same RCU and seqcount block.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kernel_stat.h |   7 ++
 kernel/sched/cputime.c      | 136 ++++++++++++++++++++++++++++++------
 2 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 79781196eb25..89f0745c096d 100644
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
index 27b5406222fc..d43318a489f2 100644
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
-- 
2.23.0

