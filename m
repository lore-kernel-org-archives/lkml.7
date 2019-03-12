Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42862087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414343;
	bh=9jhTcBV93F/rUl40YM2NTogGBf9PFh4gTfh/ZTCJFSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oZTsgEJLIVeUZnvR3AGLEufyfuP/eitPtnApnqO7KVmH9qsv1CdxJ+acIqNvBaJS1
	 exyqswFmOuU2cgDDL61mDJeLaTl2l/+BYfDq8tpoX2YVF6aaFyrziYpUcPjbSXYoj6
	 aqwmAk8q7w9grFA7fm2TIQP1F6pDizGBWp7+qe4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfCLSMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfCLRLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:36 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10BBF2184C;
        Tue, 12 Mar 2019 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410696;
        bh=9jhTcBV93F/rUl40YM2NTogGBf9PFh4gTfh/ZTCJFSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6rpmURTpp0tlKvBpeRNydoe6vSKTVGwD07ziZOLXGpj6wHM3FaeOyoI3tQng0+QR
         Ki++7kWoiC//Ch65J/85tmdQGsiRRMwpukjmo67rLZAHnAk8WqpaL7f8bDUuA5cV/r
         OWjcpqQ1V2z+zwyH9f1ehak7Dw97EvA/NER9Jld4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.0 22/25] perf/x86/intel: Make cpuc allocations consistent
Date:   Tue, 12 Mar 2019 10:09:00 -0700
Message-Id: <20190312170405.316790931@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

The cpuc data structure allocation is different between fake and real
cpuc's; use the same code to init/free both.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/core.c       |   13 +++++--------
 arch/x86/events/intel/core.c |   29 ++++++++++++++++++-----------
 arch/x86/events/perf_event.h |   11 ++++++++---
 3 files changed, 31 insertions(+), 22 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1995,7 +1995,7 @@ static int x86_pmu_commit_txn(struct pmu
  */
 static void free_fake_cpuc(struct cpu_hw_events *cpuc)
 {
-	kfree(cpuc->shared_regs);
+	intel_cpuc_finish(cpuc);
 	kfree(cpuc);
 }
 
@@ -2007,14 +2007,11 @@ static struct cpu_hw_events *allocate_fa
 	cpuc = kzalloc(sizeof(*cpuc), GFP_KERNEL);
 	if (!cpuc)
 		return ERR_PTR(-ENOMEM);
-
-	/* only needed, if we have extra_regs */
-	if (x86_pmu.extra_regs) {
-		cpuc->shared_regs = allocate_shared_regs(cpu);
-		if (!cpuc->shared_regs)
-			goto error;
-	}
 	cpuc->is_fake = 1;
+
+	if (intel_cpuc_prepare(cpuc, cpu))
+		goto error;
+
 	return cpuc;
 error:
 	free_fake_cpuc(cpuc);
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3398,7 +3398,7 @@ ssize_t intel_event_sysfs_show(char *pag
 	return x86_event_sysfs_show(page, config, event);
 }
 
-struct intel_shared_regs *allocate_shared_regs(int cpu)
+static struct intel_shared_regs *allocate_shared_regs(int cpu)
 {
 	struct intel_shared_regs *regs;
 	int i;
@@ -3430,10 +3430,9 @@ static struct intel_excl_cntrs *allocate
 	return c;
 }
 
-static int intel_pmu_cpu_prepare(int cpu)
-{
-	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 
+int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
+{
 	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
 		cpuc->shared_regs = allocate_shared_regs(cpu);
 		if (!cpuc->shared_regs)
@@ -3443,7 +3442,7 @@ static int intel_pmu_cpu_prepare(int cpu
 	if (x86_pmu.flags & PMU_FL_EXCL_CNTRS) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
-		cpuc->constraint_list = kzalloc(sz, GFP_KERNEL);
+		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
 		if (!cpuc->constraint_list)
 			goto err_shared_regs;
 
@@ -3468,6 +3467,11 @@ err:
 	return -ENOMEM;
 }
 
+static int intel_pmu_cpu_prepare(int cpu)
+{
+	return intel_cpuc_prepare(&per_cpu(cpu_hw_events, cpu), cpu);
+}
+
 static void flip_smm_bit(void *data)
 {
 	unsigned long set = *(unsigned long *)data;
@@ -3542,9 +3546,8 @@ static void intel_pmu_cpu_starting(int c
 	}
 }
 
-static void free_excl_cntrs(int cpu)
+static void free_excl_cntrs(struct cpu_hw_events *cpuc)
 {
-	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	struct intel_excl_cntrs *c;
 
 	c = cpuc->excl_cntrs;
@@ -3565,9 +3568,8 @@ static void intel_pmu_cpu_dying(int cpu)
 		disable_counter_freeze();
 }
 
-static void intel_pmu_cpu_dead(int cpu)
+void intel_cpuc_finish(struct cpu_hw_events *cpuc)
 {
-	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	struct intel_shared_regs *pc;
 
 	pc = cpuc->shared_regs;
@@ -3577,7 +3579,12 @@ static void intel_pmu_cpu_dead(int cpu)
 		cpuc->shared_regs = NULL;
 	}
 
-	free_excl_cntrs(cpu);
+	free_excl_cntrs(cpuc);
+}
+
+static void intel_pmu_cpu_dead(int cpu)
+{
+	intel_cpuc_finish(&per_cpu(cpu_hw_events, cpu));
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
@@ -4715,7 +4722,7 @@ static __init int fixup_ht_bug(void)
 	hardlockup_detector_perf_restart();
 
 	for_each_online_cpu(c)
-		free_excl_cntrs(c);
+		free_excl_cntrs(&per_cpu(cpu_hw_events, c));
 
 	cpus_read_unlock();
 	pr_info("PMU erratum BJ122, BV98, HSD29 workaround disabled, HT off\n");
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -889,7 +889,8 @@ struct event_constraint *
 x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event);
 
-struct intel_shared_regs *allocate_shared_regs(int cpu);
+extern int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu);
+extern void intel_cpuc_finish(struct cpu_hw_events *cpuc);
 
 int intel_pmu_init(void);
 
@@ -1025,9 +1026,13 @@ static inline int intel_pmu_init(void)
 	return 0;
 }
 
-static inline struct intel_shared_regs *allocate_shared_regs(int cpu)
+static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
+{
+	return 0;
+}
+
+static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
 {
-	return NULL;
 }
 
 static inline int is_ht_workaround_enabled(void)


