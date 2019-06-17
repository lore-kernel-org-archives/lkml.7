Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F83C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B242085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="byVs9bX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfFQTbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:31:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35439 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfFQTbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:31:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJVKRS3564674
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:31:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJVKRS3564674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799881;
        bh=QTk1s2lfDkFQBOkVEKwwNWwO0tkIbs/oBXYPsQXBL7E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=byVs9bX/hY7qhdxecXV00OVacaLkLNBTQZmwPh/ArLWZRfH0hr9LIFUPq0i+re9Ac
         GQlaaWVBcEH8axcPzs13B4rYY3mniVwsky2hCbN7b7EKFUzltRY/4hU7C0fMIq++Yk
         D9dLKBcPcYv+rsat0U/o+Ra0J2Ehxs5oJBx6uDp0mDlFMGQ7l9QwAib8NaIQIrMcLp
         2O9TakFd5VW+07pGvgKKkOuWrSbquKW6Hnox9DOXegKlaE7zgyKLChu6FEHBS9VIny
         fBuxR+xuwoJ+7H6oj0sRq9mkv7o35uPVek2wYOC3Nt2Pa5sJcecxN+ghVsEF0PCfYk
         QrgC72iUwZgvA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJVKUs3564671;
        Mon, 17 Jun 2019 12:31:20 -0700
Date:   Mon, 17 Jun 2019 12:31:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-21fe8dc1191a1528f6732e471f45d370a5c48045@git.kernel.org>
Cc:     peterz@infradead.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, jolsa@redhat.com, namhyung@kernel.org,
        acme@redhat.com, leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
          acme@redhat.com, leo.yan@linaro.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          hpa@zytor.com, suzuki.poulose@arm.com, peterz@infradead.org,
          jolsa@redhat.com, mathieu.poirier@linaro.org
In-Reply-To: <20190524173508.29044-18-mathieu.poirier@linaro.org>
References: <20190524173508.29044-18-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Add support for CPU-wide trace
 scenarios
Git-Commit-ID: 21fe8dc1191a1528f6732e471f45d370a5c48045
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

Commit-ID:  21fe8dc1191a1528f6732e471f45d370a5c48045
Gitweb:     https://git.kernel.org/tip/21fe8dc1191a1528f6732e471f45d370a5c48045
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 24 May 2019 11:35:08 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:02 -0300

perf cs-etm: Add support for CPU-wide trace scenarios

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
 tools/perf/util/cs-etm.c | 254 +++++++++++++++++++++++++++++++++++++++++++++--
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
 
