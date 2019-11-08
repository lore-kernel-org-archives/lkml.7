Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B131FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A59206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EHl7l4Lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389237AbfKHTkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:40:10 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:41624 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbfKHTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:40:09 -0500
Received: by mail-qk1-f202.google.com with SMTP id c77so7877791qkb.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 11:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VRnTto8KPjkvow/svAK/HtQEwlurCDazmk8BqxCWuF0=;
        b=EHl7l4Lq9VH5X9AXjHCKaa610RoACsxtY8fTjtJX9iB1ikgAE0nREMQkQiiw14GCYt
         2HGKyGBYX2GtjA6lp3kbDtgb/DJ+UjZYIbXfePN4uXvOe5yRY9XgX+8sbNBeGk4Nk2QQ
         TsjeANtIdrQ07dS4cdVmUy+a6OrPgyPCuNvQsKDKFE9UMWjAqvbAf5LFq1p2LFh5Xedd
         t5r02cabu+ELUsWFmmqVBAJ9lcyXf5wVssRbYlwwxTOWrmOEvfi32l+us16YucMiSFbZ
         hniikBfjH+KFVn/5YuzWIjGE2UMolwoyMXbsRXbzUrEr6Ux724ZsX6kr0PADPOMPPzbV
         miJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VRnTto8KPjkvow/svAK/HtQEwlurCDazmk8BqxCWuF0=;
        b=cBZfQMAIcVwsBLiaPWWA0Rn59QFpFCZaKUO3Sf1Gaczmw/G+Bc6CwUmBkGxWcLE6c4
         kAgRjIFa9OIkSSQPRJ5OpUB9DC+KctIzQ588nN9hHJDMgt5y0krGYC0EbY3VGdbXO6R/
         j0hTPMsF2KfroC6HDH+9QJWj6zExXdg2e6XRSCmtbeQGNxKWMvrBKKUTqhHAFSmxQabz
         0IfEQIkBlHwbR5E7FffiYCjnAUzKGcYUMvqNsCWjaHnmK+JKKM9zSf8Vw965f7WXuA4/
         NiczokynijwI4z9Vp3DDxcP+Nq3Z3bbftb9RGPMQL733mkp9jGWZ0fnSqn6sGJDB8v6O
         WfPA==
X-Gm-Message-State: APjAAAUS0xtLuzOHWU3HatTPbnvOGRmN7vcc+VKiMgs075z0IT/Sa5W6
        tl09zdBJn72FrYX4BBTr3JX197Paomg=
X-Google-Smtp-Source: APXvYqyuspsk6FSAUHmMHKxk9TJyjFNZzJP9dZgoZElU900N3afONr5EmK/09VzVWIvEbGdXQVXryuZGPmA=
X-Received: by 2002:ac8:384f:: with SMTP id r15mr12476756qtb.155.1573242008100;
 Fri, 08 Nov 2019 11:40:08 -0800 (PST)
Date:   Fri,  8 Nov 2019 12:39:58 -0700
In-Reply-To: <20191108193958.205102-1-yuzhao@google.com>
Message-Id: <20191108193958.205102-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20190914000743.182739-1-yuzhao@google.com> <20191108193958.205102-1-yuzhao@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 2/2] mm: avoid slub allocation while holding list_lock
From:   Yu Zhao <yuzhao@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
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

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/slub.c | 88 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 41 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6930c3febad7..7a4ec3c4b4d9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -441,19 +441,38 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
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
@@ -3695,13 +3714,12 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
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
@@ -3709,8 +3727,9 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 			print_tracking(s, p);
 		}
 	}
+	put_map(map);
+
 	slab_unlock(page);
-	bitmap_free(map);
 #endif
 }
 
@@ -4404,19 +4423,19 @@ static int count_total(struct page *page)
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
@@ -4424,18 +4443,13 @@ static void validate_slab(struct kmem_cache *s, struct page *page,
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
@@ -4444,7 +4458,7 @@ static int validate_slab_node(struct kmem_cache *s,
 	spin_lock_irqsave(&n->list_lock, flags);
 
 	list_for_each_entry(page, &n->partial, slab_list) {
-		validate_slab_slab(s, page, map);
+		validate_slab(s, page);
 		count++;
 	}
 	if (count != n->nr_partial)
@@ -4455,7 +4469,7 @@ static int validate_slab_node(struct kmem_cache *s,
 		goto out;
 
 	list_for_each_entry(page, &n->full, slab_list) {
-		validate_slab_slab(s, page, map);
+		validate_slab(s, page);
 		count++;
 	}
 	if (count != atomic_long_read(&n->nr_slabs))
@@ -4472,15 +4486,11 @@ static long validate_slab_cache(struct kmem_cache *s)
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
@@ -4610,18 +4620,17 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
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
@@ -4632,11 +4641,9 @@ static int list_locations(struct kmem_cache *s, char *buf,
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
@@ -4651,9 +4658,9 @@ static int list_locations(struct kmem_cache *s, char *buf,
 
 		spin_lock_irqsave(&n->list_lock, flags);
 		list_for_each_entry(page, &n->partial, slab_list)
-			process_slab(&t, s, page, alloc, map);
+			process_slab(&t, s, page, alloc);
 		list_for_each_entry(page, &n->full, slab_list)
-			process_slab(&t, s, page, alloc, map);
+			process_slab(&t, s, page, alloc);
 		spin_unlock_irqrestore(&n->list_lock, flags);
 	}
 
@@ -4702,7 +4709,6 @@ static int list_locations(struct kmem_cache *s, char *buf,
 	}
 
 	free_loc_track(&t);
-	bitmap_free(map);
 	if (!t.count)
 		len += sprintf(buf, "No data\n");
 	return len;
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

