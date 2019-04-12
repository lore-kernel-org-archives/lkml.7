Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54885C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C54F20674
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDLBwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:52:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:48896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfDLBwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:52:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5DFAAD0A;
        Fri, 12 Apr 2019 01:52:39 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Fri, 12 Apr 2019 11:52:08 +1000
Subject: [PATCH 2/5] rhashtable: reorder some inline functions and macros.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Message-ID: <155503392797.17793.15780367123758287135.stgit@noble.brown>
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

This patch only moves some code around, it doesn't
change the code at all.
A subsequent patch will benefit from this as it needs
to add calls to functions which are now defined before the
call-site, but weren't before.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |  142 ++++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 2711cbf01b64..c504cd820736 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -87,77 +87,6 @@ struct bucket_table {
 	struct rhash_lock_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
 
-/*
- * We lock a bucket by setting BIT(1) in the pointer - this is always
- * zero in real pointers and in the nulls marker.
- * bit_spin_locks do not handle contention well, but the whole point
- * of the hashtable design is to achieve minimum per-bucket contention.
- * A nested hash table might not have a bucket pointer.  In that case
- * we cannot get a lock.  For remove and replace the bucket cannot be
- * interesting and doesn't need locking.
- * For insert we allocate the bucket if this is the last bucket_table,
- * and then take the lock.
- * Sometimes we unlock a bucket by writing a new pointer there.  In that
- * case we don't need to unlock, but we do need to reset state such as
- * local_bh. For that we have rht_assign_unlock().  As rcu_assign_pointer()
- * provides the same release semantics that bit_spin_unlock() provides,
- * this is safe.
- */
-
-static inline void rht_lock(struct bucket_table *tbl,
-			    struct rhash_lock_head **bkt)
-{
-	local_bh_disable();
-	bit_spin_lock(1, (unsigned long *)bkt);
-	lock_map_acquire(&tbl->dep_map);
-}
-
-static inline void rht_lock_nested(struct bucket_table *tbl,
-				   struct rhash_lock_head **bucket,
-				   unsigned int subclass)
-{
-	local_bh_disable();
-	bit_spin_lock(1, (unsigned long *)bucket);
-	lock_acquire_exclusive(&tbl->dep_map, subclass, 0, NULL, _THIS_IP_);
-}
-
-static inline void rht_unlock(struct bucket_table *tbl,
-			      struct rhash_lock_head **bkt)
-{
-	lock_map_release(&tbl->dep_map);
-	bit_spin_unlock(1, (unsigned long *)bkt);
-	local_bh_enable();
-}
-
-static inline void rht_assign_unlock(struct bucket_table *tbl,
-				     struct rhash_lock_head __rcu **bkt,
-				     struct rhash_head *obj)
-{
-	struct rhash_head __rcu **p = (struct rhash_head __rcu **)bkt;
-
-	lock_map_release(&tbl->dep_map);
-	rcu_assign_pointer(*p, obj);
-	preempt_enable();
-	__release(bitlock);
-	local_bh_enable();
-}
-
-/*
- * If 'p' is a bucket head and might be locked:
- *   rht_ptr() returns the address without the lock bit.
- *   rht_ptr_locked() returns the address WITH the lock bit.
- */
-static inline struct rhash_head __rcu *rht_ptr(const struct rhash_lock_head *p)
-{
-	return (void *)(((unsigned long)p) & ~BIT(1));
-}
-
-static inline struct rhash_lock_head __rcu *rht_ptr_locked(const
-							   struct rhash_head *p)
-{
-	return (void *)(((unsigned long)p) | BIT(1));
-}
-
 /*
  * NULLS_MARKER() expects a hash value with the low
  * bits mostly likely to be significant, and it discards
@@ -372,6 +301,77 @@ static inline struct rhash_lock_head __rcu **rht_bucket_insert(
 				     &tbl->buckets[hash];
 }
 
+/*
+ * We lock a bucket by setting BIT(1) in the pointer - this is always
+ * zero in real pointers and in the nulls marker.
+ * bit_spin_locks do not handle contention well, but the whole point
+ * of the hashtable design is to achieve minimum per-bucket contention.
+ * A nested hash table might not have a bucket pointer.  In that case
+ * we cannot get a lock.  For remove and replace the bucket cannot be
+ * interesting and doesn't need locking.
+ * For insert we allocate the bucket if this is the last bucket_table,
+ * and then take the lock.
+ * Sometimes we unlock a bucket by writing a new pointer there.  In that
+ * case we don't need to unlock, but we do need to reset state such as
+ * local_bh. For that we have rht_assign_unlock().  As rcu_assign_pointer()
+ * provides the same release semantics that bit_spin_unlock() provides,
+ * this is safe.
+ */
+
+static inline void rht_lock(struct bucket_table *tbl,
+			    struct rhash_lock_head **bkt)
+{
+	local_bh_disable();
+	bit_spin_lock(1, (unsigned long *)bkt);
+	lock_map_acquire(&tbl->dep_map);
+}
+
+static inline void rht_lock_nested(struct bucket_table *tbl,
+				   struct rhash_lock_head **bucket,
+				   unsigned int subclass)
+{
+	local_bh_disable();
+	bit_spin_lock(1, (unsigned long *)bucket);
+	lock_acquire_exclusive(&tbl->dep_map, subclass, 0, NULL, _THIS_IP_);
+}
+
+static inline void rht_unlock(struct bucket_table *tbl,
+			      struct rhash_lock_head **bkt)
+{
+	lock_map_release(&tbl->dep_map);
+	bit_spin_unlock(1, (unsigned long *)bkt);
+	local_bh_enable();
+}
+
+/*
+ * If 'p' is a bucket head and might be locked:
+ *   rht_ptr() returns the address without the lock bit.
+ *   rht_ptr_locked() returns the address WITH the lock bit.
+ */
+static inline struct rhash_head __rcu *rht_ptr(const struct rhash_lock_head *p)
+{
+	return (void *)(((unsigned long)p) & ~BIT(1));
+}
+
+static inline struct rhash_lock_head __rcu *rht_ptr_locked(const
+							   struct rhash_head *p)
+{
+	return (void *)(((unsigned long)p) | BIT(1));
+}
+
+static inline void rht_assign_unlock(struct bucket_table *tbl,
+				     struct rhash_lock_head __rcu **bkt,
+				     struct rhash_head *obj)
+{
+	struct rhash_head __rcu **p = (struct rhash_head __rcu **)bkt;
+
+	lock_map_release(&tbl->dep_map);
+	rcu_assign_pointer(*p, obj);
+	preempt_enable();
+	__release(bitlock);
+	local_bh_enable();
+}
+
 /**
  * rht_for_each_from - iterate over hash chain from given head
  * @pos:	the &struct rhash_head to use as a loop cursor.


