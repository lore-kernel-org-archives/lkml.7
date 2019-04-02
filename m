Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B4BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885F32084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221282;
	bh=poTimfobPizsMZweSjSebvizaJAZFpp1MHlET46VrpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFNqgBDOf3VlBzjkUPKvFTdEov7hMc4M0X87tHN0TOJ5ZQ0t2alNph0xCIA8QOfmB
	 aEpztiuUhgD+iOFZtOeYzQXuPKknVUg4tC6Y8Qgyb/U08ZldGqXHW4BM3aYzksmq+z
	 iyepuX2DLKE42vdQeIzytDjIs3YfriBZstgszGUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbfDBQIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbfDBQH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:07:56 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9812214AF;
        Tue,  2 Apr 2019 16:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221270;
        bh=poTimfobPizsMZweSjSebvizaJAZFpp1MHlET46VrpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fj11amWD+UBYkQhndr90DgmzJXpSxdXllMhSdnqDkc774n4xcggVdi76Ccw5XhdcX
         Ic2W9CJMMlX2/EEw0fhXaJaBT/ZNSjNMbRYed1Z+wwdHKuOXp9JjTgf2VNYHn4fTNO
         YWWtcDk8Rw07kEYof+qD3z8hrU6biQiRV3CwnZNc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 33/44] perf vendor events intel: Update BroadwellX events to v14
Date:   Tue,  2 Apr 2019 13:05:38 -0300
Message-Id: <20190402160549.13544-34-acme@kernel.org>
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
 .../pmu-events/arch/x86/broadwellx/cache.json | 161 +++++++++---------
 .../arch/x86/broadwellx/floating-point.json   |  16 +-
 .../arch/x86/broadwellx/memory.json           | 148 ++++++++--------
 .../arch/x86/broadwellx/pipeline.json         |  50 +++---
 4 files changed, 186 insertions(+), 189 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
index 141b1080429d..75a3098d5775 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
@@ -57,17 +57,17 @@
     },
     {
         "EventCode": "0x24",
-        "UMask": "0x41",
+        "UMask": "0xc1",
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
         "Counter": "0,1,2,3",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
-        "PublicDescription": "This event counts the number of demand Data Read requests that hit L2 cache. Only not rejected loads are counted.",
+        "PublicDescription": "Counts the number of demand Data Read requests, initiated by load instructions, that hit L2 cache.",
         "SampleAfterValue": "200003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0x24",
-        "UMask": "0x42",
+        "UMask": "0xc2",
         "BriefDescription": "RFO requests that hit L2 cache.",
         "Counter": "0,1,2,3",
         "EventName": "L2_RQSTS.RFO_HIT",
@@ -76,7 +76,7 @@
     },
     {
         "EventCode": "0x24",
-        "UMask": "0x44",
+        "UMask": "0xc4",
         "BriefDescription": "L2 cache hits when fetching instructions, code reads.",
         "Counter": "0,1,2,3",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
@@ -85,7 +85,7 @@
     },
     {
         "EventCode": "0x24",
-        "UMask": "0x50",
+        "UMask": "0xd0",
         "BriefDescription": "L2 prefetch requests that hit L2 cache",
         "Counter": "0,1,2,3",
         "EventName": "L2_RQSTS.L2_PF_HIT",
@@ -396,24 +396,24 @@
     {
         "EventCode": "0xD0",
         "UMask": "0x11",
-        "BriefDescription": "Retired load uops that miss the STLB. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops that miss the STLB.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts load uops with true STLB miss retired to the architected path. True STLB miss is an uop triggering page walk that gets completed without blocks, and later gets retired. This page walk can end up with or without a fault.",
+        "PublicDescription": "This event counts load uops with true STLB miss retired to the architected path. True STLB miss is an uop triggering page walk that gets completed without blocks, and later gets retired. This page walk can end up with or without a fault.",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD0",
         "UMask": "0x12",
-        "BriefDescription": "Retired store uops that miss the STLB. (Precise Event - PEBS)",
+        "BriefDescription": "Retired store uops that miss the STLB.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts store uops true STLB miss retired to the architected path. True STLB miss is an uop triggering page walk that gets completed without blocks, and later gets retired. This page walk can end up with or without a fault.",
+        "PublicDescription": "This event counts store uops with true STLB miss retired to the architected path. True STLB miss is an uop triggering page walk that gets completed without blocks, and later gets retired. This page walk can end up with or without a fault.",
         "SampleAfterValue": "100003",
         "L1_Hit_Indication": "1",
         "CounterHTOff": "0,1,2,3"
@@ -421,37 +421,37 @@
     {
         "EventCode": "0xD0",
         "UMask": "0x21",
-        "BriefDescription": "Retired load uops with locked access. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops with locked access.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
         "Errata": "BDM35",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts load uops with locked access retired to the architected path.",
+        "PublicDescription": "This event counts load uops with locked access retired to the architected path.",
         "SampleAfterValue": "100007",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD0",
         "UMask": "0x41",
-        "BriefDescription": "Retired load uops that split across a cacheline boundary.(Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops that split across a cacheline boundary.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-splitted load uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD0",
         "UMask": "0x42",
-        "BriefDescription": "Retired store uops that split across a cacheline boundary. (Precise Event - PEBS)",
+        "BriefDescription": "Retired store uops that split across a cacheline boundary.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts line-split store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
+        "PublicDescription": "This event counts line-splitted store uops retired to the architected path. A line split is across 64B cache-line which includes a page split (4K).",
         "SampleAfterValue": "100003",
         "L1_Hit_Indication": "1",
         "CounterHTOff": "0,1,2,3"
@@ -459,24 +459,24 @@
     {
         "EventCode": "0xD0",
         "UMask": "0x81",
-        "BriefDescription": "All retired load uops. (Precise Event - PEBS)",
+        "BriefDescription": "All retired load uops.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts load uops retired to the architected path with a filter on bits 0 and 1 applied.\nNote: This event ?ounts AVX-256bit load/store double-pump memory uops as a single uop at retirement. This event also counts SW prefetches.",
+        "PublicDescription": "This event counts load uops retired to the architected path with a filter on bits 0 and 1 applied.\nNote: This event counts AVX-256bit load/store double-pump memory uops as a single uop at retirement. This event also counts SW prefetches.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD0",
         "UMask": "0x82",
-        "BriefDescription": "Retired store uops that split across a cacheline boundary. (Precise Event - PEBS)",
+        "BriefDescription": "All retired store uops.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts store uops retired to the architected path with a filter on bits 0 and 1 applied.\nNote: This event ?ounts AVX-256bit load/store double-pump memory uops as a single uop at retirement.",
+        "PublicDescription": "This event counts store uops retired to the architected path with a filter on bits 0 and 1 applied.\nNote: This event counts AVX-256bit load/store double-pump memory uops as a single uop at retirement.",
         "SampleAfterValue": "2000003",
         "L1_Hit_Indication": "1",
         "CounterHTOff": "0,1,2,3"
@@ -484,69 +484,69 @@
     {
         "EventCode": "0xD1",
         "UMask": "0x1",
-        "BriefDescription": "Retired load uops with L1 cache hits as data sources. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops with L1 cache hits as data sources.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts retired load uops which data source were hits in the nearest-level (L1) cache.\nNote: Only two data-sources of L1/FB are applicable for AVX-256bit  even though the corresponding AVX load could be serviced by a deeper level in the memory hierarchy. Data source is reported for the Low-half load. This event also counts SW prefetches independent of the actual data source.",
+        "PublicDescription": "This event counts retired load uops which data sources were hits in the nearest-level (L1) cache.\nNote: Only two data-sources of L1/FB are applicable for AVX-256bit  even though the corresponding AVX load could be serviced by a deeper level in the memory hierarchy. Data source is reported for the Low-half load. This event also counts SW prefetches independent of the actual data source.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD1",
         "UMask": "0x2",
-        "BriefDescription": "Retired load uops with L2 cache hits as data sources. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops with L2 cache hits as data sources.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
         "Errata": "BDM35",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts retired load uops which data sources were hits in the mid-level (L2) cache.",
+        "PublicDescription": "This event counts retired load uops which data sources were hits in the mid-level (L2) cache.",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD1",
         "UMask": "0x4",
-        "BriefDescription": "Hit in last-level (L3) cache. Excludes Unknown data-source. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops which data sources were data hits in L3 without snoops required.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
         "Errata": "BDM100",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts retired load uops which data sources were data hits in the last-level (L3) cache without snoops required.",
+        "PublicDescription": "This event counts retired load uops which data sources were data hits in the last-level (L3) cache without snoops required.",
         "SampleAfterValue": "50021",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD1",
         "UMask": "0x8",
-        "BriefDescription": "Retired load uops misses in L1 cache as data sources. Uses PEBS.",
+        "BriefDescription": "Retired load uops misses in L1 cache as data sources.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts retired load uops which data sources were misses in the nearest-level (L1) cache. Counting excludes unknown and UC data source.",
+        "PublicDescription": "This event counts retired load uops which data sources were misses in the nearest-level (L1) cache. Counting excludes unknown and UC data source.",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD1",
         "UMask": "0x10",
-        "BriefDescription": "Retired load uops with L2 cache misses as data sources. Uses PEBS.",
+        "BriefDescription": "Miss in mid-level (L2) cache. Excludes Unknown data-source.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts retired load uops which data sources were misses in the mid-level (L2) cache. Counting excludes unknown and UC data source.",
+        "PublicDescription": "This event counts retired load uops which data sources were misses in the mid-level (L2) cache. Counting excludes unknown and UC data source.",
         "SampleAfterValue": "50021",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD1",
         "UMask": "0x20",
-        "BriefDescription": "Miss in last-level (L3) cache. Excludes Unknown data-source. (Precise Event - PEBS).",
+        "BriefDescription": "Miss in last-level (L3) cache. Excludes Unknown data-source.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
@@ -558,83 +558,84 @@
     {
         "EventCode": "0xD1",
         "UMask": "0x40",
-        "BriefDescription": "Retired load uops which data sources were load uops missed L1 but hit FB due to preceding miss to the same cache line with data not ready. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops which data sources were load uops missed L1 but hit FB due to preceding miss to the same cache line with data not ready.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_RETIRED.HIT_LFB",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts retired load uops which data sources were load uops missed L1 but hit a fill buffer due to a preceding miss to the same cache line with the data not ready.\nNote: Only two data-sources of L1/FB are applicable for AVX-256bit  even though the corresponding AVX load could be serviced by a deeper level in the memory hierarchy. Data source is reported for the Low-half load.",
+        "PublicDescription": "This event counts retired load uops which data sources were load uops missed L1 but hit a fill buffer due to a preceding miss to the same cache line with the data not ready.\nNote: Only two data-sources of L1/FB are applicable for AVX-256bit  even though the corresponding AVX load could be serviced by a deeper level in the memory hierarchy. Data source is reported for the Low-half load.",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD2",
         "UMask": "0x1",
-        "BriefDescription": "Retired load uops which data sources were L3 hit and cross-core snoop missed in on-pkg core cache. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops which data sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS",
         "Errata": "BDM100",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts retired load uops which data sources were L3 Hit and a cross-core snoop missed in the on-pkg core cache.",
+        "PublicDescription": "This event counts retired load uops which data sources were L3 Hit and a cross-core snoop missed in the on-pkg core cache.",
         "SampleAfterValue": "20011",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD2",
         "UMask": "0x2",
-        "BriefDescription": "Retired load uops which data sources were L3 and cross-core snoop hits in on-pkg core cache. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops which data sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT",
         "Errata": "BDM100",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts retired load uops which data sources were L3 hit and a cross-core snoop hit in the on-pkg core cache.",
+        "PublicDescription": "This event counts retired load uops which data sources were L3 hit and a cross-core snoop hit in the on-pkg core cache.",
         "SampleAfterValue": "20011",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD2",
         "UMask": "0x4",
-        "BriefDescription": "Retired load uops which data sources were HitM responses from shared L3. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops which data sources were HitM responses from shared L3.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM",
         "Errata": "BDM100",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts retired load uops which data sources were HitM responses from a core on same socket (shared L3).",
+        "PublicDescription": "This event counts retired load uops which data sources were HitM responses from a core on same socket (shared L3).",
         "SampleAfterValue": "20011",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD2",
         "UMask": "0x8",
-        "BriefDescription": "Retired load uops which data sources were hits in L3 without snoops required. (Precise Event - PEBS)",
+        "BriefDescription": "Retired load uops which data sources were hits in L3 without snoops required.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_NONE",
         "Errata": "BDM100",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts retired load uops which data sources were hits in the last-level (L3) cache without snoops required.",
+        "PublicDescription": "This event counts retired load uops which data sources were hits in the last-level (L3) cache without snoops required.",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "EventCode": "0xD3",
         "UMask": "0x1",
+        "BriefDescription": "Data from local DRAM either Snoop not needed or Snoop Miss (RspI)",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM",
         "Errata": "BDE70, BDM100",
-        "PublicDescription": "This event counts retired load uops where the data came from local DRAM. This does not include hardware prefetches. This is a precise event.",
+        "PublicDescription": "Retired load uop whose Data Source was: local DRAM either Snoop not needed or Snoop Miss (RspI).",
         "SampleAfterValue": "100007",
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
@@ -646,7 +647,7 @@
     {
         "EventCode": "0xD3",
         "UMask": "0x10",
-        "BriefDescription": "Retired load uop whose Data Source was: Remote cache HITM (Precise Event)",
+        "BriefDescription": "Retired load uop whose Data Source was: Remote cache HITM",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
@@ -658,7 +659,7 @@
     {
         "EventCode": "0xD3",
         "UMask": "0x20",
-        "BriefDescription": "Retired load uop whose Data Source was: forwarded from remote cache (Precise Event)",
+        "BriefDescription": "Retired load uop whose Data Source was: forwarded from remote cache",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
@@ -810,12 +811,12 @@
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
     },
@@ -823,12 +824,12 @@
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
@@ -836,12 +837,12 @@
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
@@ -849,12 +850,12 @@
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
@@ -862,12 +863,12 @@
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
@@ -875,12 +876,12 @@
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
@@ -888,12 +889,12 @@
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
@@ -901,12 +902,12 @@
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
@@ -914,12 +915,12 @@
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
@@ -927,12 +928,12 @@
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
@@ -940,12 +941,12 @@
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
@@ -953,12 +954,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hit in the L3",
-        "MSRValue": "0x3f803c0002",
+        "BriefDescription": "Counts all demand data writes (RFOs) hit in the L3",
+        "MSRValue": "0x3F803C0002",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand data writes (RFOs) that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs) hit in the L3",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json b/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
index d7b9d9c9c518..ba0e0c4e74eb 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
@@ -42,7 +42,7 @@
     {
         "EventCode": "0xC7",
         "UMask": "0x3",
-        "BriefDescription": "Number of SSE/AVX computational scalar floating-point instructions retired. Applies to SSE* and AVX* scalar, double and single precision floating-point: ADD SUB MUL DIV MIN MAX RSQRT RCP SQRT FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
+        "BriefDescription": "Number of SSE/AVX computational scalar floating-point instructions retired. Applies to SSE* and AVX* scalar, double and single precision floating-point: ADD SUB MUL DIV MIN MAX RSQRT RCP SQRT FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element. (RSQRT for single precision?)",
         "Counter": "0,1,2,3",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
         "SampleAfterValue": "2000003",
@@ -51,7 +51,7 @@
     {
         "EventCode": "0xC7",
         "UMask": "0x4",
-        "BriefDescription": "Number of SSE/AVX computational 128-bit packed double precision floating-point instructions retired.  Each count represents 2 computations. Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packed double precision floating-point instructions retired.  Each count represents 2 computations. Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
         "Counter": "0,1,2,3",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
         "SampleAfterValue": "2000003",
@@ -60,7 +60,7 @@
     {
         "EventCode": "0xC7",
         "UMask": "0x8",
-        "BriefDescription": "Number of SSE/AVX computational 128-bit packed single precision floating-point instructions retired.  Each count represents 4 computations. Applies to SSE* and AVX* packed single precision floating-point instructions: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packed single precision floating-point instructions retired.  Each count represents 4 computations. Applies to SSE* and AVX* packed single precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
         "Counter": "0,1,2,3",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
         "SampleAfterValue": "2000003",
@@ -69,7 +69,7 @@
     {
         "EventCode": "0xC7",
         "UMask": "0x10",
-        "BriefDescription": "Number of SSE/AVX computational 256-bit packed double precision floating-point instructions retired.  Each count represents 4 computations. Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
+        "BriefDescription": "Number of SSE/AVX computational 256-bit packed double precision floating-point instructions retired.  Each count represents 4 computations. Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
         "Counter": "0,1,2,3",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
         "SampleAfterValue": "2000003",
@@ -78,7 +78,7 @@
     {
         "EventCode": "0xC7",
         "UMask": "0x15",
-        "BriefDescription": "Number of SSE/AVX computational double precision floating-point instructions retired. Applies to SSE* and AVX*scalar, double and single precision floating-point: ADD SUB MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.  ?.",
+        "BriefDescription": "Number of SSE/AVX computational double precision floating-point instructions retired. Applies to SSE* and AVX*scalar, double and single precision floating-point: ADD SUB MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
         "Counter": "0,1,2,3",
         "EventName": "FP_ARITH_INST_RETIRED.DOUBLE",
         "SampleAfterValue": "2000006",
@@ -87,7 +87,7 @@
     {
         "EventCode": "0xc7",
         "UMask": "0x20",
-        "BriefDescription": "Number of SSE/AVX computational 256-bit packed single precision floating-point instructions retired.  Each count represents 8 computations. Applies to SSE* and AVX* packed single precision floating-point instructions: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
+        "BriefDescription": "Number of SSE/AVX computational 256-bit packed single precision floating-point instructions retired.  Each count represents 8 computations. Applies to SSE* and AVX* packed single precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
         "Counter": "0,1,2,3",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
         "SampleAfterValue": "2000003",
@@ -96,7 +96,7 @@
     {
         "EventCode": "0xC7",
         "UMask": "0x2a",
-        "BriefDescription": "Number of SSE/AVX computational single precision floating-point instructions retired. Applies to SSE* and AVX*scalar, double and single precision floating-point: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element. ?.",
+        "BriefDescription": "Number of SSE/AVX computational single precision floating-point instructions retired. Applies to SSE* and AVX*scalar, double and single precision floating-point: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
         "Counter": "0,1,2,3",
         "EventName": "FP_ARITH_INST_RETIRED.SINGLE",
         "SampleAfterValue": "2000005",
@@ -105,7 +105,7 @@
     {
         "EventCode": "0xC7",
         "UMask": "0x3c",
-        "BriefDescription": "Number of SSE/AVX computational packed floating-point instructions retired. Applies to SSE* and AVX*, packed, double and single precision floating-point: ADD SUB MUL DIV MIN MAX RSQRT RCP SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element.",
+        "BriefDescription": "Number of SSE/AVX computational packed floating-point instructions retired. Applies to SSE* and AVX*, packed, double and single precision floating-point: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple calculations per element. (RSQRT for single-precision?)",
         "Counter": "0,1,2,3",
         "EventName": "FP_ARITH_INST_RETIRED.PACKED",
         "SampleAfterValue": "2000004",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/memory.json b/tools/perf/pmu-events/arch/x86/broadwellx/memory.json
index d79a5cfea44b..ecb413bb67ca 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/memory.json
@@ -170,11 +170,11 @@
     {
         "EventCode": "0xc8",
         "UMask": "0x4",
-        "BriefDescription": "Number of times HLE abort was triggered (PEBS)",
+        "BriefDescription": "Number of times HLE abort was triggered",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "HLE_RETIRED.ABORTED",
-        "PublicDescription": "Number of times HLE abort was triggered (PEBS).",
+        "PublicDescription": "Number of times HLE abort was triggered.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -251,11 +251,11 @@
     {
         "EventCode": "0xc9",
         "UMask": "0x4",
-        "BriefDescription": "Number of times RTM abort was triggered (PEBS)",
+        "BriefDescription": "Number of times RTM abort was triggered",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "RTM_RETIRED.ABORTED",
-        "PublicDescription": "Number of times RTM abort was triggered (PEBS).",
+        "PublicDescription": "Number of times RTM abort was triggered .",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -312,14 +312,14 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 4",
+        "BriefDescription": "Randomly selected loads with latency value being above 4",
         "PEBS": "2",
         "MSRValue": "0x4",
         "Counter": "3",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "Errata": "BDM100, BDM35",
-        "PublicDescription": "This event counts loads with latency value being above four.",
+        "PublicDescription": "Counts randomly selected loads with latency value being above four.",
         "TakenAlone": "1",
         "SampleAfterValue": "100003",
         "CounterHTOff": "3"
@@ -327,14 +327,14 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 8",
+        "BriefDescription": "Randomly selected loads with latency value being above 8",
         "PEBS": "2",
         "MSRValue": "0x8",
         "Counter": "3",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "Errata": "BDM100, BDM35",
-        "PublicDescription": "This event counts loads with latency value being above eight.",
+        "PublicDescription": "Counts randomly selected loads with latency value being above eight.",
         "TakenAlone": "1",
         "SampleAfterValue": "50021",
         "CounterHTOff": "3"
@@ -342,14 +342,14 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 16",
+        "BriefDescription": "Randomly selected loads with latency value being above 16",
         "PEBS": "2",
         "MSRValue": "0x10",
         "Counter": "3",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "Errata": "BDM100, BDM35",
-        "PublicDescription": "This event counts loads with latency value being above 16.",
+        "PublicDescription": "Counts randomly selected loads with latency value being above 16.",
         "TakenAlone": "1",
         "SampleAfterValue": "20011",
         "CounterHTOff": "3"
@@ -357,14 +357,14 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 32",
+        "BriefDescription": "Randomly selected loads with latency value being above 32",
         "PEBS": "2",
         "MSRValue": "0x20",
         "Counter": "3",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "Errata": "BDM100, BDM35",
-        "PublicDescription": "This event counts loads with latency value being above 32.",
+        "PublicDescription": "Counts randomly selected loads with latency value being above 32.",
         "TakenAlone": "1",
         "SampleAfterValue": "100007",
         "CounterHTOff": "3"
@@ -372,14 +372,14 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 64",
+        "BriefDescription": "Randomly selected loads with latency value being above 64",
         "PEBS": "2",
         "MSRValue": "0x40",
         "Counter": "3",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "Errata": "BDM100, BDM35",
-        "PublicDescription": "This event counts loads with latency value being above 64.",
+        "PublicDescription": "Counts randomly selected loads with latency value being above 64.",
         "TakenAlone": "1",
         "SampleAfterValue": "2003",
         "CounterHTOff": "3"
@@ -387,14 +387,14 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 128",
+        "BriefDescription": "Randomly selected loads with latency value being above 128",
         "PEBS": "2",
         "MSRValue": "0x80",
         "Counter": "3",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "Errata": "BDM100, BDM35",
-        "PublicDescription": "This event counts loads with latency value being above 128.",
+        "PublicDescription": "Counts randomly selected loads with latency value being above 128.",
         "TakenAlone": "1",
         "SampleAfterValue": "1009",
         "CounterHTOff": "3"
@@ -402,14 +402,14 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 256",
+        "BriefDescription": "Randomly selected loads with latency value being above 256",
         "PEBS": "2",
         "MSRValue": "0x100",
         "Counter": "3",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "Errata": "BDM100, BDM35",
-        "PublicDescription": "This event counts loads with latency value being above 256.",
+        "PublicDescription": "Counts randomly selected loads with latency value being above 256.",
         "TakenAlone": "1",
         "SampleAfterValue": "503",
         "CounterHTOff": "3"
@@ -417,14 +417,14 @@
     {
         "EventCode": "0xCD",
         "UMask": "0x1",
-        "BriefDescription": "Loads with latency value being above 512",
+        "BriefDescription": "Randomly selected loads with latency value being above 512",
         "PEBS": "2",
         "MSRValue": "0x200",
         "Counter": "3",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "Errata": "BDM100, BDM35",
-        "PublicDescription": "This event counts loads with latency value being above 512.",
+        "PublicDescription": "Counts randomly selected loads with latency value being above 512.",
         "TakenAlone": "1",
         "SampleAfterValue": "101",
         "CounterHTOff": "3"
@@ -433,12 +433,12 @@
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
     },
@@ -446,12 +446,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and clean or shared data is transferred from remote cache",
-        "MSRValue": "0x087fc007f7",
+        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and clean or shared data is transferred from remote cache",
+        "MSRValue": "0x087FC007F7",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_HIT_FORWARD",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and clean or shared data is transferred from remote cache Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and clean or shared data is transferred from remote cache",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -459,12 +459,12 @@
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
@@ -472,12 +472,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the data is returned from remote dram",
-        "MSRValue": "0x063bc007f7",
+        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and the data is returned from remote dram",
+        "MSRValue": "0x063BC007F7",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the data is returned from remote dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and the data is returned from remote dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -485,12 +485,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the data is returned from local dram",
-        "MSRValue": "0x06040007f7",
+        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and the data is returned from local dram",
+        "MSRValue": "0x06040007F7",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -498,12 +498,12 @@
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
@@ -511,12 +511,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch code reads that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch code reads miss the L3 and the data is returned from local dram",
         "MSRValue": "0x0604000244",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch code reads that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch code reads miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -524,12 +524,12 @@
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
@@ -537,12 +537,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch RFOs that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch RFOs miss the L3 and the data is returned from local dram",
         "MSRValue": "0x0604000122",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch RFOs that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -550,12 +550,12 @@
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
@@ -563,12 +563,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch data reads that miss the L3 and clean or shared data is transferred from remote cache",
-        "MSRValue": "0x087fc00091",
+        "BriefDescription": "Counts all demand & prefetch data reads miss the L3 and clean or shared data is transferred from remote cache",
+        "MSRValue": "0x087FC00091",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.REMOTE_HIT_FORWARD",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch data reads that miss the L3 and clean or shared data is transferred from remote cache Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads miss the L3 and clean or shared data is transferred from remote cache",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -576,12 +576,12 @@
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
@@ -589,12 +589,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch data reads that miss the L3 and the data is returned from remote dram",
-        "MSRValue": "0x063bc00091",
+        "BriefDescription": "Counts all demand & prefetch data reads miss the L3 and the data is returned from remote dram",
+        "MSRValue": "0x063BC00091",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.REMOTE_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch data reads that miss the L3 and the data is returned from remote dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads miss the L3 and the data is returned from remote dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -602,12 +602,12 @@
         "Offcore": "1",
         "EventCode": "0xB7, 0xBB",
         "UMask": "0x1",
-        "BriefDescription": "Counts all demand & prefetch data reads that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch data reads miss the L3 and the data is returned from local dram",
         "MSRValue": "0x0604000091",
         "Counter": "0,1,2,3",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "PublicDescription": "Counts all demand & prefetch data reads that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads miss the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "CounterHTOff": "0,1,2,3"
     },
@@ -615,12 +615,12 @@
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
@@ -628,12 +628,12 @@
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
@@ -641,12 +641,12 @@
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
@@ -654,12 +654,12 @@
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
@@ -667,12 +667,12 @@
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
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
index 0d04bf9db000..c2f6932a5817 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
@@ -1,6 +1,5 @@
 [
     {
-        "EventCode": "0x00",
         "UMask": "0x1",
         "BriefDescription": "Instructions retired from execution.",
         "Counter": "Fixed counter 0",
@@ -10,7 +9,6 @@
         "CounterHTOff": "Fixed counter 0"
     },
     {
-        "EventCode": "0x00",
         "UMask": "0x2",
         "BriefDescription": "Core cycles when the thread is not in halt state",
         "Counter": "Fixed counter 1",
@@ -20,7 +18,6 @@
         "CounterHTOff": "Fixed counter 1"
     },
     {
-        "EventCode": "0x00",
         "UMask": "0x2",
         "BriefDescription": "Core cycles when at least one thread on the physical core is not in halt state.",
         "Counter": "Fixed counter 1",
@@ -30,7 +27,6 @@
         "CounterHTOff": "Fixed counter 1"
     },
     {
-        "EventCode": "0x00",
         "UMask": "0x3",
         "BriefDescription": "Reference cycles when the core is not in halt state.",
         "Counter": "Fixed counter 2",
@@ -322,7 +318,7 @@
         "BriefDescription": "Stalls caused by changing prefix length of the instruction.",
         "Counter": "0,1,2,3",
         "EventName": "ILD_STALL.LCP",
-        "PublicDescription": "This event counts stalls occurred due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occured due to changing prefix length (66, 67 or REX.W when they change the length of the decoded instruction). Occurrences counting is proportional to the number of prefixes in a 16B-line. This may result in the following penalties: three-cycle penalty for each LCP in a 16-byte chunk.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -786,12 +782,12 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "EventCode": "0xA2",
+        "EventCode": "0xa2",
         "UMask": "0x1",
         "BriefDescription": "Resource-related stall cycles",
         "Counter": "0,1,2,3",
         "EventName": "RESOURCE_STALLS.ANY",
-        "PublicDescription": "This event counts resource-related stall cycles. Reasons for stalls can be as follows:\n - *any* u-arch structure got full (LB, SB, RS, ROB, BOB, LM, Physical Register Reclaim Table (PRRT), or Physical History Table (PHT) slots)\n - *any* u-arch structure got empty (like INT/SIMD FreeLists)\n - FPU control word (FPCW), MXCSR\nand others. This counts cycles that the pipeline backend blocked uop delivery from the front end.",
+        "PublicDescription": "This event counts resource-related stall cycles.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1168,12 +1164,12 @@
     {
         "EventCode": "0xC2",
         "UMask": "0x1",
-        "BriefDescription": "Actually retired uops. (Precise Event - PEBS)",
+        "BriefDescription": "Actually retired uops.",
         "Data_LA": "1",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "UOPS_RETIRED.ALL",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts all actually retired uops. Counting increments by two for micro-fused uops, and by one for macro-fused and other uops. Maximal increment value for one cycle is eight.",
+        "PublicDescription": "This event counts all actually retired uops. Counting increments by two for micro-fused uops, and by one for macro-fused and other uops. Maximal increment value for one cycle is eight.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1204,11 +1200,11 @@
     {
         "EventCode": "0xC2",
         "UMask": "0x2",
-        "BriefDescription": "Retirement slots used. (Precise Event - PEBS)",
+        "BriefDescription": "Retirement slots used.",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "UOPS_RETIRED.RETIRE_SLOTS",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts the number of retirement slots used.",
+        "PublicDescription": "This event counts the number of retirement slots used.",
         "SampleAfterValue": "2000003",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1266,33 +1262,33 @@
     {
         "EventCode": "0xC4",
         "UMask": "0x1",
-        "BriefDescription": "Conditional branch instructions retired. (Precise Event - PEBS)",
+        "BriefDescription": "Conditional branch instructions retired.",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_INST_RETIRED.CONDITIONAL",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts conditional branch instructions retired.",
+        "PublicDescription": "This event counts conditional branch instructions retired.",
         "SampleAfterValue": "400009",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0xC4",
         "UMask": "0x2",
-        "BriefDescription": "Direct and indirect near call instructions retired. (Precise Event - PEBS)",
+        "BriefDescription": "Direct and indirect near call instructions retired.",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts both direct and indirect near call instructions retired.",
+        "PublicDescription": "This event counts both direct and indirect near call instructions retired.",
         "SampleAfterValue": "100007",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0xC4",
         "UMask": "0x2",
-        "BriefDescription": "Direct and indirect macro near call instructions retired (captured in ring 3). (Precise Event - PEBS)",
+        "BriefDescription": "Direct and indirect macro near call instructions retired (captured in ring 3).",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_INST_RETIRED.NEAR_CALL_R3",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts both direct and indirect macro near call instructions retired (captured in ring 3).",
+        "PublicDescription": "This event counts both direct and indirect macro near call instructions retired (captured in ring 3).",
         "SampleAfterValue": "100007",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1311,11 +1307,11 @@
     {
         "EventCode": "0xC4",
         "UMask": "0x8",
-        "BriefDescription": "Return instructions retired. (Precise Event - PEBS)",
+        "BriefDescription": "Return instructions retired.",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts return instructions retired.",
+        "PublicDescription": "This event counts return instructions retired.",
         "SampleAfterValue": "100007",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1332,11 +1328,11 @@
     {
         "EventCode": "0xC4",
         "UMask": "0x20",
-        "BriefDescription": "Taken branch instructions retired. (Precise Event - PEBS)",
+        "BriefDescription": "Taken branch instructions retired.",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts taken branch instructions retired.",
+        "PublicDescription": "This event counts taken branch instructions retired.",
         "SampleAfterValue": "400009",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1364,11 +1360,11 @@
     {
         "EventCode": "0xC5",
         "UMask": "0x1",
-        "BriefDescription": "Mispredicted conditional branch instructions retired. (Precise Event - PEBS)",
+        "BriefDescription": "Mispredicted conditional branch instructions retired.",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_MISP_RETIRED.CONDITIONAL",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts mispredicted conditional branch instructions retired.",
+        "PublicDescription": "This event counts mispredicted conditional branch instructions retired.",
         "SampleAfterValue": "400009",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
@@ -1386,22 +1382,22 @@
     {
         "EventCode": "0xC5",
         "UMask": "0x8",
-        "BriefDescription": "This event counts the number of mispredicted ret instructions retired.(Precise Event)",
+        "BriefDescription": "This event counts the number of mispredicted ret instructions retired. Non PEBS",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts mispredicted return instructions retired.",
+        "PublicDescription": "This event counts mispredicted return instructions retired.",
         "SampleAfterValue": "100007",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
         "EventCode": "0xC5",
         "UMask": "0x20",
-        "BriefDescription": "number of near branch instructions retired that were mispredicted and taken. (Precise Event - PEBS).",
+        "BriefDescription": "number of near branch instructions retired that were mispredicted and taken.",
         "PEBS": "1",
         "Counter": "0,1,2,3",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PublicDescription": "Number of near branch instructions retired that were mispredicted and taken. (Precise Event - PEBS).",
+        "PublicDescription": "Number of near branch instructions retired that were mispredicted and taken.",
         "SampleAfterValue": "400009",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
-- 
2.20.1

