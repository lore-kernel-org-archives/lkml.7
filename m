Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23BBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D892089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfJODth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:49:37 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45072 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727092AbfJODtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:49:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tf5len0_1571111370;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0Tf5len0_1571111370)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Oct 2019 11:49:33 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     konrad.wilk@oracle.com, sjenning@redhat.com, ddstreet@ieee.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH 2/2] mm, zswap: Support THP
Date:   Tue, 15 Oct 2019 11:49:09 +0800
Message-Id: <1571111349-5041-2-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571111349-5041-1-git-send-email-teawater@gmail.com>
References: <1571111349-5041-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit let zswap treats THP as continuous normal pages
in zswap_frontswap_store.
It will store them to a lot of "zswap_entry".  These "zswap_entry"
will be inserted to "zswap_tree" together.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 mm/zswap.c | 170 +++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 109 insertions(+), 61 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 46a3223..36aa10d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -316,11 +316,7 @@ static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
 	}
 }
 
-/*
- * Carries out the common pattern of freeing and entry's zpool allocation,
- * freeing the entry itself, and decrementing the number of stored pages.
- */
-static void zswap_free_entry(struct zswap_entry *entry)
+static void zswap_free_entry_1(struct zswap_entry *entry)
 {
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
@@ -329,6 +325,15 @@ static void zswap_free_entry(struct zswap_entry *entry)
 		zswap_pool_put(entry->pool);
 	}
 	zswap_entry_cache_free(entry);
+}
+
+/*
+ * Carries out the common pattern of freeing and entry's zpool allocation,
+ * freeing the entry itself, and decrementing the number of stored pages.
+ */
+static void zswap_free_entry(struct zswap_entry *entry)
+{
+	zswap_free_entry_1(entry);
 	atomic_dec(&zswap_stored_pages);
 	zswap_update_total_size();
 }
@@ -980,15 +985,11 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
-/*********************************
-* frontswap hooks
-**********************************/
-/* attempts to compress and store an single page */
-static int zswap_frontswap_store(unsigned type, pgoff_t offset,
-				struct page *page)
+static int zswap_frontswap_store_1(unsigned type, pgoff_t offset,
+				struct page *page,
+				struct zswap_entry **entry_pointer)
 {
-	struct zswap_tree *tree = zswap_trees[type];
-	struct zswap_entry *entry, *dupentry;
+	struct zswap_entry *entry;
 	struct crypto_comp *tfm;
 	int ret;
 	unsigned int hlen, dlen = PAGE_SIZE;
@@ -998,36 +999,6 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	struct zswap_header zhdr = { .swpentry = swp_entry(type, offset) };
 	gfp_t gfp;
 
-	/* THP isn't supported */
-	if (PageTransHuge(page)) {
-		ret = -EINVAL;
-		goto reject;
-	}
-
-	if (!zswap_enabled || !tree) {
-		ret = -ENODEV;
-		goto reject;
-	}
-
-	/* reclaim space if needed */
-	if (zswap_is_full()) {
-		zswap_pool_limit_hit++;
-		if (zswap_shrink()) {
-			zswap_reject_reclaim_fail++;
-			ret = -ENOMEM;
-			goto reject;
-		}
-
-		/* A second zswap_is_full() check after
-		 * zswap_shrink() to make sure it's now
-		 * under the max_pool_percent
-		 */
-		if (zswap_is_full()) {
-			ret = -ENOMEM;
-			goto reject;
-		}
-	}
-
 	/* allocate entry */
 	entry = zswap_entry_cache_alloc(GFP_KERNEL);
 	if (!entry) {
@@ -1035,6 +1006,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		ret = -ENOMEM;
 		goto reject;
 	}
+	*entry_pointer = entry;
 
 	if (zswap_same_filled_pages_enabled) {
 		src = kmap_atomic(page);
@@ -1044,7 +1016,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 			entry->length = 0;
 			entry->value = value;
 			atomic_inc(&zswap_same_filled_pages);
-			goto insert_entry;
+			goto out;
 		}
 		kunmap_atomic(src);
 	}
@@ -1093,31 +1065,105 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	entry->handle = handle;
 	entry->length = dlen;
 
-insert_entry:
+out:
+	return 0;
+
+put_dstmem:
+	put_cpu_var(zswap_dstmem);
+	zswap_pool_put(entry->pool);
+freepage:
+	zswap_entry_cache_free(entry);
+reject:
+	return ret;
+}
+
+/*********************************
+* frontswap hooks
+**********************************/
+/* attempts to compress and store an single page */
+static int zswap_frontswap_store(unsigned type, pgoff_t offset,
+				struct page *page)
+{
+	struct zswap_tree *tree = zswap_trees[type];
+	struct zswap_entry **entries = NULL, *dupentry;
+	struct zswap_entry *single_entry[1];
+	int ret;
+	int i, nr;
+
+	if (!zswap_enabled || !tree) {
+		ret = -ENODEV;
+		goto reject;
+	}
+
+	/* reclaim space if needed */
+	if (zswap_is_full()) {
+		zswap_pool_limit_hit++;
+		if (zswap_shrink()) {
+			zswap_reject_reclaim_fail++;
+			ret = -ENOMEM;
+			goto reject;
+		}
+
+		/* A second zswap_is_full() check after
+		 * zswap_shrink() to make sure it's now
+		 * under the max_pool_percent
+		 */
+		if (zswap_is_full()) {
+			ret = -ENOMEM;
+			goto reject;
+		}
+	}
+
+	nr = hpage_nr_pages(page);
+
+	if (unlikely(nr > 1)) {
+		entries = kvmalloc(sizeof(struct zswap_entry *) * nr,
+				GFP_KERNEL);
+		if (!entries) {
+			ret = -ENOMEM;
+			goto reject;
+		}
+	} else
+		entries = single_entry;
+
+	for (i = 0; i < nr; i++) {
+		ret = zswap_frontswap_store_1(type, offset + i, page + i,
+					&entries[i]);
+		if (ret)
+			goto freepage;
+	}
+
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
+	for (i = 0; i < nr; i++) {
+		do {
+			ret = zswap_rb_insert(&tree->rbroot, entries[i],
+					&dupentry);
+			if (ret == -EEXIST) {
+				zswap_duplicate_entry++;
+				/* remove from rbtree */
+				zswap_rb_erase(&tree->rbroot, dupentry);
+				zswap_entry_put(tree, dupentry);
+			}
+		} while (ret == -EEXIST);
+	}
 	spin_unlock(&tree->lock);
 
 	/* update stats */
-	atomic_inc(&zswap_stored_pages);
+	atomic_add(nr, &zswap_stored_pages);
 	zswap_update_total_size();
 
-	return 0;
-
-put_dstmem:
-	put_cpu_var(zswap_dstmem);
-	zswap_pool_put(entry->pool);
+	ret = 0;
 freepage:
-	zswap_entry_cache_free(entry);
+	if (unlikely(nr > 1)) {
+		if (ret) {
+			int j;
+
+			for (j = 0; j < i; j++)
+				zswap_free_entry_1(entries[j]);
+		}
+		kvfree(entries);
+	}
 reject:
 	return ret;
 }
@@ -1136,6 +1182,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	unsigned int dlen;
 	int ret;
 
+	BUG_ON(PageTransHuge(page));
+
 	/* find */
 	spin_lock(&tree->lock);
 	entry = zswap_entry_find_get(&tree->rbroot, offset);
-- 
2.7.4

