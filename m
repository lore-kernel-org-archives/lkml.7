Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1393C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BCD2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfKOMnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:43:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfKOMne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749681"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:33 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] perf inject: Cut AUX area samples
Date:   Fri, 15 Nov 2019 14:42:18 +0200
Message-Id: <20191115124225.5247-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124225.5247-1-adrian.hunter@intel.com>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After decoding AUX area samples, the AUX area data is no longer needed
(having been replaced by synthesized events) so cut it out.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-inject.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 1e5d28311e14..9664a72a089d 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -45,6 +45,7 @@ struct perf_inject {
 	u64			aux_id;
 	struct list_head	samples;
 	struct itrace_synth_opts itrace_synth_opts;
+	char			event_copy[PERF_SAMPLE_MAX_SIZE];
 };
 
 struct event_entry {
@@ -214,6 +215,28 @@ static int perf_event__drop_aux(struct perf_tool *tool,
 	return 0;
 }
 
+static union perf_event *
+perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
+				 union perf_event *event,
+				 struct perf_sample *sample)
+{
+	size_t sz1 = sample->aux_sample.data - (void *)event;
+	size_t sz2 = event->header.size - sample->aux_sample.size - sz1;
+	union perf_event *ev = (union perf_event *)inject->event_copy;
+
+	if (sz1 > event->header.size || sz2 > event->header.size ||
+	    sz1 + sz2 > event->header.size ||
+	    sz1 < sizeof(struct perf_event_header) + sizeof(u64))
+		return event;
+
+	memcpy(ev, event, sz1);
+	memcpy((void *)ev + sz1, (void *)event + event->header.size - sz2, sz2);
+	ev->header.size = sz1 + sz2;
+	((u64 *)((void *)ev + sz1))[-1] = 0;
+
+	return ev;
+}
+
 typedef int (*inject_handler)(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
@@ -226,6 +249,9 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 				     struct evsel *evsel,
 				     struct machine *machine)
 {
+	struct perf_inject *inject = container_of(tool, struct perf_inject,
+						  tool);
+
 	if (evsel && evsel->handler) {
 		inject_handler f = evsel->handler;
 		return f(tool, event, sample, evsel, machine);
@@ -233,6 +259,9 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 
 	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
 
+	if (inject->itrace_synth_opts.set && sample->aux_sample.size)
+		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
+
 	return perf_event__repipe_synth(tool, event);
 }
 
-- 
2.17.1

