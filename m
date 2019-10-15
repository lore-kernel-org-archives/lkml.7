Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED4BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D072086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfJOFcc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42160 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbfJOFcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRG-0000M7-2Q; Tue, 15 Oct 2019 07:32:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9F2B71C0671;
        Tue, 15 Oct 2019 07:31:46 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:46 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Allow choosing how to augment the
 tracepoint arguments
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-o8qdluotkcb3b1x2gjqrejcl@git.kernel.org>
References: <tip-o8qdluotkcb3b1x2gjqrejcl@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750652.12254.5582029482419632958.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f11b2803bb88655d90b88c787710b53100913bff
Gitweb:        https://git.kernel.org/tip/f11b2803bb88655d90b88c787710b53100913bff
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 04 Oct 2019 15:28:13 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:18 -03:00

perf trace: Allow choosing how to augment the tracepoint arguments

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
 tools/perf/Documentation/perf-config.txt |  5 +-
 tools/perf/Documentation/perf-trace.txt  |  5 +-
 tools/perf/builtin-trace.c               | 83 ++++++++++++++++++++++-
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c599623..c4dd23c 100644
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
index 25b74fd..ba16cd5 100644
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
index 297aeaa..8303d83 100644
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
