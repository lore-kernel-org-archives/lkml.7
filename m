Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EE3C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFD8222C9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573009720;
	bh=2adWG03503CxjQwiKnkzmVP8mIRVy+gwj2DXV59CqCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vZI8Jp732lH4r4YBBkLGwF3VMj8ESobLgb18tH6ZLdNAuYiBPkgIUQq0/r/L34xwf
	 ZJVjamvVycZnWXmlHK2Q+QIPDVXGyjIE3vZ6O5i9ECim+iiMYPyC7f6jkbEF0ZY8V2
	 1OpZSUunKTD7bqATBdyo1erK0s+9Hf6KmSxtVgxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388389AbfKFDIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388315AbfKFDIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:32 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E6521882;
        Wed,  6 Nov 2019 03:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573009711;
        bh=2adWG03503CxjQwiKnkzmVP8mIRVy+gwj2DXV59CqCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJwwUYXT3+79eze5l0Wa2hNmxwGIpEBOV7bJ3oydf77EIYYNtn3bkIS7qRtOsjc4p
         fxPuDzLL1bGs++h+5RSWwPOYhhFHkjrFqlv+ruXJ3P3YrVTdYAYYnUNq84PZvlBlJx
         RB2ZosqUbeUiO3xU6RNsUrDQro58lkH/aBRLRZis=
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
Subject: [PATCH 5/9] sched/vtime: Bring all-in-one kcpustat accessor for vtime fields
Date:   Wed,  6 Nov 2019 04:08:03 +0100
Message-Id: <20191106030807.31091-6-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030807.31091-1-frederic@kernel.org>
References: <20191106030807.31091-1-frederic@kernel.org>
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
 kernel/sched/cputime.c      | 138 ++++++++++++++++++++++++++++++------
 2 files changed, 141 insertions(+), 20 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 1b9b97f6946e..c76daad2d8e2 100644
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
index bf4b61f71194..0006dfccbeb7 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -1042,6 +1042,30 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
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
@@ -1062,26 +1086,9 @@ static int kcpustat_field_vtime(u64 *cpustat,
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
 
@@ -1149,4 +1156,95 @@ u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 	}
 }
 EXPORT_SYMBOL_GPL(kcpustat_field);
+
+static int kcpustat_cputime_vtime(u64 *cpustat, struct vtime *vtime,
+				  int cpu, u64 *user, u64 *nice,
+				  u64 *system, u64 *guest, u64 *guest_nice)
+{
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
+			if (vtime->nice)
+				*nice += vtime->utime + delta;
+			else
+				*user += vtime->utime + delta;
+		} else {
+			WARN_ON_ONCE(vtime->state != VTIME_GUEST);
+			if (vtime->nice) {
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
+		err = kcpustat_cputime_vtime(cpustat, &curr->vtime, cpu, user,
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

