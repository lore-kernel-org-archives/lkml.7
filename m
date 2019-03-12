Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D9BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7554D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413527;
	bh=Q5r4hnj20sDoyva8BiUTqcq9VqnPMfXynZ+qQoz6Bjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cNb42UVoZflPQEqatdw7s3TsbsCCZrEd4K8EDnM5zNE/tJSoOOvQbHckDZVEb7Xnt
	 OSLufaouxuzZRidqMgnJYx4YOjQ1wqY+Vlvt08reeMj320c/RkxH7zN2QoqF7wvEV1
	 2i4wyBLbRhP+ypsYgfkYP8JLLFzoQpgGxBRlvlys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfCLR6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbfCLRNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:39 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E982183E;
        Tue, 12 Mar 2019 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410818;
        bh=Q5r4hnj20sDoyva8BiUTqcq9VqnPMfXynZ+qQoz6Bjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b87c8jxm7Tp8Y9170f082tc+JwxT3NDXywtxeioxBAmrf/80AGM2Ad8QpLRKqElqg
         jyX7jiRSHQn/TPtwbtHDZwbNJWJzC1OjtoiFTkKaPnkCTe/FkBCxGcrnhVliGPyae7
         jIdvH7btL3g5MXYxdA1cszHhVdwH8lt49Fi47E4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.20 171/171] perf/x86/intel: Implement support for TSX Force Abort
Date:   Tue, 12 Mar 2019 10:09:11 -0700
Message-Id: <20190312170402.234807734@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

commit 400816f60c543153656ac74eaf7f36f6b7202378 upstream

Skylake (and later) will receive a microcode update to address a TSX
errata. This microcode will, on execution of a TSX instruction
(speculative or not) use (clobber) PMC3. This update will also provide
a new MSR to change this behaviour along with a CPUID bit to enumerate
the presence of this new MSR.

When the MSR gets set; the microcode will no longer use PMC3 but will
Force Abort every TSX transaction (upon executing COMMIT).

When TSX Force Abort (TFA) is allowed (default); the MSR gets set when
PMC3 gets scheduled and cleared when, after scheduling, PMC3 is
unused.

When TFA is not allowed; clear PMC3 from all constraints such that it
will not get used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |   74 +++++++++++++++++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h |    6 +++
 2 files changed, 77 insertions(+), 3 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -1999,6 +1999,39 @@ static void intel_pmu_nhm_enable_all(int
 	intel_pmu_enable_all(added);
 }
 
+static void intel_set_tfa(struct cpu_hw_events *cpuc, bool on)
+{
+	u64 val = on ? MSR_TFA_RTM_FORCE_ABORT : 0;
+
+	if (cpuc->tfa_shadow != val) {
+		cpuc->tfa_shadow = val;
+		wrmsrl(MSR_TSX_FORCE_ABORT, val);
+	}
+}
+
+static void intel_tfa_commit_scheduling(struct cpu_hw_events *cpuc, int idx, int cntr)
+{
+	/*
+	 * We're going to use PMC3, make sure TFA is set before we touch it.
+	 */
+	if (cntr == 3 && !cpuc->is_fake)
+		intel_set_tfa(cpuc, true);
+}
+
+static void intel_tfa_pmu_enable_all(int added)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	/*
+	 * If we find PMC3 is no longer used when we enable the PMU, we can
+	 * clear TFA.
+	 */
+	if (!test_bit(3, cpuc->active_mask))
+		intel_set_tfa(cpuc, false);
+
+	intel_pmu_enable_all(added);
+}
+
 static void enable_counter_freeze(void)
 {
 	update_debugctlmsr(get_debugctlmsr() |
@@ -3354,6 +3387,26 @@ glp_get_event_constraints(struct cpu_hw_
 	return c;
 }
 
+static bool allow_tsx_force_abort = true;
+
+static struct event_constraint *
+tfa_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			  struct perf_event *event)
+{
+	struct event_constraint *c = hsw_get_event_constraints(cpuc, idx, event);
+
+	/*
+	 * Without TFA we must not use PMC3.
+	 */
+	if (!allow_tsx_force_abort && test_bit(3, c->idxmsk)) {
+		c = dyn_constraint(cpuc, c, idx);
+		c->idxmsk64 &= ~(1ULL << 3);
+		c->weight--;
+	}
+
+	return c;
+}
+
 /*
  * Broadwell:
  *
@@ -3448,13 +3501,15 @@ int intel_cpuc_prepare(struct cpu_hw_eve
 			goto err;
 	}
 
-	if (x86_pmu.flags & PMU_FL_EXCL_CNTRS) {
+	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA)) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
 		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
 		if (!cpuc->constraint_list)
 			goto err_shared_regs;
+	}
 
+	if (x86_pmu.flags & PMU_FL_EXCL_CNTRS) {
 		cpuc->excl_cntrs = allocate_excl_cntrs(cpu);
 		if (!cpuc->excl_cntrs)
 			goto err_constraint_list;
@@ -3564,9 +3619,10 @@ static void free_excl_cntrs(struct cpu_h
 		if (c->core_id == -1 || --c->refcnt == 0)
 			kfree(c);
 		cpuc->excl_cntrs = NULL;
-		kfree(cpuc->constraint_list);
-		cpuc->constraint_list = NULL;
 	}
+
+	kfree(cpuc->constraint_list);
+	cpuc->constraint_list = NULL;
 }
 
 static void intel_pmu_cpu_dying(int cpu)
@@ -4086,8 +4142,11 @@ static struct attribute *intel_pmu_caps_
        NULL
 };
 
+DEVICE_BOOL_ATTR(allow_tsx_force_abort, 0644, allow_tsx_force_abort);
+
 static struct attribute *intel_pmu_attrs[] = {
 	&dev_attr_freeze_on_smi.attr,
+	NULL, /* &dev_attr_allow_tsx_force_abort.attr.attr */
 	NULL,
 };
 
@@ -4580,6 +4639,15 @@ __init int intel_pmu_init(void)
 		tsx_attr = hsw_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(
 			boot_cpu_data.x86_model == INTEL_FAM6_SKYLAKE_X);
+
+		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
+			x86_pmu.flags |= PMU_FL_TFA;
+			x86_pmu.get_event_constraints = tfa_get_event_constraints;
+			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
+			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
+			intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr.attr;
+		}
+
 		pr_cont("Skylake events, ");
 		name = "skylake";
 		break;
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -243,6 +243,11 @@ struct cpu_hw_events {
 	int excl_thread_id; /* 0 or 1 */
 
 	/*
+	 * SKL TSX_FORCE_ABORT shadow
+	 */
+	u64				tfa_shadow;
+
+	/*
 	 * AMD specific bits
 	 */
 	struct amd_nb			*amd_nb;
@@ -681,6 +686,7 @@ do {									\
 #define PMU_FL_EXCL_CNTRS	0x4 /* has exclusive counter requirements  */
 #define PMU_FL_EXCL_ENABLED	0x8 /* exclusive counter active */
 #define PMU_FL_PEBS_ALL		0x10 /* all events are valid PEBS events */
+#define PMU_FL_TFA		0x20 /* deal with TSX force abort */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr


