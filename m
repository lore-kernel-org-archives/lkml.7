Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A408DC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836BB218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfGDQAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:00:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:53366 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfGDQAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:00:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="185016986"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jul 2019 09:00:39 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 5/7] perf intel-pt: Process options for PEBS event synthesis
Date:   Thu,  4 Jul 2019 19:00:22 +0300
Message-Id: <20190704160024.56600-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704160024.56600-1-alexander.shishkin@linux.intel.com>
References: <20190704160024.56600-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Process synth_opts.other_events and attr.aux_source to set up for
synthesizing PEBs via Intel PT events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 23 +++++++++++++++++++++++
 tools/perf/util/intel-pt.c          | 18 ++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 9804098dcefb..a776cfcc0705 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -548,6 +548,26 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
 					evsel->attr.config);
 }
 
+/*
+ * Currently, there is not enough information to disambiguate different PEBS
+ * events, so only allow one.
+ */
+static bool intel_pt_too_many_aux_source(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+	int aux_source_cnt = 0;
+
+	evlist__for_each_entry(evlist, evsel)
+		aux_source_cnt += !!evsel->attr.aux_source;
+
+	if (aux_source_cnt > 1) {
+		pr_err(INTEL_PT_PMU_NAME " supports at most one event with aux-source\n");
+		return true;
+	}
+
+	return false;
+}
+
 static int intel_pt_recording_options(struct auxtrace_record *itr,
 				      struct perf_evlist *evlist,
 				      struct record_opts *opts)
@@ -588,6 +608,9 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		return -EINVAL;
 	}
 
+	if (intel_pt_too_many_aux_source(evlist))
+		return -EINVAL;
+
 	if (!opts->full_auxtrace)
 		return 0;
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 470aaae9d930..b8771e073efb 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2894,6 +2894,22 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 	return 0;
 }
 
+static void intel_pt_setup_pebs_events(struct intel_pt *pt)
+{
+	struct perf_evsel *evsel;
+
+	if (!pt->synth_opts.other_events)
+		return;
+
+	evlist__for_each_entry(pt->session->evlist, evsel) {
+		if (evsel->attr.aux_source && evsel->id) {
+			pt->sample_pebs = true;
+			pt->pebs_evsel = evsel;
+			return;
+		}
+	}
+}
+
 static struct perf_evsel *intel_pt_find_sched_switch(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel;
@@ -3266,6 +3282,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_delete_thread;
 
+	intel_pt_setup_pebs_events(pt);
+
 	err = auxtrace_queues__process_index(&pt->queues, session);
 	if (err)
 		goto err_delete_thread;
-- 
2.20.1

