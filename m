Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D13C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAF9206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbfDBQ5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:57:02 -0400
Received: from anholt.net ([50.246.234.109]:53644 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729783AbfDBQ5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:57:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8DABB10A2C48;
        Tue,  2 Apr 2019 09:57:01 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hLJGv_vq150r; Tue,  2 Apr 2019 09:56:59 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id C7CB210A2AA9;
        Tue,  2 Apr 2019 09:56:59 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 5EF582FE33BA; Tue,  2 Apr 2019 09:56:59 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 7/7] drm/lima: Use the drm_gem_fence_array_add helpers for our deps.
In-Reply-To: <CAKGbVbvfXmwKcLX=OwKRjDNBg8d9uK8yLQUUG6KsmdMyW5zxGA@mail.gmail.com>
References: <20190401222635.25013-1-eric@anholt.net> <20190401222635.25013-8-eric@anholt.net> <CAKGbVbvfXmwKcLX=OwKRjDNBg8d9uK8yLQUUG6KsmdMyW5zxGA@mail.gmail.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Tue, 02 Apr 2019 09:56:59 -0700
Message-ID: <87o95o4a78.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Qiang Yu <yuq825@gmail.com> writes:

> On Tue, Apr 2, 2019 at 6:26 AM Eric Anholt <eric@anholt.net> wrote:
>>
>> I haven't tested this, but it's a pretty direct port of what I did for
>> v3d.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/gpu/drm/lima/lima_gem.c   | 37 +----------------
>>  drivers/gpu/drm/lima/lima_sched.c | 66 ++++++-------------------------
>>  drivers/gpu/drm/lima/lima_sched.h |  6 +--
>>  3 files changed, 16 insertions(+), 93 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
>> index 2d3cf96f6c58..8f80286c80b4 100644
>> --- a/drivers/gpu/drm/lima/lima_gem.c
>> +++ b/drivers/gpu/drm/lima/lima_gem.c
>> @@ -144,40 +144,7 @@ static int lima_gem_sync_bo(struct lima_sched_task *task, struct lima_bo *bo,
>>         if (explicit)
>>                 return 0;
>>
>> -       /* implicit sync use bo fence in resv obj */
>> -       if (write) {
>> -               unsigned nr_fences;
>> -               struct dma_fence **fences;
>> -               int i;
>> -
>> -               err = reservation_object_get_fences_rcu(
>> -                       bo->gem.resv, NULL, &nr_fences, &fences);
>> -               if (err || !nr_fences)
>> -                       return err;
>> -
>> -               for (i = 0; i < nr_fences; i++) {
>> -                       err = lima_sched_task_add_dep(task, fences[i]);
>> -                       if (err)
>> -                               break;
>> -               }
>> -
>> -               /* for error case free remaining fences */
>> -               for ( ; i < nr_fences; i++)
>> -                       dma_fence_put(fences[i]);
>> -
>> -               kfree(fences);
>> -       } else {
>> -               struct dma_fence *fence;
>> -
>> -               fence = reservation_object_get_excl_rcu(bo->gem.resv);
>> -               if (fence) {
>> -                       err = lima_sched_task_add_dep(task, fence);
>> -                       if (err)
>> -                               dma_fence_put(fence);
>> -               }
>> -       }
>> -
>> -       return err;
>> +       return drm_gem_fence_array_add_implicit(&task->deps, &bo->gem, write);
>>  }
>>
>>  static int lima_gem_lock_bos(struct lima_bo **bos, u32 nr_bos,
>> @@ -250,7 +217,7 @@ static int lima_gem_add_deps(struct drm_file *file, struct lima_submit *submit)
>>                 if (err)
>>                         return err;
>>
>> -               err = lima_sched_task_add_dep(submit->task, fence);
>> +               err = drm_gem_fence_array_add(&submit->task->deps, fence);
>>                 if (err) {
>>                         dma_fence_put(fence);
>>                         return err;
>> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
>> index 97bd9c1deb87..e253d031fb3d 100644
>> --- a/drivers/gpu/drm/lima/lima_sched.c
>> +++ b/drivers/gpu/drm/lima/lima_sched.c
>> @@ -3,6 +3,7 @@
>>
>>  #include <linux/kthread.h>
>>  #include <linux/slab.h>
>> +#include <linux/xarray.h>
>>
>>  #include "lima_drv.h"
>>  #include "lima_sched.h"
>> @@ -126,19 +127,24 @@ int lima_sched_task_init(struct lima_sched_task *task,
>>
>>         task->num_bos = num_bos;
>>         task->vm = lima_vm_get(vm);
>> +
>> +       xa_init_flags(&task->deps, XA_FLAGS_ALLOC);
>> +
>>         return 0;
>>  }
>>
>>  void lima_sched_task_fini(struct lima_sched_task *task)
>>  {
>> +       struct dma_fence *fence;
>> +       unsigned long index;
>>         int i;
>>
>>         drm_sched_job_cleanup(&task->base);
>>
>> -       for (i = 0; i < task->num_dep; i++)
>> -               dma_fence_put(task->dep[i]);
>> -
>> -       kfree(task->dep);
>> +       xa_for_each(&task->deps, index, fence) {
>> +               dma_fence_put(fence);
>> +       }
>> +       xa_destroy(&task->deps);
>>
>>         if (task->bos) {
>>                 for (i = 0; i < task->num_bos; i++)
>> @@ -149,42 +155,6 @@ void lima_sched_task_fini(struct lima_sched_task *task)
>>         lima_vm_put(task->vm);
>>  }
>>
>> -int lima_sched_task_add_dep(struct lima_sched_task *task, struct dma_fence *fence)
>> -{
>> -       int i, new_dep = 4;
>> -
>> -       /* same context's fence is definitly earlier then this task */
>> -       if (fence->context == task->base.s_fence->finished.context) {
>> -               dma_fence_put(fence);
>> -               return 0;
>> -       }
>
> Seems you dropped this check in the drm_gem_fence_array_add, no bug if we
> don't have this, but redundant fence will be added in the deps array. Maybe we
> can add a context parameter to drm_gem_fence_array_add and
> drm_gem_fence_array_add_implicit to filter out fences from same
> drm_sched_entity.

Does this feel important to you?  To me, one extra slot in the array and
a trip through the top of drm_sched_entity_add_dependency_cb() doesn't
like it's feel worth making the API clumsier.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyjlFsACgkQtdYpNtH8
nugzjw/+JIUmvOODqZs8UycSfEjEpyhx84AUY+qPm1Bo37lftUuCH2kO/Vlt/6F9
MkY+jLsETdUSQU7XBxnpEXZeQwdJCb+0EmtpquvJlQFPVCGEie53snkPkAB9feiK
N716S6kKZ4kj4rQ2iiztczB9oWpA1LKbwiddNP3+WKqJyA9tw8cwwWdWFYS5ytmI
WZxXyUOIX0jrVC3lXZnFgsTZW3flXQIZjocEAjQYTqg7aPaudAXZBhsAV6CR1CCf
cKu1U+kgcHbxKmh3lnh0gyGDJW9UFcUzig7Nt5VUWP7I4YhQdWtCKf+u3EkRuaXZ
1478teunGA9xf90u+sY1g3o8oB3fLmVGkIujGbWmZu0aMTxrR8GzybcGftOdIxJe
u0INfmy1OIdU0Xwdr24ZL3iTPmeYzPeubi8LxvFdiqOJtCF+vBF75KFH93L0bOAq
JuKNBIiw4EfpAYqBuCnsbAqoVnTpfE0Cd6HRVIU+Rdk+PxwoBrVQ5KDKKf64tMOp
9W2+qb/WahvHfUOavUPv8e4TF9Ru4nAwRuENV77/aMjSZ32m0GuZA2uwsXrZNgzp
9rtQ7YLTK+seY/FoYHC3BwiFkBh9z5/Eo776wxMICz5VprXY1wG06b0UENNno6eA
czExBAm+NDFWYw6Bv0H862WqAi5AQc2g9Rdk2gSfthIaxx61tWY=
=W49P
-----END PGP SIGNATURE-----
--=-=-=--
