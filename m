Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CFEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A224020857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogsYye/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCRI6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37519 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfCRI6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so7401493pfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wdiUfVDE3WLt8JxKjWsZM/JvS9h1apw7CblGhVbEEzc=;
        b=ogsYye/xYmdSTq4QXr18tedTvEMpfutXREYmd6X3LyHuuFzTCaGFCea4jOGiyxdhhS
         FSRUsGwItYH/uUlKDfs6GNsFUeikzelD8tsOp8mFdpCAfgkpvRNVusnjjNjDQgN/v1Je
         AhSqzwVtTym5/nI+LHLG4Af3tI1B8wyTiSaVPqbqUuKEpFpvHKSYKIzQsJYln/KrOG/q
         WOG8Fa4vm4lblV+TFwqvL4YtRl91B0Ql2oawJ/88RpjFDpaUfMFm4Xsfk10dpQreYdj0
         vtZ6jyJpky3Mfu9UldBKvYF8gs2leUB3MewZ8IQu3TW2O+Bwlu6f03wue88p9s9lb7r/
         VBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wdiUfVDE3WLt8JxKjWsZM/JvS9h1apw7CblGhVbEEzc=;
        b=S4mSz6ZCUqLYHUX/DI+Bq2vNdMwShfJgm+dhMR4VP7cryY4t0EAByiD+HDdrBAf4s9
         1y74aUtWk9jTqWL70ACPNy26v8G15PWqIHTFbFKZs7cEo1YQUhXomsC2+CqvVsMgrTy3
         RodN7rB2XQ6fHL4BjzVqdCtEZp/8DmXzxz9oMxRGQrHAoYYap4Z4o+C2ZaY2uZXWimHh
         0f0LxjlWgoEeL2HNzjwyjfs9UHldrxZbGI+20pqUWNhZnLmjKMiNIl7G7W9468VcrEct
         i+kxF7UpRrNbIdNpMy5QYHzp7r7QVW2aD1z6b26mEaPzljhhrnrpD3wWaH9xS1fWUrN3
         yejw==
X-Gm-Message-State: APjAAAXo8dhNu2XiSGu8WFUD45zrFdQjSyLbZ3yy/E3HEqHELcJduw2o
        XtFyXrgjUiKG4LnAP29rppE=
X-Google-Smtp-Source: APXvYqwB7TYrc2F+epB9tAKv7Ea3JPnz8dBvuERQ4/f9yjQI0BjDYp9xthMMH1Hx149wXvC4XAfWsQ==
X-Received: by 2002:a17:902:e5:: with SMTP id a92mr18419897pla.326.1552899502860;
        Mon, 18 Mar 2019 01:58:22 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:22 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 14/19] locking/lockdep: Change type of the element field in circular_queue
Date:   Mon, 18 Mar 2019 16:57:28 +0800
Message-Id: <20190318085733.3143-15-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The element field is an array in struct circular_queue to keep track of locks
in the search. Making it the same type as the locks avoids type cast.  Also
fix a typo.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index de731b8..a3fb112 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1272,13 +1272,16 @@ static int add_lock_to_list(struct lock_class *this,
 #define CQ_MASK				(MAX_CIRCULAR_QUEUE_SIZE-1)
 
 /*
- * The circular_queue and helpers is used to implement the
- * breadth-first search(BFS)algorithem, by which we can build
- * the shortest path from the next lock to be acquired to the
- * previous held lock if there is a circular between them.
+ * The circular_queue and helpers are used to implement the graph
+ * breadth-first search (BFS) algorithm, by which we can determine whether
+ * there is a path from the next lock to be acquired to a previous held
+ * lock, which indicates that adding the <prev> -> <next> lock dependency
+ * produces a circle in the lock dependency graph. Breadth-first search
+ * instead of depth-first search is used for finding the shortest circular
+ * path.
  */
 struct circular_queue {
-	unsigned long element[MAX_CIRCULAR_QUEUE_SIZE];
+	struct lock_list *element[MAX_CIRCULAR_QUEUE_SIZE];
 	unsigned int  front, rear;
 };
 
@@ -1304,7 +1307,7 @@ static inline int __cq_full(struct circular_queue *cq)
 	return ((cq->rear + 1) & CQ_MASK) == cq->front;
 }
 
-static inline int __cq_enqueue(struct circular_queue *cq, unsigned long elem)
+static inline int __cq_enqueue(struct circular_queue *cq, struct lock_list *elem)
 {
 	if (__cq_full(cq))
 		return -1;
@@ -1314,7 +1317,7 @@ static inline int __cq_enqueue(struct circular_queue *cq, unsigned long elem)
 	return 0;
 }
 
-static inline int __cq_dequeue(struct circular_queue *cq, unsigned long *elem)
+static inline int __cq_dequeue(struct circular_queue *cq, struct lock_list **elem)
 {
 	if (__cq_empty(cq))
 		return -1;
@@ -1392,12 +1395,12 @@ static int __bfs(struct lock_list *source_entry,
 		goto exit;
 
 	__cq_init(cq);
-	__cq_enqueue(cq, (unsigned long)source_entry);
+	__cq_enqueue(cq, source_entry);
 
 	while (!__cq_empty(cq)) {
 		struct lock_list *lock;
 
-		__cq_dequeue(cq, (unsigned long *)&lock);
+		__cq_dequeue(cq, &lock);
 
 		if (!lock->class) {
 			ret = -2;
@@ -1421,7 +1424,7 @@ static int __bfs(struct lock_list *source_entry,
 					goto exit;
 				}
 
-				if (__cq_enqueue(cq, (unsigned long)entry)) {
+				if (__cq_enqueue(cq, entry)) {
 					ret = -1;
 					goto exit;
 				}
-- 
1.8.3.1

