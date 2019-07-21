Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E006CC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC08C2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708723;
	bh=lR9AZBbOMQ+V8e76odKG32jXAlHAlISTgE/bqJ1kdTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E0skGAaIiE+pj/Yzgh3IaYod782UJFXyezO8Qw9F86tuCRxk/BY+NwghcdmQscRYd
	 6HQJ7NdnSElQTcnshqKp78qDatTs4APrR5R9OVQ6Y3H3e9gl0qEH3aYkgu5b5iciB7
	 Fjrz4dhhQkhfjRzRDzt0Vr7N0mf8qzqYU+5oAQus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfGULcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:32:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:32:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0EAF308AA11;
        Sun, 21 Jul 2019 11:32:00 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 100545D9D3;
        Sun, 21 Jul 2019 11:31:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 64/79] libperf: Add perf_evsel__read function
Date:   Sun, 21 Jul 2019 13:24:51 +0200
Message-Id: <20190721112506.12306-65-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sun, 21 Jul 2019 11:32:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_evsel__read function into libperf as a public
interface together with struct perf_counts_values for
passing the counter values to the user.

Link: http://lkml.kernel.org/n/tip-1c012lnj5ksqtgtlol3iqxx3@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index 41104ac662b0..9f9312dc9dfe 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -3,12 +3,24 @@
 #define __LIBPERF_EVSEL_H
 
 #include <linux/perf_event.h>
+#include <stdint.h>
 #include <perf/core.h>
 
 struct perf_evsel;
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

