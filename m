Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3CDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747152064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="4zI1Q3qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbfG3S1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:27:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51365 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbfG3S07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:26:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHrMHs3320600
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:53:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHrMHs3320600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509203;
        bh=GVCJAbAs0wCNkUy0tP9z0EuH7PBXfcO9jxwzcY8xl6M=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=4zI1Q3qmwv64GKH0Ekdo1R5u1bluplkgEyS+Em31uElT6sw3S6NA6AGgWgg7+yMhZ
         rHv6vpIiGud4Zyl8xsX5YpEqrNu5nKZoiNJr3iYi2PJlGuLpIelEVFYTGPJ+fVclM4
         5e+J65RRG6nrR0SlfUi/zQARx0N8VaJvdoy3HUaCYBNPmbJOrb0PobzPFZkNR8FDFq
         PIQzv26yCFxB9HP540NyAnq9DD6vLgs6Mvj05/h0dPLAoiucR3R+1RU7NFulZzOXwn
         niaSk5nwxif95QrRIqkyY1dosC/ub83mUYh4DMH2gcBpAYypg+iZwZxkeF0dtnT7Bo
         1IdWffDGE7D2Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHrMAg3320597;
        Tue, 30 Jul 2019 10:53:22 -0700
Date:   Tue, 30 Jul 2019 10:53:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-t0p4u43i9vbpzs1xtowna3gb@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@kernel.org, acme@redhat.com,
        lclaudio@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, namhyung@kernel.org,
          lclaudio@redhat.com, acme@redhat.com, jolsa@kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Put the per-syscall entry/exit
 prog_array BPF map infrastructure in place
Git-Commit-ID: 3803a229312de539d2878f2fc5c6ee0202ce6728
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

Commit-ID:  3803a229312de539d2878f2fc5c6ee0202ce6728
Gitweb:     https://git.kernel.org/tip/3803a229312de539d2878f2fc5c6ee0202ce6728
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 11:27:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf trace: Put the per-syscall entry/exit prog_array BPF map infrastructure in place

I.e. look for "syscalls_sys_enter" and "syscalls_sys_exit" BPF maps of
type PROG_ARRAY and populate it with the handlers as specified per
syscall, for now only 'open' is wiring it to something, in time all
syscalls that need to copy arguments entering a syscall or returning
from one will set these to the right handlers, reusing when possible
pre-existing ones.

Next step is to use bpf_tail_call() into that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-t0p4u43i9vbpzs1xtowna3gb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                       | 76 ++++++++++++++++++++++--
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 14 +++++
 2 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6cc696edf24a..fb8b8e78d7b5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0-only
 /*
  * builtin-trace.c
  *
@@ -83,6 +82,10 @@ struct trace {
 		int		max;
 		struct syscall  *table;
 		struct bpf_map  *map;
+		struct { // per syscall BPF_MAP_TYPE_PROG_ARRAY
+			struct bpf_map  *sys_enter,
+					*sys_exit;
+		}		prog_array;
 		struct {
 			struct perf_evsel *sys_enter,
 					  *sys_exit,
@@ -1619,6 +1622,22 @@ out_free:
 	goto out;
 }
 
+static __maybe_unused bool trace__syscall_enabled(struct trace *trace, int id)
+{
+	bool in_ev_qualifier;
+
+	if (trace->ev_qualifier_ids.nr == 0)
+		return true;
+
+	in_ev_qualifier = bsearch(&id, trace->ev_qualifier_ids.entries,
+				  trace->ev_qualifier_ids.nr, sizeof(int), intcmp) != NULL;
+
+	if (in_ev_qualifier)
+	       return !trace->not_ev_qualifier;
+
+	return trace->not_ev_qualifier;
+}
+
 /*
  * args is to be interpreted as a series of longs but we need to handle
  * 8-byte unaligned accesses. args points to raw_data within the event
@@ -2784,6 +2803,18 @@ static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
 	}
 }
 
+static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
+{
+	struct syscall *sc = trace__syscall_info(trace, NULL, id);
+	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program__fd(trace->syscalls.unaugmented_prog);
+}
+
+static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
+{
+	struct syscall *sc = trace__syscall_info(trace, NULL, id);
+	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->syscalls.unaugmented_prog);
+}
+
 static void trace__init_bpf_map_syscall_args(struct trace *trace, int id, struct bpf_map_syscall_entry *entry)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, id);
@@ -2837,10 +2868,8 @@ static int __trace__init_syscalls_bpf_map(struct trace *trace, bool enabled)
 	int err = 0, key;
 
 	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
-		if (enabled) {
+		if (enabled)
 			trace__init_bpf_map_syscall_args(trace, key, &value);
-			trace__init_syscall_bpf_progs(trace, key);
-		}
 
 		err = bpf_map_update_elem(fd, &key, &value, BPF_ANY);
 		if (err)
@@ -2859,6 +2888,34 @@ static int trace__init_syscalls_bpf_map(struct trace *trace)
 
 	return __trace__init_syscalls_bpf_map(trace, enabled);
 }
+
+static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
+{
+	int map_enter_fd = bpf_map__fd(trace->syscalls.prog_array.sys_enter),
+	    map_exit_fd  = bpf_map__fd(trace->syscalls.prog_array.sys_exit);
+	int err = 0, key;
+
+	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
+		int prog_fd;
+
+		if (!trace__syscall_enabled(trace, key))
+			continue;
+
+		trace__init_syscall_bpf_progs(trace, key);
+
+		// It'll get at least the "!raw_syscalls:unaugmented"
+		prog_fd = trace__bpf_prog_sys_enter_fd(trace, key);
+		err = bpf_map_update_elem(map_enter_fd, &key, &prog_fd, BPF_ANY);
+		if (err)
+			break;
+		prog_fd = trace__bpf_prog_sys_exit_fd(trace, key);
+		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
+		if (err)
+			break;
+	}
+
+	return err;
+}
 #else
 static int trace__set_ev_qualifier_bpf_filter(struct trace *trace __maybe_unused)
 {
@@ -2875,6 +2932,11 @@ static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace
 {
 	return NULL;
 }
+
+static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace __maybe_unused)
+{
+	return 0;
+}
 #endif // HAVE_LIBBPF_SUPPORT
 
 static int trace__set_ev_qualifier_filter(struct trace *trace)
@@ -3129,6 +3191,10 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->syscalls.map)
 		trace__init_syscalls_bpf_map(trace);
 
+	if (trace->syscalls.prog_array.sys_enter)
+		trace__init_syscalls_bpf_prog_array_maps(trace);
+
+
 	if (trace->ev_qualifier_ids.nr > 0) {
 		err = trace__set_ev_qualifier_filter(trace);
 		if (err < 0)
@@ -3754,6 +3820,8 @@ static void trace__set_bpf_map_filtered_pids(struct trace *trace)
 static void trace__set_bpf_map_syscalls(struct trace *trace)
 {
 	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
+	trace->syscalls.prog_array.sys_enter = trace__find_bpf_map_by_name(trace, "syscalls_sys_enter");
+	trace->syscalls.prog_array.sys_exit  = trace__find_bpf_map_by_name(trace, "syscalls_sys_exit");
 }
 
 static int trace__config(const char *var, const char *value, void *arg)
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 66b33b299349..c66474a6ccf4 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -33,6 +33,20 @@ struct syscall {
 
 bpf_map(syscalls, ARRAY, int, struct syscall, 512);
 
+/*
+ * What to augment at entry?
+ *
+ * Pointer arg payloads (filenames, etc) passed from userspace to the kernel
+ */
+bpf_map(syscalls_sys_enter, PROG_ARRAY, u32, u32, 512);
+
+/*
+ * What to augment at exit?
+ *
+ * Pointer arg payloads returned from the kernel (struct stat, etc) to userspace.
+ */
+bpf_map(syscalls_sys_exit, PROG_ARRAY, u32, u32, 512);
+
 struct syscall_enter_args {
 	unsigned long long common_tp_fields;
 	long		   syscall_nr;
