Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89BAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7088720857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqGLcFsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfCRI63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35286 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfCRI60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so261478pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z1HnwHwgfeXQ7XP8WlaW6BcJ+08knK59sSP1bt+0T7A=;
        b=kqGLcFsDQ/VXqFdsppizRx9pVyQR7Kq9nE6zuYHPFtK0Nszdxf0OU3EYFrIbbEWoYf
         G2Y2j8zuxgEqGz9kFiHHfR1mgUI7Yim5pNsIt4x5fcJtYNNEpT2l28n3HY8KMIaZoKeY
         slzICrNyfwypOinG8IpfEnkBjCmhQHIgxbAOAyYIl8mJ6o45mksFUdvZGBW65lmOW47S
         +6mtYFQLuMkjEsBWXt3mXj7h9WAOZ2BTYdvdjKqddG5rBsc3imZ4a90nNRsTvbyfd6Nj
         3iz6zr7vg2AHHqaeN8jDiiWZBA6JrXVPhFua8d+VkBH2QdLIeSnp1bMkm6e04yuUfom8
         urMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z1HnwHwgfeXQ7XP8WlaW6BcJ+08knK59sSP1bt+0T7A=;
        b=c8WMlQCSIwo4VCqKLsKdFFnyRdFtpc3sDpTY10+EmfkfUm7HH7A8szp2LDznCQ0oNO
         Ow0QWB2l5L83ZJdg0FD3fICziwJ+AV5sdyZNSTf39vZxW5NUZ6+SkWa9GtQBrptHv/+N
         dXH8/A0GhL75KLfYGXgmQqhz1i4PppuxBpMauAW5c8v55QuqDr3lxe0JjDPSFA+TEo/Z
         NthyghquceEjwTKsi38Q5fnP0IT9jeOzqt+LvesNsEN1JsSaDCWokLgy0xL2tILjq6YC
         0HgB7WiGXYfl7zM5BZZ6qnojIumQfrHE7hCKdRtWtfElVdfcMkTyhZ+vEC+H7lguXza8
         0feg==
X-Gm-Message-State: APjAAAXnQikidU3icTbdspFg7/9eYqmxaVGaU4txleQbd9vHgjWElfFD
        IXgqzm8FfLZZ/xBNuMMVeZY=
X-Google-Smtp-Source: APXvYqyW+lqdfDH2wzDBzX/OjmS2Ow8LPQmL3Jsir+nrpxkDLXmsVTuhFNZvmUr1Jaxa0qoL267tiA==
X-Received: by 2002:aa7:9143:: with SMTP id 3mr18070202pfi.238.1552899505728;
        Mon, 18 Mar 2019 01:58:25 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:25 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 15/19] locking/lockdep: Remove __cq_empty()
Date:   Mon, 18 Mar 2019 16:57:29 +0800
Message-Id: <20190318085733.3143-16-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__cq_empty() can be embeded in __cq_dequeue(), removing it. We get slightly
simpler code. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a3fb112..ee8fe64 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1297,11 +1297,6 @@ static inline void __cq_init(struct circular_queue *cq)
 	lockdep_dependency_gen_id++;
 }
 
-static inline int __cq_empty(struct circular_queue *cq)
-{
-	return (cq->front == cq->rear);
-}
-
 static inline int __cq_full(struct circular_queue *cq)
 {
 	return ((cq->rear + 1) & CQ_MASK) == cq->front;
@@ -1317,14 +1312,24 @@ static inline int __cq_enqueue(struct circular_queue *cq, struct lock_list *elem
 	return 0;
 }
 
-static inline int __cq_dequeue(struct circular_queue *cq, struct lock_list **elem)
+/*
+ * Dequeue an element from the circular_queue, return the lock if the queue
+ * is not empty, or NULL if otherwise
+ */
+static inline struct lock_list * __cq_dequeue(struct circular_queue *cq)
 {
-	if (__cq_empty(cq))
-		return -1;
+	struct lock_list * lock;
 
-	*elem = cq->element[cq->front];
+	/*
+	 * Is the circular_queue empty?
+	 */
+	if (cq->front == cq->rear)
+		return NULL;
+
+	lock = cq->element[cq->front];
 	cq->front = (cq->front + 1) & CQ_MASK;
-	return 0;
+
+	return lock;
 }
 
 static inline unsigned int  __cq_get_elem_count(struct circular_queue *cq)
@@ -1376,6 +1381,7 @@ static int __bfs(struct lock_list *source_entry,
 		 int forward)
 {
 	struct lock_list *entry;
+	struct lock_list *lock;
 	struct list_head *head;
 	struct circular_queue *cq = &lock_cq;
 	int ret = 1;
@@ -1397,10 +1403,7 @@ static int __bfs(struct lock_list *source_entry,
 	__cq_init(cq);
 	__cq_enqueue(cq, source_entry);
 
-	while (!__cq_empty(cq)) {
-		struct lock_list *lock;
-
-		__cq_dequeue(cq, &lock);
+	while ((lock = __cq_dequeue(cq))) {
 
 		if (!lock->class) {
 			ret = -2;
-- 
1.8.3.1

