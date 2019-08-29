Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC6CC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB45233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwQJJPic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfH2Ico (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41429 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfH2Icj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so1233612pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pq5J6NeNkP3wzC0N3DZc+7+s4IIo5Z92ZSV0ODJhIFg=;
        b=kwQJJPicEDKe9Ys10A87NsreJw/A3sv/C4tcu7yE5XPEAcxrJHHEESYKfiS+Dy0Cux
         X6ovfozJbPLjD38MPT/Lxgjv2NdEc3J3yZyZWw13MVyYA/TjUflgPGFBcxGF5wIEgKTa
         NScOcQTDitkx1NT/RSxjZOnrn/ej1amx933/5PxP9QiJSSEMWSwb4lzp8P7oLDfi/dXy
         ur+zVmz9NBbK7DN1lpjX1o9LhfNMKqKkfyWyB2QquLRf2hpYlTKXfWmkOA/Kkiq/6JV/
         A6ojlAM6BJ7mq7WBTDrQobcSkHBSWO8cmfYeXZkgLeT9KR/tdwzUeloq204MdEjz3DkX
         rX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pq5J6NeNkP3wzC0N3DZc+7+s4IIo5Z92ZSV0ODJhIFg=;
        b=Usz57Fg75kI4CglYs0jEBCH36bBpJPjSXHGsc77PN59SFL9anhXMD5RqIpom38B6ox
         v/9Hg0760Zj7JUaD5k+jtnfxxWuq4ZKRbxzzRTSexAp513r/TnhegPuv24ZbPvB8/o8s
         6+AJBJtwIVG7tA6SM0I62XW7ad8PT0tD6eHJ3f6WeOxo+TdxbBgnF5D9QC4I0Z8qUnJ/
         4fYPHamV+PUmwbUZ+d2HALhbfyn/lDIazOMkYnndgXr5JcbZ2ke+931S/eb//fwl7UHK
         QmSIz1dE2mkWPH4VBS860PlygiMuwfLvlx3lzN5bDEqHZzhb4qR/KVFG/hGjUoDsCGsl
         0suA==
X-Gm-Message-State: APjAAAX3D9VwoJ6qrVoN+7oR6PQEitKIwvFs520d3j1TJbBz9Lb/GZ2z
        S9uuZ008n5XHDIRg1APvik4=
X-Google-Smtp-Source: APXvYqziKAc7A1iPeXGPHI/kViPKp1zrbjDyJZPzmH9C8gNy+uXa7PPeWEIEhL4UY+0fYgO1vr60pg==
X-Received: by 2002:a17:902:5a1:: with SMTP id f30mr8827635plf.64.1567067559051;
        Thu, 29 Aug 2019 01:32:39 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:38 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 14/30] locking/lockdep: Combine lock_lists in struct lock_class into an array
Date:   Thu, 29 Aug 2019 16:31:16 +0800
Message-Id: <20190829083132.22394-15-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to combine forward dependency lock_lists and backward
dependency lock_lists. To prepare for that, we combine locks_before and
locks_after lists, which makes the codes a bit clearer after all.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h       |  6 ++---
 kernel/locking/lockdep.c      | 63 +++++++++++++++++++------------------------
 kernel/locking/lockdep_proc.c |  2 +-
 3 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 0246a70..06b686d 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -89,10 +89,10 @@ struct lock_class {
 
 	/*
 	 * These fields represent a directed graph of lock dependencies,
-	 * to every node we attach a list of "forward" and a list of
-	 * "backward" graph nodes.
+	 * to every node we attach a list of "forward" graph nodes
+	 * @dep_list[1] and a list of "backward" graph nodes @dep_list[0].
 	 */
-	struct list_head		locks_after, locks_before;
+	struct list_head		dep_list[2];
 
 	const struct lockdep_subclass_key *key;
 	unsigned int			subclass;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 21d9e99..8c53b59 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -901,8 +901,7 @@ static bool in_list(struct list_head *e, struct list_head *h)
 }
 
 /*
- * Check whether entry @e occurs in any of the locks_after or locks_before
- * lists.
+ * Check whether entry @e occurs in any of the dep lists.
  */
 static bool in_any_class_list(struct list_head *e)
 {
@@ -911,8 +910,8 @@ static bool in_any_class_list(struct list_head *e)
 
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
 		class = &lock_classes[i];
-		if (in_list(e, &class->locks_after) ||
-		    in_list(e, &class->locks_before))
+		if (in_list(e, &class->dep_list[0]) ||
+		    in_list(e, &class->dep_list[1]))
 			return true;
 	}
 	return false;
@@ -1000,9 +999,9 @@ static bool __check_data_structures(void)
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
 
@@ -1098,8 +1097,8 @@ static void init_data_structures_once(void)
 
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
 		list_add_tail(&lock_classes[i].lock_entry, &free_lock_classes);
-		INIT_LIST_HEAD(&lock_classes[i].locks_after);
-		INIT_LIST_HEAD(&lock_classes[i].locks_before);
+		INIT_LIST_HEAD(&lock_classes[i].dep_list[0]);
+		INIT_LIST_HEAD(&lock_classes[i].dep_list[1]);
 	}
 }
 
@@ -1228,8 +1227,8 @@ static bool is_dynamic_key(const struct lock_class_key *key)
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
@@ -1448,15 +1447,14 @@ static inline int get_lock_depth(struct lock_list *child)
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
@@ -1466,8 +1464,7 @@ static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
-		 struct lock_list **target_entry,
-		 int offset)
+		 struct lock_list **target_entry, int forward)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1481,7 +1478,7 @@ static int __bfs(struct lock_list *source_entry,
 		goto exit;
 	}
 
-	head = get_dep_list(source_entry, offset);
+	head = get_dep_list(source_entry, forward);
 	if (list_empty(head))
 		goto exit;
 
@@ -1495,7 +1492,7 @@ static int __bfs(struct lock_list *source_entry,
 			goto exit;
 		}
 
-		head = get_dep_list(lock, offset);
+		head = get_dep_list(lock, forward);
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
@@ -1528,9 +1525,7 @@ static inline int __bfs_forwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_after));
-
+	return __bfs(src_entry, data, match, target_entry, 1);
 }
 
 static inline int __bfs_backwards(struct lock_list *src_entry,
@@ -1538,9 +1533,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_before));
-
+	return __bfs(src_entry, data, match, target_entry, 0);
 }
 
 static void print_lock_trace(const struct lock_trace *trace,
@@ -2445,7 +2438,7 @@ static inline void inc_chains(void)
 	 *  chains - the second one will be new, but L1 already has
 	 *  L2 added to its dependency list, due to the first chain.)
 	 */
-	list_for_each_entry(entry, &hlock_class(prev)->locks_after, entry) {
+	list_for_each_entry(entry, &hlock_class(prev)->dep_list[1], entry) {
 		if (entry->class == hlock_class(next)) {
 			debug_atomic_inc(nr_redundant);
 
@@ -2495,14 +2488,14 @@ static inline void inc_chains(void)
 	 * to the previous lock's dependency list:
 	 */
 	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
-			       &hlock_class(prev)->locks_after,
+			       &hlock_class(prev)->dep_list[1],
 			       next->acquire_ip, distance, *trace);
 
 	if (!ret)
 		return 0;
 
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
-			       &hlock_class(next)->locks_before,
+			       &hlock_class(next)->dep_list[0],
 			       next->acquire_ip, distance, *trace);
 	if (!ret)
 		return 0;
@@ -4811,8 +4804,8 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
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
@@ -4833,12 +4826,12 @@ static void reinit_class(struct lock_class *class)
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
index edc4a7b..989c27e 100644
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

