Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E668DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738712189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfH1GA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:00:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:22123 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfH1GA1 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:00:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 23:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="181924766"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2019 23:00:23 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Haiyan Song <haiyanx.song@intel.com>
Subject: [PATCH v1 2/4] perf vendor events intel: Update cascadelakex uncore events to v1.04
Date:   Wed, 28 Aug 2019 13:59:30 +0800
Message-Id: <20190828055932.8269-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828055932.8269-1-yao.jin@linux.intel.com>
References: <20190828055932.8269-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyan Song <haiyanx.song@intel.com>

Signed-off-by: Haiyan Song <haiyanx.song@intel.com>
---
 .../arch/x86/cascadelakex/uncore-memory.json  |  191 ++
 .../arch/x86/cascadelakex/uncore-other.json   | 1809 ++++++++++++++++-
 2 files changed, 1971 insertions(+), 29 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
index 22df833fe032..3fb5cdce842f 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
@@ -73,6 +73,22 @@
         "UMask": "0x8",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Write requests allocated in the PMM Write Pending Queue for Intel Optane DC persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M_PMM_RPQ_INSERTS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write requests allocated in the PMM Write Pending Queue for Intel Optane DC persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE7",
+        "EventName": "UNC_M_PMM_WPQ_INSERTS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Intel Optane DC persistent memory bandwidth read (MB/sec). Derived from unc_m_pmm_rpq_inserts",
         "Counter": "0,1,2,3",
@@ -102,6 +118,15 @@
         "ScaleUnit": "6.103515625E-5MB/sec",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Read Pending Queue Occupancy of all read requests for Intel Optane DC persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Intel Optane DC persistent memory read latency (ns). Derived from unc_m_pmm_rpq_occupancy.all",
         "Counter": "0,1,2,3",
@@ -113,5 +138,171 @@
         "ScaleUnit": "6000000000ns",
         "UMask": "0x1",
         "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Page Activate commands sent due to a write request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_M_ACT_COUNT.WR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts DRAM Page Activate commands sent on this channel due to a write request to the iMC (Memory Controller).  Activate commands are issued to open up a page on the DRAM devices so that it can be read or written to with a CAS (Column Access Select) command.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "All DRAM CAS Commands issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts all CAS (Column Address Select) commands issued to DRAM per memory channel.  CAS commands are issued to specify the address to read or write on DRAM, so this event increments for every read and write. This event counts whether AutoPrecharge (which closes the DRAM Page automatically after a read/write) is enabled or not.",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "All DRAM Read CAS Commands issued (does not include underfills)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_REG",
+        "PerPkg": "1",
+        "PublicDescription": "Counts CAS (Column Access Select) regular read commands issued to DRAM on a per channel basis.  CAS commands are issued to specify the address to read or write on DRAM, and this event increments for every regular read.  This event only counts regular reads and does not includes underfill reads due to partial write requests.  This event counts whether AutoPrecharge (which closes the DRAM Page automatically after a read/write)  is enabled or not.",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Underfill Read CAS Commands issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts CAS (Column Access Select) underfill read commands issued to DRAM due to a partial write, on a per channel basis.  CAS commands are issued to specify the address to read or write on DRAM, and this command counts underfill reads.  Partial writes must be completed by first reading in the underfill from DRAM and then merging in the partial write data before writing the full line back to DRAM. This event will generally count about the same as the number of partial writes, but may be slightly less because of partials hitting in the WPQ (due to a previous write request).",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM CAS (Column Address Strobe) Commands.; DRAM WR_CAS (w/ and w/out auto-pre) in Write Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.WR_WMM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number or DRAM Write CAS commands issued on this channel while in Write-Major-Mode.",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "All commands for Intel Optane DC persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xEA",
+        "EventName": "UNC_M_PMM_CMD1.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "All commands for Intel Optane DC persistent memory",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Regular reads(RPQ) commands for Intel Optane DC persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xEA",
+        "EventName": "UNC_M_PMM_CMD1.RD",
+        "PerPkg": "1",
+        "PublicDescription": "All Reads - RPQ or Ufill",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Underfill read commands for Intel Optane DC persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xEA",
+        "EventName": "UNC_M_PMM_CMD1.UFILL_RD",
+        "PerPkg": "1",
+        "PublicDescription": "Underfill reads",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write commands for Intel Optane DC persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xEA",
+        "EventName": "UNC_M_PMM_CMD1.WR",
+        "PerPkg": "1",
+        "PublicDescription": "Writes",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Occupancy of all write requests for Intel Optane DC persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE4",
+        "EventName": "UNC_M_PMM_WPQ_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Write Pending Queue Occupancy of all write requests for Intel Optane DC persistent memory",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of read requests allocated into the Read Pending Queue (RPQ).  This queue is used to schedule reads out to the memory controller and to track the requests.  Requests allocate into the RPQ soon after they enter the memory controller, and need credits for an entry in this buffer before being sent from the CHA to the iMC.  The requests deallocate after the read CAS command has been issued to DRAM.  This event counts both Isochronous and non-Isochronous requests which were issued to the RPQ.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_M_RPQ_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries in the Read Pending Queue (RPQ) at each cycle.  This can then be used to calculate both the average occupancy of the queue (in conjunction with the number of cycles not empty) and the average latency in the queue (in conjunction with the number of allocations).  The RPQ is used to schedule reads out to the memory controller and to track the requests.  Requests allocate into the RPQ soon after they enter the memory controller, and need credits for an entry in this buffer before being sent from the CHA to the iMC. They deallocate from the RPQ after the CAS command has been issued to memory.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "All hits to Near Memory(DRAM cache) in Memory Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD3",
+        "EventName": "UNC_M_TAGCHK.HIT",
+        "PerPkg": "1",
+        "PublicDescription": "Tag Check; Hit",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "All Clean line misses to Near Memory(DRAM cache) in Memory Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD3",
+        "EventName": "UNC_M_TAGCHK.MISS_CLEAN",
+        "PerPkg": "1",
+        "PublicDescription": "Tag Check; Clean",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "All dirty line misses to Near Memory(DRAM cache) in Memory Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD3",
+        "EventName": "UNC_M_TAGCHK.MISS_DIRTY",
+        "PerPkg": "1",
+        "PublicDescription": "Tag Check; Dirty",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_WPQ_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of writes requests allocated into the Write Pending Queue (WPQ).  The WPQ is used to schedule writes out to the memory controller and to track the requests.  Requests allocate into the WPQ soon after they enter the memory controller, and need credits for an entry in this buffer before being sent from the CHA to the iMC (Memory Controller).  The write requests deallocate after being issued to DRAM.  Write requests themselves are able to complete (from the perspective of the rest of the system) as soon they have 'posted' to the iMC.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x81",
+        "EventName": "UNC_M_WPQ_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries in the Write Pending Queue (WPQ) at each cycle.  This can then be used to calculate both the average queue occupancy (in conjunction with the number of cycles not empty) and the average latency (in conjunction with the number of allocations).  The WPQ is used to schedule writes out to the memory controller and to track the requests.  Requests allocate into the WPQ soon after they enter the memory controller, and need credits for an entry in this buffer before being sent from the CHA to the iMC (memory controller).  They deallocate after being issued to DRAM.  Write requests themselves are able to complete (from the perspective of the rest of the system) as soon they have 'posted' to the iMC.  This is not to be confused with actually performing the write to DRAM.  Therefore, the average latency for this queue is actually not useful for deconstruction intermediate write latencies.  So, we provide filtering based on if the requ
 est has posted or not.  By using the 'not posted' filter, we can track how long writes spent in the iMC before completions were sent to the HA.  The 'posted' filter, on the other hand, provides information about how much queueing is actually happenning in the iMC for writes before they are actually issued to memory.  High average occupancies will generally coincide with high write major mode counts. Is there a filter of sorts???",
+        "Unit": "iMC"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
index cab355872dff..c14276f9021d 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
@@ -119,7 +119,7 @@
         "EventName": "UPI_DATA_BANDWIDTH_TX",
         "PerPkg": "1",
         "ScaleUnit": "7.11E-06Bytes",
-        "UMask": "0x0F",
+        "UMask": "0xf",
         "Unit": "UPI LL"
     },
     {
@@ -152,20 +152,6 @@
         "UMask": "0x01",
         "Unit": "IIO"
     },
-    {
-        "BriefDescription": "PCI Express bandwidth writing at IIO, part 0",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
-        "FCMask": "0x07",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
-        "MetricName": "LLC_MISSES.PCIE_WRITE",
-        "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x01",
-        "Unit": "IIO"
-    },
     {
         "BriefDescription": "PCI Express bandwidth writing at IIO, part 1",
         "Counter": "0,1",
@@ -202,20 +188,6 @@
         "UMask": "0x01",
         "Unit": "IIO"
     },
-    {
-        "BriefDescription": "PCI Express bandwidth reading at IIO, part 0",
-        "Counter": "0,1",
-        "EventCode": "0x83",
-        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
-        "FCMask": "0x07",
-        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
-        "MetricName": "LLC_MISSES.PCIE_READ",
-        "PerPkg": "1",
-        "PortMask": "0x01",
-        "ScaleUnit": "4Bytes",
-        "UMask": "0x04",
-        "Unit": "IIO"
-    },
     {
         "BriefDescription": "PCI Express bandwidth reading at IIO, part 1",
         "Counter": "0,1",
@@ -251,5 +223,1784 @@
         "ScaleUnit": "4Bytes",
         "UMask": "0x04",
         "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; Multiple Core Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.CORE_GTONE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that trigger a configurable number of cross snoops.  Cores are snooped if the transaction looks up the cache and determines that it is necessary based on the operation type and what CoreValid bits are set.  For example, if 2 CV bits are set on a data read, the cores must have the data in S state so it is not necessary to snoop them.  However, if only 1 CV bit is set the core my have modified the data.  If the transaction was an RFO, it would need to invalidate the lines.  This event can be filtered based on who triggered the initial snoop(s).",
+        "UMask": "0x42",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Core Cross Snoops Issued; Multiple Eviction",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_CHA_CORE_SNP.EVICT_GTONE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that trigger a configurable number of cross snoops.  Cores are snooped if the transaction looks up the cache and determines that it is necessary based on the operation type and what CoreValid bits are set.  For example, if 2 CV bits are set on a data read, the cores must have the data in S state so it is not necessary to snoop them.  However, if only 1 CV bit is set the core my have modified the data.  If the transaction was an RFO, it would need to invalidate the lines.  This event can be filtered based on who triggered the initial snoop(s).",
+        "UMask": "0x82",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory state lookups; Snoop Not Needed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts transactions that looked into the multi-socket cacheline Directory state, and therefore did not send a snoop because the Directory indicated it was not needed",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory state lookups; Snoop Needed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts  transactions that looked into the multi-socket cacheline Directory state, and sent one or more snoops, because the Directory indicated it was needed",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory state updates; Directory Updated memory write from the HA pipe",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.HA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts only multi-socket cacheline Directory state updates memory writes issued from the HA pipe. This does not include memory write requests which are for I (Invalid) or E (Exclusive) cachelines.",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory state updates; Directory Updated memory write from TOR pipe",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.TOR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts only multi-socket cacheline Directory state updates due to memory writes issued from the TOR pipe which are the result of remote transaction hitting the SF/LLC and returning data Core2Core. This does not include memory write requests which are for I (Invalid) or E (Exclusive) cachelines.",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FaST wire asserted; Horizontal",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA5",
+        "EventName": "UNC_CHA_FAST_ASSERTED.HORZ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles either the local or incoming distress signals are asserted.  Incoming distress includes up, dn and across.",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read request from a remote socket which hit in the HitMe Cache to a line In the E state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5F",
+        "EventName": "UNC_CHA_HITME_HIT.EX_RDS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts read requests from a remote socket which hit in the HitME cache (used to cache the multi-socket Directory state) to a line in the E(Exclusive) state.  This includes the following read opcodes (RdCode, RdData, RdDataMigratory, RdCur, RdInv*, Inv*)",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Normal priority reads issued to the memory controller from the CHA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_IMC_READS_COUNT.NORMAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when a normal (Non-Isochronous) read is issued to any of the memory controller channels from the CHA.",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued; Full Line Non-ISOCH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5B",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when a normal (Non-Isochronous) full line write is issued from the CHA to the any of the memory controller channels.",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Lines in E state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of lines that were victimized on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Lines in F State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_F",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of lines that were victimized on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Lines in M state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of lines that were victimized on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Lines in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of lines that were victimized on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Number of times that an RFO hit in S state.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.RFO_HIT_S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when a RFO (the Read for Ownership issued before a  write) request hit a cacheline in the S (Shared) state.",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Local requests for exclusive ownership of a cache line  without receiving data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of requests coming from a unit on this socket for exclusive ownership of a cache line without receiving data (INVITOE) to the CHA.",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Local requests for exclusive ownership of a cache line without receiving data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of requests coming from a remote socket for exclusive ownership of a cache line without receiving data (INVITOE) to the CHA.",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations; IRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.IRQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into the specified Ingress queue.",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Request Queue Rejects; PhyAddr Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
+        "PerPkg": "1",
+        "PublicDescription": "Ingress (from CMS) Request Queue Rejects; PhyAddr Match",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Occupancy; IRQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_CHA_RxC_OCCUPANCY.IRQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of entries in the specified Ingress queue in each cycle.",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop filter capacity evictions for E-state entries.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3D",
+        "EventName": "UNC_CHA_SF_EVICTION.E_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts snoop filter capacity evictions for entries tracking exclusive lines in the cores cache. Snoop filter capacity evictions occur when the snoop filter is full and evicts an existing entry to track a new entry. Does not count clean evictions such as when a cores cache replaces a tracked cacheline with a new cacheline.",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop filter capacity evictions for M-state entries.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3D",
+        "EventName": "UNC_CHA_SF_EVICTION.M_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts snoop filter capacity evictions for entries tracking modified lines in the cores cache. Snoop filter capacity evictions occur when the snoop filter is full and evicts an existing entry to track a new entry. Does not count clean evictions such as when a cores cache replaces a tracked cacheline with a new cacheline.",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Snoop filter capacity evictions for S-state entries.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3D",
+        "EventName": "UNC_CHA_SF_EVICTION.S_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts snoop filter capacity evictions for entries tracking shared lines in the cores cache. Snoop filter capacity evictions occur when the snoop filter is full and evicts an existing entry to track a new entry. Does not count clean evictions such as when a cores cache replaces a tracked cacheline with a new cacheline.",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RspCnflct* Snoop Responses Received",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSPCNFLCTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when a a transaction with the opcode type RspCnflct* Snoop Response was received. This is returned when a snoop finds an existing outstanding transaction in a remote caching agent. This triggers conflict resolution hardware. This covers both the opcode RspCnflct and RspCnflctWbI.",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RspI Snoop Responses Received",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSPI",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when a transaction with the opcode type RspI Snoop Response was received which indicates the remote cache does not have the data, or when the remote cache silently evicts data (such as when an RFO: the Read for Ownership issued before a write hits non-modified data).",
+        "UMask": "0x01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RspIFwd Snoop Responses Received",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSPIFWD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when a a transaction with the opcode type RspIFwd Snoop Response was received which indicates a remote caching agent forwarded the data and the requesting agent is able to acquire the data in E (Exclusive) or M (modified) states.  This is commonly returned with RFO (the Read for Ownership issued before a write) transactions.  The snoop could have either been to a cacheline in the M,E,F (Modified, Exclusive or Forward)  states.",
+        "UMask": "0x04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RspSFwd Snoop Responses Received",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSPSFWD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when a a transaction with the opcode type RspSFwd Snoop Response was received which indicates a remote caching agent forwarded the data but held on to its current copy.  This is common for data and code reads that hit in a remote socket in E (Exclusive) or F (Forward) state.",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Rsp*Fwd*WB Snoop Responses Received",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when a transaction with the opcode type Rsp*Fwd*WB Snoop Response was received which indicates the data was written back to it's home socket, and the cacheline was forwarded to the requestor socket.  This snoop response is only used in >= 4 socket systems.  It is used when a snoop HITM's in a remote caching agent and it directly forwards data to a requestor, and simultaneously returns data to it's home socket to be written back to memory.",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Rsp*WB Snoop Responses Received",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5C",
+        "EventName": "UNC_CHA_SNOOP_RESP.RSP_WBWB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when a transaction with the opcode type Rsp*WB Snoop Response was received which indicates which indicates the data was written back to it's home.  This is returned when a non-RFO request hits a cacheline in the Modified state. The Cache can either downgrade the cacheline to a S (Shared) or I (Invalid) state depending on how the system has been configured.  This reponse will also be sent when a cache requests E (Exclusive) ownership of a cache line without receiving data, because the cache must acquire ownership.",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
+        "Filter": "config1=0x40233",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
+        "Filter": "config1=0x40433",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
+        "Filter": "config1=0x4b233",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
+        "Filter": "config1=0x4b433",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefRFO",
+        "Filter": "config1=0x4b033",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
+        "Filter": "config1=0x40033",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
+        "Filter": "config1=0x40233",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD",
+        "Filter": "config1=0x40433",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
+        "Filter": "config1=0x4b233",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
+        "Filter": "config1=0x4b433",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
+        "Filter": "config1=0x4b033",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
+        "Filter": "config1=0x40033",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
+        "Filter": "config1=0x40233",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
+        "Filter": "config1=0x40433",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
+        "Filter": "config1=0x4b233",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
+        "Filter": "config1=0x4b433",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
+        "Filter": "config1=0x4b033",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
+        "Filter": "config1=0x40033",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
+        "Filter": "config1=0x40233",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD",
+        "Filter": "config1=0x40433",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
+        "Filter": "config1=0x4b233",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
+        "Filter": "config1=0x4b433",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
+        "Filter": "config1=0x4b033",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
+        "Filter": "config1=0x40033",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Clockticks of the IIO Traffic Controller",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_IIO_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts clockticks of the 1GHz trafiic controller clock in the IIO unit.",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for 4 bytes made by the CPU to IIO Part0",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every read request for 4 bytes of data made by a unit on the main die (generally a core) or by another IIO unit to the MMIO space of a card on IIO Part0. In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for 4 bytes made by the CPU to IIO Part1",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every read request for 4 bytes of data made by a unit on the main die (generally a core) or by another IIO unit to the MMIO space of a card on IIO Part1. In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for 4 bytes made by the CPU to IIO Part2",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every read request for 4 bytes of data made by a unit on the main die (generally a core) or by another IIO unit to the MMIO space of a card on IIO Part2. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for 4 bytes made by the CPU to IIO Part3",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every read request for 4 bytes of data made by a unit on the main die (generally a core) or by another IIO unit to the MMIO space of a card on IIO Part3. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to  any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of 4 bytes made to IIO Part0 by the CPU",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every write request of 4 bytes of data made to the MMIO space of a card on IIO Part0 by a unit on the main die (generally a core) or by another IIO unit. In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of 4 bytes made to IIO Part1 by the CPU",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every write request of 4 bytes of data made to the MMIO space of a card on IIO Part1 by a unit on the main die (generally a core) or by another IIO unit. In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of 4 bytes made to IIO Part2 by the CPU",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every write request of 4 bytes of data made to the MMIO space of a card on IIO Part2 by  a unit on the main die (generally a core) or by another IIO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of 4 bytes made to IIO Part3 by the CPU",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every write request of 4 bytes of data made to the MMIO space of a card on IIO Part3 by  a unit on the main die (generally a core) or by another IIO unit. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by a different IIO unit to IIO Part0",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts ever peer to peer read request for 4 bytes of data made by a different IIO unit to the MMIO space of a card on IIO Part0. Does not include requests made by the same IIO unit. In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by a different IIO unit to IIO Part1",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts ever peer to peer read request for 4 bytes of data made by a different IIO unit to the MMIO space of a card on IIO Part1. Does not include requests made by the same IIO unit. In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by a different IIO unit to IIO Part2",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts ever peer to peer read request for 4 bytes of data made by a different IIO unit to the MMIO space of a card on IIO Part2. Does not include requests made by the same IIO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by a different IIO unit to IIO Part3",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts ever peer to peer read request for 4 bytes of data made by a different IIO unit to the MMIO space of a card on IIO Part3. Does not include requests made by the same IIO unit. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to  any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made to IIO Part0 by a different IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every peer to peer write request of 4 bytes of data made to the MMIO space of a card on IIO Part0 by a different IIO unit. Does not include requests made by the same IIO unit.  In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made to IIO Part1 by a different IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every peer to peer write request of 4 bytes of data made to the MMIO space of a card on IIO Part1 by a different IIO unit. Does not include requests made by the same IIO unit. In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made to IIO Part2 by a different IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every peer to peer write request of 4 bytes of data made to the MMIO space of a card on IIO Part2 by a different IIO unit. Does not include requests made by the same IIO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made to IIO Part3 by a different IIO unit",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every peer to peer write request of 4 bytes of data made to the MMIO space of a card on IIO Part3 by a different IIO unit. Does not include requests made by the same IIO unit. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by IIO Part0 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every peer to peer read request for 4 bytes of data made by IIO Part0 to the MMIO space of an IIO target. In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by IIO Part1 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every peer to peer read request for 4 bytes of data made by IIO Part1 to the MMIO space of an IIO target. In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by IIO Part2 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every peer to peer read request for 4 bytes of data made by IIO Part2 to the MMIO space of an IIO target. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for 4 bytes made by IIO Part3 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every peer to peer read request for 4 bytes of data made by IIO Part3 to the MMIO space of an IIO target. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made by IIO Part0 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every peer to peer write request of 4 bytes of data made by IIO Part0 to the MMIO space of an IIO target. In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made by IIO Part0 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every peer to peer write request of 4 bytes of data made by IIO Part1 to the MMIO space of an IIO target. In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made by IIO Part0 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every peer to peer write request of 4 bytes of data made by IIO Part2 to the MMIO space of an IIO target. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of 4 bytes made by IIO Part0 to an IIO target",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every peer to peer write request of 4 bytes of data made by IIO Part3 to the MMIO space of an IIO target. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to  any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction is made by the CPU to IIO Part0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every read request for up to a 64 byte transaction of data made by a unit on the main die (generally a core) or by another IIO unit to the MMIO space of a card on IIO Part0. In the general case, part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction is made by the CPU to IIO Part1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every read request for up to a 64 byte transaction of data made by a unit on the main die (generally a core) or by another IIO unit to the MMIO space of a card on IIO Part1. In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction is made by the CPU to IIO Part2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every read request for up to a 64 byte transaction of data made by a unit on the main die (generally a core) or by another IIO unit to the MMIO space of a card on IIO Part2. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction is made by the CPU to IIO Part3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every read request for up to a 64 byte transaction of data made by a unit on the main die (generally a core) or by another IIO unit to the MMIO space of a card on IIO Part3. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to  any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction is made to IIO Part0 by the CPU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every write request of up to a 64 byte transaction of data made to the MMIO space of a card on IIO Part0 by a unit on the main die (generally a core) or by another IIO unit. In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction is made to IIO Part1 by the CPU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every write request of up to a 64 byte transaction of data made to the MMIO space of a card on IIO Part1 by a unit on the main die (generally a core) or by another IIO unit. In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction is made to IIO Part2 by the CPU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every write request of up to a 64 byte transaction of data made to the MMIO space of a card on IIO Part2 by a unit on the main die (generally a core) or by another IIO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction is made to IIO Part3 by the CPU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every write request of up to a 64 byte transaction of data made to the MMIO space of a card on IIO Part3 by a unit on the main die (generally a core) or by another IIO unit. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to  any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for up to a 64 byte transaction is made by a different IIO unit to IIO Part0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every peer to peer read request for up to a 64 byte transaction of data made by a different IIO unit to the MMIO space of a card on IIO Part0. Does not include requests made by the same IIO unit. In the general case, part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for up to a 64 byte transaction is made by a different IIO unit to IIO Part1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every peer to peer read request for up to a 64 byte transaction of data made by a different IIO unit to the MMIO space of a card on IIO Part1. Does not include requests made by the same IIO unit. In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for up to a 64 byte transaction is made by a different IIO unit to IIO Part2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every peer to peer read request for up to a 64 byte transaction of data made by a different IIO unit to the MMIO space of a card on IIO Part2. Does not include requests made by the same IIO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request for up to a 64 byte transaction is made by a different IIO unit to IIO Part3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every peer to peer read request for up to a 64 byte transaction of data made by a different IIO unit to the MMIO space of a card on IIO Part3. Does not include requests made by the same IIO unit. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to  any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte transaction is made to IIO Part0 by a different IIO unit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every peer to peer write request of up to a 64 byte transaction of data made to the MMIO space of a card on IIO Part0 by a different IIO unit. Does not include requests made by the same IIO unit. In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte transaction is made to IIO Part1 by a different IIO unit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every peer to peer write request of up to a 64 byte transaction of data made to the MMIO space of a card on IIO Part1 by a different IIO unit. Does not include requests made by the same IIO unit. In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte transaction is made to IIO Part2 by a different IIO unit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every peer to peer write request of up to a 64 byte transaction of data made to the MMIO space of a card on IIO Part2 by a different IIO unit. Does not include requests made by the same IIO unit. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte transaction is made to IIO Part3 by a different IIO unit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "Filter": "fc, chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every peer to peer write request of up to a 64 byte transaction of data made to the MMIO space of a card on IIO Part3 by a different IIO unit. Does not include requests made by the same IIO unit. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to  any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction is made by IIO Part0 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every read request for up to a 64 byte transaction of data made by IIO Part0 to a unit on the main die (generally memory). In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction is  made by IIO Part1 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every read request for up to a 64 byte transaction of data made by IIO Part1 to a unit on the main die (generally memory). In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction is made by IIO Part2 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every read request for up to a 64 byte transaction of data made by IIO Part2 to a unit on the main die (generally memory). In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Read request for up to a 64 byte transaction is made by IIO Part3 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every read request for up to a 64 byte transaction of data made by IIO Part3 to a unit on the main die (generally memory). In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to  any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction is made by IIO Part0 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every write request of up to a 64 byte transaction of data made by IIO Part0 to a unit on the main die (generally memory). In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction is made by IIO Part1 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every write request of up to a 64 byte transaction of data made by IIO Part1 to a unit on the main die (generally memory). In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction is made by IIO Part2 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every write request of up to a 64 byte transaction of data made by IIO Part2 to a unit on the main die (generally memory). In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Write request of up to a 64 byte transaction is made by IIO Part3 to Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every write request of up to a 64 byte transaction of data made by IIO Part3 to a unit on the main die (generally memory). In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to  any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request of up to a 64 byte transaction is made by IIO Part0 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART0",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every peer to peer read request of up to a 64 byte transaction made by IIO Part0 to the MMIO space of an IIO target. In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request of up to a 64 byte transaction is made by IIO Part1 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART1",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every peer to peer read request of up to a 64 byte transaction made by IIO Part1 to the MMIO space of an IIO target. In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request of up to a 64 byte transaction is made by IIO Part2 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART2",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every peer to peer read request of up to a 64 byte transaction made by IIO Part2 to the MMIO space of an IIO target. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer read request of up to a 64 byte transaction is made by IIO Part3 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART3",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every peer to peer read request of up to a 64 byte transaction made by IIO Part3 to the MMIO space of an IIO target. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x08",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte transaction is made by IIO Part0 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "PublicDescription": "Counts every peer to peer write request of up to a 64 byte transaction of data made by IIO Part0 to the MMIO space of an IIO target. In the general case, Part0 refers to a standard PCIe card of any size (x16,x8,x4) that is plugged directly into one of the PCIe slots. Part0 could also refer to any device plugged into the first slot of a PCIe riser card or to a device attached to the IIO unit which starts its use of the bus using lane 0 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte transaction is made by IIO Part1 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "PublicDescription": "Counts every peer to peer write request of up to a 64 byte transaction of data made by IIO Part1 to the MMIO space of an IIO target.In the general case, Part1 refers to a x4 PCIe card plugged into the second slot of a PCIe riser card, but it could refer to any x4 device attached to the IIO unit using lanes starting at lane 4 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte transaction is made by IIO Part2 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "PublicDescription": "Counts every peer to peer write request of up to a 64 byte transaction of data made by IIO Part2 to the MMIO space of an IIO target. In the general case, Part2 refers to a x4 or x8 PCIe card plugged into the third slot of a PCIe riser card, but it could refer to any x4 or x8 device attached to the IIO unit and using lanes starting at lane 8 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Peer to peer write request of up to a 64 byte transaction is made by IIO Part3 to an IIO target",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
+        "FCMask": "0x07",
+        "Filter": "chnl",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "PublicDescription": "Counts every peer to peer write request of up to a 64 byte transaction of data made by IIO Part3 to the MMIO space of an IIO target. In the general case, Part3 refers to a x4 PCIe card plugged into the fourth slot of a PCIe riser card, but it could brefer to  any device attached to the IIO unit using the lanes starting at lane 12 of the 16 lanes supported by the bus.",
+        "UMask": "0x02",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Traffic in which the M2M to iMC Bypass was not taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M2M_BYPASS_M2M_Egress.NOT_TAKEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts traffic in which the M2M (Mesh to Memory) to iMC (Memory Controller) bypass was not taken",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles when direct to core mode (which bypasses the CHA) was disabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M2M_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles when direct to core mode (which bypasses the CHA) was disabled",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages sent direct to core (bypassing the CHA)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_M2M_DIRECT2CORE_TAKEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when messages were sent direct to core (bypassing the CHA)",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number of reads in which direct to core transaction were overridden",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_M2M_DIRECT2CORE_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts reads in which direct to core transactions (which would have bypassed the CHA) were overridden",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number of reads in which direct to Intel UPI transactions were overridden",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts reads in which direct to Intel Ultra Path Interconnect (UPI) transactions (which would have bypassed the CHA) were overridden",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Cycles when direct to Intel UPI was disabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_M2M_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles when the ability to send messages direct to the Intel Ultra Path Interconnect (bypassing the CHA) was disabled",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Messages sent direct to the Intel UPI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_M2M_DIRECT2UPI_TAKEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when messages were sent direct to the Intel Ultra Path Interconnect (bypassing the CHA)",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Number of reads that a message sent direct2 Intel UPI was overridden",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_M2M_DIRECT2UPI_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when a read message that was sent direct to the Intel Ultra Path Interconnect (bypassing the CHA) was overridden",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory lookups (any state found)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks into the multi-socket cacheline Directory state, and found the cacheline marked in Any State (A, I, S or unused)",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory lookups (cacheline found in A state)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_A",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks into the multi-socket cacheline Directory state, and found the cacheline marked in the A (SnoopAll) state, indicating the cacheline is stored in another socket in any state, and we must snoop the other sockets to make sure we get the latest data.  The data may be stored in any state in the local socket.",
+        "UMask": "0x8",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory lookup (cacheline found in I state)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_I",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks into the multi-socket cacheline Directory state , and found the cacheline marked in the I (Invalid) state indicating the cacheline is not stored in another socket, and so there is no need to snoop the other sockets for the latest data.  The data may be stored in any state in the local socket.",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory lookup (cacheline found in S state)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_M2M_DIRECTORY_LOOKUP.STATE_S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) looks into the multi-socket cacheline Directory state , and found the cacheline marked in the S (Shared) state indicating the cacheline is either stored in another socket in the S(hared) state , and so there is no need to snoop the other sockets for the latest data.  The data may be stored in any state in the local socket.",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from A to I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2I",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates the multi-socket cacheline Directory state from from A (SnoopAll) to I (Invalid)",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from A to S",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.A2S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates the multi-socket cacheline Directory state from from A (SnoopAll) to S (Shared)",
+        "UMask": "0x40",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from/to Any state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates the multi-socket cacheline Directory to a new state",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from I to A",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2A",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates the multi-socket cacheline Directory state from from I (Invalid) to A (SnoopAll)",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from I to S",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.I2S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates the multi-socket cacheline Directory state from from I (Invalid) to S (Shared)",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from S to A",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2A",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates the multi-socket cacheline Directory state from from S (Shared) to A (SnoopAll)",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Multi-socket cacheline Directory update from S to I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_M2M_DIRECTORY_UPDATE.S2I",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) updates the multi-socket cacheline Directory state from from S (Shared) to I (Invalid)",
+        "UMask": "0x8",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Reads to iMC issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) issues reads to the iMC (Memory Controller).",
+        "UMask": "0x4",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Reads to iMC issued at Normal Priority (Non-Isochronous)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.NORMAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) issues reads to the iMC (Memory Controller).  It only counts  normal priority non-isochronous reads.",
+        "UMask": "0x1",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Read requests to Intel Optane DC persistent memory issued to the iMC from M2M",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_M2M_IMC_READS.TO_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "M2M Reads Issued to iMC; All, regardless of priority.",
+        "UMask": "0x8",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Writes to iMC issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) issues writes to the iMC (Memory Controller).",
+        "UMask": "0x10",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "M2M Writes Issued to iMC; All, regardless of priority.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.NI",
+        "PerPkg": "1",
+        "PublicDescription": "M2M Writes Issued to iMC; All, regardless of priority.",
+        "UMask": "0x80",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Partial Non-Isochronous writes to the iMC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.PARTIAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) issues partial writes to the iMC (Memory Controller).  It only counts normal priority non-isochronous writes.",
+        "UMask": "0x2",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Write requests to Intel Optane DC persistent memory issued to the iMC from M2M",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_M2M_IMC_WRITES.TO_PMM",
+        "PerPkg": "1",
+        "PublicDescription": "M2M Writes Issued to iMC; All, regardless of priority.",
+        "UMask": "0x20",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefecth requests that got turn into a demand request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_M2M_PREFCAM_DEMAND_PROMOTIONS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) promotes a outstanding request in the prefetch queue due to a subsequent demand read request that entered the M2M with the same address.  Explanatory Side Note: The Prefecth queue is made of CAM (Content Addressable Memory)",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Inserts into the Memory Controller Prefetch Queue",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x57",
+        "EventName": "UNC_M2M_PREFCAM_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the M2M (Mesh to Memory) recieves a prefetch request and inserts it into its outstanding prefetch queue.  Explanatory Side Note: the prefect queue is made from CAM: Content Addressable Memory",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Ingress (from CMS) Queue Inserts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_M2M_RxC_AD_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the a new entry is Received(RxC) and then added to the AD (Address Ring) Ingress Queue from the CMS (Common Mesh Stop).  This is generally used for reads, and",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Ingress (from CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M2M_RxC_AD_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "AD Ingress (from CMS) Occupancy",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Ingress (from CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_M2M_RxC_BL_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "BL Ingress (from CMS) Allocations",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Ingress (from CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_M2M_RxC_BL_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "BL Ingress (from CMS) Occupancy",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Dirty line read hits(Regular and RFO) to Near Memory(DRAM cache) in Memory Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_M2M_TAG_HIT.NM_RD_HIT_DIRTY",
+        "PerPkg": "1",
+        "PublicDescription": "Tag Hit; Read Hit from NearMem, Dirty  Line",
+        "UMask": "0x02",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Clean line underfill read hits to Near Memory(DRAM cache) in Memory Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_M2M_TAG_HIT.NM_UFILL_HIT_CLEAN",
+        "PerPkg": "1",
+        "PublicDescription": "Tag Hit; Underfill Rd Hit from NearMem, Clean Line",
+        "UMask": "0x04",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Dirty line underfill read hits to Near Memory(DRAM cache) in Memory Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_M2M_TAG_HIT.NM_UFILL_HIT_DIRTY",
+        "PerPkg": "1",
+        "PublicDescription": "Tag Hit; Underfill Rd Hit from NearMem, Dirty  Line",
+        "UMask": "0x08",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_M2M_TxC_AD_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress (to CMS) Allocations",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "AD Egress (to CMS) Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_M2M_TxC_AD_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress (to CMS) Occupancy",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_M2M_TxC_BL_INSERTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress (to CMS) Allocations; All",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "BL Egress (to CMS) Occupancy; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_M2M_TxC_BL_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress (to CMS) Occupancy; All",
+        "UMask": "0x03",
+        "Unit": "M2M"
+    },
+    {
+        "BriefDescription": "Prefetches generated by the flow control queue of the M3UPI unit.",
+        "Counter": "0,1,2",
+        "EventCode": "0x29",
+        "EventName": "UNC_M3UPI_UPI_PREFETCH_SPAWN",
+        "PerPkg": "1",
+        "PublicDescription": "Count cases where flow control queue that sits between the Intel Ultra Path Interconnect (UPI) and the mesh spawns a prefetch to the iMC (Memory Controller)",
+        "Unit": "M3UPI"
+    },
+    {
+        "BriefDescription": "Clocks of the Intel Ultra Path Interconnect (UPI)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_UPI_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts clockticks of the fixed frequency clock controlling the Intel Ultra Path Interconnect (UPI).  This clock runs at1/8th the 'GT/s' speed of the UPI link.  For example, a  9.6GT/s  link will have a fixed Frequency of 1.2 Ghz.",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Data Response packets that go direct to core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2C",
+        "PerPkg": "1",
+        "PublicDescription": "Counts Data Response (DRS) packets that attempted to go direct to core bypassing the CHA.",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Data Response packets that go direct to Intel UPI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2U",
+        "PerPkg": "1",
+        "PublicDescription": "Counts Data Response (DRS) packets that attempted to go direct to Intel Ultra Path Interconnect (UPI) bypassing the CHA .",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Cycles Intel UPI is in L1 power mode (shutdown)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_UPI_L1_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles when the Intel Ultra Path Interconnect (UPI) is in L1 power mode.  L1 is a mode that totally shuts down the UPI link.  Link power states are per link and per direction, so for example the Tx direction could be in one state while Rx was in another, this event only coutns when both links are shutdown.",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Cycles the Rx of the Intel UPI is in L0p power mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_UPI_RxL0P_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles when the the receive side (Rx) of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode where we disable 60% of the UPI lanes, decreasing our bandwidth in order to save power.",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "FLITs received which bypassed the Slot0 Receive Buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot0 RxQ buffer (Receive Queue) and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
+        "UMask": "0x1",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "FLITs received which bypassed the Slot0 Receive Buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the slot1 RxQ buffer  (Receive Queue) and passed directly across the BGF and into the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "FLITs received which bypassed the Slot0 Recieve Buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_UPI_RxL_BYPASSED.SLOT2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts incoming FLITs (FLow control unITs) whcih bypassed the slot2 RxQ buffer (Receive Queue)  and passed directly to the Egress.  This is a latency optimization, and should generally be the common case.  If this value is less than the number of FLITs transfered, it implies that there was queueing getting onto the ring, and thus the transactions saw higher latency.",
+        "UMask": "0x4",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid data FLITs received from any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts valid data FLITs  (80 bit FLow control unITs: 64bits of data) received from any of the 3 Intel Ultra Path Interconnect (UPI) Receive Queue slots on this UPI unit.",
+        "UMask": "0x0F",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Null FLITs received from any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts null FLITs (80 bit FLow control unITs) received from any of the 3 Intel Ultra Path Interconnect (UPI) Receive Queue slots on this UPI unit.",
+        "UMask": "0x27",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Protocol header and credit FLITs received from any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts protocol header and credit FLITs  (80 bit FLow control unITs) received from any of the 3 UPI slots on this UPI unit.",
+        "UMask": "0x97",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in which the Tx of the Intel Ultra Path Interconnect (UPI) is in L0p power mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles when the transmit side (Tx) of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode where we disable 60% of the UPI lanes, decreasing our bandwidth in order to save power.",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "FLITs that bypassed the TxL Buffer",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_UPI_TxL_BYPASSED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts incoming FLITs (FLow control unITs) which bypassed the TxL(transmit) FLIT buffer and pass directly out the UPI Link. Generally, when data is transmitted across the Intel Ultra Path Interconnect (UPI), it will bypass the TxQ and pass directly to the link.  However, the TxQ will be used in L0p (Low Power) mode and (Link Layer Retry) LLR  mode, increasing latency to transfer out to the link.",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Null FLITs transmitted from any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts null FLITs (80 bit FLow control unITs) transmitted via any of the 3 Intel Ulra Path Interconnect (UPI) slots on this UPI unit.",
+        "UMask": "0x27",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent; Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Shows legal flit time (hides impact of L0p and L0c).; Count Data Flits (which consume all slots), but how much to count is based on Slot0-2 mask, so count can be 0-3 depending on which slots are enabled for counting..",
+        "UMask": "0x8",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Idle FLITs transmitted",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.IDLE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts when the Intel Ultra Path Interconnect(UPI) transmits an idle FLIT(80 bit FLow control unITs).  Every UPI cycle must be sending either data FLITs, protocol/credit FLITs or idle FLITs.",
+        "UMask": "0x47",
+        "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "Protocol header and credit FLITs transmitted across any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts protocol header and credit FLITs (80 bit FLow control unITs) transmitted across any of the 3 UPI (Ultra Path Interconnect) slots on this UPI unit.",
+        "UMask": "0x97",
+        "Unit": "UPI LL"
     }
 ]
-- 
2.17.1

