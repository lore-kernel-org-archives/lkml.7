Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F06C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C032E2133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOZAQaCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfJEJRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 05:17:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43081 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 05:17:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so8143467qke.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MASENXtjvjrGt9RAiM0XMBiZxBBH7YBJCk7GCr7TS68=;
        b=BOZAQaCtY3VPwH+2WpEjt6kSfv/nQ8w6QKgJreO5w8ha6Xch0n3Gz1CSS4U+u65pnF
         qjwyPDVvQd5HttZYsi6omNZiaPcmbInsUs9rDSDwQeDwKbbBAM547VNDrnk+HRFifbRI
         k2idWM85mMwtcLNM/GiWrYbEstXYFyFTGBIp7IPWVnyz2ItuUZdsWfftzgAolt81wQiV
         /zJq4O79Y7ezXfnqwNAG0SHpsI3FvqEh65vnZkG9GRW3B+o2zgFyNJRMKZo7k3Oz1YmV
         KwCc55v63Likpj+nSVG2NPQJmbDLO1HRr1afjRQnfKieML/oAJXkHTjNZOgwuM+5snrV
         UYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MASENXtjvjrGt9RAiM0XMBiZxBBH7YBJCk7GCr7TS68=;
        b=X95iZvpuoF3cx+Qdlg6JPGhlhNYWZe6aUeu+MHvbnogaxqYWs2WvVPdFEp7ReOFtwI
         y+6jF+P3SiIzJJtx+ri6KaksupOwNs0zIg8yHnpiDjyYBRoeLDbx9a88drfLhH3B/2ae
         RazyKgBUTFWL6w17WsGZIobwq1lzTJuF9yrTlVLN0DraETPVMRMzT0I7NEKfoec2mFQc
         AUvDJys9Bf+WQ2PF6Hs369wXe4OZ0/+A/q3ynwHHl9TgbyyceU4BXejKSVofk5d6wFYl
         8Fal3dYX37dsl+Yg1fOhHEmwr6bnWI4eKzg+T6V0d3YF9yVKkVopR1fXwh0PdcPN3bD1
         jyHg==
X-Gm-Message-State: APjAAAVG4cRpjhl39lM0LZBQS1gwiFnIHPCIMIzjpZuk5utF4YfPUPVx
        wpOILeX1vET+l3mPRh2oRjKZug==
X-Google-Smtp-Source: APXvYqxaCS/RWXRAQ/pUsBVqO66Nz19/Jb4pys6tEihT2HU84dD8DBm86OXU3GYgMtiY+FG+zbI12Q==
X-Received: by 2002:a37:4e48:: with SMTP id c69mr14232654qkb.182.1570267028692;
        Sat, 05 Oct 2019 02:17:08 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id u132sm4384621qka.50.2019.10.05.02.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 02:17:08 -0700 (PDT)
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
Subject: [PATCH v3 6/6] perf cs-etm: Synchronize instruction sample with the thread stack
Date:   Sat,  5 Oct 2019 17:16:14 +0800
Message-Id: <20191005091614.11635-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191005091614.11635-1-leo.yan@linaro.org>
References: <20191005091614.11635-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synthesized flow use 'tidq->packet' for instruction samples; on the
other hand, 'tidp->prev_packet' is used to generate the thread stack and
the branch samples, this results in the instruction samples using one
packet ahead than thread stack and branch samples ('tidp->prev_packet'
vs 'tidq->packet').

This leads to an instruction's callchain error as shows in below
example:

  main  1579        100      instructions:
  	ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
  	ffff000010214850 perf_event_update_userpage+0x48 ([kernel.kallsyms])
  	ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
  	ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
  	ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
  	ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
  	ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])

In the callchain log, for the two continuous lines the up line contains
one child function info and the followed line contains the caller
function info, and so forth.  So the first two lines are:

  perf_event_update_userpage+0x4c  => the sampled instruction
  perf_event_update_userpage+0x48  => the parent function's calling

The child function and parent function both are the same function
perf_event_update_userpage(), but this isn't a recursive function, thus
the sequence for perf_event_update_userpage() calling itself shouldn't
never happen.  This callchain error is caused by the instruction sample
using an ahead packet than the thread stack, the thread stack is deferred
to process the new packet and misses to pop stack if it is just a return
packet.

To fix this issue, we can simply change to use 'tidq->prev_packet' to
generate the instruction samples, this allows the thread stack to push
and pop synchronously with instruction sample.  Finally, the callchain
can be displayed correctly as below:

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
index 56e501cd2f5f..fa969dcb45d2 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1419,7 +1419,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	struct cs_etm_packet *tmp;
 	int ret;
 	u8 trace_chan_id = tidq->trace_chan_id;
-	u64 instrs_executed = tidq->packet->instr_count;
+	u64 instrs_executed = tidq->prev_packet->instr_count;
 
 	tidq->period_instructions += instrs_executed;
 
@@ -1450,7 +1450,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 */
 		s64 offset = (instrs_executed - instrs_over - 1);
 		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
-					      tidq->packet, offset);
+					      tidq->prev_packet, offset);
 
 		ret = cs_etm__synth_instruction_sample(
 			etmq, tidq, addr, etm->instructions_sample_period);
-- 
2.17.1

