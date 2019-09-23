Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EADAC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C71620882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FSOY9rC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbfIWQIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:08:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34513 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387969AbfIWQIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:08:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so9415564pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qbgL52JbC3nZvOpwtMEyx7CsWNJZAh5SrAdnx2jzAo8=;
        b=FSOY9rC3vU5FztGsRFEwH7V4vSC9FJwLCLLrXOgsTUDaEwnAmpuq8BbixzXG2ShMOL
         6lLd0syInfmXdqh3Al2QF+TUN79k3rBRUqlhtoX+TSudrnCbPz/q5/W2p5ygqb5kOQhl
         CnUXmSZFkMcg+WAj3b1AFeDWZ6VA5jzu6MW/OwI58N93JXE4xidealql1q8NAYKm6H38
         tUwoNg8zLOr1KT09n5HsSneDQYjLwHoKbwCeHrDbG+J2ibdHNqDaDUTkFSoJWBfWD16c
         +yZQ1VB6Y0h7yY85Pe7mLUYfXy/Q370DvImDh7J1Vb9oh0oN1B8jdJO+sngnP1GgpSbC
         RyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qbgL52JbC3nZvOpwtMEyx7CsWNJZAh5SrAdnx2jzAo8=;
        b=lk+ychHVC/KG5qXTOZ4MhbKilCBwpL/uWQiChkFjnP6sEBFATIi95hR/qbLiPwVws7
         xbEEErFmAjxbttBDkgpzU5ZdBqbhIvOmsoyyYdAxbJjU3v4+tT/uFbM75bOynM6KwCSG
         g/w7HcHbXT69vXLwhT2pNnpvDjqMT+6OJZvqDBpXTIxXn2Tl/HBZu/SuYnDbJZIMa+0B
         Q/+ZCuIABAua9V66DuZb7OrXekZZpr0Ri4GEOsPh4DrUFF0pkbIOEEzTDFTAJuapZYt8
         2NE2Bp8Zr7nO6ldFJGckP68ZlZMAOu6oBvYcATdqw0uxUd+jav5m3akyDB25AbPHEIBv
         LBwQ==
X-Gm-Message-State: APjAAAVMUx9RytSkptYEOIFiQWK1xBAKgfcx+Lf11Ot1RoKotLTCHJpE
        aBtlV/4Meo+S1PdM0zCsMQWaqg==
X-Google-Smtp-Source: APXvYqybSHGIhV3dLeByo9yn27L1VeNLtWPNru/lozTdZ/6Wmi0V0CdmHJwmlZZT4kwUekU6QL4cIw==
X-Received: by 2002:a62:4e09:: with SMTP id c9mr373088pfb.152.1569254899217;
        Mon, 23 Sep 2019 09:08:19 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
        by smtp.gmail.com with ESMTPSA id r1sm9880006pgv.70.2019.09.23.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 09:08:18 -0700 (PDT)
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
Subject: [PATCH v2 5/5] perf cs-etm: Correct callchain for instruction sample
Date:   Tue, 24 Sep 2019 00:07:59 +0800
Message-Id: <20190923160759.14866-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923160759.14866-1-leo.yan@linaro.org>
References: <20190923160759.14866-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synthesized flow use 'tidq->packet' for instruction samples,
comparing against the thread stack and the branch samples which are uses
the 'tidp->prev_packet', thus the instruction samples result in using an
packet ahead than thread stack and branch samples.

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
function info, and so forth.  But the first two lines:

  perf_event_update_userpage+0x4c  => the sampled instruction
  perf_event_update_userpage+0x48  => the parent function's calling

The child function and parent function both are the same function
perf_event_update_userpage(), but this isn't a recursive function, thus
the sequence for perf_event_update_userpage() calling itself shouldn't
never happen.  This callchain error is caused by the instruction sample
using an ahead packet than the thread stack, the thread stack is deferred
to process this packet and missed to pop stack if this is a return
packet.

To fix this issue, we can simply change to use 'tidq->prev_packet' to
generate the instruction samples, this allows the thread stack to push
and pop synchronously with instruction sample.  Finally, the callchain
is displayed as below:

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
index bd09254a7208..3f7edfd15124 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1418,7 +1418,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	struct cs_etm_packet *tmp;
 	int ret;
 	u8 trace_chan_id = tidq->trace_chan_id;
-	u64 instrs_executed = tidq->packet->instr_count;
+	u64 instrs_executed = tidq->prev_packet->instr_count;
 
 	tidq->period_instructions += instrs_executed;
 
@@ -1449,7 +1449,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 */
 		u64 offset = (instrs_executed - instrs_over - 1);
 		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
-					      tidq->packet, offset);
+					      tidq->prev_packet, offset);
 
 		ret = cs_etm__synth_instruction_sample(
 			etmq, tidq, addr, etm->instructions_sample_period);
-- 
2.17.1

