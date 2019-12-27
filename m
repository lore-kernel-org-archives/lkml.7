Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E87C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2AE24654
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="xQr3mEcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfL0NFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:05:37 -0500
Received: from ms11p00im-qufo17281801.me.com ([17.58.38.55]:49968 "EHLO
        ms11p00im-qufo17281801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfL0NFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 08:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1577451362; bh=yxn7IiWLAHYLpEeOk7071BF3qmIMeq7GlwM6MgZKVAM=;
        h=From:To:Subject:Date:Message-Id;
        b=xQr3mEcDX2LTTN4nMRqZeJ/CFKVJYkWvliGjUDSPfWDDAD8Ovvx0PqRGUslCB3lTt
         M/LFq1y0meLJTGCqR6RK/TBsY2eJygdS0M5QuZDSJ9tvRnCGegVbwi/qOrwgP/KrYi
         EwkmU9BCmKyWobtWPrvK7X9efL0JAyWa3mpAihVW9YiprB9TGxWiJR7yVKo9uYyrgK
         n3RGNPrdtvi23KUtaHJpWWyda27oGRBGhh/0ml6NGtArWUZA0OTAGQCDkkGrBWa5HY
         wOh94J0cb6KNBonS/Gh0+iCqVn1R/GkOQWjkdHH5Xbbtb23iqqFlgd4UjXnj7pHNBJ
         FirgE8gQhBVsg==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by ms11p00im-qufo17281801.me.com (Postfix) with ESMTPSA id E612D1007B9;
        Fri, 27 Dec 2019 12:56:01 +0000 (UTC)
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Vijay Thakkar <vijaythakkar@me.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf vendor events amd: update Zen1 events to V2
Date:   Fri, 27 Dec 2019 07:55:36 -0500
Message-Id: <20191227125536.1091387-4-vijaythakkar@me.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191227125536.1091387-1-vijaythakkar@me.com>
References: <20191227125536.1091387-1-vijaythakkar@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912270111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the PMCs for AMD Zen1 core based processors (Family
17h; Models 01, 08, 10 and 18) to be in accordance with PMCs as
documented in the latest versions of the AMD Processor Programming
Reference [1] and [2].

PMCs added:
fpu_pipe_assignment.dual{0|1|2|3}
fpu_pipe_assignment.total{0|1|2|3}
ls_mab_alloc.dc_prefetcher
ls_mab_alloc.stores
ls_mab_alloc.loads

PMC removed:
ex_ret_cond_misp

Cumulative counts, fpu_pipe_assignment.total and
fpu_pipe_assignment.dual, existed in v1, but did expose port-level
counters.

ex_ret_cond_misp has been removed as it has been removed from the latest
versions of the PPR, and when tested, always seems to sample zero as
tested on a Ryzen 3400G system.

[1]: Processor Programming Reference (PPR) for AMD Family 17h Models
01h,08h, Revision B2 Processors, 54945 Rev 3.03 - Jun 14, 2019.
[2]: Processor Programming Reference (PPR) for AMD Family 17h Model 18h,
Revision B1 Processors, 55570-B1 Rev 3.14 - Sep 26, 2019.

Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
---
 .../pmu-events/arch/x86/amdzen1/core.json     |  5 --
 .../arch/x86/amdzen1/floating-point.json      | 56 +++++++++++++++++++
 .../pmu-events/arch/x86/amdzen1/memory.json   | 18 ++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
index 1079544eeed5..38994fb4b625 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/core.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
@@ -90,11 +90,6 @@
     "EventCode": "0xd1",
     "BriefDescription": "Retired Conditional Branch Instructions."
   },
-  {
-    "EventName": "ex_ret_cond_misp",
-    "EventCode": "0xd2",
-    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
-  },
   {
     "EventName": "ex_div_busy",
     "EventCode": "0xd3",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
index ea4711983d1d..878c1adcf91c 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
@@ -6,6 +6,34 @@
     "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
     "UMask": "0xf0"
   },
+  {
+    "EventName": "fpu_pipe_assignment.dual3",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 3.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual2",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 2.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual1",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 1.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.dual0",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number multi-pipe uOps to pipe 0.",
+    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
+    "UMask": "0x1"
+  },
   {
     "EventName": "fpu_pipe_assignment.total",
     "EventCode": "0x00",
@@ -13,6 +41,34 @@
     "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to Pipe 3.",
     "UMask": "0xf"
   },
+  {
+    "EventName": "fpu_pipe_assignment.total3",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 3.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total2",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 2.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total1",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps on pipe 1.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total0",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps  on pipe 0.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0x1"
+  },
   {
     "EventName": "fp_sched_empty",
     "EventCode": "0x01",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/memory.json b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
index fa2d60d4def0..def2acf3c8d9 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
@@ -37,6 +37,24 @@
     "EventCode": "0x40",
     "BriefDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
   },
+  {
+    "EventName": "ls_mab_alloc.dc_prefetcher",
+    "EventCode": "0x41",
+    "BriefDescription": "Data cache prefetcher miss.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_mab_alloc.stores",
+    "EventCode": "0x41",
+    "BriefDescription": "Data cache store miss.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_mab_alloc.loads",
+    "EventCode": "0x41",
+    "BriefDescription": "Data cache load miss.",
+    "UMask": "0x40"
+  },
   {
     "EventName": "ls_l1_d_tlb_miss.all",
     "EventCode": "0x45",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 82b573956e96..54a8dbdd2fe4 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -36,6 +36,6 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
-AuthenticAMD-23-[01][18],v1,amdzen1,core
+AuthenticAMD-23-[01][18],v2,amdzen1,core
 AuthenticAMD-23-[37]1,v1,amdzen2,core
 AuthenticAMD-23-2[0123456789ABCDEF],v1,amdzen2,core
-- 
2.24.1

