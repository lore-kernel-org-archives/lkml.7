Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F4BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782ED206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1MI6x7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfCJSMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:12:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45159 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfCJSM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:12:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id o7so2622599wrp.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 11:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1TfFyjmju0trauNzj8mLdRPLJSW2/vzxX4W6lPtYQU=;
        b=K1MI6x7r3euOnbBHikS92atb94FGWXGGScoBwetmCeXSMUrKI1PH3sC+IShkd/WY3f
         2SqVuUnAZ1m5d0KfSuxwS/SB+pldGFkmA/2rlvw9FhRRwOj7Maq9RFsSN0hOnoT41MV+
         21ffC/1GjDBd5l8UR6JxhLVxTSgLBokO9FwrPnZ7ymK+4geUdmpoaaVekP7qtfGgRVvf
         9Xhq6J8Tw5bWYagtmkcpF6TJLbXIAPxdsMpyJW8Ok7YeU2nskO2Wx/t0hisq2f4HypEm
         Tl320rPWZWNj/YkId116uWGHmeBh+RlPgQLpVCzQL4ds6GXqG8odFFi8E5bOPAagrE2B
         hBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1TfFyjmju0trauNzj8mLdRPLJSW2/vzxX4W6lPtYQU=;
        b=pHqqFYiXbk78/LjHGKoL+HEh9iJP+QNu8m03qc0ol1cqzPx5ATuMfAubsqg66h/k+U
         Y4ZUA54VAWwKAHVw0WWGBZX7aQ7F02AdCe2NLeb5DvsZifefNTSsbi7M8HJvj63dt/hC
         eEOKhbXtFti3E+m65XdCm0c43zsELqUGRk+eXcNcCeV+1Emcm8NgSBYSMz9QmDryOQZ9
         Gv131uFfgjphI9zmY+GIElhjzmAPu1cruakwsxTx5KVNZV9/w6vm5v5fisqTizZvv8ST
         /FbkLxImD8zw/2sB3GQlMCBq4eWkOxCL0l5bWSfeD3BnfDzQHXODOZKSjku7hpEBgec5
         hNMw==
X-Gm-Message-State: APjAAAW7Q/Yu1cM8Mlev7z6TLnsj0lF6etwoGfgByRChg75OGhSM7bg0
        ysQ3cP3jNkPJfYdd5be7EpcYOA==
X-Google-Smtp-Source: APXvYqylKw74GOhyIvjXfI0KuxScRGKe0OQZl+Ajt1lnsEprRpSq/SXprnSDc1heL75HIW8wE80ncw==
X-Received: by 2002:adf:e442:: with SMTP id t2mr4773085wrm.256.1552241546350;
        Sun, 10 Mar 2019 11:12:26 -0700 (PDT)
Received: from localhost.localdomain (146-241-67-113.dyn.eolo.it. [146.241.67.113])
        by smtp.gmail.com with ESMTPSA id d206sm24906368wmc.11.2019.03.10.11.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:12:25 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, fra.fra.800@gmail.com,
        alessio.masola@gmail.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 8/9] block, bfq: save & resume weight on a queue merge/split
Date:   Sun, 10 Mar 2019 19:11:36 +0100
Message-Id: <20190310181137.2604-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310181137.2604-1-paolo.valente@linaro.org>
References: <20190310181137.2604-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Pollicino <fra.fra.800@gmail.com>

bfq saves the state of a queue each time a merge occurs, to be
able to resume such a state when the queue is associated again
with its original process, on a split.

Unfortunately bfq does not save & restore also the weight of the
queue. If the weight is not correctly resumed when the queue is
recycled, then the weight of the recycled queue could differ
from the weight of the original queue.

This commit adds the missing save & resume of the weight.

Signed-off-by: Francesco Pollicino <fra.fra.800@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 ++
 block/bfq-iosched.h | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7d95d9c01036..1712d12340c0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1028,6 +1028,7 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 	else
 		bfq_clear_bfqq_IO_bound(bfqq);
 
+	bfqq->entity.new_weight = bic->saved_weight;
 	bfqq->ttime = bic->saved_ttime;
 	bfqq->wr_coeff = bic->saved_wr_coeff;
 	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
@@ -2502,6 +2503,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	if (!bic)
 		return;
 
+	bic->saved_weight = bfqq->entity.orig_weight;
 	bic->saved_ttime = bfqq->ttime;
 	bic->saved_has_short_ttime = bfq_bfqq_has_short_ttime(bfqq);
 	bic->saved_IO_bound = bfq_bfqq_IO_bound(bfqq);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 6410cc9a064d..1e34cce59ba7 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -404,6 +404,15 @@ struct bfq_io_cq {
 	 */
 	bool was_in_burst_list;
 
+	/*
+	 * Save the weight when a merge occurs, to be able
+	 * to restore it in case of split. If the weight is not
+	 * correctly resumed when the queue is recycled,
+	 * then the weight of the recycled queue could differ
+	 * from the weight of the original queue.
+	 */
+	unsigned int saved_weight;
+
 	/*
 	 * Similar to previous fields: save wr information.
 	 */
-- 
2.20.1

