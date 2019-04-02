Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFDDC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F46208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221297;
	bh=wus7MIi9HBpJCHFPmXR6r4kphhM+pokjx0Uie4q3bJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gSBSNvJ9FV78diIXo2dQ0Gkot8yLcFfUW6lXpu+CEPZdE0aqYQnJXsgz963ZE6F5t
	 Ogsex/OuBx65d+irHkLKiiFJPwgLyw1WDCh1AEgcbbSjVOwsGY/4zIun4XonDxUKz/
	 kFvdcgSjP1bMc/JuWXETvkEPTxSp88ePMcfaptS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbfDBQIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731561AbfDBQIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:08:11 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE3B20882;
        Tue,  2 Apr 2019 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221288;
        bh=wus7MIi9HBpJCHFPmXR6r4kphhM+pokjx0Uie4q3bJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XSwhOZ1B2V987BpGZcB8K/g0zcE45lup8JD5a6pi10NkKJ/Rd7iyxZwq0+M3RSLWF
         nStSc3uIHl+9zR04McaENTQQjRWElUpdemZjfh1zLDsjUhSDKCGm1XwhoUtSMRGkwF
         DMRGynWa/pkpEnc7sFuyzbo/w102cpoTV6uP6uhg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 39/44] perf vendor events intel: Update Haswell events to v28
Date:   Tue,  2 Apr 2019 13:05:44 -0300
Message-Id: <20190402160549.13544-40-acme@kernel.org>
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
 .../pmu-events/arch/x86/haswell/cache.json    | 175 +++++++++---------
 .../arch/x86/haswell/floating-point.json      |  33 ++--
 .../pmu-events/arch/x86/haswell/memory.json   | 172 ++++++++---------
 .../pmu-events/arch/x86/haswell/pipeline.json |  33 ++--
 4 files changed, 213 insertions(+), 200 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswell/cache.json b/tools/perf/pmu-events/arch/x86/haswell/cache.json
index da4d6ddd4f92..7fb0ad8d8ca1 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/cache.json
@@ -63,10 +63,10 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Demand data read requests that hit L2 cache.",
+        "PublicDescription": "Counts the number of demand Data Read requests, initiated by load instructions, that hit L2 cache",
         "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x41",
+        "UMask": "0xc1",
         "Errata": "HSD78",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "SampleAfterValue": "200003",
@@ -77,7 +77,7 @@
         "PublicDescription": "Counts the number of store RFO requests that hit the L2 cache.",
         "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x42",
+        "UMask": "0xc2",
         "EventName": "L2_RQSTS.RFO_HIT",
         "SampleAfterValue": "200003",
         "BriefDescription": "RFO requests that hit L2 cache",
@@ -87,7 +87,7 @@
         "PublicDescription": "Number of instruction fetches that hit the L2 cache.",
         "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x44",
+        "UMask": "0xc4",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "SampleAfterValue": "200003",
         "BriefDescription": "L2 cache hits when fetching instructions, code reads.",
@@ -97,7 +97,7 @@
         "PublicDescription": "Counts all L2 HW prefetcher requests that hit L2.",
         "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x50",
+        "UMask": "0xd0",
         "EventName": "L2_RQSTS.L2_PF_HIT",
         "SampleAfterValue": "200003",
         "BriefDescription": "L2 prefetch requests that hit L2 cache",
@@ -610,7 +610,7 @@
         "Errata": "HSD29, HSD25, HSM26, HSM30",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT",
         "SampleAfterValue": "20011",
-        "BriefDescription": "Retired load uops which data sources were L3 and cross-core snoop hits in on-pkg core cache. ",
+        "BriefDescription": "Retired load uops which data sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "CounterHTOff": "0,1,2,3",
         "Data_LA": "1"
     },
@@ -623,7 +623,7 @@
         "Errata": "HSD29, HSD25, HSM26, HSM30",
         "EventName": "MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM",
         "SampleAfterValue": "20011",
-        "BriefDescription": "Retired load uops which data sources were HitM responses from shared L3. ",
+        "BriefDescription": "Retired load uops which data sources were HitM responses from shared L3.",
         "CounterHTOff": "0,1,2,3",
         "Data_LA": "1"
     },
@@ -792,7 +792,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "",
         "EventCode": "0xf4",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
@@ -802,262 +801,262 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Counts all requests that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all requests hit in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c8fff",
+        "MSRValue": "0x3F803C8FFF",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_REQUESTS.L3_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all requests that hit in the L3",
+        "BriefDescription": "Counts all requests hit in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c07f7",
+        "MSRValue": "0x10003C07F7",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "BriefDescription": "hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c07f7",
+        "MSRValue": "0x04003C07F7",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch code reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch code reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0244",
+        "MSRValue": "0x04003C0244",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch code reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts all demand & prefetch code reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0122",
+        "MSRValue": "0x10003C0122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "BriefDescription": "Counts all demand & prefetch RFOs hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0122",
+        "MSRValue": "0x04003C0122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts all demand & prefetch RFOs hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0091",
+        "MSRValue": "0x10003C0091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "BriefDescription": "Counts all demand & prefetch data reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0091",
+        "MSRValue": "0x04003C0091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts all demand & prefetch data reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to LLC only) code reads that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only) code reads hit in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0200",
+        "MSRValue": "0x3F803C0200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) code reads that hit in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only) code reads hit in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) RFOs  that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) RFOs hit in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0100",
+        "MSRValue": "0x3F803C0100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  that hit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs hit in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) data reads that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) data reads hit in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0080",
+        "MSRValue": "0x3F803C0080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads that hit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads hit in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) code reads that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) code reads hit in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0040",
+        "MSRValue": "0x3F803C0040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads that hit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads hit in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to L2) RFOs that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) RFOs hit in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0020",
+        "MSRValue": "0x3F803C0020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs that hit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs hit in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to L2) data reads that hit in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data reads hit in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0010",
+        "MSRValue": "0x3F803C0010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that hit in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads hit in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0004",
+        "MSRValue": "0x10003C0004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "BriefDescription": "Counts all demand code reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0004",
+        "MSRValue": "0x04003C0004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts all demand code reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs) hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0002",
+        "MSRValue": "0x10003C0002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "BriefDescription": "Counts all demand data writes (RFOs) hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs) hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0002",
+        "MSRValue": "0x04003C0002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts all demand data writes (RFOs) hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0001",
+        "MSRValue": "0x10003C0001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_CORE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
+        "BriefDescription": "Counts demand data reads hit in the L3 and the snoop to one of the sibling cores hits the line in M state and the line is forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0001",
+        "MSRValue": "0x04003C0001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_CORE_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
+        "BriefDescription": "Counts demand data reads hit in the L3 and the snoops to sibling cores hit in either E/S state and the line is not forwarded",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     }
diff --git a/tools/perf/pmu-events/arch/x86/haswell/floating-point.json b/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
index f9843e5a9b42..f5a3beaa19fc 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
@@ -1,22 +1,26 @@
 [
     {
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xC1",
         "Counter": "0,1,2,3",
         "UMask": "0x8",
         "Errata": "HSD56, HSM57",
         "EventName": "OTHER_ASSISTS.AVX_TO_SSE",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of transitions from AVX-256 to legacy SSE when penalty applicable.",
+        "BriefDescription": "Number of transitions from AVX-256 to legacy SSE when penalty applicable",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xC1",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
         "Errata": "HSD56, HSM57",
         "EventName": "OTHER_ASSISTS.SSE_TO_AVX",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of transitions from SSE to AVX-256 when penalty applicable.",
+        "BriefDescription": "Number of transitions from legacy SSE to AVX-256 when penalty applicable",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -30,53 +34,58 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Number of X87 FP assists due to output values.",
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xCA",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
         "EventName": "FP_ASSIST.X87_OUTPUT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of X87 assists due to output value.",
+        "BriefDescription": "output - Numeric Overflow, Numeric Underflow, Inexact Result",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Number of X87 FP assists due to input values.",
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xCA",
         "Counter": "0,1,2,3",
         "UMask": "0x4",
         "EventName": "FP_ASSIST.X87_INPUT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of X87 assists due to input value.",
+        "BriefDescription": "input - Invalid Operation, Denormal Operand, SNaN Operand",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Number of SIMD FP assists due to output values.",
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xCA",
         "Counter": "0,1,2,3",
         "UMask": "0x8",
         "EventName": "FP_ASSIST.SIMD_OUTPUT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of SIMD FP assists due to Output values",
+        "BriefDescription": "SSE* FP micro-code assist when output value is invalid.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Number of SIMD FP assists due to input values.",
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xCA",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
         "EventName": "FP_ASSIST.SIMD_INPUT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of SIMD FP assists due to input values",
+        "BriefDescription": "Any input SSE* FP Assist",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Cycles with any input/output SSE* or FP assists.",
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xCA",
         "Counter": "0,1,2,3",
         "UMask": "0x1e",
         "EventName": "FP_ASSIST.ANY",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Cycles with any input/output SSE or FP assist",
+        "BriefDescription": "Counts any FP_ASSIST umask was incrementing",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3"
     }
diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/perf/pmu-events/arch/x86/haswell/memory.json
index e5f9fa6655b3..ef13ed88e2ea 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
@@ -298,7 +298,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Loads with latency value being above 4.",
+        "BriefDescription": "Randomly selected loads with latency value being above 4.",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
@@ -312,7 +312,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "50021",
-        "BriefDescription": "Loads with latency value being above 8.",
+        "BriefDescription": "Randomly selected loads with latency value being above 8.",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
@@ -326,7 +326,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "20011",
-        "BriefDescription": "Loads with latency value being above 16.",
+        "BriefDescription": "Randomly selected loads with latency value being above 16.",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
@@ -340,7 +340,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Loads with latency value being above 32.",
+        "BriefDescription": "Randomly selected loads with latency value being above 32.",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
@@ -354,7 +354,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "2003",
-        "BriefDescription": "Loads with latency value being above 64.",
+        "BriefDescription": "Randomly selected loads with latency value being above 64.",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
@@ -368,7 +368,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "1009",
-        "BriefDescription": "Loads with latency value being above 128.",
+        "BriefDescription": "Randomly selected loads with latency value being above 128.",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
@@ -382,7 +382,7 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "503",
-        "BriefDescription": "Loads with latency value being above 256.",
+        "BriefDescription": "Randomly selected loads with latency value being above 256.",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
@@ -396,280 +396,280 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "101",
-        "BriefDescription": "Loads with latency value being above 512.",
+        "BriefDescription": "Randomly selected loads with latency value being above 512.",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
     {
-        "PublicDescription": "Counts all requests that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all requests miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc08fff",
+        "MSRValue": "0x3FFFC08FFF",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_REQUESTS.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all requests that miss in the L3",
+        "BriefDescription": "Counts all requests miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01004007f7",
+        "MSRValue": "0x01004007F7",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_MISS.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "miss the L3 and the data is returned from local dram",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc007f7",
+        "MSRValue": "0x3FFFC007F7",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all data/code/rfo reads (demand & prefetch) that miss in the L3",
+        "BriefDescription": "miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch code reads that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch code reads miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "MSRValue": "0x0100400244",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_MISS.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch code reads that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch code reads miss the L3 and the data is returned from local dram",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch code reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch code reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00244",
+        "MSRValue": "0x3FFFC00244",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch code reads that miss in the L3",
+        "BriefDescription": "Counts all demand & prefetch code reads miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "MSRValue": "0x0100400122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch RFOs miss the L3 and the data is returned from local dram",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00122",
+        "MSRValue": "0x3FFFC00122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that miss in the L3",
+        "BriefDescription": "Counts all demand & prefetch RFOs miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "MSRValue": "0x0100400091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch data reads miss the L3 and the data is returned from local dram",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00091",
+        "MSRValue": "0x3FFFC00091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that miss in the L3",
+        "BriefDescription": "Counts all demand & prefetch data reads miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to LLC only) code reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only) code reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00200",
+        "MSRValue": "0x3FFFC00200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only) code reads that miss in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only) code reads miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) RFOs  that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) RFOs miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00100",
+        "MSRValue": "0x3FFFC00100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs  that miss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) RFOs miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) data reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) data reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00080",
+        "MSRValue": "0x3FFFC00080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads that miss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) data reads miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC only) code reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC only) code reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00040",
+        "MSRValue": "0x3FFFC00040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads that miss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC only) code reads miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to L2) RFOs that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) RFOs miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00020",
+        "MSRValue": "0x3FFFC00020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs that miss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) RFOs miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to L2) data reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00010",
+        "MSRValue": "0x3FFFC00010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data reads that miss in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data reads miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "MSRValue": "0x0100400004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand code reads miss the L3 and the data is returned from local dram",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00004",
+        "MSRValue": "0x3FFFC00004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that miss in the L3",
+        "BriefDescription": "Counts all demand code reads miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs) miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "MSRValue": "0x0100400002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand data writes (RFOs) miss the L3 and the data is returned from local dram",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs) miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00002",
+        "MSRValue": "0x3FFFC00002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that miss in the L3",
+        "BriefDescription": "Counts all demand data writes (RFOs) miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that miss the L3 and the data is returned from local dram Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads miss the L3 and the data is returned from local dram",
         "EventCode": "0xB7, 0xBB",
         "MSRValue": "0x0100400001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that miss the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts demand data reads miss the L3 and the data is returned from local dram",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that miss in the L3 Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads miss in the L3",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fffc00001",
+        "MSRValue": "0x3FFFC00001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that miss in the L3",
+        "BriefDescription": "Counts demand data reads miss in the L3",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     }
diff --git a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
index a4dcfce4a512..734d3873729e 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
@@ -1,7 +1,6 @@
 [
     {
         "PublicDescription": "This event counts the number of instructions retired from execution. For instructions that consist of multiple micro-ops, this event counts the retirement of the last micro-op of the instruction. Counting continues during hardware interrupts, traps, and inside interrupt handlers. INST_RETIRED.ANY is counted by a designated fixed counter, leaving the programmable counters available for other events. Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 0",
         "UMask": "0x1",
         "Errata": "HSD140, HSD143",
@@ -12,7 +11,6 @@
     },
     {
         "PublicDescription": "This event counts the number of thread cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. The core frequency may change from time to time due to power or thermal throttling.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x2",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
@@ -21,7 +19,6 @@
         "CounterHTOff": "Fixed counter 1"
     },
     {
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x2",
         "AnyThread": "1",
@@ -32,7 +29,6 @@
     },
     {
         "PublicDescription": "This event counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 2",
         "UMask": "0x3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
@@ -1071,7 +1067,8 @@
         "CounterHTOff": "1"
     },
     {
-        "PublicDescription": "This is a non-precise version (that is, does not use PEBS) of the event that counts FP operations retired. For X87 FP operations that have no exceptions counting also includes flows that have several X87, or flows that use X87 uops in the exception handling.",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEBS) of the event that counts FP operations retired. For X87 FP operations that have no exceptions counting also includes flows that have several X87, or flows that use X87 uops in the exception handling.",
         "EventCode": "0xC0",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
@@ -1081,13 +1078,13 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Number of microcode assists invoked by HW upon uop writeback.",
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xC1",
         "Counter": "0,1,2,3",
         "UMask": "0x40",
         "EventName": "OTHER_ASSISTS.ANY_WB_ASSIST",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of times any microcode assist is invoked by HW upon uop writeback.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -1102,28 +1099,34 @@
         "Data_LA": "1"
     },
     {
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xC2",
         "Invert": "1",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles without actually retired uops.",
+        "BriefDescription": "Cycles no executable uops retired",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xC2",
         "Invert": "1",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles with less than 10 actually retired uops.",
+        "BriefDescription": "Number of cycles using always true condition applied to  PEBS uops retired event.",
         "CounterMask": "10",
         "CounterHTOff": "0,1,2,3"
     },
     {
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xC2",
         "Invert": "1",
         "Counter": "0,1,2,3",
@@ -1131,7 +1134,7 @@
         "AnyThread": "1",
         "EventName": "UOPS_RETIRED.CORE_STALL_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles without actually retired uops.",
+        "BriefDescription": "Cycles no executable uops retired on core",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3"
     },
@@ -1245,13 +1248,14 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Counts the number of not taken branch instructions retired.",
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xC4",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
         "EventName": "BR_INST_RETIRED.NOT_TAKEN",
         "SampleAfterValue": "400009",
-        "BriefDescription": "Not taken branch instructions retired.",
+        "BriefDescription": "Counts all not taken macro branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -1265,13 +1269,14 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Number of far branches retired.",
+        "PEBS": "1",
+        "PublicDescription": "",
         "EventCode": "0xC4",
         "Counter": "0,1,2,3",
         "UMask": "0x40",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Far branch instructions retired.",
+        "BriefDescription": "Counts the number of far branch instructions retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-- 
2.20.1

