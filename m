Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE742C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CA02089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Pv4yX2Z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfG3RwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:52:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfG3RwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:52:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHpqZG3320508
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:51:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHpqZG3320508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509113;
        bh=h03JjELIP2FGtSZBvPS/BqEzDZ3RDBbo7/+OJA3jTHQ=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=Pv4yX2Z+C+4SsIQXxOfblmjG3/qp2Em8ECp87ZO8uNDsRcz7aA6byINJ9WvmU3RQ2
         b9ngAbUxJBUop54Cme9EQJsuAvbOdfDclU3IatLDWYimVlTiVuGxqNgQY5ayLxc8aG
         tPyhZyG5mMo5/XWBnoOkow7ZFQEN+KBHR5JqAojlJn4F8t0NMhekGFjlDZf4vYWqFX
         rC/3YtjxOb0rJOBX7zW76Ln1SS5irkI9ncVUGiRCh65C0pS6pOG9bpr/XxiqvizM/Y
         MOhhEY91BRPPBuALS+oYoT+/Vtb7EhyThc6aJTit1C7qfCwgo9QuWSPxLUgrP9bAyv
         53h+dIn2wkZag==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHppr93320505;
        Tue, 30 Jul 2019 10:51:51 -0700
Date:   Tue, 30 Jul 2019 10:51:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-meucpjx2u0slpkayx56lxqq6@git.kernel.org>
Cc:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, tglx@linutronix.de, lclaudio@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
        hpa@zytor.com
Reply-To: mingo@kernel.org, hpa@zytor.com, acme@redhat.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          lclaudio@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Add BPF handler for unaugmented
 syscalls
Git-Commit-ID: 5834da7f10917245d191032f76f132e62e57197c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5834da7f10917245d191032f76f132e62e57197c
Gitweb:     https://git.kernel.org/tip/5834da7f10917245d191032f76f132e62e57197c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 15 Jul 2019 17:51:43 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf trace: Add BPF handler for unaugmented syscalls

Will be used to assign to syscalls that don't need augmentation, i.e.
those with just integer args.

All syscalls will be in a BPF_MAP_TYPE_PROG_ARRAY, and the
bpf_tail_call() keyed by the syscall id will either find nothing in
place, which means the syscall is being filtered, or a function that
will either add things like filenames to the ring buffer, right after
the raw syscall args, or be this unaugmented handler that will just
return 1, meaning don't filter the original
raw_syscalls:sys_{enter,exit} tracepoint.

For now it is not really being used, this is just leg work to break the
patch into smaller pieces.

It introduces a trace__find_bpf_program_by_title() helper that in turn
uses libbpf's bpf_object__find_program_by_title() on the BPF object with
the __augmented_syscalls__ map. "title" is how libbpf calls the SEC()
argument for functions, i.e. the ELF section that follows a convention
to specify what BPF program (a function with this SEC() marking) should
be connected to which tracepoint, kprobes, etc.

In perf anything that is of the form SEC("sys:event_name") will be
connected to that tracepoint by perf's BPF loader.

In this case its something that will be bpf_tail_call()ed from either
the "raw_syscalls:sys_enter" or "raw_syscall:sys_exit" tracepoints, so
its named "!raw_syscalls:unaugmented" to convey that idea, i.e. its not
going to be directly attached to a tracepoint, thus it starts with a
"!".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-meucpjx2u0slpkayx56lxqq6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                       | 16 ++++++++++++++++
 tools/perf/examples/bpf/augmented_raw_syscalls.c |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9bd5ecd6a8dd..07df952a0d7f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -88,6 +88,7 @@ struct trace {
 					  *sys_exit,
 					  *augmented;
 		}		events;
+		struct bpf_program *unaugmented_prog;
 	} syscalls;
 	struct {
 		struct bpf_map *map;
@@ -2733,6 +2734,14 @@ out_enomem:
 }
 
 #ifdef HAVE_LIBBPF_SUPPORT
+static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
+{
+	if (trace->bpf_obj == NULL)
+		return NULL;
+
+	return bpf_object__find_program_by_title(trace->bpf_obj, name);
+}
+
 static void trace__init_bpf_map_syscall_args(struct trace *trace, int id, struct bpf_map_syscall_entry *entry)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, id);
@@ -2814,6 +2823,12 @@ static int trace__init_syscalls_bpf_map(struct trace *trace __maybe_unused)
 {
 	return 0;
 }
+
+static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace __maybe_unused,
+							    const char *name __maybe_unused)
+{
+	return NULL;
+}
 #endif // HAVE_LIBBPF_SUPPORT
 
 static int trace__set_ev_qualifier_filter(struct trace *trace)
@@ -3914,6 +3929,7 @@ int cmd_trace(int argc, const char **argv)
 
 		trace__set_bpf_map_filtered_pids(&trace);
 		trace__set_bpf_map_syscalls(&trace);
+		trace.syscalls.unaugmented_prog = trace__find_bpf_program_by_title(&trace, "!raw_syscalls:unaugmented");
 	}
 
 	err = bpf__setup_stdout(trace.evlist);
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 2f822bb51717..48a536b1be6d 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -88,6 +88,12 @@ unsigned int augmented_filename__read(struct augmented_filename *augmented_filen
 	return len;
 }
 
+SEC("!raw_syscalls:unaugmented")
+int syscall_unaugmented(struct syscall_enter_args *args)
+{
+	return 1;
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
