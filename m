Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA5BC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A655020679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cfCmfk7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbfG3S4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:56:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59311 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388140AbfG3S4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:56:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIuIKj3336762
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:56:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIuIKj3336762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512979;
        bh=hcy/n/CSc3ozRpkImB7HVWhYZIzXYJwwEsfzFzqCYxc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cfCmfk7jB4Ztzh5h7ymazr8MnbK9GRnnWWa15UH6P+gGMAnHCmT0twwWMrj6O1DlD
         cn3ijWJ5PojMgqNBDfmXBJHvTynqEDsOxYJKhbdDiFc4VSSkcI9kUh4z0fbD3hwVDN
         g1gWb3VxTWKPdVCMD4K0iNfmcRK1vfbbLhse6hUbdGA3CAFMlf/FL6Xk4x9PkEVWCU
         CnhB3TaSZUvToXJS7CdN5ACCa8wH/e2X+OEwmVzuUwGgJcr+JdeU8vZYrRmvWP4MwI
         LmewvOKTcHUTMFhHbMyBAVyJzsv85kvqQfaziND7wNHnCAHJJUFV92enams90tZFxK
         6PuHZwBK/5PdQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIuHbq3336759;
        Tue, 30 Jul 2019 11:56:17 -0700
Date:   Tue, 30 Jul 2019 11:56:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a00571fda6091b5268d05e87d0797efe2db1920a@git.kernel.org>
Cc:     ak@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, mpetlan@redhat.com, jolsa@kernel.org,
        hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
        alexey.budankov@linux.intel.com, mingo@kernel.org
Reply-To: namhyung@kernel.org, ak@linux.intel.com, mpetlan@redhat.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          alexey.budankov@linux.intel.com, acme@redhat.com,
          jolsa@kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190721112506.12306-66-jolsa@kernel.org>
References: <20190721112506.12306-66-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Adopt
 perf_evsel__enable()/disable()/apply_filter() functions
Git-Commit-ID: a00571fda6091b5268d05e87d0797efe2db1920a
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

Commit-ID:  a00571fda6091b5268d05e87d0797efe2db1920a
Gitweb:     https://git.kernel.org/tip/a00571fda6091b5268d05e87d0797efe2db1920a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:52 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Adopt perf_evsel__enable()/disable()/apply_filter() functions

Move the following functions:

  evsel__enable()
  evsel__disable()
  evsel__apply_filter()

to libperf with the following names:

  perf_evsel__enable()
  perf_evsel__disable()
  perf_evsel__apply_filter()

Export only perf_evsel__enable()/disable(), keeping the
perf_evsel__apply_filter() one private for the moment.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-66-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c                  | 36 +++++++++++++++++++++++++++++++++
 tools/perf/lib/include/internal/evsel.h |  1 +
 tools/perf/lib/include/perf/evsel.h     |  2 ++
 tools/perf/lib/libperf.map              |  2 ++
 tools/perf/util/evlist.c                |  2 +-
 tools/perf/util/evsel.c                 | 29 ++------------------------
 tools/perf/util/evsel.h                 |  1 -
 7 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 390fcf9107c1..c3f3722e9f91 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -14,6 +14,7 @@
 #include <internal/threadmap.h>
 #include <internal/lib.h>
 #include <linux/string.h>
+#include <sys/ioctl.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
@@ -179,3 +180,38 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 
 	return 0;
 }
+
+static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
+				 int ioc,  void *arg)
+{
+	int cpu, thread;
+
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+			int fd = FD(evsel, cpu, thread),
+			    err = ioctl(fd, ioc, arg);
+
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+int perf_evsel__enable(struct perf_evsel *evsel)
+{
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
+}
+
+int perf_evsel__disable(struct perf_evsel *evsel)
+{
+	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
+}
+
+int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
+{
+	return perf_evsel__run_ioctl(evsel,
+				     PERF_EVENT_IOC_SET_FILTER,
+				     (void *)filter);
+}
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
index 89bae3720d67..8b854d1c9b45 100644
--- a/tools/perf/lib/include/internal/evsel.h
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -24,5 +24,6 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__close_fd(struct perf_evsel *evsel);
 void perf_evsel__free_fd(struct perf_evsel *evsel);
 int perf_evsel__read_size(struct perf_evsel *evsel);
+int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
 
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 16ae3f873280..0db18dfabdb8 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -30,5 +30,7 @@ LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *
 LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
+LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
+LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 2e23cf420cce..5bd491ac1762 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -13,6 +13,8 @@ LIBPERF_0.0.1 {
 		perf_thread_map__put;
 		perf_evsel__new;
 		perf_evsel__delete;
+		perf_evsel__enable;
+		perf_evsel__disable;
 		perf_evsel__init;
 		perf_evsel__open;
 		perf_evsel__close;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c6b4883b2d49..c4489a1ad6bc 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1109,7 +1109,7 @@ int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
 		 * filters only work for tracepoint event, which doesn't have cpu limit.
 		 * So evlist and evsel should always be same.
 		 */
-		err = evsel__apply_filter(evsel, evsel->filter);
+		err = perf_evsel__apply_filter(&evsel->core, evsel->filter);
 		if (err) {
 			*err_evsel = evsel;
 			break;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0957ec24f518..64bc32ed6dfa 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1153,31 +1153,6 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
-static int perf_evsel__run_ioctl(struct evsel *evsel,
-			  int ioc,  void *arg)
-{
-	int cpu, thread;
-
-	for (cpu = 0; cpu < xyarray__max_x(evsel->core.fd); cpu++) {
-		for (thread = 0; thread < xyarray__max_y(evsel->core.fd); thread++) {
-			int fd = FD(evsel, cpu, thread),
-			    err = ioctl(fd, ioc, arg);
-
-			if (err)
-				return err;
-		}
-	}
-
-	return 0;
-}
-
-int evsel__apply_filter(struct evsel *evsel, const char *filter)
-{
-	return perf_evsel__run_ioctl(evsel,
-				     PERF_EVENT_IOC_SET_FILTER,
-				     (void *)filter);
-}
-
 int perf_evsel__set_filter(struct evsel *evsel, const char *filter)
 {
 	char *new_filter = strdup(filter);
@@ -1220,7 +1195,7 @@ int perf_evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 
 int evsel__enable(struct evsel *evsel)
 {
-	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
+	int err = perf_evsel__enable(&evsel->core);
 
 	if (!err)
 		evsel->disabled = false;
@@ -1230,7 +1205,7 @@ int evsel__enable(struct evsel *evsel)
 
 int evsel__disable(struct evsel *evsel)
 {
-	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
+	int err = perf_evsel__disable(&evsel->core);
 	/*
 	 * We mark it disabled here so that tools that disable a event can
 	 * ignore events after they disable it. I.e. the ring buffer may have
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 57e315d8158e..0989fb2eb1ec 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -287,7 +287,6 @@ int perf_evsel__set_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
-int evsel__apply_filter(struct evsel *evsel, const char *filter);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 
