Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2190C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894C3206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381106;
	bh=Bd9ZlYnvCVm+9gIvOGd/4m6ABNoqmdaAsqvBtTrJb+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LOoR55g5OOcfDjGJ6hKx1GPIMGZVGVd+dwxCh+KY2bRQP/70NDgdvBgXPNZCcTmW4
	 s3Dm5+/ZUzPvQOmdvqtvykE6PmGPzaZx9hIN+Kx0kp5DramU4uc0fr0s0kd5Xv6aST
	 nlG/hmRq5aBUV1hc6APw+mP0fn2iGSHAjc6mH2jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391283AbfIMNZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390933AbfIMNZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A011307CDE7;
        Fri, 13 Sep 2019 13:25:03 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 183D65C1D4;
        Fri, 13 Sep 2019 13:24:59 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 25/73] libperf: Move ids from struct evsel to struct perf_evsel
Date:   Fri, 13 Sep 2019 15:23:07 +0200
Message-Id: <20190913132355.21634-26-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 13 Sep 2019 13:25:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ids from struct evsel to libperf's struct perf_evsel.

Link: http://lkml.kernel.org/n/tip-oaox9ryle29sepvxaur57swa@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/util/evlist.c                |  2 +-
 tools/perf/util/evsel.c                 |  2 +-
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/header.c                | 16 ++++++++--------
 tools/perf/util/intel-bts.c             |  2 +-
 tools/perf/util/intel-pt.c              |  2 +-
 tools/perf/util/session.c               |  4 ++--
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index bea14e6e28f5..0b04065cae8e 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -17,6 +17,7 @@ struct perf_evsel {
 	struct xyarray		*fd;
 	struct xyarray		*sample_id;
 	u64			*id;
+	u32			 ids;
 
 	/* parse modifier helper */
 	int			 nr_members;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ae7f62ae1d29..9dcecb5e05a0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -481,7 +481,7 @@ void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
 			 int cpu, int thread, u64 id)
 {
 	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
-	evsel->core.id[evsel->ids++] = id;
+	evsel->core.id[evsel->core.ids++] = id;
 }
 
 int perf_evlist__id_add_fd(struct evlist *evlist,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 194bead17f64..7501b4403b7f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1253,7 +1253,7 @@ static void perf_evsel__free_id(struct evsel *evsel)
 	xyarray__delete(evsel->core.sample_id);
 	evsel->core.sample_id = NULL;
 	zfree(&evsel->core.id);
-	evsel->ids = 0;
+	evsel->core.ids = 0;
 }
 
 static void perf_evsel__free_config_terms(struct evsel *evsel)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index f313e07925c4..765f722fc128 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -120,7 +120,6 @@ struct evsel {
 	struct perf_counts	*counts;
 	struct perf_counts	*prev_raw_counts;
 	int			idx;
-	u32			ids;
 	unsigned long		max_events;
 	unsigned long		nr_events_printed;
 	char			*name;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ebdabaa33d8b..360fc61c5754 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -524,7 +524,7 @@ static int write_event_desc(struct feat_fd *ff,
 		 * copy into an nri to be independent of the
 		 * type of ids,
 		 */
-		nri = evsel->ids;
+		nri = evsel->core.ids;
 		ret = do_write(ff, &nri, sizeof(nri));
 		if (ret < 0)
 			return ret;
@@ -538,7 +538,7 @@ static int write_event_desc(struct feat_fd *ff,
 		/*
 		 * write unique ids for this event
 		 */
-		ret = do_write(ff, evsel->core.id, evsel->ids * sizeof(u64));
+		ret = do_write(ff, evsel->core.id, evsel->core.ids * sizeof(u64));
 		if (ret < 0)
 			return ret;
 	}
@@ -1664,7 +1664,7 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		id = calloc(nr, sizeof(*id));
 		if (!id)
 			goto error;
-		evsel->ids = nr;
+		evsel->core.ids = nr;
 		evsel->core.id = id;
 
 		for (j = 0 ; j < nr; j++) {
@@ -1707,9 +1707,9 @@ static void print_event_desc(struct feat_fd *ff, FILE *fp)
 	for (evsel = events; evsel->core.attr.size; evsel++) {
 		fprintf(fp, "# event : name = %s, ", evsel->name);
 
-		if (evsel->ids) {
+		if (evsel->core.ids) {
 			fprintf(fp, ", id = {");
-			for (j = 0, id = evsel->core.id; j < evsel->ids; j++, id++) {
+			for (j = 0, id = evsel->core.id; j < evsel->core.ids; j++, id++) {
 				if (j)
 					fputc(',', fp);
 				fprintf(fp, " %"PRIu64, *id);
@@ -3083,7 +3083,7 @@ int perf_session__write_header(struct perf_session *session,
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		evsel->id_offset = lseek(fd, 0, SEEK_CUR);
-		err = do_write(&ff, evsel->core.id, evsel->ids * sizeof(u64));
+		err = do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
 		if (err < 0) {
 			pr_debug("failed to write perf header\n");
 			return err;
@@ -3097,7 +3097,7 @@ int perf_session__write_header(struct perf_session *session,
 			.attr = evsel->core.attr,
 			.ids  = {
 				.offset = evsel->id_offset,
-				.size   = evsel->ids * sizeof(u64),
+				.size   = evsel->core.ids * sizeof(u64),
 			}
 		};
 		err = do_write(&ff, &f_attr, sizeof(f_attr));
@@ -3951,7 +3951,7 @@ int perf_event__synthesize_attrs(struct perf_tool *tool,
 	int err = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
-		err = perf_event__synthesize_attr(tool, &evsel->core.attr, evsel->ids,
+		err = perf_event__synthesize_attr(tool, &evsel->core.attr, evsel->core.ids,
 						  evsel->core.id, process);
 		if (err) {
 			pr_debug("failed to create perf header attribute\n");
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index daf42915b326..e49d38b21909 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -768,7 +768,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 	int err;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == bts->pmu_type && evsel->ids) {
+		if (evsel->core.attr.type == bts->pmu_type && evsel->core.ids) {
 			found = true;
 			break;
 		}
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 4a1d46158401..b08d80adfa32 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2734,7 +2734,7 @@ static struct evsel *intel_pt_evsel(struct intel_pt *pt,
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == pt->pmu_type && evsel->ids)
+		if (evsel->core.attr.type == pt->pmu_type && evsel->core.ids)
 			return evsel;
 	}
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f50cd54cf96b..32226e71949e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2429,7 +2429,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool,
 		 sizeof(struct id_index_entry);
 
 	evlist__for_each_entry(evlist, evsel)
-		nr += evsel->ids;
+		nr += evsel->core.ids;
 
 	n = nr > max_nr ? max_nr : nr;
 	sz = sizeof(struct perf_record_id_index) + n * sizeof(struct id_index_entry);
@@ -2444,7 +2444,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool,
 	evlist__for_each_entry(evlist, evsel) {
 		u32 j;
 
-		for (j = 0; j < evsel->ids; j++) {
+		for (j = 0; j < evsel->core.ids; j++) {
 			struct id_index_entry *e;
 			struct perf_sample_id *sid;
 
-- 
2.21.0

