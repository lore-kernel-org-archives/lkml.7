Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD35C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21409218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfe0aSmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfCUH6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:58:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36717 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbfCUH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:58:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id p10so3797689pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rrxP6v+2lHMkCgAoQ19mxfczpqRbnf20CLXAc3lvVaA=;
        b=Yfe0aSmNuUQCCIOJcuTUO7ldovYy7X85yJQDCU/UQm7f+bzIef2d+Iuxx6el1kmABO
         v92fEfOskbiNPQmZZiTnG3ZNWrWEIm8hLcwHaLAR4OEzuQeeNkfKt85sr+7CGgCTrbSB
         t62xg6BBsQsmgfiivAbmOacF7P6xrPF7/92LUahGBggpcdXN+VC7kE4hXPS4Cp6TDNJA
         upPPcj6IXFd4lfTDgDU1wkms07/WqYtACvqGDQBBgPLhHHdwFRA1lrx3/D81CuDroVDk
         Wc281eIDZck6Y20bigYLOIcQhCmJViXDVnKj6OqnuS10AoiZxAg/YHh5zU4BPUthOeMD
         CiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rrxP6v+2lHMkCgAoQ19mxfczpqRbnf20CLXAc3lvVaA=;
        b=gcfdsnC1XFzDrOaZmF9lJP8hxyaJxCoNeSPlbro5dnZxMZdm46FYETQJ60dlRFKvEy
         a7g6faDZ78HVXBJqXqD3AoSml1cTHEBj8Y2ZYyOBpCgL1n+obG0gMS1A1qcARoxoOD0b
         CDY8feQWJ2p39ep2b+HXiDSBv+fz4BCLpNbwJkOjAWvF7KAersqIJhPKATXfganuFKkE
         8cEA0Q7NJllkxy5aC0n8CvtvnU9Xhpcp9QXOzwBQQ+j/Ki8kl7hMmycaAQ3QWCg4gHOv
         ykFv8lYQ5LwpXDtXVFREA5NjFwq5+lVY9kZmKiaQfq1iFlEyFMAKFieNCOKqOdYXEKqb
         NM9A==
X-Gm-Message-State: APjAAAXMXtFEh0ohmqO0o2PjX2WXJSvuG/zecnqcu9tP3Z6PgeJ4jwD3
        hSLPhyY69tCHnLaF9T/pWYI=
X-Google-Smtp-Source: APXvYqyVEbZOOY7vYJKutyCH0jQr/JIfi31jum1lfKkZqj2mYD3lS0/3kQvWA6wuUKqoME6h6geIHA==
X-Received: by 2002:a62:ae13:: with SMTP id q19mr2028836pff.152.1553155095423;
        Thu, 21 Mar 2019 00:58:15 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:58:15 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 14/18] locking/lockdep: Change the return type of __cq_dequeue()
Date:   Thu, 21 Mar 2019 15:57:21 +0800
Message-Id: <20190321075725.14054-15-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the change, we can slightly adjust the code to iterate the queue in BFS
search, which simplifies the code. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8167d69..ad16793 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1317,14 +1317,21 @@ static inline int __cq_enqueue(struct circular_queue *cq, struct lock_list *elem
 	return 0;
 }
 
-static inline int __cq_dequeue(struct circular_queue *cq, struct lock_list **elem)
+/*
+ * Dequeue an element from the circular_queue, return the lock if the queue
+ * is not empty, or NULL if otherwise
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
@@ -1376,6 +1383,7 @@ static int __bfs(struct lock_list *source_entry,
 		 int forward)
 {
 	struct lock_list *entry;
+	struct lock_list *lock;
 	struct list_head *head;
 	struct circular_queue *cq = &lock_cq;
 	int ret = 1;
@@ -1397,10 +1405,7 @@ static int __bfs(struct lock_list *source_entry,
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

