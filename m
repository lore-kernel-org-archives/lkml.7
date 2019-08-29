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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640D6C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B439215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7LxmTTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfH2IdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42054 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfH2IdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id y1so1231760plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=quESet5Kw5IYsWIdcIIRqLkrcTZZW6u8dYTNYlJvYZo=;
        b=o7LxmTTN/pqIMAj9GiqC/CQ/Psrz6vHtIpmrnnW5zZ2e/8vmv0YOhOPOKZiY6FYMX1
         bg2YwyNKfLCIHbPe9OlbN4CAlzHC+8QDPoRugWvKGgZiBogKVJlnPNF4aH7er0XXtglx
         aJYgycnBW6JqQqj/6enfCrb2kXVpuu0cYyfBqk2UW8z+wYgC5YkZJi2gVAJZ8pZXbTvy
         B/krVLv7TPM/k9FdH96xnrn4BzlQ/dUXmvMteNU4hSTl9Lx9xYFL3b0la4KlE4GmrjDt
         sRr5EoBbKXDGeuD1lZ8kr8vl2fuCj1KeCoIBWFOJGyeVZNGElkEDIaJOU6u67F8fGJd/
         zl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=quESet5Kw5IYsWIdcIIRqLkrcTZZW6u8dYTNYlJvYZo=;
        b=QAyahqYkKC5LMVYfrcMzKQcOsR1PblhuT2HT4Lj1v9dwhL76T+KT7biGLQdbc1h45x
         AbklALzqaJAlfQbjixXUjMrutRjDeHU924fDkZ1Lx3iPUP3sJiegcDU1BlBdmqlcQqMF
         taUjNU/x/gPBlqd5DYg8rEE74Ip+v6zUgvYhgxxynFAXtDMXfhvLiUuqBT3zk1NCdScC
         oh3lPM18zDKLJzLhwPcw0ja5JFB2pZwnoHnTV2Etik5UCMsxPJp72+x9vPTwvKqbenmH
         lFkB8GvGmSyVy4762o/uweujQsYQsZDhbeN19NaDdGWWxvREKmcFqc5Ojcmq//SjNkzu
         /+1g==
X-Gm-Message-State: APjAAAUaWJkbWVtGWaPaUbLM2MNMzmjm+YKQ2HLOb/tnTnhq9OHxkaQU
        9yHBnYk329q1XUHUGoYI+lg=
X-Google-Smtp-Source: APXvYqwi0KjCokl9JXhCypIYN5/G0gMKnC6W0Wt1MAAXx2bp63hrUAJTmATq1z2IkArYMZfjtHhyFQ==
X-Received: by 2002:a17:902:20ec:: with SMTP id v41mr8487897plg.117.1567067594852;
        Thu, 29 Aug 2019 01:33:14 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:33:14 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 23/30] locking/lockdep: Adjust BFS algorithm to support multiple matches
Date:   Thu, 29 Aug 2019 16:31:25 +0800
Message-Id: <20190829083132.22394-24-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With recursive-read locks, a circle is not sufficient condition for
deadlocks. As a result, we need to continue the search after a match but
the match is not wanted. __bfs() is adjusted to that end. The basic idea
is to enqueue a node's children before matching the node.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d13b6b7..3ad97bc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1623,7 +1623,7 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
-		 struct lock_list **target_entry, int forward)
+		 struct lock_list **target_entry, int forward, bool init)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1631,19 +1631,11 @@ static int __bfs(struct lock_list *source_entry,
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
 
-	head = get_dep_list(source_entry, forward);
-	if (list_empty(head))
-		goto exit;
-
-	__cq_init(cq);
-	__cq_enqueue(cq, source_entry);
-
 	while ((lock = __cq_dequeue(cq))) {
 
 		if (!lock->class[forward]) {
@@ -1655,25 +1647,34 @@ static int __bfs(struct lock_list *source_entry,
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
+		/*
+		 * Enqueue a node's children before match() so that even
+		 * this node matches but is not wanted, we can continue
+		 * the search.
+		 */
 		list_for_each_entry_rcu(entry, head, entry[forward]) {
 			if (!lock_accessed(entry, forward)) {
 				unsigned int cq_depth;
+
 				mark_lock_accessed(entry, lock, forward);
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
@@ -1682,9 +1683,9 @@ static int __bfs(struct lock_list *source_entry,
 static inline int __bfs_forwards(struct lock_list *src_entry,
 			void *data,
 			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+			struct lock_list **target_entry, bool init)
 {
-	return __bfs(src_entry, data, match, target_entry, 1);
+	return __bfs(src_entry, data, match, target_entry, 1, init);
 }
 
 static inline int __bfs_backwards(struct lock_list *src_entry,
@@ -1692,7 +1693,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 0);
+	return __bfs(src_entry, data, match, target_entry, 0, true);
 }
 
 static void print_lock_trace(const struct lock_trace *trace,
@@ -1864,7 +1865,7 @@ static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
 	unsigned long  count = 0;
 	struct lock_list *uninitialized_var(target_entry);
 
-	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
+	__bfs_forwards(this, (void *)&count, noop_count, &target_entry, true);
 
 	return count;
 }
@@ -1918,12 +1919,12 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
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
@@ -1951,7 +1952,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+	ret = check_path(hlock_class(target), &src_entry, &target_entry, true);
 
 	if (unlikely(!ret)) {
 		if (!*trace) {
@@ -2012,7 +2013,7 @@ static inline int usage_match_backward(struct lock_list *entry, void *mask)
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
 	result = __bfs_forwards(root, &usage_mask, usage_match_forward,
-				target_entry);
+				target_entry, true);
 
 	return result;
 }
-- 
1.8.3.1

