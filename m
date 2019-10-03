Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F39AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D5920865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123263;
	bh=MGvHbC9K5+l59c4z5K2Nq/I42snRLtWbzjkUQSSFuAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1yY/HodksuaI6sO/O0GI/bgWKQUIF9zKyzPm+Vo/LBbbiqqEIOhczDS/6KAzrncMf
	 9iuBYnWQRVlF64HcmoPl0WrFkbz62Qj7UYcwx2iRaU3B9Un3ciSKn79/EhjqQlsSTe
	 dRrMpvIx90bePO2aIsKtqCUm1bl8+CMPdmMBAjCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbfJCQSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387651AbfJCQR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:17:59 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60DAF21A4C;
        Thu,  3 Oct 2019 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119478;
        bh=MGvHbC9K5+l59c4z5K2Nq/I42snRLtWbzjkUQSSFuAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2QWZklpfkmxHS+bqZrDH/IqoyZ0JKs8aKP8Bvz5EtMSkHKO/yWARdyRGuzOWjEyjy
         fpXzZ5wsnId1Pq2xOWiDkWjoCf98dIF/xQtzLfWhGQTg5Jz76+zFEDKKRHlDyjCcIA
         mXE1wBihO/qEsROPkzm3TOC0sJ25VfkbkIdSP/U8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH 2/2] vtime: Spare a seqcount lock/unlock cycle on context switch
Date:   Thu,  3 Oct 2019 18:17:45 +0200
Message-Id: <20191003161745.28464-3-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003161745.28464-1-frederic@kernel.org>
References: <20191003161745.28464-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On context switch we are locking the vtime seqcount of the scheduling-out
task twice:

 * On vtime_task_switch_common(), when we flush the pending vtime through
   vtime_account_system()

 * On arch_vtime_task_switch() to reset the vtime state.

This is pointless as these actions can be performed without the need
to unlock/lock in the middle. The reason these steps are separated is to
consolidate a very small amount of common code between
CONFIG_VIRT_CPU_ACCOUNTING_GEN and CONFIG_VIRT_CPU_ACCOUNTING_NATIVE.

Performance in this fast path is definetly a priority over artificial
code factorization so split the task switch code between GEN and
NATIVE and mutualize the parts than can run under a single seqcount
locked block.

As a side effect, vtime_account_idle() becomes included in the seqcount
protection. This happens to be a welcome preparation in order to
properly support kcpustat under vtime in the future and fetch
CPUTIME_IDLE without race.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/vtime.h  | 32 ++++++++++++++++----------------
 kernel/sched/cputime.c | 34 +++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 2fd247f90408..d9160ab3667a 100644
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
index b45932e27857..cef23c211f41 100644
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
@@ -731,19 +729,25 @@ static void vtime_account_guest(struct task_struct *tsk,
 	}
 }
 
-void vtime_account_kernel(struct task_struct *tsk)
+static void __vtime_account_kernel(struct task_struct *tsk,
+				   struct vtime *vtime)
 {
-	struct vtime *vtime = &tsk->vtime;
-
-	if (!vtime_delta(vtime))
-		return;
-
-	write_seqcount_begin(&vtime->seqcount);
 	/* We might have scheduled out from guest path */
 	if (tsk->flags & PF_VCPU)
 		vtime_account_guest(tsk, vtime);
 	else
 		vtime_account_system(tsk, vtime);
+}
+
+void vtime_account_kernel(struct task_struct *tsk)
+{
+	struct vtime *vtime = &tsk->vtime;
+
+	if (!vtime_delta(vtime))
+		return;
+
+	write_seqcount_begin(&vtime->seqcount);
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
 
-- 
2.23.0

