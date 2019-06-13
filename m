Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B52C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5417620644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392909AbfFMQmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:42:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34158 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730518AbfFMGtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 02:49:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so11203293pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 23:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7QpysVK7P/S7y51wNC4f0qx82b0Q0ZQf5FM1IyByFmU=;
        b=XRDOgRuGM/jB2msDvgBT4Gi0DmMIsp1hpPGDYGnsIKzfq2j3+x4zcIKoySHR5fvdR8
         +9e1l+iNaWWqZR6DTaNWW799MYaANf9n4VZoPhYSEe/CHR2R+GTYWulKwaGmsAU6dwmM
         JuYJc+8fbtSCJGezyAAQRzbhnqoqkOv283RB/XlGpB5J3COi5GpksH4UD5ln8WIFJKs6
         g08w8GuVoIZa84VH3dLpFsaC4ZKPx1sPx3KlbQWTJAgAQRZic6cthAadd8V60DCGk/Hb
         7N2Vv2rCUqJ6kUHfZmVnShVoi7XW4hncE9V5FHKSHlN7HGOEc0IJAHeh+/OUAtK/QQZH
         Syvg==
X-Gm-Message-State: APjAAAUDAX6/GdQLZU023SXhzmocTK0Iahf93J7VOTAUQ9zYv+bkbjZ4
        cNxBzv0OGZfHdwK80MeZNTM=
X-Google-Smtp-Source: APXvYqxe0A4P24qC4Me0m2uIthyBJeRImFsk6sHYYRg56ggduIO9ovMPNDK2Qy/AoKC2nOVZsypHRg==
X-Received: by 2002:a62:6044:: with SMTP id u65mr67334900pfb.15.1560408558677;
        Wed, 12 Jun 2019 23:49:18 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id i3sm1559973pfa.175.2019.06.12.23.49.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 23:49:18 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH 3/9] x86/mm/tlb: Refactor common code into flush_tlb_on_cpus()
Date:   Wed, 12 Jun 2019 23:48:07 -0700
Message-Id: <20190613064813.8102-4-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613064813.8102-1-namit@vmware.com>
References: <20190613064813.8102-1-namit@vmware.com>
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
index 91f6db92554c..c34bcf03f06f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -734,7 +734,11 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
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
@@ -762,6 +766,23 @@ static inline void put_flush_tlb_info(void)
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
@@ -770,9 +791,6 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 {
 	struct flush_tlb_info *info;
 	u64 new_tlb_gen;
-	int cpu;
-
-	cpu = get_cpu();
 
 	/* Should we flush just the requested range? */
 	if ((end == TLB_FLUSH_ALL) ||
@@ -787,18 +805,18 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
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
+			(mm == this_cpu_read(cpu_tlbstate.loaded_mm)) &&
+			mm != &init_mm);
 
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
-		flush_tlb_others(mm_cpumask(mm), info);
+	flush_tlb_on_cpus(mm_cpumask(mm), info);
 
 	put_flush_tlb_info();
-	put_cpu();
 }
 
 
@@ -833,13 +851,11 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	} else {
 		struct flush_tlb_info *info;
 
-		preempt_disable();
 		info = get_flush_tlb_info(NULL, start, end, 0, false, 0);
 
 		on_each_cpu(do_kernel_range_flush, info, 1);
 
 		put_flush_tlb_info();
-		preempt_enable();
 	}
 }
 
@@ -857,21 +873,11 @@ static const struct flush_tlb_info full_flush_tlb_info = {
 
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

