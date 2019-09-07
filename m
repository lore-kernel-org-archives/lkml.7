Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB7DC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221B121744
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TvXeKsfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436661AbfIGTgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 15:36:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33817 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfIGTgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 15:36:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id c7so8920503otp.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhGLMNYUXJVQObvjLPO1eOiQfW1an+aVLoibG+hHY9Q=;
        b=TvXeKsfp/nWWk1PSAqPnMBAzbhIuOo4U+A7gi16k160MJlt2d/O7WhwFaZ9rraOsBP
         7N/K3JNqDHlTMvGrCbJT1jAqvcZTdlyv+rQ8SF3cgvWCRCRobvt14qMcVu/E8TediIDT
         DF9GT+FB8MGRmump0F5RFngwNYnrA+hvFDHg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhGLMNYUXJVQObvjLPO1eOiQfW1an+aVLoibG+hHY9Q=;
        b=h+qBicbjqOTK1g84HmzzxNuA9KCSfSIGIecGir6AUmvnqx25yG7YQuJhod7Hgdk9LJ
         QBQwejY85g5+PE1bIi0UZ+zQqHIdu3oLrrNs3594dymqMziS5iX0kX40Q/l9kG47fcv8
         DroNOTFOkiiB+W6ulO5XeYrork3ewImcTuUdCjx5OrUHMMGDTkMyrOCGeEsbD2K237EQ
         UTHy21PbNnBDfcW1adJ/RL5d7AXoEFeBDqAlMb82yEMaMNRvt93YKCI7xWBezMhiccu7
         0dZmkXESfEBKWi7oKCAoRYbpe7siIGSJPvEknyAGEzdCrIJafNjzwzJJhnPWgfkGYI7j
         8bBw==
X-Gm-Message-State: APjAAAXcIiEi8zjQwdLmun47y5l0IJ5LK0upr3t+wiHla9LQ5c5l/rvb
        vJI90Vj1GipPQ4eFX5KgaRV/nv2BGEcwVqPSfU9GbsNP
X-Google-Smtp-Source: APXvYqw9MLHsMbDuHWusaaUeavHJQNS8sUOSW/qUdjoZHHhfwfZJnEgUK1X7iy+POt0zvZdNu+dnfsKg4HRMF4ea7fw=
X-Received: by 2002:a05:6830:10d8:: with SMTP id z24mr1919013oto.281.1567884975003;
 Sat, 07 Sep 2019 12:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190905121141.42820-1-steven.price@arm.com> <CAL_JsqKyKUBOK7+fSpr+ShjUz72oXC91ySOKCST9WyWjd0nqww@mail.gmail.com>
 <d0fb9ba9-d8af-1523-192c-23376e467f12@arm.com>
In-Reply-To: <d0fb9ba9-d8af-1523-192c-23376e467f12@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sat, 7 Sep 2019 21:36:03 +0200
Message-ID: <CAKMK7uF1PYEPjQBvZwFOzAtjQ4YbY7AWj5mV106fvk_e=2ohsw@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Prevent race when handling page fault
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 2:42 PM Steven Price <steven.price@arm.com> wrote:
>
> On 06/09/2019 12:10, Rob Herring wrote:
> > On Thu, Sep 5, 2019 at 1:11 PM Steven Price <steven.price@arm.com> wrote:
> >>
> >> When handling a GPU page fault addr_to_drm_mm_node() is used to
> >> translate the GPU address to a buffer object. However it is possible for
> >> the buffer object to be freed after the function has returned resulting
> >> in a use-after-free of the BO.
> >>
> >> Change addr_to_drm_mm_node to return the panfrost_gem_object with an
> >> extra reference on it, preventing the BO from being freed until after
> >> the page fault has been handled.
> >>
> >> Signed-off-by: Steven Price <steven.price@arm.com>
> >> ---
> >>
> >> I've managed to trigger this, generating the following stack trace.
> >
> > Humm, the assumption was that a fault could only happen during a job
> > and so a reference would already be held. Otherwise, couldn't the GPU
> > also be accessing the BO after it is freed?
>
> Ah, I guess I missed that in the commit message. This is assuming that
> user space doesn't include the BO in the job even though the GPU then
> does try to access it. AIUI mesa wouldn't do this, but this is still
> easily possible if user space wants to crash the kernel.

Do we have some nice regression tests for uapi exploits and corner
cases like this? Maybe even in igt?
-Daniel

>
> > Also, looking at this again, I think we need to hold the mm_lock
> > around the drm_mm_for_each_node().
>
> Ah, good point. Squashing in the following should do the trick:
>
> ----8<----
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index ccc536d2e489..41f297aa259c 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -396,26 +396,33 @@ static struct panfrost_gem_object *
>  addr_to_drm_mm_node(struct panfrost_device *pfdev, int as, u64 addr)
>  {
>         struct panfrost_gem_object *bo = NULL;
> +       struct panfrost_file_priv *priv;
>         struct drm_mm_node *node;
>         u64 offset = addr >> PAGE_SHIFT;
>         struct panfrost_mmu *mmu;
>
>         spin_lock(&pfdev->as_lock);
>         list_for_each_entry(mmu, &pfdev->as_lru_list, list) {
> -               struct panfrost_file_priv *priv;
> -               if (as != mmu->as)
> -                       continue;
> +               if (as == mmu->as)
> +                       break;
> +       }
> +       if (as != mmu->as)
> +               goto out;
>
> -               priv = container_of(mmu, struct panfrost_file_priv, mmu);
> -               drm_mm_for_each_node(node, &priv->mm) {
> -                       if (offset >= node->start &&
> -                           offset < (node->start + node->size)) {
> -                               bo = drm_mm_node_to_panfrost_bo(node);
> -                               drm_gem_object_get(&bo->base.base);
> -                               goto out;
> -                       }
> +       priv = container_of(mmu, struct panfrost_file_priv, mmu);
> +
> +       spin_lock(&priv->mm_lock);
> +
> +       drm_mm_for_each_node(node, &priv->mm) {
> +               if (offset >= node->start &&
> +                               offset < (node->start + node->size)) {
> +                       bo = drm_mm_node_to_panfrost_bo(node);
> +                       drm_gem_object_get(&bo->base.base);
> +                       break;
>                 }
>         }
> +
> +       spin_unlock(&priv->mm_lock);
>  out:
>         spin_unlock(&pfdev->as_lock);
>         return bo;
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
