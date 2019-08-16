Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D8C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BF12173E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986634;
	bh=DFHprfG/qfd42t0Vx/DYYVx57aMEyUE0lVDJk4Ys/6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wF0KLOQ7ye0i5ME9pzpLlc4/aIdnPSgdq8pCqgnjquagcnFyK77eN08Oi2vTlILCW
	 aBdj++K4bMdvUFv5uVvRtE8YmwHw9hlXGAvCESUiEJ9KssaQRsuijuKV8ey7cCusVP
	 lTZ866rHi6Qi0iqXpX25t89E4ttyb4gExcyw5U4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfHPURN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfHPURM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:17:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF3CE2171F;
        Fri, 16 Aug 2019 20:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986628;
        bh=DFHprfG/qfd42t0Vx/DYYVx57aMEyUE0lVDJk4Ys/6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpezAjX6SCX9qKx+xe6HVaFkTgltFofWVmjIASRi0WStSaa4B4xAbYpTa1SBxtWW1
         62MPDzM4ng84pAT1I9uf5GcWbalusa59NxyJzQy6735UN99oECVSLcQDRaFv8RFwgr
         lhKcmazMZcQBFSRMYtdU4aUVGhG9BoiC6oDB4DsA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Haiyan Song <haiyanx.song@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/17] perf vendor events intel: Add Tremontx event file v1.02
Date:   Fri, 16 Aug 2019 17:16:37 -0300
Message-Id: <20190816201653.19332-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816201653.19332-1-acme@kernel.org>
References: <20190816201653.19332-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyan Song <haiyanx.song@intel.com>

Add a Intel event file for perf.

Signed-off-by: Haiyan Song <haiyanx.song@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190815035942.30602-1-haiyanx.song@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
 .../pmu-events/arch/x86/tremontx/cache.json   | 111 +++++
 .../arch/x86/tremontx/frontend.json           |  26 ++
 .../pmu-events/arch/x86/tremontx/memory.json  |  26 ++
 .../pmu-events/arch/x86/tremontx/other.json   |  26 ++
 .../arch/x86/tremontx/pipeline.json           | 111 +++++
 .../arch/x86/tremontx/uncore-memory.json      |  73 +++
 .../arch/x86/tremontx/uncore-other.json       | 431 ++++++++++++++++++
 .../arch/x86/tremontx/uncore-power.json       |  11 +
 .../arch/x86/tremontx/virtual-memory.json     |  86 ++++
 10 files changed, 902 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index b90e5fec2f32..745ced083844 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -35,4 +35,5 @@ GenuineIntel-6-55-[01234],v1,skylakex,core
 GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
+GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/cache.json b/tools/perf/pmu-events/arch/x86/tremontx/cache.json
new file mode 100644
index 000000000000..f88040171b4d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/cache.json
@@ -0,0 +1,111 @@
+[
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cacheable memory requests that miss in the the Last Level Cache.  Requests include Demand Loads, Reads for Ownership(RFO), Instruction fetches and L1 HW prefetches. If the platform has an L3 cache, last level cache is the L3, otherwise it is the L2.",
+        "EventCode": "0x2e",
+        "Counter": "0,1,2,3",
+        "UMask": "0x41",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts memory requests originating from the core that miss in the last level cache. If the platform has an L3 cache, last level cache is the L3, otherwise it is the L2."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cacheable memory requests that access the Last Level Cache.  Requests include Demand Loads, Reads for Ownership(RFO), Instruction fetches and L1 HW prefetches. If the platform has an L3 cache, last level cache is the L3, otherwise it is the L2.",
+        "EventCode": "0x2e",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4f",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts memory requests originating from the core that reference a cache line in the last level cache. If the platform has an L3 cache, last level cache is the L3, otherwise it is the L2."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of load uops retired. This event is Precise Event capable",
+        "EventCode": "0xd0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x81",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts the number of load uops retired.",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of store uops retired. This event is Precise Event capable",
+        "EventCode": "0xd0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x82",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts the number of store uops retired.",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xd1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts the number of load uops retired that hit the level 1 data cache",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xd1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts the number of load uops retired that hit in the level 2 cache",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xd1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts the number of load uops retired that miss in the level 3 cache"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xd1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts the number of load uops retired that miss in the level 1 data cache",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xd1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts the number of load uops retired that miss in the level 2 cache",
+        "Data_LA": "1"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/frontend.json b/tools/perf/pmu-events/arch/x86/tremontx/frontend.json
new file mode 100644
index 000000000000..73b0a1ed5756
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/frontend.json
@@ -0,0 +1,26 @@
+[
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts requests to the Instruction Cache (ICache)  for one or more bytes in an ICache Line and that cache line is not in the ICache (miss).  The event strives to count on a cache line basis, so that multiple accesses which miss in a single cache line count as one ICACHE.MISS.  Specifically, the event counts when straight line code crosses the cache line boundary, or when a branch target is to a new line, and that cache line is not in the ICache.",
+        "EventCode": "0x80",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ICACHE.MISSES",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts requests to the Instruction Cache (ICache) for one or more bytes in a cache line and they do not hit in the ICache (miss)."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts requests to the Instruction Cache (ICache) for one or more bytes in an ICache Line.  The event strives to count on a cache line basis, so that multiple fetches to a single cache line count as one ICACHE.ACCESS.  Specifically, the event counts when accesses from straight line code crosses the cache line boundary, or when a branch target is to a new line.",
+        "EventCode": "0x80",
+        "Counter": "0,1,2,3",
+        "UMask": "0x3",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ICACHE.ACCESSES",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts requests to the Instruction Cache (ICache) for one or more bytes cache Line."
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/memory.json b/tools/perf/pmu-events/arch/x86/tremontx/memory.json
new file mode 100644
index 000000000000..65469e84f35b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/memory.json
@@ -0,0 +1,26 @@
+[
+    {
+        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "EventCode": "0XB7",
+        "MSRValue": "0x000000003F04000001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads that was not supplied by the L3 cache.",
+        "Offcore": "1"
+    },
+    {
+        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "EventCode": "0XB7",
+        "MSRValue": "0x000000003F04000002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand reads for ownership (RFO) requests and software based prefetches for exclusive ownership (PREFETCHW) that was not supplied by the L3 cache.",
+        "Offcore": "1"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/other.json b/tools/perf/pmu-events/arch/x86/tremontx/other.json
new file mode 100644
index 000000000000..85bf3c8f3914
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/other.json
@@ -0,0 +1,26 @@
+[
+    {
+        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "EventCode": "0XB7",
+        "MSRValue": "0x000000000000010001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads that have any response type.",
+        "Offcore": "1"
+    },
+    {
+        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "EventCode": "0XB7",
+        "MSRValue": "0x000000000000010002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand reads for ownership (RFO) requests and software based prefetches for exclusive ownership (PREFETCHW) that have any response type.",
+        "Offcore": "1"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json b/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
new file mode 100644
index 000000000000..05a8f6a7d9c0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
@@ -0,0 +1,111 @@
+[
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of instructions that retire. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. The counter continues counting during hardware interrupts, traps, and inside interrupt handlers.  This event uses fixed counter 0.",
+        "Counter": "32",
+        "UMask": "0x1",
+        "PEBScounters": "32",
+        "EventName": "INST_RETIRED.ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts the number of instructions retired. (Fixed event)"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of core cycles while the core is not in a halt state.  The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time.  This event uses fixed counter 1.",
+        "Counter": "33",
+        "UMask": "0x2",
+        "PEBScounters": "33",
+        "EventName": "CPU_CLK_UNHALTED.CORE",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of reference cycles that the core is not in a halt state. The core enters the halt state when it is running the HLT instruction.  The core frequency may change from time.  This event is not affected by core frequency changes and at a fixed frequency.  This event uses fixed counter 2.",
+        "Counter": "34",
+        "UMask": "0x3",
+        "PEBScounters": "34",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts the number of unhalted reference clock cycles at TSC frequency. (Fixed event)"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of core cycles while the core is not in a halt state.  The core enters the halt state when it is running the HLT instruction. The core frequency may change from time to time. For this reason this event may have a changing ratio with regards to time.  This event uses a programmable general purpose performance counter.",
+        "EventCode": "0x3c",
+        "Counter": "0,1,2,3",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CPU_CLK_UNHALTED.CORE_P",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts the number of unhalted core clock cycles."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts reference cycles (at TSC frequency) when core is not halted.  This event uses a programmable general purpose perfmon counter.",
+        "EventCode": "0x3c",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CPU_CLK_UNHALTED.REF",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts the number of unhalted reference clock cycles at TSC frequency."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of instructions that retire execution. For instructions that consist of multiple uops, this event counts the retirement of the last uop of the instruction. The event continues counting during hardware interrupts, traps, and inside interrupt handlers.  This is an architectural performance event.  This event uses a Programmable general purpose perfmon counter. *This event is Precise Event capable:  The EventingRIP field in the PEBS record is precise to the address of the instruction which caused the event.",
+        "EventCode": "0xc0",
+        "Counter": "0,1,2,3",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "INST_RETIRED.ANY_P",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts the number of instructions retired."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xc3",
+        "Counter": "0,1,2,3",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MACHINE_CLEARS.ANY",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "20003",
+        "BriefDescription": "Counts all machine clears due to, but not limited to memory ordering, memory disambiguation, SMC, page faults and FP assist."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts branch instructions retired for all branch types. This event is Precise Event capable. This is an architectural event.",
+        "EventCode": "0xc4",
+        "Counter": "0,1,2,3",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts the number of branch instructions retired for all branch types."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts mispredicted branch instructions retired for all branch types. This event is Precise Event capable. This is an architectural event.",
+        "EventCode": "0xc5",
+        "Counter": "0,1,2,3",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts the number of mispredicted branch instructions retired."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xcd",
+        "Counter": "0,1,2,3",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CYCLES_DIV_BUSY.ANY",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts cycles the floating point divider or integer divider or both are busy.  Does not imply a stall waiting for either divider."
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json b/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
new file mode 100644
index 000000000000..15376f2cf052
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
@@ -0,0 +1,73 @@
+[
+    {
+        "BriefDescription": "read requests to memory controller. Derived from unc_m_cas_count.rd",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "LLC_MISSES.MEM_READ",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x0f",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "write requests to memory controller. Derived from unc_m_cas_count.wr",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x04",
+        "EventName": "LLC_MISSES.MEM_WRITE",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x30",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Memory controller clock ticks",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventName": "UNC_M_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Pre-charge for reads",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_PRE_COUNT.RD",
+        "PerPkg": "1",
+        "UMask": "0x04",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Pre-charge for writes",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_PRE_COUNT.WR",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Precharge due to read on page miss, write on page miss or PGT",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_PRE_COUNT.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1c",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to page table",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_PRE_COUNT.PGT",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM Precharge commands. : Precharge due to page table : Counts the number of DRAM Precharge commands sent on this channel.",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json b/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
new file mode 100644
index 000000000000..6deff1fe89e3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
@@ -0,0 +1,431 @@
+[
+    {
+        "BriefDescription": "Uncore cache clock ticks",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventName": "UNC_CHA_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . Derived from unc_cha_tor_inserts.ia_miss",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.UNCACHEABLE",
+        "Filter": "config1=0x40e33",
+        "PerPkg": "1",
+        "UMask": "0xC001FE01",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "MMIO reads. Derived from unc_cha_tor_inserts.ia_miss",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.MMIO_READ",
+        "Filter": "config1=0x40040e33",
+        "PerPkg": "1",
+        "UMask": "0xC001FE01",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "MMIO writes. Derived from unc_cha_tor_inserts.ia_miss",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "LLC_MISSES.MMIO_WRITE",
+        "Filter": "config1=0x40041e33",
+        "PerPkg": "1",
+        "UMask": "0xC001FE01",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Streaming stores (full cache line). Derived from unc_cha_tor_inserts.ia_miss",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "LLC_REFERENCES.STREAMING_FULL",
+        "Filter": "config1=0x41833",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0xC001FE01",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Streaming stores (partial cache line). Derived from unc_cha_tor_inserts.ia_miss",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
+        "Filter": "config1=0x41a33",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0xC001FE01",
+        "UMaskExt": "0xC001FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO. Derived from unc_iio_data_req_of_cpu.mem_read.part0",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "LLC_MISSES.PCIE_READ",
+        "FCMask": "0x07",
+        "Filter": "ch_mask=0x1f",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "MetricName": "LLC_MISSES.PCIE_READ",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth writing at IIO. Derived from unc_iio_data_req_of_cpu.mem_write.part0",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "LLC_MISSES.PCIE_WRITE",
+        "FCMask": "0x07",
+        "Filter": "ch_mask=0x1f",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "MetricName": "LLC_MISSES.PCIE_WRITE",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth writing at IIO, part 1",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth writing at IIO, part 2",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth writing at IIO, part 3",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO, part 1",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO, part 2",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO, part 3",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; CRd misses from local IA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts; Code read from local IA that misses in the snoop filter",
+        "UMask": "0xC80FFE01",
+        "UMaskExt": "0xC80FFE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; CRd Pref misses from local IA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts; Code read prefetch from local IA that misses in the snoop filter",
+        "UMask": "0xC88FFE01",
+        "UMaskExt": "0xC88FFE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; DRd Opt misses from local IA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts; Data read opt from local IA that misses in the snoop filter",
+        "UMask": "0xC827FE01",
+        "UMaskExt": "0xC827FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; DRd Opt Pref misses from local IA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts; Data read opt prefetch from local IA that misses in the snoop filter",
+        "UMask": "0xC8A7FE01",
+        "UMaskExt": "0xC8A7FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; RFO misses from local IA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts; Read for ownership from local IA that misses in the snoop filter",
+        "UMask": "0xC807FE01",
+        "UMaskExt": "0xC807FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; RFO pref misses from local IA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts; Read for ownership prefetch from local IA that misses in the snoop filter",
+        "UMask": "0xC887FE01",
+        "UMaskExt": "0xC887FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; WCiL misses from local IA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts; Data read from local IA that misses in the snoop filter",
+        "UMask": "0xC86FFE01",
+        "UMaskExt": "0xC86FFE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts; WCiLF misses from local IA",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts; Data read from local IA that misses in the snoop filter",
+        "UMask": "0xC867FE01",
+        "UMaskExt": "0xC867FE",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Clockticks of the integrated IO (IIO) traffic controller",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x01",
+        "EventName": "UNC_IIO_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Clockticks of the integrated IO (IIO) traffic controller",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "PublicDescription": "Data requested of the CPU : Card reading from DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includes all requests initiated by the Card, including reads and writes. : x16 card plugged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "PublicDescription": "Data requested of the CPU : Card reading from DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includes all requests initiated by the Card, including reads and writes. : x4 card is plugged in to slot 1",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "PublicDescription": "Data requested of the CPU : Card reading from DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includes all requests initiated by the Card, including reads and writes. : x8 card plugged in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "PublicDescription": "Data requested of the CPU : Card reading from DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includes all requests initiated by the Card, including reads and writes. : x4 card is plugged in to slot 3",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "PublicDescription": "Data requested of the CPU : Card writing to DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includes all requests initiated by the Card, including reads and writes. : x16 card plugged in to stack, Or x8 card plugged in to Lane 0/1, Or x4 card is plugged in to slot 0",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "PublicDescription": "Data requested of the CPU : Card writing to DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includes all requests initiated by the Card, including reads and writes. : x4 card is plugged in to slot 1",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "PublicDescription": "Data requested of the CPU : Card writing to DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includes all requests initiated by the Card, including reads and writes. : x8 card plugged in to Lane 2/3, Or x4 card is plugged in to slot 1",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to DRAM",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "PublicDescription": "Data requested of the CPU : Card writing to DRAM : Number of DWs (4 bytes) the card requests of the main die.    Includes all requests initiated by the Card, including reads and writes. : x4 card is plugged in to slot 3",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Clockticks of the IO coherency tracker (IRP)",
+        "Counter": "0,1",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x01",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Clockticks of the IO coherency tracker (IRP)",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Clockticks of the mesh to memory (M2M)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventName": "UNC_M2M_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Clockticks of the mesh to memory (M2M)",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Clockticks of the mesh to PCI (M2P)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventCode": "0x01",
+        "EventName": "UNC_M2P_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Clockticks of the mesh to PCI (M2P)",
+        "Unit": "M2PCIe"
+    },
+    {
+        "BriefDescription": "Clockticks in the UBOX using a dedicated 48-bit Fixed Counter",
+        "Counter": "FIXED",
+        "CounterType": "PGMABLE",
+        "EventCode": "0xff",
+        "EventName": "UNC_U_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Clockticks in the UBOX using a dedicated 48-bit Fixed Counter",
+        "Unit": "UBOX"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json b/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
new file mode 100644
index 000000000000..ea62c092b43f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
@@ -0,0 +1,11 @@
+[
+    {
+        "BriefDescription": "Clockticks of the power control unit (PCU)",
+        "Counter": "0,1,2,3",
+        "CounterType": "PGMABLE",
+        "EventName": "UNC_P_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Clockticks of the power control unit (PCU)",
+        "Unit": "PCU"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json b/tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json
new file mode 100644
index 000000000000..93e407a0f645
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json
@@ -0,0 +1,86 @@
+[
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts page walks completed due to demand data loads (including SW prefetches) whose address translations missed in all TLB levels and were mapped to 4K pages.  The page walks can end with or without a page fault.",
+        "EventCode": "0x08",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Page walk completed due to a demand load to a 4K page."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts page walks completed due to demand data loads (including SW prefetches) whose address translations missed in all TLB levels and were mapped to 2M or 4M pages.  The page walks can end with or without a page fault.",
+        "EventCode": "0x08",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Page walk completed due to a demand load to a 2M or 4M page."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts page walks completed due to demand data stores whose address translations missed in the TLB and were mapped to 4K pages.  The page walks can end with or without a page fault.",
+        "EventCode": "0x49",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Page walk completed due to a demand data store to a 4K page."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts page walks completed due to demand data stores whose address translations missed in the TLB and were mapped to 2M or 4M pages.  The page walks can end with or without a page fault.",
+        "EventCode": "0x49",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Page walk completed due to a demand data store to a 2M or 4M page."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times the machine was unable to find a translation in the Instruction Translation Lookaside Buffer (ITLB) and new translation was filled into the ITLB.  The event is speculative in nature, but will not count translations (page walks) that are begun and not finished, or translations that are finished but not filled into the ITLB.",
+        "EventCode": "0x81",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ITLB.FILLS",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Counts the number of times there was an ITLB miss and a new translation was filled into the ITLB."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts page walks completed due to instruction fetches whose address translations missed in the TLB and were mapped to 4K pages.  The page walks can end with or without a page fault.",
+        "EventCode": "0x85",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Page walk completed due to an instruction fetch in a 4K page."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts page walks completed due to instruction fetches whose address translations missed in the TLB and were mapped to 2M or 4M pages.  The page walks can end with or without a page fault.",
+        "EventCode": "0x85",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
+        "PDIR_COUNTER": "na",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Page walk completed due to an instruction fetch in a 2M or 4M page."
+    }
+]
\ No newline at end of file
-- 
2.21.0

