Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D855CECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD0421848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfJOFb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:31:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41929 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfJOFbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQm-0008S5-1r; Tue, 15 Oct 2019 07:31:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A7D4C1C0482;
        Tue, 15 Oct 2019 07:31:35 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:35 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Introduce perf_evlist__purge()
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-26-jolsa@kernel.org>
References: <20191007125344.14268-26-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749561.12254.7991223629195181264.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     696f27c994ed056fd176ce9dc51c7988e148e4b0
Gitweb:        https://git.kernel.org/tip/696f27c994ed056fd176ce9dc51c7988e148e4b0
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:33 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 12:57:22 -03:00

libperf: Introduce perf_evlist__purge()

Add a static perf_evlist__purge() function to purge evsels from a evlist.

Add also perf_evlist__for_each_entry_safe() which is used by
perf_evlist__purge().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-26-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c                  | 13 +++++++++++++
 tools/perf/lib/include/internal/evlist.h | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 7ba98f0..9534ad9 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -109,6 +109,18 @@ perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
 	return next;
 }
 
+static void perf_evlist__purge(struct perf_evlist *evlist)
+{
+	struct perf_evsel *pos, *n;
+
+	perf_evlist__for_each_entry_safe(evlist, n, pos) {
+		list_del_init(&pos->node);
+		perf_evsel__delete(pos);
+	}
+
+	evlist->nr_entries = 0;
+}
+
 void perf_evlist__exit(struct perf_evlist *evlist)
 {
 	perf_cpu_map__put(evlist->cpus);
@@ -125,6 +137,7 @@ void perf_evlist__delete(struct perf_evlist *evlist)
 
 	perf_evlist__munmap(evlist);
 	perf_evlist__close(evlist);
+	perf_evlist__purge(evlist);
 	perf_evlist__exit(evlist);
 	free(evlist);
 }
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 0721512..be0b25a 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -82,6 +82,24 @@ void perf_evlist__exit(struct perf_evlist *evlist);
 #define perf_evlist__for_each_entry_reverse(evlist, evsel) \
 	__perf_evlist__for_each_entry_reverse(&(evlist)->entries, evsel)
 
+/**
+ * __perf_evlist__for_each_entry_safe - safely iterate thru all the evsels
+ * @list: list_head instance to iterate
+ * @tmp: struct evsel temp iterator
+ * @evsel: struct evsel iterator
+ */
+#define __perf_evlist__for_each_entry_safe(list, tmp, evsel) \
+	list_for_each_entry_safe(evsel, tmp, list, node)
+
+/**
+ * perf_evlist__for_each_entry_safe - safely iterate thru all the evsels
+ * @evlist: evlist instance to iterate
+ * @evsel: struct evsel iterator
+ * @tmp: struct evsel temp iterator
+ */
+#define perf_evlist__for_each_entry_safe(evlist, tmp, evsel) \
+	__perf_evlist__for_each_entry_safe(&(evlist)->entries, tmp, evsel)
+
 static inline struct perf_evsel *perf_evlist__first(struct perf_evlist *evlist)
 {
 	return list_entry(evlist->entries.next, struct perf_evsel, node);
