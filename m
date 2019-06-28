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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB67EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C29208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGzbMJib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfF1JRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:17:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43648 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF1JRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so2653728pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMGlIVutsjY+wGu2oGB2uXR1IhLTYT9V4RijA/g6l/k=;
        b=dGzbMJibABpNsRkfxbPNQAfb3ohVkDZJbyrhRtxysn2SqJvtKGjSG+LO5C3qFF2RUd
         yBTDoSEIcIJ46uwTq658na1rcvNQiB4JjnYSgRv9TIRXZ75liO43sB9wgAWB7pV53fc+
         VVh2RfEJ78EPsQonpkX9uwudbZt4agT34hslcPRg+Kc5OR5R5cGnVkQpPFHpnWyviujB
         qpgDBLAygNHJCfEj7fhNHmiwoRhI+M7RsrI/iIUyYXF7GhPHFJyDvHAZwZVyoMwL6MKL
         PquDGZyXR0p98hY3MKZayQXCeAejuB0EPVjfOjt05llcF98Dfi8gew54hDcDvfwvrwO8
         RuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMGlIVutsjY+wGu2oGB2uXR1IhLTYT9V4RijA/g6l/k=;
        b=Z6HrQJpNrxTqkyyZ4uwZEpamE+vz8pJVArdls68+pdtR3kNdfdLSc4VU9FyDMiYVWB
         3bwBRKGQtIiNOx3DkxlPyir9Hc8bkICQfHKEICqNR5U9pGWyjPnh5joLSwstcG5LVIM9
         n6kAMqKFiilqNjmkNgAvZrBOfdk44IWpY7Gef0+CCrZ7ACm0PLt+rwam6rFf7Ah7OZ28
         7KB9JFrbH0f0tBzNgbtMEzRuN3FvyX5nisrGSmSRxWmKhrj4uPdyUdrX25pKNJkr93HG
         OtEbhHOkvS4wfJ8aDc6Dej9kQHsHQUyO5G2W9pehNycqQLOX+geJ8PZsXirNy5RhUHMT
         klOw==
X-Gm-Message-State: APjAAAU78I9MWxbL7kkSRbzONuIKiEyYUsXSEhgD2ZO8YXe4RDjSwkwM
        rHUv1ADCP+2jBAnq+mmafXQ=
X-Google-Smtp-Source: APXvYqwUcgCCgpyYwmfYG66XpUCuqeq1v1YLMQ9164YWnGUekFtccl3ADcYH4MKlSWj9l02SA2xBGQ==
X-Received: by 2002:a63:514e:: with SMTP id r14mr8118790pgl.71.1561713442285;
        Fri, 28 Jun 2019 02:17:22 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:17:21 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 22/30] locking/lockdep: Adjust BFS algorithm to support multiple matches
Date:   Fri, 28 Jun 2019 17:15:20 +0800
Message-Id: <20190628091528.17059-23-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With recursive-read locks, a circle is not sufficient condition for a
deadlock. As a result, we need to continue the search after a match but
the match is not wanted. __bfs() is adjusted to that end. The basic idea
is to enqueue a node's children before matching the node.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 10df8eb..7d02b94 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1551,7 +1551,7 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
-		 struct lock_list **target_entry, int forward)
+		 struct lock_list **target_entry, int forward, bool init)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1559,19 +1559,11 @@ static int __bfs(struct lock_list *source_entry,
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
@@ -1583,25 +1575,34 @@ static int __bfs(struct lock_list *source_entry,
 
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
@@ -1610,9 +1611,9 @@ static int __bfs(struct lock_list *source_entry,
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
@@ -1620,7 +1621,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 0);
+	return __bfs(src_entry, data, match, target_entry, 0, true);
 }
 
 static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
@@ -1792,7 +1793,7 @@ static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
 	unsigned long  count = 0;
 	struct lock_list *uninitialized_var(target_entry);
 
-	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
+	__bfs_forwards(this, (void *)&count, noop_count, &target_entry, true);
 
 	return count;
 }
@@ -1846,12 +1847,12 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
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
@@ -1879,7 +1880,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+	ret = check_path(hlock_class(target), &src_entry, &target_entry, true);
 
 	if (unlikely(!ret)) {
 		if (!trace->nr_entries) {
@@ -1940,7 +1941,7 @@ static inline int usage_match_backward(struct lock_list *entry, void *mask)
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
 	result = __bfs_forwards(root, &usage_mask, usage_match_forward,
-				target_entry);
+				target_entry, true);
 
 	return result;
 }
-- 
1.8.3.1

