Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95B7C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD27021841
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279759;
	bh=rRPWyXf/P4oPTjeQEGzzjTqCNe8zouGMXITP7Rfy/AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=15gjaUMYb/Ux5nR+83p+LWO1a4GKv7OXIZmvcmeSSSz28uf7AZbBYXyoBW5LtikuP
	 /6huB4uPNhrgOtUmGo3ACF23RChNd70xNqLogAoflTZr0ODx6n77jXU8cuOof6Yb5I
	 T9ptd12wJSTcdOBPX/axtU6IL51HgLZLZijUdMyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405295AbfFKTCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388030AbfFKTCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:02:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B9162184B;
        Tue, 11 Jun 2019 19:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279756;
        bh=rRPWyXf/P4oPTjeQEGzzjTqCNe8zouGMXITP7Rfy/AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KlXoXJNF1Or1TnqMkBibpoSCPCj/61oO1LLyy/Gbk7gpi3FFa8CkzRcSeOliJnRE3
         HxTmHc1qMBbuhK7frE8ZLyu+kcfe902eCqbqJG5fpuryQb6ifEMhIl/y8VnRbRZOUi
         NHqP5YX7ROHwI3oN5jRr3zg6/mZ4I6wZJyFOOSnU=
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
Subject: [PATCH 43/85] perf cs-etm: Move packet queue out of decoder structure
Date:   Tue, 11 Jun 2019 15:58:29 -0300
Message-Id: <20190611185911.11645-44-acme@kernel.org>
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

The decoder needs to work with more than one traceID queue if we want to
support CPU-wide scenarios with N:1 source/sink topologies.  As such
move the packet buffer and related fields out of the decoder structure
and into the cs_etm_queue structure.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-8-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 129 +++++++-----------
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  36 +----
 tools/perf/util/cs-etm.c                      |  37 ++++-
 tools/perf/util/cs-etm.h                      |  53 +++++++
 4 files changed, 144 insertions(+), 111 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 5dafec421b0d..3ac238e58901 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -18,8 +18,6 @@
 #include "intlist.h"
 #include "util.h"
 
-#define MAX_BUFFER 1024
-
 /* use raw logging */
 #ifdef CS_DEBUG_RAW
 #define CS_LOG_RAW_FRAMES
@@ -31,18 +29,12 @@
 #endif
 #endif
 
-#define CS_ETM_INVAL_ADDR	0xdeadbeefdeadbeefUL
-
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg);
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
 	ocsd_datapath_resp_t prev_return;
-	u32 packet_count;
-	u32 head;
-	u32 tail;
-	struct cs_etm_packet packet_buffer[MAX_BUFFER];
 };
 
 static u32
@@ -88,14 +80,14 @@ int cs_etm_decoder__reset(struct cs_etm_decoder *decoder)
 	return 0;
 }
 
-int cs_etm_decoder__get_packet(struct cs_etm_decoder *decoder,
+int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
 			       struct cs_etm_packet *packet)
 {
-	if (!decoder || !packet)
+	if (!packet_queue || !packet)
 		return -EINVAL;
 
 	/* Nothing to do, might as well just return */
-	if (decoder->packet_count == 0)
+	if (packet_queue->packet_count == 0)
 		return 0;
 	/*
 	 * The queueing process in function cs_etm_decoder__buffer_packet()
@@ -106,11 +98,12 @@ int cs_etm_decoder__get_packet(struct cs_etm_decoder *decoder,
 	 * value.  Otherwise the first element of the packet queue is not
 	 * used.
 	 */
-	decoder->head = (decoder->head + 1) & (MAX_BUFFER - 1);
+	packet_queue->head = (packet_queue->head + 1) &
+			     (CS_ETM_PACKET_MAX_BUFFER - 1);
 
-	*packet = decoder->packet_buffer[decoder->head];
+	*packet = packet_queue->packet_buffer[packet_queue->head];
 
-	decoder->packet_count--;
+	packet_queue->packet_count--;
 
 	return 1;
 }
@@ -276,84 +269,60 @@ cs_etm_decoder__create_etm_packet_printer(struct cs_etm_trace_params *t_params,
 						     trace_config);
 }
 
-static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
-{
-	int i;
-
-	decoder->head = 0;
-	decoder->tail = 0;
-	decoder->packet_count = 0;
-	for (i = 0; i < MAX_BUFFER; i++) {
-		decoder->packet_buffer[i].isa = CS_ETM_ISA_UNKNOWN;
-		decoder->packet_buffer[i].start_addr = CS_ETM_INVAL_ADDR;
-		decoder->packet_buffer[i].end_addr = CS_ETM_INVAL_ADDR;
-		decoder->packet_buffer[i].instr_count = 0;
-		decoder->packet_buffer[i].last_instr_taken_branch = false;
-		decoder->packet_buffer[i].last_instr_size = 0;
-		decoder->packet_buffer[i].last_instr_type = 0;
-		decoder->packet_buffer[i].last_instr_subtype = 0;
-		decoder->packet_buffer[i].last_instr_cond = 0;
-		decoder->packet_buffer[i].flags = 0;
-		decoder->packet_buffer[i].exception_number = UINT32_MAX;
-		decoder->packet_buffer[i].trace_chan_id = UINT8_MAX;
-		decoder->packet_buffer[i].cpu = INT_MIN;
-	}
-}
-
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
+cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
 			      const u8 trace_chan_id,
 			      enum cs_etm_sample_type sample_type)
 {
 	u32 et = 0;
 	int cpu;
 
-	if (decoder->packet_count >= MAX_BUFFER - 1)
+	if (packet_queue->packet_count >= CS_ETM_PACKET_MAX_BUFFER - 1)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
 	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-	et = decoder->tail;
-	et = (et + 1) & (MAX_BUFFER - 1);
-	decoder->tail = et;
-	decoder->packet_count++;
-
-	decoder->packet_buffer[et].sample_type = sample_type;
-	decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
-	decoder->packet_buffer[et].cpu = cpu;
-	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
-	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
-	decoder->packet_buffer[et].instr_count = 0;
-	decoder->packet_buffer[et].last_instr_taken_branch = false;
-	decoder->packet_buffer[et].last_instr_size = 0;
-	decoder->packet_buffer[et].last_instr_type = 0;
-	decoder->packet_buffer[et].last_instr_subtype = 0;
-	decoder->packet_buffer[et].last_instr_cond = 0;
-	decoder->packet_buffer[et].flags = 0;
-	decoder->packet_buffer[et].exception_number = UINT32_MAX;
-	decoder->packet_buffer[et].trace_chan_id = trace_chan_id;
-
-	if (decoder->packet_count == MAX_BUFFER - 1)
+	et = packet_queue->tail;
+	et = (et + 1) & (CS_ETM_PACKET_MAX_BUFFER - 1);
+	packet_queue->tail = et;
+	packet_queue->packet_count++;
+
+	packet_queue->packet_buffer[et].sample_type = sample_type;
+	packet_queue->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
+	packet_queue->packet_buffer[et].cpu = cpu;
+	packet_queue->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
+	packet_queue->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
+	packet_queue->packet_buffer[et].instr_count = 0;
+	packet_queue->packet_buffer[et].last_instr_taken_branch = false;
+	packet_queue->packet_buffer[et].last_instr_size = 0;
+	packet_queue->packet_buffer[et].last_instr_type = 0;
+	packet_queue->packet_buffer[et].last_instr_subtype = 0;
+	packet_queue->packet_buffer[et].last_instr_cond = 0;
+	packet_queue->packet_buffer[et].flags = 0;
+	packet_queue->packet_buffer[et].exception_number = UINT32_MAX;
+	packet_queue->packet_buffer[et].trace_chan_id = trace_chan_id;
+
+	if (packet_queue->packet_count == CS_ETM_PACKET_MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
 
 	return OCSD_RESP_CONT;
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
+cs_etm_decoder__buffer_range(struct cs_etm_packet_queue *packet_queue,
 			     const ocsd_generic_trace_elem *elem,
 			     const uint8_t trace_chan_id)
 {
 	int ret = 0;
 	struct cs_etm_packet *packet;
 
-	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+	ret = cs_etm_decoder__buffer_packet(packet_queue, trace_chan_id,
 					    CS_ETM_RANGE);
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
 
-	packet = &decoder->packet_buffer[decoder->tail];
+	packet = &packet_queue->packet_buffer[packet_queue->tail];
 
 	switch (elem->isa) {
 	case ocsd_isa_aarch64:
@@ -400,36 +369,36 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
-					   const uint8_t trace_chan_id)
+cs_etm_decoder__buffer_discontinuity(struct cs_etm_packet_queue *queue,
+				     const uint8_t trace_chan_id)
 {
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+	return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
 					     CS_ETM_DISCONTINUITY);
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
+cs_etm_decoder__buffer_exception(struct cs_etm_packet_queue *queue,
 				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
 {	int ret = 0;
 	struct cs_etm_packet *packet;
 
-	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+	ret = cs_etm_decoder__buffer_packet(queue, trace_chan_id,
 					    CS_ETM_EXCEPTION);
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
 
-	packet = &decoder->packet_buffer[decoder->tail];
+	packet = &queue->packet_buffer[queue->tail];
 	packet->exception_number = elem->exception_number;
 
 	return ret;
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_exception_ret(struct cs_etm_decoder *decoder,
+cs_etm_decoder__buffer_exception_ret(struct cs_etm_packet_queue *queue,
 				     const uint8_t trace_chan_id)
 {
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+	return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
 					     CS_ETM_EXCEPTION_RET);
 }
 
@@ -441,6 +410,13 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 {
 	ocsd_datapath_resp_t resp = OCSD_RESP_CONT;
 	struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
+	struct cs_etm_queue *etmq = decoder->data;
+	struct cs_etm_packet_queue *packet_queue;
+
+	/* First get the packet queue */
+	packet_queue = cs_etm__etmq_get_packet_queue(etmq);
+	if (!packet_queue)
+		return OCSD_RESP_FATAL_SYS_ERR;
 
 	switch (elem->elem_type) {
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
@@ -448,19 +424,19 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_EO_TRACE:
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
-		resp = cs_etm_decoder__buffer_discontinuity(decoder,
+		resp = cs_etm_decoder__buffer_discontinuity(packet_queue,
 							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
-		resp = cs_etm_decoder__buffer_range(decoder, elem,
+		resp = cs_etm_decoder__buffer_range(packet_queue, elem,
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(decoder, elem,
+		resp = cs_etm_decoder__buffer_exception(packet_queue, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
-		resp = cs_etm_decoder__buffer_exception_ret(decoder,
+		resp = cs_etm_decoder__buffer_exception_ret(packet_queue,
 							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
@@ -554,7 +530,6 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
 
 	decoder->data = d_params->data;
 	decoder->prev_return = OCSD_RESP_CONT;
-	cs_etm_decoder__clear_buffer(decoder);
 	format = (d_params->formatted ? OCSD_TRC_SRC_FRAME_FORMATTED :
 					 OCSD_TRC_SRC_SINGLE);
 	flags = 0;
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 3ab11dfa92ae..6ae7ab4cf5fe 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -14,38 +14,8 @@
 #include <stdio.h>
 
 struct cs_etm_decoder;
-
-enum cs_etm_sample_type {
-	CS_ETM_EMPTY,
-	CS_ETM_RANGE,
-	CS_ETM_DISCONTINUITY,
-	CS_ETM_EXCEPTION,
-	CS_ETM_EXCEPTION_RET,
-};
-
-enum cs_etm_isa {
-	CS_ETM_ISA_UNKNOWN,
-	CS_ETM_ISA_A64,
-	CS_ETM_ISA_A32,
-	CS_ETM_ISA_T32,
-};
-
-struct cs_etm_packet {
-	enum cs_etm_sample_type sample_type;
-	enum cs_etm_isa isa;
-	u64 start_addr;
-	u64 end_addr;
-	u32 instr_count;
-	u32 last_instr_type;
-	u32 last_instr_subtype;
-	u32 flags;
-	u32 exception_number;
-	u8 last_instr_cond;
-	u8 last_instr_taken_branch;
-	u8 last_instr_size;
-	u8 trace_chan_id;
-	int cpu;
-};
+struct cs_etm_packet;
+struct cs_etm_packet_queue;
 
 struct cs_etm_queue;
 
@@ -119,7 +89,7 @@ int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
 				      u64 start, u64 end,
 				      cs_etm_mem_cb_type cb_func);
 
-int cs_etm_decoder__get_packet(struct cs_etm_decoder *decoder,
+int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
 			       struct cs_etm_packet *packet);
 
 int cs_etm_decoder__reset(struct cs_etm_decoder *decoder);
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5322dcaaf654..a74c53a45839 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -78,6 +78,7 @@ struct cs_etm_queue {
 	struct cs_etm_packet *packet;
 	const unsigned char *buf;
 	size_t buf_len, buf_used;
+	struct cs_etm_packet_queue packet_queue;
 };
 
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
@@ -125,6 +126,36 @@ int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
 	return 0;
 }
 
+static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
+{
+	int i;
+
+	queue->head = 0;
+	queue->tail = 0;
+	queue->packet_count = 0;
+	for (i = 0; i < CS_ETM_PACKET_MAX_BUFFER; i++) {
+		queue->packet_buffer[i].isa = CS_ETM_ISA_UNKNOWN;
+		queue->packet_buffer[i].start_addr = CS_ETM_INVAL_ADDR;
+		queue->packet_buffer[i].end_addr = CS_ETM_INVAL_ADDR;
+		queue->packet_buffer[i].instr_count = 0;
+		queue->packet_buffer[i].last_instr_taken_branch = false;
+		queue->packet_buffer[i].last_instr_size = 0;
+		queue->packet_buffer[i].last_instr_type = 0;
+		queue->packet_buffer[i].last_instr_subtype = 0;
+		queue->packet_buffer[i].last_instr_cond = 0;
+		queue->packet_buffer[i].flags = 0;
+		queue->packet_buffer[i].exception_number = UINT32_MAX;
+		queue->packet_buffer[i].trace_chan_id = UINT8_MAX;
+		queue->packet_buffer[i].cpu = INT_MIN;
+	}
+}
+
+struct cs_etm_packet_queue
+*cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq)
+{
+	return &etmq->packet_queue;
+}
+
 static void cs_etm__packet_dump(const char *pkt_string)
 {
 	const char *color = PERF_COLOR_BLUE;
@@ -513,6 +544,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	etmq->pid = -1;
 	etmq->offset = 0;
 	etmq->period_instructions = 0;
+	cs_etm__clear_packet_queue(&etmq->packet_queue);
 
 out:
 	return ret;
@@ -1542,10 +1574,13 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq)
 static int cs_etm__process_decoder_queue(struct cs_etm_queue *etmq)
 {
 	int ret;
+	struct cs_etm_packet_queue *packet_queue;
+
+	packet_queue = cs_etm__etmq_get_packet_queue(etmq);
 
 		/* Process each packet in this chunk */
 		while (1) {
-			ret = cs_etm_decoder__get_packet(etmq->decoder,
+			ret = cs_etm_decoder__get_packet(packet_queue,
 							 etmq->packet);
 			if (ret <= 0)
 				/*
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 826c9eedaf5c..75385e2fd283 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -97,12 +97,57 @@ enum {
 	CS_ETMV4_EXC_END = 31,
 };
 
+enum cs_etm_sample_type {
+	CS_ETM_EMPTY,
+	CS_ETM_RANGE,
+	CS_ETM_DISCONTINUITY,
+	CS_ETM_EXCEPTION,
+	CS_ETM_EXCEPTION_RET,
+};
+
+enum cs_etm_isa {
+	CS_ETM_ISA_UNKNOWN,
+	CS_ETM_ISA_A64,
+	CS_ETM_ISA_A32,
+	CS_ETM_ISA_T32,
+};
+
 /* RB tree for quick conversion between traceID and metadata pointers */
 struct intlist *traceid_list;
 
+struct cs_etm_queue;
+
+struct cs_etm_packet {
+	enum cs_etm_sample_type sample_type;
+	enum cs_etm_isa isa;
+	u64 start_addr;
+	u64 end_addr;
+	u32 instr_count;
+	u32 last_instr_type;
+	u32 last_instr_subtype;
+	u32 flags;
+	u32 exception_number;
+	u8 last_instr_cond;
+	u8 last_instr_taken_branch;
+	u8 last_instr_size;
+	u8 trace_chan_id;
+	int cpu;
+};
+
+#define CS_ETM_PACKET_MAX_BUFFER 1024
+
+struct cs_etm_packet_queue {
+	u32 packet_count;
+	u32 head;
+	u32 tail;
+	struct cs_etm_packet packet_buffer[CS_ETM_PACKET_MAX_BUFFER];
+};
+
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
 
+#define CS_ETM_INVAL_ADDR 0xdeadbeefdeadbeefUL
+
 /*
  * Create a contiguous bitmask starting at bit position @l and ending at
  * position @h. For example
@@ -126,6 +171,8 @@ struct intlist *traceid_list;
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
+struct cs_etm_packet_queue
+*cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq);
 #else
 static inline int
 cs_etm__process_auxtrace_info(union perf_event *event __maybe_unused,
@@ -139,6 +186,12 @@ static inline int cs_etm__get_cpu(u8 trace_chan_id __maybe_unused,
 {
 	return -1;
 }
+
+static inline struct cs_etm_packet_queue *cs_etm__etmq_get_packet_queue(
+				struct cs_etm_queue *etmq __maybe_unused)
+{
+	return NULL;
+}
 #endif
 
 #endif
-- 
2.20.1

