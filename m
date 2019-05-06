Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B5C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFE32054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEFOUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:20:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:13324 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbfEFOUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:20:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 07:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="171282084"
Received: from otc-icl-cdi187.jf.intel.com ([10.54.55.103])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2019 07:20:18 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 3/3] perf vendor events intel: Add JSON files for Tremontx
Date:   Mon,  6 May 2019 07:19:26 -0700
Message-Id: <20190506141926.13659-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506141926.13659-1-kan.liang@linux.intel.com>
References: <20190506141926.13659-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add V1 event list. This is not a full event list yet, but a short list
for now.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  1 +
 .../pmu-events/arch/x86/tremontx/cache.json   | 52 +++++++++++
 .../pmu-events/arch/x86/tremontx/memory.json  | 26 ++++++
 .../pmu-events/arch/x86/tremontx/other.json   | 26 ++++++
 .../arch/x86/tremontx/pipeline.json           | 91 +++++++++++++++++++
 .../arch/x86/tremontx/uncore-memory.json      | 29 ++++++
 .../arch/x86/tremontx/uncore-other.json       | 40 ++++++++
 .../arch/x86/tremontx/uncore-power.json       |  9 ++
 .../arch/x86/tremontx/virtual-memory.json     | 86 ++++++++++++++++++
 9 files changed, 360 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index f8357a79641a..d9d5f3c7f93f 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -34,4 +34,5 @@ GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55-[01234],v1,skylakex,core
 GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7E,v1,icelake,core
+GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/cache.json b/tools/perf/pmu-events/arch/x86/tremontx/cache.json
new file mode 100644
index 000000000000..1871a46cb6bd
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/cache.json
@@ -0,0 +1,52 @@
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
index 000000000000..865aa68fb6ff
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
@@ -0,0 +1,91 @@
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
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json b/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
new file mode 100644
index 000000000000..c502342115f7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-memory.json
@@ -0,0 +1,29 @@
+[
+    {
+        "BriefDescription": "read requests to memory controller. Derived from unc_m_cas_count.rd",
+        "Counter": "0,1,2,3",
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
+        "EventName": "UNC_M_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json b/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
new file mode 100644
index 000000000000..94fd57151099
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
@@ -0,0 +1,40 @@
+[
+    {
+        "BriefDescription": "Clockticks of the uncore caching and home agent",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_CHA_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Clockticks of the integrated IO (IIO) traffic controller",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_IIO_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Clockticks of the IO coherency tracker (IRP)",
+        "Counter": "0,1",
+        "EventCode": "0x01",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Clockticks of the mesh to memory (M2M)",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_M2M_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Clockticks of the mesh to PCI (M2P)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_M2P_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "M2PCIe"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json b/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
new file mode 100644
index 000000000000..ce693244ab98
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-power.json
@@ -0,0 +1,9 @@
+[
+    {
+        "BriefDescription": "Clockticks of the power control unit (PCU)",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_P_CLOCKTICKS",
+        "PerPkg": "1",
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
2.17.1

