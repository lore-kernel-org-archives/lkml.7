Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ACCC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8F22085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MFr9kOGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfFQTdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:33:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFQTdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:33:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJUcEg3564582
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:30:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJUcEg3564582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799839;
        bh=gB8UsdySmsBDH9KnTcLLie/MEktSaTCRAXYu9992xmc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=MFr9kOGyY7O33xBN+kwNriTjEHZebIr/cvoWzT3rwNm1iXiJqvpKHFSbkSJyBpAFW
         dpskU31qA/XvhYjcaKUNz1olL/GFOwPdvkvS9JsKyN8gM+EFflj0Q2zS438BXqMnPn
         SZz+bFMSIrSBvHzZEIFBLI6+ByQCMyvZecnVJ64WIa6w2sNKEFYimX07G82fRCnZ5t
         LImbQuYQok+doFRhHDhfJYT28BDc2tl1izSsmFCUQzTYU6/fcmmov4SDgkg2jTOVDP
         djnnuw0F4Cmz6wSOaaxXMhGeYjC7R32yc0i5g1cZ30ehUUeDkpUVw23xGLBwDCcSfB
         KKdQY1BOwlQDw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJUcpw3564576;
        Mon, 17 Jun 2019 12:30:38 -0700
Date:   Mon, 17 Jun 2019 12:30:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-675f302fc261fc2af738397cdfb139bae3c58a18@git.kernel.org>
Cc:     leo.yan@linaro.org, jolsa@redhat.com, namhyung@kernel.org,
        mathieu.poirier@linaro.org, acme@redhat.com,
        suzuki.poulose@arm.com, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com
Reply-To: alexander.shishkin@linux.intel.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
          hpa@zytor.com, namhyung@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, mingo@kernel.org, leo.yan@linaro.org,
          suzuki.poulose@arm.com, jolsa@redhat.com
In-Reply-To: <20190524173508.29044-17-mathieu.poirier@linaro.org>
References: <20190524173508.29044-17-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Add notion of time to decoding code
Git-Commit-ID: 675f302fc261fc2af738397cdfb139bae3c58a18
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

Commit-ID:  675f302fc261fc2af738397cdfb139bae3c58a18
Gitweb:     https://git.kernel.org/tip/675f302fc261fc2af738397cdfb139bae3c58a18
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:35:07 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:02 -0300

perf cs-etm: Add notion of time to decoding code

This patch deals with timestamp packets received from the decoding
library in order to give the front end packet processing loop a handle
on the time instruction conveyed by range packets have been executed at.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-17-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 111 +++++++++++++++++++++++-
 tools/perf/util/cs-etm.c                        |  19 ++++
 tools/perf/util/cs-etm.h                        |  17 ++++
 3 files changed, 143 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index ce85e52f989c..bb45e23018ee 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -269,6 +269,75 @@ cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
 						     trace_config);
 }
 
+static ocsd_datapath_resp_t
+cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
+				  struct cs_etm_packet_queue *packet_queue,
+				  const uint8_t trace_chan_id)
+{
+	/* No timestamp packet has been received, nothing to do */
+	if (!packet_queue->timestamp)
+		return OCSD_RESP_CONT;
+
+	packet_queue->timestamp = packet_queue->next_timestamp;
+
+	/* Estimate the timestamp for the next range packet */
+	packet_queue->next_timestamp += packet_queue->instr_count;
+	packet_queue->instr_count = 0;
+
+	/* Tell the front end which traceid_queue needs attention */
+	cs_etm__etmq_set_traceid_queue_timestamp(etmq, trace_chan_id);
+
+	return OCSD_RESP_WAIT;
+}
+
+static ocsd_datapath_resp_t
+cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
+				  const ocsd_generic_trace_elem *elem,
+				  const uint8_t trace_chan_id)
+{
+	struct cs_etm_packet_queue *packet_queue;
+
+	/* First get the packet queue for this traceID */
+	packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
+	if (!packet_queue)
+		return OCSD_RESP_FATAL_SYS_ERR;
+
+	/*
+	 * We've seen a timestamp packet before - simply record the new value.
+	 * Function do_soft_timestamp() will report the value to the front end,
+	 * hence asking the decoder to keep decoding rather than stopping.
+	 */
+	if (packet_queue->timestamp) {
+		packet_queue->next_timestamp = elem->timestamp;
+		return OCSD_RESP_CONT;
+	}
+
+	/*
+	 * This is the first timestamp we've seen since the beginning of traces
+	 * or a discontinuity.  Since timestamps packets are generated *after*
+	 * range packets have been generated, we need to estimate the time at
+	 * which instructions started by substracting the number of instructions
+	 * executed to the timestamp.
+	 */
+	packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
+	packet_queue->next_timestamp = elem->timestamp;
+	packet_queue->instr_count = 0;
+
+	/* Tell the front end which traceid_queue needs attention */
+	cs_etm__etmq_set_traceid_queue_timestamp(etmq, trace_chan_id);
+
+	/* Halt processing until we are being told to proceed */
+	return OCSD_RESP_WAIT;
+}
+
+static void
+cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
+{
+	packet_queue->timestamp = 0;
+	packet_queue->next_timestamp = 0;
+	packet_queue->instr_count = 0;
+}
+
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
 			      const u8 trace_chan_id,
@@ -310,7 +379,8 @@ cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_range(struct cs_etm_packet_queue *packet_queue,
+cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
+			     struct cs_etm_packet_queue *packet_queue,
 			     const ocsd_generic_trace_elem *elem,
 			     const uint8_t trace_chan_id)
 {
@@ -365,6 +435,23 @@ cs_etm_decoder__buffer_range(struct cs_etm_packet_queue *packet_queue,
 
 	packet->last_instr_size = elem->last_instr_sz;
 
+	/* per-thread scenario, no need to generate a timestamp */
+	if (cs_etm__etmq_is_timeless(etmq))
+		goto out;
+
+	/*
+	 * The packet queue is full and we haven't seen a timestamp (had we
+	 * seen one the packet queue wouldn't be full).  Let the front end
+	 * deal with it.
+	 */
+	if (ret == OCSD_RESP_WAIT)
+		goto out;
+
+	packet_queue->instr_count += elem->num_instr_range;
+	/* Tell the front end we have a new timestamp to process */
+	ret = cs_etm_decoder__do_soft_timestamp(etmq, packet_queue,
+						trace_chan_id);
+out:
 	return ret;
 }
 
@@ -372,6 +459,11 @@ static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_discontinuity(struct cs_etm_packet_queue *queue,
 				     const uint8_t trace_chan_id)
 {
+	/*
+	 * Something happened and who knows when we'll get new traces so
+	 * reset time statistics.
+	 */
+	cs_etm_decoder__reset_timestamp(queue);
 	return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
 					     CS_ETM_DISCONTINUITY);
 }
@@ -404,6 +496,7 @@ cs_etm_decoder__buffer_exception_ret(struct cs_etm_packet_queue *queue,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
+			struct cs_etm_packet_queue *packet_queue,
 			const ocsd_generic_trace_elem *elem,
 			const uint8_t trace_chan_id)
 {
@@ -417,6 +510,12 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 	if (cs_etm__etmq_set_tid(etmq, tid, trace_chan_id))
 		return OCSD_RESP_FATAL_SYS_ERR;
 
+	/*
+	 * A timestamp is generated after a PE_CONTEXT element so make sure
+	 * to rely on that coming one.
+	 */
+	cs_etm_decoder__reset_timestamp(packet_queue);
+
 	return OCSD_RESP_CONT;
 }
 
@@ -446,7 +545,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
-		resp = cs_etm_decoder__buffer_range(packet_queue, elem,
+		resp = cs_etm_decoder__buffer_range(etmq, packet_queue, elem,
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
@@ -457,11 +556,15 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 		resp = cs_etm_decoder__buffer_exception_ret(packet_queue,
 							    trace_chan_id);
 		break;
+	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
+		resp = cs_etm_decoder__do_hard_timestamp(etmq, elem,
+							 trace_chan_id);
+		break;
 	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
-		resp = cs_etm_decoder__set_tid(etmq, elem, trace_chan_id);
+		resp = cs_etm_decoder__set_tid(etmq, packet_queue,
+					       elem, trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
-	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
 	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
 	case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
 	case OCSD_GEN_TRC_ELEM_EVENT:
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 17adf554b679..91496a3a2209 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -80,6 +80,7 @@ struct cs_etm_queue {
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
 	unsigned int queue_nr;
+	u8 pending_timestamp;
 	u64 offset;
 	const unsigned char *buf;
 	size_t buf_len, buf_used;
@@ -133,6 +134,19 @@ int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
 	return 0;
 }
 
+void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
+					      u8 trace_chan_id)
+{
+	/*
+	 * Wnen a timestamp packet is encountered the backend code
+	 * is stopped so that the front end has time to process packets
+	 * that were accumulated in the traceID queue.  Since there can
+	 * be more than one channel per cs_etm_queue, we need to specify
+	 * what traceID queue needs servicing.
+	 */
+	etmq->pending_timestamp = trace_chan_id;
+}
+
 static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
 {
 	int i;
@@ -942,6 +956,11 @@ int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
 	return 0;
 }
 
+bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq)
+{
+	return !!etmq->etm->timeless_decoding;
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index b2a7628620bf..33b57e748c3d 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -150,6 +150,9 @@ struct cs_etm_packet_queue {
 	u32 packet_count;
 	u32 head;
 	u32 tail;
+	u32 instr_count;
+	u64 timestamp;
+	u64 next_timestamp;
 	struct cs_etm_packet packet_buffer[CS_ETM_PACKET_MAX_BUFFER];
 };
 
@@ -183,6 +186,9 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
 int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
 			 pid_t tid, u8 trace_chan_id);
+bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
+void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
+					      u8 trace_chan_id);
 struct cs_etm_packet_queue
 *cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
 #else
@@ -207,6 +213,17 @@ static inline int cs_etm__etmq_set_tid(
 	return -1;
 }
 
+static inline bool cs_etm__etmq_is_timeless(
+				struct cs_etm_queue *etmq __maybe_unused)
+{
+	/* What else to return? */
+	return true;
+}
+
+static inline void cs_etm__etmq_set_traceid_queue_timestamp(
+				struct cs_etm_queue *etmq __maybe_unused,
+				u8 trace_chan_id __maybe_unused) {}
+
 static inline struct cs_etm_packet_queue *cs_etm__etmq_get_packet_queue(
 				struct cs_etm_queue *etmq __maybe_unused,
 				u8 trace_chan_id __maybe_unused)
