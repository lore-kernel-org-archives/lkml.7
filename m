Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53661C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203B022DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566329312;
	bh=+99t8uWPpHsa73f0qFGS//ICn30kmzPeiJkhqv+rac0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1wmlbsAvj45oaebrDqcSmnMLpE6UVZv1PkjOPSNpT10SL4LbbR8HmtyC3Y4zgFrjF
	 kZJcLGjUo8A7AiXvW9Iy821G5yQ8Y4lP+cuSVVBKhU4DCM60N2Tnt/wVfGzdS5pnlJ
	 Uwn6C6Ipitowd1o7TwaLOsO+4EuJvtChrIVKgJ3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfHTT2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730847AbfHTT23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:29 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6BA0233A0;
        Tue, 20 Aug 2019 19:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329309;
        bh=+99t8uWPpHsa73f0qFGS//ICn30kmzPeiJkhqv+rac0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9Io0IyTRLo0REatzoM6GlB16Zlth1r3cc0Ir3IKqwGknBbg7N36lImDD2kXkAlwX
         XOwYxz+E+ACGtuYukuMGY/TE264KXB4tZwGpkNPp6qX9pLwveODNiK1EB4pWyT8jmS
         0KeQiOxRIlA7GF7V5VzjzNWZRJDMm/Mr/wbB5/iw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 09/17] perf report: Dump LBR callstack data by -D jointly with thread stack
Date:   Tue, 20 Aug 2019 16:27:25 -0300
Message-Id: <20190820192733.19180-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

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

Committer testing:

  # perf record -g --call-graph dwarf,1024 -j stack,u ls > /dev/null
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.042 MB perf.data (10 samples) ]
  #

Before:

  # perf report -D |& grep PERF_RECORD_SAMPLE -A28 | tail -29
  67538909824483 0xa7a0 [0x560]: PERF_RECORD_SAMPLE(IP, 0x4002): 9721/9721: 0x7f441b2b1e20 period: 1376095 addr: 0
  ... FP chain: nr:0
  ... user regs: mask 0xff0fff ABI 64-bit
  .... AX    0x7f441b2b1000
  .... BX    0x7f441b55b970
  .... CX    0x7fff6e2db218
  .... DX    0x7fff6e2db218
  .... SI    0x7fff6e2db208
  .... DI    0x1
  .... BP    0x1
  .... SP    0x7fff6e2db178
  .... IP    0x7f441b2b1e20
  .... FLAGS 0x20a
  .... CS    0x33
  .... SS    0x2b
  .... R8    0x1
  .... R9    0x7f441b371c18
  .... R10   0x7f441b5a5f10
  .... R11   0x202
  .... R12   0x7fff6e2db208
  .... R13   0x7fff6e2db218
  .... R14   0x7f441b5a7150
  .... R15   0x0
  ... ustack: size 1024, offset 0x148
   . data_src: 0x5080021
   ... thread: ls:9721
   ...... dso: /usr/lib64/libpthread-2.29.so

  0xad00 [0x60]: event: 10
  #

After:

  # perf report -D |& grep PERF_RECORD_SAMPLE -A31 | tail -32
  67538909824483 0xa7a0 [0x560]: PERF_RECORD_SAMPLE(IP, 0x4002): 9721/9721: 0x7f441b2b1e20 period: 1376095 addr: 0
  ... FP chain: nr:0
  ... branch callstack: nr:4
  .....  0: 00007f441b2b1e20
  .....  1: 00007f441b58af1a
  .....  2: 00007f441b58b0e1
  .....  3: 00007f441b57c145
  ... user regs: mask 0xff0fff ABI 64-bit
  .... AX    0x7f441b2b1000
  .... BX    0x7f441b55b970
  .... CX    0x7fff6e2db218
  .... DX    0x7fff6e2db218
  .... SI    0x7fff6e2db208
  .... DI    0x1
  .... BP    0x1
  .... SP    0x7fff6e2db178
  .... IP    0x7f441b2b1e20
  .... FLAGS 0x20a
  .... CS    0x33
  .... SS    0x2b
  .... R8    0x1
  .... R9    0x7f441b371c18
  .... R10   0x7f441b5a5f10
  .... R11   0x202
  .... R12   0x7fff6e2db208
  .... R13   0x7fff6e2db218
  .... R14   0x7f441b5a7150
  .... R15   0x0
  ... ustack: size 1024, offset 0x148
   . data_src: 0x5080021
   ... thread: ls:9721
   ...... dso: /usr/lib64/libpthread-2.29.so
  #

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/aa82e5dd-def2-0ca8-a064-db9e2e8ad076@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.21.0

