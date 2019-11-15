Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB116C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F132072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCvH5rQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfKOPon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:44:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45785 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfKOPon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:44:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so11133454ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 07:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=84pl1/1+YPRtIqTofzdrWQY2WZWjY9tDk/ZvXd4FhfU=;
        b=vCvH5rQ0JC4w4QwWVm5lwaEEg+3sxM3iFLQU9k+U3ozBbKcf2+0rPoueV0G1KLP/uy
         sspJPoRqhGtxsNUOz9Asjt26NxCbR9s6vl1DZwzRK7E7PQf1y3vx7IAmPDS8iGwA36F7
         0KuPtN8HCc84Rfl3IWPzvQ4iLo26eRWhzSA4ANnUOEmq5vCIdREcYXvrgJoO3MB40aoW
         vtaFscl/4GtNQkVEHhPlYII5nSGNVtdnn+Z1IO6hhjHyQFgN/dXQq/fHwaEssTF92laA
         gtdEgLgMbjpj/NJJISw/mLpmZww3EC+As3UbZkriMyj9Y5DS4mxmEVDx7ts/aJgUs8H+
         IoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=84pl1/1+YPRtIqTofzdrWQY2WZWjY9tDk/ZvXd4FhfU=;
        b=rnC6qCqnfvvfMjeo8xuXk5+uBwCPtGGaSqNeBms6TrBQffwkhspOJw5bxkLyqZhH+G
         cB3lwgPOLmHk0Cxkjtrz+DMR5TmatV6Lik8Ki/eVwJCEesSXeKRpNKlnNuHRB1BJBoOv
         YqSkSAHweI6HPkRcePptDiTLImW4w1h8uISeLN0ztxZqDmciu8kgwMdVD0HCtxa+LsMQ
         SkNInDD2DdFD5c/iv9Kv+c+AFsFkj5FIoDkUxqRqBGkjP0qMT5VRxBQrHnTVXv5G96TW
         1EBjAyY34LLjBXUUXhbOwR5rAOI5H5fttnPIVDoaNMpxa28+sd3oQh3spAGurAeebzsA
         Wf/Q==
X-Gm-Message-State: APjAAAUtAxuR5TOHr1VWN0m8mMFcVcXI6lbr5eDopBff+7hxKM1ZgN4r
        a9RIdp5wIlysTjVwW3jvycs=
X-Google-Smtp-Source: APXvYqwjp5Jc5QL96PbtcfSeNmz7lyM5E4hliHUzg13SaO34zCfUgrkVkLxYPcA4usBJcXzj7wgevg==
X-Received: by 2002:a05:651c:1053:: with SMTP id x19mr11796456ljm.39.1573832679135;
        Fri, 15 Nov 2019 07:44:39 -0800 (PST)
Received: from seldlx21914.corpusers.net ([37.139.156.40])
        by smtp.gmail.com with ESMTPSA id r22sm4412765lji.71.2019.11.15.07.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 07:44:38 -0800 (PST)
Date:   Fri, 15 Nov 2019 16:44:36 +0100
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     vitaly.wool@konsulko.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>
Subject: [RFC] zswap: use B-tree for search
Message-Id: <20191115164436.da3ae5bd403564174e334bca@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current zswap implementation uses red-black trees to store entries
and to perform lookups. Although this algorithm obviously has complexity
of O(log N) it still takes a while to complete lookup (or, even more for
replacement) of an entry, when the amount of entries is huge (100K+).

B-trees are known to handle such cases more efficiently (i. e. also with
O(log N) complexity but with way lower coefficient) so trying zswap with
B-trees sounded good to me from the start.

The implementation of B-trees that is currently present in Linux kernel
isn't really doing things in the best possible way (i. e. it has
recursion) but I thought it was worth trying anyway. So I modified zswap
(the patch follows below) to use lib/btree and I can see substantial
improvement in my tests when thie patch is applied. I do not post test
results here since we're not quite there yet; I'd like to first hear
opinions on the idea as such and on the way I use B-trees here. Thanks
in advance :)

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>

 mm/zswap.c |  147 +++++++++++++++++++++++++++-------------------------------------
 1 file changed, 64 insertions(+), 83 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 46a322316e52..c2cc07be1322 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -21,7 +21,7 @@
 #include <linux/types.h>
 #include <linux/atomic.h>
 #include <linux/frontswap.h>
-#include <linux/rbtree.h>
+#include <linux/btree.h>
 #include <linux/swap.h>
 #include <linux/crypto.h>
 #include <linux/mempool.h>
@@ -134,7 +134,6 @@ struct zswap_pool {
  * This structure contains the metadata for tracking a single compressed
  * page within zswap.
  *
- * rbnode - links the entry into red-black tree for the appropriate swap type
  * offset - the swap offset for the entry.  Index into the red-black tree.
  * refcount - the number of outstanding reference to the entry. This is needed
  *            to protect against premature freeing of the entry by code
@@ -149,7 +148,6 @@ struct zswap_pool {
  * value - value of the same-value filled pages which have same content
  */
 struct zswap_entry {
-	struct rb_node rbnode;
 	pgoff_t offset;
 	int refcount;
 	unsigned int length;
@@ -166,11 +164,11 @@ struct zswap_header {
 
 /*
  * The tree lock in the zswap_tree struct protects a few things:
- * - the rbtree
+ * - the tree
  * - the refcount field of each entry in the tree
  */
 struct zswap_tree {
-	struct rb_root rbroot;
+	struct btree_head head;
 	spinlock_t lock;
 };
 
@@ -252,7 +250,6 @@ static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp)
 	if (!entry)
 		return NULL;
 	entry->refcount = 1;
-	RB_CLEAR_NODE(&entry->rbnode);
 	return entry;
 }
 
@@ -262,58 +259,18 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 }
 
 /*********************************
-* rbtree functions
+* btree functions
 **********************************/
-static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
-{
-	struct rb_node *node = root->rb_node;
-	struct zswap_entry *entry;
+static struct btree_geo *btree_pgofft_geo;
 
-	while (node) {
-		entry = rb_entry(node, struct zswap_entry, rbnode);
-		if (entry->offset > offset)
-			node = node->rb_left;
-		else if (entry->offset < offset)
-			node = node->rb_right;
-		else
-			return entry;
-	}
-	return NULL;
-}
-
-/*
- * In the case that a entry with the same offset is found, a pointer to
- * the existing entry is stored in dupentry and the function returns -EEXIST
- */
-static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
-			struct zswap_entry **dupentry)
+static struct zswap_entry *zswap_search(struct btree_head *head, pgoff_t offset)
 {
-	struct rb_node **link = &root->rb_node, *parent = NULL;
-	struct zswap_entry *myentry;
-
-	while (*link) {
-		parent = *link;
-		myentry = rb_entry(parent, struct zswap_entry, rbnode);
-		if (myentry->offset > entry->offset)
-			link = &(*link)->rb_left;
-		else if (myentry->offset < entry->offset)
-			link = &(*link)->rb_right;
-		else {
-			*dupentry = myentry;
-			return -EEXIST;
-		}
-	}
-	rb_link_node(&entry->rbnode, parent, link);
-	rb_insert_color(&entry->rbnode, root);
-	return 0;
+	return btree_lookup(head, btree_pgofft_geo, &offset);
 }
 
-static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
+static void zswap_erase(struct btree_head *head, struct zswap_entry *entry)
 {
-	if (!RB_EMPTY_NODE(&entry->rbnode)) {
-		rb_erase(&entry->rbnode, root);
-		RB_CLEAR_NODE(&entry->rbnode);
-	}
+	btree_remove(head, btree_pgofft_geo, &entry->offset);
 }
 
 /*
@@ -342,25 +299,40 @@ static void zswap_entry_get(struct zswap_entry *entry)
 /* caller must hold the tree lock
 * remove from the tree and free it, if nobody reference the entry
 */
-static void zswap_entry_put(struct zswap_tree *tree,
+static void zswap_entry_put(struct btree_head *head,
 			struct zswap_entry *entry)
 {
 	int refcount = --entry->refcount;
 
 	BUG_ON(refcount < 0);
 	if (refcount == 0) {
-		zswap_rb_erase(&tree->rbroot, entry);
+		zswap_erase(head, entry);
 		zswap_free_entry(entry);
 	}
 }
 
+static int zswap_insert_or_replace(struct btree_head *head,
+				struct zswap_entry *entry)
+{
+	struct zswap_entry *old;
+
+	do {
+		old = btree_remove(head, btree_pgofft_geo, &entry->offset);
+		if (old) {
+			zswap_duplicate_entry++;
+			zswap_entry_put(head, old);
+		}
+	} while (old);
+	return btree_insert(head, btree_pgofft_geo, &entry->offset, entry,
+			GFP_ATOMIC);
+}
 /* caller must hold the tree lock */
-static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
+static struct zswap_entry *zswap_entry_find_get(struct btree_head *head,
 				pgoff_t offset)
 {
 	struct zswap_entry *entry;
 
-	entry = zswap_rb_search(root, offset);
+	entry = zswap_search(head, offset);
 	if (entry)
 		zswap_entry_get(entry);
 
@@ -861,7 +833,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 
 	/* find and ref zswap entry */
 	spin_lock(&tree->lock);
-	entry = zswap_entry_find_get(&tree->rbroot, offset);
+	entry = zswap_entry_find_get(&tree->head, offset);
 	if (!entry) {
 		/* entry was invalidated */
 		spin_unlock(&tree->lock);
@@ -910,7 +882,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 
 	spin_lock(&tree->lock);
 	/* drop local reference */
-	zswap_entry_put(tree, entry);
+	zswap_entry_put(&tree->head, entry);
 
 	/*
 	* There are two possible situations for entry here:
@@ -919,8 +891,8 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	*     because invalidate happened during writeback
 	*  search the tree and free the entry if find entry
 	*/
-	if (entry == zswap_rb_search(&tree->rbroot, offset))
-		zswap_entry_put(tree, entry);
+	if (entry == zswap_search(&tree->head, offset))
+		zswap_entry_put(&tree->head, entry);
 	spin_unlock(&tree->lock);
 
 	goto end;
@@ -934,7 +906,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	*/
 fail:
 	spin_lock(&tree->lock);
-	zswap_entry_put(tree, entry);
+	zswap_entry_put(&tree->head, entry);
 	spin_unlock(&tree->lock);
 
 end:
@@ -988,7 +960,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 				struct page *page)
 {
 	struct zswap_tree *tree = zswap_trees[type];
-	struct zswap_entry *entry, *dupentry;
+	struct zswap_entry *entry;
 	struct crypto_comp *tfm;
 	int ret;
 	unsigned int hlen, dlen = PAGE_SIZE;
@@ -1096,16 +1068,12 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 insert_entry:
 	/* map */
 	spin_lock(&tree->lock);
-	do {
-		ret = zswap_rb_insert(&tree->rbroot, entry, &dupentry);
-		if (ret == -EEXIST) {
-			zswap_duplicate_entry++;
-			/* remove from rbtree */
-			zswap_rb_erase(&tree->rbroot, dupentry);
-			zswap_entry_put(tree, dupentry);
-		}
-	} while (ret == -EEXIST);
+	ret = zswap_insert_or_replace(&tree->head, entry);
 	spin_unlock(&tree->lock);
+	if (ret < 0)  {
+		zswap_reject_alloc_fail++;
+		goto put_dstmem;
+	}
 
 	/* update stats */
 	atomic_inc(&zswap_stored_pages);
@@ -1138,7 +1106,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 
 	/* find */
 	spin_lock(&tree->lock);
-	entry = zswap_entry_find_get(&tree->rbroot, offset);
+	entry = zswap_entry_find_get(&tree->head, offset);
 	if (!entry) {
 		/* entry was written back */
 		spin_unlock(&tree->lock);
@@ -1168,7 +1136,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 
 freeentry:
 	spin_lock(&tree->lock);
-	zswap_entry_put(tree, entry);
+	zswap_entry_put(&tree->head, entry);
 	spin_unlock(&tree->lock);
 
 	return 0;
@@ -1182,36 +1150,41 @@ static void zswap_frontswap_invalidate_page(unsigned type, pgoff_t offset)
 
 	/* find */
 	spin_lock(&tree->lock);
-	entry = zswap_rb_search(&tree->rbroot, offset);
+	entry = zswap_search(&tree->head, offset);
 	if (!entry) {
 		/* entry was written back */
 		spin_unlock(&tree->lock);
 		return;
 	}
 
-	/* remove from rbtree */
-	zswap_rb_erase(&tree->rbroot, entry);
+	/* remove from tree */
+	zswap_erase(&tree->head, entry);
 
 	/* drop the initial reference from entry creation */
-	zswap_entry_put(tree, entry);
+	zswap_entry_put(&tree->head, entry);
 
 	spin_unlock(&tree->lock);
 }
 
+void do_free_entry(void *elem, unsigned long opaque, unsigned long *key,
+		size_t index, void *func2)
+{
+	struct zswap_entry *entry = elem;
+	zswap_free_entry(entry);
+}
+
 /* frees all zswap entries for the given swap type */
 static void zswap_frontswap_invalidate_area(unsigned type)
 {
 	struct zswap_tree *tree = zswap_trees[type];
-	struct zswap_entry *entry, *n;
 
 	if (!tree)
 		return;
 
 	/* walk the tree and free everything */
 	spin_lock(&tree->lock);
-	rbtree_postorder_for_each_entry_safe(entry, n, &tree->rbroot, rbnode)
-		zswap_free_entry(entry);
-	tree->rbroot = RB_ROOT;
+	btree_visitor(&tree->head, btree_pgofft_geo, 0, do_free_entry, NULL);
+	btree_destroy(&tree->head);
 	spin_unlock(&tree->lock);
 	kfree(tree);
 	zswap_trees[type] = NULL;
@@ -1226,8 +1199,11 @@ static void zswap_frontswap_init(unsigned type)
 		pr_err("alloc failed, zswap disabled for swap type %d\n", type);
 		return;
 	}
-
-	tree->rbroot = RB_ROOT;
+	if (btree_init(&tree->head) < 0) {
+		pr_err("couldn't init the tree head\n");
+		kfree(tree);
+		return;
+	}
 	spin_lock_init(&tree->lock);
 	zswap_trees[type] = tree;
 }
@@ -1302,6 +1278,11 @@ static int __init init_zswap(void)
 
 	zswap_init_started = true;
 
+	if (sizeof(pgoff_t) == 8)
+		btree_pgofft_geo = &btree_geo64;
+	else
+		btree_pgofft_geo = &btree_geo32;
+
 	if (zswap_entry_cache_create()) {
 		pr_err("entry cache creation failed\n");
 		goto cache_fail;
