Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99DFC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C7E20840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221372;
	bh=WaWxns70iBqp/mmMZrdptDuRhlDY57VOYX8Zcpjk/ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=piXuEi4RgnI8yA/Mrid7RVPntYi97s57c9doa9fzNR8ovfpOS6bIVP9UXJ06szIbR
	 pFWcuLLRWWQ37GRKWcziXo4EHl7S1/K3Y8yLwFEU9zuo1vxLS+D9KlGPWA7Gix9tJy
	 yv0jLi/yTlQDlq9YyS47fLi2/pguMDyvKMY46RRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfDBQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729949AbfDBQH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:07:57 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476CB2148E;
        Tue,  2 Apr 2019 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221258;
        bh=WaWxns70iBqp/mmMZrdptDuRhlDY57VOYX8Zcpjk/ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jgb4+eKBfmDZkxea6S+lFquGNoqBcZdVH0eSVmwSedanhaNkd3wVra2edh6ug0mrQ
         3095hnCYwKjHB1QcljaIfdRXl0SMLYNoeL7ZF7o9ILMzI9HkJNa1wjis1oD+vgBKyn
         uUr3LsnMFavv8cNNZu4CDWZOzHH59x+j8CJ6O018=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 29/44] perf vendor events intel: Update Broadwell events to v23
Date:   Tue,  2 Apr 2019 13:05:34 -0300
Message-Id: <20190402160549.13544-30-acme@kernel.org>
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
 .../pmu-events/arch/x86/broadwell/cache.json  | 1630 ++++++++--------
 .../arch/x86/broadwell/floating-point.json    |   51 +-
 .../arch/x86/broadwell/frontend.json          |    4 +-
 .../pmu-events/arch/x86/broadwell/memory.json | 1640 ++++++++---------
 .../arch/x86/broadwell/pipeline.json          |   36 +-
 5 files changed, 1685 insertions(+), 1676 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/cache.json b/tools/pe=
rf/pmu-events/arch/x86/broadwell/cache.json
index 0b080b0352d8..7938bf5689ab 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
@@ -56,10 +56,10 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts the number of demand Data =
Read requests that hit L2 cache. Only not rejected loads are counted.",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts, initiated by load instructions, that hit L2 cache.",
         "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x41",
+        "UMask": "0xc1",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "SampleAfterValue": "200003",
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
@@ -68,7 +68,7 @@
     {
         "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x42",
+        "UMask": "0xc2",
         "EventName": "L2_RQSTS.RFO_HIT",
         "SampleAfterValue": "200003",
         "BriefDescription": "RFO requests that hit L2 cache.",
@@ -77,7 +77,7 @@
     {
         "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x44",
+        "UMask": "0xc4",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "SampleAfterValue": "200003",
         "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
@@ -87,7 +87,7 @@
         "PublicDescription": "This event counts the number of requests fro=
m the L2 hardware prefetchers that hit L2 cache. L3 prefetch new types.",
         "EventCode": "0x24",
         "Counter": "0,1,2,3",
-        "UMask": "0x50",
+        "UMask": "0xd0",
         "EventName": "L2_RQSTS.L2_PF_HIT",
         "SampleAfterValue": "200003",
         "BriefDescription": "L2 prefetch requests that hit L2 cache",
@@ -433,7 +433,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts line-split load uops retired to the architected=
 path. A line split is across 64B cache-line which includes a page split (4=
K).",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts line-splitted load uops retired to the architec=
ted path. A line split is across 64B cache-line which includes a page split=
 (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x41",
@@ -445,7 +445,7 @@
     },
     {
         "PEBS": "1",
-        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts line-split store uops retired to the architecte=
d path. A line split is across 64B cache-line which includes a page split (=
4K).",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts line-splitted store uops retired to the archite=
cted path. A line split is across 64B cache-line which includes a page spli=
t (4K).",
         "EventCode": "0xD0",
         "Counter": "0,1,2,3",
         "UMask": "0x42",
@@ -771,2628 +771,2628 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
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
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020001 ",
+        "MSRValue": "0x0080020001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & SNOOP_NONE",
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
-        "MSRValue": "0x0100020001 ",
+        "MSRValue": "0x0100020001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & SNOOP_NOT_NE=
EDED",
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
-        "MSRValue": "0x0200020001 ",
+        "MSRValue": "0x0200020001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & SNOOP_MISS",
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
-        "MSRValue": "0x0400020001 ",
+        "MSRValue": "0x0400020001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & SNOOP_HIT_NO=
_FWD",
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
-        "MSRValue": "0x1000020001 ",
+        "MSRValue": "0x1000020001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & SNOOP_HITM",
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
-        "MSRValue": "0x3f80020001 ",
+        "MSRValue": "0x3F80020001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.ANY_SN=
OOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that hit in the L3 =
with no details on snoop-related information. Offcore response can be progr=
ammed only with a specific pair of event select and counter MSR, and with s=
pecific event codes and predefine mask bit value in a dedicated MSR to spec=
ify attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0001 ",
+        "MSRValue": "0x00803C0001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the L3 w=
ith no details on snoop-related information.",
+        "BriefDescription": "Counts demand data reads",
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
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0001 ",
+        "MSRValue": "0x01003C0001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the L3 a=
nd sibling core snoops are not needed as either the core-valid bit is not s=
et or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that hit in the L3 =
with a snoop miss response. Offcore response can be programmed only with a =
specific pair of event select and counter MSR, and with specific event code=
s and predefine mask bit value in a dedicated MSR to specify attributes of =
the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0001 ",
+        "MSRValue": "0x02003C0001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the L3 w=
ith a snoop miss response.",
+        "BriefDescription": "Counts demand data reads",
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
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0001 ",
+        "MSRValue": "0x04003C0001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the L3 a=
nd the snoops to sibling cores hit in either E/S state and the line is not =
forwarded.",
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
-        "MSRValue": "0x10003c0001 ",
+        "MSRValue": "0x10003C0001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that hit in the L3.=
 Offcore response can be programmed only with a specific pair of event sele=
ct and counter MSR, and with specific event codes and predefine mask bit va=
lue in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0001 ",
+        "MSRValue": "0x3F803C0001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the L3.",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that ha=
ve any response type. Offcore response can be programmed only with a specif=
ic pair of event select and counter MSR, and with specific event codes and =
predefine mask bit value in a dedicated MSR to specify attributes of the of=
fcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs) have an=
y response type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010002 ",
+        "MSRValue": "0x0000010002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hav=
e any response type.",
+        "BriefDescription": "Counts all demand data writes (RFOs) have any=
 response type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that hi=
t in the L3 with no details on snoop-related information. Offcore response =
can be programmed only with a specific pair of event select and counter MSR=
, and with specific event codes and predefine mask bit value in a dedicated=
 MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0002 ",
+        "MSRValue": "0x00803C0002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hit=
 in the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that hi=
t in the L3 and sibling core snoops are not needed as either the core-valid=
 bit is not set or the shared line is present in multiple cores. Offcore re=
sponse can be programmed only with a specific pair of event select and coun=
ter MSR, and with specific event codes and predefine mask bit value in a de=
dicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0002 ",
+        "MSRValue": "0x01003C0002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hit=
 in the L3 and sibling core snoops are not needed as either the core-valid =
bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that hi=
t in the L3 with a snoop miss response. Offcore response can be programmed =
only with a specific pair of event select and counter MSR, and with specifi=
c event codes and predefine mask bit value in a dedicated MSR to specify at=
tributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0002 ",
+        "MSRValue": "0x02003C0002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hit=
 in the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that hi=
t in the L3 and the snoops to sibling cores hit in either E/S state and the=
 line is not forwarded. Offcore response can be programmed only with a spec=
ific pair of event select and counter MSR, and with specific event codes an=
d predefine mask bit value in a dedicated MSR to specify attributes of the =
offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0002 ",
+        "MSRValue": "0x04003C0002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hit=
 in the L3 and the snoops to sibling cores hit in either E/S state and the =
line is not forwarded.",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0002 ",
+        "MSRValue": "0x10003C0002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_RFO & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that hi=
t in the L3. Offcore response can be programmed only with a specific pair o=
f event select and counter MSR, and with specific event codes and predefine=
 mask bit value in a dedicated MSR to specify attributes of the offcore tra=
nsaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0002 ",
+        "MSRValue": "0x3F803C0002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hit=
 in the L3.",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that have any r=
esponse type. Offcore response can be programmed only with a specific pair =
of event select and counter MSR, and with specific event codes and predefin=
e mask bit value in a dedicated MSR to specify attributes of the offcore tr=
ansaction.",
+        "PublicDescription": "Counts all demand code reads have any respon=
se type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010004 ",
+        "MSRValue": "0x0000010004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that have any re=
sponse type.",
+        "BriefDescription": "Counts all demand code reads have any respons=
e type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020004 ",
+        "MSRValue": "0x0080020004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020004 ",
+        "MSRValue": "0x0100020004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & SUPPLIER_NONE & SNOOP_NOT_NE=
EDED",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020004 ",
+        "MSRValue": "0x0200020004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020004 ",
+        "MSRValue": "0x0400020004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & SUPPLIER_NONE & SNOOP_HIT_NO=
_FWD",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020004 ",
+        "MSRValue": "0x1000020004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020004 ",
+        "MSRValue": "0x3F80020004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.ANY_SN=
OOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that hit in the=
 L3 with no details on snoop-related information. Offcore response can be p=
rogrammed only with a specific pair of event select and counter MSR, and wi=
th specific event codes and predefine mask bit value in a dedicated MSR to =
specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0004 ",
+        "MSRValue": "0x00803C0004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that hit in the =
L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that hit in the=
 L3 and sibling core snoops are not needed as either the core-valid bit is =
not set or the shared line is present in multiple cores. Offcore response c=
an be programmed only with a specific pair of event select and counter MSR,=
 and with specific event codes and predefine mask bit value in a dedicated =
MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0004 ",
+        "MSRValue": "0x01003C0004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that hit in the =
L3 and sibling core snoops are not needed as either the core-valid bit is n=
ot set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that hit in the=
 L3 with a snoop miss response. Offcore response can be programmed only wit=
h a specific pair of event select and counter MSR, and with specific event =
codes and predefine mask bit value in a dedicated MSR to specify attributes=
 of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0004 ",
+        "MSRValue": "0x02003C0004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that hit in the =
L3 with a snoop miss response.",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that hit in the=
 L3 and the snoops to sibling cores hit in either E/S state and the line is=
 not forwarded. Offcore response can be programmed only with a specific pai=
r of event select and counter MSR, and with specific event codes and predef=
ine mask bit value in a dedicated MSR to specify attributes of the offcore =
transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0004 ",
+        "MSRValue": "0x04003C0004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that hit in the =
L3 and the snoops to sibling cores hit in either E/S state and the line is =
not forwarded.",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0004 ",
+        "MSRValue": "0x10003C0004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that hit in the=
 L3. Offcore response can be programmed only with a specific pair of event =
select and counter MSR, and with specific event codes and predefine mask bi=
t value in a dedicated MSR to specify attributes of the offcore transaction=
.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0004 ",
+        "MSRValue": "0x3F803C0004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that hit in the =
L3.",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts writebacks (modified to exclusive) th=
at have any response type. Offcore response can be programmed only with a s=
pecific pair of event select and counter MSR, and with specific event codes=
 and predefine mask bit value in a dedicated MSR to specify attributes of t=
he offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive) ha=
ve any response type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010008 ",
+        "MSRValue": "0x0000010008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts writebacks (modified to exclusive) tha=
t have any response type.",
+        "BriefDescription": "Counts writebacks (modified to exclusive) hav=
e any response type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020008 ",
+        "MSRValue": "0x0080020008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020008 ",
+        "MSRValue": "0x0100020008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_NOT_NEED=
ED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & SUPPLIER_NONE & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020008 ",
+        "MSRValue": "0x0200020008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020008 ",
+        "MSRValue": "0x0400020008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_HIT_NO_F=
WD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & SUPPLIER_NONE & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020008 ",
+        "MSRValue": "0x1000020008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020008 ",
+        "MSRValue": "0x3F80020008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts writebacks (modified to exclusive) th=
at hit in the L3 with no details on snoop-related information. Offcore resp=
onse can be programmed only with a specific pair of event select and counte=
r MSR, and with specific event codes and predefine mask bit value in a dedi=
cated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0008 ",
+        "MSRValue": "0x00803C0008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts writebacks (modified to exclusive) tha=
t hit in the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts writebacks (modified to exclusive) th=
at hit in the L3 and sibling core snoops are not needed as either the core-=
valid bit is not set or the shared line is present in multiple cores. Offco=
re response can be programmed only with a specific pair of event select and=
 counter MSR, and with specific event codes and predefine mask bit value in=
 a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0008 ",
+        "MSRValue": "0x01003C0008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts writebacks (modified to exclusive) tha=
t hit in the L3 and sibling core snoops are not needed as either the core-v=
alid bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts writebacks (modified to exclusive) th=
at hit in the L3 with a snoop miss response. Offcore response can be progra=
mmed only with a specific pair of event select and counter MSR, and with sp=
ecific event codes and predefine mask bit value in a dedicated MSR to speci=
fy attributes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0008 ",
+        "MSRValue": "0x02003C0008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts writebacks (modified to exclusive) tha=
t hit in the L3 with a snoop miss response.",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts writebacks (modified to exclusive) th=
at hit in the L3 and the snoops to sibling cores hit in either E/S state an=
d the line is not forwarded. Offcore response can be programmed only with a=
 specific pair of event select and counter MSR, and with specific event cod=
es and predefine mask bit value in a dedicated MSR to specify attributes of=
 the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0008 ",
+        "MSRValue": "0x04003C0008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts writebacks (modified to exclusive) tha=
t hit in the L3 and the snoops to sibling cores hit in either E/S state and=
 the line is not forwarded.",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0008 ",
+        "MSRValue": "0x10003C0008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts writebacks (modified to exclusive) th=
at hit in the L3. Offcore response can be programmed only with a specific p=
air of event select and counter MSR, and with specific event codes and pred=
efine mask bit value in a dedicated MSR to specify attributes of the offcor=
e transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0008 ",
+        "MSRValue": "0x3F803C0008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts writebacks (modified to exclusive) tha=
t hit in the L3.",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads that have any response type. Offcore response can be programmed only=
 with a specific pair of event select and counter MSR, and with specific ev=
ent codes and predefine mask bit value in a dedicated MSR to specify attrib=
utes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads have any response type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010010 ",
+        "MSRValue": "0x0000010010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that have any response type.",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads have any response type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020010 ",
+        "MSRValue": "0x0080020010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020010 ",
+        "MSRValue": "0x0100020010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & SUPPLIER_NONE & SNOOP_NOT_NEE=
DED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020010 ",
+        "MSRValue": "0x0200020010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020010 ",
+        "MSRValue": "0x0400020010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & SUPPLIER_NONE & SNOOP_HIT_NO_=
FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020010 ",
+        "MSRValue": "0x1000020010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_H=
ITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020010 ",
+        "MSRValue": "0x3F80020010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.ANY_SNO=
OP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads that hit in the L3 with no details on snoop-related information. Off=
core response can be programmed only with a specific pair of event select a=
nd counter MSR, and with specific event codes and predefine mask bit value =
in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0010 ",
+        "MSRValue": "0x00803C0010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that hit in the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads that hit in the L3 and sibling core snoops are not needed as either =
the core-valid bit is not set or the shared line is present in multiple cor=
es. Offcore response can be programmed only with a specific pair of event s=
elect and counter MSR, and with specific event codes and predefine mask bit=
 value in a dedicated MSR to specify attributes of the offcore transaction.=
",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0010 ",
+        "MSRValue": "0x01003C0010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that hit in the L3 and sibling core snoops are not needed as either t=
he core-valid bit is not set or the shared line is present in multiple core=
s.",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads that hit in the L3 with a snoop miss response. Offcore response can =
be programmed only with a specific pair of event select and counter MSR, an=
d with specific event codes and predefine mask bit value in a dedicated MSR=
 to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0010 ",
+        "MSRValue": "0x02003C0010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that hit in the L3 with a snoop miss response.",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads that hit in the L3 and the snoops to sibling cores hit in either E/S=
 state and the line is not forwarded. Offcore response can be programmed on=
ly with a specific pair of event select and counter MSR, and with specific =
event codes and predefine mask bit value in a dedicated MSR to specify attr=
ibutes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0010 ",
+        "MSRValue": "0x04003C0010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that hit in the L3 and the snoops to sibling cores hit in either E/S =
state and the line is not forwarded.",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0010 ",
+        "MSRValue": "0x10003C0010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads that hit in the L3. Offcore response can be programmed only with a s=
pecific pair of event select and counter MSR, and with specific event codes=
 and predefine mask bit value in a dedicated MSR to specify attributes of t=
he offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0010 ",
+        "MSRValue": "0x3F803C0010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that hit in the L3.",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs that have any response type. Offcore response can be programmed only w=
ith a specific pair of event select and counter MSR, and with specific even=
t codes and predefine mask bit value in a dedicated MSR to specify attribut=
es of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs have any response type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010020 ",
+        "MSRValue": "0x0000010020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs that have any response type.",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs have any response type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020020 ",
+        "MSRValue": "0x0080020020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020020 ",
+        "MSRValue": "0x0100020020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_NOT_N=
EEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & SUPPLIER_NONE & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020020 ",
+        "MSRValue": "0x0200020020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020020 ",
+        "MSRValue": "0x0400020020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_HIT_N=
O_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & SUPPLIER_NONE & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020020 ",
+        "MSRValue": "0x1000020020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020020 ",
+        "MSRValue": "0x3F80020020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs that hit in the L3 with no details on snoop-related information. Offco=
re response can be programmed only with a specific pair of event select and=
 counter MSR, and with specific event codes and predefine mask bit value in=
 a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0020 ",
+        "MSRValue": "0x00803C0020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs that hit in the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs that hit in the L3 and sibling core snoops are not needed as either th=
e core-valid bit is not set or the shared line is present in multiple cores=
. Offcore response can be programmed only with a specific pair of event sel=
ect and counter MSR, and with specific event codes and predefine mask bit v=
alue in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0020 ",
+        "MSRValue": "0x01003C0020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs that hit in the L3 and sibling core snoops are not needed as either the=
 core-valid bit is not set or the shared line is present in multiple cores.=
",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs that hit in the L3 with a snoop miss response. Offcore response can be=
 programmed only with a specific pair of event select and counter MSR, and =
with specific event codes and predefine mask bit value in a dedicated MSR t=
o specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0020 ",
+        "MSRValue": "0x02003C0020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs that hit in the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs that hit in the L3 and the snoops to sibling cores hit in either E/S s=
tate and the line is not forwarded. Offcore response can be programmed only=
 with a specific pair of event select and counter MSR, and with specific ev=
ent codes and predefine mask bit value in a dedicated MSR to specify attrib=
utes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0020 ",
+        "MSRValue": "0x04003C0020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs that hit in the L3 and the snoops to sibling cores hit in either E/S st=
ate and the line is not forwarded.",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0020 ",
+        "MSRValue": "0x10003C0020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs that hit in the L3. Offcore response can be programmed only with a spe=
cific pair of event select and counter MSR, and with specific event codes a=
nd predefine mask bit value in a dedicated MSR to specify attributes of the=
 offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0020 ",
+        "MSRValue": "0x3F803C0020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs that hit in the L3.",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads that have any response type. Offcore response can be progr=
ammed only with a specific pair of event select and counter MSR, and with s=
pecific event codes and predefine mask bit value in a dedicated MSR to spec=
ify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads have any response type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010040 ",
+        "MSRValue": "0x0000010040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads that have any response type.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads have any response type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020040 ",
+        "MSRValue": "0x0080020040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020040 ",
+        "MSRValue": "0x0100020040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & SUPPLIER_NONE & SNOOP_NOT_NEE=
DED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020040 ",
+        "MSRValue": "0x0200020040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020040 ",
+        "MSRValue": "0x0400020040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & SUPPLIER_NONE & SNOOP_HIT_NO_=
FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020040 ",
+        "MSRValue": "0x1000020040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_H=
ITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020040 ",
+        "MSRValue": "0x3F80020040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.ANY_SNO=
OP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads that hit in the L3 with no details on snoop-related inform=
ation. Offcore response can be programmed only with a specific pair of even=
t select and counter MSR, and with specific event codes and predefine mask =
bit value in a dedicated MSR to specify attributes of the offcore transacti=
on.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0040 ",
+        "MSRValue": "0x00803C0040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads that hit in the L3 with no details on snoop-related informa=
tion.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads that hit in the L3 and sibling core snoops are not needed =
as either the core-valid bit is not set or the shared line is present in mu=
ltiple cores. Offcore response can be programmed only with a specific pair =
of event select and counter MSR, and with specific event codes and predefin=
e mask bit value in a dedicated MSR to specify attributes of the offcore tr=
ansaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0040 ",
+        "MSRValue": "0x01003C0040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads that hit in the L3 and sibling core snoops are not needed a=
s either the core-valid bit is not set or the shared line is present in mul=
tiple cores.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads that hit in the L3 with a snoop miss response. Offcore res=
ponse can be programmed only with a specific pair of event select and count=
er MSR, and with specific event codes and predefine mask bit value in a ded=
icated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0040 ",
+        "MSRValue": "0x02003C0040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads that hit in the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads that hit in the L3 and the snoops to sibling cores hit in =
either E/S state and the line is not forwarded. Offcore response can be pro=
grammed only with a specific pair of event select and counter MSR, and with=
 specific event codes and predefine mask bit value in a dedicated MSR to sp=
ecify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0040 ",
+        "MSRValue": "0x04003C0040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads that hit in the L3 and the snoops to sibling cores hit in e=
ither E/S state and the line is not forwarded.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0040 ",
+        "MSRValue": "0x10003C0040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads that hit in the L3. Offcore response can be programmed onl=
y with a specific pair of event select and counter MSR, and with specific e=
vent codes and predefine mask bit value in a dedicated MSR to specify attri=
butes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0040 ",
+        "MSRValue": "0x3F803C0040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads that hit in the L3.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads that have any response type. Offcore response can be progr=
ammed only with a specific pair of event select and counter MSR, and with s=
pecific event codes and predefine mask bit value in a dedicated MSR to spec=
ify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads have any response type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010080 ",
+        "MSRValue": "0x0000010080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads that have any response type.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads have any response type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020080 ",
+        "MSRValue": "0x0080020080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020080 ",
+        "MSRValue": "0x0100020080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & SUPPLIER_NONE & SNOOP_NOT_NEE=
DED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020080 ",
+        "MSRValue": "0x0200020080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020080 ",
+        "MSRValue": "0x0400020080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & SUPPLIER_NONE & SNOOP_HIT_NO_=
FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020080 ",
+        "MSRValue": "0x1000020080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_H=
ITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020080 ",
+        "MSRValue": "0x3F80020080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.ANY_SNO=
OP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads that hit in the L3 with no details on snoop-related inform=
ation. Offcore response can be programmed only with a specific pair of even=
t select and counter MSR, and with specific event codes and predefine mask =
bit value in a dedicated MSR to specify attributes of the offcore transacti=
on.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0080 ",
+        "MSRValue": "0x00803C0080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads that hit in the L3 with no details on snoop-related informa=
tion.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads that hit in the L3 and sibling core snoops are not needed =
as either the core-valid bit is not set or the shared line is present in mu=
ltiple cores. Offcore response can be programmed only with a specific pair =
of event select and counter MSR, and with specific event codes and predefin=
e mask bit value in a dedicated MSR to specify attributes of the offcore tr=
ansaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0080 ",
+        "MSRValue": "0x01003C0080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads that hit in the L3 and sibling core snoops are not needed a=
s either the core-valid bit is not set or the shared line is present in mul=
tiple cores.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads that hit in the L3 with a snoop miss response. Offcore res=
ponse can be programmed only with a specific pair of event select and count=
er MSR, and with specific event codes and predefine mask bit value in a ded=
icated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0080 ",
+        "MSRValue": "0x02003C0080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads that hit in the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads that hit in the L3 and the snoops to sibling cores hit in =
either E/S state and the line is not forwarded. Offcore response can be pro=
grammed only with a specific pair of event select and counter MSR, and with=
 specific event codes and predefine mask bit value in a dedicated MSR to sp=
ecify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0080 ",
+        "MSRValue": "0x04003C0080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads that hit in the L3 and the snoops to sibling cores hit in e=
ither E/S state and the line is not forwarded.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0080 ",
+        "MSRValue": "0x10003C0080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads that hit in the L3. Offcore response can be programmed onl=
y with a specific pair of event select and counter MSR, and with specific e=
vent codes and predefine mask bit value in a dedicated MSR to specify attri=
butes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0080 ",
+        "MSRValue": "0x3F803C0080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads that hit in the L3.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs that have any response type. Offcore response can be programmed =
only with a specific pair of event select and counter MSR, and with specifi=
c event codes and predefine mask bit value in a dedicated MSR to specify at=
tributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs have any response type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010100 ",
+        "MSRValue": "0x0000010100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs that have any response type.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs have any response type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020100 ",
+        "MSRValue": "0x0080020100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020100 ",
+        "MSRValue": "0x0100020100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_NOT_N=
EEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & SUPPLIER_NONE & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020100 ",
+        "MSRValue": "0x0200020100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020100 ",
+        "MSRValue": "0x0400020100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_HIT_N=
O_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & SUPPLIER_NONE & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020100 ",
+        "MSRValue": "0x1000020100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020100 ",
+        "MSRValue": "0x3F80020100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs that hit in the L3 with no details on snoop-related information.=
 Offcore response can be programmed only with a specific pair of event sele=
ct and counter MSR, and with specific event codes and predefine mask bit va=
lue in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0100 ",
+        "MSRValue": "0x00803C0100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs that hit in the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs that hit in the L3 and sibling core snoops are not needed as eit=
her the core-valid bit is not set or the shared line is present in multiple=
 cores. Offcore response can be programmed only with a specific pair of eve=
nt select and counter MSR, and with specific event codes and predefine mask=
 bit value in a dedicated MSR to specify attributes of the offcore transact=
ion.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0100 ",
+        "MSRValue": "0x01003C0100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs that hit in the L3 and sibling core snoops are not needed as eith=
er the core-valid bit is not set or the shared line is present in multiple =
cores.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs that hit in the L3 with a snoop miss response. Offcore response =
can be programmed only with a specific pair of event select and counter MSR=
, and with specific event codes and predefine mask bit value in a dedicated=
 MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0100 ",
+        "MSRValue": "0x02003C0100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs that hit in the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs that hit in the L3 and the snoops to sibling cores hit in either=
 E/S state and the line is not forwarded. Offcore response can be programme=
d only with a specific pair of event select and counter MSR, and with speci=
fic event codes and predefine mask bit value in a dedicated MSR to specify =
attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0100 ",
+        "MSRValue": "0x04003C0100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs that hit in the L3 and the snoops to sibling cores hit in either =
E/S state and the line is not forwarded.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0100 ",
+        "MSRValue": "0x10003C0100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs that hit in the L3. Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0100 ",
+        "MSRValue": "0x3F803C0100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs that hit in the L3.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads that have any response type. Offcore response can be programme=
d only with a specific pair of event select and counter MSR, and with speci=
fic event codes and predefine mask bit value in a dedicated MSR to specify =
attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads have any response type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010200 ",
+        "MSRValue": "0x0000010200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads that have any response type.",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads have any response type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020200 ",
+        "MSRValue": "0x0080020200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_N=
ONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020200 ",
+        "MSRValue": "0x0100020200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_N=
OT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & SUPPLIER_NONE & SNOOP_NOT_NEE=
DED",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020200 ",
+        "MSRValue": "0x0200020200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_M=
ISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020200 ",
+        "MSRValue": "0x0400020200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_H=
IT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & SUPPLIER_NONE & SNOOP_HIT_NO_=
FWD",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020200 ",
+        "MSRValue": "0x1000020200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_H=
ITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020200 ",
+        "MSRValue": "0x3F80020200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.ANY_SNO=
OP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads that hit in the L3 with no details on snoop-related informatio=
n. Offcore response can be programmed only with a specific pair of event se=
lect and counter MSR, and with specific event codes and predefine mask bit =
value in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0200 ",
+        "MSRValue": "0x00803C0200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads that hit in the L3 with no details on snoop-related information=
.",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads that hit in the L3 and sibling core snoops are not needed as e=
ither the core-valid bit is not set or the shared line is present in multip=
le cores. Offcore response can be programmed only with a specific pair of e=
vent select and counter MSR, and with specific event codes and predefine ma=
sk bit value in a dedicated MSR to specify attributes of the offcore transa=
ction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0200 ",
+        "MSRValue": "0x01003C0200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_NOT_NEED=
ED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads that hit in the L3 and sibling core snoops are not needed as ei=
ther the core-valid bit is not set or the shared line is present in multipl=
e cores.",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads that hit in the L3 with a snoop miss response. Offcore respons=
e can be programmed only with a specific pair of event select and counter M=
SR, and with specific event codes and predefine mask bit value in a dedicat=
ed MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0200 ",
+        "MSRValue": "0x02003C0200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads that hit in the L3 with a snoop miss response.",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads that hit in the L3 and the snoops to sibling cores hit in eith=
er E/S state and the line is not forwarded. Offcore response can be program=
med only with a specific pair of event select and counter MSR, and with spe=
cific event codes and predefine mask bit value in a dedicated MSR to specif=
y attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0200 ",
+        "MSRValue": "0x04003C0200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_HIT_NO_F=
WD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads that hit in the L3 and the snoops to sibling cores hit in eithe=
r E/S state and the line is not forwarded.",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0200 ",
+        "MSRValue": "0x10003C0200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads that hit in the L3. Offcore response can be programmed only wi=
th a specific pair of event select and counter MSR, and with specific event=
 codes and predefine mask bit value in a dedicated MSR to specify attribute=
s of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0200 ",
+        "MSRValue": "0x3F803C0200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads that hit in the L3.",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts any other requests that have any resp=
onse type. Offcore response can be programmed only with a specific pair of =
event select and counter MSR, and with specific event codes and predefine m=
ask bit value in a dedicated MSR to specify attributes of the offcore trans=
action.",
+        "PublicDescription": "Counts any other requests have any response =
type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000018000 ",
+        "MSRValue": "0x0000018000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts any other requests that have any respo=
nse type.",
+        "BriefDescription": "Counts any other requests have any response t=
ype.",
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
-        "MSRValue": "0x0080028000 ",
+        "MSRValue": "0x0080028000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & SUPPLIER_NONE & SNOOP_NONE",
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
-        "MSRValue": "0x0100028000 ",
+        "MSRValue": "0x0100028000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NOT_NEEDE=
D",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & SUPPLIER_NONE & SNOOP_NOT_NEEDED",
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
-        "MSRValue": "0x0200028000 ",
+        "MSRValue": "0x0200028000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & SUPPLIER_NONE & SNOOP_MISS",
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
-        "MSRValue": "0x0400028000 ",
+        "MSRValue": "0x0400028000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_HIT_NO_FW=
D",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & SUPPLIER_NONE & SNOOP_HIT_NO_FWD",
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
-        "MSRValue": "0x1000028000 ",
+        "MSRValue": "0x1000028000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & SUPPLIER_NONE & SNOOP_HITM",
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
-        "MSRValue": "0x3f80028000 ",
+        "MSRValue": "0x3F80028000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts any other requests that hit in the L3=
 with no details on snoop-related information. Offcore response can be prog=
rammed only with a specific pair of event select and counter MSR, and with =
specific event codes and predefine mask bit value in a dedicated MSR to spe=
cify attributes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c8000 ",
+        "MSRValue": "0x00803C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts any other requests that hit in the L3 =
with no details on snoop-related information.",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts any other requests that hit in the L3=
 and sibling core snoops are not needed as either the core-valid bit is not=
 set or the shared line is present in multiple cores. Offcore response can =
be programmed only with a specific pair of event select and counter MSR, an=
d with specific event codes and predefine mask bit value in a dedicated MSR=
 to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c8000 ",
+        "MSRValue": "0x01003C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts any other requests that hit in the L3 =
and sibling core snoops are not needed as either the core-valid bit is not =
set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts any other requests that hit in the L3=
 with a snoop miss response. Offcore response can be programmed only with a=
 specific pair of event select and counter MSR, and with specific event cod=
es and predefine mask bit value in a dedicated MSR to specify attributes of=
 the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c8000 ",
+        "MSRValue": "0x02003C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts any other requests that hit in the L3 =
with a snoop miss response.",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts any other requests that hit in the L3=
 and the snoops to sibling cores hit in either E/S state and the line is no=
t forwarded. Offcore response can be programmed only with a specific pair o=
f event select and counter MSR, and with specific event codes and predefine=
 mask bit value in a dedicated MSR to specify attributes of the offcore tra=
nsaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c8000 ",
+        "MSRValue": "0x04003C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts any other requests that hit in the L3 =
and the snoops to sibling cores hit in either E/S state and the line is not=
 forwarded.",
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
-        "MSRValue": "0x10003c8000 ",
+        "MSRValue": "0x10003C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts any other requests that hit in the L3=
. Offcore response can be programmed only with a specific pair of event sel=
ect and counter MSR, and with specific event codes and predefine mask bit v=
alue in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c8000 ",
+        "MSRValue": "0x3F803C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts any other requests that hit in the L3.=
",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch data reads that have any=
 response type. Offcore response can be programmed only with a specific pai=
r of event select and counter MSR, and with specific event codes and predef=
ine mask bit value in a dedicated MSR to specify attributes of the offcore =
transaction.",
+        "PublicDescription": "Counts all prefetch data reads have any resp=
onse type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010090 ",
+        "MSRValue": "0x0000010090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch data reads that have any =
response type.",
+        "BriefDescription": "Counts all prefetch data reads have any respo=
nse type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020090 ",
+        "MSRValue": "0x0080020090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020090 ",
+        "MSRValue": "0x0100020090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & SNOOP_NOT_NE=
EDED",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020090 ",
+        "MSRValue": "0x0200020090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020090 ",
+        "MSRValue": "0x0400020090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & SNOOP_HIT_NO=
_FWD",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020090 ",
+        "MSRValue": "0x1000020090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020090 ",
+        "MSRValue": "0x3F80020090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.ANY_SN=
OOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch data reads that hit in t=
he L3 with no details on snoop-related information. Offcore response can be=
 programmed only with a specific pair of event select and counter MSR, and =
with specific event codes and predefine mask bit value in a dedicated MSR t=
o specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0090 ",
+        "MSRValue": "0x00803C0090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch data reads that hit in th=
e L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch data reads that hit in t=
he L3 and sibling core snoops are not needed as either the core-valid bit i=
s not set or the shared line is present in multiple cores. Offcore response=
 can be programmed only with a specific pair of event select and counter MS=
R, and with specific event codes and predefine mask bit value in a dedicate=
d MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0090 ",
+        "MSRValue": "0x01003C0090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch data reads that hit in th=
e L3 and sibling core snoops are not needed as either the core-valid bit is=
 not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch data reads that hit in t=
he L3 with a snoop miss response. Offcore response can be programmed only w=
ith a specific pair of event select and counter MSR, and with specific even=
t codes and predefine mask bit value in a dedicated MSR to specify attribut=
es of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0090 ",
+        "MSRValue": "0x02003C0090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch data reads that hit in th=
e L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch data reads that hit in t=
he L3 and the snoops to sibling cores hit in either E/S state and the line =
is not forwarded. Offcore response can be programmed only with a specific p=
air of event select and counter MSR, and with specific event codes and pred=
efine mask bit value in a dedicated MSR to specify attributes of the offcor=
e transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0090 ",
+        "MSRValue": "0x04003C0090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch data reads that hit in th=
e L3 and the snoops to sibling cores hit in either E/S state and the line i=
s not forwarded.",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0090 ",
+        "MSRValue": "0x10003C0090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch data reads that hit in t=
he L3. Offcore response can be programmed only with a specific pair of even=
t select and counter MSR, and with specific event codes and predefine mask =
bit value in a dedicated MSR to specify attributes of the offcore transacti=
on.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0090 ",
+        "MSRValue": "0x3F803C0090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch data reads that hit in th=
e L3.",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch RFOs that have any response =
type. Offcore response can be programmed only with a specific pair of event=
 select and counter MSR, and with specific event codes and predefine mask b=
it value in a dedicated MSR to specify attributes of the offcore transactio=
n.",
+        "PublicDescription": "Counts prefetch RFOs have any response type.=
",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010120 ",
+        "MSRValue": "0x0000010120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch RFOs that have any response t=
ype.",
+        "BriefDescription": "Counts prefetch RFOs have any response type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020120 ",
+        "MSRValue": "0x0080020120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_NONE=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020120 ",
+        "MSRValue": "0x0100020120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_NOT_=
NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & SNOOP_NOT_NEEDED=
",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020120 ",
+        "MSRValue": "0x0200020120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_MISS=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020120 ",
+        "MSRValue": "0x0400020120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_HIT_=
NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & SNOOP_HIT_NO_FWD=
",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020120 ",
+        "MSRValue": "0x1000020120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_HITM=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020120 ",
+        "MSRValue": "0x3F80020120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch RFOs that hit in the L3 with=
 no details on snoop-related information. Offcore response can be programme=
d only with a specific pair of event select and counter MSR, and with speci=
fic event codes and predefine mask bit value in a dedicated MSR to specify =
attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0120 ",
+        "MSRValue": "0x00803C0120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch RFOs that hit in the L3 with =
no details on snoop-related information.",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch RFOs that hit in the L3 and =
sibling core snoops are not needed as either the core-valid bit is not set =
or the shared line is present in multiple cores. Offcore response can be pr=
ogrammed only with a specific pair of event select and counter MSR, and wit=
h specific event codes and predefine mask bit value in a dedicated MSR to s=
pecify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0120 ",
+        "MSRValue": "0x01003C0120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch RFOs that hit in the L3 and s=
ibling core snoops are not needed as either the core-valid bit is not set o=
r the shared line is present in multiple cores.",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch RFOs that hit in the L3 with=
 a snoop miss response. Offcore response can be programmed only with a spec=
ific pair of event select and counter MSR, and with specific event codes an=
d predefine mask bit value in a dedicated MSR to specify attributes of the =
offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0120 ",
+        "MSRValue": "0x02003C0120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch RFOs that hit in the L3 with =
a snoop miss response.",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch RFOs that hit in the L3 and =
the snoops to sibling cores hit in either E/S state and the line is not for=
warded. Offcore response can be programmed only with a specific pair of eve=
nt select and counter MSR, and with specific event codes and predefine mask=
 bit value in a dedicated MSR to specify attributes of the offcore transact=
ion.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0120 ",
+        "MSRValue": "0x04003C0120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch RFOs that hit in the L3 and t=
he snoops to sibling cores hit in either E/S state and the line is not forw=
arded.",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0120 ",
+        "MSRValue": "0x10003C0120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch RFOs that hit in the L3. Off=
core response can be programmed only with a specific pair of event select a=
nd counter MSR, and with specific event codes and predefine mask bit value =
in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0120 ",
+        "MSRValue": "0x3F803C0120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch RFOs that hit in the L3.",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch code reads that have any=
 response type. Offcore response can be programmed only with a specific pai=
r of event select and counter MSR, and with specific event codes and predef=
ine mask bit value in a dedicated MSR to specify attributes of the offcore =
transaction.",
+        "PublicDescription": "Counts all prefetch code reads have any resp=
onse type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010240 ",
+        "MSRValue": "0x0000010240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch code reads that have any =
response type.",
+        "BriefDescription": "Counts all prefetch code reads have any respo=
nse type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020240 ",
+        "MSRValue": "0x0080020240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020240 ",
+        "MSRValue": "0x0100020240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & SUPPLIER_NONE & SNOOP_NOT_NE=
EDED",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020240 ",
+        "MSRValue": "0x0200020240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020240 ",
+        "MSRValue": "0x0400020240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & SUPPLIER_NONE & SNOOP_HIT_NO=
_FWD",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020240 ",
+        "MSRValue": "0x1000020240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020240 ",
+        "MSRValue": "0x3F80020240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.ANY_SN=
OOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch code reads that hit in t=
he L3 with no details on snoop-related information. Offcore response can be=
 programmed only with a specific pair of event select and counter MSR, and =
with specific event codes and predefine mask bit value in a dedicated MSR t=
o specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0240 ",
+        "MSRValue": "0x00803C0240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch code reads that hit in th=
e L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch code reads that hit in t=
he L3 and sibling core snoops are not needed as either the core-valid bit i=
s not set or the shared line is present in multiple cores. Offcore response=
 can be programmed only with a specific pair of event select and counter MS=
R, and with specific event codes and predefine mask bit value in a dedicate=
d MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0240 ",
+        "MSRValue": "0x01003C0240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_NOT_NEE=
DED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch code reads that hit in th=
e L3 and sibling core snoops are not needed as either the core-valid bit is=
 not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch code reads that hit in t=
he L3 with a snoop miss response. Offcore response can be programmed only w=
ith a specific pair of event select and counter MSR, and with specific even=
t codes and predefine mask bit value in a dedicated MSR to specify attribut=
es of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0240 ",
+        "MSRValue": "0x02003C0240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch code reads that hit in th=
e L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch code reads that hit in t=
he L3 and the snoops to sibling cores hit in either E/S state and the line =
is not forwarded. Offcore response can be programmed only with a specific p=
air of event select and counter MSR, and with specific event codes and pred=
efine mask bit value in a dedicated MSR to specify attributes of the offcor=
e transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0240 ",
+        "MSRValue": "0x04003C0240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_HIT_NO_=
FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch code reads that hit in th=
e L3 and the snoops to sibling cores hit in either E/S state and the line i=
s not forwarded.",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0240 ",
+        "MSRValue": "0x10003C0240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch code reads that hit in t=
he L3. Offcore response can be programmed only with a specific pair of even=
t select and counter MSR, and with specific event codes and predefine mask =
bit value in a dedicated MSR to specify attributes of the offcore transacti=
on.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0240 ",
+        "MSRValue": "0x3F803C0240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch code reads that hit in th=
e L3.",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that=
 have any response type. Offcore response can be programmed only with a spe=
cific pair of event select and counter MSR, and with specific event codes a=
nd predefine mask bit value in a dedicated MSR to specify attributes of the=
 offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads have=
 any response type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010091 ",
+        "MSRValue": "0x0000010091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that =
have any response type.",
+        "BriefDescription": "Counts all demand & prefetch data reads have =
any response type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020091 ",
+        "MSRValue": "0x0080020091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_NON=
E",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020091 ",
+        "MSRValue": "0x0100020091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_NOT=
_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & SNOOP_NOT_NEEDE=
D",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020091 ",
+        "MSRValue": "0x0200020091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_MIS=
S",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020091 ",
+        "MSRValue": "0x0400020091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_HIT=
_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & SNOOP_HIT_NO_FW=
D",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020091 ",
+        "MSRValue": "0x1000020091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_HIT=
M",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020091 ",
+        "MSRValue": "0x3F80020091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.ANY_SNOOP=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that=
 hit in the L3 with no details on snoop-related information. Offcore respon=
se can be programmed only with a specific pair of event select and counter =
MSR, and with specific event codes and predefine mask bit value in a dedica=
ted MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0091 ",
+        "MSRValue": "0x00803C0091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that =
hit in the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that=
 hit in the L3 and sibling core snoops are not needed as either the core-va=
lid bit is not set or the shared line is present in multiple cores. Offcore=
 response can be programmed only with a specific pair of event select and c=
ounter MSR, and with specific event codes and predefine mask bit value in a=
 dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0091 ",
+        "MSRValue": "0x01003C0091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that =
hit in the L3 and sibling core snoops are not needed as either the core-val=
id bit is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that=
 hit in the L3 with a snoop miss response. Offcore response can be programm=
ed only with a specific pair of event select and counter MSR, and with spec=
ific event codes and predefine mask bit value in a dedicated MSR to specify=
 attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0091 ",
+        "MSRValue": "0x02003C0091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that =
hit in the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that=
 hit in the L3 and the snoops to sibling cores hit in either E/S state and =
the line is not forwarded. Offcore response can be programmed only with a s=
pecific pair of event select and counter MSR, and with specific event codes=
 and predefine mask bit value in a dedicated MSR to specify attributes of t=
he offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0091 ",
+        "MSRValue": "0x04003C0091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that =
hit in the L3 and the snoops to sibling cores hit in either E/S state and t=
he line is not forwarded.",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0091 ",
+        "MSRValue": "0x10003C0091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that=
 hit in the L3. Offcore response can be programmed only with a specific pai=
r of event select and counter MSR, and with specific event codes and predef=
ine mask bit value in a dedicated MSR to specify attributes of the offcore =
transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0091 ",
+        "MSRValue": "0x3F803C0091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that =
hit in the L3.",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that have =
any response type. Offcore response can be programmed only with a specific =
pair of event select and counter MSR, and with specific event codes and pre=
define mask bit value in a dedicated MSR to specify attributes of the offco=
re transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs have any r=
esponse type.",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0000010122 ",
+        "MSRValue": "0x0000010122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that have a=
ny response type.",
+        "BriefDescription": "Counts all demand & prefetch RFOs have any re=
sponse type.",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0080020122 ",
+        "MSRValue": "0x0080020122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & SNOOP_NONE",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0100020122 ",
+        "MSRValue": "0x0100020122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_NOT_NEE=
DED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0200020122 ",
+        "MSRValue": "0x0200020122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & SNOOP_MISS",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0400020122 ",
+        "MSRValue": "0x0400020122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_HIT_NO_=
FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1000020122 ",
+        "MSRValue": "0x1000020122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & SNOOP_HITM",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f80020122 ",
+        "MSRValue": "0x3F80020122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & ANY_SNOOP",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that hit i=
n the L3 with no details on snoop-related information. Offcore response can=
 be programmed only with a specific pair of event select and counter MSR, a=
nd with specific event codes and predefine mask bit value in a dedicated MS=
R to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00803c0122 ",
+        "MSRValue": "0x00803C0122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that hit in=
 the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that hit i=
n the L3 and sibling core snoops are not needed as either the core-valid bi=
t is not set or the shared line is present in multiple cores. Offcore respo=
nse can be programmed only with a specific pair of event select and counter=
 MSR, and with specific event codes and predefine mask bit value in a dedic=
ated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x01003c0122 ",
+        "MSRValue": "0x01003C0122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that hit in=
 the L3 and sibling core snoops are not needed as either the core-valid bit=
 is not set or the shared line is present in multiple cores.",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that hit i=
n the L3 with a snoop miss response. Offcore response can be programmed onl=
y with a specific pair of event select and counter MSR, and with specific e=
vent codes and predefine mask bit value in a dedicated MSR to specify attri=
butes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x02003c0122 ",
+        "MSRValue": "0x02003C0122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that hit in=
 the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that hit i=
n the L3 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded. Offcore response can be programmed only with a specifi=
c pair of event select and counter MSR, and with specific event codes and p=
redefine mask bit value in a dedicated MSR to specify attributes of the off=
core transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x04003c0122 ",
+        "MSRValue": "0x04003C0122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that hit in=
 the L3 and the snoops to sibling cores hit in either E/S state and the lin=
e is not forwarded.",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x10003c0122 ",
+        "MSRValue": "0x10003C0122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & L3_HIT & SNOOP_HITM",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that hit i=
n the L3. Offcore response can be programmed only with a specific pair of e=
vent select and counter MSR, and with specific event codes and predefine ma=
sk bit value in a dedicated MSR to specify attributes of the offcore transa=
ction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f803c0122 ",
+        "MSRValue": "0x3F803C0122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that hit in=
 the L3.",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json b=
/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
index 689d478dae93..15291239c128 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
@@ -1,24 +1,26 @@
 [
     {
-        "PublicDescription": "This event counts the number of transitions =
from AVX-256 to legacy SSE when penalty is applicable.",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts the number of transitions from AVX-256 to legac=
y SSE when penalty is applicable.",
         "EventCode": "0xC1",
         "Counter": "0,1,2,3",
         "UMask": "0x8",
         "Errata": "BDM30",
         "EventName": "OTHER_ASSISTS.AVX_TO_SSE",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of transitions from AVX-256 to legacy =
SSE when penalty applicable.",
+        "BriefDescription": "Number of transitions from AVX-256 to legacy =
SSE when penalty applicable (Precise Event)",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts the number of transitions =
from legacy SSE to AVX-256 when penalty is applicable.",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts the number of transitions from legacy SSE to AV=
X-256 when penalty is applicable.",
         "EventCode": "0xC1",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
         "Errata": "BDM30",
         "EventName": "OTHER_ASSISTS.SSE_TO_AVX",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of transitions from SSE to AVX-256 whe=
n penalty applicable.",
+        "BriefDescription": "Number of transitions from legacy SSE to AVX-=
256 when penalty applicable (Precise Event)",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -45,7 +47,7 @@
         "UMask": "0x3",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired. Applies to SSE* and AVX* scalar, double and =
single precision floating-point: ADD SUB MUL DIV MIN MAX RSQRT RCP SQRT FM(=
N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform multiple c=
alculations per element.",
+        "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired. Applies to SSE* and AVX* scalar, double and =
single precision floating-point: ADD SUB MUL DIV MIN MAX RSQRT RCP SQRT FM(=
N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform multiple c=
alculations per element. (RSQRT for single precision?)",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -54,7 +56,7 @@
         "UMask": "0x4",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d double precision floating-point instructions retired.  Each count represe=
nts 2 computations. Applies to SSE* and AVX* packed double precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP =
and FM(N)ADD/SUB instructions count twice as they perform multiple calculat=
ions per element.",
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d double precision floating-point instructions retired.  Each count represe=
nts 2 computations. Applies to SSE* and AVX* packed double precision floati=
ng-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT DPP FM=
(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform =
multiple calculations per element.",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -63,7 +65,7 @@
         "UMask": "0x8",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired.  Each count represe=
nts 4 computations. Applies to SSE* and AVX* packed single precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT DPP FM(N)ADD/=
SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multipl=
e calculations per element.",
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired.  Each count represe=
nts 4 computations. Applies to SSE* and AVX* packed single precision floati=
ng-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT =
DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they pe=
rform multiple calculations per element.",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -72,7 +74,7 @@
         "UMask": "0x10",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d double precision floating-point instructions retired.  Each count represe=
nts 4 computations. Applies to SSE* and AVX* packed double precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP =
and FM(N)ADD/SUB instructions count twice as they perform multiple calculat=
ions per element.",
+        "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d double precision floating-point instructions retired.  Each count represe=
nts 4 computations. Applies to SSE* and AVX* packed double precision floati=
ng-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT DPP FM=
(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform =
multiple calculations per element.",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -81,7 +83,7 @@
         "UMask": "0x15",
         "EventName": "FP_ARITH_INST_RETIRED.DOUBLE",
         "SampleAfterValue": "2000006",
-        "BriefDescription": "Number of SSE/AVX computational double precis=
ion floating-point instructions retired. Applies to SSE* and AVX*scalar, do=
uble and single precision floating-point: ADD SUB MUL DIV MIN MAX SQRT DPP =
FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perfor=
m multiple calculations per element.  ?.",
+        "BriefDescription": "Number of SSE/AVX computational double precis=
ion floating-point instructions retired. Applies to SSE* and AVX*scalar, do=
uble and single precision floating-point: ADD SUB MUL DIV MIN MAX SQRT DPP =
FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perfor=
m multiple calculations per element.",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -90,7 +92,7 @@
         "UMask": "0x20",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d single precision floating-point instructions retired.  Each count represe=
nts 8 computations. Applies to SSE* and AVX* packed single precision floati=
ng-point instructions: ADD SUB MUL DIV MIN MAX RCP RSQRT SQRT DPP FM(N)ADD/=
SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform multipl=
e calculations per element.",
+        "BriefDescription": "Number of SSE/AVX computational 256-bit packe=
d single precision floating-point instructions retired.  Each count represe=
nts 8 computations. Applies to SSE* and AVX* packed single precision floati=
ng-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT =
DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they pe=
rform multiple calculations per element.",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -99,7 +101,7 @@
         "UMask": "0x2a",
         "EventName": "FP_ARITH_INST_RETIRED.SINGLE",
         "SampleAfterValue": "2000005",
-        "BriefDescription": "Number of SSE/AVX computational single precis=
ion floating-point instructions retired. Applies to SSE* and AVX*scalar, do=
uble and single precision floating-point: ADD SUB MUL DIV MIN MAX RCP RSQRT=
 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as t=
hey perform multiple calculations per element. ?.",
+        "BriefDescription": "Number of SSE/AVX computational single precis=
ion floating-point instructions retired. Applies to SSE* and AVX*scalar, do=
uble and single precision floating-point: ADD SUB MUL DIV MIN MAX RCP RSQRT=
 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as t=
hey perform multiple calculations per element.",
         "CounterHTOff": "0,1,2,3"
     },
     {
@@ -108,57 +110,62 @@
         "UMask": "0x3c",
         "EventName": "FP_ARITH_INST_RETIRED.PACKED",
         "SampleAfterValue": "2000004",
-        "BriefDescription": "Number of SSE/AVX computational packed floati=
ng-point instructions retired. Applies to SSE* and AVX*, packed, double and=
 single precision floating-point: ADD SUB MUL DIV MIN MAX RSQRT RCP SQRT DP=
P FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perf=
orm multiple calculations per element.",
+        "BriefDescription": "Number of SSE/AVX computational packed floati=
ng-point instructions retired. Applies to SSE* and AVX*, packed, double and=
 single precision floating-point: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX =
SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as th=
ey perform multiple calculations per element. (RSQRT for single-precision?)=
",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "This event counts the number of x87 floating=
 point (FP) micro-code assist (numeric overflow/underflow, inexact result) =
when the output value (destination register) is invalid.",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts the number of x87 floating point (FP) micro-cod=
e assist (numeric overflow/underflow, inexact result) when the output value=
 (destination register) is invalid.",
         "EventCode": "0xCA",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
         "EventName": "FP_ASSIST.X87_OUTPUT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of X87 assists due to output value.",
+        "BriefDescription": "output - Numeric Overflow, Numeric Underflow,=
 Inexact Result  (Precise Event)",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts x87 floating point (FP) mi=
cro-code assist (invalid operation, denormal operand, SNaN operand) when th=
e input value (one of the source operands to an FP instruction) is invalid.=
",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts x87 floating point (FP) micro-code assist (inva=
lid operation, denormal operand, SNaN operand) when the input value (one of=
 the source operands to an FP instruction) is invalid.",
         "EventCode": "0xCA",
         "Counter": "0,1,2,3",
         "UMask": "0x4",
         "EventName": "FP_ASSIST.X87_INPUT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of X87 assists due to input value.",
+        "BriefDescription": "input - Invalid Operation, Denormal Operand, =
SNaN Operand  (Precise Event)",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts the number of SSE* floatin=
g point (FP) micro-code assist (numeric overflow/underflow) when the output=
 value (destination register) is invalid. Counting covers only cases involv=
ing penalties that require micro-code assist intervention.",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts the number of SSE* floating point (FP) micro-co=
de assist (numeric overflow/underflow) when the output value (destination r=
egister) is invalid. Counting covers only cases involving penalties that re=
quire micro-code assist intervention.",
         "EventCode": "0xCA",
         "Counter": "0,1,2,3",
         "UMask": "0x8",
         "EventName": "FP_ASSIST.SIMD_OUTPUT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of SIMD FP assists due to Output value=
s",
+        "BriefDescription": "SSE* FP micro-code assist when output value i=
s invalid. (Precise Event)",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts any input SSE* FP assist -=
 invalid operation, denormal operand, dividing by zero, SNaN operand. Count=
ing includes only cases involving penalties that required micro-code assist=
 intervention.",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts any input SSE* floating-point (FP) assist - inv=
alid operation, denormal operand, dividing by zero, SNaN operand. Counting =
includes only cases involving penalties that required micro-code assist int=
ervention.",
         "EventCode": "0xCA",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
         "EventName": "FP_ASSIST.SIMD_INPUT",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of SIMD FP assists due to input values=
",
+        "BriefDescription": "Any input SSE* FP Assist -   (Precise Event)",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts cycles with any input and =
output SSE or x87 FP assist. If an input and output assist are detected on =
the same cycle the event increments by 1.",
+        "PEBS": "1",
+        "PublicDescription": "This event counts cycles with any input and =
output SSE or x87 FP assist. If an input and output assist are detected on =
the same cycle the event increments by 1. Uses PEBS.",
         "EventCode": "0xCA",
         "Counter": "0,1,2,3",
         "UMask": "0x1e",
         "EventName": "FP_ASSIST.ANY",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Cycles with any input/output SSE or FP assist=
",
+        "BriefDescription": "Counts any FP_ASSIST umask was incrementing  =
 (Precise Event)",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3"
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/frontend.json b/tools=
/perf/pmu-events/arch/x86/broadwell/frontend.json
index 7142c76d7f11..aa4a5d762f21 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/frontend.json
@@ -211,7 +211,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts the number of uops not del=
ivered to Resource Allocation Table (RAT) per thread adding 4  x when Resou=
rce Allocation Table (RAT) is not stalled and Instruction Decode Queue (IDQ=
) delivers x uops to Resource Allocation Table (RAT) (where x belongs to {0=
,1,2,3}). Counting does not cover cases when:\n a. IDQ-Resource Allocation =
Table (RAT) pipe serves the other thread;\n b. Resource Allocation Table (R=
AT) is stalled for the thread (including uop drops and clear BE conditions)=
; \n c. Instruction Decode Queue (IDQ) delivers four uops.",
+        "PublicDescription": "This event counts the number of uops not del=
ivered to Resource Allocation Table (RAT) per thread adding \u201c4 \u2013 =
x\u201d when Resource Allocation Table (RAT) is not stalled and Instruction=
 Decode Queue (IDQ) delivers x uops to Resource Allocation Table (RAT) (whe=
re x belongs to {0,1,2,3}). Counting does not cover cases when:\n a. IDQ-Re=
source Allocation Table (RAT) pipe serves the other thread;\n b. Resource A=
llocation Table (RAT) is stalled for the thread (including uop drops and cl=
ear BE conditions); \n c. Instruction Decode Queue (IDQ) delivers four uops=
.",
         "EventCode": "0x9C",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
@@ -274,7 +274,7 @@
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "This event counts Decode Stream Buffer (DSB)=
-to-MITE switch true penalty cycles. These cycles do not include uops route=
d through because of the switch itself, for example, when Instruction Decod=
e Queue (IDQ) pre-allocation is unavailable, or Instruction Decode Queue (I=
DQ) is full. SBD-to-MITE switch true penalty cycles happen after the merge =
mux (MM) receives Decode Stream Buffer (DSB) Sync-indication until receivin=
g the first MITE uop. \nMM is placed before Instruction Decode Queue (IDQ) =
to merge uops being fed from the MITE and Decode Stream Buffer (DSB) paths.=
 Decode Stream Buffer (DSB) inserts the Sync-indication whenever a Decode S=
tream Buffer (DSB)-to-MITE switch occurs.\nPenalty: A Decode Stream Buffer =
(DSB) hit followed by a Decode Stream Buffer (DSB) miss can cost up to six =
cycles in which no uops are delivered to the IDQ. Most often, such switches=
 from the Decode Stream Buffer (DSB) to the legacy pipeline cost 02 cycles.=
",
+        "PublicDescription": "This event counts Decode Stream Buffer (DSB)=
-to-MITE switch true penalty cycles. These cycles do not include uops route=
d through because of the switch itself, for example, when Instruction Decod=
e Queue (IDQ) pre-allocation is unavailable, or Instruction Decode Queue (I=
DQ) is full. SBD-to-MITE switch true penalty cycles happen after the merge =
mux (MM) receives Decode Stream Buffer (DSB) Sync-indication until receivin=
g the first MITE uop. \nMM is placed before Instruction Decode Queue (IDQ) =
to merge uops being fed from the MITE and Decode Stream Buffer (DSB) paths.=
 Decode Stream Buffer (DSB) inserts the Sync-indication whenever a Decode S=
tream Buffer (DSB)-to-MITE switch occurs.\nPenalty: A Decode Stream Buffer =
(DSB) hit followed by a Decode Stream Buffer (DSB) miss can cost up to six =
cycles in which no uops are delivered to the IDQ. Most often, such switches=
 from the Decode Stream Buffer (DSB) to the legacy pipeline cost 0\u20132 c=
ycles.",
         "EventCode": "0xAB",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/memory.json b/tools/p=
erf/pmu-events/arch/x86/broadwell/memory.json
index c9154cebbdf0..b6b5247d3d5a 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/memory.json
@@ -311,7 +311,7 @@
     },
     {
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above four.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above four.",
         "EventCode": "0xCD",
         "MSRValue": "0x4",
         "Counter": "3",
@@ -320,13 +320,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Loads with latency value being above 4",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 4",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above eight.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above eight.",
         "EventCode": "0xCD",
         "MSRValue": "0x8",
         "Counter": "3",
@@ -335,13 +335,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "50021",
-        "BriefDescription": "Loads with latency value being above 8",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 8",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 16.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 16.",
         "EventCode": "0xCD",
         "MSRValue": "0x10",
         "Counter": "3",
@@ -350,13 +350,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "20011",
-        "BriefDescription": "Loads with latency value being above 16",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 16",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 32.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 32.",
         "EventCode": "0xCD",
         "MSRValue": "0x20",
         "Counter": "3",
@@ -365,13 +365,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Loads with latency value being above 32",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 32",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 64.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 64.",
         "EventCode": "0xCD",
         "MSRValue": "0x40",
         "Counter": "3",
@@ -380,13 +380,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "2003",
-        "BriefDescription": "Loads with latency value being above 64",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 64",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 128.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 128.",
         "EventCode": "0xCD",
         "MSRValue": "0x80",
         "Counter": "3",
@@ -395,13 +395,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "1009",
-        "BriefDescription": "Loads with latency value being above 128",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 128",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 256.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 256.",
         "EventCode": "0xCD",
         "MSRValue": "0x100",
         "Counter": "3",
@@ -410,13 +410,13 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "503",
-        "BriefDescription": "Loads with latency value being above 256",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 256",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
     {
         "PEBS": "2",
-        "PublicDescription": "This event counts loads with latency value b=
eing above 512.",
+        "PublicDescription": "Counts randomly selected loads with latency =
value being above 512.",
         "EventCode": "0xCD",
         "MSRValue": "0x200",
         "Counter": "3",
@@ -425,2620 +425,2620 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "SampleAfterValue": "101",
-        "BriefDescription": "Loads with latency value being above 512",
+        "BriefDescription": "Randomly selected loads with latency value be=
ing above 512",
         "TakenAlone": "1",
         "CounterHTOff": "3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020001 ",
+        "MSRValue": "0x2000020001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & SUPPLIER_NONE & SNOOP_NON_DR=
AM",
+        "BriefDescription": "Counts demand data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts demand data reads that hit in the L3 =
and the target was non-DRAM system address. Offcore response can be program=
med only with a specific pair of event select and counter MSR, and with spe=
cific event codes and predefine mask bit value in a dedicated MSR to specif=
y attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0001 ",
+        "MSRValue": "0x20003C0001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.SNOOP_NON_DRA=
M",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that hit in the L3 a=
nd the target was non-DRAM system address.",
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
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
ONE",
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
-        "MSRValue": "0x1004000001 ",
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
-        "MSRValue": "0x2004000001 ",
+        "MSRValue": "0x2004000001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
ON_DRAM",
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
-        "MSRValue": "0x3f84000001 ",
+        "MSRValue": "0x3F84000001",
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
-        "PublicDescription": "Counts demand data reads that miss the L3 wi=
th no details on snoop-related information. Offcore response can be program=
med only with a specific pair of event select and counter MSR, and with spe=
cific event codes and predefine mask bit value in a dedicated MSR to specif=
y attributes of the offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000001 ",
+        "MSRValue": "0x00BC000001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that miss the L3 wit=
h no details on snoop-related information.",
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
+        "MSRValue": "0x013C000001",
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
-        "PublicDescription": "Counts demand data reads that miss the L3 wi=
th a snoop miss response. Offcore response can be programmed only with a sp=
ecific pair of event select and counter MSR, and with specific event codes =
and predefine mask bit value in a dedicated MSR to specify attributes of th=
e offcore transaction.",
+        "PublicDescription": "Counts demand data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000001 ",
+        "MSRValue": "0x023C000001",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts demand data reads that miss the L3 wit=
h a snoop miss response.",
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
+        "MSRValue": "0x043C000001",
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
-        "PublicDescription": "Counts all demand data writes (RFOs) that hi=
t in the L3 and the target was non-DRAM system address. Offcore response ca=
n be programmed only with a specific pair of event select and counter MSR, =
and with specific event codes and predefine mask bit value in a dedicated M=
SR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0002 ",
+        "MSRValue": "0x20003C0002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that hit=
 in the L3 and the target was non-DRAM system address.",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000002 ",
+        "MSRValue": "0x3F84000002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS_LOCAL_DRAM.ANY_S=
NOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_RFO & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that mi=
ss the L3 with no details on snoop-related information. Offcore response ca=
n be programmed only with a specific pair of event select and counter MSR, =
and with specific event codes and predefine mask bit value in a dedicated M=
SR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000002 ",
+        "MSRValue": "0x00BC000002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that mis=
s the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000002 ",
+        "MSRValue": "0x013C000002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_NOT_NEEDED=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_RFO & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand data writes (RFOs) that mi=
ss the L3 with a snoop miss response. Offcore response can be programmed on=
ly with a specific pair of event select and counter MSR, and with specific =
event codes and predefine mask bit value in a dedicated MSR to specify attr=
ibutes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000002 ",
+        "MSRValue": "0x023C000002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand data writes (RFOs) that mis=
s the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand data writes (RFOs)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000002 ",
+        "MSRValue": "0x043C000002",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.SNOOP_HIT_NO_FWD=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_RFO & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all demand data writes (RFOs)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020004 ",
+        "MSRValue": "0x2000020004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & SUPPLIER_NONE & SNOOP_NON_DR=
AM",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that hit in the=
 L3 and the target was non-DRAM system address. Offcore response can be pro=
grammed only with a specific pair of event select and counter MSR, and with=
 specific event codes and predefine mask bit value in a dedicated MSR to sp=
ecify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0004 ",
+        "MSRValue": "0x20003C0004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.SNOOP_NON_DRA=
M",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that hit in the =
L3 and the target was non-DRAM system address.",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000004 ",
+        "MSRValue": "0x0084000004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
ONE",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000004 ",
+        "MSRValue": "0x0104000004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
OT_NEEDED",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000004 ",
+        "MSRValue": "0x0204000004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_M=
ISS",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000004 ",
+        "MSRValue": "0x0404000004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_H=
IT_NO_FWD",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000004 ",
+        "MSRValue": "0x1004000004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_H=
ITM",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000004 ",
+        "MSRValue": "0x2004000004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
ON_DRAM",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000004 ",
+        "MSRValue": "0x3F84000004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS_LOCAL_DRAM.A=
NY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & L3_MISS_LOCAL_DRAM & ANY_SNO=
OP",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that miss the L=
3 with no details on snoop-related information. Offcore response can be pro=
grammed only with a specific pair of event select and counter MSR, and with=
 specific event codes and predefine mask bit value in a dedicated MSR to sp=
ecify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000004 ",
+        "MSRValue": "0x00BC000004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that miss the L3=
 with no details on snoop-related information.",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000004 ",
+        "MSRValue": "0x013C000004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand code reads that miss the L=
3 with a snoop miss response. Offcore response can be programmed only with =
a specific pair of event select and counter MSR, and with specific event co=
des and predefine mask bit value in a dedicated MSR to specify attributes o=
f the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000004 ",
+        "MSRValue": "0x023C000004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand code reads that miss the L3=
 with a snoop miss response.",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000004 ",
+        "MSRValue": "0x043C000004",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "DEMAND_CODE_RD & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all demand code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020008 ",
+        "MSRValue": "0x2000020008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.SUPPLIER_NONE.SNOOP_NON_DRAM=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & SUPPLIER_NONE & SNOOP_NON_DRAM",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts writebacks (modified to exclusive) th=
at hit in the L3 and the target was non-DRAM system address. Offcore respon=
se can be programmed only with a specific pair of event select and counter =
MSR, and with specific event codes and predefine mask bit value in a dedica=
ted MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0008 ",
+        "MSRValue": "0x20003C0008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_HIT.SNOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts writebacks (modified to exclusive) tha=
t hit in the L3 and the target was non-DRAM system address.",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000008 ",
+        "MSRValue": "0x0084000008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_NON=
E",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & L3_MISS_LOCAL_DRAM & SNOOP_NONE",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000008 ",
+        "MSRValue": "0x0104000008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_NOT=
_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & L3_MISS_LOCAL_DRAM & SNOOP_NOT_NEEDE=
D",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000008 ",
+        "MSRValue": "0x0204000008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_MIS=
S",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & L3_MISS_LOCAL_DRAM & SNOOP_MISS",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000008 ",
+        "MSRValue": "0x0404000008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_HIT=
_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & L3_MISS_LOCAL_DRAM & SNOOP_HIT_NO_FW=
D",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000008 ",
+        "MSRValue": "0x1004000008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_HIT=
M",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & L3_MISS_LOCAL_DRAM & SNOOP_HITM",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000008 ",
+        "MSRValue": "0x2004000008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.SNOOP_NON=
_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & L3_MISS_LOCAL_DRAM & SNOOP_NON_DRAM",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000008 ",
+        "MSRValue": "0x3F84000008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS_LOCAL_DRAM.ANY_SNOOP=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts writebacks (modified to exclusive) th=
at miss the L3 with no details on snoop-related information. Offcore respon=
se can be programmed only with a specific pair of event select and counter =
MSR, and with specific event codes and predefine mask bit value in a dedica=
ted MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000008 ",
+        "MSRValue": "0x00BC000008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts writebacks (modified to exclusive) tha=
t miss the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000008 ",
+        "MSRValue": "0x013C000008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts writebacks (modified to exclusive) th=
at miss the L3 with a snoop miss response. Offcore response can be programm=
ed only with a specific pair of event select and counter MSR, and with spec=
ific event codes and predefine mask bit value in a dedicated MSR to specify=
 attributes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000008 ",
+        "MSRValue": "0x023C000008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts writebacks (modified to exclusive) tha=
t miss the L3 with a snoop miss response.",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts writebacks (modified to exclusive)",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000008 ",
+        "MSRValue": "0x043C000008",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.COREWB.L3_MISS.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "COREWB & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts writebacks (modified to exclusive)",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020010 ",
+        "MSRValue": "0x2000020010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.SUPPLIER_NONE.SNOOP_N=
ON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & SUPPLIER_NONE & SNOOP_NON_DRA=
M",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads that hit in the L3 and the target was non-DRAM system address. Offco=
re response can be programmed only with a specific pair of event select and=
 counter MSR, and with specific event codes and predefine mask bit value in=
 a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0010 ",
+        "MSRValue": "0x20003C0010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_HIT.SNOOP_NON_DRAM=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that hit in the L3 and the target was non-DRAM system address.",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000010 ",
+        "MSRValue": "0x0084000010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
NE",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000010 ",
+        "MSRValue": "0x0104000010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
T_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000010 ",
+        "MSRValue": "0x0204000010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_MI=
SS",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000010 ",
+        "MSRValue": "0x0404000010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_HI=
T_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000010 ",
+        "MSRValue": "0x1004000010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_HI=
TM",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000010 ",
+        "MSRValue": "0x2004000010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
N_DRAM",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000010 ",
+        "MSRValue": "0x3F84000010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS_LOCAL_DRAM.AN=
Y_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & L3_MISS_LOCAL_DRAM & ANY_SNOO=
P",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads that miss the L3 with no details on snoop-related information. Offco=
re response can be programmed only with a specific pair of event select and=
 counter MSR, and with specific event codes and predefine mask bit value in=
 a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000010 ",
+        "MSRValue": "0x00BC000010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that miss the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000010 ",
+        "MSRValue": "0x013C000010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads that miss the L3 with a snoop miss response. Offcore response can be=
 programmed only with a specific pair of event select and counter MSR, and =
with specific event codes and predefine mask bit value in a dedicated MSR t=
o specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000010 ",
+        "MSRValue": "0x023C000010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads that miss the L3 with a snoop miss response.",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000010 ",
+        "MSRValue": "0x043C000010",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_DATA_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_DATA_RD & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020020 ",
+        "MSRValue": "0x2000020020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.SUPPLIER_NONE.SNOOP_NON_D=
RAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & SUPPLIER_NONE & SNOOP_NON_DRAM",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs that hit in the L3 and the target was non-DRAM system address. Offcore=
 response can be programmed only with a specific pair of event select and c=
ounter MSR, and with specific event codes and predefine mask bit value in a=
 dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0020 ",
+        "MSRValue": "0x20003C0020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_HIT.SNOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs that hit in the L3 and the target was non-DRAM system address.",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000020 ",
+        "MSRValue": "0x0084000020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000020 ",
+        "MSRValue": "0x0104000020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NOT_NE=
EDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000020 ",
+        "MSRValue": "0x0204000020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & L3_MISS_LOCAL_DRAM & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000020 ",
+        "MSRValue": "0x0404000020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & L3_MISS_LOCAL_DRAM & SNOOP_HIT_NO=
_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000020 ",
+        "MSRValue": "0x1004000020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & L3_MISS_LOCAL_DRAM & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000020 ",
+        "MSRValue": "0x2004000020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NON_DR=
AM",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000020 ",
+        "MSRValue": "0x3F84000020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS_LOCAL_DRAM.ANY_SN=
OOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs that miss the L3 with no details on snoop-related information. Offcore=
 response can be programmed only with a specific pair of event select and c=
ounter MSR, and with specific event codes and predefine mask bit value in a=
 dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000020 ",
+        "MSRValue": "0x00BC000020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs that miss the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000020 ",
+        "MSRValue": "0x013C000020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs that miss the L3 with a snoop miss response. Offcore response can be p=
rogrammed only with a specific pair of event select and counter MSR, and wi=
th specific event codes and predefine mask bit value in a dedicated MSR to =
specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000020 ",
+        "MSRValue": "0x023C000020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs that miss the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000020 ",
+        "MSRValue": "0x043C000020",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_RFO.L3_MISS.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_RFO & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020040 ",
+        "MSRValue": "0x2000020040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.SUPPLIER_NONE.SNOOP_N=
ON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & SUPPLIER_NONE & SNOOP_NON_DRA=
M",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads that hit in the L3 and the target was non-DRAM system addr=
ess. Offcore response can be programmed only with a specific pair of event =
select and counter MSR, and with specific event codes and predefine mask bi=
t value in a dedicated MSR to specify attributes of the offcore transaction=
.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0040 ",
+        "MSRValue": "0x20003C0040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_HIT.SNOOP_NON_DRAM=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads that hit in the L3 and the target was non-DRAM system addre=
ss.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000040 ",
+        "MSRValue": "0x0084000040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
NE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000040 ",
+        "MSRValue": "0x0104000040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
T_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000040 ",
+        "MSRValue": "0x0204000040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_MI=
SS",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000040 ",
+        "MSRValue": "0x0404000040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_HI=
T_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000040 ",
+        "MSRValue": "0x1004000040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_HI=
TM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000040 ",
+        "MSRValue": "0x2004000040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
N_DRAM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000040 ",
+        "MSRValue": "0x3F84000040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS_LOCAL_DRAM.AN=
Y_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & L3_MISS_LOCAL_DRAM & ANY_SNOO=
P",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads that miss the L3 with no details on snoop-related informat=
ion. Offcore response can be programmed only with a specific pair of event =
select and counter MSR, and with specific event codes and predefine mask bi=
t value in a dedicated MSR to specify attributes of the offcore transaction=
.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000040 ",
+        "MSRValue": "0x00BC000040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads that miss the L3 with no details on snoop-related informati=
on.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000040 ",
+        "MSRValue": "0x013C000040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads that miss the L3 with a snoop miss response. Offcore respo=
nse can be programmed only with a specific pair of event select and counter=
 MSR, and with specific event codes and predefine mask bit value in a dedic=
ated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000040 ",
+        "MSRValue": "0x023C000040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads that miss the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000040 ",
+        "MSRValue": "0x043C000040",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L2_CODE_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L2_CODE_RD & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020080 ",
+        "MSRValue": "0x2000020080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.SUPPLIER_NONE.SNOOP_N=
ON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & SUPPLIER_NONE & SNOOP_NON_DRA=
M",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads that hit in the L3 and the target was non-DRAM system addr=
ess. Offcore response can be programmed only with a specific pair of event =
select and counter MSR, and with specific event codes and predefine mask bi=
t value in a dedicated MSR to specify attributes of the offcore transaction=
.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0080 ",
+        "MSRValue": "0x20003C0080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_HIT.SNOOP_NON_DRAM=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads that hit in the L3 and the target was non-DRAM system addre=
ss.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000080 ",
+        "MSRValue": "0x0084000080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
NE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000080 ",
+        "MSRValue": "0x0104000080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
T_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000080 ",
+        "MSRValue": "0x0204000080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_MI=
SS",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000080 ",
+        "MSRValue": "0x0404000080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_HI=
T_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000080 ",
+        "MSRValue": "0x1004000080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_HI=
TM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000080 ",
+        "MSRValue": "0x2004000080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
N_DRAM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000080 ",
+        "MSRValue": "0x3F84000080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS_LOCAL_DRAM.AN=
Y_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & L3_MISS_LOCAL_DRAM & ANY_SNOO=
P",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads that miss the L3 with no details on snoop-related informat=
ion. Offcore response can be programmed only with a specific pair of event =
select and counter MSR, and with specific event codes and predefine mask bi=
t value in a dedicated MSR to specify attributes of the offcore transaction=
.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000080 ",
+        "MSRValue": "0x00BC000080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads that miss the L3 with no details on snoop-related informati=
on.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000080 ",
+        "MSRValue": "0x013C000080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads that miss the L3 with a snoop miss response. Offcore respo=
nse can be programmed only with a specific pair of event select and counter=
 MSR, and with specific event codes and predefine mask bit value in a dedic=
ated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000080 ",
+        "MSRValue": "0x023C000080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads that miss the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000080 ",
+        "MSRValue": "0x043C000080",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_DATA_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_DATA_RD & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020100 ",
+        "MSRValue": "0x2000020100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.SUPPLIER_NONE.SNOOP_NON_D=
RAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & SUPPLIER_NONE & SNOOP_NON_DRAM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs that hit in the L3 and the target was non-DRAM system address. O=
ffcore response can be programmed only with a specific pair of event select=
 and counter MSR, and with specific event codes and predefine mask bit valu=
e in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0100 ",
+        "MSRValue": "0x20003C0100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_HIT.SNOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs that hit in the L3 and the target was non-DRAM system address.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000100 ",
+        "MSRValue": "0x0084000100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NONE",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000100 ",
+        "MSRValue": "0x0104000100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NOT_NE=
EDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000100 ",
+        "MSRValue": "0x0204000100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & L3_MISS_LOCAL_DRAM & SNOOP_MISS",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000100 ",
+        "MSRValue": "0x0404000100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & L3_MISS_LOCAL_DRAM & SNOOP_HIT_NO=
_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000100 ",
+        "MSRValue": "0x1004000100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & L3_MISS_LOCAL_DRAM & SNOOP_HITM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000100 ",
+        "MSRValue": "0x2004000100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.SNOOP_=
NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NON_DR=
AM",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000100 ",
+        "MSRValue": "0x3F84000100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS_LOCAL_DRAM.ANY_SN=
OOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs that miss the L3 with no details on snoop-related information. O=
ffcore response can be programmed only with a specific pair of event select=
 and counter MSR, and with specific event codes and predefine mask bit valu=
e in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000100 ",
+        "MSRValue": "0x00BC000100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs that miss the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000100 ",
+        "MSRValue": "0x013C000100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs that miss the L3 with a snoop miss response. Offcore response ca=
n be programmed only with a specific pair of event select and counter MSR, =
and with specific event codes and predefine mask bit value in a dedicated M=
SR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000100 ",
+        "MSRValue": "0x023C000100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs that miss the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000100 ",
+        "MSRValue": "0x043C000100",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_RFO.L3_MISS.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_RFO & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020200 ",
+        "MSRValue": "0x2000020200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.SUPPLIER_NONE.SNOOP_N=
ON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & SUPPLIER_NONE & SNOOP_NON_DRA=
M",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads that hit in the L3 and the target was non-DRAM system address.=
 Offcore response can be programmed only with a specific pair of event sele=
ct and counter MSR, and with specific event codes and predefine mask bit va=
lue in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0200 ",
+        "MSRValue": "0x20003C0200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_HIT.SNOOP_NON_DRAM=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads that hit in the L3 and the target was non-DRAM system address.",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000200 ",
+        "MSRValue": "0x0084000200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
NE",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000200 ",
+        "MSRValue": "0x0104000200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
T_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000200 ",
+        "MSRValue": "0x0204000200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_MI=
SS",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000200 ",
+        "MSRValue": "0x0404000200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_HI=
T_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000200 ",
+        "MSRValue": "0x1004000200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_HI=
TM",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000200 ",
+        "MSRValue": "0x2004000200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.SN=
OOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_NO=
N_DRAM",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000200 ",
+        "MSRValue": "0x3F84000200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS_LOCAL_DRAM.AN=
Y_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & L3_MISS_LOCAL_DRAM & ANY_SNOO=
P",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads that miss the L3 with no details on snoop-related information.=
 Offcore response can be programmed only with a specific pair of event sele=
ct and counter MSR, and with specific event codes and predefine mask bit va=
lue in a dedicated MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000200 ",
+        "MSRValue": "0x00BC000200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads that miss the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000200 ",
+        "MSRValue": "0x013C000200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_NOT_NEE=
DED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads that miss the L3 with a snoop miss response. Offcore response =
can be programmed only with a specific pair of event select and counter MSR=
, and with specific event codes and predefine mask bit value in a dedicated=
 MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000200 ",
+        "MSRValue": "0x023C000200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads that miss the L3 with a snoop miss response.",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000200 ",
+        "MSRValue": "0x043C000200",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.PF_L3_CODE_RD.L3_MISS.SNOOP_HIT_NO_=
FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "PF_L3_CODE_RD & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads",
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
-        "MSRValue": "0x2000028000 ",
+        "MSRValue": "0x2000028000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.SUPPLIER_NONE.SNOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & SUPPLIER_NONE & SNOOP_NON_DRAM",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts any other requests that hit in the L3=
 and the target was non-DRAM system address. Offcore response can be progra=
mmed only with a specific pair of event select and counter MSR, and with sp=
ecific event codes and predefine mask bit value in a dedicated MSR to speci=
fy attributes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c8000 ",
+        "MSRValue": "0x20003C8000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_HIT.SNOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts any other requests that hit in the L3 =
and the target was non-DRAM system address.",
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
-        "MSRValue": "0x0084008000 ",
+        "MSRValue": "0x0084008000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NONE=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & L3_MISS_LOCAL_DRAM & SNOOP_NONE",
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
-        "MSRValue": "0x0104008000 ",
+        "MSRValue": "0x0104008000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NOT_=
NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & L3_MISS_LOCAL_DRAM & SNOOP_NOT_NEEDED=
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
-        "MSRValue": "0x0204008000 ",
+        "MSRValue": "0x0204008000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_MISS=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & L3_MISS_LOCAL_DRAM & SNOOP_MISS",
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
-        "MSRValue": "0x0404008000 ",
+        "MSRValue": "0x0404008000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_HIT_=
NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & L3_MISS_LOCAL_DRAM & SNOOP_HIT_NO_FWD=
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
-        "MSRValue": "0x1004008000 ",
+        "MSRValue": "0x1004008000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_HITM=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & L3_MISS_LOCAL_DRAM & SNOOP_HITM",
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
-        "MSRValue": "0x2004008000 ",
+        "MSRValue": "0x2004008000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.SNOOP_NON_=
DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & L3_MISS_LOCAL_DRAM & SNOOP_NON_DRAM",
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
-        "MSRValue": "0x3f84008000 ",
+        "MSRValue": "0x3F84008000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS_LOCAL_DRAM.ANY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts any other requests that miss the L3 w=
ith no details on snoop-related information. Offcore response can be progra=
mmed only with a specific pair of event select and counter MSR, and with sp=
ecific event codes and predefine mask bit value in a dedicated MSR to speci=
fy attributes of the offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc008000 ",
+        "MSRValue": "0x00BC008000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts any other requests that miss the L3 wi=
th no details on snoop-related information.",
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
-        "MSRValue": "0x013c008000 ",
+        "MSRValue": "0x013C008000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts any other requests that miss the L3 w=
ith a snoop miss response. Offcore response can be programmed only with a s=
pecific pair of event select and counter MSR, and with specific event codes=
 and predefine mask bit value in a dedicated MSR to specify attributes of t=
he offcore transaction.",
+        "PublicDescription": "Counts any other requests",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c008000 ",
+        "MSRValue": "0x023C008000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts any other requests that miss the L3 wi=
th a snoop miss response.",
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
-        "MSRValue": "0x043c008000 ",
+        "MSRValue": "0x043C008000",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.OTHER.L3_MISS.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "OTHER & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts any other requests",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020090 ",
+        "MSRValue": "0x2000020090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & SUPPLIER_NONE & SNOOP_NON_DR=
AM",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch data reads that hit in t=
he L3 and the target was non-DRAM system address. Offcore response can be p=
rogrammed only with a specific pair of event select and counter MSR, and wi=
th specific event codes and predefine mask bit value in a dedicated MSR to =
specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0090 ",
+        "MSRValue": "0x20003C0090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_HIT.SNOOP_NON_DRA=
M",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch data reads that hit in th=
e L3 and the target was non-DRAM system address.",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000090 ",
+        "MSRValue": "0x0084000090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
ONE",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000090 ",
+        "MSRValue": "0x0104000090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
OT_NEEDED",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000090 ",
+        "MSRValue": "0x0204000090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_M=
ISS",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000090 ",
+        "MSRValue": "0x0404000090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_H=
IT_NO_FWD",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000090 ",
+        "MSRValue": "0x1004000090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_H=
ITM",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000090 ",
+        "MSRValue": "0x2004000090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
ON_DRAM",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000090 ",
+        "MSRValue": "0x3F84000090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS_LOCAL_DRAM.A=
NY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS_LOCAL_DRAM & ANY_SNO=
OP",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch data reads that miss the=
 L3 with no details on snoop-related information. Offcore response can be p=
rogrammed only with a specific pair of event select and counter MSR, and wi=
th specific event codes and predefine mask bit value in a dedicated MSR to =
specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000090 ",
+        "MSRValue": "0x00BC000090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch data reads that miss the =
L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000090 ",
+        "MSRValue": "0x013C000090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch data reads that miss the=
 L3 with a snoop miss response. Offcore response can be programmed only wit=
h a specific pair of event select and counter MSR, and with specific event =
codes and predefine mask bit value in a dedicated MSR to specify attributes=
 of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000090 ",
+        "MSRValue": "0x023C000090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch data reads that miss the =
L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000090 ",
+        "MSRValue": "0x043C000090",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_DATA_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_DATA_RD & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020120 ",
+        "MSRValue": "0x2000020120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.SUPPLIER_NONE.SNOOP_NON_=
DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & SUPPLIER_NONE & SNOOP_NON_DRAM",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch RFOs that hit in the L3 and =
the target was non-DRAM system address. Offcore response can be programmed =
only with a specific pair of event select and counter MSR, and with specifi=
c event codes and predefine mask bit value in a dedicated MSR to specify at=
tributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0120 ",
+        "MSRValue": "0x20003C0120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_HIT.SNOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch RFOs that hit in the L3 and t=
he target was non-DRAM system address.",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000120 ",
+        "MSRValue": "0x0084000120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NONE",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000120 ",
+        "MSRValue": "0x0104000120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NOT_N=
EEDED",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000120 ",
+        "MSRValue": "0x0204000120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & SNOOP_MISS",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000120 ",
+        "MSRValue": "0x0404000120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & SNOOP_HIT_N=
O_FWD",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000120 ",
+        "MSRValue": "0x1004000120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & SNOOP_HITM",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000120 ",
+        "MSRValue": "0x2004000120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.SNOOP=
_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NON_D=
RAM",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000120 ",
+        "MSRValue": "0x3F84000120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS_LOCAL_DRAM.ANY_S=
NOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch RFOs that miss the L3 with n=
o details on snoop-related information. Offcore response can be programmed =
only with a specific pair of event select and counter MSR, and with specifi=
c event codes and predefine mask bit value in a dedicated MSR to specify at=
tributes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000120 ",
+        "MSRValue": "0x00BC000120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch RFOs that miss the L3 with no=
 details on snoop-related information.",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000120 ",
+        "MSRValue": "0x013C000120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_NOT_NEEDED=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts prefetch RFOs that miss the L3 with a=
 snoop miss response. Offcore response can be programmed only with a specif=
ic pair of event select and counter MSR, and with specific event codes and =
predefine mask bit value in a dedicated MSR to specify attributes of the of=
fcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000120 ",
+        "MSRValue": "0x023C000120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts prefetch RFOs that miss the L3 with a =
snoop miss response.",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000120 ",
+        "MSRValue": "0x043C000120",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_RFO.L3_MISS.SNOOP_HIT_NO_FWD=
",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_RFO & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020240 ",
+        "MSRValue": "0x2000020240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.SUPPLIER_NONE.SNOOP_=
NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & SUPPLIER_NONE & SNOOP_NON_DR=
AM",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch code reads that hit in t=
he L3 and the target was non-DRAM system address. Offcore response can be p=
rogrammed only with a specific pair of event select and counter MSR, and wi=
th specific event codes and predefine mask bit value in a dedicated MSR to =
specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0240 ",
+        "MSRValue": "0x20003C0240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_HIT.SNOOP_NON_DRA=
M",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch code reads that hit in th=
e L3 and the target was non-DRAM system address.",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000240 ",
+        "MSRValue": "0x0084000240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
ONE",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000240 ",
+        "MSRValue": "0x0104000240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
OT_NEEDED",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000240 ",
+        "MSRValue": "0x0204000240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_M=
ISS",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000240 ",
+        "MSRValue": "0x0404000240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_H=
IT_NO_FWD",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000240 ",
+        "MSRValue": "0x1004000240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_H=
ITM",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000240 ",
+        "MSRValue": "0x2004000240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.S=
NOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & L3_MISS_LOCAL_DRAM & SNOOP_N=
ON_DRAM",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000240 ",
+        "MSRValue": "0x3F84000240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS_LOCAL_DRAM.A=
NY_SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & L3_MISS_LOCAL_DRAM & ANY_SNO=
OP",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch code reads that miss the=
 L3 with no details on snoop-related information. Offcore response can be p=
rogrammed only with a specific pair of event select and counter MSR, and wi=
th specific event codes and predefine mask bit value in a dedicated MSR to =
specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000240 ",
+        "MSRValue": "0x00BC000240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch code reads that miss the =
L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000240 ",
+        "MSRValue": "0x013C000240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_NOT_NE=
EDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all prefetch code reads that miss the=
 L3 with a snoop miss response. Offcore response can be programmed only wit=
h a specific pair of event select and counter MSR, and with specific event =
codes and predefine mask bit value in a dedicated MSR to specify attributes=
 of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000240 ",
+        "MSRValue": "0x023C000240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all prefetch code reads that miss the =
L3 with a snoop miss response.",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all prefetch code reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000240 ",
+        "MSRValue": "0x043C000240",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_PF_CODE_RD.L3_MISS.SNOOP_HIT_NO=
_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_PF_CODE_RD & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all prefetch code reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020091 ",
+        "MSRValue": "0x2000020091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.SUPPLIER_NONE.SNOOP_NON=
_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & SUPPLIER_NONE & SNOOP_NON_DRAM",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that=
 hit in the L3 and the target was non-DRAM system address. Offcore response=
 can be programmed only with a specific pair of event select and counter MS=
R, and with specific event codes and predefine mask bit value in a dedicate=
d MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0091 ",
+        "MSRValue": "0x20003C0091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.SNOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that =
hit in the L3 and the target was non-DRAM system address.",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000091 ",
+        "MSRValue": "0x0084000091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_NONE=
",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000091 ",
+        "MSRValue": "0x0104000091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_NOT_=
NEEDED",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000091 ",
+        "MSRValue": "0x0204000091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_MISS=
",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000091 ",
+        "MSRValue": "0x0404000091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_HIT_=
NO_FWD",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000091 ",
+        "MSRValue": "0x1004000091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_HITM=
",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000091 ",
+        "MSRValue": "0x2004000091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.SNOO=
P_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & SNOOP_NON_=
DRAM",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000091 ",
+        "MSRValue": "0x3F84000091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS_LOCAL_DRAM.ANY_=
SNOOP",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that=
 miss the L3 with no details on snoop-related information. Offcore response=
 can be programmed only with a specific pair of event select and counter MS=
R, and with specific event codes and predefine mask bit value in a dedicate=
d MSR to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000091 ",
+        "MSRValue": "0x00BC000091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that =
miss the L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000091 ",
+        "MSRValue": "0x013C000091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_NOT_NEEDE=
D",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch data reads that=
 miss the L3 with a snoop miss response. Offcore response can be programmed=
 only with a specific pair of event select and counter MSR, and with specif=
ic event codes and predefine mask bit value in a dedicated MSR to specify a=
ttributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000091 ",
+        "MSRValue": "0x023C000091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch data reads that =
miss the L3 with a snoop miss response.",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch data reads",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000091 ",
+        "MSRValue": "0x043C000091",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.SNOOP_HIT_NO_FW=
D",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_DATA_RD & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all demand & prefetch data reads",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2000020122 ",
+        "MSRValue": "0x2000020122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.SUPPLIER_NONE.SNOOP_NON_DRA=
M",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & SUPPLIER_NONE & SNOOP_NON_DRAM",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that hit i=
n the L3 and the target was non-DRAM system address. Offcore response can b=
e programmed only with a specific pair of event select and counter MSR, and=
 with specific event codes and predefine mask bit value in a dedicated MSR =
to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x20003c0122 ",
+        "MSRValue": "0x20003C0122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.SNOOP_NON_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that hit in=
 the L3 and the target was non-DRAM system address.",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0084000122 ",
+        "MSRValue": "0x0084000122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_NO=
NE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NONE",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0104000122 ",
+        "MSRValue": "0x0104000122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_NO=
T_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NOT_NEED=
ED",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0204000122 ",
+        "MSRValue": "0x0204000122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_MI=
SS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & SNOOP_MISS",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x0404000122 ",
+        "MSRValue": "0x0404000122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_HI=
T_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & SNOOP_HIT_NO_F=
WD",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x1004000122 ",
+        "MSRValue": "0x1004000122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_HI=
TM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & SNOOP_HITM",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x2004000122 ",
+        "MSRValue": "0x2004000122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.SNOOP_NO=
N_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & SNOOP_NON_DRAM=
",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x3f84000122 ",
+        "MSRValue": "0x3F84000122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS_LOCAL_DRAM.ANY_SNOO=
P",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & L3_MISS_LOCAL_DRAM & ANY_SNOOP",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that miss =
the L3 with no details on snoop-related information. Offcore response can b=
e programmed only with a specific pair of event select and counter MSR, and=
 with specific event codes and predefine mask bit value in a dedicated MSR =
to specify attributes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x00bc000122 ",
+        "MSRValue": "0x00BC000122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_NONE",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that miss t=
he L3 with no details on snoop-related information.",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x013c000122 ",
+        "MSRValue": "0x013C000122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & L3_MISS & SNOOP_NOT_NEEDED",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Counts all demand & prefetch RFOs that miss =
the L3 with a snoop miss response. Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x023c000122 ",
+        "MSRValue": "0x023C000122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Counts all demand & prefetch RFOs that miss t=
he L3 with a snoop miss response.",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "tbd Offcore response can be programmed only =
with a specific pair of event select and counter MSR, and with specific eve=
nt codes and predefine mask bit value in a dedicated MSR to specify attribu=
tes of the offcore transaction.",
+        "PublicDescription": "Counts all demand & prefetch RFOs",
         "EventCode": "0xB7, 0xBB",
-        "MSRValue": "0x043c000122 ",
+        "MSRValue": "0x043C000122",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
+        "MSRIndex": "0x1a6, 0x1a7",
         "SampleAfterValue": "100003",
-        "BriefDescription": "ALL_RFO & L3_MISS & SNOOP_HIT_NO_FWD",
+        "BriefDescription": "Counts all demand & prefetch RFOs",
         "Offcore": "1",
         "CounterHTOff": "0,1,2,3"
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/tools=
/perf/pmu-events/arch/x86/broadwell/pipeline.json
index 999cf3066363..bb25574b8d21 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
@@ -1,7 +1,6 @@
 [
     {
         "PublicDescription": "This event counts the number of instructions=
 retired from execution. For instructions that consist of multiple micro-op=
s, this event counts the retirement of the last micro-op of the instruction=
. Counting continues during hardware interrupts, traps, and inside interrup=
t handlers. \nNotes: INST_RETIRED.ANY is counted by a designated fixed coun=
ter, leaving the four (eight when Hyperthreading is disabled) programmable =
counters available for other events. INST_RETIRED.ANY_P is counted by a pro=
grammable counter and it is an architectural performance event. \nCounting:=
 Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as ret=
ired instructions.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 0",
         "UMask": "0x1",
         "EventName": "INST_RETIRED.ANY",
@@ -11,7 +10,6 @@
     },
     {
         "PublicDescription": "This event counts the number of core cycles =
while the thread is not in a halt state. The thread enters the halt state w=
hen it is running the HLT instruction. This event is a component in many ke=
y event ratios. The core frequency may change from time to time due to tran=
sitions associated with Enhanced Intel SpeedStep Technology or TM2. For thi=
s reason this event may have a changing ratio with regards to time. When th=
e core frequency is constant, this event can approximate elapsed time while=
 the core was not in the halt state. It is counted on a dedicated fixed cou=
nter, leaving the four (eight when Hyperthreading is disabled) programmable=
 counters available for other events.",
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
         "PublicDescription": "This event counts the number of reference cy=
cles when the core is not in a halt state. The core enters the halt state w=
hen it is running the HLT instruction or the MWAIT instruction. This event =
is not affected by core frequency changes (for example, P states, TM2 trans=
itions) but has the same incrementing frequency as the time stamp counter. =
This event can approximate elapsed time while the core was not in a halt st=
ate. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK eve=
nt. It is counted on a dedicated fixed counter, leaving the four (eight whe=
n Hyperthreading is disabled) programmable counters available for other eve=
nts. \nNote: On all current platforms this event stops counting during 'thr=
ottling (TM)' states duty off periods the processor is 'halted'.  This even=
t is clocked by base clock (100 Mhz) on Sandy Bridge. The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
-        "EventCode": "0x00",
         "Counter": "Fixed counter 2",
         "UMask": "0x3",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
@@ -317,7 +313,7 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts stalls occurred due to cha=
nging prefix length (66, 67 or REX.W when they change the length of the dec=
oded instruction). Occurrences counting is proportional to the number of pr=
efixes in a 16B-line. This may result in the following penalties: three-cyc=
le penalty for each LCP in a 16-byte chunk.",
+        "PublicDescription": "This event counts stalls occured due to chan=
ging prefix length (66, 67 or REX.W when they change the length of the deco=
ded instruction). Occurrences counting is proportional to the number of pre=
fixes in a 16B-line. This may result in the following penalties: three-cycl=
e penalty for each LCP in a 16-byte chunk.",
         "EventCode": "0x87",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
@@ -786,8 +782,8 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts resource-related stall cyc=
les. Reasons for stalls can be as follows:\n - *any* u-arch structure got f=
ull (LB, SB, RS, ROB, BOB, LM, Physical Register Reclaim Table (PRRT), or P=
hysical History Table (PHT) slots)\n - *any* u-arch structure got empty (li=
ke INT/SIMD FreeLists)\n - FPU control word (FPCW), MXCSR\nand others. This=
 counts cycles that the pipeline backend blocked uop delivery from the fron=
t end.",
-        "EventCode": "0xA2",
+        "PublicDescription": "This event counts resource-related stall cyc=
les.",
+        "EventCode": "0xa2",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "RESOURCE_STALLS.ANY",
@@ -973,6 +969,7 @@
         "CounterHTOff": "2"
     },
     {
+        "PublicDescription": "Number of Uops delivered by the LSD.",
         "EventCode": "0xA8",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
@@ -1147,7 +1144,8 @@
         "CounterHTOff": "1"
     },
     {
-        "PublicDescription": "This event counts FP operations retired. For=
 X87 FP operations that have no exceptions counting also includes flows tha=
t have several X87, or flows that use X87 uops in the exception handling.",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts FP operations retired. For X87 FP operations th=
at have no exceptions counting also includes flows that have several X87, o=
r flows that use X87 uops in the exception handling.",
         "EventCode": "0xC0",
         "Counter": "0,1,2,3",
         "UMask": "0x2",
@@ -1157,12 +1155,12 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
+        "PEBS": "1",
         "EventCode": "0xC1",
         "Counter": "0,1,2,3",
         "UMask": "0x40",
         "EventName": "OTHER_ASSISTS.ANY_WB_ASSIST",
         "SampleAfterValue": "100003",
-        "BriefDescription": "Number of times any microcode assist is invok=
ed by HW upon uop writeback.",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -1178,26 +1176,28 @@
         "Data_LA": "1"
     },
     {
-        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts cycles without actually retired uops.",
         "EventCode": "0xC2",
         "Invert": "1",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "UOPS_RETIRED.STALL_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles without actually retired uops.",
+        "BriefDescription": "Cycles no executable uops retired (Precise Ev=
ent)",
         "CounterMask": "1",
         "CounterHTOff": "0,1,2,3"
     },
     {
-        "PublicDescription": "Number of cycles using always true condition=
 (uops_ret < 16) applied to non PEBS uops retired event.",
+        "PEBS": "1",
+        "PublicDescription": "Number of cycles using always true condition=
 (uops_ret < 16) applied to  PEBS uops retired event.",
         "EventCode": "0xC2",
         "Invert": "1",
         "Counter": "0,1,2,3",
         "UMask": "0x1",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
         "SampleAfterValue": "2000003",
-        "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
+        "BriefDescription": "Number of cycles using always true condition =
applied to  PEBS uops retired event.",
         "CounterMask": "10",
         "CounterHTOff": "0,1,2,3"
     },
@@ -1320,13 +1320,14 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts not taken branch instructi=
ons retired.",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts not taken branch instructions retired.",
         "EventCode": "0xC4",
         "Counter": "0,1,2,3",
         "UMask": "0x10",
         "EventName": "BR_INST_RETIRED.NOT_TAKEN",
         "SampleAfterValue": "400009",
-        "BriefDescription": "Not taken branch instructions retired.",
+        "BriefDescription": "Counts all not taken macro branch instruction=
s retired. (Precise Event)",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
@@ -1341,14 +1342,15 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
-        "PublicDescription": "This event counts far branch instructions re=
tired.",
+        "PEBS": "1",
+        "PublicDescription": "This is a precise version (that is, uses PEB=
S) of the event that counts far branch instructions retired.",
         "EventCode": "0xC4",
         "Counter": "0,1,2,3",
         "UMask": "0x40",
         "Errata": "BDW98",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "SampleAfterValue": "100007",
-        "BriefDescription": "Far branch instructions retired.",
+        "BriefDescription": "Counts the number of far branch instructions =
retired.(Precise Event)",
         "CounterHTOff": "0,1,2,3,4,5,6,7"
     },
     {
--=20
2.20.1

