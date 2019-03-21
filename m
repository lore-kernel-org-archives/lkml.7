Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC4EC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA9A218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfCUDoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:44:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbfCUDoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:44:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36540AD49;
        Thu, 21 Mar 2019 03:44:31 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Miller <davem@davemloft.net>
Date:   Thu, 21 Mar 2019 14:42:40 +1100
Subject: [PATCH 2/2] rhashtable: rename rht_for_each*continue as *from.
Cc:     tgraf@suug.ch, netdev@vger.kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org
Message-ID: <155313976003.31132.1151463596410155500.stgit@noble.brown>
In-Reply-To: <155313966311.31132.17461701268394583387.stgit@noble.brown>
References: <155313966311.31132.17461701268394583387.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern set by list.h is that for_each..continue()
iterators start at the next entry after the given one,
while for_each..from() iterators start at the given
entry.

The rht_for_each*continue() iterators are documented as though the
start at the 'next' entry, but actually start at the given entry,
and they are used expecting that behaviour.
So fix the documentation and change the names to *from for consistency
with list.h

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 .clang-format              |    8 ++++----
 include/linux/rhashtable.h |   40 ++++++++++++++++++++--------------------
 lib/rhashtable.c           |    2 +-
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/.clang-format b/.clang-format
index f49620f506f1..3a4c8220df2f 100644
--- a/.clang-format
+++ b/.clang-format
@@ -366,14 +366,14 @@ ForEachMacros:
   - 'rhl_for_each_entry_rcu'
   - 'rhl_for_each_rcu'
   - 'rht_for_each'
-  - 'rht_for_each_continue'
+  - 'rht_for_each_from'
   - 'rht_for_each_entry'
-  - 'rht_for_each_entry_continue'
+  - 'rht_for_each_entry_from'
   - 'rht_for_each_entry_rcu'
-  - 'rht_for_each_entry_rcu_continue'
+  - 'rht_for_each_entry_rcu_from'
   - 'rht_for_each_entry_safe'
   - 'rht_for_each_rcu'
-  - 'rht_for_each_rcu_continue'
+  - 'rht_for_each_rcu_from'
   - '__rq_for_each_bio'
   - 'rq_for_each_segment'
   - 'scsi_for_each_prot_sg'
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 3864193d5e2e..86dfa417848d 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -306,13 +306,13 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
 }
 
 /**
- * rht_for_each_continue - continue iterating over hash chain
+ * rht_for_each_from - iterate over hash chain from given head
  * @pos:	the &struct rhash_head to use as a loop cursor.
- * @head:	the previous &struct rhash_head to continue from
+ * @head:	the &struct rhash_head to start from
  * @tbl:	the &struct bucket_table
  * @hash:	the hash value / bucket index
  */
-#define rht_for_each_continue(pos, head, tbl, hash) \
+#define rht_for_each_from(pos, head, tbl, hash) \
 	for (pos = rht_dereference_bucket(head, tbl, hash); \
 	     !rht_is_a_nulls(pos); \
 	     pos = rht_dereference_bucket((pos)->next, tbl, hash))
@@ -324,18 +324,18 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * @hash:	the hash value / bucket index
  */
 #define rht_for_each(pos, tbl, hash) \
-	rht_for_each_continue(pos, *rht_bucket(tbl, hash), tbl, hash)
+	rht_for_each_from(pos, *rht_bucket(tbl, hash), tbl, hash)
 
 /**
- * rht_for_each_entry_continue - continue iterating over hash chain
+ * rht_for_each_entry_from - iterate over hash chain from given head
  * @tpos:	the type * to use as a loop cursor.
  * @pos:	the &struct rhash_head to use as a loop cursor.
- * @head:	the previous &struct rhash_head to continue from
+ * @head:	the &struct rhash_head to start from
  * @tbl:	the &struct bucket_table
  * @hash:	the hash value / bucket index
  * @member:	name of the &struct rhash_head within the hashable struct.
  */
-#define rht_for_each_entry_continue(tpos, pos, head, tbl, hash, member)	\
+#define rht_for_each_entry_from(tpos, pos, head, tbl, hash, member)	\
 	for (pos = rht_dereference_bucket(head, tbl, hash);		\
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	\
 	     pos = rht_dereference_bucket((pos)->next, tbl, hash))
@@ -349,7 +349,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * @member:	name of the &struct rhash_head within the hashable struct.
  */
 #define rht_for_each_entry(tpos, pos, tbl, hash, member)		\
-	rht_for_each_entry_continue(tpos, pos, *rht_bucket(tbl, hash),	\
+	rht_for_each_entry_from(tpos, pos, *rht_bucket(tbl, hash),	\
 				    tbl, hash, member)
 
 /**
@@ -374,9 +374,9 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
 		       rht_dereference_bucket(pos->next, tbl, hash) : NULL)
 
 /**
- * rht_for_each_rcu_continue - continue iterating over rcu hash chain
+ * rht_for_each_rcu_from - iterate over rcu hash chain from given head
  * @pos:	the &struct rhash_head to use as a loop cursor.
- * @head:	the previous &struct rhash_head to continue from
+ * @head:	the &struct rhash_head to start from
  * @tbl:	the &struct bucket_table
  * @hash:	the hash value / bucket index
  *
@@ -384,7 +384,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * the _rcu mutation primitives such as rhashtable_insert() as long as the
  * traversal is guarded by rcu_read_lock().
  */
-#define rht_for_each_rcu_continue(pos, head, tbl, hash)			\
+#define rht_for_each_rcu_from(pos, head, tbl, hash)			\
 	for (({barrier(); }),						\
 	     pos = rht_dereference_bucket_rcu(head, tbl, hash);		\
 	     !rht_is_a_nulls(pos);					\
@@ -401,13 +401,13 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * traversal is guarded by rcu_read_lock().
  */
 #define rht_for_each_rcu(pos, tbl, hash)				\
-	rht_for_each_rcu_continue(pos, *rht_bucket(tbl, hash), tbl, hash)
+	rht_for_each_rcu_from(pos, *rht_bucket(tbl, hash), tbl, hash)
 
 /**
- * rht_for_each_entry_rcu_continue - continue iterating over rcu hash chain
+ * rht_for_each_entry_rcu_from - iterated over rcu hash chain from given head
  * @tpos:	the type * to use as a loop cursor.
  * @pos:	the &struct rhash_head to use as a loop cursor.
- * @head:	the previous &struct rhash_head to continue from
+ * @head:	the &struct rhash_head to start from
  * @tbl:	the &struct bucket_table
  * @hash:	the hash value / bucket index
  * @member:	name of the &struct rhash_head within the hashable struct.
@@ -416,7 +416,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * the _rcu mutation primitives such as rhashtable_insert() as long as the
  * traversal is guarded by rcu_read_lock().
  */
-#define rht_for_each_entry_rcu_continue(tpos, pos, head, tbl, hash, member) \
+#define rht_for_each_entry_rcu_from(tpos, pos, head, tbl, hash, member) \
 	for (({barrier(); }),						    \
 	     pos = rht_dereference_bucket_rcu(head, tbl, hash);		    \
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	    \
@@ -435,7 +435,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * traversal is guarded by rcu_read_lock().
  */
 #define rht_for_each_entry_rcu(tpos, pos, tbl, hash, member)		   \
-	rht_for_each_entry_rcu_continue(tpos, pos, *rht_bucket(tbl, hash), \
+	rht_for_each_entry_rcu_from(tpos, pos, *rht_bucket(tbl, hash), \
 					tbl, hash, member)
 
 /**
@@ -491,7 +491,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 	hash = rht_key_hashfn(ht, tbl, key, params);
 	head = rht_bucket(tbl, hash);
 	do {
-		rht_for_each_rcu_continue(he, *head, tbl, hash) {
+		rht_for_each_rcu_from(he, *head, tbl, hash) {
 			if (params.obj_cmpfn ?
 			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
 			    rhashtable_compare(&arg, rht_obj(ht, he)))
@@ -625,7 +625,7 @@ static inline void *__rhashtable_insert_fast(
 	if (!pprev)
 		goto out;
 
-	rht_for_each_continue(head, *pprev, tbl, hash) {
+	rht_for_each_from(head, *pprev, tbl, hash) {
 		struct rhlist_head *plist;
 		struct rhlist_head *list;
 
@@ -890,7 +890,7 @@ static inline int __rhashtable_remove_fast_one(
 	spin_lock_bh(lock);
 
 	pprev = rht_bucket_var(tbl, hash);
-	rht_for_each_continue(he, *pprev, tbl, hash) {
+	rht_for_each_from(he, *pprev, tbl, hash) {
 		struct rhlist_head *list;
 
 		list = container_of(he, struct rhlist_head, rhead);
@@ -1042,7 +1042,7 @@ static inline int __rhashtable_replace_fast(
 	spin_lock_bh(lock);
 
 	pprev = rht_bucket_var(tbl, hash);
-	rht_for_each_continue(he, *pprev, tbl, hash) {
+	rht_for_each_from(he, *pprev, tbl, hash) {
 		if (he != obj_old) {
 			pprev = &he->next;
 			continue;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 776b3a82d3a1..f65e43fb1ff8 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -490,7 +490,7 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 
 	elasticity = RHT_ELASTICITY;
 	pprev = rht_bucket_var(tbl, hash);
-	rht_for_each_continue(head, *pprev, tbl, hash) {
+	rht_for_each_from(head, *pprev, tbl, hash) {
 		struct rhlist_head *list;
 		struct rhlist_head *plist;
 


