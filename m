Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73C4C28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891602497F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfEaGhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:37:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42556 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfEaGhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:37:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id r22so5548941pfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c7McEbiFD1Kvb2Lg59lrSKaUPVdhbvcrjvcA62X4+go=;
        b=FqB7LB61iBuB6IM8KaFu9iXu6qYmA4WVXPy3zLdxFcjLRLds4lOZ3iax1Qu9QyU6Ws
         zN641Cx4am3AShXHPQ+vp5u+T3fdl5ISQQxPMmM+5cLFJcD8/hvyPNt0zwLVIlqam0ex
         7cA94Dwgewx6OoOBBgOcaYzISaqW8MHRfg3iQxyo2cZG8LBV7LjGewK0HkbyiE9cbFxJ
         mR2Q9H913O/wIZVzTejqXdJ6dkwV9Ntp1pVIfj7Kxxw8GGoE7OwcoC87tgS/iGiPhQRm
         cQt6mZ87JZUrxRHByiBjtHSd5Z999bi8D2GWwV3j4i4PhSzGZlfncra8V3FB1LtRkIto
         eOxg==
X-Gm-Message-State: APjAAAXPGJVTP8JUxsoGeSK9Al2nel5OZZs1XVrVP7WiTjWwDFM+fQS6
        MAseocJEjd7oH+UJAfktwnQcADlGVOw=
X-Google-Smtp-Source: APXvYqxuiP7liPEMnxDKjUrShyL5hFHfhW8fxfv2nb0YHKO3Mhi/pCCS4cixpTtbmqHN3x0f72P1kw==
X-Received: by 2002:a17:90a:c481:: with SMTP id j1mr7384539pjt.96.1559284620831;
        Thu, 30 May 2019 23:37:00 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g17sm9256429pfk.55.2019.05.30.23.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:36:59 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 02/12] smp: Run functions concurrently in smp_call_function_many()
Date:   Thu, 30 May 2019 23:36:35 -0700
Message-Id: <20190531063645.4697-3-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531063645.4697-1-namit@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index bb8b451ab01f..b69abc88259d 100644
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
index e0b05ac53108..6b411ee86ef6 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -387,9 +387,13 @@ int smp_call_function_any(const struct cpumask *mask,
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
@@ -400,11 +404,16 @@ EXPORT_SYMBOL_GPL(smp_call_function_any);
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
@@ -412,55 +421,62 @@ void smp_call_function_many(const struct cpumask *mask,
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
 
@@ -469,7 +485,7 @@ void smp_call_function_many(const struct cpumask *mask,
 		}
 	}
 }
-EXPORT_SYMBOL(smp_call_function_many);
+EXPORT_SYMBOL(__smp_call_function_many);
 
 /**
  * smp_call_function(): Run a function on all other CPUs.
@@ -586,24 +602,6 @@ void __init smp_init(void)
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
@@ -623,16 +621,11 @@ EXPORT_SYMBOL(on_each_cpu);
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
2.20.1

