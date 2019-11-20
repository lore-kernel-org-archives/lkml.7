Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D4DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71151223D1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfKTJjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:39:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:28148 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbfKTJjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:39:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 01:39:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,221,1571727600"; 
   d="scan'208";a="289891302"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2019 01:39:00 -0800
Received: from [10.249.33.94] (abudanko-mobl.ccr.corp.intel.com [10.249.33.94])
        by linux.intel.com (Postfix) with ESMTP id 96F7B5804A0;
        Wed, 20 Nov 2019 01:38:58 -0800 (PST)
Subject: [PATCH v1 3/3] perf record: adapt affinity to machines with #CPUs >
 1K
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <26d1512a-9dea-bf7e-d18e-705846a870c4@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2561f736-bdb5-a10a-1a5d-590ad499ce49@linux.intel.com>
Date:   Wed, 20 Nov 2019 12:38:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <26d1512a-9dea-bf7e-d18e-705846a870c4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Use struct mmap_cpu_mask type for tool's thread and mmap data
buffers to overcome current 1024 CPUs mask size limitation of
cpu_set_t type.

Currently glibc cpu_set_t type has internal mask size limit
of 1024 CPUs. Moving to struct mmap_cpu_mask type allows
overcoming that limit. tools bitmap API is used to manipulate
objects of struct mmap_cpu_mask type.

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 28 ++++++++++++++++++++++------
 tools/perf/util/mmap.c      | 28 ++++++++++++++++++++++------
 tools/perf/util/mmap.h      |  2 +-
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b95c000c1ed9..238688516bc8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -62,6 +62,7 @@
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
+#include <linux/bitmap.h>
 
 struct switch_output {
 	bool		 enabled;
@@ -93,7 +94,7 @@ struct record {
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
-	cpu_set_t		affinity_mask;
+	struct mmap_cpu_mask	affinity_mask;
 	unsigned long		output_max_size;	/* = 0: unlimited */
 };
 
@@ -951,13 +952,21 @@ static struct perf_event_header finished_round_event = {
 	.type = PERF_RECORD_FINISHED_ROUND,
 };
 
+#define MASK_SIZE 1023
 static void record__adjust_affinity(struct record *rec, struct mmap *map)
 {
+	char mask[MASK_SIZE + 1] = {0};
+
 	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
-	    !CPU_EQUAL(&rec->affinity_mask, &map->affinity_mask)) {
-		CPU_ZERO(&rec->affinity_mask);
-		CPU_OR(&rec->affinity_mask, &rec->affinity_mask, &map->affinity_mask);
-		sched_setaffinity(0, sizeof(rec->affinity_mask), &rec->affinity_mask);
+	    !bitmap_equal(rec->affinity_mask.bits, map->affinity_mask.bits,
+			  rec->affinity_mask.nbits)) {
+		bitmap_zero(rec->affinity_mask.bits, rec->affinity_mask.nbits);
+		bitmap_or(rec->affinity_mask.bits, rec->affinity_mask.bits,
+			  map->affinity_mask.bits, rec->affinity_mask.nbits);
+		sched_setaffinity(0, mmap_cpu_mask_bytes(&rec->affinity_mask),
+				  (cpu_set_t *)rec->affinity_mask.bits);
+		bitmap_scnprintf(rec->affinity_mask.bits, rec->affinity_mask.nbits, mask, MASK_SIZE);
+		pr_debug("thread mask[%ld]: %s\n", rec->affinity_mask.nbits, mask);
 	}
 }
 
@@ -2389,7 +2398,6 @@ int cmd_record(int argc, const char **argv)
 # undef REASON
 #endif
 
-	CPU_ZERO(&rec->affinity_mask);
 	rec->opts.affinity = PERF_AFFINITY_SYS;
 
 	rec->evlist = evlist__new();
@@ -2405,6 +2413,14 @@ int cmd_record(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
+	rec->affinity_mask.nbits = cpu__max_cpu();
+	rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
+	if (!rec->affinity_mask.bits) {
+		pr_err("Failed to allocate thread mask for %ld cpus\n", rec->affinity_mask.nbits);
+		return -ENOMEM;
+	}
+	pr_debug("thread mask[%ld]: empty\n", rec->affinity_mask.nbits);
+
 	/* Make system wide (-a) the default target. */
 	if (!argc && target__none(&rec->opts.target))
 		rec->opts.target.system_wide = true;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 063d1b93c53d..070b1873cd45 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -23,6 +23,7 @@
 #include "mmap.h"
 #include "../perf.h"
 #include <internal/lib.h> /* page_size */
+#include <linux/bitmap.h>
 
 size_t mmap__mmap_len(struct mmap *map)
 {
@@ -215,7 +216,7 @@ void mmap__munmap(struct mmap *map)
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
-static void build_node_mask(int node, cpu_set_t *mask)
+static void build_node_mask(int node, struct mmap_cpu_mask *mask)
 {
 	int c, cpu, nr_cpus;
 	const struct perf_cpu_map *cpu_map = NULL;
@@ -228,28 +229,43 @@ static void build_node_mask(int node, cpu_set_t *mask)
 	for (c = 0; c < nr_cpus; c++) {
 		cpu = cpu_map->map[c]; /* map c index to online cpu index */
 		if (cpu__get_node(cpu) == node)
-			CPU_SET(cpu, mask);
+			set_bit(cpu, mask->bits);
 	}
 }
 
-static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
+static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
 {
-	CPU_ZERO(&map->affinity_mask);
+	map->affinity_mask.nbits = cpu__max_cpu();
+	map->affinity_mask.bits = bitmap_alloc(map->affinity_mask.nbits);
+	if (!map->affinity_mask.bits)
+		return 1;
+
 	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
 		build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask);
 	else if (mp->affinity == PERF_AFFINITY_CPU)
-		CPU_SET(map->core.cpu, &map->affinity_mask);
+		set_bit(map->core.cpu, map->affinity_mask.bits);
+
+	return 0;
 }
 
+#define MASK_SIZE 1023
 int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
+	char mask[MASK_SIZE + 1] = {0};
+
 	if (perf_mmap__mmap(&map->core, &mp->core, fd, cpu)) {
 		pr_debug2("failed to mmap perf event ring buffer, error %d\n",
 			  errno);
 		return -1;
 	}
 
-	perf_mmap__setup_affinity_mask(map, mp);
+	if (perf_mmap__setup_affinity_mask(map, mp)) {
+		pr_debug2("failed to alloc mmap affinity mask, error %d\n",
+			  errno);
+		return -1;
+	}
+	bitmap_scnprintf(map->affinity_mask.bits, map->affinity_mask.nbits, mask, MASK_SIZE);
+	pr_debug("%p: mmap mask[%ld]: %s\n", map, map->affinity_mask.nbits, mask);
 
 	map->core.flush = mp->flush;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index a218a0eb1466..0a644e112ac6 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -40,7 +40,7 @@ struct mmap {
 		int		 nr_cblocks;
 	} aio;
 #endif
-	cpu_set_t	affinity_mask;
+	struct mmap_cpu_mask	affinity_mask;
 	void		*data;
 	int		comp_level;
 };
-- 
2.20.1

