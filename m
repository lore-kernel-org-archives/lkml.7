Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F6CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D9720661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCHSR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:17:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:50770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfCHSR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:17:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28613ACF8;
        Fri,  8 Mar 2019 18:17:55 +0000 (UTC)
Date:   Fri, 8 Mar 2019 10:17:47 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] tools/perf-bench: Add basic syscall benchmark
Message-ID: <20190308181747.l36zqz2avtivrr3c@linux-r8p5>
References: <20190307185253.28432-1-dave@stgolabs.net>
 <20190307191157.GB32240@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190307191157.GB32240@kernel.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Mar 2019, Arnaldo Carvalho de Melo wrote:
>You forgot to update tools/perf/Documentation/perf-bench.txt, and please
>take a look at tools/perf/util/pmu.c convert_scale() to see how to save
>the current locale, set the one you want, then restore the previous one,
>so that at the end of this benchmark the environment is back to where it
>was.

Here's an updated version with the corresponding docs, but I removed the
setlocale() - doesn't seem worth it; I hope Mel has no strong objection.

Thanks.

-------8<----------------------------------------------------------
[PATCH v2] tools/perf-bench: Add basic syscall benchmark

The usefulness of having a standard way of testing syscall performance
has come up from time to time[0]. Furthermore, some of our testing
machinery (such as 'mmtests') already makes use of a simplified version
of the microbenchmark. This patch mainly takes the same idea to measure
syscall throughput compatible with 'perf-bench' via getppid(2), yet
without any of the additional template stuff from Ingo's version (based
on numa.c). The code is identical to what mmtests uses.

[0] https://lore.kernel.org/lkml/20160201074156.GA27156@gmail.com/

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/Documentation/perf-bench.txt | 11 +++++
 tools/perf/bench/Build                  |  1 +
 tools/perf/bench/bench.h                |  1 +
 tools/perf/bench/syscall.c              | 78 +++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c              |  8 ++++
 5 files changed, 99 insertions(+)
 create mode 100644 tools/perf/bench/syscall.c

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 0921a3c67381..8093cafc530a 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -49,6 +49,9 @@ SUBSYSTEM
 'sched'::
 	Scheduler and IPC mechanisms.
 
+'syscall'::
+	System call performance (throughput).
+
 'mem'::
 	Memory access performance.
 
@@ -134,6 +137,14 @@ Example of *pipe*
                 59004 ops/sec
 ---------------------
 
+SUITES FOR 'syscall'
+~~~~~~~~~~~~~~~~~~
+*basic*::
+Suite for evaluating performance of core system call throughput (both usecs/op and ops/sec metrics).
+This uses a single thread simply doing getppid(2), which is a simple syscall where the result is not
+cached by glibc.
+
+
 SUITES FOR 'mem'
 ~~~~~~~~~~~~~~~~
 *memcpy*::
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
index 000000000000..409f84a4fe4f
--- /dev/null
+++ b/tools/perf/bench/syscall.c
@@ -0,0 +1,78 @@
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
index 334c77ffc1d9..017029765404 100644
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
+	{ "basic",	"Benchmark for basic getppid(2) calls",		bench_syscall_basic	},
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

