Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65700C32756
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389BA214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5q9nk8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407244AbfHIQqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:46:50 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44660 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHIQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:46:49 -0400
Received: by mail-pg1-f201.google.com with SMTP id i134so22829143pgd.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kplyFBVLfjKpkfsvr+g9LWPdkB2amai/k5Uo/Q9auD8=;
        b=h5q9nk8tAZfenmZ9nj7f5DB5oIskrbAkgH1SUH6gc/dL9++Do8uiSM7Hh8La2YdhUr
         c98OMPd7HtrSuUYueAjsNgPsYn0tZRK/5HaykIpTugn6BG5+Vza6P/OsAgMFjkqbX1jb
         tKDl834IzGHcGXrnYRgJRmTFadPUx3REtsWU81DVqjN2jN5FDozEZFjlmyU/hBBXbLJw
         ih9km7R2a/yMONai2mjBAVT5BYQDwqVyE8IBYdzOCEpuj+Mpro6pHR2JAgxY5pDIXht1
         PLk/YyZZ8j9SAXEnGBIuDAzGcW9+kc7EpkUM3SSLFCJSLBJNDHIyfL5sXiJ1vvh7SCy/
         GzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kplyFBVLfjKpkfsvr+g9LWPdkB2amai/k5Uo/Q9auD8=;
        b=iYWL93dylIuQ8UKJg3rM8NXl79SNyQGVlAKkmYTIIfqnUE86EPnldi3b/z0p3t8Wjb
         bOlbAAHqMBQbiQPISMVrouYICB3VdTh6lA4LWd2hzqXJijl/4YnZdMcp74jBGb9M70SS
         c3+0ZEoDhB9RFRzJgR2l/bmQz3vAslexJkDvMBwlKBxWCpOKRdI0YTLkVDTRowo8sCRz
         XzWz0xadgyujACT832IzcV0Ngs2si2jFOPfaI//jx1nwoFLRqbeKKQi1OoH4MXLP1BNi
         kjT6TqcX/8+Ta5lvqeCf29uTJf2k8unPJILJpvN4uqK4lH1xxU5LwLW86+xcsBtOR4yu
         BSCQ==
X-Gm-Message-State: APjAAAXqV1OPwmWTlfUjS6Xvgr1vOX/061XF4x2gF9veY2FM8zV+6G+o
        cfa0eegySjrp7CR+zkamVWTc/qolbObBJ9MN
X-Google-Smtp-Source: APXvYqx/T4pUV4w673pBYfyL91Im0CVeVEr8FGQeETHGkS2gMOK6RWfCsg0q/8JeJa1WpxxrqXiPwnZ99ymqgwMp
X-Received: by 2002:a63:7205:: with SMTP id n5mr18128177pgc.443.1565369207803;
 Fri, 09 Aug 2019 09:46:47 -0700 (PDT)
Date:   Fri,  9 Aug 2019 09:46:43 -0700
Message-Id: <20190809164643.5978-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH] mm/z3fold.c: Fix race between migration and destruction
From:   Henry Burns <henryburns@google.com>
To:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In z3fold_destroy_pool() we call destroy_workqueue(&pool->compact_wq).
However, we have no guarantee that migration isn't happening in the
background at that time.

Migration directly calls queue_work_on(pool->compact_wq), if destruction
wins that race we are using a destroyed workqueue.

Signed-off-by: Henry Burns <henryburns@google.com>
---
 mm/z3fold.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 78447cecfffa..e136d97ce56e 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -40,6 +40,7 @@
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <linux/zpool.h>
 
 /*
@@ -161,8 +162,10 @@ struct z3fold_pool {
 	const struct zpool_ops *zpool_ops;
 	struct workqueue_struct *compact_wq;
 	struct workqueue_struct *release_wq;
+	struct wait_queue_head isolate_wait;
 	struct work_struct work;
 	struct inode *inode;
+	int isolated_pages;
 };
 
 /*
@@ -772,6 +775,7 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
 		goto out_c;
 	spin_lock_init(&pool->lock);
 	spin_lock_init(&pool->stale_lock);
+	init_waitqueue_head(&pool->isolate_wait);
 	pool->unbuddied = __alloc_percpu(sizeof(struct list_head)*NCHUNKS, 2);
 	if (!pool->unbuddied)
 		goto out_pool;
@@ -811,6 +815,15 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
 	return NULL;
 }
 
+static bool pool_isolated_are_drained(struct z3fold_pool *pool)
+{
+	bool ret;
+
+	spin_lock(&pool->lock);
+	ret = pool->isolated_pages == 0;
+	spin_unlock(&pool->lock);
+	return ret;
+}
 /**
  * z3fold_destroy_pool() - destroys an existing z3fold pool
  * @pool:	the z3fold pool to be destroyed
@@ -821,6 +834,13 @@ static void z3fold_destroy_pool(struct z3fold_pool *pool)
 {
 	kmem_cache_destroy(pool->c_handle);
 
+	/*
+	 * We need to ensure that no pages are being migrated while we destroy
+	 * these workqueues, as migration can queue work on either of the
+	 * workqueues.
+	 */
+	wait_event(pool->isolate_wait, !pool_isolated_are_drained(pool));
+
 	/*
 	 * We need to destroy pool->compact_wq before pool->release_wq,
 	 * as any pending work on pool->compact_wq will call
@@ -1317,6 +1337,28 @@ static u64 z3fold_get_pool_size(struct z3fold_pool *pool)
 	return atomic64_read(&pool->pages_nr);
 }
 
+/*
+ * z3fold_dec_isolated() expects to be called while pool->lock is held.
+ */
+static void z3fold_dec_isolated(struct z3fold_pool *pool)
+{
+	assert_spin_locked(&pool->lock);
+	VM_BUG_ON(pool->isolated_pages <= 0);
+	pool->isolated_pages--;
+
+	/*
+	 * If we have no more isolated pages, we have to see if
+	 * z3fold_destroy_pool() is waiting for a signal.
+	 */
+	if (pool->isolated_pages == 0 && waitqueue_active(&pool->isolate_wait))
+		wake_up_all(&pool->isolate_wait);
+}
+
+static void z3fold_inc_isolated(struct z3fold_pool *pool)
+{
+	pool->isolated_pages++;
+}
+
 static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 {
 	struct z3fold_header *zhdr;
@@ -1343,6 +1385,7 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 		spin_lock(&pool->lock);
 		if (!list_empty(&page->lru))
 			list_del(&page->lru);
+		z3fold_inc_isolated(pool);
 		spin_unlock(&pool->lock);
 		z3fold_page_unlock(zhdr);
 		return true;
@@ -1417,6 +1460,10 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
 
 	queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
 
+	spin_lock(&pool->lock);
+	z3fold_dec_isolated(pool);
+	spin_unlock(&pool->lock);
+
 	page_mapcount_reset(page);
 	put_page(page);
 	return 0;
@@ -1436,10 +1483,14 @@ static void z3fold_page_putback(struct page *page)
 	INIT_LIST_HEAD(&page->lru);
 	if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
 		atomic64_dec(&pool->pages_nr);
+		spin_lock(&pool->lock);
+		z3fold_dec_isolated(pool);
+		spin_unlock(&pool->lock);
 		return;
 	}
 	spin_lock(&pool->lock);
 	list_add(&page->lru, &pool->lru);
+	z3fold_dec_isolated(pool);
 	spin_unlock(&pool->lock);
 	z3fold_page_unlock(zhdr);
 }
-- 
2.22.0.770.g0f2c4a37fd-goog

