Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EEEC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEE420815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfEPNWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:22:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45610 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbfEPNWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:22:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 867531A25;
        Thu, 16 May 2019 06:22:32 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC5843F703;
        Thu, 16 May 2019 06:22:30 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, mark.rutland@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH 5/6] arm64: perf: Enable pmu counter direct access for perf event on armv8
Date:   Thu, 16 May 2019 14:21:47 +0100
Message-Id: <20190516132148.10085-6-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516132148.10085-1-raphael.gault@arm.com>
References: <20190516132148.10085-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep track of event opened with direct access to the hardware counters
and modify permissions while they are open.

The strategy used here is the same which x86 uses: everytime an event
is mapped, the permissions are set if required. The atomic field added
in the mm_context helps keep track of the different event opened and
de-activate the permissions when all are unmapped.
We also need to update the permissions in the context switch code so
that tasks keep the right permissions.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 arch/arm64/include/asm/mmu.h         |  6 +++++
 arch/arm64/include/asm/mmu_context.h |  2 ++
 arch/arm64/include/asm/perf_event.h  | 14 ++++++++++
 drivers/perf/arm_pmu.c               | 38 ++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 67ef25d037ea..9de4cf0b17c7 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -29,6 +29,12 @@
 
 typedef struct {
 	atomic64_t	id;
+
+	/*
+	 * non-zero if userspace have access to hardware
+	 * counters directly.
+	 */
+	atomic_t	pmu_direct_access;
 	void		*vdso;
 	unsigned long	flags;
 } mm_context_t;
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 2da3e478fd8f..33494af613d8 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -32,6 +32,7 @@
 #include <asm-generic/mm_hooks.h>
 #include <asm/cputype.h>
 #include <asm/pgtable.h>
+#include <asm/perf_event.h>
 #include <asm/sysreg.h>
 #include <asm/tlbflush.h>
 
@@ -235,6 +236,7 @@ static inline void __switch_mm(struct mm_struct *next)
 	}
 
 	check_and_switch_context(next, cpu);
+	perf_switch_user_access(next);
 }
 
 static inline void
diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index c593761ba61c..32a6d604bb3b 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -19,6 +19,7 @@
 
 #include <asm/stack_pointer.h>
 #include <asm/ptrace.h>
+#include <linux/mm_types.h>
 
 #define	ARMV8_PMU_MAX_COUNTERS	32
 #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
@@ -234,4 +235,17 @@ extern unsigned long perf_misc_flags(struct pt_regs *regs);
 	(regs)->pstate = PSR_MODE_EL1h;	\
 }
 
+static inline void perf_switch_user_access(struct mm_struct *mm)
+{
+	if (!IS_ENABLED(CONFIG_PERF_EVENTS))
+		return;
+
+	if (atomic_read(&mm->context.pmu_direct_access)) {
+		write_sysreg(ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR,
+			     pmuserenr_el0);
+	} else {
+		write_sysreg(0, pmuserenr_el0);
+	}
+}
+
 #endif
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 3f4c2ec7ff89..45a64f942864 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -24,6 +24,7 @@
 #include <linux/irqdesc.h>
 
 #include <asm/irq_regs.h>
+#include <asm/mmu_context.h>
 
 static DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
@@ -786,6 +787,41 @@ static int armpmu_event_idx(struct perf_event *event)
 	return event->hw.idx;
 }
 
+static void refresh_pmuserenr(void *mm)
+{
+	perf_switch_user_access(mm);
+}
+
+static void armpmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return;
+
+	/*
+	 * This function relies on not being called concurrently in two
+	 * tasks in the same mm.  Otherwise one task could observe
+	 * pmu_direct_access > 1 and return all the way back to
+	 * userspace with user access disabled while another task is still
+	 * doing on_each_cpu_mask() to enable user access.
+	 *
+	 * For now, this can't happen because all callers hold mmap_sem
+	 * for write.  If this changes, we'll need a different solution.
+	 */
+	lockdep_assert_held_exclusive(&mm->mmap_sem);
+
+	if (atomic_inc_return(&mm->context.pmu_direct_access) == 1)
+		on_each_cpu(refresh_pmuserenr, mm, 1);
+}
+
+static void armpmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
+{
+	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
+		return;
+
+	if (atomic_dec_and_test(&mm->context.pmu_direct_access))
+		on_each_cpu_mask(mm_cpumask(mm), refresh_pmuserenr, NULL, 1);
+}
+
 static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 {
 	struct arm_pmu *pmu;
@@ -807,6 +843,8 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
 		.event_init	= armpmu_event_init,
+		.event_mapped	= armpmu_event_mapped,
+		.event_unmapped	= armpmu_event_unmapped,
 		.add		= armpmu_add,
 		.del		= armpmu_del,
 		.start		= armpmu_start,
-- 
2.17.1

