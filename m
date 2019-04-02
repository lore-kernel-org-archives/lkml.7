Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D06C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E8C2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221305;
	bh=RZdTnHOAD700MfE6s9sWPfKPT9nOO/nFgEThlAKIQmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=inJ3/26JpsUefoxFxvF3WLYFz7S1ORJbrTb7KxW44M2sRFR17hKnSnxjz1HYRIPbV
	 fmOibRfLYyIne+8tllFQJE3AtW4YIB11jMggwusGaSCmZt/9Hl/nL0GFN9hwHVsq+o
	 mXlDFN+M6J7tLTWxiBPABiXfSmiiXjXI84FCmMAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbfDBQIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbfDBQIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:08:19 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C0820840;
        Tue,  2 Apr 2019 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221291;
        bh=RZdTnHOAD700MfE6s9sWPfKPT9nOO/nFgEThlAKIQmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xKuTgMbBd0XViMCthjoHynh9KvHWuV8vBKfZX6xmYabAKjyl8hJ+rQIxgojDha98v
         /GH1lkQbWTZELJhwjdTTjZUOHB3K9xQBTdmvraSxwJK4bZJupELWjqQwXRUkPmcfH9
         HvXYhWPPFNogjNNVFd8psp1U6qK5rHx7huFe2v6U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 40/44] perf vendor events intel: Update KnightsLanding events to v9
Date:   Tue,  2 Apr 2019 13:05:45 -0300
Message-Id: <20190402160549.13544-41-acme@kernel.org>
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
 .../arch/x86/knightslanding/cache.json        | 666 +++++++++---------
 .../arch/x86/knightslanding/memory.json       | 268 +++----
 .../arch/x86/knightslanding/pipeline.json     |  15 +-
 .../x86/knightslanding/virtual-memory.json    |   2 +-
 4 files changed, 474 insertions(+), 477 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
index e434ec723001..e847b0fd696d 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/cache.json
@@ -32,16 +32,16 @@
         "BriefDescription": "Counts the number of L2 cache misses"
     },
     {
-        "PublicDescription": "This event counts the number of core cycles the fetch stalls because of an icache miss. This is a cumulative count of cycles the NIP stalled for all icache misses. ",
+        "PublicDescription": "This event counts the number of core cycles the fetch stalls because of an icache miss. This is a cumulative count of cycles the NIP stalled for all icache misses.",
         "EventCode": "0x86",
         "Counter": "0,1",
         "UMask": "0x4",
         "EventName": "FETCH_STALL.ICACHE_FILL_PENDING_CYCLES",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of core cycles the fetch stalls because of an icache miss. This is a cummulative count of core cycles the fetch stalled for all icache misses. "
+        "BriefDescription": "Counts the number of core cycles the fetch stalls because of an icache miss. This is a cummulative count of core cycles the fetch stalled for all icache misses."
     },
     {
-        "PublicDescription": "This event counts the number of load micro-ops retired that miss in L1 Data cache. Note that prefetch misses will not be counted. ",
+        "PublicDescription": "This event counts the number of load micro-ops retired that miss in L1 Data cache. Note that prefetch misses will not be counted.",
         "EventCode": "0x04",
         "Counter": "0,1",
         "UMask": "0x1",
@@ -115,29 +115,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000000070 ",
+        "MSRValue": "0x4000000070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Prefetch requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts any Prefetch requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400070 ",
+        "MSRValue": "0x1000400070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Prefetch requests that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts any Prefetch requests that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400070 ",
+        "MSRValue": "0x0800400070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE_E_F",
@@ -148,29 +148,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080070 ",
+        "MSRValue": "0x1000080070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Prefetch requests that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts any Prefetch requests that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080070 ",
+        "MSRValue": "0x0800080070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Prefetch requests that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts any Prefetch requests that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010070 ",
+        "MSRValue": "0x0000010070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.ANY_RESPONSE",
@@ -181,29 +181,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x40000032f7 ",
+        "MSRValue": "0x40000032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts any Read request  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x10004032f7 ",
+        "MSRValue": "0x10004032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts any Read request  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x08004032f7 ",
+        "MSRValue": "0x08004032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE_E_F",
@@ -214,29 +214,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x10000832f7 ",
+        "MSRValue": "0x10000832f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts any Read request  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x08000832f7 ",
+        "MSRValue": "0x08000832f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts any Read request  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x00000132f7 ",
+        "MSRValue": "0x00000132f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.ANY_RESPONSE",
@@ -247,29 +247,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000000044 ",
+        "MSRValue": "0x4000000044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400044 ",
+        "MSRValue": "0x1000400044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400044 ",
+        "MSRValue": "0x0800400044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE_E_F",
@@ -280,29 +280,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080044 ",
+        "MSRValue": "0x1000080044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080044 ",
+        "MSRValue": "0x0800080044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010044 ",
+        "MSRValue": "0x0000010044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.ANY_RESPONSE",
@@ -313,29 +313,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000000022 ",
+        "MSRValue": "0x4000000022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400022 ",
+        "MSRValue": "0x1000400022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400022 ",
+        "MSRValue": "0x0800400022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE_E_F",
@@ -346,29 +346,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080022 ",
+        "MSRValue": "0x1000080022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080022 ",
+        "MSRValue": "0x0800080022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010022 ",
+        "MSRValue": "0x0000010022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.ANY_RESPONSE",
@@ -379,29 +379,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000003091 ",
+        "MSRValue": "0x4000003091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000403091 ",
+        "MSRValue": "0x1000403091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800403091 ",
+        "MSRValue": "0x0800403091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE_E_F",
@@ -412,29 +412,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000083091 ",
+        "MSRValue": "0x1000083091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800083091 ",
+        "MSRValue": "0x0800083091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000013091 ",
+        "MSRValue": "0x0000013091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.ANY_RESPONSE",
@@ -445,29 +445,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000008000 ",
+        "MSRValue": "0x4000008000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts any request that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000408000 ",
+        "MSRValue": "0x1000408000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts any request that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800408000 ",
+        "MSRValue": "0x0800408000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE_E_F",
@@ -478,29 +478,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000088000 ",
+        "MSRValue": "0x1000088000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts any request that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800088000 ",
+        "MSRValue": "0x0800088000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts any request that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000018000 ",
+        "MSRValue": "0x0000018000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.ANY_RESPONSE",
@@ -511,7 +511,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000014800 ",
+        "MSRValue": "0x0000014800",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.STREAMING_STORES.ANY_RESPONSE",
@@ -522,7 +522,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000014000 ",
+        "MSRValue": "0x0000014000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_STREAMING_STORES.ANY_RESPONSE",
@@ -533,29 +533,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000002000 ",
+        "MSRValue": "0x4000002000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts L1 data HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000402000 ",
+        "MSRValue": "0x1000402000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800402000 ",
+        "MSRValue": "0x0800402000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE_E_F",
@@ -566,29 +566,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000082000 ",
+        "MSRValue": "0x1000082000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800082000 ",
+        "MSRValue": "0x0800082000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000012000 ",
+        "MSRValue": "0x0000012000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.ANY_RESPONSE",
@@ -599,29 +599,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000001000 ",
+        "MSRValue": "0x4000001000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Software Prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000401000 ",
+        "MSRValue": "0x1000401000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Software Prefetches that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800401000 ",
+        "MSRValue": "0x0800401000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE_E_F",
@@ -632,29 +632,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000081000 ",
+        "MSRValue": "0x1000081000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Software Prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800081000 ",
+        "MSRValue": "0x0800081000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts Software Prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000011000 ",
+        "MSRValue": "0x0000011000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.ANY_RESPONSE",
@@ -665,7 +665,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010800 ",
+        "MSRValue": "0x0000010800",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.FULL_STREAMING_STORES.ANY_RESPONSE",
@@ -676,29 +676,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000000400 ",
+        "MSRValue": "0x4000000400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Bus locks and split lock requests that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400400 ",
+        "MSRValue": "0x1000400400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400400 ",
+        "MSRValue": "0x0800400400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE_E_F",
@@ -709,29 +709,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080400 ",
+        "MSRValue": "0x1000080400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080400 ",
+        "MSRValue": "0x0800080400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010400 ",
+        "MSRValue": "0x0000010400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.ANY_RESPONSE",
@@ -742,29 +742,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000000200 ",
+        "MSRValue": "0x4000000200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400200 ",
+        "MSRValue": "0x1000400200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400200 ",
+        "MSRValue": "0x0800400200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_FAR_TILE_E_F",
@@ -775,29 +775,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080200 ",
+        "MSRValue": "0x1000080200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080200 ",
+        "MSRValue": "0x0800080200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010200 ",
+        "MSRValue": "0x0000010200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.ANY_RESPONSE",
@@ -808,18 +808,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400100 ",
+        "MSRValue": "0x1000400100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400100 ",
+        "MSRValue": "0x0800400100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE_E_F",
@@ -830,29 +830,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080100 ",
+        "MSRValue": "0x1000080100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080100 ",
+        "MSRValue": "0x0800080100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010100 ",
+        "MSRValue": "0x0000010100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.ANY_RESPONSE",
@@ -863,29 +863,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000000080 ",
+        "MSRValue": "0x4000000080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400080 ",
+        "MSRValue": "0x1000400080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400080 ",
+        "MSRValue": "0x0800400080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE_E_F",
@@ -896,29 +896,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080080 ",
+        "MSRValue": "0x1000080080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080080 ",
+        "MSRValue": "0x0800080080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010080 ",
+        "MSRValue": "0x0000010080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.ANY_RESPONSE",
@@ -929,29 +929,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000000040 ",
+        "MSRValue": "0x4000000040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 code HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts L2 code HW prefetches that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400040 ",
+        "MSRValue": "0x1000400040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 code HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts L2 code HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400040 ",
+        "MSRValue": "0x0800400040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE_E_F",
@@ -962,29 +962,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080040 ",
+        "MSRValue": "0x1000080040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 code HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts L2 code HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080040 ",
+        "MSRValue": "0x0800080040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 code HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts L2 code HW prefetches that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010040 ",
+        "MSRValue": "0x0000010040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.ANY_RESPONSE",
@@ -995,18 +995,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400020 ",
+        "MSRValue": "0x1000400020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400020 ",
+        "MSRValue": "0x0800400020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_FAR_TILE_E_F",
@@ -1017,29 +1017,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080020 ",
+        "MSRValue": "0x1000080020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080020 ",
+        "MSRValue": "0x0800080020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000020020 ",
+        "MSRValue": "0x0000020020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE",
@@ -1050,7 +1050,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010020 ",
+        "MSRValue": "0x0000010020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.ANY_RESPONSE",
@@ -1061,29 +1061,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000000004 ",
+        "MSRValue": "0x4000000004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400004 ",
+        "MSRValue": "0x1000400004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400004 ",
+        "MSRValue": "0x0800400004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE_E_F",
@@ -1094,29 +1094,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080004 ",
+        "MSRValue": "0x1000080004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080004 ",
+        "MSRValue": "0x0800080004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010004 ",
+        "MSRValue": "0x0000010004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
@@ -1127,29 +1127,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000000002 ",
+        "MSRValue": "0x4000000002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts Demand cacheable data writes that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400002 ",
+        "MSRValue": "0x1000400002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400002 ",
+        "MSRValue": "0x0800400002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE_E_F",
@@ -1160,29 +1160,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080002 ",
+        "MSRValue": "0x1000080002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080002 ",
+        "MSRValue": "0x0800080002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010002 ",
+        "MSRValue": "0x0000010002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
@@ -1193,29 +1193,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x4000000001 ",
+        "MSRValue": "0x4000000001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.OUTSTANDING",
         "MSRIndex": "0x1a6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The outstanding response should be programmed only on PMC0. ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that are outstanding, per weighted cycle, from the time of the request to when any response is received. The oustanding response should be programmed only on PMC0.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000400001 ",
+        "MSRValue": "0x1000400001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_FAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state. ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses from a snoop request hit with data forwarded from its Far(not in the same quadrant as the request)-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800400001 ",
+        "MSRValue": "0x0800400001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_FAR_TILE_E_F",
@@ -1226,29 +1226,29 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1000080001 ",
+        "MSRValue": "0x1000080001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_NEAR_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state. ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in M state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0800080001 ",
+        "MSRValue": "0x0800080001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_NEAR_TILE_E_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state. ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses from a snoop request hit with data forwarded from its Near-other tile's L2 in E/F state.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0000010001 ",
+        "MSRValue": "0x0000010001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
@@ -1259,722 +1259,722 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002000001 ",
+        "MSRValue": "0x0002000001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002000002 ",
+        "MSRValue": "0x0002000002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002000004 ",
+        "MSRValue": "0x0002000004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002000020 ",
+        "MSRValue": "0x0002000020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002000080 ",
+        "MSRValue": "0x0002000080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002000100 ",
+        "MSRValue": "0x0002000100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002000200 ",
+        "MSRValue": "0x0002000200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002000400 ",
+        "MSRValue": "0x0002000400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002001000 ",
+        "MSRValue": "0x0002001000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts Software Prefetches that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002002000 ",
+        "MSRValue": "0x0002002000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002008000 ",
+        "MSRValue": "0x0002008000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts any request that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002003091 ",
+        "MSRValue": "0x0002003091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002000022 ",
+        "MSRValue": "0x0002000022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002000044 ",
+        "MSRValue": "0x0002000044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x00020032f7 ",
+        "MSRValue": "0x00020032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts any Read request  that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0002000070 ",
+        "MSRValue": "0x0002000070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_THIS_TILE_M",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Prefetch requests that accounts for responses which hit its own tile's L2 with data in M state ",
+        "BriefDescription": "Counts any Prefetch requests that accounts for responses which hit its own tile's L2 with data in M state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000001 ",
+        "MSRValue": "0x0004000001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000002 ",
+        "MSRValue": "0x0004000002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000004 ",
+        "MSRValue": "0x0004000004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000020 ",
+        "MSRValue": "0x0004000020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000040 ",
+        "MSRValue": "0x0004000040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 code HW prefetches that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts L2 code HW prefetches that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000080 ",
+        "MSRValue": "0x0004000080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000100 ",
+        "MSRValue": "0x0004000100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000200 ",
+        "MSRValue": "0x0004000200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000400 ",
+        "MSRValue": "0x0004000400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004001000 ",
+        "MSRValue": "0x0004001000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts Software Prefetches that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004002000 ",
+        "MSRValue": "0x0004002000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004008000 ",
+        "MSRValue": "0x0004008000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts any request that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004003091 ",
+        "MSRValue": "0x0004003091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000022 ",
+        "MSRValue": "0x0004000022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000044 ",
+        "MSRValue": "0x0004000044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x00040032f7 ",
+        "MSRValue": "0x00040032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts any Read request  that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0004000070 ",
+        "MSRValue": "0x0004000070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_THIS_TILE_E",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Prefetch requests that accounts for responses which hit its own tile's L2 with data in E state ",
+        "BriefDescription": "Counts any Prefetch requests that accounts for responses which hit its own tile's L2 with data in E state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008000001 ",
+        "MSRValue": "0x0008000001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008000002 ",
+        "MSRValue": "0x0008000002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008000004 ",
+        "MSRValue": "0x0008000004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008000020 ",
+        "MSRValue": "0x0008000020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008000080 ",
+        "MSRValue": "0x0008000080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008000100 ",
+        "MSRValue": "0x0008000100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008000200 ",
+        "MSRValue": "0x0008000200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008000400 ",
+        "MSRValue": "0x0008000400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008001000 ",
+        "MSRValue": "0x0008001000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts Software Prefetches that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008002000 ",
+        "MSRValue": "0x0008002000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008008000 ",
+        "MSRValue": "0x0008008000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts any request that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008003091 ",
+        "MSRValue": "0x0008003091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008000022 ",
+        "MSRValue": "0x0008000022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0008000044 ",
+        "MSRValue": "0x0008000044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x00080032f7 ",
+        "MSRValue": "0x00080032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_S",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that accounts for responses which hit its own tile's L2 with data in S state ",
+        "BriefDescription": "Counts any Read request  that accounts for responses which hit its own tile's L2 with data in S state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000001 ",
+        "MSRValue": "0x0010000001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000002 ",
+        "MSRValue": "0x0010000002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts Demand cacheable data writes that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000004 ",
+        "MSRValue": "0x0010000004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000020 ",
+        "MSRValue": "0x0010000020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000040 ",
+        "MSRValue": "0x0010000040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 code HW prefetches that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts L2 code HW prefetches that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000080 ",
+        "MSRValue": "0x0010000080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000100 ",
+        "MSRValue": "0x0010000100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000200 ",
+        "MSRValue": "0x0010000200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000400 ",
+        "MSRValue": "0x0010000400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts Bus locks and split lock requests that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010001000 ",
+        "MSRValue": "0x0010001000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts Software Prefetches that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010002000 ",
+        "MSRValue": "0x0010002000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010008000 ",
+        "MSRValue": "0x0010008000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts any request that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010003091 ",
+        "MSRValue": "0x0010003091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000022 ",
+        "MSRValue": "0x0010000022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000044 ",
+        "MSRValue": "0x0010000044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x00100032f7 ",
+        "MSRValue": "0x00100032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts any Read request  that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0010000070 ",
+        "MSRValue": "0x0010000070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_THIS_TILE_F",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Prefetch requests that accounts for responses which hit its own tile's L2 with data in F state ",
+        "BriefDescription": "Counts any Prefetch requests that accounts for responses which hit its own tile's L2 with data in F state",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800180002 ",
+        "MSRValue": "0x1800180002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_NEAR_TILE",
@@ -1985,7 +1985,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800180004 ",
+        "MSRValue": "0x1800180004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_NEAR_TILE",
@@ -1996,7 +1996,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800180020 ",
+        "MSRValue": "0x1800180020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L2_HIT_NEAR_TILE",
@@ -2007,7 +2007,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800180040 ",
+        "MSRValue": "0x1800180040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_NEAR_TILE",
@@ -2018,7 +2018,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800180080 ",
+        "MSRValue": "0x1800180080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_NEAR_TILE",
@@ -2029,7 +2029,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800180100 ",
+        "MSRValue": "0x1800180100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_NEAR_TILE",
@@ -2040,7 +2040,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800180200 ",
+        "MSRValue": "0x1800180200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.L2_HIT_NEAR_TILE",
@@ -2051,7 +2051,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800180400 ",
+        "MSRValue": "0x1800180400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_NEAR_TILE",
@@ -2062,7 +2062,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800181000 ",
+        "MSRValue": "0x1800181000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_NEAR_TILE",
@@ -2073,7 +2073,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800182000 ",
+        "MSRValue": "0x1800182000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_NEAR_TILE",
@@ -2084,7 +2084,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800188000 ",
+        "MSRValue": "0x1800188000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_NEAR_TILE",
@@ -2095,7 +2095,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800183091 ",
+        "MSRValue": "0x1800183091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_NEAR_TILE",
@@ -2106,7 +2106,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800180022 ",
+        "MSRValue": "0x1800180022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_NEAR_TILE",
@@ -2117,7 +2117,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800180044 ",
+        "MSRValue": "0x1800180044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_NEAR_TILE",
@@ -2128,7 +2128,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x18001832f7 ",
+        "MSRValue": "0x18001832f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_NEAR_TILE",
@@ -2139,7 +2139,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800180070 ",
+        "MSRValue": "0x1800180070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_NEAR_TILE",
@@ -2150,7 +2150,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800400002 ",
+        "MSRValue": "0x1800400002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L2_HIT_FAR_TILE",
@@ -2161,7 +2161,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800400004 ",
+        "MSRValue": "0x1800400004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L2_HIT_FAR_TILE",
@@ -2172,7 +2172,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800400040 ",
+        "MSRValue": "0x1800400040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L2_HIT_FAR_TILE",
@@ -2183,7 +2183,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800400080 ",
+        "MSRValue": "0x1800400080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.L2_HIT_FAR_TILE",
@@ -2194,7 +2194,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800400100 ",
+        "MSRValue": "0x1800400100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.L2_HIT_FAR_TILE",
@@ -2205,7 +2205,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800400400 ",
+        "MSRValue": "0x1800400400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.L2_HIT_FAR_TILE",
@@ -2216,7 +2216,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800401000 ",
+        "MSRValue": "0x1800401000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.L2_HIT_FAR_TILE",
@@ -2227,7 +2227,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800402000 ",
+        "MSRValue": "0x1800402000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.L2_HIT_FAR_TILE",
@@ -2238,7 +2238,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800408000 ",
+        "MSRValue": "0x1800408000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.L2_HIT_FAR_TILE",
@@ -2249,7 +2249,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800403091 ",
+        "MSRValue": "0x1800403091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.L2_HIT_FAR_TILE",
@@ -2260,7 +2260,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800400022 ",
+        "MSRValue": "0x1800400022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.L2_HIT_FAR_TILE",
@@ -2271,7 +2271,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800400044 ",
+        "MSRValue": "0x1800400044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.L2_HIT_FAR_TILE",
@@ -2282,7 +2282,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x18004032f7 ",
+        "MSRValue": "0x18004032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.L2_HIT_FAR_TILE",
@@ -2293,7 +2293,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x1800400070 ",
+        "MSRValue": "0x1800400070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.L2_HIT_FAR_TILE",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/memory.json b/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
index 700652566200..c6bb16ba0f86 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/memory.json
@@ -9,18 +9,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400070 ",
+        "MSRValue": "0x0100400070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Prefetch requests that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts any Prefetch requests that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200070 ",
+        "MSRValue": "0x0080200070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.MCDRAM_NEAR",
@@ -31,18 +31,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000070 ",
+        "MSRValue": "0x0101000070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Prefetch requests that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts any Prefetch requests that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800070 ",
+        "MSRValue": "0x0080800070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.DDR_NEAR",
@@ -53,18 +53,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x01004032f7 ",
+        "MSRValue": "0x01004032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts any Read request  that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x00802032f7 ",
+        "MSRValue": "0x00802032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.MCDRAM_NEAR",
@@ -75,18 +75,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x01010032f7 ",
+        "MSRValue": "0x01010032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any Read request  that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts any Read request  that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x00808032f7 ",
+        "MSRValue": "0x00808032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.DDR_NEAR",
@@ -97,18 +97,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400044 ",
+        "MSRValue": "0x0100400044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200044 ",
+        "MSRValue": "0x0080200044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.MCDRAM_NEAR",
@@ -119,18 +119,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000044 ",
+        "MSRValue": "0x0101000044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts Demand code reads and prefetch code read requests  that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800044 ",
+        "MSRValue": "0x0080800044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.DDR_NEAR",
@@ -141,18 +141,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400022 ",
+        "MSRValue": "0x0100400022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200022 ",
+        "MSRValue": "0x0080200022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.MCDRAM_NEAR",
@@ -163,18 +163,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000022 ",
+        "MSRValue": "0x0101000022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts Demand cacheable data write requests  that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800022 ",
+        "MSRValue": "0x0080800022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.DDR_NEAR",
@@ -185,18 +185,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100403091 ",
+        "MSRValue": "0x0100403091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080203091 ",
+        "MSRValue": "0x0080203091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.MCDRAM_NEAR",
@@ -207,18 +207,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101003091 ",
+        "MSRValue": "0x0101003091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts Demand cacheable data and L1 prefetch data read requests  that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080803091 ",
+        "MSRValue": "0x0080803091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.DDR_NEAR",
@@ -229,18 +229,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100408000 ",
+        "MSRValue": "0x0100408000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts any request that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080208000 ",
+        "MSRValue": "0x0080208000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.MCDRAM_NEAR",
@@ -251,18 +251,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101008000 ",
+        "MSRValue": "0x0101008000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts any request that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts any request that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080808000 ",
+        "MSRValue": "0x0080808000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.DDR_NEAR",
@@ -273,18 +273,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100402000 ",
+        "MSRValue": "0x0100402000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080202000 ",
+        "MSRValue": "0x0080202000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.MCDRAM_NEAR",
@@ -295,18 +295,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101002000 ",
+        "MSRValue": "0x0101002000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L1 data HW prefetches that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts L1 data HW prefetches that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080802000 ",
+        "MSRValue": "0x0080802000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.DDR_NEAR",
@@ -317,18 +317,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100401000 ",
+        "MSRValue": "0x0100401000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts Software Prefetches that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080201000 ",
+        "MSRValue": "0x0080201000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.MCDRAM_NEAR",
@@ -339,18 +339,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101001000 ",
+        "MSRValue": "0x0101001000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Software Prefetches that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts Software Prefetches that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080801000 ",
+        "MSRValue": "0x0080801000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.DDR_NEAR",
@@ -361,18 +361,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400400 ",
+        "MSRValue": "0x0100400400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts Bus locks and split lock requests that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200400 ",
+        "MSRValue": "0x0080200400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.MCDRAM_NEAR",
@@ -383,18 +383,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000400 ",
+        "MSRValue": "0x0101000400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Bus locks and split lock requests that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts Bus locks and split lock requests that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800400 ",
+        "MSRValue": "0x0080800400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.DDR_NEAR",
@@ -405,18 +405,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400200 ",
+        "MSRValue": "0x0100400200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200200 ",
+        "MSRValue": "0x0080200200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.MCDRAM_NEAR",
@@ -427,18 +427,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000200 ",
+        "MSRValue": "0x0101000200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts UC code reads (valid only for Outstanding response type)  that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800200 ",
+        "MSRValue": "0x0080800200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.DDR_NEAR",
@@ -449,18 +449,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400100 ",
+        "MSRValue": "0x0100400100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.MCDRAM_FAR",
         "MSRIndex": "0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200100 ",
+        "MSRValue": "0x0080200100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.MCDRAM_NEAR",
@@ -471,18 +471,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000100 ",
+        "MSRValue": "0x0101000100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.DDR_FAR",
         "MSRIndex": "0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts Partial writes (UC or WT or WP and should be programmed on PMC1) that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800100 ",
+        "MSRValue": "0x0080800100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.DDR_NEAR",
@@ -493,7 +493,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x2000020080 ",
+        "MSRValue": "0x2000020080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.NON_DRAM",
@@ -504,18 +504,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400080 ",
+        "MSRValue": "0x0100400080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200080 ",
+        "MSRValue": "0x0080200080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.MCDRAM_NEAR",
@@ -526,18 +526,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000080 ",
+        "MSRValue": "0x0101000080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts Partial reads (UC or WC and is valid only for Outstanding response type).  that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800080 ",
+        "MSRValue": "0x0080800080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.DDR_NEAR",
@@ -548,18 +548,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400040 ",
+        "MSRValue": "0x0100400040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 code HW prefetches that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts L2 code HW prefetches that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200040 ",
+        "MSRValue": "0x0080200040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.MCDRAM_NEAR",
@@ -570,18 +570,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000040 ",
+        "MSRValue": "0x0101000040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 code HW prefetches that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts L2 code HW prefetches that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800040 ",
+        "MSRValue": "0x0080800040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.DDR_NEAR",
@@ -592,7 +592,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x2000020020 ",
+        "MSRValue": "0x2000020020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.NON_DRAM",
@@ -603,18 +603,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400020 ",
+        "MSRValue": "0x0100400020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200020 ",
+        "MSRValue": "0x0080200020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.MCDRAM_NEAR",
@@ -625,18 +625,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000020 ",
+        "MSRValue": "0x0101000020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts L2 data RFO prefetches (includes PREFETCHW instruction) that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800020 ",
+        "MSRValue": "0x0080800020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.DDR_NEAR",
@@ -647,18 +647,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400004 ",
+        "MSRValue": "0x0100400004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200004 ",
+        "MSRValue": "0x0080200004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.MCDRAM_NEAR",
@@ -669,18 +669,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000004 ",
+        "MSRValue": "0x0101000004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts demand code reads and prefetch code reads that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800004 ",
+        "MSRValue": "0x0080800004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.DDR_NEAR",
@@ -691,18 +691,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400002 ",
+        "MSRValue": "0x0100400002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts Demand cacheable data writes that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200002 ",
+        "MSRValue": "0x0080200002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.MCDRAM_NEAR",
@@ -713,18 +713,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000002 ",
+        "MSRValue": "0x0101000002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts Demand cacheable data writes that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts Demand cacheable data writes that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800002 ",
+        "MSRValue": "0x0080800002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.DDR_NEAR",
@@ -735,18 +735,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0100400001 ",
+        "MSRValue": "0x0100400001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.MCDRAM_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for data responses from MCDRAM Far or Other tile L2 hit far. ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for data responses from MCDRAM Far or Other tile L2 hit far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080200001 ",
+        "MSRValue": "0x0080200001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.MCDRAM_NEAR",
@@ -757,18 +757,18 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0101000001 ",
+        "MSRValue": "0x0101000001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.DDR_FAR",
         "MSRIndex": "0x1a6,0x1a7",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for data responses from DRAM Far. ",
+        "BriefDescription": "Counts demand cacheable data and L1 prefetch data reads that accounts for data responses from DRAM Far.",
         "Offcore": "1"
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0080800001 ",
+        "MSRValue": "0x0080800001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.DDR_NEAR",
@@ -779,7 +779,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180600001 ",
+        "MSRValue": "0x0180600001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.MCDRAM",
@@ -790,7 +790,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180600002 ",
+        "MSRValue": "0x0180600002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.MCDRAM",
@@ -801,7 +801,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180600004 ",
+        "MSRValue": "0x0180600004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.MCDRAM",
@@ -812,7 +812,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180600020 ",
+        "MSRValue": "0x0180600020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.MCDRAM",
@@ -823,7 +823,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180600080 ",
+        "MSRValue": "0x0180600080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.MCDRAM",
@@ -834,7 +834,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180600100 ",
+        "MSRValue": "0x0180600100",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_WRITES.MCDRAM",
@@ -845,7 +845,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180600200 ",
+        "MSRValue": "0x0180600200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.MCDRAM",
@@ -856,7 +856,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180600400 ",
+        "MSRValue": "0x0180600400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.MCDRAM",
@@ -867,7 +867,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180601000 ",
+        "MSRValue": "0x0180601000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.MCDRAM",
@@ -878,7 +878,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180608000 ",
+        "MSRValue": "0x0180608000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.MCDRAM",
@@ -889,7 +889,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180603091 ",
+        "MSRValue": "0x0180603091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.MCDRAM",
@@ -900,7 +900,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180600022 ",
+        "MSRValue": "0x0180600022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.MCDRAM",
@@ -911,7 +911,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180600044 ",
+        "MSRValue": "0x0180600044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.MCDRAM",
@@ -922,7 +922,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x01806032f7 ",
+        "MSRValue": "0x01806032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.MCDRAM",
@@ -933,7 +933,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0180600070 ",
+        "MSRValue": "0x0180600070",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_PF_L2.MCDRAM",
@@ -944,7 +944,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181800001 ",
+        "MSRValue": "0x0181800001",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.DDR",
@@ -955,7 +955,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181800002 ",
+        "MSRValue": "0x0181800002",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.DDR",
@@ -966,7 +966,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181800004 ",
+        "MSRValue": "0x0181800004",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.DDR",
@@ -977,7 +977,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181800020 ",
+        "MSRValue": "0x0181800020",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.DDR",
@@ -988,7 +988,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181800040 ",
+        "MSRValue": "0x0181800040",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.DDR",
@@ -999,7 +999,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181800080 ",
+        "MSRValue": "0x0181800080",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PARTIAL_READS.DDR",
@@ -1010,7 +1010,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181800200 ",
+        "MSRValue": "0x0181800200",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.UC_CODE_READS.DDR",
@@ -1021,7 +1021,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181800400 ",
+        "MSRValue": "0x0181800400",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.BUS_LOCKS.DDR",
@@ -1032,7 +1032,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181801000 ",
+        "MSRValue": "0x0181801000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_SOFTWARE.DDR",
@@ -1043,7 +1043,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181802000 ",
+        "MSRValue": "0x0181802000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L1_DATA_RD.DDR",
@@ -1054,7 +1054,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181808000 ",
+        "MSRValue": "0x0181808000",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_REQUEST.DDR",
@@ -1065,7 +1065,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181803091 ",
+        "MSRValue": "0x0181803091",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_DATA_RD.DDR",
@@ -1076,7 +1076,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181800022 ",
+        "MSRValue": "0x0181800022",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_RFO.DDR",
@@ -1087,7 +1087,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x0181800044 ",
+        "MSRValue": "0x0181800044",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_CODE_RD.DDR",
@@ -1098,7 +1098,7 @@
     },
     {
         "EventCode": "0xB7",
-        "MSRValue": "0x01818032f7 ",
+        "MSRValue": "0x01818032f7",
         "Counter": "0,1",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ANY_READ.DDR",
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
index bb5494cfb5ae..92e4ef2e22c6 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
@@ -144,7 +144,7 @@
         "BriefDescription": "Counts the number of micro-ops retired that are from the complex flows issued by the micro-sequencer (MS)."
     },
     {
-        "PublicDescription": "This event counts the number of micro-ops (uops) retired. The processor decodes complex macro instructions into a sequence of simpler uops. Most instructions are composed of one or two uops. Some instructions are decoded into longer sequences such as repeat instructions, floating point transcendental instructions, and assists. ",
+        "PublicDescription": "This event counts the number of micro-ops (uops) retired. The processor decodes complex macro instructions into a sequence of simpler uops. Most instructions are composed of one or two uops. Some instructions are decoded into longer sequences such as repeat instructions, floating point transcendental instructions, and assists.",
         "EventCode": "0xC2",
         "Counter": "0,1",
         "UMask": "0x10",
@@ -218,7 +218,7 @@
         "UMask": "0x20",
         "EventName": "NO_ALLOC_CYCLES.RAT_STALL",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of core cycles when no micro-ops are allocated and a RATstall (caused by reservation station full) is asserted.  "
+        "BriefDescription": "Counts the number of core cycles when no micro-ops are allocated and a RATstall (caused by reservation station full) is asserted."
     },
     {
         "PublicDescription": "This event counts the number of core cycles when no uops are allocated, the instruction queue is empty and the alloc pipe is stalled waiting for instructions to be fetched.",
@@ -251,7 +251,7 @@
         "UMask": "0x1f",
         "EventName": "RS_FULL_STALL.ALL",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the total number of core cycles the Alloc pipeline is stalled when any one of the reservation stations is full. "
+        "BriefDescription": "Counts the total number of core cycles the Alloc pipeline is stalled when any one of the reservation stations is full."
     },
     {
         "EventCode": "0xC0",
@@ -268,11 +268,10 @@
         "UMask": "0x1",
         "EventName": "CYCLES_DIV_BUSY.ALL",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles the number of core cycles when divider is busy.  Does not imply a stall waiting for the divider.  "
+        "BriefDescription": "Cycles the number of core cycles when divider is busy.  Does not imply a stall waiting for the divider."
     },
     {
         "PublicDescription": "This event counts the number of instructions that retire.  For instructions that consist of multiple micro-ops, this event counts exactly once, as the last micro-op of the instruction retires.  The event continues counting while instructions retire, including during interrupt service routines caused by hardware interrupts, faults or traps.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x1",
         "EventName": "INST_RETIRED.ANY",
@@ -296,8 +295,7 @@
         "BriefDescription": "Counts the number of unhalted reference clock cycles"
     },
     {
-        "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter\r\n",
-        "EventCode": "0x00",
+        "PublicDescription": "This event counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter",
         "Counter": "Fixed counter 2",
         "UMask": "0x2",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
@@ -305,7 +303,6 @@
         "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles"
     },
     {
-        "EventCode": "0x00",
         "Counter": "Fixed counter 3",
         "UMask": "0x3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
@@ -343,7 +340,7 @@
         "UMask": "0x1",
         "EventName": "RECYCLEQ.LD_BLOCK_ST_FORWARD",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of occurences a retired load gets blocked because its address partially overlaps with a store ",
+        "BriefDescription": "Counts the number of occurences a retired load gets blocked because its address partially overlaps with a store",
         "Data_LA": "1"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
index f31594507f8c..9e493977771f 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
@@ -36,7 +36,7 @@
         "EdgeDetect": "1"
     },
     {
-        "PublicDescription": "This event counts every cycle when an I-side (walks due to an instruction fetch) page walk is in progress. ",
+        "PublicDescription": "This event counts every cycle when an I-side (walks due to an instruction fetch) page walk is in progress.",
         "EventCode": "0x05",
         "Counter": "0,1",
         "UMask": "0x2",
-- 
2.20.1

