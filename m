Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E88C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69387206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mF+AxVL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfDZNkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:40:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDZNkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:40:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3QDeKWU3665482
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 26 Apr 2019 06:40:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3QDeKWU3665482
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556286021;
        bh=opfYyLN8dW79qmza6NpCVIp6iAclrMYhjIC0pnMTWXM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mF+AxVL60fYvTFP3FhCZ8aRd6H0oE4TjRq4MqNi50RFkQIIncgtKzqNVYGdyyiI5p
         VdNRRY3W3lnlSC9+iicTlx3LbxH+psvD+XE5hFNpZnaX1CDwrGFzTIC3n9xLT8R4zW
         HfNvZjj1RpORk4bidaOkfu9MnKyRGRpgW4qkN5Re1EnngzDFxUY0oMd4uu2GMDfiEM
         5chLzaU9+chjEuw3hAMANG14aOwsTGFa/i9XrezvSM5ZTVTRMMbXYRHs+ffFcdpezN
         mZ36ZxjysehGBP5CV8sTfOxxx3muWkhlJv6Bl+L+LXqKclrZOY0BuT2j0tFWtbYceH
         mKxGzHwyoVdcg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3QDeJ5E3665477;
        Fri, 26 Apr 2019 06:40:19 -0700
Date:   Fri, 26 Apr 2019 06:40:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-3db6d5a5ecaf0a778d721ccf9809248350d4bfaf@git.kernel.org>
Cc:     luto@kernel.org, bp@alien8.de, namit@vmware.com,
        tglx@linutronix.de, dave.hansen@intel.com, riel@surriel.com,
        mingo@kernel.org, brgerst@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, hpa@zytor.com
Reply-To: dave.hansen@intel.com, riel@surriel.com, tglx@linutronix.de,
          mingo@kernel.org, luto@kernel.org, namit@vmware.com,
          bp@alien8.de, a.p.zijlstra@chello.nl,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          torvalds@linux-foundation.org, brgerst@gmail.com
In-Reply-To: <20190425230143.7008-1-namit@vmware.com>
References: <20190425230143.7008-1-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/tlb: Remove 'struct flush_tlb_info' from the
 stack
Git-Commit-ID: 3db6d5a5ecaf0a778d721ccf9809248350d4bfaf
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

Commit-ID:  3db6d5a5ecaf0a778d721ccf9809248350d4bfaf
Gitweb:     https://git.kernel.org/tip/3db6d5a5ecaf0a778d721ccf9809248350d4bfaf
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Thu, 25 Apr 2019 16:01:43 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 26 Apr 2019 12:01:45 +0200

x86/mm/tlb: Remove 'struct flush_tlb_info' from the stack

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
  stddev		0.014		0.009

Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190425230143.7008-1-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/tlb.c | 116 ++++++++++++++++++++++++++++++++++++++----------------
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
 
