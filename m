Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7EC2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393625AbfITQXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:23:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404848AbfITQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLeb-00047D-Kz; Fri, 20 Sep 2019 18:21:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2555C1C0E2C;
        Fri, 20 Sep 2019 18:21:00 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:21:00 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf event: Move perf_event__synthesize* to event.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-outjyzh1o29ndcv9lsqyzt87@git.kernel.org>
References: <tip-outjyzh1o29ndcv9lsqyzt87@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899646007.24167.12247910897602587358.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     278306163882a3557fb2c69fd2cc632a2f9ef601
Gitweb:        https://git.kernel.org/tip/278306163882a3557fb2c69fd2cc632a2f9ef601
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 10 Sep 2019 16:42:52 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 09:19:21 -03:00

perf event: Move perf_event__synthesize* to event.h

Where is the perf_event__handler_t typedef they need, which was the only
reason for header.h to be including event.h, untangle that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-outjyzh1o29ndcv9lsqyzt87@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.h  | 36 +++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h | 42 ++-------------------------------------
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 47ad81d..4e6d33c 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -279,6 +279,9 @@ enum {
 
 void perf_event__print_totals(void);
 
+struct evlist;
+struct evsel;
+struct perf_session;
 struct perf_tool;
 struct perf_thread_map;
 struct perf_cpu_map;
@@ -290,6 +293,39 @@ typedef int (*perf_event__handler_t)(struct perf_tool *tool,
 				     struct perf_sample *sample,
 				     struct machine *machine);
 
+int perf_event__synthesize_attr(struct perf_tool *tool,
+				struct perf_event_attr *attr, u32 ids, u64 *id,
+				perf_event__handler_t process);
+int perf_event__synthesize_attrs(struct perf_tool *tool,
+				 struct evlist *evlist,
+				 perf_event__handler_t process);
+int perf_event__synthesize_build_id(struct perf_tool *tool,
+				    struct dso *pos, u16 misc,
+				    perf_event__handler_t process,
+				    struct machine *machine);
+int perf_event__synthesize_extra_attr(struct perf_tool *tool,
+				      struct evlist *evsel_list,
+				      perf_event__handler_t process,
+				      bool is_pipe);
+int perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
+					     struct evsel *evsel,
+					     perf_event__handler_t process);
+int perf_event__synthesize_event_update_name(struct perf_tool *tool,
+					     struct evsel *evsel,
+					     perf_event__handler_t process);
+int perf_event__synthesize_event_update_scale(struct perf_tool *tool,
+					      struct evsel *evsel,
+					      perf_event__handler_t process);
+int perf_event__synthesize_event_update_unit(struct perf_tool *tool,
+					     struct evsel *evsel,
+					     perf_event__handler_t process);
+int perf_event__synthesize_features(struct perf_tool *tool,
+				    struct perf_session *session,
+				    struct evlist *evlist,
+				    perf_event__handler_t process);
+int perf_event__synthesize_tracing_data(struct perf_tool *tool,
+					int fd, struct evlist *evlist,
+					perf_event__handler_t process);
 int perf_event__synthesize_thread_map(struct perf_tool *tool,
 				      struct perf_thread_map *threads,
 				      perf_event__handler_t process,
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 3e48ae3..999dac4 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -5,10 +5,10 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include <sys/types.h>
+#include <stdio.h> // FILE
 #include <stdbool.h>
 #include <linux/bitmap.h>
 #include <linux/types.h>
-#include "event.h"
 #include "env.h"
 #include "pmu.h"
 
@@ -94,6 +94,8 @@ struct perf_header {
 
 struct evlist;
 struct perf_session;
+struct perf_tool;
+union perf_event;
 
 int perf_session__read_header(struct perf_session *session);
 int perf_session__write_header(struct perf_session *session,
@@ -115,54 +117,16 @@ int perf_header__process_sections(struct perf_header *header, int fd,
 
 int perf_header__fprintf_info(struct perf_session *s, FILE *fp, bool full);
 
-int perf_event__synthesize_features(struct perf_tool *tool,
-				    struct perf_session *session,
-				    struct evlist *evlist,
-				    perf_event__handler_t process);
-
-int perf_event__synthesize_extra_attr(struct perf_tool *tool,
-				      struct evlist *evsel_list,
-				      perf_event__handler_t process,
-				      bool is_pipe);
-
 int perf_event__process_feature(struct perf_session *session,
 				union perf_event *event);
-
-int perf_event__synthesize_attr(struct perf_tool *tool,
-				struct perf_event_attr *attr, u32 ids, u64 *id,
-				perf_event__handler_t process);
-int perf_event__synthesize_attrs(struct perf_tool *tool,
-				 struct evlist *evlist,
-				 perf_event__handler_t process);
-int perf_event__synthesize_event_update_unit(struct perf_tool *tool,
-					     struct evsel *evsel,
-					     perf_event__handler_t process);
-int perf_event__synthesize_event_update_scale(struct perf_tool *tool,
-					      struct evsel *evsel,
-					      perf_event__handler_t process);
-int perf_event__synthesize_event_update_name(struct perf_tool *tool,
-					     struct evsel *evsel,
-					     perf_event__handler_t process);
-int perf_event__synthesize_event_update_cpus(struct perf_tool *tool,
-					     struct evsel *evsel,
-					     perf_event__handler_t process);
 int perf_event__process_attr(struct perf_tool *tool, union perf_event *event,
 			     struct evlist **pevlist);
 int perf_event__process_event_update(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct evlist **pevlist);
 size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp);
-
-int perf_event__synthesize_tracing_data(struct perf_tool *tool,
-					int fd, struct evlist *evlist,
-					perf_event__handler_t process);
 int perf_event__process_tracing_data(struct perf_session *session,
 				     union perf_event *event);
-
-int perf_event__synthesize_build_id(struct perf_tool *tool,
-				    struct dso *pos, u16 misc,
-				    perf_event__handler_t process,
-				    struct machine *machine);
 int perf_event__process_build_id(struct perf_session *session,
 				 union perf_event *event);
 bool is_perf_magic(u64 magic);
