Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC001C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96EC2148E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221295;
	bh=lXB/cp8iTOora9aaUWVMDOkSiLYSQAasWiArZqyIMt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J2RYog49k4LjIH9FHlTvr6BgfLdGfc0jleQ2emf82HUQz6/bLCnBb7+HsHfmp2emY
	 OJ7wrYXB9DBZjfCaKEOMkbI8BHbV5wNZ5UauAwHg6Cr9qijdgGp4NDFZ2OdgzTsJ0I
	 9q3xHci8PMfDCF2wP9JHdKyp3uMCJNXrZ9XHxWqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfDBQIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730283AbfDBQIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:08:10 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 275D02082C;
        Tue,  2 Apr 2019 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221282;
        bh=lXB/cp8iTOora9aaUWVMDOkSiLYSQAasWiArZqyIMt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0e9tA3RjTcuaEtKIEWeuVokvWITcA22VulXuUq0L+MZB0n2KZFS2T2lSZuCtsVmM
         RIzmk54vLJ3gL81uN+8nlWZzlmnqpQqYPhmpuySiBmEAm63bqeva84A4B/ggSviePE
         paW88RwdmL8btDRyj2cogFwXkmJ0G2nPdQW9iZAE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/44] perf vendor events intel: Update SandyBridge events to v16
Date:   Tue,  2 Apr 2019 13:05:42 -0300
Message-Id: <20190402160549.13544-38-acme@kernel.org>
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

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190315165219.GA21223@tassilo.jf.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/x86/sandybridge/cache.json           |  680 ++++-----
 .../arch/x86/sandybridge/floating-point.json  |  126 +-
 .../arch/x86/sandybridge/frontend.json        |  268 ++--
 .../arch/x86/sandybridge/memory.json          |   68 +-
 .../arch/x86/sandybridge/other.json           |   18 +-
 .../arch/x86/sandybridge/pipeline.json        | 1338 +++++++++--------
 .../arch/x86/sandybridge/virtual-memory.json  |  108 +-
 7 files changed, 1306 insertions(+), 1300 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
index 16b04a20bc12..bb79e89c2049 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/cache.json
@@ -1,207 +1,200 @@
 [
     {
-        "PEBS": "1",
-        "EventCode": "0xD0",
+        "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x11",
-        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Retired load uops that miss the STLB.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0x1",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Demand Data Read requests that hit L2 cache.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xD0",
+        "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x12",
-        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Retired store uops that miss the STLB.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0x3",
+        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Demand Data Read requests.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xD0",
+        "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x21",
-        "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
-        "SampleAfterValue": "100007",
-        "BriefDescription": "Retired load uops with locked access.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0x4",
+        "EventName": "L2_RQSTS.RFO_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "RFO requests that hit L2 cache.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "PublicDescription": "This event counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
-        "EventCode": "0xD0",
+        "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x41",
-        "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Retired load uops that split across a cacheline boundary.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0x8",
+        "EventName": "L2_RQSTS.RFO_MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "RFO requests that miss L2 cache.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "PublicDescription": "This event counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
-        "EventCode": "0xD0",
+        "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x42",
-        "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Retired store uops that split across a cacheline boundary.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0xc",
+        "EventName": "L2_RQSTS.ALL_RFO",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "RFO requests to L2 cache.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "PublicDescription": "This event counts the number of load uops retired",
-        "EventCode": "0xD0",
+        "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x81",
-        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "All retired load uops.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0x10",
+        "EventName": "L2_RQSTS.CODE_RD_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "L2 cache hits when fetching instructions, code reads.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "PublicDescription": "This event counts the number of store uops retired.",
-        "EventCode": "0xD0",
+        "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x82",
-        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "All retired store uops.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0x20",
+        "EventName": "L2_RQSTS.CODE_RD_MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "L2 cache misses when fetching instructions.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xD1",
+        "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Retired load uops with L1 cache hits as data sources.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0x30",
+        "EventName": "L2_RQSTS.ALL_CODE_RD",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "L2 code requests.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xD1",
+        "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Retired load uops with L2 cache hits as data sources.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0x40",
+        "EventName": "L2_RQSTS.PF_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Requests from the L2 hardware prefetchers that hit L2 cache.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "PublicDescription": "This event counts retired load uops that hit in the last-level (L3) cache without snoops required.",
-        "EventCode": "0xD1",
+        "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "MEM_LOAD_UOPS_RETIRED.LLC_HIT",
-        "SampleAfterValue": "50021",
-        "BriefDescription": "Retired load uops which data sources were data hits in LLC without snoops required.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0x80",
+        "EventName": "L2_RQSTS.PF_MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Requests from the L2 hardware prefetchers that miss L2 cache.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xD1",
+        "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
-        "EventName": "MEM_LOAD_UOPS_RETIRED.HIT_LFB",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Retired load uops which data sources were load uops missed L1 but hit FB due to preceding miss to the same cache line with data not ready.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0xc0",
+        "EventName": "L2_RQSTS.ALL_PF",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Requests from L2 hardware prefetchers.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xD2",
+        "EventCode": "0x27",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS",
-        "SampleAfterValue": "20011",
-        "BriefDescription": "Retired load uops which data sources were LLC hit and cross-core snoop missed in on-pkg core cache.",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "PEBS": "1",
-        "PublicDescription": "This event counts retired load uops that hit in the last-level cache (L3) and were found in a non-modified state in a neighboring core's private cache (same package).  Since the last level cache is inclusive, hits to the L3 may require snooping the private L2 caches of any cores on the same socket that have the line.  In this case, a snoop was required, and another L2 had the line in a non-modified state.",
-        "EventCode": "0xD2",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT",
-        "SampleAfterValue": "20011",
-        "BriefDescription": "Retired load uops which data sources were LLC and cross-core snoop hits in on-pkg core cache.",
-        "CounterHTOff": "0,1,2,3"
+        "EventName": "L2_STORE_LOCK_RQSTS.MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "RFOs that miss cache lines.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "PublicDescription": "This event counts retired load uops that hit in the last-level cache (L3) and were found in a non-modified state in a neighboring core's private cache (same package).  Since the last level cache is inclusive, hits to the L3 may require snooping the private L2 caches of any cores on the same socket that have the line.  In this case, a snoop was required, and another L2 had the line in a modified state, so the line had to be invalidated in that L2 cache and transferred to the requesting L2.",
-        "EventCode": "0xD2",
+        "EventCode": "0x27",
         "Counter": "0,1,2,3",
         "UMask": "0x4",
-        "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM",
-        "SampleAfterValue": "20011",
-        "BriefDescription": "Retired load uops which data sources were HitM responses from shared LLC.",
-        "CounterHTOff": "0,1,2,3"
+        "EventName": "L2_STORE_LOCK_RQSTS.HIT_E",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "RFOs that hit cache lines in E state.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xD2",
+        "EventCode": "0x27",
         "Counter": "0,1,2,3",
         "UMask": "0x8",
-        "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_NONE",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Retired load uops which data sources were hits in LLC without snoops required.",
-        "CounterHTOff": "0,1,2,3"
+        "EventName": "L2_STORE_LOCK_RQSTS.HIT_M",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "RFOs that hit cache lines in M state.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "PublicDescription": "This event counts retired demand loads that missed the  last-level (L3) cache. This means that the load is usually satisfied from memory in a client system or possibly from the remote socket in a server. Demand loads are non speculative load uops.",
-        "EventCode": "0xD4",
+        "EventCode": "0x27",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS",
-        "SampleAfterValue": "100007",
-        "BriefDescription": "Retired load uops with unknown information as data source in cache serviced the load.",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0xf",
+        "EventName": "L2_STORE_LOCK_RQSTS.ALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "RFOs that access cache lines in any state.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts L1D data line replacements.  Replacements occur when a new line is brought into the cache, causing eviction of a line loaded earlier.  ",
-        "EventCode": "0x51",
+        "EventCode": "0x28",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "L1D.REPLACEMENT",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "L1D data line replacements.",
+        "EventName": "L2_L1D_WB_RQSTS.MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Count the number of modified Lines evicted from L1 and missed L2. (Non-rejected WBs from the DCU.).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x51",
+        "EventCode": "0x28",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
-        "EventName": "L1D.ALLOCATED_IN_M",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Allocated L1D data cache lines in M state.",
+        "EventName": "L2_L1D_WB_RQSTS.HIT_S",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Not rejected writebacks from L1D to L2 cache lines in S state.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x51",
+        "EventCode": "0x28",
         "Counter": "0,1,2,3",
         "UMask": "0x4",
-        "EventName": "L1D.EVICTION",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "L1D data cache lines in M state evicted due to replacement.",
+        "EventName": "L2_L1D_WB_RQSTS.HIT_E",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Not rejected writebacks from L1D to L2 cache lines in E state.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x51",
+        "EventCode": "0x28",
         "Counter": "0,1,2,3",
         "UMask": "0x8",
-        "EventName": "L1D.ALL_M_REPLACEMENT",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cache lines in M state evicted out of L1D due to Snoop HitM or dirty line replacement.",
+        "EventName": "L2_L1D_WB_RQSTS.HIT_M",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Not rejected writebacks from L1D to L2 cache lines in M state.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0x28",
+        "Counter": "0,1,2,3",
+        "UMask": "0xf",
+        "EventName": "L2_L1D_WB_RQSTS.ALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Not rejected writebacks from L1D to L2 cache lines in any state.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0x2E",
+        "Counter": "0,1,2,3",
+        "UMask": "0x41",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Core-originated cacheable demand requests missed LLC.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0x2E",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4f",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Core-originated cacheable demand requests that refer to LLC.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -224,12 +217,61 @@
         "CounterHTOff": "2"
     },
     {
-        "EventCode": "0x63",
+        "EventCode": "0x48",
+        "Counter": "2",
+        "UMask": "0x1",
+        "AnyThread": "1",
+        "EventName": "L1D_PEND_MISS.PENDING_CYCLES_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles with L1D load Misses outstanding from any thread on physical core.",
+        "CounterMask": "1",
+        "CounterHTOff": "2"
+    },
+    {
+        "EventCode": "0x48",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
-        "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
+        "EventName": "L1D_PEND_MISS.FB_FULL",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when L1D is locked.",
+        "BriefDescription": "Cycles a demand request was blocked due to Fill Buffers inavailability.",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "This event counts L1D data line replacements.  Replacements occur when a new line is brought into the cache, causing eviction of a line loaded earlier.",
+        "EventCode": "0x51",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "L1D.REPLACEMENT",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "L1D data line replacements.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0x51",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "L1D.ALLOCATED_IN_M",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Allocated L1D data cache lines in M state.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0x51",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "EventName": "L1D.EVICTION",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "L1D data cache lines in M state evicted due to replacement.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0x51",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "EventName": "L1D.ALL_M_REPLACEMENT",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cache lines in M state evicted out of L1D due to Snoop HitM or dirty line replacement.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -251,6 +293,16 @@
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "EventCode": "0x60",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD_C6",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles with at least 6 offcore outstanding Demand Data Read transactions in uncore queue.",
+        "CounterMask": "6",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "EventCode": "0x60",
         "Counter": "0,1,2,3",
@@ -260,6 +312,16 @@
         "BriefDescription": "Offcore outstanding RFO store transactions in SuperQueue (SQ), queue to uncore.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "EventCode": "0x60",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Offcore outstanding demand rfo reads transactions in SuperQueue (SQ), queue to uncore, every cycle.",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "EventCode": "0x60",
         "Counter": "0,1,2,3",
@@ -279,6 +341,15 @@
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "EventCode": "0x63",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when L1D is locked.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "EventCode": "0xB0",
         "Counter": "0,1,2,3",
@@ -325,148 +396,182 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x24",
+        "EventCode": "0xBF",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Demand Data Read requests that hit L2 cache.",
+        "UMask": "0x5",
+        "EventName": "L1D_BLOCKS.BANK_CONFLICT_CYCLES",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Cycles when dispatched loads are cancelled due to L1D bank conflicts with other load ports.",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x24",
+        "PEBS": "1",
+        "EventCode": "0xD0",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "L2_RQSTS.RFO_HIT",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "RFO requests that hit L2 cache.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x11",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired load uops that miss the STLB. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x24",
+        "PEBS": "1",
+        "EventCode": "0xD0",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "L2_RQSTS.RFO_MISS",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "RFO requests that miss L2 cache.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x12",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired store uops that miss the STLB. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PEBS": "1",
+        "EventCode": "0xD0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x21",
+        "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired load uops with locked access. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x24",
+        "PEBS": "1",
+        "PublicDescription": "This event counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K). (Precise Event - PEBS)",
+        "EventCode": "0xD0",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "L2_RQSTS.CODE_RD_HIT",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "L2 cache hits when fetching instructions, code reads.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x41",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired load uops that split across a cacheline boundary. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x24",
+        "PEBS": "1",
+        "PublicDescription": "This event counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K). (Precise Event - PEBS)",
+        "EventCode": "0xD0",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "L2_RQSTS.CODE_RD_MISS",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "L2 cache misses when fetching instructions.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x42",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired store uops that split across a cacheline boundary. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x24",
+        "PEBS": "1",
+        "PublicDescription": "This event counts the number of load uops retired (Precise Event)",
+        "EventCode": "0xD0",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
-        "EventName": "L2_RQSTS.PF_HIT",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Requests from the L2 hardware prefetchers that hit L2 cache.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x81",
+        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "All retired load uops. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x24",
+        "PEBS": "1",
+        "PublicDescription": "This event counts the number of store uops retired. (Precise Event - PEBS)",
+        "EventCode": "0xD0",
         "Counter": "0,1,2,3",
-        "UMask": "0x80",
-        "EventName": "L2_RQSTS.PF_MISS",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Requests from the L2 hardware prefetchers that miss L2 cache.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x82",
+        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "All retired store uops. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x27",
+        "PEBS": "1",
+        "EventCode": "0xD1",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "L2_STORE_LOCK_RQSTS.MISS",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "RFOs that miss cache lines.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Retired load uops with L1 cache hits as data sources. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x27",
+        "PEBS": "1",
+        "EventCode": "0xD1",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "L2_STORE_LOCK_RQSTS.HIT_E",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "RFOs that hit cache lines in E state.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x2",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired load uops with L2 cache hits as data sources. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x27",
+        "PEBS": "1",
+        "PublicDescription": "This event counts retired load uops that hit in the last-level (L3) cache without snoops required. (Precise Event - PEBS)",
+        "EventCode": "0xD1",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "L2_STORE_LOCK_RQSTS.HIT_M",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "RFOs that hit cache lines in M state.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x4",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.LLC_HIT",
+        "SampleAfterValue": "50021",
+        "BriefDescription": "Retired load uops which data sources were data hits in LLC without snoops required. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x27",
+        "PEBS": "1",
+        "EventCode": "0xD1",
         "Counter": "0,1,2,3",
-        "UMask": "0xf",
-        "EventName": "L2_STORE_LOCK_RQSTS.ALL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "RFOs that access cache lines in any state.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x40",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.HIT_LFB",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired load uops which data sources were load uops missed L1 but hit FB due to preceding miss to the same cache line with data not ready. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x28",
+        "PEBS": "1",
+        "EventCode": "0xD2",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "L2_L1D_WB_RQSTS.MISS",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Count the number of modified Lines evicted from L1 and missed L2. (Non-rejected WBs from the DCU.).",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS",
+        "SampleAfterValue": "20011",
+        "BriefDescription": "Retired load uops which data sources were LLC hit and cross-core snoop missed in on-pkg core cache. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x28",
+        "PEBS": "1",
+        "PublicDescription": "This event counts retired load uops that hit in the last-level cache (L3) and were found in a non-modified state in a neighboring core's private cache (same package).  Since the last level cache is inclusive, hits to the L3 may require snooping the private L2 caches of any cores on the same socket that have the line.  In this case, a snoop was required, and another L2 had the line in a non-modified state. (Precise Event - PEBS)",
+        "EventCode": "0xD2",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
-        "EventName": "L2_L1D_WB_RQSTS.HIT_S",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Not rejected writebacks from L1D to L2 cache lines in S state.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT",
+        "SampleAfterValue": "20011",
+        "BriefDescription": "Retired load uops which data sources were LLC and cross-core snoop hits in on-pkg core cache. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x28",
+        "PEBS": "1",
+        "PublicDescription": "This event counts retired load uops that hit in the last-level cache (L3) and were found in a non-modified state in a neighboring core's private cache (same package).  Since the last level cache is inclusive, hits to the L3 may require snooping the private L2 caches of any cores on the same socket that have the line.  In this case, a snoop was required, and another L2 had the line in a modified state, so the line had to be invalidated in that L2 cache and transferred to the requesting L2. (Precise Event - PEBS)",
+        "EventCode": "0xD2",
         "Counter": "0,1,2,3",
         "UMask": "0x4",
-        "EventName": "L2_L1D_WB_RQSTS.HIT_E",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Not rejected writebacks from L1D to L2 cache lines in E state.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM",
+        "SampleAfterValue": "20011",
+        "BriefDescription": "Retired load uops which data sources were HitM responses from shared LLC. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x28",
+        "PEBS": "1",
+        "EventCode": "0xD2",
         "Counter": "0,1,2,3",
         "UMask": "0x8",
-        "EventName": "L2_L1D_WB_RQSTS.HIT_M",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Not rejected writebacks from L1D to L2 cache lines in M state.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "EventName": "MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_NONE",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired load uops which data sources were hits in LLC without snoops required. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x28",
+        "PEBS": "1",
+        "PublicDescription": "This event counts retired demand loads that missed the  last-level (L3) cache. This means that the load is usually satisfied from memory in a client system or possibly from the remote socket in a server. Demand loads are non speculative load uops. (Precise Event - PEBS)",
+        "EventCode": "0xD4",
         "Counter": "0,1,2,3",
-        "UMask": "0xf",
-        "EventName": "L2_L1D_WB_RQSTS.ALL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Not rejected writebacks from L1D to L2 cache lines in any state.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x2",
+        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired load uops with unknown information as data source in cache serviced the load. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xF0",
@@ -622,24 +727,6 @@
         "BriefDescription": "Dirty L2 cache lines filling the L2.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
-    {
-        "EventCode": "0x2E",
-        "Counter": "0,1,2,3",
-        "UMask": "0x41",
-        "EventName": "LONGEST_LAT_CACHE.MISS",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Core-originated cacheable demand requests missed LLC.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x2E",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4f",
-        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Core-originated cacheable demand requests that refer to LLC.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
     {
         "EventCode": "0xF4",
         "Counter": "0,1,2,3",
@@ -649,93 +736,6 @@
         "BriefDescription": "Split locks in SQ.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
-    {
-        "EventCode": "0x24",
-        "Counter": "0,1,2,3",
-        "UMask": "0x3",
-        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Demand Data Read requests.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x24",
-        "Counter": "0,1,2,3",
-        "UMask": "0xc",
-        "EventName": "L2_RQSTS.ALL_RFO",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "RFO requests to L2 cache.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x24",
-        "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "EventName": "L2_RQSTS.ALL_CODE_RD",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "L2 code requests.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x24",
-        "Counter": "0,1,2,3",
-        "UMask": "0xc0",
-        "EventName": "L2_RQSTS.ALL_PF",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Requests from L2 hardware prefetchers.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xBF",
-        "Counter": "0,1,2,3",
-        "UMask": "0x5",
-        "EventName": "L1D_BLOCKS.BANK_CONFLICT_CYCLES",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Cycles when dispatched loads are cancelled due to L1D bank conflicts with other load ports.",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x60",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Offcore outstanding demand rfo reads transactions in SuperQueue (SQ), queue to uncore, every cycle.",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x60",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD_C6",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles with at least 6 offcore outstanding Demand Data Read transactions in uncore queue.",
-        "CounterMask": "6",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x48",
-        "Counter": "2",
-        "UMask": "0x1",
-        "AnyThread": "1",
-        "EventName": "L1D_PEND_MISS.PENDING_CYCLES_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles with L1D load Misses outstanding from any thread on physical core.",
-        "CounterMask": "1",
-        "CounterHTOff": "2"
-    },
-    {
-        "EventCode": "0x48",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "L1D_PEND_MISS.FB_FULL",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles a demand request was blocked due to Fill Buffers inavailability.",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
     {
         "EventCode": "0xB7, 0xBB",
         "MSRValue": "0x10003c0244",
@@ -1825,7 +1825,7 @@
         "EventName": "OFFCORE_RESPONSE.DATA_IN.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = DATA_INTO_CORE and RESPONSE = ANY_RESPONSE",
+        "BriefDescription": "REQUEST = DATA_INTO_CORE and RESPONSE = ANY_RESPONSE",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1837,7 +1837,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT_M.HITM",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = DEMAND_RFO and RESPONSE = LLC_HIT_M and SNOOP = HITM",
+        "BriefDescription": "REQUEST = DEMAND_RFO and RESPONSE = LLC_HIT_M and SNOOP = HITM",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1849,7 +1849,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = PF_RFO and RESPONSE = ANY_RESPONSE",
+        "BriefDescription": "REQUEST = PF_RFO and RESPONSE = ANY_RESPONSE",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1861,7 +1861,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_L_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = PF_LLC_DATA_RD and RESPONSE = ANY_RESPONSE",
+        "BriefDescription": "REQUEST = PF_LLC_DATA_RD and RESPONSE = ANY_RESPONSE",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -1873,7 +1873,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_L_IFETCH.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = PF_LLC_IFETCH and RESPONSE = ANY_RESPONSE",
+        "BriefDescription": "REQUEST = PF_LLC_IFETCH and RESPONSE = ANY_RESPONSE",
         "CounterHTOff": "0,1,2,3"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json b/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
index 982eda48785e..ce26537c7d47 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
@@ -1,67 +1,4 @@
 [
-    {
-        "EventCode": "0xC1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "OTHER_ASSISTS.AVX_STORE",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Number of GSSE memory assist for stores. GSSE microcode assist is being invoked whenever the hardware is unable to properly handle GSSE-256b operations.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xC1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "OTHER_ASSISTS.AVX_TO_SSE",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Number of transitions from AVX-256 to legacy SSE when penalty applicable.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xC1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "OTHER_ASSISTS.SSE_TO_AVX",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Number of transitions from SSE to AVX-256 when penalty applicable.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xCA",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "FP_ASSIST.X87_OUTPUT",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Number of X87 assists due to output value.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xCA",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "FP_ASSIST.X87_INPUT",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Number of X87 assists due to input value.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xCA",
-        "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "FP_ASSIST.SIMD_OUTPUT",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Number of SIMD FP assists due to Output values.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xCA",
-        "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "FP_ASSIST.SIMD_INPUT",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Number of SIMD FP assists due to input values.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
     {
         "EventCode": "0x10",
         "Counter": "0,1,2,3",
@@ -125,6 +62,69 @@
         "BriefDescription": "Number of AVX-256 Computational FP double precision uops issued this cycle.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "EventCode": "0xC1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "EventName": "OTHER_ASSISTS.AVX_STORE",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of GSSE memory assist for stores. GSSE microcode assist is being invoked whenever the hardware is unable to properly handle GSSE-256b operations.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xC1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "EventName": "OTHER_ASSISTS.AVX_TO_SSE",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of transitions from AVX-256 to legacy SSE when penalty applicable.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xC1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x20",
+        "EventName": "OTHER_ASSISTS.SSE_TO_AVX",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of transitions from SSE to AVX-256 when penalty applicable.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xCA",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "FP_ASSIST.X87_OUTPUT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of X87 assists due to output value.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xCA",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "EventName": "FP_ASSIST.X87_INPUT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of X87 assists due to input value.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xCA",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "EventName": "FP_ASSIST.SIMD_OUTPUT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of SIMD FP assists due to Output values.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xCA",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "EventName": "FP_ASSIST.SIMD_INPUT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of SIMD FP assists due to input values.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "EventCode": "0xCA",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json b/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
index 1b7b1dd36c68..e58ed14a204c 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
@@ -1,23 +1,4 @@
 [
-    {
-        "EventCode": "0x80",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "ICACHE.HIT",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of Instruction Cache, Streaming Buffer and Victim Cache Reads. both cacheable and noncacheable, including UC fetches.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "PublicDescription": "This event counts the number of instruction cache, streaming buffer and victim cache misses. Counting includes unchacheable accesses.",
-        "EventCode": "0x80",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "ICACHE.MISSES",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Instruction cache, streaming buffer and victim cache misses.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
     {
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
@@ -39,158 +20,200 @@
     {
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "IDQ.DSB_UOPS",
+        "UMask": "0x4",
+        "EventName": "IDQ.MITE_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
+        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from MITE path.",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "IDQ.MS_DSB_UOPS",
+        "UMask": "0x8",
+        "EventName": "IDQ.DSB_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) that are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "IDQ.MS_MITE_UOPS",
+        "UMask": "0x8",
+        "EventName": "IDQ.DSB_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops initiated by MITE and delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
+        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path.",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "EventName": "IDQ.MS_UOPS",
+        "UMask": "0x10",
+        "EventName": "IDQ.MS_DSB_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
+        "BriefDescription": "Uops initiated by Decode Stream Buffer (DSB) that are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts cycles during which the microcode sequencer assisted the front-end in delivering uops.  Microcode assists are used for complex instructions or scenarios that can't be handled by the standard decoder.  Using other instructions, if possible, will usually improve performance.  See the Intel? 64 and IA-32 Architectures Optimization Reference Manual for more information.",
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "EventName": "IDQ.MS_CYCLES",
+        "UMask": "0x10",
+        "EventName": "IDQ.MS_DSB_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
+        "BriefDescription": "Cycles when uops initiated by Decode Stream Buffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts the number of uops not delivered to the back-end per cycle, per thread, when the back-end was not stalled.  In the ideal case 4 uops can be delivered each cycle.  The event counts the undelivered uops - so if 3 were delivered in one cycle, the counter would be incremented by 1 for that cycle (4 - 3). If the back-end is stalled, the count for this event is not incremented even when uops were not delivered, because the back-end would not have been able to accept them.  This event is used in determining the front-end bound category of the top-down pipeline slots characterization.",
-        "EventCode": "0x9C",
+        "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
+        "UMask": "0x10",
+        "EdgeDetect": "1",
+        "EventName": "IDQ.MS_DSB_OCCUR",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops not delivered to Resource Allocation Table (RAT) per thread when backend of the machine is not stalled .",
-        "CounterHTOff": "0,1,2,3"
+        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is busy.",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x9C",
+        "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
+        "UMask": "0x18",
+        "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when 4 or more uops are not delivered to Resource Allocation Table (RAT) when backend of the machine is not stalled.",
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is delivering 4 Uops.",
         "CounterMask": "4",
-        "CounterHTOff": "0,1,2,3"
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x9C",
+        "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_1_UOP_DELIV.CORE",
+        "UMask": "0x18",
+        "EventName": "IDQ.ALL_DSB_CYCLES_ANY_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when 3 or more uops are not delivered to Resource Allocation Table (RAT) when backend of the machine is not stalled.",
-        "CounterMask": "3",
-        "CounterHTOff": "0,1,2,3"
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is delivering any Uop.",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xAB",
+        "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "DSB2MITE_SWITCHES.COUNT",
+        "UMask": "0x20",
+        "EventName": "IDQ.MS_MITE_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switches.",
+        "BriefDescription": "Uops initiated by MITE and delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts the cycles attributed to a switch from the Decoded Stream Buffer (DSB), which holds decoded instructions, to the legacy decode pipeline.  It excludes cycles when the back-end cannot  accept new micro-ops.  The penalty for these switches is potentially several cycles of instruction starvation, where no micro-ops are delivered to the back-end.",
-        "EventCode": "0xAB",
+        "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
+        "UMask": "0x24",
+        "EventName": "IDQ.ALL_MITE_CYCLES_4_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switch true penalty cycles.",
+        "BriefDescription": "Cycles MITE is delivering 4 Uops.",
+        "CounterMask": "4",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xAC",
+        "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "DSB_FILL.OTHER_CANCEL",
+        "UMask": "0x24",
+        "EventName": "IDQ.ALL_MITE_CYCLES_ANY_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cases of cancelling valid DSB fill not because of exceeding way limit.",
+        "BriefDescription": "Cycles MITE is delivering any Uop.",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xAC",
+        "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "DSB_FILL.EXCEED_DSB_LINES",
+        "UMask": "0x30",
+        "EventName": "IDQ.MS_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when Decode Stream Buffer (DSB) fill encounter more than 3 Decode Stream Buffer (DSB) lines.",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
+        "PublicDescription": "This event counts cycles during which the microcode sequencer assisted the front-end in delivering uops.  Microcode assists are used for complex instructions or scenarios that can't be handled by the standard decoder.  Using other instructions, if possible, will usually improve performance.  See the Intel\u00ae 64 and IA-32 Architectures Optimization Reference Manual for more information.",
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "IDQ.MITE_CYCLES",
+        "UMask": "0x30",
+        "EventName": "IDQ.MS_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from MITE path.",
+        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "IDQ.DSB_CYCLES",
+        "UMask": "0x30",
+        "EdgeDetect": "1",
+        "EventName": "IDQ.MS_SWITCHES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when uops are being delivered to Instruction Decode Queue (IDQ) from Decode Stream Buffer (DSB) path.",
+        "BriefDescription": "Number of switches from DSB (Decode Stream Buffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0x79",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "IDQ.MS_DSB_CYCLES",
+        "UMask": "0x3c",
+        "EventName": "IDQ.MITE_ALL_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when uops initiated by Decode Stream Buffer (DSB) are being delivered to Instruction Decode Queue (IDQ) while Microcode Sequenser (MS) is busy.",
-        "CounterMask": "1",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) from MITE path.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x79",
+        "EventCode": "0x80",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EdgeDetect": "1",
-        "EventName": "IDQ.MS_DSB_OCCUR",
+        "UMask": "0x1",
+        "EventName": "ICACHE.HIT",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Deliveries to Instruction Decode Queue (IDQ) initiated by Decode Stream Buffer (DSB) while Microcode Sequenser (MS) is busy.",
-        "CounterMask": "1",
+        "BriefDescription": "Number of Instruction Cache, Streaming Buffer and Victim Cache Reads. both cacheable and noncacheable, including UC fetches.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "This event counts the number of instruction cache, streaming buffer and victim cache misses. Counting includes unchacheable accesses.",
+        "EventCode": "0x80",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "ICACHE.MISSES",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Instruction cache, streaming buffer and victim cache misses.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "PublicDescription": "This event counts the number of uops not delivered to the back-end per cycle, per thread, when the back-end was not stalled.  In the ideal case 4 uops can be delivered each cycle.  The event counts the undelivered uops - so if 3 were delivered in one cycle, the counter would be incremented by 1 for that cycle (4 - 3). If the back-end is stalled, the count for this event is not incremented even when uops were not delivered, because the back-end would not have been able to accept them.  This event is used in determining the front-end bound category of the top-down pipeline slots characterization.",
+        "EventCode": "0x9C",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Uops not delivered to Resource Allocation Table (RAT) per thread when backend of the machine is not stalled .",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0x9C",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles per thread when 4 or more uops are not delivered to Resource Allocation Table (RAT) when backend of the machine is not stalled.",
+        "CounterMask": "4",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0x9C",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_1_UOP_DELIV.CORE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles per thread when 3 or more uops are not delivered to Resource Allocation Table (RAT) when backend of the machine is not stalled.",
+        "CounterMask": "3",
+        "CounterHTOff": "0,1,2,3"
+    },
     {
         "EventCode": "0x9C",
         "Counter": "0,1,2,3",
@@ -223,83 +246,60 @@
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x79",
-        "Counter": "0,1,2,3",
-        "UMask": "0x18",
-        "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is delivering 4 Uops.",
-        "CounterMask": "4",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x79",
+        "EventCode": "0x9C",
+        "Invert": "1",
         "Counter": "0,1,2,3",
-        "UMask": "0x18",
-        "EventName": "IDQ.ALL_DSB_CYCLES_ANY_UOPS",
+        "UMask": "0x1",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is delivering any Uop.",
+        "BriefDescription": "Counts cycles FE delivered 4 uops or Resource Allocation Table (RAT) was stalling FE.",
         "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x79",
+        "EventCode": "0xAB",
         "Counter": "0,1,2,3",
-        "UMask": "0x24",
-        "EventName": "IDQ.ALL_MITE_CYCLES_4_UOPS",
+        "UMask": "0x1",
+        "EventName": "DSB2MITE_SWITCHES.COUNT",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles MITE is delivering 4 Uops.",
-        "CounterMask": "4",
+        "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switches.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x79",
+        "PublicDescription": "This event counts the cycles attributed to a switch from the Decoded Stream Buffer (DSB), which holds decoded instructions, to the legacy decode pipeline.  It excludes cycles when the back-end cannot  accept new micro-ops.  The penalty for these switches is potentially several cycles of instruction starvation, where no micro-ops are delivered to the back-end.",
+        "EventCode": "0xAB",
         "Counter": "0,1,2,3",
-        "UMask": "0x24",
-        "EventName": "IDQ.ALL_MITE_CYCLES_ANY_UOPS",
+        "UMask": "0x2",
+        "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles MITE is delivering any Uop.",
-        "CounterMask": "1",
+        "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switch true penalty cycles.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0xAC",
         "Counter": "0,1,2,3",
-        "UMask": "0xa",
-        "EventName": "DSB_FILL.ALL_CANCEL",
+        "UMask": "0x2",
+        "EventName": "DSB_FILL.OTHER_CANCEL",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cases of cancelling valid Decode Stream Buffer (DSB) fill not because of exceeding way limit.",
+        "BriefDescription": "Cases of cancelling valid DSB fill not because of exceeding way limit.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x9C",
-        "Invert": "1",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Counts cycles FE delivered 4 uops or Resource Allocation Table (RAT) was stalling FE.",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3"
-    },
-    {
-        "EventCode": "0x79",
+        "EventCode": "0xAC",
         "Counter": "0,1,2,3",
-        "UMask": "0x3c",
-        "EventName": "IDQ.MITE_ALL_UOPS",
+        "UMask": "0x8",
+        "EventName": "DSB_FILL.EXCEED_DSB_LINES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) from MITE path.",
+        "BriefDescription": "Cycles when Decode Stream Buffer (DSB) fill encounter more than 3 Decode Stream Buffer (DSB) lines.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x79",
+        "EventCode": "0xAC",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "EdgeDetect": "1",
-        "EventName": "IDQ.MS_SWITCHES",
+        "UMask": "0xa",
+        "EventName": "DSB_FILL.ALL_CANCEL",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of switches from DSB (Decode Stream Buffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
-        "CounterMask": "1",
+        "BriefDescription": "Cases of cancelling valid Decode Stream Buffer (DSB) fill not because of exceeding way limit.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/memory.json b/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
index e6dfa89d00f3..78c1a987f9a2 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/memory.json
@@ -1,4 +1,31 @@
 [
+    {
+        "EventCode": "0x05",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "MISALIGN_MEM_REF.LOADS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Speculative cache line split load uops dispatched to L1 cache.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0x05",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "MISALIGN_MEM_REF.STORES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Speculative cache line split STA uops dispatched to L1 cache.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xBE",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "PAGE_WALKS.LLC_MISS",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of any page walk that had a miss in LLC. Does not necessary cause a SUSPEND.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "This event counts the number of memory ordering Machine Clears detected. Memory Ordering Machine Clears can result from memory disambiguation, external snoops, or cross SMT-HW-thread snoop (stores) hitting load buffers.  Machine clears can have a significant performance impact if they are happening frequently.",
         "EventCode": "0xC3",
@@ -125,33 +152,6 @@
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
-    {
-        "EventCode": "0xBE",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "PAGE_WALKS.LLC_MISS",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Number of any page walk that had a miss in LLC. Does not necessary cause a SUSPEND.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x05",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "MISALIGN_MEM_REF.LOADS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Speculative cache line split load uops dispatched to L1 cache.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x05",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "MISALIGN_MEM_REF.STORES",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Speculative cache line split STA uops dispatched to L1 cache.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
     {
         "EventCode": "0xB7, 0xBB",
         "MSRValue": "0x300400244",
@@ -367,7 +367,7 @@
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.LLC_MISS_LOCAL.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = ANY_REQUEST and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
+        "BriefDescription": "REQUEST = ANY_REQUEST and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -379,7 +379,7 @@
         "EventName": "OFFCORE_RESPONSE.DATA_IN_SOCKET.LLC_MISS_LOCAL.ANY_LLC_HIT",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = DATA_IN_SOCKET and RESPONSE = LLC_MISS_LOCAL and SNOOP = ANY_LLC_HIT",
+        "BriefDescription": "REQUEST = DATA_IN_SOCKET and RESPONSE = LLC_MISS_LOCAL and SNOOP = ANY_LLC_HIT",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -391,7 +391,7 @@
         "EventName": "OFFCORE_RESPONSE.DEMAND_IFETCH.LLC_MISS_LOCAL.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = DEMAND_IFETCH and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
+        "BriefDescription": "REQUEST = DEMAND_IFETCH and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -403,7 +403,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_DATA_RD.LLC_MISS_LOCAL.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = PF_DATA_RD and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
+        "BriefDescription": "REQUEST = PF_DATA_RD and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -415,7 +415,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_IFETCH.LLC_MISS_LOCAL.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = PF_RFO and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
+        "BriefDescription": "REQUEST = PF_RFO and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -427,7 +427,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_L_DATA_RD.LLC_MISS_LOCAL.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = PF_LLC_DATA_RD and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
+        "BriefDescription": "REQUEST = PF_LLC_DATA_RD and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -439,7 +439,7 @@
         "EventName": "OFFCORE_RESPONSE.PF_L_IFETCH.LLC_MISS_LOCAL.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": " REQUEST = PF_LLC_IFETCH and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
+        "BriefDescription": "REQUEST = PF_LLC_IFETCH and RESPONSE = LLC_MISS_LOCAL and SNOOP = DRAM",
         "CounterHTOff": "0,1,2,3"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/other.json b/tools/perf/pmu-events/arch/x86/sandybridge/other.json
index 64b195b82c50..874eb40a2e0f 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/other.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/other.json
@@ -8,6 +8,15 @@
         "BriefDescription": "Valid instructions written to IQ per cycle.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "EventCode": "0x4E",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "EventName": "HW_PRE_REQ.DL1_MISS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Hardware Prefetch requests that miss the L1D cache. This accounts for both L1 streamer and IP-based (IPP) HW prefetchers. A request is being counted each time it access the cache & miss it, including if a block is applicable or if hit the Fill Buffer for .",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "EventCode": "0x5C",
         "Counter": "0,1,2,3",
@@ -37,15 +46,6 @@
         "BriefDescription": "Unhalted core cycles when thread is in rings 1, 2, or 3.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
-    {
-        "EventCode": "0x4E",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "HW_PRE_REQ.DL1_MISS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Hardware Prefetch requests that miss the L1D cache. This accounts for both L1 streamer and IP-based (IPP) HW prefetchers. A request is being counted each time it access the cache & miss it, including if a block is applicable or if hit the Fill Buffer for .",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
     {
         "EventCode": "0x63",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
index 34a519d9bfa0..b7150f65f16d 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
@@ -1,289 +1,307 @@
 [
     {
-        "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers. ",
-        "EventCode": "0x00",
-        "Counter": "Fixed counter 1",
+        "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
+        "Counter": "Fixed counter 2",
+        "UMask": "0x3",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "CounterHTOff": "Fixed counter 2"
+    },
+    {
+        "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers.",
+        "Counter": "Fixed counter 0",
         "UMask": "0x1",
         "EventName": "INST_RETIRED.ANY",
         "SampleAfterValue": "2000003",
         "BriefDescription": "Instructions retired from execution.",
-        "CounterHTOff": "Fixed counter 1"
+        "CounterHTOff": "Fixed counter 0"
     },
     {
-        "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. ",
-        "EventCode": "0x00",
-        "Counter": "Fixed counter 2",
+        "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
+        "Counter": "Fixed counter 1",
         "UMask": "0x2",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
         "BriefDescription": "Core cycles when the thread is not in halt state.",
-        "CounterHTOff": "Fixed counter 2"
+        "CounterHTOff": "Fixed counter 1"
     },
     {
-        "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. ",
-        "EventCode": "0x00",
-        "Counter": "Fixed counter 3",
-        "UMask": "0x3",
-        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "Counter": "Fixed counter 1",
+        "UMask": "0x2",
+        "AnyThread": "1",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Reference cycles when the core is not in halt state.",
-        "CounterHTOff": "Fixed counter 3"
+        "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "CounterHTOff": "Fixed counter 1"
     },
     {
-        "EventCode": "0x88",
+        "EventCode": "0x03",
         "Counter": "0,1,2,3",
-        "UMask": "0x41",
-        "EventName": "BR_INST_EXEC.NONTAKEN_CONDITIONAL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Not taken macro-conditional branches.",
+        "UMask": "0x1",
+        "EventName": "LD_BLOCKS.DATA_UNKNOWN",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Loads delayed due to SB blocks, preceding store operations with known addresses but unknown data.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceeding smaller uncompleted store.  See the table of not supported store forwards in the Intel\u00ae 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
+        "EventCode": "0x03",
         "Counter": "0,1,2,3",
-        "UMask": "0x81",
-        "EventName": "BR_INST_EXEC.TAKEN_CONDITIONAL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Taken speculative and retired macro-conditional branches.",
+        "UMask": "0x2",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Cases when loads get true Block-on-Store blocking code preventing store forwarding.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "EventCode": "0x03",
         "Counter": "0,1,2,3",
-        "UMask": "0x82",
-        "EventName": "BR_INST_EXEC.TAKEN_DIRECT_JUMP",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Taken speculative and retired macro-conditional branch instructions excluding calls and indirects.",
+        "UMask": "0x8",
+        "EventName": "LD_BLOCKS.NO_SR",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "This event counts the number of times that split load operations are temporarily blocked because all resources for handling the split accesses are in use.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "EventCode": "0x03",
         "Counter": "0,1,2,3",
-        "UMask": "0x84",
-        "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Taken speculative and retired indirect branches excluding calls and returns.",
+        "UMask": "0x10",
+        "EventName": "LD_BLOCKS.ALL_BLOCK",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of cases where any load ends up with a valid block-code written to the load buffer (including blocks due to Memory Order Buffer (MOB), Data Cache Unit (DCU), TLB, but load has no DCU miss).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "PublicDescription": "Aliasing occurs when a load is issued after a store and their memory addresses are offset by 4K.  This event counts the number of loads that aliased with a preceding store, resulting in an extended address check in the pipeline.  The enhanced address check typically has a performance penalty of 5 cycles.",
+        "EventCode": "0x07",
         "Counter": "0,1,2,3",
-        "UMask": "0x88",
-        "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_RETURN",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Taken speculative and retired indirect branches with return mnemonic.",
+        "UMask": "0x1",
+        "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "False dependencies in MOB due to partial compare.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "EventCode": "0x07",
         "Counter": "0,1,2,3",
-        "UMask": "0x90",
-        "EventName": "BR_INST_EXEC.TAKEN_DIRECT_NEAR_CALL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Taken speculative and retired direct near calls.",
+        "UMask": "0x8",
+        "EventName": "LD_BLOCKS_PARTIAL.ALL_STA_BLOCK",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "This event counts the number of times that load operations are temporarily blocked because of older stores, with addresses that are not yet known. A load operation may incur more than one block of this type.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "EventCode": "0x0D",
         "Counter": "0,1,2,3",
-        "UMask": "0xa0",
-        "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Taken speculative and retired indirect calls.",
+        "UMask": "0x3",
+        "EventName": "INT_MISC.RECOVERY_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of cycles waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "EventCode": "0x0D",
         "Counter": "0,1,2,3",
-        "UMask": "0xc1",
-        "EventName": "BR_INST_EXEC.ALL_CONDITIONAL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Speculative and retired macro-conditional branches.",
+        "UMask": "0x3",
+        "EdgeDetect": "1",
+        "EventName": "INT_MISC.RECOVERY_STALLS_COUNT",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of occurences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "EventCode": "0x0D",
         "Counter": "0,1,2,3",
-        "UMask": "0xc2",
-        "EventName": "BR_INST_EXEC.ALL_DIRECT_JMP",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Speculative and retired macro-unconditional branches excluding calls and indirects.",
+        "UMask": "0x3",
+        "AnyThread": "1",
+        "EventName": "INT_MISC.RECOVERY_CYCLES_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Core cycles the allocator was stalled due to recovery from earlier clear event for any thread running on the physical core (e.g. misprediction or memory nuke).",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "EventCode": "0x0D",
         "Counter": "0,1,2,3",
-        "UMask": "0xc4",
-        "EventName": "BR_INST_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Speculative and retired indirect branches excluding calls and returns.",
+        "UMask": "0x40",
+        "EventName": "INT_MISC.RAT_STALL_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when Resource Allocation Table (RAT) external stall is sent to Instruction Decode Queue (IDQ) for the thread.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "PublicDescription": "This event counts the number of Uops issued by the front-end of the pipeilne to the back-end.",
+        "EventCode": "0x0E",
         "Counter": "0,1,2,3",
-        "UMask": "0xc8",
-        "EventName": "BR_INST_EXEC.ALL_INDIRECT_NEAR_RETURN",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Speculative and retired indirect return branches.",
+        "UMask": "0x1",
+        "EventName": "UOPS_ISSUED.ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Uops that Resource Allocation Table (RAT) issues to Reservation Station (RS).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "EventCode": "0x0E",
+        "Invert": "1",
         "Counter": "0,1,2,3",
-        "UMask": "0xd0",
-        "EventName": "BR_INST_EXEC.ALL_DIRECT_NEAR_CALL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Speculative and retired direct near calls.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x1",
+        "EventName": "UOPS_ISSUED.STALL_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when Resource Allocation Table (RAT) does not issue Uops to Reservation Station (RS) for the thread.",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x89",
+        "EventCode": "0x0E",
+        "Invert": "1",
         "Counter": "0,1,2,3",
-        "UMask": "0x41",
-        "EventName": "BR_MISP_EXEC.NONTAKEN_CONDITIONAL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x1",
+        "AnyThread": "1",
+        "EventName": "UOPS_ISSUED.CORE_STALL_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when Resource Allocation Table (RAT) does not issue Uops to Reservation Station (RS) for all threads.",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x89",
+        "EventCode": "0x14",
         "Counter": "0,1,2,3",
-        "UMask": "0x81",
-        "EventName": "BR_MISP_EXEC.TAKEN_CONDITIONAL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Taken speculative and retired mispredicted macro conditional branches.",
+        "UMask": "0x1",
+        "EventName": "ARITH.FPU_DIV_ACTIVE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when divider is busy executing divide operations.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x89",
+        "PublicDescription": "This event counts the number of the divide operations executed.",
+        "EventCode": "0x14",
         "Counter": "0,1,2,3",
-        "UMask": "0x84",
-        "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Taken speculative and retired mispredicted indirect branches excluding calls and returns.",
+        "UMask": "0x1",
+        "EdgeDetect": "1",
+        "EventName": "ARITH.FPU_DIV",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Divide operations executed.",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x89",
+        "EventCode": "0x3C",
         "Counter": "0,1,2,3",
-        "UMask": "0x88",
-        "EventName": "BR_MISP_EXEC.TAKEN_RETURN_NEAR",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Taken speculative and retired mispredicted indirect branches with return mnemonic.",
+        "UMask": "0x0",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Thread cycles when thread is not in halt state.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x89",
+        "EventCode": "0x3C",
         "Counter": "0,1,2,3",
-        "UMask": "0x90",
-        "EventName": "BR_MISP_EXEC.TAKEN_DIRECT_NEAR_CALL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Taken speculative and retired mispredicted direct near calls.",
+        "UMask": "0x0",
+        "AnyThread": "1",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x89",
+        "EventCode": "0x3C",
         "Counter": "0,1,2,3",
-        "UMask": "0xa0",
-        "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_NEAR_CALL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Taken speculative and retired mispredicted indirect calls.",
+        "UMask": "0x1",
+        "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Reference cycles when the thread is unhalted (counts at 100 MHz rate).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x89",
+        "EventCode": "0x3C",
         "Counter": "0,1,2,3",
-        "UMask": "0xc1",
-        "EventName": "BR_MISP_EXEC.ALL_CONDITIONAL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Speculative and retired mispredicted macro conditional branches.",
+        "UMask": "0x1",
+        "AnyThread": "1",
+        "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Reference cycles when the at least one thread on the physical core is unhalted (counts at 100 MHz rate).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x89",
+        "PublicDescription": "Reference cycles when the thread is unhalted (counts at 100 MHz rate)",
+        "EventCode": "0x3C",
         "Counter": "0,1,2,3",
-        "UMask": "0xc4",
-        "EventName": "BR_MISP_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Mispredicted indirect branches excluding calls and returns.",
+        "UMask": "0x1",
+        "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Reference cycles when the thread is unhalted (counts at 100 MHz rate).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x89",
+        "EventCode": "0x3C",
         "Counter": "0,1,2,3",
-        "UMask": "0xd0",
-        "EventName": "BR_MISP_EXEC.ALL_DIRECT_NEAR_CALL",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Speculative and retired mispredicted direct near calls.",
+        "UMask": "0x1",
+        "AnyThread": "1",
+        "EventName": "CPU_CLK_UNHALTED.REF_XCLK_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Reference cycles when the at least one thread on the physical core is unhalted (counts at 100 MHz rate).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0x3C",
         "Counter": "0,1,2,3",
-        "UMask": "0x0",
-        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Thread cycles when thread is not in halt state.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xA8",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "LSD.UOPS",
+        "UMask": "0x2",
+        "EventName": "CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of Uops delivered by the LSD.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "BriefDescription": "Count XClk pulses when this thread is unhalted and the other is halted.",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0xA8",
+        "EventCode": "0x3C",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "LSD.CYCLES_ACTIVE",
+        "UMask": "0x2",
+        "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles Uops delivered by the LSD, but didn't come from the decoder.",
-        "CounterMask": "1",
+        "BriefDescription": "Count XClk pulses when this thread is unhalted and the other thread is halted.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x87",
+        "EventCode": "0x4C",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "ILD_STALL.LCP",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Stalls caused by changing prefix length of the instruction.",
+        "EventName": "LOAD_HIT_PRE.SW_PF",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Not software-prefetch load dispatches that hit FB allocated for software prefetch.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x87",
+        "EventCode": "0x4C",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "ILD_STALL.IQ_FULL",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Stall cycles because IQ is full.",
+        "UMask": "0x2",
+        "EventName": "LOAD_HIT_PRE.HW_PF",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Not software-prefetch load dispatches that hit FB allocated for hardware prefetch.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x0D",
+        "EventCode": "0x59",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
-        "EventName": "INT_MISC.RAT_STALL_CYCLES",
+        "UMask": "0x20",
+        "EventName": "PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when Resource Allocation Table (RAT) external stall is sent to Instruction Decode Queue (IDQ) for the thread.",
+        "BriefDescription": "Increments the number of flags-merge uops in flight each cycle.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
+        "PublicDescription": "This event counts the number of cycles spent executing performance-sensitive flags-merging uops. For example, shift CL (merge_arith_flags). For more details, See the Intel\u00ae 64 and IA-32 Architectures Optimization Reference Manual.",
         "EventCode": "0x59",
         "Counter": "0,1,2,3",
         "UMask": "0x20",
-        "EventName": "PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP",
+        "EventName": "PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Increments the number of flags-merge uops in flight each cycle.",
+        "BriefDescription": "Performance sensitive flags-merging uops added by Sandy Bridge u-arch.",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts the number of cycles with at least one slow LEA uop being allocated. A uop is generally considered as slow LEA if it has three sources (for example, two sources and immediate) regardless of whether it is a result of LEA instruction or not. Examples of the slow LEA uop are or uops with base, index, and offset source operands using base and index reqisters, where base is EBR/RBP/R13, using RIP relative or 16-bit addressing modes. See the Intel? 64 and IA-32 Architectures Optimization Reference Manual for more details about slow LEA instructions.",
+        "PublicDescription": "This event counts the number of cycles with at least one slow LEA uop being allocated. A uop is generally considered as slow LEA if it has three sources (for example, two sources and immediate) regardless of whether it is a result of LEA instruction or not. Examples of the slow LEA uop are or uops with base, index, and offset source operands using base and index reqisters, where base is EBR/RBP/R13, using RIP relative or 16-bit addressing modes. See the Intel\u00ae 64 and IA-32 Architectures Optimization Reference Manual for more details about slow LEA instructions.",
         "EventCode": "0x59",
         "Counter": "0,1,2,3",
         "UMask": "0x40",
@@ -302,48 +320,21 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA2",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "RESOURCE_STALLS.ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Resource-related stall cycles.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xA2",
-        "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "RESOURCE_STALLS.LB",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Counts the cycles of stall due to lack of load buffers.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xA2",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "RESOURCE_STALLS.RS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles stalled due to no eligible RS entry available.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xA2",
+        "EventCode": "0x5B",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "RESOURCE_STALLS.SB",
+        "UMask": "0xc",
+        "EventName": "RESOURCE_STALLS2.ALL_FL_EMPTY",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles stalled due to no store buffers available. (not including draining form sync).",
+        "BriefDescription": "Cycles with either free list is empty.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA2",
+        "EventCode": "0x5B",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "RESOURCE_STALLS.ROB",
+        "UMask": "0xf",
+        "EventName": "RESOURCE_STALLS2.ALL_PRF_CONTROL",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles stalled due to re-order buffer full.",
+        "BriefDescription": "Resource stalls2 control structures full for physical registers.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -356,577 +347,609 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts the number of Uops issued by the front-end of the pipeilne to the back-end.",
-        "EventCode": "0x0E",
+        "EventCode": "0x5B",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "UOPS_ISSUED.ANY",
+        "UMask": "0x4f",
+        "EventName": "RESOURCE_STALLS2.OOO_RSRC",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops that Resource Allocation Table (RAT) issues to Reservation Station (RS).",
+        "BriefDescription": "Resource stalls out of order resources full.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x0E",
-        "Invert": "1",
+        "EventCode": "0x5E",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "UOPS_ISSUED.STALL_CYCLES",
+        "EventName": "RS_EVENTS.EMPTY_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when Resource Allocation Table (RAT) does not issue Uops to Reservation Station (RS) for the thread.",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3"
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty for the thread.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x0E",
+        "EventCode": "0x5E",
         "Invert": "1",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "AnyThread": "1",
-        "EventName": "UOPS_ISSUED.CORE_STALL_CYCLES",
+        "EdgeDetect": "1",
+        "EventName": "RS_EVENTS.EMPTY_END",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when Resource Allocation Table (RAT) does not issue Uops to Reservation Station (RS) for all threads.",
+        "BriefDescription": "Counts end of periods where the Reservation Station (RS) was empty. Could be useful to precisely locate Frontend Latency Bound issues.",
         "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3"
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x5E",
+        "EventCode": "0x87",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "RS_EVENTS.EMPTY_CYCLES",
+        "EventName": "ILD_STALL.LCP",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when Reservation Station (RS) is empty for the thread.",
+        "BriefDescription": "Stalls caused by changing prefix length of the instruction.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xCC",
+        "EventCode": "0x87",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "ROB_MISC_EVENTS.LBR_INSERTS",
+        "UMask": "0x4",
+        "EventName": "ILD_STALL.IQ_FULL",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Count cases of saving new LBR.",
+        "BriefDescription": "Stall cycles because IQ is full.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event is incremented when self-modifying code (SMC) is detected, which causes a machine clear.  Machine clears can have a significant performance impact if they are happening frequently.",
-        "EventCode": "0xC3",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "MACHINE_CLEARS.SMC",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Self-modifying code (SMC) detected.",
+        "UMask": "0x41",
+        "EventName": "BR_INST_EXEC.NONTAKEN_CONDITIONAL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Not taken macro-conditional branches.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Maskmov false fault - counts number of time ucode passes through Maskmov flow due to instruction's mask being 0 while the flow was completed without raising a fault.",
-        "EventCode": "0xC3",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "MACHINE_CLEARS.MASKMOV",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "This event counts the number of executed Intel AVX masked load operations that refer to an illegal address range with the mask bits set to 0.",
+        "UMask": "0x81",
+        "EventName": "BR_INST_EXEC.TAKEN_CONDITIONAL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Taken speculative and retired macro-conditional branches.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xC0",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x0",
-        "EventName": "INST_RETIRED.ANY_P",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of instructions retired. General Counter   - architectural event.",
+        "UMask": "0x82",
+        "EventName": "BR_INST_EXEC.TAKEN_DIRECT_JUMP",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Taken speculative and retired macro-conditional branch instructions excluding calls and indirects.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "PublicDescription": "This event counts the number of micro-ops retired.",
-        "EventCode": "0xC2",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "UOPS_RETIRED.ALL",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Actually retired uops.",
+        "UMask": "0x84",
+        "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Taken speculative and retired indirect branches excluding calls and returns.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "PublicDescription": "This event counts the number of retirement slots used each cycle.  There are potentially 4 slots that can be used each cycle - meaning, 4 micro-ops or 4 instructions could retire each cycle.  This event is used in determining the 'Retiring' category of the Top-Down pipeline slots characterization.",
-        "EventCode": "0xC2",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Retirement slots used.",
+        "UMask": "0x88",
+        "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_RETURN",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Taken speculative and retired indirect branches with return mnemonic.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xC2",
-        "Invert": "1",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "UOPS_RETIRED.STALL_CYCLES",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles without actually retired uops.",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0x90",
+        "EventName": "BR_INST_EXEC.TAKEN_DIRECT_NEAR_CALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Taken speculative and retired direct near calls.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xC2",
-        "Invert": "1",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles with less than 10 actually retired uops.",
-        "CounterMask": "10",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0xa0",
+        "EventName": "BR_INST_EXEC.TAKEN_INDIRECT_NEAR_CALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Taken speculative and retired indirect calls.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC4",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "BR_INST_RETIRED.CONDITIONAL",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "Conditional branch instructions retired.",
+        "UMask": "0xc1",
+        "EventName": "BR_INST_EXEC.ALL_CONDITIONAL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Speculative and retired macro-conditional branches.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC4",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "SampleAfterValue": "100007",
-        "BriefDescription": "Direct and indirect near call instructions retired.",
+        "UMask": "0xc2",
+        "EventName": "BR_INST_EXEC.ALL_DIRECT_JMP",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Speculative and retired macro-unconditional branches excluding calls and indirects.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xC4",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x0",
-        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "All (macro) branch instructions retired.",
+        "UMask": "0xc4",
+        "EventName": "BR_INST_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Speculative and retired indirect branches excluding calls and returns.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC4",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "SampleAfterValue": "100007",
-        "BriefDescription": "Return instructions retired.",
+        "UMask": "0xc8",
+        "EventName": "BR_INST_EXEC.ALL_INDIRECT_NEAR_RETURN",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Speculative and retired indirect return branches.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xC4",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "BR_INST_RETIRED.NOT_TAKEN",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "Not taken branch instructions retired.",
+        "UMask": "0xd0",
+        "EventName": "BR_INST_EXEC.ALL_DIRECT_NEAR_CALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Speculative and retired direct near calls.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC4",
+        "EventCode": "0x88",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "Taken branch instructions retired.",
+        "UMask": "0xff",
+        "EventName": "BR_INST_EXEC.ALL_BRANCHES",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Speculative and retired  branches.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xC4",
+        "EventCode": "0x89",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
-        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "SampleAfterValue": "100007",
-        "BriefDescription": "Far branch instructions retired.",
+        "UMask": "0x41",
+        "EventName": "BR_MISP_EXEC.NONTAKEN_CONDITIONAL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Not taken speculative and retired mispredicted macro conditional branches.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "2",
-        "EventCode": "0xC4",
+        "EventCode": "0x89",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "BR_INST_RETIRED.ALL_BRANCHES_PEBS",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "All (macro) branch instructions retired. (Precise Event - PEBS).",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0x81",
+        "EventName": "BR_MISP_EXEC.TAKEN_CONDITIONAL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Taken speculative and retired mispredicted macro conditional branches.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC5",
+        "EventCode": "0x89",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "BR_MISP_RETIRED.CONDITIONAL",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "Mispredicted conditional branch instructions retired.",
+        "UMask": "0x84",
+        "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_JUMP_NON_CALL_RET",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Taken speculative and retired mispredicted indirect branches excluding calls and returns.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC5",
+        "EventCode": "0x89",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "BR_MISP_RETIRED.NEAR_CALL",
-        "SampleAfterValue": "100007",
-        "BriefDescription": "Direct and indirect mispredicted near call instructions retired.",
+        "UMask": "0x88",
+        "EventName": "BR_MISP_EXEC.TAKEN_RETURN_NEAR",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Taken speculative and retired mispredicted indirect branches with return mnemonic.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xC5",
+        "EventCode": "0x89",
         "Counter": "0,1,2,3",
-        "UMask": "0x0",
-        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "All mispredicted macro branch instructions retired.",
+        "UMask": "0x90",
+        "EventName": "BR_MISP_EXEC.TAKEN_DIRECT_NEAR_CALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Taken speculative and retired mispredicted direct near calls.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC5",
+        "EventCode": "0x89",
         "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "BR_MISP_RETIRED.NOT_TAKEN",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "Mispredicted not taken branch instructions retired.",
+        "UMask": "0xa0",
+        "EventName": "BR_MISP_EXEC.TAKEN_INDIRECT_NEAR_CALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Taken speculative and retired mispredicted indirect calls.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "1",
-        "EventCode": "0xC5",
+        "EventCode": "0x89",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "BR_MISP_RETIRED.TAKEN",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "Mispredicted taken branch instructions retired.",
+        "UMask": "0xc1",
+        "EventName": "BR_MISP_EXEC.ALL_CONDITIONAL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Speculative and retired mispredicted macro conditional branches.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PEBS": "2",
-        "PublicDescription": "Mispredicted macro branch instructions retired. (Precise Event - PEBS)",
-        "EventCode": "0xC5",
+        "EventCode": "0x89",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_PEBS",
-        "SampleAfterValue": "400009",
-        "BriefDescription": "Mispredicted macro branch instructions retired. (Precise Event - PEBS).",
-        "CounterHTOff": "0,1,2,3"
+        "UMask": "0xc4",
+        "EventName": "BR_MISP_EXEC.ALL_INDIRECT_JUMP_NON_CALL_RET",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Mispredicted indirect branches excluding calls and returns.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xC1",
+        "EventCode": "0x89",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "OTHER_ASSISTS.ITLB_MISS_RETIRED",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Retired instructions experiencing ITLB misses.",
+        "UMask": "0xd0",
+        "EventName": "BR_MISP_EXEC.ALL_DIRECT_NEAR_CALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Speculative and retired mispredicted direct near calls.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x14",
+        "EventCode": "0x89",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "ARITH.FPU_DIV_ACTIVE",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles when divider is busy executing divide operations.",
+        "UMask": "0xff",
+        "EventName": "BR_MISP_EXEC.ALL_BRANCHES",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Speculative and retired mispredicted macro conditional branches.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts the number of the divide operations executed.",
-        "EventCode": "0x14",
+        "EventCode": "0xA1",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EdgeDetect": "1",
-        "EventName": "ARITH.FPU_DIV",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Divide operations executed.",
-        "CounterMask": "1",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_0",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles per thread when uops are dispatched to port 0.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xB1",
+        "EventCode": "0xA1",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "UOPS_DISPATCHED.THREAD",
+        "AnyThread": "1",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_0_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops dispatched per thread.",
+        "BriefDescription": "Cycles per core when uops are dispatched to port 0.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xB1",
+        "EventCode": "0xA1",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
-        "EventName": "UOPS_DISPATCHED.CORE",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_1",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Uops dispatched from any thread.",
+        "BriefDescription": "Cycles per thread when uops are dispatched to port 1.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_0",
+        "UMask": "0x2",
+        "AnyThread": "1",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_1_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when uops are dispatched to port 0.",
+        "BriefDescription": "Cycles per core when uops are dispatched to port 1.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_1",
+        "UMask": "0xc",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_2",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when uops are dispatched to port 1.",
+        "BriefDescription": "Cycles per thread when load or STA uops are dispatched to port 2.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_4",
+        "UMask": "0xc",
+        "AnyThread": "1",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_2_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when uops are dispatched to port 4.",
+        "BriefDescription": "Cycles per core when load or STA uops are dispatched to port 2.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x80",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_5",
+        "UMask": "0x30",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_3",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when uops are dispatched to port 5.",
+        "BriefDescription": "Cycles per thread when load or STA uops are dispatched to port 3.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA3",
+        "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x4",
-        "EventName": "CYCLE_ACTIVITY.CYCLES_NO_DISPATCH",
+        "UMask": "0x30",
+        "AnyThread": "1",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_3_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Each cycle there was no dispatch for this thread, increment by 1. Note this is connect to Umask 2. No dispatch can be deduced from the UOPS_EXECUTED event.",
-        "CounterMask": "4",
-        "CounterHTOff": "0,1,2,3"
+        "BriefDescription": "Cycles per core when load or STA uops are dispatched to port 3.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA3",
-        "Counter": "2",
-        "UMask": "0x2",
-        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_PENDING",
+        "EventCode": "0xA1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x40",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_4",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Each cycle there was a miss-pending demand load this thread, increment by 1. Note this is in DCU and connected to Umask 1. Miss Pending demand load should be deduced by OR-ing increment bits of DCACHE_MISS_PEND.PENDING.",
-        "CounterMask": "2",
-        "CounterHTOff": "2"
+        "BriefDescription": "Cycles per thread when uops are dispatched to port 4.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA3",
+        "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "CYCLE_ACTIVITY.CYCLES_L2_PENDING",
+        "UMask": "0x40",
+        "AnyThread": "1",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_4_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Each cycle there was a MLC-miss pending demand load this thread (i.e. Non-completed valid SQ entry allocated for demand load and waiting for Uncore), increment by 1. Note this is in MLC and connected to Umask 0.",
-        "CounterMask": "1",
+        "BriefDescription": "Cycles per core when uops are dispatched to port 4.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA3",
-        "Counter": "2",
-        "UMask": "0x6",
-        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_PENDING",
+        "EventCode": "0xA1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x80",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_5",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Each cycle there was a miss-pending demand load this thread and no uops dispatched, increment by 1. Note this is in DCU and connected to Umask 1 and 2. Miss Pending demand load should be deduced by OR-ing increment bits of DCACHE_MISS_PEND.PENDING.",
-        "CounterMask": "6",
-        "CounterHTOff": "2"
+        "BriefDescription": "Cycles per thread when uops are dispatched to port 5.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA3",
+        "EventCode": "0xA1",
         "Counter": "0,1,2,3",
-        "UMask": "0x5",
-        "EventName": "CYCLE_ACTIVITY.STALLS_L2_PENDING",
+        "UMask": "0x80",
+        "AnyThread": "1",
+        "EventName": "UOPS_DISPATCHED_PORT.PORT_5_CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Each cycle there was a MLC-miss pending demand load and no uops dispatched on this thread (i.e. Non-completed valid SQ entry allocated for demand load and waiting for Uncore), increment by 1. Note this is in MLC and connected to Umask 0 and 2.",
-        "CounterMask": "5",
-        "CounterHTOff": "0,1,2,3"
+        "BriefDescription": "Cycles per core when uops are dispatched to port 5.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x4C",
+        "EventCode": "0xA2",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "LOAD_HIT_PRE.SW_PF",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Not software-prefetch load dispatches that hit FB allocated for software prefetch.",
+        "EventName": "RESOURCE_STALLS.ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Resource-related stall cycles.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x4C",
+        "EventCode": "0xA2",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
-        "EventName": "LOAD_HIT_PRE.HW_PF",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Not software-prefetch load dispatches that hit FB allocated for hardware prefetch.",
+        "EventName": "RESOURCE_STALLS.LB",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts the cycles of stall due to lack of load buffers.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x03",
+        "EventCode": "0xA2",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "LD_BLOCKS.DATA_UNKNOWN",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Loads delayed due to SB blocks, preceding store operations with known addresses but unknown data.",
+        "UMask": "0x4",
+        "EventName": "RESOURCE_STALLS.RS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles stalled due to no eligible RS entry available.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts loads that followed a store to the same address, where the data could not be forwarded inside the pipeline from the store to the load.  The most common reason why store forwarding would be blocked is when a load's address range overlaps with a preceding smaller uncompleted store.  See the table of not supported store forwards in the Intel? 64 and IA-32 Architectures Optimization Reference Manual.  The penalty for blocked store forwarding is that the load must wait for the store to complete before it can be issued.",
-        "EventCode": "0x03",
+        "EventCode": "0xA2",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Cases when loads get true Block-on-Store blocking code preventing store forwarding.",
+        "UMask": "0x8",
+        "EventName": "RESOURCE_STALLS.SB",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles stalled due to no store buffers available. (not including draining form sync).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x03",
+        "EventCode": "0xA2",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "LD_BLOCKS.NO_SR",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "This event counts the number of times that split load operations are temporarily blocked because all resources for handling the split accesses are in use.",
+        "UMask": "0xa",
+        "EventName": "RESOURCE_STALLS.LB_SB",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Resource stalls due to load or store buffers all being in use.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x03",
+        "EventCode": "0xA2",
+        "Counter": "0,1,2,3",
+        "UMask": "0xe",
+        "EventName": "RESOURCE_STALLS.MEM_RS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Resource stalls due to memory buffers or Reservation Station (RS) being fully utilized.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xA2",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
-        "EventName": "LD_BLOCKS.ALL_BLOCK",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Number of cases where any load ends up with a valid block-code written to the load buffer (including blocks due to Memory Order Buffer (MOB), Data Cache Unit (DCU), TLB, but load has no DCU miss).",
+        "EventName": "RESOURCE_STALLS.ROB",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles stalled due to re-order buffer full.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Aliasing occurs when a load is issued after a store and their memory addresses are offset by 4K.  This event counts the number of loads that aliased with a preceding store, resulting in an extended address check in the pipeline.  The enhanced address check typically has a performance penalty of 5 cycles.",
-        "EventCode": "0x07",
+        "EventCode": "0xA2",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "False dependencies in MOB due to partial compare.",
+        "UMask": "0xf0",
+        "EventName": "RESOURCE_STALLS.OOO_RSRC",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Resource stalls due to Rob being full, FCSW, MXCSR and OTHER.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x07",
+        "EventCode": "0xA3",
         "Counter": "0,1,2,3",
-        "UMask": "0x8",
-        "EventName": "LD_BLOCKS_PARTIAL.ALL_STA_BLOCK",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "This event counts the number of times that load operations are temporarily blocked because of older stores, with addresses that are not yet known. A load operation may incur more than one block of this type.",
+        "UMask": "0x1",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L2_PENDING",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Each cycle there was a MLC-miss pending demand load this thread (i.e. Non-completed valid SQ entry allocated for demand load and waiting for Uncore), increment by 1. Note this is in MLC and connected to Umask 0.",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xB6",
+        "EventCode": "0xA3",
+        "Counter": "2",
+        "UMask": "0x2",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_PENDING",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Each cycle there was a miss-pending demand load this thread, increment by 1. Note this is in DCU and connected to Umask 1. Miss Pending demand load should be deduced by OR-ing increment bits of DCACHE_MISS_PEND.PENDING.",
+        "CounterMask": "2",
+        "CounterHTOff": "2"
+    },
+    {
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_NO_DISPATCH",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Each cycle there was no dispatch for this thread, increment by 1. Note this is connect to Umask 2. No dispatch can be deduced from the UOPS_EXECUTED event.",
+        "CounterMask": "4",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x5",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L2_PENDING",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Each cycle there was a MLC-miss pending demand load and no uops dispatched on this thread (i.e. Non-completed valid SQ entry allocated for demand load and waiting for Uncore), increment by 1. Note this is in MLC and connected to Umask 0 and 2.",
+        "CounterMask": "5",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "EventCode": "0xA3",
+        "Counter": "2",
+        "UMask": "0x6",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_PENDING",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Each cycle there was a miss-pending demand load this thread and no uops dispatched, increment by 1. Note this is in DCU and connected to Umask 1 and 2. Miss Pending demand load should be deduced by OR-ing increment bits of DCACHE_MISS_PEND.PENDING.",
+        "CounterMask": "6",
+        "CounterHTOff": "2"
+    },
+    {
+        "EventCode": "0xA8",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "AGU_BYPASS_CANCEL.COUNT",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "This event counts executed load operations with all the following traits: 1. addressing of the format [base + offset], 2. the offset is between 1 and 2047, 3. the address specified in the base register is in one page and the address [base+offset] is in an.",
+        "EventName": "LSD.UOPS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of Uops delivered by the LSD.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x3C",
+        "EventCode": "0xA8",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK",
+        "EventName": "LSD.CYCLES_ACTIVE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Reference cycles when the thread is unhalted (counts at 100 MHz rate).",
+        "BriefDescription": "Cycles Uops delivered by the LSD, but didn't come from the decoder.",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x3C",
+        "EventCode": "0xA8",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "CPU_CLK_THREAD_UNHALTED.ONE_THREAD_ACTIVE",
+        "UMask": "0x1",
+        "EventName": "LSD.CYCLES_4_UOPS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Count XClk pulses when this thread is unhalted and the other is halted.",
-        "CounterHTOff": "0,1,2,3"
+        "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn't come from the decoder.",
+        "CounterMask": "4",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA1",
+        "EventCode": "0xB1",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_0_CORE",
+        "EventName": "UOPS_DISPATCHED.THREAD",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per core when uops are dispatched to port 0.",
+        "BriefDescription": "Uops dispatched per thread.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA1",
+        "EventCode": "0xB1",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
-        "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_1_CORE",
+        "EventName": "UOPS_DISPATCHED.CORE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per core when uops are dispatched to port 1.",
+        "BriefDescription": "Uops dispatched from any thread.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA1",
+        "EventCode": "0xB1",
         "Counter": "0,1,2,3",
-        "UMask": "0x40",
-        "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_4_CORE",
+        "UMask": "0x2",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per core when uops are dispatched to port 4.",
+        "BriefDescription": "Cycles at least 1 micro-op is executed from any thread on physical core.",
+        "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA1",
+        "EventCode": "0xB1",
         "Counter": "0,1,2,3",
-        "UMask": "0x80",
-        "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_5_CORE",
+        "UMask": "0x2",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per core when uops are dispatched to port 5.",
+        "BriefDescription": "Cycles at least 2 micro-op is executed from any thread on physical core.",
+        "CounterMask": "2",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA1",
+        "EventCode": "0xB1",
         "Counter": "0,1,2,3",
-        "UMask": "0xc",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_2",
+        "UMask": "0x2",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when load or STA uops are dispatched to port 2.",
+        "BriefDescription": "Cycles at least 3 micro-op is executed from any thread on physical core.",
+        "CounterMask": "3",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA1",
+        "EventCode": "0xB1",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_3",
+        "UMask": "0x2",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per thread when load or STA uops are dispatched to port 3.",
+        "BriefDescription": "Cycles at least 4 micro-op is executed from any thread on physical core.",
+        "CounterMask": "4",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA1",
+        "EventCode": "0xB1",
+        "Invert": "1",
         "Counter": "0,1,2,3",
-        "UMask": "0xc",
-        "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_2_CORE",
+        "UMask": "0x2",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_NONE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per core when load or STA uops are dispatched to port 2.",
+        "BriefDescription": "Cycles with no micro-ops executed from any thread on physical core.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA1",
+        "EventCode": "0xB6",
         "Counter": "0,1,2,3",
-        "UMask": "0x30",
-        "AnyThread": "1",
-        "EventName": "UOPS_DISPATCHED_PORT.PORT_3_CORE",
+        "UMask": "0x1",
+        "EventName": "AGU_BYPASS_CANCEL.COUNT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "This event counts executed load operations with all the following traits: 1. addressing of the format [base + offset], 2. the offset is between 1 and 2047, 3. the address specified in the base register is in one page and the address [base+offset] is in an.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xC0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x0",
+        "EventName": "INST_RETIRED.ANY_P",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles per core when load or STA uops are dispatched to port 3.",
+        "BriefDescription": "Number of instructions retired. General Counter   - architectural event.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -941,280 +964,263 @@
         "CounterHTOff": "1"
     },
     {
-        "EventCode": "0x5B",
+        "EventCode": "0xC1",
         "Counter": "0,1,2,3",
-        "UMask": "0xf",
-        "EventName": "RESOURCE_STALLS2.ALL_PRF_CONTROL",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Resource stalls2 control structures full for physical registers.",
+        "UMask": "0x2",
+        "EventName": "OTHER_ASSISTS.ITLB_MISS_RETIRED",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired instructions experiencing ITLB misses.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x5B",
+        "PEBS": "1",
+        "PublicDescription": "This event counts the number of micro-ops retired. (Precise Event)",
+        "EventCode": "0xC2",
         "Counter": "0,1,2,3",
-        "UMask": "0xc",
-        "EventName": "RESOURCE_STALLS2.ALL_FL_EMPTY",
+        "UMask": "0x1",
+        "EventName": "UOPS_RETIRED.ALL",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles with either free list is empty.",
+        "BriefDescription": "Actually retired uops. (Precise Event - PEBS).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA2",
+        "EventCode": "0xC2",
+        "Invert": "1",
         "Counter": "0,1,2,3",
-        "UMask": "0xe",
-        "EventName": "RESOURCE_STALLS.MEM_RS",
+        "UMask": "0x1",
+        "EventName": "UOPS_RETIRED.STALL_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Resource stalls due to memory buffers or Reservation Station (RS) being fully utilized.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "BriefDescription": "Cycles without actually retired uops.",
+        "CounterMask": "1",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0xA2",
+        "EventCode": "0xC2",
+        "Invert": "1",
         "Counter": "0,1,2,3",
-        "UMask": "0xf0",
-        "EventName": "RESOURCE_STALLS.OOO_RSRC",
+        "UMask": "0x1",
+        "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Resource stalls due to Rob being full, FCSW, MXCSR and OTHER.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x5B",
-        "Counter": "0,1,2,3",
-        "UMask": "0x4f",
-        "EventName": "RESOURCE_STALLS2.OOO_RSRC",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Resource stalls out of order resources full.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0xA2",
-        "Counter": "0,1,2,3",
-        "UMask": "0xa",
-        "EventName": "RESOURCE_STALLS.LB_SB",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Resource stalls due to load or store buffers all being in use.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "BriefDescription": "Cycles with less than 10 actually retired uops.",
+        "CounterMask": "10",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x0D",
+        "EventCode": "0xC2",
+        "Invert": "1",
         "Counter": "0,1,2,3",
-        "UMask": "0x3",
-        "EventName": "INT_MISC.RECOVERY_CYCLES",
+        "UMask": "0x1",
+        "EventName": "UOPS_RETIRED.CORE_STALL_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of cycles waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
+        "BriefDescription": "Cycles without actually retired uops.",
         "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "This event counts the number of cycles spent executing performance-sensitive flags-merging uops. For example, shift CL (merge_arith_flags). For more details, See the Intel? 64 and IA-32 Architectures Optimization Reference Manual.",
-        "EventCode": "0x59",
+        "PEBS": "1",
+        "PublicDescription": "This event counts the number of retirement slots used each cycle.  There are potentially 4 slots that can be used each cycle - meaning, 4 micro-ops or 4 instructions could retire each cycle.  This event is used in determining the 'Retiring' category of the Top-Down pipeline slots characterization. (Precise Event - PEBS)",
+        "EventCode": "0xC2",
         "Counter": "0,1,2,3",
-        "UMask": "0x20",
-        "EventName": "PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP_CYCLES",
+        "UMask": "0x2",
+        "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Performance sensitive flags-merging uops added by Sandy Bridge u-arch.",
-        "CounterMask": "1",
+        "BriefDescription": "Retirement slots used. (Precise Event - PEBS).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x0D",
+        "EventCode": "0xc3",
         "Counter": "0,1,2,3",
-        "UMask": "0x3",
+        "UMask": "0x1",
         "EdgeDetect": "1",
-        "EventName": "INT_MISC.RECOVERY_STALLS_COUNT",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of occurences waiting for the checkpoints in Resource Allocation Table (RAT) to be recovered after Nuke due to all other cases except JEClear (e.g. whenever a ucode assist is needed like SSE exception, memory disambiguation, etc...).",
+        "EventName": "MACHINE_CLEARS.COUNT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of machine clears (nukes) of any type.",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xE6",
+        "PublicDescription": "This event is incremented when self-modifying code (SMC) is detected, which causes a machine clear.  Machine clears can have a significant performance impact if they are happening frequently.",
+        "EventCode": "0xC3",
         "Counter": "0,1,2,3",
-        "UMask": "0x1f",
-        "EventName": "BACLEARS.ANY",
+        "UMask": "0x4",
+        "EventName": "MACHINE_CLEARS.SMC",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end.",
+        "BriefDescription": "Self-modifying code (SMC) detected.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x88",
+        "PublicDescription": "Maskmov false fault - counts number of time ucode passes through Maskmov flow due to instruction's mask being 0 while the flow was completed without raising a fault.",
+        "EventCode": "0xC3",
         "Counter": "0,1,2,3",
-        "UMask": "0xff",
-        "EventName": "BR_INST_EXEC.ALL_BRANCHES",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Speculative and retired  branches.",
+        "UMask": "0x20",
+        "EventName": "MACHINE_CLEARS.MASKMOV",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "This event counts the number of executed Intel AVX masked load operations that refer to an illegal address range with the mask bits set to 0.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x89",
+        "EventCode": "0xC4",
         "Counter": "0,1,2,3",
-        "UMask": "0xff",
-        "EventName": "BR_MISP_EXEC.ALL_BRANCHES",
-        "SampleAfterValue": "200003",
-        "BriefDescription": "Speculative and retired mispredicted macro conditional branches.",
+        "UMask": "0x0",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "All (macro) branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xC2",
-        "Invert": "1",
+        "PEBS": "1",
+        "EventCode": "0xC4",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "UOPS_RETIRED.CORE_STALL_CYCLES",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles without actually retired uops.",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3"
+        "EventName": "BR_INST_RETIRED.CONDITIONAL",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Conditional branch instructions retired. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA8",
+        "PEBS": "1",
+        "EventCode": "0xC4",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "LSD.CYCLES_4_UOPS",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles 4 Uops delivered by the LSD, but didn't come from the decoder.",
-        "CounterMask": "4",
+        "UMask": "0x2",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Direct and indirect near call instructions retired. (Precise Event - PEBS).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xc3",
+        "PEBS": "1",
+        "EventCode": "0xC4",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EdgeDetect": "1",
-        "EventName": "MACHINE_CLEARS.COUNT",
-        "SampleAfterValue": "100003",
-        "BriefDescription": "Number of machine clears (nukes) of any type.",
-        "CounterMask": "1",
+        "UMask": "0x2",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL_R3",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Direct and indirect macro near call instructions retired (captured in ring 3). (Precise Event - PEBS).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x5E",
-        "Invert": "1",
+        "PEBS": "2",
+        "EventCode": "0xC4",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EdgeDetect": "1",
-        "EventName": "RS_EVENTS.EMPTY_END",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Counts end of periods where the Reservation Station (RS) was empty. Could be useful to precisely locate Frontend Latency Bound issues.",
-        "CounterMask": "1",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES_PEBS",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "All (macro) branch instructions retired. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0x00",
-        "Counter": "Fixed counter 2",
-        "UMask": "0x2",
-        "AnyThread": "1",
-        "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
-        "CounterHTOff": "Fixed counter 2"
+        "PEBS": "1",
+        "EventCode": "0xC4",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Return instructions retired. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x3C",
+        "EventCode": "0xC4",
         "Counter": "0,1,2,3",
-        "UMask": "0x0",
-        "AnyThread": "1",
-        "EventName": "CPU_CLK_UNHALTED.THREAD_P_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
+        "UMask": "0x10",
+        "EventName": "BR_INST_RETIRED.NOT_TAKEN",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Not taken branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x3C",
+        "PEBS": "1",
+        "EventCode": "0xC4",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "AnyThread": "1",
-        "EventName": "CPU_CLK_THREAD_UNHALTED.REF_XCLK_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Reference cycles when the at least one thread on the physical core is unhalted (counts at 100 MHz rate).",
+        "UMask": "0x20",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Taken branch instructions retired. (Precise Event - PEBS).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x0D",
+        "EventCode": "0xC4",
         "Counter": "0,1,2,3",
-        "UMask": "0x3",
-        "AnyThread": "1",
-        "EventName": "INT_MISC.RECOVERY_CYCLES_ANY",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Core cycles the allocator was stalled due to recovery from earlier clear event for any thread running on the physical core (e.g. misprediction or memory nuke).",
-        "CounterMask": "1",
+        "UMask": "0x40",
+        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Far branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xB1",
+        "EventCode": "0xC5",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles at least 1 micro-op is executed from any thread on physical core.",
-        "CounterMask": "1",
+        "UMask": "0x0",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "All mispredicted macro branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xB1",
+        "PEBS": "1",
+        "EventCode": "0xC5",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles at least 2 micro-op is executed from any thread on physical core.",
-        "CounterMask": "2",
+        "UMask": "0x1",
+        "EventName": "BR_MISP_RETIRED.CONDITIONAL",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Mispredicted conditional branch instructions retired. (Precise Event - PEBS).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xB1",
+        "PEBS": "1",
+        "EventCode": "0xC5",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
-        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles at least 3 micro-op is executed from any thread on physical core.",
-        "CounterMask": "3",
+        "EventName": "BR_MISP_RETIRED.NEAR_CALL",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Direct and indirect mispredicted near call instructions retired. (Precise Event - PEBS).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xB1",
+        "PEBS": "2",
+        "PublicDescription": "Mispredicted macro branch instructions retired. (Precise Event - PEBS)",
+        "EventCode": "0xC5",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles at least 4 micro-op is executed from any thread on physical core.",
-        "CounterMask": "4",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
+        "UMask": "0x4",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_PEBS",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Mispredicted macro branch instructions retired. (Precise Event - PEBS).",
+        "CounterHTOff": "0,1,2,3"
     },
     {
-        "EventCode": "0xB1",
-        "Invert": "1",
+        "PEBS": "1",
+        "EventCode": "0xC5",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "UOPS_EXECUTED.CORE_CYCLES_NONE",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles with no micro-ops executed from any thread on physical core.",
+        "UMask": "0x10",
+        "EventName": "BR_MISP_RETIRED.NOT_TAKEN",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Mispredicted not taken branch instructions retired.(Precise Event - PEBS).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Reference cycles when the thread is unhalted (counts at 100 MHz rate)",
-        "EventCode": "0x3C",
+        "PEBS": "1",
+        "EventCode": "0xC5",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Reference cycles when the thread is unhalted (counts at 100 MHz rate).",
+        "UMask": "0x20",
+        "EventName": "BR_MISP_RETIRED.TAKEN",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Mispredicted taken branch instructions retired. (Precise Event - PEBS).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x3C",
+        "EventCode": "0xCC",
         "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "AnyThread": "1",
-        "EventName": "CPU_CLK_UNHALTED.REF_XCLK_ANY",
+        "UMask": "0x20",
+        "EventName": "ROB_MISC_EVENTS.LBR_INSERTS",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Reference cycles when the at least one thread on the physical core is unhalted (counts at 100 MHz rate).",
+        "BriefDescription": "Count cases of saving new LBR.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x3C",
+        "EventCode": "0xE6",
         "Counter": "0,1,2,3",
-        "UMask": "0x2",
-        "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Count XClk pulses when this thread is unhalted and the other thread is halted.",
+        "UMask": "0x1f",
+        "EventName": "BACLEARS.ANY",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json b/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
index a654ab771fce..b8eccce5d75d 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
@@ -1,131 +1,131 @@
 [
     {
-        "EventCode": "0xAE",
-        "Counter": "0,1,2,3",
-        "UMask": "0x1",
-        "EventName": "ITLB.ITLB_FLUSH",
-        "SampleAfterValue": "100007",
-        "BriefDescription": "Flushing of the Instruction TLB (ITLB) pages, includes 4k/2M/4M pages.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x4F",
-        "Counter": "0,1,2,3",
-        "UMask": "0x10",
-        "EventName": "EPT.WALK_CYCLES",
-        "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycle count for an Extended Page table walk.  The Extended Page Directory cache is used by Virtual Machine operating systems while the guest operating systems use the standard TLB caches.",
-        "CounterHTOff": "0,1,2,3,4,5,6,7"
-    },
-    {
-        "EventCode": "0x85",
+        "EventCode": "0x08",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "ITLB_MISSES.MISS_CAUSES_A_WALK",
+        "EventName": "DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Misses at all ITLB levels that cause page walks.",
+        "BriefDescription": "Load misses in all DTLB levels that cause page walks.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x85",
+        "EventCode": "0x08",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
-        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Misses in all ITLB levels that cause completed page walks.",
+        "BriefDescription": "Load misses at all DTLB levels that cause completed page walks.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event count cycles when Page Miss Handler (PMH) is servicing page walks caused by ITLB misses.",
-        "EventCode": "0x85",
+        "PublicDescription": "This event counts cycles when the  page miss handler (PMH) is servicing page walks caused by DTLB load misses.",
+        "EventCode": "0x08",
         "Counter": "0,1,2,3",
         "UMask": "0x4",
-        "EventName": "ITLB_MISSES.WALK_DURATION",
+        "EventName": "DTLB_LOAD_MISSES.WALK_DURATION",
         "SampleAfterValue": "2000003",
         "BriefDescription": "Cycles when PMH is busy with page walks.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x85",
+        "PublicDescription": "This event counts load operations that miss the first DTLB level but hit the second and do not cause any page walks. The penalty in this case is approximately 7 cycles.",
+        "EventCode": "0x08",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
-        "EventName": "ITLB_MISSES.STLB_HIT",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Operations that miss the first ITLB level but hit the second and do not cause any page walks.",
+        "BriefDescription": "Load operations that miss the first DTLB level but hit the second and do not cause page walks.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x08",
+        "EventCode": "0x49",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "DTLB_LOAD_MISSES.MISS_CAUSES_A_WALK",
+        "EventName": "DTLB_STORE_MISSES.MISS_CAUSES_A_WALK",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Load misses in all DTLB levels that cause page walks.",
+        "BriefDescription": "Store misses in all DTLB levels that cause page walks.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x08",
+        "EventCode": "0x49",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
-        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Load misses at all DTLB levels that cause completed page walks.",
+        "BriefDescription": "Store misses in all DTLB levels that cause completed page walks.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts cycles when the  page miss handler (PMH) is servicing page walks caused by DTLB load misses.",
-        "EventCode": "0x08",
+        "EventCode": "0x49",
         "Counter": "0,1,2,3",
         "UMask": "0x4",
-        "EventName": "DTLB_LOAD_MISSES.WALK_DURATION",
+        "EventName": "DTLB_STORE_MISSES.WALK_DURATION",
         "SampleAfterValue": "2000003",
         "BriefDescription": "Cycles when PMH is busy with page walks.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts load operations that miss the first DTLB level but hit the second and do not cause any page walks. The penalty in this case is approximately 7 cycles.",
-        "EventCode": "0x08",
+        "EventCode": "0x49",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
-        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Load operations that miss the first DTLB level but hit the second and do not cause page walks.",
+        "BriefDescription": "Store operations that miss the first TLB level but hit the second and do not cause page walks.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x49",
+        "EventCode": "0x4F",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "EventName": "EPT.WALK_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycle count for an Extended Page table walk.  The Extended Page Directory cache is used by Virtual Machine operating systems while the guest operating systems use the standard TLB caches.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0x85",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "DTLB_STORE_MISSES.MISS_CAUSES_A_WALK",
+        "EventName": "ITLB_MISSES.MISS_CAUSES_A_WALK",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Store misses in all DTLB levels that cause page walks.",
+        "BriefDescription": "Misses at all ITLB levels that cause page walks.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x49",
+        "EventCode": "0x85",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
-        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Store misses in all DTLB levels that cause completed page walks.",
+        "BriefDescription": "Misses in all ITLB levels that cause completed page walks.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x49",
+        "PublicDescription": "This event count cycles when Page Miss Handler (PMH) is servicing page walks caused by ITLB misses.",
+        "EventCode": "0x85",
         "Counter": "0,1,2,3",
         "UMask": "0x4",
-        "EventName": "DTLB_STORE_MISSES.WALK_DURATION",
+        "EventName": "ITLB_MISSES.WALK_DURATION",
         "SampleAfterValue": "2000003",
         "BriefDescription": "Cycles when PMH is busy with page walks.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0x49",
+        "EventCode": "0x85",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
-        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
+        "EventName": "ITLB_MISSES.STLB_HIT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Store operations that miss the first TLB level but hit the second and do not cause page walks.",
+        "BriefDescription": "Operations that miss the first ITLB level but hit the second and do not cause any page walks.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
+    {
+        "EventCode": "0xAE",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "ITLB.ITLB_FLUSH",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Flushing of the Instruction TLB (ITLB) pages, includes 4k/2M/4M pages.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-- 
2.20.1

