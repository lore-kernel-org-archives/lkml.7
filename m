Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE14CA9EC9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD78B20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbfKEAZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:25:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:30774 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387440AbfKEAZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:25:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 16:25:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="213712864"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 04 Nov 2019 16:25:28 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0B19C300884; Mon,  4 Nov 2019 16:25:28 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 3/9] perf evlist: Maintain evlist->all_cpus
Date:   Mon,  4 Nov 2019 16:25:16 -0800
Message-Id: <20191105002522.83803-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191105002522.83803-1-andi@firstfloor.org>
References: <20191105002522.83803-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Maintain a cpumap in the evlist that is the union of all the cpus
of the events.

This needs a cpumap merge operation. To make the merge operation
work efficiently maintain the cpumap in a sorted state.

The sorting is also needed for the affinity loop changes later.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/lib/cpumap.c                  | 42 ++++++++++++++++++++++++
 tools/perf/lib/evlist.c                  |  1 +
 tools/perf/lib/include/internal/evlist.h |  1 +
 tools/perf/lib/include/perf/cpumap.h     |  2 ++
 4 files changed, 46 insertions(+)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 2ca1fafa620d..5ca26a9d318f 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -68,6 +68,11 @@ static struct perf_cpu_map *cpu_map__default_new(void)
 	return cpus;
 }
 
+static int cmp_int(const void *a, const void *b)
+{
+	return *(const int *)a - *(const int*)b;
+}
+
 static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
 {
 	size_t payload_size = nr_cpus * sizeof(int);
@@ -76,6 +81,7 @@ static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
 	if (cpus != NULL) {
 		cpus->nr = nr_cpus;
 		memcpy(cpus->map, tmp_cpus, payload_size);
+		qsort(cpus->map, nr_cpus, sizeof(int), cmp_int);
 		refcount_set(&cpus->refcnt, 1);
 	}
 
@@ -272,3 +278,39 @@ int perf_cpu_map__max(struct perf_cpu_map *map)
 
 	return max;
 }
+
+struct perf_cpu_map *perf_cpu_map__update(struct perf_cpu_map *orig,
+					  struct perf_cpu_map *other)
+{
+	int *tmp_cpus;
+	int tmp_len;
+	int i, j, k;
+	struct perf_cpu_map *merged;
+
+	if (!orig) {
+		perf_cpu_map__get(other);
+		return other;
+	}
+	if (orig->nr == other->nr &&
+	    !memcmp(orig->map, other->map, orig->nr * sizeof(int)))
+		return orig;
+	tmp_len = orig->nr + other->nr;
+	tmp_cpus = malloc(tmp_len * sizeof(int));
+	if (!tmp_cpus)
+		return NULL;
+	i = j = k = 0;
+	while (i < orig->nr && j < other->nr) {
+		if (orig->map[i] <= other->map[j])
+			tmp_cpus[k++] = orig->map[i++];
+		else
+			tmp_cpus[k++] = other->map[j++];
+	}
+	while (i < orig->nr)
+		tmp_cpus[k++] = orig->map[i++];
+	while (j < other->nr)
+		tmp_cpus[k++] = other->map[j++];
+	assert(k < tmp_len);
+	merged = cpu_map__trim_new(k, tmp_cpus);
+	free(tmp_cpus);
+	return merged;
+}
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 205ddbb80bc1..35a627283122 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -54,6 +54,7 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 
 	perf_thread_map__put(evsel->threads);
 	evsel->threads = perf_thread_map__get(evlist->threads);
+	evlist->all_cpus = perf_cpu_map__update(evlist->all_cpus, evsel->cpus);
 }
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index a2fbccf1922f..74dc8c3f0b66 100644
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
index ac9aa497f84a..dcf61da64267 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -12,6 +12,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
+LIBPERF_API struct perf_cpu_map *perf_cpu_map__update(struct perf_cpu_map *orig,
+						      struct perf_cpu_map *other);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
 LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
-- 
2.23.0

