Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D848C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B1020835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iuoaK4s3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbfIWQIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:08:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46137 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387819AbfIWQIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:08:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so8224772pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PTSvUaUcz4xj5MLSxSCaFDMyStE9w7Ne+2lkvbOJnZc=;
        b=iuoaK4s3jA9qx5hTsEJ8UFFw44uPYfMk/d78HxnJHP/HCH8BHehsUezXIaOoWyuLGD
         m1LjGTOKOcFyhs640Cx3260rEuQwrXfsUPxak7Q+SX1xCWIn4YvI2gaWdt/svmbiqEbI
         1Lo2bwde76R1s6P2jv7SFBrSsKwHjWFcz6qfEP7tPj2u42shRsYTFePN1bYIJMPrwHzI
         QuVCEABL/4di0uIuJlLvgnfXp/69OMqj0de4ztKYR6YODPOo/zKzPiYGe7qBNLlT1Mqn
         qNim+dVhvYu+lY5vwg4XKRIduCHPedYyaeGu+I7Z2hHwHFxh8ZH7ZXsCkVF83hgSiwGa
         1Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PTSvUaUcz4xj5MLSxSCaFDMyStE9w7Ne+2lkvbOJnZc=;
        b=s4QhyUPy4yKfU0PD1ZhV8MxDEA3Hz4cOfUsAmyLWavjyOk4D2gqde+4vpDg02JHWic
         kJP67GIIPMZ8qayxioflBceJpNyVhdQUSu/XQKGiI+ysA+yxCY2r9Ob0SHN/SfQpNFii
         nMno+81Otk8qs7upzhbNeO83hsNUWPEoVlFBO5pDcS88l7p0PNgFMNjzIQhREp4W1U5R
         nUqYu84sa8eg/b9XXHmhwdtCoIjXmwStO74rUK5ePPZ+0+ag6TLwANjQ3wqprqixU7Q9
         gZmMszEB5scQCsqXkh+slVvv96YpMbMde/rtO//yqnyLV/PRAAWjMG59bCpA7iB39ze5
         ztLw==
X-Gm-Message-State: APjAAAVpidSHuBUPaEgNlis70L9zc7u190TFl1Vv4ytbSvmO+X2D3IfO
        iamDUbMhUb346QeYnzIthAMdRA==
X-Google-Smtp-Source: APXvYqzR/rWOqsp0ZVjpUnk9SDs/SXltXYRViavE2rZoOppr4DQZ84RBCTAu/gdcYH5fcb+4HBNhjQ==
X-Received: by 2002:a62:1cd2:: with SMTP id c201mr335248pfc.51.1569254892370;
        Mon, 23 Sep 2019 09:08:12 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
        by smtp.gmail.com with ESMTPSA id r1sm9880006pgv.70.2019.09.23.09.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 09:08:11 -0700 (PDT)
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
Subject: [PATCH v2 1/5] perf cs-etm: Refactor instruction size handling
Date:   Tue, 24 Sep 2019 00:07:55 +0800
Message-Id: <20190923160759.14866-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923160759.14866-1-leo.yan@linaro.org>
References: <20190923160759.14866-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cs-etm.c there have several functions need to know instruction size
based on address, e.g. cs_etm__instr_addr() and cs_etm__copy_insn()
these two functions both calculate the instruction size separately.
Furthermore, if we consider to add new features later which also might
require to calculate instruction size.

For this reason, this patch refactors the code to introduce a new
function cs_etm__instr_size(), it will be a central place to calculate
the instruction size based on ISA type and instruction address.

For a neat implementation, cs_etm__instr_addr() will always execute the
loop without checking ISA type, this allows cs_etm__instr_size() and
cs_etm__instr_addr() have no any duplicate code with each other and both
functions can be changed independently later without breaking anything.
As a side effect, cs_etm__instr_addr() will do a few more iterations for
A32/A64 instructions, this would be fine if consider perf tool runs in
the user space.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 48 +++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f87b9c1c9f9a..1de3f9361193 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -917,6 +917,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 	return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
 }
 
+static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
+				     u8 trace_chan_id,
+				     enum cs_etm_isa isa,
+				     u64 addr)
+{
+	int insn_len;
+
+	/*
+	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
+	 * cs_etm__t32_instr_size().
+	 */
+	if (isa == CS_ETM_ISA_T32)
+		insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id, addr);
+	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
+	else
+		insn_len = 4;
+
+	return insn_len;
+}
+
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
 {
 	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
@@ -941,19 +961,15 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 				     const struct cs_etm_packet *packet,
 				     u64 offset)
 {
-	if (packet->isa == CS_ETM_ISA_T32) {
-		u64 addr = packet->start_addr;
+	u64 addr = packet->start_addr;
 
-		while (offset > 0) {
-			addr += cs_etm__t32_instr_size(etmq,
-						       trace_chan_id, addr);
-			offset--;
-		}
-		return addr;
+	while (offset > 0) {
+		addr += cs_etm__instr_size(etmq, trace_chan_id,
+					   packet->isa, addr);
+		offset--;
 	}
 
-	/* Assume a 4 byte instruction size (A32/A64) */
-	return packet->start_addr + offset * 4;
+	return addr;
 }
 
 static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
@@ -1093,16 +1109,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 		return;
 	}
 
-	/*
-	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
-	 * cs_etm__t32_instr_size().
-	 */
-	if (packet->isa == CS_ETM_ISA_T32)
-		sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
-							  sample->ip);
-	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
-	else
-		sample->insn_len = 4;
+	sample->insn_len = cs_etm__instr_size(etmq, trace_chan_id,
+					      packet->isa, sample->ip);
 
 	cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
 			   sample->insn_len, (void *)sample->insn);
-- 
2.17.1

