Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81488C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5030D21835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824401;
	bh=LPj9dTzhpJsBECL7/gTfppERK4IlrDo9SugAQoGD4XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dvySj0gydUazRqLJ1/hw/p+2jQ8l/XIgqzd+2jQwb3lTi03hJPZLjldnTvtQfJ/8J
	 ilCY4mbA5lHSTNRHgAn+lVTaeavg0B131odMbuCQeM018Br6khY957/hQVlps9FX7w
	 Dfq98IDj7hEPJbLPCQVTT4JkWOiAfr1uNX1OO8wQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfJKUGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbfJKUGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:06:39 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 597C221D80;
        Fri, 11 Oct 2019 20:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824398;
        bh=LPj9dTzhpJsBECL7/gTfppERK4IlrDo9SugAQoGD4XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhqUk9298z//v07Vm2eJtEz1fcSdTJbAcn2gSpz/qvEbCMQuG9dJZIB1E6HAKTJM5
         kTjoj+rAawxstXkk3cv2YLhAtaPCtnDWc2V1R+lTjfhQ7BHRU4m4XTggyui9jlKY4Q
         THE9rSwDJwxlMPua5Y9VO4R4N98tnFaPWtjaHIWw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 03/69] perf evlist: Adopt __set_tracepoint_handlers method from perf_session
Date:   Fri, 11 Oct 2019 17:04:53 -0300
Message-Id: <20191011200559.7156-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index d277a98e62df..b4c43ac4583f 100644
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
index 7cfe75522ba5..00eab9435847 100644
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
index 061bb4d6a3f5..6cc32f5ec043 100644
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
index b4c9428c18f0..8456e1d868fd 100644
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
 
-- 
2.21.0

