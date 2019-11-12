Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C3C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABBA2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q61JAj3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfKLHtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:49:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36422 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLHtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:49:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id c22so1823710wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 23:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h+vr6PNUoMDGum6dWz+gtk31tHP3FZ8Tbn4zljQ9/yo=;
        b=q61JAj3Nv+2bmyX2BElQcE/CdF63fy8UBh9vOX4+5wtt1qU0l+At2fLHtC9V44RrvJ
         S6gH5dPypoWemgb4AWOp4ne7x9iRQKrBy+64JAkHzq3hw0IrIuXNPeLCM/HqucVOgJyf
         gGIf1QmA++75IxCNB6yH1fOwcM21UH3GVLy6T9eh/I0vVWwKu6T2GcGPgIGXtm4LERzW
         ssi8crq8fPSBCgIeaS1/YuVnHf4r45ZuezRy6R9+Q9eH/+rxlhnv+7RW0JZRoHDChMD2
         msU6IFnEnoKk0zavHf23UlaOAZd+g3SawOh+uP8cF+7sbAPxEF00AAvhW4PZ8TRZoKo5
         cYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h+vr6PNUoMDGum6dWz+gtk31tHP3FZ8Tbn4zljQ9/yo=;
        b=eR6wlvvrA41CRr9wxYFuebqH2M0BNsJ5rtt12va7qjGmRDObB/58tGnmumA3wicsfl
         v67txu2CgoV7Ht12K+4bsB+cTiB7PyGurULE3JKESRjgx4Y9AqGqM5iw3FhTmxKQBETK
         a7qM9xR8aXWvsS2ezJzCJ7R0/2FKWIEfs4MwNp4VgtR9tk4Z4R//OljtGNCjnFjk+3ot
         pWY0JnfUYHvmSn81K/+jprvec1ENt2BCgysEj46wLQtURATAxuQ9CJJfuBrbhwAwOnrM
         NORfO+u2TWMi99lRxlmhgVaarhe4oSPQfYNXy9urKOHt6a+utmDXOzp/26UliwAGLOI9
         llow==
X-Gm-Message-State: APjAAAUbld/ZKuQYEqy7XVtGjgFkCs+DBQ8wU5IOrqzNM6ku0ugCZrS9
        ZxLM8sjKM24RJ81w1IZjpMEqdQ==
X-Google-Smtp-Source: APXvYqwvi42Af4KWqn1d+iULQZP4KGlAeWLtnO86KWmu7eJ92YByKkS63dzNtbW62k17evDEBTR+JA==
X-Received: by 2002:a1c:39c2:: with SMTP id g185mr2519283wma.88.1573544950426;
        Mon, 11 Nov 2019 23:49:10 -0800 (PST)
Received: from localhost.localdomain (88-147-76-3.dyn.eolo.it. [88.147.76.3])
        by smtp.gmail.com with ESMTPSA id f67sm2819974wme.16.2019.11.11.23.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 23:49:09 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>,
        Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
Subject: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not referred by any process
Date:   Tue, 12 Nov 2019 08:48:56 +0100
Message-Id: <20191112074856.40433-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3726112ec731 ("block, bfq: re-schedule empty queues if
they deserve I/O plugging"), to prevent the service guarantees of a
bfq_queue from being violated, the bfq_queue may be left busy, i.e.,
scheduled for service, even if empty (see comments in
__bfq_bfqq_expire() for details). But, if no process will send
requests to the bfq_queue any longer, then there is no point in
keeping the bfq_queue scheduled for service.

In addition, keeping the bfq_queue scheduled for service, but with no
process reference any longer, may cause the bfq_queue to be freed when
descheduled from service. But this is assumed to never happen, and
causes a UAF if it happens. This, in turn, caused crashes [1, 2].

This commit fixes this issue by descheduling an empty bfq_queue when
it remains with not process reference.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1767539
[2] https://bugzilla.kernel.org/show_bug.cgi?id=205447

Fixes: 3726112ec731 ("block, bfq: re-schedule empty queues if they deserve I/O plugging")
Reported-by: Chris Evich <cevich@redhat.com>
Reported-by: Patrick Dung <patdung100@gmail.com>
Reported-by: Thorsten Schubert <tschubert@bafh.org>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0319d6339822..ba68627f7740 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2713,6 +2713,27 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	}
 }
 
+
+static
+void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+{
+	/*
+	 * To prevent bfqq's service guarantees from being violated,
+	 * bfqq may be left busy, i.e., queued for service, even if
+	 * empty (see comments in __bfq_bfqq_expire() for
+	 * details). But, if no process will send requests to bfqq any
+	 * longer, then there is no point in keeping bfqq queued for
+	 * service. In addition, keeping bfqq queued for service, but
+	 * with no process ref any longer, may have caused bfqq to be
+	 * freed when dequeued from service. But this is assumed to
+	 * never happen.
+	 */
+	if (bfq_bfqq_busy(bfqq) && RB_EMPTY_ROOT(&bfqq->sort_list))
+		bfq_del_bfqq_busy(bfqd, bfqq, false);
+
+	bfq_put_queue(bfqq);
+}
+
 static void
 bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 		struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
@@ -2783,8 +2804,7 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 	 */
 	new_bfqq->pid = -1;
 	bfqq->bic = NULL;
-	/* release process reference to bfqq */
-	bfq_put_queue(bfqq);
+	bfq_release_process_ref(bfqd, bfqq);
 }
 
 static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
@@ -4899,7 +4919,7 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	bfq_put_cooperator(bfqq);
 
-	bfq_put_queue(bfqq); /* release process reference */
+	bfq_release_process_ref(bfqd, bfqq);
 }
 
 static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
@@ -5001,8 +5021,7 @@ static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 
 	bfqq = bic_to_bfqq(bic, false);
 	if (bfqq) {
-		/* release process reference on this queue */
-		bfq_put_queue(bfqq);
+		bfq_release_process_ref(bfqd, bfqq);
 		bfqq = bfq_get_queue(bfqd, bio, BLK_RW_ASYNC, bic);
 		bic_set_bfqq(bic, bfqq, false);
 	}
@@ -5963,7 +5982,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
 
 	bfq_put_cooperator(bfqq);
 
-	bfq_put_queue(bfqq);
+	bfq_release_process_ref(bfqq->bfqd, bfqq);
 	return NULL;
 }
 
-- 
2.20.1

