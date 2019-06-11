Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C95C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD3D2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279602;
	bh=/NpgXN69vlcrulgR2nZ38KQ8yTPrplwscqXBBg6GGy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Znp2J3wP5i1pIWux5F+8/gc33dupaqK/LvXJOH1hZZbCPCGpipojPgLWTXJjLrzWD
	 iuWHo/HaoogLWRI4uKLZMGs7QbjuE+52yYu2i5dpLZdejuDurdBcjH9jRUpf8a7GW9
	 fo/EZJY8P/0jvFAW+ipZYMam10eeA89b49E0s088=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407134AbfFKTAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404869AbfFKTAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:00:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04282183F;
        Tue, 11 Jun 2019 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279599;
        bh=/NpgXN69vlcrulgR2nZ38KQ8yTPrplwscqXBBg6GGy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XONxcJIYSlYTx7h84GbWamNKODPZAmZit9Wjt826C9FgWCyWJ9j+zX6r91475gdF4
         iUDVzumJjLGv74/0ZnQQ5T7k2YOWi7o3i/GAKsYaVac7h2a6z4AXnYBHq31v/btZYg
         +1/xigBPdDRtezBEoDPrlY8qbsiPcWYfZ4db48Rg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 11/85] perf script: Add output of IPC ratio
Date:   Tue, 11 Jun 2019 15:57:57 -0300
Message-Id: <20190611185911.11645-12-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
execution. The additional cycles are due to the time to enter the
kernel, not the actual kernel page fault handler.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  5 ++++-
 tools/perf/builtin-script.c              | 23 ++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index af8282782911..c59fd52e9e91 100644
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
index 3a48a2627670..80c722ade852 100644
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
 
@@ -1859,6 +1877,9 @@ static void process_event(struct perf_script *script,
 
 	if (PRINT_FIELD(PHYS_ADDR))
 		fprintf(fp, "%16" PRIx64, sample->phys_addr);
+
+	perf_sample__fprintf_ipc(sample, attr, fp);
+
 	fprintf(fp, "\n");
 
 	if (PRINT_FIELD(SRCCODE)) {
@@ -3433,7 +3454,7 @@ int cmd_script(int argc, const char **argv)
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
 		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
-		     "callindent,insn,insnlen,synth,phys_addr,metric,misc",
+		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
-- 
2.20.1

