Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC18AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D25821852
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279791;
	bh=qzE6Q3XplctFACCyBy1H8PtIRSIfvoHm3GL1eypW52w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ysWKhF79dQ0YGhfbJ7G2aWhK+5R1xh8yMtoXFKbxK8mBXxdlBH7zy2wgMnW93/ykD
	 FB/llxRm3Zll8Jba24jnvZskEWlwEqQcjki3q68VkWO/lrpYEwBTUzkEdPBVtrqGs4
	 zrMDDAohZj8MTkjo4N5aIuUez/kLkBjP5eQ0pmBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392466AbfFKTDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392437AbfFKTDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:03:02 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C488217D6;
        Tue, 11 Jun 2019 19:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279782;
        bh=qzE6Q3XplctFACCyBy1H8PtIRSIfvoHm3GL1eypW52w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uzkf1stv8nZn1zpRKDhw1pWlVjHpnDUHiEFrqkcypWUubJj/aDGvkkZtV0Pta/fhM
         6GecTUBQN39HVVW3yfxLEw86TB1d5K2Hbe3GmRf9Nz+ojaGiL7ToBcS9wcvZuudHcW
         eZOOA9OIQ2uD4ZDVJeoO0YlWKj+r5ph4bhTbp/Y8=
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
Subject: [PATCH 49/85] perf cs-etm: Use traceID aware memory callback API
Date:   Tue, 11 Jun 2019 15:58:35 -0300
Message-Id: <20190611185911.11645-50-acme@kernel.org>
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

When working with CPU-wide traces different traceID may be found in the
same stream.  As such we need to use the decoder callback that provides
the traceID in order to know the thread context being decoded.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190524173508.29044-14-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 14 +++----
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  3 +-
 tools/perf/util/cs-etm.c                      | 41 +++++++++++++------
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 4303d2d00d31..87264b79de0e 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -41,15 +41,14 @@ static u32
 cs_etm_decoder__mem_access(const void *context,
 			   const ocsd_vaddr_t address,
 			   const ocsd_mem_space_acc_t mem_space __maybe_unused,
+			   const u8 trace_chan_id,
 			   const u32 req_size,
 			   u8 *buffer)
 {
 	struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
 
-	return decoder->mem_access(decoder->data,
-				   address,
-				   req_size,
-				   buffer);
+	return decoder->mem_access(decoder->data, trace_chan_id,
+				   address, req_size, buffer);
 }
 
 int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
@@ -58,9 +57,10 @@ int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
 {
 	decoder->mem_access = cb_func;
 
-	if (ocsd_dt_add_callback_mem_acc(decoder->dcd_tree, start, end,
-					 OCSD_MEM_SPACE_ANY,
-					 cs_etm_decoder__mem_access, decoder))
+	if (ocsd_dt_add_callback_trcid_mem_acc(decoder->dcd_tree, start, end,
+					       OCSD_MEM_SPACE_ANY,
+					       cs_etm_decoder__mem_access,
+					       decoder))
 		return -1;
 
 	return 0;
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 6ae7ab4cf5fe..11f3391d06f2 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -19,8 +19,7 @@ struct cs_etm_packet_queue;
 
 struct cs_etm_queue;
 
-typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u64,
-				  size_t, u8 *);
+typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u8, u64, size_t, u8 *);
 
 struct cs_etmv3_trace_params {
 	u32 reg_ctrl;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 7e3b4d10f5c4..2483293266d8 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -491,8 +491,8 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
 	}
 }
 
-static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
-			      size_t size, u8 *buffer)
+static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
+			      u64 address, size_t size, u8 *buffer)
 {
 	u8  cpumode;
 	u64 offset;
@@ -501,6 +501,8 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	struct	 machine *machine;
 	struct	 addr_location al;
 
+	(void)trace_chan_id;
+
 	if (!etmq)
 		return 0;
 
@@ -687,10 +689,12 @@ void cs_etm__reset_last_branch_rb(struct cs_etm_traceid_queue *tidq)
 }
 
 static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
-					 u64 addr) {
+					 u8 trace_chan_id, u64 addr)
+{
 	u8 instrBytes[2];
 
-	cs_etm__mem_access(etmq, addr, ARRAY_SIZE(instrBytes), instrBytes);
+	cs_etm__mem_access(etmq, trace_chan_id, addr,
+			   ARRAY_SIZE(instrBytes), instrBytes);
 	/*
 	 * T32 instruction size is indicated by bits[15:11] of the first
 	 * 16-bit word of the instruction: 0b11101, 0b11110 and 0b11111
@@ -719,6 +723,7 @@ u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
 }
 
 static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
+				     u64 trace_chan_id,
 				     const struct cs_etm_packet *packet,
 				     u64 offset)
 {
@@ -726,7 +731,8 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 		u64 addr = packet->start_addr;
 
 		while (offset > 0) {
-			addr += cs_etm__t32_instr_size(etmq, addr);
+			addr += cs_etm__t32_instr_size(etmq,
+						       trace_chan_id, addr);
 			offset--;
 		}
 		return addr;
@@ -1063,6 +1069,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet *tmp;
 	int ret;
+	u8 trace_chan_id = tidq->trace_chan_id;
 	u64 instrs_executed = tidq->packet->instr_count;
 
 	tidq->period_instructions += instrs_executed;
@@ -1093,7 +1100,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 * executed, but PC has not advanced to next instruction)
 		 */
 		u64 offset = (instrs_executed - instrs_over - 1);
-		u64 addr = cs_etm__instr_addr(etmq, tidq->packet, offset);
+		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
+					      tidq->packet, offset);
 
 		ret = cs_etm__synth_instruction_sample(
 			etmq, tidq, addr, etm->instructions_sample_period);
@@ -1268,7 +1276,7 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 	return etmq->buf_len;
 }
 
-static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
+static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 				 struct cs_etm_packet *packet,
 				 u64 end_addr)
 {
@@ -1291,7 +1299,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 		 * so below only read 2 bytes as instruction size for T32.
 		 */
 		addr = end_addr - 2;
-		cs_etm__mem_access(etmq, addr, sizeof(instr16), (u8 *)&instr16);
+		cs_etm__mem_access(etmq, trace_chan_id, addr,
+				   sizeof(instr16), (u8 *)&instr16);
 		if ((instr16 & 0xFF00) == 0xDF00)
 			return true;
 
@@ -1306,7 +1315,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 		 * +---------+---------+-------------------------+
 		 */
 		addr = end_addr - 4;
-		cs_etm__mem_access(etmq, addr, sizeof(instr32), (u8 *)&instr32);
+		cs_etm__mem_access(etmq, trace_chan_id, addr,
+				   sizeof(instr32), (u8 *)&instr32);
 		if ((instr32 & 0x0F000000) == 0x0F000000 &&
 		    (instr32 & 0xF0000000) != 0xF0000000)
 			return true;
@@ -1322,7 +1332,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 		 * +-----------------------+---------+-----------+
 		 */
 		addr = end_addr - 4;
-		cs_etm__mem_access(etmq, addr, sizeof(instr32), (u8 *)&instr32);
+		cs_etm__mem_access(etmq, trace_chan_id, addr,
+				   sizeof(instr32), (u8 *)&instr32);
 		if ((instr32 & 0xFFE0001F) == 0xd4000001)
 			return true;
 
@@ -1338,6 +1349,7 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq,
 static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
 			       struct cs_etm_traceid_queue *tidq, u64 magic)
 {
+	u8 trace_chan_id = tidq->trace_chan_id;
 	struct cs_etm_packet *packet = tidq->packet;
 	struct cs_etm_packet *prev_packet = tidq->prev_packet;
 
@@ -1352,7 +1364,7 @@ static bool cs_etm__is_syscall(struct cs_etm_queue *etmq,
 	 */
 	if (magic == __perf_cs_etmv4_magic) {
 		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
-		    cs_etm__is_svc_instr(etmq, prev_packet,
+		    cs_etm__is_svc_instr(etmq, trace_chan_id, prev_packet,
 					 prev_packet->end_addr))
 			return true;
 	}
@@ -1390,6 +1402,7 @@ static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
 				      struct cs_etm_traceid_queue *tidq,
 				      u64 magic)
 {
+	u8 trace_chan_id = tidq->trace_chan_id;
 	struct cs_etm_packet *packet = tidq->packet;
 	struct cs_etm_packet *prev_packet = tidq->prev_packet;
 
@@ -1415,7 +1428,7 @@ static bool cs_etm__is_sync_exception(struct cs_etm_queue *etmq,
 		 * (SMC, HVC) are taken as sync exceptions.
 		 */
 		if (packet->exception_number == CS_ETMV4_EXC_CALL &&
-		    !cs_etm__is_svc_instr(etmq, prev_packet,
+		    !cs_etm__is_svc_instr(etmq, trace_chan_id, prev_packet,
 					  prev_packet->end_addr))
 			return true;
 
@@ -1439,6 +1452,7 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 {
 	struct cs_etm_packet *packet = tidq->packet;
 	struct cs_etm_packet *prev_packet = tidq->prev_packet;
+	u8 trace_chan_id = tidq->trace_chan_id;
 	u64 magic;
 	int ret;
 
@@ -1519,7 +1533,8 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 		if (prev_packet->flags == (PERF_IP_FLAG_BRANCH |
 					   PERF_IP_FLAG_RETURN |
 					   PERF_IP_FLAG_INTERRUPT) &&
-		    cs_etm__is_svc_instr(etmq, packet, packet->start_addr))
+		    cs_etm__is_svc_instr(etmq, trace_chan_id,
+					 packet, packet->start_addr))
 			prev_packet->flags = PERF_IP_FLAG_BRANCH |
 					     PERF_IP_FLAG_RETURN |
 					     PERF_IP_FLAG_SYSCALLRET;
-- 
2.20.1

