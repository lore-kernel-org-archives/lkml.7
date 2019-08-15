Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB602C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816EB208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="1Yd5y0Xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbfHOJbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:31:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38427 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOJbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:31:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9VWwc2274393
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:31:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9VWwc2274393
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861493;
        bh=nlS6jRcmhYdusrdJEPi5/I1pR9Nj7ux3gwKkdKr9NnI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=1Yd5y0Xf9KBXHsljILvjUUb73o6LqmTMJzh5YIgWYtHCAICRfei/GLGMpgBEQQ9LP
         zKwJ9WlBuBZG8b5LamsfpWVZ8vU6HDaVxMraFlJSxLwp6qIbGKQK/Jcfb/68Sg9Ibp
         eUWt/mQUp90m26kdauAL6oLBOiYUlGJlmzWuLnYjPsHiB9Jy7g2gnBuc5rDihj3fVV
         MQJv41ILypMN8+ED4kYzvuG3I3OGtpy9QjL9wlG/tybuDGw0Y5ITAH8GDpOT+w3FBo
         siRBgVoOH3V9I9ua2ald05MrGgTOrU2LnVue4knhP1Bc5WH1UGipUgsRadJNFBECNT
         KKIhfJOKloZcg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9VWF22274389;
        Thu, 15 Aug 2019 02:31:32 -0700
Date:   Thu, 15 Aug 2019 02:31:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-9e64cefe4335b0f2799956d3f3cca8bb652d950f@git.kernel.org>
Cc:     acme@redhat.com, jolsa@kernel.org, kan.liang@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        peterz@infradead.org, namhyung@kernel.org, hpa@zytor.com
Reply-To: namhyung@kernel.org, kan.liang@linux.intel.com, jolsa@kernel.org,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, peterz@infradead.org, adrian.hunter@intel.com
In-Reply-To: <20190806084606.4021-6-alexander.shishkin@linux.intel.com>
References: <20190806084606.4021-6-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Process options for PEBS event
 synthesis
Git-Commit-ID: 9e64cefe4335b0f2799956d3f3cca8bb652d950f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9e64cefe4335b0f2799956d3f3cca8bb652d950f
Gitweb:     https://git.kernel.org/tip/9e64cefe4335b0f2799956d3f3cca8bb652d950f
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Aug 2019 11:46:04 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf intel-pt: Process options for PEBS event synthesis

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
