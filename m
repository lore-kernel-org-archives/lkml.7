Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A86C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060B72133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3K/eMQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfFZMX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:23:28 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:55877 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZMX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:23:27 -0400
Received: by mail-vk1-f201.google.com with SMTP id b85so804030vke.22
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VZ1Nu4TClKywlJIX2MtkIO8a/JcUzUmevX6rOfNTQ4s=;
        b=R3K/eMQJQRtikm1dkDPsjm0vASp36psrk0zphCIGzfzKdobUSKP98DNPLmE3jtTz36
         k53RvT9C4WPzIrAf7ogmvNgTJP4wcCVxNDiuaOfrQkNwQXRiv4gX3Sie3ymaWUgyagMg
         ySSkdoOWxJnKUXRr1FdQqhPlm4/2c1Z726b2YODRRqTL0VIS1JsdL1HX3mFeeiGmiAS/
         ZZ47BRrNaqaviL/MHAk9Lv7rCAqpfm6krL2+Cx/hFK5eUZ+FOWrS8SnUejWx9ZAUtqxA
         /FEM2bkxjkcXiLiaM5BfOOoQj6y2Tm4lRbVetJavA7nYiXeYRy5l25bLE/DfavSm0Web
         3Zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VZ1Nu4TClKywlJIX2MtkIO8a/JcUzUmevX6rOfNTQ4s=;
        b=mVL9+ItiR9D7suGfo2vPRLHvIveOp+bA6e4EiSMEjx4xNoqjnPICQh365yWuAkHHiT
         gRIa223N6pywDCw3mWyIE+ktWUkCpkTqT89wiO+/4Heh5nRiIDC8BhWPGqa5mOeUGr9U
         Xiw3JeWyxYNOX0nHSnNruH4IhH061SzI3iziBCl421Pf/h1sJ/rrmks7mr5ZPGbfuBt8
         WKsfGqvlT1wl5g7L5H0Fen10X80oHehy1wqW68ehPFmQE7Ymci/9+YZJpudPG/hJPxnJ
         vpSkpVzYufTcSLb2avPp+yQ34lhmuH7AX4l43W43aTs/edjfdKYgXo5XBQqB7+z7BUZG
         4FDg==
X-Gm-Message-State: APjAAAU7zwKERLT69JEtvGxkn4IA2uID8ghrLgMMNM/Jy4zAWYjnx97J
        v+LruPipsAzAYHi4wGiSDDc5KsEVgA==
X-Google-Smtp-Source: APXvYqygvrRZ1bPrPIv8ogsJy+NDtCh0yd5w8q0aP5/NTB15AyjhsuzojOb2uSDRovh5ehYjdR+FYjXA0w==
X-Received: by 2002:a1f:a887:: with SMTP id r129mr1048981vke.75.1561551806136;
 Wed, 26 Jun 2019 05:23:26 -0700 (PDT)
Date:   Wed, 26 Jun 2019 14:20:19 +0200
In-Reply-To: <20190626122018.171606-1-elver@google.com>
Message-Id: <20190626122018.171606-5-elver@google.com>
Mime-Version: 1.0
References: <20190626122018.171606-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 4/4] mm/kasan: Add object validation in ksize()
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
Cc: kasan-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/kasan.h |  7 +++++--
 mm/slab_common.c      | 21 ++++++++++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

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
index b7c6a40e436a..ba4a859261d5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1613,7 +1613,26 @@ EXPORT_SYMBOL(kzfree);
  */
 size_t ksize(const void *objp)
 {
-	size_t size = __ksize(objp);
+	size_t size;
+
+	BUG_ON(!objp);
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

