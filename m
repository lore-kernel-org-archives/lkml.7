Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8691ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4D22190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824428;
	bh=GAVUYoogW31qyFDHR+Iep0GVQcg3eHPmxVUp2FdtIow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lRS7EiaFcD1M/ibQLiwPdIprTA2IUMr0BXgOw2alAurPLu9hQbMzp6l1epIn86wwu
	 k/39wnV0cxGeHsgO67fcAw3wtItnvbM7wxv+F+8BW8rrM3tPsRr4ctFjZ9TLfuZNdP
	 yU79Xk0sLc7NQQUx2BKuV23CDsnyqrpVSFjrdK4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfJKUHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbfJKUHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:07:05 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F329821D56;
        Fri, 11 Oct 2019 20:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824425;
        bh=GAVUYoogW31qyFDHR+Iep0GVQcg3eHPmxVUp2FdtIow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2bkGv8uCFeYXT6D+5pNv+S4OuCmQUDw275L9FLgssnX0Bn9G+kFkOc+nMYIKGBLFz
         k4py5B3/jlyq3H9Draznre4131wETts6pOA3qISl9KZq2q+OIIii5iRF2iaxG4rhmx
         aP/sFuD8dOdN3qPEZOZ4pHqgDo0lAN7syiPHz6Uk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 08/69] perf trace augmented_syscalls: Do not show syscalls when none was asked for
Date:   Fri, 11 Oct 2019 17:04:58 -0300
Message-Id: <20191011200559.7156-9-acme@kernel.org>
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

When not using augmented syscalls, i.e. not passing thru the command
line a eBPF source or object file event that provides the
__augmented_syscalls__ BPF_MAP_TYPE_PERF_EVENT_ARRAY, etc, as with:

   perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c

or passing that augmented eBPF source/object via the trace.add_events in
.perfconfig file, we were assuming that syscalls were asked for,
differing from when not using augmented syscalls at all.

This is confusing when using .perfconfig to hide the fact we're using
the augmenter, i.e. using:

 # perf trace -e sched:* sleep 1

Will show both the scheduler tracepoints and the syscalls, where what we
want is to show just the scheduler tracepoints.

To see the scheduler tracepoints and some specific syscall strace-like
formatting, one has to use:

  # perf trace -e sched:*,nanosleep sleep 1

Or, if wanting all the syscalls:

  # perf trace -e sched:* --syscalls sleep 1

This way 'perf trace' can be used to trace just a set of tracepoints
while allowing for mixing with strace-like when desired, by simply
adding to the mix the name of the syscalls to show in addition to the
tracepoints.

Fix it so that the behaviour using the eBPF based syscall augmenter is
the same as when not using one.

Testing:

Before this patch, with this ~/.perfconfig:

  # egrep -B1 ^[[:space:]]+add_events ~/.perfconfig
  [trace]
  	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  #

That points to this pre-compiled eBPF syscall augmenter:

  # file /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped

And when asking for _only_ sched:sched_switch and sched:sched_wakeup we
were unconditionally getting all the syscalls formatted strace-like:

  # perf trace -e sched:*switch,sched:*wakeup sleep 1 |& tail
     0.633 fstat(3, 0x7fe11d030ac0)                = 0
     0.635 mmap(NULL, 217750512, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fe10fec5000
     0.643 close(3)                                = 0
     0.668 nanosleep(0x7fff649a3a90, NULL)      ...
     0.672 sched:sched_switch:prev_comm=sleep prev_pid=4417 prev_prio=120 prev_state=S ==> next_comm=swapper/6 next_pid=0 next_prio=120
  1000.822 sched:sched_wakeup:comm=sleep pid=4417 prio=120 target_cpu=006
     0.668  ... [continued]: nanosleep())          = 0
  1000.923 close(1)                                = 0
  1000.941 close(2)                                = 0
  1000.974 exit_group(0)                           = ?
  #

After the patch:

  # perf trace -e sched:*switch,sched:*wakeup sleep 1
     0.000 sched:sched_wakeup:comm=perf pid=5529 prio=120 target_cpu=005
     1.186 sched:sched_switch:prev_comm=sleep prev_pid=5529 prev_prio=120 prev_state=S ==> next_comm=swapper/5 next_pid=0 next_prio=120
  1001.573 sched:sched_wakeup:comm=sleep pid=5529 prio=120 target_cpu=005
  #

If we add the "open*" syscalls to the mix then the eBPF augmented _will_
be used and these syscalls will be traced together with the specified
sched tracepoints:

  # cd /sys/kernel/debug/tracing/events/syscalls/
  # ls -1d sys_enter_open*
  sys_enter_open
  sys_enter_openat
  sys_enter_open_by_handle_at
  sys_enter_open_tree
  #

  # perf trace -e open*,sched:*switch,sched:*wakeup sleep 1
       0.000 sched:sched_wakeup:comm=perf pid=5580 prio=120 target_cpu=005
       0.590 openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
       0.616 openat(AT_FDCWD, "/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
       0.846 openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
       0.891 sched:sched_switch:prev_comm=sleep prev_pid=5580 prev_prio=120 prev_state=S ==> next_comm=swapper/5 next_pid=0 next_prio=120
    1001.005 sched:sched_wakeup:comm=sleep pid=5580 prio=120 target_cpu=005
  #

And as we can see, the pathnames were collected via the eBPF augmenters.

If we don't specify anything it'll trace all syscalls:

  # perf trace sleep 1 |& tail
       0.299 brk(0x5597543a3000)                     = 0x5597543a3000
       0.302 brk(NULL)                               = 0x5597543a3000
       0.307 openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
       0.313 fstat(3, 0x7feece50cac0)                = 0
       0.315 mmap(NULL, 217750512, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7feec13a1000
       0.323 close(3)                                = 0
       0.354 nanosleep(0x7ffe338856e0, NULL)         = 0
    1000.641 close(1)                                = 0
    1000.655 close(2)                                = 0
    1000.673 exit_group(0)                           = ?
  #

Ditto if we don't use .perfconfig's trace.add_events but instead pass
just the augmenter as a command line event:

  # vim ~/.perfconfig
  # egrep -B1 ^[[:space:]]+add_events ~/.perfconfig
  # perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o sleep 1 |& tail
       0.294 brk(0x55ae08ec3000)                     = 0x55ae08ec3000
       0.297 brk(NULL)                               = 0x55ae08ec3000
       0.302 openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
       0.309 fstat(3, 0x7f726488fac0)                = 0
       0.311 mmap(NULL, 217750512, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f7257724000
       0.319 close(3)                                = 0
       0.347 nanosleep(0x7ffe23643a70, NULL)         = 0
    1000.560 close(1)                                = 0
    1000.575 close(2)                                = 0
    1000.593 exit_group(0)                           = ?
  #

As well as that + some syscall names for strace-like formatting:

  # perf trace -e socket,connect,/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o ssh localhost
       0.000 socket(PF_LOCAL, SOCK_STREAM|CLOEXEC|NONBLOCK, 0) = 3
       0.021 connect(3, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
       0.034 socket(PF_LOCAL, SOCK_STREAM|CLOEXEC|NONBLOCK, 0) = 3
       0.041 connect(3, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
       0.163 socket(PF_LOCAL, SOCK_STREAM, 0)        = 4
       0.185 connect(4, { .family: PF_LOCAL, path: /var/lib/sss/pipes/nss }, 110) = 0
       0.670 socket(PF_LOCAL, SOCK_STREAM|CLOEXEC|NONBLOCK, 0) = 7
       0.684 connect(7, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
       0.694 socket(PF_LOCAL, SOCK_STREAM|CLOEXEC|NONBLOCK, 0) = 7
       0.701 connect(7, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
       0.994 socket(PF_LOCAL, SOCK_STREAM|CLOEXEC|NONBLOCK, 0) = 5
       1.006 connect(5, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
       1.014 socket(PF_LOCAL, SOCK_STREAM|CLOEXEC|NONBLOCK, 0) = 5
       1.022 connect(5, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
       1.068 socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 5
       1.087 connect(5, { .family: PF_INET, port: 22, addr: 127.0.0.1 }, 16) = 0
      24.299 socket(PF_LOCAL, SOCK_STREAM, 0)        = 6
      24.337 connect(6, { .family: PF_LOCAL, path: /var/run/.heim_org.h5l.kcm-socket }, 110) = 0
      28.441 socket(PF_LOCAL, SOCK_STREAM, 0)        = 6
      28.516 connect(6, { .family: PF_LOCAL, path: /var/run/.heim_org.h5l.kcm-socket }, 110) = 0
  root@localhost's password:^C
  #

Everything works without augmenters:

  # egrep -B1 ^[[:space:]]+add_events ~/.perfconfig
  # perf trace sleep 1 |& tail
       0.261 brk(0x5635068ac000)                     = 0x5635068ac000
       0.264 brk(NULL)                               = 0x5635068ac000
       0.268 openat(AT_FDCWD, 0xdce642a0, O_RDONLY|O_CLOEXEC) = 3
       0.275 fstat(3, 0x7f3fdce97ac0)                = 0
       0.277 mmap(NULL, 217750512, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f3fcfd2c000
       0.284 close(3)                                = 0
       0.310 nanosleep(0x7ffdaea6ecd0, NULL)         = 0
    1000.552 close(1)                                = 0
    1000.565 close(2)                                = 0
    1000.580 exit_group(0)                           = ?
  #

  # perf trace -e connect ssh localhost
       0.000 connect(3, 0x58266930, 110)             = -1 ENOENT (No such file or directory)
       0.022 connect(3, 0x58266af0, 110)             = -1 ENOENT (No such file or directory)
       0.150 connect(4, 0x58266b00, 110)             = 0
       0.490 connect(7, 0x58264150, 110)             = -1 ENOENT (No such file or directory)
       0.505 connect(7, 0x58264300, 110)             = -1 ENOENT (No such file or directory)
       0.832 connect(5, 0x58266220, 110)             = -1 ENOENT (No such file or directory)
       0.847 connect(5, 0x582663e0, 110)             = -1 ENOENT (No such file or directory)
       0.899 connect(5, 0x95ba0630, 16)              = 0
      25.619 connect(6, 0x58266360, 110)             = 0
      40.564 connect(6, 0x58266330, 110)             = 0
  root@localhost's password: ^C
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-624f6jxic04031tnt40va4dd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 105 +++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3d54316639a4..6c7025370ec0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3117,7 +3117,27 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 
 	return err;
 }
-#else
+
+static void trace__delete_augmented_syscalls(struct trace *trace)
+{
+	struct evsel *evsel, *tmp;
+
+	evlist__remove(trace->evlist, trace->syscalls.events.augmented);
+	evsel__delete(trace->syscalls.events.augmented);
+	trace->syscalls.events.augmented = NULL;
+
+	evlist__for_each_entry_safe(trace->evlist, tmp, evsel) {
+		if (evsel->bpf_obj == trace->bpf_obj) {
+			evlist__remove(trace->evlist, evsel);
+			evsel__delete(evsel);
+		}
+
+	}
+
+	bpf_object__close(trace->bpf_obj);
+	trace->bpf_obj = NULL;
+}
+#else // HAVE_LIBBPF_SUPPORT
 static int trace__set_ev_qualifier_bpf_filter(struct trace *trace __maybe_unused)
 {
 	return 0;
@@ -3138,8 +3158,27 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace __maybe_
 {
 	return 0;
 }
+
+static void trace__delete_augmented_syscalls(struct trace *trace __maybe_unused)
+{
+}
 #endif // HAVE_LIBBPF_SUPPORT
 
+static bool trace__only_augmented_syscalls_evsels(struct trace *trace)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(trace->evlist, evsel) {
+		if (evsel == trace->syscalls.events.augmented ||
+		    evsel->bpf_obj == trace->bpf_obj)
+			continue;
+
+		return false;
+	}
+
+	return true;
+}
+
 static int trace__set_ev_qualifier_filter(struct trace *trace)
 {
 	if (trace->syscalls.map)
@@ -3316,7 +3355,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	    perf_evlist__add_newtp(evlist, "sched", "sched_stat_runtime",
 				   trace__sched_stat_runtime))
 		goto out_error_sched_stat_runtime;
-
 	/*
 	 * If a global cgroup was set, apply it to all the events without an
 	 * explicit cgroup. I.e.:
@@ -4221,6 +4259,22 @@ int cmd_trace(int argc, const char **argv)
 
 	argc = parse_options_subcommand(argc, argv, trace_options, trace_subcommands,
 				 trace_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	/*
+	 * Here we already passed thru trace__parse_events_option() and it has
+	 * already figured out if -e syscall_name, if not but if --event
+	 * foo:bar was used, the user is interested _just_ in those, say,
+	 * tracepoint events, not in the strace-like syscall-name-based mode.
+	 *
+	 * This is important because we need to check if strace-like mode is
+	 * needed to decided if we should filter out the eBPF
+	 * __augmented_syscalls__ code, if it is in the mix, say, via
+	 * .perfconfig trace.add_events, and filter those out.
+	 */
+	if (!trace.trace_syscalls && !trace.trace_pgfaults &&
+	    trace.evlist->core.nr_entries == 0 /* Was --events used? */) {
+		trace.trace_syscalls = true;
+	}
 	/*
 	 * Now that we have --verbose figured out, lets see if we need to parse
 	 * events from .perfconfig, so that if those events fail parsing, say some
@@ -4265,9 +4319,45 @@ int cmd_trace(int argc, const char **argv)
 
 		trace.bpf_obj = evsel->bpf_obj;
 
-		trace__set_bpf_map_filtered_pids(&trace);
-		trace__set_bpf_map_syscalls(&trace);
-		trace.syscalls.unaugmented_prog = trace__find_bpf_program_by_title(&trace, "!raw_syscalls:unaugmented");
+		/*
+		 * If we have _just_ the augmenter event but don't have a
+		 * explicit --syscalls, then assume we want all strace-like
+		 * syscalls:
+		 */
+		if (!trace.trace_syscalls && trace__only_augmented_syscalls_evsels(&trace))
+			trace.trace_syscalls = true;
+		/*
+		 * So, if we have a syscall augmenter, but trace_syscalls, aka
+		 * strace-like syscall tracing is not set, then we need to trow
+		 * away the augmenter, i.e. all the events that were created
+		 * from that BPF object file.
+		 *
+		 * This is more to fix the current .perfconfig trace.add_events
+		 * style of setting up the strace-like eBPF based syscall point
+		 * payload augmenter.
+		 *
+		 * All this complexity will be avoided by adding an alternative
+		 * to trace.add_events in the form of
+		 * trace.bpf_augmented_syscalls, that will be only parsed if we
+		 * need it.
+		 *
+		 * .perfconfig trace.add_events is still useful if we want, for
+		 * instance, have msr_write.msr in some .perfconfig profile based
+		 * 'perf trace --config determinism.profile' mode, where for some
+		 * particular goal/workload type we want a set of events and
+		 * output mode (with timings, etc) instead of having to add
+		 * all via the command line.
+		 *
+		 * Also --config to specify an alternate .perfconfig file needs
+		 * to be implemented.
+		 */
+		if (!trace.trace_syscalls) {
+			trace__delete_augmented_syscalls(&trace);
+		} else {
+			trace__set_bpf_map_filtered_pids(&trace);
+			trace__set_bpf_map_syscalls(&trace);
+			trace.syscalls.unaugmented_prog = trace__find_bpf_program_by_title(&trace, "!raw_syscalls:unaugmented");
+		}
 	}
 
 	err = bpf__setup_stdout(trace.evlist);
@@ -4410,11 +4500,6 @@ int cmd_trace(int argc, const char **argv)
 	if (trace.summary_only)
 		trace.summary = trace.summary_only;
 
-	if (!trace.trace_syscalls && !trace.trace_pgfaults &&
-	    trace.evlist->core.nr_entries == 0 /* Was --events used? */) {
-		trace.trace_syscalls = true;
-	}
-
 	if (output_name != NULL) {
 		err = trace__open_output(&trace, output_name);
 		if (err < 0) {
-- 
2.21.0

