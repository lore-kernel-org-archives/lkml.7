Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB044C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A702084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221269;
	bh=aW6M2DVav4qYwo7CBnhyopR879I7PW/BpM7iEy0WruQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A0O7s3l6pzx0WegQO17+WHyBhW6epfAjNyj3YcL3G9ikbQjjppq9iGxuubSiZQULj
	 gVzSnoXESY453x4BybciHWqI7CHUS4H5Syqvg1E6QttqlMnJaHHgR72WEVfu2IIqJs
	 beXFengpSZxDMKlsURss6UBE01ckWO4KUi4zCWPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfDBQHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbfDBQHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:07:44 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F377020856;
        Tue,  2 Apr 2019 16:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221254;
        bh=aW6M2DVav4qYwo7CBnhyopR879I7PW/BpM7iEy0WruQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rx2StZTX+15gqa3gdcEMEK/ixYnHDb1h7u9qNV784K6FQrnp1OeBCR/QYuQkpSlMJ
         s2m4gNYYryeqyt5TZ1BOZTcZxp7z/oZ4ONz6Z89nOSgOJ9De2XEDaEXpqRp9RMiD6q
         6lNLlzzumTEPnssGOZudTL3iMfb4X9rtWbuvnRi0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/44] perf vendor events intel: Update metrics from TMAM 3.5
Date:   Tue,  2 Apr 2019 13:05:33 -0300
Message-Id: <20190402160549.13544-29-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Update all the Intel JSON metrics from Ahmad Yasin's TMAM 3.5
for Intel big core from Sandy Bridge to Cascade Lake.

This has many improvements and new metircs

- New TopDownL1_SMT group that provides a per SMT thread version
of --topdown that does not require -a anymore. The drawback is
increased multiplexing though since L1 TopDown does not fit into
4 generic counters anymore.

- Added SMT aware versions of other metrics

- Split SMT aware metrics into separate metrics to avoid
unnecessary event collections

- New metrics for better branch analysis:
Estimated Branch_Mispredict_Costs, Instructions per taken Branch,
Branch Instructions per Taken Branch, etc.

- Instruction mix metrics:
Instructions per load, Instructions per store, Instructions per Branch,
Instructions per Call

- New Cache metrics:
Bandwidth to L1/L2/L3 caches. L1/L2/L3 misses per kilo instructions.
memory level parallelism

- New memory controller metrics:
Normalized memory bandwidth in interval mode, Average memory latency,
Average number of parallel read requests,

- 3DXP persistent memory metrics for Cascade Lake:
3dxp read latency, 3dxp read/write bandwidth

- Some other useful metrics like Instruction Level Parallelism,

- Various other improvements.

Not all metrics are available on all CPUs. Skylake has best coverage.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190315165219.GA21223@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/x86/broadwell/bdw-metrics.json       | 260 ++++++++++++---
 .../arch/x86/broadwellx/bdx-metrics.json      | 278 +++++++++++++---
 .../arch/x86/cascadelakex/clx-metrics.json    | 304 +++++++++++++++---
 .../arch/x86/haswell/hsw-metrics.json         | 234 ++++++++++++--
 .../arch/x86/haswellx/hsx-metrics.json        | 252 +++++++++++++--
 .../arch/x86/ivybridge/ivb-metrics.json       | 250 +++++++++++---
 .../arch/x86/ivytown/ivt-metrics.json         | 256 ++++++++++++---
 .../arch/x86/jaketown/jkt-metrics.json        | 150 +++++++--
 .../arch/x86/sandybridge/snb-metrics.json     | 144 +++++++--
 .../arch/x86/skylake/skl-metrics.json         | 274 +++++++++++++---
 .../arch/x86/skylakex/skx-metrics.json        | 304 +++++++++++++++---
 11 files changed, 2321 insertions(+), 385 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
index 00bfdb5c5acb..212b117a8ffb 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
@@ -1,164 +1,352 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Frontend_Bound"
+    },
+    {
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Frontend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Bad_Speculation"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Bad_Speculation_SMT"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Backend_Bound"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Backend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Retiring"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Retiring_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retiring",
         "MetricName": "UPI"
     },
     {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Instruction per taken branch",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "IpTB"
+    },
+    {
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "BpTB"
+    },
+    {
         "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
-        "MetricGroup": "Frontend",
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
+        "MetricGroup": "PGO",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
-        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
+        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
+        "MetricExpr": "4 * cycles",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
+        "MetricGroup": "TopDownL1_SMT",
+        "MetricName": "SLOTS_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
+        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
+        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricName": "IpL"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Instructions per Store",
+        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricName": "IpS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch",
+        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricName": "IpB"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "BriefDescription": "Instruction per (near) call",
+        "MetricGroup": "Branches",
+        "MetricName": "IpCall"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / cycles",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS",
+        "MetricName": "FLOPc"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS_SMT",
+        "MetricName": "FLOPc_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
-        "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE.IFDATA_STALL  - (( 14 * ITLB_MISSES.STLB_HIT + cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=1@ + 7* ITLB_MISSES.WALK_COMPLETED )) ) / RS_EVENTS.EMPTY_END)",
-        "MetricGroup": "Unknown_Branches",
-        "MetricName": "BAClear_Cost"
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) * (12 * ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "Branch_Misprediction_Cost"
     },
     {
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) * (12 * ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
+        "MetricGroup": "Branch_Mispredicts_SMT",
+        "MetricName": "Branch_Misprediction_Cost_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (( cpu@l1d_pend_miss.pending_cycles\\,any\\=1@ / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
+        "MetricExpr": "( cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_LOAD_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_STORE_MISSES.WALK_DURATION\\,cmask\\=1@ + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / cycles",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_LOAD_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_STORE_MISSES.WALK_DURATION\\,cmask\\=1@ + 7*(DTLB_STORE_MISSES.WALK_COMPLETED+DTLB_LOAD_MISSES.WALK_COMPLETED+ITLB_MISSES.WALK_COMPLETED)) / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "( cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_LOAD_MISSES.WALK_DURATION\\,cmask\\=1@ + cpu@DTLB_STORE_MISSES.WALK_DURATION\\,cmask\\=1@ + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricGroup": "TLB_SMT",
+        "MetricName": "Page_Walks_Utilization_SMT"
+    },
+    {
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L1MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI"
+    },
+    {
+        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2HPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L3MPKI"
+    },
+    {
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
+        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(( 1*( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2* FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4*( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8* FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
index 5a7f1ec24200..c6f9762f32c0 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
@@ -1,164 +1,370 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Frontend_Bound"
+    },
+    {
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Frontend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Bad_Speculation"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Bad_Speculation_SMT"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Backend_Bound"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Backend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Retiring"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Retiring_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retiring",
         "MetricName": "UPI"
     },
     {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Instruction per taken branch",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "IpTB"
+    },
+    {
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "BpTB"
+    },
+    {
         "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
-        "MetricGroup": "Frontend",
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
+        "MetricGroup": "PGO",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
-        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
+        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
+        "MetricExpr": "4 * cycles",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
+        "MetricGroup": "TopDownL1_SMT",
+        "MetricName": "SLOTS_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
+        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
+        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricName": "IpL"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Instructions per Store",
+        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricName": "IpS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch",
+        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricName": "IpB"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "BriefDescription": "Instruction per (near) call",
+        "MetricGroup": "Branches",
+        "MetricName": "IpCall"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / cycles",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS",
+        "MetricName": "FLOPc"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS_SMT",
+        "MetricName": "FLOPc_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
-        "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE.IFDATA_STALL  - (( 14 * ITLB_MISSES.STLB_HIT + cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=1@ + 7* ITLB_MISSES.WALK_COMPLETED )) ) / RS_EVENTS.EMPTY_END)",
-        "MetricGroup": "Unknown_Branches",
-        "MetricName": "BAClear_Cost"
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) * (12 * ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "Branch_Misprediction_Cost"
+    },
+    {
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) * (12 * ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
+        "MetricGroup": "Branch_Mispredicts_SMT",
+        "MetricName": "Branch_Misprediction_Cost_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "IpMispredict"
     },
     {
+        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (( cpu@l1d_pend_miss.pending_cycles\\,any\\=1@ / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / ( 2 * cycles )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION + 7*(DTLB_STORE_MISSES.WALK_COMPLETED+DTLB_LOAD_MISSES.WALK_COMPLETED+ITLB_MISSES.WALK_COMPLETED) ) / (2*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles))",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION + 7 * ( DTLB_STORE_MISSES.WALK_COMPLETED + DTLB_LOAD_MISSES.WALK_COMPLETED + ITLB_MISSES.WALK_COMPLETED ) ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
+        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricGroup": "TLB_SMT",
+        "MetricName": "Page_Walks_Utilization_SMT"
+    },
+    {
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L1MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI"
+    },
+    {
+        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2HPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L3MPKI"
+    },
+    {
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
+        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(( 1*( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2* FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4*( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8* FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
+        "MetricExpr": "1000000000 * ( cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x35\\,umask\\=0x3\\,filter_opc\\=0x182@ ) / ( cbox_0@event\\=0x0@ / duration_time )",
+        "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
+        "MetricGroup": "Memory_Lat",
+        "MetricName": "DRAM_Read_Latency"
+    },
+    {
+        "MetricExpr": "cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182\\,thresh\\=1@",
+        "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_Parallel_Reads"
+    },
+    {
+        "MetricExpr": "cbox_0@event\\=0x0@",
+        "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricGroup": "",
+        "MetricName": "Socket_CLKS"
+    },
+    {
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 71e9737f4614..1a1a3501180a 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -1,164 +1,394 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Frontend_Bound"
+    },
+    {
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Frontend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Bad_Speculation"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Bad_Speculation_SMT"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Backend_Bound"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Backend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Retiring"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Retiring_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retiring",
         "MetricName": "UPI"
     },
     {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ((UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1) )",
-        "MetricGroup": "Frontend",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Instruction per taken branch",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "IpTB"
+    },
+    {
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "BpTB"
+    },
+    {
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1 ) )",
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
+        "MetricGroup": "PGO",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
-        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ))",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
+        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
+        "MetricExpr": "4 * cycles",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
+        "MetricGroup": "TopDownL1_SMT",
+        "MetricName": "SLOTS_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
+        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
+        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricName": "IpL"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
+        "BriefDescription": "Instructions per Store",
+        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricName": "IpS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch",
+        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricName": "IpB"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "BriefDescription": "Instruction per (near) call",
+        "MetricGroup": "Branches",
+        "MetricName": "IpCall"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / cycles",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS",
+        "MetricName": "FLOPc"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS_SMT",
+        "MetricName": "FLOPc_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
-        "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE_16B.IFDATA_STALL  - ICACHE_64B.IFTAG_STALL ) / RS_EVENTS.EMPTY_END)",
-        "MetricGroup": "Unknown_Branches",
-        "MetricName": "BAClear_Cost"
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "Branch_Misprediction_Cost"
+    },
+    {
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
+        "MetricGroup": "Branch_Mispredicts_SMT",
+        "MetricName": "Branch_Misprediction_Cost_SMT"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (( L1D_PEND_MISS.PENDING_CYCLES_ANY / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles) )",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
+        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricGroup": "TLB_SMT",
+        "MetricName": "Page_Walks_Utilization_SMT"
+    },
+    {
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Access_BW"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L1MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI"
+    },
+    {
+        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2HPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L3MPKI"
+    },
+    {
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
+        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(( 1*( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2* FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4*( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8* FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
+        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
+        "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
+        "MetricGroup": "Memory_Lat",
+        "MetricName": "DRAM_Read_Latency"
+    },
+    {
+        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
+        "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_Parallel_Reads"
+    },
+    {
+        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\\\\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ ) if 1 if 1 == 1 else 0 else 0",
+        "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
+        "MetricGroup": "Memory_Lat",
+        "MetricName": "MEM_PMM_Read_Latency"
+    },
+    {
+        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time ) if 1 if 1 == 1 else 0 else 0",
+        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "PMM_Read_BW"
+    },
+    {
+        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time ) if 1 if 1 == 1 else 0 else 0",
+        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "PMM_Write_BW"
+    },
+    {
+        "MetricExpr": "cha_0@event\\=0x0@",
+        "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricGroup": "",
+        "MetricName": "Socket_CLKS"
+    },
+    {
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
index 5ab5c78fe580..21b27488b621 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
@@ -1,158 +1,322 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Frontend_Bound"
+    },
+    {
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Frontend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Bad_Speculation"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Bad_Speculation_SMT"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Backend_Bound"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Backend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Retiring"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Retiring_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retiring",
         "MetricName": "UPI"
     },
     {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Instruction per taken branch",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "IpTB"
+    },
+    {
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "BpTB"
+    },
+    {
         "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
-        "MetricGroup": "Frontend",
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
+        "MetricGroup": "PGO",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
-        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
+        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
+        "MetricExpr": "4 * cycles",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
+        "MetricGroup": "TopDownL1_SMT",
+        "MetricName": "SLOTS_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
+        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
+        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricName": "IpL"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Instructions per Store",
+        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricName": "IpS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch",
+        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricName": "IpB"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "BriefDescription": "Instruction per (near) call",
+        "MetricGroup": "Branches",
+        "MetricName": "IpCall"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
-        "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE.IFDATA_STALL  - (( 14 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURATION )) ) / RS_EVENTS.EMPTY_END)",
-        "MetricGroup": "Unknown_Branches",
-        "MetricName": "BAClear_Cost"
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "IpMispredict"
     },
     {
+        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (( cpu@l1d_pend_miss.pending_cycles\\,any\\=1@ / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricGroup": "TLB_SMT",
+        "MetricName": "Page_Walks_Utilization_SMT"
+    },
+    {
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L1MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2HPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L3MPKI"
+    },
+    {
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index 5ab5c78fe580..e5aac148c941 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -1,158 +1,340 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Frontend_Bound"
+    },
+    {
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Frontend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Bad_Speculation"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Bad_Speculation_SMT"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Backend_Bound"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Backend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Retiring"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Retiring_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retiring",
         "MetricName": "UPI"
     },
     {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Instruction per taken branch",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "IpTB"
+    },
+    {
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "BpTB"
+    },
+    {
         "MetricExpr": "min( 1 , IDQ.MITE_UOPS / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 16 * ( ICACHE.HIT + ICACHE.MISSES ) / 4.0 ) )",
-        "MetricGroup": "Frontend",
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
+        "MetricGroup": "PGO",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
-        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
+        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
+        "MetricExpr": "4 * cycles",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
+        "MetricGroup": "TopDownL1_SMT",
+        "MetricName": "SLOTS_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
+        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
+        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricName": "IpL"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Instructions per Store",
+        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricName": "IpS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch",
+        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricName": "IpB"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "BriefDescription": "Instruction per (near) call",
+        "MetricGroup": "Branches",
+        "MetricName": "IpCall"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
-        "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE.IFDATA_STALL  - (( 14 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURATION )) ) / RS_EVENTS.EMPTY_END)",
-        "MetricGroup": "Unknown_Branches",
-        "MetricName": "BAClear_Cost"
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "IpMispredict"
     },
     {
+        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (( cpu@l1d_pend_miss.pending_cycles\\,any\\=1@ / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricGroup": "TLB_SMT",
+        "MetricName": "Page_Walks_Utilization_SMT"
+    },
+    {
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L1MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2HPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L3MPKI"
+    },
+    {
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
+        "MetricExpr": "1000000000 * ( cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x35\\,umask\\=0x3\\,filter_opc\\=0x182@ ) / ( cbox_0@event\\=0x0@ / duration_time )",
+        "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
+        "MetricGroup": "Memory_Lat",
+        "MetricName": "DRAM_Read_Latency"
+    },
+    {
+        "MetricExpr": "cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182@ / cbox@event\\=0x36\\,umask\\=0x3\\,filter_opc\\=0x182\\,thresh\\=1@",
+        "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_Parallel_Reads"
+    },
+    {
+        "MetricExpr": "cbox_0@event\\=0x0@",
+        "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricGroup": "",
+        "MetricName": "Socket_CLKS"
+    },
+    {
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index 7c2679514efb..bc4d5fc284a0 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
@@ -1,164 +1,340 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Frontend_Bound"
+    },
+    {
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Frontend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Bad_Speculation"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Bad_Speculation_SMT"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Backend_Bound"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Backend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Retiring"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Retiring_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retiring",
         "MetricName": "UPI"
     },
     {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4) )",
-        "MetricGroup": "Frontend",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Instruction per taken branch",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "IpTB"
+    },
+    {
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "BpTB"
+    },
+    {
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
+        "MetricGroup": "PGO",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
-        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
+        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
+        "MetricExpr": "4 * cycles",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
+        "MetricGroup": "TopDownL1_SMT",
+        "MetricName": "SLOTS_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
+        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
+        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricName": "IpL"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Instructions per Store",
+        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricName": "IpS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch",
+        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricName": "IpB"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "BriefDescription": "Instruction per (near) call",
+        "MetricGroup": "Branches",
+        "MetricName": "IpCall"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS",
+        "MetricName": "FLOPc"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS_SMT",
+        "MetricName": "FLOPc_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
-        "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE.IFETCH_STALL ) / RS_EVENTS.EMPTY_END)",
-        "MetricGroup": "Unknown_Branches",
-        "MetricName": "BAClear_Cost"
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "IpMispredict"
     },
     {
+        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (( cpu@l1d_pend_miss.pending_cycles\\,any\\=1@ / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricGroup": "TLB_SMT",
+        "MetricName": "Page_Walks_Utilization_SMT"
+    },
+    {
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L1MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2HPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L3MPKI"
+    },
+    {
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
+        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(( 1*( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2* FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4*( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8* SIMD_FP_256.PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index 7c2679514efb..f3874b5f9995 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
@@ -1,164 +1,346 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Frontend_Bound"
+    },
+    {
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Frontend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Bad_Speculation"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Bad_Speculation_SMT"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Backend_Bound"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Backend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Retiring"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Retiring_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retiring",
         "MetricName": "UPI"
     },
     {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4) )",
-        "MetricGroup": "Frontend",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Instruction per taken branch",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "IpTB"
+    },
+    {
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "BpTB"
+    },
+    {
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
+        "MetricGroup": "PGO",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
-        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
+        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
+        "MetricExpr": "4 * cycles",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
+        "MetricGroup": "TopDownL1_SMT",
+        "MetricName": "SLOTS_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
+        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
+        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricName": "IpL"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Instructions per Store",
+        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricName": "IpS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch",
+        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricName": "IpB"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "BriefDescription": "Instruction per (near) call",
+        "MetricGroup": "Branches",
+        "MetricName": "IpCall"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS",
+        "MetricName": "FLOPc"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS_SMT",
+        "MetricName": "FLOPc_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
-        "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE.IFETCH_STALL ) / RS_EVENTS.EMPTY_END)",
-        "MetricGroup": "Unknown_Branches",
-        "MetricName": "BAClear_Cost"
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "IpMispredict"
     },
     {
+        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (( cpu@l1d_pend_miss.pending_cycles\\,any\\=1@ / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / cycles",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "( ITLB_MISSES.WALK_DURATION + DTLB_LOAD_MISSES.WALK_DURATION + DTLB_STORE_MISSES.WALK_DURATION ) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricGroup": "TLB_SMT",
+        "MetricName": "Page_Walks_Utilization_SMT"
+    },
+    {
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L1MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2HPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.LLC_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L3MPKI"
+    },
+    {
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
+        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(( 1*( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2* FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4*( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8* SIMD_FP_256.PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
+        "MetricExpr": "cbox_0@event\\=0x0@",
+        "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricGroup": "",
+        "MetricName": "Socket_CLKS"
+    },
+    {
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index fd7d7c438226..98c73e430b05 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -1,140 +1,232 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Frontend_Bound"
+    },
+    {
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Frontend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Bad_Speculation"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Bad_Speculation_SMT"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Backend_Bound"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Backend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Retiring"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Retiring_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retiring",
         "MetricName": "UPI"
     },
     {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4) )",
-        "MetricGroup": "Frontend",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
+        "MetricGroup": "PGO",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
-        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
+        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
+        "MetricExpr": "4 * cycles",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
+        "MetricGroup": "TopDownL1_SMT",
+        "MetricName": "SLOTS_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS",
+        "MetricName": "FLOPc"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS_SMT",
+        "MetricName": "FLOPc_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_DISPATCHED.THREAD / (( cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_DISPATCHED.THREAD / (( cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@ / 2) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
+        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
+        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(( 1*( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2* FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4*( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8* SIMD_FP_256.PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
+        "MetricExpr": "cbox_0@event\\=0x0@",
+        "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricGroup": "",
+        "MetricName": "Socket_CLKS"
+    },
+    {
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index fd7d7c438226..cfeba5067bab 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
@@ -1,140 +1,226 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Frontend_Bound"
+    },
+    {
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Frontend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Bad_Speculation"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Bad_Speculation_SMT"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Backend_Bound"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Backend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Retiring"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Retiring_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retiring",
         "MetricName": "UPI"
     },
     {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4) )",
-        "MetricGroup": "Frontend",
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 32 * ( ICACHE.HIT + ICACHE.MISSES ) / 4 ) )",
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
+        "MetricGroup": "PGO",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
-        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
+        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
+        "MetricExpr": "4 * cycles",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
+        "MetricGroup": "TopDownL1_SMT",
+        "MetricName": "SLOTS_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / cycles",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS",
+        "MetricName": "FLOPc"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS_SMT",
+        "MetricName": "FLOPc_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_DISPATCHED.THREAD / (( cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_DISPATCHED.THREAD / (( cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@ / 2) if #SMT_on else cpu@UOPS_DISPATCHED.CORE\\,cmask\\=1@)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
+        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
+        "MetricExpr": "( (( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * SIMD_FP_256.PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(( 1*( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2* FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4*( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8* SIMD_FP_256.PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 71e9737f4614..2c95417a4dae 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -1,164 +1,364 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Frontend_Bound"
+    },
+    {
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Frontend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Bad_Speculation"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Bad_Speculation_SMT"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Backend_Bound"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Backend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Retiring"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Retiring_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retiring",
         "MetricName": "UPI"
     },
     {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ((UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1) )",
-        "MetricGroup": "Frontend",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Instruction per taken branch",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "IpTB"
+    },
+    {
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "BpTB"
+    },
+    {
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1 ) )",
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
+        "MetricGroup": "PGO",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
-        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ))",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
+        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
+        "MetricExpr": "4 * cycles",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
+        "MetricGroup": "TopDownL1_SMT",
+        "MetricName": "SLOTS_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
+        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
+        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricName": "IpL"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
+        "BriefDescription": "Instructions per Store",
+        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricName": "IpS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch",
+        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricName": "IpB"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "BriefDescription": "Instruction per (near) call",
+        "MetricGroup": "Branches",
+        "MetricName": "IpCall"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / cycles",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS",
+        "MetricName": "FLOPc"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS_SMT",
+        "MetricName": "FLOPc_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
-        "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE_16B.IFDATA_STALL  - ICACHE_64B.IFTAG_STALL ) / RS_EVENTS.EMPTY_END)",
-        "MetricGroup": "Unknown_Branches",
-        "MetricName": "BAClear_Cost"
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "Branch_Misprediction_Cost"
     },
     {
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
+        "MetricGroup": "Branch_Mispredicts_SMT",
+        "MetricName": "Branch_Misprediction_Cost_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (( L1D_PEND_MISS.PENDING_CYCLES_ANY / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles) )",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
+        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricGroup": "TLB_SMT",
+        "MetricName": "Page_Walks_Utilization_SMT"
+    },
+    {
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Access_BW"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L1MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI"
+    },
+    {
+        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2HPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L3MPKI"
+    },
+    {
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
+        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(( 1*( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2* FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4*( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8* FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "64 * ( arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@ ) / 1000000 / duration_time / 1000",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
+        "MetricExpr": "arb@event\\=0x80\\,umask\\=0x2@ / arb@event\\=0x80\\,umask\\=0x2\\,thresh\\=1@",
+        "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_Parallel_Reads"
+    },
+    {
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 71e9737f4614..56e03ba771f4 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -1,164 +1,394 @@
 [
     {
-        "BriefDescription": "Instructions Per Cycle (per logical thread)",
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Frontend_Bound"
+    },
+    {
+        "MetricExpr": "IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. Frontend denotes the first part of the processor core responsible to fetch operations that are executed later on by the Backend part. Within the Frontend; a branch predictor predicts the next address to fetch; cache-lines are fetched from the memory subsystem; parsed into instructions; and lastly decoded into micro-ops (uops). Ideally the Frontend can issue 4 uops every cycle to the Backend. Frontend Bound denotes unutilized issue-slots when there is no Backend stall; i.e. bubbles where Frontend delivered no uops while Backend could have accepted them. For example; stalls due to instruction-cache misses would be categorized under Frontend Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where the processor's Frontend undersupplies its Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Frontend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Bad_Speculation"
+    },
+    {
+        "MetricExpr": "( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots wasted due to incorrect speculations. This include slots used to issue uops that do not eventually get retired and slots for which the issue-pipeline was blocked due to recovery from earlier incorrect speculation. For example; wasted work due to miss-predicted branches are categorized under Bad Speculation category. Incorrect data speculation followed by Memory Ordering Nukes is another example. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots wasted due to incorrect speculations. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Bad_Speculation_SMT"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * cycles)) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles)) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Backend_Bound"
+    },
+    {
+        "MetricExpr": "1 - ( (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) + (UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
+        "PublicDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. Backend is the portion of the processor core where the out-of-order scheduler dispatches ready uops into their respective execution units; and once completed these uops get retired according to program order. For example; stalls due to data-cache misses or stalls due to the divider unit being overloaded are both categorized under Backend Bound. Backend Bound is further divided into two main categories: Memory Bound and Core Bound. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots where no uops are being delivered due to a lack of required resources for accepting new uops in the Backend. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Backend_Bound_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * cycles)",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. ",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired",
+        "MetricGroup": "TopdownL1",
+        "MetricName": "Retiring"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))",
+        "PublicDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. Ideally; all pipeline slots would be attributed to the Retiring category.  Retiring of 100% would indicate the maximum 4 uops retired per cycle has been achieved.  Maximizing Retiring typically increases the Instruction-Per-Cycle metric. Note that a high Retiring value does not necessary mean there is no room for more performance.  For example; Microcode assists are categorized under Retiring. They hurt performance and can often be avoided. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "BriefDescription": "This category represents fraction of slots utilized by useful work i.e. issued uops that eventually get retired. SMT version; use when SMT is enabled and measuring per logical CPU.",
+        "MetricGroup": "TopdownL1_SMT",
+        "MetricName": "Retiring_SMT"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per logical thread)",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retiring",
         "MetricName": "UPI"
     },
     {
-        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely consumed by program instructions",
-        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ((UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1) )",
-        "MetricGroup": "Frontend",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Instruction per taken branch",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "IpTB"
+    },
+    {
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "BpTB"
+    },
+    {
+        "MetricExpr": "min( 1 , UOPS_ISSUED.ANY / ( (UOPS_RETIRED.RETIRE_SLOTS / INST_RETIRED.ANY) * 64 * ( ICACHE_64B.IFTAG_HIT + ICACHE_64B.IFTAG_MISS ) / 4.1 ) )",
+        "BriefDescription": "Rough Estimation of fraction of fetched lines bytes that were likely (includes speculatively fetches) consumed by program instructions",
+        "MetricGroup": "PGO",
         "MetricName": "IFetch_Line_Utilization"
     },
     {
-        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded Icache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS )",
-        "MetricGroup": "DSB; Frontend_Bandwidth",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ))",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;Frontend_Bandwidth",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricExpr": "1 / (INST_RETIRED.ANY / cycles)",
+        "BriefDescription": "Cycles Per Instruction (threaded)",
         "MetricGroup": "Pipeline;Summary",
         "MetricName": "CPI"
     },
     {
-        "BriefDescription": "Per-thread actual clocks when the logical processor is active. This is called 'Clockticks' in VTune.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-thread actual clocks when the logical processor is active.",
         "MetricGroup": "Summary",
         "MetricName": "CLKS"
     },
     {
-        "BriefDescription": "Total issue-pipeline slots",
-        "MetricExpr": "4*(( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
+        "MetricExpr": "4 * cycles",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
         "MetricGroup": "TopDownL1",
         "MetricName": "SLOTS"
     },
     {
-        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Total issue-pipeline slots (per core)",
+        "MetricGroup": "TopDownL1_SMT",
+        "MetricName": "SLOTS_SMT"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
+        "BriefDescription": "Instructions per Load (lower number means loads are more frequent)",
+        "MetricGroup": "Instruction_Type;L1_Bound",
+        "MetricName": "IpL"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
+        "BriefDescription": "Instructions per Store",
+        "MetricGroup": "Instruction_Type;Store_Bound",
+        "MetricName": "IpS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch",
+        "MetricGroup": "Branches;Instruction_Type;Port_5;Port_6",
+        "MetricName": "IpB"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "BriefDescription": "Instruction per (near) call",
+        "MetricGroup": "Branches",
+        "MetricName": "IpCall"
+    },
+    {
         "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
         "MetricGroup": "Summary",
         "MetricName": "Instructions"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
         "BriefDescription": "Instructions Per Cycle (per physical core)",
-        "MetricExpr": "INST_RETIRED.ANY / (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles)",
         "MetricGroup": "SMT",
         "MetricName": "CoreIPC"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT",
+        "MetricName": "CoreIPC_SMT"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / cycles",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS",
+        "MetricName": "FLOPc"
+    },
+    {
+        "MetricExpr": "(( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "FLOPS_SMT",
+        "MetricName": "FLOPc_SMT"
+    },
+    {
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "MetricGroup": "Pipeline;Ports_Utilization",
         "MetricName": "ILP"
     },
     {
-        "BriefDescription": "Average Branch Address Clear Cost (fraction of cycles)",
-        "MetricExpr": "2* (( RS_EVENTS.EMPTY_CYCLES - ICACHE_16B.IFDATA_STALL  - ICACHE_64B.IFTAG_STALL ) / RS_EVENTS.EMPTY_END)",
-        "MetricGroup": "Unknown_Branches",
-        "MetricName": "BAClear_Cost"
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * cycles))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * cycles)) ) * (4 * cycles) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "Branch_Misprediction_Cost"
+    },
+    {
+        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (( INT_MISC.RECOVERY_CYCLES_ANY / 2 )) ) / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) * (( INT_MISC.CLEAR_RESTEER_CYCLES + 9 * BACLEARS.ANY ) / cycles) / (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * (4 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TopDown slots wasted per branch misprediction (jeclear and baclear)",
+        "MetricGroup": "Branch_Mispredicts_SMT",
+        "MetricName": "Branch_Misprediction_Cost_SMT"
     },
     {
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricGroup": "Branch_Mispredicts",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
         "BriefDescription": "Core actual clocks when any thread is active on the physical core",
-        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "SMT",
         "MetricName": "CORE_CLKS"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least 1 such miss)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / (( L1D_PEND_MISS.PENDING_CYCLES_ANY / 2) if #SMT_on else L1D_PEND_MISS.PENDING_CYCLES)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-thread)",
         "MetricGroup": "Memory_Bound;Memory_BW",
         "MetricName": "MLP"
     },
     {
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * cycles )",
         "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
-        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else cycles) )",
         "MetricGroup": "TLB",
         "MetricName": "Page_Walks_Utilization"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING + EPT.WALK_PENDING ) / ( 2 * (( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) )",
+        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricGroup": "TLB_SMT",
+        "MetricName": "Page_Walks_Utilization_SMT"
+    },
+    {
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "L3_Cache_Access_BW"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L1MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI"
+    },
+    {
+        "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2MPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * ( L2_RQSTS.REFERENCES - L2_RQSTS.MISS ) / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache hits per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L2HPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "Cache_Misses;",
+        "MetricName": "L3MPKI"
+    },
+    {
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
         "MetricGroup": "Summary",
         "MetricName": "CPU_Utilization"
     },
     {
+        "MetricExpr": "( (( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )) / 1000000000 ) / duration_time",
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(( 1*( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2* FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4*( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8* FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE )) / 1000000000 / duration_time",
         "MetricGroup": "FLOPS;Summary",
         "MetricName": "GFLOPs"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
         "MetricGroup": "Power",
         "MetricName": "Turbo_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricExpr": "1 - CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE / ( CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY / 2 ) if #SMT_on else 0",
+        "BriefDescription": "Fraction of cycles where both hardware threads were active",
         "MetricGroup": "SMT;Summary",
         "MetricName": "SMT_2T_Utilization"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC:u / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
         "MetricGroup": "Summary",
         "MetricName": "Kernel_Utilization"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
+        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
+        "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
+        "MetricGroup": "Memory_Lat",
+        "MetricName": "DRAM_Read_Latency"
+    },
+    {
+        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
+        "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "DRAM_Parallel_Reads"
+    },
+    {
+        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\\\\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ ) if 1 if 0 == 1 else 0 else 0",
+        "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
+        "MetricGroup": "Memory_Lat",
+        "MetricName": "MEM_PMM_Read_Latency"
+    },
+    {
+        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
+        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "PMM_Read_BW"
+    },
+    {
+        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
+        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
+        "MetricGroup": "Memory_BW",
+        "MetricName": "PMM_Write_BW"
+    },
+    {
+        "MetricExpr": "cha_0@event\\=0x0@",
+        "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricGroup": "",
+        "MetricName": "Socket_CLKS"
+    },
+    {
         "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per core",
         "MetricName": "C3_Core_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per core",
         "MetricName": "C6_Core_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per core",
         "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per core",
         "MetricName": "C7_Core_Residency"
     },
     {
-        "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C2 residency percent per package",
         "MetricName": "C2_Pkg_Residency"
     },
     {
-        "BriefDescription": "C3 residency percent per package",
         "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C3 residency percent per package",
         "MetricName": "C3_Pkg_Residency"
     },
     {
-        "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C6 residency percent per package",
         "MetricName": "C6_Pkg_Residency"
     },
     {
-        "BriefDescription": "C7 residency percent per package",
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
+        "BriefDescription": "C7 residency percent per package",
         "MetricName": "C7_Pkg_Residency"
     }
 ]
-- 
2.20.1

