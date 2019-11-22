Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6165E20706
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434722;
	bh=7au0IO5/UDVIEcCqwQ/MnGIP8BuR1YX+Hv0dGlUJdM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QAfDFmmRlDysQQUEY/2KlyeowaugA/gWpNuB9JVVKLn5WOLAKGCzZPY3zdBGcsqr6
	 CqoFctBKh8TlAWc78/ymxd78ihtsUYQwH7UNAnghAL4XTkq0xGG7W8reBE2qauEOAc
	 j4x96/4ANHdj2jNKKtv6B1ljkmcQXVGQqJUZQtAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfKVO6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfKVO6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:58:17 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95DAF2073B;
        Fri, 22 Nov 2019 14:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434696;
        bh=7au0IO5/UDVIEcCqwQ/MnGIP8BuR1YX+Hv0dGlUJdM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzpUNQRmjF6O0N4dZcVPGW0qpt9QLz0BSBH1Pxc95fTA5xDbquARqtQj1tMpcQHdJ
         mi/vutLA8k7JQ92kgzKoKRQvKkazHA3Qn43dpefi0byc5Kwdy08FIBgzbHmLUxSxlA
         /kT5X6myRSVelZmsDauDcTBanTTnO+P+KTiaRdFE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/26] perf intel-pt: Add support for decoding AUX area samples
Date:   Fri, 22 Nov 2019 11:57:06 -0300
Message-Id: <20191122145711.3171-22-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add support for dumping, queuing and decoding AUX area samples. Decoding
samples is the same as regular decoding, except in the case where there
are no timestamps, in which case buffers are decoded immediately before
the sample event.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 109 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a1c9eb6d4f40..409afc611be9 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -233,6 +233,16 @@ static void intel_pt_log_event(union perf_event *event)
 	perf_event__fprintf(event, f);
 }
 
+static void intel_pt_dump_sample(struct perf_session *session,
+				 struct perf_sample *sample)
+{
+	struct intel_pt *pt = container_of(session->auxtrace, struct intel_pt,
+					   auxtrace);
+
+	printf("\n");
+	intel_pt_dump(pt, sample->aux_sample.data, sample->aux_sample.size);
+}
+
 static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *a,
 				   struct auxtrace_buffer *b)
 {
@@ -836,6 +846,18 @@ static bool intel_pt_have_tsc(struct intel_pt *pt)
 	return have_tsc;
 }
 
+static bool intel_pt_sampling_mode(struct intel_pt *pt)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(pt->session->evlist, evsel) {
+		if ((evsel->core.attr.sample_type & PERF_SAMPLE_AUX) &&
+		    evsel->core.attr.aux_sample_size)
+			return true;
+	}
+	return false;
+}
+
 static u64 intel_pt_ns_to_ticks(const struct intel_pt *pt, u64 ns)
 {
 	u64 quot, rem;
@@ -2320,6 +2342,56 @@ static int intel_pt_process_timeless_queues(struct intel_pt *pt, pid_t tid,
 	return 0;
 }
 
+static void intel_pt_sample_set_pid_tid_cpu(struct intel_pt_queue *ptq,
+					    struct auxtrace_queue *queue,
+					    struct perf_sample *sample)
+{
+	struct machine *m = ptq->pt->machine;
+
+	ptq->pid = sample->pid;
+	ptq->tid = sample->tid;
+	ptq->cpu = queue->cpu;
+
+	intel_pt_log("queue %u cpu %d pid %d tid %d\n",
+		     ptq->queue_nr, ptq->cpu, ptq->pid, ptq->tid);
+
+	thread__zput(ptq->thread);
+
+	if (ptq->tid == -1)
+		return;
+
+	if (ptq->pid == -1) {
+		ptq->thread = machine__find_thread(m, -1, ptq->tid);
+		if (ptq->thread)
+			ptq->pid = ptq->thread->pid_;
+		return;
+	}
+
+	ptq->thread = machine__findnew_thread(m, ptq->pid, ptq->tid);
+}
+
+static int intel_pt_process_timeless_sample(struct intel_pt *pt,
+					    struct perf_sample *sample)
+{
+	struct auxtrace_queue *queue;
+	struct intel_pt_queue *ptq;
+	u64 ts = 0;
+
+	queue = auxtrace_queues__sample_queue(&pt->queues, sample, pt->session);
+	if (!queue)
+		return -EINVAL;
+
+	ptq = queue->priv;
+	if (!ptq)
+		return 0;
+
+	ptq->stop = false;
+	ptq->time = sample->time;
+	intel_pt_sample_set_pid_tid_cpu(ptq, queue, sample);
+	intel_pt_run_decoder(ptq, &ts);
+	return 0;
+}
+
 static int intel_pt_lost(struct intel_pt *pt, struct perf_sample *sample)
 {
 	return intel_pt_synth_error(pt, INTEL_PT_ERR_LOST, sample->cpu,
@@ -2550,7 +2622,11 @@ static int intel_pt_process_event(struct perf_session *session,
 	}
 
 	if (pt->timeless_decoding) {
-		if (event->header.type == PERF_RECORD_EXIT) {
+		if (pt->sampling_mode) {
+			if (sample->aux_sample.size)
+				err = intel_pt_process_timeless_sample(pt,
+								       sample);
+		} else if (event->header.type == PERF_RECORD_EXIT) {
 			err = intel_pt_process_timeless_queues(pt,
 							       event->fork.tid,
 							       sample->time);
@@ -2676,6 +2752,28 @@ static int intel_pt_process_auxtrace_event(struct perf_session *session,
 	return 0;
 }
 
+static int intel_pt_queue_data(struct perf_session *session,
+			       struct perf_sample *sample,
+			       union perf_event *event, u64 data_offset)
+{
+	struct intel_pt *pt = container_of(session->auxtrace, struct intel_pt,
+					   auxtrace);
+	u64 timestamp;
+
+	if (event) {
+		return auxtrace_queues__add_event(&pt->queues, session, event,
+						  data_offset, NULL);
+	}
+
+	if (sample->time && sample->time != (u64)-1)
+		timestamp = perf_time_to_tsc(sample->time, &pt->tc);
+	else
+		timestamp = 0;
+
+	return auxtrace_queues__add_sample(&pt->queues, session, sample,
+					   data_offset, timestamp);
+}
+
 struct intel_pt_synth {
 	struct perf_tool dummy_tool;
 	struct perf_session *session;
@@ -3178,7 +3276,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	if (pt->timeless_decoding && !pt->tc.time_mult)
 		pt->tc.time_mult = 1;
 	pt->have_tsc = intel_pt_have_tsc(pt);
-	pt->sampling_mode = false;
+	pt->sampling_mode = intel_pt_sampling_mode(pt);
 	pt->est_tsc = !pt->timeless_decoding;
 
 	pt->unknown_thread = thread__new(999999999, 999999999);
@@ -3205,6 +3303,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 
 	pt->auxtrace.process_event = intel_pt_process_event;
 	pt->auxtrace.process_auxtrace_event = intel_pt_process_auxtrace_event;
+	pt->auxtrace.queue_data = intel_pt_queue_data;
+	pt->auxtrace.dump_auxtrace_sample = intel_pt_dump_sample;
 	pt->auxtrace.flush_events = intel_pt_flush;
 	pt->auxtrace.free_events = intel_pt_free_events;
 	pt->auxtrace.free = intel_pt_free;
@@ -3282,7 +3382,10 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 
 	intel_pt_setup_pebs_events(pt);
 
-	err = auxtrace_queues__process_index(&pt->queues, session);
+	if (pt->sampling_mode || list_empty(&session->auxtrace_index))
+		err = auxtrace_queue_data(session, true, true);
+	else
+		err = auxtrace_queues__process_index(&pt->queues, session);
 	if (err)
 		goto err_delete_thread;
 
-- 
2.21.0

