Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CEBC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42A42075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IQ2BvWTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfECF4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:56:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECF4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:56:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435uMRC2618523
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:56:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435uMRC2618523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556862983;
        bh=HcyxK8WPy4fpSAPYmh6NQdADe1J4FuUOw3Cp3f0j3Bg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IQ2BvWTa9Ovk6fMa9+83bIv3OUPuvDDZf1mk9CvI0F5HDaNKkSd3eNfbk1h5Gqvkg
         vqeRK74cZRymr8KY2Mw5k17akjwlOLPCvGOZWo93UdhYAHsPYiD8/roGzqc6AhDKDe
         e7JCijXnFfaWTtQdXvYk0Z1UAm5A0xn4xwY2xjgCzb4H/HnBwP30eCYsxPRi8cjs0/
         H8vJg9W739ljZ1KreXRNHIUHpS9M+LSEb+vRUpAAoC+8ykq7Anwq11EtKySUQFRiCd
         iMJItkNH7sMWt+kBXEyqIfBfNDRXaMxror6SeiR5qPBgU/Gdj5mXj1W56JrRR86UuG
         f4stV00+tSItw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435uM042618520;
        Thu, 2 May 2019 22:56:22 -0700
Date:   Thu, 2 May 2019 22:56:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-cf0c37b6dbf74fb71bea07b516612d29e00dcbc4@git.kernel.org>
Cc:     jolsa@redhat.com, leo.yan@linaro.org, acme@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, alexander.shishkin@linux.intel.com,
        suzuki.poulose@arm.com, tglx@linutronix.de, mingo@kernel.org,
        namhyung@kernel.org, robert.walker@arm.com, mike.leach@linaro.org
Reply-To: jolsa@redhat.com, linux-kernel@vger.kernel.org,
          mathieu.poirier@linaro.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, leo.yan@linaro.org, hpa@zytor.com,
          suzuki.poulose@arm.com, tglx@linutronix.de, mingo@kernel.org,
          namhyung@kernel.org, robert.walker@arm.com, mike.leach@linaro.org
In-Reply-To: <20190428083228.20246-2-leo.yan@linaro.org>
References: <20190428083228.20246-2-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf cs-etm: Don't check
 cs_etm_queue::prev_packet validity
Git-Commit-ID: cf0c37b6dbf74fb71bea07b516612d29e00dcbc4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cf0c37b6dbf74fb71bea07b516612d29e00dcbc4
Gitweb:     https://git.kernel.org/tip/cf0c37b6dbf74fb71bea07b516612d29e00dcbc4
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Sun, 28 Apr 2019 16:32:28 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:20 -0400

perf cs-etm: Don't check cs_etm_queue::prev_packet validity

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
