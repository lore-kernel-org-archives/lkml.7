Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D7C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6922082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9p6sijT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbfDBKWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:22:20 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53650 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfDBKWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:22:19 -0400
Received: by mail-it1-f196.google.com with SMTP id y204so4178922itf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXbNbULYsMg60PvS/gPPJQbFY61xqdPyOU9U0IvY6Ts=;
        b=g9p6sijTwwcRMG+nqmQ8TjoC7qYo0nren0WnjWOxP85RNZ43dkK7nKNqk2g7XQ9yd4
         lmHTa579kYpuGtklV8HACj4HnGQ0kdc0NiaY55Sg81CPQX+nkeX3YZbSWVeDQ8c41Fn4
         SrU9A27H9fiObp60gSgGas5ETDVORADFMpgowx3ggKrOv8APCIGlS4Ze+RQ3bDEVLV2F
         gB9npAXqy0itsS7gU3KM6zqoNj+iybgUo5EGpqHiVu++GXnatv1uV9uIJWVZL6gJwPQJ
         J+8sP4gr82CHnaqvh1kvu8giFHeHSGPKwbbXD7ciX2FqQf3r5YUky/AGiQY8Ycf28K58
         LyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXbNbULYsMg60PvS/gPPJQbFY61xqdPyOU9U0IvY6Ts=;
        b=IUc0NHAbdcu+rEuMheB7C2egXZcsOi6zH3uIKiWtsS9PUjMZNufVX4cFiNCXsvypm1
         YEffO6g/sJANLUbc3uAF1TnSH8xoZZ+m7Fy/3EzkQ8A7HaTgzQwp1DpKp3VTLtWyqvU0
         qPVb97jmXG1GvRGDuvjkMKXfOQE6eBPtzRQByX+vylOmDXw+PSrSC/YpINXtr0yr8mjM
         fVcuGEhFjt+M+0oQHmXek0fNlXQW6mGjHMpW5l7H6iHwmC3xXFRJGpGBT6hQy3kNN1Bl
         jGQZ+5iEnZHIPuXPW9Kc9GBrqjl2nFCmGf3EL/KKLHtXvX/Ct5tIfHHumLdXGXA9708u
         mQNg==
X-Gm-Message-State: APjAAAWXF5erl17u5ZoxCKZQbRQhUWT+IvTjuQ24FV6JE5fhdNsOVrSi
        cdw6eYo/JQqBtNz5gjTfIZKBQYnfVwbsFVpq+ow=
X-Google-Smtp-Source: APXvYqyPyigPW/J53BJt1m91XnedFbkWPkxREX2ItDbpier7Gu9gzDr/AuJ2v9FFTCccc+FlU6kiQc+DPy7N5wbn5jQ=
X-Received: by 2002:a02:924d:: with SMTP id y13mr41269840jag.24.1554200538732;
 Tue, 02 Apr 2019 03:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190401222635.25013-1-eric@anholt.net> <20190401222635.25013-8-eric@anholt.net>
In-Reply-To: <20190401222635.25013-8-eric@anholt.net>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Tue, 2 Apr 2019 18:22:07 +0800
Message-ID: <CAKGbVbvfXmwKcLX=OwKRjDNBg8d9uK8yLQUUG6KsmdMyW5zxGA@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/lima: Use the drm_gem_fence_array_add helpers for
 our deps.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 6:26 AM Eric Anholt <eric@anholt.net> wrote:
>
> I haven't tested this, but it's a pretty direct port of what I did for
> v3d.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/lima/lima_gem.c   | 37 +----------------
>  drivers/gpu/drm/lima/lima_sched.c | 66 ++++++-------------------------
>  drivers/gpu/drm/lima/lima_sched.h |  6 +--
>  3 files changed, 16 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
> index 2d3cf96f6c58..8f80286c80b4 100644
> --- a/drivers/gpu/drm/lima/lima_gem.c
> +++ b/drivers/gpu/drm/lima/lima_gem.c
> @@ -144,40 +144,7 @@ static int lima_gem_sync_bo(struct lima_sched_task *task, struct lima_bo *bo,
>         if (explicit)
>                 return 0;
>
> -       /* implicit sync use bo fence in resv obj */
> -       if (write) {
> -               unsigned nr_fences;
> -               struct dma_fence **fences;
> -               int i;
> -
> -               err = reservation_object_get_fences_rcu(
> -                       bo->gem.resv, NULL, &nr_fences, &fences);
> -               if (err || !nr_fences)
> -                       return err;
> -
> -               for (i = 0; i < nr_fences; i++) {
> -                       err = lima_sched_task_add_dep(task, fences[i]);
> -                       if (err)
> -                               break;
> -               }
> -
> -               /* for error case free remaining fences */
> -               for ( ; i < nr_fences; i++)
> -                       dma_fence_put(fences[i]);
> -
> -               kfree(fences);
> -       } else {
> -               struct dma_fence *fence;
> -
> -               fence = reservation_object_get_excl_rcu(bo->gem.resv);
> -               if (fence) {
> -                       err = lima_sched_task_add_dep(task, fence);
> -                       if (err)
> -                               dma_fence_put(fence);
> -               }
> -       }
> -
> -       return err;
> +       return drm_gem_fence_array_add_implicit(&task->deps, &bo->gem, write);
>  }
>
>  static int lima_gem_lock_bos(struct lima_bo **bos, u32 nr_bos,
> @@ -250,7 +217,7 @@ static int lima_gem_add_deps(struct drm_file *file, struct lima_submit *submit)
>                 if (err)
>                         return err;
>
> -               err = lima_sched_task_add_dep(submit->task, fence);
> +               err = drm_gem_fence_array_add(&submit->task->deps, fence);
>                 if (err) {
>                         dma_fence_put(fence);
>                         return err;
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> index 97bd9c1deb87..e253d031fb3d 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -3,6 +3,7 @@
>
>  #include <linux/kthread.h>
>  #include <linux/slab.h>
> +#include <linux/xarray.h>
>
>  #include "lima_drv.h"
>  #include "lima_sched.h"
> @@ -126,19 +127,24 @@ int lima_sched_task_init(struct lima_sched_task *task,
>
>         task->num_bos = num_bos;
>         task->vm = lima_vm_get(vm);
> +
> +       xa_init_flags(&task->deps, XA_FLAGS_ALLOC);
> +
>         return 0;
>  }
>
>  void lima_sched_task_fini(struct lima_sched_task *task)
>  {
> +       struct dma_fence *fence;
> +       unsigned long index;
>         int i;
>
>         drm_sched_job_cleanup(&task->base);
>
> -       for (i = 0; i < task->num_dep; i++)
> -               dma_fence_put(task->dep[i]);
> -
> -       kfree(task->dep);
> +       xa_for_each(&task->deps, index, fence) {
> +               dma_fence_put(fence);
> +       }
> +       xa_destroy(&task->deps);
>
>         if (task->bos) {
>                 for (i = 0; i < task->num_bos; i++)
> @@ -149,42 +155,6 @@ void lima_sched_task_fini(struct lima_sched_task *task)
>         lima_vm_put(task->vm);
>  }
>
> -int lima_sched_task_add_dep(struct lima_sched_task *task, struct dma_fence *fence)
> -{
> -       int i, new_dep = 4;
> -
> -       /* same context's fence is definitly earlier then this task */
> -       if (fence->context == task->base.s_fence->finished.context) {
> -               dma_fence_put(fence);
> -               return 0;
> -       }

Seems you dropped this check in the drm_gem_fence_array_add, no bug if we
don't have this, but redundant fence will be added in the deps array. Maybe we
can add a context parameter to drm_gem_fence_array_add and
drm_gem_fence_array_add_implicit to filter out fences from same
drm_sched_entity.

Regards,
Qiang


> -
> -       if (task->dep && task->num_dep == task->max_dep)
> -               new_dep = task->max_dep * 2;
> -
> -       if (task->max_dep < new_dep) {
> -               void *dep = krealloc(task->dep, sizeof(*task->dep) * new_dep, GFP_KERNEL);
> -
> -               if (!dep)
> -                       return -ENOMEM;
> -
> -               task->max_dep = new_dep;
> -               task->dep = dep;
> -       }
> -
> -       for (i = 0; i < task->num_dep; i++) {
> -               if (task->dep[i]->context == fence->context &&
> -                   dma_fence_is_later(fence, task->dep[i])) {
> -                       dma_fence_put(task->dep[i]);
> -                       task->dep[i] = fence;
> -                       return 0;
> -               }
> -       }
> -
> -       task->dep[task->num_dep++] = fence;
> -       return 0;
> -}
> -
>  int lima_sched_context_init(struct lima_sched_pipe *pipe,
>                             struct lima_sched_context *context,
>                             atomic_t *guilty)
> @@ -213,21 +183,9 @@ static struct dma_fence *lima_sched_dependency(struct drm_sched_job *job,
>                                                struct drm_sched_entity *entity)
>  {
>         struct lima_sched_task *task = to_lima_task(job);
> -       int i;
> -
> -       for (i = 0; i < task->num_dep; i++) {
> -               struct dma_fence *fence = task->dep[i];
> -
> -               if (!task->dep[i])
> -                       continue;
> -
> -               task->dep[i] = NULL;
>
> -               if (!dma_fence_is_signaled(fence))
> -                       return fence;
> -
> -               dma_fence_put(fence);
> -       }
> +       if (!xa_empty(&task->deps))
> +               return xa_erase(&task->deps, task->last_dep++);
>
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lima_sched.h
> index b017cfa7e327..928af91c1118 100644
> --- a/drivers/gpu/drm/lima/lima_sched.h
> +++ b/drivers/gpu/drm/lima/lima_sched.h
> @@ -14,9 +14,8 @@ struct lima_sched_task {
>         struct lima_vm *vm;
>         void *frame;
>
> -       struct dma_fence **dep;
> -       int num_dep;
> -       int max_dep;
> +       struct xarray deps;
> +       unsigned long last_dep;
>
>         struct lima_bo **bos;
>         int num_bos;
> @@ -78,7 +77,6 @@ int lima_sched_task_init(struct lima_sched_task *task,
>                          struct lima_bo **bos, int num_bos,
>                          struct lima_vm *vm);
>  void lima_sched_task_fini(struct lima_sched_task *task);
> -int lima_sched_task_add_dep(struct lima_sched_task *task, struct dma_fence *fence);
>
>  int lima_sched_context_init(struct lima_sched_pipe *pipe,
>                             struct lima_sched_context *context,
> --
> 2.20.1
>
