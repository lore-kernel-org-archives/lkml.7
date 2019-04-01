Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4224C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8E020880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 23:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfDAXI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 19:08:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:54380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbfDAXIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 19:08:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC11FAFF9;
        Mon,  1 Apr 2019 23:08:23 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Tue, 02 Apr 2019 10:07:45 +1100
Subject: [PATCH 2/4] rhashtable: allow rht_bucket_var to return NULL.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <155416006517.9540.11353811989522154490.stgit@noble.brown>
In-Reply-To: <155416000985.9540.14182958463813560577.stgit@noble.brown>
References: <155416000985.9540.14182958463813560577.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than returning a pointer to a static nulls, rht_bucket_var()
now returns NULL if the bucket doesn't exist.
This will make the next patch, which stores a bitlock in the
bucket pointer, somewhat cleaner.

This change involves introducing __rht_bucket_nested() which is
like rht_bucket_nested(), but doesn't provide the static nulls,
and changing rht_bucket_nested() to call this and possible
provide a static nulls - as is still needed for the non-var case.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   11 +++++++++--
 lib/rhashtable.c           |   29 ++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 86dfa417848d..0c9175aeab8a 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -265,6 +265,8 @@ void rhashtable_destroy(struct rhashtable *ht);
 
 struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
 					    unsigned int hash);
+struct rhash_head __rcu **__rht_bucket_nested(const struct bucket_table *tbl,
+					      unsigned int hash);
 struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
 						   struct bucket_table *tbl,
 						   unsigned int hash);
@@ -294,7 +296,7 @@ static inline struct rhash_head __rcu *const *rht_bucket(
 static inline struct rhash_head __rcu **rht_bucket_var(
 	struct bucket_table *tbl, unsigned int hash)
 {
-	return unlikely(tbl->nest) ? rht_bucket_nested(tbl, hash) :
+	return unlikely(tbl->nest) ? __rht_bucket_nested(tbl, hash) :
 				     &tbl->buckets[hash];
 }
 
@@ -890,6 +892,8 @@ static inline int __rhashtable_remove_fast_one(
 	spin_lock_bh(lock);
 
 	pprev = rht_bucket_var(tbl, hash);
+	if (!pprev)
+		goto out;
 	rht_for_each_from(he, *pprev, tbl, hash) {
 		struct rhlist_head *list;
 
@@ -934,6 +938,7 @@ static inline int __rhashtable_remove_fast_one(
 		break;
 	}
 
+out:
 	spin_unlock_bh(lock);
 
 	if (err > 0) {
@@ -1042,6 +1047,8 @@ static inline int __rhashtable_replace_fast(
 	spin_lock_bh(lock);
 
 	pprev = rht_bucket_var(tbl, hash);
+	if (!pprev)
+		goto out;
 	rht_for_each_from(he, *pprev, tbl, hash) {
 		if (he != obj_old) {
 			pprev = &he->next;
@@ -1053,7 +1060,7 @@ static inline int __rhashtable_replace_fast(
 		err = 0;
 		break;
 	}
-
+out:
 	spin_unlock_bh(lock);
 
 	return err;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6c4f5c8e9baa..b28fdd560ea9 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -237,8 +237,10 @@ static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
 		goto out;
 
 	err = -ENOENT;
+	if (!pprev)
+		goto out;
 
-	rht_for_each(entry, old_tbl, old_hash) {
+	rht_for_each_from(entry, *pprev, old_tbl, old_hash) {
 		err = 0;
 		next = rht_dereference_bucket(entry->next, old_tbl, old_hash);
 
@@ -496,6 +498,8 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 
 	elasticity = RHT_ELASTICITY;
 	pprev = rht_bucket_var(tbl, hash);
+	if (!pprev)
+		return ERR_PTR(-ENOENT);
 	rht_for_each_from(head, *pprev, tbl, hash) {
 		struct rhlist_head *list;
 		struct rhlist_head *plist;
@@ -1161,11 +1165,10 @@ void rhashtable_destroy(struct rhashtable *ht)
 }
 EXPORT_SYMBOL_GPL(rhashtable_destroy);
 
-struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
-					    unsigned int hash)
+struct rhash_head __rcu **__rht_bucket_nested(const struct bucket_table *tbl,
+					      unsigned int hash)
 {
 	const unsigned int shift = PAGE_SHIFT - ilog2(sizeof(void *));
-	static struct rhash_head __rcu *rhnull;
 	unsigned int index = hash & ((1 << tbl->nest) - 1);
 	unsigned int size = tbl->size >> tbl->nest;
 	unsigned int subhash = hash;
@@ -1183,15 +1186,23 @@ struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
 		subhash >>= shift;
 	}
 
-	if (!ntbl) {
-		if (!rhnull)
-			INIT_RHT_NULLS_HEAD(rhnull);
-		return &rhnull;
-	}
+	if (!ntbl)
+		return NULL;
 
 	return &ntbl[subhash].bucket;
 
 }
+EXPORT_SYMBOL_GPL(__rht_bucket_nested);
+
+struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
+					    unsigned int hash)
+{
+	static struct rhash_head __rcu *rhnull;
+
+	if (!rhnull)
+		INIT_RHT_NULLS_HEAD(rhnull);
+	return __rht_bucket_nested(tbl, hash) ?: &rhnull;
+}
 EXPORT_SYMBOL_GPL(rht_bucket_nested);
 
 struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,


