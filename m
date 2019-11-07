Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61249C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C79218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153297;
	bh=mLv9srSdCScvSK+KObTSW8M2mnct2ipluEZmZHHVwpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kvOKW73ObQanAIHFPRZotbarpFWSHvDEzawtkNA2ih6xXr2GURTjteESy4+JcQeNp
	 MqsBFO9yBRQF285NtEzc6H9/qtq0MD7aUvJD+Bf+Luw+WSJkW2Vh7iON+dZZ4FV216
	 AyREtxUMx56wPQWvzZB5Y0nK7J22KvoSaSbZLdUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfKGTBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfKGTBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:01:35 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46B5821882;
        Thu,  7 Nov 2019 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153294;
        bh=mLv9srSdCScvSK+KObTSW8M2mnct2ipluEZmZHHVwpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DP0hI2tG8tarJZYhxakyNh6eIUS8hLP86qHzkV4XQ5jN3qYsuvj0ktVNl3buzQ03H
         39S1qnMNQ0bnzOCj3RC1I1gN5lCnO35Jo/wb71dWnwSV5jL1/dvmxns74SeFFBGUZ7
         WCztfe0a/EUeY0nb8BMMvaTgqYeChAwQzAhK/X38=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight ml <coresight@lists.linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/63] perf cs-etm: Fix definition of macro TO_CS_QUEUE_NR
Date:   Thu,  7 Nov 2019 15:59:16 -0300
Message-Id: <20191107190011.23924-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Macro TO_CS_QUEUE_NR definition has a typo, which uses 'trace_id_chan'
as its parameter, this doesn't match with its definition body which uses
'trace_chan_id'.  So renames the parameter to 'trace_chan_id'.

It's luck to have a local variable 'trace_chan_id' in the function
cs_etm__setup_queue(), even we wrongly define the macro TO_CS_QUEUE_NR,
the local variable 'trace_chan_id' is used rather than the macro's
parameter 'trace_id_chan'; so the compiler doesn't complain for this
before.

After renaming the parameter, it leads to a compiling error due
cs_etm__setup_queue() has no variable 'trace_id_chan'.  This patch uses
the variable 'trace_chan_id' for the macro so that fixes the compiling
error.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lore.kernel.org/lkml/20191021074808.25795-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4ba0f871f086..f5f855fff412 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -110,7 +110,7 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
  * encode the etm queue number as the upper 16 bit and the channel as
  * the lower 16 bit.
  */
-#define TO_CS_QUEUE_NR(queue_nr, trace_id_chan)	\
+#define TO_CS_QUEUE_NR(queue_nr, trace_chan_id)	\
 		      (queue_nr << 16 | trace_chan_id)
 #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
 #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
@@ -819,7 +819,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	 * Note that packets decoded above are still in the traceID's packet
 	 * queue and will be processed in cs_etm__process_queues().
 	 */
-	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_id_chan);
+	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
 	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
 out:
 	return ret;
-- 
2.21.0

