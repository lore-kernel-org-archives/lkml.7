Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1655EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA7020679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cbs+6p0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbfG3S6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:58:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48799 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387964AbfG3S6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:58:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIwYdt3337214
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:58:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIwYdt3337214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513115;
        bh=heZz7mp4XwFUxcANHayD2owWdpgyfjny9yXc9j5h164=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cbs+6p0dggZrSWCamNoB1Um04h0QuUdegAq+lXI/jSR6YTBBL61LNuIZSWsEBzZ3G
         cMdRZZB0V1Fxq5+QoyszLZCcCEXlhZcKeHTcAfjiTDPpvKbFsXUUhDA4lSBOAsB7Ua
         ERflI9kTvVwvikzE2OTZcaJ7MfcxVu87JkNU/cFZ7nQOSGfCeHgYYBHRWY3YgiH8x7
         5/Ir+6X52IN6lgn67tobYtFgdtplDs6xaFVfDd+paKF6HxnaJ8yjFyEu1YhHBayU3+
         hTvPRyYfgtK9z57EL0oriIPeG5wFr4/FRqmxbk+TH73WT3vuVYnU/cMfnVjvIjWvYo
         wgnhUKvFatFZQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIwX7J3337211;
        Tue, 30 Jul 2019 11:58:33 -0700
Date:   Tue, 30 Jul 2019 11:58:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-80dc2b3e257cbd62e1cd5b18a6581f231c828c81@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, acme@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, mpetlan@redhat.com
Reply-To: ak@linux.intel.com, alexey.budankov@linux.intel.com,
          peterz@infradead.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mpetlan@redhat.com, alexander.shishkin@linux.intel.com,
          jolsa@kernel.org, acme@redhat.com, namhyung@kernel.org
In-Reply-To: <20190721112506.12306-69-jolsa@kernel.org>
References: <20190721112506.12306-69-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Adopt simplified
 perf_evlist__open()/close() functions from tools/perf
Git-Commit-ID: 80dc2b3e257cbd62e1cd5b18a6581f231c828c81
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

Commit-ID:  80dc2b3e257cbd62e1cd5b18a6581f231c828c81
Gitweb:     https://git.kernel.org/tip/80dc2b3e257cbd62e1cd5b18a6581f231c828c81
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:55 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Adopt simplified perf_evlist__open()/close() functions from tools/perf

Add the following functions:

  perf_evlist__open()
  perf_evlist__close()

It's a simplified version of perf's evlist__open() without the sampling
id index calculations. We can try to merge it in the future when we need
it in some new libperf user.

Also adopt some helper evlist traversing macros. In the future we can
remove them from util/evlist.h, but that requires also some other
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-69-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 27 +++++++++++++++++++++++++
 tools/perf/lib/include/internal/evlist.h | 34 ++++++++++++++++++++++++++++++++
 tools/perf/lib/include/perf/evlist.h     |  2 ++
 tools/perf/lib/libperf.map               |  2 ++
 4 files changed, 65 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 6a2308ef9868..5dda96b1d4da 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <perf/evlist.h>
+#include <perf/evsel.h>
 #include <linux/list.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
@@ -114,3 +115,29 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 
 	perf_evlist__propagate_maps(evlist);
 }
+
+int perf_evlist__open(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+	int err;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		err = perf_evsel__open(evsel, evsel->cpus, evsel->threads);
+		if (err < 0)
+			goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	perf_evlist__close(evlist);
+	return err;
+}
+
+void perf_evlist__close(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry_reverse(evlist, evsel)
+		perf_evsel__close(evsel);
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index b7b43dbc9b82..448891f06e3e 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -2,6 +2,8 @@
 #ifndef __LIBPERF_INTERNAL_EVLIST_H
 #define __LIBPERF_INTERNAL_EVLIST_H
 
+#include <linux/list.h>
+
 struct perf_cpu_map;
 struct perf_thread_map;
 
@@ -13,4 +15,36 @@ struct perf_evlist {
 	struct perf_thread_map	*threads;
 };
 
+/**
+ * __perf_evlist__for_each_entry - iterate thru all the evsels
+ * @list: list_head instance to iterate
+ * @evsel: struct perf_evsel iterator
+ */
+#define __perf_evlist__for_each_entry(list, evsel) \
+	list_for_each_entry(evsel, list, node)
+
+/**
+ * evlist__for_each_entry - iterate thru all the evsels
+ * @evlist: perf_evlist instance to iterate
+ * @evsel: struct perf_evsel iterator
+ */
+#define perf_evlist__for_each_entry(evlist, evsel) \
+	__perf_evlist__for_each_entry(&(evlist)->entries, evsel)
+
+/**
+ * __perf_evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
+ * @list: list_head instance to iterate
+ * @evsel: struct evsel iterator
+ */
+#define __perf_evlist__for_each_entry_reverse(list, evsel) \
+	list_for_each_entry_reverse(evsel, list, node)
+
+/**
+ * perf_evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
+ * @evlist: evlist instance to iterate
+ * @evsel: struct evsel iterator
+ */
+#define perf_evlist__for_each_entry_reverse(evlist, evsel) \
+	__perf_evlist__for_each_entry_reverse(&(evlist)->entries, evsel)
+
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index b1d8dee018d6..6d3dda743541 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -18,6 +18,8 @@ LIBPERF_API struct perf_evlist *perf_evlist__new(void);
 LIBPERF_API void perf_evlist__delete(struct perf_evlist *evlist);
 LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
 						 struct perf_evsel *evsel);
+LIBPERF_API int perf_evlist__open(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__close(struct perf_evlist *evlist);
 
 #define perf_evlist__for_each_evsel(evlist, pos)	\
 	for ((pos) = perf_evlist__next((evlist), NULL);	\
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 9f43b5cda031..4f966ddd5e53 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -25,6 +25,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__threads;
 		perf_evlist__new;
 		perf_evlist__delete;
+		perf_evlist__open;
+		perf_evlist__close;
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
