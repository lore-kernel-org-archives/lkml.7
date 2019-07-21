Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E70C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260032147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708466;
	bh=/pt/I0liL5WsNBINxsv8TJAUVI+71lmW7Up/RvkrM+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sfzDFxkZMJNHzseEeQwD3C0MCQdiCXjnsgAA8TO+kThVKrtOdhQ1oH3CykNs9EUbV
	 I1eZ0+RSoax2O5C7JIux4jsMOXIW8K2Oe1HCEr6ELHofyyq5XR0kqnDNxXBLyIsF9C
	 T8NP9PgmVRDoaWQMDtrH7KvYPn+uVD633NRARjCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfGUL1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:27:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfGUL1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:27:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B083130821A0;
        Sun, 21 Jul 2019 11:27:43 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4E7B13AD1;
        Sun, 21 Jul 2019 11:27:39 +0000 (UTC)
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
Subject: [PATCH 18/79] perf tools: Rename perf_evsel__cpus to evsel__cpus
Date:   Sun, 21 Jul 2019 13:24:05 +0200
Message-Id: <20190721112506.12306-19-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 21 Jul 2019 11:27:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming perf_evsel__cpus to evsel__cpus, so we don't
have a name clash when we add perf_evsel__cpus in libperf.

Link: http://lkml.kernel.org/n/tip-3udl12g7x61nlxgasskccmae@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

