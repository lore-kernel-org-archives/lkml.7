Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9EFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BB92166E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665285;
	bh=NCqa5kDfdg9diKHbg5XzWi27W8i42Jsf97cMO0wx7qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KH0mAECNq8hi39nwDS7so0H25jKs5TjYPlGevs4S49SgvlCGGvIBmnar2z5dSjh7Z
	 4RAb/JPO/rx0PZ0ZUc80QuLZngdsgZbk0JoWGBeRpT5GRdF3I7zJvYSd2vll6kZ8M6
	 ns3A1wbZ4tDFxTh2+CDLZP9CHLix9gGd8fSl5xIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfJUNlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbfJUNlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B599214AE;
        Mon, 21 Oct 2019 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665276;
        bh=NCqa5kDfdg9diKHbg5XzWi27W8i42Jsf97cMO0wx7qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fv04R86Pr6MkNDnRTs3VfThuvAHProiZaTTfi7u6DpE9Pp7pJmdY//C+QeIdShwDD
         f4kbWae6RUwyPcrCAwlGn0DhQxWoidB0yCvSkHpLWjNtEMsTG//g+Jtet3drxMmXM+
         N8YH6SYHzbGT4MFjM8fLTzRa8+3AhFNwqfqpYSKQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 47/57] libperf: Add tests_mmap_thread test
Date:   Mon, 21 Oct 2019 10:38:24 -0300
Message-Id: <20191021133834.25998-48-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
 tools/perf/lib/tests/test-evlist.c | 119 +++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
index e6b2ab2e2bde..90a1869ba4b1 100644
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
-- 
2.21.0

