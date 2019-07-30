Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21289C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5382182B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455571;
	bh=k03r6OlCwNuID60dGPhqDy8NBrtOf/G52n8KbziPeAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ogNFSlQUxFPdtHu2zDdR5rAyH4yJ+0dbsjgFr3lQB5eYbYWOPAk3WV9+b1DK0Cecx
	 cfYZEMXgQ2l6ZvAHGiu3JDf2eBkdaMAuwEVHKzIOofmcLRm063WLdM3nAQxlkuWFr/
	 G6bZkBm6KRImy1POJID+vavm2GumpY6mnmtJrkSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbfG3C73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732186AbfG3C70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:59:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13FEA20578;
        Tue, 30 Jul 2019 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455565;
        bh=k03r6OlCwNuID60dGPhqDy8NBrtOf/G52n8KbziPeAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDJd9d20SOYB4y8jcN17JiwXTa0GQc2rfwRMhbn5v5VyEMw9xQgBAgAqKFmeYNrUu
         rcS11qBuS7W88XnBdFYnLlWzUrIxLOuNV/OAuhTArkJBoG3lSip6wDZOW+9X+2gLHi
         FTHk77xW8fuu4oT+Wp2o4levl9AOSq7YZGZ8YvBY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 056/107] libperf: Add perf_cpu_map__dummy_new() function
Date:   Mon, 29 Jul 2019 23:55:19 -0300
Message-Id: <20190730025610.22603-57-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move cpu_map__dummy_new() to libperf as perf_cpu_map__dummy_new() function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-30-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/cpumap.c              | 13 +++++++++++++
 tools/perf/lib/include/perf/cpumap.h |  4 ++++
 tools/perf/lib/libperf.map           |  1 +
 tools/perf/tests/sw-clock.c          |  2 +-
 tools/perf/tests/task-exit.c         |  2 +-
 tools/perf/util/cpumap.c             | 15 +--------------
 tools/perf/util/cpumap.h             |  2 +-
 tools/perf/util/evlist.c             |  2 +-
 tools/perf/util/evsel.c              |  2 +-
 9 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 86a199c26f20..80d587ab95aa 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -3,3 +3,16 @@
 #include <stdlib.h>
 #include <linux/refcount.h>
 #include <internal/cpumap.h>
+
+struct perf_cpu_map *perf_cpu_map__dummy_new(void)
+{
+	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
+
+	if (cpus != NULL) {
+		cpus->nr = 1;
+		cpus->map[0] = -1;
+		refcount_set(&cpus->refcnt, 1);
+	}
+
+	return cpus;
+}
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index 8355d3ce7d0c..fa1e5aa9d662 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -2,6 +2,10 @@
 #ifndef __LIBPERF_CPUMAP_H
 #define __LIBPERF_CPUMAP_H
 
+#include <perf/core.h>
+
 struct perf_cpu_map;
 
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
+
 #endif /* __LIBPERF_CPUMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 3536242c545c..65201c6cbe7e 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -1,6 +1,7 @@
 LIBPERF_0.0.1 {
 	global:
 		libperf_set_print;
+		perf_cpu_map__dummy_new;
 	local:
 		*;
 };
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index ba033a6e6c0f..c6d3f4488b73 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -56,7 +56,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	}
 	evlist__add(evlist, evsel);
 
-	cpus = cpu_map__dummy_new();
+	cpus = perf_cpu_map__dummy_new();
 	threads = thread_map__new_by_tid(getpid());
 	if (!cpus || !threads) {
 		err = -ENOMEM;
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index d17effdd55c8..c094fb8cc877 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -63,7 +63,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	 * perf_evlist__prepare_workload we'll fill in the only thread
 	 * we're monitoring, the one forked there.
 	 */
-	cpus = cpu_map__dummy_new();
+	cpus = perf_cpu_map__dummy_new();
 	threads = thread_map__new_by_tid(-1);
 	if (!cpus || !threads) {
 		err = -ENOMEM;
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 5eb4e1fbb877..acda9bfb4002 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -189,7 +189,7 @@ struct perf_cpu_map *cpu_map__new(const char *cpu_list)
 	else if (*cpu_list != '\0')
 		cpus = cpu_map__default_new();
 	else
-		cpus = cpu_map__dummy_new();
+		cpus = perf_cpu_map__dummy_new();
 invalid:
 	free(tmp_cpus);
 out:
@@ -256,19 +256,6 @@ size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
 #undef BUFSIZE
 }
 
-struct perf_cpu_map *cpu_map__dummy_new(void)
-{
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
-
-	if (cpus != NULL) {
-		cpus->nr = 1;
-		cpus->map[0] = -1;
-		refcount_set(&cpus->refcnt, 1);
-	}
-
-	return cpus;
-}
-
 struct perf_cpu_map *cpu_map__empty_new(int nr)
 {
 	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index c2ba9ae195f7..0ce3f6bd9449 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -6,13 +6,13 @@
 #include <stdbool.h>
 #include <linux/refcount.h>
 #include <internal/cpumap.h>
+#include <perf/cpumap.h>
 
 #include "perf.h"
 #include "util/debug.h"
 
 struct perf_cpu_map *cpu_map__new(const char *cpu_list);
 struct perf_cpu_map *cpu_map__empty_new(int nr);
-struct perf_cpu_map *cpu_map__dummy_new(void);
 struct perf_cpu_map *cpu_map__new_data(struct cpu_map_data *data);
 struct perf_cpu_map *cpu_map__read(FILE *file);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1bedec28e58f..461c1e68e9e7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1086,7 +1086,7 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
 		return -1;
 
 	if (target__uses_dummy_map(target))
-		cpus = cpu_map__dummy_new();
+		cpus = perf_cpu_map__dummy_new();
 	else
 		cpus = cpu_map__new(target->cpu_list);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5aeb7260c8e1..a389752840a9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1840,7 +1840,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		static struct perf_cpu_map *empty_cpu_map;
 
 		if (empty_cpu_map == NULL) {
-			empty_cpu_map = cpu_map__dummy_new();
+			empty_cpu_map = perf_cpu_map__dummy_new();
 			if (empty_cpu_map == NULL)
 				return -ENOMEM;
 		}
-- 
2.21.0

