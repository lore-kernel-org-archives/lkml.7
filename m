Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42BEC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6B6207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbfFJH3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:29:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:14549 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388054AbfFJH3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:29:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 00:29:31 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2019 00:29:29 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] perf intel-pt: Synthesize PEBS sample basic information
Date:   Mon, 10 Jun 2019 10:27:58 +0300
Message-Id: <20190610072803.10456-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610072803.10456-1-adrian.hunter@intel.com>
References: <20190610072803.10456-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthesize a PEBS sample using basic information (ip, timestamp) only.
Other PEBS information will be added in later patches.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 52 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 1f5520f964ab..4517c02fa478 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1443,9 +1443,57 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 					    pt->pwr_events_sample_type);
 }
 
-static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq __maybe_unused)
+static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
-	return 0;
+	const struct intel_pt_blk_items *items = &ptq->state->items;
+	struct perf_sample sample = { .ip = 0, };
+	union perf_event *event = ptq->event_buf;
+	struct intel_pt *pt = ptq->pt;
+	struct perf_evsel *evsel = pt->pebs_evsel;
+	u64 sample_type = evsel->attr.sample_type;
+	u64 id = evsel->id[0];
+	u8 cpumode;
+
+	if (intel_pt_skip_event(pt))
+		return 0;
+
+	intel_pt_prep_a_sample(ptq, event, &sample);
+
+	sample.id = id;
+	sample.stream_id = id;
+
+	if (!evsel->attr.freq)
+		sample.period = evsel->attr.sample_period;
+
+	/* No support for non-zero CS base */
+	if (items->has_ip)
+		sample.ip = items->ip;
+	else if (items->has_rip)
+		sample.ip = items->rip;
+	else
+		sample.ip = ptq->state->from_ip;
+
+	/* No support for guest mode at this time */
+	cpumode = sample.ip < ptq->pt->kernel_start ?
+		  PERF_RECORD_MISC_USER :
+		  PERF_RECORD_MISC_KERNEL;
+
+	event->sample.header.misc = cpumode | PERF_RECORD_MISC_EXACT_IP;
+
+	sample.cpumode = cpumode;
+
+	if (sample_type & PERF_SAMPLE_TIME) {
+		u64 timestamp = 0;
+
+		if (items->has_timestamp)
+			timestamp = items->timestamp;
+		else if (!pt->timeless_decoding)
+			timestamp = ptq->timestamp;
+		if (timestamp)
+			sample.time = tsc_to_perf_time(timestamp, &pt->tc);
+	}
+
+	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
 static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
-- 
2.17.1

