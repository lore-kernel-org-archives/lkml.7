Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E0DC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB29217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 03:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573009791;
	bh=5d3jodw8Ujz7IUIPxTMO7wvUsEtvGfTnaxFnwWf0kl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xo73yg7zzgAWwbah1JwDRR0Msf9g/eJKGEY+qVXxErDGo/WZIR+y1/6YdaL5e20Hf
	 IUrIPaJeOFstiEtzjRtXmjN9SvLCmEgJruC8wUQVKcCrU2UmoRGLW03KH+BG+UBnQ6
	 i7ADXW+ht58XCt6UZA3aWl0+BUY7KbEvojY1DXKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbfKFDI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 22:08:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388236AbfKFDIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:23 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2DC520659;
        Wed,  6 Nov 2019 03:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573009702;
        bh=5d3jodw8Ujz7IUIPxTMO7wvUsEtvGfTnaxFnwWf0kl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StWKR/gAK9SIMxhISd8nK7x0xxhFcyAlL1hB+RLYPat1K6P01Ic1IJp6S20Njo9+4
         Oe2NYFvHTX/qkI/69naYaAbpHIJ4+SNQ6P2cdpL1366gWDzOJ3ndertIyo0QSiy5wD
         GFowlsM05s4dYO0fNLxbtf6OUpuR4K8JE2Q/72PM=
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
Subject: [PATCH 2/9] sched/cputime: Standardize the kcpustat index based accounting functions
Date:   Wed,  6 Nov 2019 04:08:00 +0100
Message-Id: <20191106030807.31091-3-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030807.31091-1-frederic@kernel.org>
References: <20191106030807.31091-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sanitize a bit the functions that do cputime accounting with custom
kcpustat indexes:

* Rename account_system_index_time() to account_system_time_index() to
  comply with account_guest/user_time_index()

* Use proper enum cpu_usage_stat type in account_system_time()

* Reorder task_group_account_field() parameters to comply with those of
  account_*_time_index().

* Rename task_group_account_field()'s tmp parameter to cputime

* Precise the type of index in task_group_account_field(): enum cpu_usage_stat

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/kernel/time.c     |  6 +++---
 arch/powerpc/kernel/time.c  |  6 +++---
 arch/s390/kernel/vtime.c    |  2 +-
 include/linux/kernel_stat.h |  2 +-
 kernel/sched/cputime.c      | 22 +++++++++++-----------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 91b4024c9351..836e17c8b004 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -79,17 +79,17 @@ void vtime_flush(struct task_struct *tsk)
 
 	if (ti->stime) {
 		delta = cycle_to_nsec(ti->stime);
-		account_system_index_time(tsk, delta, CPUTIME_SYSTEM);
+		account_system_time_index(tsk, delta, CPUTIME_SYSTEM);
 	}
 
 	if (ti->hardirq_time) {
 		delta = cycle_to_nsec(ti->hardirq_time);
-		account_system_index_time(tsk, delta, CPUTIME_IRQ);
+		account_system_time_index(tsk, delta, CPUTIME_IRQ);
 	}
 
 	if (ti->softirq_time) {
 		delta = cycle_to_nsec(ti->softirq_time);
-		account_system_index_time(tsk, delta, CPUTIME_SOFTIRQ);
+		account_system_time_index(tsk, delta, CPUTIME_SOFTIRQ);
 	}
 
 	ti->utime = 0;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 84827da01d45..f03469fe398b 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -418,14 +418,14 @@ void vtime_flush(struct task_struct *tsk)
 		account_idle_time(cputime_to_nsecs(acct->idle_time));
 
 	if (acct->stime)
-		account_system_index_time(tsk, cputime_to_nsecs(acct->stime),
+		account_system_time_index(tsk, cputime_to_nsecs(acct->stime),
 					  CPUTIME_SYSTEM);
 
 	if (acct->hardirq_time)
-		account_system_index_time(tsk, cputime_to_nsecs(acct->hardirq_time),
+		account_system_time_index(tsk, cputime_to_nsecs(acct->hardirq_time),
 					  CPUTIME_IRQ);
 	if (acct->softirq_time)
-		account_system_index_time(tsk, cputime_to_nsecs(acct->softirq_time),
+		account_system_time_index(tsk, cputime_to_nsecs(acct->softirq_time),
 					  CPUTIME_SOFTIRQ);
 
 	vtime_flush_scaled(tsk, acct);
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 8df10d3c8f6c..3428f28d3df1 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -115,7 +115,7 @@ static void account_system_index_scaled(struct task_struct *p, u64 cputime,
 					enum cpu_usage_stat index)
 {
 	p->stimescaled += cputime_to_nsecs(scale_vtime(cputime));
-	account_system_index_time(p, cputime_to_nsecs(cputime), index);
+	account_system_time_index(p, cputime_to_nsecs(cputime), index);
 }
 
 /*
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 79781196eb25..1b9b97f6946e 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -92,7 +92,7 @@ static inline u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 extern void account_user_time(struct task_struct *, u64);
 extern void account_guest_time(struct task_struct *, u64);
 extern void account_system_time(struct task_struct *, int, u64);
-extern void account_system_index_time(struct task_struct *, u64,
+extern void account_system_time_index(struct task_struct *, u64,
 				      enum cpu_usage_stat);
 extern void account_steal_time(u64);
 extern void account_idle_time(u64);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 738ed7db615e..687b8684e480 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -95,8 +95,8 @@ static u64 irqtime_tick_accounted(u64 dummy)
 
 #endif /* !CONFIG_IRQ_TIME_ACCOUNTING */
 
-static inline void task_group_account_field(struct task_struct *p, int index,
-					    u64 tmp)
+static inline void task_group_account_field(struct task_struct *p, u64 cputime,
+					    enum cpu_usage_stat index)
 {
 	/*
 	 * Since all updates are sure to touch the root cgroup, we
@@ -104,9 +104,9 @@ static inline void task_group_account_field(struct task_struct *p, int index,
 	 * is the only cgroup, then nothing else should be necessary.
 	 *
 	 */
-	__this_cpu_add(kernel_cpustat.cpustat[index], tmp);
+	__this_cpu_add(kernel_cpustat.cpustat[index], cputime);
 
-	cgroup_account_cputime_field(p, index, tmp);
+	cgroup_account_cputime_field(p, index, cputime);
 }
 
 static void account_user_time_index(struct task_struct *p,
@@ -117,7 +117,7 @@ static void account_user_time_index(struct task_struct *p,
 	account_group_user_time(p, cputime);
 
 	/* Add user time to cpustat. */
-	task_group_account_field(p, index, cputime);
+	task_group_account_field(p, cputime, index);
 
 	/* Account for user time used */
 	acct_account_cputime(p);
@@ -175,7 +175,7 @@ void account_guest_time(struct task_struct *p, u64 cputime)
  * @cputime: the CPU time spent in kernel space since the last update
  * @index: pointer to cpustat field that has to be updated
  */
-void account_system_index_time(struct task_struct *p,
+void account_system_time_index(struct task_struct *p,
 			       u64 cputime, enum cpu_usage_stat index)
 {
 	/* Add system time to process. */
@@ -183,7 +183,7 @@ void account_system_index_time(struct task_struct *p,
 	account_group_system_time(p, cputime);
 
 	/* Add system time to cpustat. */
-	task_group_account_field(p, index, cputime);
+	task_group_account_field(p, cputime, index);
 
 	/* Account for system time used */
 	acct_account_cputime(p);
@@ -197,7 +197,7 @@ void account_system_index_time(struct task_struct *p,
  */
 void account_system_time(struct task_struct *p, int hardirq_offset, u64 cputime)
 {
-	int index;
+	enum cpu_usage_stat index;
 
 	if ((p->flags & PF_VCPU) && (irq_count() - hardirq_offset == 0)) {
 		account_guest_time(p, cputime);
@@ -211,7 +211,7 @@ void account_system_time(struct task_struct *p, int hardirq_offset, u64 cputime)
 	else
 		index = CPUTIME_SYSTEM;
 
-	account_system_index_time(p, cputime, index);
+	account_system_time_index(p, cputime, index);
 }
 
 /*
@@ -392,7 +392,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 		 * So, we have to handle it separately here.
 		 * Also, p->stime needs to be updated for ksoftirqd.
 		 */
-		account_system_index_time(p, cputime, CPUTIME_SOFTIRQ);
+		account_system_time_index(p, cputime, CPUTIME_SOFTIRQ);
 	} else if (user_tick) {
 		account_user_time(p, cputime);
 	} else if (p == rq->idle) {
@@ -400,7 +400,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 	} else if (p->flags & PF_VCPU) { /* System time or guest time */
 		account_guest_time(p, cputime);
 	} else {
-		account_system_index_time(p, cputime, CPUTIME_SYSTEM);
+		account_system_time_index(p, cputime, CPUTIME_SYSTEM);
 	}
 }
 
-- 
2.23.0

