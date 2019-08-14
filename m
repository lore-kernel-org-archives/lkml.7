Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2546AC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFE22084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808315;
	bh=LN2nON9IB2dArS/LeA33fzoRnPn+aCnWHqeHNC0fLjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FQzxGIg/N/H8xis5IlxqVJxyudBZsLeysSDRKeQxkypsKhlbAgs0o8DXo50seBEM9
	 xVCyt8A7mRcHKxEwDoODdqHNrwlR+86Ycd7GiOHip+/4iyzl+ATV/u0RBi0qxYtr1M
	 n62gKH/c3ingPALiYU1GvjvA28PU/RCI+wt7RPII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfHNSpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfHNSpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:45:13 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27DC321721;
        Wed, 14 Aug 2019 18:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808312;
        bh=LN2nON9IB2dArS/LeA33fzoRnPn+aCnWHqeHNC0fLjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBkzFdSQImaaZaqY62rauiFOFM5vGmzbVRD3dAhSWFJNTzNNC4NizmYBW1eGL8VGS
         6oHIn1lnkVb+zmv+jVN4w/rt3Tju0hPCE4NiNVK9YAoKX3J5gmKRap8HtZuucyUyCU
         tgaZ0dBSWgaiH74DhP0oRXlXKGEXSSx8EeDBnniQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/28] perf intel-pt: Process options for PEBS event synthesis
Date:   Wed, 14 Aug 2019 15:40:44 -0300
Message-Id: <20190814184051.3125-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Process synth_opts.other_events and attr.aux_output to set up for
synthesizing PEBs via Intel PT events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806084606.4021-6-alexander.shishkin@linux.intel.com
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
[ Fixed up libbperf clashes, i.e. some places using perf_evsel (now in libperf)
  need to use instead 'evsel' (a tools/perf only abstraction) ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 23 +++++++++++++++++++++++
 tools/perf/util/intel-pt.c          | 18 ++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 218a4e694618..a8e633aa278a 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -548,6 +548,26 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
 					evsel->core.attr.config);
 }
 
+/*
+ * Currently, there is not enough information to disambiguate different PEBS
+ * events, so only allow one.
+ */
+static bool intel_pt_too_many_aux_output(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	int aux_output_cnt = 0;
+
+	evlist__for_each_entry(evlist, evsel)
+		aux_output_cnt += !!evsel->core.attr.aux_output;
+
+	if (aux_output_cnt > 1) {
+		pr_err(INTEL_PT_PMU_NAME " supports at most one event with aux-output\n");
+		return true;
+	}
+
+	return false;
+}
+
 static int intel_pt_recording_options(struct auxtrace_record *itr,
 				      struct evlist *evlist,
 				      struct record_opts *opts)
@@ -588,6 +608,9 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		return -EINVAL;
 	}
 
+	if (intel_pt_too_many_aux_output(evlist))
+		return -EINVAL;
+
 	if (!opts->full_auxtrace)
 		return 0;
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 4c52204868d8..ea504fa9b623 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2894,6 +2894,22 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 	return 0;
 }
 
+static void intel_pt_setup_pebs_events(struct intel_pt *pt)
+{
+	struct evsel *evsel;
+
+	if (!pt->synth_opts.other_events)
+		return;
+
+	evlist__for_each_entry(pt->session->evlist, evsel) {
+		if (evsel->core.attr.aux_output && evsel->id) {
+			pt->sample_pebs = true;
+			pt->pebs_evsel = evsel;
+			return;
+		}
+	}
+}
+
 static struct evsel *intel_pt_find_sched_switch(struct evlist *evlist)
 {
 	struct evsel *evsel;
@@ -3263,6 +3279,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_delete_thread;
 
+	intel_pt_setup_pebs_events(pt);
+
 	err = auxtrace_queues__process_index(&pt->queues, session);
 	if (err)
 		goto err_delete_thread;
-- 
2.21.0

