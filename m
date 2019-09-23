Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01C8C4CED2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CED720835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuJY65Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbfIWQIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:08:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36450 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387969AbfIWQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:08:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so9409554pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2BxhOdJYXJi532SmentxbXVQYJErTKd5nVs++YvZFCU=;
        b=FuJY65Uccx36X3yZKLYnu5YgoLkoKPHdaCgcxI4S3TLOblQObylYTyM2jj+nF8rT0/
         wKwhN0mJ0QORonekDL+A+pYZXSlNOkrbFoETnBLYUZyi4+4YqHR0H/JyPGKIFmZ7b/6Z
         nyeYgnu9EVky+iLmTg6GeRPSw4Ae7h36sN/IwIrqlxo0MgqJvpQOjHKuyb6Xqdk90hLd
         qcSiDIRuvQ5VCzh4PBcdrNCFPZATaeszoier7rCXg1QcPnyExYfodq1GSToljEwJ9vZg
         q0YTKL3e/eTPv1ZMvAhgWVHC9NaoNFKYsivR48KdZiNbGMbznV2txAnDg6FxMYZIin4T
         T/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2BxhOdJYXJi532SmentxbXVQYJErTKd5nVs++YvZFCU=;
        b=DKjPSNxxseJTT26q0pTVcGNe3Yk2/Gdw9M6sAWSeKhPRbX3gqg4ws7Onf+CJ2kE6kg
         /WladwCiHJ45sVPQMm8stOZeUUH9QIhghI373mfMtoSqQwpiPte8dzYblAciSqIShA3q
         87Rh2CbHyQ3HNmC+g7ItpRwSyh8ofLVZETx24vkTBde5dzeR7V/GIexTBLUOAsZ9EZhz
         PHY//mNGUXJHO+i6lhBP8N4hIAUGcOyQbcXSdo//1KkytgsMiryAYJAvkmZDguE08qlT
         A47j05KRTgZFs1frHuiMmB5HzanbPyNjJR/Hxc+cWWh4aJKGaWuYQsbMFcTrYJ8Yb+jQ
         p6rQ==
X-Gm-Message-State: APjAAAVBxHpAjr6jcNsIHvg/LqdnYZUxjkXrccdPzdgfXIAyItgC2W/8
        ksMAUGcZPA8WwsNe1oPL30LKDA==
X-Google-Smtp-Source: APXvYqw6T/7IjKrKVaAajLeADPD6VoGJqijdG5Z3NMpXxdMrCV8teoH5N4iSVsr2pq+grVHMPX0jOw==
X-Received: by 2002:a63:1d02:: with SMTP id d2mr708391pgd.190.1569254893704;
        Mon, 23 Sep 2019 09:08:13 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
        by smtp.gmail.com with ESMTPSA id r1sm9880006pgv.70.2019.09.23.09.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 09:08:13 -0700 (PDT)
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
Subject: [PATCH v2 2/5] perf cs-etm: Support thread stack
Date:   Tue, 24 Sep 2019 00:07:56 +0800
Message-Id: <20190923160759.14866-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923160759.14866-1-leo.yan@linaro.org>
References: <20190923160759.14866-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm CoreSight doesn't support thread stack, thus the decoding cannot
display the symbol with indented spaces to reflect the stack depth.

This patch adds support thread stack, this allows 'perf script' to
support option '-F,+callindent'.

Before:

  # perf script -F,+callindent
            main  2808          1          branches: coresight_test1                      ffff8634f5c8 coresight_test1+0x3c (/root/coresight_test/libcstest.so)
            main  2808          1          branches: printf@plt                           aaaaba8d37ec main+0x28 (/root/coresight_test/main)
            main  2808          1          branches: printf@plt                           aaaaba8d36bc printf@plt+0xc (/root/coresight_test/main)
            main  2808          1          branches: _init                                aaaaba8d3650 _init+0x30 (/root/coresight_test/main)
            main  2808          1          branches: _dl_fixup                            ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches: _dl_lookup_symbol_x                  ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
  [...]

After:

  # perf script -F,+callindent
            main  2808          1          branches:                 coresight_test1                                      ffff8634f5c8 coresight_test1+0x3c (/root/coresight_test/libcstest.so)
            main  2808          1          branches:                 printf@plt                                           aaaaba8d37ec main+0x28 (/root/coresight_test/main)
            main  2808          1          branches:                     printf@plt                                       aaaaba8d36bc printf@plt+0xc (/root/coresight_test/main)
            main  2808          1          branches:                     _init                                            aaaaba8d3650 _init+0x30 (/root/coresight_test/main)
            main  2808          1          branches:                     _dl_fixup                                        ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                         _dl_lookup_symbol_x                          ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1de3f9361193..6bdc9cd8293c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1116,6 +1116,45 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
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
+	if (etm->synth_opts.thread_stack) {
+		from_ip = cs_etm__last_executed_instr(tidq->prev_packet);
+		to_ip = cs_etm__first_executed_instr(tidq->packet);
+
+		insn_len = cs_etm__instr_size(etmq, trace_chan_id,
+					      tidq->prev_packet->isa, from_ip);
+
+		/*
+		 * Create thread stacks by keeping track of calls and returns;
+		 * any call pushes thread stack, return pops the stack, and
+		 * flush stack when the trace is discontinuous.
+		 */
+		thread_stack__event(tidq->thread, tidq->prev_packet->cpu,
+				    tidq->prev_packet->flags,
+				    from_ip, to_ip, insn_len,
+				    etmq->buffer->buffer_nr);
+	} else {
+		/*
+		 * The thread stack can be output via thread_stack__process();
+		 * thus the detailed information about paired calls and returns
+		 * will be facilitated by Python script for the db-export.
+		 *
+		 * Need to set trace buffer number and flush thread stack if the
+		 * trace buffer number has been alternate.
+		 */
+		thread_stack__set_trace_nr(tidq->thread,
+					   tidq->prev_packet->cpu,
+					   etmq->buffer->buffer_nr);
+	}
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
@@ -1392,6 +1431,9 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		tidq->period_instructions = instrs_over;
 	}
 
+	if (tidq->prev_packet->last_instr_taken_branch)
+		cs_etm__add_stack_event(etmq, tidq);
+
 	if (etm->sample_branches) {
 		bool generate_sample = false;
 
@@ -2592,6 +2634,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		itrace_synth_opts__set_default(&etm->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
 		etm->synth_opts.callchain = false;
+		etm->synth_opts.thread_stack =
+				session->itrace_synth_opts->thread_stack;
 	}
 
 	err = cs_etm__synth_events(etm, session);
-- 
2.17.1

