Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BD9C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8537821841
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279794;
	bh=1Dv8CzymVwIcmwV7LnpzwdGNkbxGgtqUnw5p71uxSZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ONyjkBELUBR6sDTNUmadhBj4W8nPAa1yCKwrb2GKp0jExF4NmccPrBIx7n22TmjJk
	 5LQ1+B5RnKkQxQW6Gu7TbBKr3QsDZEKPHEoQFLX3LjLgc5RcEKWva3vY2x1zV9QdCn
	 A3eKLOL4yYucv0UmhtvS9M/JH+e9Idwgl3TYAb3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392518AbfFKTDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392492AbfFKTDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:03:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C762183E;
        Tue, 11 Jun 2019 19:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279790;
        bh=1Dv8CzymVwIcmwV7LnpzwdGNkbxGgtqUnw5p71uxSZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xJcpKlHjOPklJNiAfj+AjS+42sPurfRZDktMdZnwJ6/EPm8MkGyFLtbQwaqq6Yghz
         UXwnlJ+vjAsL8Tn8BniicpMfOeqsUzuZzttG7qn2YDWtMB3HgtkDzjWsCzzxrRUKyz
         2nsWpr4qq2JHPENgYWFSoxueILBmySi9W7Uibodw=
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
Subject: [PATCH 51/85] perf cs-etm: Linking PE contextID with perf thread mechanic
Date:   Tue, 11 Jun 2019 15:58:37 -0300
Message-Id: <20190611185911.11645-52-acme@kernel.org>
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

Link contextID packets received from the decoder with the perf tool
thread mechanic so that we know the specifics of the process currently
executing.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-16-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 ++++++++++++
 tools/perf/util/cs-etm.c                      | 32 +++++++++++++++----
 tools/perf/util/cs-etm.h                      | 10 ++++++
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 87264b79de0e..ce85e52f989c 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -402,6 +402,24 @@ cs_etm_decoder__buffer_exception_ret(struct cs_etm_packet_queue *queue,
 					     CS_ETM_EXCEPTION_RET);
 }
 
+static ocsd_datapath_resp_t
+cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
+			const ocsd_generic_trace_elem *elem,
+			const uint8_t trace_chan_id)
+{
+	pid_t tid;
+
+	/* Ignore PE_CONTEXT packets that don't have a valid contextID */
+	if (!elem->context.ctxt_id_valid)
+		return OCSD_RESP_CONT;
+
+	tid =  elem->context.context_id;
+	if (cs_etm__etmq_set_tid(etmq, tid, trace_chan_id))
+		return OCSD_RESP_FATAL_SYS_ERR;
+
+	return OCSD_RESP_CONT;
+}
+
 static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 				const void *context,
 				const ocsd_trc_index_t indx __maybe_unused,
@@ -440,6 +458,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
+		resp = cs_etm_decoder__set_tid(etmq, elem, trace_chan_id);
+		break;
 	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
 	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
 	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index afc2491f9f2a..17adf554b679 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -907,13 +907,8 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
 }
 
 static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
-				    struct auxtrace_queue *queue,
 				    struct cs_etm_traceid_queue *tidq)
 {
-	/* CPU-wide tracing isn't supported yet */
-	if (queue->tid == -1)
-		return;
-
 	if ((!tidq->thread) && (tidq->tid != -1))
 		tidq->thread = machine__find_thread(etm->machine, -1,
 						    tidq->tid);
@@ -922,6 +917,31 @@ static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
 		tidq->pid = tidq->thread->pid_;
 }
 
+int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
+			 pid_t tid, u8 trace_chan_id)
+{
+	int cpu, err = -EINVAL;
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	struct cs_etm_traceid_queue *tidq;
+
+	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
+	if (!tidq)
+		return err;
+
+	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
+		return err;
+
+	err = machine__set_current_tid(etm->machine, cpu, tid, tid);
+	if (err)
+		return err;
+
+	tidq->tid = tid;
+	thread__zput(tidq->thread);
+
+	cs_etm__set_pid_tid_cpu(etm, tidq);
+	return 0;
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
@@ -1866,7 +1886,7 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 			continue;
 
 		if ((tid == -1) || (tidq->tid == tid)) {
-			cs_etm__set_pid_tid_cpu(etm, queue, tidq);
+			cs_etm__set_pid_tid_cpu(etm, tidq);
 			cs_etm__run_decoder(etmq);
 		}
 	}
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index f16082d37ab5..b2a7628620bf 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -181,6 +181,8 @@ struct cs_etm_packet_queue {
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
+int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
+			 pid_t tid, u8 trace_chan_id);
 struct cs_etm_packet_queue
 *cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
 #else
@@ -197,6 +199,14 @@ static inline int cs_etm__get_cpu(u8 trace_chan_id __maybe_unused,
 	return -1;
 }
 
+static inline int cs_etm__etmq_set_tid(
+				struct cs_etm_queue *etmq __maybe_unused,
+				pid_t tid __maybe_unused,
+				u8 trace_chan_id __maybe_unused)
+{
+	return -1;
+}
+
 static inline struct cs_etm_packet_queue *cs_etm__etmq_get_packet_queue(
 				struct cs_etm_queue *etmq __maybe_unused,
 				u8 trace_chan_id __maybe_unused)
-- 
2.20.1

