Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5055ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCDA21835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824520;
	bh=aie6CxpK/7qLbS1b0yymZogYb8gZquurq36TLH2jHo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9vy3j33EBM7Zx7QFBNzoNoETxIBjOy/6Im0+v4dB7g29ugwOwO6/9xdbBNObN+Nb
	 AG5OTGc/vEwlsdhvpMOUJy1WZBkI/Oe42MZ8tWQrj143G6ONMa8DWDpd+tRfJSVj9C
	 IDsSXl/fy5So+/NKp3pmCgkVAXhYLIu+VWLp5APM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfJKUIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfJKUIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:08:38 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FF9121D56;
        Fri, 11 Oct 2019 20:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824517;
        bh=aie6CxpK/7qLbS1b0yymZogYb8gZquurq36TLH2jHo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4mqbqqAeUW99L/i5MQCLDr/1hpulwJf98pxTxYBhe3TQJ49m+JDcXoZNAE5ucmYI
         6HrvGjMaB9BVaagD3msEKnMfCh9w2hShflkFSYSuWovx0vcaz3sLd1NYmid7MJgBN+
         CZYyjrtzypj9JSIJtfvaOTA0imD1lyTJfe921Zlw=
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
Subject: [PATCH 24/69] perf trace: Allow choosing how to augment the tracepoint arguments
Date:   Fri, 11 Oct 2019 17:05:14 -0300
Message-Id: <20191011200559.7156-25-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So far we used the libtraceevent printing routines when showing
tracepoint arguments, but since 'perf trace' has a lot of beautifiers
for syscall arguments, and since some of those can be used to augment
tracepoint arguments, add a routine to make use of those beautifiers
and allow the user to choose which one to use.

The default now is to use the same beautifiers used for the strace-like
sys_enter+sys_exit lines, but the user can choose the libtraceevent ones
by either using the:

    perf trace --libtraceevent_print

command line option, or by setting:

  # cat ~/.perfconfig
  [trace]
	tracepoint_beautifiers = libtraceevent

For instance, here are some examples:

  # perf trace -e sched:*switch,*sleep,sched:*wakeup,exit*,sched:*exit sleep 1
       0.000 sched:sched_wakeup(comm: "perf", pid: 5273 (perf), prio: 120, success: 1, target_cpu: 6)
       0.621 nanosleep(rqtp: 0x7ffdd06d1140, rmtp: NULL) ...
       0.628 sched:sched_switch(prev_comm: "sleep", prev_pid: 5273 (sleep), prev_prio: 120, prev_state: 1, next_comm: "swapper/6", next_pid: 0, next_prio: 120)
    1000.879 sched:sched_wakeup(comm: "sleep", pid: 5273 (sleep), prio: 120, success: 1, target_cpu: 6)
       0.621  ... [continued]: nanosleep())          = 0
    1001.026 exit_group(error_code: 0)               = ?
    1001.216 sched:sched_process_exit(comm: "sleep", pid: 5273 (sleep), prio: 120)
  #

And then using libtraceevent, as before:

  # perf trace --libtraceevent_print -e sched:*switch,*sleep,sched:*wakeup,exit*,sched:*exit sleep 1
       0.000 sched:sched_wakeup(comm=perf pid=5288 prio=120 target_cpu=001)
       0.739 nanosleep(rqtp: 0x7ffeba6c2f40, rmtp: NULL) ...
       0.747 sched:sched_switch(prev_comm=sleep prev_pid=5288 prev_prio=120 prev_state=S ==> next_comm=swapper/1 next_pid=0 next_prio=120)
    1000.902 sched:sched_wakeup(comm=sleep pid=5288 prio=120 target_cpu=001)
       0.739  ... [continued]: nanosleep())          = 0
    1001.012 exit_group(error_code: 0)               = ?
  #

The new default allocates an array of 'struct syscall_arg_fmt' for the
tracepoint arguments and, just like with syscall arguments, tries to
find suitable syscall_arg__scnprintf_NAME() routines to augment those
tracepoint arguments based on their type (as in the tracefs "format"
file), or even in their name + type, for instance arguntents with names
ending in "fd" with type "int" get the fd scnprintf beautifier attached,
etc.

Soon this will take advantage of the kernel BTF information to augment
enumerations based on the tracefs "format" type info.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-o8qdluotkcb3b1x2gjqrejcl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  5 ++
 tools/perf/Documentation/perf-trace.txt  |  5 ++
 tools/perf/builtin-trace.c               | 83 +++++++++++++++++++++++-
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c599623a1f3d..c4dd23c4b478 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -561,6 +561,11 @@ trace.*::
 	trace.show_zeros::
 		Do not suppress syscall arguments that are equal to zero.
 
+	trace.tracepoint_beautifiers::
+		Use "libtraceevent" to use that library to augment the tracepoint arguments,
+		"libbeauty", the default, to use the same argument beautifiers used in the
+		strace-like sys_enter+sys_exit lines.
+
 llvm.*::
 	llvm.clang-path::
 		Path to clang. If omit, search it from $PATH.
diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 25b74fdb36fa..ba16cd5b680f 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -219,6 +219,11 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	may happen, for instance, when a thread gets migrated to a different CPU
 	while processing a syscall.
 
+--libtraceevent_print::
+	Use libtraceevent to print tracepoint arguments. By default 'perf trace' uses
+	the same beautifiers used in the strace-like enter+exit lines to augment the
+	tracepoint arguments.
+
 --map-dump::
 	Dump BPF maps setup by events passed via -e, for instance the augmented_raw_syscalls
 	living in tools/perf/examples/bpf/augmented_raw_syscalls.c. For now this
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 297aeaa9f69d..8303d83cb93c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -175,6 +175,7 @@ struct trace {
 	bool			print_sample;
 	bool			show_tool_stats;
 	bool			trace_syscalls;
+	bool			libtraceevent_print;
 	bool			kernel_syscallchains;
 	s16			args_alignment;
 	bool			show_tstamp;
@@ -2397,6 +2398,71 @@ static void bpf_output__fprintf(struct trace *trace,
 	++trace->nr_events_printed;
 }
 
+static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
+				       struct thread *thread, void *augmented_args, int augmented_args_size)
+{
+	char bf[2048];
+	size_t size = sizeof(bf);
+	struct tep_format_field *field = evsel->tp_format->format.fields;
+	struct syscall_arg_fmt *arg = evsel->priv;
+	size_t printed = 0;
+	unsigned long val;
+	u8 bit = 1;
+	struct syscall_arg syscall_arg = {
+		.augmented = {
+			.size = augmented_args_size,
+			.args = augmented_args,
+		},
+		.idx	= 0,
+		.mask	= 0,
+		.trace  = trace,
+		.thread = thread,
+		.show_string_prefix = trace->show_string_prefix,
+	};
+
+	for (; field && arg; field = field->next, ++syscall_arg.idx, bit <<= 1, ++arg) {
+		if (syscall_arg.mask & bit)
+			continue;
+
+		syscall_arg.fmt = arg;
+		if (field->flags & TEP_FIELD_IS_ARRAY)
+			val = (uintptr_t)(sample->raw_data + field->offset);
+		else
+			val = format_field__intval(field, sample, evsel->needs_swap);
+		/*
+		 * Some syscall args need some mask, most don't and
+		 * return val untouched.
+		 */
+		val = syscall_arg_fmt__mask_val(arg, &syscall_arg, val);
+
+		/*
+		 * Suppress this argument if its value is zero and
+		 * and we don't have a string associated in an
+		 * strarray for it.
+		 */
+		if (val == 0 &&
+		    !trace->show_zeros &&
+		    !((arg->show_zero ||
+		       arg->scnprintf == SCA_STRARRAY ||
+		       arg->scnprintf == SCA_STRARRAYS) &&
+		      arg->parm))
+			continue;
+
+		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
+
+		/*
+		 * XXX Perhaps we should have a show_tp_arg_names,
+		 * leaving show_arg_names just for syscalls?
+		 */
+		if (1 || trace->show_arg_names)
+			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
+
+		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
+	}
+
+	return printed + fprintf(trace->output, "%s", bf);
+}
+
 static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 				union perf_event *event __maybe_unused,
 				struct perf_sample *sample)
@@ -2457,9 +2523,13 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	} else if (evsel->tp_format) {
 		if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
 		    trace__fprintf_sys_enter(trace, evsel, sample)) {
-			event_format__fprintf(evsel->tp_format, sample->cpu,
-					      sample->raw_data, sample->raw_size,
-					      trace->output);
+			if (trace->libtraceevent_print) {
+				event_format__fprintf(evsel->tp_format, sample->cpu,
+						      sample->raw_data, sample->raw_size,
+						      trace->output);
+			} else {
+				trace__fprintf_tp_fields(trace, evsel, sample, thread, NULL, 0);
+			}
 			++trace->nr_events_printed;
 
 			if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
@@ -4150,6 +4220,11 @@ static int trace__config(const char *var, const char *value, void *arg)
 		int args_alignment = 0;
 		if (perf_config_int(&args_alignment, var, value) == 0)
 			trace->args_alignment = args_alignment;
+	} else if (!strcmp(var, "trace.tracepoint_beautifiers")) {
+		if (strcasecmp(value, "libtraceevent") == 0)
+			trace->libtraceevent_print = true;
+		else if (strcasecmp(value, "libbeauty") == 0)
+			trace->libtraceevent_print = false;
 	}
 out:
 	return err;
@@ -4239,6 +4314,8 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK(0, "call-graph", &trace.opts,
 		     "record_mode[,record_size]", record_callchain_help,
 		     &record_parse_callchain_opt),
+	OPT_BOOLEAN(0, "libtraceevent_print", &trace.libtraceevent_print,
+		    "Use libtraceevent to print the tracepoint arguments."),
 	OPT_BOOLEAN(0, "kernel-syscall-graph", &trace.kernel_syscallchains,
 		    "Show the kernel callchains on the syscall exit path"),
 	OPT_ULONG(0, "max-events", &trace.max_events,
-- 
2.21.0

