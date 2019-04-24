Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C2FC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA0A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTVzgqPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfDXKVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39501 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbfDXKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id e92so7285600plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDCj3vcYJ2ba6ECukipCJlwQYuaJnMKHKn0JgJNY2Z8=;
        b=UTVzgqPCPEmf//BD3SkIj838oTmXB4U6v1tISa/DwaP8JlbMEKUoxf6ZASLwWs0iWe
         +Zj2ueMi/tjejX3ZxsFDhUxIFbQtqTfFDp+dlUKOpHDSE2MEh3tb9084qUOyOxv96tS0
         NH8lZ4Svp/logoEakFBHzoQDtWJdfuCfhRDwUUUYlM0t4pNH40qkJDkbVQQVAfmh/xRc
         IgwTK7iF/obULiCzQpb8esPG16QdQUmwSLikXGfg/WyCRP/wJ+efclXFSBhxaFGFagqw
         LKFm/TncytRXwtQAK5RwAnT067T+vZRf4wOuSYQU/AlGgshYwkFzDyyaNJ4ukRNogXx3
         nnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDCj3vcYJ2ba6ECukipCJlwQYuaJnMKHKn0JgJNY2Z8=;
        b=JcxbBKjnRxTWA+FFkPWtCplX+6hj/BKuNAASIMDxm7NR+obcUoSU1YrRv0LeAPUz2M
         NugtDztO6me37gqHuFdr071bNza3psThENXFOATCjeO5KwMNRwNu1CNU58yfWmaB1C47
         cnrKeughg0OBUeFl2LCNDly0aMeN3LufKMwwv0XU59hjMjEwENKvXzkSro1JvDyiIMCn
         m89O0uuDyZwSDDtF6r/Avk1tsEgIsZGzq6ibVjAGJlX0PmTw24js8+e9PxET6NmqT8Ko
         fYFwJlCecq6WbEkqCsDf0wWcgHUVnRBvHAeDItpn5PCPGAkxinL5lypaWP6zK3GWsqb5
         gMmg==
X-Gm-Message-State: APjAAAXGsKVJvMDSOWLX2hBcUz36FA9jqP8SHkJZk2Kwytri7MnZaw2G
        5VQ2FjEv62jyKoffLw8klG0=
X-Google-Smtp-Source: APXvYqw+YsW4N2GNhk6FPGmMKHJRv22lyv55tbElxOENS7sruUMCKZ+nNYR80x6tc3jJU1qOIEpwWw==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr29988632pls.73.1556101308405;
        Wed, 24 Apr 2019 03:21:48 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:47 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 26/28] locking/lockdep: Remove __bfs
Date:   Wed, 24 Apr 2019 18:19:32 +0800
Message-Id: <20190424101934.51535-27-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is no need for backward dependecy searching, remove this
extra function layer.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 40 +++++++---------------------------------
 1 file changed, 7 insertions(+), 33 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 06ae87f..acaa3b3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1393,27 +1393,13 @@ static inline int get_lock_depth(struct lock_list *child)
 }
 
 /*
- * Return the forward or backward dependency list.
- *
- * @lock:   the lock_list to get its class's dependency list
- * @offset: the offset to struct lock_class to determine whether it is
- *          locks_after or locks_before
- */
-static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
-{
-	void *lock_class = lock->class;
-
-	return lock_class + offset;
-}
-
-/*
- * Forward- or backward-dependency search, used for both circular dependency
+ * Forward-dependency search, used for both circular dependency
  * checking and hardirq-unsafe/softirq-unsafe checking.
  */
-static int __bfs(struct lock_list *source_entry, void *data,
-		 int (*match)(struct lock_list *entry, void *data),
-		 struct lock_list **target_entry, int offset, int index,
-		 int distance, struct lock_class *safe_lock, bool reach)
+static int __bfs_forwards(struct lock_list *source_entry, void *data,
+			  int (*match)(struct lock_list *entry, void *data),
+			  struct lock_list **target_entry, int index,
+			  int distance, struct lock_class *safe_lock, bool reach)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1429,7 +1415,7 @@ static int __bfs(struct lock_list *source_entry, void *data,
 		goto exit;
 	}
 
-	head = get_dep_list(source_entry, offset);
+	head = &source_entry->class->locks_after;
 	if (list_empty(head))
 		goto exit;
 
@@ -1443,7 +1429,7 @@ static int __bfs(struct lock_list *source_entry, void *data,
 			goto exit;
 		}
 
-		head = get_dep_list(lock, offset);
+		head = &lock->class->locks_after;
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
@@ -1475,18 +1461,6 @@ static int __bfs(struct lock_list *source_entry, void *data,
 	return ret;
 }
 
-static inline int __bfs_forwards(struct lock_list *src_entry, void *data,
-				 int (*match)(struct lock_list *entry, void *data),
-				 struct lock_list **target_entry, int index,
-				 int distance, struct lock_class *safe_lock,
-				 bool reach)
-{
-	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_after),
-		     index, distance, safe_lock, reach);
-
-}
-
 static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
 {
 	unsigned long *entries = stack_trace + trace->offset;
-- 
1.8.3.1

