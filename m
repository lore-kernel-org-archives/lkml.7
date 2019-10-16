Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A779ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D443221D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194662;
	bh=wpi0dsjlwuqDZqP122meByKO1xyjIDCM0Vm/2WYURTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PyFjklAA9EidLv5Td5jkspixHaY6VndLXAXqHtBQB1biwqBbK21WcMEH0phCVnSX6
	 VyMBZUtOIySeSQct7ls9ZCJV5otEskVjthnYdgan3EFWUl9KE485Q1YQuD96vYe4q4
	 gZSoJSs1dFTmvP2fImCi0ImomBCwkjOd1livJ/Ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390788AbfJPC5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390775AbfJPC5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:39 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F60D20663;
        Wed, 16 Oct 2019 02:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194658;
        bh=wpi0dsjlwuqDZqP122meByKO1xyjIDCM0Vm/2WYURTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a33mqc8vMCvvZI/WsYudrn8K02wGU5Clh7twZ5MPW71xOd2/7YnVBxQgepD8Yc6vo
         +IEOOqodzI0B+hhKFJfWTAaknO2N11Rl0Nwz2UmQghKDxOFL/scRAwuNzT+oPRE023
         uVb8aUfQreQm2+2kBnusolDR6eVydzCVw9uCcf5I=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 11/14] sched/kcpustat: Introduce vtime-aware kcpustat accessor for CPUTIME_SYSTEM
Date:   Wed, 16 Oct 2019 04:56:57 +0200
Message-Id: <20191016025700.31277-12-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kernel_stat.h | 11 +++++
 kernel/sched/cputime.c      | 83 +++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 7ee2bb43b251..79781196eb25 100644
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
index b931a19df093..bff5bf33d27e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -911,4 +911,87 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
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
+		if (vtime->cpu != cpu && vtime->cpu != -1) {
+			err = -EAGAIN;
+			continue;
+		}
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
+		if (vtime->state == VTIME_INACTIVE) {
+			err = -EAGAIN;
+			continue;
+		}
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
+	return err;
+}
+
+u64 kcpustat_field(struct kernel_cpustat *kcpustat,
+		   enum cpu_usage_stat usage, int cpu)
+{
+	u64 val;
+	int err;
+	u64 *cpustat = kcpustat->cpustat;
+
+	if (!vtime_accounting_enabled_cpu(cpu))
+		return cpustat[usage];
+
+	/* Only support sys vtime for now */
+	if (usage != CPUTIME_SYSTEM)
+		return cpustat[usage];
+
+	rcu_read_lock();
+
+	do {
+		struct rq *rq = cpu_rq(cpu);
+		struct task_struct *curr;
+		struct vtime *vtime;
+
+		curr = rcu_dereference(rq->curr);
+		if (WARN_ON_ONCE(!curr)) {
+			val = cpustat[usage];
+			break;
+		}
+
+		vtime = &curr->vtime;
+		err = kcpustat_field_vtime(cpustat, vtime, usage, cpu, &val);
+	} while (err == -EAGAIN);
+
+	rcu_read_unlock();
+
+	return val;
+}
+
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
-- 
2.23.0

