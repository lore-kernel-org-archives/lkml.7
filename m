Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FACC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BA4215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123270;
	bh=6+z8HPX3gQVp7v3MP3VMlQDEtk2bBbOhScr3L95UUC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=isvOqR4WSNFguglf5lhBCS0Xt0L4SF5dG9c3eqXy+HapaKaLwbkGUtBJs5VexvkbS
	 ylLrinu8zeBw1XjbgdMJAK3lESsP8UHem+R/kRBRkBNkJ3lEwYvS3Wfm+VvNBfqREi
	 tNY5zyrmzNDunEVRd5IY8CsZsXXWL0eRdCDkGpEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbfJCQSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389357AbfJCQR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:17:57 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE0621783;
        Thu,  3 Oct 2019 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119475;
        bh=6+z8HPX3gQVp7v3MP3VMlQDEtk2bBbOhScr3L95UUC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEUhSU6yLjIjJitOpe47ICQpXc2lS34flqRfpjgkq1bS8n6NFw0BiK5vOaMx+HkWX
         n0kG//i93jAvaHy8IJwjbmosgR4T+hhVK6De7TwkESHLhgWwvi9kryXsgweAgMDeY/
         +LS1MNma9pY9T28MsYDl+SqCfCuor5BM8c8dXXng=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH 1/2] vtime: Rename vtime_account_system() to vtime_account_kernel()
Date:   Thu,  3 Oct 2019 18:17:44 +0200
Message-Id: <20191003161745.28464-2-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003161745.28464-1-frederic@kernel.org>
References: <20191003161745.28464-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vtime_account_system() decides if we need to account the time to the
system (__vtime_account_system()) or to the guest (vtime_account_guest()).

So this function is a misnommer as we are on a higher level than
"system". All we know when we call that function is that we are
accounting kernel cputime. Whether it belongs to guest or system time
is a lower level detail.

Rename this function to vtime_account_kernel(). This will clarify things
and avoid too many underscored vtime_account_system() versions.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/kernel/time.c          |  4 ++--
 arch/powerpc/kernel/time.c       |  6 +++---
 arch/s390/kernel/vtime.c         |  4 ++--
 include/linux/context_tracking.h |  4 ++--
 include/linux/vtime.h            |  6 +++---
 kernel/sched/cputime.c           | 18 +++++++++---------
 6 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 1e95d32c8877..91b4024c9351 100644
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
index 694522308cd5..84827da01d45 100644
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
index c475ca49cfc6..8df10d3c8f6c 100644
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
index d05609ad329d..558a209c247d 100644
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
index a26ed10a4eac..2fd247f90408 100644
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
index 46ed4e1383e2..b45932e27857 100644
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
-- 
2.23.0

