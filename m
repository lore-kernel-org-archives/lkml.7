Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F57C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69311206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411900;
	bh=r9FyuzUaMkY+NKLBvsOsD/XkV/PD1DRxFBnrIJxCrCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FdxCv0ZVqWfQJDDh9hsTziHsBFK3MqyfpMyE/FXeYWbKvdStbSgGGLFyqJPC65L6T
	 6mjrtnOiyfRuhgDDwPr7IL1mx2IRxHKIl8m3q8GoZFUdhO6U7agXSIA4MZuzcB42Es
	 YPVNoBkpDWl4RG4v4+zML+tsLWTaTge+ppAxaCps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfCLRbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbfCLRRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:10 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B592171F;
        Tue, 12 Mar 2019 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411029;
        bh=r9FyuzUaMkY+NKLBvsOsD/XkV/PD1DRxFBnrIJxCrCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mvk/aYAoGECSRwtdwRrw9CSNYNYwmNiZ+tKDEGxazlVvyzBWnmHX2uttrCB1vvTXp
         BjPGwznF+dYWTNadpKplte3pWeuopJO3UquSaAJhzkGW09eisjkPUEE1VeKDi8BtjD
         TGqMpmj+gh33wsr3hTWUyXiC2bvUjDoMxcJeKM4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 132/135] perf/x86/intel: Make cpuc allocations consistent
Date:   Tue, 12 Mar 2019 10:09:39 -0700
Message-Id: <20190312170353.325992189@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

commit d01b1f96a82e5dd7841a1d39db3abfdaf95f70ab upstream

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
@@ -1968,7 +1968,7 @@ static int x86_pmu_commit_txn(struct pmu
  */
 static void free_fake_cpuc(struct cpu_hw_events *cpuc)
 {
-	kfree(cpuc->shared_regs);
+	intel_cpuc_finish(cpuc);
 	kfree(cpuc);
 }
 
@@ -1980,14 +1980,11 @@ static struct cpu_hw_events *allocate_fa
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
@@ -3262,7 +3262,7 @@ ssize_t intel_event_sysfs_show(char *pag
 	return x86_event_sysfs_show(page, config, event);
 }
 
-struct intel_shared_regs *allocate_shared_regs(int cpu)
+static struct intel_shared_regs *allocate_shared_regs(int cpu)
 {
 	struct intel_shared_regs *regs;
 	int i;
@@ -3294,10 +3294,9 @@ static struct intel_excl_cntrs *allocate
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
@@ -3307,7 +3306,7 @@ static int intel_pmu_cpu_prepare(int cpu
 	if (x86_pmu.flags & PMU_FL_EXCL_CNTRS) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
-		cpuc->constraint_list = kzalloc(sz, GFP_KERNEL);
+		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
 		if (!cpuc->constraint_list)
 			goto err_shared_regs;
 
@@ -3332,6 +3331,11 @@ err:
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
@@ -3403,9 +3407,8 @@ static void intel_pmu_cpu_starting(int c
 	}
 }
 
-static void free_excl_cntrs(int cpu)
+static void free_excl_cntrs(struct cpu_hw_events *cpuc)
 {
-	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	struct intel_excl_cntrs *c;
 
 	c = cpuc->excl_cntrs;
@@ -3423,9 +3426,8 @@ static void intel_pmu_cpu_dying(int cpu)
 	fini_debug_store_on_cpu(cpu);
 }
 
-static void intel_pmu_cpu_dead(int cpu)
+void intel_cpuc_finish(struct cpu_hw_events *cpuc)
 {
-	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	struct intel_shared_regs *pc;
 
 	pc = cpuc->shared_regs;
@@ -3435,7 +3437,12 @@ static void intel_pmu_cpu_dead(int cpu)
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
@@ -4494,7 +4501,7 @@ static __init int fixup_ht_bug(void)
 	hardlockup_detector_perf_restart();
 
 	for_each_online_cpu(c)
-		free_excl_cntrs(c);
+		free_excl_cntrs(&per_cpu(cpu_hw_events, c));
 
 	cpus_read_unlock();
 	pr_info("PMU erratum BJ122, BV98, HSD29 workaround disabled, HT off\n");
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -880,7 +880,8 @@ struct event_constraint *
 x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event);
 
-struct intel_shared_regs *allocate_shared_regs(int cpu);
+extern int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu);
+extern void intel_cpuc_finish(struct cpu_hw_events *cpuc);
 
 int intel_pmu_init(void);
 
@@ -1014,9 +1015,13 @@ static inline int intel_pmu_init(void)
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


