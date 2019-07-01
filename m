Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BBFC06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352C021721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 17:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYl2HFPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfGARbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 13:31:17 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:40169 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfGARbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:31:17 -0400
Received: by mail-qt1-f202.google.com with SMTP id z6so13977517qtj.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=57FXAe/wgMHkImrRgxBMfz6F69lw3WXfZi6uoGW6nJo=;
        b=SYl2HFPLHC4vO1l86HKGG+KsnA3p3ugT/bhNQ/ORJtqVZc8wQfosqv55sqkPjCue2f
         7e+f0w+fwy4nCLJm+aSX0gjcTPTFuslk7RJ2coLvl4tv42WYnQaSVWoyeshxUbGcyoO4
         hhD0T0RPIoAUdBGs62mRr5atpiOg14m1NCtJjHk47BVcRRY/tyaLMM7grU8ZMoLNJZwx
         IcepxW70TRfXeKJAeFoYS7BQzeBLr9pEERYN8p01Y1/ZagLCW5l8l5vOesfkxnJcd8au
         EhxOm/nyih6HRvFbzX+vkO9xWXLQ+vCqk6tmWeWdmKAGMqonEnvKkeksITidwsCJDq9F
         iQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=57FXAe/wgMHkImrRgxBMfz6F69lw3WXfZi6uoGW6nJo=;
        b=JNDex+O0k9ILV0t7OSn65rvPnzkrXxnj8DOlWdOymQ45dVMJWB0YO9jnpVXh/EeaXa
         65i1PUw3gbYftnmkfYpq0Bvwni2uY/IHtfv/9iw+J+wxJEy74EdxGOgehprKueGMjlW3
         bw40gBvz8g4Vh/QDZ0j17YqpwwtG/vdi2CpN3YgYd39QW1vS6ZW+FHCMGpqr10+5liPJ
         h87kJayR/yTdYfwwVXY1GnXgVUkn9bDJGEFO2D8T7+QVEHf1vxr/QsMRa/pGdC7xFGro
         i/WVDa8+XVgSkFJYDPhjI51pIZfWtap1F6RGKQuuXYd7gLCERH5M0/Eh9PsHqkDeDHNn
         VM4g==
X-Gm-Message-State: APjAAAX7mFbpJgkMyFrtWRJbdJo/KtiFA+DKhktv/UFQDmGH7i0veNzL
        vYj0CEYfRDOdXLE5zaMhMka0lWlPtno4vj6x
X-Google-Smtp-Source: APXvYqwzE7/6t/styf6kTpX++BJRIsoo5TiY7JuE7+CzfD2WEAoCByH3gCWAWT1gJmZrbbugH9SfdK0LrtM8ZHGQ
X-Received: by 2002:ac8:fbb:: with SMTP id b56mr2584122qtk.324.1562002276640;
 Mon, 01 Jul 2019 10:31:16 -0700 (PDT)
Date:   Mon,  1 Jul 2019 10:30:42 -0700
Message-Id: <20190701173042.221453-1-henryburns@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] mm/z3fold: Fix z3fold_buddy_slots use after free
From:   Henry Burns <henryburns@google.com>
To:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <mawilcox@microsoft.com>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Henry Burns <henryburns@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running z3fold stress testing with address sanitization
showed zhdr->slots was being used after it was freed.

z3fold_free(z3fold_pool, handle)
  free_handle(handle)
    kmem_cache_free(pool->c_handle, zhdr->slots)
  release_z3fold_page_locked_list(kref)
    __release_z3fold_page(zhdr, true)
      zhdr_to_pool(zhdr)
        slots_to_pool(zhdr->slots)  *BOOM*

Instead we split free_handle into two functions, release_handle()
and free_slots(). We use release_handle() in place of free_handle(),
and use free_slots() to call kmem_cache_free() after
__release_z3fold_page() is done.

Fixes: 7c2b8baa61fe  ("mm/z3fold.c: add structure for buddy handles")
Signed-off-by: Henry Burns <henryburns@google.com>
---
 mm/z3fold.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index f7993ff778df..e174d1549734 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -213,31 +213,24 @@ static inline struct z3fold_buddy_slots *handle_to_slots(unsigned long handle)
 	return (struct z3fold_buddy_slots *)(handle & ~(SLOTS_ALIGN - 1));
 }
 
-static inline void free_handle(unsigned long handle)
+static inline void release_handle(unsigned long handle)
 {
-	struct z3fold_buddy_slots *slots;
-	int i;
-	bool is_free;
-
 	if (handle & (1 << PAGE_HEADLESS))
 		return;
 
 	WARN_ON(*(unsigned long *)handle == 0);
 	*(unsigned long *)handle = 0;
-	slots = handle_to_slots(handle);
-	is_free = true;
-	for (i = 0; i <= BUDDY_MASK; i++) {
-		if (slots->slot[i]) {
-			is_free = false;
-			break;
-		}
-	}
+}
 
-	if (is_free) {
-		struct z3fold_pool *pool = slots_to_pool(slots);
+/* At this point all of the slots should be empty */
+static inline void free_slots(struct z3fold_buddy_slots *slots)
+{
+	struct z3fold_pool *pool = slots_to_pool(slots);
+	int i;
 
-		kmem_cache_free(pool->c_handle, slots);
-	}
+	for (i = 0; i <= BUDDY_MASK; i++)
+		VM_BUG_ON(slots->slot[i]);
+	kmem_cache_free(pool->c_handle, slots);
 }
 
 static struct dentry *z3fold_do_mount(struct file_system_type *fs_type,
@@ -431,7 +424,8 @@ static inline struct z3fold_pool *zhdr_to_pool(struct z3fold_header *zhdr)
 static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 {
 	struct page *page = virt_to_page(zhdr);
-	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
+	struct z3fold_buddy_slots *slots = zhdr->slots;
+	struct z3fold_pool *pool = slots_to_pool(slots);
 
 	WARN_ON(!list_empty(&zhdr->buddy));
 	set_bit(PAGE_STALE, &page->private);
@@ -442,6 +436,7 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 	spin_unlock(&pool->lock);
 	if (locked)
 		z3fold_page_unlock(zhdr);
+	free_slots(slots);
 	spin_lock(&pool->stale_lock);
 	list_add(&zhdr->buddy, &pool->stale);
 	queue_work(pool->release_wq, &pool->work);
@@ -1009,7 +1004,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		return;
 	}
 
-	free_handle(handle);
+	release_handle(handle);
 	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list)) {
 		atomic64_dec(&pool->pages_nr);
 		return;
-- 
2.22.0.410.gd8fdbe21b5-goog

