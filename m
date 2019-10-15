Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C529EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE412086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfJOFdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:33:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42249 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbfJOFcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRQ-0000X2-8K; Tue, 15 Oct 2019 07:32:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8C9051C070D;
        Tue, 15 Oct 2019 07:31:52 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:52 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Adopt __set_tracepoint_handlers method
 from perf_session
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-9oc53gnfi53vg82fvolkm85g@git.kernel.org>
References: <tip-9oc53gnfi53vg82fvolkm85g@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111751245.12254.8726429854829041178.tip-bot2@tip-bot2>
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

Commit-ID:     c0e53476ab5087353547cbcd37f001d98941326c
Gitweb:        https://git.kernel.org/tip/c0e53476ab5087353547cbcd37f001d98941326c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 01 Oct 2019 11:14:26 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:17 -03:00

perf evlist: Adopt __set_tracepoint_handlers method from perf_session

It all operates on the evsels in the session's evlist, so move it to the
evlist layer to make it useful to tools not using perf_session, just
evlists, like 'perf trace' in live mode.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9oc53gnfi53vg82fvolkm85g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c  | 24 ++++++++++++++++++++++++
 tools/perf/util/evlist.h  |  7 +++++++
 tools/perf/util/session.c | 29 -----------------------------
 tools/perf/util/session.h |  6 +-----
 4 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d277a98..b4c43ac 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -186,6 +186,30 @@ void perf_evlist__splice_list_tail(struct evlist *evlist,
 	}
 }
 
+int __evlist__set_tracepoints_handlers(struct evlist *evlist,
+				       const struct evsel_str_handler *assocs, size_t nr_assocs)
+{
+	struct evsel *evsel;
+	size_t i;
+	int err;
+
+	for (i = 0; i < nr_assocs; i++) {
+		// Adding a handler for an event not in this evlist, just ignore it.
+		evsel = perf_evlist__find_tracepoint_by_name(evlist, assocs[i].name);
+		if (evsel == NULL)
+			continue;
+
+		err = -EEXIST;
+		if (evsel->handler != NULL)
+			goto out;
+		evsel->handler = assocs[i].handler;
+	}
+
+	err = 0;
+out:
+	return err;
+}
+
 void __perf_evlist__set_leader(struct list_head *list)
 {
 	struct evsel *evsel, *leader;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 7cfe755..00eab94 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -118,6 +118,13 @@ void perf_evlist__stop_sb_thread(struct evlist *evlist);
 int perf_evlist__add_newtp(struct evlist *evlist,
 			   const char *sys, const char *name, void *handler);
 
+int __evlist__set_tracepoints_handlers(struct evlist *evlist,
+				       const struct evsel_str_handler *assocs,
+				       size_t nr_assocs);
+
+#define evlist__set_tracepoints_handlers(evlist, array) \
+	__evlist__set_tracepoints_handlers(evlist, array, ARRAY_SIZE(array))
+
 void __perf_evlist__set_sample_bit(struct evlist *evlist,
 				   enum perf_event_sample_format bit);
 void __perf_evlist__reset_sample_bit(struct evlist *evlist,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 061bb4d..6cc32f5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2355,35 +2355,6 @@ void perf_session__fprintf_info(struct perf_session *session, FILE *fp,
 	fprintf(fp, "# ========\n#\n");
 }
 
-
-int __perf_session__set_tracepoints_handlers(struct perf_session *session,
-					     const struct evsel_str_handler *assocs,
-					     size_t nr_assocs)
-{
-	struct evsel *evsel;
-	size_t i;
-	int err;
-
-	for (i = 0; i < nr_assocs; i++) {
-		/*
-		 * Adding a handler for an event not in the session,
-		 * just ignore it.
-		 */
-		evsel = perf_evlist__find_tracepoint_by_name(session->evlist, assocs[i].name);
-		if (evsel == NULL)
-			continue;
-
-		err = -EEXIST;
-		if (evsel->handler != NULL)
-			goto out;
-		evsel->handler = assocs[i].handler;
-	}
-
-	err = 0;
-out:
-	return err;
-}
-
 int perf_event__process_id_index(struct perf_session *session,
 				 union perf_event *event)
 {
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index b4c9428..8456e1d 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -120,12 +120,8 @@ void perf_session__fprintf_info(struct perf_session *s, FILE *fp, bool full);
 
 struct evsel_str_handler;
 
-int __perf_session__set_tracepoints_handlers(struct perf_session *session,
-					     const struct evsel_str_handler *assocs,
-					     size_t nr_assocs);
-
 #define perf_session__set_tracepoints_handlers(session, array) \
-	__perf_session__set_tracepoints_handlers(session, array, ARRAY_SIZE(array))
+	__evlist__set_tracepoints_handlers(session->evlist, array, ARRAY_SIZE(array))
 
 extern volatile int session_done;
 
