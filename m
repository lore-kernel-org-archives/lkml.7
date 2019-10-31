Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE97CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428DF20874
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfJaBTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:19:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:33111 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfJaBTU (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:19:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 18:19:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,249,1569308400"; 
   d="scan'208";a="212300098"
Received: from haiyan.sh.intel.com ([10.239.48.70])
  by orsmga002.jf.intel.com with ESMTP; 30 Oct 2019 18:19:01 -0700
From:   Haiyan Song <haiyanx.song@intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, andi.kleen@intel.com,
        Haiyan Song <haiyanx.song@intel.com>
Subject: [PATCH v2 2/2] perf vendor events intel: Update metrics from TMAM 3.6
Date:   Thu, 31 Oct 2019 09:30:14 +0800
Message-Id: <20191031013014.15882-1-haiyanx.song@intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update all the Intel JSON metrics from TMAM 3.6.

New Metrics:
- DSB_Switches: fraction of cycles CPU was stalled due to switches from DSB to MITE pipeline [all]
- L2_Evictions_{Silent|NonSilent}_PKI: L2 {silent|non silent} ecivtions rate per Kilo instruction [SKX+]
- IpFarBranch - Instructions per Far Branch

Other Enhancements & fixes:
- KBLR/CFL & CLX move to separate columns (no column sharing via if #model)
- Re-organized/renamed Metric Group

Signed-off-by: Haiyan Song <haiyanx.song@intel.com>
---
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json | 178 ++++++++---------
 .../arch/x86/broadwellx/bdx-metrics.json           | 184 +++++++++---------
 .../arch/x86/cascadelakex/clx-metrics.json         | 210 +++++++++++----------
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   | 164 ++++++++--------
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  | 170 ++++++++---------
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json | 170 ++++++++---------
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   | 172 ++++++++---------
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  | 114 +++++------
 .../arch/x86/sandybridge/snb-metrics.json          | 112 +++++------
 .../pmu-events/arch/x86/skylake/skl-metrics.json   | 188 +++++++++---------
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  | 204 +++++++++++---------
 11 files changed, 954 insertions(+), 912 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
index 212b117a8ffb..bc7151d639d7 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
@@ -1,352 +1,352 @@
 [
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound"
+        "MetricName": "Frontend_Bound",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT"
+        "MetricName": "Frontend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation"
+        "MetricName": "Bad_Speculation",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT"
+        "MetricName": "Bad_Speculation_SMT",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound"
+        "MetricName": "Backend_Bound",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT"
+        "MetricName": "Backend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring"
+        "MetricName": "Retiring",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT"
+        "MetricName": "Retiring_SMT",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "BriefDescription": "Uops Per Instruction",
-        "MetricGroup": "Pipeline;Retiring",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Retire",
         "MetricName": "UPI"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Instruction per taken branch",
-        "MetricGroup": "Branches;PGO",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fetch_BW;PGO",
         "MetricName": "IpTB"
     },
     {
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;PGO",
         "MetricName": "BpTB"
     },
     {
-        "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricGroup": "PGO",
+        "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
+        "MetricGroup": "PGO;IcMiss",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricGroup": "DSB;Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "MetricGroup": "DSB;Fetch_BW",
         "MetricName": "DSB_Coverage"
     },
     {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * cycles",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
+        "BriefDescription": "Instructions per Load (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
-        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpL"
     },
     {
+        "BriefDescription": "Instructions per Store (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "BriefDescription": "Instructions per Store",
-        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpS"
     },
     {
+        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Instructions per Branch",
-        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricGroup": "Branches;Instruction_Type",
         "MetricName": "IpB"
     },
     {
+        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "BriefDescription": "Instruction per (near) call",
         "MetricGroup": "Branches",
         "MetricName": "IpCall"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY",
         "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / cycles",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / cycles",
         "MetricGroup": "FLOPS",
         "MetricName": "FLOPc"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "FLOPS_SMT",
         "MetricName": "FLOPc_SMT"
     },
     {
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
+        "MetricGroup": "Pipeline",
         "MetricName": "ILP"
     },
     {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
         "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) * (12 * ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "Branch_Misprediction_Cost"
     },
     {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
         "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) * (12 * ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
-        "MetricGroup": "Branch_Mispredicts_SMT",
+        "MetricGroup": "BrMispredicts_SMT",
         "MetricName": "Branch_Misprediction_Cost_SMT"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
         "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "IpMispredict"
     },
     {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
-        "MetricExpr": "( cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_LOAD_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_STORE_MISSES.WALK_DURATION\\,cmask\\=1@ + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / cycles",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_LOAD_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_STORE_MISSES.WALK_DURATION\\,cmask\\=1@ + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / cycles",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "MetricExpr": "( cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_LOAD_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_STORE_MISSES.WALK_DURATION\\,cmask\\=1@ + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_LOAD_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_STORE_MISSES.WALK_DURATION\\,cmask\\=1@ + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "TLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
     {
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L1MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI"
     },
     {
-        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI_All"
     },
     {
-        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2HPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L3MPKI"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_BW_Use"
     },
     {
+        "BriefDescription": "C3 residency percent per core",
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
+        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
+        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
index c6f9762f32c0..113d19e92678 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
@@ -1,370 +1,370 @@
 [
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound"
+        "MetricName": "Frontend_Bound",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT"
+        "MetricName": "Frontend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation"
+        "MetricName": "Bad_Speculation",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT"
+        "MetricName": "Bad_Speculation_SMT",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound"
+        "MetricName": "Backend_Bound",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT"
+        "MetricName": "Backend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring"
+        "MetricName": "Retiring",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT"
+        "MetricName": "Retiring_SMT",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "BriefDescription": "Uops Per Instruction",
-        "MetricGroup": "Pipeline;Retiring",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Retire",
         "MetricName": "UPI"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Instruction per taken branch",
-        "MetricGroup": "Branches;PGO",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fetch_BW;PGO",
         "MetricName": "IpTB"
     },
     {
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;PGO",
         "MetricName": "BpTB"
     },
     {
-        "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricGroup": "PGO",
+        "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
+        "MetricGroup": "PGO;IcMiss",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricGroup": "DSB;Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "MetricGroup": "DSB;Fetch_BW",
         "MetricName": "DSB_Coverage"
     },
     {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * cycles",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
+        "BriefDescription": "Instructions per Load (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
-        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpL"
     },
     {
+        "BriefDescription": "Instructions per Store (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "BriefDescription": "Instructions per Store",
-        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpS"
     },
     {
+        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Instructions per Branch",
-        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricGroup": "Branches;Instruction_Type",
         "MetricName": "IpB"
     },
     {
+        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "BriefDescription": "Instruction per (near) call",
         "MetricGroup": "Branches",
         "MetricName": "IpCall"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY",
         "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / cycles",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / cycles",
         "MetricGroup": "FLOPS",
         "MetricName": "FLOPc"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "FLOPS_SMT",
         "MetricName": "FLOPc_SMT"
     },
     {
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
+        "MetricGroup": "Pipeline",
         "MetricName": "ILP"
     },
     {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
         "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) * (12 * ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "Branch_Misprediction_Cost"
     },
     {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
         "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) * (12 * ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
-        "MetricGroup": "Branch_Mispredicts_SMT",
+        "MetricGroup": "BrMispredicts_SMT",
         "MetricName": "Branch_Misprediction_Cost_SMT"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
         "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "IpMispredict"
     },
     {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / ( 2 * cycles )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / ( 2 * cycles )",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
         "MetricGroup": "TLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
     {
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L1MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI"
     },
     {
-        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI_All"
     },
     {
-        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2HPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L3MPKI"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_BW_Use"
     },
     {
-        "MetricExpr": "1000000000 * ( cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x35\\,umask\\=0x3\\,filter_opc\\=0x182@ ) / ( cbox_0@event\\=0x0@ / duration_time )",
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
+        "MetricExpr": "1000000000 * ( cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x35\\,umask\\=0x3\\,filter_opc\\=0x182@ ) / ( cbox_0@event\\=0x0@ / duration_time )",
         "MetricGroup": "Memory_Lat",
         "MetricName": "DRAM_Read_Latency"
     },
     {
-        "MetricExpr": "cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182\\,thresh\\=1@",
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricExpr": "cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182\\,thresh\\=1@",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_Parallel_Reads"
     },
     {
-        "MetricExpr": "cbox_0@event\\=0x0@",
         "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricExpr": "cbox_0@event\\=0x0@",
         "MetricGroup": "",
         "MetricName": "Socket_CLKS"
     },
     {
+        "BriefDescription": "C3 residency percent per core",
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
+        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
+        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index a382b115633d..2ba32af9bc36 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -1,394 +1,412 @@
 [
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound"
+        "MetricName": "Frontend_Bound",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT"
+        "MetricName": "Frontend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation"
+        "MetricName": "Bad_Speculation",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT"
+        "MetricName": "Bad_Speculation_SMT",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound"
+        "MetricName": "Backend_Bound",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT"
+        "MetricName": "Backend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring"
+        "MetricName": "Retiring",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT"
+        "MetricName": "Retiring_SMT",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "BriefDescription": "Uops Per Instruction",
-        "MetricGroup": "Pipeline;Retiring",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Retire",
         "MetricName": "UPI"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Instruction per taken branch",
-        "MetricGroup": "Branches;PGO",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fetch_BW;PGO",
         "MetricName": "IpTB"
     },
     {
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;PGO",
         "MetricName": "BpTB"
     },
     {
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1 ) )",
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricGroup": "PGO",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1 ) )",
+        "MetricGroup": "PGO;IcMiss",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ))",
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricGroup": "DSB;Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
+        "MetricGroup": "DSB;Fetch_BW",
         "MetricName": "DSB_Coverage"
     },
     {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * cycles",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
+        "BriefDescription": "Instructions per Load (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
-        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
-        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpL"
     },
     {
+        "BriefDescription": "Instructions per Store (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
-        "BriefDescription": "Instructions per Store",
-        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpS"
     },
     {
+        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Instructions per Branch",
-        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricGroup": "Branches;Instruction_Type",
         "MetricName": "IpB"
     },
     {
+        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "BriefDescription": "Instruction per (near) call",
         "MetricGroup": "Branches",
         "MetricName": "IpCall"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY",
         "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / cycles",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / cycles",
         "MetricGroup": "FLOPS",
         "MetricName": "FLOPc"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "FLOPS_SMT",
         "MetricName": "FLOPc_SMT"
     },
     {
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricGroup": "Pipeline",
         "MetricName": "ILP"
     },
     {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
         "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "Branch_Misprediction_Cost"
     },
     {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
         "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
-        "MetricGroup": "Branch_Mispredicts_SMT",
+        "MetricGroup": "BrMispredicts_SMT",
         "MetricName": "Branch_Misprediction_Cost_SMT"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
         "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "IpMispredict"
     },
     {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
         "MetricGroup": "TLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
     {
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Access_BW"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L1MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI"
     },
     {
-        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI_All"
     },
     {
-        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2HPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L3MPKI"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Rate of silent evictions from the L2 cache per Kilo instruction where the evicted lines are dropped (no writeback to L3 or memory)",
+        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "L2_Evictions_Silent_PKI"
+    },
+    {
+        "BriefDescription": "Rate of non silent evictions from the L2 cache per Kilo instruction",
+        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "L2_Evictions_NonSilent_PKI"
+    },
+    {
         "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_BW_Use"
     },
     {
-	"MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x35\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ ) / ( cha_0@event\\=0x0@ / duration_time )",
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
+        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
         "MetricGroup": "Memory_Lat",
         "MetricName": "DRAM_Read_Latency"
     },
     {
-	"MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1\\\\\\,config\\=0x40433@",
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_Parallel_Reads"
     },
     {
-        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\\\\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ ) if 1 if 1 == 1 else 0 else 0",
         "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
+        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\\\\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ ) if 1 if 0 == 1 else 0 else 0",
         "MetricGroup": "Memory_Lat",
         "MetricName": "MEM_PMM_Read_Latency"
     },
     {
-        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time ) if 1 if 1 == 1 else 0 else 0",
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
+        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
         "MetricGroup": "Memory_BW",
         "MetricName": "PMM_Read_BW"
     },
     {
-        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time ) if 1 if 1 == 1 else 0 else 0",
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
+        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
         "MetricGroup": "Memory_BW",
         "MetricName": "PMM_Write_BW"
     },
     {
-        "MetricExpr": "cha_0@event\\=0x0@",
         "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricExpr": "cha_0@event\\=0x0@",
         "MetricGroup": "",
         "MetricName": "Socket_CLKS"
     },
     {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions. )",
+        "MetricExpr": "INST_RETIRED.ANY / ( BR_INST_RETIRED.FAR_BRANCH / 2 )",
+        "MetricGroup": "",
+        "MetricName": "IpFarBranch"
+    },
+    {
+        "BriefDescription": "C3 residency percent per core",
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
+        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
+        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
index 21b27488b621..c80f16fde6d0 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
@@ -1,322 +1,322 @@
 [
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound"
+        "MetricName": "Frontend_Bound",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT"
+        "MetricName": "Frontend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation"
+        "MetricName": "Bad_Speculation",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT"
+        "MetricName": "Bad_Speculation_SMT",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound"
+        "MetricName": "Backend_Bound",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT"
+        "MetricName": "Backend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring"
+        "MetricName": "Retiring",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT"
+        "MetricName": "Retiring_SMT",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "BriefDescription": "Uops Per Instruction",
-        "MetricGroup": "Pipeline;Retiring",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Retire",
         "MetricName": "UPI"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Instruction per taken branch",
-        "MetricGroup": "Branches;PGO",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fetch_BW;PGO",
         "MetricName": "IpTB"
     },
     {
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;PGO",
         "MetricName": "BpTB"
     },
     {
-        "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricGroup": "PGO",
+        "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
+        "MetricGroup": "PGO;IcMiss",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricGroup": "DSB;Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "MetricGroup": "DSB;Fetch_BW",
         "MetricName": "DSB_Coverage"
     },
     {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * cycles",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
+        "BriefDescription": "Instructions per Load (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
-        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpL"
     },
     {
+        "BriefDescription": "Instructions per Store (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "BriefDescription": "Instructions per Store",
-        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpS"
     },
     {
+        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Instructions per Branch",
-        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricGroup": "Branches;Instruction_Type",
         "MetricName": "IpB"
     },
     {
+        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "BriefDescription": "Instruction per (near) call",
         "MetricGroup": "Branches",
         "MetricName": "IpCall"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY",
         "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@)",
+        "MetricGroup": "Pipeline",
         "MetricName": "ILP"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
         "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "IpMispredict"
     },
     {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "TLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
     {
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L1MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2HPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L3MPKI"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_BW_Use"
     },
     {
+        "BriefDescription": "C3 residency percent per core",
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
+        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
+        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index e5aac148c941..e501729c3dd1 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -1,340 +1,340 @@
 [
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound"
+        "MetricName": "Frontend_Bound",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT"
+        "MetricName": "Frontend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation"
+        "MetricName": "Bad_Speculation",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT"
+        "MetricName": "Bad_Speculation_SMT",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound"
+        "MetricName": "Backend_Bound",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT"
+        "MetricName": "Backend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring"
+        "MetricName": "Retiring",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT"
+        "MetricName": "Retiring_SMT",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "BriefDescription": "Uops Per Instruction",
-        "MetricGroup": "Pipeline;Retiring",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Retire",
         "MetricName": "UPI"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Instruction per taken branch",
-        "MetricGroup": "Branches;PGO",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fetch_BW;PGO",
         "MetricName": "IpTB"
     },
     {
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;PGO",
         "MetricName": "BpTB"
     },
     {
-        "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricGroup": "PGO",
+        "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
+        "MetricGroup": "PGO;IcMiss",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricGroup": "DSB;Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "MetricGroup": "DSB;Fetch_BW",
         "MetricName": "DSB_Coverage"
     },
     {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * cycles",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
+        "BriefDescription": "Instructions per Load (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
-        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpL"
     },
     {
+        "BriefDescription": "Instructions per Store (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "BriefDescription": "Instructions per Store",
-        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpS"
     },
     {
+        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Instructions per Branch",
-        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricGroup": "Branches;Instruction_Type",
         "MetricName": "IpB"
     },
     {
+        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "BriefDescription": "Instruction per (near) call",
         "MetricGroup": "Branches",
         "MetricName": "IpCall"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY",
         "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@)",
+        "MetricGroup": "Pipeline",
         "MetricName": "ILP"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
         "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "IpMispredict"
     },
     {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "TLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
     {
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L1MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2HPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L3MPKI"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_BW_Use"
     },
     {
-        "MetricExpr": "1000000000 * ( cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x35\\,umask\\=0x3\\,filter_opc\\=0x182@ ) / ( cbox_0@event\\=0x0@ / duration_time )",
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
+        "MetricExpr": "1000000000 * ( cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x35\\,umask\\=0x3\\,filter_opc\\=0x182@ ) / ( cbox_0@event\\=0x0@ / duration_time )",
         "MetricGroup": "Memory_Lat",
         "MetricName": "DRAM_Read_Latency"
     },
     {
-        "MetricExpr": "cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182\\,thresh\\=1@",
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricExpr": "cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182\\,thresh\\=1@",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_Parallel_Reads"
     },
     {
-        "MetricExpr": "cbox_0@event\\=0x0@",
         "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricExpr": "cbox_0@event\\=0x0@",
         "MetricGroup": "",
         "MetricName": "Socket_CLKS"
     },
     {
+        "BriefDescription": "C3 residency percent per core",
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
+        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
+        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index bc4d5fc284a0..e2446966b651 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
@@ -1,340 +1,340 @@
 [
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound"
+        "MetricName": "Frontend_Bound",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT"
+        "MetricName": "Frontend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation"
+        "MetricName": "Bad_Speculation",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT"
+        "MetricName": "Bad_Speculation_SMT",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound"
+        "MetricName": "Backend_Bound",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT"
+        "MetricName": "Backend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring"
+        "MetricName": "Retiring",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT"
+        "MetricName": "Retiring_SMT",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "BriefDescription": "Uops Per Instruction",
-        "MetricGroup": "Pipeline;Retiring",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Retire",
         "MetricName": "UPI"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Instruction per taken branch",
-        "MetricGroup": "Branches;PGO",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fetch_BW;PGO",
         "MetricName": "IpTB"
     },
     {
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;PGO",
         "MetricName": "BpTB"
     },
     {
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricGroup": "PGO",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
+        "MetricGroup": "PGO;IcMiss",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricGroup": "DSB;Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "MetricGroup": "DSB;Fetch_BW",
         "MetricName": "DSB_Coverage"
     },
     {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * cycles",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
+        "BriefDescription": "Instructions per Load (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
-        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpL"
     },
     {
+        "BriefDescription": "Instructions per Store (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "BriefDescription": "Instructions per Store",
-        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpS"
     },
     {
+        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Instructions per Branch",
-        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricGroup": "Branches;Instruction_Type",
         "MetricName": "IpB"
     },
     {
+        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "BriefDescription": "Instruction per (near) call",
         "MetricGroup": "Branches",
         "MetricName": "IpCall"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY",
         "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
         "MetricGroup": "FLOPS",
         "MetricName": "FLOPc"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "FLOPS_SMT",
         "MetricName": "FLOPc_SMT"
     },
     {
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
+        "MetricGroup": "Pipeline",
         "MetricName": "ILP"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
         "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "IpMispredict"
     },
     {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "TLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
     {
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L1MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2HPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L3MPKI"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_BW_Use"
     },
     {
+        "BriefDescription": "C3 residency percent per core",
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
+        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
+        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index f3874b5f9995..9294769dec64 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
@@ -1,346 +1,346 @@
 [
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound"
+        "MetricName": "Frontend_Bound",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT"
+        "MetricName": "Frontend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation"
+        "MetricName": "Bad_Speculation",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT"
+        "MetricName": "Bad_Speculation_SMT",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound"
+        "MetricName": "Backend_Bound",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT"
+        "MetricName": "Backend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring"
+        "MetricName": "Retiring",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT"
+        "MetricName": "Retiring_SMT",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "BriefDescription": "Uops Per Instruction",
-        "MetricGroup": "Pipeline;Retiring",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Retire",
         "MetricName": "UPI"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Instruction per taken branch",
-        "MetricGroup": "Branches;PGO",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fetch_BW;PGO",
         "MetricName": "IpTB"
     },
     {
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;PGO",
         "MetricName": "BpTB"
     },
     {
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricGroup": "PGO",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
+        "MetricGroup": "PGO;IcMiss",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricGroup": "DSB;Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "MetricGroup": "DSB;Fetch_BW",
         "MetricName": "DSB_Coverage"
     },
     {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * cycles",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
+        "BriefDescription": "Instructions per Load (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
-        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpL"
     },
     {
+        "BriefDescription": "Instructions per Store (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "BriefDescription": "Instructions per Store",
-        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpS"
     },
     {
+        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Instructions per Branch",
-        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricGroup": "Branches;Instruction_Type",
         "MetricName": "IpB"
     },
     {
+        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "BriefDescription": "Instruction per (near) call",
         "MetricGroup": "Branches",
         "MetricName": "IpCall"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY",
         "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
         "MetricGroup": "FLOPS",
         "MetricName": "FLOPc"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "FLOPS_SMT",
         "MetricName": "FLOPc_SMT"
     },
     {
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
+        "MetricGroup": "Pipeline",
         "MetricName": "ILP"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
         "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "IpMispredict"
     },
     {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "TLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
     {
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L1MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2HPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L3MPKI"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_BW_Use"
     },
     {
-        "MetricExpr": "cbox_0@event\\=0x0@",
         "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricExpr": "cbox_0@event\\=0x0@",
         "MetricGroup": "",
         "MetricName": "Socket_CLKS"
     },
     {
+        "BriefDescription": "C3 residency percent per core",
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
+        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
+        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index 98c73e430b05..603ff9c2e9a1 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -1,232 +1,232 @@
 [
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound"
+        "MetricName": "Frontend_Bound",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT"
+        "MetricName": "Frontend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation"
+        "MetricName": "Bad_Speculation",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT"
+        "MetricName": "Bad_Speculation_SMT",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound"
+        "MetricName": "Backend_Bound",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT"
+        "MetricName": "Backend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring"
+        "MetricName": "Retiring",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT"
+        "MetricName": "Retiring_SMT",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "BriefDescription": "Uops Per Instruction",
-        "MetricGroup": "Pipeline;Retiring",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Retire",
         "MetricName": "UPI"
     },
     {
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricGroup": "PGO",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
+        "MetricGroup": "PGO;IcMiss",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricGroup": "DSB;Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "MetricGroup": "DSB;Fetch_BW",
         "MetricName": "DSB_Coverage"
     },
     {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * cycles",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY",
         "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
         "MetricGroup": "FLOPS",
         "MetricName": "FLOPc"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "FLOPS_SMT",
         "MetricName": "FLOPc_SMT"
     },
     {
-        "MetricExpr": "UOPS_DISPATCHED.THREAD / (( cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricExpr": "UOPS_DISPATCHED.THREAD / (( cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@)",
+        "MetricGroup": "Pipeline",
         "MetricName": "ILP"
     },
     {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_BW_Use"
     },
     {
-        "MetricExpr": "cbox_0@event\\=0x0@",
         "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricExpr": "cbox_0@event\\=0x0@",
         "MetricGroup": "",
         "MetricName": "Socket_CLKS"
     },
     {
+        "BriefDescription": "C3 residency percent per core",
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
+        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
+        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index cfeba5067bab..c6b485b3a2cb 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
@@ -1,226 +1,226 @@
 [
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound"
+        "MetricName": "Frontend_Bound",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT"
+        "MetricName": "Frontend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation"
+        "MetricName": "Bad_Speculation",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT"
+        "MetricName": "Bad_Speculation_SMT",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound"
+        "MetricName": "Backend_Bound",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT"
+        "MetricName": "Backend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring"
+        "MetricName": "Retiring",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT"
+        "MetricName": "Retiring_SMT",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "BriefDescription": "Uops Per Instruction",
-        "MetricGroup": "Pipeline;Retiring",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Retire",
         "MetricName": "UPI"
     },
     {
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricGroup": "PGO",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
+        "MetricGroup": "PGO;IcMiss",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricGroup": "DSB;Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "MetricGroup": "DSB;Fetch_BW",
         "MetricName": "DSB_Coverage"
     },
     {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * cycles",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY",
         "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
         "MetricGroup": "FLOPS",
         "MetricName": "FLOPc"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "FLOPS_SMT",
         "MetricName": "FLOPc_SMT"
     },
     {
-        "MetricExpr": "UOPS_DISPATCHED.THREAD / (( cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricExpr": "UOPS_DISPATCHED.THREAD / (( cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@)",
+        "MetricGroup": "Pipeline",
         "MetricName": "ILP"
     },
     {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_BW_Use"
     },
     {
+        "BriefDescription": "C3 residency percent per core",
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
+        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
+        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 2c95417a4dae..0ca539bb60f6 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -1,364 +1,370 @@
 [
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound"
+        "MetricName": "Frontend_Bound",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT"
+        "MetricName": "Frontend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation"
+        "MetricName": "Bad_Speculation",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT"
+        "MetricName": "Bad_Speculation_SMT",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound"
+        "MetricName": "Backend_Bound",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT"
+        "MetricName": "Backend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring"
+        "MetricName": "Retiring",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT"
+        "MetricName": "Retiring_SMT",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "BriefDescription": "Uops Per Instruction",
-        "MetricGroup": "Pipeline;Retiring",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Retire",
         "MetricName": "UPI"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Instruction per taken branch",
-        "MetricGroup": "Branches;PGO",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fetch_BW;PGO",
         "MetricName": "IpTB"
     },
     {
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;PGO",
         "MetricName": "BpTB"
     },
     {
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1 ) )",
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricGroup": "PGO",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1 ) )",
+        "MetricGroup": "PGO;IcMiss",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ))",
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricGroup": "DSB;Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
+        "MetricGroup": "DSB;Fetch_BW",
         "MetricName": "DSB_Coverage"
     },
     {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * cycles",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
+        "BriefDescription": "Instructions per Load (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
-        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
-        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpL"
     },
     {
+        "BriefDescription": "Instructions per Store (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
-        "BriefDescription": "Instructions per Store",
-        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpS"
     },
     {
+        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Instructions per Branch",
-        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricGroup": "Branches;Instruction_Type",
         "MetricName": "IpB"
     },
     {
+        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "BriefDescription": "Instruction per (near) call",
         "MetricGroup": "Branches",
         "MetricName": "IpCall"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY",
         "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / cycles",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / cycles",
         "MetricGroup": "FLOPS",
         "MetricName": "FLOPc"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "FLOPS_SMT",
         "MetricName": "FLOPc_SMT"
     },
     {
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricGroup": "Pipeline",
         "MetricName": "ILP"
     },
     {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
         "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "Branch_Misprediction_Cost"
     },
     {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
         "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
-        "MetricGroup": "Branch_Mispredicts_SMT",
+        "MetricGroup": "BrMispredicts_SMT",
         "MetricName": "Branch_Misprediction_Cost_SMT"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
         "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "IpMispredict"
     },
     {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
         "MetricGroup": "TLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
     {
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Access_BW"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L1MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI"
     },
     {
-        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI_All"
     },
     {
-        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2HPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L3MPKI"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_BW_Use"
     },
     {
-        "MetricExpr": "arb@event\\=0x80\\,umask\\=0x2@ / arb@event\\=0x80\\,umask\\=0x2\\,thresh\\=1@",
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricExpr": "arb@event\\=0x80\\,umask\\=0x2@ / arb@event\\=0x80\\,umask\\=0x2\\,thresh\\=1@",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_Parallel_Reads"
     },
     {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions. )",
+        "MetricExpr": "INST_RETIRED.ANY / ( BR_INST_RETIRED.FAR_BRANCH / 2 )",
+        "MetricGroup": "",
+        "MetricName": "IpFarBranch"
+    },
+    {
+        "BriefDescription": "C3 residency percent per core",
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
+        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
+        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 35b255fa6a79..047d7e11aa6f 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -1,376 +1,394 @@
 [
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Frontend_Bound"
+        "MetricName": "Frontend_Bound",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound."
     },
     {
-        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Frontend_Bound_SMT"
+        "MetricName": "Frontend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Bad_Speculation"
+        "MetricName": "Bad_Speculation",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example."
     },
     {
-        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Bad_Speculation_SMT"
+        "MetricName": "Bad_Speculation_SMT",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Backend_Bound"
+        "MetricName": "Backend_Bound",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound."
     },
     {
-        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
-        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Backend_Bound_SMT"
+        "MetricName": "Backend_Bound_SMT",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
         "MetricGroup": "TopdownL1",
-        "MetricName": "Retiring"
+        "MetricName": "Retiring",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. "
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
-        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
         "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
         "MetricGroup": "TopdownL1_SMT",
-        "MetricName": "Retiring_SMT"
+        "MetricName": "Retiring_SMT",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU."
     },
     {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
         "BriefDescription": "Uops Per Instruction",
-        "MetricGroup": "Pipeline;Retiring",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
+        "MetricGroup": "Pipeline;Retire",
         "MetricName": "UPI"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Instruction per taken branch",
-        "MetricGroup": "Branches;PGO",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "MetricGroup": "Branches;Fetch_BW;PGO",
         "MetricName": "IpTB"
     },
     {
-        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;PGO",
         "MetricName": "BpTB"
     },
     {
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1 ) )",
         "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
-        "MetricGroup": "PGO",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1 ) )",
+        "MetricGroup": "PGO;IcMiss",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ))",
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
-        "MetricGroup": "DSB;Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
+        "MetricGroup": "DSB;Fetch_BW",
         "MetricName": "DSB_Coverage"
     },
     {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * cycles",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core)",
         "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
-        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1_SMT",
         "MetricName": "SLOTS_SMT"
     },
     {
+        "BriefDescription": "Instructions per Load (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
-        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
-        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpL"
     },
     {
+        "BriefDescription": "Instructions per Store (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
-        "BriefDescription": "Instructions per Store",
-        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricGroup": "Instruction_Type",
         "MetricName": "IpS"
     },
     {
+        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Instructions per Branch",
-        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricGroup": "Branches;Instruction_Type",
         "MetricName": "IpB"
     },
     {
+        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "BriefDescription": "Instruction per (near) call",
         "MetricGroup": "Branches",
         "MetricName": "IpCall"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY",
         "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / cycles",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / cycles",
         "MetricGroup": "FLOPS",
         "MetricName": "FLOPc"
     },
     {
-        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
         "MetricGroup": "FLOPS_SMT",
         "MetricName": "FLOPc_SMT"
     },
     {
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricGroup": "Pipeline;Ports_Utilization",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
+        "MetricGroup": "Pipeline",
         "MetricName": "ILP"
     },
     {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
         "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "Branch_Misprediction_Cost"
     },
     {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per non-speculative branch misprediction (jeclear)",
         "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
-        "MetricGroup": "Branch_Mispredicts_SMT",
+        "MetricGroup": "BrMispredicts_SMT",
         "MetricName": "Branch_Misprediction_Cost_SMT"
     },
     {
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
         "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
-        "MetricGroup": "Branch_Mispredicts",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "BrMispredicts",
         "MetricName": "IpMispredict"
     },
     {
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
-        "BriefDescription": "Core actual clocks when any thread is active on the physical core",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
         "MetricGroup": "TLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
     {
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L1D_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L2_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Fill_BW"
     },
     {
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
         "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "L3_Cache_Access_BW"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L1MPKI"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI"
     },
     {
-        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2MPKI_All"
     },
     {
-        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
         "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L2HPKI_All"
     },
     {
-        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
         "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
-        "MetricGroup": "Cache_Misses;",
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "Cache_Misses",
         "MetricName": "L3MPKI"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Rate of silent evictions from the L2 cache per Kilo instruction where the evicted lines are dropped (no writeback to L3 or memory)",
+        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "L2_Evictions_Silent_PKI"
+    },
+    {
+        "BriefDescription": "Rate of non silent evictions from the L2 cache per Kilo instruction",
+        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "L2_Evictions_NonSilent_PKI"
+    },
+    {
         "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_BW_Use"
     },
     {
-	"MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x35\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ ) / ( cha_0@event\\=0x0@ / duration_time )",
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
+        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
         "MetricGroup": "Memory_Lat",
         "MetricName": "DRAM_Read_Latency"
     },
     {
-	"MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1\\\\\\,config\\=0x40433@",
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_Parallel_Reads"
     },
     {
-        "MetricExpr": "cha_0@event\\=0x0@",
         "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricExpr": "cha_0@event\\=0x0@",
         "MetricGroup": "",
         "MetricName": "Socket_CLKS"
     },
     {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions. )",
+        "MetricExpr": "INST_RETIRED.ANY / ( BR_INST_RETIRED.FAR_BRANCH / 2 )",
+        "MetricGroup": "",
+        "MetricName": "IpFarBranch"
+    },
+    {
+        "BriefDescription": "C3 residency percent per core",
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
+        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
+        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
+        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
+        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
-- 
2.11.0

