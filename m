Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0222C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23510206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221359;
	bh=ykxQ9k3DvZk/Hzq6DlN/oG8rsqvI2DjX3QJPRsfLMpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jQ0iO7y7izPZAvIs7/JCVUixTcnS8a8/VBNK1YcwDFoQLhcxthcRwuJsnHMmDuXhA
	 qO5c4XmchOKxGYyWQdQ2Id/iaIMHi/Oo01mlna9Vve6tKS6zrjIpAKuVtu/K2mQpD2
	 7owFfFpGfWpuCxEE1l+FQConGTr6X7IBsezv5fuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbfDBQJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731490AbfDBQH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:07:57 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3A22084C;
        Tue,  2 Apr 2019 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221273;
        bh=ykxQ9k3DvZk/Hzq6DlN/oG8rsqvI2DjX3QJPRsfLMpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxsWWNbRwv9jAFUjtoF4ZbfdHqGTIK9BqGqNI3Eux+TeMHt78P1TOTfq7Zi0bZhSG
         A5g2DcGyhmx6LZyUJ1TDM1QFs5z3X6DmTdmfGvFHGf8a5/0WMZKdzaJXrFSUhqjjZc
         W3zB1D7L2N8EkBoP6Z6WZHdMMhoES/0aJ1OiIY5A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 34/44] perf vendor events intel: Update HaswellX events to v20
Date:   Tue,  2 Apr 2019 13:05:39 -0300
Message-Id: <20190402160549.13544-35-acme@kernel.org>
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
 .../pmu-events/arch/x86/haswellx/cache.json   | 173 +++++++++---------
 .../pmu-events/arch/x86/haswellx/memory.json  | 172 ++++++++---------
 .../arch/x86/haswellx/pipeline.json           |  10 +-
 3 files changed, 177 insertions(+), 178 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswellx/cache.json b/tools/perf/pmu-events/arch/x86/haswellx/cache.json
index b2fbd617306a..a9e62d4357af 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/cache.json
@@ -64,18 +64,18 @@
     },
     {
         "EventCode": "0x24",
-        "UMask": "0x41",
+        "UMask": "0xc1",
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
         "Counter": "0,1,2,3",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "Errata": "HSD78",
-        "PublicDescription": "Demand data read requests that hit L2 cache.",
+        "PublicDescription": "Counts the number of demand Data Read requests, initiated by load instructions, that hit L2 cache",
         "SampleAfterValue": "200003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0x24",
-        "UMask": "0x42",
+        "UMask": "0xc2",
         "BriefDescription": "RFO requests that hit L2 cache",
         "Counter": "0,1,2,3",
         "EventName": "L2_RQSTS.RFO_HIT",
@@ -85,7 +85,7 @@
     },
     {
         "EventCode": "0x24",
-        "UMask": "0x44",
+        "UMask": "0xc4",
         "BriefDescription": "L2 cache hits when fetching instructions, code reads.",
         "Counter": "0,1,2,3",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
@@ -95,7 +95,7 @@
     },
     {
         "EventCode": "0x24",
-        "UMask": "0x50",
+        "UMask": "0xd0",
         "BriefDescription": "L2 prefetch requests that hit L2 cache",
         "Counter": "0,1,2,3",
         "EventName": "L2_RQSTS.L2_PF_HIT",
@@ -416,7 +416,7 @@
     {
         "EventCode": "0xD0",
         "UMask": "0x11",
-        "BriefDescription": "Retired load uops that miss the STLB. (precise Event)",
+        "BriefDescription": "Retired load uops that miss the STLB.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
@@ -428,7 +428,7 @@
     {
         "EventCode": "0xD0",
         "UMask": "0x12",
-        "BriefDescription": "Retired store uops that miss the STLB. (precise Event)",
+        "BriefDescription": "Retired store uops that miss the STLB.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
@@ -441,7 +441,7 @@
     {
         "EventCode": "0xD0",
         "UMask": "0x21",
-        "BriefDescription": "Retired load uops with locked access. (precise Event)",
+        "BriefDescription": "Retired load uops with locked access.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
@@ -453,34 +453,32 @@
     {
         "EventCode": "0xD0",
         "UMask": "0x41",
-        "BriefDescription": "Retired load uops that split across a cacheline boundary. (precise Event)",
+        "BriefDescription": "Retired load uops that split across a cacheline boundary.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
         "Errata": "HSD29, HSM30",
-        "PublicDescription": "This event counts load uops retired which had memory addresses spilt across 2 cache lines. A line split is across 64B cache-lines which may include a page split (4K). This is a precise event.",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD0",
         "UMask": "0x42",
-        "BriefDescription": "Retired store uops that split across a cacheline boundary. (precise Event)",
+        "BriefDescription": "Retired store uops that split across a cacheline boundary.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
         "Errata": "HSD29, HSM30",
         "L1_Hit_Indication": "1",
-        "PublicDescription": "This event counts store uops retired which had memory addresses spilt across 2 cache lines. A line split is across 64B cache-lines which may include a page split (4K). This is a precise event.",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD0",
         "UMask": "0x81",
-        "BriefDescription": "All retired load uops. (precise Event)",
+        "BriefDescription": "All retired load uops.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
@@ -492,14 +490,13 @@
     {
         "EventCode": "0xD0",
         "UMask": "0x82",
-        "BriefDescription": "All retired store uops. (precise Event)",
+        "BriefDescription": "All retired store uops.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "Errata": "HSD29, HSM30",
         "L1_Hit_Indication": "1",
-        "PublicDescription": "This event counts all store uops retired. This is a precise event.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -530,13 +527,13 @@
     {
         "EventCode": "0xD1",
         "UMask": "0x4",
-        "BriefDescription": "Miss in last-level (L3) cache. Excludes Unknown data-source.",
+        "BriefDescription": "Retired load uops which data sources were data hits in L3 without snoops required.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
         "Errata": "HSD74, HSD29, HSD25, HSM26, HSM30",
-        "PublicDescription": "This event counts retired load uops in which data sources were data hits in the L3 cache without snoops required. This does not include hardware prefetches. This is a precise event.",
+        "PublicDescription": "Retired load uops with L3 cache hits as data sources.",
         "SampleAfterValue": "50021",
         "CounterHTOff": "0,1,2,3"
     },
@@ -549,19 +546,20 @@
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
         "Errata": "HSM30",
-        "PublicDescription": "This event counts retired load uops in which data sources missed in the L1 cache. This does not include hardware prefetches. This is a precise event.",
+        "PublicDescription": "Retired load uops missed L1 cache as data sources.",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD1",
         "UMask": "0x10",
-        "BriefDescription": "Retired load uops with L2 cache misses as data sources.",
+        "BriefDescription": "Miss in mid-level (L2) cache. Excludes Unknown data-source.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
         "Errata": "HSD29, HSM30",
+        "PublicDescription": "Retired load uops missed L2. Unknown data source excluded.",
         "SampleAfterValue": "50021",
         "CounterHTOff": "0,1,2,3"
     },
@@ -574,6 +572,7 @@
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_MISS",
         "Errata": "HSD74, HSD29, HSD25, HSM26, HSM30",
+        "PublicDescription": "Retired load uops missed L3. Excludes unknown data source .",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -604,26 +603,24 @@
     {
         "EventCode": "0xD2",
         "UMask": "0x2",
-        "BriefDescription": "Retired load uops which data sources were L3 and cross-core snoop hits in on-pkg core cache. ",
+        "BriefDescription": "Retired load uops which data sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT",
         "Errata": "HSD29, HSD25, HSM26, HSM30",
-        "PublicDescription": "This event counts retired load uops that hit in the L3 cache, but required a cross-core snoop which resulted in a HIT in an on-pkg core cache. This does not include hardware prefetches. This is a precise event.",
         "SampleAfterValue": "20011",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD2",
         "UMask": "0x4",
-        "BriefDescription": "Retired load uops which data sources were HitM responses from shared L3. ",
+        "BriefDescription": "Retired load uops which data sources were HitM responses from shared L3.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM",
         "Errata": "HSD29, HSD25, HSM26, HSM30",
-        "PublicDescription": "This event counts retired load uops that hit in the L3 cache, but required a cross-core snoop which resulted in a HITM (hit modified) in an on-pkg core cache. This does not include hardware prefetches. This is a precise event.",
         "SampleAfterValue": "20011",
         "CounterHTOff": "0,1,2,3"
     },
@@ -642,19 +639,20 @@
     {
         "EventCode": "0xD3",
         "UMask": "0x1",
+        "BriefDescription": "Data from local DRAM either Snoop not needed or Snoop Miss (RspI)",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM",
         "Errata": "HSD74, HSD29, HSD25, HSM30",
-        "PublicDescription": "This event counts retired load uops where the data came from local DRAM. This does not include hardware prefetches. This is a precise event.",
+        "PublicDescription": "This event counts retired load uops where the data came from local DRAM. This does not include hardware prefetches.",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD3",
         "UMask": "0x4",
-        "BriefDescription": "Retired load uop whose Data Source was: remote DRAM either Snoop not needed or Snoop Miss (RspI) (Precise Event)",
+        "BriefDescription": "Retired load uop whose Data Source was: remote DRAM either Snoop not needed or Snoop Miss (RspI)",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
@@ -666,7 +664,7 @@
     {
         "EventCode": "0xD3",
         "UMask": "0x10",
-        "BriefDescription": "Retired load uop whose Data Source was: Remote cache HITM (Precise Event)",
+        "BriefDescription": "Retired load uop whose Data Source was: Remote cache HITM",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
@@ -678,7 +676,7 @@
     {
         "EventCode": "0xD3",
         "UMask": "0x20",
-        "BriefDescription": "Retired load uop whose Data Source was: forwarded from remote cache (Precise Event)",
+        "BriefDescription": "Retired load uop whose Data Source was: forwarded from remote cache",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
@@ -833,7 +831,6 @@
         "BriefDescription": "Split locks in SQ",
         "Counter": "0,1,2,3",
         "EventName": "SQ_MISC.SPLIT_LOCK",
-        "PublicDescription": "",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -841,12 +838,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts demand data reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "MSRValue": "0x04003c0001",
+        "BriefDescription": "Counts demand data reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "MSRValue": "0x04003C0001",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts demand data reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -854,12 +851,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts demand data reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "MSRValue": "0x10003c0001",
+        "BriefDescription": "Counts demand data reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "MSRValue": "0x10003C0001",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts demand data reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -867,12 +864,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "MSRValue": "0x04003c0002",
+        "BriefDescription": "Counts all demand data writes (RFOs) hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "MSRValue": "0x04003C0002",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand data writes (RFOs) that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs) hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -880,12 +877,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "MSRValue": "0x10003c0002",
+        "BriefDescription": "Counts all demand data writes (RFOs) hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "MSRValue": "0x10003C0002",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand data writes (RFOs) that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs) hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -893,12 +890,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand code reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "MSRValue": "0x04003c0004",
+        "BriefDescription": "Counts all demand code reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "MSRValue": "0x04003C0004",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand code reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -906,12 +903,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand code reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "MSRValue": "0x10003c0004",
+        "BriefDescription": "Counts all demand code reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "MSRValue": "0x10003C0004",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand code reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -919,12 +916,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that hit in the L3",
-        "MSRValue": "0x3f803c0010",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads hit in the L3",
+        "MSRValue": "0x3F803C0010",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data reads that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data reads hit in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -932,12 +929,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs that hit in the L3",
-        "MSRValue": "0x3f803c0020",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs hit in the L3",
+        "MSRValue": "0x3F803C0020",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) RFOs that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) RFOs hit in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -945,12 +942,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads that hit in the L3",
-        "MSRValue": "0x3f803c0040",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads hit in the L3",
+        "MSRValue": "0x3F803C0040",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) code reads that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) code reads hit in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -958,12 +955,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads that hit in the L3",
-        "MSRValue": "0x3f803c0080",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads hit in the L3",
+        "MSRValue": "0x3F803C0080",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) data reads that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) data reads hit in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -971,12 +968,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs that hit in the L3",
-        "MSRValue": "0x3f803c0100",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs hit in the L3",
+        "MSRValue": "0x3F803C0100",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_RFO.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) RFOs that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) RFOs hit in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -984,12 +981,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) code reads that hit in the L3",
-        "MSRValue": "0x3f803c0200",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only) code reads hit in the L3",
+        "MSRValue": "0x3F803C0200",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_CODE_RD.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only) code reads that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only) code reads hit in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -997,12 +994,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch data reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "MSRValue": "0x04003c0091",
+        "BriefDescription": "Counts all demand & prefetch data reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "MSRValue": "0x04003C0091",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch data reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -1010,12 +1007,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch data reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "MSRValue": "0x10003c0091",
+        "BriefDescription": "Counts all demand & prefetch data reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "MSRValue": "0x10003C0091",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch data reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -1023,12 +1020,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch RFOs that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "MSRValue": "0x04003c0122",
+        "BriefDescription": "Counts all demand & prefetch RFOs hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "MSRValue": "0x04003C0122",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch RFOs that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -1036,12 +1033,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch RFOs that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "MSRValue": "0x10003c0122",
+        "BriefDescription": "Counts all demand & prefetch RFOs hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "MSRValue": "0x10003C0122",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.LLC_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch RFOs that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -1049,12 +1046,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch code reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "MSRValue": "0x04003c0244",
+        "BriefDescription": "Counts all demand & prefetch code reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "MSRValue": "0x04003C0244",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch code reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch code reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -1062,12 +1059,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
-        "MSRValue": "0x04003c07f7",
+        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "MSRValue": "0x04003C07F7",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -1075,12 +1072,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
-        "MSRValue": "0x10003c07f7",
+        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "MSRValue": "0x10003C07F7",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.HITM_OTHER_CORE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -1088,12 +1085,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all requests that hit in the L3",
-        "MSRValue": "0x3f803c8fff",
+        "BriefDescription": "Counts all requests hit in the L3",
+        "MSRValue": "0x3F803C8FFF",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_REQUESTS.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all requests that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all requests hit in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     }
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/memory.json b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
index 56b0f24b8029..a42d5ce86b6f 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
@@ -291,7 +291,7 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 4.",
+        "BriefDescription": "Randomly selected loads with latency value being above 4.",
         "PEBS": "2",
         "MSRValue": "0x4",
         "Counter": "3",
@@ -305,7 +305,7 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 8.",
+        "BriefDescription": "Randomly selected loads with latency value being above 8.",
         "PEBS": "2",
         "MSRValue": "0x8",
         "Counter": "3",
@@ -319,7 +319,7 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 16.",
+        "BriefDescription": "Randomly selected loads with latency value being above 16.",
         "PEBS": "2",
         "MSRValue": "0x10",
         "Counter": "3",
@@ -333,7 +333,7 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 32.",
+        "BriefDescription": "Randomly selected loads with latency value being above 32.",
         "PEBS": "2",
         "MSRValue": "0x20",
         "Counter": "3",
@@ -347,7 +347,7 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 64.",
+        "BriefDescription": "Randomly selected loads with latency value being above 64.",
         "PEBS": "2",
         "MSRValue": "0x40",
         "Counter": "3",
@@ -361,7 +361,7 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 128.",
+        "BriefDescription": "Randomly selected loads with latency value being above 128.",
         "PEBS": "2",
         "MSRValue": "0x80",
         "Counter": "3",
@@ -375,7 +375,7 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 256.",
+        "BriefDescription": "Randomly selected loads with latency value being above 256.",
         "PEBS": "2",
         "MSRValue": "0x100",
         "Counter": "3",
@@ -389,7 +389,7 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 512.",
+        "BriefDescription": "Randomly selected loads with latency value being above 512.",
         "PEBS": "2",
         "MSRValue": "0x200",
         "Counter": "3",
@@ -404,12 +404,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts demand data reads that miss in the L3",
-        "MSRValue": "0x3fbfc00001",
+        "BriefDescription": "Counts demand data reads miss in the L3",
+        "MSRValue": "0x3FBFC00001",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts demand data reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -417,12 +417,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts demand data reads that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts demand data reads miss the L3 and the data is returned from local dram",
         "MSRValue": "0x0600400001",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts demand data reads that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -430,12 +430,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand data writes (RFOs) that miss in the L3",
-        "MSRValue": "0x3fbfc00002",
+        "BriefDescription": "Counts all demand data writes (RFOs) miss in the L3",
+        "MSRValue": "0x3FBFC00002",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand data writes (RFOs) that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs) miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -443,12 +443,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand data writes (RFOs) that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand data writes (RFOs) miss the L3 and the data is returned from local dram",
         "MSRValue": "0x0600400002",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand data writes (RFOs) that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs) miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -456,12 +456,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand data writes (RFOs) that miss the L3 and the modified data is transferred from remote cache",
-        "MSRValue": "0x103fc00002",
+        "BriefDescription": "Counts all demand data writes (RFOs) miss the L3 and the modified data is transferred from remote cache",
+        "MSRValue": "0x103FC00002",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.REMOTE_HITM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand data writes (RFOs) that miss the L3 and the modified data is transferred from remote cache Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs) miss the L3 and the modified data is transferred from remote cache",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -469,12 +469,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand code reads that miss in the L3",
-        "MSRValue": "0x3fbfc00004",
+        "BriefDescription": "Counts all demand code reads miss in the L3",
+        "MSRValue": "0x3FBFC00004",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand code reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -482,12 +482,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand code reads that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand code reads miss the L3 and the data is returned from local dram",
         "MSRValue": "0x0600400004",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand code reads that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -495,12 +495,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that miss in the L3",
-        "MSRValue": "0x3fbfc00010",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads miss in the L3",
+        "MSRValue": "0x3FBFC00010",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data reads miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -508,12 +508,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs that miss in the L3",
-        "MSRValue": "0x3fbfc00020",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs miss in the L3",
+        "MSRValue": "0x3FBFC00020",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) RFOs that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) RFOs miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -521,12 +521,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads that miss in the L3",
-        "MSRValue": "0x3fbfc00040",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads miss in the L3",
+        "MSRValue": "0x3FBFC00040",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) code reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) code reads miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -534,12 +534,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads that miss in the L3",
-        "MSRValue": "0x3fbfc00080",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads miss in the L3",
+        "MSRValue": "0x3FBFC00080",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_DATA_RD.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) data reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) data reads miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -547,12 +547,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs that miss in the L3",
-        "MSRValue": "0x3fbfc00100",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs miss in the L3",
+        "MSRValue": "0x3FBFC00100",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_RFO.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) RFOs that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) RFOs miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -560,12 +560,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) code reads that miss in the L3",
-        "MSRValue": "0x3fbfc00200",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only) code reads miss in the L3",
+        "MSRValue": "0x3FBFC00200",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.PF_LLC_CODE_RD.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only) code reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only) code reads miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -573,12 +573,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch data reads that miss in the L3",
-        "MSRValue": "0x3fbfc00091",
+        "BriefDescription": "Counts all demand & prefetch data reads miss in the L3",
+        "MSRValue": "0x3FBFC00091",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch data reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -586,12 +586,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch data reads that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch data reads miss the L3 and the data is returned from local dram",
         "MSRValue": "0x0600400091",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch data reads that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -599,12 +599,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch data reads that miss the L3 and the data is returned from remote dram",
-        "MSRValue": "0x063f800091",
+        "BriefDescription": "Counts all demand & prefetch data reads miss the L3 and the data is returned from remote dram",
+        "MSRValue": "0x063F800091",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.REMOTE_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch data reads that miss the L3 and the data is returned from remote dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads miss the L3 and the data is returned from remote dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -612,12 +612,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch data reads that miss the L3 and the modified data is transferred from remote cache",
-        "MSRValue": "0x103fc00091",
+        "BriefDescription": "Counts all demand & prefetch data reads miss the L3 and the modified data is transferred from remote cache",
+        "MSRValue": "0x103FC00091",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.REMOTE_HITM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch data reads that miss the L3 and the modified data is transferred from remote cache Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads miss the L3 and the modified data is transferred from remote cache",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -625,12 +625,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch data reads that miss the L3 and clean or shared data is transferred from remote cache",
-        "MSRValue": "0x083fc00091",
+        "BriefDescription": "Counts all demand & prefetch data reads miss the L3 and clean or shared data is transferred from remote cache",
+        "MSRValue": "0x083FC00091",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.REMOTE_HIT_FORWARD",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch data reads that miss the L3 and clean or shared data is transferred from remote cache Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads miss the L3 and clean or shared data is transferred from remote cache",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -638,12 +638,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch RFOs that miss in the L3",
-        "MSRValue": "0x3fbfc00122",
+        "BriefDescription": "Counts all demand & prefetch RFOs miss in the L3",
+        "MSRValue": "0x3FBFC00122",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch RFOs that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -651,12 +651,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch RFOs that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch RFOs miss the L3 and the data is returned from local dram",
         "MSRValue": "0x0600400122",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch RFOs that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -664,12 +664,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch code reads that miss in the L3",
-        "MSRValue": "0x3fbfc00244",
+        "BriefDescription": "Counts all demand & prefetch code reads miss in the L3",
+        "MSRValue": "0x3FBFC00244",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch code reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch code reads miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -677,12 +677,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch code reads that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch code reads miss the L3 and the data is returned from local dram",
         "MSRValue": "0x0600400244",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch code reads that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch code reads miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -690,12 +690,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss in the L3",
-        "MSRValue": "0x3fbfc007f7",
+        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) miss in the L3",
+        "MSRValue": "0x3FBFC007F7",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -703,12 +703,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the data is returned from local dram",
-        "MSRValue": "0x06004007f7",
+        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and the data is returned from local dram",
+        "MSRValue": "0x06004007F7",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -716,12 +716,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the data is returned from remote dram",
-        "MSRValue": "0x063f8007f7",
+        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and the data is returned from remote dram",
+        "MSRValue": "0x063F8007F7",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the data is returned from remote dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and the data is returned from remote dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -729,12 +729,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the modified data is transferred from remote cache",
-        "MSRValue": "0x103fc007f7",
+        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and the modified data is transferred from remote cache",
+        "MSRValue": "0x103FC007F7",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_HITM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the modified data is transferred from remote cache Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and the modified data is transferred from remote cache",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -742,12 +742,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and clean or shared data is transferred from remote cache",
-        "MSRValue": "0x083fc007f7",
+        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and clean or shared data is transferred from remote cache",
+        "MSRValue": "0x083FC007F7",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_HIT_FORWARD",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and clean or shared data is transferred from remote cache Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and clean or shared data is transferred from remote cache",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -755,12 +755,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all requests that miss in the L3",
-        "MSRValue": "0x3fbfc08fff",
+        "BriefDescription": "Counts all requests miss in the L3",
+        "MSRValue": "0x3FBFC08FFF",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_REQUESTS.LLC_MISS.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all requests that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all requests miss in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     }
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
index 8a18bfe9e3e4..26f2888341ee 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
@@ -1,6 +1,5 @@
 [
     {
-        "EventCode": "0x00",
         "UMask": "0x1",
         "BriefDescription": "Instructions retired from execution.",
         "Counter": "Fixed counter 0",
@@ -11,7 +10,6 @@
         "CounterHTOff": "Fixed counter 0"
     },
     {
-        "EventCode": "0x00",
         "UMask": "0x2",
         "BriefDescription": "Core cycles when the thread is not in halt state.",
         "Counter": "Fixed counter 1",
@@ -21,7 +19,6 @@
         "CounterHTOff": "Fixed counter 1"
     },
     {
-        "EventCode": "0x00",
         "UMask": "0x2",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
         "Counter": "Fixed counter 1",
@@ -31,7 +28,6 @@
         "CounterHTOff": "Fixed counter 1"
     },
     {
-        "EventCode": "0x00",
         "UMask": "0x3",
         "BriefDescription": "Reference cycles when the core is not in halt state.",
         "Counter": "Fixed counter 2",
@@ -1098,6 +1094,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "UOPS_RETIRED.ALL",
+        "PublicDescription": "Counts the number of micro-ops retired. Use Cmask=1 and invert to count active cycles or stalled cycles.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1142,6 +1139,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
+        "PublicDescription": "This event counts the number of retirement slots used each cycle.  There are potentially 4 slots that can be used each cycle - meaning, 4 uops or 4 instructions could retire each cycle.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1201,6 +1199,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
+        "PublicDescription": "Counts the number of conditional branch instructions retired.",
         "SampleAfterValue": "400009",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1241,6 +1240,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PublicDescription": "Counts the number of near return instructions retired.",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1261,6 +1261,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "PublicDescription": "Number of near taken branches retired.",
         "SampleAfterValue": "400009",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1312,6 +1313,7 @@
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "PublicDescription": "Number of near branch instructions retired that were taken but mispredicted.",
         "SampleAfterValue": "400009",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
-- 
2.20.1

