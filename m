Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80562C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFA7218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQEJzMsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfDXKVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32928 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbfDXKVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id h5so9088060pfo.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDO37esfHaDtszPueRakP7VqmTqFEoXaIhsG37nsoAI=;
        b=hQEJzMsYKZtntAo4S4k8JtJ8uneUYlnpOQmJnEUwS1KyIX+RgEnNREa7ZBGI2jADXO
         yIEn2yRZkYOsiqyog5F7SINQRXqh+8K3tqPSCq5Yri8W18KpukkLjlVUmO476kOeJSbM
         m6oJykhYhsOBSkoD16ZkDq+Rk85h6uvfVUNL6MNiZEjb9+KJ4ASdCl0kjMtqMECyu0X0
         mSBneySe6rhq5vtU8TA+u6cAD1eDorsuLodK0vIsJrIx4kwau2IgxPuuYhxjhgycSQVB
         e+BBhVeeZc2wugVffDFmukQ5G1W/zscJlto9WIZObPIzN86v/sfFZjDbtXLDZgiezv9v
         oxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDO37esfHaDtszPueRakP7VqmTqFEoXaIhsG37nsoAI=;
        b=Ltz4ZXEthVkJYbIDcJW3xCFszRc25H6qBAp5hEwyUv9Zx12mRH7vgSnE2SfgwI5gD8
         4ELmwx9eLexUABWeNznU777a41VYRcm2ATHpsOWlRcPnR1WDSA50OaA7kc+A7xP6xqOd
         62d4q517zQ3p1AQxKqx142K8SKW3P+aIfUz/6ctKox99Ww0odMRC49Mz8k0AHsd1srZV
         mEAizze35JmO1fUGGYcwT+WBUt9FpX/6yr5gv+BznCNNqgX9Tc1kSVXQGlihygu1wYsG
         d8ZdZruFMzdT44LP8CBbhKs7BJDQBMxcnjYCSwjgAZvOCs1UxsUQEcB2dHkwm4rTn68/
         cjLQ==
X-Gm-Message-State: APjAAAWNe7zQt+bvmlAPlJAGrdA9LtR+4AeNZtuTnyTGE0fzhN8qPGai
        TLMy7/uaGx/mbH9y0zuRjIY=
X-Google-Smtp-Source: APXvYqwh0oJV+Rv+WfIdmFEkKSBwJfXkCIFVLcFTTJK+a9sHOXtljSpTMNHjcClRG6t5uL0ty28tQA==
X-Received: by 2002:a65:4302:: with SMTP id j2mr29551718pgq.291.1556101270688;
        Wed, 24 Apr 2019 03:21:10 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:10 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 14/28] locking/lockdep: Avoid constant checks in __bfs by using offset reference
Date:   Wed, 24 Apr 2019 18:19:20 +0800
Message-Id: <20190424101934.51535-15-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 225eeeb..16f524c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1361,11 +1361,25 @@ static inline int get_lock_depth(struct lock_list *child)
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
@@ -1379,11 +1393,7 @@ static int __bfs(struct lock_list *source_entry,
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
 
@@ -1397,10 +1407,7 @@ static int __bfs(struct lock_list *source_entry,
 			goto exit;
 		}
 
-		if (forward)
-			head = &lock->class->locks_after;
-		else
-			head = &lock->class->locks_before;
+		head = get_dep_list(lock, offset);
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
@@ -1433,7 +1440,8 @@ static inline int __bfs_forwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 1);
+	return __bfs(src_entry, data, match, target_entry,
+		     offsetof(struct lock_class, locks_after));
 
 }
 
@@ -1442,7 +1450,8 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 0);
+	return __bfs(src_entry, data, match, target_entry,
+		     offsetof(struct lock_class, locks_before));
 
 }
 
-- 
1.8.3.1

