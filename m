Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6BBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA7C2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 00:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBytd01s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDCAzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 20:55:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40887 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfDCAzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 20:55:15 -0400
Received: by mail-io1-f68.google.com with SMTP id d201so12620111iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 17:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5f23IKH86kUzuSwD9zAKGYIocV0wFxjx8LkFB8K+zk8=;
        b=TBytd01sr4PGil494fh2PWCcvkaU34f6/guQHPQboR2rJvX7nUQcF1HOEjByxosSt1
         4V6pTSvqxkx7LqZOS25Eq46fMXTDNsumg0Rm57pkb5SBD5NYOhaXO5K7XV4x4sVePs4I
         495kS4WELqoSCA65sRVEQKps7aas3OYgQWp+I9t0zFzkP/9ISZRHpGCpOWKtaztKQeJi
         4p5FiZ04YLShhVM1tSTvOzUqKWktKUs8qyyksa+QCOoljOa2Fmz+2tqcpr1wn0oUF13N
         VSXgGcOo4iIYPpI30/+jN7DtyE64r5/OqTWm2ehSxwLIFTPd2KDA3tu8mn132eAh3YhS
         GxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5f23IKH86kUzuSwD9zAKGYIocV0wFxjx8LkFB8K+zk8=;
        b=FbC2o+89rJ2YFl/WwUOr9ELeEOW6tdARMkBzWLwshoewrO0mRNCjdj/rJxPGMWZLlY
         dlaO1WGwTO/gEiyZsI2pkr171vzuTBmHwSRu3hineoJoBlEc4MtjN51/V74hCsxsbWWH
         xHhvBGB7r0BfyzaXf359ZZLdE4Cz4KZcRane8yd4mQ1Eg9MbRKn6igNvGidyiC23EJrl
         FrRk+qhI94R/hCdP3QNw+KYyT+OI2P6fMhKcumPmrSUADgEuqTR8AGrUr0MYXB+tQobe
         RXjlXcWf8S5lb2Mv8WvzWGGYtFKOVxWusHyJ8dO4wnuCZV/eRFy1NoEXjzfei5jenH11
         e2bg==
X-Gm-Message-State: APjAAAWNdAJ52+Dhxtpz7DsB4y+YmmNl9GiSEY/Vt2DJbRD9MWC3JyjJ
        ixpWj3gvz97oubsexKIRfRLsWxdvDE8qHY9M0OQ=
X-Google-Smtp-Source: APXvYqzDxRay0XXLZGwrpoeMSfF0fquA2azxn98erSf5pO/2PuxXXls961fkICHH5aNN927QDokMpnztCo5IWvAGdZg=
X-Received: by 2002:a6b:8d87:: with SMTP id p129mr50348937iod.10.1554252914219;
 Tue, 02 Apr 2019 17:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190401222635.25013-1-eric@anholt.net> <20190401222635.25013-8-eric@anholt.net>
 <CAKGbVbvfXmwKcLX=OwKRjDNBg8d9uK8yLQUUG6KsmdMyW5zxGA@mail.gmail.com> <87o95o4a78.fsf@anholt.net>
In-Reply-To: <87o95o4a78.fsf@anholt.net>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Wed, 3 Apr 2019 08:55:03 +0800
Message-ID: <CAKGbVbu-mdY92zuR6204SVktS_e98XJM1b=gWodO_TySUP2K2Q@mail.gmail.com>
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

Indeed not that important, so patch 5&7 is:
Reviewed-and-tested-by: Qiang Yu <yuq825@gmail.com>

Regards,
Qiang

On Wed, Apr 3, 2019 at 12:57 AM Eric Anholt <eric@anholt.net> wrote:
>
> Qiang Yu <yuq825@gmail.com> writes:
>
> > On Tue, Apr 2, 2019 at 6:26 AM Eric Anholt <eric@anholt.net> wrote:
> >>
> >> I haven't tested this, but it's a pretty direct port of what I did for
> >> v3d.
> >>
> >> Signed-off-by: Eric Anholt <eric@anholt.net>
> >> ---
> >>  drivers/gpu/drm/lima/lima_gem.c   | 37 +----------------
> >>  drivers/gpu/drm/lima/lima_sched.c | 66 ++++++-------------------------
> >>  drivers/gpu/drm/lima/lima_sched.h |  6 +--
> >>  3 files changed, 16 insertions(+), 93 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
> >> index 2d3cf96f6c58..8f80286c80b4 100644
> >> --- a/drivers/gpu/drm/lima/lima_gem.c
> >> +++ b/drivers/gpu/drm/lima/lima_gem.c
> >> @@ -144,40 +144,7 @@ static int lima_gem_sync_bo(struct lima_sched_task *task, struct lima_bo *bo,
> >>         if (explicit)
> >>                 return 0;
> >>
> >> -       /* implicit sync use bo fence in resv obj */
> >> -       if (write) {
> >> -               unsigned nr_fences;
> >> -               struct dma_fence **fences;
> >> -               int i;
> >> -
> >> -               err = reservation_object_get_fences_rcu(
> >> -                       bo->gem.resv, NULL, &nr_fences, &fences);
> >> -               if (err || !nr_fences)
> >> -                       return err;
> >> -
> >> -               for (i = 0; i < nr_fences; i++) {
> >> -                       err = lima_sched_task_add_dep(task, fences[i]);
> >> -                       if (err)
> >> -                               break;
> >> -               }
> >> -
> >> -               /* for error case free remaining fences */
> >> -               for ( ; i < nr_fences; i++)
> >> -                       dma_fence_put(fences[i]);
> >> -
> >> -               kfree(fences);
> >> -       } else {
> >> -               struct dma_fence *fence;
> >> -
> >> -               fence = reservation_object_get_excl_rcu(bo->gem.resv);
> >> -               if (fence) {
> >> -                       err = lima_sched_task_add_dep(task, fence);
> >> -                       if (err)
> >> -                               dma_fence_put(fence);
> >> -               }
> >> -       }
> >> -
> >> -       return err;
> >> +       return drm_gem_fence_array_add_implicit(&task->deps, &bo->gem, write);
> >>  }
> >>
> >>  static int lima_gem_lock_bos(struct lima_bo **bos, u32 nr_bos,
> >> @@ -250,7 +217,7 @@ static int lima_gem_add_deps(struct drm_file *file, struct lima_submit *submit)
> >>                 if (err)
> >>                         return err;
> >>
> >> -               err = lima_sched_task_add_dep(submit->task, fence);
> >> +               err = drm_gem_fence_array_add(&submit->task->deps, fence);
> >>                 if (err) {
> >>                         dma_fence_put(fence);
> >>                         return err;
> >> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> >> index 97bd9c1deb87..e253d031fb3d 100644
> >> --- a/drivers/gpu/drm/lima/lima_sched.c
> >> +++ b/drivers/gpu/drm/lima/lima_sched.c
> >> @@ -3,6 +3,7 @@
> >>
> >>  #include <linux/kthread.h>
> >>  #include <linux/slab.h>
> >> +#include <linux/xarray.h>
> >>
> >>  #include "lima_drv.h"
> >>  #include "lima_sched.h"
> >> @@ -126,19 +127,24 @@ int lima_sched_task_init(struct lima_sched_task *task,
> >>
> >>         task->num_bos = num_bos;
> >>         task->vm = lima_vm_get(vm);
> >> +
> >> +       xa_init_flags(&task->deps, XA_FLAGS_ALLOC);
> >> +
> >>         return 0;
> >>  }
> >>
> >>  void lima_sched_task_fini(struct lima_sched_task *task)
> >>  {
> >> +       struct dma_fence *fence;
> >> +       unsigned long index;
> >>         int i;
> >>
> >>         drm_sched_job_cleanup(&task->base);
> >>
> >> -       for (i = 0; i < task->num_dep; i++)
> >> -               dma_fence_put(task->dep[i]);
> >> -
> >> -       kfree(task->dep);
> >> +       xa_for_each(&task->deps, index, fence) {
> >> +               dma_fence_put(fence);
> >> +       }
> >> +       xa_destroy(&task->deps);
> >>
> >>         if (task->bos) {
> >>                 for (i = 0; i < task->num_bos; i++)
> >> @@ -149,42 +155,6 @@ void lima_sched_task_fini(struct lima_sched_task *task)
> >>         lima_vm_put(task->vm);
> >>  }
> >>
> >> -int lima_sched_task_add_dep(struct lima_sched_task *task, struct dma_fence *fence)
> >> -{
> >> -       int i, new_dep = 4;
> >> -
> >> -       /* same context's fence is definitly earlier then this task */
> >> -       if (fence->context == task->base.s_fence->finished.context) {
> >> -               dma_fence_put(fence);
> >> -               return 0;
> >> -       }
> >
> > Seems you dropped this check in the drm_gem_fence_array_add, no bug if we
> > don't have this, but redundant fence will be added in the deps array. Maybe we
> > can add a context parameter to drm_gem_fence_array_add and
> > drm_gem_fence_array_add_implicit to filter out fences from same
> > drm_sched_entity.
>
> Does this feel important to you?  To me, one extra slot in the array and
> a trip through the top of drm_sched_entity_add_dependency_cb() doesn't
> like it's feel worth making the API clumsier.
