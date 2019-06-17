Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE3C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FD12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bI22uc2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfFQT2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:28:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41313 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfFQT2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:28:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJRABa3563789
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:27:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJRABa3563789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799630;
        bh=qVrqCOSxoxKaGACE3JUe0YlCveq6puWgKfAYyVMSSTg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bI22uc2GzGld7ya2PNv/R4vLEFGvK3BkGvhfjrHdvEoA5Ec5Yhfb24CIvRjDl4cLT
         nx/63UJuCUd9tfjB9fnWnXJacReEtdjAHnBkdZhWLnU6dLcEBwrVigVmNOxd4Xw4Ey
         5aUdditOa5whZ5jfq3bAZwrHk76ElJgw7kM7/FbJxqrRrtQGY9ykKBtdnBzVTBo1Kl
         hKzk/zyNKL8DmiXmuJijoD8Na7ODtXVJBUfBCJtvy5AeN6pmAiCfpn41TZTjFgvfhg
         jaocN3RyJ+zg+gsYl+hApGQhVCoZYYKvCTrcJ3tLCI9/4lgg0xgwaYWd+meMCncFQO
         kXDRQB3yPfosA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJR9GF3563786;
        Mon, 17 Jun 2019 12:27:09 -0700
Date:   Mon, 17 Jun 2019 12:27:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-3c21d7d813c55fa1688c2223fe15a1c5cb14a559@git.kernel.org>
Cc:     jolsa@redhat.com, leo.yan@linaro.org, peterz@infradead.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de
Reply-To: mathieu.poirier@linaro.org, peterz@infradead.org,
          mingo@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          suzuki.poulose@arm.com, leo.yan@linaro.org, jolsa@redhat.com,
          hpa@zytor.com, acme@redhat.com
In-Reply-To: <20190524173508.29044-12-mathieu.poirier@linaro.org>
References: <20190524173508.29044-12-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Move thread to traceid_queue
Git-Commit-ID: 3c21d7d813c55fa1688c2223fe15a1c5cb14a559
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

Commit-ID:  3c21d7d813c55fa1688c2223fe15a1c5cb14a559
Gitweb:     https://git.kernel.org/tip/3c21d7d813c55fa1688c2223fe15a1c5cb14a559
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:35:02 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:02 -0300

perf cs-etm: Move thread to traceid_queue

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
