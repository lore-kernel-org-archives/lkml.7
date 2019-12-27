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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E7C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B36020882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="XXqLAGLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfL0NFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:05:40 -0500
Received: from ms11p00im-qufo17281801.me.com ([17.58.38.55]:49983 "EHLO
        ms11p00im-qufo17281801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbfL0NFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 08:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1577451353; bh=GEfg/R028FoKd/fMVS6+OMIo8IRjS9mK213u8AtFPuU=;
        h=From:To:Subject:Date:Message-Id;
        b=XXqLAGLqrk4YwcCKwTZcEg5nBTy0FGyQa7S3NaFvxwSGLt5JpQeSGsvlScN/sQYTy
         uYndeZ8NLnliPPhCiHiBQRn0oECD3PDB1SdFSzh7sbQAr1tPsDsbGq7Me/nMbdby9Y
         k1jOuOwRk78MsK+4MpBPOy9gLlSspa7NGVkNi/fiBHTqDqDVxjK46X/fr0YP+aOwR6
         i2VhH+Bh4C+iA1oPqAplFLd87sW/y3vkWCtV5KRbR1X/aNZfNZoDvNULWkzhlDtcxQ
         UOY7D55xah/KoeRsuVT5b2dtcKbrEbNdjPoCvL3GEgO5QXECTHzwQeRoEm85kUXVc8
         pWCVS8IJy2AkQ==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by ms11p00im-qufo17281801.me.com (Postfix) with ESMTPSA id 66E0D10078E;
        Fri, 27 Dec 2019 12:55:52 +0000 (UTC)
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
Subject: [PATCH 2/3] perf vendor events amd: add Zen2 events
Date:   Fri, 27 Dec 2019 07:55:35 -0500
Message-Id: <20191227125536.1091387-3-vijaythakkar@me.com>
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

This patch adds PMU events for AMD Zen2 core based processors, namely,
Matisse (model 71h), Castle Peak (model 31h) and Rome (model 2xh), as
documented in the AMD Processor Programming Reference for Matisse [1].
Zen2 adds some additional counters that are not present in Zen1 and
events for them have been added in this patch. Some counters have also
been removed for Zen2 thatwere previously present in Zen1 and have been
confirmed to always sample zero on zen2. These added/removed counters
have been omitted for brevity.

Note that PPR for Zen2 [1] does not include some counters that were
documented in the PPR for Zen1 based processors [2]. After having tested
these counters, some of them that still work for zen2 systems have been
preserved in the events for zen2. The counters that are omitted in [1]
but are still measurable and non-zero on zen2 (tested on a Ryzen 3900X
system) are the following:

PMC 0x000 fpu_pipe_assignment.{total|total0|total1|total2|total3}
PMC 0x004 fp_num_mov_elim_scal_op.*
PMC 0x046 ls_tablewalker.*
PMC 0x062 l2_latency.l2_cycles_waiting_on_fills
PMC 0x063 l2_wcb_req.*
PMC 0x06D l2_fill_pending.l2_fill_busy
PMC 0x080 ic_fw32
PMC 0x081 ic_fw32_miss
PMC 0x086 bp_snp_re_sync
PMC 0x087 ic_fetch_stall.*
PMC 0x08C ic_cache_inval.*
PMC 0x099 bp_tlb_rel
PMC 0x0C7 ex_ret_brn_resync
PMC 0x28A ic_oc_mode_switch.*
L3PMC 0x001 l3_request_g1.*
L3PMC 0x006 l3_comb_clstr_state.*

[1]: Processor Programming Reference (PPR) for AMD Family 17h Model 71h,
Revision B0 Processors, 56176 Rev 3.06 - Jul 17, 2019
[2]: Processor Programming Reference (PPR) for AMD Family 17h Models
01h,08h, Revision B2 Processors, 54945 Rev 3.03 - Jun 14, 2019

Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
---
 .../pmu-events/arch/x86/amdzen2/branch.json   |  56 +++
 .../pmu-events/arch/x86/amdzen2/cache.json    | 375 ++++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/core.json     | 134 +++++++
 .../arch/x86/amdzen2/floating-point.json      | 128 ++++++
 .../pmu-events/arch/x86/amdzen2/memory.json   | 349 ++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/other.json    | 137 +++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +
 7 files changed, 1181 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/branch.json b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
new file mode 100644
index 000000000000..c1c1b856504d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
@@ -0,0 +1,56 @@
+[
+  {
+    "EventName": "bp_l1_btb_correct",
+    "EventCode": "0x8a",
+    "BriefDescription": "L1 BTB Correction."
+  },
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 BTB Correction."
+  },
+  {
+    "EventName": "bp_dyn_ind_pred",
+    "EventCode": "0x8e",
+    "BriefDescription": "Dynamic Indirect Predictions.",
+    "PublicDescription": "Indirect Branch Prediction for potential multi-target branch (speculative)."
+  },
+  {
+    "EventName": "bp_de_redirect",
+    "EventCode": "0x91",
+    "BriefDescription": "Decoder Overrides Existing Branch Prediction (speculative)."
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit",
+    "EventCode": "0x94",
+    "BriefDescription": "All instruction fetches.",
+    "PublicDescription": "The number of instruction fetches that hit in the L1 ITLB.",
+    "UMask": "0xFF"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if1g",
+    "EventCode": "0x94",
+    "BriefDescription": "Instuction fetches to a 1GB page.",
+    "PublicDescription": "The number of instruction fetches that hit in the L1 ITLB.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if2m",
+    "EventCode": "0x94",
+    "BriefDescription": "Instuction fetches to a 2MB page.",
+    "PublicDescription": "The number of instruction fetches that hit in the L1 ITLB.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if4k",
+    "EventCode": "0x94",
+    "BriefDescription": "Instuction fetches to a 4KB page.",
+    "PublicDescription": "The number of instruction fetches that hit in the L1 ITLB.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "bp_tlb_rel",
+    "EventCode": "0x99",
+    "BriefDescription": "The number of ITLB reload requests."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
new file mode 100644
index 000000000000..aee22537b711
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
@@ -0,0 +1,375 @@
+[
+  {
+    "EventName": "l2_request_g1.rd_blk_l",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_x",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g1.ls_rd_blk_c_s",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g1.cacheable_ic_read",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g1.change_to_x",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_request_g1.prefetch_l2",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_request_g1.l2_hw_pf",
+    "EventCode": "0x60",
+    "BriefDescription": "Requests to L2 Group1.",
+    "PublicDescription": "Requests to L2 Group1.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_request_g1.other_requests",
+    "EventCode": "0x60",
+    "BriefDescription": "Events covered by l2_request_g2.",
+    "PublicDescription": "Requests to L2 Group1. Events covered by l2_request_g2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_request_g2.group1",
+    "EventCode": "0x61",
+    "BriefDescription": "All Group 1 commands not in unit0.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. All Group 1 commands not in unit0.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "RdSized, RdSized32, RdSized64.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSized, RdSized32, RdSized64.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "RdSizedNC, RdSized32NC, RdSized64NC.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSizedNC, RdSized32NC, RdSized64NC.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_request_g2.smc_inval",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_originator",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_responses",
+    "EventCode": "0x61",
+    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_latency.l2_cycles_waiting_on_fills",
+    "EventCode": "0x62",
+    "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
+    "PublicDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_write",
+    "EventCode": "0x63",
+    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) write requests.",
+    "BriefDescription": "LS to L2 WCB write requests.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_close",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB close requests.",
+    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) close requests.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_wcb_req.zero_byte_store",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB zero byte store requests.",
+    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_wcb_req.cl_zero",
+    "EventCode": "0x63",
+    "PublicDescription": "LS to L2 WCB cache line zeroing requests.",
+    "BriefDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
+    "EventCode": "0x64",
+    "BriefDescription": "LS ReadBlock C/S Hit.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS ReadBlock C/S Hit.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "LS Read Block L Hit X.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block L Hit X.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "LsRdBlkL Hit Shared.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkL Hit Shared.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
+    "EventCode": "0x64",
+    "BriefDescription": "LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
+    "EventCode": "0x64",
+    "BriefDescription": "LS Read Block C S L X Change to X Miss.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block C S L X Change to X Miss.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "IC Fill Hit Exclusive Stale.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Exclusive Stale.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "IC Fill Hit Shared.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Shared.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "IC Fill Miss.",
+    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Miss.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_fill_pending.l2_fill_busy",
+    "EventCode": "0x6d",
+    "BriefDescription": "Total cycles spent with one or more fill requests in flight from L2.",
+    "PublicDescription": "Total cycles spent with one or more fill requests in flight from L2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_pf_hit_l2",
+    "EventCode": "0x70",
+    "BriefDescription": "All L2 prefetches accepted by the L2 pipeline which hit the L2."
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3",
+    "EventCode": "0x71",
+    "BriefDescription": "All L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit the L3."
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3",
+    "EventCode": "0x72",
+    "BriefDescription": "All L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches."
+  },
+  {
+    "EventName": "ic_fw32",
+    "EventCode": "0x80",
+    "BriefDescription": "The number of 32B fetch windows transferred from IC pipe to DE instruction decoder (includes non-cacheable and cacheable fill responses)."
+  },
+  {
+    "EventName": "ic_fw32_miss",
+    "EventCode": "0x81",
+    "BriefDescription": "The number of 32B fetch windows tried to read the L1 IC and missed in the full tag."
+  },
+  {
+    "EventName": "ic_cache_fill_l2",
+    "EventCode": "0x82",
+    "BriefDescription": "The number of 64 byte instruction cache line was fulfilled from the L2 cache."
+  },
+  {
+    "EventName": "ic_cache_fill_sys",
+    "EventCode": "0x83",
+    "BriefDescription": "The number of 64 byte instruction cache line fulfilled from system memory or another cache."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_hit",
+    "EventCode": "0x84",
+    "BriefDescription": "The number of instruction fetches that miss in the L1 ITLB but hit in the L2 ITLB."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if1g",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches to a 1GB page.",
+    "PublicDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if2m",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches to a 2MB page.",
+    "PublicDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if4k",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches to a 4KB page.",
+    "PublicDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "bp_snp_re_sync",
+    "EventCode": "0x86",
+    "BriefDescription": "The number of pipeline restarts caused by invalidating probes that hit on the instruction stream currently being executed. This would happen if the active instruction stream was being modified by another processor in an MP system - typically a highly unlikely event."
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_any",
+    "EventCode": "0x87",
+    "BriefDescription": "IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
+    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_dq_empty",
+    "EventCode": "0x87",
+    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
+    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_back_pressure",
+    "EventCode": "0x87",
+    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
+    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ic_cache_inval.l2_invalidating_probe",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS).",
+    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to L2 invalidating probe (external or LS).",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_cache_inval.fill_invalidated",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to overwriting fill response.",
+    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to overwriting fill response.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ic_oc_mode_switch.oc_ic_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "OC to IC mode switch.",
+    "PublicDescription": "OC Mode Switch. OC to IC mode switch.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_oc_mode_switch.ic_oc_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "IC to OC mode switch.",
+    "PublicDescription": "OC Mode Switch. IC to OC mode switch.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l3_request_g1.caching_l3_cache_accesses",
+    "EventCode": "0x01",
+    "BriefDescription": "Caching: L3 cache accesses",
+    "UMask": "0x80",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.all_l3_req_typs",
+    "EventCode": "0x04",
+    "BriefDescription": "All L3 Request Types",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.other_l3_miss_typs",
+    "EventCode": "0x06",
+    "BriefDescription": "Other L3 Miss Request Types",
+    "UMask": "0xfe",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.request_miss",
+    "EventCode": "0x06",
+    "BriefDescription": "L3 cache misses",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_sys_fill_latency",
+    "EventCode": "0x90",
+    "BriefDescription": "L3 Cache Miss Latency. Total cycles for all transactions divided by 16. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x00",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_ccx_sdp_req1.all_l3_miss_req_typs",
+    "EventCode": "0x9A",
+    "BriefDescription": "All L3 Miss Request Types. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x3f",
+    "Unit": "L3PMC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/core.json b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
new file mode 100644
index 000000000000..1079544eeed5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
@@ -0,0 +1,134 @@
+[
+  {
+    "EventName": "ex_ret_instr",
+    "EventCode": "0xc0",
+    "BriefDescription": "Retired Instructions."
+  },
+  {
+    "EventName": "ex_ret_cops",
+    "EventCode": "0xc1",
+    "BriefDescription": "Retired Uops.",
+    "PublicDescription": "The number of uOps retired. This includes all processor activity (instructions, exceptions, interrupts, microcode assists, etc.). The number of events logged per cycle can vary from 0 to 4."
+  },
+  {
+    "EventName": "ex_ret_brn",
+    "EventCode": "0xc2",
+    "BriefDescription": "Retired Branch Instructions.",
+    "PublicDescription": "The number of branch instructions retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_misp",
+    "EventCode": "0xc3",
+    "BriefDescription": "Retired Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of branch instructions retired, of any type, that were not correctly predicted. This includes those for which prediction is not attempted (far control transfers, exceptions and interrupts)."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn",
+    "EventCode": "0xc4",
+    "BriefDescription": "Retired Taken Branch Instructions.",
+    "PublicDescription": "The number of taken branches that were retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn_misp",
+    "EventCode": "0xc5",
+    "BriefDescription": "Retired Taken Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of retired taken branch instructions that were mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_far",
+    "EventCode": "0xc6",
+    "BriefDescription": "Retired Far Control Transfers.",
+    "PublicDescription": "The number of far control transfers retired including far call/jump/return, IRET, SYSCALL and SYSRET, plus exceptions and interrupts. Far control transfers are not subject to branch prediction."
+  },
+  {
+    "EventName": "ex_ret_brn_resync",
+    "EventCode": "0xc7",
+    "BriefDescription": "Retired Branch Resyncs.",
+    "PublicDescription": "The number of resync branches. These reflect pipeline restarts due to certain microcode assists and events such as writes to the active instruction stream, among other things. Each occurrence reflects a restart penalty similar to a branch mispredict. This is relatively rare."
+  },
+  {
+    "EventName": "ex_ret_near_ret",
+    "EventCode": "0xc8",
+    "BriefDescription": "Retired Near Returns.",
+    "PublicDescription": "The number of near return instructions (RET or RET Iw) retired."
+  },
+  {
+    "EventName": "ex_ret_near_ret_mispred",
+    "EventCode": "0xc9",
+    "BriefDescription": "Retired Near Returns Mispredicted.",
+    "PublicDescription": "The number of near returns retired that were not correctly predicted by the return address predictor. Each such mispredict incurs the same penalty as a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_brn_ind_misp",
+    "EventCode": "0xca",
+    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted.",
+    "PublicDescription": "Retired Indirect Branch Instructions Mispredicted."
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.sse_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.mmx_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "MMX instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. MMX instructions.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.x87_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "x87 instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. x87 instructions.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ex_ret_cond",
+    "EventCode": "0xd1",
+    "BriefDescription": "Retired Conditional Branch Instructions."
+  },
+  {
+    "EventName": "ex_ret_cond_misp",
+    "EventCode": "0xd2",
+    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
+  },
+  {
+    "EventName": "ex_div_busy",
+    "EventCode": "0xd3",
+    "BriefDescription": "Div Cycles Busy count."
+  },
+  {
+    "EventName": "ex_div_count",
+    "EventCode": "0xd4",
+    "BriefDescription": "Div Op Count."
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
+    "PublicDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Number of Ops tagged by IBS that retired.",
+    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Number of Ops tagged by IBS.",
+    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ex_ret_fus_brnch_inst",
+    "EventCode": "0x1d0",
+    "BriefDescription": "The number of fused retired branch instructions retired per cycle. The number of events logged per cycle can vary from 0 to 3."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
new file mode 100644
index 000000000000..df530b398f9d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
@@ -0,0 +1,128 @@
+[
+  {
+    "EventName": "fpu_pipe_assignment.total",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0xf"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.all",
+    "EventCode": "0x03",
+    "BriefDescription": "All FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mult_add_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Single precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.div_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Divide/square root FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision divide/square root FLOPS.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mult_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Multiply FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision multiply FLOPS.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.add_sub_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Add/subtract FLOPS.",
+    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision add/subtract FLOPS.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.optimized",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Scalar Ops optimized.",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Scalar Ops optimized.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.opt_potential",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops_elim",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops eliminated.",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops eliminated.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops.",
+    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "SSE bottom-executing uOps retired.",
+    "PublicDescription": "The number of serializing Ops retired. SSE bottom-executing uOps retired.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
+    "PublicDescription": "The number of serializing Ops retired. SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 bottom-executing uOps retired.",
+    "PublicDescription": "The number of serializing Ops retired. x87 bottom-executing uOps retired.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
+    "PublicDescription": "The number of serializing Ops retired. x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_spill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "YMM spill fault.",
+    "PublicDescription": "Floating Point Dispatch Faults.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "YMM fill fault.",
+    "PublicDescription": "Floating Point Dispatch Faults.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_disp_faults.xmm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "XMM fill fault.",
+    "PublicDescription": "Floating Point Dispatch Faults.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_disp_faults.x87_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "x87 fill fault.",
+    "PublicDescription": "Floating Point Dispatch Faults.",
+    "UMask": "0x1"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/memory.json b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
new file mode 100644
index 000000000000..932fe8080f50
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
@@ -0,0 +1,349 @@
+[
+  {
+    "EventName": "ls_bad_status2.stli_other",
+    "EventCode": "0x24",
+    "BriefDescription": "Non-forwardable conflict; used to reduce STLI's via software. All reasons.",
+    "PublicDescription": "Store To Load Interlock (STLI) are loads that were unable to complete because of a possible match with an older store, and the older store could not do STLF for some reason. There are a number of reasons why this occurs, and this perfmon organizes them into three major groups. ",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_locks.spec_lock_hi_spec",
+    "EventCode": "0x25",
+    "BriefDescription": "High speculative cacheable lock speculation succeeded.",
+    "PublicDescription": "Retired lock instructions.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_locks.spec_lock_lo_spec",
+    "EventCode": "0x25",
+    "BriefDescription": "Low speculative cacheable lock speculation succeeded.",
+    "PublicDescription": "Retired lock instructions.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_locks.non_spec_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Non-speculative lock succeeded.",
+    "PublicDescription": "Retired lock instructions.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_locks.bus_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Comparable to legacy bus lock.",
+    "PublicDescription": "Retired lock instructions. Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_ret_cl_flush",
+    "EventCode": "0x26",
+    "BriefDescription": "Number of retired CLFLUSH instructions."
+  },
+  {
+    "EventName": "ls_ret_cpuid",
+    "EventCode": "0x27",
+    "BriefDescription": "Number of retired CLFLUSH instructions."
+  },
+  {
+    "EventName": "ls_dispatch.ld_st_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of single ops that do load/store to an address.",
+    "PublicDescription": "Dispatch of a single op that performs a load from and store to the same memory address.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_dispatch.store_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of stores dispatched.",
+    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_dispatch.ld_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of loads dispatched.",
+    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_smi_rx",
+    "EventCode": "0x2B",
+    "BriefDescription": "Number of SMIs received."
+  },
+  {
+    "EventName": "ls_int_taken",
+    "EventCode": "0x2C",
+    "BriefDescription": "Number of interrupts taken."
+  },
+  {
+    "EventName": "ls_rdtsc",
+    "EventCode": "0x2D",
+    "BriefDescription": "Number of reads of the TSC (RDTSC instructions). The count is speculative."
+  },
+  {
+    "EventName": "ls_stlf",
+    "EventCode": "0x35",
+    "BriefDescription": "Number of STLF hits."
+  },
+  {
+    "EventName": "ls_st_commit_cancel2.st_commit_cancel_wcb_full",
+    "EventCode": "0x37",
+    "BriefDescription": "A non-cacheable store and the non-cacheable commit buffer is full."
+  },
+  {
+    "EventName": "ls_dc_accesses",
+    "EventCode": "0x40",
+    "BriefDescription": "Number of accesses to the dcache for load/store references.",
+    "PublicDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
+  },
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
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_dram",
+    "EventCode": "0x43",
+    "BriefDescription": "DRAM or IO from different die.",
+    "PublicDescription": "Demand Data Cache Fills by Data Source.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Hit in cache; Remote CCX and the address's Home Node is on a different die.",
+    "PublicDescription": "Demand Data Cache Fills by Data Source.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_dram",
+    "EventCode": "0x43",
+    "BriefDescription": "DRAM or IO from this thread's die.",
+    "PublicDescription": "Demand Data Cache Fills by Data Source.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
+    "PublicDescription": "Demand Data Cache Fills by Data Source.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_l2",
+    "EventCode": "0x43",
+    "BriefDescription": "Local L2 hit.",
+    "PublicDescription": "Demand Data Cache Fills by Data Source.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.all",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss or Reload off all sizes.",
+    "PublicDescription": "L1 DTLB Miss or Reload off all sizes.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 1G size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 1G size.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 2M size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 2M size.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 32K size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 32K size.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss of a page of 4K size.",
+    "PublicDescription": "L1 DTLB Miss of a page of 4K size.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 1G size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 1G size.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 2M size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 2M size.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 32K size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 32K size.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Reload of a page of 4K size.",
+    "PublicDescription": "L1 DTLB Reload of a page of 4K size.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_iside",
+    "EventCode": "0x46",
+    "BriefDescription": "Tablewalker allocation.",
+    "PublicDescription": "Tablewalker allocation.",
+    "UMask": "0xc"
+  },
+  {
+    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_dside",
+    "EventCode": "0x46",
+    "BriefDescription": "Tablewalker allocation.",
+    "PublicDescription": "Tablewalker allocation.",
+    "UMask": "0x3"
+  },
+  {
+    "EventName": "ls_misal_accesses",
+    "EventCode": "0x47",
+    "BriefDescription": "Misaligned loads."
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_nta",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
+    "PublicDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.store_prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
+    "PublicDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.load_prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Prefetch, Prefetch_T0_T1_T2.",
+    "PublicDescription": "Software Prefetch Instructions Dispatched. Prefetch, Prefetch_T0_T1_T2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.mab_mch_cnt",
+    "EventCode": "0x52",
+    "BriefDescription": "Software PREFETCH instruction saw a match on an already-allocated miss request buffer.",
+    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
+    "EventCode": "0x52",
+    "BriefDescription": "Software PREFETCH instruction saw a DC hit.",
+    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_rmt_dram",
+    "EventCode": "0x59",
+    "BriefDescription": "DRAM or IO from different die.",
+    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_rmt_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Hit in cache; Remote CCX and the address's Home Node is on a different die.",
+    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_dram",
+    "EventCode": "0x59",
+    "BriefDescription": "DRAM or IO from this thread's die.",
+    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
+    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_l2",
+    "EventCode": "0x59",
+    "BriefDescription": "Local L2 hit.",
+    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram",
+    "EventCode": "0x5A",
+    "BriefDescription": "DRAM or IO from different die.",
+    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hit in cache; Remote CCX and the address's Home Node is on a different die.",
+    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram",
+    "EventCode": "0x5A",
+    "BriefDescription": "DRAM or IO from this thread's die.",
+    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
+    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2",
+    "EventCode": "0x5A",
+    "BriefDescription": "Local L2 hit.",
+    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_not_halted_cyc",
+    "EventCode": "0x76",
+    "BriefDescription": "Cycles not in Halt."
+  },
+  {
+    "EventName": "ls_tlb_flush",
+    "EventCode": "0x78",
+    "BriefDescription": "All TLB Flushes"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/other.json b/tools/perf/pmu-events/arch/x86/amdzen2/other.json
new file mode 100644
index 000000000000..5d2b53a7465d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/other.json
@@ -0,0 +1,137 @@
+[
+  {
+    "EventName": "de_dis_uop_queue_empty_di0",
+    "EventCode": "0xa9",
+    "BriefDescription": "Cycles where the Micro-Op Queue is empty."
+  },
+  {
+    "EventName": "de_dis_uops_from_decoder",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from either the decoders, OpCache or both.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "de_dis_uops_from_decoder.opcache_dispatched",
+    "EventCode": "0xaa",
+    "BriefDescription": "Count of dispatched Ops from OpCache.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "de_dis_uops_from_decoder.decoder_dispatched",
+    "EventCode": "0xaa",
+    "BriefDescription": "Count of dispatched Ops from Decoder.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_misc_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "FP Miscellaneous resource unavailable",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_sch_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "FP scheduler resource stall.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_reg_file_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Floating point register file resource stall.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.taken_branch_buffer_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.int_sched_misc_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Integer Scheduler miscellaneous resource stall.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.store_queue_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Store queue resource stall.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.load_queue_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Load queue resource stall.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.int_phy_reg_file_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Integer Physical Register File resource stall.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.sc_agu_dispatch_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "SC AGU dispatch stall.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.retire_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "RETIRE Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.agsq_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "AGSQ Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. AGSQ Tokens unavailable.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alu_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALU tokens total unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALU tokens total unavailable.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq3_0_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq3_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALSQ 3 Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 3 Tokens unavailable.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq2_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALSQ 2 Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 2 Tokens unavailable.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq1_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "ALSQ 1 Tokens unavailable.",
+    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 1 Tokens unavailable.",
+    "UMask": "0x1"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index cb1454017557..82b573956e96 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -37,3 +37,5 @@ GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-[01][18],v1,amdzen1,core
+AuthenticAMD-23-[37]1,v1,amdzen2,core
+AuthenticAMD-23-2[0123456789ABCDEF],v1,amdzen2,core
-- 
2.24.1

