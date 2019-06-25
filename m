Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E185DC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A640A2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOIauIcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfFYFNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:13:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55717 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfFYFNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:13:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so1364636wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 22:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JW8uE9p2cExcuevLdfaub1Bim8IPk1JSRsG24Fpy7KY=;
        b=kOIauIcnpP/LDmX0G7V5Ri7NZ333YCW3flfMrFaZsHPyrIRVmeQMfukl03nKK29YqP
         NG/4fA21zTbXiS1iiqKk/vW0ZlPAVkPzIcsBkeMvbe7j+k3djhbbO+r09LYw38QQ54rg
         04azTRQo0/2xvfIPqhGkIN311I81CkNgz6jpcV1glxGpwpZlUR0jPGteD5iTrS6E8eTm
         2sA0bI6Zedvpvl8MFHI6fISWME+1DDG1a0+KMS5e/GWgpnEX/a98+UEiHZCXdrDDdvYG
         /tGPOEkiXFv6Yzvvoohe7ZioBaKE71e7RQ4/ha4b/HEUWcESirpO1QQ9wcr9/5AtofpT
         jESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JW8uE9p2cExcuevLdfaub1Bim8IPk1JSRsG24Fpy7KY=;
        b=A8foK12YSlvHYWEFQ+YrO86ODhkqcA80EODl8sBkE+AstpzFl+HGBoP8Uxwq6Q5iOW
         5OA/AEEJ7sB+xtXtnWQWQwfBZKFByM/GB/WPUpPrdR3MiC1/WJmzyQJbRSDT/idSUk13
         09RQa3JBrpwO+AZFP6FvYM9gy5qi+N7QCg/bEptt6f+tPUDBrOcz7BVFeKkYN0FTKgc8
         LmzQXaKzCyNMFwN4EYDerS9tKIdGdHHBj/uCn/Uie+A5Z/tjwtJ/eqoGlRdkFu3YnmT0
         XZ68Hlk60gVm02bzQe+t5O/1dDEcbsgJwczvDZVhVTckP7bV0rv2ibhF3w8iicrjwcK/
         B4mA==
X-Gm-Message-State: APjAAAW23+DVjBP16TpY6TXeWVjjK4OADUZmnXGFq6960+MxUac/PklG
        iVkVjv5zocxuWk2Ktu7yZ5hyKA==
X-Google-Smtp-Source: APXvYqwwq1CEXCNGGo/wz6fE88uyQjUG4jCI8/ZxdgTsKTuKHvAICtkcJo2Arce7XLsHkA98Ls5f2w==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr17784467wmc.16.1561439591442;
        Mon, 24 Jun 2019 22:13:11 -0700 (PDT)
Received: from localhost.localdomain (146-241-102-168.dyn.eolo.it. [146.241.102.168])
        by smtp.gmail.com with ESMTPSA id q20sm28543149wra.36.2019.06.24.22.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 22:13:10 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 6/7] block, bfq: preempt lower-weight or lower-priority queues
Date:   Tue, 25 Jun 2019 07:12:48 +0200
Message-Id: <20190625051249.39265-7-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625051249.39265-1-paolo.valente@linaro.org>
References: <20190625051249.39265-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BFQ enqueues the I/O coming from each process into a separate
bfq_queue, and serves bfq_queues one at a time. Each bfq_queue may be
served for at most timeout_sync milliseconds (default: 125 ms). This
service scheme is prone to the following inaccuracy.

While a bfq_queue Q1 is in service, some empty bfq_queue Q2 may
receive I/O, and, according to BFQ's scheduling policy, may become the
right bfq_queue to serve, in place of the currently in-service
bfq_queue. In this respect, postponing the service of Q2 to after the
service of Q1 finishes may delay the completion of Q2's I/O, compared
with an ideal service in which all non-empty bfq_queues are served in
parallel, and every non-empty bfq_queue is served at a rate
proportional to the bfq_queue's weight. This additional delay is equal
at most to the time Q1 may unjustly remain in service before switching
to Q2.

If Q1 and Q2 have the same weight, then this time is most likely
negligible compared with the completion time to be guaranteed to Q2's
I/O. In addition, first, one of the reasons why BFQ may want to serve
Q1 for a while is that this boosts throughput and, second, serving Q1
longer reduces BFQ's overhead. As a conclusion, it is usually better
not to preempt Q1 if both Q1 and Q2 have the same weight.

In contrast, as Q2's weight or priority becomes higher and higher
compared with that of Q1, the above delay becomes larger and larger,
compared with the I/O completion times that have to be guaranteed to
Q2 according to Q2's weight. So reducing this delay may be more
important than avoiding the costs of preempting Q1.

Accordingly, this commit preempts Q1 if Q2 has a higher weight or a
higher priority than Q1. Preemption causes Q1 to be re-scheduled, and
triggers a new choice of the next bfq_queue to serve. If Q2 really is
the next bfq_queue to serve, then Q2 will be set in service
immediately.

This change reduces the component of the I/O latency caused by the
above delay by about 80%. For example, on an (old) PLEXTOR PX-256M5
SSD, the maximum latency reported by fio drops from 15.1 to 3.2 ms for
a process doing sporadic random reads while another process is doing
continuous sequential reads.

Signed-off-by: Nicola Bottura <bottura.nicola95@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 95 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 75 insertions(+), 20 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9e2fbb7d1fb6..6a3d05023300 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1428,17 +1428,19 @@ static int bfq_min_budget(struct bfq_data *bfqd)
  * mechanism may be re-designed in such a way to make it possible to
  * know whether preemption is needed without needing to update service
  * trees). In addition, queue preemptions almost always cause random
- * I/O, and thus loss of throughput. Because of these facts, the next
- * function adopts the following simple scheme to avoid both costly
- * operations and too frequent preemptions: it requests the expiration
- * of the in-service queue (unconditionally) only for queues that need
- * to recover a hole, or that either are weight-raised or deserve to
- * be weight-raised.
+ * I/O, which may in turn cause loss of throughput. Finally, there may
+ * even be no in-service queue when the next function is invoked (so,
+ * no queue to compare timestamps with). Because of these facts, the
+ * next function adopts the following simple scheme to avoid costly
+ * operations, too frequent preemptions and too many dependencies on
+ * the state of the scheduler: it requests the expiration of the
+ * in-service queue (unconditionally) only for queues that need to
+ * recover a hole. Then it delegates to other parts of the code the
+ * responsibility of handling the above case 2.
  */
 static bool bfq_bfqq_update_budg_for_activation(struct bfq_data *bfqd,
 						struct bfq_queue *bfqq,
-						bool arrived_in_time,
-						bool wr_or_deserves_wr)
+						bool arrived_in_time)
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
@@ -1493,7 +1495,7 @@ static bool bfq_bfqq_update_budg_for_activation(struct bfq_data *bfqd,
 	entity->budget = max_t(unsigned long, bfqq->max_budget,
 			       bfq_serv_to_charge(bfqq->next_rq, bfqq));
 	bfq_clear_bfqq_non_blocking_wait_rq(bfqq);
-	return wr_or_deserves_wr;
+	return false;
 }
 
 /*
@@ -1611,6 +1613,36 @@ static bool bfq_bfqq_idle_for_long_time(struct bfq_data *bfqd,
 			bfqd->bfq_wr_min_idle_time);
 }
 
+
+/*
+ * Return true if bfqq is in a higher priority class, or has a higher
+ * weight than the in-service queue.
+ */
+static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
+					    struct bfq_queue *in_serv_bfqq)
+{
+	int bfqq_weight, in_serv_weight;
+
+	if (bfqq->ioprio_class < in_serv_bfqq->ioprio_class)
+		return true;
+
+	if (in_serv_bfqq->entity.parent == bfqq->entity.parent) {
+		bfqq_weight = bfqq->entity.weight;
+		in_serv_weight = in_serv_bfqq->entity.weight;
+	} else {
+		if (bfqq->entity.parent)
+			bfqq_weight = bfqq->entity.parent->weight;
+		else
+			bfqq_weight = bfqq->entity.weight;
+		if (in_serv_bfqq->entity.parent)
+			in_serv_weight = in_serv_bfqq->entity.parent->weight;
+		else
+			in_serv_weight = in_serv_bfqq->entity.weight;
+	}
+
+	return bfqq_weight > in_serv_weight;
+}
+
 static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 					     struct bfq_queue *bfqq,
 					     int old_wr_coeff,
@@ -1655,8 +1687,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 */
 	bfqq_wants_to_preempt =
 		bfq_bfqq_update_budg_for_activation(bfqd, bfqq,
-						    arrived_in_time,
-						    wr_or_deserves_wr);
+						    arrived_in_time);
 
 	/*
 	 * If bfqq happened to be activated in a burst, but has been
@@ -1721,16 +1752,40 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 
 	/*
 	 * Expire in-service queue only if preemption may be needed
-	 * for guarantees. In this respect, the function
-	 * next_queue_may_preempt just checks a simple, necessary
-	 * condition, and not a sufficient condition based on
-	 * timestamps. In fact, for the latter condition to be
-	 * evaluated, timestamps would need first to be updated, and
-	 * this operation is quite costly (see the comments on the
-	 * function bfq_bfqq_update_budg_for_activation).
+	 * for guarantees. In particular, we care only about two
+	 * cases. The first is that bfqq has to recover a service
+	 * hole, as explained in the comments on
+	 * bfq_bfqq_update_budg_for_activation(), i.e., that
+	 * bfqq_wants_to_preempt is true. However, if bfqq does not
+	 * carry time-critical I/O, then bfqq's bandwidth is less
+	 * important than that of queues that carry time-critical I/O.
+	 * So, as a further constraint, we consider this case only if
+	 * bfqq is at least as weight-raised, i.e., at least as time
+	 * critical, as the in-service queue.
+	 *
+	 * The second case is that bfqq is in a higher priority class,
+	 * or has a higher weight than the in-service queue. If this
+	 * condition does not hold, we don't care because, even if
+	 * bfqq does not start to be served immediately, the resulting
+	 * delay for bfqq's I/O is however lower or much lower than
+	 * the ideal completion time to be guaranteed to bfqq's I/O.
+	 *
+	 * In both cases, preemption is needed only if, according to
+	 * the timestamps of both bfqq and of the in-service queue,
+	 * bfqq actually is the next queue to serve. So, to reduce
+	 * useless preemptions, the return value of
+	 * next_queue_may_preempt() is considered in the next compound
+	 * condition too. Yet next_queue_may_preempt() just checks a
+	 * simple, necessary condition for bfqq to be the next queue
+	 * to serve. In fact, to evaluate a sufficient condition, the
+	 * timestamps of the in-service queue would need to be
+	 * updated, and this operation is quite costly (see the
+	 * comments on bfq_bfqq_update_budg_for_activation()).
 	 */
-	if (bfqd->in_service_queue && bfqq_wants_to_preempt &&
-	    bfqd->in_service_queue->wr_coeff < bfqq->wr_coeff &&
+	if (bfqd->in_service_queue &&
+	    ((bfqq_wants_to_preempt &&
+	      bfqq->wr_coeff >= bfqd->in_service_queue->wr_coeff) ||
+	     bfq_bfqq_higher_class_or_weight(bfqq, bfqd->in_service_queue)) &&
 	    next_queue_may_preempt(bfqd))
 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
 				false, BFQQE_PREEMPTED);
-- 
2.20.1

