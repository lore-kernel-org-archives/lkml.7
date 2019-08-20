Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FA4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13032339E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566329322;
	bh=nyQDcDGVNc52qwyCVzLDl29QlA+MDVXD/S7ZPOvV3AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P0haJCyg3zrI51ZaGNaFmC4n/3++b3MQbCQL4tRze/l7INlFqImDKKxEGZVeXfMuf
	 bYgMPQ+3cuYIIcKSt4FQWnP/ZfIjdEyzKF7OwwLPh5pmWBkpVsNi1NTIEoDhOjqICp
	 /hc3GOmJK2Y/TmE2KQDuTMedUaYPkA00kIpZSG8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbfHTT2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730466AbfHTT2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:40 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C70D22DD6;
        Tue, 20 Aug 2019 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329319;
        bh=nyQDcDGVNc52qwyCVzLDl29QlA+MDVXD/S7ZPOvV3AY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glezjKsKTTE8U3A0qUcMpTsgKWzjLZL70stlvw3BUEPBC5o+zym5w+Y6FSaGwaCcO
         rNNiGdk+VgKfsBjQMzOGeSFJbFqSpePlaattXdccUWwUJaDVMU7XlDlK9d70quAsvX
         +2UN+dHgnkk2vja2Scbl1QFibkr3HyWjod710Npg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/17] perf cs-etm: Support sample flags 'insn' and 'insnlen'
Date:   Tue, 20 Aug 2019 16:27:27 -0300
Message-Id: <20190820192733.19180-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

The synthetic branch and instruction samples are missed to set
instruction related info, thus the perf tool fails to display samples
with flags '-F,+insn,+insnlen'.

The CoreSight trace decoder provides sufficient information to decide
the instruction size based on the ISA type: A64/A32 instructions are
32-bit size, but one exception is the T32 instruction size, which might
be 32-bit or 16-bit.

This patch handles these cases and it reads the instruction values from
DSO file; thus can support the flags '-F,+insn,+insnlen'.

Before:

  # perf script -F,insn,insnlen,ip,sym
                0 [unknown] ilen: 0
     ffff97174044 _start ilen: 0
     ffff97174938 _dl_start ilen: 0
     ffff97174938 _dl_start ilen: 0
     ffff97174938 _dl_start ilen: 0
     ffff97174938 _dl_start ilen: 0
     ffff97174938 _dl_start ilen: 0
     ffff97174938 _dl_start ilen: 0
     ffff97174938 _dl_start ilen: 0
     ffff97174938 _dl_start ilen: 0

  [...]

After:

  # perf script -F,insn,insnlen,ip,sym
                0 [unknown] ilen: 0
     ffff97174044 _start ilen: 4 insn: 2f 02 00 94
     ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
     ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
     ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
     ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
     ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
     ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
     ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
     ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54

  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190815082854.18191-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ed6f7fd5b90b..b3a5daaf1a8f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1076,6 +1076,35 @@ bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq)
 	return !!etmq->etm->timeless_decoding;
 }
 
+static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
+			      u64 trace_chan_id,
+			      const struct cs_etm_packet *packet,
+			      struct perf_sample *sample)
+{
+	/*
+	 * It's pointless to read instructions for the CS_ETM_DISCONTINUITY
+	 * packet, so directly bail out with 'insn_len' = 0.
+	 */
+	if (packet->sample_type == CS_ETM_DISCONTINUITY) {
+		sample->insn_len = 0;
+		return;
+	}
+
+	/*
+	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
+	 * cs_etm__t32_instr_size().
+	 */
+	if (packet->isa == CS_ETM_ISA_T32)
+		sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
+							  sample->ip);
+	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
+	else
+		sample->insn_len = 4;
+
+	cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
+			   sample->insn_len, (void *)sample->insn);
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
@@ -1097,9 +1126,10 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.period = period;
 	sample.cpu = tidq->packet->cpu;
 	sample.flags = tidq->prev_packet->flags;
-	sample.insn_len = 1;
 	sample.cpumode = event->sample.header.misc;
 
+	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
+
 	if (etm->synth_opts.last_branch) {
 		cs_etm__copy_last_branch_rb(etmq, tidq);
 		sample.branch_stack = tidq->last_branch;
@@ -1159,6 +1189,9 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	sample.flags = tidq->prev_packet->flags;
 	sample.cpumode = event->sample.header.misc;
 
+	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->prev_packet,
+			  &sample);
+
 	/*
 	 * perf report cannot handle events without a branch stack
 	 */
-- 
2.21.0

