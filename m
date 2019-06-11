Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440ABC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB7921850
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279802;
	bh=yVVltIFuXXUA/CjtqNSVl1PIh+nqm9yCuBw/vB+EbZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p3n0SK/vK+uP8XK2q1HA7e9Kl2L4dMANWJWjrXlLalXjNW6ApTSL0u459NTx1FocF
	 JJyb3WjxuAb55I/2zYuCELhd+3pNIL2K0fAiMAHBKLma0epFZDh5a3US9+UnNpeFtO
	 f7vRbeit+IucD4IZaAo3WGCwIW46VYRbtxa0CLTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392520AbfFKTDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392485AbfFKTDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:03:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 158C121841;
        Tue, 11 Jun 2019 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279798;
        bh=yVVltIFuXXUA/CjtqNSVl1PIh+nqm9yCuBw/vB+EbZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GHrPCDetFA1S9QvFFOOTqLfEF7wRnON5vp9F8a5C06lgM3idUAugLsX+7yDlphIsU
         I2DnFVQltaCS/prS0n8H874g/FKXHu6E8KyM1/Skl6qn3KAtaBQS4l0THXXt7s0IOQ
         y1kSQvS5HYbexhmWmRdmBK7awgvV9xYWgo1SUhcU=
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
Subject: [PATCH 53/85] perf cs-etm: Add support for CPU-wide trace scenarios
Date:   Tue, 11 Jun 2019 15:58:39 -0300
Message-Id: <20190611185911.11645-54-acme@kernel.org>
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

Add support for CPU-wide trace scenarios by correlating range packets
with timestamp packets.  That way range packets received on different
ETMQ/traceID channels can be processed and synthesized in chronological
order.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-18-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 254 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 246 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 91496a3a2209..0c7776b51045 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -90,12 +90,26 @@ struct cs_etm_queue {
 };
 
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
+static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid);
+static int cs_etm__get_data_block(struct cs_etm_queue *etmq);
+static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
 
 /* PTMs ETMIDR [11:8] set to b0011 */
 #define ETMIDR_PTM_VERSION 0x00000300
 
+/*
+ * A struct auxtrace_heap_item only has a queue_nr and a timestamp to
+ * work with.  One option is to modify to auxtrace_heap_XYZ() API or simply
+ * encode the etm queue number as the upper 16 bit and the channel as
+ * the lower 16 bit.
+ */
+#define TO_CS_QUEUE_NR(queue_nr, trace_id_chan)	\
+		      (queue_nr << 16 | trace_chan_id)
+#define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
+#define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
+
 static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 {
 	etmidr &= ETMIDR_PTM_VERSION;
@@ -147,6 +161,29 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
 	etmq->pending_timestamp = trace_chan_id;
 }
 
+static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
+				      u8 *trace_chan_id)
+{
+	struct cs_etm_packet_queue *packet_queue;
+
+	if (!etmq->pending_timestamp)
+		return 0;
+
+	if (trace_chan_id)
+		*trace_chan_id = etmq->pending_timestamp;
+
+	packet_queue = cs_etm__etmq_get_packet_queue(etmq,
+						     etmq->pending_timestamp);
+	if (!packet_queue)
+		return 0;
+
+	/* Acknowledge pending status */
+	etmq->pending_timestamp = 0;
+
+	/* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
+	return packet_queue->timestamp;
+}
+
 static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
 {
 	int i;
@@ -171,6 +208,20 @@ static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
 	}
 }
 
+static void cs_etm__clear_all_packet_queues(struct cs_etm_queue *etmq)
+{
+	int idx;
+	struct int_node *inode;
+	struct cs_etm_traceid_queue *tidq;
+	struct intlist *traceid_queues_list = etmq->traceid_queues_list;
+
+	intlist__for_each_entry(inode, traceid_queues_list) {
+		idx = (int)(intptr_t)inode->priv;
+		tidq = etmq->traceid_queues[idx];
+		cs_etm__clear_packet_queue(&tidq->packet_queue);
+	}
+}
+
 static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 				      struct cs_etm_traceid_queue *tidq,
 				      u8 trace_chan_id)
@@ -458,15 +509,15 @@ static int cs_etm__flush_events(struct perf_session *session,
 	if (!tool->ordered_events)
 		return -EINVAL;
 
-	if (!etm->timeless_decoding)
-		return -EINVAL;
-
 	ret = cs_etm__update_queues(etm);
 
 	if (ret < 0)
 		return ret;
 
-	return cs_etm__process_timeless_queues(etm, -1);
+	if (etm->timeless_decoding)
+		return cs_etm__process_timeless_queues(etm, -1);
+
+	return cs_etm__process_queues(etm);
 }
 
 static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
@@ -685,6 +736,9 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       unsigned int queue_nr)
 {
 	int ret = 0;
+	unsigned int cs_queue_nr;
+	u8 trace_chan_id;
+	u64 timestamp;
 	struct cs_etm_queue *etmq = queue->priv;
 
 	if (list_empty(&queue->head) || etmq)
@@ -702,6 +756,67 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	etmq->queue_nr = queue_nr;
 	etmq->offset = 0;
 
+	if (etm->timeless_decoding)
+		goto out;
+
+	/*
+	 * We are under a CPU-wide trace scenario.  As such we need to know
+	 * when the code that generated the traces started to execute so that
+	 * it can be correlated with execution on other CPUs.  So we get a
+	 * handle on the beginning of traces and decode until we find a
+	 * timestamp.  The timestamp is then added to the auxtrace min heap
+	 * in order to know what nibble (of all the etmqs) to decode first.
+	 */
+	while (1) {
+		/*
+		 * Fetch an aux_buffer from this etmq.  Bail if no more
+		 * blocks or an error has been encountered.
+		 */
+		ret = cs_etm__get_data_block(etmq);
+		if (ret <= 0)
+			goto out;
+
+		/*
+		 * Run decoder on the trace block.  The decoder will stop when
+		 * encountering a timestamp, a full packet queue or the end of
+		 * trace for that block.
+		 */
+		ret = cs_etm__decode_data_block(etmq);
+		if (ret)
+			goto out;
+
+		/*
+		 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
+		 * the timestamp calculation for us.
+		 */
+		timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
+
+		/* We found a timestamp, no need to continue. */
+		if (timestamp)
+			break;
+
+		/*
+		 * We didn't find a timestamp so empty all the traceid packet
+		 * queues before looking for another timestamp packet, either
+		 * in the current data block or a new one.  Packets that were
+		 * just decoded are useless since no timestamp has been
+		 * associated with them.  As such simply discard them.
+		 */
+		cs_etm__clear_all_packet_queues(etmq);
+	}
+
+	/*
+	 * We have a timestamp.  Add it to the min heap to reflect when
+	 * instructions conveyed by the range packets of this traceID queue
+	 * started to execute.  Once the same has been done for all the traceID
+	 * queues of each etmq, redenring and decoding can start in
+	 * chronological order.
+	 *
+	 * Note that packets decoded above are still in the traceID's packet
+	 * queue and will be processed in cs_etm__process_queues().
+	 */
+	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_id_chan);
+	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
 out:
 	return ret;
 }
@@ -1846,6 +1961,28 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 	return ret;
 }
 
+static void cs_etm__clear_all_traceid_queues(struct cs_etm_queue *etmq)
+{
+	int idx;
+	struct int_node *inode;
+	struct cs_etm_traceid_queue *tidq;
+	struct intlist *traceid_queues_list = etmq->traceid_queues_list;
+
+	intlist__for_each_entry(inode, traceid_queues_list) {
+		idx = (int)(intptr_t)inode->priv;
+		tidq = etmq->traceid_queues[idx];
+
+		/* Ignore return value */
+		cs_etm__process_traceid_queue(etmq, tidq);
+
+		/*
+		 * Generate an instruction sample with the remaining
+		 * branchstack entries.
+		 */
+		cs_etm__flush(etmq, tidq);
+	}
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	int err = 0;
@@ -1913,6 +2050,105 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
+{
+	int ret = 0;
+	unsigned int cs_queue_nr, queue_nr;
+	u8 trace_chan_id;
+	u64 timestamp;
+	struct auxtrace_queue *queue;
+	struct cs_etm_queue *etmq;
+	struct cs_etm_traceid_queue *tidq;
+
+	while (1) {
+		if (!etm->heap.heap_cnt)
+			goto out;
+
+		/* Take the entry at the top of the min heap */
+		cs_queue_nr = etm->heap.heap_array[0].queue_nr;
+		queue_nr = TO_QUEUE_NR(cs_queue_nr);
+		trace_chan_id = TO_TRACE_CHAN_ID(cs_queue_nr);
+		queue = &etm->queues.queue_array[queue_nr];
+		etmq = queue->priv;
+
+		/*
+		 * Remove the top entry from the heap since we are about
+		 * to process it.
+		 */
+		auxtrace_heap__pop(&etm->heap);
+
+		tidq  = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
+		if (!tidq) {
+			/*
+			 * No traceID queue has been allocated for this traceID,
+			 * which means something somewhere went very wrong.  No
+			 * other choice than simply exit.
+			 */
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/*
+		 * Packets associated with this timestamp are already in
+		 * the etmq's traceID queue, so process them.
+		 */
+		ret = cs_etm__process_traceid_queue(etmq, tidq);
+		if (ret < 0)
+			goto out;
+
+		/*
+		 * Packets for this timestamp have been processed, time to
+		 * move on to the next timestamp, fetching a new auxtrace_buffer
+		 * if need be.
+		 */
+refetch:
+		ret = cs_etm__get_data_block(etmq);
+		if (ret < 0)
+			goto out;
+
+		/*
+		 * No more auxtrace_buffers to process in this etmq, simply
+		 * move on to another entry in the auxtrace_heap.
+		 */
+		if (!ret)
+			continue;
+
+		ret = cs_etm__decode_data_block(etmq);
+		if (ret)
+			goto out;
+
+		timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
+
+		if (!timestamp) {
+			/*
+			 * Function cs_etm__decode_data_block() returns when
+			 * there is no more traces to decode in the current
+			 * auxtrace_buffer OR when a timestamp has been
+			 * encountered on any of the traceID queues.  Since we
+			 * did not get a timestamp, there is no more traces to
+			 * process in this auxtrace_buffer.  As such empty and
+			 * flush all traceID queues.
+			 */
+			cs_etm__clear_all_traceid_queues(etmq);
+
+			/* Fetch another auxtrace_buffer for this etmq */
+			goto refetch;
+		}
+
+		/*
+		 * Add to the min heap the timestamp for packets that have
+		 * just been decoded.  They will be processed and synthesized
+		 * during the next call to cs_etm__process_traceid_queue() for
+		 * this queue/traceID.
+		 */
+		cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
+		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
+	}
+
+out:
+	return ret;
+}
+
 static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
 					union perf_event *event)
 {
@@ -1991,9 +2227,6 @@ static int cs_etm__process_event(struct perf_session *session,
 		return -EINVAL;
 	}
 
-	if (!etm->timeless_decoding)
-		return -EINVAL;
-
 	if (sample->time && (sample->time != (u64) -1))
 		timestamp = sample->time;
 	else
@@ -2005,7 +2238,8 @@ static int cs_etm__process_event(struct perf_session *session,
 			return err;
 	}
 
-	if (event->header.type == PERF_RECORD_EXIT)
+	if (etm->timeless_decoding &&
+	    event->header.type == PERF_RECORD_EXIT)
 		return cs_etm__process_timeless_queues(etm,
 						       event->fork.tid);
 
@@ -2014,6 +2248,10 @@ static int cs_etm__process_event(struct perf_session *session,
 	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
 		return cs_etm__process_switch_cpu_wide(etm, event);
 
+	if (!etm->timeless_decoding &&
+	    event->header.type == PERF_RECORD_AUX)
+		return cs_etm__process_queues(etm);
+
 	return 0;
 }
 
-- 
2.20.1

