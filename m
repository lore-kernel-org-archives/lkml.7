Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC89C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F11D21871
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uexRFuRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403966AbfEXRf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:35:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41218 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403760AbfEXRf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so877645pfq.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eTGrl1VwMHPMcZROfgPIL9cYLAfm7e1gifTctdhMIag=;
        b=uexRFuRCUMiVTKpuY4H6ZXEoKfbokTfvLGUjC/jwLmemjjK+9N08UN2R450MQzMQFS
         SDYZUWqYuwiEWmCasHAcniqKd8VZ1P9qLod4b26Q3GLCZniJsQc8MPQjnN5JxRgQdtX0
         +BSF0I69lK+hyZyucAN5AmDmmVYB9bGjevMr73ySf1a5aXZPRdECjJHyvinKVAw4AOqQ
         z9D++HcFUhruKpxEn3SksqcIh5wZAf0QWLZRdtKmqPtO5Z5YCA08an7r7P/RqcQI7d5t
         x1Qeaar+Gxem++wi2r0RFocbzTW/ZaEaLfO2QRxBjq9syIms/TNaxDjUyWMA1jDMufq0
         U03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eTGrl1VwMHPMcZROfgPIL9cYLAfm7e1gifTctdhMIag=;
        b=ZjGmEIZiDaklM+b270rpHfsAhEG1GHwQ0ipKDwsivoVvyi9hnu7qEzV+HPDngSJJTj
         Le6eAJYt1hBjjSt9MxSGKThCJDCWJqB3x+IQpUNMfXVBcrrfkg0vZ1HXMV9WeXt5rrBm
         yc+8LiK3GM0ZqsatRqyV5UcQf/JOmb/MWGBKJpHZOtwW61rr8aTHYlH2nekvDFt7qeOD
         01Ud/DcgZuHWpO5eEbPNcEsoCZL3rIbQJvoUZbFtquqPNg7QsrPemK9AESn6vBjNvQJ3
         O2geVvBxJP3Qj2aR8KbjwXa7HTwIzGcl8RamUr4iuH+LQSWrit7v0B/cu85fh9sPN3hd
         KkZQ==
X-Gm-Message-State: APjAAAXRLagSMvAAXcEc4s00JdpX9Q+AcP+mB5khJdSk+5Fdn9WiRdmB
        FHElSFrb+3SFKr3oDZx87KADDw==
X-Google-Smtp-Source: APXvYqxafBcXyO1ItWy6aoLqqZOafSURtK+DsdQ9+wximkDSKsA3cFE7FLAZvxWK6L4NzpzoVcgJ0w==
X-Received: by 2002:a63:6ac3:: with SMTP id f186mr107175814pgc.326.1558719325379;
        Fri, 24 May 2019 10:35:25 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:24 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 12/17] perf tools: Move tid/pid to traceid_queue
Date:   Fri, 24 May 2019 11:35:03 -0600
Message-Id: <20190524173508.29044-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tid/pid fields of structure cs_etm_queue are CPU dependent and as
such need to be part of the cs_etm_traceid_queue in order to support
CPU-wide trace scenarios.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
2.17.1

