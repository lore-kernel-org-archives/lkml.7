Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95DFC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0986207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbfFJH3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:29:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:14549 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388098AbfFJH33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:29:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 00:29:29 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2019 00:29:26 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] perf intel-pt: Factor out common sample preparation for re-use
Date:   Mon, 10 Jun 2019 10:27:57 +0300
Message-Id: <20190610072803.10456-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610072803.10456-1-adrian.hunter@intel.com>
References: <20190610072803.10456-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out common sample preparation for re-use when synthesizing PEBS
samples.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 389ec4612f86..1f5520f964ab 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1078,28 +1078,37 @@ static inline bool intel_pt_skip_event(struct intel_pt *pt)
 	       pt->num_events++ < pt->synth_opts.initial_skip;
 }
 
+static void intel_pt_prep_a_sample(struct intel_pt_queue *ptq,
+				   union perf_event *event,
+				   struct perf_sample *sample)
+{
+	event->sample.header.type = PERF_RECORD_SAMPLE;
+	event->sample.header.size = sizeof(struct perf_event_header);
+
+	sample->pid = ptq->pid;
+	sample->tid = ptq->tid;
+	sample->cpu = ptq->cpu;
+	sample->insn_len = ptq->insn_len;
+	memcpy(sample->insn, ptq->insn, INTEL_PT_INSN_BUF_SZ);
+}
+
 static void intel_pt_prep_b_sample(struct intel_pt *pt,
 				   struct intel_pt_queue *ptq,
 				   union perf_event *event,
 				   struct perf_sample *sample)
 {
+	intel_pt_prep_a_sample(ptq, event, sample);
+
 	if (!pt->timeless_decoding)
 		sample->time = tsc_to_perf_time(ptq->timestamp, &pt->tc);
 
 	sample->ip = ptq->state->from_ip;
 	sample->cpumode = intel_pt_cpumode(pt, sample->ip);
-	sample->pid = ptq->pid;
-	sample->tid = ptq->tid;
 	sample->addr = ptq->state->to_ip;
 	sample->period = 1;
-	sample->cpu = ptq->cpu;
 	sample->flags = ptq->flags;
-	sample->insn_len = ptq->insn_len;
-	memcpy(sample->insn, ptq->insn, INTEL_PT_INSN_BUF_SZ);
 
-	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = sample->cpumode;
-	event->sample.header.size = sizeof(struct perf_event_header);
 }
 
 static int intel_pt_inject_event(union perf_event *event,
-- 
2.17.1

