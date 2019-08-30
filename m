Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEB0C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D830422CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPf/U6vB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfH3GYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:24:55 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46439 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfH3GYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:24:55 -0400
Received: by mail-yb1-f196.google.com with SMTP id y194so2065985ybe.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 23:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ELhnXlXvAFpwCV+V+b16yA2Nld0gK9Jz+4VNmTdBWdw=;
        b=wPf/U6vBDNIDDjJdEeBOmvaat9NvWYI/03e7p7HMz2TC2ZjEYLn5tveASdi7BR+AvA
         uibnvuSe/esgef7sw1I5vAnsW00Xt5qexP5PVQEKjG+YBy/bipVr9GF+qOmUXjwWvIH4
         +NQOJiJcjkNj/PGY9m38pWmhGpi5pg1gNh0m5GcDsHpyQBAc/eWhNB99u1fyWR3uCGax
         Q4oEXrIKdlL+17FlRKeL/DyTkK7kIEYOmkNZzLjmp7FW7fxRziJmV6SxPOfzMw7i5+ts
         mrnyKG47YnoVjyQ0ZKwjJNOOLU0rgdzouLzcJTO0m2hh6YR2L8qWgiV9vBsC5BRKr4O/
         7XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ELhnXlXvAFpwCV+V+b16yA2Nld0gK9Jz+4VNmTdBWdw=;
        b=B88PwJxkaHtaOx+bYbCxa7aq4EuBJR3d+dk9FNq1s1MufzX2ijdWnIxtUw1KTg+5vJ
         YM76/Gm7XLkPtFJzFsCN+9psHIr6GwLWZLfvNcWaeRVvufR29WXucyxji+x4nCnJjTFd
         OQBciKUrhP4RaTNPlucQoFUYJdaNEVesEVwU481HIcwq0qOg+66ok0zjWL+td2cptKbh
         12+tjQ4rxlnAuIE4y7BHnVw07dBg68812PCpAJs4SXqmSXc5TZkFF0e2zLddt+x+j6z3
         dyrjigSKia03X0Jv2ZY5cirPyVhKr5NIfxlSk2fsHPIJN8LA2GDGf9pM3U8Ejd9efvOj
         Y8DA==
X-Gm-Message-State: APjAAAVLMkSiT5nffEueplVCazfSfSjFnXE2tv2Q4O+4KcoeDV5vJ4x9
        HqOHlhwzQ3V9PpSfq3qom4h0Aw==
X-Google-Smtp-Source: APXvYqyvU5/TZFIK+mjFwUTLF+eCFaZYTSR08qcHNcKCNl2yqbNOf3yvoTXvqjr/RXrksLmAjMn8LQ==
X-Received: by 2002:a25:bb83:: with SMTP id y3mr9736959ybg.345.1567146294119;
        Thu, 29 Aug 2019 23:24:54 -0700 (PDT)
Received: from localhost.localdomain (li1320-244.members.linode.com. [45.79.221.244])
        by smtp.gmail.com with ESMTPSA id r193sm976784ywe.8.2019.08.29.23.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 23:24:53 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <Robert.Walker@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/3] perf cs-etm: Add callchain to instruction sample
Date:   Fri, 30 Aug 2019 14:24:20 +0800
Message-Id: <20190830062421.31275-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830062421.31275-1-leo.yan@linaro.org>
References: <20190830062421.31275-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, this patch adds support for the thread stack; when every branch
packet is coming we will push or pop the stack based on the sample
flags.

Secondly, based on the thread stack we can synthesize call chain for the
instruction sample, this can be used by itrace option '--itrace=g'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 74 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 882a0718033d..ad573d3bd305 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 
 #include "auxtrace.h"
+#include "callchain.h"
 #include "color.h"
 #include "cs-etm.h"
 #include "cs-etm-decoder/cs-etm-decoder.h"
@@ -69,6 +70,7 @@ struct cs_etm_traceid_queue {
 	size_t last_branch_pos;
 	union perf_event *event_buf;
 	struct thread *thread;
+	struct ip_callchain *chain;
 	struct branch_stack *last_branch;
 	struct branch_stack *last_branch_rb;
 	struct cs_etm_packet *prev_packet;
@@ -246,6 +248,16 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	if (!tidq->prev_packet)
 		goto out_free;
 
+	if (etm->synth_opts.callchain) {
+		size_t sz = sizeof(struct ip_callchain);
+
+		/* Add 1 to callchain_sz for callchain context */
+		sz += (etm->synth_opts.callchain_sz + 1) * sizeof(u64);
+		tidq->chain = zalloc(sz);
+		if (!tidq->chain)
+			goto out_free;
+	}
+
 	if (etm->synth_opts.last_branch) {
 		size_t sz = sizeof(struct branch_stack);
 
@@ -270,6 +282,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	zfree(&tidq->last_branch);
 	zfree(&tidq->prev_packet);
 	zfree(&tidq->packet);
+	zfree(&tidq->chain);
 out:
 	return rc;
 }
@@ -541,6 +554,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		zfree(&tidq->last_branch_rb);
 		zfree(&tidq->prev_packet);
 		zfree(&tidq->packet);
+		zfree(&tidq->chain);
 		zfree(&tidq);
 
 		/*
@@ -1121,6 +1135,41 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 			   sample->insn_len, (void *)sample->insn);
 }
 
+static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
+				    struct cs_etm_traceid_queue *tidq)
+{
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	u8 trace_chan_id = tidq->trace_chan_id;
+	int insn_len;
+	u64 from_ip, to_ip;
+
+	if (etm->synth_opts.callchain || etm->synth_opts.thread_stack) {
+
+		from_ip = cs_etm__last_executed_instr(tidq->prev_packet);
+		to_ip = cs_etm__first_executed_instr(tidq->packet);
+
+		/*
+		 * T32 instruction size might be 32-bit or 16-bit, decide by
+		 * calling cs_etm__t32_instr_size().
+		 */
+		if (tidq->prev_packet->isa == CS_ETM_ISA_T32)
+			insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
+							  from_ip);
+		/* Otherwise, A64 and A32 instruction size are always 32-bit. */
+		else
+			insn_len = 4;
+
+		thread_stack__event(tidq->thread, tidq->prev_packet->cpu,
+				    tidq->prev_packet->flags,
+				    from_ip, to_ip, insn_len,
+				    etmq->buffer->buffer_nr);
+	} else {
+		thread_stack__set_trace_nr(tidq->thread,
+					   tidq->prev_packet->cpu,
+					   etmq->buffer->buffer_nr);
+	}
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
@@ -1146,6 +1195,14 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
 	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
 
+	if (etm->synth_opts.callchain) {
+		thread_stack__sample(tidq->thread, tidq->packet->cpu,
+				     tidq->chain,
+				     etm->synth_opts.callchain_sz + 1,
+				     sample.ip, etm->kernel_start);
+		sample.callchain = tidq->chain;
+	}
+
 	if (etm->synth_opts.last_branch) {
 		cs_etm__copy_last_branch_rb(etmq, tidq);
 		sample.branch_stack = tidq->last_branch;
@@ -1329,6 +1386,8 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
 	}
 
+	if (etm->synth_opts.callchain)
+		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
 	if (etm->synth_opts.last_branch)
 		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
 
@@ -1397,6 +1456,9 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		tidq->period_instructions = instrs_over;
 	}
 
+	if (tidq->prev_packet->last_instr_taken_branch)
+		cs_etm__add_stack_event(etmq, tidq);
+
 	if (etm->sample_branches) {
 		bool generate_sample = false;
 
@@ -2596,7 +2658,17 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	} else {
 		itrace_synth_opts__set_default(&etm->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
-		etm->synth_opts.callchain = false;
+
+		etm->synth_opts.thread_stack =
+				session->itrace_synth_opts->thread_stack;
+	}
+
+	if (etm->synth_opts.callchain && !symbol_conf.use_callchain) {
+		symbol_conf.use_callchain = true;
+		if (callchain_register_param(&callchain_param) < 0) {
+			symbol_conf.use_callchain = false;
+			etm->synth_opts.callchain = false;
+		}
 	}
 
 	err = cs_etm__synth_events(etm, session);
-- 
2.17.1

