Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7A0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9873E206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZKutHJ5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfCFHOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:14:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49236 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729316AbfCFHOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:14:40 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x267EOKT027937
        for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2019 23:14:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=+2bdhBCHoUTMvMJXVt2p1xLyY+Hq8xNP3KqJwt83FOw=;
 b=ZKutHJ5BO27zu4qXEIdF5z/V42EJrOjZume4urIQgSKDq0KCWBzpdJ9XHJFSoh4ZvTlU
 SU4dzVQE1tjHIFBiAD97fMMM/+PFKW3cBoLNEXYytKkIEpNtLa8+mzi//jAaVsZNfJrl
 DKQnDk4vg0vLpEazqkBCZBAII/WfcLR2PgQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2r276y0aap-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 23:14:39 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 5 Mar 2019 23:14:36 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E1B6562E2965; Tue,  5 Mar 2019 23:14:35 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v6 perf,bpf 14/15] perf: introduce side band thread
Date:   Tue, 5 Mar 2019 23:13:58 -0800
Message-ID: <20190306071359.2359896-15-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190306071359.2359896-1-songliubraving@fb.com>
References: <20190306071359.2359896-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces side band thread that captures extended information
for events like PERF_RECORD_BPF_EVENT.

This new thread uses its own evlist that uses ring buffer with very low
watermark for lower latency.

To use side band thread, we need to:

1. add side band event(s) by calling perf_evlist__add_sb_event();
2. calls perf_evlist__start_sb_thread();
3. at the end of perf run, perf_evlist__stop_sb_thread().

In the next patch, we use this thread to handle PERF_RECORD_BPF_EVENT.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-record.c |   5 ++
 tools/perf/builtin-top.c    |   5 ++
 tools/perf/util/evlist.c    | 113 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  13 +++++
 tools/perf/util/evsel.h     |   6 ++
 5 files changed, 142 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2355e0a9eda0..435b94f1f3b3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1106,6 +1106,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_data *data = &rec->data;
 	struct perf_session *session;
 	bool disabled = false, draining = false;
+	struct perf_evlist *sb_evlist = NULL;
 	int fd;
 
 	atexit(record__sig_exit);
@@ -1206,6 +1207,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target);
+
 	err = record__synthesize(rec, false);
 	if (err < 0)
 		goto out_child;
@@ -1456,6 +1459,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 out_delete_session:
 	perf_session__delete(session);
+
+	perf_evlist__stop_sb_thread(sb_evlist);
 	return status;
 }
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ccdf5689452f..ec69eb040933 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1524,6 +1524,7 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_END()
 	};
+	struct perf_evlist *sb_evlist = NULL;
 	const char * const top_usage[] = {
 		"perf top [<options>]",
 		NULL
@@ -1654,8 +1655,12 @@ int cmd_top(int argc, const char **argv)
 
 	top.record_opts.bpf_event = !top.no_bpf_event;
 
+	perf_evlist__start_sb_thread(sb_evlist, target);
+
 	status = __cmd_top(&top);
 
+	perf_evlist__stop_sb_thread(sb_evlist);
+
 out_delete_evlist:
 	perf_evlist__delete(top.evlist);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8c902276d4b4..a06a4f54b083 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -19,6 +19,7 @@
 #include "debug.h"
 #include "units.h"
 #include "asm/bug.h"
+#include "bpf-event.h"
 #include <signal.h>
 #include <unistd.h>
 
@@ -1841,3 +1842,115 @@ struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
 	}
 	return leader;
 }
+
+int perf_evlist__add_sb_event(struct perf_evlist **evlist,
+			      struct perf_event_attr *attr,
+			      perf_evsel__sb_cb_t cb,
+			      void *data)
+{
+	struct perf_evsel *evsel;
+	bool new_evlist = (*evlist) == NULL;
+
+	if (*evlist == NULL)
+		*evlist = perf_evlist__new();
+	if (*evlist == NULL)
+		return -1;
+
+	if (!attr->sample_id_all) {
+		pr_warning("enabling sample_id_all for all side band events\n");
+		attr->sample_id_all = 1;
+	}
+
+	evsel = perf_evsel__new_idx(attr, (*evlist)->nr_entries);
+	if (!evsel)
+		goto out_err;
+
+	evsel->side_band.cb = cb;
+	evsel->side_band.data = data;
+	perf_evlist__add(*evlist, evsel);
+	return 0;
+
+out_err:
+	if (new_evlist) {
+		perf_evlist__delete(*evlist);
+		*evlist = NULL;
+	}
+	return -1;
+}
+
+static void *perf_evlist__poll_thread(void *arg)
+{
+	struct perf_evlist *evlist = arg;
+	int i;
+
+	while (!(evlist->thread.done)) {
+		perf_evlist__poll(evlist, 1000);
+
+		for (i = 0; i < evlist->nr_mmaps; i++) {
+			struct perf_mmap *map = &evlist->mmap[i];
+			union perf_event *event;
+
+			if (perf_mmap__read_init(map))
+				continue;
+			while ((event = perf_mmap__read_event(map)) != NULL) {
+				struct perf_evsel *evsel = perf_evlist__event2evsel(evlist, event);
+
+				if (evsel && evsel->side_band.cb)
+					evsel->side_band.cb(event, evsel->side_band.data);
+				else
+					pr_warning("cannot locate proper evsel for the side band event\n");
+
+				perf_mmap__consume(map);
+			}
+			perf_mmap__read_done(map);
+		}
+	}
+	return NULL;
+}
+
+int perf_evlist__start_sb_thread(struct perf_evlist *evlist,
+				 struct target *target)
+{
+	struct perf_evsel *counter;
+
+	if (!evlist)
+		return 0;
+
+	if (perf_evlist__create_maps(evlist, target))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (perf_evsel__open(counter, evlist->cpus,
+				     evlist->threads) < 0)
+			goto out_delete_evlist;
+	}
+
+	if (perf_evlist__mmap(evlist, UINT_MAX))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (perf_evsel__enable(counter))
+			goto out_delete_evlist;
+	}
+
+	evlist->thread.done = 0;
+	if (pthread_create(&evlist->thread.th, NULL, perf_evlist__poll_thread, evlist))
+		goto out_delete_evlist;
+
+	return 0;
+
+out_delete_evlist:
+	perf_evlist__delete(evlist);
+	evlist = NULL;
+	return -1;
+}
+
+void perf_evlist__stop_sb_thread(struct perf_evlist *evlist)
+{
+	if (!evlist)
+		return;
+	evlist->thread.done = 1;
+	pthread_join(evlist->thread.th, NULL);
+	perf_evlist__exit(evlist);
+	evlist = NULL;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 868294491194..ed8cab1b7438 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -51,6 +51,11 @@ struct perf_evlist {
 	struct perf_env	*env;
 	u64		first_sample_time;
 	u64		last_sample_time;
+	struct {
+		pthread_t		th;
+		struct perf_evsel	*evsel;
+		volatile int		done;
+	} thread;
 };
 
 struct perf_evsel_str_handler {
@@ -84,6 +89,14 @@ int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
 
 int perf_evlist__add_dummy(struct perf_evlist *evlist);
 
+int perf_evlist__add_sb_event(struct perf_evlist **evlist,
+			      struct perf_event_attr *attr,
+			      perf_evsel__sb_cb_t cb,
+			      void *data);
+int perf_evlist__start_sb_thread(struct perf_evlist *evlist,
+				 struct target *target);
+void perf_evlist__stop_sb_thread(struct perf_evlist *evlist);
+
 int perf_evlist__add_newtp(struct perf_evlist *evlist,
 			   const char *sys, const char *name, void *handler);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 29c5eb68c44b..94232ba9acce 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -73,6 +73,8 @@ struct perf_evsel_config_term {
 
 struct perf_stat_evsel;
 
+typedef int (perf_evsel__sb_cb_t)(union perf_event *event, void *data);
+
 /** struct perf_evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
@@ -151,6 +153,10 @@ struct perf_evsel {
 	bool			collect_stat;
 	bool			weak_group;
 	const char		*pmu_name;
+	struct {
+		perf_evsel__sb_cb_t	*cb;
+		void			*data;
+	} side_band;
 };
 
 union u64_swap {
-- 
2.17.1

