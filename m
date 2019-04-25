Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FFFC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D4F206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbfDYXBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:01:46 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:29269 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbfDYXBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:01:46 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 25 Apr 2019 16:01:43 -0700
Received: from htb-2n-eng-dhcp405.eng.vmware.com (unknown [10.33.114.36])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id A5DDFB1F67;
        Thu, 25 Apr 2019 19:01:44 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
CC:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v3] x86/mm/tlb: Remove flush_tlb_info from the stack
Date:   Thu, 25 Apr 2019 16:01:43 -0700
Message-ID: <20190425230143.7008-1-namit@vmware.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move flush_tlb_info variables off the stack. This allows to align
flush_tlb_info to cache-line and avoid potentially unnecessary cache
line movements. It also allows to have a fixed virtual-to-physical
translation of the variables, which reduces TLB misses.

Use per-CPU struct for flush_tlb_mm_range() and
flush_tlb_kernel_range(). Add debug assertions to ensure there are
no nested TLB flushes that might overwrite the per-CPU data. For
arch_tlbbatch_flush() use a const struct.

Results when running a microbenchmarks that performs 10^6 MADV_DONTEED
operations and touching a page, in which 3 additional threads run a
busy-wait loop (5 runs, PTI and retpolines are turned off):

			base		off-stack
			----		---------
avg (usec/op)		1.629		1.570	(-3%)
stddev			0.014		0.009

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nadav Amit <namit@vmware.com>

---

v2->v3:
- Remove redundant assignment operations
- Formatting, comments, adding full_flush_tlb_info [Ingo]

v1->v2:
- Initialize all flush_tlb_info fields [Andy]
---
 arch/x86/mm/tlb.c | 116 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 34 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 487b8474c01c..7f61431c75fb 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -634,7 +634,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	this_cpu_write(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen, mm_tlb_gen);
 }
 
-static void flush_tlb_func_local(void *info, enum tlb_flush_reason reason)
+static void flush_tlb_func_local(const void *info, enum tlb_flush_reason reason)
 {
 	const struct flush_tlb_info *f = info;
 
@@ -722,43 +722,81 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
  */
 unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_info);
+
+#ifdef CONFIG_DEBUG_VM
+static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
+#endif
+
+static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
+			unsigned long start, unsigned long end,
+			unsigned int stride_shift, bool freed_tables,
+			u64 new_tlb_gen)
+{
+	struct flush_tlb_info *info = this_cpu_ptr(&flush_tlb_info);
+
+#ifdef CONFIG_DEBUG_VM
+	/*
+	 * Ensure that the following code is non-reentrant and flush_tlb_info
+	 * is not overwritten. This means no TLB flushing is initiated by
+	 * interrupt handlers and machine-check exception handlers.
+	 */
+	BUG_ON(this_cpu_inc_return(flush_tlb_info_idx) != 1);
+#endif
+
+	info->start		= start;
+	info->end		= end;
+	info->mm		= mm;
+	info->stride_shift	= stride_shift;
+	info->freed_tables	= freed_tables;
+	info->new_tlb_gen	= new_tlb_gen;
+
+	return info;
+}
+
+static inline void put_flush_tlb_info(void)
+{
+#ifdef CONFIG_DEBUG_VM
+	/* Complete reentrency prevention checks */
+	barrier();
+	this_cpu_dec(flush_tlb_info_idx);
+#endif
+}
+
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
 				bool freed_tables)
 {
+	struct flush_tlb_info *info;
+	u64 new_tlb_gen;
 	int cpu;
 
-	struct flush_tlb_info info = {
-		.mm = mm,
-		.stride_shift = stride_shift,
-		.freed_tables = freed_tables,
-	};
-
 	cpu = get_cpu();
 
-	/* This is also a barrier that synchronizes with switch_mm(). */
-	info.new_tlb_gen = inc_mm_tlb_gen(mm);
-
 	/* Should we flush just the requested range? */
-	if ((end != TLB_FLUSH_ALL) &&
-	    ((end - start) >> stride_shift) <= tlb_single_page_flush_ceiling) {
-		info.start = start;
-		info.end = end;
-	} else {
-		info.start = 0UL;
-		info.end = TLB_FLUSH_ALL;
+	if ((end == TLB_FLUSH_ALL) ||
+	    ((end - start) >> stride_shift) > tlb_single_page_flush_ceiling) {
+		start = 0;
+		end = TLB_FLUSH_ALL;
 	}
 
+	/* This is also a barrier that synchronizes with switch_mm(). */
+	new_tlb_gen = inc_mm_tlb_gen(mm);
+
+	info = get_flush_tlb_info(mm, start, end, stride_shift, freed_tables,
+				  new_tlb_gen);
+
 	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
-		VM_WARN_ON(irqs_disabled());
+		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-		flush_tlb_func_local(&info, TLB_LOCAL_MM_SHOOTDOWN);
+		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
 		local_irq_enable();
 	}
 
 	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
-		flush_tlb_others(mm_cpumask(mm), &info);
+		flush_tlb_others(mm_cpumask(mm), info);
 
+	put_flush_tlb_info();
 	put_cpu();
 }
 
@@ -787,38 +825,48 @@ static void do_kernel_range_flush(void *info)
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-
 	/* Balance as user space task's flush, a bit conservative */
 	if (end == TLB_FLUSH_ALL ||
 	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
 		on_each_cpu(do_flush_tlb_all, NULL, 1);
 	} else {
-		struct flush_tlb_info info;
-		info.start = start;
-		info.end = end;
-		on_each_cpu(do_kernel_range_flush, &info, 1);
+		struct flush_tlb_info *info;
+
+		preempt_disable();
+		info = get_flush_tlb_info(NULL, start, end, 0, false, 0);
+
+		on_each_cpu(do_kernel_range_flush, info, 1);
+
+		put_flush_tlb_info();
+		preempt_enable();
 	}
 }
 
+/*
+ * arch_tlbbatch_flush() performs a full TLB flush regardless of the active mm.
+ * This means that the 'struct flush_tlb_info' that describes which mappings to
+ * flush is actually fixed. We therefore set a single fixed struct and use it in
+ * arch_tlbbatch_flush().
+ */
+static const struct flush_tlb_info full_flush_tlb_info = {
+	.mm = NULL,
+	.start = 0,
+	.end = TLB_FLUSH_ALL,
+};
+
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
-	struct flush_tlb_info info = {
-		.mm = NULL,
-		.start = 0UL,
-		.end = TLB_FLUSH_ALL,
-	};
-
 	int cpu = get_cpu();
 
 	if (cpumask_test_cpu(cpu, &batch->cpumask)) {
-		VM_WARN_ON(irqs_disabled());
+		lockdep_assert_irqs_enabled();
 		local_irq_disable();
-		flush_tlb_func_local(&info, TLB_LOCAL_SHOOTDOWN);
+		flush_tlb_func_local(&full_flush_tlb_info, TLB_LOCAL_SHOOTDOWN);
 		local_irq_enable();
 	}
 
 	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids)
-		flush_tlb_others(&batch->cpumask, &info);
+		flush_tlb_others(&batch->cpumask, &full_flush_tlb_info);
 
 	cpumask_clear(&batch->cpumask);
 
-- 
2.19.1

