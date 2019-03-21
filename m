Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F316C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B0E218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLZq8L8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfCUH6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:58:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45826 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbfCUH6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:58:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so3657536pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dfCfOEPJnXrjKZNyGXOlfp7qK4c6wG8AdxQp4q9noKA=;
        b=WLZq8L8BdoGlwZbLh0l+o0poOxozL0k/PA7aeuqn9qQhY82y8pbLx4Z60FMPfvOEfs
         r6r67PuYKJUqQlU108D7JJ60uN8fx3vEHplSldfdRKNgKYpsLP6569s2h0GNeSGmEIMZ
         tJME8aFhKIZJNLxKsV5OjLIFtHQ34Oy+a6/xdmQpG0yLzKM8trMx85XPUABTGvJUWSCQ
         sdpFEnYjZbE0dZhbPd/+f5WzX+0dBYYaU3yzCtb7R+ml24EFavmNQiB/Pf2XDPUXXOnW
         /0k3bOgYqA8R/zMSm8msxA7fYyCFeqE4Ox1pDbTAVVdKrQzMm7dvOM5FU2CY2iSO5Ea6
         XK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dfCfOEPJnXrjKZNyGXOlfp7qK4c6wG8AdxQp4q9noKA=;
        b=RbE/DOVId8pMKCU/k+HoUwl3+/C3WHNH2D7kQnE3Lt6iKzrCMp4Q4qE16zMZV8AzFN
         vqAXqjqnipd+Suxcvc2jDCtmcUZzEX2c6e2voyUrJG28slWh8lVcVcgh445jyPVoP2Cb
         QReZkwZYBZhBA7zR2tKfJD2hskKjc8DohURSJyZdztUws4V+Nq+9SODbpjM+bzMYZ48b
         2P3YTziniDu8KuVod2y50cro6MMiVP/OmK3I7sTosk87osPE3wqNcXbgSrxiwsNZ+mLH
         izUE1D5UrKB9K7xGJq4UR4fLFPYDp3Lrjdq9g9bdKSggl48j6JNUtSosCppwpt+nl2hF
         fhfg==
X-Gm-Message-State: APjAAAVfJMbW7ZKANGdWieCpHnPIhS1qE2KBzx9A18EZ9lSgkGVEX/Bo
        H50kmyTGKeo9D684QYOixvM=
X-Google-Smtp-Source: APXvYqyHQ3r164fXgiwh0PcPJ5fSOkLUNTtZLqKLE1sUpJvAVA5CunZ4kRUtNiyTbkbJ4oArWRjIng==
X-Received: by 2002:a62:4649:: with SMTP id t70mr2125697pfa.100.1553155092538;
        Thu, 21 Mar 2019 00:58:12 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:58:12 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 13/18] locking/lockdep: Change type of the element field in circular_queue
Date:   Thu, 21 Mar 2019 15:57:20 +0800
Message-Id: <20190321075725.14054-14-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
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
index f46695a..8167d69 100644
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

