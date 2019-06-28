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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA71AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F142133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4cKqfSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfF1JQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36958 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfF1JQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id g15so417596pgi.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fyo/z5cDgcZ8CUPvEH7NHSKzO3PAor9YvhoVUFLT7ZA=;
        b=d4cKqfSej40hHQZ5Znq2zW//OozsvmQe/oB1AWNT+CYsqLwzr+cb4evpUX2WvFf7XP
         c3GZYX8OSf+II9A36KIiyInXFt+R+0/zKl/GcltlCHTNOpJCNCaV9hCQeZqeS6Z3Jf6p
         X0e46de1VoGVBl/0bVeL8igvOZzXbxLUc2hKrPLCHyss4XMesW6FjAWMh6prUo/wVFxm
         Ja4hXNz1vU3HBt3voCNw0p9E/AHlmWddwVHT3jMy/YefV1OVrVXHgh82VQSzYlfpWIvg
         QSPNoz7mMV6bXGo+V8/3a9+c85Westv9imy6ZTubF+RDjSo6E+trQjZ4fLfTGcAGGy6p
         L+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fyo/z5cDgcZ8CUPvEH7NHSKzO3PAor9YvhoVUFLT7ZA=;
        b=md19qH38E+/ZiByo+h/55krWxroKXBnFdpLPsUCptfi5lOjU6lj0Zm4G8cUx+jC2Ey
         +2nuo6JK0GGcxHMHhnuXb0cbGpaONyPj+kDxQNifnnFEHro8nKo5AYesz3s4aOVlVvRj
         5iY30SLE29rHE/yx8wzIWWmv+fT/DRYdOF2treTgbBTb6ESrOeebLi6VRYwTzMvLs+XC
         JpqvLtVOP7oOtFUuQukhaFCKEcXLZtnhzvENZRQynq7zwD+MO/sEQZaGoFtc6W0ByAje
         WVmqTXXa1Jhhn3FPryNAagQYC9sinopkkoBiQjjmVa/6vLlAHZTHegG+VBFSeDGXOTcH
         fPMg==
X-Gm-Message-State: APjAAAVKzbeL01rgrN7GKu6LwMXHWxnnI2frVjEgvEOmPGFdU1FNAAMw
        wgUuNAE2MJ0BbcDay59XyhU=
X-Google-Smtp-Source: APXvYqwb/w8GdiDxkl1b8f9Yyh/QxaMA28PkaXqrXAWYR4TNTZnG08VO+uXKuazGaV4Zy6wobUgYsg==
X-Received: by 2002:a63:d103:: with SMTP id k3mr7851249pgg.189.1561713393242;
        Fri, 28 Jun 2019 02:16:33 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:32 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 11/30] locking/lockdep: Specify the depth of current lock stack in lookup_chain_cache_add()
Date:   Fri, 28 Jun 2019 17:15:09 +0800
Message-Id: <20190628091528.17059-12-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When looking up and adding a chain (i.e., in lookup_chain_cache_add()
and only in it), explicitly specify the depth of the held lock stack.
This is now only curr->lockdep_depth.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 095e532..5d19dc6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2527,12 +2527,12 @@ struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
  * Returns the index of the first held_lock of the current chain
  */
 static inline int get_first_held_lock(struct task_struct *curr,
-					struct held_lock *hlock)
+				      struct held_lock *hlock, int depth)
 {
 	int i;
 	struct held_lock *hlock_curr;
 
-	for (i = curr->lockdep_depth - 1; i >= 0; i--) {
+	for (i = depth - 1; i >= 0; i--) {
 		hlock_curr = curr->held_locks + i;
 		if (hlock_curr->irq_context != hlock->irq_context)
 			break;
@@ -2557,12 +2557,12 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 }
 
 static void
-print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_next)
+print_chain_keys_held_locks(struct task_struct *curr,
+			    struct held_lock *hlock_next, int depth)
 {
 	struct held_lock *hlock;
 	u64 chain_key = INITIAL_CHAIN_KEY;
-	int depth = curr->lockdep_depth;
-	int i = get_first_held_lock(curr, hlock_next);
+	int i = get_first_held_lock(curr, hlock_next, depth);
 
 	printk("depth: %u (irq_context %u)\n", depth - i + 1,
 		hlock_next->irq_context);
@@ -2594,8 +2594,8 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 }
 
 static void print_collision(struct task_struct *curr,
-			struct held_lock *hlock_next,
-			struct lock_chain *chain)
+			    struct held_lock *hlock_next,
+			    struct lock_chain *chain, int depth)
 {
 	pr_warn("\n");
 	pr_warn("============================\n");
@@ -2606,7 +2606,7 @@ static void print_collision(struct task_struct *curr,
 	pr_warn("Hash chain already cached but the contents don't match!\n");
 
 	pr_warn("Held locks:");
-	print_chain_keys_held_locks(curr, hlock_next);
+	print_chain_keys_held_locks(curr, hlock_next, depth);
 
 	pr_warn("Locks in cached chain:");
 	print_chain_keys_chain(chain);
@@ -2622,17 +2622,16 @@ static void print_collision(struct task_struct *curr,
  * that there was a collision during the calculation of the chain_key.
  * Returns: 0 not passed, 1 passed
  */
-static int check_no_collision(struct task_struct *curr,
-			struct held_lock *hlock,
-			struct lock_chain *chain)
+static int check_no_collision(struct task_struct *curr, struct held_lock *hlock,
+			      struct lock_chain *chain, int depth)
 {
 #ifdef CONFIG_DEBUG_LOCKDEP
 	int i, j, id;
 
-	i = get_first_held_lock(curr, hlock);
+	i = get_first_held_lock(curr, hlock, depth);
 
-	if (DEBUG_LOCKS_WARN_ON(chain->depth != curr->lockdep_depth - (i - 1))) {
-		print_collision(curr, hlock, chain);
+	if (DEBUG_LOCKS_WARN_ON(chain->depth != depth - (i - 1))) {
+		print_collision(curr, hlock, chain, depth);
 		return 0;
 	}
 
@@ -2640,7 +2639,7 @@ static int check_no_collision(struct task_struct *curr,
 		id = curr->held_locks[i].class_idx;
 
 		if (DEBUG_LOCKS_WARN_ON(chain_hlocks[chain->base + j] != id)) {
-			print_collision(curr, hlock, chain);
+			print_collision(curr, hlock, chain, depth);
 			return 0;
 		}
 	}
@@ -2684,7 +2683,7 @@ static struct lock_chain *alloc_lock_chain(void)
  */
 static inline struct lock_chain *add_chain_cache(struct task_struct *curr,
 						 struct held_lock *hlock,
-						 u64 chain_key)
+						 u64 chain_key, int depth)
 {
 	struct lock_class *class = hlock_class(hlock);
 	struct hlist_head *hash_head = chainhashentry(chain_key);
@@ -2710,8 +2709,8 @@ static inline struct lock_chain *add_chain_cache(struct task_struct *curr,
 	}
 	chain->chain_key = chain_key;
 	chain->irq_context = hlock->irq_context;
-	i = get_first_held_lock(curr, hlock);
-	chain->depth = curr->lockdep_depth + 1 - i;
+	i = get_first_held_lock(curr, hlock, depth);
+	chain->depth = depth + 1 - i;
 
 	BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
 	BUILD_BUG_ON((1UL << 6)  <= ARRAY_SIZE(curr->held_locks));
@@ -2764,17 +2763,21 @@ static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
  * add it and return the chain - in this case the new dependency
  * chain will be validated. If the key is already hashed, return
  * NULL. (On return with the new chain graph_lock is held.)
+ *
+ * If the key is not hashed, the new chain is composed of @hlock
+ * and @depth worth of the current held lock stack, of which the
+ * held locks are in the same context as @hlock.
  */
 static inline struct lock_chain *
 lookup_chain_cache_add(struct task_struct *curr, struct held_lock *hlock,
-		       u64 chain_key)
+		       u64 chain_key, int depth)
 {
 	struct lock_class *class = hlock_class(hlock);
 	struct lock_chain *chain = lookup_chain_cache(chain_key);
 
 	if (chain) {
 cache_hit:
-		if (!check_no_collision(curr, hlock, chain))
+		if (!check_no_collision(curr, hlock, chain, depth))
 			return NULL;
 
 		if (very_verbose(class)) {
@@ -2804,7 +2807,7 @@ static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
 		goto cache_hit;
 	}
 
-	return add_chain_cache(curr, hlock, chain_key);
+	return add_chain_cache(curr, hlock, chain_key, depth);
 }
 
 static int validate_chain(struct task_struct *curr, struct held_lock *hlock,
@@ -2822,7 +2825,8 @@ static int validate_chain(struct task_struct *curr, struct held_lock *hlock,
 	 * graph_lock for us)
 	 */
 	if (!hlock->trylock && hlock->check &&
-	    (chain = lookup_chain_cache_add(curr, hlock, chain_key))) {
+	    (chain = lookup_chain_cache_add(curr, hlock, chain_key,
+					    curr->lockdep_depth))) {
 		/*
 		 * Check whether last held lock:
 		 *
-- 
1.8.3.1

