Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0929DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EE62133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El54/Fxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfF1JQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36853 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF1JQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so2672213pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHPOoRqSRjVm8Jf/89G0zJiwwNRFSrQP8sanvOv03zc=;
        b=El54/FxaO79tdgg9kUiDlWO1OKhn44cp79V4ytHtDntACjC3RqdXgYywI1+fTNUH7b
         gR5YtoQrYINXFTUq2XRdRK5vVijHRIFpLWDnlMcTmiuRiR5I0yicOuqIjJKTmwxPe8YQ
         KyUpYXDdy3Pjzc1wj5QRUHe+QU4X4MihIwgRSEnr2TmCV5a0W6HNRU+ZI6Cwo4/gDW79
         hKh2Pfu1z8LBGclF5fXIzkA1YVn0vU1vG7dKZ8t2kZ5in0iJ9VjWZtjNMqTSkG2i48G3
         pcX+4G3j2qfdbcKKFpqoOxTjW028NlJuo0PVZ3tIss55OQqJEZUGddiZXNTkrH/xJSkH
         +z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHPOoRqSRjVm8Jf/89G0zJiwwNRFSrQP8sanvOv03zc=;
        b=lvwy7IJVyqoWnBMP8+jsMSunZf//4Tfpx6LwN5wgegaaevudM8VRgsUkBQnoRpurfN
         UEKEZrwpYiPjF9PxL7BGdO9jfE5bwPabXEfGeMihJ8wT44EA81TUfgtBOAJb4uQazwzO
         8H5A/zxFjlBZKLXr2p/KH9IdwNc0XSbquKptilFBGV9/8Zw/037TFuomnz6uqCRjBM8M
         5meNrkuTlCseH6YHqZiy2zEws7Y7F9PrLRNwXdzlb17O1ga58RttcfbQVGnaBqIt0V/4
         ueVum/ZI9UG5YrLVh/TOVe4TeRv69EKSUxuRERZ56ALA8ah5T8jLJFyu4sjLTvdJPOoM
         hqFw==
X-Gm-Message-State: APjAAAXBrScH35GlZzb6QtkpGpIN5CXLGr6pku+uqHTCZfeAOROJVXJ9
        rPmiSxqRFKjEerNuUfPfvj8=
X-Google-Smtp-Source: APXvYqwdoRWosNJuKkoyfBLiD4jXSfEUW9SeRK9iuJfgEozmXUCvER3d0Bq4T4RFqRod3IZqG/nmPg==
X-Received: by 2002:a17:90a:8a15:: with SMTP id w21mr11937620pjn.134.1561713402212;
        Fri, 28 Jun 2019 02:16:42 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:41 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 13/30] locking/lockdep: Combine lock_lists in struct lock_class into an array
Date:   Fri, 28 Jun 2019 17:15:11 +0800
Message-Id: <20190628091528.17059-14-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to combine forward dependency lock_lists and backward
dependency lock_lists. Combing locks_before and locks_after lists, this
patch makes the code after all this a bit clearer.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h       |  6 ++---
 kernel/locking/lockdep.c      | 63 +++++++++++++++++++------------------------
 kernel/locking/lockdep_proc.c |  2 +-
 3 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 5e0a1a9..62eba72 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -92,10 +92,10 @@ struct lock_class {
 
 	/*
 	 * These fields represent a directed graph of lock dependencies,
-	 * to every node we attach a list of "forward" and a list of
-	 * "backward" graph nodes.
+	 * to every node we attach a list of "forward" graph nodes
+	 * @dep_list[1] and a list of "backward" graph nodes @dep_list[0].
 	 */
-	struct list_head		locks_after, locks_before;
+	struct list_head		dep_list[2];
 
 	struct lockdep_subclass_key	*key;
 	unsigned int			subclass;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6f457ef..39210a4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -833,8 +833,7 @@ static bool in_list(struct list_head *e, struct list_head *h)
 }
 
 /*
- * Check whether entry @e occurs in any of the locks_after or locks_before
- * lists.
+ * Check whether entry @e occurs in any of the dep lists.
  */
 static bool in_any_class_list(struct list_head *e)
 {
@@ -843,8 +842,8 @@ static bool in_any_class_list(struct list_head *e)
 
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
 		class = &lock_classes[i];
-		if (in_list(e, &class->locks_after) ||
-		    in_list(e, &class->locks_before))
+		if (in_list(e, &class->dep_list[0]) ||
+		    in_list(e, &class->dep_list[1]))
 			return true;
 	}
 	return false;
@@ -932,9 +931,9 @@ static bool __check_data_structures(void)
 	/* Check whether all classes have valid lock lists. */
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
 		class = &lock_classes[i];
-		if (!class_lock_list_valid(class, &class->locks_before))
+		if (!class_lock_list_valid(class, &class->dep_list[0]))
 			return false;
-		if (!class_lock_list_valid(class, &class->locks_after))
+		if (!class_lock_list_valid(class, &class->dep_list[1]))
 			return false;
 	}
 
@@ -1030,8 +1029,8 @@ static void init_data_structures_once(void)
 
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
 		list_add_tail(&lock_classes[i].lock_entry, &free_lock_classes);
-		INIT_LIST_HEAD(&lock_classes[i].locks_after);
-		INIT_LIST_HEAD(&lock_classes[i].locks_before);
+		INIT_LIST_HEAD(&lock_classes[i].dep_list[0]);
+		INIT_LIST_HEAD(&lock_classes[i].dep_list[1]);
 	}
 }
 
@@ -1160,8 +1159,8 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 	class->key = key;
 	class->name = lock->name;
 	class->subclass = subclass;
-	WARN_ON_ONCE(!list_empty(&class->locks_before));
-	WARN_ON_ONCE(!list_empty(&class->locks_after));
+	WARN_ON_ONCE(!list_empty(&class->dep_list[0]));
+	WARN_ON_ONCE(!list_empty(&class->dep_list[1]));
 	class->name_version = count_matching_names(class);
 	/*
 	 * We use RCU's safe list-add method to make
@@ -1380,15 +1379,14 @@ static inline int get_lock_depth(struct lock_list *child)
 /*
  * Return the forward or backward dependency list.
  *
- * @lock:   the lock_list to get its class's dependency list
- * @offset: the offset to struct lock_class to determine whether it is
- *          locks_after or locks_before
+ * @lock:    the lock_list to get its class's dependency list
+ * @forward: the forward dep list or backward dep list
  */
-static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
+static inline struct list_head *get_dep_list(struct lock_list *lock, int forward)
 {
-	void *lock_class = lock->class;
+	struct lock_class *class = lock->class;
 
-	return lock_class + offset;
+	return &class->dep_list[forward];
 }
 
 /*
@@ -1398,8 +1396,7 @@ static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
-		 struct lock_list **target_entry,
-		 int offset)
+		 struct lock_list **target_entry, int forward)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1413,7 +1410,7 @@ static int __bfs(struct lock_list *source_entry,
 		goto exit;
 	}
 
-	head = get_dep_list(source_entry, offset);
+	head = get_dep_list(source_entry, forward);
 	if (list_empty(head))
 		goto exit;
 
@@ -1427,7 +1424,7 @@ static int __bfs(struct lock_list *source_entry,
 			goto exit;
 		}
 
-		head = get_dep_list(lock, offset);
+		head = get_dep_list(lock, forward);
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
@@ -1460,9 +1457,7 @@ static inline int __bfs_forwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_after));
-
+	return __bfs(src_entry, data, match, target_entry, 1);
 }
 
 static inline int __bfs_backwards(struct lock_list *src_entry,
@@ -1470,9 +1465,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_before));
-
+	return __bfs(src_entry, data, match, target_entry, 0);
 }
 
 static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
@@ -2375,7 +2368,7 @@ static inline void inc_chains(void)
 	 *  chains - the second one will be new, but L1 already has
 	 *  L2 added to its dependency list, due to the first chain.)
 	 */
-	list_for_each_entry(entry, &hlock_class(prev)->locks_after, entry) {
+	list_for_each_entry(entry, &hlock_class(prev)->dep_list[1], entry) {
 		if (entry->class == hlock_class(next)) {
 			debug_atomic_inc(nr_redundant);
 
@@ -2422,14 +2415,14 @@ static inline void inc_chains(void)
 	 * to the previous lock's dependency list:
 	 */
 	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
-			       &hlock_class(prev)->locks_after,
+			       &hlock_class(prev)->dep_list[1],
 			       next->acquire_ip, distance, trace);
 
 	if (!ret)
 		return 0;
 
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
-			       &hlock_class(next)->locks_before,
+			       &hlock_class(next)->dep_list[0],
 			       next->acquire_ip, distance, trace);
 	if (!ret)
 		return 0;
@@ -4740,8 +4733,8 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		nr_list_entries--;
 		list_del_rcu(&entry->entry);
 	}
-	if (list_empty(&class->locks_after) &&
-	    list_empty(&class->locks_before)) {
+	if (list_empty(&class->dep_list[0]) &&
+	    list_empty(&class->dep_list[1])) {
 		list_move_tail(&class->lock_entry, &pf->zapped);
 		hlist_del_rcu(&class->hash_entry);
 		WRITE_ONCE(class->key, NULL);
@@ -4762,12 +4755,12 @@ static void reinit_class(struct lock_class *class)
 	const unsigned int offset = offsetof(struct lock_class, key);
 
 	WARN_ON_ONCE(!class->lock_entry.next);
-	WARN_ON_ONCE(!list_empty(&class->locks_after));
-	WARN_ON_ONCE(!list_empty(&class->locks_before));
+	WARN_ON_ONCE(!list_empty(&class->dep_list[0]));
+	WARN_ON_ONCE(!list_empty(&class->dep_list[1]));
 	memset(p + offset, 0, sizeof(*class) - offset);
 	WARN_ON_ONCE(!class->lock_entry.next);
-	WARN_ON_ONCE(!list_empty(&class->locks_after));
-	WARN_ON_ONCE(!list_empty(&class->locks_before));
+	WARN_ON_ONCE(!list_empty(&class->dep_list[0]));
+	WARN_ON_ONCE(!list_empty(&class->dep_list[1]));
 }
 
 static inline int within(const void *addr, void *start, unsigned long size)
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 58ed889..dc0dfae 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -82,7 +82,7 @@ static int l_show(struct seq_file *m, void *v)
 	print_name(m, class);
 	seq_puts(m, "\n");
 
-	list_for_each_entry(entry, &class->locks_after, entry) {
+	list_for_each_entry(entry, &class->dep_list[1], entry) {
 		if (entry->distance == 1) {
 			seq_printf(m, " -> [%p] ", entry->class->key);
 			print_name(m, entry->class);
-- 
1.8.3.1

