Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8CAFA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41462214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571310006;
	bh=zpBpXGFC+94jDnDc1mLLHgM6VvWiRDsJEQCTOcIpWB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ca36e4UWYVez7zASBeCSC9PNGp5i5ajP+5D1I+IEBFKilqxMAJmu1AKfCpVxf/Q6L
	 iH1VL1vIKM8S8gZ+aU2E6+PbNxsnfTRMhPlcEWAHTkqck6NIrGLSbrHuVRUHvwbv2J
	 6eFO4f6Or8hoarhi2PpDLiULgxYaVUSk+66Mn3cY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409299AbfJQLAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:00:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409221AbfJQK7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:59:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B43EB305B41D;
        Thu, 17 Oct 2019 10:59:37 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71EFD5D713;
        Thu, 17 Oct 2019 10:59:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 06/10] libperf: Add tests_mmap_thread test
Date:   Thu, 17 Oct 2019 12:59:14 +0200
Message-Id: <20191017105918.20873-7-jolsa@kernel.org>
In-Reply-To: <20191017105918.20873-1-jolsa@kernel.org>
References: <20191017105918.20873-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 17 Oct 2019 10:59:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding mmaping tests that generates 100 prctl calls
in monitored child process and validates it gets
100 events in ring buffer.

Link: http://lkml.kernel.org/n/tip-5qzuxnmde9x6uojkysp3rldn@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

