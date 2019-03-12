Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A885C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D692D214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pXjSgIM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfCLFbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:31:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727222AbfCLFb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:31:28 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C5NtD1015177
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=kmDmlstFJ1qGbKNR3tqSx4OrheOY2dBiCc98UY6ad+U=;
 b=pXjSgIM+o6exZGRtF6Wu5sZPWpnwx9SbMN9rF2noZ1VCjsjr1B1+QHl5J+r8X7zaBARv
 iuCTozMr+h8IyH8T+yn8bt/CUVzk1DWGIGOQp1/HQr50RrCo/8gnO9UtHqESbYhZEdCk
 s30zrVCk2fSaY1YT10fOMPJZ40FiY/cal/Y= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r65vng3q1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 22:31:27 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 11 Mar 2019 22:31:25 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id CEE3362E2019; Mon, 11 Mar 2019 22:31:23 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v9 perf,bpf 14/15] perf: introduce side band thread
Date:   Mon, 11 Mar 2019 22:30:50 -0700
Message-ID: <20190312053051.2690567-15-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312053051.2690567-1-songliubraving@fb.com>
References: <20190312053051.2690567-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_04:,,
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
 tools/perf/util/evlist.c    | 119 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  12 ++++
 tools/perf/util/evsel.h     |   6 ++
 5 files changed, 147 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2d34039c4246..f792dd28d936 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1116,6 +1116,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_data *data = &rec->data;
 	struct perf_session *session;
 	bool disabled = false, draining = false;
+	struct perf_evlist *sb_evlist = NULL;
 	int fd;
 
 	atexit(record__sig_exit);
@@ -1216,6 +1217,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target);
+
 	err = record__synthesize(rec, false);
 	if (err < 0)
 		goto out_child;
@@ -1466,6 +1469,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 out_delete_session:
 	perf_session__delete(session);
+
+	perf_evlist__stop_sb_thread(sb_evlist);
 	return status;
 }
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 63a8f686c5cb..9577dba4996b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1512,6 +1512,7 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_END()
 	};
+	struct perf_evlist *sb_evlist = NULL;
 	const char * const top_usage[] = {
 		"perf top [<options>]",
 		NULL
@@ -1640,8 +1641,12 @@ int cmd_top(int argc, const char **argv)
 		signal(SIGWINCH, winch_sig);
 	}
 
+	perf_evlist__start_sb_thread(sb_evlist, target);
+
 	status = __cmd_top(&top);
 
+	perf_evlist__stop_sb_thread(sb_evlist);
+
 out_delete_evlist:
 	perf_evlist__delete(top.evlist);
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ed20f4379956..ec78e93085de 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -19,6 +19,7 @@
 #include "debug.h"
 #include "units.h"
 #include "asm/bug.h"
+#include "bpf-event.h"
 #include <signal.h>
 #include <unistd.h>
 
@@ -1856,3 +1857,121 @@ struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
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
+	bool draining = false;
+	int i;
+
+	while (draining || !(evlist->thread.done)) {
+		if (draining)
+			draining = false;
+		else if (evlist->thread.done)
+			draining = true;
+
+		if (!draining)
+			perf_evlist__poll(evlist, 1000);
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
+	perf_evlist__delete(evlist);
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 744906dd4887..dcb68f34d2cd 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -54,6 +54,10 @@ struct perf_evlist {
 				       struct perf_sample *sample);
 	u64		first_sample_time;
 	u64		last_sample_time;
+	struct {
+		pthread_t		th;
+		volatile int		done;
+	} thread;
 };
 
 struct perf_evsel_str_handler {
@@ -87,6 +91,14 @@ int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
 
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
index cc578e02e08f..0f2c6c93d721 100644
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

