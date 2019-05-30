Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8F3C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC7F25D50
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QxUyMepP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbfE3Eu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:50:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47058 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfE3EuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:50:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so3092787pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 21:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ro0eZo0iqlYxkBqPnVWAwPHhTLd6Yb2usUf2C4gK6mE=;
        b=QxUyMepPmuFlBPWIdyq+hDUvIJEUHMM8hSMqXOaU5d+qk1TA2YsVTjyuk0Nq3LDdod
         JjwD0ZGD8M+YE/Y6QaRqXLENweWTFQfFepMCtYGmzHPzsVLJQ2RWsJ21V8QjF5O2Mqix
         c+CfgfD3OKGNqSm1uCtBNhVSJThW/A2BIVKxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ro0eZo0iqlYxkBqPnVWAwPHhTLd6Yb2usUf2C4gK6mE=;
        b=gfabUmLXDNXWR3qr2DYF+OOAcJ9KVE6jLXxf5L5BjhFs359aiLCwvtCA5+G5SpbTl5
         umHA0wXxIfRnM/cwlnF7M3ho80s9RlFAWuaX05rlRhuyQPGhl4/SPKTtIDl3H5wM335K
         lVXPdNAPAiE+7+1NJmRaE2zAPeznqHNvc0cLLtsd5DOfsj0v90AcKbxEzPdBdqv+yjco
         CteHRpIBP2VElPc1VaRj/ZV2MTCYMMDdiRDe1IWN6VRQ948sTUx3kQCb+pmA4oXicu5c
         e8ERJruxhqBNXKrLgFyMIGfV3WM/EvaRt4MaShJhTJtT9yNFFeBZygXlpXmaSLUz+ryM
         Curw==
X-Gm-Message-State: APjAAAVdvEZghpW5AHZOmh8t2OOpN4ohPVlNO9Wkdz9x+UmWNhYWFyyO
        l8Sx5a8HUDHeuvPY6tYuZknbew==
X-Google-Smtp-Source: APXvYqx6yhz7sBMRnROF3lrt43atOsL36IzpXQDT7eajC7OfATKiWWEfU232CwKhSVYrVQa1CAtd9Q==
X-Received: by 2002:a63:3141:: with SMTP id x62mr2022883pgx.282.1559191825131;
        Wed, 29 May 2019 21:50:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l141sm1451014pfd.24.2019.05.29.21.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 21:50:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Popov <alex.popov@linux.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/3] mm/slab: Sanity-check page type when looking up cache
Date:   Wed, 29 May 2019 21:50:16 -0700
Message-Id: <20190530045017.15252-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530045017.15252-1-keescook@chromium.org>
References: <20190530045017.15252-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids any possible type confusion when looking up an object. For
example, if a non-slab were to be passed to kfree(), the invalid
slab_cache pointer (i.e. overlapped with some other value from the struct
page union) would be used for subsequent slab manipulations that could
lead to further memory corruption.

Since the page is already in cache, adding the PageSlab() check will
have nearly zero cost, so add a check and WARN() to virt_to_cache().
Additionally replaces an open-coded virt_to_cache(). To support the failure
mode this also updates all callers of virt_to_cache() and cache_from_obj()
to handle a NULL cache pointer return value (though note that several
already handle this case gracefully).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/slab.c | 14 +++++++-------
 mm/slab.h | 17 +++++++++++++----
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index f7117ad9b3a3..9e3eee5568b6 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -371,12 +371,6 @@ static void **dbg_userword(struct kmem_cache *cachep, void *objp)
 static int slab_max_order = SLAB_MAX_ORDER_LO;
 static bool slab_max_order_set __initdata;
 
-static inline struct kmem_cache *virt_to_cache(const void *obj)
-{
-	struct page *page = virt_to_head_page(obj);
-	return page->slab_cache;
-}
-
 static inline void *index_to_obj(struct kmem_cache *cache, struct page *page,
 				 unsigned int idx)
 {
@@ -3715,6 +3709,8 @@ void kmem_cache_free_bulk(struct kmem_cache *orig_s, size_t size, void **p)
 			s = virt_to_cache(objp);
 		else
 			s = cache_from_obj(orig_s, objp);
+		if (!s)
+			continue;
 
 		debug_check_no_locks_freed(objp, s->object_size);
 		if (!(s->flags & SLAB_DEBUG_OBJECTS))
@@ -3749,6 +3745,8 @@ void kfree(const void *objp)
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = virt_to_cache(objp);
+	if (!c)
+		return;
 	debug_check_no_locks_freed(objp, c->object_size);
 
 	debug_check_no_obj_freed(objp, c->object_size);
@@ -4219,13 +4217,15 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
  */
 size_t ksize(const void *objp)
 {
+	struct kmem_cache *c;
 	size_t size;
 
 	BUG_ON(!objp);
 	if (unlikely(objp == ZERO_SIZE_PTR))
 		return 0;
 
-	size = virt_to_cache(objp)->object_size;
+	c = virt_to_cache(objp);
+	size = c ? c->object_size : 0;
 	/* We assume that ksize callers could use the whole allocated area,
 	 * so we need to unpoison this area.
 	 */
diff --git a/mm/slab.h b/mm/slab.h
index 4dafae2c8620..739099af6cbb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -350,10 +350,20 @@ static inline void memcg_link_cache(struct kmem_cache *s)
 
 #endif /* CONFIG_MEMCG_KMEM */
 
+static inline struct kmem_cache *virt_to_cache(const void *obj)
+{
+	struct page *page;
+
+	page = virt_to_head_page(obj);
+	if (WARN_ONCE(!PageSlab(page), "%s: Object is not a Slab page!\n",
+					__func__))
+		return NULL;
+	return page->slab_cache;
+}
+
 static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 {
 	struct kmem_cache *cachep;
-	struct page *page;
 
 	/*
 	 * When kmemcg is not being used, both assignments should return the
@@ -367,9 +377,8 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 	    !unlikely(s->flags & SLAB_CONSISTENCY_CHECKS))
 		return s;
 
-	page = virt_to_head_page(x);
-	cachep = page->slab_cache;
-	WARN_ONCE(!slab_equal_or_root(cachep, s),
+	cachep = virt_to_cache(x);
+	WARN_ONCE(cachep && !slab_equal_or_root(cachep, s),
 		  "%s: Wrong slab cache. %s but object is from %s\n",
 		  __func__, s->name, cachep->name);
 	return cachep;
-- 
2.17.1

