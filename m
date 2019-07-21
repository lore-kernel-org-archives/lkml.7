Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC066C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F092189D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708662;
	bh=W93yec/QPUi2dajsf6Gs8piVcb7DbezfvUPy1JCq0r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QyTiqN3LD0ue55+gKA1I+QyMAZtBnij4dwhbT/jpb2mO1M79R0oTltrGxuZz6unJI
	 TOwIFEKy3k0XWFamzccvkWRBs6IsKjiGT6/teRbKIKUDEvupFeDlbRYKhfOJVADErS
	 rj25r1Sy+ITbqimhtd1zLfuDwQYzeqEEIAV6abhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfGULbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:31:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfGULbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:31:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E7713082A98;
        Sun, 21 Jul 2019 11:30:59 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06DB75D9D3;
        Sun, 21 Jul 2019 11:30:54 +0000 (UTC)
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
Subject: [PATCH 51/79] libperf: Add own_cpus to struct perf_evsel
Date:   Sun, 21 Jul 2019 13:24:38 +0200
Message-Id: <20190721112506.12306-52-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sun, 21 Jul 2019 11:30:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving own_cpus from evsel into perf_evsel struct.

Link: http://lkml.kernel.org/n/tip-0wpynm56w2v1w8faidl049dt@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index 58f041263bd8..c490795dc079 100644
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
index 4fcf334470ac..21d845202c29 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3854,10 +3854,10 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 	int max, err;
 	u16 type;
 
-	if (!evsel->own_cpus)
+	if (!evsel->core.own_cpus)
 		return 0;
 
-	ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);
+	ev = cpu_map_data__alloc(evsel->core.own_cpus, &size, &type, &max);
 	if (!ev)
 		return -ENOMEM;
 
@@ -3867,7 +3867,7 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 	ev->id   = evsel->id[0];
 
 	cpu_map_data__synthesize((struct cpu_map_data *) ev->data,
-				 evsel->own_cpus,
+				 evsel->core.own_cpus,
 				 type, max);
 
 	err = process(tool, (union perf_event*) ev, NULL, NULL);
@@ -3978,7 +3978,7 @@ int perf_event__synthesize_extra_attr(struct perf_tool *tool,
 			}
 		}
 
-		if (counter->own_cpus) {
+		if (counter->core.own_cpus) {
 			err = perf_event__synthesize_event_update_cpus(tool, counter, process);
 			if (err < 0) {
 				pr_err("Couldn't synthesize evsel cpus.\n");
@@ -4075,7 +4075,7 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
 
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

