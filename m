Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE2FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B95D23406
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390933AbfHWC2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:28:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33821 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390502AbfHWC23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:28:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zJA-00019X-TL; Fri, 23 Aug 2019 04:28:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6DC2A1C0883;
        Fri, 23 Aug 2019 04:28:08 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:28:08 -0000
From:   tip-bot2 for Leo Yan <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf cs-etm: Support sample flags 'insn' and
 'insnlen'
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Robert Walker <robert.walker@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
In-Reply-To: <20190815082854.18191-1-leo.yan@linaro.org>
References: <20190815082854.18191-1-leo.yan@linaro.org>
MIME-Version: 1.0
Message-ID: <156652728831.12701.17501120781804999488.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a4973d8f7bea98a0795ba853e7bd2cef11363824
Gitweb:        https://git.kernel.org/tip/a4973d8f7bea98a0795ba853e7bd2cef11363824
Author:        Leo Yan <leo.yan@linaro.org>
AuthorDate:    Thu, 15 Aug 2019 16:28:54 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:20:52 -03:00

perf cs-etm: Support sample flags 'insn' and 'insnlen'

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
index ed6f7fd..b3a5daa 100644
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
