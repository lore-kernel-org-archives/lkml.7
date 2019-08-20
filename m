Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C19C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AE123B19
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PdH3S17C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfHTIUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:20:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46727 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbfHTIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:19:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id z51so5334204edz.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srDEnH/8i+zuixLxaU9X48M+24Hlu1GtsG3lr0c5CQI=;
        b=PdH3S17CyTBIXJEbAG9EB5jwyIHQ3XXH0fTulxAw6a/Z+aaM/vDXJHD9NDTLpNHTQz
         dejmlFEatO5BVBUFv+AEPpsqUfOYjB70iQ0kQNKfsbEjiE8tDKm9Dtj08YCXCqAq+txp
         idWNoYL1FEefVxB9Xx4UKO/Zs02XV2KotjoNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=srDEnH/8i+zuixLxaU9X48M+24Hlu1GtsG3lr0c5CQI=;
        b=bubllvhDXQMpGkZ7So36aPwA/3U/p5yAmqHCG7PpzBk9GxPjhCE0scgAfawVHw3YEb
         ed7OmvqwB3aeWclXyNgvZAkC3cEOgYruZdtRbss/jkHwAIYWu2dkBDEQABDnKQQCRVYp
         rcJKb1JGuMmuSUGDa2HEThoDh2BnKLDUGM5WqAEY6McGCceHM6hwizxJezkfQle9Ge5/
         +fGkXMa74a2bTp9dOk+nc1HxVG4ed9LAP4D3rUhOgrPz9Uv4UAs4HiH3leKH8zXdd3Jq
         rvGV5drb8cWRlO7I+bb/PcE7B56HC5gI4Tb1+G4Ifs5DofnqyU7ONIQ78Due8SpGC+pM
         udUA==
X-Gm-Message-State: APjAAAVRJGzy1NpGNDlvbuLOFyImUkg6RLbqxR7tLQc9z/ZjNM+Ylo2l
        Ix2/NDoz2h1+o9DrkBKBZravJA==
X-Google-Smtp-Source: APXvYqzSLhtbWy6AB43Od/tIcvENCeCQJsQe7k/GdZYs8JTL/xbofJsGf9m1napRk025g0gJo4SNHA==
X-Received: by 2002:a50:c35b:: with SMTP id q27mr29520070edb.98.1566289196964;
        Tue, 20 Aug 2019 01:19:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i4sm2467705ejs.39.2019.08.20.01.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:19:56 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Tang, CQ" <cq.tang@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 1/3] drm/i915: Switch obj->mm.lock lockdep annotations on its head
Date:   Tue, 20 Aug 2019 10:19:49 +0200
Message-Id: <20190820081951.25053-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trouble with having a plain nesting flag for locks which do not
naturally nest (unlike block devices and their partitions, which is
the original motivation for nesting levels) is that lockdep will
never spot a true deadlock if you screw up.

This patch is an attempt at trying better, by highlighting a bit more
the actual nature of the nesting that's going on. Essentially we have
two kinds of objects:

- objects without pages allocated, which cannot be on any lru and are
  hence inaccessible to the shrinker.

- objects which have pages allocated, which are on an lru, and which
  the shrinker can decide to throw out.

For the former type of object, memory allcoations while holding
obj->mm.lock are permissible. For the latter they are not. And
get/put_pages transitions between the two types of objects.

This is still not entirely fool-proof since the rules might chance.
But as long as we run such a code ever at runtime lockdep should be
able to observe the inconsistency and complain (like with any other
lockdep class that we've split up in multiple classes). But there are
a few clear benefits:

- We can drop the nesting flag parameter from
  __i915_gem_object_put_pages, because that function by definition is
  never going allocate memory, and calling it on an object which
  doesn't have its pages allocated would be a bug.

- We strictly catch more bugs, since there's not only one place in the
  entire tree which is annotated with the special class. All the
  other places that had explicit lockdep nesting annotations we're now
  going to leave up to lockdep again.

- Specifically this catches stuff like calling get_pages from
  put_pages (which isn't really a good idea, if we can call put_pages
  so could the shrinker). I've seen patches do exactly that.

Of course I fully expect CI will show me for the fool I am with this
one here :-)

v2: There can only be one (lockdep only has a cache for the first
subclass, not for deeper ones, and we don't want to make these locks
even slower). Still separate enums for better documentation.

Real fix: don forget about phys objs and pin_map(), and fix the
shrinker to have the right annotations ... silly me.

v3: Forgot usertptr too ...

v4: Improve comment for pages_pin_count, drop the IMPORTANT comment
and instead prime lockdep (Chris).

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: "Tang, CQ" <cq.tang@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.c       | 13 ++++++++++++-
 drivers/gpu/drm/i915/gem/i915_gem_object.h       | 16 +++++++++++++---
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h |  6 +++++-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c        |  9 ++++-----
 drivers/gpu/drm/i915/gem/i915_gem_phys.c         |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c     |  5 ++---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c      |  4 ++--
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c  | 12 ++++++------
 8 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index d7855dc5a5c5..c1894aa06528 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -22,6 +22,8 @@
  *
  */
 
+#include <linux/sched/mm.h>
+
 #include "display/intel_frontbuffer.h"
 #include "gt/intel_gt.h"
 #include "i915_drv.h"
@@ -51,6 +53,15 @@ void i915_gem_object_init(struct drm_i915_gem_object *obj,
 {
 	mutex_init(&obj->mm.lock);
 
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		mutex_lock_nested(&obj->mm.lock, I915_MM_GET_PAGES);
+		fs_reclaim_acquire(GFP_KERNEL);
+		might_lock(&obj->mm.lock);
+		fs_reclaim_release(GFP_KERNEL);
+		mutex_unlock(&obj->mm.lock);
+	}
+
+
 	spin_lock_init(&obj->vma.lock);
 	INIT_LIST_HEAD(&obj->vma.list);
 
@@ -176,7 +187,7 @@ static void __i915_gem_free_objects(struct drm_i915_private *i915,
 		GEM_BUG_ON(!list_empty(&obj->lut_list));
 
 		atomic_set(&obj->mm.pages_pin_count, 0);
-		__i915_gem_object_put_pages(obj, I915_MM_NORMAL);
+		__i915_gem_object_put_pages(obj);
 		GEM_BUG_ON(i915_gem_object_has_pages(obj));
 		bitmap_free(obj->bit_17);
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index 5efb9936e05b..a0b1fa8a3224 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -281,11 +281,21 @@ i915_gem_object_unpin_pages(struct drm_i915_gem_object *obj)
 
 enum i915_mm_subclass { /* lockdep subclass for obj->mm.lock/struct_mutex */
 	I915_MM_NORMAL = 0,
-	I915_MM_SHRINKER /* called "recursively" from direct-reclaim-esque */
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
 };
 
-int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj,
-				enum i915_mm_subclass subclass);
+int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj);
 void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
 void i915_gem_object_writeback(struct drm_i915_gem_object *obj);
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
index ede0eb4218a8..7b7cf711a21a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
@@ -156,7 +156,11 @@ struct drm_i915_gem_object {
 	unsigned int pin_global;
 
 	struct {
-		struct mutex lock; /* protects the pages and their use */
+		/*
+		 * Protects the pages and their use. Do not use directly, but
+		 * instead go through the pin/unpin interfaces.
+		 */
+		struct mutex lock;
 		atomic_t pages_pin_count;
 
 		struct sg_table *pages;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 18f0ce0135c1..202526e8910f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -101,7 +101,7 @@ int __i915_gem_object_get_pages(struct drm_i915_gem_object *obj)
 {
 	int err;
 
-	err = mutex_lock_interruptible(&obj->mm.lock);
+	err = mutex_lock_interruptible_nested(&obj->mm.lock, I915_MM_GET_PAGES);
 	if (err)
 		return err;
 
@@ -179,8 +179,7 @@ __i915_gem_object_unset_pages(struct drm_i915_gem_object *obj)
 	return pages;
 }
 
-int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj,
-				enum i915_mm_subclass subclass)
+int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj)
 {
 	struct sg_table *pages;
 	int err;
@@ -191,7 +190,7 @@ int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj,
 	GEM_BUG_ON(atomic_read(&obj->bind_count));
 
 	/* May be called by shrinker from within get_pages() (on another bo) */
-	mutex_lock_nested(&obj->mm.lock, subclass);
+	mutex_lock(&obj->mm.lock);
 	if (unlikely(atomic_read(&obj->mm.pages_pin_count))) {
 		err = -EBUSY;
 		goto unlock;
@@ -285,7 +284,7 @@ void *i915_gem_object_pin_map(struct drm_i915_gem_object *obj,
 	if (unlikely(!i915_gem_object_has_struct_page(obj)))
 		return ERR_PTR(-ENXIO);
 
-	err = mutex_lock_interruptible(&obj->mm.lock);
+	err = mutex_lock_interruptible_nested(&obj->mm.lock, I915_MM_GET_PAGES);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
index 768356908160..2aea8960f0f1 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_phys.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
@@ -163,7 +163,7 @@ int i915_gem_object_attach_phys(struct drm_i915_gem_object *obj, int align)
 	if (err)
 		return err;
 
-	mutex_lock(&obj->mm.lock);
+	mutex_lock_nested(&obj->mm.lock, I915_MM_GET_PAGES);
 
 	if (obj->mm.madv != I915_MADV_WILLNEED) {
 		err = -EFAULT;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
index edd21d14e64f..0b0d6e27b996 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
@@ -98,7 +98,7 @@ static bool unsafe_drop_pages(struct drm_i915_gem_object *obj,
 		flags = I915_GEM_OBJECT_UNBIND_ACTIVE;
 
 	if (i915_gem_object_unbind(obj, flags) == 0)
-		__i915_gem_object_put_pages(obj, I915_MM_SHRINKER);
+		__i915_gem_object_put_pages(obj);
 
 	return !i915_gem_object_has_pages(obj);
 }
@@ -254,8 +254,7 @@ i915_gem_shrink(struct drm_i915_private *i915,
 
 			if (unsafe_drop_pages(obj, shrink)) {
 				/* May arrive from get_pages on another bo */
-				mutex_lock_nested(&obj->mm.lock,
-						  I915_MM_SHRINKER);
+				mutex_lock(&obj->mm.lock);
 				if (!i915_gem_object_has_pages(obj)) {
 					try_to_writeback(obj, shrink);
 					count += obj->base.size >> PAGE_SHIFT;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 70dc506a5426..f3b3bc7c32cb 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -158,7 +158,7 @@ userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
 		ret = i915_gem_object_unbind(obj,
 					     I915_GEM_OBJECT_UNBIND_ACTIVE);
 		if (ret == 0)
-			ret = __i915_gem_object_put_pages(obj, I915_MM_SHRINKER);
+			ret = __i915_gem_object_put_pages(obj);
 		i915_gem_object_put(obj);
 		if (ret)
 			goto unlock;
@@ -514,7 +514,7 @@ __i915_gem_userptr_get_pages_worker(struct work_struct *_work)
 		}
 	}
 
-	mutex_lock(&obj->mm.lock);
+	mutex_lock_nested(&obj->mm.lock, I915_MM_GET_PAGES);
 	if (obj->userptr.work == &work->work) {
 		struct sg_table *pages = ERR_PTR(ret);
 
diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index 8de83c6d81f5..81af85971856 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -562,7 +562,7 @@ static int igt_mock_ppgtt_misaligned_dma(void *arg)
 		i915_vma_close(vma);
 
 		i915_gem_object_unpin_pages(obj);
-		__i915_gem_object_put_pages(obj, I915_MM_NORMAL);
+		__i915_gem_object_put_pages(obj);
 		i915_gem_object_put(obj);
 	}
 
@@ -590,7 +590,7 @@ static void close_object_list(struct list_head *objects,
 
 		list_del(&obj->st_link);
 		i915_gem_object_unpin_pages(obj);
-		__i915_gem_object_put_pages(obj, I915_MM_NORMAL);
+		__i915_gem_object_put_pages(obj);
 		i915_gem_object_put(obj);
 	}
 }
@@ -860,7 +860,7 @@ static int igt_mock_ppgtt_64K(void *arg)
 			i915_vma_close(vma);
 
 			i915_gem_object_unpin_pages(obj);
-			__i915_gem_object_put_pages(obj, I915_MM_NORMAL);
+			__i915_gem_object_put_pages(obj);
 			i915_gem_object_put(obj);
 		}
 	}
@@ -1164,7 +1164,7 @@ static int igt_ppgtt_exhaust_huge(void *arg)
 			}
 
 			i915_gem_object_unpin_pages(obj);
-			__i915_gem_object_put_pages(obj, I915_MM_NORMAL);
+			__i915_gem_object_put_pages(obj);
 			i915_gem_object_put(obj);
 		}
 	}
@@ -1226,7 +1226,7 @@ static int igt_ppgtt_internal_huge(void *arg)
 		}
 
 		i915_gem_object_unpin_pages(obj);
-		__i915_gem_object_put_pages(obj, I915_MM_NORMAL);
+		__i915_gem_object_put_pages(obj);
 		i915_gem_object_put(obj);
 	}
 
@@ -1295,7 +1295,7 @@ static int igt_ppgtt_gemfs_huge(void *arg)
 		}
 
 		i915_gem_object_unpin_pages(obj);
-		__i915_gem_object_put_pages(obj, I915_MM_NORMAL);
+		__i915_gem_object_put_pages(obj);
 		i915_gem_object_put(obj);
 	}
 
-- 
2.23.0.rc1

