Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC406C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC9821726
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455531;
	bh=wTdkiZmVqJKgi/YZYB1VyYdLTDoQy5zxpkIHAUhXGbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hArB7HMogn0NouzwO+Vr4wKEjvNR1TBAlchU+KdmSbPih2XWN3RwiNKUoZslm+Z19
	 9XIgDiH1Cn2rQU+il8YfzQ51OiYj/zmCt5LAkZp9nth5TifFHHqQ45cFn+nOlSDrs+
	 bFOf93E9zo77/4SYybI2bwta5LzYpOYzsE+w4Uh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbfG3C6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732061AbfG3C6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 430DA2070B;
        Tue, 30 Jul 2019 02:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455526;
        bh=wTdkiZmVqJKgi/YZYB1VyYdLTDoQy5zxpkIHAUhXGbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkhPlaNinqiGGjL6TBTLHtKRnJZxNwWrTbOkjJCuGoHJY0RLBurLiRNfKUsCskp6j
         0wx9b2SQJzVxW00BuavcbqjKx/otuiBHkesc9X2tZTPqLNirnEoaiAiTMDkYLqRKKa
         yM9ujwA8HsO7b4ZGomWvboQcBBVJD7FrO2uAvaSI=
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
Subject: [PATCH 045/107] perf evsel: Rename perf_evsel__cpus() to evsel__cpus()
Date:   Mon, 29 Jul 2019 23:55:08 -0300
Message-Id: <20190730025610.22603-46-acme@kernel.org>
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

Rename perf_evsel__cpus() to evsel__cpus(), so we don't have a name
clash when we add perf_evsel__cpus() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-19-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h        | 4 ++--
 tools/perf/util/stat-display.c | 6 +++---
 tools/perf/util/stat.c         | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35f7e7ff3c5e..5fec1ca64f58 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -197,14 +197,14 @@ struct target;
 struct thread_map;
 struct record_opts;
 
-static inline struct perf_cpu_map *perf_evsel__cpus(struct evsel *evsel)
+static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 {
 	return evsel->cpus;
 }
 
 static inline int perf_evsel__nr_cpus(struct evsel *evsel)
 {
-	return perf_evsel__cpus(evsel)->nr;
+	return evsel__cpus(evsel)->nr;
 }
 
 void perf_counts_values__scale(struct perf_counts_values *count,
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index cdfceb5b4d72..f7666d2e6e0c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -109,7 +109,7 @@ static void aggr_printout(struct perf_stat_config *config,
 		} else {
 			fprintf(config->output, "CPU%*d%s ",
 				config->csv_output ? 0 : -5,
-				perf_evsel__cpus(evsel)->map[id],
+				evsel__cpus(evsel)->map[id],
 				config->csv_sep);
 		}
 		break;
@@ -325,7 +325,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 		return 0;
 
 	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
-		int cpu2 = perf_evsel__cpus(evsel)->map[i];
+		int cpu2 = evsel__cpus(evsel)->map[i];
 
 		if (config->aggr_get_id(config, evlist->cpus, cpu2) == id)
 			return cpu2;
@@ -593,7 +593,7 @@ static void aggr_cb(struct perf_stat_config *config,
 	for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
 		struct perf_counts_values *counts;
 
-		s2 = config->aggr_get_id(config, perf_evsel__cpus(counter), cpu);
+		s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
 		if (s2 != ad->id)
 			continue;
 		if (first)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index efd934ec02c3..63f7815ceb4f 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -215,7 +215,7 @@ static int check_per_pkg(struct evsel *counter,
 			 struct perf_counts_values *vals, int cpu, bool *skip)
 {
 	unsigned long *mask = counter->per_pkg_mask;
-	struct perf_cpu_map *cpus = perf_evsel__cpus(counter);
+	struct perf_cpu_map *cpus = evsel__cpus(counter);
 	int s;
 
 	*skip = false;
@@ -483,7 +483,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	}
 
 	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return perf_evsel__open_per_cpu(evsel, perf_evsel__cpus(evsel));
+		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel));
 
 	return perf_evsel__open_per_thread(evsel, evsel->threads);
 }
-- 
2.21.0

