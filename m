Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F81C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773312087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556843189;
	bh=V6PvajlKKbO94N9tpD0LRZ4MKdSxlJ0h4zbL/CW1ovI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EvHF/b88Ksg9bvAECwPMUo14ZlnJ0oNNqHmzoChKtFCaKMwh0qUVV/HSldrPPjrvZ
	 RLHSdc5od+vAvqUMSPvMRGeusag8n+wzs0Ql3TxIvZFwtWvq+QYkkZV0DQlyQGGzn6
	 mNOh6d6XWVXV2A/2Cda9h51kPqKSOHvvYSeYQjE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfECA0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:26:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfECA0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:26:06 -0400
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8098021783;
        Fri,  3 May 2019 00:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556843166;
        bh=V6PvajlKKbO94N9tpD0LRZ4MKdSxlJ0h4zbL/CW1ovI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJBrDxZGikPv7ODXs7raFTmF5MSlSpAqAviVGvOaJnzr8n0btgonB+RtLoHP93SgI
         9Kr8WIHeXS9VToq+6sLW/ZUXv7f9Y4ynRWnKXEQ5++0k2UlY7bxKuAD1zgGxfeNJ+4
         nDewXMgyCQvWO2SLukjaBWa6J0VDNAbU4cEaeYSM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/11] perf cs-etm: Don't check cs_etm_queue::prev_packet validity
Date:   Thu,  2 May 2019 20:25:29 -0400
Message-Id: <20190503002533.29359-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

Since cs_etm_queue::prev_packet is allocated for all cases, it will
never be NULL pointer; now validity checking prev_packet is pointless,
remove all of them.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190428083228.20246-2-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 110804936fc3..7777cfc1ad8c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -981,7 +981,6 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 	 * PREV_PACKET is a branch.
 	 */
 	if (etm->synth_opts.last_branch &&
-	    etmq->prev_packet &&
 	    etmq->prev_packet->sample_type == CS_ETM_RANGE &&
 	    etmq->prev_packet->last_instr_taken_branch)
 		cs_etm__update_last_branch_rb(etmq);
@@ -1014,7 +1013,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
 		etmq->period_instructions = instrs_over;
 	}
 
-	if (etm->sample_branches && etmq->prev_packet) {
+	if (etm->sample_branches) {
 		bool generate_sample = false;
 
 		/* Generate sample for tracing on packet */
@@ -1071,9 +1070,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet *tmp;
 
-	if (!etmq->prev_packet)
-		return 0;
-
 	/* Handle start tracing packet */
 	if (etmq->prev_packet->sample_type == CS_ETM_EMPTY)
 		goto swap_packet;
-- 
2.20.1

