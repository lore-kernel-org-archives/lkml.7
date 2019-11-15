Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8383C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A3F2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfKOMnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:43:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbfKOMng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749684"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:35 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] perf auxtrace: Add support for dumping AUX area samples
Date:   Fri, 15 Nov 2019 14:42:19 +0200
Message-Id: <20191115124225.5247-10-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124225.5247-1-adrian.hunter@intel.com>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for dumping AUX area samples i.e. via the perf script/report
 -D (--dump-raw-trace) option.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 10 ++++++++++
 tools/perf/util/auxtrace.h | 11 +++++++++++
 tools/perf/util/session.c  |  9 +++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 026585b67a3c..4f5c5fe3516b 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2417,6 +2417,16 @@ int auxtrace__process_event(struct perf_session *session, union perf_event *even
 	return session->auxtrace->process_event(session, event, sample, tool);
 }
 
+void auxtrace__dump_auxtrace_sample(struct perf_session *session,
+				    struct perf_sample *sample)
+{
+	if (!session->auxtrace || !session->auxtrace->dump_auxtrace_sample ||
+	    auxtrace__dont_decode(session))
+		return;
+
+	session->auxtrace->dump_auxtrace_sample(session, sample);
+}
+
 int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool)
 {
 	if (!session->auxtrace)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 12b02eb4e01c..7ca3e6dcf8b8 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -141,6 +141,7 @@ struct auxtrace_index {
  * struct auxtrace - session callbacks to allow AUX area data decoding.
  * @process_event: lets the decoder see all session events
  * @process_auxtrace_event: process a PERF_RECORD_AUXTRACE event
+ * @dump_auxtrace_sample: dump AUX area sample data
  * @flush_events: process any remaining data
  * @free_events: free resources associated with event processing
  * @free: free resources associated with the session
@@ -153,6 +154,8 @@ struct auxtrace {
 	int (*process_auxtrace_event)(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_tool *tool);
+	void (*dump_auxtrace_sample)(struct perf_session *session,
+				     struct perf_sample *sample);
 	int (*flush_events)(struct perf_session *session,
 			    struct perf_tool *tool);
 	void (*free_events)(struct perf_session *session);
@@ -555,6 +558,8 @@ int auxtrace_parse_filters(struct evlist *evlist);
 
 int auxtrace__process_event(struct perf_session *session, union perf_event *event,
 			    struct perf_sample *sample, struct perf_tool *tool);
+void auxtrace__dump_auxtrace_sample(struct perf_session *session,
+				    struct perf_sample *sample);
 int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool);
 void auxtrace__free_events(struct perf_session *session);
 void auxtrace__free(struct perf_session *session);
@@ -673,6 +678,12 @@ int auxtrace__process_event(struct perf_session *session __maybe_unused,
 	return 0;
 }
 
+static inline
+void auxtrace__dump_auxtrace_sample(struct perf_session *session,
+				    struct perf_sample *sample)
+{
+}
+
 static inline
 int auxtrace__flush_events(struct perf_session *session __maybe_unused,
 			   struct perf_tool *tool __maybe_unused)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index eb7ffd5524dc..72a1f73c2878 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1496,8 +1496,13 @@ static int perf_session__deliver_event(struct perf_session *session,
 	if (ret > 0)
 		return 0;
 
-	return machines__deliver_event(&session->machines, session->evlist,
-				       event, &sample, tool, file_offset);
+	ret = machines__deliver_event(&session->machines, session->evlist,
+				      event, &sample, tool, file_offset);
+
+	if (dump_trace && sample.aux_sample.size)
+		auxtrace__dump_auxtrace_sample(session, &sample);
+
+	return ret;
 }
 
 static s64 perf_session__process_user_event(struct perf_session *session,
-- 
2.17.1

