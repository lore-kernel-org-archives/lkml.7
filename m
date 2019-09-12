Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B5BC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D5B206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g70fJyo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfILCbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:31:24 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:43109 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfILCbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:31:22 -0400
Received: by mail-yw1-f74.google.com with SMTP id a12so19597829ywm.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 19:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ojJ7cMXPrEiz/FyLr9IQHwY3KlzuwRhifydshmfR8I0=;
        b=g70fJyo13BA1SXnh7P2t5j+psqVthBSTait77IbUPz5S/ugHncKb8NdHARQU7D+yHV
         DH1m/luteU9Lh6efd+9JaPISUkB4s7qnKuxFdF/8hjRthqdzrfsBnNxp6FsCQgYw3MrN
         xPnD7ikF/rma/1+/ECGTyoWQz0t2HhS6P59KZW1laQOd2bsxR2pMxo65jKJAfOMLUFPn
         I56eFmQbSHkyt3bAmYbs1IkL+nad1hunZWr43vropeMB7GCFL2PuMSdMLxVGBYqb36uP
         8EKua6gMR4PjylhKKoOGkC7Ey2d98UliNcm27tLZjvUDnPUE6rD7Gnl/B2WO0D03b24/
         MZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ojJ7cMXPrEiz/FyLr9IQHwY3KlzuwRhifydshmfR8I0=;
        b=Rw75BO6hP3aoPGfNsjlP6/YDGaPrnDloyFnzZR5aMJOQK2+aj3/wgfOlRqSoreYGD4
         YALnxZyReo5n/nZaKczIPXnSMOVxip/SXmAvDj7GMexRZtzcJy45YB7olI4bo6B4DVGE
         HtL6r9A2hhY+3EPVNxgn+7uqlWcC5oqc+wopTVuo8NNMmjeUh8qYjG7HcctYpv26qk8J
         VAyxwB5jtKZu8bIprD4pcY8Q7DSAtiARw2S6yojDOxbFxmCED7qkgpNbgDVLKhfqhBSE
         OgpA1SyFnDi7/OhJmN8o97V9KJYd1vZw00FJw58UQ33PR8Vc413YoZA7PJKDMDZNfH8t
         tAVw==
X-Gm-Message-State: APjAAAW82ZICxIR+0v38sz5xP+JyWIh76R0Bn4mQTeY5C45QJQGwVmCP
        92SJesz/PlcTTwG6Unde8AGjojVW0so=
X-Google-Smtp-Source: APXvYqyN8W0NkYp7bgByDnua+Ana3vwfRAMK8BwsDNoKd2gpjIGh08yVuV1JR7vlGcnBDJyX+XKuNtv/kJU=
X-Received: by 2002:a81:4788:: with SMTP id u130mr26980216ywa.287.1568255477484;
 Wed, 11 Sep 2019 19:31:17 -0700 (PDT)
Date:   Wed, 11 Sep 2019 20:31:10 -0600
In-Reply-To: <20190912023111.219636-1-yuzhao@google.com>
Message-Id: <20190912023111.219636-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20190912004401.jdemtajrspetk3fh@box> <20190912023111.219636-1-yuzhao@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v2 3/4] mm: avoid slub allocation while holding list_lock
From:   Yu Zhao <yuzhao@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we are already under list_lock, don't call kmalloc(). Otherwise we
will run into deadlock because kmalloc() also tries to grab the same
lock.

Fixing the problem by using a static bitmap instead.

  WARNING: possible recursive locking detected
  --------------------------------------------
  mount-encrypted/4921 is trying to acquire lock:
  (&(&n->list_lock)->rlock){-.-.}, at: ___slab_alloc+0x104/0x437

  but task is already holding lock:
  (&(&n->list_lock)->rlock){-.-.}, at: __kmem_cache_shutdown+0x81/0x3cb

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&(&n->list_lock)->rlock);
    lock(&(&n->list_lock)->rlock);

   *** DEADLOCK ***

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/slub.c | 88 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 41 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7b7e1ee264ef..baa60dd73942 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -443,19 +443,38 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 }
 
 #ifdef CONFIG_SLUB_DEBUG
+static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
+static DEFINE_SPINLOCK(object_map_lock);
+
 /*
  * Determine a map of object in use on a page.
  *
  * Node listlock must be held to guarantee that the page does
  * not vanish from under us.
  */
-static void get_map(struct kmem_cache *s, struct page *page, unsigned long *map)
+static unsigned long *get_map(struct kmem_cache *s, struct page *page)
 {
 	void *p;
 	void *addr = page_address(page);
 
+	VM_BUG_ON(!irqs_disabled());
+
+	spin_lock(&object_map_lock);
+
+	bitmap_zero(object_map, page->objects);
+
 	for (p = page->freelist; p; p = get_freepointer(s, p))
-		set_bit(slab_index(p, s, addr), map);
+		set_bit(slab_index(p, s, addr), object_map);
+
+	return object_map;
+}
+
+static void put_map(unsigned long *map)
+{
+	VM_BUG_ON(map != object_map);
+	lockdep_assert_held(&object_map_lock);
+
+	spin_unlock(&object_map_lock);
 }
 
 static inline unsigned int size_from_object(struct kmem_cache *s)
@@ -3685,13 +3704,12 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 #ifdef CONFIG_SLUB_DEBUG
 	void *addr = page_address(page);
 	void *p;
-	unsigned long *map = bitmap_zalloc(page->objects, GFP_ATOMIC);
-	if (!map)
-		return;
+	unsigned long *map;
+
 	slab_err(s, page, text, s->name);
 	slab_lock(page);
 
-	get_map(s, page, map);
+	map = get_map(s, page);
 	for_each_object(p, s, addr, page->objects) {
 
 		if (!test_bit(slab_index(p, s, addr), map)) {
@@ -3699,8 +3717,9 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 			print_tracking(s, p);
 		}
 	}
+	put_map(map);
+
 	slab_unlock(page);
-	bitmap_free(map);
 #endif
 }
 
@@ -4386,19 +4405,19 @@ static int count_total(struct page *page)
 #endif
 
 #ifdef CONFIG_SLUB_DEBUG
-static void validate_slab(struct kmem_cache *s, struct page *page,
-						unsigned long *map)
+static void validate_slab(struct kmem_cache *s, struct page *page)
 {
 	void *p;
 	void *addr = page_address(page);
+	unsigned long *map;
+
+	slab_lock(page);
 
 	if (!check_slab(s, page) || !on_freelist(s, page, NULL))
-		return;
+		goto unlock;
 
 	/* Now we know that a valid freelist exists */
-	bitmap_zero(map, page->objects);
-
-	get_map(s, page, map);
+	map = get_map(s, page);
 	for_each_object(p, s, addr, page->objects) {
 		u8 val = test_bit(slab_index(p, s, addr), map) ?
 			 SLUB_RED_INACTIVE : SLUB_RED_ACTIVE;
@@ -4406,18 +4425,13 @@ static void validate_slab(struct kmem_cache *s, struct page *page,
 		if (!check_object(s, page, p, val))
 			break;
 	}
-}
-
-static void validate_slab_slab(struct kmem_cache *s, struct page *page,
-						unsigned long *map)
-{
-	slab_lock(page);
-	validate_slab(s, page, map);
+	put_map(map);
+unlock:
 	slab_unlock(page);
 }
 
 static int validate_slab_node(struct kmem_cache *s,
-		struct kmem_cache_node *n, unsigned long *map)
+		struct kmem_cache_node *n)
 {
 	unsigned long count = 0;
 	struct page *page;
@@ -4426,7 +4440,7 @@ static int validate_slab_node(struct kmem_cache *s,
 	spin_lock_irqsave(&n->list_lock, flags);
 
 	list_for_each_entry(page, &n->partial, slab_list) {
-		validate_slab_slab(s, page, map);
+		validate_slab(s, page);
 		count++;
 	}
 	if (count != n->nr_partial)
@@ -4437,7 +4451,7 @@ static int validate_slab_node(struct kmem_cache *s,
 		goto out;
 
 	list_for_each_entry(page, &n->full, slab_list) {
-		validate_slab_slab(s, page, map);
+		validate_slab(s, page);
 		count++;
 	}
 	if (count != atomic_long_read(&n->nr_slabs))
@@ -4454,15 +4468,11 @@ static long validate_slab_cache(struct kmem_cache *s)
 	int node;
 	unsigned long count = 0;
 	struct kmem_cache_node *n;
-	unsigned long *map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);
-
-	if (!map)
-		return -ENOMEM;
 
 	flush_all(s);
 	for_each_kmem_cache_node(s, node, n)
-		count += validate_slab_node(s, n, map);
-	bitmap_free(map);
+		count += validate_slab_node(s, n);
+
 	return count;
 }
 /*
@@ -4592,18 +4602,17 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 }
 
 static void process_slab(struct loc_track *t, struct kmem_cache *s,
-		struct page *page, enum track_item alloc,
-		unsigned long *map)
+		struct page *page, enum track_item alloc)
 {
 	void *addr = page_address(page);
 	void *p;
+	unsigned long *map;
 
-	bitmap_zero(map, page->objects);
-	get_map(s, page, map);
-
+	map = get_map(s, page);
 	for_each_object(p, s, addr, page->objects)
 		if (!test_bit(slab_index(p, s, addr), map))
 			add_location(t, s, get_track(s, p, alloc));
+	put_map(map);
 }
 
 static int list_locations(struct kmem_cache *s, char *buf,
@@ -4614,11 +4623,9 @@ static int list_locations(struct kmem_cache *s, char *buf,
 	struct loc_track t = { 0, 0, NULL };
 	int node;
 	struct kmem_cache_node *n;
-	unsigned long *map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);
 
-	if (!map || !alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
-				     GFP_KERNEL)) {
-		bitmap_free(map);
+	if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
+			     GFP_KERNEL)) {
 		return sprintf(buf, "Out of memory\n");
 	}
 	/* Push back cpu slabs */
@@ -4633,9 +4640,9 @@ static int list_locations(struct kmem_cache *s, char *buf,
 
 		spin_lock_irqsave(&n->list_lock, flags);
 		list_for_each_entry(page, &n->partial, slab_list)
-			process_slab(&t, s, page, alloc, map);
+			process_slab(&t, s, page, alloc);
 		list_for_each_entry(page, &n->full, slab_list)
-			process_slab(&t, s, page, alloc, map);
+			process_slab(&t, s, page, alloc);
 		spin_unlock_irqrestore(&n->list_lock, flags);
 	}
 
@@ -4684,7 +4691,6 @@ static int list_locations(struct kmem_cache *s, char *buf,
 	}
 
 	free_loc_track(&t);
-	bitmap_free(map);
 	if (!t.count)
 		len += sprintf(buf, "No data\n");
 	return len;
-- 
2.23.0.162.g0b9fbb3734-goog

