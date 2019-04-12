Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA84C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D3320674
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDLBxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:53:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:48974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726678AbfDLBxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:53:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 95B6FAD03;
        Fri, 12 Apr 2019 01:52:58 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Fri, 12 Apr 2019 11:52:08 +1000
Subject: [PATCH 5/5] rhashtable: use BIT(0) for locking.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Message-ID: <155503392809.17793.9965831639493335726.stgit@noble.brown>
In-Reply-To: <155503371949.17793.8266195008003399968.stgit@noble.brown>
References: <155503371949.17793.8266195008003399968.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Guenter Roeck, the new bit-locking using
BIT(1) doesn't work on the m68k architecture.  m68k only requires
2-byte alignment for words and longwords, so there is only one
unused bit in pointers to structs - We current use two, one for the
NULLS marker at the end of the linked list, and one for the bit-lock
in the head of the list.

The two uses don't need to conflict as we never need the head of the
list to be a NULLS marker - the marker is only needed to check if an
object has moved to a different table, and the bucket head cannot
move.  The NULLS marker is only needed in a ->next pointer.

As we already have different types for the bucket head pointer (struct
rhash_lock_head) and the ->next pointers (struct rhash_head), it is
fairly easy to treat the lsb differently in each.

So: Initialize buckets heads to NULL, and use the lsb for locking.
When loading the pointer from the bucket head, if it is NULL (ignoring
the lock big), report as being the expected NULLS marker.
When storing a value into a bucket head, if it is a NULLS marker,
store NULL instead.

And convert all places that used bit 1 for locking, to use bit 0.

Fixes: 8f0db018006a ("rhashtable: use bit_spin_locks to protect hash bucket.")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   35 ++++++++++++++++++++++++-----------
 lib/rhashtable.c           |    2 +-
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 882bc0fcea4b..f7714d3b46bd 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -35,7 +35,7 @@
  * the least significant bit set but otherwise stores the address of
  * the hash bucket.  This allows us to be be sure we've found the end
  * of the right list.
- * The value stored in the hash bucket has BIT(2) used as a lock bit.
+ * The value stored in the hash bucket has BIT(0) used as a lock bit.
  * This bit must be atomically set before any changes are made to
  * the chain.  To avoid dereferencing this pointer without clearing
  * the bit first, we use an opaque 'struct rhash_lock_head *' for the
@@ -91,15 +91,19 @@ struct bucket_table {
  * NULLS_MARKER() expects a hash value with the low
  * bits mostly likely to be significant, and it discards
  * the msb.
- * We git it an address, in which the bottom 2 bits are
+ * We give it an address, in which the bottom bit is
  * always 0, and the msb might be significant.
  * So we shift the address down one bit to align with
  * expectations and avoid losing a significant bit.
+ *
+ * We never store the NULLS_MARKER in the hash table
+ * itself as we need the lsb for locking.
+ * Instead we store a NULL
  */
 #define	RHT_NULLS_MARKER(ptr)	\
 	((void *)NULLS_MARKER(((unsigned long) (ptr)) >> 1))
 #define INIT_RHT_NULLS_HEAD(ptr)	\
-	((ptr) = RHT_NULLS_MARKER(&(ptr)))
+	((ptr) = NULL)
 
 static inline bool rht_is_a_nulls(const struct rhash_head *ptr)
 {
@@ -302,8 +306,9 @@ static inline struct rhash_lock_head __rcu **rht_bucket_insert(
 }
 
 /*
- * We lock a bucket by setting BIT(1) in the pointer - this is always
- * zero in real pointers and in the nulls marker.
+ * We lock a bucket by setting BIT(0) in the pointer - this is always
+ * zero in real pointers.  The NULLS mark is never stored in the bucket,
+ * rather we store NULL if the bucket is empty.
  * bit_spin_locks do not handle contention well, but the whole point
  * of the hashtable design is to achieve minimum per-bucket contention.
  * A nested hash table might not have a bucket pointer.  In that case
@@ -323,7 +328,7 @@ static inline void rht_lock(struct bucket_table *tbl,
 			    struct rhash_lock_head **bkt)
 {
 	local_bh_disable();
-	bit_spin_lock(1, (unsigned long *)bkt);
+	bit_spin_lock(0, (unsigned long *)bkt);
 	lock_map_acquire(&tbl->dep_map);
 }
 
@@ -332,7 +337,7 @@ static inline void rht_lock_nested(struct bucket_table *tbl,
 				   unsigned int subclass)
 {
 	local_bh_disable();
-	bit_spin_lock(1, (unsigned long *)bucket);
+	bit_spin_lock(0, (unsigned long *)bucket);
 	lock_acquire_exclusive(&tbl->dep_map, subclass, 0, NULL, _THIS_IP_);
 }
 
@@ -340,7 +345,7 @@ static inline void rht_unlock(struct bucket_table *tbl,
 			      struct rhash_lock_head **bkt)
 {
 	lock_map_release(&tbl->dep_map);
-	bit_spin_unlock(1, (unsigned long *)bkt);
+	bit_spin_unlock(0, (unsigned long *)bkt);
 	local_bh_enable();
 }
 
@@ -358,7 +363,9 @@ static inline struct rhash_head *rht_ptr(
 	const struct rhash_lock_head *p =
 		rht_dereference_bucket_rcu(*bkt, tbl, hash);
 
-	return (void *)(((unsigned long)p) & ~BIT(1));
+	if ((((unsigned long)p) & ~BIT(0)) == 0)
+		return RHT_NULLS_MARKER(bkt);
+	return (void *)(((unsigned long)p) & ~BIT(0));
 }
 
 static inline struct rhash_head *rht_ptr_exclusive(
@@ -367,7 +374,9 @@ static inline struct rhash_head *rht_ptr_exclusive(
 	const struct rhash_lock_head *p =
 		rcu_dereference_protected(*bkt, 1);
 
-	return (void *)(((unsigned long)p) & ~BIT(1));
+	if (!p)
+		return RHT_NULLS_MARKER(bkt);
+	return (void *)(((unsigned long)p) & ~BIT(0));
 }
 
 static inline void rht_assign_locked(struct rhash_lock_head __rcu **bkt,
@@ -375,7 +384,9 @@ static inline void rht_assign_locked(struct rhash_lock_head __rcu **bkt,
 {
 	struct rhash_head __rcu **p = (struct rhash_head __rcu **)bkt;
 
-	rcu_assign_pointer(*p, (void *)((unsigned long)obj | BIT(1)));
+	if (rht_is_a_nulls(obj))
+		obj = NULL;
+	rcu_assign_pointer(*p, (void *)((unsigned long)obj | BIT(0)));
 }
 
 static inline void rht_assign_unlock(struct bucket_table *tbl,
@@ -384,6 +395,8 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
 {
 	struct rhash_head __rcu **p = (struct rhash_head __rcu **)bkt;
 
+	if (rht_is_a_nulls(obj))
+		obj = NULL;
 	lock_map_release(&tbl->dep_map);
 	rcu_assign_pointer(*p, obj);
 	preempt_enable();
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 3bae6b05b4ba..ad5ab98328c5 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -59,7 +59,7 @@ int lockdep_rht_bucket_is_held(const struct bucket_table *tbl, u32 hash)
 		return 1;
 	if (unlikely(tbl->nest))
 		return 1;
-	return bit_spin_is_locked(1, (unsigned long *)&tbl->buckets[hash]);
+	return bit_spin_is_locked(0, (unsigned long *)&tbl->buckets[hash]);
 }
 EXPORT_SYMBOL_GPL(lockdep_rht_bucket_is_held);
 #else


