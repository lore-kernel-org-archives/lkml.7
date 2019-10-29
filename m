Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC665CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEF820874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbfJ2JxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:53:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47812 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733005AbfJ2Jwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:47 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAs-0004O4-1P; Tue, 29 Oct 2019 10:52:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9E31A1C047C;
        Tue, 29 Oct 2019 10:52:20 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:20 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/vtime: Rename vtime_accounting_cpu_enabled()
 to vtime_accounting_enabled_this_cpu()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191016025700.31277-9-frederic@kernel.org>
References: <20191016025700.31277-9-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157234274038.29376.7255236944838511857.tip-bot2@tip-bot2>
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

Commit-ID:     e44fcb4b7a299602fb300b82a546c0b8a50d9d90
Gitweb:        https://git.kernel.org/tip/e44fcb4b7a299602fb300b82a546c0b8a50d9d90
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 16 Oct 2019 04:56:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:14 +01:00

sched/vtime: Rename vtime_accounting_cpu_enabled() to vtime_accounting_enabled_this_cpu()

Standardize the naming on top of the vtime_accounting_enabled_*() base.
Also make it clear we are checking the vtime state of the
*current* CPU with this function. We'll need to add an API to check that
state on remote CPUs as well, so we must disambiguate the naming.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rjw@rjwysocki.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Link: https://lkml.kernel.org/r/20191016025700.31277-9-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking.h |  4 ++--
 include/linux/vtime.h            | 10 +++++-----
 kernel/sched/cputime.c           |  2 +-
 kernel/time/tick-sched.c         |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index c9065ad..64ec828 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -103,7 +103,7 @@ static inline void context_tracking_init(void) { }
 /* must be called with irqs disabled */
 static inline void guest_enter_irqoff(void)
 {
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_enter(current);
 	else
 		current->flags |= PF_VCPU;
@@ -127,7 +127,7 @@ static inline void guest_exit_irqoff(void)
 	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
 
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_exit(current);
 	else
 		current->flags &= ~PF_VCPU;
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 54e9151..eb2e7a1 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -11,11 +11,11 @@
 struct task_struct;
 
 /*
- * vtime_accounting_cpu_enabled() definitions/declarations
+ * vtime_accounting_enabled_this_cpu() definitions/declarations
  */
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE)
 
-static inline bool vtime_accounting_cpu_enabled(void) { return true; }
+static inline bool vtime_accounting_enabled_this_cpu(void) { return true; }
 extern void vtime_task_switch(struct task_struct *prev);
 
 #elif defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
@@ -31,7 +31,7 @@ static inline bool vtime_accounting_enabled(void)
 	return context_tracking_enabled();
 }
 
-static inline bool vtime_accounting_cpu_enabled(void)
+static inline bool vtime_accounting_enabled_this_cpu(void)
 {
 	if (vtime_accounting_enabled()) {
 		if (context_tracking_enabled_this_cpu())
@@ -45,13 +45,13 @@ extern void vtime_task_switch_generic(struct task_struct *prev);
 
 static inline void vtime_task_switch(struct task_struct *prev)
 {
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		vtime_task_switch_generic(prev);
 }
 
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
-static inline bool vtime_accounting_cpu_enabled(void) { return false; }
+static inline bool vtime_accounting_enabled_this_cpu(void) { return false; }
 static inline void vtime_task_switch(struct task_struct *prev) { }
 
 #endif
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 34086af..b931a19 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -475,7 +475,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
 	u64 cputime, steal;
 	struct rq *rq = this_rq();
 
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		return;
 
 	if (sched_clock_irqtime) {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9558517..c274823 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1119,7 +1119,7 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	unsigned long ticks;
 
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		return;
 	/*
 	 * We stopped the tick in idle. Update process times would miss the
