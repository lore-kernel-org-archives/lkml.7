Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD5BC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B7F218B6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGCHOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:14:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46570 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfGCHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:14:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so694195pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/x9cjOs9PD+cFT+y2OjFs9RyRV2Pw3b28B7myQ2XC+8=;
        b=iKB475lql5sZAVK+9nN4Wgdskc1GUP5GdsCtp7qk7WpJ/kfHQYfCkggc2PwA/35HlK
         ctK2VNwBeiVbOGb3SifxH5Huhr6brMOugP1K7GOock8ryq9+98pJCw9REfGSxylaX4Zv
         mIvC9O6TDCRDZvP7SnB2tATVdLa2eWxOGPsdVXcWN+4Y3goS2MjItq7HQukEsZE8IHDC
         GsDy7c2GtIwC7WdBg6ImQOOayp0/7Mbhzi5l+TCrv30VYvmvMnzCUJtPSLHA0bA1NmVU
         Nmb6sP7P0PsMYT7HCcFLuAtoFjsgW6VC7N60jpUgRShJ4x2fkBgE2bEaJ5G6o38jwHR2
         naqg==
X-Gm-Message-State: APjAAAWuykX8TaAS8I+22c4f65psRSw8c8evaLvm++DuZKng4aGEsoQ0
        aOFIcpzXX3vW8i70noDHUaM=
X-Google-Smtp-Source: APXvYqw13klK84bq+RvyY66FBmfodi76m/TymYlZysq0M9X2bgydBR5s6BA9nUgF1KLNFs2nQwiHKA==
X-Received: by 2002:a17:902:e282:: with SMTP id cf2mr40903325plb.301.1562138044356;
        Wed, 03 Jul 2019 00:14:04 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j21sm1256593pfh.86.2019.07.03.00.14.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 00:14:02 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Nadav Amit <namit@vmware.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 1/9] smp: Run functions concurrently in smp_call_function_many()
Date:   Tue,  2 Jul 2019 16:51:43 -0700
Message-Id: <20190702235151.4377-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702235151.4377-1-namit@vmware.com>
References: <20190702235151.4377-1-namit@vmware.com>
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

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/smp.h |  27 ++++++---
 kernel/smp.c        | 133 +++++++++++++++++++++-----------------------
 2 files changed, 83 insertions(+), 77 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 6fc856c9eda5..c31c7cde0f77 100644
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
@@ -44,6 +39,15 @@ void on_each_cpu(smp_call_func_t func, void *info, int wait);
 void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
 		void *info, bool wait);
 
+/*
+ * Call a function on all processors.  May be used during early boot while
+ * early_boot_irqs_disabled is set.
+ */
+static inline void on_each_cpu(smp_call_func_t func, void *info, int wait)
+{
+	on_each_cpu_mask(cpu_online_mask, func, info, wait);
+}
+
 /*
  * Call a function on each processor for which the supplied function
  * cond_func returns a positive value. This may include the local
@@ -102,8 +106,17 @@ extern void smp_cpus_done(unsigned int max_cpus);
  * Call a function on all other processors
  */
 void smp_call_function(smp_call_func_t func, void *info, int wait);
-void smp_call_function_many(const struct cpumask *mask,
-			    smp_call_func_t func, void *info, bool wait);
+
+void __smp_call_function_many(const struct cpumask *mask,
+			      smp_call_func_t remote_func,
+			      smp_call_func_t local_func,
+			      void *info, bool wait);
+
+static inline void smp_call_function_many(const struct cpumask *mask,
+				smp_call_func_t func, void *info, bool wait)
+{
+	__smp_call_function_many(mask, func, NULL, info, wait);
+}
 
 int smp_call_function_any(const struct cpumask *mask,
 			  smp_call_func_t func, void *info, int wait);
diff --git a/kernel/smp.c b/kernel/smp.c
index 616d4d114847..d5d8dee8e3f3 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -388,9 +388,13 @@ int smp_call_function_any(const struct cpumask *mask,
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
 /**
- * smp_call_function_many(): Run a function on a set of other CPUs.
+ * __smp_call_function_many(): Run a function on a set of CPUs.
  * @mask: The set of cpus to run on (only runs on online subset).
- * @func: The function to run. This must be fast and non-blocking.
+ * @remote_func: The function to run on remote cores. This must be fast and
+ *		 non-blocking.
+ * @local_func: The function that should be run on this CPU. This must be
+ *		fast and non-blocking. If NULL is provided, no function will
+ *		be executed on this CPU.
  * @info: An arbitrary pointer to pass to the function.
  * @wait: If true, wait (atomically) until function has completed
  *        on other CPUs.
@@ -401,11 +405,16 @@ EXPORT_SYMBOL_GPL(smp_call_function_any);
  * hardware interrupt handler or from a bottom half handler. Preemption
  * must be disabled when calling this function.
  */
-void smp_call_function_many(const struct cpumask *mask,
-			    smp_call_func_t func, void *info, bool wait)
+void __smp_call_function_many(const struct cpumask *mask,
+			      smp_call_func_t remote_func,
+			      smp_call_func_t local_func,
+			      void *info, bool wait)
 {
+	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
-	int cpu, next_cpu, this_cpu = smp_processor_id();
+	bool run_remote = false;
+	bool run_local = false;
+	int nr_cpus = 0;
 
 	/*
 	 * Can deadlock when called with interrupts disabled.
@@ -413,55 +422,62 @@ void smp_call_function_many(const struct cpumask *mask,
 	 * send smp call function interrupt to this cpu and as such deadlocks
 	 * can't happen.
 	 */
-	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
-		     && !oops_in_progress && !early_boot_irqs_disabled);
+	if (cpu_online(this_cpu) && !oops_in_progress && !early_boot_irqs_disabled)
+		lockdep_assert_irqs_enabled();
+
+	/* Check if we need local execution. */
+	if (local_func && cpumask_test_cpu(this_cpu, mask))
+		run_local = true;
 
-	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
+	/* Check if we need remote execution, i.e., any CPU excluding this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
 	if (cpu == this_cpu)
 		cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
+	if (cpu < nr_cpu_ids)
+		run_remote = true;
 
-	/* No online cpus?  We're done. */
-	if (cpu >= nr_cpu_ids)
-		return;
+	if (run_remote) {
+		cfd = this_cpu_ptr(&cfd_data);
 
-	/* Do we have another CPU which isn't us? */
-	next_cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
-	if (next_cpu == this_cpu)
-		next_cpu = cpumask_next_and(next_cpu, mask, cpu_online_mask);
-
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
+			nr_cpus++;
+			last_cpu = cpu;
+
+			csd_lock(csd);
+			if (wait)
+				csd->flags |= CSD_FLAG_SYNCHRONOUS;
+			csd->func = remote_func;
+			csd->info = info;
+			if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
+				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
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
+		local_func(info);
+		local_irq_restore(flags);
 	}
 
-	/* Send a message to all CPUs in the map */
-	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
-
-	if (wait) {
+	if (run_remote && wait) {
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd;
 
@@ -470,7 +486,7 @@ void smp_call_function_many(const struct cpumask *mask,
 		}
 	}
 }
-EXPORT_SYMBOL(smp_call_function_many);
+EXPORT_SYMBOL(__smp_call_function_many);
 
 /**
  * smp_call_function(): Run a function on all other CPUs.
@@ -587,24 +603,6 @@ void __init smp_init(void)
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
@@ -624,16 +622,11 @@ EXPORT_SYMBOL(on_each_cpu);
 void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
 			void *info, bool wait)
 {
-	int cpu = get_cpu();
+	preempt_disable();
 
-	smp_call_function_many(mask, func, info, wait);
-	if (cpumask_test_cpu(cpu, mask)) {
-		unsigned long flags;
-		local_irq_save(flags);
-		func(info);
-		local_irq_restore(flags);
-	}
-	put_cpu();
+	__smp_call_function_many(mask, func, func, info, wait);
+
+	preempt_enable();
 }
 EXPORT_SYMBOL(on_each_cpu_mask);
 
-- 
2.17.1

