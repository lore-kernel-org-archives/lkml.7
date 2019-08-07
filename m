Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDF6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124C121993
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Slbetn8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388731AbfHGRV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:21:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55279 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbfHGRV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:21:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so803836wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2EJNQPnOEl3GZNAxpz5JJlhH5o76gr2JP/NdmhEjGs=;
        b=Slbetn8k4h8b+dLP23JOZzACY2KPtfhEdyy4tIy1t0kM6CLvwNMntuGC8OWdSosCwC
         Mn1hdHbI42z8YdGqz3QU3H5n2snOQDR/snOwPv52MyekKooNtPIfnm8/xJm1l0R1kd0v
         GB4Vw1raWpROllTv0w7r/AdyRxKhXb7T0BrhMDejdNdArhaNlj9/4IFqRsPN27rghRaR
         IroQlGR7jYdWs4YoT8GQbtavA8dOdKl7/jOIXcNFH4NePAZfTYGplEszVQK4o9k/HSoL
         65ECmXVSCxDJFQtPd4UuGfmfXGDqliW49oP8V/KGMXudqKR8YfhlR0rej4aMYD4dlDyC
         uKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2EJNQPnOEl3GZNAxpz5JJlhH5o76gr2JP/NdmhEjGs=;
        b=qXb+HyzRPp2TJkAE/KimJQWrD8Yv+GsvK0jzNPQlaXJrNlOVSyPdXlMa3TLig1FqoK
         WCXp1qts+YNaouT9fkFWAZeaf4CayQew6luuEqMyUBLNR5tdXJ1xm8tEOExDRBzr7ADk
         qOYJDXf6TxoRvh2t9wifMM9P1rTm5Gl5oa8qlKz1NVFkEqt6Ltl/0D+ot/dcJozu/W5K
         ldkday4CIUZVHnBJJaAdiEeB26d+LBffTe/m9/2sD0VJ0+BqbaTY8ZztP6ugou1ta2Te
         7l6b73p5CTnQHFyPYznYCVLx7oLx73vgX7mFS1Jj1VOI0Qr+9whack14R0qw4LlFDSDs
         vC7A==
X-Gm-Message-State: APjAAAW43s/fGPqTRyAjERNeXES6d2HCiX0im3tFZZ4CfGRsNvOa+kPe
        HKKVHjemC0qdsjZFB1WPrHT3WQ==
X-Google-Smtp-Source: APXvYqzBdRIfE+HrknLNxY/zsTEgRLTff26RF5t3imH7y4D5rR5RbsMu8UTWdbsANsG2R+dUMRYXXg==
X-Received: by 2002:a1c:751a:: with SMTP id o26mr920609wmc.13.1565198484766;
        Wed, 07 Aug 2019 10:21:24 -0700 (PDT)
Received: from localhost.localdomain (88-147-66-140.dyn.eolo.it. [88.147.66.140])
        by smtp.gmail.com with ESMTPSA id q193sm586773wme.8.2019.08.07.10.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 10:21:24 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux@roeck-us.net
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>,
        Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [BUGFIX 1/1] block, bfq: handle NULL return value by bfq_init_rq()
Date:   Wed,  7 Aug 2019 19:21:11 +0200
Message-Id: <20190807172111.4718-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807172111.4718-1-paolo.valente@linaro.org>
References: <20190807172111.4718-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported in [1], the call bfq_init_rq(rq) may return NULL in case
of OOM (in particular, if rq->elv.icq is NULL because memory
allocation failed in failed in ioc_create_icq()).

This commit handles this circumstance.

[1] https://lkml.org/lkml/2019/7/22/824

Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Hsin-Yi Wang <hsinyi@google.com>
Cc: Hsin-Yi Wang <hsinyi@google.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 586fcfe227ea..32686300d89b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2250,9 +2250,14 @@ static void bfq_request_merged(struct request_queue *q, struct request *req,
 	    blk_rq_pos(container_of(rb_prev(&req->rb_node),
 				    struct request, rb_node))) {
 		struct bfq_queue *bfqq = bfq_init_rq(req);
-		struct bfq_data *bfqd = bfqq->bfqd;
+		struct bfq_data *bfqd;
 		struct request *prev, *next_rq;
 
+		if (!bfqq)
+			return;
+
+		bfqd = bfqq->bfqd;
+
 		/* Reposition request in its sort_list */
 		elv_rb_del(&bfqq->sort_list, req);
 		elv_rb_add(&bfqq->sort_list, req);
@@ -2299,6 +2304,9 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 	struct bfq_queue *bfqq = bfq_init_rq(rq),
 		*next_bfqq = bfq_init_rq(next);
 
+	if (!bfqq)
+		return;
+
 	/*
 	 * If next and rq belong to the same bfq_queue and next is older
 	 * than rq, then reposition rq in the fifo (by substituting next
@@ -5436,12 +5444,12 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
-	if (at_head || blk_rq_is_passthrough(rq)) {
+	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
 		if (at_head)
 			list_add(&rq->queuelist, &bfqd->dispatch);
 		else
 			list_add_tail(&rq->queuelist, &bfqd->dispatch);
-	} else { /* bfqq is assumed to be non null here */
+	} else {
 		idle_timer_disabled = __bfq_insert_request(bfqd, rq);
 		/*
 		 * Update bfqq, because, if a queue merge has occurred
-- 
2.20.1

