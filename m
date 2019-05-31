Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91BAC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63B02646E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfEaGhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:37:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33048 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaGhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:37:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so3486773pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBajaBal8qaaTwN0mvJMqHtJ3QjywAhkGdRUatyZFOA=;
        b=svv7490Y1uJRCiLaZ1fpFrKVamy8Dei+v1LqH/2/NQNFv0Dsnsj6RaS/RiyOvsMf/p
         UAbAn/rvA6NeCF5W9jFOnGs5S2m6dzDrIeUpw0mqjFkoxmsUKmfadomFQVoXNwCP7klC
         5kFh/6gyEO57lV5fzkmAsJ8+4jUh3M5gXquDFoA61gaBqOSWzNuRH/hq0VrsmNDfzKG3
         WgUiSOdxy5dz8LzZX+7+hbVnmi84po1YTiUajUsbGSCIJ/g/UCTbqxE4VZowXM3yf1xe
         gX3/B1n10NeTKuEnyejO9BA1yc6J+JSvyava1LYU+WsOCqigQ5+7D0xlGWplywcjAgMh
         h3RA==
X-Gm-Message-State: APjAAAWwbMgCOdWhsI0hvjv49M7BW7OZU93ul8RTpup1PUFt1nO8o6+O
        ssuMKa0RIRwxycjA3jcK9KU=
X-Google-Smtp-Source: APXvYqxVZeL5YYWbn5ei0723NwNgVhlZ4ZINw/79wB+GZyciyX2BQXdGrqZDvvnlpqIa/5mh6+k3cA==
X-Received: by 2002:a63:d652:: with SMTP id d18mr7596653pgj.112.1559284619307;
        Thu, 30 May 2019 23:36:59 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g17sm9256429pfk.55.2019.05.30.23.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:36:58 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH v2 01/12] smp: Remove smp_call_function() and on_each_cpu() return values
Date:   Thu, 30 May 2019 23:36:34 -0700
Message-Id: <20190531063645.4697-2-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531063645.4697-1-namit@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value is fixed. Remove it and amend the callers.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/alpha/kernel/smp.c      | 19 +++++--------------
 arch/alpha/oprofile/common.c |  6 +++---
 arch/ia64/kernel/perfmon.c   | 12 ++----------
 arch/ia64/kernel/uncached.c  |  8 ++++----
 arch/x86/lib/cache-smp.c     |  3 ++-
 drivers/char/agp/generic.c   |  3 +--
 include/linux/smp.h          |  7 +++----
 kernel/smp.c                 | 10 +++-------
 kernel/up.c                  |  3 +--
 9 files changed, 24 insertions(+), 47 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index d0dccae53ba9..5f90df30be20 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -614,8 +614,7 @@ void
 smp_imb(void)
 {
 	/* Must wait other processors to flush their icache before continue. */
-	if (on_each_cpu(ipi_imb, NULL, 1))
-		printk(KERN_CRIT "smp_imb: timed out\n");
+	on_each_cpu(ipi_imb, NULL, 1);
 }
 EXPORT_SYMBOL(smp_imb);
 
@@ -630,9 +629,7 @@ flush_tlb_all(void)
 {
 	/* Although we don't have any data to pass, we do want to
 	   synchronize with the other processors.  */
-	if (on_each_cpu(ipi_flush_tlb_all, NULL, 1)) {
-		printk(KERN_CRIT "flush_tlb_all: timed out\n");
-	}
+	on_each_cpu(ipi_flush_tlb_all, NULL, 1);
 }
 
 #define asn_locked() (cpu_data[smp_processor_id()].asn_lock)
@@ -667,9 +664,7 @@ flush_tlb_mm(struct mm_struct *mm)
 		}
 	}
 
-	if (smp_call_function(ipi_flush_tlb_mm, mm, 1)) {
-		printk(KERN_CRIT "flush_tlb_mm: timed out\n");
-	}
+	smp_call_function(ipi_flush_tlb_mm, mm, 1);
 
 	preempt_enable();
 }
@@ -720,9 +715,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 	data.mm = mm;
 	data.addr = addr;
 
-	if (smp_call_function(ipi_flush_tlb_page, &data, 1)) {
-		printk(KERN_CRIT "flush_tlb_page: timed out\n");
-	}
+	smp_call_function(ipi_flush_tlb_page, &data, 1);
 
 	preempt_enable();
 }
@@ -772,9 +765,7 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 		}
 	}
 
-	if (smp_call_function(ipi_flush_icache_page, mm, 1)) {
-		printk(KERN_CRIT "flush_icache_page: timed out\n");
-	}
+	smp_call_function(ipi_flush_icache_page, mm, 1);
 
 	preempt_enable();
 }
diff --git a/arch/alpha/oprofile/common.c b/arch/alpha/oprofile/common.c
index 310a4ce1dccc..1b1259c7d7d1 100644
--- a/arch/alpha/oprofile/common.c
+++ b/arch/alpha/oprofile/common.c
@@ -65,7 +65,7 @@ op_axp_setup(void)
 	model->reg_setup(&reg, ctr, &sys);
 
 	/* Configure the registers on all cpus.  */
-	(void)smp_call_function(model->cpu_setup, &reg, 1);
+	smp_call_function(model->cpu_setup, &reg, 1);
 	model->cpu_setup(&reg);
 	return 0;
 }
@@ -86,7 +86,7 @@ op_axp_cpu_start(void *dummy)
 static int
 op_axp_start(void)
 {
-	(void)smp_call_function(op_axp_cpu_start, NULL, 1);
+	smp_call_function(op_axp_cpu_start, NULL, 1);
 	op_axp_cpu_start(NULL);
 	return 0;
 }
@@ -101,7 +101,7 @@ op_axp_cpu_stop(void *dummy)
 static void
 op_axp_stop(void)
 {
-	(void)smp_call_function(op_axp_cpu_stop, NULL, 1);
+	smp_call_function(op_axp_cpu_stop, NULL, 1);
 	op_axp_cpu_stop(NULL);
 }
 
diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index 7a969f4c3534..6cf7db1daba2 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -6389,11 +6389,7 @@ pfm_install_alt_pmu_interrupt(pfm_intr_handler_desc_t *hdl)
 	}
 
 	/* save the current system wide pmu states */
-	ret = on_each_cpu(pfm_alt_save_pmu_state, NULL, 1);
-	if (ret) {
-		DPRINT(("on_each_cpu() failed: %d\n", ret));
-		goto cleanup_reserve;
-	}
+	on_each_cpu(pfm_alt_save_pmu_state, NULL, 1);
 
 	/* officially change to the alternate interrupt handler */
 	pfm_alt_intr_handler = hdl;
@@ -6420,7 +6416,6 @@ int
 pfm_remove_alt_pmu_interrupt(pfm_intr_handler_desc_t *hdl)
 {
 	int i;
-	int ret;
 
 	if (hdl == NULL) return -EINVAL;
 
@@ -6434,10 +6429,7 @@ pfm_remove_alt_pmu_interrupt(pfm_intr_handler_desc_t *hdl)
 
 	pfm_alt_intr_handler = NULL;
 
-	ret = on_each_cpu(pfm_alt_restore_pmu_state, NULL, 1);
-	if (ret) {
-		DPRINT(("on_each_cpu() failed: %d\n", ret));
-	}
+	on_each_cpu(pfm_alt_restore_pmu_state, NULL, 1);
 
 	for_each_online_cpu(i) {
 		pfm_unreserve_session(NULL, 1, i);
diff --git a/arch/ia64/kernel/uncached.c b/arch/ia64/kernel/uncached.c
index 583f7ff6b589..c618d0745e22 100644
--- a/arch/ia64/kernel/uncached.c
+++ b/arch/ia64/kernel/uncached.c
@@ -124,8 +124,8 @@ static int uncached_add_chunk(struct uncached_pool *uc_pool, int nid)
 	status = ia64_pal_prefetch_visibility(PAL_VISIBILITY_PHYSICAL);
 	if (status == PAL_VISIBILITY_OK_REMOTE_NEEDED) {
 		atomic_set(&uc_pool->status, 0);
-		status = smp_call_function(uncached_ipi_visibility, uc_pool, 1);
-		if (status || atomic_read(&uc_pool->status))
+		smp_call_function(uncached_ipi_visibility, uc_pool, 1);
+		if (atomic_read(&uc_pool->status))
 			goto failed;
 	} else if (status != PAL_VISIBILITY_OK)
 		goto failed;
@@ -146,8 +146,8 @@ static int uncached_add_chunk(struct uncached_pool *uc_pool, int nid)
 	if (status != PAL_STATUS_SUCCESS)
 		goto failed;
 	atomic_set(&uc_pool->status, 0);
-	status = smp_call_function(uncached_ipi_mc_drain, uc_pool, 1);
-	if (status || atomic_read(&uc_pool->status))
+	smp_call_function(uncached_ipi_mc_drain, uc_pool, 1);
+	if (atomic_read(&uc_pool->status))
 		goto failed;
 
 	/*
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 1811fa4a1b1a..7c48ff4ae8d1 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -15,6 +15,7 @@ EXPORT_SYMBOL(wbinvd_on_cpu);
 
 int wbinvd_on_all_cpus(void)
 {
-	return on_each_cpu(__wbinvd, NULL, 1);
+	on_each_cpu(__wbinvd, NULL, 1);
+	return 0;
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);
diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index 658664a5a5aa..df1edb5ec0ad 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -1311,8 +1311,7 @@ static void ipi_handler(void *null)
 
 void global_cache_flush(void)
 {
-	if (on_each_cpu(ipi_handler, NULL, 1) != 0)
-		panic(PFX "timed out waiting for the other CPUs!\n");
+	on_each_cpu(ipi_handler, NULL, 1);
 }
 EXPORT_SYMBOL(global_cache_flush);
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index a56f08ff3097..bb8b451ab01f 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -35,7 +35,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 /*
  * Call a function on all processors
  */
-int on_each_cpu(smp_call_func_t func, void *info, int wait);
+void on_each_cpu(smp_call_func_t func, void *info, int wait);
 
 /*
  * Call a function on processors specified by mask, which might include
@@ -101,7 +101,7 @@ extern void smp_cpus_done(unsigned int max_cpus);
 /*
  * Call a function on all other processors
  */
-int smp_call_function(smp_call_func_t func, void *info, int wait);
+void smp_call_function(smp_call_func_t func, void *info, int wait);
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait);
 
@@ -144,9 +144,8 @@ static inline void smp_send_stop(void) { }
  *	These macros fold the SMP functionality into a single CPU system
  */
 #define raw_smp_processor_id()			0
-static inline int up_smp_call_function(smp_call_func_t func, void *info)
+static inline void up_smp_call_function(smp_call_func_t func, void *info)
 {
-	return 0;
 }
 #define smp_call_function(func, info, wait) \
 			(up_smp_call_function(func, info))
diff --git a/kernel/smp.c b/kernel/smp.c
index f4cf1b0bb3b8..e0b05ac53108 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -486,13 +486,11 @@ EXPORT_SYMBOL(smp_call_function_many);
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-int smp_call_function(smp_call_func_t func, void *info, int wait)
+void smp_call_function(smp_call_func_t func, void *info, int wait)
 {
 	preempt_disable();
 	smp_call_function_many(cpu_online_mask, func, info, wait);
 	preempt_enable();
-
-	return 0;
 }
 EXPORT_SYMBOL(smp_call_function);
 
@@ -593,18 +591,16 @@ void __init smp_init(void)
  * early_boot_irqs_disabled is set.  Use local_irq_save/restore() instead
  * of local_irq_disable/enable().
  */
-int on_each_cpu(void (*func) (void *info), void *info, int wait)
+void on_each_cpu(void (*func) (void *info), void *info, int wait)
 {
 	unsigned long flags;
-	int ret = 0;
 
 	preempt_disable();
-	ret = smp_call_function(func, info, wait);
+	smp_call_function(func, info, wait);
 	local_irq_save(flags);
 	func(info);
 	local_irq_restore(flags);
 	preempt_enable();
-	return ret;
 }
 EXPORT_SYMBOL(on_each_cpu);
 
diff --git a/kernel/up.c b/kernel/up.c
index ff536f9cc8a2..378551e79894 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -34,14 +34,13 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 }
 EXPORT_SYMBOL(smp_call_function_single_async);
 
-int on_each_cpu(smp_call_func_t func, void *info, int wait)
+void on_each_cpu(smp_call_func_t func, void *info, int wait)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
 	func(info);
 	local_irq_restore(flags);
-	return 0;
 }
 EXPORT_SYMBOL(on_each_cpu);
 
-- 
2.20.1

