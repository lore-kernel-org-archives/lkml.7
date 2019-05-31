Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82925C28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6137B2646E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfEaGhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:37:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37248 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfEaGhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:37:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id e7so3112525pln.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4BOxKga3sIPJeUuSYhutOqVYFIx9PIo1uS8S8T7b8Wc=;
        b=HNBIE+sJLwgWQmKGfuwpt61MxqUONPu0df3NwSir5CMPCfkgeRjEyPwV/ZrkV0h4vm
         2LmELnAW0kWC/uGXxYjPT+4amlzlIveYQvCEQxVu7K92LnhXVAgmTaT7ExfyCB/StbCZ
         gOadEVpRUMEPzHq4jjs0ptrjZtzb5VxJT3SCjbIudLfFKmGgvLjpdn+mfgJz3l0DP2Po
         5pTCnEsW+udL4TE5QCHHtTwNKB19g5ZYKLwY28VoElLjHPZpjVip2H0novlhwVV7KbkQ
         h7OBmI0kd3y1/gHqHCppCs7mi/N9E6ExVwVe7MSEnENCktekxyJgHxDHvOTTAbqn2cOW
         xZ+g==
X-Gm-Message-State: APjAAAWk5yflX3T6VxG3kYpUfyHJ9AtVLg6hkM+fVS/OTL8lLxUOrbcp
        DeUr7hTYhtbStrPydbUO/BY=
X-Google-Smtp-Source: APXvYqxZ/flXbfZHHkwwSBPFNK+xb9uFSYxDNQQ/Xc91PNsquLCy/kiUa1bVC06oo7PJ3neykmSqYg==
X-Received: by 2002:a17:902:e48e:: with SMTP id cj14mr6926096plb.299.1559284622267;
        Thu, 30 May 2019 23:37:02 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g17sm9256429pfk.55.2019.05.30.23.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:37:01 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [RFC PATCH v2 03/12] x86/mm/tlb: Refactor common code into flush_tlb_on_cpus()
Date:   Thu, 30 May 2019 23:36:36 -0700
Message-Id: <20190531063645.4697-4-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531063645.4697-1-namit@vmware.com>
References: <20190531063645.4697-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_tlbbatch_flush() and flush_tlb_mm_range() have very similar code,
which is effectively the same. Extract the mutual code into a new
function flush_tlb_on_cpus().

There is one functional change, which should not affect correctness:
flush_tlb_mm_range compared loaded_mm and the mm to figure out if local
flush is needed. Instead, the common code would look at the mm_cpumask()
which should give the same result. Performance should not be affected,
since this cpumask should not change in such a frequency that would
introduce cache contention.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 62 ++++++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 7f61431c75fb..ac98ad76f695 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -733,7 +733,11 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 			unsigned int stride_shift, bool freed_tables,
 			u64 new_tlb_gen)
 {
-	struct flush_tlb_info *info = this_cpu_ptr(&flush_tlb_info);
+	struct flush_tlb_info *info;
+
+	preempt_disable();
+
+	info = this_cpu_ptr(&flush_tlb_info);
 
 #ifdef CONFIG_DEBUG_VM
 	/*
@@ -761,6 +765,23 @@ static inline void put_flush_tlb_info(void)
 	barrier();
 	this_cpu_dec(flush_tlb_info_idx);
 #endif
+	preempt_enable();
+}
+
+static void flush_tlb_on_cpus(const cpumask_t *cpumask,
+			      const struct flush_tlb_info *info)
+{
+	int this_cpu = smp_processor_id();
+
+	if (cpumask_test_cpu(this_cpu, cpumask)) {
+		lockdep_assert_irqs_enabled();
+		local_irq_disable();
+		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
+		local_irq_enable();
+	}
+
+	if (cpumask_any_but(cpumask, this_cpu) < nr_cpu_ids)
+		flush_tlb_others(cpumask, info);
 }
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
@@ -769,9 +790,6 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 {
 	struct flush_tlb_info *info;
 	u64 new_tlb_gen;
-	int cpu;
-
-	cpu = get_cpu();
 
 	/* Should we flush just the requested range? */
 	if ((end == TLB_FLUSH_ALL) ||
@@ -786,18 +804,18 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
 				  new_tlb_gen);
 
-	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
-		lockdep_assert_irqs_enabled();
-		local_irq_disable();
-		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
-		local_irq_enable();
-	}
+	/*
+	 * Assert that mm_cpumask() corresponds with the loaded mm. We got one
+	 * exception: for init_mm we do not need to flush anything, and the
+	 * cpumask does not correspond with loaded_mm.
+	 */
+	VM_WARN_ON_ONCE(cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm)) !=
+			(mm == this_cpu_read(cpu_tlbstate.loaded_mm)) ||
+			mm == &init_mm);
 
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
-		flush_tlb_others(mm_cpumask(mm), info);
+	flush_tlb_on_cpus(mm_cpumask(mm), info);
 
 	put_flush_tlb_info();
-	put_cpu();
 }
 
 
@@ -832,13 +850,11 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	} else {
 		struct flush_tlb_info *info;
 
-		preempt_disable();
 		info = get_flush_tlb_info(NULL, start, end, 0, false, 0);
 
 		on_each_cpu(do_kernel_range_flush, info, 1);
 
 		put_flush_tlb_info();
-		preempt_enable();
 	}
 }
 
@@ -856,21 +872,11 @@ static const struct flush_tlb_info full_flush_tlb_info = {
 
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
-	int cpu = get_cpu();
-
-	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
-		lockdep_assert_irqs_enabled();
-		local_irq_disable();
-		flush_tlb_func_local(&full_flush_tlb_info, TLB_LOCAL_SHOOTDOWN);
-		local_irq_enable();
-	}
-
-	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids)
-		flush_tlb_others(&batch->cpumask, &full_flush_tlb_info);
+	preempt_disable();
+	flush_tlb_on_cpus(&batch->cpumask, &full_flush_tlb_info);
+	preempt_enable();
 
 	cpumask_clear(&batch->cpumask);
-
-	put_cpu();
 }
 
 static ssize_t tlbflush_read_file(struct file *file, char __user *user_buf,
-- 
2.20.1

