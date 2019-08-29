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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF5C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E332073F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI63RI2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfH2IdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:33:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34853 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfH2IdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:33:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id d85so1588008pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LkyFJrLqM/1skkJ2JlKIrqfmHWAJ7sxdhCa7MxHNzNk=;
        b=GI63RI2O2Agt0MZqP9S6OT3XQNshcxT8YKQsqJUFAcNIWwB2xCGVLxjAd3Lq3xroZj
         aIEGTUtowqk8TyP2HtO6IZhe+leyPuE7hIeFefJu+7BmLQVBO9ALwuy9ioRqzEWFICwL
         1atPMXxvSMcgsHu25eHyUrI+QrTrWWBzjoNRg8WVAgd7QEw0DIqcs9Xzr67zYw6eAtWL
         FURAiaVgj1QRYwwcKuhC5lt7sE53zpKCkik02gaFLC66tWlMnLKSOl9KhFL6vIWT5BfC
         MEH13BoAknzN8taWWvmkQd530AxLTJacHDayluiYWPWNMe2hIMhBwIs3F7+w0gcZsE87
         Fohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkyFJrLqM/1skkJ2JlKIrqfmHWAJ7sxdhCa7MxHNzNk=;
        b=VFRoR0gPHTZ0IMvrqmyH3TOGszK+blyEBMK8g4oiAfHC9xsToflNgJjqfC+QCeEbxl
         gPyrG3onhEcYR9lUufMqmGovQyOzeOygczn4hPLAkjICJsJZ8AUCgPw8ddZo4uxIbZKt
         fO74ReLqaZ96nbvTxVryfc5rdG1y+iyO/409GoDWaNS3yr0rc0tnxQWwn9gcdwfPXXqO
         CfyGmA/chs4bmjrH+Pamm7NpYiDYY150a1pgkFD06EHrcbIwDr6Jr24gOrhBuY1LJbMM
         s3WbdVZWMzpF3JOH3ZY0U/A/7qQvDvvMzDRCWuL17mrlYWdSvM8Np3jGaPR2nz/mkz0I
         IKTQ==
X-Gm-Message-State: APjAAAVUGGMPrijkFUVhBNp0fi5U98t+8+/i6qOltx/5HthZMrZMSY4Y
        ZIkCsq6hikIkLaNeEhVuN3o=
X-Google-Smtp-Source: APXvYqxQt97omGWgA3aZSuGJgbfQ1Es7S34wDGlDpA27UW5rhH2d/4tLjE63UMWM9ndZ40dPaGr+YA==
X-Received: by 2002:a62:35c6:: with SMTP id c189mr9873050pfa.96.1567067590794;
        Thu, 29 Aug 2019 01:33:10 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:33:10 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 22/30] locking/lockdep: Hash held lock's read-write type into chain key
Date:   Thu, 29 Aug 2019 16:31:24 +0800
Message-Id: <20190829083132.22394-23-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When computing a chain's hash key, we need to consider a held lock's
read-write type. To do so, we hash the held lock's read-write type into the
chain key. So the additional data to use Jenkins hash algorithm is a
composite of the new held lock's lock class index (lower 16 bits) and its
read-write type (higher 16 bits) as opposed to just class index before:

        held lock type (16 bits) : lock class index (16 bits)

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  |  1 +
 kernel/locking/lockdep.c | 55 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index eab8a90..3de4b37 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -183,6 +183,7 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 }
 
 #define LOCK_TYPE_BITS	2
+#define LOCK_TYPE_SHIFT	16
 
 /*
  * Every lock has a list of other locks that were taken after or before
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1166262..d13b6b7 100644
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
@@ -960,7 +971,8 @@ static bool check_lock_chain_key(struct lock_chain *chain)
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++)
-		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i],
+					      chain_hlocks_type[i]);
 	/*
 	 * The 'unsigned long long' casts avoid that a compiler warning
 	 * is reported when building tools/lib/lockdep.
@@ -2700,12 +2712,13 @@ static inline int get_first_held_lock(struct task_struct *curr,
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
@@ -2722,12 +2735,15 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
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
 
@@ -2735,12 +2751,14 @@ static void print_chain_keys_chain(struct lock_chain *chain)
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
@@ -2780,7 +2798,7 @@ static int check_no_collision(struct task_struct *curr, struct held_lock *hlock,
 			      struct lock_chain *chain, int depth)
 {
 #ifdef CONFIG_DEBUG_LOCKDEP
-	int i, j, id;
+	int i, j, id, type;
 
 	i = get_first_held_lock(curr, hlock, depth);
 
@@ -2789,10 +2807,12 @@ static int check_no_collision(struct task_struct *curr, struct held_lock *hlock,
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
@@ -3081,7 +3101,8 @@ static int validate_chain(struct task_struct *curr, struct held_lock *next,
 	 * lock_chains. If it exists the check is actually not needed.
 	 */
 	chain_key = iterate_chain_key(hlock->prev_chain_key,
-				      hlock_class(next) - lock_classes);
+				      hlock_class(next) - lock_classes,
+				      next->read);
 
 	goto chain_again;
 
@@ -3139,7 +3160,8 @@ static void check_chain_key(struct task_struct *curr)
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
 			chain_key = INITIAL_CHAIN_KEY;
-		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
+		chain_key = iterate_chain_key(chain_key, hlock->class_idx,
+					      hlock->read);
 		prev_hlock = hlock;
 	}
 	if (chain_key != curr->curr_chain_key) {
@@ -4048,7 +4070,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (separate_irq_context(curr, hlock))
 		chain_key = INITIAL_CHAIN_KEY;
 
-	chain_key = iterate_chain_key(chain_key, class_idx);
+	chain_key = iterate_chain_key(chain_key, class_idx, read);
 
 	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
 		print_lock_nested_lock_not_held(curr, hlock, ip);
@@ -4908,7 +4930,8 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
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

