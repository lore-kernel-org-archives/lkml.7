Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E31C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844952175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="modEms7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfDXKWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:22:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39631 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbfDXKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id l18so9032719pgj.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B0zIug3byHnqFY6zU5sDm8sMZPCbIfr9tms2OJ2D7bM=;
        b=modEms7kAWuIj4U05MaCKH7+t44MS4tmNh9qXirSBnDawIXj80b+oBRyWdBq4FAqhY
         DVZtrlSdsbVTGZ/zwaBSpxdw1cLq78S/Scury6erBjmLOvNN8N+AW3/X7FccCfj1ISOk
         tT1kMgBvG6j9axARhFrRvIeHtM4X/AvUH6JSUIDlQqiRigh/dJck72uTU4cvVKQbUeSH
         J2Hy4KM8XgYB1aVqGYG7Jp4GhKVXzA09toczw4zhN5anRwaKR+uKjJo4w+z5JwxmsZc9
         jMTQnyDa/bFLN3oMXMGcc9x8LSc58Nil67MuTtzyK5iKvBvEaIBIAw5d2XCBlXQE6cYU
         7upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B0zIug3byHnqFY6zU5sDm8sMZPCbIfr9tms2OJ2D7bM=;
        b=BwR8AxNOWu0cs1Woe/7mywVDaCsU+FGJm2lFlJhdaeFeo/qbVMcFBzTZFYFnrVhC6d
         aFiLmWQfnJog/X4ToXgcAkOY+DgF/Z00Yi452w6jBg13z/IKctWJafuW+lhouAgEOnyu
         qVLzydRKFwPLeYB2TG5IwbeComfILOrHT9Yij4F6kgTNdgqkIyYisXdWIxkRU4VesyEj
         pKXkXAPxSVXCFzSBKLGCoyMZANOUB+xzPRfZY6pvfi8m7/9mGFSarkrR1/RKeOnoVg/a
         oS2Za9b3LXEGyWiBmukAvqi9v5VKmB9rvWRVOpXo26WhYuVtbvoSn2jYdfSh4YGg+5/D
         5XeA==
X-Gm-Message-State: APjAAAWOZzACbFgU24AAes8EAWqFrea4qGOvPpvJVbyQjCum7Z8zUE0r
        a8W1p/xLUoyOWxfoq/Z/9GA=
X-Google-Smtp-Source: APXvYqwp/8i/93ZcWbvz97SgnSDfEddtsPMSbrzjjyrxYwl9wVDLkdUVa44/84qlNUVhiFe2oRztrw==
X-Received: by 2002:a62:6c43:: with SMTP id h64mr32818844pfc.123.1556101264605;
        Wed, 24 Apr 2019 03:21:04 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:04 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 12/28] locking/lockdep: Change type of the element field in circular_queue
Date:   Wed, 24 Apr 2019 18:19:18 +0800
Message-Id: <20190424101934.51535-13-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The element field is an array in struct circular_queue to keep track of locks
in the search. Making it the same type as the locks avoids type cast. Also
fix a typo and elaborate the comment above struct circular_queue.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0543872..683aaf60 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1257,13 +1257,16 @@ static int add_lock_to_list(struct lock_class *this,
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
 
@@ -1289,7 +1292,7 @@ static inline int __cq_full(struct circular_queue *cq)
 	return ((cq->rear + 1) & CQ_MASK) == cq->front;
 }
 
-static inline int __cq_enqueue(struct circular_queue *cq, unsigned long elem)
+static inline int __cq_enqueue(struct circular_queue *cq, struct lock_list *elem)
 {
 	if (__cq_full(cq))
 		return -1;
@@ -1299,7 +1302,7 @@ static inline int __cq_enqueue(struct circular_queue *cq, unsigned long elem)
 	return 0;
 }
 
-static inline int __cq_dequeue(struct circular_queue *cq, unsigned long *elem)
+static inline int __cq_dequeue(struct circular_queue *cq, struct lock_list **elem)
 {
 	if (__cq_empty(cq))
 		return -1;
@@ -1377,12 +1380,12 @@ static int __bfs(struct lock_list *source_entry,
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
@@ -1406,7 +1409,7 @@ static int __bfs(struct lock_list *source_entry,
 					goto exit;
 				}
 
-				if (__cq_enqueue(cq, (unsigned long)entry)) {
+				if (__cq_enqueue(cq, entry)) {
 					ret = -1;
 					goto exit;
 				}
-- 
1.8.3.1

