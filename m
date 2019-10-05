Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EACFC3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68B8222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDZr/IHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfJEJQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 05:16:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37381 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 05:16:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id l3so12198876qtr.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6oKadehOfuqvchi0MOdyWhMtht9hVnMfKkag850zFWI=;
        b=TDZr/IHUGHDNGMgaV72PWvAvVyveRW1J40XKwUGE+N8oYAHUd9mhkLlu09mVxBJI7s
         GqbPNcNj/bRMrczIfnEdBFl3ybYNtf4bIgaClwcgeUX4Rb+QHAk20D3cp9dfWcwRr4kG
         9D29taw93N0VDo+9tf5dkmzL+dwoq9dvXJFxUN/t/1uJo2zsTO7+CPGv7WbG03vos9Tk
         diUjMGTSVNEgULTFALrHjMVgz4+eBpTrb5jDNoE4AmMxZ0Ib4MuqucEfuuz0VvOlIic8
         PgBJApbTEMADIMHR4mf+dGQtoPkcNhb+uI20FhXYRF6+837HLdLIRfuxm4v6ybJ/39qh
         0Kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6oKadehOfuqvchi0MOdyWhMtht9hVnMfKkag850zFWI=;
        b=fzzIEeMLi+QUKyp+510Og0dyTo1pB/S1mHochaoNAIytT1OLSbEcm7Ycmg7jBqPdkF
         yENS8nwPDPgOcFxG5Fh+nnajjOGlufyUh5zeiYR10FuGTCX41CTKmloyQYfucDAZEABV
         aDF3IYFByj2PZStWOQUEwj47isEQffwVdXn4x+vBpaHEVCBRL7eitSjB23Hkk7kX7pil
         GwYGhZSOk83mjXMQR3VrkIitEOmhf/HHbLSlxfGKpcocQAqbeHQAFlMnalYY9nCHbJv+
         LFJklTNRYVPtjbiXLghKHeyd7TFcAKu8Wc+vXZvvX1H7HdsPUM468/Xx08/Q2ycOlgne
         knbw==
X-Gm-Message-State: APjAAAXC+6q0/8cGP01v9r55FYy4nQdYrp2vb49pKIPGIIhNBIszTRX/
        /GgHTSDCRCcuxorZzcAg4/YHAA==
X-Google-Smtp-Source: APXvYqwm5BY4l2NqSfENXb6KtiQLbeZX5B53V8Nw1aoIlItN4tedlMnC/dP000d3XY8Wl7GtAxXKPw==
X-Received: by 2002:aed:31c6:: with SMTP id 64mr20419643qth.67.1570267005805;
        Sat, 05 Oct 2019 02:16:45 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id u132sm4384621qka.50.2019.10.05.02.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 02:16:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/6] perf cs-etm: Refactor instruction size handling
Date:   Sat,  5 Oct 2019 17:16:10 +0800
Message-Id: <20191005091614.11635-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191005091614.11635-1-leo.yan@linaro.org>
References: <20191005091614.11635-1-leo.yan@linaro.org>
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
index 4bc2d9709d4f..58ceba7b91d5 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -918,6 +918,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
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
@@ -942,19 +962,15 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 				     const struct cs_etm_packet *packet,
 				     s64 offset)
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
@@ -1094,16 +1110,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
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

