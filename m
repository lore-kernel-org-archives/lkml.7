Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA75C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942752087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq/q7l8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfEPIA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:00:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42705 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPIA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:00:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id 145so1150245pgg.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AaKDsv43boINjs1bPKErBXZMYRaGI638p9LN6KhRPVM=;
        b=fq/q7l8tRuXWjvfR4sfXjdwXzdeSBknipBzLudleGw3lDEKiQNMJcRLmKi9gpqVsJL
         MuJESeMW6jBdxVajNC9D4dPK6i+HJQFAzSLf9itCFUkEkES3ue2wWHZVOLQhqbXmfJKp
         mj/1ZS1BZu5d0KfXZ9WjvjGcJfm2lQsNreo/f+6o1hhcvaVCwCQC5NRD/eTksIQBk0ep
         oROYSofbVSXteoEw+FNJkpPTY6T+jfYbeHb8Ns9iiQFnwOmH/EtKQvg2c2IxAUz21oNP
         NMVYWux+Kc2D9UE029naJmsEGYYLlODwgQtuakxG1cqeUP2sxnfIdjTaaWnsjdM51gXW
         Oc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AaKDsv43boINjs1bPKErBXZMYRaGI638p9LN6KhRPVM=;
        b=iz6YvZNyh0CjR8uAUPJzeMgc402x6Tnm8I7zXWWJ/1kpa+g4ZVsah/bOUNN0Wz9CM6
         7DKKD9q296HXudKJQcZZvZ7eOYlwbWMBZUG2J78IAvYphU74ErrsZqfgyH4HlFMGjnv/
         FU5lxgR34xT1+6bZx+aESSXkk/bhByyMTaOs66+LpvAaMeDBxKSzEYxD1AndQr4Y8yOG
         VYfBbXv7RpQNKoaidcoIieC7vyby4ndsf+iBYydlxBB2j08qdUqR7MHF2DHiW3aKOC41
         GMYR/bZ3GwU571OwWTE0RDWAxYBcMK60buuOHowKADhRmnXOTXphh5gpgP/31/YYOY2f
         hZcQ==
X-Gm-Message-State: APjAAAUwofOyJGprze9xuLIbPk2iNLb0NzASw3UrHrgslSYCR8OK/Dro
        fX94YsipD+/waTg8HuqCrjw=
X-Google-Smtp-Source: APXvYqzWRfv0Gfs+evVdyN5YWPIKPnbWm11S0Y6ADOpVdnkvRCwoP4pe9qI7xEpu//1ru8v5TLZ5nA==
X-Received: by 2002:a62:3381:: with SMTP id z123mr54131503pfz.42.1557993655593;
        Thu, 16 May 2019 01:00:55 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:00:55 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 09/17] locking/lockdep: Hash held lock's read-write type into chain key
Date:   Thu, 16 May 2019 16:00:07 +0800
Message-Id: <20190516080015.16033-10-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When computing a chain's hash key, we need to consider a held lock's type,
so the additional data to use Jenkins hash algorithm is a composite of the
new held lock's lock class index (lower 16 bits) and its read-write type
(higher 16 bits) as opposed to just class index before:

        held lock type (u16) : lock class index (u16)

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f11d018d..019099e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -359,11 +359,19 @@ struct pending_free {
  * it's a hash of all locks taken up to that lock, including that lock.
  * It's a 64-bit hash, because it's important for the keys to be
  * unique.
+ *
+ * The additional u32 data to hash is a composite of the new held lock's
+ * lock class index (lower 16 bits) and its read-write type (higher 16
+ * bits):
+ *
+ *     hlock type (u16) : lock class index (u16)
  */
-static inline u64 iterate_chain_key(u64 key, u32 idx)
+static inline u64 iterate_chain_key(u64 key, u32 idx, u16 hlock_type)
 {
 	u32 k0 = key, k1 = key >> 32;
 
+	idx += hlock_type << LOCK_TYPE_BITS;
+
 	__jhash_mix(idx, k0, k1); /* Macro that modifies arguments! */
 
 	return k0 | (u64)k1 << 32;
@@ -871,7 +879,8 @@ static bool check_lock_chain_key(struct lock_chain *chain)
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++)
-		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i],
+					      chain_hlocks_type[i]);
 	/*
 	 * The 'unsigned long long' casts avoid that a compiler warning
 	 * is reported when building tools/lib/lockdep.
@@ -2699,9 +2708,9 @@ static inline int get_first_held_lock(struct task_struct *curr,
 /*
  * Returns the next chain_key iteration
  */
-static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
+static u64 print_chain_key_iteration(int class_idx, u64 chain_key, int lock_type)
 {
-	u64 new_chain_key = iterate_chain_key(chain_key, class_idx);
+	u64 new_chain_key = iterate_chain_key(chain_key, class_idx, lock_type);
 
 	printk(" class_idx:%d -> chain_key:%016Lx",
 		class_idx,
@@ -2721,12 +2730,15 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
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
 
@@ -2734,12 +2746,14 @@ static void print_chain_keys_chain(struct lock_chain *chain)
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
@@ -2780,7 +2794,7 @@ static int check_no_collision(struct task_struct *curr,
 			struct lock_chain *chain)
 {
 #ifdef CONFIG_DEBUG_LOCKDEP
-	int i, j, id;
+	int i, j, id, type;
 
 	i = get_first_held_lock(curr, hlock);
 
@@ -2789,10 +2803,12 @@ static int check_no_collision(struct task_struct *curr,
 		return 0;
 	}
 
-	for (j = 0; j < chain->depth - 1; j++, i++) {
+	for (j = chain->base; j < chain->base + chain->depth - 1; j++, i++) {
 		id = curr->held_locks[i].class_idx;
+		type = curr->held_locks[i].read;
 
-		if (DEBUG_LOCKS_WARN_ON(chain_hlocks[chain->base + j] != id)) {
+		if (DEBUG_LOCKS_WARN_ON((chain_hlocks[j] != id) ||
+					(chain_hlocks_type[j] != type))) {
 			print_collision(curr, hlock, chain);
 			return 0;
 		}
@@ -3078,7 +3094,8 @@ static void check_chain_key(struct task_struct *curr)
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
 			chain_key = INITIAL_CHAIN_KEY;
-		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
+		chain_key = iterate_chain_key(chain_key, hlock->class_idx,
+					      hlock->read);
 		prev_hlock = hlock;
 	}
 	if (chain_key != curr->curr_chain_key) {
@@ -4001,7 +4018,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		chain_key = INITIAL_CHAIN_KEY;
 		chain_head = 1;
 	}
-	chain_key = iterate_chain_key(chain_key, class_idx);
+	chain_key = iterate_chain_key(chain_key, class_idx, read);
 
 	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
 		print_lock_nested_lock_not_held(curr, hlock, ip);
@@ -4845,7 +4862,8 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
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

