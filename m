Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D40C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D2F20640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381215;
	bh=kO5cLL7fZq3pQ8qCHzRLCLzATqGSVGA08QdoUphbeks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zgYHu+isM507KMwbWZqlqFo/mjw3P05C3qBmpgYArpEC6HYNpbbLl1HlKM0F/maIf
	 PFbo7lkwa9kFzcHCBC+YJ5JpUmRpQE7GP5Pj3o7uBZDeclw4k8LaZILb5Mwos5i3l4
	 0b5oGYps6SoxYliNU3bLgOAMZ8d8RG3S8wC+utAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403868AbfIMN0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390764AbfIMN0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A1B510C0922;
        Fri, 13 Sep 2019 13:26:45 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 853995C1D4;
        Fri, 13 Sep 2019 13:26:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 70/73] libperf: Add tests_mmap_cpus test
Date:   Fri, 13 Sep 2019 15:23:52 +0200
Message-Id: <20190913132355.21634-71-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Fri, 13 Sep 2019 13:26:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding mmaping tests that generates prctl call on
every cpu validates it gets all the related events
in ring buffer.

Link: http://lkml.kernel.org/n/tip-9qdckblmgjm42ofd7haflso0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/tests/test-evlist.c | 97 ++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tools/perf/lib/tests/test-evlist.c b/tools/perf/lib/tests/test-evlist.c
index aa90e8d40738..2b7271130223 100644
--- a/tools/perf/lib/tests/test-evlist.c
+++ b/tools/perf/lib/tests/test-evlist.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
+#include <sched.h>
 #include <stdarg.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -299,6 +300,101 @@ static int test_mmap_thread(void)
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
+	perf_evlist__for_each_mmap(evlist, map) {
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
@@ -309,6 +405,7 @@ int main(int argc, char **argv)
 	test_stat_thread();
 	test_stat_thread_enable();
 	test_mmap_thread();
+	test_mmap_cpus();
 
 	__T_OK;
 	return 0;
-- 
2.21.0

