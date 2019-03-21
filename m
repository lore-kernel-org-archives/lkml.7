Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CD3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEEE218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlX3CG7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfCUH6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:58:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43417 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfCUH6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:58:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so3776643pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y7A7fEo+qJsIbgesbK8rzibOZD6lU/sqy8Uf3F36qfU=;
        b=VlX3CG7cfL/ThHGcRg8wwhYQFwMvWpMeCwxYbKmDayW2Sx1m3+Dw5vVTiO6/UnGmfH
         UY2MIzT61ffZbFqeC73pyhYZJ4AfDuNxND3NVJ9ayGCbdYims9HVvL00WgLRN6RiRnog
         kw07hoqlDI3b0by550pVQriD8L6yr8esQsWOZisPKrqJ4+Ge/k7C2zO+yi88hFwoiwHf
         r9TJiQpd9eixO6ctiNd/hG2jl0zegKCijAAXwrQIA5U08Am+F0qTHYyCJjPjVv5wUFT/
         96bvPko8uYL3+zhzWL+wh0RTr9CHhE2ZD2Cc44JrYeQq0fuFx//FJfNH1j+R1XN7Lwz9
         TQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y7A7fEo+qJsIbgesbK8rzibOZD6lU/sqy8Uf3F36qfU=;
        b=ikTXeXtTgrndwxrFoSzFcaA2XL3xrMPMbyGU/4LASTM2clwOQ1K/amFEHmzoINc7Yp
         +NzO0LZdzz2r5Avr6wpWI3PFXkugjcqL4/v4ptgPV2S6wTD77d+scNKXSzkDTL6yXJOC
         Je5hsv3ubdDBxIBcalbfF2m8FT9fwlIY3yUzJgw9VQ19ij9VsmB9AnrtxhFAsalzq8FG
         CNlBBnoou54SUHdBTh5A5vO/zL4FFMlJEZLdmwY7p47c8v4WcxbSWVABK/zGEP/v2TAr
         H0jjpoHMKEnG4Mzc7YpUgjglDPIh3lwTuWRB8CUO8zgAwMepn3HbbzBctE/4HzcsLYNv
         sLhw==
X-Gm-Message-State: APjAAAXzuLtaIwrzbEa6FWe2NqufsLmwxWekURe1kqEQSO1C9eKLa/k1
        MU9COpoqL+jSi+RUksW1ysM=
X-Google-Smtp-Source: APXvYqwKU92ih6Vyno/PcMOsoXywkvbRAV0jrIuQNLCMBbVFwuBQZgTcYBibsssF7FIW6i29G6kbCg==
X-Received: by 2002:a63:db07:: with SMTP id e7mr1954419pgg.231.1553155098291;
        Thu, 21 Mar 2019 00:58:18 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:58:17 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 15/18] locking/lockdep: Avoid constant checks in __bfs by using offset reference
Date:   Thu, 21 Mar 2019 15:57:22 +0800
Message-Id: <20190321075725.14054-16-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In search of a dependency in the lock graph, there is contant checks for
forward or backward search. Directly reference the field offset of the
struct that differentiates the type of search to avoid those checks.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ad16793..cd6792c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1376,11 +1376,25 @@ static inline int get_lock_depth(struct lock_list *child)
 	return depth;
 }
 
+/*
+ * Return the forward or backward dependency list.
+ *
+ * @lock:   the lock_list to get its class's dependency list
+ * @offset: the offset to struct lock_class to determine whether it is
+ *          locks_after or locks_before
+ */
+static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
+{
+	void *lock_class = lock->class;
+
+	return lock_class + offset;
+}
+
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
 		 struct lock_list **target_entry,
-		 int forward)
+		 int offset)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1394,11 +1408,7 @@ static int __bfs(struct lock_list *source_entry,
 		goto exit;
 	}
 
-	if (forward)
-		head = &source_entry->class->locks_after;
-	else
-		head = &source_entry->class->locks_before;
-
+	head = get_dep_list(source_entry, offset);
 	if (list_empty(head))
 		goto exit;
 
@@ -1412,10 +1422,7 @@ static int __bfs(struct lock_list *source_entry,
 			goto exit;
 		}
 
-		if (forward)
-			head = &lock->class->locks_after;
-		else
-			head = &lock->class->locks_before;
+		head = get_dep_list(lock, offset);
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
@@ -1448,7 +1455,8 @@ static inline int __bfs_forwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 1);
+	return __bfs(src_entry, data, match, target_entry,
+		     offsetof(struct lock_class, locks_after));
 
 }
 
@@ -1457,7 +1465,8 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 0);
+	return __bfs(src_entry, data, match, target_entry,
+		     offsetof(struct lock_class, locks_before));
 
 }
 
-- 
1.8.3.1

