Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC66C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51A02086A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407398AbfHIP0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:26:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:27708 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfHIP0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:26:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 08:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="177666378"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2019 08:26:35 -0700
Received: from [10.252.0.91] (abudanko-mobl.ccr.corp.intel.com [10.252.0.91])
        by linux.intel.com (Postfix) with ESMTP id 235B4580417;
        Fri,  9 Aug 2019 08:26:31 -0700 (PDT)
Subject: [PATCH v1 2/3] perf report: dump LBR callstack data by -D jointly
 with thread stack
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Jin, Yao" <yao.jin@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ec5fe6b1-a116-fb60-42c6-dc8a9dedfc15@linux.intel.com>
Organization: Intel Corp.
Message-ID: <aa82e5dd-def2-0ca8-a064-db9e2e8ad076@linux.intel.com>
Date:   Fri, 9 Aug 2019 18:26:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ec5fe6b1-a116-fb60-42c6-dc8a9dedfc15@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Make perf report -D command print captured LBR callstack chain when it is
collected together with raw thread stack data:

  2752673087247083 0x5d10 [0x548]: PERF_RECORD_SAMPLE(IP, 0x4002): 5841/5841: 0x40121f period: 1543862 addr: 0
  ... FP chain: nr:0
  ... branch callstack: nr:3
  .....  0: 00000000004011d0
  .....  1: 00007f393c388411
  .....  2: 0000000000401098
  ... user regs: mask 0xff0fff ABI 64-bit
  .... AX    0x34e7
  .... BX    0x7fff5f6dd3c0
  .... CX    0xffffffff
  .... DX    0x34e6
  .... SI    0x7f393c5268d0
  .... DI    0x0
  .... BP    0x401260
  .... SP    0x7fff5f6dd3c0
  .... IP    0x40121f
  .... FLAGS 0x29f
  .... CS    0x33
  .... SS    0x2b
  .... R8    0x7f393c526800
  .... R9    0x7f393c525da0
  .... R10   0xfffffffffffff70a
  .... R11   0x246
  .... R12   0x401070
  .... R13   0x7fff5f6ddcb0
  .... R14   0x0
  .... R15   0x0
  ... ustack: size 1024, offset 0x130
   . data_src: 0x5080021
   ... thread: stack_test:5841
   ...... dso: /root/abudanko/stacks/stack_test

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/session.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b9fe71d11bf6..82e0438a9160 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1051,23 +1051,30 @@ static void callchain__printf(struct evsel *evsel,
 		       i, callchain->ips[i]);
 }
 
-static void branch_stack__printf(struct perf_sample *sample)
+static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 {
 	uint64_t i;
 
-	printf("... branch stack: nr:%" PRIu64 "\n", sample->branch_stack->nr);
+	printf("%s: nr:%" PRIu64 "\n",
+		!callstack ? "... branch stack" : "... branch callstack",
+		sample->branch_stack->nr);
 
 	for (i = 0; i < sample->branch_stack->nr; i++) {
 		struct branch_entry *e = &sample->branch_stack->entries[i];
 
-		printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x\n",
-			i, e->from, e->to,
-			(unsigned short)e->flags.cycles,
-			e->flags.mispred ? "M" : " ",
-			e->flags.predicted ? "P" : " ",
-			e->flags.abort ? "A" : " ",
-			e->flags.in_tx ? "T" : " ",
-			(unsigned)e->flags.reserved);
+		if (!callstack) {
+			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x\n",
+				i, e->from, e->to,
+				(unsigned short)e->flags.cycles,
+				e->flags.mispred ? "M" : " ",
+				e->flags.predicted ? "P" : " ",
+				e->flags.abort ? "A" : " ",
+				e->flags.in_tx ? "T" : " ",
+				(unsigned)e->flags.reserved);
+		} else {
+			printf("..... %2"PRIu64": %016" PRIx64 "\n",
+				i, i > 0 ? e->from : e->to);
+		}
 	}
 }
 
@@ -1217,8 +1224,8 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 	if (evsel__has_callchain(evsel))
 		callchain__printf(evsel, sample);
 
-	if ((sample_type & PERF_SAMPLE_BRANCH_STACK) && !perf_evsel__has_branch_callstack(evsel))
-		branch_stack__printf(sample);
+	if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+		branch_stack__printf(sample, perf_evsel__has_branch_callstack(evsel));
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
 		regs_user__printf(sample);
-- 
2.20.1

