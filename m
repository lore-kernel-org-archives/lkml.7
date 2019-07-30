Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA88C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1805420679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BcZGa4s7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbfG3Szr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:55:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45741 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbfG3Szr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:55:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UItYrl3336688
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:55:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UItYrl3336688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512934;
        bh=7HpGjktDh9LvhgF8NYuofjbDXp+Vk+Zs4G8uBvkk3MQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BcZGa4s7KJSIJiNwkQR8sAMJeGIj0t6RF6eUy+hQ+X7+O6Ttjj2FNBOu2Omv1IDBB
         GTrpxdZucOEYkiUkBLQiiYpWDfylZ5WDXZG5Y16Hb0Ce5gTHueWdg+FYR/C3QlCumw
         HHlKN1GgD0HdawfLKt3fXzRWKMK2pAjPj0w8K8F0XDf3nu3YmgxPQK/KOAehw5OuRG
         osu5Nd9aTRG+3ENCBYtO9jVQt8yzaZq4IguQKjcco6Gmduy4ma0y2/cf7AEci9Yu2Y
         miMtQEa9mjiaR2w/3W9MqMuHTUQlwRAKDc6oB/WFDXTa9QdgcbXZNIo4mOQDwFKdqo
         ILLCDJdOCdDTw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UItXhp3336685;
        Tue, 30 Jul 2019 11:55:33 -0700
Date:   Tue, 30 Jul 2019 11:55:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5c30af92f2b1e9d844e1ae3243e4adcd7753d4c1@git.kernel.org>
Cc:     ak@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        mpetlan@redhat.com, jolsa@kernel.org, peterz@infradead.org,
        namhyung@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        alexey.budankov@linux.intel.com
Reply-To: ak@linux.intel.com, acme@redhat.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          mpetlan@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
          peterz@infradead.org, alexey.budankov@linux.intel.com,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190721112506.12306-65-jolsa@kernel.org>
References: <20190721112506.12306-65-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Adopt perf_evsel__read() function from
 tools/perf
Git-Commit-ID: 5c30af92f2b1e9d844e1ae3243e4adcd7753d4c1
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5c30af92f2b1e9d844e1ae3243e4adcd7753d4c1
Gitweb:     https://git.kernel.org/tip/5c30af92f2b1e9d844e1ae3243e4adcd7753d4c1
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:51 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Adopt perf_evsel__read() function from tools/perf

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
 tools/perf/lib/evsel.c                  | 42 ++++++++++++++++++++++++++++++
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/lib/include/perf/evsel.h     | 14 ++++++++++
 tools/perf/lib/libperf.map              |  1 +
 tools/perf/tests/event-times.c          |  2 +-
 tools/perf/util/counts.h                | 12 +--------
 tools/perf/util/evsel.c                 | 45 ++-------------------------------
 tools/perf/util/evsel.h                 |  3 ---
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
