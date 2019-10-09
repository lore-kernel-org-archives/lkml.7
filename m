Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C736ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C4720B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfJIM7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:59:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50923 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbfJIM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:59:36 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIBYr-0002r1-5p; Wed, 09 Oct 2019 14:59:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 838C01C031F;
        Wed,  9 Oct 2019 14:59:20 +0200 (CEST)
Date:   Wed, 09 Oct 2019 12:59:20 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cputime: Rename vtime_account_system() to
 vtime_account_kernel()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191003161745.28464-2-frederic@kernel.org>
References: <20191003161745.28464-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157062596047.9978.13993465481296426700.tip-bot2@tip-bot2>
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

Commit-ID:     f83eeb1a01689b2691f6f56629ac9f66de8d41c2
Gitweb:        https://git.kernel.org/tip/f83eeb1a01689b2691f6f56629ac9f66de8d41c2
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 03 Oct 2019 18:17:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Oct 2019 12:39:25 +02:00

sched/cputime: Rename vtime_account_system() to vtime_account_kernel()

vtime_account_system() decides if we need to account the time to the
system (__vtime_account_system()) or to the guest (vtime_account_guest()).

So this function is a misnomer as we are on a higher level than
"system". All we know when we call that function is that we are
accounting kernel cputime. Whether it belongs to guest or system time
is a lower level detail.

Rename this function to vtime_account_kernel(). This will clarify things
and avoid too many underscored vtime_account_system() versions.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Link: https://lkml.kernel.org/r/20191003161745.28464-2-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/kernel/time.c          |  4 ++--
 arch/powerpc/kernel/time.c       |  6 +++---
 arch/s390/kernel/vtime.c         |  4 ++--
 include/linux/context_tracking.h |  4 ++--
 include/linux/vtime.h            |  6 +++---
 kernel/sched/cputime.c           | 18 +++++++++---------
 6 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 1e95d32..91b4024 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -132,7 +132,7 @@ static __u64 vtime_delta(struct task_struct *tsk)
 	return delta_stime;
 }
 
-void vtime_account_system(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 {
 	struct thread_info *ti = task_thread_info(tsk);
 	__u64 stime = vtime_delta(tsk);
@@ -146,7 +146,7 @@ void vtime_account_system(struct task_struct *tsk)
 	else
 		ti->stime += stime;
 }
-EXPORT_SYMBOL_GPL(vtime_account_system);
+EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
 void vtime_account_idle(struct task_struct *tsk)
 {
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 6945223..84827da 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -338,7 +338,7 @@ static unsigned long vtime_delta(struct task_struct *tsk,
 	return stime;
 }
 
-void vtime_account_system(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 {
 	unsigned long stime, stime_scaled, steal_time;
 	struct cpu_accounting_data *acct = get_accounting(tsk);
@@ -366,7 +366,7 @@ void vtime_account_system(struct task_struct *tsk)
 #endif
 	}
 }
-EXPORT_SYMBOL_GPL(vtime_account_system);
+EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
 void vtime_account_idle(struct task_struct *tsk)
 {
@@ -395,7 +395,7 @@ static void vtime_flush_scaled(struct task_struct *tsk,
 /*
  * Account the whole cputime accumulated in the paca
  * Must be called with interrupts disabled.
- * Assumes that vtime_account_system/idle() has been called
+ * Assumes that vtime_account_kernel/idle() has been called
  * recently (i.e. since the last entry from usermode) so that
  * get_paca()->user_time_scaled is up to date.
  */
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index c475ca4..8df10d3 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -247,9 +247,9 @@ void vtime_account_irq_enter(struct task_struct *tsk)
 }
 EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
 
-void vtime_account_system(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 __attribute__((alias("vtime_account_irq_enter")));
-EXPORT_SYMBOL_GPL(vtime_account_system);
+EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
 /*
  * Sorted add to a list. List is linear searched until first bigger
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index d05609a..558a209 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -141,7 +141,7 @@ static inline void guest_enter_irqoff(void)
 	 * to assume that it's the stime pending cputime
 	 * to flush.
 	 */
-	vtime_account_system(current);
+	vtime_account_kernel(current);
 	current->flags |= PF_VCPU;
 	rcu_virt_note_context_switch(smp_processor_id());
 }
@@ -149,7 +149,7 @@ static inline void guest_enter_irqoff(void)
 static inline void guest_exit_irqoff(void)
 {
 	/* Flush the guest cputime we spent on the guest */
-	vtime_account_system(current);
+	vtime_account_kernel(current);
 	current->flags &= ~PF_VCPU;
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index a26ed10..2fd247f 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -57,13 +57,13 @@ static inline void vtime_task_switch(struct task_struct *prev)
 }
 #endif /* __ARCH_HAS_VTIME_TASK_SWITCH */
 
-extern void vtime_account_system(struct task_struct *tsk);
+extern void vtime_account_kernel(struct task_struct *tsk);
 extern void vtime_account_idle(struct task_struct *tsk);
 
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 static inline void vtime_task_switch(struct task_struct *prev) { }
-static inline void vtime_account_system(struct task_struct *tsk) { }
+static inline void vtime_account_kernel(struct task_struct *tsk) { }
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
@@ -86,7 +86,7 @@ extern void vtime_account_irq_enter(struct task_struct *tsk);
 static inline void vtime_account_irq_exit(struct task_struct *tsk)
 {
 	/* On hard|softirq exit we always account to hard|softirq cputime */
-	vtime_account_system(tsk);
+	vtime_account_kernel(tsk);
 }
 extern void vtime_flush(struct task_struct *tsk);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 46ed4e1..b45932e 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -412,7 +412,7 @@ void vtime_common_task_switch(struct task_struct *prev)
 	if (is_idle_task(prev))
 		vtime_account_idle(prev);
 	else
-		vtime_account_system(prev);
+		vtime_account_kernel(prev);
 
 	vtime_flush(prev);
 	arch_vtime_task_switch(prev);
@@ -425,7 +425,7 @@ void vtime_common_task_switch(struct task_struct *prev)
 /*
  * Archs that account the whole time spent in the idle task
  * (outside irq) as idle time can rely on this and just implement
- * vtime_account_system() and vtime_account_idle(). Archs that
+ * vtime_account_kernel() and vtime_account_idle(). Archs that
  * have other meaning of the idle time (s390 only includes the
  * time spent by the CPU when it's in low power mode) must override
  * vtime_account().
@@ -436,7 +436,7 @@ void vtime_account_irq_enter(struct task_struct *tsk)
 	if (!in_interrupt() && is_idle_task(tsk))
 		vtime_account_idle(tsk);
 	else
-		vtime_account_system(tsk);
+		vtime_account_kernel(tsk);
 }
 EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
 #endif /* __ARCH_HAS_VTIME_ACCOUNT */
@@ -711,8 +711,8 @@ static u64 get_vtime_delta(struct vtime *vtime)
 	return delta - other;
 }
 
-static void __vtime_account_system(struct task_struct *tsk,
-				   struct vtime *vtime)
+static void vtime_account_system(struct task_struct *tsk,
+				 struct vtime *vtime)
 {
 	vtime->stime += get_vtime_delta(vtime);
 	if (vtime->stime >= TICK_NSEC) {
@@ -731,7 +731,7 @@ static void vtime_account_guest(struct task_struct *tsk,
 	}
 }
 
-void vtime_account_system(struct task_struct *tsk)
+void vtime_account_kernel(struct task_struct *tsk)
 {
 	struct vtime *vtime = &tsk->vtime;
 
@@ -743,7 +743,7 @@ void vtime_account_system(struct task_struct *tsk)
 	if (tsk->flags & PF_VCPU)
 		vtime_account_guest(tsk, vtime);
 	else
-		__vtime_account_system(tsk, vtime);
+		vtime_account_system(tsk, vtime);
 	write_seqcount_end(&vtime->seqcount);
 }
 
@@ -752,7 +752,7 @@ void vtime_user_enter(struct task_struct *tsk)
 	struct vtime *vtime = &tsk->vtime;
 
 	write_seqcount_begin(&vtime->seqcount);
-	__vtime_account_system(tsk, vtime);
+	vtime_account_system(tsk, vtime);
 	vtime->state = VTIME_USER;
 	write_seqcount_end(&vtime->seqcount);
 }
@@ -782,7 +782,7 @@ void vtime_guest_enter(struct task_struct *tsk)
 	 * that can thus safely catch up with a tickless delta.
 	 */
 	write_seqcount_begin(&vtime->seqcount);
-	__vtime_account_system(tsk, vtime);
+	vtime_account_system(tsk, vtime);
 	tsk->flags |= PF_VCPU;
 	write_seqcount_end(&vtime->seqcount);
 }
