Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B4E2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfCVWpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:45:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36385 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbfCVWpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:45:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMjAEZ757846
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:45:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMj9GV757843;
        Fri, 22 Mar 2019 15:45:09 -0700
Date:   Fri, 22 Mar 2019 15:45:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-657ee5531903339b06697581532ed32d4762526e@git.kernel.org>
Cc:     jolsa@kernel.org, sdf@google.com, hpa@zytor.com, acme@redhat.com,
        songliubraving@fb.com, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          daniel@iogearbox.net, ast@kernel.org, namhyung@kernel.org,
          hpa@zytor.com, mingo@kernel.org, songliubraving@fb.com,
          acme@redhat.com, sdf@google.com, jolsa@kernel.org,
          peterz@infradead.org
In-Reply-To: <20190312053051.2690567-15-songliubraving@fb.com>
References: <20190312053051.2690567-15-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evlist: Introduce side band thread
Git-Commit-ID: 657ee5531903339b06697581532ed32d4762526e
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

Commit-ID:  657ee5531903339b06697581532ed32d4762526e
Gitweb:     https://git.kernel.org/tip/657ee5531903339b06697581532ed32d4762526e
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:50 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 21 Mar 2019 11:27:03 -0300

perf evlist: Introduce side band thread

This patch introduces side band thread that captures extended
information for events like PERF_RECORD_BPF_EVENT.

This new thread uses its own evlist that uses ring buffer with very low
watermark for lower latency.

To use side band thread, we need to:

1. add side band event(s) by calling perf_evlist__add_sb_event();
2. calls perf_evlist__start_sb_thread();
3. at the end of perf run, perf_evlist__stop_sb_thread().

In the next patch, we use this thread to handle PERF_RECORD_BPF_EVENT.

Committer notes:

Add fix by Jiri Olsa for when te sb_tread can't get started and then at
the end the stop_sb_thread() segfaults when joining the (non-existing)
thread.

That can happen when running 'perf top' or 'perf record' as a normal
user, for instance.

Further checks need to be done on top of this to more graciously handle
these possible failure scenarios.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190312053051.2690567-15-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |   9 ++++
 tools/perf/builtin-top.c    |   9 ++++
 tools/perf/util/evlist.c    | 119 ++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  12 +++++
 tools/perf/util/evsel.h     |   6 +++
 5 files changed, 155 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e79faccd7842..6f645fd72fed 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1137,6 +1137,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	struct perf_data *data = &rec->data;
 	struct perf_session *session;
 	bool disabled = false, draining = false;
+	struct perf_evlist *sb_evlist = NULL;
 	int fd;
 
 	atexit(record__sig_exit);
@@ -1237,6 +1238,11 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	if (perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target)) {
+		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
+		opts->no_bpf_event = true;
+	}
+
 	err = record__synthesize(rec, false);
 	if (err < 0)
 		goto out_child;
@@ -1487,6 +1493,9 @@ out_child:
 
 out_delete_session:
 	perf_session__delete(session);
+
+	if (!opts->no_bpf_event)
+		perf_evlist__stop_sb_thread(sb_evlist);
 	return status;
 }
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c2ea22c4ea67..3ce8a8db6c1d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1501,6 +1501,7 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_END()
 	};
+	struct perf_evlist *sb_evlist = NULL;
 	const char * const top_usage[] = {
 		"perf top [<options>]",
 		NULL
@@ -1636,8 +1637,16 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
+	if (perf_evlist__start_sb_thread(sb_evlist, target)) {
+		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
+		opts->no_bpf_event = true;
+	}
+
 	status = __cmd_top(&top);
 
+	if (!opts->no_bpf_event)
+		perf_evlist__stop_sb_thread(sb_evlist);
+
 out_delete_evlist:
 	perf_evlist__delete(top.evlist);
 	perf_session__delete(top.session);
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
