Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B29C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CCE2084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfLDHyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:54:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56159 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfLDHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:54:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icPU3-0004YP-9y; Wed, 04 Dec 2019 08:54:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 89BE21C2651;
        Wed,  4 Dec 2019 08:53:55 +0100 (CET)
Date:   Wed, 04 Dec 2019 07:53:55 -0000
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf evlist: Maintain evlist->all_cpus
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121001522.180827-5-andi@firstfloor.org>
References: <20191121001522.180827-5-andi@firstfloor.org>
MIME-Version: 1.0
Message-ID: <157544603545.21853.16342096532124116230.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a2408a70368ade9c99de27da78d49416313b8833
Gitweb:        https://git.kernel.org/tip/a2408a70368ade9c99de27da78d49416313b8833
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Wed, 20 Nov 2019 16:15:14 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 29 Nov 2019 12:20:45 -03:00

perf evlist: Maintain evlist->all_cpus

Maintain a cpumap in the evlist that is the union of all the cpus of the
events.

This needs a cpumap merge operation, which is added together with tests.

v2:
Add tests for cpu map merge
Fix handling of duplicates
Rename _update to _merge
Factor out sorting.
Fix handling of NULL maps in merge

v3:
Add comments and empty lines to _merge

Committer testing:

  # perf test "Merge cpu map"
  52: Merge cpu map                                         : Ok
  #

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lore.kernel.org/lkml/20191121001522.180827-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/cpumap.c                  | 57 +++++++++++++++++++++++-
 tools/perf/lib/evlist.c                  |  1 +-
 tools/perf/lib/include/internal/evlist.h |  1 +-
 tools/perf/lib/include/perf/cpumap.h     |  2 +-
 tools/perf/tests/builtin-test.c          |  5 ++-
 tools/perf/tests/cpumap.c                | 16 ++++++-
 tools/perf/tests/tests.h                 |  1 +-
 7 files changed, 83 insertions(+)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index d81656b..f93f4e7 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -286,3 +286,60 @@ int perf_cpu_map__max(struct perf_cpu_map *map)
 
 	return max;
 }
+
+/*
+ * Merge two cpumaps
+ *
+ * orig either gets freed and replaced with a new map, or reused
+ * with no reference count change (similar to "realloc")
+ * other has its reference count increased.
+ */
+
+struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
+					 struct perf_cpu_map *other)
+{
+	int *tmp_cpus;
+	int tmp_len;
+	int i, j, k;
+	struct perf_cpu_map *merged;
+
+	if (!orig && !other)
+		return NULL;
+	if (!orig) {
+		perf_cpu_map__get(other);
+		return other;
+	}
+	if (!other)
+		return orig;
+	if (orig->nr == other->nr &&
+	    !memcmp(orig->map, other->map, orig->nr * sizeof(int)))
+		return orig;
+
+	tmp_len = orig->nr + other->nr;
+	tmp_cpus = malloc(tmp_len * sizeof(int));
+	if (!tmp_cpus)
+		return NULL;
+
+	/* Standard merge algorithm from wikipedia */
+	i = j = k = 0;
+	while (i < orig->nr && j < other->nr) {
+		if (orig->map[i] <= other->map[j]) {
+			if (orig->map[i] == other->map[j])
+				j++;
+			tmp_cpus[k++] = orig->map[i++];
+		} else
+			tmp_cpus[k++] = other->map[j++];
+	}
+
+	while (i < orig->nr)
+		tmp_cpus[k++] = orig->map[i++];
+
+	while (j < other->nr)
+		tmp_cpus[k++] = other->map[j++];
+	assert(k <= tmp_len);
+
+	merged = cpu_map__trim_new(k, tmp_cpus);
+	free(tmp_cpus);
+	perf_cpu_map__put(orig);
+	return merged;
+}
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 205ddbb..ae9e65a 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -54,6 +54,7 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 
 	perf_thread_map__put(evsel->threads);
 	evsel->threads = perf_thread_map__get(evlist->threads);
+	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
 }
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index a2fbccf..74dc8c3 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -18,6 +18,7 @@ struct perf_evlist {
 	int			 nr_entries;
 	bool			 has_user_cpus;
 	struct perf_cpu_map	*cpus;
+	struct perf_cpu_map	*all_cpus;
 	struct perf_thread_map	*threads;
 	int			 nr_mmaps;
 	size_t			 mmap_len;
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index ac9aa49..6a17ad7 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -12,6 +12,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
+						     struct perf_cpu_map *other);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7115aa3..82d19a8 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -260,6 +260,11 @@ static struct test generic_tests[] = {
 		.func = test__cpu_map_print,
 	},
 	{
+		.desc = "Merge cpu map",
+		.func = test__cpu_map_merge,
+	},
+
+	{
 		.desc = "Probe SDT events",
 		.func = test__sdt_event,
 	},
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 8a0d236..4ac5674 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -120,3 +120,19 @@ int test__cpu_map_print(struct test *test __maybe_unused, int subtest __maybe_un
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1-10,12-20,22-30,32-40"));
 	return 0;
 }
+
+int test__cpu_map_merge(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
+	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
+	struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
+	char buf[100];
+
+	TEST_ASSERT_VAL("failed to merge map: bad nr", c->nr == 5);
+	cpu_map__snprint(c, buf, sizeof(buf));
+	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
+	perf_cpu_map__put(a);
+	perf_cpu_map__put(b);
+	perf_cpu_map__put(c);
+	return 0;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 25aea38..4f9ae6a 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -98,6 +98,7 @@ int test__event_update(struct test *test, int subtest);
 int test__event_times(struct test *test, int subtest);
 int test__backward_ring_buffer(struct test *test, int subtest);
 int test__cpu_map_print(struct test *test, int subtest);
+int test__cpu_map_merge(struct test *test, int subtest);
 int test__sdt_event(struct test *test, int subtest);
 int test__is_printable_array(struct test *test, int subtest);
 int test__bitmap_print(struct test *test, int subtest);
