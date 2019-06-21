Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459E3C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC5820673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561110089;
	bh=RUhdn1Fmrgf8hVLPUiLBH+TPrUQP4dOPOdTJb/LnqtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mowcbmv9oneO4FYbiSPWhHxpVtHUQzjkSkRyDucYamfyR0TDDV+yHDy1j47qqbfme
	 j87tNvzGJ/Oxt3p7ExJYUwOw1djCR8dA5qRwJNg99ax8G/v3amMXoWDeaQhGWfVTkc
	 V2ltB0Z+X3w2FMYuhm/r9GIjmLwWxfzg194LwSpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfFUJl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFUJkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:40:25 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F1820673;
        Fri, 21 Jun 2019 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561110024;
        bh=RUhdn1Fmrgf8hVLPUiLBH+TPrUQP4dOPOdTJb/LnqtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uUmaTQod0r/I/XSqI+fJry40BgwW1Z8jeSlAYe0F6cPJ7Soy8mOxJM4SG4pXm3lCo
         o7GQ46bOwXMiwzB02MHEIX4qh2CreB80W3GuN3/s59hlE0gQGSvk00T5S11U2eOD55
         e7NPsZzpZdlAZyeOwFZnh/pFbD4LWcqkur0Bj+cA=
From:   guoren@kernel.org
To:     julien.grall@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc:     linux-csky@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 3/4] csky: Use generic asid algorithm to implement switch_mm
Date:   Fri, 21 Jun 2019 17:39:58 +0800
Message-Id: <1561109999-4322-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561109999-4322-1-git-send-email-guoren@kernel.org>
References: <1561109999-4322-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Use linux generic asid/vmid algorithm to implement csky
switch_mm function. The algorithm is from arm and it could
work with SMP system. It'll help reduce tlb flush for
switch_mm in task/vm switch.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/inc/abi/ckmmu.h     |  6 +++++
 arch/csky/abiv2/inc/abi/ckmmu.h     | 10 ++++++++
 arch/csky/include/asm/mmu.h         |  1 +
 arch/csky/include/asm/mmu_context.h | 12 ++++++++--
 arch/csky/mm/Makefile               |  1 +
 arch/csky/mm/context.c              | 46 +++++++++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 arch/csky/mm/context.c

diff --git a/arch/csky/abiv1/inc/abi/ckmmu.h b/arch/csky/abiv1/inc/abi/ckmmu.h
index 81f3771..ba8eb58 100644
--- a/arch/csky/abiv1/inc/abi/ckmmu.h
+++ b/arch/csky/abiv1/inc/abi/ckmmu.h
@@ -78,6 +78,12 @@ static inline void tlb_invalid_all(void)
 	cpwcr("cpcr8", 0x04000000);
 }
 
+
+static inline void local_tlb_invalid_all(void)
+{
+	tlb_invalid_all();
+}
+
 static inline void tlb_invalid_indexed(void)
 {
 	cpwcr("cpcr8", 0x02000000);
diff --git a/arch/csky/abiv2/inc/abi/ckmmu.h b/arch/csky/abiv2/inc/abi/ckmmu.h
index e4480e6..73ded7c 100644
--- a/arch/csky/abiv2/inc/abi/ckmmu.h
+++ b/arch/csky/abiv2/inc/abi/ckmmu.h
@@ -85,6 +85,16 @@ static inline void tlb_invalid_all(void)
 #endif
 }
 
+static inline void local_tlb_invalid_all(void)
+{
+#ifdef CONFIG_CPU_HAS_TLBI
+	asm volatile("tlbi.all\n":::"memory");
+	sync_is();
+#else
+	tlb_invalid_all();
+#endif
+}
+
 static inline void tlb_invalid_indexed(void)
 {
 	mtcr("cr<8, 15>", 0x02000000);
diff --git a/arch/csky/include/asm/mmu.h b/arch/csky/include/asm/mmu.h
index 06f509a..b382a14 100644
--- a/arch/csky/include/asm/mmu.h
+++ b/arch/csky/include/asm/mmu.h
@@ -5,6 +5,7 @@
 #define __ASM_CSKY_MMU_H
 
 typedef struct {
+	atomic64_t	asid;
 	void *vdso;
 } mm_context_t;
 
diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index 86dde48..0285b0a 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -20,20 +20,28 @@
 #define TLBMISS_HANDLER_SETUP_PGD_KERNEL(pgd) \
 	setup_pgd(__pa(pgd), true)
 
-#define init_new_context(tsk,mm)	0
+#define ASID_MASK		((1 << CONFIG_CPU_ASID_BITS) - 1)
+#define cpu_asid(mm)		(atomic64_read(&mm->context.asid) & ASID_MASK)
+
+#define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.asid, 0); 0; })
 #define activate_mm(prev,next)		switch_mm(prev, next, current)
 
 #define destroy_context(mm)		do {} while (0)
 #define enter_lazy_tlb(mm, tsk)		do {} while (0)
 #define deactivate_mm(tsk, mm)		do {} while (0)
 
+void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
+
 static inline void
 switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	  struct task_struct *tsk)
 {
+	unsigned int cpu = smp_processor_id();
+
 	if (prev != next)
-		tlb_invalid_all();
+		check_and_switch_context(next, cpu);
 
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
+	write_mmu_entryhi(next->context.asid.counter);
 }
 #endif /* __ASM_CSKY_MMU_CONTEXT_H */
diff --git a/arch/csky/mm/Makefile b/arch/csky/mm/Makefile
index 897368f..34cb5b1 100644
--- a/arch/csky/mm/Makefile
+++ b/arch/csky/mm/Makefile
@@ -12,3 +12,4 @@ obj-y +=			ioremap.o
 obj-y +=			syscache.o
 obj-y +=			tlb.o
 obj-y +=			asid.o
+obj-y +=			context.o
diff --git a/arch/csky/mm/context.c b/arch/csky/mm/context.c
new file mode 100644
index 0000000..0d95bdd
--- /dev/null
+++ b/arch/csky/mm/context.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/bitops.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+
+#include <asm/asid.h>
+#include <asm/mmu_context.h>
+#include <asm/smp.h>
+#include <asm/tlbflush.h>
+
+static DEFINE_PER_CPU(atomic64_t, active_asids);
+static DEFINE_PER_CPU(u64, reserved_asids);
+
+struct asid_info asid_info;
+
+void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
+{
+	asid_check_context(&asid_info, &mm->context.asid, cpu, mm);
+}
+
+static void asid_flush_cpu_ctxt(void)
+{
+	local_tlb_invalid_all();
+}
+
+static int asids_init(void)
+{
+	BUG_ON(((1 << CONFIG_CPU_ASID_BITS) - 1) <= num_possible_cpus());
+
+	if (asid_allocator_init(&asid_info, CONFIG_CPU_ASID_BITS, 1,
+				asid_flush_cpu_ctxt))
+		panic("Unable to initialize ASID allocator for %lu ASIDs\n",
+		      NUM_ASIDS(&asid_info));
+
+	asid_info.active = &active_asids;
+	asid_info.reserved = &reserved_asids;
+
+	pr_info("ASID allocator initialised with %lu entries\n",
+		NUM_CTXT_ASIDS(&asid_info));
+
+	return 0;
+}
+early_initcall(asids_init);
-- 
2.7.4

