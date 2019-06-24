Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB2CC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6682146E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vosRPmYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfFXLGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:06:00 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:46382 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfFXLGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:06:00 -0400
Received: by mail-qk1-f201.google.com with SMTP id 18so15760910qkl.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 04:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PHd5TU1tSErJuln8CLwgi6IjxpHufjIY0VZFaXkHGNk=;
        b=vosRPmYOoKEVRZZMh5n78maBJpGu9JU/xpF6TD3FlIpepWnIPkIDSseYdS/kli9c23
         En9IpdwouPvux+1HD/GtnHn7igk+wht09bMoFi38Fhk1GIyCePRSO09mvSYfIymVD0px
         lHIi558uyfcZIkRjsy4NiWcehmrN9cfFF1+IP/yEA4gbnw4S8rAYxTN2dufQdWS4+P8l
         uCCQIqe0HQa1cCK9pnMMWmOlhAZ7uQcMBXA7GWVQUITkc71GUeJprSIEW4sS7Z2dnDk3
         Qw7KiZFFuR9bquQZBhJMbB7FrA9VsuY8rrNpWoYcqhryopYvpFLFmA9a+2OU9yAPvTUq
         4Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PHd5TU1tSErJuln8CLwgi6IjxpHufjIY0VZFaXkHGNk=;
        b=rJCQhqEX2fN1UmmTDE+CErGUqOQNDVPAZIszd6NvsDTbIAW+RUx0hKx1aewAH8kymK
         XHqh1aaG0/YWjibluV3hPRaPTvNmnsO9IOThgxY6aMTlnRYuwKf9hgP0JF58a2bj0qu0
         OUrGGD/vwQsjiHl3oKDtKGEQ+R25C7O6XBN/fingIKyWGwMjCHpl2dI13QXe3AWMJ+tG
         36KyxJF5CnGSrqpazJ6V+MFjta/L4gcE3dSZu1T8gzlW8BpS8MHgoKmkFfkPUk9sb05s
         BmMBZSF6p0V44ddcxzbYvfCRCV0rJm152Q5BAxAqNurKEt0PGtt7rsqDqRKMHCzGhSoK
         Dt1w==
X-Gm-Message-State: APjAAAXs5eAUlVl0xtVmlkTADq2wi63T2N1wE9An7Wj33i4n0i6Ntpog
        2fhlvG5e0cQAfeqRyy0pljD+cIRUkg==
X-Google-Smtp-Source: APXvYqzed8xxggaQRg/+ic0BLsdTYDC0epTsxdulJgxPeeCwXFWeEbWlaqpgELg0b+3ya6R95iIR3lAqAQ==
X-Received: by 2002:a37:805:: with SMTP id 5mr15123706qki.385.1561374359272;
 Mon, 24 Jun 2019 04:05:59 -0700 (PDT)
Date:   Mon, 24 Jun 2019 13:05:32 +0200
Message-Id: <20190624110532.41065-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] mm/kasan: Add shadow memory validation in ksize()
From:   Marco Elver <elver@google.com>
To:     aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ksize() has been unconditionally unpoisoning the whole shadow memory region
associated with an allocation. This can lead to various undetected bugs,
for example, double-kzfree().

kzfree() uses ksize() to determine the actual allocation size, and
subsequently zeroes the memory. Since ksize() used to just unpoison the
whole shadow memory region, no invalid free was detected.

This patch addresses this as follows:

1. For each SLAB and SLUB allocators: add a check in ksize() that the
   pointed to object's shadow memory is valid, and only then unpoison
   the memory region.

2. Update kasan_unpoison_slab() to explicitly unpoison the shadow memory
   region using the size obtained from ksize(); it is possible that
   double-unpoison can occur if the shadow was already valid, however,
   this should not be the general case.

Tested:
1. With SLAB allocator: a) normal boot without warnings; b) verified the
   added double-kzfree() is detected.
2. With SLUB allocator: a) normal boot without warnings; b) verified the
   added double-kzfree() is detected.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199359
Signed-off-by: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kasan-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/kasan.h | 20 +++++++++++++++++++-
 lib/test_kasan.c      | 17 +++++++++++++++++
 mm/kasan/common.c     | 15 ++++++++++++---
 mm/slab.c             | 12 ++++++++----
 mm/slub.c             | 11 +++++++----
 5 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b40ea104dd36..9778a68fb5cf 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -63,6 +63,14 @@ void * __must_check kasan_krealloc(const void *object, size_t new_size,
 
 void * __must_check kasan_slab_alloc(struct kmem_cache *s, void *object,
 					gfp_t flags);
+
+/**
+ * kasan_shadow_invalid - Check if shadow memory of object is invalid.
+ * @object: The pointed to object; the object pointer may be tagged.
+ * @return: true if shadow is invalid, false if valid.
+ */
+bool kasan_shadow_invalid(const void *object);
+
 bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
 
 struct kasan_cache {
@@ -77,7 +85,11 @@ int kasan_add_zero_shadow(void *start, unsigned long size);
 void kasan_remove_zero_shadow(void *start, unsigned long size);
 
 size_t ksize(const void *);
-static inline void kasan_unpoison_slab(const void *ptr) { ksize(ptr); }
+static inline void kasan_unpoison_slab(const void *ptr)
+{
+	/* Force unpoison: ksize() only unpoisons if shadow of ptr is valid. */
+	kasan_unpoison_shadow(ptr, ksize(ptr));
+}
 size_t kasan_metadata_size(struct kmem_cache *cache);
 
 bool kasan_save_enable_multi_shot(void);
@@ -133,6 +145,12 @@ static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
 {
 	return object;
 }
+
+static inline bool kasan_shadow_invalid(const void *object)
+{
+	return false;
+}
+
 static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 				   unsigned long ip)
 {
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 7de2702621dc..9b710bfa84da 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -623,6 +623,22 @@ static noinline void __init kasan_strings(void)
 	strnlen(ptr, 1);
 }
 
+static noinline void __init kmalloc_pagealloc_double_kzfree(void)
+{
+	char *ptr;
+	size_t size = 16;
+
+	pr_info("kmalloc pagealloc allocation: double-free (kzfree)\n");
+	ptr = kmalloc(size, GFP_KERNEL);
+	if (!ptr) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	kzfree(ptr);
+	kzfree(ptr);
+}
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -664,6 +680,7 @@ static int __init kmalloc_tests_init(void)
 	kasan_memchr();
 	kasan_memcmp();
 	kasan_strings();
+	kmalloc_pagealloc_double_kzfree();
 
 	kasan_restore_multi_shot(multishot);
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 242fdc01aaa9..357e02e73163 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -413,10 +413,20 @@ static inline bool shadow_invalid(u8 tag, s8 shadow_byte)
 		return tag != (u8)shadow_byte;
 }
 
+bool kasan_shadow_invalid(const void *object)
+{
+	u8 tag = get_tag(object);
+	s8 shadow_byte;
+
+	object = reset_tag(object);
+
+	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
+	return shadow_invalid(tag, shadow_byte);
+}
+
 static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 			      unsigned long ip, bool quarantine)
 {
-	s8 shadow_byte;
 	u8 tag;
 	void *tagged_object;
 	unsigned long rounded_up_size;
@@ -435,8 +445,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
 		return false;
 
-	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
-	if (shadow_invalid(tag, shadow_byte)) {
+	if (kasan_shadow_invalid(tagged_object)) {
 		kasan_report_invalid_free(tagged_object, ip);
 		return true;
 	}
diff --git a/mm/slab.c b/mm/slab.c
index f7117ad9b3a3..3595348c401b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4226,10 +4226,14 @@ size_t ksize(const void *objp)
 		return 0;
 
 	size = virt_to_cache(objp)->object_size;
-	/* We assume that ksize callers could use the whole allocated area,
-	 * so we need to unpoison this area.
-	 */
-	kasan_unpoison_shadow(objp, size);
+
+	if (!kasan_shadow_invalid(objp)) {
+		/*
+		 * We assume that ksize callers could use the whole allocated
+		 * area, so we need to unpoison this area.
+		 */
+		kasan_unpoison_shadow(objp, size);
+	}
 
 	return size;
 }
diff --git a/mm/slub.c b/mm/slub.c
index cd04dbd2b5d0..28231d30358e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3921,10 +3921,13 @@ static size_t __ksize(const void *object)
 size_t ksize(const void *object)
 {
 	size_t size = __ksize(object);
-	/* We assume that ksize callers could use whole allocated area,
-	 * so we need to unpoison this area.
-	 */
-	kasan_unpoison_shadow(object, size);
+	if (!kasan_shadow_invalid(object)) {
+		/*
+		 * We assume that ksize callers could use whole allocated area,
+		 * so we need to unpoison this area.
+		 */
+		kasan_unpoison_shadow(object, size);
+	}
 	return size;
 }
 EXPORT_SYMBOL(ksize);
-- 
2.22.0.410.gd8fdbe21b5-goog

