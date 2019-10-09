Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D345ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F7D2190F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="B8+o2znH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfJIOpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:45:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35309 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfJIOpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:45:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so2810357lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHLqnBcAMWl9oxUxGSTJExK0Gib3hZ/+qFSag2SnMEc=;
        b=B8+o2znHRHD/V8dEhy4aDoTZdnArOLYa6TUorSUQmIk595Xl7NOFqChI8+KUigVn7R
         zlFYkGRa6y+deWLCikjjE/igMxZvZNiDVolisBb3GENV9jT9d9LN5v8vAYapFFXs1YKh
         G57ER7/3a8JEZa5VMordbF57zRzgyGSrIwMkscdM6N+iuwV8gRwzXrizlsEtSCB1QmOF
         G/QHCh3KsQ7gAGKE3kTgKEROxy3pHW7gervRWU1djCfyD0mtj5I0gNVkiGDcgltErZKC
         SlzmgRyy9/u2xJO86fivb3NFp7sxv74EzVNylni3AXBuK1WP+1rrmZeIjUS267SuYBfS
         st9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WHLqnBcAMWl9oxUxGSTJExK0Gib3hZ/+qFSag2SnMEc=;
        b=cHiEXqsCtB0hTPwuJxu14Qk8bRMd+mUEXuynNHFYC72tkMRkN7mJRALaAGP43/41j8
         bj94+EQ5D2mBYlk85ObR1CNs4p1lxTQTMJv/Pap5NyyQdMKZRL8IMgxC0O9vNksP5Z18
         tI0sLtLzEbZUUPBRA38R2DR71HTTJ6RcplV3NJYRJ02MLwjOF6mJV1na62ResNUJ7lWe
         msyCabovl7xcrG1GHi3FdFZKFuuDHRhlKuFtyyZ8MyoLhLCDz2LIN0PNl+WzGiNspbSZ
         n1EU9pbSp1fWCMHEUvML8IZskcPXyHjTjWE1pYFySZbJWgSVwhLTBLXTilHOJPRhTlTd
         EwBA==
X-Gm-Message-State: APjAAAWZPrcqK/RVaODrGGKiqeD/DR9eD7ExLw93FMDtpN+MMP8Xr+HJ
        Q3TsybEC0+B9IZhZl6k970rANA==
X-Google-Smtp-Source: APXvYqxTbi648QQFAqz7HczUUQLCcbKuogovtYoFBs5AJSxYzt2EYoP7qLWmnUsU7NeYOv4zy2KZsQ==
X-Received: by 2002:a2e:5dd5:: with SMTP id v82mr2693751lje.54.1570632317793;
        Wed, 09 Oct 2019 07:45:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c4sm514343lfm.4.2019.10.09.07.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 07:45:17 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 3DD02102BFA; Wed,  9 Oct 2019 17:45:17 +0300 (+03)
To:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, hughd@google.com, rientjes@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC, PATCH] mm, thp: Try to bound number of pages on deferred split queue
Date:   Wed,  9 Oct 2019 17:45:09 +0300
Message-Id: <20191009144509.23649-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THPs on deferred split queue got split by shrinker if memory pressure
comes.

In absence of memory pressure, there is no bound on how long the
deferred split queue can be. In extreme cases, deferred queue can grow
to tens of gigabytes.

It is suboptimal: even without memory pressure we can find better way to
use the memory (page cache for instance).

Make deferred_split_huge_page() to trigger a work that would split
pages, if we have more than NR_PAGES_ON_QUEUE_TO_SPLIT on the queue.

The split can fail (i.e. due to memory pinning by GUP), making the
queue grow despite the effort. Rate-limit the work triggering to at most
every NR_CALLS_TO_SPLIT calls of deferred_split_huge_page().

NR_PAGES_ON_QUEUE_TO_SPLIT and NR_CALLS_TO_SPLIT chosen arbitrarily and
will likely require tweaking.

The patch has risk to introduce performance regressions. For system with
plenty of free memory, triggering the split would cost CPU time (~100ms
per GB of THPs to split).

I have doubts about the approach, so:

Not-Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/mmzone.h |   5 ++
 mm/huge_memory.c       | 129 ++++++++++++++++++++++++++++-------------
 mm/memcontrol.c        |   3 +
 mm/page_alloc.c        |   2 +
 4 files changed, 100 insertions(+), 39 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index bda20282746b..f748542745ec 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -684,7 +684,12 @@ struct deferred_split {
 	spinlock_t split_queue_lock;
 	struct list_head split_queue;
 	unsigned long split_queue_len;
+	unsigned int deferred_split_calls;
+	struct work_struct deferred_split_work;
 };
+
+void flush_deferred_split_queue(struct work_struct *work);
+void flush_deferred_split_queue_memcg(struct work_struct *work);
 #endif
 
 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c5cb6dcd6c69..bb7bef856e38 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2842,43 +2842,6 @@ void free_transhuge_page(struct page *page)
 	free_compound_page(page);
 }
 
-void deferred_split_huge_page(struct page *page)
-{
-	struct deferred_split *ds_queue = get_deferred_split_queue(page);
-#ifdef CONFIG_MEMCG
-	struct mem_cgroup *memcg = compound_head(page)->mem_cgroup;
-#endif
-	unsigned long flags;
-
-	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
-
-	/*
-	 * The try_to_unmap() in page reclaim path might reach here too,
-	 * this may cause a race condition to corrupt deferred split queue.
-	 * And, if page reclaim is already handling the same page, it is
-	 * unnecessary to handle it again in shrinker.
-	 *
-	 * Check PageSwapCache to determine if the page is being
-	 * handled by page reclaim since THP swap would add the page into
-	 * swap cache before calling try_to_unmap().
-	 */
-	if (PageSwapCache(page))
-		return;
-
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-	if (list_empty(page_deferred_list(page))) {
-		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
-		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
-		ds_queue->split_queue_len++;
-#ifdef CONFIG_MEMCG
-		if (memcg)
-			memcg_set_shrinker_bit(memcg, page_to_nid(page),
-					       deferred_split_shrinker.id);
-#endif
-	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
-}
-
 static unsigned long deferred_split_count(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
@@ -2895,8 +2858,7 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 static unsigned long deferred_split_scan(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
-	struct pglist_data *pgdata = NODE_DATA(sc->nid);
-	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
+	struct deferred_split *ds_queue = NULL;
 	unsigned long flags;
 	LIST_HEAD(list), *pos, *next;
 	struct page *page;
@@ -2906,6 +2868,10 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	if (sc->memcg)
 		ds_queue = &sc->memcg->deferred_split_queue;
 #endif
+	if (!ds_queue) {
+		struct pglist_data *pgdata = NODE_DATA(sc->nid);
+		ds_queue = &pgdata->deferred_split_queue;
+	}
 
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	/* Take pin on all head pages to avoid freeing them under us */
@@ -2957,6 +2923,91 @@ static struct shrinker deferred_split_shrinker = {
 		 SHRINKER_NONSLAB,
 };
 
+static void __flush_deferred_split_queue(struct pglist_data *pgdata,
+		struct mem_cgroup *memcg)
+{
+	struct shrink_control sc;
+
+	sc.nid = pgdata ? pgdata->node_id : 0;
+	sc.memcg = memcg;
+	sc.nr_to_scan = 0; /* Unlimited */
+
+	deferred_split_scan(NULL, &sc);
+}
+
+void flush_deferred_split_queue(struct work_struct *work)
+{
+	struct deferred_split *ds_queue;
+	struct pglist_data *pgdata;
+
+	ds_queue = container_of(work, struct deferred_split,
+			deferred_split_work);
+	pgdata = container_of(ds_queue, struct pglist_data,
+			deferred_split_queue);
+	__flush_deferred_split_queue(pgdata, NULL);
+}
+
+#ifdef CONFIG_MEMCG
+void flush_deferred_split_queue_memcg(struct work_struct *work)
+{
+	struct deferred_split *ds_queue;
+	struct mem_cgroup *memcg;
+
+	ds_queue = container_of(work, struct deferred_split,
+			deferred_split_work);
+	memcg = container_of(ds_queue, struct mem_cgroup,
+			deferred_split_queue);
+	__flush_deferred_split_queue(NULL, memcg);
+}
+#endif
+
+#define NR_CALLS_TO_SPLIT 32
+#define NR_PAGES_ON_QUEUE_TO_SPLIT 16
+
+void deferred_split_huge_page(struct page *page)
+{
+	struct deferred_split *ds_queue = get_deferred_split_queue(page);
+#ifdef CONFIG_MEMCG
+	struct mem_cgroup *memcg = compound_head(page)->mem_cgroup;
+#endif
+	unsigned long flags;
+
+	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
+
+	/*
+	 * The try_to_unmap() in page reclaim path might reach here too,
+	 * this may cause a race condition to corrupt deferred split queue.
+	 * And, if page reclaim is already handling the same page, it is
+	 * unnecessary to handle it again in shrinker.
+	 *
+	 * Check PageSwapCache to determine if the page is being
+	 * handled by page reclaim since THP swap would add the page into
+	 * swap cache before calling try_to_unmap().
+	 */
+	if (PageSwapCache(page))
+		return;
+
+	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	if (list_empty(page_deferred_list(page))) {
+		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
+		ds_queue->split_queue_len++;
+		ds_queue->deferred_split_calls++;
+#ifdef CONFIG_MEMCG
+		if (memcg)
+			memcg_set_shrinker_bit(memcg, page_to_nid(page),
+					       deferred_split_shrinker.id);
+#endif
+	}
+
+	if (ds_queue->split_queue_len > NR_PAGES_ON_QUEUE_TO_SPLIT &&
+			ds_queue->deferred_split_calls > NR_CALLS_TO_SPLIT) {
+		ds_queue->deferred_split_calls = 0;
+		schedule_work(&ds_queue->deferred_split_work);
+	}
+	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int split_huge_pages_set(void *data, u64 val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c313c49074ca..67305ec75fdc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5085,6 +5085,9 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
 	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
 	memcg->deferred_split_queue.split_queue_len = 0;
+	memcg->deferred_split_queue.deferred_split_calls = 0;
+	INIT_WORK(&memcg->deferred_split_queue.deferred_split_work,
+			flush_deferred_split_queue_memcg);
 #endif
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
 	return memcg;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 15c2050c629b..2f52e538a26f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6674,6 +6674,8 @@ static void pgdat_init_split_queue(struct pglist_data *pgdat)
 	spin_lock_init(&ds_queue->split_queue_lock);
 	INIT_LIST_HEAD(&ds_queue->split_queue);
 	ds_queue->split_queue_len = 0;
+	ds_queue->deferred_split_calls = 0;
+	INIT_WORK(&ds_queue->deferred_split_work, flush_deferred_split_queue);
 }
 #else
 static void pgdat_init_split_queue(struct pglist_data *pgdat) {}
-- 
2.21.0

