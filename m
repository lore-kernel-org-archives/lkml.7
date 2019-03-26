Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163ECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E702070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfCZQMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:12:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:55266 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbfCZQLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:11:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 09:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,273,1549958400"; 
   d="scan'208";a="217714814"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2019 09:11:39 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 19/23] perf/x86/intel: Support CPUID 10.ECX to disable fixed counters
Date:   Tue, 26 Mar 2019 09:08:57 -0700
Message-Id: <20190326160901.4887-20-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326160901.4887-1-kan.liang@linux.intel.com>
References: <20190326160901.4887-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Icelake supports a new CPUID 10.ECX cpu leaf to indicate some fixed
counters are not supported.  This extends the previous count to a bitmap
which allows to disable even lower counters.

It's a nop on Icelake (all fixed counters are supported), but let's
implement it here.  This adds the necessary checks. In theory it could
be used today by a Hypervisor.

For disabled counters disable any constraint events. I reuse the
existing intel_ctrl variable to remember which counters are disabled.
All code that reads all counters is fixed to check this extra bitmask.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V3.

 arch/x86/events/core.c       |  8 +++++++-
 arch/x86/events/intel/core.c | 22 +++++++++++++++-------
 arch/x86/events/perf_event.h |  6 ++++++
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b9bee53e53d8..12d7d591843e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -225,6 +225,8 @@ static bool check_hw_exists(void)
 		if (ret)
 			goto msr_fail;
 		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
+			if (fixed_counter_disabled(i))
+				continue;
 			if (val & (0x03 << i*4)) {
 				bios_fail = 1;
 				val_fail = val;
@@ -1372,6 +1374,8 @@ void perf_event_print_debug(void)
 			cpu, idx, prev_left);
 	}
 	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
+		if (fixed_counter_disabled(idx))
+			continue;
 		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, pmc_count);
 
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
@@ -1887,7 +1891,9 @@ static int __init init_hw_perf_events(void)
 	pr_info("... generic registers:      %d\n",     x86_pmu.num_counters);
 	pr_info("... value mask:             %016Lx\n", x86_pmu.cntval_mask);
 	pr_info("... max period:             %016Lx\n", x86_pmu.max_period);
-	pr_info("... fixed-purpose events:   %d\n",     x86_pmu.num_counters_fixed);
+	pr_info("... fixed-purpose events:   %lu\n",
+			hweight64((((1ULL << x86_pmu.num_counters_fixed) - 1)
+					<< INTEL_PMC_IDX_FIXED) & x86_pmu.intel_ctrl));
 	pr_info("... event mask:             %016Lx\n", x86_pmu.intel_ctrl);
 
 	/*
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ef6045544628..a4b7711ef0ee 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2311,8 +2311,11 @@ static void intel_pmu_reset(void)
 		wrmsrl_safe(x86_pmu_config_addr(idx), 0ull);
 		wrmsrl_safe(x86_pmu_event_addr(idx),  0ull);
 	}
-	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++)
+	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
+		if (fixed_counter_disabled(idx))
+			continue;
 		wrmsrl_safe(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, 0ull);
+	}
 
 	if (ds)
 		ds->bts_index = ds->bts_buffer_base;
@@ -4551,7 +4554,7 @@ __init int intel_pmu_init(void)
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
 	struct event_constraint *c;
-	unsigned int unused;
+	unsigned int fixed_mask;
 	struct extra_reg *er;
 	int version, i;
 	char *name;
@@ -4572,9 +4575,11 @@ __init int intel_pmu_init(void)
 	 * Check whether the Architectural PerfMon supports
 	 * Branch Misses Retired hw_event or not.
 	 */
-	cpuid(10, &eax.full, &ebx.full, &unused, &edx.full);
+	cpuid(10, &eax.full, &ebx.full, &fixed_mask, &edx.full);
 	if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT)
 		return -ENODEV;
+	if (!fixed_mask)
+		fixed_mask = -1;
 
 	version = eax.split.version_id;
 	if (version < 2)
@@ -5104,7 +5109,8 @@ __init int intel_pmu_init(void)
 	}
 
 	x86_pmu.intel_ctrl |=
-		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
+		(((1LL << x86_pmu.num_counters_fixed)-1) & (u64)fixed_mask)
+			<< INTEL_PMC_IDX_FIXED;
 
 	if (x86_pmu.event_constraints) {
 		/*
@@ -5121,9 +5127,11 @@ __init int intel_pmu_init(void)
 				c->weight = hweight64(c->idxmsk64);
 				continue;
 			}
-			if (c->cmask == FIXED_EVENT_FLAGS
-			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES) {
-				c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
+			if (c->cmask == FIXED_EVENT_FLAGS)  {
+				if (c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES)
+					c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
+				/* Disabled fixed counters which are not in CPUID */
+				c->idxmsk64 &= x86_pmu.intel_ctrl;
 			}
 			c->idxmsk64 &=
 				~(~0ULL << (INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed));
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 077d44a96d31..fff8868f92a8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -925,6 +925,12 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr,
 ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
 
+static inline bool fixed_counter_disabled(int i)
+{
+	return x86_pmu.intel_ctrl &&
+		((1ULL << (i + INTEL_PMC_IDX_FIXED)) & x86_pmu.intel_ctrl);
+}
+
 #ifdef CONFIG_CPU_SUP_AMD
 
 int amd_pmu_init(void);
-- 
2.17.1

