Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDF5C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB0720674
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDLBwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:52:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:48850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfDLBwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:52:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCD11AD03;
        Fri, 12 Apr 2019 01:52:33 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Fri, 12 Apr 2019 11:52:07 +1000
Subject: [PATCH 1/5] rhashtable: fix some __rcu annotation errors
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Message-ID: <155503392792.17793.11454059177248116925.stgit@noble.brown>
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

With these annotations, the rhashtable now gets no
warnings when compiled with "C=1" for sparse checking.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   11 ++++++-----
 lib/rhashtable.c           |    4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 460c0eaf6b96..2711cbf01b64 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -40,7 +40,7 @@
  * the chain.  To avoid dereferencing this pointer without clearing
  * the bit first, we use an opaque 'struct rhash_lock_head *' for the
  * pointer stored in the bucket.  This struct needs to be defined so
- * that rcu_derefernce() works on it, but it has no content so a
+ * that rcu_dereference() works on it, but it has no content so a
  * cast is needed for it to be useful.  This ensures it isn't
  * used by mistake with clearing the lock bit first.
  */
@@ -130,10 +130,10 @@ static inline void rht_unlock(struct bucket_table *tbl,
 }
 
 static inline void rht_assign_unlock(struct bucket_table *tbl,
-				     struct rhash_lock_head **bkt,
+				     struct rhash_lock_head __rcu **bkt,
 				     struct rhash_head *obj)
 {
-	struct rhash_head **p = (struct rhash_head **)bkt;
+	struct rhash_head __rcu **p = (struct rhash_head __rcu **)bkt;
 
 	lock_map_release(&tbl->dep_map);
 	rcu_assign_pointer(*p, obj);
@@ -556,6 +556,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 	};
 	struct rhash_lock_head __rcu * const *bkt;
 	struct bucket_table *tbl;
+	struct rhash_head __rcu *head;
 	struct rhash_head *he;
 	unsigned int hash;
 
@@ -564,8 +565,8 @@ static inline struct rhash_head *__rhashtable_lookup(
 	hash = rht_key_hashfn(ht, tbl, key, params);
 	bkt = rht_bucket(tbl, hash);
 	do {
-		he = rht_ptr(rht_dereference_bucket_rcu(*bkt, tbl, hash));
-		rht_for_each_rcu_from(he, he, tbl, hash) {
+		head = rht_ptr(rht_dereference_bucket_rcu(*bkt, tbl, hash));
+		rht_for_each_rcu_from(he, head, tbl, hash) {
 			if (params.obj_cmpfn ?
 			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
 			    rhashtable_compare(&arg, rht_obj(ht, he)))
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index a8583af43b59..ec485962de5f 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -224,7 +224,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 	struct bucket_table *new_tbl = rhashtable_last_table(ht, old_tbl);
 	int err = -EAGAIN;
 	struct rhash_head *head, *next, *entry;
-	struct rhash_head **pprev = NULL;
+	struct rhash_head __rcu **pprev = NULL;
 	unsigned int new_hash;
 
 	if (new_tbl->nest)
@@ -487,7 +487,7 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 		.ht = ht,
 		.key = key,
 	};
-	struct rhash_head **pprev = NULL;
+	struct rhash_head __rcu **pprev = NULL;
 	struct rhash_head *head;
 	int elasticity;
 


