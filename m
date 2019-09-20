Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD98C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719A72086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989713;
	bh=yICsD6IyOQt8lboXlHYWu0RqSkp8rzo+xnIJPFCkXN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qodEtCL4GBWyKexx88pJrBT0WKiKM5+A8hrpvQ1MXmgw9EoQyyHshv1L5dIkfKLBU
	 CbzPOXM+bHH06Cy/NGLWWf0aoegAMhvCSgmRIwPKRJoeV8Vs07Dg2YMAYpoL3vOPn5
	 a8dEhLhNq1I30W8h3UBlnepqlGCjBnu3YGRqxBj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbfITO1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388890AbfITO0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DE7A20882;
        Fri, 20 Sep 2019 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989571;
        bh=yICsD6IyOQt8lboXlHYWu0RqSkp8rzo+xnIJPFCkXN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4y3LWJ6DDpa8BFKGen5F9gPmf/ClBIGRyn4yftVmu6UInKXhJtIDEToOeEqnK+tM
         71bZYV/6VQ+VMpoL3N0cXwCS1rdH9nlrhXjaiRnS7/Yh/EEJo1FY7gSl0TLpcwotFF
         vl2tCIftDXmIBtFCNpvwjZO/On0rPusjApJ3CKxw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <James.Clark@arm.com>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>, nd <nd@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/31] perf tools: Add PMU event JSON files for ARM Cortex-A76 and, Neoverse N1.
Date:   Fri, 20 Sep 2019 11:25:17 -0300
Message-Id: <20190920142542.12047-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Clark <James.Clark@arm.com>

The source of the event codes and description text was the Neoverse N1
technical reference manual at:

  http://infocenter.arm.com/help/topic/com.arm.doc.100616_0301_01_en/neoverse_n1_trm_100616_0301_01_en.pdf

The Cortex-A76 shares the same event IDs as the Neoverse N1 and they
can be viewed at:

  https://static.docs.arm.com/100798/0400/cortex_a76_trm_100798_0400_00_en.pdf

Signed-off-by: James Clark <james.clark@arm.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: james clark <james.clark@arm.com>
Cc: nd <nd@arm.com>
Link: http://lore.kernel.org/lkml/20190902160713.1425-2-james.clark@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/arm64/arm/cortex-a76-n1/branch.json  |  14 ++
 .../arch/arm64/arm/cortex-a76-n1/bus.json     |  24 ++
 .../arch/arm64/arm/cortex-a76-n1/cache.json   | 207 ++++++++++++++++++
 .../arm64/arm/cortex-a76-n1/exception.json    |  52 +++++
 .../arm64/arm/cortex-a76-n1/instruction.json  | 108 +++++++++
 .../arch/arm64/arm/cortex-a76-n1/memory.json  |  23 ++
 .../arch/arm64/arm/cortex-a76-n1/other.json   |   7 +
 .../arm64/arm/cortex-a76-n1/pipeline.json     |  14 ++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
 9 files changed, 451 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
new file mode 100644
index 000000000000..b5e5d055c70d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
@@ -0,0 +1,14 @@
+[
+    {
+        "PublicDescription": "Mispredicted or not predicted branch speculatively executed. This event counts any predictable branch instruction which is mispredicted either due to dynamic misprediction or because the MMU is off and the branches are statically predicted not taken.",
+        "EventCode": "0x10",
+        "EventName": "BR_MIS_PRED",
+        "BriefDescription": "Mispredicted or not predicted branch speculatively executed."
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed. This event counts all predictable branches.",
+        "EventCode": "0x12",
+        "EventName": "BR_PRED",
+        "BriefDescription": "Predictable branch speculatively executed."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
new file mode 100644
index 000000000000..fce7309ae624
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.json
@@ -0,0 +1,24 @@
+[
+    {
+        "EventCode": "0x11",
+        "EventName": "CPU_CYCLES",
+        "BriefDescription": "The number of core clock cycles."
+    },
+    {
+        "PublicDescription": "Bus access. This event counts for every beat of data transferred over the data channels between the core and the SCU. If both read and write data beats are transferred on a given cycle, this event is counted twice on that cycle. This event counts the sum of BUS_ACCESS_RD and BUS_ACCESS_WR.",
+        "EventCode": "0x19",
+        "EventName": "BUS_ACCESS",
+        "BriefDescription": "Bus access."
+    },
+    {
+        "EventCode": "0x1D",
+        "EventName": "BUS_CYCLES",
+        "BriefDescription": "Bus cycles. This event duplicates CPU_CYCLES."
+    },
+    {
+        "ArchStdEvent":  "BUS_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent":  "BUS_ACCESS_WR"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
new file mode 100644
index 000000000000..24594081c199
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cache.json
@@ -0,0 +1,207 @@
+[
+    {
+        "PublicDescription": "L1 instruction cache refill. This event counts any instruction fetch which misses in the cache.",
+        "EventCode": "0x01",
+        "EventName": "L1I_CACHE_REFILL",
+        "BriefDescription": "L1 instruction cache refill"
+    },
+    {
+        "PublicDescription": "L1 instruction TLB refill. This event counts any refill of the instruction L1 TLB from the L2 TLB. This includes refills that result in a translation fault.",
+        "EventCode": "0x02",
+        "EventName": "L1I_TLB_REFILL",
+        "BriefDescription": "L1 instruction TLB refill"
+    },
+    {
+        "PublicDescription": "L1 data cache refill. This event counts any load or store operation or page table walk access which causes data to be read from outside the L1, including accesses which do not allocate into L1.",
+        "EventCode": "0x03",
+        "EventName": "L1D_CACHE_REFILL",
+        "BriefDescription": "L1 data cache refill"
+    },
+    {
+        "PublicDescription": "L1 data cache access. This event counts any load or store operation or page table walk access which looks up in the L1 data cache. In particular, any access which could count the L1D_CACHE_REFILL event causes this event to count.",
+        "EventCode": "0x04",
+        "EventName": "L1D_CACHE",
+        "BriefDescription": "L1 data cache access"
+    },
+    {
+        "PublicDescription": "L1 data TLB refill. This event counts any refill of the data L1 TLB from the L2 TLB. This includes refills that result in a translation fault.",
+        "EventCode": "0x05",
+        "EventName": "L1D_TLB_REFILL",
+        "BriefDescription": "L1 data TLB refill"
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache access or Level 0 Macro-op cache access. This event counts any instruction fetch which accesses the L1 instruction cache or L0 Macro-op cache.",
+        "EventCode": "0x14",
+        "EventName": "L1I_CACHE",
+        "BriefDescription": "L1 instruction cache access"
+    },
+    {
+        "PublicDescription": "L1 data cache Write-Back. This event counts any write-back of data from the L1 data cache to L2 or L3. This counts both victim line evictions and snoops, including cache maintenance operations.",
+        "EventCode": "0x15",
+        "EventName": "L1D_CACHE_WB",
+        "BriefDescription": "L1 data cache Write-Back"
+    },
+    {
+        "PublicDescription": "L2 data cache access. This event counts any transaction from L1 which looks up in the L2 cache, and any write-back from the L1 to the L2. Snoops from outside the core and cache maintenance operations are not counted.",
+        "EventCode": "0x16",
+        "EventName": "L2D_CACHE",
+        "BriefDescription": "L2 data cache access"
+    },
+    {
+        "PublicDescription": "L2 data cache refill. This event counts any cacheable transaction from L1 which causes data to be read from outside the core. L2 refills caused by stashes into L2 should not be counted",
+        "EventCode": "0x17",
+        "EventName": "L2D_CACHE_REFILL",
+        "BriefDescription": "L2 data cache refill"
+    },
+    {
+        "PublicDescription": "L2 data cache write-back. This event counts any write-back of data from the L2 cache to outside the core. This includes snoops to the L2 which return data, regardless of whether they cause an invalidation. Invalidations from the L2 which do not write data outside of the core and snoops which return data from the L1 are not counted",
+        "EventCode": "0x18",
+        "EventName": "L2D_CACHE_WB",
+        "BriefDescription": "L2 data cache write-back"
+    },
+    {
+        "PublicDescription": "L2 data cache allocation without refill. This event counts any full cache line write into the L2 cache which does not cause a linefill, including write-backs from L1 to L2 and full-line writes which do not allocate into L1.",
+        "EventCode": "0x20",
+        "EventName": "L2D_CACHE_ALLOCATE",
+        "BriefDescription": "L2 data cache allocation without refill"
+    },
+    {
+        "PublicDescription": "Level 1 data TLB access. This event counts any load or store operation which accesses the data L1 TLB. If both a load and a store are executed on a cycle, this event counts twice. This event counts regardless of whether the MMU is enabled.",
+        "EventCode": "0x25",
+        "EventName": "L1D_TLB",
+        "BriefDescription": "Level 1 data TLB access."
+    },
+    {
+        "PublicDescription": "Level 1 instruction TLB access. This event counts any instruction fetch which accesses the instruction L1 TLB.This event counts regardless of whether the MMU is enabled.",
+        "EventCode": "0x26",
+        "EventName": "L1I_TLB",
+        "BriefDescription": "Level 1 instruction TLB access"
+    },
+    {
+        "PublicDescription": "This event counts any full cache line write into the L3 cache which does not cause a linefill, including write-backs from L2 to L3 and full-line writes which do not allocate into L2",
+        "EventCode": "0x29",
+        "EventName": "L3D_CACHE_ALLOCATE",
+        "BriefDescription": "Allocation without refill"
+    },
+    {
+        "PublicDescription": "Attributable Level 3 unified cache refill. This event counts for any cacheable read transaction returning datafrom the SCU for which the data source was outside the cluster. Transactions such as ReadUnique are counted here as 'read' transactions, even though they can be generated by store instructions.",
+        "EventCode": "0x2A",
+        "EventName": "L3D_CACHE_REFILL",
+        "BriefDescription": "Attributable Level 3 unified cache refill."
+    },
+    {
+        "PublicDescription": "Attributable Level 3 unified cache access. This event counts for any cacheable read transaction returning datafrom the SCU, or for any cacheable write to the SCU.",
+        "EventCode": "0x2B",
+        "EventName": "L3D_CACHE",
+        "BriefDescription": "Attributable Level 3 unified cache access."
+    },
+    {
+        "PublicDescription": "Attributable L2 data or unified TLB refill. This event counts on anyrefill of the L2 TLB, caused by either an instruction or data access.This event does not count if the MMU is disabled.",
+        "EventCode": "0x2D",
+        "EventName": "L2D_TLB_REFILL",
+        "BriefDescription": "Attributable L2 data or unified TLB refill"
+    },
+    {
+        "PublicDescription": "Attributable L2 data or unified TLB access. This event counts on any access to the L2 TLB (caused by a refill of any of the L1 TLBs). This event does not count if the MMU is disabled.",
+        "EventCode": "0x2F",
+        "EventName": "L2D_TLB",
+        "BriefDescription": "Attributable L2 data or unified TLB access"
+    },
+    {
+        "PublicDescription": "Access to data TLB that caused a page table walk. This event counts on any data access which causes L2D_TLB_REFILL to count.",
+        "EventCode": "0x34",
+        "EventName": "DTLB_WALK",
+        "BriefDescription": "Access to data TLB that caused a page table walk."
+    },
+    {
+        "PublicDescription": "Access to instruction TLB that caused a page table walk. This event counts on any instruction access which causes L2D_TLB_REFILL to count.",
+        "EventCode": "0x35",
+        "EventName": "ITLB_WALK",
+        "BriefDescription": "Access to instruction TLB that caused a page table walk."
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "LL_CACHE_RD",
+        "BriefDescription": "Last level cache access, read"
+    },
+    {
+        "EventCode": "0x37",
+        "EventName": "LL_CACHE_MISS_RD",
+        "BriefDescription": "Last level cache miss, read"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR"
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RD"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
new file mode 100644
index 000000000000..98d29c862320
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exception.json
@@ -0,0 +1,52 @@
+[
+    {
+        "EventCode": "0x09",
+        "EventName": "EXC_TAKEN",
+        "BriefDescription": "Exception taken."
+    },
+    {
+        "PublicDescription": "Local memory error. This event counts any correctable or uncorrectable memory error (ECC or parity) in the protected core RAMs",
+        "EventCode": "0x1A",
+        "EventName": "MEMORY_ERROR",
+        "BriefDescription": "Local memory error."
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ"
+    },
+    {
+        "ArchStdEvent": "EXC_HVC"
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_SMC"
+    },
+    {
+        "ArchStdEvent": "EXC_SVC"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
new file mode 100644
index 000000000000..c153ac706d8d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/instruction.json
@@ -0,0 +1,108 @@
+[
+    {
+        "PublicDescription": "Software increment. Instruction architecturally executed (condition code check pass).",
+        "EventCode": "0x00",
+        "EventName": "SW_INCR",
+        "BriefDescription": "Software increment."
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed. This event counts all retired instructions, including those that fail their condition check.",
+        "EventCode": "0x08",
+        "EventName": "INST_RETIRED",
+        "BriefDescription": "Instruction architecturally executed."
+    },
+    {
+        "EventCode": "0x0A",
+        "EventName": "EXC_RETURN",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, exception return."
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR. This event only counts writes to CONTEXTIDR in AArch32 state, and via the CONTEXTIDR_EL1 mnemonic in AArch64 state.",
+        "EventCode": "0x0B",
+        "EventName": "CID_WRITE_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, write to CONTEXTIDR."
+    },
+    {
+        "EventCode": "0x1B",
+        "EventName": "INST_SPEC",
+        "BriefDescription": "Operation speculatively executed"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, condition code check pass, write to TTBR. This event only counts writes to TTBR0/TTBR1 in AArch32 state and TTBR0_EL1/TTBR1_EL1 in AArch64 state.",
+        "EventCode": "0x1C",
+        "EventName": "TTBR_WRITE_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, condition code check pass, write to TTBR"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, branch. This event counts all branches, taken or not. This excludes exception entries, debug entries and CCFAIL branches.",
+        "EventCode": "0x21",
+        "EventName": "BR_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, branch."
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, mispredicted branch. This event counts any branch counted by BR_RETIRED which is not correctly predicted and causes a pipeline flush.",
+        "EventCode": "0x22",
+        "EventName": "BR_MIS_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, mispredicted branch."
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC"
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC"
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DP_SPEC"
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC"
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC"
+    },
+    {
+        "ArchStdEvent": "LDREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC"
+    },
+    {
+        "ArchStdEvent": "LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC"
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
new file mode 100644
index 000000000000..b86643253f19
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memory.json
@@ -0,0 +1,23 @@
+[
+    {
+        "PublicDescription": "Data memory access. This event counts memory accesses due to load or store instructions. This event counts the sum of MEM_ACCESS_RD and MEM_ACCESS_WR.",
+        "EventCode": "0x13",
+        "EventName": "MEM_ACCESS",
+        "BriefDescription": "Data memory access"
+    },
+    {
+         "ArchStdEvent": "MEM_ACCESS_RD"
+    },
+    {
+         "ArchStdEvent": "MEM_ACCESS_WR"
+    },
+    {
+         "ArchStdEvent": "UNALIGNED_LD_SPEC"
+    },
+    {
+         "ArchStdEvent": "UNALIGNED_ST_SPEC"
+    },
+    {
+         "ArchStdEvent": "UNALIGNED_LDST_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
new file mode 100644
index 000000000000..8bde029a62d5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/other.json
@@ -0,0 +1,7 @@
+[
+    {
+        "EventCode": "0x31",
+        "EventName": "REMOTE_ACCESS",
+        "BriefDescription": "Access to another socket in a multi-socket system"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
new file mode 100644
index 000000000000..010a647f9d02
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipeline.json
@@ -0,0 +1,14 @@
+[
+    {
+        "PublicDescription": "No operation issued because of the frontend. The counter counts on any cycle when there are no fetched instructions available to dispatch.",
+        "EventCode": "0x23",
+        "EventName": "STALL_FRONTEND",
+        "BriefDescription": "No operation issued because of the frontend."
+    },
+    {
+        "PublicDescription": "No operation issued because of the backend. The counter counts on any cycle fetched instructions are not dispatched due to resource constraints.",
+        "EventCode": "0x24",
+        "EventName": "STALL_BACKEND",
+        "BriefDescription": "No operation issued because of the backend."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 927fcddcb4aa..0d609149b82a 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -16,6 +16,8 @@
 0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000410fd070,v1,arm/cortex-a57-a72,core
 0x00000000410fd080,v1,arm/cortex-a57-a72,core
+0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
+0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
-- 
2.21.0

