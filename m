Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6EEC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D186D22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anOoup8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfH3GZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:25:00 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39068 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfH3GZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:25:00 -0400
Received: by mail-yb1-f196.google.com with SMTP id s142so2084995ybc.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 23:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LW/cyVok2Jx1Gl00HhV8gtiT8RMfRuMvrAfcIARqkHQ=;
        b=anOoup8NEzR708g9QLZe0LlLW1dHoyJlaY4aiva0hYfwdnh/25lhlp6WWCRuVqfDDK
         dJrpirug7Wvl1oNUStKASkVBltOaFvN/8PjGmFx3GMU9ptP/VgRaS673M+3oQyKJZ9g/
         XiG5ZQYvUkV4JsYMChF0y+xq0opTxWZI7lTtP7A8X0jXlG7ymholngnzlPFOc/WIm4D4
         0O63FdN51BBL4rrEewu4y0ErkJ7aSiT/YCl0a68k2bDep7HyagVbrQbPJ7ANfulPycqR
         1fANyvSx1HcIUW4qUqrJrCLufB1EXHolBJ04sAfeSq/+baTPSIxL+C1JlPkZevF1lXkh
         N1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LW/cyVok2Jx1Gl00HhV8gtiT8RMfRuMvrAfcIARqkHQ=;
        b=efvkJOTlPwo9G9n0d/pnbKPSkFa7vo0cGJ+UZGFNcxvfhMOTK4Gi5gFWzq62ToiUBL
         tMDsDbZEZwaCIKJFRPSxQbEPPF0fm4XTYEbuEiCxwyalYptcMUKaCLJqjFwzKbh99puu
         y4V7n3o6PbQV2gNfo1V5nkqXTRq8Ks7t+5zQIck3ab/wj+TwdN3BIt4CEGiVN91Gmgzq
         0fZcO6EBPbEvP0rWiyJHJfy5P8yHhVrvi9uAsq/FnDGG8UHLYpwYK9toOA4tFkuV5vRC
         daXsYN7tSwb9PLHTrA3mAGcADTjnV0vZGiAOi4L6KsSPk24wlvzU8ZNzF0/E/C0HrLZ0
         xydQ==
X-Gm-Message-State: APjAAAUZZykWbxmvWQo3XJ+/HkU+1lX2eef0TbXo8oUQWUvtAHqU+frm
        OW1Xx4HszRH2uUi3lwiyRVUr+A==
X-Google-Smtp-Source: APXvYqzXKOQ8vLvXYqgVCKUbIIGXmIs/9n9gYZH3CWl6SicBE7b7FoFlpIMNY4eBB8SbvaOW52BQhg==
X-Received: by 2002:a25:2f85:: with SMTP id v127mr9400791ybv.95.1567146299428;
        Thu, 29 Aug 2019 23:24:59 -0700 (PDT)
Received: from localhost.localdomain (li1320-244.members.linode.com. [45.79.221.244])
        by smtp.gmail.com with ESMTPSA id r193sm976784ywe.8.2019.08.29.23.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 23:24:58 -0700 (PDT)
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
Subject: [PATCH v1 3/3] perf cs-etm: Correct the packet usage for instruction sample
Date:   Fri, 30 Aug 2019 14:24:21 +0800
Message-Id: <20190830062421.31275-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830062421.31275-1-leo.yan@linaro.org>
References: <20190830062421.31275-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It uses 'tidq->packet' rather than 'tidq->prev_packet' to generate
instruction sample, comparing against the thread stack and the branch
samples which are using the 'tidp->prev_packet', thus this leads the
instruction sample to use one ahead packet than thread stack and branch
samples.

As result, the instruction's call chain can be wrongly displayed as
below:

  main  1579        100      instructions:
  	ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
  	ffff000010214850 perf_event_update_userpage+0x48 ([kernel.kallsyms])
  	ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
  	ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
  	ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
  	ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
  	ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

In this log, the continuous two lines includes two functions, the up
line contains the child function info and the bottom line contains
its parent function, and so forth.  But if review the first two lines:

  perf_event_update_userpage+0x4c  => the sampled instruction
  perf_event_update_userpage+0x48  => the parent function's calling

The child function and parent function is the same function
perf_event_update_userpage(), but perf_event_update_userpage() isn't
a recursive function, thus this calling sequence shouldn't never happen.
This is caused by the instruction sample using the 'tidq->packet', but
this packet is not handled yet by thread stack, the thread stack is
delayed to handle one return packet for stack popping.

To fix this issue, we can simply to use 'tidq->prev_packet' to generate
the instruction sample, this allows the thread stack to push/pop
properly for instruction sample.  Finally, we can get below result:

  main  1579        100      instructions:
	ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
	ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
	ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
	ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
	ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
	ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ad573d3bd305..0bd2b3c48394 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1414,7 +1414,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	struct cs_etm_packet *tmp;
 	int ret;
 	u8 trace_chan_id = tidq->trace_chan_id;
-	u64 instrs_executed = tidq->packet->instr_count;
+	u64 instrs_executed = tidq->prev_packet->instr_count;
 
 	tidq->period_instructions += instrs_executed;
 
@@ -1445,7 +1445,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 */
 		u64 offset = (instrs_executed - instrs_over - 1);
 		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
-					      tidq->packet, offset);
+					      tidq->prev_packet, offset);
 
 		ret = cs_etm__synth_instruction_sample(
 			etmq, tidq, addr, etm->instructions_sample_period);
-- 
2.17.1

