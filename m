Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE878C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE69121883
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279781;
	bh=B6Q4bDYKlyzC/S0jqBgL7/O6Uc7TYaH3j4vbbLJ6NSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sDTuYRt9gvl3qtliPwdg2qNur88UtzQFdM0yLFgxU7EHg71yAIwx27AsEsXxfekak
	 f3Wkb2z+NKvVHLDtH0p/nTCU9OIUaxixysPa7jDiISUXTFho/Mhx55dF9LMCtGMohn
	 AdCuZsOwUSLMsw234zlbufG25RdlGLq68/qrSCHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392435AbfFKTDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391474AbfFKTC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:02:58 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 368AC2184B;
        Tue, 11 Jun 2019 19:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279777;
        bh=B6Q4bDYKlyzC/S0jqBgL7/O6Uc7TYaH3j4vbbLJ6NSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXic+bdSHOMGjIYFN/r4KPMK3VzPGSh1eICxTh4TG5ObcEJF87uQ3682s8/hx4yZX
         MJDjJjmBnOICGE49hz3nObsScRHZktlMRhpBUbovtMeEMzInL7ECSqqWdRzT4PK9iH
         4aFVbamTDJo4ar0Bgav145a9h0NkID42NVEUaSZw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 48/85] perf cs-etm: Move tid/pid to traceid_queue
Date:   Tue, 11 Jun 2019 15:58:34 -0300
Message-Id: <20190611185911.11645-49-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

The tid/pid fields of structure cs_etm_queue are CPU dependent and as
such need to be part of the cs_etm_traceid_queue in order to support
CPU-wide trace scenarios.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-13-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0d51d6d9a594..7e3b4d10f5c4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -62,6 +62,7 @@ struct cs_etm_auxtrace {
 
 struct cs_etm_traceid_queue {
 	u8 trace_chan_id;
+	pid_t pid, tid;
 	u64 period_instructions;
 	size_t last_branch_pos;
 	union perf_event *event_buf;
@@ -78,7 +79,6 @@ struct cs_etm_queue {
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
-	pid_t pid, tid;
 	u64 offset;
 	const unsigned char *buf;
 	size_t buf_len, buf_used;
@@ -159,10 +159,14 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 				      u8 trace_chan_id)
 {
 	int rc = -ENOMEM;
+	struct auxtrace_queue *queue;
 	struct cs_etm_auxtrace *etm = etmq->etm;
 
 	cs_etm__clear_packet_queue(&tidq->packet_queue);
 
+	queue = &etmq->etm->queues.queue_array[etmq->queue_nr];
+	tidq->tid = queue->tid;
+	tidq->pid = -1;
 	tidq->trace_chan_id = trace_chan_id;
 
 	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
@@ -598,8 +602,6 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	queue->priv = etmq;
 	etmq->etm = etm;
 	etmq->queue_nr = queue_nr;
-	etmq->tid = queue->tid;
-	etmq->pid = -1;
 	etmq->offset = 0;
 
 out:
@@ -817,23 +819,19 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
 }
 
 static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
-				    struct auxtrace_queue *queue)
+				    struct auxtrace_queue *queue,
+				    struct cs_etm_traceid_queue *tidq)
 {
-	struct cs_etm_traceid_queue *tidq;
-	struct cs_etm_queue *etmq = queue->priv;
-
-	tidq = cs_etm__etmq_get_traceid_queue(etmq, CS_ETM_PER_THREAD_TRACEID);
-
 	/* CPU-wide tracing isn't supported yet */
 	if (queue->tid == -1)
 		return;
 
-	if ((!tidq->thread) && (etmq->tid != -1))
+	if ((!tidq->thread) && (tidq->tid != -1))
 		tidq->thread = machine__find_thread(etm->machine, -1,
-						    etmq->tid);
+						    tidq->tid);
 
 	if (tidq->thread)
-		etmq->pid = tidq->thread->pid_;
+		tidq->pid = tidq->thread->pid_;
 }
 
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
@@ -850,8 +848,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	sample.ip = addr;
-	sample.pid = etmq->pid;
-	sample.tid = etmq->tid;
+	sample.pid = tidq->pid;
+	sample.tid = tidq->tid;
 	sample.id = etmq->etm->instructions_id;
 	sample.stream_id = etmq->etm->instructions_id;
 	sample.period = period;
@@ -909,8 +907,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	event->sample.header.size = sizeof(struct perf_event_header);
 
 	sample.ip = ip;
-	sample.pid = etmq->pid;
-	sample.tid = etmq->tid;
+	sample.pid = tidq->pid;
+	sample.tid = tidq->tid;
 	sample.addr = cs_etm__first_executed_instr(tidq->packet);
 	sample.id = etmq->etm->branches_id;
 	sample.stream_id = etmq->etm->branches_id;
@@ -1758,9 +1756,19 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 	for (i = 0; i < queues->nr_queues; i++) {
 		struct auxtrace_queue *queue = &etm->queues.queue_array[i];
 		struct cs_etm_queue *etmq = queue->priv;
+		struct cs_etm_traceid_queue *tidq;
+
+		if (!etmq)
+			continue;
+
+		tidq = cs_etm__etmq_get_traceid_queue(etmq,
+						CS_ETM_PER_THREAD_TRACEID);
+
+		if (!tidq)
+			continue;
 
-		if (etmq && ((tid == -1) || (etmq->tid == tid))) {
-			cs_etm__set_pid_tid_cpu(etm, queue);
+		if ((tid == -1) || (tidq->tid == tid)) {
+			cs_etm__set_pid_tid_cpu(etm, queue, tidq);
 			cs_etm__run_decoder(etmq);
 		}
 	}
-- 
2.20.1

