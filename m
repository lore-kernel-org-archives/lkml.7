Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF704ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CE721835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfJIM7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:59:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50952 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbfJIM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:59:43 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIBYp-0002qn-HN; Wed, 09 Oct 2019 14:59:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 57AF01C0315;
        Wed,  9 Oct 2019 14:59:20 +0200 (CEST)
Date:   Wed, 09 Oct 2019 12:59:20 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cputime: Spare a seqcount lock/unlock cycle
 on context switch
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191003161745.28464-3-frederic@kernel.org>
References: <20191003161745.28464-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157062596029.9978.18197974483711646093.tip-bot2@tip-bot2>
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

Commit-ID:     8d495477d62e4397207f22a432fcaa86d9f2bc2d
Gitweb:        https://git.kernel.org/tip/8d495477d62e4397207f22a432fcaa86d9f2bc2d
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 03 Oct 2019 18:17:45 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Oct 2019 12:39:26 +02:00

sched/cputime: Spare a seqcount lock/unlock cycle on context switch

On context switch we are locking the vtime seqcount of the scheduling-out
task twice:

 * On vtime_task_switch_common(), when we flush the pending vtime through
   vtime_account_system()

 * On arch_vtime_task_switch() to reset the vtime state.

This is pointless as these actions can be performed without the need
to unlock/lock in the middle. The reason these steps are separated is to
consolidate a very small amount of common code between
CONFIG_VIRT_CPU_ACCOUNTING_GEN and CONFIG_VIRT_CPU_ACCOUNTING_NATIVE.

Performance in this fast path is definitely a priority over artificial
code factorization so split the task switch code between GEN and
NATIVE and mutualize the parts than can run under a single seqcount
locked block.

As a side effect, vtime_account_idle() becomes included in the seqcount
protection. This happens to be a welcome preparation in order to
properly support kcpustat under vtime in the future and fetch
CPUTIME_IDLE without race.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Link: https://lkml.kernel.org/r/20191003161745.28464-3-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/vtime.h  | 32 ++++++++++++++++----------------
 kernel/sched/cputime.c | 30 +++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 2fd247f..d9160ab 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -14,8 +14,12 @@ struct task_struct;
  * vtime_accounting_cpu_enabled() definitions/declarations
  */
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE)
+
 static inline bool vtime_accounting_cpu_enabled(void) { return true; }
+extern void vtime_task_switch(struct task_struct *prev);
+
 #elif defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
+
 /*
  * Checks if vtime is enabled on some CPU. Cputime readers want to be careful
  * in that case and compute the tickless cputime.
@@ -36,33 +40,29 @@ static inline bool vtime_accounting_cpu_enabled(void)
 
 	return false;
 }
+
+extern void vtime_task_switch_generic(struct task_struct *prev);
+
+static inline void vtime_task_switch(struct task_struct *prev)
+{
+	if (vtime_accounting_cpu_enabled())
+		vtime_task_switch_generic(prev);
+}
+
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
+
 static inline bool vtime_accounting_cpu_enabled(void) { return false; }
-#endif
+static inline void vtime_task_switch(struct task_struct *prev) { }
 
+#endif
 
 /*
  * Common vtime APIs
  */
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
-
-#ifdef __ARCH_HAS_VTIME_TASK_SWITCH
-extern void vtime_task_switch(struct task_struct *prev);
-#else
-extern void vtime_common_task_switch(struct task_struct *prev);
-static inline void vtime_task_switch(struct task_struct *prev)
-{
-	if (vtime_accounting_cpu_enabled())
-		vtime_common_task_switch(prev);
-}
-#endif /* __ARCH_HAS_VTIME_TASK_SWITCH */
-
 extern void vtime_account_kernel(struct task_struct *tsk);
 extern void vtime_account_idle(struct task_struct *tsk);
-
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
-
-static inline void vtime_task_switch(struct task_struct *prev) { }
 static inline void vtime_account_kernel(struct task_struct *tsk) { }
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index b45932e..cef23c2 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -405,9 +405,10 @@ static inline void irqtime_account_process_tick(struct task_struct *p, int user_
 /*
  * Use precise platform statistics if available:
  */
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+
 # ifndef __ARCH_HAS_VTIME_TASK_SWITCH
-void vtime_common_task_switch(struct task_struct *prev)
+void vtime_task_switch(struct task_struct *prev)
 {
 	if (is_idle_task(prev))
 		vtime_account_idle(prev);
@@ -418,10 +419,7 @@ void vtime_common_task_switch(struct task_struct *prev)
 	arch_vtime_task_switch(prev);
 }
 # endif
-#endif /* CONFIG_VIRT_CPU_ACCOUNTING */
-
 
-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 /*
  * Archs that account the whole time spent in the idle task
  * (outside irq) as idle time can rely on this and just implement
@@ -731,6 +729,16 @@ static void vtime_account_guest(struct task_struct *tsk,
 	}
 }
 
+static void __vtime_account_kernel(struct task_struct *tsk,
+				   struct vtime *vtime)
+{
+	/* We might have scheduled out from guest path */
+	if (tsk->flags & PF_VCPU)
+		vtime_account_guest(tsk, vtime);
+	else
+		vtime_account_system(tsk, vtime);
+}
+
 void vtime_account_kernel(struct task_struct *tsk)
 {
 	struct vtime *vtime = &tsk->vtime;
@@ -739,11 +747,7 @@ void vtime_account_kernel(struct task_struct *tsk)
 		return;
 
 	write_seqcount_begin(&vtime->seqcount);
-	/* We might have scheduled out from guest path */
-	if (tsk->flags & PF_VCPU)
-		vtime_account_guest(tsk, vtime);
-	else
-		vtime_account_system(tsk, vtime);
+	__vtime_account_kernel(tsk, vtime);
 	write_seqcount_end(&vtime->seqcount);
 }
 
@@ -804,11 +808,15 @@ void vtime_account_idle(struct task_struct *tsk)
 	account_idle_time(get_vtime_delta(&tsk->vtime));
 }
 
-void arch_vtime_task_switch(struct task_struct *prev)
+void vtime_task_switch_generic(struct task_struct *prev)
 {
 	struct vtime *vtime = &prev->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
+	if (is_idle_task(prev))
+		vtime_account_idle(prev);
+	else
+		__vtime_account_kernel(prev, vtime);
 	vtime->state = VTIME_INACTIVE;
 	write_seqcount_end(&vtime->seqcount);
 
