Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352FEC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C902086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393582AbfITQWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:22:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52829 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404907AbfITQVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:15 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLee-00046o-0A; Fri, 20 Sep 2019 18:21:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EC8D11C0E2D;
        Fri, 20 Sep 2019 18:20:59 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:20:59 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf stat: Move perf_stat_synthesize_config() to event.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-q5ebhrp44txboobs86htu5r9@git.kernel.org>
References: <tip-q5ebhrp44txboobs86htu5r9@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899645989.24167.3290450684967954761.tip-bot2@tip-bot2>
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

Commit-ID:     b251892d6ceafa3c8f8e6835a664e248766b1b3e
Gitweb:        https://git.kernel.org/tip/b251892d6ceafa3c8f8e6835a664e248766b1b3e
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 10 Sep 2019 17:17:33 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 09:19:21 -03:00

perf stat: Move perf_stat_synthesize_config() to event.h

Together with the other synthsizers, and rename it to
perf_event__synthesize_stat_events().

This allows us to stop including event.h in util/stat.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-q5ebhrp44txboobs86htu5r9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c |  4 ++--
 tools/perf/util/event.h   |  5 +++++
 tools/perf/util/stat.c    | 10 +++++-----
 tools/perf/util/stat.h    |  8 ++------
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5bc0c57..b55e806 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -540,8 +540,8 @@ try_again:
 		if (err < 0)
 			return err;
 
-		err = perf_stat_synthesize_config(&stat_config, NULL, evsel_list,
-						  process_synthesized_event, is_pipe);
+		err = perf_event__synthesize_stat_events(&stat_config, NULL, evsel_list,
+							 process_synthesized_event, is_pipe);
 		if (err < 0)
 			return err;
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 4e6d33c..89a2404 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -293,6 +293,11 @@ typedef int (*perf_event__handler_t)(struct perf_tool *tool,
 				     struct perf_sample *sample,
 				     struct machine *machine);
 
+int perf_event__synthesize_stat_events(struct perf_stat_config *config,
+				       struct perf_tool *tool,
+				       struct evlist *evlist,
+				       perf_event__handler_t process,
+				       bool attrs);
 int perf_event__synthesize_attr(struct perf_tool *tool,
 				struct perf_event_attr *attr, u32 ids, u64 *id,
 				perf_event__handler_t process);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index d309c1c..2e318d9 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -495,11 +495,11 @@ int create_perf_stat_counter(struct evsel *evsel,
 	return perf_evsel__open_per_thread(evsel, evsel->core.threads);
 }
 
-int perf_stat_synthesize_config(struct perf_stat_config *config,
-				struct perf_tool *tool,
-				struct evlist *evlist,
-				perf_event__handler_t process,
-				bool attrs)
+int perf_event__synthesize_stat_events(struct perf_stat_config *config,
+				       struct perf_tool *tool,
+				       struct evlist *evlist,
+				       perf_event__handler_t process,
+				       bool attrs)
 {
 	int err;
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 14fe3e5..0f9c9f6 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -7,8 +7,9 @@
 #include <sys/types.h>
 #include <sys/resource.h>
 #include "rblist.h"
-#include "event.h"
 
+struct perf_cpu_map;
+struct perf_stat_config;
 struct timespec;
 
 struct stats {
@@ -210,11 +211,6 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
 int create_perf_stat_counter(struct evsel *evsel,
 			     struct perf_stat_config *config,
 			     struct target *target);
-int perf_stat_synthesize_config(struct perf_stat_config *config,
-				struct perf_tool *tool,
-				struct evlist *evlist,
-				perf_event__handler_t process,
-				bool attrs);
 void
 perf_evlist__print_counters(struct evlist *evlist,
 			    struct perf_stat_config *config,
