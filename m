Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CC9C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAC4222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458119;
	bh=5+WNarihB7bt+9A9G8cDIgq2+z8y9Atyd4VP/m6NWmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gKLEkBqpBlDAm/Jw39kIX0tzW9vO9bnmRpe1B+gEO4SruFEZ5hjL3ZYf7D3lqr8/F
	 BwaVo4tySgupQS0jsX6yF1VAMqpFgoHuH6O0fHfBdrOx8UlKAoa/NqXBZHUBazEuIJ
	 XbQjjE8s0V5jle4LQ7CkQ9U+IRWFGacmhia3NFBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389526AbfIZAfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389070AbfIZAfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:35:16 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87EB521D7B;
        Thu, 26 Sep 2019 00:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458115;
        bh=5+WNarihB7bt+9A9G8cDIgq2+z8y9Atyd4VP/m6NWmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMxRL4DZAU+TCf7Uzs2668ntyC4UNZHdp7OO1aIFad3H8wlGDKRxP01gaL6vGWA1G
         Rgqyq/QYISxG9Cg0nIQQb+AOIHaFV6cqzmWTjjeGTJtpRqfNvZ+oFoGm2BtSRL+YYD
         cE10eEquA3m2liorZ5vZntwE6kZnQkODL12gqpn4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 38/66] libperf: Move 'id' from 'struct evsel' to 'struct perf_evsel'
Date:   Wed, 25 Sep 2019 21:32:16 -0300
Message-Id: <20190926003244.13962-39-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the 'id' array from 'struct evsel' to libperf's 'struct perf_evsel'.

Committer note:

Fix the tools/perf/util/cs-etm.c build, i.e. aarch64's CoreSight.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-25-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/util/cs-etm.c                |  2 +-
 tools/perf/util/evlist.c                |  2 +-
 tools/perf/util/evsel.c                 |  6 +++---
 tools/perf/util/evsel.h                 |  1 -
 tools/perf/util/header.c                | 10 +++++-----
 tools/perf/util/intel-bts.c             |  2 +-
 tools/perf/util/intel-pt.c              |  8 ++++----
 tools/perf/util/synthetic-events.c      | 12 ++++++------
 9 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 1ddb969f7807..e7171948c347 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -18,6 +18,7 @@ struct perf_evsel {
 	struct perf_thread_map	*threads;
 	struct xyarray		*fd;
 	struct xyarray		*sample_id;
+	u64			*id;
 
 	/* parse modifier helper */
 	int			 nr_members;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 6021974577d5..4ba0f871f086 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1298,7 +1298,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 	attr.read_format = evsel->core.attr.read_format;
 
 	/* create new id val to be a fixed offset from evsel id */
-	id = evsel->id[0] + 1000000000;
+	id = evsel->core.id[0] + 1000000000;
 
 	if (!id)
 		id = 1;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 84b409802298..24f03f245525 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -482,7 +482,7 @@ void perf_evlist__id_add(struct evlist *evlist, struct evsel *evsel,
 			 int cpu, int thread, u64 id)
 {
 	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
-	evsel->id[evsel->ids++] = id;
+	evsel->core.id[evsel->ids++] = id;
 }
 
 int perf_evlist__id_add_fd(struct evlist *evlist,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cb1ada8cf4a4..9c1b4f4a5fa3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1239,8 +1239,8 @@ int perf_evsel__alloc_id(struct evsel *evsel, int ncpus, int nthreads)
 	if (evsel->core.sample_id == NULL)
 		return -ENOMEM;
 
-	evsel->id = zalloc(ncpus * nthreads * sizeof(u64));
-	if (evsel->id == NULL) {
+	evsel->core.id = zalloc(ncpus * nthreads * sizeof(u64));
+	if (evsel->core.id == NULL) {
 		xyarray__delete(evsel->core.sample_id);
 		evsel->core.sample_id = NULL;
 		return -ENOMEM;
@@ -1253,7 +1253,7 @@ static void perf_evsel__free_id(struct evsel *evsel)
 {
 	xyarray__delete(evsel->core.sample_id);
 	evsel->core.sample_id = NULL;
-	zfree(&evsel->id);
+	zfree(&evsel->core.id);
 	evsel->ids = 0;
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 2d2c6cad81f8..0d2aa933ceb3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -116,7 +116,6 @@ struct evsel {
 	struct perf_evsel	core;
 	struct evlist	*evlist;
 	char			*filter;
-	u64			*id;
 	struct perf_counts	*counts;
 	struct perf_counts	*prev_raw_counts;
 	int			idx;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 0167f9697172..2b0681ab08aa 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -530,7 +530,7 @@ static int write_event_desc(struct feat_fd *ff,
 		/*
 		 * write unique ids for this event
 		 */
-		ret = do_write(ff, evsel->id, evsel->ids * sizeof(u64));
+		ret = do_write(ff, evsel->core.id, evsel->ids * sizeof(u64));
 		if (ret < 0)
 			return ret;
 	}
@@ -1590,7 +1590,7 @@ static void free_event_desc(struct evsel *events)
 
 	for (evsel = events; evsel->core.attr.size; evsel++) {
 		zfree(&evsel->name);
-		zfree(&evsel->id);
+		zfree(&evsel->core.id);
 	}
 
 	free(events);
@@ -1657,7 +1657,7 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		if (!id)
 			goto error;
 		evsel->ids = nr;
-		evsel->id = id;
+		evsel->core.id = id;
 
 		for (j = 0 ; j < nr; j++) {
 			if (do_read_u64(ff, id))
@@ -1701,7 +1701,7 @@ static void print_event_desc(struct feat_fd *ff, FILE *fp)
 
 		if (evsel->ids) {
 			fprintf(fp, ", id = {");
-			for (j = 0, id = evsel->id; j < evsel->ids; j++, id++) {
+			for (j = 0, id = evsel->core.id; j < evsel->ids; j++, id++) {
 				if (j)
 					fputc(',', fp);
 				fprintf(fp, " %"PRIu64, *id);
@@ -3068,7 +3068,7 @@ int perf_session__write_header(struct perf_session *session,
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		evsel->id_offset = lseek(fd, 0, SEEK_CUR);
-		err = do_write(&ff, evsel->id, evsel->ids * sizeof(u64));
+		err = do_write(&ff, evsel->core.id, evsel->ids * sizeof(u64));
 		if (err < 0) {
 			pr_debug("failed to write perf header\n");
 			return err;
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 3888d4cd3ed1..c94360cd9c00 100644
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
index bcdc0359f7cf..24ca5d5908ca 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1705,7 +1705,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	struct intel_pt *pt = ptq->pt;
 	struct evsel *evsel = pt->pebs_evsel;
 	u64 sample_type = evsel->core.attr.sample_type;
-	u64 id = evsel->id[0];
+	u64 id = evsel->core.id[0];
 	u8 cpumode;
 
 	if (intel_pt_skip_event(pt))
@@ -2720,7 +2720,7 @@ static void intel_pt_set_event_name(struct evlist *evlist, u64 id,
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->id && evsel->id[0] == id) {
+		if (evsel->core.id && evsel->core.id[0] == id) {
 			if (evsel->name)
 				zfree(&evsel->name);
 			evsel->name = strdup(name);
@@ -2776,7 +2776,7 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 	attr.sample_id_all = evsel->core.attr.sample_id_all;
 	attr.read_format = evsel->core.attr.read_format;
 
-	id = evsel->id[0] + 1000000000;
+	id = evsel->core.id[0] + 1000000000;
 	if (!id)
 		id = 1;
 
@@ -2903,7 +2903,7 @@ static void intel_pt_setup_pebs_events(struct intel_pt *pt)
 		return;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-		if (evsel->core.attr.aux_output && evsel->id) {
+		if (evsel->core.attr.aux_output && evsel->core.id) {
 			pt->sample_pebs = true;
 			pt->pebs_evsel = evsel;
 			return;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 8322028a9a97..907ac3971959 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1442,7 +1442,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool, perf_event__handler_
 
 			e = &ev->id_index.entries[i++];
 
-			e->id = evsel->id[j];
+			e->id = evsel->core.id[j];
 
 			sid = perf_evlist__id2sid(evlist, e->id);
 			if (!sid) {
@@ -1515,7 +1515,7 @@ int perf_event__synthesize_event_update_unit(struct perf_tool *tool, struct evse
 	struct perf_record_event_update *ev;
 	int err;
 
-	ev = event_update_event__new(size + 1, PERF_EVENT_UPDATE__UNIT, evsel->id[0]);
+	ev = event_update_event__new(size + 1, PERF_EVENT_UPDATE__UNIT, evsel->core.id[0]);
 	if (ev == NULL)
 		return -ENOMEM;
 
@@ -1532,7 +1532,7 @@ int perf_event__synthesize_event_update_scale(struct perf_tool *tool, struct evs
 	struct perf_record_event_update_scale *ev_data;
 	int err;
 
-	ev = event_update_event__new(sizeof(*ev_data), PERF_EVENT_UPDATE__SCALE, evsel->id[0]);
+	ev = event_update_event__new(sizeof(*ev_data), PERF_EVENT_UPDATE__SCALE, evsel->core.id[0]);
 	if (ev == NULL)
 		return -ENOMEM;
 
@@ -1550,7 +1550,7 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
 	size_t len = strlen(evsel->name);
 	int err;
 
-	ev = event_update_event__new(len + 1, PERF_EVENT_UPDATE__NAME, evsel->id[0]);
+	ev = event_update_event__new(len + 1, PERF_EVENT_UPDATE__NAME, evsel->core.id[0]);
 	if (ev == NULL)
 		return -ENOMEM;
 
@@ -1578,7 +1578,7 @@ int perf_event__synthesize_event_update_cpus(struct perf_tool *tool, struct evse
 	ev->header.type = PERF_RECORD_EVENT_UPDATE;
 	ev->header.size = (u16)size;
 	ev->type	= PERF_EVENT_UPDATE__CPUS;
-	ev->id		= evsel->id[0];
+	ev->id		= evsel->core.id[0];
 
 	cpu_map_data__synthesize((struct perf_record_cpu_map_data *)ev->data,
 				 evsel->core.own_cpus, type, max);
@@ -1596,7 +1596,7 @@ int perf_event__synthesize_attrs(struct perf_tool *tool, struct evlist *evlist,
 
 	evlist__for_each_entry(evlist, evsel) {
 		err = perf_event__synthesize_attr(tool, &evsel->core.attr, evsel->ids,
-						  evsel->id, process);
+						  evsel->core.id, process);
 		if (err) {
 			pr_debug("failed to create perf header attribute\n");
 			return err;
-- 
2.21.0

