Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C399C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE0D25088
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Bm3XqfXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfFCNPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:15:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbfFCNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:15:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DF7P7606021
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:15:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DF7P7606021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567707;
        bh=p0X1AcJdJsIH9G1aM0A4a9ivY9INZIElMqFTamOmf8A=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Bm3XqfXzkExifPlghCK5WVJ1HKcULIBePGjx8gXu/sJYxoFJVVZBKxHDcQ7S7J4F7
         3kklfYSARpHAyaB7Y+l/bv3jAe14td2b403zF8/xtg/mvPMLUtCilaK4DdVLCyvJK7
         cPHyQpsrKV2W+cDr4CgQDdSXd6vtsdEoW5QwkZ4YHIdHsHoPZYxlzJAbvnZwcDo9Xa
         ciriEoCAyNSxkHmKWgOvIMus6+2DwT5f5JYlQP6berbVQzwvrZUN5Is1+sjdOveYcK
         vkCCKhFP4k+LRzfZhm0oVFAqI7j/IFYiYoYy9/wpWBTBha0KPYrbGLOG4uY1N3zMqf
         yiAhrE475+Ffw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DF6PX606015;
        Mon, 3 Jun 2019 06:15:06 -0700
Date:   Mon, 3 Jun 2019 06:15:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-c1661325597f68bc9e632c4fa9c86983d56fba4f@git.kernel.org>
Cc:     duyuyang@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, hpa@zytor.com
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          mingo@kernel.org, duyuyang@gmail.com, hpa@zytor.com
In-Reply-To: <20190506081939.74287-14-duyuyang@gmail.com>
References: <20190506081939.74287-14-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Change the return type of
 __cq_dequeue()
Git-Commit-ID: c1661325597f68bc9e632c4fa9c86983d56fba4f
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

Commit-ID:  c1661325597f68bc9e632c4fa9c86983d56fba4f
Gitweb:     https://git.kernel.org/tip/c1661325597f68bc9e632c4fa9c86983d56fba4f
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:29 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:46 +0200

locking/lockdep: Change the return type of __cq_dequeue()

With the change, we can slightly adjust the code to iterate the queue in BFS
search, which simplifies the code. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-14-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d467ba825dca..d23dcb47389e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1308,14 +1308,21 @@ static inline int __cq_enqueue(struct circular_queue *cq, struct lock_list *elem
 	return 0;
 }
 
-static inline int __cq_dequeue(struct circular_queue *cq, struct lock_list **elem)
+/*
+ * Dequeue an element from the circular_queue, return a lock_list if
+ * the queue is not empty, or NULL if otherwise.
+ */
+static inline struct lock_list * __cq_dequeue(struct circular_queue *cq)
 {
+	struct lock_list * lock;
+
 	if (__cq_empty(cq))
-		return -1;
+		return NULL;
 
-	*elem = cq->element[cq->front];
+	lock = cq->element[cq->front];
 	cq->front = (cq->front + 1) & CQ_MASK;
-	return 0;
+
+	return lock;
 }
 
 static inline unsigned int  __cq_get_elem_count(struct circular_queue *cq)
@@ -1367,6 +1374,7 @@ static int __bfs(struct lock_list *source_entry,
 		 int forward)
 {
 	struct lock_list *entry;
+	struct lock_list *lock;
 	struct list_head *head;
 	struct circular_queue *cq = &lock_cq;
 	int ret = 1;
@@ -1388,10 +1396,7 @@ static int __bfs(struct lock_list *source_entry,
 	__cq_init(cq);
 	__cq_enqueue(cq, source_entry);
 
-	while (!__cq_empty(cq)) {
-		struct lock_list *lock;
-
-		__cq_dequeue(cq, &lock);
+	while ((lock = __cq_dequeue(cq))) {
 
 		if (!lock->class) {
 			ret = -2;
