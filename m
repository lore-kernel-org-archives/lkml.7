Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F5FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F2E21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfB1Ho3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:44:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfB1Ho3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:44:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7hwWH2948194
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:43:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7hwJM2948191;
        Wed, 27 Feb 2019 23:43:58 -0800
Date:   Wed, 27 Feb 2019 23:43:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ztxj25rtx37ixo9cfajt8ocy@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, yhs@fb.com, tglx@linutronix.de,
        adrian.hunter@intel.com, jolsa@kernel.org, acme@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        mingo@kernel.org, namhyung@kernel.org, hpa@zytor.com
Reply-To: namhyung@kernel.org, mingo@kernel.org, kafai@fb.com,
          hpa@zytor.com, adrian.hunter@intel.com, acme@redhat.com,
          jolsa@kernel.org, linux-kernel@vger.kernel.org, yhs@fb.com,
          tglx@linutronix.de, daniel@iogearbox.net, ast@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Allow dumping a BPF map after setting
 up BPF events
Git-Commit-ID: ff7a4f98d52cd3f13b1f4f6f22208498b0c113f7
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

Commit-ID:  ff7a4f98d52cd3f13b1f4f6f22208498b0c113f7
Gitweb:     https://git.kernel.org/tip/ff7a4f98d52cd3f13b1f4f6f22208498b0c113f7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 19 Feb 2019 16:17:33 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Feb 2019 16:35:45 -0300

perf trace: Allow dumping a BPF map after setting up BPF events

Initial use case:

Dumping the maps setup by tools/perf/examples/bpf/augmented_raw_syscalls.c,
which so far are just booleans, showing just non-zeroed entries:

  # cat ~/.perfconfig
  [llvm]
	dump-obj = true
	clang-opt = -g
  [trace]
	#add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
	add_events = /wb/augmented_raw_syscalls.o
  $ date
  Tue Feb 19 16:29:33 -03 2019
  $ ls -la /wb/augmented_raw_syscalls.o
  -rwxr-xr-x. 1 root root 14048 Jan 24 12:09 /wb/augmented_raw_syscalls.o
  $ file /wb/augmented_raw_syscalls.o
  /wb/augmented_raw_syscalls.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped
  $
  # trace -e recvmmsg,sendmmsg --map-dump foobar
  ERROR: BPF map "foobar" not found
  # trace -e recvmmsg,sendmmsg --map-dump filtered_pids
  ERROR: BPF map "filtered_pids" not found
  # trace -e recvmmsg,sendmmsg --map-dump pids_filtered
  [2583] = 1,
  [2267] = 1,
  ^Z
  [1]+  Stopped                 trace -e recvmmsg,sendmmsg --map-dump pids_filtered
  # pidof trace
  2267
  # ps ax|grep gnome-terminal|grep -v grep
  2583 ?        Ssl   58:33 /usr/libexec/gnome-terminal-server
  ^C
  # trace -e recvmmsg,sendmmsg --map-dump syscalls
  [299] = 1,
  [307] = 1,
  ^C
  # grep x64_recvmmsg arch/x86/entry/syscalls/syscall_64.tbl
  299	64	recvmmsg		__x64_sys_recvmmsg
  # grep x64_sendmmsg arch/x86/entry/syscalls/syscall_64.tbl
  307	64	sendmmsg		__x64_sys_sendmmsg
  #

Next step probably will be something like 'perf stat's --interval-print and
--interval-clear.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-ztxj25rtx37ixo9cfajt8ocy@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt |  8 ++++++++
 tools/perf/builtin-trace.c              | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 631e687be4eb..fc6e43262c41 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -210,6 +210,14 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	may happen, for instance, when a thread gets migrated to a different CPU
 	while processing a syscall.
 
+--map-dump::
+	Dump BPF maps setup by events passed via -e, for instance the augmented_raw_syscalls
+	living in tools/perf/examples/bpf/augmented_raw_syscalls.c. For now this
+	dumps just boolean map values and integer keys, in time this will print in hex
+	by default and use BTF when available, as well as use functions to do pretty
+	printing using the existing 'perf trace' syscall arg beautifiers to map integer
+	arguments to strings (pid to comm, syscall id to syscall name, etc).
+
 
 PAGEFAULTS
 ----------
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 68a01e624ad3..1a11fe656afc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -19,6 +19,7 @@
 #include <traceevent/event-parse.h>
 #include <api/fs/tracing_path.h>
 #include <bpf/bpf.h>
+#include "util/bpf_map.h"
 #include "builtin.h"
 #include "util/cgroup.h"
 #include "util/color.h"
@@ -87,6 +88,9 @@ struct trace {
 					  *augmented;
 		}		events;
 	} syscalls;
+	struct {
+		struct bpf_map *map;
+	} dump;
 	struct record_opts	opts;
 	struct perf_evlist	*evlist;
 	struct machine		*host;
@@ -2997,6 +3001,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_apply_filters;
 
+	if (trace->dump.map)
+		bpf_map__fprintf(trace->dump.map, trace->output);
+
 	err = perf_evlist__mmap(evlist, trace->opts.mmap_pages);
 	if (err < 0)
 		goto out_error_mmap;
@@ -3686,6 +3693,7 @@ int cmd_trace(int argc, const char **argv)
 		.max_stack = UINT_MAX,
 		.max_events = ULONG_MAX,
 	};
+	const char *map_dump_str = NULL;
 	const char *output_name = NULL;
 	const struct option trace_options[] = {
 	OPT_CALLBACK('e', "event", &trace, "event",
@@ -3718,6 +3726,9 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK(0, "duration", &trace, "float",
 		     "show only events with duration > N.M ms",
 		     trace__set_duration),
+#ifdef HAVE_LIBBPF_SUPPORT
+	OPT_STRING(0, "map-dump", &map_dump_str, "BPF map", "BPF map to periodically dump"),
+#endif
 	OPT_BOOLEAN(0, "sched", &trace.sched, "show blocking scheduler events"),
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 	OPT_BOOLEAN('T', "time", &trace.full_time,
@@ -3812,6 +3823,14 @@ int cmd_trace(int argc, const char **argv)
 
 	err = -1;
 
+	if (map_dump_str) {
+		trace.dump.map = bpf__find_map_by_name(map_dump_str);
+		if (trace.dump.map == NULL) {
+			pr_err("ERROR: BPF map \"%s\" not found\n", map_dump_str);
+			goto out;
+		}
+	}
+
 	if (trace.trace_pgfaults) {
 		trace.opts.sample_address = true;
 		trace.opts.sample_time = true;
