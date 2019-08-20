Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631DAC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247F823A53
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZWhyXfve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfHTIUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:20:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45459 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfHTIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:20:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id x19so5330471eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P0MHbp8icd2EnfbEt8W/+7c9GESmHjcRIzzc5mREfHc=;
        b=ZWhyXfvekp7mtomOPeNw+gKv8PoctORQT4qK6vDORYQfVlFc1kfl2BJJV3TJHQGZCb
         CB0pHjKkl5vhMQORtswylUJcIGVL8oEiKsxpArAFePsSZ3hLP59vaTJNnC9fuUB3KIBn
         d39pjVY9A1d2vscbkTfyqP3a+l5l1lbvao8nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P0MHbp8icd2EnfbEt8W/+7c9GESmHjcRIzzc5mREfHc=;
        b=Z0oyyJnV2DeFeNsJ8yQ/GbU/MU29qTB1g4g9T5hBGnsysa1gshPExBAhstaHNjGIkS
         0owoK/V3c5EVeS5f+R7YplCdwwo8V7hO2sQQ+B9Y1wJbv4jtHCiq+WAHqfqVA+OW1JZ/
         fgqsJcIaAB8P1tgQvuLeRfclic0Ca8qsz0RcoegiualfjTetgy0N8j629S5yYKavoY34
         cbHRsml0tqtiXENDVmCXLWDJpIGDiHS6MOhRKpIKQbK6kQWYYTZarYQQ9uI0zSlQIsfO
         GL6oS8mcu8OHtERKhQjjXUBLNdzuVcLvp60QPJU5sNCAJ1QQ0uHdHtWetMYoeUceQQE8
         jWaA==
X-Gm-Message-State: APjAAAU+9jAKe0oaOypKRuk0BfjGiZcoVq3eauzMJh3ALNJAKic3Qvbx
        p9WQTQYMymSo4+uOwC1KVKvPGg==
X-Google-Smtp-Source: APXvYqwws+tGdhwNI/AHb6Ki0sR410Q/kQWDEPFTsVjfkvGHAhHMdqj8R+dup9TBx0dLBbst5g9vkw==
X-Received: by 2002:a17:906:9b1:: with SMTP id q17mr10487760eje.224.1566289199282;
        Tue, 20 Aug 2019 01:19:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i4sm2467705ejs.39.2019.08.20.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:19:58 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH 3/3] drm/i915: use might_lock_nested in get_pages annotation
Date:   Tue, 20 Aug 2019 10:19:51 +0200
Message-Id: <20190820081951.25053-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820081951.25053-1-daniel.vetter@ffwll.ch>
References: <20190820081951.25053-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So strictly speaking the existing annotation is also ok, because we
have a chain of

obj->mm.lock#I915_MM_GET_PAGES -> fs_reclaim -> obj->mm.lock

(the shrinker cannot get at an object while we're in get_pages, hence
this is safe). But it's confusing, so try to take the right subclass
of the lock.

This does a bit reduce our lockdep based checking, but then it's also
less fragile, in case we ever change the nesting around.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/i915/gem/i915_gem_object.h | 34 +++++++++++-----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index a0b1fa8a3224..b3fd6aac93bc 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -233,10 +233,26 @@ void __i915_gem_object_set_pages(struct drm_i915_gem_object *obj,
 int ____i915_gem_object_get_pages(struct drm_i915_gem_object *obj);
 int __i915_gem_object_get_pages(struct drm_i915_gem_object *obj);
 
+enum i915_mm_subclass { /* lockdep subclass for obj->mm.lock/struct_mutex */
+	I915_MM_NORMAL = 0,
+	/*
+	 * Only used by struct_mutex, when called "recursively" from
+	 * direct-reclaim-esque. Safe because there is only every one
+	 * struct_mutex in the entire system. */
+	I915_MM_SHRINKER = 1,
+	/*
+	 * Used for obj->mm.lock when allocating pages. Safe because the object
+	 * isn't yet on any LRU, and therefore the shrinker can't deadlock on
+	 * it. As soon as the object has pages, obj->mm.lock nests within
+	 * fs_reclaim.
+	 */
+	I915_MM_GET_PAGES = 1,
+};
+
 static inline int __must_check
 i915_gem_object_pin_pages(struct drm_i915_gem_object *obj)
 {
-	might_lock(&obj->mm.lock);
+	might_lock_nested(&obj->mm.lock, I915_MM_GET_PAGES);
 
 	if (atomic_inc_not_zero(&obj->mm.pages_pin_count))
 		return 0;
@@ -279,22 +295,6 @@ i915_gem_object_unpin_pages(struct drm_i915_gem_object *obj)
 	__i915_gem_object_unpin_pages(obj);
 }
 
-enum i915_mm_subclass { /* lockdep subclass for obj->mm.lock/struct_mutex */
-	I915_MM_NORMAL = 0,
-	/*
-	 * Only used by struct_mutex, when called "recursively" from
-	 * direct-reclaim-esque. Safe because there is only every one
-	 * struct_mutex in the entire system. */
-	I915_MM_SHRINKER = 1,
-	/*
-	 * Used for obj->mm.lock when allocating pages. Safe because the object
-	 * isn't yet on any LRU, and therefore the shrinker can't deadlock on
-	 * it. As soon as the object has pages, obj->mm.lock nests within
-	 * fs_reclaim.
-	 */
-	I915_MM_GET_PAGES = 1,
-};
-
 int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj);
 void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
 void i915_gem_object_writeback(struct drm_i915_gem_object *obj);
-- 
2.23.0.rc1

