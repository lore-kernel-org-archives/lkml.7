Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E95C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AC120851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfCGSxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:53:46 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:48513 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGSxp (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 7 Mar 2019 13:53:45 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 07 Mar 2019 19:53:43 +0100
Received: from linux-r8p5.suse.cz (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Thu, 07 Mar 2019 18:53:21 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@kernel.org, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] tools/perf-bench: Add basic syscall benchmark
Date:   Thu,  7 Mar 2019 10:52:53 -0800
Message-Id: <20190307185253.28432-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usefulness of having a standard way of testing syscall performance
has come up from time to time[0]. Furthermore, some of our testing
machinery (such as 'mmtests') already makes use of a simplified version
of the microbenchmark. This patch mainly takes the same idea to measure
syscall throughput compatible with 'perf-bench' via getppid(2), yet
without any of the additional template stuff from Ingo's version (based
on numa.c). The code is identical to what mmtests uses.

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1067469.html

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/Build     |  1 +
 tools/perf/bench/bench.h   |  1 +
 tools/perf/bench/syscall.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c |  8 +++++
 4 files changed, 90 insertions(+)
 create mode 100644 tools/perf/bench/syscall.c

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index e4e321b6f883..839f9b790587 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -1,5 +1,6 @@
 perf-y += sched-messaging.o
 perf-y += sched-pipe.o
+perf-y += syscall.o
 perf-y += mem-functions.o
 perf-y += futex-hash.o
 perf-y += futex-wake.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index fddb3ced9db6..31ad3283d41b 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -29,6 +29,7 @@
 int bench_numa(int argc, const char **argv);
 int bench_sched_messaging(int argc, const char **argv);
 int bench_sched_pipe(int argc, const char **argv);
+int bench_syscall_basic(int argc, const char **argv);
 int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
 int bench_futex_hash(int argc, const char **argv);
diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
new file mode 100644
index 000000000000..149129cca639
--- /dev/null
+++ b/tools/perf/bench/syscall.c
@@ -0,0 +1,80 @@
+/*
+ *
+ * syscall.c
+ *
+ * syscall: Benchmark for system call performance
+ */
+#include "../perf.h"
+#include "../util/util.h"
+#include <subcmd/parse-options.h>
+#include "../builtin.h"
+#include "bench.h"
+
+#include <stdio.h>
+#include <locale.h>
+#include <sys/time.h>
+#include <sys/syscall.h>
+
+#define LOOPS_DEFAULT 10000000
+static	int loops = LOOPS_DEFAULT;
+
+static const struct option options[] = {
+	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
+	OPT_END()
+};
+
+static const char * const bench_syscall_usage[] = {
+	"perf bench syscall <options>",
+	NULL
+};
+
+int bench_syscall_basic(int argc, const char **argv)
+{
+	struct timeval start, stop, diff;
+	unsigned long long result_usec = 0;
+	int i;
+
+	argc = parse_options(argc, argv, options, bench_syscall_usage, 0);
+
+	gettimeofday(&start, NULL);
+
+	for (i = 0; i < loops; i++)
+		getppid();
+
+	gettimeofday(&stop, NULL);
+	timersub(&stop, &start, &diff);
+
+	switch (bench_format) {
+	case BENCH_FORMAT_DEFAULT:
+		setlocale(LC_NUMERIC, "");
+		printf("# Executed %'d getppid() calls\n", loops);
+
+		result_usec = diff.tv_sec * 1000000;
+		result_usec += diff.tv_usec;
+
+		printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
+		       diff.tv_sec,
+		       (unsigned long) (diff.tv_usec/1000));
+
+		printf(" %14lf usecs/op\n",
+		       (double)result_usec / (double)loops);
+		printf(" %'14d ops/sec\n",
+		       (int)((double)loops /
+			     ((double)result_usec / (double)1000000)));
+		break;
+
+	case BENCH_FORMAT_SIMPLE:
+		printf("%lu.%03lu\n",
+		       diff.tv_sec,
+		       (unsigned long) (diff.tv_usec / 1000));
+		break;
+
+	default:
+		/* reaching here is something disaster */
+		fprintf(stderr, "Unknown format:%d\n", bench_format);
+		exit(1);
+		break;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 334c77ffc1d9..4e9dd0f4eced 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -11,6 +11,7 @@
  * Available benchmark collection list:
  *
  *  sched ... scheduler and IPC performance
+ *  syscall ... System call performance
  *  mem   ... memory access performance
  *  numa  ... NUMA scheduling and MM performance
  *  futex ... Futex performance
@@ -50,6 +51,12 @@ static struct bench sched_benchmarks[] = {
 	{ NULL,		NULL,						NULL			}
 };
 
+static struct bench syscall_benchmarks[] = {
+	{ "basic",	"Benchmark for basic getppid() system calls",	bench_syscall_basic	},
+	{ "all",	"Run all syscall benchmarks",			NULL			},
+	{ NULL,		NULL,						NULL			},
+};
+
 static struct bench mem_benchmarks[] = {
 	{ "memcpy",	"Benchmark for memcpy() functions",		bench_mem_memcpy	},
 	{ "memset",	"Benchmark for memset() functions",		bench_mem_memset	},
@@ -85,6 +92,7 @@ struct collection {
 
 static struct collection collections[] = {
 	{ "sched",	"Scheduler and IPC benchmarks",			sched_benchmarks	},
+	{ "syscall",	"System call benchmarks",			syscall_benchmarks	},
 	{ "mem",	"Memory access benchmarks",			mem_benchmarks		},
 #ifdef HAVE_LIBNUMA_SUPPORT
 	{ "numa",	"NUMA scheduling and MM benchmarks",		numa_benchmarks		},
-- 
2.16.4

