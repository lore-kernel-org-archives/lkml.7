Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094A7C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCB920857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221277;
	bh=Eq4Ju++VKbhJEzO/mees4dREd6urQlZMyOeufdKO1x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T/i6kgEt19gnLm0zKUNE59bVCU+inPy8k/vF4Xpv4L7j7RFnRY3Ji6wNn5IOn34HS
	 ct9X50eFaQzqMr1YjuMNnpdQ4B3fFX5acwQbSiuqKVpttyy2qV3hOKmIbGCjarIhFu
	 cJ8Mijhjz69VRZ0xW9D2ziJZcpdroDJPK+WLeneA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfDBQHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbfDBQHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:07:52 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86D3A2082C;
        Tue,  2 Apr 2019 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221264;
        bh=Eq4Ju++VKbhJEzO/mees4dREd6urQlZMyOeufdKO1x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pi8HED3uIvjfnWrec0U6AW4AHojviMStSLjhMRTzuy8J3Jn/j4o6/Ifm1/RyM3fLF
         eJsKIGiay0tTfn5RQEGsDiegnvTO1pVH5aXuj0TMpmKhrBPeC7TFKqULevzJnbpT+m
         fglsY9+okvBPBJZGyhYRIZ/dlwAn5jBci/IqZjcY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/44] perf vendor events intel: Update Skylake events to v42
Date:   Tue,  2 Apr 2019 13:05:36 -0300
Message-Id: <20190402160549.13544-32-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
 .../pmu-events/arch/x86/skylake/cache.json    | 2193 ++++++++++++++++-
 .../pmu-events/arch/x86/skylake/frontend.json |   14 +-
 .../pmu-events/arch/x86/skylake/memory.json   | 1121 ++++++++-
 .../pmu-events/arch/x86/skylake/pipeline.json |   39 +-
 4 files changed, 3181 insertions(+), 186 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylake/cache.json b/tools/perf=
/pmu-events/arch/x86/skylake/cache.json
index 54bfe9e4045c..720458139049 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/cache.json
@@ -60,10 +60,10 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Counts the number of demand Data Read reques=
ts that hit L2 cache. Only non rejected loads are counted.",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts, initiated by load instructions, that hit L2 cache",
         "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x41",
+        "UMask": "0xc1",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "SampleAfterValue": "200003",
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
@@ -73,7 +73,7 @@
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
         "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x42",
+        "UMask": "0xc2",
         "EventName": "L2_RQSTS.RFO_HIT",
         "SampleAfterValue": "200003",
         "BriefDescription": "RFO requests that hit L2 cache",
@@ -83,7 +83,7 @@
         "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
         "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x44",
+        "UMask": "0xc4",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "SampleAfterValue": "200003",
         "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
@@ -482,7 +482,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.\r\n",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
         "EventCode": "0xD1",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
@@ -554,7 +554,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready. \r\n",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
         "EventCode": "0xD1",
         "Counter": "0,1,2,3",
         "UMask": "0x40",
@@ -661,13 +661,13 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Counts the number of lines that have been ha=
rdware prefetched but not used and now evicted by L2 cache.",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 L2_LINES_OUT.USELESS_HWPF",
         "EventCode": "0xF2",
         "Counter": "0,1,2,3",
         "UMask": "0x4",
         "EventName": "L2_LINES_OUT.USELESS_PREF",
         "SampleAfterValue": "200003",
-        "BriefDescription": "Counts the number of lines that have been har=
dware prefetched but not used and now evicted by L2 cache",
+        "BriefDescription": "This event is deprecated. Refer to new event =
L2_LINES_OUT.USELESS_HWPF",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -690,249 +690,2238 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fc0400001 ",
+        "MSRValue": "0x3FC0408000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.ANY_=
SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L4_HIT_LOCAL_L4 & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000400001 ",
+        "MSRValue": "0x1000408000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L4_HIT_LOCAL_L4 & SNOOP_HITM=
",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400400001 ",
+        "MSRValue": "0x0400408000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_HIT_NO_=
FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L4_HIT_LOCAL_L4 & SNOOP_HIT_=
NO_FWD",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200400001 ",
+        "MSRValue": "0x0200408000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L4_HIT_LOCAL_L4 & SNOOP_MISS=
",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100400001 ",
+        "MSRValue": "0x0100408000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_NOT_NEE=
DED",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L4_HIT_LOCAL_L4 & SNOOP_NOT_=
NEEDED",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080400001 ",
+        "MSRValue": "0x0080408000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L4_HIT_LOCAL_L4 & SNOOP_NONE=
",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fc01c0001 ",
+        "MSRValue": "0x0040408000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_HIT & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10001c0001 ",
+        "MSRValue": "0x3FC01C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that hit in the L3 =
and the snoops to sibling cores hit in either E/S state and the line is not=
 forwarded. Offcore response can be programmed only with a specific pair of=
 event select and counter MSR, and with specific event codes and predefine =
mask bit value in a dedicated MSR to specify attributes of the offcore tran=
saction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04001c0001 ",
+        "MSRValue": "0x10001C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the L3 a=
nd the snoops to sibling cores hit in either E/S state and the line is not =
forwarded.",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that hit in the L3 =
and the snoops sent to sibling cores return clean response. Offcore respons=
e can be programmed only with a specific pair of event select and counter M=
SR, and with specific event codes and predefine mask bit value in a dedicat=
ed MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02001c0001 ",
+        "MSRValue": "0x04001C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the L3 a=
nd the snoops sent to sibling cores return clean response.",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that hit in the L3 =
and sibling core snoops are not needed as either the core-valid bit is not =
set or the shared line is present in multiple cores. Offcore response can b=
e programmed only with a specific pair of event select and counter MSR, and=
 with specific event codes and predefine mask bit value in a dedicated MSR =
to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01001c0001 ",
+        "MSRValue": "0x02001C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the L3 a=
nd sibling core snoops are not needed as either the core-valid bit is not s=
et or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00801c0001 ",
+        "MSRValue": "0x01001C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_HIT & SNOOP_NONE",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fc0020001 ",
+        "MSRValue": "0x00801C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.ANY_SN=
OOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020001 ",
+        "MSRValue": "0x00401C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020001 ",
+        "MSRValue": "0x3FC0108000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & SNOOP_HIT_NO=
_FWD",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020001 ",
+        "MSRValue": "0x1000108000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020001 ",
+        "MSRValue": "0x0400108000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & SNOOP_NOT_NE=
EDED",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020001 ",
+        "MSRValue": "0x0200108000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
-        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100108000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080108000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040108000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0088000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000088000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400088000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200088000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100088000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080088000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040088000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0048000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000048000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400048000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200048000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100048000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080048000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040048000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0028000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000028000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400028000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_HIT_NO_FW=
D",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200028000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100028000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NOT_NEEDE=
D",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080028000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040028000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests have any response =
type.",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0000018000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.ANY_RESPONSE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests have any response t=
ype.",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.ANY_=
SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SPL_=
HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC01C0004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x10001C0004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x04001C0004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x02001C0004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x01001C0004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00801C0004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00401C0004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0100004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000100004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400100004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_HIT_N=
O_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200100004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100100004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_NOT_N=
EEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080100004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040100004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0080004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000080004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400080004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_HIT_N=
O_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200080004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100080004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_NOT_N=
EEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080080004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040080004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0040004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000040004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400040004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_HIT_N=
O_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200040004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100040004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_NOT_N=
EEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080040004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040040004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0020004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.ANY_SN=
OOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000020004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400020004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200020004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100020004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080020004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040020004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SPL_HI=
T",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that have any response type.",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0000010004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any response type.",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.ANY_SNOO=
P",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_HI=
TM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_HI=
T_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_MI=
SS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_NO=
T_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_NO=
NE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC01C0002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x10001C0002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x04001C0002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x02001C0002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x01001C0002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00801C0002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00401C0002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0100002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000100002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400100002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_HIT_NO_FW=
D",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200100002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100100002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_NOT_NEEDE=
D",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080100002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040100002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0080002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000080002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400080002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_HIT_NO_FW=
D",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200080002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100080002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_NOT_NEEDE=
D",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080080002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040080002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0040002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000040002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400040002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_HIT_NO_FW=
D",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200040002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100040002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_NOT_NEEDE=
D",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080040002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040040002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0020002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000020002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_HITM=
",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400020002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_HIT_=
NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200020002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_MISS=
",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100020002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_NOT_=
NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080020002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_NONE=
",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040020002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs) have an=
y response type.",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0000010002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs) have any=
 response type.",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0400001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.ANY_=
SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000400001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400400001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200400001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100400001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080400001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040400001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SPL_=
HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC01C0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x10001C0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x04001C0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x02001C0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x01001C0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00801C0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00401C0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0100001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000100001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400100001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_HIT_N=
O_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200100001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100100001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_NOT_N=
EEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080100001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040100001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0080001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000080001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400080001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_HIT_N=
O_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200080001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100080001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_NOT_N=
EEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080080001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040080001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0040001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000040001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400040001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_HIT_N=
O_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200040001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100040001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_NOT_N=
EEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080040001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040040001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC0020001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.ANY_SN=
OOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1000020001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0400020001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0200020001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0100020001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0080020001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0040020001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SPL_HI=
T",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that have any respo=
nse type. Offcore response can be programmed only with a specific pair of e=
vent select and counter MSR, and with specific event codes and predefine ma=
sk bit value in a dedicated MSR to specify attributes of the offcore transa=
ction.",
+        "PublicDescription": "Counts demand data reads have any response t=
ype.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010001 ",
+        "MSRValue": "0x0000010001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that have any respon=
se type.",
+        "BriefDescription": "Counts demand data reads have any response ty=
pe.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     }
diff --git a/tools/perf/pmu-events/arch/x86/skylake/frontend.json b/tools/p=
erf/pmu-events/arch/x86/skylake/frontend.json
index 578dff5bd823..7fa95a35e3ca 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/frontend.json
@@ -177,7 +177,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Counts the number of uops not delivered to R=
esource Allocation Table (RAT) per thread adding 4  x when Resource Allocat=
ion Table (RAT) is not stalled and Instruction Decode Queue (IDQ) delivers =
x uops to Resource Allocation Table (RAT) (where x belongs to {0,1,2,3}). C=
ounting does not cover cases when: a. IDQ-Resource Allocation Table (RAT) p=
ipe serves the other thread. b. Resource Allocation Table (RAT) is stalled =
for the thread (including uop drops and clear BE conditions).  c. Instructi=
on Decode Queue (IDQ) delivers four uops.",
+        "PublicDescription": "Counts the number of uops not delivered to R=
esource Allocation Table (RAT) per thread adding \u201c4 \u2013 x\u201d whe=
n Resource Allocation Table (RAT) is not stalled and Instruction Decode Que=
ue (IDQ) delivers x uops to Resource Allocation Table (RAT) (where x belong=
s to {0,1,2,3}). Counting does not cover cases when: a. IDQ-Resource Alloca=
tion Table (RAT) pipe serves the other thread. b. Resource Allocation Table=
 (RAT) is stalled for the thread (including uop drops and clear BE conditio=
ns).  c. Instruction Decode Queue (IDQ) delivers four uops.",
         "EventCode": "0x9C",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
@@ -242,7 +242,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Counts Decode Stream Buffer (DSB)-to-MITE sw=
itch true penalty cycles. These cycles do not include uops routed through b=
ecause of the switch itself, for example, when Instruction Decode Queue (ID=
Q) pre-allocation is unavailable, or Instruction Decode Queue (IDQ) is full=
. SBD-to-MITE switch true penalty cycles happen after the merge mux (MM) re=
ceives Decode Stream Buffer (DSB) Sync-indication until receiving the first=
 MITE uop. MM is placed before Instruction Decode Queue (IDQ) to merge uops=
 being fed from the MITE and Decode Stream Buffer (DSB) paths. Decode Strea=
m Buffer (DSB) inserts the Sync-indication whenever a Decode Stream Buffer =
(DSB)-to-MITE switch occurs.Penalty: A Decode Stream Buffer (DSB) hit follo=
wed by a Decode Stream Buffer (DSB) miss can cost up to six cycles in which=
 no uops are delivered to the IDQ. Most often, such switches from the Decod=
e Stream Buffer (DSB) to the legacy pipeline cost 02 cycles.",
+        "PublicDescription": "Counts Decode Stream Buffer (DSB)-to-MITE sw=
itch true penalty cycles. These cycles do not include uops routed through b=
ecause of the switch itself, for example, when Instruction Decode Queue (ID=
Q) pre-allocation is unavailable, or Instruction Decode Queue (IDQ) is full=
. SBD-to-MITE switch true penalty cycles happen after the merge mux (MM) re=
ceives Decode Stream Buffer (DSB) Sync-indication until receiving the first=
 MITE uop. MM is placed before Instruction Decode Queue (IDQ) to merge uops=
 being fed from the MITE and Decode Stream Buffer (DSB) paths. Decode Strea=
m Buffer (DSB) inserts the Sync-indication whenever a Decode Stream Buffer =
(DSB)-to-MITE switch occurs.Penalty: A Decode Stream Buffer (DSB) hit follo=
wed by a Decode Stream Buffer (DSB) miss can cost up to six cycles in which=
 no uops are delivered to the IDQ. Most often, such switches from the Decod=
e Stream Buffer (DSB) to the legacy pipeline cost 0\u20132 cycles.",
         "EventCode": "0xAB",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
@@ -253,7 +253,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss. \r\n",
+        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
         "EventCode": "0xC6",
         "MSRValue": "0x11",
         "Counter": "0,1,2,3",
@@ -360,7 +360,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops. \r\n",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
         "EventCode": "0xC6",
         "MSRValue": "0x400806",
         "Counter": "0,1,2,3",
@@ -374,7 +374,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.\r\n",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
         "EventCode": "0xC6",
         "MSRValue": "0x401006",
         "Counter": "0,1,2,3",
@@ -388,7 +388,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end  after a front-end stall of at least 32 cycles. During t=
his period the front-end delivered no uops.\r\n",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end  after a front-end stall of at least 32 cycles. During t=
his period the front-end delivered no uops.",
         "EventCode": "0xC6",
         "MSRValue": "0x402006",
         "Counter": "0,1,2,3",
@@ -454,7 +454,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.\r\n",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
         "EventCode": "0xC6",
         "MSRValue": "0x100206",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/memory.json b/tools/per=
f/pmu-events/arch/x86/skylake/memory.json
index 3bd8b712c889..f197b4c7695b 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/memory.json
@@ -215,7 +215,7 @@
         "UMask": "0x4",
         "EventName": "HLE_RETIRED.ABORTED",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of times an HLE execution aborted due =
to any reasons (multiple categories may count as one). ",
+        "BriefDescription": "Number of times an HLE execution aborted due =
to any reasons (multiple categories may count as one).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -237,6 +237,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
+        "PublicDescription": "Number of times an HLE execution aborted due=
 to HLE-unfriendly instructions and certain unfriendly events (such as AD a=
ssists etc.).",
         "EventCode": "0xC8",
         "Counter": "0,1,2,3",
         "UMask": "0x20",
@@ -292,7 +293,7 @@
         "UMask": "0x4",
         "EventName": "RTM_RETIRED.ABORTED",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of times an RTM execution aborted due =
to any reasons (multiple categories may count as one). ",
+        "BriefDescription": "Number of times an RTM execution aborted due =
to any reasons (multiple categories may count as one).",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -346,7 +347,7 @@
     },
     {
         "PEBS": "2",
-        "PublicDescription": "Counts loads when the latency from first dis=
patch to completion is greater than 4 cycles.  Reported latency may be long=
er than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "EventCode": "0xCD",
         "MSRValue": "0x4",
         "Counter": "0,1,2,3",
@@ -354,13 +355,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts loads when the latency from first disp=
atch to completion is greater than 4 cycles.",
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 4 cycles.",
         "TakenAlone": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "Counts loads when the latency from first dis=
patch to completion is greater than 8 cycles.  Reported latency may be long=
er than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "EventCode": "0xCD",
         "MSRValue": "0x8",
         "Counter": "0,1,2,3",
@@ -368,13 +369,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "50021",
-        "BriefDescription": "Counts loads when the latency from first disp=
atch to completion is greater than 8 cycles.",
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 8 cycles.",
         "TakenAlone": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "Counts loads when the latency from first dis=
patch to completion is greater than 16 cycles.  Reported latency may be lon=
ger than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
         "EventCode": "0xCD",
         "MSRValue": "0x10",
         "Counter": "0,1,2,3",
@@ -382,13 +383,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "20011",
-        "BriefDescription": "Counts loads when the latency from first disp=
atch to completion is greater than 16 cycles.",
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 16 cycles.",
         "TakenAlone": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "Counts loads when the latency from first dis=
patch to completion is greater than 32 cycles.  Reported latency may be lon=
ger than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
         "EventCode": "0xCD",
         "MSRValue": "0x20",
         "Counter": "0,1,2,3",
@@ -396,13 +397,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Counts loads when the latency from first disp=
atch to completion is greater than 32 cycles.",
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 32 cycles.",
         "TakenAlone": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "Counts loads when the latency from first dis=
patch to completion is greater than 64 cycles.  Reported latency may be lon=
ger than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
         "EventCode": "0xCD",
         "MSRValue": "0x40",
         "Counter": "0,1,2,3",
@@ -410,13 +411,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "2003",
-        "BriefDescription": "Counts loads when the latency from first disp=
atch to completion is greater than 64 cycles.",
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 64 cycles.",
         "TakenAlone": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "Counts loads when the latency from first dis=
patch to completion is greater than 128 cycles.  Reported latency may be lo=
nger than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "EventCode": "0xCD",
         "MSRValue": "0x80",
         "Counter": "0,1,2,3",
@@ -424,13 +425,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "1009",
-        "BriefDescription": "Counts loads when the latency from first disp=
atch to completion is greater than 128 cycles.",
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
         "TakenAlone": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "Counts loads when the latency from first dis=
patch to completion is greater than 256 cycles.  Reported latency may be lo=
nger than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "EventCode": "0xCD",
         "MSRValue": "0x100",
         "Counter": "0,1,2,3",
@@ -438,13 +439,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "503",
-        "BriefDescription": "Counts loads when the latency from first disp=
atch to completion is greater than 256 cycles.",
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
         "TakenAlone": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "Counts loads when the latency from first dis=
patch to completion is greater than 512 cycles.  Reported latency may be lo=
nger than just the memory latency.",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "EventCode": "0xCD",
         "MSRValue": "0x200",
         "Counter": "0,1,2,3",
@@ -452,163 +453,1151 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "101",
-        "BriefDescription": "Counts loads when the latency from first disp=
atch to completion is greater than 512 cycles.",
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 512 cycles.",
         "TakenAlone": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3ffc000001 ",
+        "MSRValue": "0x3FFC408000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x203C408000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x103C408000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x043C408000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x023C408000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x013C408000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00BC408000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x007C408000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC4008000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2004008000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NON_=
DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1004008000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_HITM=
",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0404008000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_HIT_=
NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0204008000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_MISS=
",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0104008000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NOT_=
NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0084008000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NONE=
",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0044008000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000408000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L4_HIT_LOCAL_L4.SNOOP_NON_DRA=
M",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x20001C8000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000108000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_S.SNOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000088000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_E.SNOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000048000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT_M.SNOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts any other requests",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000028000",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts any other requests",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FFC400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x203C400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NON_DR=
AM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x103C400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x043C400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x023C400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x013C400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00BC400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x007C400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC4000004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.A=
NY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2004000004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1004000004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0404000004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0204000004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0104000004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0084000004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0044000004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
PL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000400004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L4_HIT_LOCAL_L4.SNOO=
P_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x20001C0004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NON_DRA=
M",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000100004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_S.SNOOP_NON_D=
RAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000080004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_E.SNOOP_NON_D=
RAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000040004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT_M.SNOOP_NON_D=
RAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand instruction fetches and L1 ins=
truction cache prefetches that",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000020004",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FFC400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.ANY_SNOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x203C400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x103C400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x043C400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_HIT_NO_FWD=
",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x023C400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x013C400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NOT_NEEDED=
",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x00BC400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x007C400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FC4000002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.ANY_S=
NOOP",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2004000002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1004000002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_HITM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0404000002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_HIT_NO_FWD",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0204000002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_MISS",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0104000002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NOT_NEEDED",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0084000002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NONE",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0044000002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.SPL_H=
IT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000400002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L4_HIT_LOCAL_L4.SNOOP_NO=
N_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x20001C0002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000100002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_S.SNOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000080002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_E.SNOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000040002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT_M.SNOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts all demand data writes (RFOs)",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000020002",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.SUPPLIER_NONE.SNOOP_NON_=
DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x3FFC400001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x103c000001 ",
+        "MSRValue": "0x203C400001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_NON_DR=
AM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x103C400001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS & SNOOP_HITM",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000001 ",
+        "MSRValue": "0x043C400001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000001 ",
+        "MSRValue": "0x023C400001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS & SNOOP_MISS",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000001 ",
+        "MSRValue": "0x013C400001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000001 ",
+        "MSRValue": "0x00BC400001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x007C400001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SPL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS & SNOOP_NONE",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3fc4000001 ",
+        "MSRValue": "0x3FC4000001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.A=
NY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & ANY_SNO=
OP",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000001 ",
+        "MSRValue": "0x2004000001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x1004000001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_H=
ITM",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000001 ",
+        "MSRValue": "0x0404000001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_H=
IT_NO_FWD",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000001 ",
+        "MSRValue": "0x0204000001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_M=
ISS",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000001 ",
+        "MSRValue": "0x0104000001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
OT_NEEDED",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000001 ",
+        "MSRValue": "0x0084000001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x0044000001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
PL_HIT",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000400001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L4_HIT_LOCAL_L4.SNOO=
P_NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x20001C0001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NON_DRA=
M",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000100001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_S.SNOOP_NON_D=
RAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000080001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_E.SNOOP_NON_D=
RAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000040001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT_M.SNOOP_NON_D=
RAM",
+        "MSRIndex": "0x1a6, 0x1a7",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts demand data reads",
+        "Offcore": "1",
+        "CounterHTOff": "0,1,2,3"
+    },
+    {
+        "PublicDescription": "Counts demand data reads",
+        "EventCode": "0xB7, 0xBB",
+        "MSRValue": "0x2000020001",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
ONE",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     }
diff --git a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/skylake/pipeline.json
index bc6d2afbcd8a..4a891fbbc4bb 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
@@ -1,7 +1,6 @@
 [
     {
         "PublicDescription": "Counts the number of instructions retired fr=
om execution. For instructions that consist of multiple micro-ops, Counts t=
he retirement of the last micro-op of the instruction. Counting continues d=
uring hardware interrupts, traps, and inside interrupt handlers. Notes: INS=
T_RETIRED.ANY is counted by a designated fixed counter, leaving the four (e=
ight when Hyperthreading is disabled) programmable counters available for o=
ther events. INST_RETIRED.ANY_P is counted by a programmable counter and it=
 is an architectural performance event. Counting: Faulting executions of GE=
TSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 0",
         "UMask": "0x1",
         "EventName": "INST_RETIRED.ANY",
@@ -11,7 +10,6 @@
     },
     {
         "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the four (eight when Hyperthreading is disabled) programmable counters a=
vailable for other events.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x2",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
@@ -20,7 +18,6 @@
         "CounterHTOff": "Fixed counter 1"
     },
     {
-        "EventCode": "0x00",
         "Counter": "Fixed counter 1",
         "UMask": "0x2",
         "AnyThread": "1",
@@ -31,7 +28,6 @@
     },
     {
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. This e=
vent has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is c=
ounted on a dedicated fixed counter, leaving the four (eight when Hyperthre=
ading is disabled) programmable counters available for other events. Note: =
On all current platforms this event stops counting during 'throttling (TM)'=
 states duty off periods the processor is 'halted'.  The counter update is =
done at a lower clock rate then the core clock the overflow status bit for =
this counter may appear 'sticky'.  After the counter has overflowed and sof=
tware clears the overflow status bit and resets the counter to less than MA=
X. The reset value to the counter is not clocked immediately so the overflo=
w status bit will flip 'high (1)' and generate another PMI (if enabled) aft=
er which the reset value gets clocked into the counter. Therefore, software=
 will get the interrupt, read the overflow status bit '1 for bit 34 while t=
he counter value is less than MAX. Software should ignore this case.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 2",
         "UMask": "0x3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
@@ -121,7 +117,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Counts the number of Blend Uops issued by th=
e Resource Allocation Table (RAT) to the reservation station (RS) in order =
to preserve upper bits of vector registers. Starting with the Skylake micro=
architecture, these Blend uops are needed since every Intel SSE instruction=
 executed in Dirty Upper State needs to preserve bits 128-255 of the destin=
ation register. For more information, refer to Mixing Intel AVX and Intel S=
SE Code section of the Optimization Guide.",
+        "PublicDescription": "Counts the number of Blend Uops issued by th=
e Resource Allocation Table (RAT) to the reservation station (RS) in order =
to preserve upper bits of vector registers. Starting with the Skylake micro=
architecture, these Blend uops are needed since every Intel SSE instruction=
 executed in Dirty Upper State needs to preserve bits 128-255 of the destin=
ation register. For more information, refer to \u201cMixing Intel AVX and I=
ntel SSE Code\u201d section of the Optimization Guide.",
         "EventCode": "0x0E",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
@@ -247,6 +243,16 @@
         "BriefDescription": "Demand load dispatches that hit L1D fill buff=
er (FB) allocated for software prefetch.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "PublicDescription": "This event counts cycles during which the mi=
crocode scoreboard stalls happen.",
+        "EventCode": "0x59",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "EventName": "PARTIAL_RAT_STALLS.SCOREBOARD",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where the pipeline is stalled due to s=
erializing operations.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for the thread.; Note: In ST-mode, not active thread s=
hould drive 0. This is usually caused by severely costly branch mispredicti=
ons, or allocator/FE issues.",
         "EventCode": "0x5E",
@@ -361,8 +367,8 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "Counts resource-related stall cycles. Reason=
s for stalls can be as follows:a. *any* u-arch structure got full (LB, SB, =
RS, ROB, BOB, LM, Physical Register Reclaim Table (PRRT), or Physical Histo=
ry Table (PHT) slots).b. *any* u-arch structure got empty (like INT/SIMD Fr=
eeLists).c. FPU control word (FPCW), MXCSR.and others. This counts cycles t=
hat the pipeline back-end blocked uop delivery from the front-end.",
-        "EventCode": "0xA2",
+        "PublicDescription": "Counts resource-related stall cycles.",
+        "EventCode": "0xa2",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "RESOURCE_STALLS.ANY",
@@ -735,7 +741,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts cycles without actually retired uop=
s.",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
         "EventCode": "0xC2",
         "Invert": "1",
         "Counter": "0,1,2,3",
@@ -759,6 +765,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
+        "PublicDescription": "Number of machine clears (nukes) of any type=
.",
         "EventCode": "0xC3",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
@@ -839,14 +846,15 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts not taken branch instructions retir=
ed.",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts not taken branch instructions retired.",
         "EventCode": "0xC4",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
         "Errata": "SKL091",
         "EventName": "BR_INST_RETIRED.NOT_TAKEN",
         "SampleAfterValue": "400009",
-        "BriefDescription": "Not taken branch instructions retired.",
+        "BriefDescription": "Counts all not taken macro branch instruction=
s retired.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -924,7 +932,7 @@
         "UMask": "0x20",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "SampleAfterValue": "400009",
-        "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken. ",
+        "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -937,6 +945,15 @@
         "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
+    {
+        "EventCode": "0xCC",
+        "Counter": "0,1,2,3",
+        "UMask": "0x40",
+        "EventName": "ROB_MISC_EVENTS.PAUSE_INST",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of retired PAUSE instructions (that do=
 not end up with a VMExit to the VMM; TSX aborted Instructions may be count=
ed). This event is not supported on first SKL and KBL products.",
+        "CounterHTOff": "0,1,2,3,4,5,6,7"
+    },
     {
         "PublicDescription": "Counts the number of times the front-end is =
resteered when it finds a branch instruction in a fetch line. This occurs f=
or the first time a branch instruction is fetched or when the branch is not=
 tracked by the BPU (Branch Prediction Unit) anymore.",
         "EventCode": "0xE6",
--=20
2.20.1

