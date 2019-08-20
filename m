Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B82C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D21B206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfHTKF1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:05:27 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:53657 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728414AbfHTKF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:05:27 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18199729-1500050 
        for multiple; Tue, 20 Aug 2019 11:05:01 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190820081951.25053-1-daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Tang, CQ" <cq.tang@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190820081951.25053-1-daniel.vetter@ffwll.ch>
Message-ID: <156629549890.1374.6035271324867139754@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 1/3] drm/i915: Switch obj->mm.lock lockdep annotations on its head
Date:   Tue, 20 Aug 2019 11:04:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Vetter (2019-08-20 09:19:49)
> +#include <linux/sched/mm.h>
> +
>  #include "display/intel_frontbuffer.h"
>  #include "gt/intel_gt.h"
>  #include "i915_drv.h"
> @@ -51,6 +53,15 @@ void i915_gem_object_init(struct drm_i915_gem_object *obj,
>  {
>         mutex_init(&obj->mm.lock);
>  
> +       if (IS_ENABLED(CONFIG_LOCKDEP)) {
> +               mutex_lock_nested(&obj->mm.lock, I915_MM_GET_PAGES);
> +               fs_reclaim_acquire(GFP_KERNEL);
> +               might_lock(&obj->mm.lock);
> +               fs_reclaim_release(GFP_KERNEL);
> +               mutex_unlock(&obj->mm.lock);
> +       }
> +
> +

It's good, but nothing is worth angering checkpatch over an extra '\n'.

>         spin_lock_init(&obj->vma.lock);
>         INIT_LIST_HEAD(&obj->vma.list);
>  
> @@ -176,7 +187,7 @@ static void __i915_gem_free_objects(struct drm_i915_private *i915,
>                 GEM_BUG_ON(!list_empty(&obj->lut_list));
>  
>                 atomic_set(&obj->mm.pages_pin_count, 0);
> -               __i915_gem_object_put_pages(obj, I915_MM_NORMAL);
> +               __i915_gem_object_put_pages(obj);
>                 GEM_BUG_ON(i915_gem_object_has_pages(obj));
>                 bitmap_free(obj->bit_17);
>  
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> index 5efb9936e05b..a0b1fa8a3224 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
> @@ -281,11 +281,21 @@ i915_gem_object_unpin_pages(struct drm_i915_gem_object *obj)
>  
>  enum i915_mm_subclass { /* lockdep subclass for obj->mm.lock/struct_mutex */
>         I915_MM_NORMAL = 0,
> -       I915_MM_SHRINKER /* called "recursively" from direct-reclaim-esque */
> +       /*
> +        * Only used by struct_mutex, when called "recursively" from
> +        * direct-reclaim-esque. Safe because there is only every one
> +        * struct_mutex in the entire system. */
> +       I915_MM_SHRINKER = 1,

MM_SHRINKER is no longer part of this subclass, and I intend to remove
shortly.

> +       /*
> +        * Used for obj->mm.lock when allocating pages. Safe because the object
> +        * isn't yet on any LRU, and therefore the shrinker can't deadlock on
> +        * it. As soon as the object has pages, obj->mm.lock nests within
> +        * fs_reclaim.
> +        */
> +       I915_MM_GET_PAGES = 1,

So I was thinking that this can just become SINGLE_DEPTH_NESTING, but
then remembered that I want a proxy object with its own recursion inside
get-pages.

>  };
>  
> -int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj,
> -                               enum i915_mm_subclass subclass);
> +int __i915_gem_object_put_pages(struct drm_i915_gem_object *obj);
>  void i915_gem_object_truncate(struct drm_i915_gem_object *obj);
>  void i915_gem_object_writeback(struct drm_i915_gem_object *obj);
>  
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
> index ede0eb4218a8..7b7cf711a21a 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
> @@ -156,7 +156,11 @@ struct drm_i915_gem_object {
>         unsigned int pin_global;
>  
>         struct {
> -               struct mutex lock; /* protects the pages and their use */
> +               /*
> +                * Protects the pages and their use. Do not use directly, but
> +                * instead go through the pin/unpin interfaces.
> +                */
> +               struct mutex lock;

I am really tempted to rename this pin_mutex.

>                 atomic_t pages_pin_count;

>  
>                 struct sg_table *pages;
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> index 18f0ce0135c1..202526e8910f 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> @@ -101,7 +101,7 @@ int __i915_gem_object_get_pages(struct drm_i915_gem_object *obj)
>  {
>         int err;
>  
> -       err = mutex_lock_interruptible(&obj->mm.lock);
> +       err = mutex_lock_interruptible_nested(&obj->mm.lock, I915_MM_GET_PAGES);
>         if (err)
>                 return err;

> @@ -285,7 +284,7 @@ void *i915_gem_object_pin_map(struct drm_i915_gem_object *obj,
>         if (unlikely(!i915_gem_object_has_struct_page(obj)))
>                 return ERR_PTR(-ENXIO);
>  
> -       err = mutex_lock_interruptible(&obj->mm.lock);
> +       err = mutex_lock_interruptible_nested(&obj->mm.lock, I915_MM_GET_PAGES);
>         if (err)
>                 return ERR_PTR(err);
>  
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> index 768356908160..2aea8960f0f1 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
> @@ -163,7 +163,7 @@ int i915_gem_object_attach_phys(struct drm_i915_gem_object *obj, int align)
>         if (err)
>                 return err;
>  
> -       mutex_lock(&obj->mm.lock);
> +       mutex_lock_nested(&obj->mm.lock, I915_MM_GET_PAGES);

> @@ -514,7 +514,7 @@ __i915_gem_userptr_get_pages_worker(struct work_struct *_work)
>                 }
>         }
>  
> -       mutex_lock(&obj->mm.lock);
> +       mutex_lock_nested(&obj->mm.lock, I915_MM_GET_PAGES);
>         if (obj->userptr.work == &work->work) {
>                 struct sg_table *pages = ERR_PTR(ret);
>  

Ok. That should be all of the allocators.

And the put are selfchecking.

The only caveat I have is that GET_PAGES is simply about the recursive
behaviour of allocating pages (to allocate one set of pages we may have
to free another), and giving it a distinct subclass tricks me, at least,
into considering it to be a distinct lockclass, and so start assuming it
needs to be used in e.g. i915_gem_madvise_ioctl.

That's just a poorly educated user problem (subclass should always be
about recursion levels, if you have distinct lockclasses, make them
distinct!) Hammer, meet screw.

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
