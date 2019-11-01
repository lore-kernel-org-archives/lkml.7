Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92597CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65236216F4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJOHhfl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfKACIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:08:23 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33232 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKACIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:08:22 -0400
Received: by mail-yw1-f66.google.com with SMTP id v5so2991538ywd.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 19:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+8OeCtlRuFQGQZkXW2FoUzBMjUDZlZhy5R5fOMQGeQ=;
        b=AJOHhfl0StRhcUpCA5zJeo0P2IEvqTeNDulLlCaBFPK+ZAP8dVuthBje7eWoyabpjm
         SSyOsc4/telusudRFg7SxtO18Dx15vBSSGVrf6wWnueNcje2xiGzfdgYnz8IwJHU5j47
         WVOhVQTaO0dD7N7OPls4kqy73Ru6D+gidplMIDTPqGoy78UtifHtMaRjWPu3wrarGqLF
         SnBaDUA9Nr7OZ63yooGcuv+E82R3dJ0OA1b3vYMGOQ5NQqwrQsbCm4AyVqGTn1P/17K+
         DirLYY63HQxTeO4NBeBIEIAj48p2Obx9uqX1AKDjI3OBSTlx+D5m39Od+M2l8Jshf1wH
         gikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2+8OeCtlRuFQGQZkXW2FoUzBMjUDZlZhy5R5fOMQGeQ=;
        b=PP8JKo8MsLrsj7MO2j+Bx8XYfZRfpFLTPf4dfv6XI7/oQDYh9cEJzTQw7Axl5jMZsE
         rfNGAzknXYXMcIkptpxaMFUaYSYdmywgpa+zKi6RnUkUEbG9Ss6nbuzdgj2tomQ/McSB
         ZAnumslUFSK4ksm4HUvGpW0V+cBa2cY2F6dA45cpGbLJS0FTAW86zkH1JeiwV4OynNDE
         kHRQ2tuaHM5J96MsihPNq/3YNilV8DFMn8DkgZ/3U6qnriHa6CReBYwplKOzoC4v3eG3
         PnG/KKt93XRlCWAEvDU99Y/IcTtzIh/YJGcaSHzTE2wk8XkrQ3R8Ft/WFat8lymooZOp
         M5UA==
X-Gm-Message-State: APjAAAUnhYc5v6to6zh3bqw7iEHSsjtd0LKvPbycDJmdaEQYO59gHZTG
        6s4KId0Maf3dGsZAAUFRsCd6EsV9dXUVrg==
X-Google-Smtp-Source: APXvYqxr+2CnsBsN1sR73t20MPxyVjLtpzG4IRIafi6LdBQhXJDhuu2RNdO0qrhXyAvPGabGBVmIIg==
X-Received: by 2002:a0d:f1c2:: with SMTP id a185mr6531087ywf.298.1572574101361;
        Thu, 31 Oct 2019 19:08:21 -0700 (PDT)
Received: from localhost.localdomain (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id m5sm3762076ywj.27.2019.10.31.19.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 19:08:20 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Robert Walker <robert.walker@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/4] perf cs-etm: Optimize copying last branches
Date:   Fri,  1 Nov 2019 10:07:49 +0800
Message-Id: <20191101020750.29063-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101020750.29063-1-leo.yan@linaro.org>
References: <20191101020750.29063-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an instruction range packet can generate multiple instruction
samples, these samples share the same last branches; it's not necessary
to copy the same last branches repeatedly for these samples within the
same packet.

This patch moves out the last branches copying from function
cs_etm__synth_instruction_sample(), and execute it once prior to
generating instruction samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8e9eb7583bcd..d9a857abaca8 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1134,10 +1134,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
 	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
 
-	if (etm->synth_opts.last_branch) {
-		cs_etm__copy_last_branch_rb(etmq, tidq);
+	if (etm->synth_opts.last_branch)
 		sample.branch_stack = tidq->last_branch;
-	}
 
 	if (etm->synth_opts.inject) {
 		ret = cs_etm__inject_event(event, &sample,
@@ -1408,6 +1406,10 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 */
 		u64 instrs_over = instrs_executed;
 
+		/* Prepare last branches for instruction sample */
+		if (etm->synth_opts.last_branch)
+			cs_etm__copy_last_branch_rb(etmq, tidq);
+
 		/*
 		 * 'head' is the instructions number of the head in the new
 		 * packet, it combines with the tail of previous packet to
@@ -1526,6 +1528,11 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 
 	if (etmq->etm->synth_opts.last_branch &&
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
+		u64 addr;
+
+		/* Prepare last branches for instruction sample */
+		cs_etm__copy_last_branch_rb(etmq, tidq);
+
 		/*
 		 * Generate a last branch event for the branches left in the
 		 * circular buffer at the end of the trace.
@@ -1533,7 +1540,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 		 * Use the address of the end of the last reported execution
 		 * range
 		 */
-		u64 addr = cs_etm__last_executed_instr(tidq->prev_packet);
+		addr = cs_etm__last_executed_instr(tidq->prev_packet);
 
 		err = cs_etm__synth_instruction_sample(
 			etmq, tidq, addr,
@@ -1586,11 +1593,16 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
 	 */
 	if (etmq->etm->synth_opts.last_branch &&
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
+		u64 addr;
+
+		/* Prepare last branches for instruction sample */
+		cs_etm__copy_last_branch_rb(etmq, tidq);
+
 		/*
 		 * Use the address of the end of the last reported execution
 		 * range.
 		 */
-		u64 addr = cs_etm__last_executed_instr(tidq->prev_packet);
+		addr = cs_etm__last_executed_instr(tidq->prev_packet);
 
 		err = cs_etm__synth_instruction_sample(
 			etmq, tidq, addr,
-- 
2.17.1

