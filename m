Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB05C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D732082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv00WVo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfEFIUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44636 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfEFIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id z16so6081048pgv.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8oVvJ9mj35Lp12Pvnx1rYrM9wXOWQruIs8G8w3waPxY=;
        b=Hv00WVo5hgfQYhK/g33jV6jD7uZtD18fCtp+V11I//o27F4G8pmpRuSwdCRafyPyfB
         1MU7A0CyOcwqTjHClv/SFN4ufVwl6aBkI5MTpN1NYpQcvxWxhMRJZ1oPz3G13M8cW/Ji
         vUZjnqVk7fEuuDLl2DDs1chBHRoh8VcuIes3CI/RFayxbjxEkg4x3O0+8GLxcq5P00Z8
         SWdfy0R+j87dkZ1m8F8OyL/u58D0NfJ0DDz2x73RZNUO9bPfr2s2qv0oSCBbh+Yb2efT
         +l1rEWiXqVOlReGOh5LmOW3iJQHJPGJ8MphZv/LO2b42oijB4puz0duKNSLEXOtVkVCS
         EXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8oVvJ9mj35Lp12Pvnx1rYrM9wXOWQruIs8G8w3waPxY=;
        b=UuH6qKsZiEgoPSh9rml4KymPgfczHPk0INflsxaqPPPwffFgQEBxTYwUwHEOVXZ+63
         DoW64rdb/jLIIqoPufeZHFpIHTser6TgEHlIw3JEjEAv0oIDHFe3ULzcLejUDfdB9nuN
         JtWbOeRJsW0YIAv7TsjOwoUFOVI350fhEOK6tWxsW1Q307M9XZfRSBaaktl1x8eMbtz4
         uvf1D/wmaFiVQE/gr/5hh7sQzAnFm6vwGNBcIIt2w0pea6WkzXkzG9eFUup5JMiQXdmI
         hlnoYOGk0rWCTJ79bTN3VS891J2aCa0O95TjU/t/CyqfwNml+fxtLfIatIzX8XreXwzZ
         47gg==
X-Gm-Message-State: APjAAAWV7VbnDuLrXrqys0QcNnKvNSQw1jM6Ds8WIotEkmFluw1FyZG3
        lNQ5oZQ8Whejbrqs+bH6GeY=
X-Google-Smtp-Source: APXvYqwPwveOBDJYOjJvpw5a2qU/GjOSBqZJeYG8THQe/E81zIH4QtChGC6q60P84cHzN+vUlRKt9g==
X-Received: by 2002:a62:4602:: with SMTP id t2mr31626278pfa.26.1557130827633;
        Mon, 06 May 2019 01:20:27 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:27 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 12/23] locking/lockdep: Change type of the element field in circular_queue
Date:   Mon,  6 May 2019 16:19:28 +0800
Message-Id: <20190506081939.74287-13-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
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

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b8e6ba3..eb8b190 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1257,13 +1257,17 @@ static int add_lock_to_list(struct lock_class *this,
 #define CQ_MASK				(MAX_CIRCULAR_QUEUE_SIZE-1)
 
 /*
- * The circular_queue and helpers is used to implement the
- * breadth-first search(BFS)algorithem, by which we can build
- * the shortest path from the next lock to be acquired to the
- * previous held lock if there is a circular between them.
+ * The circular_queue and helpers are used to implement graph
+ * breadth-first search (BFS) algorithm, by which we can determine
+ * whether there is a path from a lock to another. In deadlock checks,
+ * a path from the next lock to be acquired to a previous held lock
+ * indicates that adding the <prev> -> <next> lock dependency will
+ * produce a circle in the graph. Breadth-first search instead of
+ * depth-first search is used in order to find the shortest (circular)
+ * path.
  */
 struct circular_queue {
-	unsigned long element[MAX_CIRCULAR_QUEUE_SIZE];
+	struct lock_list *element[MAX_CIRCULAR_QUEUE_SIZE];
 	unsigned int  front, rear;
 };
 
@@ -1289,7 +1293,7 @@ static inline int __cq_full(struct circular_queue *cq)
 	return ((cq->rear + 1) & CQ_MASK) == cq->front;
 }
 
-static inline int __cq_enqueue(struct circular_queue *cq, unsigned long elem)
+static inline int __cq_enqueue(struct circular_queue *cq, struct lock_list *elem)
 {
 	if (__cq_full(cq))
 		return -1;
@@ -1299,7 +1303,7 @@ static inline int __cq_enqueue(struct circular_queue *cq, unsigned long elem)
 	return 0;
 }
 
-static inline int __cq_dequeue(struct circular_queue *cq, unsigned long *elem)
+static inline int __cq_dequeue(struct circular_queue *cq, struct lock_list **elem)
 {
 	if (__cq_empty(cq))
 		return -1;
@@ -1377,12 +1381,12 @@ static int __bfs(struct lock_list *source_entry,
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
@@ -1406,7 +1410,7 @@ static int __bfs(struct lock_list *source_entry,
 					goto exit;
 				}
 
-				if (__cq_enqueue(cq, (unsigned long)entry)) {
+				if (__cq_enqueue(cq, entry)) {
 					ret = -1;
 					goto exit;
 				}
-- 
1.8.3.1

