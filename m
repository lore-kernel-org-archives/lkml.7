Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39FFC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3B4217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455695;
	bh=D5NeG7kNVxEEr2fKMRpiKJK8inR7pTy+TYFvaY1iUMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CV6lM589L+0SPAN5sX70rAiBo3oGftBhlpG77fQ+x0OiUWdXbxbUziwP+YQUYKDia
	 1PUiCiP1ZcG1Ssp1rplE9X+TG95Zq3AgKXxEWR+dZdEUC8tUcr7nFQj+kTYqcTR0dS
	 6YTgNru7v2LlaTGHAIa9pl3yOzMI/jgSPlsLkSJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbfG3DBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732607AbfG3DBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BE8F206DD;
        Tue, 30 Jul 2019 03:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455689;
        bh=D5NeG7kNVxEEr2fKMRpiKJK8inR7pTy+TYFvaY1iUMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCZZ3SN618vl9oCOrIr0f+WT/nyPsnaNtZoNYmIruHS6vI+G1m36Kzenz1TXc65ii
         0FB8HNqnSQQf4kgihzcU5GypubjEdCPgu+d5sqh6jxPmovZD5uwkhj+woj2E0/rLYh
         fh/eOTyNq8ru2X7iA9EFIaE4RjMdsc/qe1ZRLHC0=
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
Subject: [PATCH 091/107] libperf: Adopt perf_evsel__read() function from tools/perf
Date:   Mon, 29 Jul 2019 23:55:54 -0300
Message-Id: <20190730025610.22603-92-acme@kernel.org>
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

Move the perf_evsel__read() function to libperf as a public interface
together with struct perf_counts_values for returning counter values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-65-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c                  | 42 +++++++++++++++++++++++
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/lib/include/perf/evsel.h     | 14 ++++++++
 tools/perf/lib/libperf.map              |  1 +
 tools/perf/tests/event-times.c          |  2 +-
 tools/perf/util/counts.h                | 12 +------
 tools/perf/util/evsel.c                 | 45 ++-----------------------
 tools/perf/util/evsel.h                 |  3 --
 8 files changed, 62 insertions(+), 58 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 50f09e939229..390fcf9107c1 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -12,6 +12,7 @@
 #include <internal/xyarray.h>
 #include <internal/cpumap.h>
 #include <internal/threadmap.h>
+#include <internal/lib.h>
 #include <linux/string.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
@@ -137,3 +138,44 @@ void perf_evsel__close(struct perf_evsel *evsel)
 	perf_evsel__close_fd(evsel);
 	perf_evsel__free_fd(evsel);
 }
+
+int perf_evsel__read_size(struct perf_evsel *evsel)
+{
+	u64 read_format = evsel->attr.read_format;
+	int entry = sizeof(u64); /* value */
+	int size = 0;
+	int nr = 1;
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		size += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		size += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_ID)
+		entry += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_GROUP) {
+		nr = evsel->nr_members;
+		size += sizeof(u64);
+	}
+
+	size += entry * nr;
+	return size;
+}
+
+int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+		     struct perf_counts_values *count)
+{
+	size_t size = perf_evsel__read_size(evsel);
+
+	memset(count, 0, sizeof(*count));
+
+	if (FD(evsel, cpu, thread) < 0)
+		return -EINVAL;
+
+	if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
+		return -errno;
+
+	return 0;
+}
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 878e2cf41ffc..89bae3720d67 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -23,5 +23,6 @@ struct perf_evsel {
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__close_fd(struct perf_evsel *evsel);
 void perf_evsel__free_fd(struct perf_evsel *evsel);
+int perf_evsel__read_size(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index aa5c48f822d2..16ae3f873280 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -2,6 +2,7 @@
 #ifndef __LIBPERF_EVSEL_H
 #define __LIBPERF_EVSEL_H
 
+#include <stdint.h>
 #include <perf/core.h>
 
 struct perf_evsel;
@@ -9,6 +10,17 @@ struct perf_event_attr;
 struct perf_cpu_map;
 struct perf_thread_map;
 
+struct perf_counts_values {
+	union {
+		struct {
+			uint64_t val;
+			uint64_t ena;
+			uint64_t run;
+		};
+		uint64_t values[3];
+	};
+};
+
 LIBPERF_API void perf_evsel__init(struct perf_evsel *evsel,
 				  struct perf_event_attr *attr);
 LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
@@ -16,5 +28,7 @@ LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 				 struct perf_thread_map *threads);
 LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+				 struct perf_counts_values *count);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 0b90999dcdcb..2e23cf420cce 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -16,6 +16,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__init;
 		perf_evsel__open;
 		perf_evsel__close;
+		perf_evsel__read;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__init;
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 00adba86403b..714e3611352c 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -196,7 +196,7 @@ static int test_times(int (attach)(struct evlist *),
 
 	TEST_ASSERT_VAL("failed to detach", !detach(evlist));
 
-	perf_evsel__read(evsel, 0, 0, &count);
+	perf_evsel__read(&evsel->core, 0, 0, &count);
 
 	err = !(count.ena == count.run);
 
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index bbfac9ecf642..13430f353c19 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -3,17 +3,7 @@
 #define __PERF_COUNTS_H
 
 #include <internal/xyarray.h>
-
-struct perf_counts_values {
-	union {
-		struct {
-			u64 val;
-			u64 ena;
-			u64 run;
-		};
-		u64 values[3];
-	};
-};
+#include <perf/evsel.h>
 
 struct perf_counts {
 	s8			  scaled;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8d8ed36377f5..0957ec24f518 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1346,53 +1346,12 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 		*pscaled = scaled;
 }
 
-static int perf_evsel__read_size(struct evsel *evsel)
-{
-	u64 read_format = evsel->core.attr.read_format;
-	int entry = sizeof(u64); /* value */
-	int size = 0;
-	int nr = 1;
-
-	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-		size += sizeof(u64);
-
-	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-		size += sizeof(u64);
-
-	if (read_format & PERF_FORMAT_ID)
-		entry += sizeof(u64);
-
-	if (read_format & PERF_FORMAT_GROUP) {
-		nr = evsel->core.nr_members;
-		size += sizeof(u64);
-	}
-
-	size += entry * nr;
-	return size;
-}
-
-int perf_evsel__read(struct evsel *evsel, int cpu, int thread,
-		     struct perf_counts_values *count)
-{
-	size_t size = perf_evsel__read_size(evsel);
-
-	memset(count, 0, sizeof(*count));
-
-	if (FD(evsel, cpu, thread) < 0)
-		return -EINVAL;
-
-	if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
-		return -errno;
-
-	return 0;
-}
-
 static int
 perf_evsel__read_one(struct evsel *evsel, int cpu, int thread)
 {
 	struct perf_counts_values *count = perf_counts(evsel->counts, cpu, thread);
 
-	return perf_evsel__read(evsel, cpu, thread, count);
+	return perf_evsel__read(&evsel->core, cpu, thread, count);
 }
 
 static void
@@ -1453,7 +1412,7 @@ perf_evsel__read_group(struct evsel *leader, int cpu, int thread)
 {
 	struct perf_stat_evsel *ps = leader->stats;
 	u64 read_format = leader->core.attr.read_format;
-	int size = perf_evsel__read_size(leader);
+	int size = perf_evsel__read_size(&leader->core);
 	u64 *data = ps->group_data;
 
 	if (!(read_format & PERF_FORMAT_ID))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 03fc8edad492..57e315d8158e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -336,9 +336,6 @@ static inline bool perf_evsel__match2(struct evsel *e1,
 	 (a)->core.attr.type == (b)->core.attr.type &&	\
 	 (a)->core.attr.config == (b)->core.attr.config)
 
-int perf_evsel__read(struct evsel *evsel, int cpu, int thread,
-		     struct perf_counts_values *count);
-
 int perf_evsel__read_counter(struct evsel *evsel, int cpu, int thread);
 
 int __perf_evsel__read_on_cpu(struct evsel *evsel,
-- 
2.21.0

