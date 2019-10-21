Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9AACA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049DF222D0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbfJVAEI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbfJVAEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxL-0004AS-6b; Tue, 22 Oct 2019 01:19:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B4F6B1C04D3;
        Tue, 22 Oct 2019 01:19:12 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:12 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Introduce --errno-summary
Cc:     Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-l0mjwczkpouov7lss5zn8d9h@git.kernel.org>
References: <tip-l0mjwczkpouov7lss5zn8d9h@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169995239.29376.16166469454124144119.tip-bot2@tip-bot2>
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

Commit-ID:     b88b14db21dbcd04a5d262b96613bfdd005341a7
Gitweb:        https://git.kernel.org/tip/b88b14db21dbcd04a5d262b96613bfdd005341a7
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 14 Oct 2019 15:32:40 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 13:03:49 -03:00

perf trace: Introduce --errno-summary

To be used with -S or -s, using just this new option implies -s,
examples:

  # perf trace --errno-summary sleep 1

   Summary of events:

   sleep (10793), 80 events, 93.0%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     nanosleep              1      0  1000.427  1000.427  1000.427  1000.427      0.00%
     mmap                   8      0     0.026     0.002     0.003     0.005      9.18%
     close                  5      0     0.018     0.001     0.004     0.009     48.97%
     mprotect               4      0     0.017     0.003     0.004     0.006     16.49%
     openat                 3      0     0.012     0.003     0.004     0.005      9.41%
     munmap                 1      0     0.010     0.010     0.010     0.010      0.00%
     brk                    4      0     0.005     0.001     0.001     0.002     22.77%
     read                   4      0     0.005     0.001     0.001     0.002     22.33%
     access                 1      1     0.004     0.004     0.004     0.004      0.00%
  				ENOENT: 1
     fstat                  3      0     0.004     0.001     0.001     0.002     17.18%
     lseek                  3      0     0.003     0.001     0.001     0.001     11.62%
     arch_prctl             2      1     0.002     0.001     0.001     0.001      3.32%
  				EINVAL: 1
     execve                 1      0     0.000     0.000     0.000     0.000      0.00%

  #

Works as well together with --failure and -S, i.e. collect the stats and
show just the syscalls that failed:

  # perf trace --failure -S --errno-summary sleep 1
       0.032 arch_prctl(option: 0x3001, arg2: 0x7fffdb11b580) = -1 EINVAL (Invalid argument)
       0.045 access(filename: "/etc/ld.so.preload", mode: R) = -1 ENOENT (No such file or directory)

   Summary of events:

   sleep (10806), 80 events, 93.0%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     nanosleep              1      0  1000.094  1000.094  1000.094  1000.094      0.00%
     mmap                   8      0     0.026     0.002     0.003     0.005      9.06%
     close                  5      0     0.018     0.001     0.004     0.010     49.58%
     mprotect               4      0     0.017     0.003     0.004     0.006     17.56%
     openat                 3      0     0.014     0.004     0.005     0.006     12.29%
     munmap                 1      0     0.010     0.010     0.010     0.010      0.00%
     brk                    4      0     0.005     0.001     0.001     0.002     22.75%
     read                   4      0     0.005     0.001     0.001     0.002     17.19%
     access                 1      1     0.005     0.005     0.005     0.005      0.00%
  				ENOENT: 1
     fstat                  3      0     0.004     0.001     0.001     0.002     21.66%
     lseek                  3      0     0.003     0.001     0.001     0.001     11.71%
     arch_prctl             2      1     0.002     0.001     0.001     0.001      2.66%
  				EINVAL: 1
     execve                 1      0     0.000     0.000     0.000     0.000      0.00%

  #

Suggested-by: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-l0mjwczkpouov7lss5zn8d9h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt |  4 ++-
 tools/perf/builtin-trace.c              | 51 ++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 3bb89c2..abc9b5d 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -146,6 +146,10 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	Show all syscalls followed by a summary by thread with min, max, and
     average times (in msec) and relative stddev.
 
+--errno-summary::
+	To be used with -s or -S, to show stats for the errnos experienced by
+	syscalls, using only this option will trigger --summary.
+
 --tool_stats::
 	Show tool stats such as number of times fd->pathname was discovered thru
 	hooking the open syscall return + vfs_getname or via reading /proc/pid/fd, etc.
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 56f2d72..467e18e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -175,6 +175,7 @@ struct trace {
 	bool			multiple_threads;
 	bool			summary;
 	bool			summary_only;
+	bool			errno_summary;
 	bool			failure_only;
 	bool			show_comm;
 	bool			print_sample;
@@ -1961,10 +1962,12 @@ out_cant_read:
 struct syscall_stats {
 	struct stats stats;
 	u64	     nr_failures;
+	int	     max_errno;
+	u32	     *errnos;
 };
 
-static void thread__update_stats(struct thread_trace *ttrace,
-				 int id, struct perf_sample *sample, long err)
+static void thread__update_stats(struct thread *thread, struct thread_trace *ttrace,
+				 int id, struct perf_sample *sample, long err, bool errno_summary)
 {
 	struct int_node *inode;
 	struct syscall_stats *stats;
@@ -1981,6 +1984,8 @@ static void thread__update_stats(struct thread_trace *ttrace,
 			return;
 
 		stats->nr_failures = 0;
+		stats->max_errno   = 0;
+		stats->errnos	   = NULL;
 		init_stats(&stats->stats);
 		inode->priv = stats;
 	}
@@ -1990,8 +1995,30 @@ static void thread__update_stats(struct thread_trace *ttrace,
 
 	update_stats(&stats->stats, duration);
 
-	if (err < 0)
+	if (err < 0) {
 		++stats->nr_failures;
+
+		if (!errno_summary)
+			return;
+
+		err = -err;
+		if (err > stats->max_errno) {
+			u32 *new_errnos = realloc(stats->errnos, err * sizeof(u32));
+
+			if (new_errnos) {
+				memset(new_errnos + stats->max_errno, 0, (err - stats->max_errno) * sizeof(u32));
+			} else {
+				pr_debug("Not enough memory for errno stats for thread \"%s\"(%d/%d), results will be incomplete\n",
+					 thread__comm_str(thread), thread->pid_, thread->tid);
+				return;
+			}
+
+			stats->errnos = new_errnos;
+			stats->max_errno = err;
+		}
+
+		++stats->errnos[err - 1];
+	}
 }
 
 static int trace__printf_interrupted_entry(struct trace *trace)
@@ -2239,7 +2266,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
 
 	if (trace->summary)
-		thread__update_stats(ttrace, id, sample, ret);
+		thread__update_stats(thread, ttrace, id, sample, ret, trace->errno_summary);
 
 	if (!trace->fd_path_disabled && sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
 		trace__set_fd_pathname(thread, ret, ttrace->filename.name);
@@ -4073,6 +4100,16 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
 			printed += fprintf(fp, " %8" PRIu64 " %6" PRIu64 " %9.3f %9.3f %9.3f",
 					   n, stats->nr_failures, syscall_stats_entry->msecs, min, avg);
 			printed += fprintf(fp, " %9.3f %9.2f%%\n", max, pct);
+
+			if (trace->errno_summary && stats->nr_failures) {
+				const char *arch_name = perf_env__arch(trace->host->env);
+				int e;
+
+				for (e = 0; e < stats->max_errno; ++e) {
+					if (stats->errnos[e] != 0)
+						fprintf(fp, "\t\t\t\t%s: %d\n", arch_syscalls__strerrno(arch_name, e + 1), stats->errnos[e]);
+				}
+			}
 		}
 	}
 
@@ -4511,6 +4548,8 @@ int cmd_trace(int argc, const char **argv)
 		    "Show only syscall summary with statistics"),
 	OPT_BOOLEAN('S', "with-summary", &trace.summary,
 		    "Show all syscalls and summary with statistics"),
+	OPT_BOOLEAN(0, "errno-summary", &trace.errno_summary,
+		    "Show errno stats per syscall, use with -s or -S"),
 	OPT_CALLBACK_DEFAULT('F', "pf", &trace.trace_pgfaults, "all|maj|min",
 		     "Trace pagefaults", parse_pagefaults, "maj"),
 	OPT_BOOLEAN(0, "syscalls", &trace.trace_syscalls, "Trace syscalls"),
@@ -4816,6 +4855,10 @@ init_augmented_syscall_tp:
 	if ((argc >= 1) && (strcmp(argv[0], "record") == 0))
 		return trace__record(&trace, argc-1, &argv[1]);
 
+	/* Using just --errno-summary will trigger --summary */
+	if (trace.errno_summary && !trace.summary && !trace.summary_only)
+		trace.summary_only = true;
+
 	/* summary_only implies summary option, but don't overwrite summary if set */
 	if (trace.summary_only)
 		trace.summary = trace.summary_only;
