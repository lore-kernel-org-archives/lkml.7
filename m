Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4676C3A5A3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD6D2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 06:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfHXGCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 02:02:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34451 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXGCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 02:02:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id b24so8061783pfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 23:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=63+2OO0IEPUZRIzkPBIw8D5vhekw4IymZUn+rUMmE/c=;
        b=TOqzBQYIDFRTTjiOdyBWrFsvytZAhHUHp5wplBjAFXYtwaUOBDQh1IRubFgSogrfS6
         BLR3tP2rE3p2e5tmIev9MfsBbizFMVac6PjW26HHK6sUjriwVNR32WGLQuGNIamNvYUe
         s3Mz5+rPWmb2lKFw+6gPLhPUD+j5mMH67+To/cFkSpdIqpbPxDvP04rCg2jc+XC3WW2i
         C+xTfEuMdX0wyKVC7eYG5zT6QCMQMCDIUP3SHbUsBE6aKAVMVC02Q/jWDKRVKMJb4sYX
         k0eiNTXlqkzqhJSDTyMZxAcw9uRWbeZQyDsDu85UsYN+oSGJEUQ96tS98DtAOS1w+9xm
         zC6Q==
X-Gm-Message-State: APjAAAVmt36YgHLE/Pf0aeSYfIL4WtOme78Gx0Z/x1pddnHmb4cRzrbw
        kOaeeUQvoM6U7tbsMZwGzVY=
X-Google-Smtp-Source: APXvYqyRROo7Wd8JBbAHXHzXd0nxjlSuk699atT/R33J+xHMi+FrW3a1TxRwXxE06d2eNjO+dJytZw==
X-Received: by 2002:a63:1743:: with SMTP id 3mr6817551pgx.435.1566626562759;
        Fri, 23 Aug 2019 23:02:42 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i11sm6505645pfk.34.2019.08.23.23.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 23:02:40 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v4 1/9] smp: Run functions concurrently in smp_call_function_many()
Date:   Fri, 23 Aug 2019 15:41:45 -0700
Message-Id: <20190823224153.15223-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823224153.15223-1-namit@vmware.com>
References: <20190823224153.15223-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, on_each_cpu() and similar functions do not exploit the
potential of concurrency: the function is first executed remotely and
only then it is executed locally. Functions such as TLB flush can take
considerable time, so this provides an opportunity for performance
optimization.

To do so, introduce __smp_call_function_many(), which allows the callers
to provide local and remote functions that should be executed, and run
them concurrently. Keep smp_call_function_many() semantic as it is today
for backward compatibility: the called function is not executed in this
case locally.

__smp_call_function_many() does not use the optimized version for a
single remote target that smp_call_function_single() implements. For
synchronous function call, smp_call_function_single() keeps a
call_single_data (which is used for synchronization) on the stack.
Interestingly, it seems that not using this optimization provides
greater performance improvements (greater speedup with a single remote
target than with multiple ones). Presumably, holding data structures
that are intended for synchronization on the stack can introduce
overheads due to TLB misses and false-sharing when the stack is used for
other purposes.

Adding support to run the functions concurrently required to remove a
micro-optimization in on_each_cpu() that disabled/enabled IRQs instead
of saving/restoring them. The benefit of running the local and remote
code concurrently is expected to be greater.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/smp.h |  34 ++++++++---
 kernel/smp.c        | 138 +++++++++++++++++++++-----------------------
 2 files changed, 92 insertions(+), 80 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 6fc856c9eda5..d18d54199635 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -32,11 +32,6 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
-/*
- * Call a function on all processors
- */
-void on_each_cpu(smp_call_func_t func, void *info, int wait);
-
 /*
  * Call a function on processors specified by mask, which might include
  * the local one.
@@ -44,6 +39,17 @@ void on_each_cpu(smp_call_func_t func, void *info, int wait);
 void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
 		void *info, bool wait);
 
+/*
+ * Call a function on all processors.  May be used during early boot while
+ * early_boot_irqs_disabled is set.
+ */
+static inline void on_each_cpu(smp_call_func_t func, void *info, int wait)
+{
+	preempt_disable();
+	on_each_cpu_mask(cpu_online_mask, func, info, wait);
+	preempt_enable();
+}
+
 /*
  * Call a function on each processor for which the supplied function
  * cond_func returns a positive value. This may include the local
@@ -102,8 +108,22 @@ extern void smp_cpus_done(unsigned int max_cpus);
  * Call a function on all other processors
  */
 void smp_call_function(smp_call_func_t func, void *info, int wait);
-void smp_call_function_many(const struct cpumask *mask,
-			    smp_call_func_t func, void *info, bool wait);
+
+/*
+ * Flags to be used as as scf_flags argument of __smp_call_function_many().
+ */
+#define SCF_WAIT	(1U << 0)	/* Wait until function execution completed */
+#define SCF_RUN_LOCAL	(1U << 1)	/* Run also locally if local cpu is set in cpumask */
+
+void __smp_call_function_many(const struct cpumask *mask,
+			      smp_call_func_t func, void *info,
+			      unsigned int scf_flags);
+
+static inline void smp_call_function_many(const struct cpumask *mask,
+				smp_call_func_t func, void *info, bool wait)
+{
+	__smp_call_function_many(mask, func, info, wait ? SCF_WAIT : 0);
+}
 
 int smp_call_function_any(const struct cpumask *mask,
 			  smp_call_func_t func, void *info, int wait);
diff --git a/kernel/smp.c b/kernel/smp.c
index 7dbcb402c2fc..9faec688b34b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -396,24 +396,28 @@ int smp_call_function_any(const struct cpumask *mask,
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
 /**
- * smp_call_function_many(): Run a function on a set of other CPUs.
+ * __smp_call_function_many(): Run a function on a set of CPUs.
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed
- *        on other CPUs.
- *
- * If @wait is true, then returns once @func has returned.
+ * @flags: Bitmask that controls the operation. If %SCF_WAIT is set, wait
+ *	   (atomically) until function has completed on other CPUs. If
+ *	   %SCF_RUN_LOCAL is set, the function will also be run locally
+ *	   if the local CPU is set in the @cpumask.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler. Preemption
  * must be disabled when calling this function.
  */
-void smp_call_function_many(const struct cpumask *mask,
-			    smp_call_func_t func, void *info, bool wait)
+void __smp_call_function_many(const struct cpumask *mask, smp_call_func_t func,
+			      void *info, unsigned int scf_flags)
 {
+	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
-	int cpu, next_cpu, this_cpu = smp_processor_id();
+	bool wait = scf_flags & SCF_WAIT;
+	bool run_remote = false;
+	bool run_local = false;
+	int nr_cpus = 0;
 
 	/*
 	 * Can deadlock when called with interrupts disabled.
@@ -421,8 +425,8 @@ void smp_call_function_many(const struct cpumask *mask,
 	 * send smp call function interrupt to this cpu and as such deadlocks
 	 * can't happen.
 	 */
-	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
-		     && !oops_in_progress && !early_boot_irqs_disabled);
+	if (cpu_online(this_cpu) && !oops_in_progress && !early_boot_irqs_disabled)
+		lockdep_assert_irqs_enabled();
 
 	/*
 	 * When @wait we can deadlock when we interrupt between llist_add() and
@@ -432,52 +436,59 @@ void smp_call_function_many(const struct cpumask *mask,
 	 */
 	WARN_ON_ONCE(!in_task());
 
-	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
+	/* Check if we need local execution. */
+	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask))
+		run_local = true;
+
+	/* Check if we need remote execution, i.e., any CPU excluding this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
 	if (cpu == this_cpu)
 		cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
+	if (cpu < nr_cpu_ids)
+		run_remote = true;
 
-	/* No online cpus?  We're done. */
-	if (cpu >= nr_cpu_ids)
-		return;
-
-	/* Do we have another CPU which isn't us? */
-	next_cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
-	if (next_cpu == this_cpu)
-		next_cpu = cpumask_next_and(next_cpu, mask, cpu_online_mask);
+	if (run_remote) {
+		cfd = this_cpu_ptr(&cfd_data);
 
-	/* Fastpath: do that cpu by itself. */
-	if (next_cpu >= nr_cpu_ids) {
-		smp_call_function_single(cpu, func, info, wait);
-		return;
-	}
+		cpumask_and(cfd->cpumask, mask, cpu_online_mask);
+		__cpumask_clear_cpu(this_cpu, cfd->cpumask);
 
-	cfd = this_cpu_ptr(&cfd_data);
-
-	cpumask_and(cfd->cpumask, mask, cpu_online_mask);
-	__cpumask_clear_cpu(this_cpu, cfd->cpumask);
+		cpumask_clear(cfd->cpumask_ipi);
+		for_each_cpu(cpu, cfd->cpumask) {
+			call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
+
+			csd_lock(csd);
+			if (wait)
+				csd->flags |= CSD_FLAG_SYNCHRONOUS;
+			csd->func = func;
+			csd->info = info;
+			if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu))) {
+				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
+				nr_cpus++;
+				last_cpu = cpu;
+			}
+		}
 
-	/* Some callers race with other cpus changing the passed mask */
-	if (unlikely(!cpumask_weight(cfd->cpumask)))
-		return;
+		/*
+		 * Choose the most efficient way to send an IPI. Note that the
+		 * number of CPUs might be zero due to concurrent changes to the
+		 * provided mask.
+		 */
+		if (nr_cpus == 1)
+			arch_send_call_function_single_ipi(last_cpu);
+		else if (likely(nr_cpus > 1))
+			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
+	}
 
-	cpumask_clear(cfd->cpumask_ipi);
-	for_each_cpu(cpu, cfd->cpumask) {
-		call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
+	if (run_local) {
+		unsigned long flags;
 
-		csd_lock(csd);
-		if (wait)
-			csd->flags |= CSD_FLAG_SYNCHRONOUS;
-		csd->func = func;
-		csd->info = info;
-		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
-			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
+		local_irq_save(flags);
+		func(info);
+		local_irq_restore(flags);
 	}
 
-	/* Send a message to all CPUs in the map */
-	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
-
-	if (wait) {
+	if (run_remote && wait) {
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd;
 
@@ -486,7 +497,7 @@ void smp_call_function_many(const struct cpumask *mask,
 		}
 	}
 }
-EXPORT_SYMBOL(smp_call_function_many);
+EXPORT_SYMBOL(__smp_call_function_many);
 
 /**
  * smp_call_function(): Run a function on all other CPUs.
@@ -603,24 +614,6 @@ void __init smp_init(void)
 	smp_cpus_done(setup_max_cpus);
 }
 
-/*
- * Call a function on all processors.  May be used during early boot while
- * early_boot_irqs_disabled is set.  Use local_irq_save/restore() instead
- * of local_irq_disable/enable().
- */
-void on_each_cpu(void (*func) (void *info), void *info, int wait)
-{
-	unsigned long flags;
-
-	preempt_disable();
-	smp_call_function(func, info, wait);
-	local_irq_save(flags);
-	func(info);
-	local_irq_restore(flags);
-	preempt_enable();
-}
-EXPORT_SYMBOL(on_each_cpu);
-
 /**
  * on_each_cpu_mask(): Run a function on processors specified by
  * cpumask, which may include the local processor.
@@ -640,16 +633,15 @@ EXPORT_SYMBOL(on_each_cpu);
 void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
 			void *info, bool wait)
 {
-	int cpu = get_cpu();
+	unsigned int scf_flags;
 
-	smp_call_function_many(mask, func, info, wait);
-	if (cpumask_test_cpu(cpu, mask)) {
-		unsigned long flags;
-		local_irq_save(flags);
-		func(info);
-		local_irq_restore(flags);
-	}
-	put_cpu();
+	scf_flags = SCF_RUN_LOCAL;
+	if (wait)
+		scf_flags |= SCF_WAIT;
+
+	preempt_disable();
+	__smp_call_function_many(mask, func, info, scf_flags);
+	preempt_enable();
 }
 EXPORT_SYMBOL(on_each_cpu_mask);
 
-- 
2.17.1

