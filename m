Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96A9C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B958821901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817206;
	bh=468+a7qSo4TMs9uU9GxdLfGOeBe2GhvBeB2WSC+5QGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zYnlCCtFZQTvAGWqIa4hTWb3eO4ArToozLw+s64AKJoswzCjCT4vh5JbyByeHX0DP
	 OrnN+7cYB54BaCMlxVDWfjrYBlOsYtOiuizdZXOMYmAI8zqsRp+DZ+dxAIaqRQC5IU
	 M1WzQpCK9wl60QeG8Cl4GsG0m5UPoZMOh/5LYC+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfGVRkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfGVRkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:40:04 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D5E21903;
        Mon, 22 Jul 2019 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817203;
        bh=468+a7qSo4TMs9uU9GxdLfGOeBe2GhvBeB2WSC+5QGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXI9fDcf4qB7kK4Q7UGsmQGYxuB2vf+7tsmZNAaZDrTFcw6TTPmFSCbzory55PzxG
         1k2/gx46uqzRUwYn0eJjmqB82Et1H2PsWJMISL8VDUHEonfyfVZtZ1/PTH6VlDkrIu
         25eaMAk1rYkRN0x5Ir/kmn0NmovU7+xZgUp8668o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 09/37] perf trace: Put the per-syscall entry/exit prog_array BPF map infrastructure in place
Date:   Mon, 22 Jul 2019 14:38:11 -0300
Message-Id: <20190722173839.22898-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/perf/builtin-trace.c                    | 76 ++++++++++++++++++-
 .../examples/bpf/augmented_raw_syscalls.c     | 14 ++++
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
@@ -1619,6 +1622,22 @@ static int trace__validate_ev_qualifier(struct trace *trace)
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
-- 
2.21.0

