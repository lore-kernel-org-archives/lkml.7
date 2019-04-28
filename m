Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFADC4321A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 08:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0E0206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 08:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wu5QE43+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfD1Icr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 04:32:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45339 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfD1Icr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 04:32:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so229856pgi.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 01:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BZzKmMo+qjjyommvsHqCKRlBwkTvNOIM1AtqhVGSBu8=;
        b=wu5QE43+AeRJsCx5EsAFQ2WNN/6Pa5OHvDpSZUE3LqXCoegpmt5xwl2xMcIjZK1a8f
         JN1e575Y97uYNyL/D011tx6b8xfVBhZ1AE24pACltyswm1WgB1S6WztEKBL7XqoBiyER
         Fvhnt93SyMNVKo7wFuP8flLqfsi0O7HvOlyCBz5MxU7YoqWszzaVlNDYo1wWaSl9VECs
         mkj8mQZnB0Jy89/+wy8e6XXq2eeRmk2nIKe0Uu/xVMO4/q9o8tdGC5x+s9sSKCv7Bh2n
         ofJSPaSUV4jcfr2NyGPC/Gp8LGRwRljm3XrvOTPW5Y1+OTXNF1ptQkkubjadVG3vhCak
         Gk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BZzKmMo+qjjyommvsHqCKRlBwkTvNOIM1AtqhVGSBu8=;
        b=sKA9ZB158YLg/hYdLP67JJWTKolfdt4/x1wC+91hJeyxAf2+T3OSA4uWFwRjhBGIvA
         T7YMTsF7XYgSElicdN+EU2WjcwtVqnaoEYJbKEPSQoZnPEBjq2dTtermYQIsi0XVt6B7
         xaRBkCfpfF3Jj9sXDdW0ucioHaNtV/KuYjx/sG4HvB0SljjXMWowQxesbgwpB/Zdahdd
         0S3AZ0omVRoWDqn6Kk866Hfc1YyC668XAkmYT3tedUN/ZE/5vH4Qez8n9oWhz4GaP7G3
         WEpdHqDgU8Wy0c/ipe6nK/kuhiE0sGvaN8Sjb2Fy7RmwHucy5Hs0Qb+B/ZXdWgy+9ezr
         p+Sw==
X-Gm-Message-State: APjAAAXZs/uuhaVBO4vslDmKQQId0SQa8AKegeYNKj7mKyqF3904Lkoa
        Ft2Pg/eeyjw6y/Fq0+6EdTOWOg==
X-Google-Smtp-Source: APXvYqw9/PtlzImn0mMJdOmeCob3wa+YqMT3LUMcbfuojD6RxMuQAk2fFD4ejtL3SH0T8BkJ7wmGkw==
X-Received: by 2002:a62:2fc1:: with SMTP id v184mr24439025pfv.258.1556440365813;
        Sun, 28 Apr 2019 01:32:45 -0700 (PDT)
Received: from localhost.localdomain (li990-117.members.linode.com. [45.33.40.117])
        by smtp.gmail.com with ESMTPSA id a12sm31960518pgq.21.2019.04.28.01.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 01:32:43 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/2] perf cs-etm: Always allocate memory for cs_etm_queue::prev_packet
Date:   Sun, 28 Apr 2019 16:32:27 +0800
Message-Id: <20190428083228.20246-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Walker reported a segmentation fault is observed when process
CoreSight trace data; this issue can be easily reproduced by the
command 'perf report --itrace=i1000i' for decoding tracing data.

If neither the 'b' flag (synthesize branches events) nor 'l' flag
(synthesize last branch entries) are specified to option '--itrace',
cs_etm_queue::prev_packet will not been initialised.  After merging
the code to support exception packets and sample flags, there
introduced a number of uses of cs_etm_queue::prev_packet without
checking whether it is valid, for these cases any accessing to
uninitialised prev_packet will cause crash.

As cs_etm_queue::prev_packet is used more widely now and it's already
hard to follow which functions have been called in a context where the
validity of cs_etm_queue::prev_packet has been checked, this patch
always allocates memory for cs_etm_queue::prev_packet.

Reported-by: Robert Walker <robert.walker@arm.com>
Suggested-by: Robert Walker <robert.walker@arm.com>
Fixes: 7100b12cf474 ("perf cs-etm: Generate branch sample for exception packet")
Fixes: 24fff5eb2b93 ("perf cs-etm: Avoid stale branch samples when flush packet")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 110804936fc3..054b480aab04 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -422,11 +422,9 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
 	if (!etmq->packet)
 		goto out_free;
 
-	if (etm->synth_opts.last_branch || etm->sample_branches) {
-		etmq->prev_packet = zalloc(szp);
-		if (!etmq->prev_packet)
-			goto out_free;
-	}
+	etmq->prev_packet = zalloc(szp);
+	if (!etmq->prev_packet)
+		goto out_free;
 
 	if (etm->synth_opts.last_branch) {
 		size_t sz = sizeof(struct branch_stack);
-- 
2.17.1

