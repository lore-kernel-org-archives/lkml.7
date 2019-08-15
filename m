Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4B9C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312A02084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4+0ImEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfHOIaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:30:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37347 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbfHOIaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:30:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1so424398pgp.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 01:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+667Tp6aRb+fNZrEkEuQBATyuYVr9DkCsoqrznJa5gI=;
        b=E4+0ImEEmPUTDK4fbSUSMUuBr6/4JC/FSu2THIDBKuiY0uw4dfY0PcLLac2NKV4fdL
         Lu1s/lkKD6MbnYfJbTSSjBaxItiA+hRYtey95pRKPsZFxiDVxCF+8bajbx72J0ES0vBX
         pw2uYBoIHgnFvVUqdEeY+QSlr0JVcAWvI0ZUCVn5QLLkqpMUIu0b0qmLyTkVxEgnKLNs
         5n1am8WziPrOPbM3o96E1pU2e62cCZawGs89rgQNOoSHQi3RHy5j6Nn1ZLXeSZQGMgw9
         n7VCHaPMlt545E535ERJLwEchIyLatWHMEwcKBg9P6MYEwMGt073PlwjDm5xDeuIKQCz
         4DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+667Tp6aRb+fNZrEkEuQBATyuYVr9DkCsoqrznJa5gI=;
        b=OtDqfKK+XLE4q52PFH6YjhvVKT1C6GacM4uXI1zrWkHJowV+JMvuYYYfwBj4huXX2G
         T7nq4gnAIQjdaREMg/gxKHxh3ZEnScSTrEnB1jlDS03YZYKKFeSgqs7T8eNPtcKioc7M
         vAy3d9nDa8FTQwdRxuf8B1h9OoR9f+yRNrcBQKZGWRENnRgGex0RUp1EsJyyTmDD3Crq
         LHRBFAEEf2zUohwTSjWOze8TSr5G7HTZS0armnkDAxYsROFhEOcOdTvU4FfV4MdZijq5
         JrfctRKHgvoGAzPWMQIWnbX68Qdj90JtFgPN9obtYelckiHCstjzY7L+GsEnFDYKsN66
         6jGg==
X-Gm-Message-State: APjAAAWWSUi+LBAv+Uroj9Wf2gji1bBLxmtNrBU3MJ82oFIN6++qdYMe
        zIMy8j+p18dVcYTxcb8br4br7A==
X-Google-Smtp-Source: APXvYqwEan4dWW0vagWBHt1IU/UkTTnvsCHImQm26AyFYF184BYwU6WZnfEB7b72g23UQobubOoXHA==
X-Received: by 2002:a65:690f:: with SMTP id s15mr2562324pgq.432.1565857819808;
        Thu, 15 Aug 2019 01:30:19 -0700 (PDT)
Received: from localhost.localdomain (li456-16.members.linode.com. [50.116.10.16])
        by smtp.gmail.com with ESMTPSA id 1sm2217413pfx.56.2019.08.15.01.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 01:30:19 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        coresight@lists.linaro.org
Subject: [PATCH 1/2] perf cs-etm: Support sample flags 'insn' and 'insnlen'
Date:   Thu, 15 Aug 2019 16:28:54 +0800
Message-Id: <20190815082854.18191-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synthetic branch and instruction samples are missed to set
instruction related info, thus perf tool fails to display samples with
flags '-F,+insn,+insnlen'.

CoreSight trace decoder has provided sufficient information to decide
the instruction size based on the isa type: A64/A32 instruction are
32-bit size, but one exception is the T32 instruction size, which might
be 32-bit or 16-bit.

This patch handles for these cases and it reads the instruction values
from DSO file; thus can support flags '-F,+insn,+insnlen'.

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

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Leo Yan <leo.yan@linaro.org>
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
2.17.1

