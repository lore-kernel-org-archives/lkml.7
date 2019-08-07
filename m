Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAAEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FC921E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDf3h5lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbfHGOSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:18:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54422 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388283AbfHGOSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:18:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so220183wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2fEGd1avRjzNgoZKRJo57rOsvWSouUmLScAruU7orM4=;
        b=CDf3h5luG1Il3ysYALeHWQ6nAmZqFgCk9fpa7U9ICPkY270+BhZcQd1bpfu9LpL/cW
         01/f7VTeMqbP+MFgqN7O087injQ04LCr9x8jQzbG7vzOiXIkQmXy6B19cyzm+lte6gie
         kqfl9GXrDqh+UN78SCyYhcv1oQ7uZOpfHYTvW8HGDhfucQtMZxypnsAYiai/SXLIpEvB
         8i0Mx/Roa1Tx3g1TdvMXc5BFGIGd8zDcU7tw206biQfAAWpwz77CIYp3lbJ/uApynJxu
         +FOOPcNPL+mQmuU14xJh/0aDwunKYcmCasNuIlg5DEkxVEUSZ6o3NlMT+TBiw6I03F/o
         qROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fEGd1avRjzNgoZKRJo57rOsvWSouUmLScAruU7orM4=;
        b=sjOPFackJaUIdxBmq8aH6FM9BT55JWaknAwH2JDvq4o++ght1cEvDhB1q6TeiNLAxq
         Yl82OPut2WLh6LxD4ecIzg5nk/EPCUDWa4B8WUfcPtD4BfPGb4vc43CKrwNgk9QN9uPk
         NNE6g9ACbsnB+0uRhel7mgsUVbaq3GecyfJBokqnVhe3YFrhXCqxmI9jBP1ULLB8AI1x
         U1o2YJWXJTeAMcuURoJ3J35+teHYkZduy6E31ox80Uva8TF5yi1PGNoLCMOrsUIP72oT
         l5/4hCjySiY+ZlnHTjnF2d7J7LLpY7F9gSyjq80kKwpVOnd40om4vtMs2n1v2cGeR2pS
         VH+w==
X-Gm-Message-State: APjAAAUsF955xljBVBi6y/03QrT9XEBLWx3+eYtixO7Zqbm/rOfSoYlh
        OuEj0uoM9qykDHu1xe+1Bw2bqg==
X-Google-Smtp-Source: APXvYqz4Ie0/WbmHMaV9QT+7Q/YEhMJKUx3I61VhSuHO5eFrBxrNI+AyMPeybnzglU2yYvc/DTgnrA==
X-Received: by 2002:a1c:9696:: with SMTP id y144mr194876wmd.73.1565187489338;
        Wed, 07 Aug 2019 07:18:09 -0700 (PDT)
Received: from localhost.localdomain (88-147-66-140.dyn.eolo.it. [88.147.66.140])
        by smtp.gmail.com with ESMTPSA id o7sm83472wmc.36.2019.08.07.07.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 07:18:08 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        pavel@denx.de, Paolo Valente <paolo.valente@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH BUGFIX 2/2] block, bfq: move update of waker and woken list to queue freeing
Date:   Wed,  7 Aug 2019 16:17:54 +0200
Message-Id: <20190807141754.3567-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807141754.3567-1-paolo.valente@linaro.org>
References: <20190807141754.3567-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 13a857a4c4e8 ("block, bfq: detect wakers and
unconditionally inject their I/O"), every bfq_queue has a pointer to a
waker bfq_queue and a list of the bfq_queues it may wake. In this
respect, when a bfq_queue, say Q, remains with no I/O source attached
to it, Q cannot be woken by any other bfq_queue, and cannot wake any
other bfq_queue. Then Q must be removed from the woken list of its
possible waker bfq_queue, and all bfq_queues in the woken list of Q
must stop having a waker bfq_queue.

Q remains with no I/O source in two cases: when the last process
associated with Q exits or when such a process gets associated with a
different bfq_queue. Unfortunately, commit 13a857a4c4e8 ("block, bfq:
detect wakers and unconditionally inject their I/O") performed the
above updates only in the first case.

This commit fixes this bug by moving these updates to when Q gets
freed. This is a simple and safe way to handle all cases, as both the
above events, process exit and re-association, lead to Q being freed
soon, and because dangling references would come out only after Q gets
freed (if no update were performed).

Fixes: 13a857a4c4e8 ("block, bfq: detect wakers and unconditionally inject their I/O")
Reported-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b2009650afc2..5f477501bb3d 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4765,6 +4765,8 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
  */
 void bfq_put_queue(struct bfq_queue *bfqq)
 {
+	struct bfq_queue *item;
+	struct hlist_node *n;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	struct bfq_group *bfqg = bfqq_group(bfqq);
 #endif
@@ -4809,6 +4811,33 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 			bfqq->bfqd->burst_size--;
 	}
 
+	/*
+	 * bfqq does not exist any longer, so it cannot be woken by
+	 * any other queue, and cannot wake any other queue. Then bfqq
+	 * must be removed from the woken list of its possible waker
+	 * queue, and all queues in the woken list of bfqq must stop
+	 * having a waker queue. Strictly speaking, these updates
+	 * should be performed when bfqq remains with no I/O source
+	 * attached to it, which happens before bfqq gets freed. In
+	 * particular, this happens when the last process associated
+	 * with bfqq exits or gets associated with a different
+	 * queue. However, both events lead to bfqq being freed soon,
+	 * and dangling references would come out only after bfqq gets
+	 * freed. So these updates are done here, as a simple and safe
+	 * way to handle all cases.
+	 */
+	/* remove bfqq from woken list */
+	if (!hlist_unhashed(&bfqq->woken_list_node))
+		hlist_del_init(&bfqq->woken_list_node);
+
+	/* reset waker for all queues in woken list */
+	hlist_for_each_entry_safe(item, n, &bfqq->woken_list,
+				  woken_list_node) {
+		item->waker_bfqq = NULL;
+		bfq_clear_bfqq_has_waker(item);
+		hlist_del_init(&item->woken_list_node);
+	}
+
 	if (bfqq->bfqd && bfqq->bfqd->last_completed_rq_bfqq == bfqq)
 		bfqq->bfqd->last_completed_rq_bfqq = NULL;
 
@@ -4839,9 +4868,6 @@ static void bfq_put_cooperator(struct bfq_queue *bfqq)
 
 static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
-	struct bfq_queue *item;
-	struct hlist_node *n;
-
 	if (bfqq == bfqd->in_service_queue) {
 		__bfq_bfqq_expire(bfqd, bfqq, BFQQE_BUDGET_TIMEOUT);
 		bfq_schedule_dispatch(bfqd);
@@ -4851,18 +4877,6 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	bfq_put_cooperator(bfqq);
 
-	/* remove bfqq from woken list */
-	if (!hlist_unhashed(&bfqq->woken_list_node))
-		hlist_del_init(&bfqq->woken_list_node);
-
-	/* reset waker for all queues in woken list */
-	hlist_for_each_entry_safe(item, n, &bfqq->woken_list,
-				  woken_list_node) {
-		item->waker_bfqq = NULL;
-		bfq_clear_bfqq_has_waker(item);
-		hlist_del_init(&item->woken_list_node);
-	}
-
 	bfq_put_queue(bfqq); /* release process reference */
 }
 
-- 
2.20.1

