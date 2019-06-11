Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B50C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45BB21841
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279776;
	bh=22JvqhMRFadlku1d18uzDdaZ+nanOpO9WyNtz0V2N0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aFbZWVK+Bo4mjMx6MflHI7wG6dkiCSiEJid1PjVm2RzLaBALahy+R9E5+RLVB3tcA
	 nD1zYCqqeTINgqFKZN44e+WaQ8FYl2PjqQxEzPA1pXfQ1zB20a9T4kLOZlI+vd5G+2
	 li98xfs04NKAYqjiwPRpihmXVHIXBhQrujuAeKwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392423AbfFKTCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392010AbfFKTCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:02:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAE22183E;
        Tue, 11 Jun 2019 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279773;
        bh=22JvqhMRFadlku1d18uzDdaZ+nanOpO9WyNtz0V2N0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v9Q8vqfS6dvj1JpborORWGI2Xcu0YKv0IK6kPZ+NJBkxtkPBpC5dJclYkEolnuCSr
         AW5lmGtgpeHGrTEF9H7sjl1sjmimnMni6kfYop1djPAR7nyIWEg/KbEFj8dPBAQ/BK
         joH5DS1CIpHTl1jK3vUj+kKvrAliq/diDf1B89UY=
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
Subject: [PATCH 47/85] perf cs-etm: Move thread to traceid_queue
Date:   Tue, 11 Jun 2019 15:58:33 -0300
Message-Id: <20190611185911.11645-48-acme@kernel.org>
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

The thread field of structure cs_etm_queue is CPU dependent and as such
need to be part of the cs_etm_traceid_queue in order to support CPU-wide
trace scenarios.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-12-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

