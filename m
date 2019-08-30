Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6073CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310A42186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHEXZXd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfH3GYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:24:49 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45629 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfH3GYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:24:49 -0400
Received: by mail-yw1-f66.google.com with SMTP id n69so2008213ywd.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 23:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OXG5Krp0+0YHinlseDtdKmGPRzdmcPPxpIaorK0Sd/U=;
        b=YHEXZXd6sRfhS4BLjTBmyXis4Z3lNVzZFsvLaN6IeIVjVYDTmD4veeHZo7dGHtMe83
         pPMJfxluP/5bGXyNRyXc8H1hGniUvoDg3qZ4wSycHg6O4NplPwDCUfsLg/ZdyIOUEXfE
         GhmISYvHcc+pqp7h2e6WfUpV8hclsnlEeFlmQ0fGdiozLihG6lPt64bRmO3k+89jaW+Z
         pEbLeoR7wiM0U1IojVKnaQ3kZo6w3vnphGTEhHN8xT/QKOq6MxIfQyWtufypvpLBzgG/
         4UwrAcFrA6umJeFVNY1hqqdyJ1cfnKLPo3StT75wvOuXb4QnnWgfBe67FNwv4+Mp4gEY
         9wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OXG5Krp0+0YHinlseDtdKmGPRzdmcPPxpIaorK0Sd/U=;
        b=Lm7ONdxoe8sdvAtP+rnm4JYj6mZQFZQhg54arIaomV9SM8b1GUKl3WuFrDBqKI4xMN
         Hy2Bf28s+DJJfqoD4+tyPrhiRzQuYyfFueyuN+GQ+y6nhNiKRRlLMgVHY/NCYw1WaIWB
         N1SY6tobHuBcBIT7Px/fWmphibIVIYaaz4C9w+xKxK7I2IX1U2HFil+iJjs0WTaikHFA
         4BKGxPm87w7e2geRobUooswtYD93Vn3QHepGLXJQHhAA1InX6H1HggAu7l8B1s2xRvOV
         lAHZhdj53055CVJ8+CAPpsJ6YdNR0yDiaFIGAi+jYY0IFZ1SalFBHhs5Duc+QPVZQHqs
         Z+ng==
X-Gm-Message-State: APjAAAUjq6WhNE6Ibr5Ghgdk3wOfyu42CXINQOBD4U99RaJ74zLX6yIE
        cP3QQeZTEhCRC+NBYLMmjHeQ8A==
X-Google-Smtp-Source: APXvYqz67vqqy5rGYmWF/4BuddczksgMWXcyQXd0kAabISPC5eC7+OWMjXoeCtH6cBGH5sHTou3oCA==
X-Received: by 2002:a0d:dd51:: with SMTP id g78mr9844096ywe.102.1567146288582;
        Thu, 29 Aug 2019 23:24:48 -0700 (PDT)
Received: from localhost.localdomain (li1320-244.members.linode.com. [45.79.221.244])
        by smtp.gmail.com with ESMTPSA id r193sm976784ywe.8.2019.08.29.23.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 23:24:48 -0700 (PDT)
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
Subject: [PATCH v1 1/3] perf cs-etm: Refactor instruction size handling
Date:   Fri, 30 Aug 2019 14:24:19 +0800
Message-Id: <20190830062421.31275-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830062421.31275-1-leo.yan@linaro.org>
References: <20190830062421.31275-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has several code pieces need to know the instruction size, but
now every place calculates the instruction size separately.

This patch refactors to create a new function cs_etm__instr_size() as
a central place to analyze the instruction length based on ISA type
and instruction value.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 44 +++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b3a5daaf1a8f..882a0718033d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -914,6 +914,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
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
@@ -938,19 +958,23 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 				     const struct cs_etm_packet *packet,
 				     u64 offset)
 {
+	int insn_len;
+
 	if (packet->isa == CS_ETM_ISA_T32) {
 		u64 addr = packet->start_addr;
 
 		while (offset > 0) {
-			addr += cs_etm__t32_instr_size(etmq,
-						       trace_chan_id, addr);
+			addr += cs_etm__instr_size(etmq, trace_chan_id,
+						   packet->isa, addr);
 			offset--;
 		}
 		return addr;
 	}
 
-	/* Assume a 4 byte instruction size (A32/A64) */
-	return packet->start_addr + offset * 4;
+	/* Return instruction size for A32/A64 */
+	insn_len = cs_etm__instr_size(etmq, trace_chan_id,
+				      packet->isa, packet->start_addr);
+	return packet->start_addr + offset * insn_len;
 }
 
 static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
@@ -1090,16 +1114,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
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

