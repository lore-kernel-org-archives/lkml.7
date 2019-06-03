Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B9C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA73523DAD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="G0f3Vdfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfFCNOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:14:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55873 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfFCNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:14:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DEMcx605757
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:14:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DEMcx605757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567663;
        bh=YMOaWVtCuTf4DTXyXnbf868JNqRHvjnYx2EObBND7aI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=G0f3VdfkqrjixoI+CY6onTUNl23AYCD2G6DkFe1Yld+GL3SzhfILRbcv2XtEGhVzr
         6igJgDeFTNIJRdD4H79kAljRAOxulQJTRgzb0Iet9kbl60uc8zp/uk9iS8SWXiRSVS
         BXUsUKmIpyAOvhAvSCRC9VIFMtw438mp/n4/dcqItS83suHDl121PLQWORSR0Mplis
         Yqs5E/Y663L4b0jJx8DvJ/g3CJcl84QKc6wWhgY6W4L7aVppFhXeW91RysbHqy7gJ2
         ld2ch8Mi/pQtFjmMBw/coBDFHhhetCV2i2/fxLZd/r/rKaE7V4ovt4sMpGqt8NZp7M
         0oxMarTQaw+Tw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DEM7d605754;
        Mon, 3 Jun 2019 06:14:22 -0700
Date:   Mon, 3 Jun 2019 06:14:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-aa4807719e076bfb2dee9c96adf2c648e47d472f@git.kernel.org>
Cc:     bvanassche@acm.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, duyuyang@gmail.com
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          bvanassche@acm.org, linux-kernel@vger.kernel.org,
          duyuyang@gmail.com
In-Reply-To: <20190506081939.74287-13-duyuyang@gmail.com>
References: <20190506081939.74287-13-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Change type of the element
 field in circular_queue
Git-Commit-ID: aa4807719e076bfb2dee9c96adf2c648e47d472f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  aa4807719e076bfb2dee9c96adf2c648e47d472f
Gitweb:     https://git.kernel.org/tip/aa4807719e076bfb2dee9c96adf2c648e47d472f
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:28 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:45 +0200

locking/lockdep: Change type of the element field in circular_queue

The element field is an array in struct circular_queue to keep track of locks
in the search. Making it the same type as the locks avoids type cast. Also
fix a typo and elaborate the comment above struct circular_queue.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-13-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a9799f9ed093..d467ba825dca 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1262,13 +1262,17 @@ static int add_lock_to_list(struct lock_class *this,
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
 
@@ -1294,7 +1298,7 @@ static inline int __cq_full(struct circular_queue *cq)
 	return ((cq->rear + 1) & CQ_MASK) == cq->front;
 }
 
-static inline int __cq_enqueue(struct circular_queue *cq, unsigned long elem)
+static inline int __cq_enqueue(struct circular_queue *cq, struct lock_list *elem)
 {
 	if (__cq_full(cq))
 		return -1;
@@ -1304,7 +1308,7 @@ static inline int __cq_enqueue(struct circular_queue *cq, unsigned long elem)
 	return 0;
 }
 
-static inline int __cq_dequeue(struct circular_queue *cq, unsigned long *elem)
+static inline int __cq_dequeue(struct circular_queue *cq, struct lock_list **elem)
 {
 	if (__cq_empty(cq))
 		return -1;
@@ -1382,12 +1386,12 @@ static int __bfs(struct lock_list *source_entry,
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
@@ -1411,7 +1415,7 @@ static int __bfs(struct lock_list *source_entry,
 					goto exit;
 				}
 
-				if (__cq_enqueue(cq, (unsigned long)entry)) {
+				if (__cq_enqueue(cq, entry)) {
 					ret = -1;
 					goto exit;
 				}
