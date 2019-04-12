Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5408AC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C30C20674
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDLBwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:52:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:48956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbfDLBwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:52:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4022BACF8;
        Fri, 12 Apr 2019 01:52:52 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Fri, 12 Apr 2019 11:52:08 +1000
Subject: [PATCH 4/5] rhashtable: replace rht_ptr_locked() with
 rht_assign_locked()
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Message-ID: <155503392804.17793.16261235110097755380.stgit@noble.brown>
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

The only times rht_ptr_locked() is used, it is to store a new
value in a bucket-head.  This is the only time it makes sense
to use it too.  So replace it by a function which does the
whole task:  Sets the lock bit and assigns to a bucket head.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    9 ++++++---
 lib/rhashtable.c           |    6 +++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index b54e6436547e..882bc0fcea4b 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -316,6 +316,7 @@ static inline struct rhash_lock_head __rcu **rht_bucket_insert(
  * local_bh. For that we have rht_assign_unlock().  As rcu_assign_pointer()
  * provides the same release semantics that bit_spin_unlock() provides,
  * this is safe.
+ * When we write to a bucket without unlocking, we use rht_assign_locked().
  */
 
 static inline void rht_lock(struct bucket_table *tbl,
@@ -369,10 +370,12 @@ static inline struct rhash_head *rht_ptr_exclusive(
 	return (void *)(((unsigned long)p) & ~BIT(1));
 }
 
-static inline struct rhash_lock_head __rcu *rht_ptr_locked(const
-							   struct rhash_head *p)
+static inline void rht_assign_locked(struct rhash_lock_head __rcu **bkt,
+				     struct rhash_head *obj)
 {
-	return (void *)(((unsigned long)p) | BIT(1));
+	struct rhash_head __rcu **p = (struct rhash_head __rcu **)bkt;
+
+	rcu_assign_pointer(*p, (void *)((unsigned long)obj | BIT(1)));
 }
 
 static inline void rht_assign_unlock(struct bucket_table *tbl,
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 1f38f550ba76..3bae6b05b4ba 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -260,7 +260,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 		rcu_assign_pointer(*pprev, next);
 	else
 		/* Need to preserved the bit lock. */
-		rcu_assign_pointer(*bkt, rht_ptr_locked(next));
+		rht_assign_locked(bkt, next);
 
 out:
 	return err;
@@ -518,7 +518,7 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 			rcu_assign_pointer(*pprev, obj);
 		else
 			/* Need to preserve the bit lock */
-			rcu_assign_pointer(*bkt, rht_ptr_locked(obj));
+			rht_assign_locked(bkt, obj);
 
 		return NULL;
 	}
@@ -571,7 +571,7 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 	/* bkt is always the head of the list, so it holds
 	 * the lock, which we need to preserve
 	 */
-	rcu_assign_pointer(*bkt, rht_ptr_locked(obj));
+	rht_assign_locked(bkt, obj);
 
 	atomic_inc(&ht->nelems);
 	if (rht_grow_above_75(ht, tbl))


