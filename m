Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8444C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CFA26472
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfEaGhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:37:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38245 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfEaGhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:37:14 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so3596230plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sy96JwOodM2uyeI9a2kYXQQ+c8Bq3Qx8sWnCw6sUcCw=;
        b=jE19gyvUohfmi14lrX+F8d1HeFDrMANYWPBJxynEF3wMjAz7En9CoBqRDXY14LHqEv
         XhxQKqcUYwO9s89nEGgVZ2vuxsddQ2NiIqV3TlgrdetTubniHIEU8YhxUjB7la+POB08
         S6gyvjNoTtJyRvti2LLi7Bo9FtFCC0ybYPHhLgAzxD1O7vYhAmx6O22zqZLUum3laiy+
         wQr9kffxd7JCuTgKXbkNcqca3Xks4nIO8jYjhNSVYQIp2T00uya0oBpLonlcpqSu1G2R
         DGmFp34hFwPrfYGYLZNyyML1vyFZd5o+nwzlKdLdOFS1zXb3m4PfaFCT07+SXmVuoQpw
         ayMQ==
X-Gm-Message-State: APjAAAVGUcuRzVM0hmOvI+eWSn+oUnZ3C3E41FAgyGXLlgpwBPBzFIud
        DPhD4K7p8fyBpVvc/NiK/Fo=
X-Google-Smtp-Source: APXvYqy2fFdv2B1srQtuU7eGqHssmNaFpqrJgS3MHPKxmjso4ohMWCFkNkFG2hGMyynmAegfdC/x6g==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr7269563pln.226.1559284632461;
        Thu, 30 May 2019 23:37:12 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g17sm9256429pfk.55.2019.05.30.23.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:37:11 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [RFC PATCH v2 10/12] smp: Enable data inlining for inter-processor function call
Date:   Thu, 30 May 2019 23:36:43 -0700
Message-Id: <20190531063645.4697-11-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531063645.4697-1-namit@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some opportunities to improve the performance of
inter-processor function calls.

First, currently call_single_data, which is used for communicating the
data that is consumed by the function call is not cacheline aligned.
This might lead to false sharing, since different structures are used
for communication between two different CPUs.

Second, the data that is used as an argument for the remotely executed
function resides in a different address (and cacheline), so it also
needs to traverse between caches (in addition to call_single_data).

Third, some functions can be executed asynchronously, but their data
(i.e., info, which is used as an argument to the function) must stay
untouched until they are done. Such functions might be executed
synchronously right now due to lack of infrastructure.

Allow callers of __smp_call_function_many() and __on_each_cpu_mask() to
request function data to be inlined with the interprocessor message on
the same cache-line. Once the IPI is received, info is first copied to
the receiver stack to both avoid false sharing and support asynchronous
mode, in which the initiator of the remote-call does not wait for the
receiver.

While a remote function is executed, save in externally visible variable
the function that is currently executed. This information will be needed
soon for asynchronous remote TLB flushing.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/smp.h | 21 ++++++++----
 kernel/smp.c        | 83 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index b69abc88259d..eb449086feb3 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -18,8 +18,11 @@ typedef void (*smp_call_func_t)(void *info);
 struct __call_single_data {
 	struct llist_node llist;
 	smp_call_func_t func;
-	void *info;
 	unsigned int flags;
+	union {
+		void *info;
+		u8 inlined_info[0];
+	};
 };
 
 /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
@@ -32,12 +35,18 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
+void __on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
+		void *info, size_t info_size, bool wait);
+
 /*
  * Call a function on processors specified by mask, which might include
  * the local one.
  */
-void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
-		void *info, bool wait);
+static inline void on_each_cpu_mask(const struct cpumask *mask,
+				smp_call_func_t func, void *info, bool wait)
+{
+	__on_each_cpu_mask(mask, func, info, 0, wait);
+}
 
 /*
  * Call a function on all processors.  May be used during early boot while
@@ -109,13 +118,13 @@ void smp_call_function(smp_call_func_t func, void *info, int wait);
 
 void __smp_call_function_many(const struct cpumask *mask,
 			      smp_call_func_t remote_func,
-			      smp_call_func_t local_func,
-			      void *info, bool wait);
+			      smp_call_func_t local_func, void *info,
+			      size_t info_size, bool wait);
 
 static inline void smp_call_function_many(const struct cpumask *mask,
 				smp_call_func_t func, void *info, bool wait)
 {
-	__smp_call_function_many(mask, func, NULL, info, wait);
+	__smp_call_function_many(mask, func, NULL, info, 0, wait);
 }
 
 int smp_call_function_any(const struct cpumask *mask,
diff --git a/kernel/smp.c b/kernel/smp.c
index f1a358f9c34c..46cbf611a38d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -25,6 +25,7 @@
 enum {
 	CSD_FLAG_LOCK		= 0x01,
 	CSD_FLAG_SYNCHRONOUS	= 0x02,
+	CSD_FLAG_INLINED	= 0x04,
 };
 
 struct call_function_data {
@@ -35,8 +36,16 @@ struct call_function_data {
 
 static DEFINE_PER_CPU(struct call_function_data, cfd_data);
 
+/* Function which is currently executed asynchronously. */
+DECLARE_PER_CPU(smp_call_func_t, async_func_in_progress);
+DEFINE_PER_CPU(smp_call_func_t, async_func_in_progress);
+EXPORT_PER_CPU_SYMBOL(async_func_in_progress);
+
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct llist_head, call_single_queue);
 
+#define MAX_FUNC_INFO_SIZE						\
+	(SMP_CACHE_BYTES - offsetof(struct __call_single_data, inlined_info[0]))
+
 static void flush_smp_call_function_queue(bool warn_cpu_offline);
 
 int smpcfd_prepare_cpu(unsigned int cpu)
@@ -51,7 +60,15 @@ int smpcfd_prepare_cpu(unsigned int cpu)
 		free_cpumask_var(cfd->cpumask);
 		return -ENOMEM;
 	}
-	cfd->csd = alloc_percpu(call_single_data_t);
+
+	/*
+	 * Allocating a whole cache line to leave space for inlined data
+	 * adjacent to call_single_data_t. Ensure first that indeed the struct
+	 * is smaller than a cache line.
+	 */
+	BUILD_BUG_ON(sizeof(call_single_data_t) > SMP_CACHE_BYTES);
+
+	cfd->csd = __alloc_percpu(SMP_CACHE_BYTES, SMP_CACHE_BYTES);
 	if (!cfd->csd) {
 		free_cpumask_var(cfd->cpumask);
 		free_cpumask_var(cfd->cpumask_ipi);
@@ -235,16 +252,36 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 	}
 
 	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
+		u8 inlined_info[MAX_FUNC_INFO_SIZE] __aligned(sizeof(long));
 		smp_call_func_t func = csd->func;
-		void *info = csd->info;
+		void *info;
+
+		/*
+		 * Check if we are requested to copy the info to the local storage
+		 * and use it.
+		 */
+		if (csd->flags & CSD_FLAG_INLINED) {
+			memcpy(inlined_info, csd->inlined_info, MAX_FUNC_INFO_SIZE);
+			info = &inlined_info;
+		} else {
+			info = csd->info;
+		}
 
 		/* Do we wait until *after* callback? */
 		if (csd->flags & CSD_FLAG_SYNCHRONOUS) {
 			func(info);
 			csd_unlock(csd);
 		} else {
+			this_cpu_write(async_func_in_progress, csd->func);
 			csd_unlock(csd);
 			func(info);
+
+			/*
+			 * Ensure the write that indicates the func is completed
+			 * is only performed after the function is called.
+			 */
+			barrier();
+			this_cpu_write(async_func_in_progress, NULL);
 		}
 	}
 
@@ -395,10 +432,15 @@ EXPORT_SYMBOL_GPL(smp_call_function_any);
  *		fast and non-blocking. If NULL is provided, no function will
  *		be executed on this CPU.
  * @info: An arbitrary pointer to pass to the function.
+ * @info_size: Size of @info to copy into the inlined message that is sent to
+ *	       the target CPUs. If zero, @info will not be copied, but can be
+ *	       accessed. Must be smaller than %MAX_FUNC_INFO_SIZE.
  * @wait: If true, wait (atomically) until function has completed
  *        on other CPUs.
  *
- * If @wait is true, then returns once @func has returned.
+ * If @wait is true, then returns once @func has returned. Otherwise, returns
+ * after the IPI is delivered. If @info_size > 0, the funciton returns only
+ * after the @info was copied by the remote CPU to local storage.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler. Preemption
@@ -406,11 +448,12 @@ EXPORT_SYMBOL_GPL(smp_call_function_any);
  */
 void __smp_call_function_many(const struct cpumask *mask,
 			      smp_call_func_t remote_func,
-			      smp_call_func_t local_func,
-			      void *info, bool wait)
+			      smp_call_func_t local_func, void *info,
+			      size_t info_size, bool wait)
 {
 	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
+	bool copy = (info_size != 0);
 	bool run_remote = false;
 	bool run_local = false;
 	int nr_cpus = 0;
@@ -424,6 +467,16 @@ void __smp_call_function_many(const struct cpumask *mask,
 	if (cpu_online(this_cpu) && !oops_in_progress && !early_boot_irqs_disabled)
 		lockdep_assert_irqs_enabled();
 
+	/*
+	 * If size is too big, issue a warning. To be safe, we have to wait for
+	 * the function to be done.
+	 */
+	if (unlikely(info_size > MAX_FUNC_INFO_SIZE && copy)) {
+		WARN_ONCE(1, "Inlined IPI info size exceeds maximum\n");
+		copy = false;
+		wait = 1;
+	}
+
 	/* Check if we need local execution. */
 	if (local_func && cpumask_test_cpu(this_cpu, mask))
 		run_local = true;
@@ -449,10 +502,18 @@ void __smp_call_function_many(const struct cpumask *mask,
 			last_cpu = cpu;
 
 			csd_lock(csd);
+
+			if (copy) {
+				csd->flags |= CSD_FLAG_INLINED;
+				memcpy(csd->inlined_info, info, info_size);
+			} else {
+				csd->info = info;
+			}
+
 			if (wait)
 				csd->flags |= CSD_FLAG_SYNCHRONOUS;
 			csd->func = remote_func;
-			csd->info = info;
+
 			if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
 				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 		}
@@ -603,7 +664,7 @@ void __init smp_init(void)
 }
 
 /**
- * on_each_cpu_mask(): Run a function on processors specified by
+ * __on_each_cpu_mask(): Run a function on processors specified by
  * cpumask, which may include the local processor.
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
@@ -618,16 +679,16 @@ void __init smp_init(void)
  * exception is that it may be used during early boot while
  * early_boot_irqs_disabled is set.
  */
-void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
-			void *info, bool wait)
+void __on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
+			void *info, size_t info_size, bool wait)
 {
 	preempt_disable();
 
-	__smp_call_function_many(mask, func, func, info, wait);
+	__smp_call_function_many(mask, func, func, info, info_size, wait);
 
 	preempt_enable();
 }
-EXPORT_SYMBOL(on_each_cpu_mask);
+EXPORT_SYMBOL(__on_each_cpu_mask);
 
 /*
  * on_each_cpu_cond(): Call a function on each processor for which
-- 
2.20.1

