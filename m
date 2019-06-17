Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62163C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2829B208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="udf58+9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfFQT3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:29:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFQT3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:29:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJRq943563920
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:27:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJRq943563920
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799672;
        bh=OQOcVr23e8H+o9eutxNbiWv1BHRO5RJhWUxwO5kiehs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=udf58+9DeYfI8tkMuZUCuvy/XWYydiIF42MvpfyNpMWleymoKWpMVR7nd+baSbTvM
         WcJ2hev+ALUJR7NdfJnCXPHWZKT+yDfmLyDDFhTIMnmDq/ra23semAfWfkJM6j5Gxz
         yV8j9yUUKld+S5Al4u5msgNMnIxCGMU2WeK6XXnK9CUEfDDyFLJF+JFZ1TKIRaGkBP
         H/0ABNaBq9HjfM/sKL8CR/6C/RhNghxFPdg9tJoMU0q9TzmQLj6mRjeXrzWYZx1PWh
         c/h1wCaRuyHN44iAHYBOdCuFOtWZFWxpXFMTmLMxa0S7a5Y/gMlO8t8Au2/sKckU9F
         ov4QEKNMXMyZw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJRpvE3563917;
        Mon, 17 Jun 2019 12:27:51 -0700
Date:   Mon, 17 Jun 2019 12:27:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-0abb868bbcbcf9f86e67bcbfaea7dcaba5a72ac0@git.kernel.org>
Cc:     hpa@zytor.com, namhyung@kernel.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        jolsa@redhat.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@redhat.com, acme@redhat.com,
          alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
          mathieu.poirier@linaro.org, mingo@kernel.org,
          suzuki.poulose@arm.com, tglx@linutronix.de, peterz@infradead.org,
          hpa@zytor.com, namhyung@kernel.org
In-Reply-To: <20190524173508.29044-13-mathieu.poirier@linaro.org>
References: <20190524173508.29044-13-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Move tid/pid to traceid_queue
Git-Commit-ID: 0abb868bbcbcf9f86e67bcbfaea7dcaba5a72ac0
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

Commit-ID:  0abb868bbcbcf9f86e67bcbfaea7dcaba5a72ac0
Gitweb:     https://git.kernel.org/tip/0abb868bbcbcf9f86e67bcbfaea7dcaba5a72ac0
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:35:03 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:02 -0300

perf cs-etm: Move tid/pid to traceid_queue

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
 tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++------------------
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
