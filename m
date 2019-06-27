Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD57C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CBB2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhKnnvq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfF0JpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:45:22 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:41607 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0JpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:45:20 -0400
Received: by mail-qt1-f201.google.com with SMTP id e39so1784305qte.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 02:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dExuKDG1Vocm7R5NxDrIVnD2CUOvxrQiPu2P2B60v+w=;
        b=WhKnnvq+eH098gHUsu9ljm8u7NiCcoAvG7V0jrd0jshrongcUzOBhvAkJkf73ihZp+
         x3Y9xDvb/jKeuWHH2u6ckxKlX4aRRtMTvzfpLyoRC8ULamnLUoUk7RmzaQm3Pu+0A4e1
         TVRXpAoOz57i7ofZgEmZe1BUe1IKn0PYDS/TQatmUcXMJo3QYgnPKgaJ7aOyp490eCa5
         9/4AAlnsh7gejuJ1dXHGMgR2RQoI5pSXa+juORIs7YAWHwbX6FFBA3ntOIo9VgB1s9h6
         itvb8QOBVqFPE3dXzuyMQc+JONF1LgPbfJqic6PD68Aab3oqz8ROjmqia26Mp4ZETGOh
         eYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dExuKDG1Vocm7R5NxDrIVnD2CUOvxrQiPu2P2B60v+w=;
        b=nHDJNpOHtyRvf22CRyanvvPYxBrGVtFQO7UpaNgxywDAwB7gHoHeYi+vnvWV4Vf31q
         JBSDEIq8FYwECdvYT0mwillWl+SJ1vmXdCv6/R3uuKopRa6YDN+KOao+SLR5y1YVm7E0
         TeQxvPNCsrVRmKNmtbEQ7gjKTEpU5K4D5PIWaKbH19lG/S+hj6qDgbvo+5gJHs6HyUFq
         tlk1dOFMmvu9z+lJ687FWswh7qUf3Bm8ihD5x1JcH/MNlhXneHYF1W4rMHpzMO9YAKt2
         qJBIEPrEqXnsSUGGzqpM8ptieTNC6asQ8iS8FcWiIhZgey9DOrWtebOZDbsw2M2obW5a
         owgw==
X-Gm-Message-State: APjAAAVQqGl7uSNKg/7qlaJOOUiMKt706BRqzPrX9/oKLv7Y9hQ39n0T
        /QDU6LoAxj9xmip4sSx7b+s83heQuQ==
X-Google-Smtp-Source: APXvYqyL0gF7qx89YSATj6wfEvyEQdk9uqASJ2qWX9sOEiRzrIlqUKvFG2sTfdKb+6/6XSohTv4Fsmd10g==
X-Received: by 2002:a05:620a:1228:: with SMTP id v8mr1133045qkj.357.1561628719562;
 Thu, 27 Jun 2019 02:45:19 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:44:45 +0200
In-Reply-To: <20190627094445.216365-1-elver@google.com>
Message-Id: <20190627094445.216365-6-elver@google.com>
Mime-Version: 1.0
References: <20190627094445.216365-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 5/5] mm/kasan: Add object validation in ksize()
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ksize() has been unconditionally unpoisoning the whole shadow memory region
associated with an allocation. This can lead to various undetected bugs,
for example, double-kzfree().

Specifically, kzfree() uses ksize() to determine the actual allocation
size, and subsequently zeroes the memory. Since ksize() used to just
unpoison the whole shadow memory region, no invalid free was detected.

This patch addresses this as follows:

1. Add a check in ksize(), and only then unpoison the memory region.

2. Preserve kasan_unpoison_slab() semantics by explicitly unpoisoning
   the shadow memory region using the size obtained from __ksize().

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
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: kasan-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
v4:
* Prefer WARN_ON_ONCE() instead of BUG_ON().
---
 include/linux/kasan.h |  7 +++++--
 mm/slab_common.c      | 22 +++++++++++++++++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b40ea104dd36..cc8a03cc9674 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -76,8 +76,11 @@ void kasan_free_shadow(const struct vm_struct *vm);
 int kasan_add_zero_shadow(void *start, unsigned long size);
 void kasan_remove_zero_shadow(void *start, unsigned long size);
 
-size_t ksize(const void *);
-static inline void kasan_unpoison_slab(const void *ptr) { ksize(ptr); }
+size_t __ksize(const void *);
+static inline void kasan_unpoison_slab(const void *ptr)
+{
+	kasan_unpoison_shadow(ptr, __ksize(ptr));
+}
 size_t kasan_metadata_size(struct kmem_cache *cache);
 
 bool kasan_save_enable_multi_shot(void);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index b7c6a40e436a..a09bb10aa026 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1613,7 +1613,27 @@ EXPORT_SYMBOL(kzfree);
  */
 size_t ksize(const void *objp)
 {
-	size_t size = __ksize(objp);
+	size_t size;
+
+	if (WARN_ON_ONCE(!objp))
+		return 0;
+	/*
+	 * We need to check that the pointed to object is valid, and only then
+	 * unpoison the shadow memory below. We use __kasan_check_read(), to
+	 * generate a more useful report at the time ksize() is called (rather
+	 * than later where behaviour is undefined due to potential
+	 * use-after-free or double-free).
+	 *
+	 * If the pointed to memory is invalid we return 0, to avoid users of
+	 * ksize() writing to and potentially corrupting the memory region.
+	 *
+	 * We want to perform the check before __ksize(), to avoid potentially
+	 * crashing in __ksize() due to accessing invalid metadata.
+	 */
+	if (unlikely(objp == ZERO_SIZE_PTR) || !__kasan_check_read(objp, 1))
+		return 0;
+
+	size = __ksize(objp);
 	/*
 	 * We assume that ksize callers could use whole allocated area,
 	 * so we need to unpoison this area.
-- 
2.22.0.410.gd8fdbe21b5-goog

