Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E5BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB07E217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455647;
	bh=IfJ/HNPKmjLC3hWS4OCkJpJAfy3W1Kw8+TY3qCvebXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RY+iBV/emEs1BPCmO8AQVokyzbCU8VXYVptR7NsiRObFyeN54NgNKtxLX5sgP7+aR
	 bQUBjtQwnna6eoyEOy4Nj7Jy6HA1ejkStgnR5HXOS6LX9tiQW7We2pvjsyJ7CVInw1
	 MgF/wpstVjJ3QVijbA8u6cpDjYr8v/p1/tjn2sz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbfG3DAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:00:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732451AbfG3DAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:00:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8576D2070B;
        Tue, 30 Jul 2019 03:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455643;
        bh=IfJ/HNPKmjLC3hWS4OCkJpJAfy3W1Kw8+TY3qCvebXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vwULiNxBSF1M1JXRVaquXTPbrto93yX80PWORVMyfTN2FrZ4XnPoyAhOjVhBWvTcO
         WUJrGOIhA/4z+uCd4QuC1IJ4GpUf2SITAl3QytmP1pMCevIsJAgCnCqrmO6yAJgfFg
         2dSmrRFQgSfO3hNi+XNqd1oKiSPuP86C2SCcc3/w=
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
Subject: [PATCH 078/107] libperf: Add own_cpus to struct perf_evsel
Date:   Mon, 29 Jul 2019 23:55:41 -0300
Message-Id: <20190730025610.22603-79-acme@kernel.org>
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

Move own_cpus from tools/perf's evsel to libbpf's perf_evsel.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-52-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/tests/event_update.c         |  4 ++--
 tools/perf/util/evlist.c                |  6 +++---
 tools/perf/util/evsel.c                 |  4 ++--
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/header.c                | 10 +++++-----
 tools/perf/util/parse-events.c          |  2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index b2c76e1a6244..d15d8ccfa3dc 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -11,6 +11,7 @@ struct perf_evsel {
 	struct list_head	 node;
 	struct perf_event_attr	 attr;
 	struct perf_cpu_map	*cpus;
+	struct perf_cpu_map	*own_cpus;
 };
 
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 2bc5145284c0..c37ff49c07c7 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -109,11 +109,11 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("failed to synthesize attr update name",
 			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
 
-	evsel->own_cpus = perf_cpu_map__new("1,2,3");
+	evsel->core.own_cpus = perf_cpu_map__new("1,2,3");
 
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
 			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
 
-	perf_cpu_map__put(evsel->own_cpus);
+	perf_cpu_map__put(evsel->core.own_cpus);
 	return 0;
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 713968130d1d..d203305ac187 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -159,12 +159,12 @@ static void __perf_evlist__propagate_maps(struct evlist *evlist,
 	 * We already have cpus for evsel (via PMU sysfs) so
 	 * keep it, if there's no target cpu list defined.
 	 */
-	if (!evsel->own_cpus || evlist->has_user_cpus) {
+	if (!evsel->core.own_cpus || evlist->has_user_cpus) {
 		perf_cpu_map__put(evsel->core.cpus);
 		evsel->core.cpus = perf_cpu_map__get(evlist->cpus);
-	} else if (evsel->core.cpus != evsel->own_cpus) {
+	} else if (evsel->core.cpus != evsel->core.own_cpus) {
 		perf_cpu_map__put(evsel->core.cpus);
-		evsel->core.cpus = perf_cpu_map__get(evsel->own_cpus);
+		evsel->core.cpus = perf_cpu_map__get(evsel->core.own_cpus);
 	}
 
 	perf_thread_map__put(evsel->threads);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 651f66ee902e..c5f6ee6d5f3b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1125,7 +1125,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
-	if (evsel->own_cpus || evsel->unit)
+	if (evsel->core.own_cpus || evsel->unit)
 		evsel->core.attr.read_format |= PERF_FORMAT_ID;
 
 	/*
@@ -1326,7 +1326,7 @@ void perf_evsel__exit(struct evsel *evsel)
 	perf_evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
 	perf_cpu_map__put(evsel->core.cpus);
-	perf_cpu_map__put(evsel->own_cpus);
+	perf_cpu_map__put(evsel->core.own_cpus);
 	perf_thread_map__put(evsel->threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8ece5edf65ac..2eff837f10bd 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -123,7 +123,6 @@ struct evsel {
 	u64			db_id;
 	struct cgroup		*cgrp;
 	void			*handler;
-	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map *threads;
 	unsigned int		sample_size;
 	int			id_pos;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fa914ba8cd56..f97df418d661 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3861,10 +3861,10 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 	int max, err;
 	u16 type;
 
-	if (!evsel->own_cpus)
+	if (!evsel->core.own_cpus)
 		return 0;
 
-	ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
+	ev = cpu_map_data__alloc(evsel->core.own_cpus, &size, &type, &max);
 	if (!ev)
 		return -ENOMEM;
 
@@ -3874,7 +3874,7 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 	ev->id   = evsel->id[0];
 
 	cpu_map_data__synthesize((struct cpu_map_data *) ev->data,
-				 evsel->own_cpus,
+				 evsel->core.own_cpus,
 				 type, max);
 
 	err = process(tool, (union perf_event*) ev, NULL, NULL);
@@ -3985,7 +3985,7 @@ int perf_event__synthesize_extra_attr(struct perf_tool *tool,
 			}
 		}
 
-		if (counter->own_cpus) {
+		if (counter->core.own_cpus) {
 			err = perf_event__synthesize_event_update_cpus(tool, counter, process);
 			if (err < 0) {
 				pr_err("Couldn't synthesize evsel cpus.\n");
@@ -4082,7 +4082,7 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 
 		map = cpu_map__new_data(&ev_cpus->cpus);
 		if (map)
-			evsel->own_cpus = map;
+			evsel->core.own_cpus = map;
 		else
 			pr_err("failed to get event_update cpus\n");
 	default:
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a27771eca9c2..8182b1e66ec6 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -334,7 +334,7 @@ __add_event(struct list_head *list, int *idx,
 
 	(*idx)++;
 	evsel->core.cpus   = perf_cpu_map__get(cpus);
-	evsel->own_cpus    = perf_cpu_map__get(cpus);
+	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->system_wide = pmu ? pmu->is_uncore : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 
-- 
2.21.0

