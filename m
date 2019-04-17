Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890D1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AD720872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="knh78s1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbfDQOVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:21:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57351 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQOVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:21:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEKpiR3935758
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:20:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEKpiR3935758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510852;
        bh=1Hu6HaJm/4PZCvsIfFrvAzsIAIF4WhzDKkO2hUv0DFE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=knh78s1gVLgxu7CQZa6inhYEYcaDZMEQ/xAD6n35s7F6Gyymf9K/YVJOe9x1g4UE9
         ojb/qJFqBCsHhvzZKa8aVoq5JYxIbjclhpI7bo+kTq/gzY/K8P23LsNzYnJytUVRz9
         qgGBdWLErDFrCJY8Y6Mi0MW9H1f9frB5d0pPHOPuS7pWGogDDHGiI/AZlz88YhQxEF
         c2L5oVeCJwFBQNIkPhq/JfTvpHhWHmz93tSF7lSMBdWEyZzeA8z1N5gpbAuFzdKc9r
         r+hT+MQbeaGwea/R+W2Elf9oeitAwN6q/Q5cwAbFRu2mjYxQKk87WjBxCy0ZCNQnsm
         wGczeHmsEPrpg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEKnVh3935755;
        Wed, 17 Apr 2019 07:20:49 -0700
Date:   Wed, 17 Apr 2019 07:20:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-66c7ceb47f628c8bd4f84a6d01c2725ded6a342d@git.kernel.org>
Cc:     jgross@suse.com, nstange@suse.de, puwen@hygon.cn,
        akpm@linux-foundation.org, mingo@redhat.com,
        suravee.suthikulpanit@amd.com, yazen.ghannam@amd.com,
        anshuman.khandual@arm.com, mingo@kernel.org,
        zhangshaokun@hisilicon.com, zhenzhong.duan@oracle.com,
        linux-kernel@vger.kernel.org, sstabellini@kernel.org,
        wang.yi59@zte.com.cn, bp@suse.de, konrad.wilk@oracle.com,
        tglx@linutronix.de, boris.ostrovsky@oracle.com,
        alison.schofield@intel.com, jpoimboe@redhat.com, x86@kernel.org,
        luto@kernel.org, hpa@zytor.com, sean.j.christopherson@intel.com
Reply-To: puwen@hygon.cn, akpm@linux-foundation.org, nstange@suse.de,
          jgross@suse.com, zhangshaokun@hisilicon.com,
          zhenzhong.duan@oracle.com, anshuman.khandual@arm.com,
          mingo@kernel.org, yazen.ghannam@amd.com,
          suravee.suthikulpanit@amd.com, mingo@redhat.com,
          boris.ostrovsky@oracle.com, tglx@linutronix.de,
          konrad.wilk@oracle.com, bp@suse.de, linux-kernel@vger.kernel.org,
          sstabellini@kernel.org, wang.yi59@zte.com.cn,
          sean.j.christopherson@intel.com, luto@kernel.org, hpa@zytor.com,
          x86@kernel.org, jpoimboe@redhat.com, alison.schofield@intel.com
In-Reply-To: <20190414160146.089060584@linutronix.de>
References: <20190414160146.089060584@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/irq/32: Handle irq stack allocation failure
 proper
Git-Commit-ID: 66c7ceb47f628c8bd4f84a6d01c2725ded6a342d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  66c7ceb47f628c8bd4f84a6d01c2725ded6a342d
Gitweb:     https://git.kernel.org/tip/66c7ceb47f628c8bd4f84a6d01c2725ded6a342d
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 18:00:04 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 15:31:42 +0200

x86/irq/32: Handle irq stack allocation failure proper

irq_ctx_init() crashes hard on page allocation failures. While that's ok
during early boot, it's just wrong in the CPU hotplug bringup code.

Check the page allocation failure and return -ENOMEM and handle it at the
call sites. On early boot the only way out is to BUG(), but on CPU hotplug
there is no reason to crash, so just abort the operation.

Rename the function to something more sensible while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Nicolai Stange <nstange@suse.de>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Yi Wang <wang.yi59@zte.com.cn>
Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Link: https://lkml.kernel.org/r/20190414160146.089060584@linutronix.de
---
 arch/x86/include/asm/irq.h |  4 ++--
 arch/x86/include/asm/smp.h |  2 +-
 arch/x86/kernel/irq_32.c   | 32 ++++++++++++++++----------------
 arch/x86/kernel/irqinit.c  |  2 +-
 arch/x86/kernel/smpboot.c  | 15 ++++++++++++---
 arch/x86/xen/smp_pv.c      |  4 +++-
 6 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index fbb16e6b6c18..d751e8440a6b 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -17,9 +17,9 @@ static inline int irq_canonicalize(int irq)
 }
 
 #ifdef CONFIG_X86_32
-extern void irq_ctx_init(int cpu);
+extern int irq_init_percpu_irqstack(unsigned int cpu);
 #else
-# define irq_ctx_init(cpu) do { } while (0)
+static inline int irq_init_percpu_irqstack(unsigned int cpu) { return 0; }
 #endif
 
 #define __ARCH_HAS_DO_SOFTIRQ
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 2e95b6c1bca3..da545df207b2 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -131,7 +131,7 @@ void native_smp_prepare_boot_cpu(void);
 void native_smp_prepare_cpus(unsigned int max_cpus);
 void calculate_max_logical_packages(void);
 void native_smp_cpus_done(unsigned int max_cpus);
-void common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
+int common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_cpu_disable(void);
 int common_cpu_die(unsigned int cpu);
diff --git a/arch/x86/kernel/irq_32.c b/arch/x86/kernel/irq_32.c
index f37489c806fa..fc34816c6f04 100644
--- a/arch/x86/kernel/irq_32.c
+++ b/arch/x86/kernel/irq_32.c
@@ -107,28 +107,28 @@ static inline int execute_on_irq_stack(int overflow, struct irq_desc *desc)
 }
 
 /*
- * allocate per-cpu stacks for hardirq and for softirq processing
+ * Allocate per-cpu stacks for hardirq and softirq processing
  */
-void irq_ctx_init(int cpu)
+int irq_init_percpu_irqstack(unsigned int cpu)
 {
-	struct irq_stack *irqstk;
+	int node = cpu_to_node(cpu);
+	struct page *ph, *ps;
 
 	if (per_cpu(hardirq_stack_ptr, cpu))
-		return;
-
-	irqstk = page_address(alloc_pages_node(cpu_to_node(cpu),
-					       THREADINFO_GFP,
-					       THREAD_SIZE_ORDER));
-	per_cpu(hardirq_stack_ptr, cpu) = irqstk;
+		return 0;
 
-	irqstk = page_address(alloc_pages_node(cpu_to_node(cpu),
-					       THREADINFO_GFP,
-					       THREAD_SIZE_ORDER));
-	per_cpu(softirq_stack_ptr, cpu) = irqstk;
+	ph = alloc_pages_node(node, THREADINFO_GFP, THREAD_SIZE_ORDER);
+	if (!ph)
+		return -ENOMEM;
+	ps = alloc_pages_node(node, THREADINFO_GFP, THREAD_SIZE_ORDER);
+	if (!ps) {
+		__free_pages(ph, THREAD_SIZE_ORDER);
+		return -ENOMEM;
+	}
 
-	pr_debug("CPU %u irqstacks, hard=%p soft=%p\n",
-		 cpu, per_cpu(hardirq_stack_ptr, cpu),
-		 per_cpu(softirq_stack_ptr, cpu));
+	per_cpu(hardirq_stack_ptr, cpu) = page_address(ph);
+	per_cpu(softirq_stack_ptr, cpu) = page_address(ps);
+	return 0;
 }
 
 void do_softirq_own_stack(void)
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index 26b5cb5386b9..16919a9671fa 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -91,7 +91,7 @@ void __init init_IRQ(void)
 	for (i = 0; i < nr_legacy_irqs(); i++)
 		per_cpu(vector_irq, 0)[ISA_IRQ_VECTOR(i)] = irq_to_desc(i);
 
-	irq_ctx_init(smp_processor_id());
+	BUG_ON(irq_init_percpu_irqstack(smp_processor_id()));
 
 	x86_init.irqs.intr_init();
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ce1a67b70168..c92b21f9e9dc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -935,20 +935,27 @@ out:
 	return boot_error;
 }
 
-void common_cpu_up(unsigned int cpu, struct task_struct *idle)
+int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 {
+	int ret;
+
 	/* Just in case we booted with a single CPU. */
 	alternatives_enable_smp();
 
 	per_cpu(current_task, cpu) = idle;
 
+	/* Initialize the interrupt stack(s) */
+	ret = irq_init_percpu_irqstack(cpu);
+	if (ret)
+		return ret;
+
 #ifdef CONFIG_X86_32
 	/* Stack for startup_32 can be just as for start_secondary onwards */
-	irq_ctx_init(cpu);
 	per_cpu(cpu_current_top_of_stack, cpu) = task_top_of_stack(idle);
 #else
 	initial_gs = per_cpu_offset(cpu);
 #endif
+	return 0;
 }
 
 /*
@@ -1106,7 +1113,9 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 	/* the FPU context is blank, nobody can own it */
 	per_cpu(fpu_fpregs_owner_ctx, cpu) = NULL;
 
-	common_cpu_up(cpu, tidle);
+	err = common_cpu_up(cpu, tidle);
+	if (err)
+		return err;
 
 	err = do_boot_cpu(apicid, cpu, tidle, &cpu0_nmi_registered);
 	if (err) {
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 145506f9fdbe..590fcf863006 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -361,7 +361,9 @@ static int xen_pv_cpu_up(unsigned int cpu, struct task_struct *idle)
 {
 	int rc;
 
-	common_cpu_up(cpu, idle);
+	rc = common_cpu_up(cpu, idle);
+	if (rc)
+		return rc;
 
 	xen_setup_runstate_info(cpu);
 
