Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FE0CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D6B2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbfJVAFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:05:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387667AbfJVAF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:05:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgwt-0003s6-Tt; Tue, 22 Oct 2019 01:18:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4C5801C0086;
        Tue, 22 Oct 2019 01:18:51 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:50 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add tests_mmap_thread test
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191017105918.20873-7-jolsa@kernel.org>
References: <20191017105918.20873-7-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157169993065.29376.8961532926431133463.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bd6b7736c1ed109f4d86f725e96a48fb81ce71f6
Gitweb:        https://git.kernel.org/tip/bd6b7736c1ed109f4d86f725e96a48fb81ce71f6
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 17 Oct 2019 12:59:14 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:01 -03:00

libperf: Add tests_mmap_thread test

Add mmaping tests that generates 100 prctl calls in monitored child
process and validates it gets 100 events in ring buffer.

Committer tests:

  # make -C tools/perf/lib tests
  make: Entering directory '/home/acme/git/perf/tools/perf/lib'
    LINK     test-cpumap-a
    LINK     test-threadmap-a
    LINK     test-evlist-a
    LINK     test-evsel-a
    LINK     test-cpumap-so
    LINK     test-threadmap-so
    LINK     test-evlist-so
    LINK     test-evsel-so
  running static:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  - running test-evsel.c...OK
  running dynamic:
  - running test-cpumap.c...OK
  - running test-threadmap.c...OK
  - running test-evlist.c...OK
  - running test-evsel.c...OK
  make: Leaving directory '/home/acme/git/perf/tools/perf/lib'
  #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/tests/test-evlist.c | 119 ++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+)

diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
index e6b2ab2..90a1869 100644
--- a/tools/perf/lib/tests/test-evlist.c
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -1,12 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <stdarg.h>
+#include <unistd.h>
+#include <stdlib.h>
 #include <linux/perf_event.h>
+#include <linux/limits.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/prctl.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <perf/evlist.h>
 #include <perf/evsel.h>
+#include <perf/mmap.h>
+#include <perf/event.h>
 #include <internal/tests.h>
+#include <api/fs/fs.h>
 
 static int libperf_print(enum libperf_print_level level,
 			 const char *fmt, va_list ap)
@@ -181,6 +190,115 @@ static int test_stat_thread_enable(void)
 	return 0;
 }
 
+static int test_mmap_thread(void)
+{
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_mmap *map;
+	struct perf_cpu_map *cpus;
+	struct perf_thread_map *threads;
+	struct perf_event_attr attr = {
+		.type             = PERF_TYPE_TRACEPOINT,
+		.sample_period    = 1,
+		.wakeup_watermark = 1,
+		.disabled         = 1,
+	};
+	char path[PATH_MAX];
+	int id, err, pid, go_pipe[2];
+	union perf_event *event;
+	char bf;
+	int count = 0;
+
+	snprintf(path, PATH_MAX, "%s/kernel/debug/tracing/events/syscalls/sys_enter_prctl/id",
+		 sysfs__mountpoint());
+
+	if (filename__read_int(path, &id)) {
+		fprintf(stderr, "error: failed to get tracepoint id: %s\n", path);
+		return -1;
+	}
+
+	attr.config = id;
+
+	err = pipe(go_pipe);
+	__T("failed to create pipe", err == 0);
+
+	fflush(NULL);
+
+	pid = fork();
+	if (!pid) {
+		int i;
+
+		read(go_pipe[0], &bf, 1);
+
+		/* Generate 100 prctl calls. */
+		for (i = 0; i < 100; i++)
+			prctl(0, 0, 0, 0, 0);
+
+		exit(0);
+	}
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	cpus = perf_cpu_map__dummy_new();
+	__T("failed to create cpus", cpus);
+
+	perf_thread_map__set_pid(threads, 0, pid);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, cpus, threads);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evlist", err == 0);
+
+	err = perf_evlist__mmap(evlist, 4);
+	__T("failed to mmap evlist", err == 0);
+
+	perf_evlist__enable(evlist);
+
+	/* kick the child and wait for it to finish */
+	write(go_pipe[1], &bf, 1);
+	waitpid(pid, NULL, 0);
+
+	/*
+	 * There's no need to call perf_evlist__disable,
+	 * monitored process is dead now.
+	 */
+
+	perf_evlist__for_each_mmap(evlist, map, false) {
+		if (perf_mmap__read_init(map) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(map)) != NULL) {
+			count++;
+			perf_mmap__consume(map);
+		}
+
+		perf_mmap__read_done(map);
+	}
+
+	/* calls perf_evlist__munmap/perf_evlist__close */
+	perf_evlist__delete(evlist);
+
+	perf_thread_map__put(threads);
+	perf_cpu_map__put(cpus);
+
+	/*
+	 * The generated prctl calls should match the
+	 * number of events in the buffer.
+	 */
+	__T("failed count", count == 100);
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	__T_START;
@@ -190,6 +308,7 @@ int main(int argc, char **argv)
 	test_stat_cpu();
 	test_stat_thread();
 	test_stat_thread_enable();
+	test_mmap_thread();
 
 	__T_OK;
 	return 0;
