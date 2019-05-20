Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BA1C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B00020645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbfETLh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:37:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:48121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733094AbfETLhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:37:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:37:53 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2019 04:37:52 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/22] perf script: Add output of IPC ratio
Date:   Mon, 20 May 2019 14:37:14 +0300
Message-Id: <20190520113728.14389-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520113728.14389-1-adrian.hunter@intel.com>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add field 'ipc' to display instructions-per-cycle.

Example:

 perf record -e intel_pt/cyc/u ls
 perf script --insn-trace --xed -F+ipc,-dso,-cpu,-tid

 ls  2670177.697113434:  7f0dfdbcd090 _start+0x0      mov %rsp, %rdi   IPC: 0.00 (1/877)
 ls  2670177.697113434:  7f0dfdbcd093 _start+0x3      callq  0x7f0dfdbce030
 ls  2670177.697113434:  7f0dfdbce030 _dl_start+0x0   pushq  %rbp
 ls  2670177.697113434:  7f0dfdbce031 _dl_start+0x1   mov %rsp, %rbp
 ls  2670177.697113434:  7f0dfdbce034 _dl_start+0x4   pushq  %r15
 ls  2670177.697113434:  7f0dfdbce036 _dl_start+0x6   pushq  %r14
 ls  2670177.697113434:  7f0dfdbce038 _dl_start+0x8   pushq  %r13
 ls  2670177.697113434:  7f0dfdbce03a _dl_start+0xa   pushq  %r12
 ls  2670177.697113434:  7f0dfdbce03c _dl_start+0xc   mov %rdi, %r12
 ls  2670177.697113434:  7f0dfdbce03f _dl_start+0xf   pushq  %rbx
 ls  2670177.697113434:  7f0dfdbce040 _dl_start+0x10  sub $0x38, %rsp
 ls  2670177.697113434:  7f0dfdbce044 _dl_start+0x14  rdtsc
 ls  2670177.697113434:  7f0dfdbce046 _dl_start+0x16  mov %eax, %eax
 ls  2670177.697113434:  7f0dfdbce048 _dl_start+0x18  shl $0x20, %rdx
 ls  2670177.697113434:  7f0dfdbce04c _dl_start+0x1c  or %rax, %rdx
 ls  2670177.697114471:  7f0dfdbce04f _dl_start+0x1f  movq  0x27e22(%rip), %rax        IPC: 0.00 (15/1685)
 ls  2670177.697116177:  7f0dfdbce056 _dl_start+0x26  movq  %rdx, 0x27683(%rip)        IPC: 0.00 (1/881)

Note, the IPC values are low due to page faults at the beginning of
execution. The additional cycles are due to the time to enter the kernel,
not the actual kernel page fault handler.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-script.txt |  5 ++++-
 tools/perf/builtin-script.c              | 23 ++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 9b0d04dd2a61..3a630dd64916 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -117,7 +117,7 @@ OPTIONS
         Comma separated list of fields to print. Options are:
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output, brstackinsn,
-        brstackoff, callindent, insn, insnlen, synth, phys_addr, metric, misc, srccode.
+        brstackoff, callindent, insn, insnlen, synth, phys_addr, metric, misc, srccode, ipc.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
@@ -203,6 +203,9 @@ OPTIONS
 	The synth field is used by synthesized events which may be created when
 	Instruction Trace decoding.
 
+	The ipc (instructions per cycle) field is synthesized and may have a value when
+	Instruction Trace decoding.
+
 	Finally, a user may not set fields to none for all event types.
 	i.e., -F "" is not allowed.
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 61cfd8f70989..331309485368 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -102,6 +102,7 @@ enum perf_output_field {
 	PERF_OUTPUT_METRIC	    = 1U << 28,
 	PERF_OUTPUT_MISC            = 1U << 29,
 	PERF_OUTPUT_SRCCODE	    = 1U << 30,
+	PERF_OUTPUT_IPC             = 1U << 31,
 };
 
 struct output_option {
@@ -139,6 +140,7 @@ struct output_option {
 	{.str = "metric", .field = PERF_OUTPUT_METRIC},
 	{.str = "misc", .field = PERF_OUTPUT_MISC},
 	{.str = "srccode", .field = PERF_OUTPUT_SRCCODE},
+	{.str = "ipc", .field = PERF_OUTPUT_IPC},
 };
 
 enum {
@@ -1268,6 +1270,20 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 	return printed;
 }
 
+static int perf_sample__fprintf_ipc(struct perf_sample *sample,
+				    struct perf_event_attr *attr, FILE *fp)
+{
+	unsigned int ipc;
+
+	if (!PRINT_FIELD(IPC) || !sample->cyc_cnt || !sample->insn_cnt)
+		return 0;
+
+	ipc = (sample->insn_cnt * 100) / sample->cyc_cnt;
+
+	return fprintf(fp, " \t IPC: %u.%02u (%" PRIu64 "/%" PRIu64 ") ",
+		       ipc / 100, ipc % 100, sample->insn_cnt, sample->cyc_cnt);
+}
+
 static int perf_sample__fprintf_bts(struct perf_sample *sample,
 				    struct perf_evsel *evsel,
 				    struct thread *thread,
@@ -1312,6 +1328,8 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 		printed += perf_sample__fprintf_addr(sample, thread, attr, fp);
 	}
 
+	printed += perf_sample__fprintf_ipc(sample, attr, fp);
+
 	if (print_srcline_last)
 		printed += map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
 
@@ -1858,6 +1876,9 @@ static void process_event(struct perf_script *script,
 
 	if (PRINT_FIELD(PHYS_ADDR))
 		fprintf(fp, "%16" PRIx64, sample->phys_addr);
+
+	perf_sample__fprintf_ipc(sample, attr, fp);
+
 	fprintf(fp, "\n");
 
 	if (PRINT_FIELD(SRCCODE)) {
@@ -3392,7 +3413,7 @@ int cmd_script(int argc, const char **argv)
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
 		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
-		     "callindent,insn,insnlen,synth,phys_addr,metric,misc",
+		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.17.1

