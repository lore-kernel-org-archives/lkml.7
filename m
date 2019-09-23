Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8BBC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F4F20835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBIwpdcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbfIWQIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:08:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34510 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387969AbfIWQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:08:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so9415511pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ETR3TzZ5ptxgZyXVIEMbUVt7wSrL6NEDEKof5BmO9Pc=;
        b=dBIwpdcLFGtVRpg1U8Z6A1m4LJ6TPyQtUZIPjP0m2JG5ph/MeYzA06C3QUqx/J/Oz0
         Nha+yE04DSTymZFcdc5tXQxPtbM1rsWA6f87YptLUpNpPUozJhycUMDE0Lkebfq8wk66
         4D/wKTKCPlV41H9n0evAjSTIZJAPycEurI+doNmcTwXOv/09PW4SgEvI/BE3RO94AP5L
         mmK5rjsvbHqztuVn55Gkx6fR0aIwjXyEC129IoQINbL2gNld9cL0+MH0QULxK6bHuLX0
         bdHc2E7/Zjphfly3enKC5U91ddmgPs9lRUPQFQSMOrPMmlR6ypbBPerX7Ig/Q1DxvAGW
         5Mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ETR3TzZ5ptxgZyXVIEMbUVt7wSrL6NEDEKof5BmO9Pc=;
        b=gb3nIdqlK2VTeKkN9r0MhVeuNGzJvlmkUxJk8yy/d4HCrx9lhMPQ7I2YURt+oYmm+k
         mvNkFWNkQzErWAzSB6/wAecB50KJr66HoQ4XOJ0yaSAkIJoAo8n/n2HctQFIwVnfoMy6
         0srdvcZkchHOOQ+r70NWuyBhHm458eBeEmJZh1lS9YbsFYM/jCS4+GqNoo1tH15D3J6K
         gSUAz9G/L9P8NNeH29Yp9hBFu/mHOETOyzPZzt6aahdPxSK1cqCqKzkKLqI2XuLFHgCF
         rCEbN4sQZS2ELyOHjwS3dWKwDQN7RTke9ya7WgQjesW33PPmMA7SR8b43qtRZoFYo1A0
         ehVA==
X-Gm-Message-State: APjAAAXGwMuknQaGpVV4T4k370GfFiHhkUjQVg8rUT966eqzs3hr43zU
        9gyg/L04QhkwIIdRAVyKb4ZbDA==
X-Google-Smtp-Source: APXvYqwdieSmWLuOn6xr91NTuHLb3msNNF1sfUL5GeSFMr/A0e9DzJSlTHcLIr09sONJ1C1DyBkI8A==
X-Received: by 2002:a17:90a:b302:: with SMTP id d2mr245796pjr.3.1569254897444;
        Mon, 23 Sep 2019 09:08:17 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
        by smtp.gmail.com with ESMTPSA id r1sm9880006pgv.70.2019.09.23.09.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 09:08:16 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/5] perf cs-etm: Support callchain for instruction sample
Date:   Tue, 24 Sep 2019 00:07:58 +0800
Message-Id: <20190923160759.14866-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923160759.14866-1-leo.yan@linaro.org>
References: <20190923160759.14866-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight has supported the thread stack; so based on the thread stack
we can synthesize call chain for the instruction sample; the call chain
can be used by itrace option '--itrace=g'.

Before:

  # perf script --itrace=g16l64i100
            main  1579        100      instructions:  ffff0000102137f0 group_sched_in+0xb0 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010213b78 flexible_sched_in+0xf0 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff0000102135ac event_sched_in.isra.57+0x74 ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010219344 perf_swevent_add+0x6c ([kernel.kallsyms])
            main  1579        100      instructions:  ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
  [...]

After:

  # perf script --itrace=g16l64i100

  main  1579        100      instructions:
          ffff000010213b78 flexible_sched_in+0xf0 ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

  main  1579        100      instructions:
          ffff0000102135ac event_sched_in.isra.57+0x74 ([kernel.kallsyms])
          ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
          ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

  main  1579        100      instructions:
          ffff000010219344 perf_swevent_add+0x6c ([kernel.kallsyms])
          ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
          ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
          ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
          ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 018c7e682ded..bd09254a7208 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 
 #include "auxtrace.h"
+#include "callchain.h"
 #include "color.h"
 #include "cs-etm.h"
 #include "cs-etm-decoder/cs-etm-decoder.h"
@@ -73,6 +74,7 @@ struct cs_etm_traceid_queue {
 	size_t last_branch_pos;
 	union perf_event *event_buf;
 	struct thread *thread;
+	struct ip_callchain *chain;
 	struct branch_stack *last_branch;
 	struct branch_stack *last_branch_rb;
 	struct cs_etm_packet *prev_packet;
@@ -250,6 +252,16 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
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
 
@@ -274,6 +286,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	zfree(&tidq->last_branch);
 	zfree(&tidq->prev_packet);
 	zfree(&tidq->packet);
+	zfree(&tidq->chain);
 out:
 	return rc;
 }
@@ -545,6 +558,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		zfree(&tidq->last_branch_rb);
 		zfree(&tidq->prev_packet);
 		zfree(&tidq->packet);
+		zfree(&tidq->chain);
 		zfree(&tidq);
 
 		/*
@@ -1125,7 +1139,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 	int insn_len;
 	u64 from_ip, to_ip;
 
-	if (etm->synth_opts.thread_stack) {
+	if (etm->synth_opts.callchain || etm->synth_opts.thread_stack) {
 		from_ip = cs_etm__last_executed_instr(tidq->prev_packet);
 		to_ip = cs_etm__first_executed_instr(tidq->packet);
 
@@ -1181,6 +1195,14 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
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
@@ -1368,6 +1390,8 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
 	}
 
+	if (etm->synth_opts.callchain)
+		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
 	if (etm->synth_opts.last_branch)
 		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
 
@@ -2638,7 +2662,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	} else {
 		itrace_synth_opts__set_default(&etm->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
-		etm->synth_opts.callchain = false;
 		etm->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
 	}
@@ -2650,6 +2673,14 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		etm->branches_filter |= PERF_IP_FLAG_RETURN |
 					PERF_IP_FLAG_TRACE_BEGIN;
 
+	if (etm->synth_opts.callchain && !symbol_conf.use_callchain) {
+		symbol_conf.use_callchain = true;
+		if (callchain_register_param(&callchain_param) < 0) {
+			symbol_conf.use_callchain = false;
+			etm->synth_opts.callchain = false;
+		}
+	}
+
 	err = cs_etm__synth_events(etm, session);
 	if (err)
 		goto err_delete_thread;
-- 
2.17.1

