Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D243DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82F92173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892664;
	bh=V/jx/GmiarNvZXeRvvsDV+LbNzlelfjOaGbjKupoD2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jZdUSXGGwU9FB5AQp5FZ6oiJF1ppH6lZXP4/Hnngpd6a8Z5EW7rUFGbcOgDl9b+Zg
	 1KaGCtcIm8JLcne2CsLvocY847JlQTQozZZSGyx22Vzwpr84DDxgeBo+/gtRXqzEYL
	 l7LJ9/OrrB4RAQ/Yx8eUL9AZdJsyzL3puxEZRUoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbfH0H5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729864AbfH0H5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:57:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFF0920828;
        Tue, 27 Aug 2019 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892660;
        bh=V/jx/GmiarNvZXeRvvsDV+LbNzlelfjOaGbjKupoD2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKxd8XZQYMGiwsTz4Oxvb4qjy5DecWNTX1RPl1K2lO45KlP52hBsDcN7ZlpsLb1UK
         yZ5LugFtGVDkh/ZyuO7R7fJ8w49r4hvPpNs3Ncg2uWQaBhm+/gsGphPCM3WZcbjCvC
         XTHCfeycurlaIidMF/5gp9GZ0rRnvOF374TlqWpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hsin-Yi Wang <hsinyi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 52/98] block, bfq: handle NULL return value by bfq_init_rq()
Date:   Tue, 27 Aug 2019 09:50:31 +0200
Message-Id: <20190827072721.062423874@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072718.142728620@linuxfoundation.org>
References: <20190827072718.142728620@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fd03177c33b287c6541f4048f1d67b7b45a1abc9 ]

As reported in [1], the call bfq_init_rq(rq) may return NULL in case
of OOM (in particular, if rq->elv.icq is NULL because memory
allocation failed in failed in ioc_create_icq()).

This commit handles this circumstance.

[1] https://lkml.org/lkml/2019/7/22/824

Cc: Hsin-Yi Wang <hsinyi@google.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Hsin-Yi Wang <hsinyi@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index becd793a258c8..d8d2ac294b0c0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1886,9 +1886,14 @@ static void bfq_request_merged(struct request_queue *q, struct request *req,
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
@@ -1930,6 +1935,9 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 	struct bfq_queue *bfqq = bfq_init_rq(rq),
 		*next_bfqq = bfq_init_rq(next);
 
+	if (!bfqq)
+		return;
+
 	/*
 	 * If next and rq belong to the same bfq_queue and next is older
 	 * than rq, then reposition rq in the fifo (by substituting next
@@ -4590,12 +4598,12 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
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



