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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E33C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2CB208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDWbv1NU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfF1JRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:17:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42672 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF1JRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so2887138plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d85MmNE1cH6QrhQEHUrDwQBYEtUq1LXEETrA5vTMkHc=;
        b=cDWbv1NU+opHLRIi20DPC1V0BYc3aSIIWh0rrriBX/nPy4/14cxdRYYBfE9shezL8V
         o0lue9wyo3Izn/fTTqjOfGLwflljxCm1diAZTLvsEge3MCbTq9Ecc3pi2inHIP3FsIm4
         Rks2e6/XknL9BpodnrcoLharq9zB3hUOIUhi35Vjv7lvDTbZc5VYzd4iOSpvsg3LX8Du
         nOv07tLqszpJaH0vmHApBlBERSLtq1nfPKHPMCE+iGUD/IU/FBWsfQvuy6t54QNBvcs4
         pZpkEWnmwxVHQRuB/WQDpNNu0oJHYLLoJPGTtCK8HxZPlRu0Lw1KjUDMAUmYdnPfFMPb
         OMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d85MmNE1cH6QrhQEHUrDwQBYEtUq1LXEETrA5vTMkHc=;
        b=X3UVaj882Q8Sh5OrpIF79NyYpfcn0+4Kan5UxHXqpfB4izpIXrLc0jEi9KtilkgJuk
         eVVApbTqeJRGkxCJALoQEU7tSO6sx7EeNPB0RJJhjXp8r325ADquoohjf4KNiCj1KTSg
         zb9KiDIBei0sW9QU1jrfi0qf7fO5lJmPVJdyTrq8alMU2UVXD9lG0oGJ486jOc3EW9dg
         taF5QStspG48fqDraNH+41hHZkvmH6L+u1pfJXaPYb6b3CAx631+J9DPLt8AiR4skCjY
         RdpBFfMmz2Fjqmbafbrt65CKCAiN4NZ0AQgSG2KzjXjBmrbADx6+Vj1NE4suEqllXn+i
         rAcg==
X-Gm-Message-State: APjAAAXBX7QwjTmxRbrkjkqWYw70RXMM9bC8fHvC5S5no6a1y5NYzp5Q
        KkO5GwEK9zNUOt9KlMAdMU4=
X-Google-Smtp-Source: APXvYqxAiva/WXzrCKcUZGiRt5KsgsaDYCyQykdsGg624aqIKBiZdawOld4IJmg5pcG9o2wJ9Ofx9Q==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr10188436plf.137.1561713437612;
        Fri, 28 Jun 2019 02:17:17 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:17:17 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 21/30] locking/lockdep: Hash held lock's read-write type into chain key
Date:   Fri, 28 Jun 2019 17:15:19 +0800
Message-Id: <20190628091528.17059-22-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When computing a chain's hash key, we need to consider a held lock's
read-write type, so the additional data to use Jenkins hash algorithm is
a composite of the new held lock's lock class index (lower 16 bits) and
its read-write type (higher 16 bits) as opposed to just class index
before:

        held lock type (16 bits) : lock class index (16 bits)

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  |  1 +
 kernel/locking/lockdep.c | 55 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index fd619ac..7878481 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -186,6 +186,7 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 }
 
 #define LOCK_TYPE_BITS	2
+#define LOCK_TYPE_SHIFT	16
 
 /*
  * Every lock has a list of other locks that were taken after or before
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 27eeacc..10df8eb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -370,11 +370,22 @@ struct pending_free {
  * it's a hash of all locks taken up to that lock, including that lock.
  * It's a 64-bit hash, because it's important for the keys to be
  * unique.
+ *
+ * The additional u32 data to hash is a composite of the new held lock's
+ * lock class index (lower 16 bits) and its read-write type (higher 16
+ * bits):
+ *
+ *     hlock type (16 bits) : lock class index (16 bits)
+ *
+ * N.B. The bits taken for lock type and index are specified by
+ * LOCK_TYPE_SHIFT.
  */
-static inline u64 iterate_chain_key(u64 key, u32 idx)
+static inline u64 iterate_chain_key(u64 key, u32 idx, int hlock_type)
 {
 	u32 k0 = key, k1 = key >> 32;
 
+	idx += hlock_type << LOCK_TYPE_SHIFT;
+
 	__jhash_mix(idx, k0, k1); /* Macro that modifies arguments! */
 
 	return k0 | (u64)k1 << 32;
@@ -892,7 +903,8 @@ static bool check_lock_chain_key(struct lock_chain *chain)
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++)
-		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i],
+					      chain_hlocks_type[i]);
 	/*
 	 * The 'unsigned long long' casts avoid that a compiler warning
 	 * is reported when building tools/lib/lockdep.
@@ -2623,12 +2635,13 @@ static inline int get_first_held_lock(struct task_struct *curr,
 /*
  * Returns the next chain_key iteration
  */
-static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
+static u64 print_chain_key_iteration(int class_idx, u64 chain_key, int lock_type)
 {
-	u64 new_chain_key = iterate_chain_key(chain_key, class_idx);
+	u64 new_chain_key = iterate_chain_key(chain_key, class_idx, lock_type);
 
-	printk(" class_idx:%d -> chain_key:%016Lx",
+	printk(" class_idx:%d (lock_type %d) -> chain_key:%016Lx",
 		class_idx,
+		lock_type,
 		(unsigned long long)new_chain_key);
 	return new_chain_key;
 }
@@ -2645,12 +2658,15 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 		hlock_next->irq_context);
 	for (; i < depth; i++) {
 		hlock = curr->held_locks + i;
-		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
+		chain_key = print_chain_key_iteration(hlock->class_idx,
+						      chain_key,
+						      hlock->read);
 
 		print_lock(hlock);
 	}
 
-	print_chain_key_iteration(hlock_next->class_idx, chain_key);
+	print_chain_key_iteration(hlock_next->class_idx, chain_key,
+				  hlock_next->read);
 	print_lock(hlock_next);
 }
 
@@ -2658,12 +2674,14 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 {
 	int i;
 	u64 chain_key = INITIAL_CHAIN_KEY;
-	int class_id;
+	int class_id, lock_type;
 
 	printk("depth: %u\n", chain->depth);
 	for (i = 0; i < chain->depth; i++) {
 		class_id = chain_hlocks[chain->base + i];
-		chain_key = print_chain_key_iteration(class_id, chain_key);
+		lock_type = chain_hlocks_type[chain->base + i];
+		chain_key = print_chain_key_iteration(class_id, chain_key,
+						      lock_type);
 
 		print_lock_name(lock_classes + class_id);
 		printk("\n");
@@ -2703,7 +2721,7 @@ static int check_no_collision(struct task_struct *curr, struct held_lock *hlock,
 			      struct lock_chain *chain, int depth)
 {
 #ifdef CONFIG_DEBUG_LOCKDEP
-	int i, j, id;
+	int i, j, id, type;
 
 	i = get_first_held_lock(curr, hlock, depth);
 
@@ -2712,10 +2730,12 @@ static int check_no_collision(struct task_struct *curr, struct held_lock *hlock,
 		return 0;
 	}
 
-	for (j = 0; j < chain->depth - 1; j++, i++) {
+	for (j = chain->base; j < chain->base + chain->depth - 1; j++, i++) {
 		id = curr->held_locks[i].class_idx;
+		type = curr->held_locks[i].read;
 
-		if (DEBUG_LOCKS_WARN_ON(chain_hlocks[chain->base + j] != id)) {
+		if (DEBUG_LOCKS_WARN_ON((chain_hlocks[j] != id) ||
+					(chain_hlocks_type[j] != type))) {
 			print_collision(curr, hlock, chain, depth);
 			return 0;
 		}
@@ -3004,7 +3024,8 @@ static int validate_chain(struct task_struct *curr, struct held_lock *next,
 	 * lock_chains. If it exists the check is actually not needed.
 	 */
 	chain_key = iterate_chain_key(hlock->prev_chain_key,
-				      hlock_class(next) - lock_classes);
+				      hlock_class(next) - lock_classes,
+				      next->read);
 
 	goto chain_again;
 
@@ -3062,7 +3083,8 @@ static void check_chain_key(struct task_struct *curr)
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
 			chain_key = INITIAL_CHAIN_KEY;
-		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
+		chain_key = iterate_chain_key(chain_key, hlock->class_idx,
+					      hlock->read);
 		prev_hlock = hlock;
 	}
 	if (chain_key != curr->curr_chain_key) {
@@ -3972,7 +3994,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (separate_irq_context(curr, hlock))
 		chain_key = INITIAL_CHAIN_KEY;
 
-	chain_key = iterate_chain_key(chain_key, class_idx);
+	chain_key = iterate_chain_key(chain_key, class_idx, read);
 
 	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
 		print_lock_nested_lock_not_held(curr, hlock, ip);
@@ -4833,7 +4855,8 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 recalc:
 	chain_key = INITIAL_CHAIN_KEY;
 	for (i = chain->base; i < chain->base + chain->depth; i++)
-		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i],
+					      chain_hlocks_type[i]);
 	if (chain->depth && chain->chain_key == chain_key)
 		return;
 	/* Overwrite the chain key for concurrent RCU readers. */
-- 
1.8.3.1

