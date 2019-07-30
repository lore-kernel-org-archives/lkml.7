Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1775C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9940920693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Li4DVRO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbfG3Sqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:46:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44839 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbfG3Sqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:46:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIjSEC3334812
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:45:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIjSEC3334812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512329;
        bh=6MOSdOQwZw2QIA2X22Z1KLRKnxjg4/vCBfCeJEAaaps=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Li4DVRO9gfy9HKSRszNa0aePpWtYCfEocv/ydQ34Ur6NE4lKbPxF4LAW8kuwWfJ48
         bKQkC83uhLvCf6Nm1y4X9zBpg8uB8AkXu6XdmF9xyH5y+WbeEM92ttTZqEUscENe1w
         XxCJlhcRHrSvTWHmnDfarBvYYfm+qycstyeThFqhQMeldOmeNlPlA7+RoP8qOvJZaW
         tRW50e8eU5SvAf3IIlLpyMnuj8C2enTq1MEhypSTfHTYlyGMG/mGFw9luYNvG4kajn
         QB2iacnMbNjsGzdUINwVkUOnk5AQb6b+UpI+IHeU7w3hvZBLBZVtZWW0p66JRqcaBR
         ydLxAWW+81QxQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIjSbK3334809;
        Tue, 30 Jul 2019 11:45:28 -0700
Date:   Tue, 30 Jul 2019 11:45:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-fe1f61b37ffada9fc7ec2c9d4ca5376b5a797dbc@git.kernel.org>
Cc:     mingo@kernel.org, ak@linux.intel.com, tglx@linutronix.de,
        peterz@infradead.org, namhyung@kernel.org, mpetlan@redhat.com,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com,
        linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: alexey.budankov@linux.intel.com, hpa@zytor.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          mpetlan@redhat.com, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, ak@linux.intel.com, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20190721112506.12306-52-jolsa@kernel.org>
References: <20190721112506.12306-52-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add own_cpus to struct perf_evsel
Git-Commit-ID: fe1f61b37ffada9fc7ec2c9d4ca5376b5a797dbc
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

Commit-ID:  fe1f61b37ffada9fc7ec2c9d4ca5376b5a797dbc
Gitweb:     https://git.kernel.org/tip/fe1f61b37ffada9fc7ec2c9d4ca5376b5a797dbc
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:38 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Add own_cpus to struct perf_evsel

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
 
