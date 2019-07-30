Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5421DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226C320679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dq50lW4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbfG3S6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:58:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51013 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbfG3S6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:58:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIvnuT3337131
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:57:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIvnuT3337131
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513070;
        bh=aFsbIVrGy0WqmqGD4Zmn7t97gSVVH8wIG/Mff6rXRO0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=dq50lW4QNfyX1O2tq+yQfMyKss1eRWD6f08jFvQMKFbkbH0x0929dMEUuVKqe+SEf
         fR30d6UozmleraOLt741f30OE76HFtLEs2A9tMHJoLqRtigN/AP3YjEhJ3TNig76N9
         v6yUX7LDdwylEKAbHRLpmzJ2EzdbvtNmdfrMxN/7RcXwf9y+Ucr7ctfIeqn1Gcq6MO
         +16CcCvmrKpI2QwlvI9/h/A1xXzXmP9Q47qR9EnOZ7iUiiOTAQGgBsA0dh2bbb2AKt
         2kAj3gT6QJJaJlopE0TKrYkAA3PZ8fQ3gY10lGVtwyw1aA1zVVHBCv+vUsHIkjzMVz
         u6KZPI0wNH+jA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIvnsi3337128;
        Tue, 30 Jul 2019 11:57:49 -0700
Date:   Tue, 30 Jul 2019 11:57:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-0ff1a0fdf52cffa998eee4303e02780d39b2b09c@git.kernel.org>
Cc:     namhyung@kernel.org, ak@linux.intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
        alexey.budankov@linux.intel.com
Reply-To: alexey.budankov@linux.intel.com, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, mpetlan@redhat.com, peterz@infradead.org,
          hpa@zytor.com, jolsa@kernel.org, namhyung@kernel.org,
          ak@linux.intel.com, acme@redhat.com
In-Reply-To: <20190721112506.12306-68-jolsa@kernel.org>
References: <20190721112506.12306-68-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evsel__cpus()/threads() functions
Git-Commit-ID: 0ff1a0fdf52cffa998eee4303e02780d39b2b09c
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

Commit-ID:  0ff1a0fdf52cffa998eee4303e02780d39b2b09c
Gitweb:     https://git.kernel.org/tip/0ff1a0fdf52cffa998eee4303e02780d39b2b09c
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:54 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Add perf_evsel__cpus()/threads() functions

Add the following functions:

  perf_evsel__cpus()
  perf_evsel__threads()

to access the evsel's cpus and threads objects.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-68-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c              | 10 ++++++++++
 tools/perf/lib/include/perf/evsel.h |  2 ++
 tools/perf/lib/libperf.map          |  2 ++
 tools/perf/util/evsel.h             |  2 +-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index c3f3722e9f91..8dbe0e841b8f 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -215,3 +215,13 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 				     PERF_EVENT_IOC_SET_FILTER,
 				     (void *)filter);
 }
+
+struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel)
+{
+	return evsel->cpus;
+}
+
+struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel)
+{
+	return evsel->threads;
+}
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
index 0db18dfabdb8..ae9f7eeb53a2 100644
--- a/tools/perf/lib/include/perf/evsel.h
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -32,5 +32,7 @@ LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
+LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
+LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index d4d34bea0b40..9f43b5cda031 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -21,6 +21,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__open;
 		perf_evsel__close;
 		perf_evsel__read;
+		perf_evsel__cpus;
+		perf_evsel__threads;
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__init;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0989fb2eb1ec..3cf35aa782b9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -193,7 +193,7 @@ struct record_opts;
 
 static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 {
-	return evsel->core.cpus;
+	return perf_evsel__cpus(&evsel->core);
 }
 
 static inline int perf_evsel__nr_cpus(struct evsel *evsel)
