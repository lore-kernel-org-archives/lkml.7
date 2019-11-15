Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F1C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6DE20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfKONj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:39:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:22156 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfKONjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:39:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 05:39:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="217099332"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.25])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2019 05:39:55 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Avoid PEBS_ENABLE MSR access in PMI
Date:   Fri, 15 Nov 2019 05:39:17 -0800
Message-Id: <20191115133917.24424-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf PMI handler, intel_pmu_handle_irq(), currently does
unnecessary MSR accesses when PEBS is enabled.

When entering the handler, global ctrl is explicitly disabled. All
counters do not count anymore. It doesn't matter if the PEBS is
enabled or disabled. Furthermore, cpuc->pebs_enabled is not changed
in PMI. The PEBS status doesn't change. The PEBS_ENABLE MSR doesn't need
to be changed either.

When exiting the handler, only the active PMU will be restore.
For active PMU, PEBS status is unchanged during the PMI handler.
Avoiding PEBS MSR access is harmless.
For inactive PMU, disable_all() will be called right after PMI handler,
which will eventually disable PEBS. During the period between PMI
handler exit and PEBS finally disabled, the global ctrl is always
disabled since we don't restore PMU state for inactive PMU. This
case is also harmless.

Use ftrace to measure the duration of intel_pmu_handle_irq() on BDX.
   #perf record -e cycles:P -- ./tchain_edit

The average duration of intel_pmu_handle_irq()
Without the patch	1.144 us
With the patch		1.025 us

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dc64b16e6b71..d715eb966334 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -1945,6 +1945,11 @@ static __initconst const u64 knl_hw_cache_extra_regs
  * intel_bts events don't coexist with intel PMU's BTS events because of
  * x86_add_exclusive(x86_lbr_exclusive_lbr); there's no need to keep them
  * disabled around intel PMU's event batching etc, only inside the PMI handler.
+ *
+ * Avoid PEBS_ENABLE MSR access in PMIs
+ * The GLOBAL_CTRL has been disabled. All counters do not count anymore.
+ * It doesn't matter if the PEBS is enabled or disabled.
+ * Furthermore, PEBS status doesn't change in PMI.
  */
 static void __intel_pmu_disable_all(void)
 {
@@ -1954,13 +1959,12 @@ static void __intel_pmu_disable_all(void)
 
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
 
@@ -1968,7 +1972,6 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	intel_pmu_pebs_enable_all();
 	intel_pmu_lbr_enable_all(pmi);
 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL,
 			x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
@@ -1986,6 +1989,7 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 
 static void intel_pmu_enable_all(int added)
 {
+	intel_pmu_pebs_enable_all();
 	__intel_pmu_enable_all(added, false);
 }
 
-- 
2.17.1

