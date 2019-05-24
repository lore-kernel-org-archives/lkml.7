Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D892AC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92FB2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxeotkVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391729AbfEXRgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:36:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32872 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391691AbfEXRfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:35:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id g21so4458013plq.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J3KXvvmyZI4M9TGLwpGRYcqjyy4iZs8aqIvbJ4YnMAg=;
        b=PxeotkVsdudTZ5DzfbDSWNGHXZFlizeQMtK9EnDTDtk3701NQsI0BL6K8GGLqdOFlS
         lQDesgnT9B211Eosr0u2MEaAt35hY9zdOr4zpF4NH+uI2g+f/Y9zKI/5gpwNWwIYpobi
         LMWB0GKpOp72zMvvLIYvikUZ+24dwfkdyQdxCpINpPbH2XpzpOM8raL5MXpz9nV+kPXu
         f635YZt7ygq+iP2HIRJ5sArUuVi9NsC1R+ko/5r+diZRFgxRl3inS7A76ngKmGyNu6It
         YDSupMpR0bHcKsWNRHIBwbC70u3X3KHAqRtmfOBMi+aP1iae511n5i9/RVoA+nZF7UJR
         Svaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J3KXvvmyZI4M9TGLwpGRYcqjyy4iZs8aqIvbJ4YnMAg=;
        b=aUeLsXEg9QsbWjzzpHkfqszl95Nt+XoFACdt5vDKj6XW1+yj4HsSPS233MsKcwuUPW
         6HwAi8TrUpVicEhyFA6cE23CciETMsfY9wieOmWzr5WbFbfMSAKk8tcpxfwEnMbJf2rC
         7anJVpRjps0iED0o/B3IKq29/k0x/Pst8NxcTku9XLNokCzkx7S8/EqnSkYmQGG3h2Ni
         J3EYYpVejEUrXf3t6pD3bMd66Q5iuQnYLLKySAqIWva92c0lntrPHRgf9stG0AmweLzZ
         PbXFXvoojue/nIurmGuLNKkuMjoAC6y6OaNlVjKV+E6JOHIBy7s4ov6m7jHkGuqMLjAl
         PGww==
X-Gm-Message-State: APjAAAWPGyzjtnnfo2zHjN5wp6hFDnmmNjZsBnPpnpqdcM8NXsLalndI
        /gFUe5a9qrR6u1B5QUsBQisuCw==
X-Google-Smtp-Source: APXvYqyW62EDQFZ/4Hvhi7yRBZOFrn0NXEa5XdwU4rEoJMlp697/fythnv78WdXBVyIDViiycykK6Q==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr92505236ply.234.1558719324246;
        Fri, 24 May 2019 10:35:24 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k13sm2809575pgr.90.2019.05.24.10.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:35:23 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH v2 11/17] perf tools: Move thread to traceid_queue
Date:   Fri, 24 May 2019 11:35:02 -0600
Message-Id: <20190524173508.29044-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524173508.29044-1-mathieu.poirier@linaro.org>
References: <20190524173508.29044-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thread field of structure cs_etm_queue is CPU dependent and as
such need to be part of the cs_etm_traceid_queue in order to support
CPU-wide trace scenarios.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 531bbb355ba4..0d51d6d9a594 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -65,6 +65,7 @@ struct cs_etm_traceid_queue {
 	u64 period_instructions;
 	size_t last_branch_pos;
 	union perf_event *event_buf;
+	struct thread *thread;
 	struct branch_stack *last_branch;
 	struct branch_stack *last_branch_rb;
 	struct cs_etm_packet *prev_packet;
@@ -74,7 +75,6 @@ struct cs_etm_traceid_queue {
 
 struct cs_etm_queue {
 	struct cs_etm_auxtrace *etm;
-	struct thread *thread;
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
@@ -415,7 +415,7 @@ static void cs_etm__free_queue(void *priv)
 	if (!etmq)
 		return;
 
-	thread__zput(etmq->thread);
+	thread__zput(etmq->traceid_queues->thread);
 	cs_etm_decoder__free(etmq->decoder);
 	zfree(&etmq->traceid_queues->event_buf);
 	zfree(&etmq->traceid_queues->last_branch);
@@ -503,7 +503,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	machine = etmq->etm->machine;
 	cpumode = cs_etm__cpu_mode(etmq, address);
 
-	thread = etmq->thread;
+	thread = etmq->traceid_queues->thread;
 	if (!thread) {
 		if (cpumode != PERF_RECORD_MISC_KERNEL)
 			return 0;
@@ -819,18 +819,21 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
 static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
 				    struct auxtrace_queue *queue)
 {
+	struct cs_etm_traceid_queue *tidq;
 	struct cs_etm_queue *etmq = queue->priv;
 
+	tidq = cs_etm__etmq_get_traceid_queue(etmq, CS_ETM_PER_THREAD_TRACEID);
+
 	/* CPU-wide tracing isn't supported yet */
 	if (queue->tid == -1)
 		return;
 
-	if ((!etmq->thread) && (etmq->tid != -1))
-		etmq->thread = machine__find_thread(etm->machine, -1,
+	if ((!tidq->thread) && (etmq->tid != -1))
+		tidq->thread = machine__find_thread(etm->machine, -1,
 						    etmq->tid);
 
-	if (etmq->thread)
-		etmq->pid = etmq->thread->pid_;
+	if (tidq->thread)
+		etmq->pid = tidq->thread->pid_;
 }
 
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
-- 
2.17.1

