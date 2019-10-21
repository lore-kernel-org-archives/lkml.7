Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A63CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878DA20882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfJVAEa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387518AbfJVAE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxI-0004Af-EZ; Tue, 22 Oct 2019 01:19:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6F8D01C0489;
        Tue, 22 Oct 2019 01:19:13 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:12 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Add syscall failure stats to
 -s/--summary and -S/--with-summary
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-k7kh2muo5oeg56yx446hnw9v@git.kernel.org>
References: <tip-k7kh2muo5oeg56yx446hnw9v@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169995293.29376.742480029095675120.tip-bot2@tip-bot2>
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

Commit-ID:     8eded45fcd3420e0f08b1e7869781f0e12927637
Gitweb:        https://git.kernel.org/tip/8eded45fcd3420e0f08b1e7869781f0e12927637
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 14 Oct 2019 14:46:40 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 08:39:42 -03:00

perf trace: Add syscall failure stats to -s/--summary and -S/--with-summary

Just like strace has:

  # trace -s sleep 1

  Summary of events:

  sleep (32370), 80 events, 93.0%

    syscall            calls  errors  total       min       avg       max       stddev
                                      (msec)    (msec)    (msec)    (msec)        (%)
    --------------- --------  ------ -------- --------- --------- ---------     ------
    nanosleep              1      0  1000.402  1000.402  1000.402  1000.402      0.00%
    mmap                   8      0     0.023     0.002     0.003     0.004      8.49%
    close                  5      0     0.015     0.001     0.003     0.009     51.39%
    mprotect               4      0     0.014     0.002     0.003     0.005     16.95%
    openat                 3      0     0.013     0.003     0.004     0.005     14.29%
    munmap                 1      0     0.010     0.010     0.010     0.010      0.00%
    read                   4      0     0.005     0.001     0.001     0.002     16.83%
    brk                    4      0     0.004     0.001     0.001     0.002     20.82%
    access                 1      1     0.004     0.004     0.004     0.004      0.00%
    fstat                  3      0     0.003     0.001     0.001     0.001     12.17%
    lseek                  3      0     0.003     0.001     0.001     0.001     11.45%
    arch_prctl             2      1     0.002     0.001     0.001     0.001      2.30%
    execve                 1      0     0.000     0.000     0.000     0.000      0.00%

  #

  # perf trace -S sleep 1
         ?  ... [continued]: execve())             = 0
     0.028 brk(brk: NULL)                          = 0x559f5bd96000
     0.033 arch_prctl(option: 0x3001, arg2: 0x7ffda8b715a0) = -1 EINVAL (Invalid argument)
     0.046 access(filename: "/etc/ld.so.preload", mode: R) = -1 ENOENT (No such file or directory)
     0.055 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
     0.060 fstat(fd: 3, statbuf: 0x7ffda8b707a0)   = 0
     0.062 mmap(addr: NULL, len: 134346, prot: READ, flags: PRIVATE, fd: 3, off: 0) = 0x7f3aedfc4000
     0.066 close(fd: 3)                            = 0
     0.079 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) = 3
     0.085 read(fd: 3, buf: 0x7ffda8b70948, count: 832) = 832
     0.088 lseek(fd: 3, offset: 792, whence: SET)  = 792
     0.090 read(fd: 3, buf: 0x7ffda8b70810, count: 68) = 68
     0.093 fstat(fd: 3, statbuf: 0x7ffda8b707f0)   = 0
     0.095 mmap(addr: NULL, len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS) = 0x7f3aedfc2000
     0.101 lseek(fd: 3, offset: 792, whence: SET)  = 792
     0.103 read(fd: 3, buf: 0x7ffda8b70450, count: 68) = 68
     0.105 lseek(fd: 3, offset: 864, whence: SET)  = 864
     0.107 read(fd: 3, buf: 0x7ffda8b70470, count: 32) = 32
     0.110 mmap(addr: NULL, len: 1857472, prot: READ, flags: PRIVATE|DENYWRITE, fd: 3, off: 0) = 0x7f3aeddfc000
     0.114 mprotect(start: 0x7f3aede1e000, len: 1679360, prot: NONE) = 0
     0.121 mmap(addr: 0x7f3aede1e000, len: 1363968, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x22000) = 0x7f3aede1e000
     0.127 mmap(addr: 0x7f3aedf6b000, len: 311296, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000) = 0x7f3aedf6b000
     0.131 mmap(addr: 0x7f3aedfb8000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1bb000) = 0x7f3aedfb8000
     0.138 mmap(addr: 0x7f3aedfbe000, len: 14272, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7f3aedfbe000
     0.147 close(fd: 3)                            = 0
     0.158 arch_prctl(option: SET_FS, arg2: 0x7f3aedfc3580) = 0
     0.210 mprotect(start: 0x7f3aedfb8000, len: 16384, prot: READ) = 0
     0.230 mprotect(start: 0x559f5b27d000, len: 4096, prot: READ) = 0
     0.236 mprotect(start: 0x7f3aee00f000, len: 4096, prot: READ) = 0
     0.240 munmap(addr: 0x7f3aedfc4000, len: 134346) = 0
     0.300 brk(brk: NULL)                          = 0x559f5bd96000
     0.302 brk(brk: 0x559f5bdb7000)                = 0x559f5bdb7000
     0.305 brk(brk: NULL)                          = 0x559f5bdb7000
     0.310 openat(dfd: CWD, filename: "/usr/lib/locale/locale-archive", flags: RDONLY|CLOEXEC) = 3
     0.315 fstat(fd: 3, statbuf: 0x7f3aedfbdac0)   = 0
     0.318 mmap(addr: NULL, len: 217750512, prot: READ, flags: PRIVATE, fd: 3, off: 0) = 0x7f3ae0e52000
     0.325 close(fd: 3)                            = 0
     0.358 nanosleep(rqtp: 0x7ffda8b714b0, rmtp: NULL) = 0
  1000.622 close(fd: 1)                            = 0
  1000.641 close(fd: 2)                            = 0
  1000.664 exit_group(error_code: 0)               = ?

   Summary of events:

   sleep (722), 80 events, 93.0%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     nanosleep              1      0  1000.194  1000.194  1000.194  1000.194      0.00%
     mmap                   8      0     0.025     0.002     0.003     0.005     10.17%
     close                  5      0     0.018     0.001     0.004     0.010     50.18%
     mprotect               4      0     0.016     0.003     0.004     0.006     16.81%
     openat                 3      0     0.011     0.003     0.004     0.004      6.57%
     munmap                 1      0     0.010     0.010     0.010     0.010      0.00%
     brk                    4      0     0.005     0.001     0.001     0.002     20.72%
     read                   4      0     0.005     0.001     0.001     0.002     16.71%
     access                 1      1     0.005     0.005     0.005     0.005      0.00%
     fstat                  3      0     0.004     0.001     0.001     0.002     14.82%
     lseek                  3      0     0.003     0.001     0.001     0.001     11.66%
     arch_prctl             2      1     0.002     0.001     0.001     0.001      3.59%
     execve                 1      0     0.000     0.000     0.000     0.000      0.00%

  #

Works for system wide, e.g. for 1ms:

  # perf trace -s -a sleep 0.001

   Summary of events:

   sleep (768), 94 events, 37.9%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     nanosleep              1      0     1.133     1.133     1.133     1.133      0.00%
     execve                 7      6     0.351     0.003     0.050     0.316     88.53%
     mmap                   8      0     0.024     0.002     0.003     0.004      8.86%
     mprotect               4      0     0.017     0.003     0.004     0.006     16.02%
     openat                 3      0     0.013     0.004     0.004     0.005      8.34%
     munmap                 1      0     0.010     0.010     0.010     0.010      0.00%
     brk                    4      0     0.007     0.001     0.002     0.002     10.99%
     close                  5      0     0.005     0.001     0.001     0.002     11.69%
     read                   5      0     0.005     0.000     0.001     0.002     30.53%
     access                 1      1     0.004     0.004     0.004     0.004      0.00%
     fstat                  3      0     0.004     0.001     0.001     0.002     10.74%
     lseek                  3      0     0.003     0.001     0.001     0.001     10.20%
     arch_prctl             2      1     0.002     0.001     0.001     0.001      3.34%

   Web Content (21258), 46 events, 18.5%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     recvmsg               12     12     0.015     0.001     0.001     0.002      8.50%
     futex                  2      0     0.008     0.003     0.004     0.005     27.08%
     poll                   6      0     0.006     0.000     0.001     0.002     22.14%
     read                   2      0     0.006     0.002     0.003     0.003     26.08%
     write                  1      0     0.002     0.002     0.002     0.002      0.00%

   Web Content (4365), 36 events, 14.5%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     recvmsg               10     10     0.015     0.001     0.002     0.003     11.83%
     poll                   5      0     0.006     0.000     0.001     0.002     28.44%
     futex                  2      0     0.005     0.001     0.003     0.004     48.29%
     read                   1      0     0.003     0.003     0.003     0.003      0.00%

   Timer (21275), 14 events, 5.6%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     futex                  6      1     0.240     0.000     0.040     0.149     64.58%
     write                  1      0     0.008     0.008     0.008     0.008      0.00%

   Timer (4383), 14 events, 5.6%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     futex                  6      2     0.186     0.000     0.031     0.181     96.45%
     write                  1      0     0.010     0.010     0.010     0.010      0.00%

   Web Content (20354), 28 events, 11.3%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     recvmsg                8      8     0.010     0.001     0.001     0.002     15.24%
     poll                   4      0     0.004     0.000     0.001     0.002     35.68%
     futex                  1      0     0.003     0.003     0.003     0.003      0.00%
     read                   1      0     0.003     0.003     0.003     0.003      0.00%

   Timer (20371), 10 events, 4.0%

     syscall            calls  errors  total       min       avg       max       stddev
                                       (msec)    (msec)    (msec)    (msec)        (%)
     --------------- --------  ------ -------- --------- --------- ---------     ------
     futex                  4      1     0.077     0.000     0.019     0.075     95.46%
     write                  1      0     0.005     0.005     0.005     0.005      0.00%

  [root@quaco ~]#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-k7kh2muo5oeg56yx446hnw9v@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 58 +++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 144d417..56f2d72 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1958,11 +1958,16 @@ out_cant_read:
 	return NULL;
 }
 
+struct syscall_stats {
+	struct stats stats;
+	u64	     nr_failures;
+};
+
 static void thread__update_stats(struct thread_trace *ttrace,
-				 int id, struct perf_sample *sample)
+				 int id, struct perf_sample *sample, long err)
 {
 	struct int_node *inode;
-	struct stats *stats;
+	struct syscall_stats *stats;
 	u64 duration = 0;
 
 	inode = intlist__findnew(ttrace->syscall_stats, id);
@@ -1971,17 +1976,22 @@ static void thread__update_stats(struct thread_trace *ttrace,
 
 	stats = inode->priv;
 	if (stats == NULL) {
-		stats = malloc(sizeof(struct stats));
+		stats = malloc(sizeof(*stats));
 		if (stats == NULL)
 			return;
-		init_stats(stats);
+
+		stats->nr_failures = 0;
+		init_stats(&stats->stats);
 		inode->priv = stats;
 	}
 
 	if (ttrace->entry_time && sample->time > ttrace->entry_time)
 		duration = sample->time - ttrace->entry_time;
 
-	update_stats(stats, duration);
+	update_stats(&stats->stats, duration);
+
+	if (err < 0)
+		++stats->nr_failures;
 }
 
 static int trace__printf_interrupted_entry(struct trace *trace)
@@ -2226,11 +2236,11 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 
 	trace__fprintf_sample(trace, evsel, sample, thread);
 
-	if (trace->summary)
-		thread__update_stats(ttrace, id, sample);
-
 	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
 
+	if (trace->summary)
+		thread__update_stats(ttrace, id, sample, ret);
+
 	if (!trace->fd_path_disabled && sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
 		trace__set_fd_pathname(thread, ret, ttrace->filename.name);
 		ttrace->filename.pending_open = false;
@@ -4016,17 +4026,17 @@ static size_t trace__fprintf_threads_header(FILE *fp)
 }
 
 DEFINE_RESORT_RB(syscall_stats, a->msecs > b->msecs,
-	struct stats 	*stats;
-	double		msecs;
-	int		syscall;
+	struct syscall_stats *stats;
+	double		     msecs;
+	int		     syscall;
 )
 {
 	struct int_node *source = rb_entry(nd, struct int_node, rb_node);
-	struct stats *stats = source->priv;
+	struct syscall_stats *stats = source->priv;
 
 	entry->syscall = source->i;
 	entry->stats   = stats;
-	entry->msecs   = stats ? (u64)stats->n * (avg_stats(stats) / NSEC_PER_MSEC) : 0;
+	entry->msecs   = stats ? (u64)stats->stats.n * (avg_stats(&stats->stats) / NSEC_PER_MSEC) : 0;
 }
 
 static size_t thread__dump_stats(struct thread_trace *ttrace,
@@ -4042,26 +4052,26 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
 
 	printed += fprintf(fp, "\n");
 
-	printed += fprintf(fp, "   syscall            calls    total       min       avg       max      stddev\n");
-	printed += fprintf(fp, "                               (msec)    (msec)    (msec)    (msec)        (%%)\n");
-	printed += fprintf(fp, "   --------------- -------- --------- --------- --------- ---------     ------\n");
+	printed += fprintf(fp, "   syscall            calls  errors  total       min       avg       max       stddev\n");
+	printed += fprintf(fp, "                                     (msec)    (msec)    (msec)    (msec)        (%%)\n");
+	printed += fprintf(fp, "   --------------- --------  ------ -------- --------- --------- ---------     ------\n");
 
 	resort_rb__for_each_entry(nd, syscall_stats) {
-		struct stats *stats = syscall_stats_entry->stats;
+		struct syscall_stats *stats = syscall_stats_entry->stats;
 		if (stats) {
-			double min = (double)(stats->min) / NSEC_PER_MSEC;
-			double max = (double)(stats->max) / NSEC_PER_MSEC;
-			double avg = avg_stats(stats);
+			double min = (double)(stats->stats.min) / NSEC_PER_MSEC;
+			double max = (double)(stats->stats.max) / NSEC_PER_MSEC;
+			double avg = avg_stats(&stats->stats);
 			double pct;
-			u64 n = (u64) stats->n;
+			u64 n = (u64)stats->stats.n;
 
-			pct = avg ? 100.0 * stddev_stats(stats)/avg : 0.0;
+			pct = avg ? 100.0 * stddev_stats(&stats->stats) / avg : 0.0;
 			avg /= NSEC_PER_MSEC;
 
 			sc = &trace->syscalls.table[syscall_stats_entry->syscall];
 			printed += fprintf(fp, "   %-15s", sc->name);
-			printed += fprintf(fp, " %8" PRIu64 " %9.3f %9.3f %9.3f",
-					   n, syscall_stats_entry->msecs, min, avg);
+			printed += fprintf(fp, " %8" PRIu64 " %6" PRIu64 " %9.3f %9.3f %9.3f",
+					   n, stats->nr_failures, syscall_stats_entry->msecs, min, avg);
 			printed += fprintf(fp, " %9.3f %9.2f%%\n", max, pct);
 		}
 	}
