Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950A5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685A420679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSwpr/P5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409669AbfJXPPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:15:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40599 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409659AbfJXPP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:15:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id o49so30540345qta.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+8OeCtlRuFQGQZkXW2FoUzBMjUDZlZhy5R5fOMQGeQ=;
        b=PSwpr/P52oXDPu2DuTOP4dcsZcERIOhjHhdwDQRNfFRrpF9TIL5cZxYpBlX/M4zdD9
         jccri2mOi3BLErYUJevgdsA74Ah0X2U1frueLyhrrZabUK9phjly8F7t+pIjD8qcJmGF
         r/8MuRsNVFxl1KfFSZI0HltGPoDsxO5xYzBk86XXz1xKEM/Qtg5Wm+sfGO0/f2ZsbfND
         D6YmUNYR9E2kolYMEcOddXAhqesSb0Fej+dqgdPaR/7ytC2+bjyTM6PAfaxaRbtOqnaP
         VeXJ7ztGmGd3lVaIMe58/MGoiQqJtukk+kgriL/7A8vhUVkkM75AAg7ZB6WGcaV4MKjP
         nZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2+8OeCtlRuFQGQZkXW2FoUzBMjUDZlZhy5R5fOMQGeQ=;
        b=b8Liss4gN8TwQdsv6SAAQlu+xXZaB6azatmsBcT68HDeUZG7iBwtGnJX8/1sLiCYgn
         wCJ4HqvnoewCcEEAZ5X2offbJ91/Zuc/f691BPu4Cw1DrKPUjVpnI/IkpVsoseeOphHt
         yQrNbsbV+aqZdaoeYyryOqXjb71cozzQy3uMzvF2n5ZIL6NfMpeyaNSSISMuGiPVV3Po
         aYVSDFKSiOdPNr2Lbq06WYpcD0rqpC022G27MQG0tBqzE8OdL4kqqmcxLBw3fpXubpFY
         vwiVsMn1Z0gouhWg2wXyklRIkoteiT7oCocaVJ6e9pjymCnL3liz4zUmm9gZGk346PUS
         u+FA==
X-Gm-Message-State: APjAAAUW3qGfriFj7DYimL/LTbgCOrsFF474omn8puu8oA8/rUBTqZyj
        hsyob6olB+hEK7TC+u5Zn9rROA==
X-Google-Smtp-Source: APXvYqwQ6KBz4sS0PRZ22lkCUee3uDjw8e66CKmbsWmea6h8xYNFQE8bF2jhT1Ce/ZksIWxqDZgHrA==
X-Received: by 2002:ac8:5343:: with SMTP id d3mr4659044qto.157.1571930126807;
        Thu, 24 Oct 2019 08:15:26 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id l5sm4346073qtj.52.2019.10.24.08.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:15:26 -0700 (PDT)
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
        Coresight ML <coresight@lists.linaro.org>,
        Robert Walker <robert.walker@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/4] perf cs-etm: Optimize copying last branches
Date:   Thu, 24 Oct 2019 23:13:24 +0800
Message-Id: <20191024151325.28623-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024151325.28623-1-leo.yan@linaro.org>
References: <20191024151325.28623-1-leo.yan@linaro.org>
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

