Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149C7C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC76B206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381108;
	bh=xS+6FgjbLQ68QUENHGcLTPrFso4GPxnpL6oDarAOiDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W/EkPcZ/6ttKtgXnJf/I2vctrPREmDwUro94RFx/rraYdAQN23j/R+ub9t4Hy7FSN
	 0qSWlXBl0H2KKnumNHpxgkD2urPUe3FjUMxpSWRYe+2zYJ42xJR0jkYTu8COjFA3gm
	 VZ5nti9jUbUB/4yLILAGR+gWow611urkiPs1F9I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391294AbfIMNZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:25:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41287 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391262AbfIMNZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:25:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1B5130001EB;
        Fri, 13 Sep 2019 13:24:59 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C1E55C1D4;
        Fri, 13 Sep 2019 13:24:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 24/73] libperf: Move id from struct evsel to struct perf_evsel
Date:   Fri, 13 Sep 2019 15:23:06 +0200
Message-Id: <20190913132355.21634-25-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 13 Sep 2019 13:24:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move id array from struct evsel to libperf's struct perf_evsel.

Link: http://lkml.kernel.org/n/tip-2m29l53x7qzpyk7gp9s8fw2a@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/util/evlist.c                |  2 +-
 tools/perf/util/evsel.c                 |  6 +++---
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/header.c                | 20 ++++++++++----------
 tools/perf/util/intel-bts.c             |  2 +-
 tools/perf/util/intel-pt.c              |  8 ++++----
 tools/perf/util/session.c               |  2 +-
 8 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index d284825383af..bea14e6e28f5 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -16,6 +16,7 @@ struct perf_evsel {
 	struct perf_thread_map	*threads;
 	struct xyarray		*fd;
 	struct xyarray		*sample_id;
+	u64			*id;
 
 	/* parse modifier helper */
 	int			 nr_members;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4018f0ff75c8..ae7f62ae1d29 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -481,7 +481,7 @@ void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
 			 int cpu, int thread, u64 id)
 {
 	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
-	evsel->id[evsel->ids++] = id;
+	evsel->core.id[evsel->ids++] = id;
 }
 
 int perf_evlist__id_add_fd(struct evlist *evlist,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index db89f98bb357..194bead17f64 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1238,8 +1238,8 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 	if (evsel->core.sample_id == NULL)
 		return -ENOMEM;
 
-	evsel->id = zalloc(ncpus * nthreads * sizeof(u64));
-	if (evsel->id == NULL) {
+	evsel->core.id = zalloc(ncpus * nthreads * sizeof(u64));
+	if (evsel->core.id == NULL) {
 		xyarray__delete(evsel->core.sample_id);
 		evsel->core.sample_id = NULL;
 		return -ENOMEM;
@@ -1252,7 +1252,7 @@ static void perf_evsel__free_id(struct evsel *evsel)
 {
 	xyarray__delete(evsel->core.sample_id);
 	evsel->core.sample_id = NULL;
-	zfree(&evsel->id);
+	zfree(&evsel->core.id);
 	evsel->ids = 0;
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 9934e99e0c64..f313e07925c4 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -117,7 +117,6 @@ struct evsel {
 	struct perf_evsel	core;
 	struct evlist	*evlist;
 	char			*filter;
-	u64			*id;
 	struct perf_counts	*counts;
 	struct perf_counts	*prev_raw_counts;
 	int			idx;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b0c34dda30a0..ebdabaa33d8b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -538,7 +538,7 @@ static int write_event_desc(struct feat_fd *ff,
 		/*
 		 * write unique ids for this event
 		 */
-		ret = do_write(ff, evsel->id, evsel->ids * sizeof(u64));
+		ret = do_write(ff, evsel->core.id, evsel->ids * sizeof(u64));
 		if (ret < 0)
 			return ret;
 	}
@@ -1598,7 +1598,7 @@ static void free_event_desc(struct evsel *events)
 
 	for (evsel = events; evsel->core.attr.size; evsel++) {
 		zfree(&evsel->name);
-		zfree(&evsel->id);
+		zfree(&evsel->core.id);
 	}
 
 	free(events);
@@ -1665,7 +1665,7 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		if (!id)
 			goto error;
 		evsel->ids = nr;
-		evsel->id = id;
+		evsel->core.id = id;
 
 		for (j = 0 ; j < nr; j++) {
 			if (do_read_u64(ff, id))
@@ -1709,7 +1709,7 @@ static void print_event_desc(struct feat_fd *ff, FILE *fp)
 
 		if (evsel->ids) {
 			fprintf(fp, ", id = {");
-			for (j = 0, id = evsel->id; j < evsel->ids; j++, id++) {
+			for (j = 0, id = evsel->core.id; j < evsel->ids; j++, id++) {
 				if (j)
 					fputc(',', fp);
 				fprintf(fp, " %"PRIu64, *id);
@@ -3083,7 +3083,7 @@ int perf_session__write_header(struct perf_session *session,
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		evsel->id_offset = lseek(fd, 0, SEEK_CUR);
-		err = do_write(&ff, evsel->id, evsel->ids * sizeof(u64));
+		err = do_write(&ff, evsel->core.id, evsel->ids * sizeof(u64));
 		if (err < 0) {
 			pr_debug("failed to write perf header\n");
 			return err;
@@ -3824,7 +3824,7 @@ perf_event__synthesize_event_update_unit(struct perf_tool *tool,
 	size_t size = strlen(evsel->unit);
 	int err;
 
-	ev = event_update_event__new(size + 1, PERF_EVENT_UPDATE__UNIT, evsel->id[0]);
+	ev = event_update_event__new(size + 1, PERF_EVENT_UPDATE__UNIT, evsel->core.id[0]);
 	if (ev == NULL)
 		return -ENOMEM;
 
@@ -3843,7 +3843,7 @@ perf_event__synthesize_event_update_scale(struct perf_tool *tool,
 	struct perf_record_event_update_scale *ev_data;
 	int err;
 
-	ev = event_update_event__new(sizeof(*ev_data), PERF_EVENT_UPDATE__SCALE, evsel->id[0]);
+	ev = event_update_event__new(sizeof(*ev_data), PERF_EVENT_UPDATE__SCALE, evsel->core.id[0]);
 	if (ev == NULL)
 		return -ENOMEM;
 
@@ -3863,7 +3863,7 @@ perf_event__synthesize_event_update_name(struct perf_tool *tool,
 	size_t len = strlen(evsel->name);
 	int err;
 
-	ev = event_update_event__new(len + 1, PERF_EVENT_UPDATE__NAME, evsel->id[0]);
+	ev = event_update_event__new(len + 1, PERF_EVENT_UPDATE__NAME, evsel->core.id[0]);
 	if (ev == NULL)
 		return -ENOMEM;
 
@@ -3893,7 +3893,7 @@ perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
 	ev->header.type = PERF_RECORD_EVENT_UPDATE;
 	ev->header.size = (u16)size;
 	ev->type = PERF_EVENT_UPDATE__CPUS;
-	ev->id   = evsel->id[0];
+	ev->id   = evsel->core.id[0];
 
 	cpu_map_data__synthesize((struct perf_record_cpu_map_data *)ev->data,
 				 evsel->core.own_cpus,
@@ -3952,7 +3952,7 @@ int perf_event__synthesize_attrs(struct perf_tool *tool,
 
 	evlist__for_each_entry(evlist, evsel) {
 		err = perf_event__synthesize_attr(tool, &evsel->core.attr, evsel->ids,
-						  evsel->id, process);
+						  evsel->core.id, process);
 		if (err) {
 			pr_debug("failed to create perf header attribute\n");
 			return err;
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index aacffa2b0362..daf42915b326 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -795,7 +795,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 	attr.sample_id_all = evsel->core.attr.sample_id_all;
 	attr.read_format = evsel->core.attr.read_format;
 
-	id = evsel->id[0] + 1000000000;
+	id = evsel->core.id[0] + 1000000000;
 	if (!id)
 		id = 1;
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 9b56fb74bedf..4a1d46158401 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1704,7 +1704,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	struct intel_pt *pt = ptq->pt;
 	struct evsel *evsel = pt->pebs_evsel;
 	u64 sample_type = evsel->core.attr.sample_type;
-	u64 id = evsel->id[0];
+	u64 id = evsel->core.id[0];
 	u8 cpumode;
 
 	if (intel_pt_skip_event(pt))
@@ -2719,7 +2719,7 @@ static void intel_pt_set_event_name(struct evlist *evlist, u64 id,
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->id && evsel->id[0] == id) {
+		if (evsel->core.id && evsel->core.id[0] == id) {
 			if (evsel->name)
 				zfree(&evsel->name);
 			evsel->name = strdup(name);
@@ -2775,7 +2775,7 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 	attr.sample_id_all = evsel->core.attr.sample_id_all;
 	attr.read_format = evsel->core.attr.read_format;
 
-	id = evsel->id[0] + 1000000000;
+	id = evsel->core.id[0] + 1000000000;
 	if (!id)
 		id = 1;
 
@@ -2902,7 +2902,7 @@ static void intel_pt_setup_pebs_events(struct intel_pt *pt)
 		return;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-		if (evsel->core.attr.aux_output && evsel->id) {
+		if (evsel->core.attr.aux_output && evsel->core.id) {
 			pt->sample_pebs = true;
 			pt->pebs_evsel = evsel;
 			return;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e9e4a04f15db..f50cd54cf96b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2458,7 +2458,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool,
 
 			e = &ev->id_index.entries[i++];
 
-			e->id = evsel->id[j];
+			e->id = evsel->core.id[j];
 
 			sid = perf_evlist__id2sid(evlist, e->id);
 			if (!sid) {
-- 
2.21.0

