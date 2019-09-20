Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C7DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F094520882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989636;
	bh=nWOLRT3qcZ0kcr3etpWUbtT9PO9YK87+jIAM0caWO3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wbbHlILtT7I/FKptVpO0USCke7sKRxzxeiVadFdAl6nMRJ8gQcF3V13nM1mig4Omt
	 TiqL2iNz9Adq51lWlHlDg+esBf5gb2VU0Qgum/Et0WF2XI+jnCjtg/RIpDSZqYO2qn
	 iynnjAgww0kOoccnXio9rSfyfk8hAKwb/+PeOmFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389691AbfITO1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389112AbfITO0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C9321A49;
        Fri, 20 Sep 2019 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989591;
        bh=nWOLRT3qcZ0kcr3etpWUbtT9PO9YK87+jIAM0caWO3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=In+/M3bpO4/U51+DtpxGp3nHgN6YY+RK63AOFB8Fxt/HGe1FRC7xCqK6InEgstu8g
         y9ObhxMVuOrM8k0X66M2SD3IvZIOn2iSVVrY70I4qAPvyGUTLqUpWAi1/OcAcRaOu/
         U5J5PJEv7FeTX//iSAi6RuR+g7dXQct+/DUfOKpY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 14/31] perf event: Move perf_event__synthesize* to event.h
Date:   Fri, 20 Sep 2019 11:25:25 -0300
Message-Id: <20190920142542.12047-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Where is the perf_event__handler_t typedef they need, which was the only
reason for header.h to be including event.h, untangle that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-outjyzh1o29ndcv9lsqyzt87@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.h  | 36 ++++++++++++++++++++++++++++++++++
 tools/perf/util/header.h | 42 +++-------------------------------------
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 47ad81d47b1a..4e6d33c76d57 100644
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
index 3e48ae3c49b1..999dac41871e 100644
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
-- 
2.21.0

