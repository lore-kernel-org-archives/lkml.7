Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF26FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9521523426
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391146AbfHWC2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:28:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33812 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390337AbfHWC2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:28:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zJC-00019x-1G; Fri, 23 Aug 2019 04:28:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 83D9C1C07E4;
        Fri, 23 Aug 2019 04:28:09 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:28:09 -0000
From:   tip-bot2 for Alexey Budankov <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report: Dump LBR callstack data by -D jointly
 with thread stack
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
In-Reply-To: <aa82e5dd-def2-0ca8-a064-db9e2e8ad076@linux.intel.com>
References: <aa82e5dd-def2-0ca8-a064-db9e2e8ad076@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156652728940.12707.17186855532932836374.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d2720c3dad58def723f9617f7cf2a48c752ef50a
Gitweb:        https://git.kernel.org/tip/d2720c3dad58def723f9617f7cf2a48c752ef50a
Author:        Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate:    Fri, 09 Aug 2019 18:26:30 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:19:44 -03:00

perf report: Dump LBR callstack data by -D jointly with thread stack

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
index b9fe71d..82e0438 100644
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
