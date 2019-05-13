Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F8AC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD1D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZPIZYsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfEMJNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:13:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33247 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfEMJNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so6468459pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XS9V02iwZYKFW5YWeFlYklsBy1zrilgFnTAf30fgF0A=;
        b=uZPIZYsT+WwBmM+dEpOWvv+if6ZEsfz0OoX9iStJUwS+5SgYY2cY0jzl+TMOVjNgBU
         rvfmz5Zdingo92huXzKGecngdxt/S6SB30nE5aJPVV8nKmF80KsS3cmE30YYhuQK4hsh
         ukTXvM5GZ3KLi7SOU6sjXFOTX/ESwS3T4+efjGvQrXZPYXx0G8yo8xSyjoWIet1j1vuI
         YiF53pIg+HLf7ZCMO8q2XUCw77OiBlRYcK2yws6KIv48MZxuYH8UHKv1P9ERdPhk/6RI
         Y3VtQMqeq8eQjfxyCO0QbUuhHyKfPe0hXOsV/BGAEIl+XcuaKYoS4tV8vR0uLUALVYlx
         PEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XS9V02iwZYKFW5YWeFlYklsBy1zrilgFnTAf30fgF0A=;
        b=CK1qIsDyxiUyB6nS6YxKFqMhHgRBClUU5ag04LfAsK+ki/xGQEorDE3ICJ5HM2OZO/
         jV2p4oUzDviA7p5hsmAfhpGbvyjqXzyccjiD/P7k4UCao5g+Cl82tXIHT7DyXsk0bfoe
         ESTTdeGxq/v6KZ4DsC35ht3xl+iDCtIC1tgzEsF8lSwl+rWXM7r4kDiRZdRCNIz8EPK6
         3d5XD0cMak8N0cXd2sTTTrmaMAG/bte86oSLWrXpMfiIGoWHq0hRJod3SAfWJ9hzf2Mr
         LTh1RGYghcRmhG29PEQJwkfjGFbmKHX9HEnOLh8ROP8PHSX+pO3D6R6hPrHrgzUGzYPG
         BLmQ==
X-Gm-Message-State: APjAAAU/vglR+3+Jb8JsfariQUOs21bdEouL32QnmVRi+Ei7onTuiZ0Y
        1Cug2+XcR+ytpX91lKGjI1U=
X-Google-Smtp-Source: APXvYqzCoHagyMxXoP4fm9/OQMr5LuvfsBTF/9tPj3Uz6fPwbrHjK+dD43TlfoxZ6njNXOOpwQOgzw==
X-Received: by 2002:a63:5421:: with SMTP id i33mr29972820pgb.257.1557738817085;
        Mon, 13 May 2019 02:13:37 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:13:36 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 06/17] locking/lockdep: Adjust BFS algorithm to support multiple matches
Date:   Mon, 13 May 2019 17:11:52 +0800
Message-Id: <20190513091203.7299-7-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With read locks, circle is not sufficient condition for a deadlock. As a
result, we need to continue the search after a match but the match is not
wanted. __bfs() is adjusted to that end. The basic idea is to enqueue a
node's children before matching the node.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 54 +++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4adaf27..4d96bdd 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1417,7 +1417,7 @@ static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
 		 struct lock_list **target_entry,
-		 int offset)
+		 int offset, bool init)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1425,19 +1425,11 @@ static int __bfs(struct lock_list *source_entry,
 	struct circular_queue *cq = &lock_cq;
 	int ret = 1;
 
-	if (match(source_entry, data)) {
-		*target_entry = source_entry;
-		ret = 0;
-		goto exit;
+	if (init) {
+		__cq_init(cq);
+		__cq_enqueue(cq, source_entry);
 	}
 
-	head = get_dep_list(source_entry, offset);
-	if (list_empty(head))
-		goto exit;
-
-	__cq_init(cq);
-	__cq_enqueue(cq, source_entry);
-
 	while ((lock = __cq_dequeue(cq))) {
 
 		if (!lock->class) {
@@ -1449,25 +1441,34 @@ static int __bfs(struct lock_list *source_entry,
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
+		/*
+		 * Enqueue a node's children before match() so that even
+		 * this node matches but is not wanted, we can continue
+		 * the search.
+		 */
 		list_for_each_entry_rcu(entry, head, entry) {
 			if (!lock_accessed(entry)) {
 				unsigned int cq_depth;
+
 				mark_lock_accessed(entry, lock);
-				if (match(entry, data)) {
-					*target_entry = entry;
-					ret = 0;
-					goto exit;
-				}
 
 				if (__cq_enqueue(cq, entry)) {
 					ret = -1;
 					goto exit;
 				}
+
 				cq_depth = __cq_get_elem_count(cq);
 				if (max_bfs_queue_depth < cq_depth)
 					max_bfs_queue_depth = cq_depth;
 			}
 		}
+
+		if (match(lock, data)) {
+			*target_entry = lock;
+			ret = 0;
+			goto exit;
+		}
+
 	}
 exit:
 	return ret;
@@ -1476,10 +1477,10 @@ static int __bfs(struct lock_list *source_entry,
 static inline int __bfs_forwards(struct lock_list *src_entry,
 			void *data,
 			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+			struct lock_list **target_entry, bool init)
 {
 	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_after));
+		     offsetof(struct lock_class, locks_after), init);
 
 }
 
@@ -1489,7 +1490,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 			struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_before));
+		     offsetof(struct lock_class, locks_before), true);
 
 }
 
@@ -1662,7 +1663,7 @@ static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
 	unsigned long  count = 0;
 	struct lock_list *uninitialized_var(target_entry);
 
-	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
+	__bfs_forwards(this, (void *)&count, noop_count, &target_entry, true);
 
 	return count;
 }
@@ -1750,12 +1751,12 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
  */
 static noinline int
 check_path(struct lock_class *target, struct lock_list *src_entry,
-	   struct lock_list **target_entry)
+	   struct lock_list **target_entry, bool init)
 {
 	int ret;
 
 	ret = __bfs_forwards(src_entry, (void *)target, class_equal,
-			     target_entry);
+			     target_entry, init);
 
 	if (unlikely(ret < 0))
 		print_bfs_bug(ret);
@@ -1783,7 +1784,7 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+	ret = check_path(hlock_class(target), &src_entry, &target_entry, true);
 
 	if (unlikely(!ret)) {
 		if (!trace->nr_entries) {
@@ -1821,7 +1822,7 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+	ret = check_path(hlock_class(target), &src_entry, &target_entry, true);
 
 	if (!ret) {
 		struct lock_list *parent;
@@ -1897,7 +1898,8 @@ static inline int usage_match(struct lock_list *entry, void *mask)
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
-	result = __bfs_forwards(root, &usage_mask, usage_match, target_entry);
+	result = __bfs_forwards(root, &usage_mask, usage_match,
+				target_entry, true);
 
 	return result;
 }
-- 
1.8.3.1

