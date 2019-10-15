Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657E4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411EC20650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388734AbfJORZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:25:53 -0400
Received: from foss.arm.com ([217.140.110.172]:44122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfJORZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:25:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 393C2337;
        Tue, 15 Oct 2019 10:25:51 -0700 (PDT)
Received: from eglon.cambridge.arm.com (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A39673F68E;
        Tue, 15 Oct 2019 10:25:49 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2] arm64: entry.S: Do not preempt from IRQ before all  cpufeatures are enabled
Date:   Tue, 15 Oct 2019 18:25:44 +0100
Message-Id: <20191015172544.186627-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Preempting from IRQ-return means that the task has its PSTATE saved
on the stack, which will get restored when the task is resumed and does
the actual IRQ return.

However, enabling some CPU features requires modifying the PSTATE. This
means that, if a task was scheduled out during an IRQ-return before all
CPU features are enabled, the task might restore a PSTATE that does not
include the feature enablement changes once scheduled back in.

* Task 1:

PAN == 0 ---|                          |---------------
            |                          |<- return from IRQ, PSTATE.PAN = 0
            | <- IRQ                   |
            +--------+ <- preempt()  +--
                                     ^
                                     |
                                     reschedule Task 1, PSTATE.PAN == 1
* Init:
        --------------------+------------------------
                            ^
                            |
                            enable_cpu_features
                            set PSTATE.PAN on all CPUs

Worse than this, since PSTATE is untouched when task switching is done,
a task missing the new bits in PSTATE might affect another task, if both
do direct calls to schedule() (outside of IRQ/exception contexts).

Fix this by preventing preemption on IRQ-return until features are
enabled on all CPUs.

This way the only PSTATE values that are saved on the stack are from
synchronous exceptions. These are expected to be fatal this early, the
exception is BRK for WARN_ON(), but as this uses do_debug_exception()
which keeps IRQs masked, it shouldn't call schedule().

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
[Replaced a really cool hack, with an even simpler static key in C.
 expanded commit message with Julien's cover-letter ascii art]
Signed-off-by: James Morse <james.morse@arm.com>
---
The suspicious __sched annotation here is to stop this symbol from
appearing in wchan. I haven't managed to make this happen, but I
can't see what stops it.

Previous version:
https://lore.kernel.org/linux-arm-kernel/20191010163447.136049-1-james.morse@arm.com/


I think the reason we don't see this happen because cpufeature enable calls
happen early, when there is not a lot going on. I couldn't hit it when
trying. I believe Julien did, by adding sleep statements(?) to kthread().

If we want to send this to stable, the first feature that depended on this
was PAN:
Fixes: 7209c868600b ("arm64: mm: Set PSTATE.PAN from the cpu_enable_pan() call")

 arch/arm64/kernel/entry.S   |  2 +-
 arch/arm64/kernel/process.c | 18 ++++++++++++++++++
 include/linux/sched.h       |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 84a822748c84..07b621bcaf1f 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -680,7 +680,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	orr	x24, x24, x0
 alternative_else_nop_endif
 	cbnz	x24, 1f				// preempt count != 0 || NMI return path
-	bl	preempt_schedule_irq		// irq en/disable is done inside
+	bl	arm64_preempt_schedule_irq	// irq en/disable is done inside
 1:
 #endif
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a47462def04b..f088ecf5d4c9 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/kernel.h>
+#include <linux/lockdep.h>
 #include <linux/mm.h>
 #include <linux/stddef.h>
 #include <linux/sysctl.h>
@@ -44,6 +45,7 @@
 #include <asm/alternative.h>
 #include <asm/arch_gicv3.h>
 #include <asm/compat.h>
+#include <asm/cpufeature.h>
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
 #include <asm/fpsimd.h>
@@ -633,3 +635,19 @@ static int __init tagged_addr_init(void)
 
 core_initcall(tagged_addr_init);
 #endif	/* CONFIG_ARM64_TAGGED_ADDR_ABI */
+
+asmlinkage void __sched arm64_preempt_schedule_irq(void)
+{
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Preempting a task from an IRQ means we leave copies of PSTATE
+	 * on the stack. cpufeature's enable calls may modify PSTATE, but
+	 * resuming one of these preempted tasks would undo those changes.
+	 *
+	 * Only allow a task to be preempted once cpufeatures have been
+	 * enabled.
+	 */
+	if (static_branch_likely(&arm64_const_caps_ready))
+		preempt_schedule_irq();
+}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2c2e56bd8913..67a1d86981a9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -223,6 +223,7 @@ extern long schedule_timeout_uninterruptible(long timeout);
 extern long schedule_timeout_idle(long timeout);
 asmlinkage void schedule(void);
 extern void schedule_preempt_disabled(void);
+asmlinkage void preempt_schedule_irq(void);
 
 extern int __must_check io_schedule_prepare(void);
 extern void io_schedule_finish(int token);
-- 
2.20.1

