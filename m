Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB594C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CB220692
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKRM6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:58:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:63296 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfKRM6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:58:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 04:58:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="236909234"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.25])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2019 04:58:47 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2] perf/x86/intel: Avoid unnecessary PEBS_ENABLE MSR access in PMI
Date:   Mon, 18 Nov 2019 04:58:05 -0800
Message-Id: <20191118125805.18918-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf PMI handler, intel_pmu_handle_irq(), currently does
unnecessary MSR accesses for PEBS_ENABLE MSR in
__intel_pmu_enable/disable_all() when PEBS is enabled.

When entering the handler, global ctrl is explicitly disabled. All
counters do not count anymore. It doesn't matter if PEBS is enabled
or not in a PMI handler.
Furthermore, for most cases, the cpuc->pebs_enabled is not changed in
PMI. The PEBS status doesn't change. The PEBS_ENABLE MSR doesn't need to
be changed either when exiting the handler.

PMI throttle may change the PEBS status during PMI handler. The
x86_pmu_stop() ends up in intel_pmu_pebs_disable() which can update
cpuc->pebs_enabled. But the PEBS_ENABLE MSR will be updated as well when
cpuc->enabled == 1. No need to access PEBS_ENABLE MSR again for this
case when exiting the handler.
However, the PMI may land after cpuc->enabled=0 in x86_pmu_disable() and
PMI throttle may be triggered for the PMI. For this rare case,
intel_pmu_pebs_disable() will not touch PEBS_ENABLE MSR. The patch
explicitly disable the PEBS for this case.

Use ftrace to measure the duration of intel_pmu_handle_irq() on BDX.
   #perf record -e cycles:P -- ./tchain_edit

The average duration of intel_pmu_handle_irq()
Without the patch       1.144 us
With the patch          1.025 us

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Update description and comments
- Handle a rare case. The PMI may land after cpuc->enabled=0 in
  x86_pmu_disable() and PMI throttle may be triggered for the PMI.

 arch/x86/events/intel/core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bc6468329c52..18e1132c0fd7 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -1963,6 +1963,14 @@ static __initconst const u64 knl_hw_cache_extra_regs
  * intel_bts events don't coexist with intel PMU's BTS events because of
  * x86_add_exclusive(x86_lbr_exclusive_lbr); there's no need to keep them
  * disabled around intel PMU's event batching etc, only inside the PMI handler.
+ *
+ * Avoid PEBS_ENABLE MSR access in PMIs.
+ * The GLOBAL_CTRL has been disabled. All the counters do not count anymore.
+ * It doesn't matter if the PEBS is enabled or not.
+ * Usually, the PEBS status are not changed in PMIs. It's unnecessary to
+ * access PEBS_ENABLE MSR in disable_all()/enable_all().
+ * However, there are some cases which may change PEBS status, e.g. PMI
+ * throttle. The PEBS_ENABLE should be updated where the status changes.
  */
 static void __intel_pmu_disable_all(void)
 {
@@ -1972,13 +1980,12 @@ static void __intel_pmu_disable_all(void)
 
 	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask))
 		intel_pmu_disable_bts();
-
-	intel_pmu_pebs_disable_all();
 }
 
 static void intel_pmu_disable_all(void)
 {
 	__intel_pmu_disable_all();
+	intel_pmu_pebs_disable_all();
 	intel_pmu_lbr_disable_all();
 }
 
@@ -1986,7 +1993,6 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	intel_pmu_pebs_enable_all();
 	intel_pmu_lbr_enable_all(pmi);
 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL,
 			x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
@@ -2004,6 +2010,7 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 
 static void intel_pmu_enable_all(int added)
 {
+	intel_pmu_pebs_enable_all();
 	__intel_pmu_enable_all(added, false);
 }
 
@@ -2620,6 +2627,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		handled++;
 		x86_pmu.drain_pebs(regs);
 		status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
+
+		/*
+		 * PMI may land after cpuc->enabled=0 in x86_pmu_disable() and
+		 * PMI throttle may be triggered for the PMI.
+		 * For this rare case, intel_pmu_pebs_disable() will not touch
+		 * MSR_IA32_PEBS_ENABLE. Explicitly disable the PEBS here.
+		 */
+		if (unlikely(!cpuc->enabled && !cpuc->pebs_enabled))
+			wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
 	}
 
 	/*
-- 
2.17.1

