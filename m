Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4ACCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBA6214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665333;
	bh=Zwl3pQ9O3p+VGC4AQ/ycgZEmApWIil1oIONXPb6yYIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q1riBJnDQAV1s52uI9ihafAbXPwCTrLmcSYEsNmIf4GX0qWxhxRmdRO4b5FY81SAK
	 J7pEkczsplKzBV9lyr9+JDTNxhb48+V+EbImHh4Qaw3HCClE1NzI1rjiclXNBsuFQD
	 UnDLH+nxwM8/HXmWqq5S+mcDAY7ubzTU6Dnm8nns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfJUNmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbfJUNlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:21 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22C01217D7;
        Mon, 21 Oct 2019 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665280;
        bh=Zwl3pQ9O3p+VGC4AQ/ycgZEmApWIil1oIONXPb6yYIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gi9tWJZ5OGcHo48hSnt6i9lF/L71xAwhNxV3ovBWR0H0/CnlOdzO/aB8cUljhyxyE
         Z59Wv4EsYGJGCJklpRovk3iVjnJNoNmB2zKGC/FvRWoKEDscsTXKvJUTi9SGN0JEuh
         dE78AFs+ZTn8yQ5yZExmbbEyWwBMMJAzWKcik70Y=
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
Subject: [PATCH 48/57] libperf: Add tests_mmap_cpus test
Date:   Mon, 21 Oct 2019 10:38:25 -0300
Message-Id: <20191021133834.25998-49-acme@kernel.org>
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

Add mmaping tests that generates prctl call on every cpu validates it
gets all the related events in ring buffer.

Committer testing:

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
Link: http://lore.kernel.org/lkml/20191017105918.20873-8-jolsa@kernel.org
[ Added _GNU_SOURCE define for sched.h to get sched_[gs]et_affinity
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/tests/test-evlist.c | 98 ++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
index 90a1869ba4b1..741bc1bb4524 100644
--- a/tools/perf/lib/tests/test-evlist.c
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
+#include <sched.h>
 #include <stdio.h>
 #include <stdarg.h>
 #include <unistd.h>
@@ -299,6 +301,101 @@ static int test_mmap_thread(void)
 	return 0;
 }
 
+static int test_mmap_cpus(void)
+{
+	struct perf_evlist *evlist;
+	struct perf_evsel *evsel;
+	struct perf_mmap *map;
+	struct perf_cpu_map *cpus;
+	struct perf_event_attr attr = {
+		.type             = PERF_TYPE_TRACEPOINT,
+		.sample_period    = 1,
+		.wakeup_watermark = 1,
+		.disabled         = 1,
+	};
+	cpu_set_t saved_mask;
+	char path[PATH_MAX];
+	int id, err, cpu, tmp;
+	union perf_event *event;
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
+	cpus = perf_cpu_map__new(NULL);
+	__T("failed to create cpus", cpus);
+
+	evlist = perf_evlist__new();
+	__T("failed to create evlist", evlist);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel1", evsel);
+
+	perf_evlist__add(evlist, evsel);
+
+	perf_evlist__set_maps(evlist, cpus, NULL);
+
+	err = perf_evlist__open(evlist);
+	__T("failed to open evlist", err == 0);
+
+	err = perf_evlist__mmap(evlist, 4);
+	__T("failed to mmap evlist", err == 0);
+
+	perf_evlist__enable(evlist);
+
+	err = sched_getaffinity(0, sizeof(saved_mask), &saved_mask);
+	__T("sched_getaffinity failed", err == 0);
+
+	perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
+		cpu_set_t mask;
+
+		CPU_ZERO(&mask);
+		CPU_SET(cpu, &mask);
+
+		err = sched_setaffinity(0, sizeof(mask), &mask);
+		__T("sched_setaffinity failed", err == 0);
+
+		prctl(0, 0, 0, 0, 0);
+	}
+
+	err = sched_setaffinity(0, sizeof(saved_mask), &saved_mask);
+	__T("sched_setaffinity failed", err == 0);
+
+	perf_evlist__disable(evlist);
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
+	/*
+	 * The generated prctl events should match the
+	 * number of cpus or be bigger (we are system-wide).
+	 */
+	__T("failed count", count >= perf_cpu_map__nr(cpus));
+
+	perf_cpu_map__put(cpus);
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	__T_START;
@@ -309,6 +406,7 @@ int main(int argc, char **argv)
 	test_stat_thread();
 	test_stat_thread_enable();
 	test_mmap_thread();
+	test_mmap_cpus();
 
 	__T_OK;
 	return 0;
-- 
2.21.0

