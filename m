Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C88C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9605E206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="c/OsgCon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfJLFua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 01:50:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40674 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfJLFuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 01:50:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so14018467wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 22:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6L2bs6j8TutkJs+FzXM4KGo0BcXqh5bqh+8TwgmkM38=;
        b=c/OsgConE2hR9FufXfwmkLkc/BMvs/lb7QyImPUxRnwovMcHIOBdDgg63HMsyU1txn
         kOXymB5+l69x10z8k3FTQzIEibLI9DKMq+66GEOGSTtdFQRq5bciQfy+Mulj8qU41XHx
         TaR/a5GEjLjAUoQsUuD8W/V/FbKkmJM0fOZ6AjOuQnEo1GMstqGyma0flYanJUbVvDyp
         sxGCohTugL04WWwnC3InhswQZN9t3hZlVvK0fO2CRxxz2CvSuhf8XPVtoPkBJAbwnhj/
         E2BXXdEKLA1MUwOEM9FViAylgD/thhaQqs9iFYulJN+P+HFp8daTgXLk2svYf+mQA8H8
         XpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6L2bs6j8TutkJs+FzXM4KGo0BcXqh5bqh+8TwgmkM38=;
        b=aq33oSqmkWyKiNy1QOiPoFPHoS45hYuNqiqVgci2G3KoOu+iVTZfQcO/nLiorp20Es
         w7QjJzZ9jyma5JANkzv66fZ0NEf1m/aAbNuBcs7bYjJufv5j/ceqNjiXpP6Fe1nL3Yzj
         a9S61htlc3/VDpMgOqXvHD7lyFTkkZz/zFbS2Fq8M1PyEdLU0PripkxbDwMvRszs22pn
         feLpRKYzChG0VoZHoYm/S+0Xkgbd+dJEavZtgtI4Zq15VoCxLmecEZmJ2Bn4mu5AqXCe
         v/KYHxN5LNINeyGuNmyDxFk0sUCHo7PPwI5DeQhTONS8BvQBijgz8VCOflbnzxbXA1Tv
         PE3A==
X-Gm-Message-State: APjAAAUVkbMeKP/k4HKA4rbqqMYnjtqdbYLlSi1TNobtTSO3FemPG/+Y
        IW7WVh74636aB/BO1nSwOWrtf3NCw7E4Sg==
X-Google-Smtp-Source: APXvYqwdEoidkRzqZDoqRUl37qosyps2HfgrFpS5KTjTTGmt/vDuLocCONQcpidL4KYo++74638eVA==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr16006399wru.116.1570859410632;
        Fri, 11 Oct 2019 22:50:10 -0700 (PDT)
Received: from linux.fritz.box (p200300D9973AD600F159A589C745B52A.dip0.t-ipconnect.de. [2003:d9:973a:d600:f159:a589:c745:b52a])
        by smtp.googlemail.com with ESMTPSA id z4sm9344955wrh.93.2019.10.11.22.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 22:50:10 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 2/6] ipc/mqueue.c: Remove duplicated code
Date:   Sat, 12 Oct 2019 07:49:54 +0200
Message-Id: <20191012054958.3624-3-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191012054958.3624-1-manfred@colorfullife.com>
References: <20191012054958.3624-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch entirely from Davidlohr:
pipelined_send() and pipelined_receive() are identical, so merge them.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/mqueue.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 3d920ff15c80..be48c0ba92f7 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -918,17 +918,12 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
  * The same algorithm is used for senders.
  */
 
-/* pipelined_send() - send a message directly to the task waiting in
- * sys_mq_timedreceive() (without inserting message into a queue).
- */
-static inline void pipelined_send(struct wake_q_head *wake_q,
+static inline void __pipelined_op(struct wake_q_head *wake_q,
 				  struct mqueue_inode_info *info,
-				  struct msg_msg *message,
-				  struct ext_wait_queue *receiver)
+				  struct ext_wait_queue *this)
 {
-	receiver->msg = message;
-	list_del(&receiver->list);
-	wake_q_add(wake_q, receiver->task);
+	list_del(&this->list);
+	wake_q_add(wake_q, this->task);
 	/*
 	 * Rely on the implicit cmpxchg barrier from wake_q_add such
 	 * that we can ensure that updating receiver->state is the last
@@ -937,7 +932,19 @@ static inline void pipelined_send(struct wake_q_head *wake_q,
 	 * yet, at that point we can later have a use-after-free
 	 * condition and bogus wakeup.
 	 */
-	receiver->state = STATE_READY;
+        this->state = STATE_READY;
+}
+
+/* pipelined_send() - send a message directly to the task waiting in
+ * sys_mq_timedreceive() (without inserting message into a queue).
+ */
+static inline void pipelined_send(struct wake_q_head *wake_q,
+				  struct mqueue_inode_info *info,
+				  struct msg_msg *message,
+				  struct ext_wait_queue *receiver)
+{
+	receiver->msg = message;
+	__pipelined_op(wake_q, info, receiver);
 }
 
 /* pipelined_receive() - if there is task waiting in sys_mq_timedsend()
@@ -955,9 +962,7 @@ static inline void pipelined_receive(struct wake_q_head *wake_q,
 	if (msg_insert(sender->msg, info))
 		return;
 
-	list_del(&sender->list);
-	wake_q_add(wake_q, sender->task);
-	sender->state = STATE_READY;
+	__pipelined_op(wake_q, info, sender);
 }
 
 static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
-- 
2.21.0

