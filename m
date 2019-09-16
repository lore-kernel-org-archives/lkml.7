Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB009C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60044216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 22:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568674406;
	bh=ddYW2WBNl6Oh0ApGXgrtqJ/jr4/K95r+xpG2bEP8o2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y0w0mqTgmVWLqcTj1rl4hs8mkuTj1mzut4mBK/JV3iqeILEZhjsKK0odsbCXYuCVK
	 w10R7AcHLiSvoF+tUZL3daJkTcipnB1951SGUJEhRnf8VKQ/mC3fSrz+CH01Syud0e
	 8uvaU7iA5xkBglAmAG0PVMrDgc7bb8hT5ULSXcNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbfIPWxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 18:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbfIPWxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 18:53:25 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16082171F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 22:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568674403;
        bh=ddYW2WBNl6Oh0ApGXgrtqJ/jr4/K95r+xpG2bEP8o2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UuJgjc27C9RwRkRzuYf9lOnNw77Cv037TE0Pdsl2FfGMCEO20DTER8ccUwFil+zuB
         Xb/kOcQb6ptFfJVyXYYApbx0y+eqTikYLhk1GK7KsJm4UDH8Jy4B0iaYkq+/J7ymD9
         ouDcOiYnJB9quB3wu5dcGAyrmcBxJFRO1i2J+Ji4=
Received: by mail-qt1-f178.google.com with SMTP id c3so1921465qtv.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 15:53:23 -0700 (PDT)
X-Gm-Message-State: APjAAAVfbH0958LUQHQdvnnPQF/dyYXgkcniDJpvu7k1O28Ip+4Bll/b
        1wQR+79mvciVSbOjdUSlxfXVTmVrvCUiUAC5eA==
X-Google-Smtp-Source: APXvYqwuEuHrXOmlu17UIy25Xr1b2cyMEojb0tWxCjpyaaD0/HsxQ2/AjpbU1oZxTTIE15gAQpaovXbELVesBVu5rao=
X-Received: by 2002:ac8:100d:: with SMTP id z13mr855289qti.224.1568674402842;
 Mon, 16 Sep 2019 15:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190905121141.42820-1-steven.price@arm.com> <20190913172454.GA5387@kevin>
In-Reply-To: <20190913172454.GA5387@kevin>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Sep 2019 17:53:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJDgNQ2gAwd+u4t0pv=dDbZoOmcu-WP+TZw+ocvtSMuQA@mail.gmail.com>
Message-ID: <CAL_JsqJDgNQ2gAwd+u4t0pv=dDbZoOmcu-WP+TZw+ocvtSMuQA@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Prevent race when handling page fault
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 12:25 PM Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com> wrote:
>
> I'm conflicted on this series.
>
> On the one hand, userspace should obviously not be able to crash the
> kernel. So the crash should be fixed in one way or another.
>
> On the other hand, userspace really has to supply all the BOs it uses
> for correctness. I realize the DDK doesn't do this but... it probably
> should, umm...
>
> Would it be possible to check for the NULL pointer in the kernel and
> skip printing information that would require a dereference? (Without
> having to play games with reference counts). Presumably that might fix
> crashes in other corner cases.

I don't think that prevents the use after free. I think the NULL is a
pointer within the BO, not the BO. So we'd still be retrieving the
NULL ptr from a freed object.

Rob

>
> On Thu, Sep 05, 2019 at 01:11:41PM +0100, Steven Price wrote:
> > When handling a GPU page fault addr_to_drm_mm_node() is used to
> > translate the GPU address to a buffer object. However it is possible for
> > the buffer object to be freed after the function has returned resulting
> > in a use-after-free of the BO.
> >
> > Change addr_to_drm_mm_node to return the panfrost_gem_object with an
> > extra reference on it, preventing the BO from being freed until after
> > the page fault has been handled.
> >
> > Signed-off-by: Steven Price <steven.price@arm.com>
> > ---
> >
> > I've managed to trigger this, generating the following stack trace.
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 00000090
> > pgd = 33a6a181
> > [00000090] *pgd=00000000
> > Internal error: Oops: 5 [#1] SMP ARM
> > Modules linked in:
> > CPU: 0 PID: 81 Comm: irq/60-mmu Not tainted 5.3.0-rc1+ #4
> > Hardware name: Rockchip (Device Tree)
> > PC is at panfrost_mmu_map_fault_addr+0x140/0x3a0
> > LR is at _raw_spin_unlock+0x20/0x3c
> > pc : [<c0508944>]    lr : [<c07ced10>]    psr: 20030013
> > sp : ec643e88  ip : ea70ce24  fp : ec5fe840
> > r10: 00000001  r9 : 00000000  r8 : 000178c9
> > r7 : 00000000  r6 : 178c9f00  r5 : ec5fe940  r4 : ea70ce08
> > r3 : 00000000  r2 : 00000000  r1 : ec640e00  r0 : ec5fe940
> > Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 10c5387d  Table: 29f8406a  DAC: 00000051
> > Process irq/60-mmu (pid: 81, stack limit = 0x4b907106)
> > Stack: (0xec643e88 to 0xec644000)
> > 3e80:                   ec640e00 c07cede0 c0c0b200 ec640e00 00000000 00000000
> > 3ea0: 000178c9 00000000 c0c0b200 c07cede0 eef91040 ec5fe840 00000001 00000000
> > 3ec0: 00010001 010003c3 000000c3 00000001 178c9f00 c0508c98 eef91050 00000000
> > 3ee0: ec643f34 c07c9188 00000001 c0167854 00000000 ec643ef8 c0c08448 c07c933c
> > 3f00: 00000000 ec643f04 fffefffe 3d182b17 ee193468 ee193400 ec5db3c0 ec5db3c0
> > 3f20: c0183840 ec5db3e4 c0cb2874 c0183b08 00000001 c018385c ffffe000 ee193400
> > 3f40: ec5db3c0 c0183b8c c0c08448 00000000 60000013 00000000 c01839b8 3d182b17
> > 3f60: ffffe000 ec5d0500 ec5db380 ec642000 ec5db3c0 c0183a64 00000000 ed025cd8
> > 3f80: ec5d0538 c0146cfc ec642000 ec5db380 c0146bc0 00000000 00000000 00000000
> > 3fa0: 00000000 00000000 00000000 c01010b4 00000000 00000000 00000000 00000000
> > 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> > [<c0508944>] (panfrost_mmu_map_fault_addr) from [<c0508c98>] (panfrost_mmu_irq_handler_thread+0xf4/0x248)
> > [<c0508c98>] (panfrost_mmu_irq_handler_thread) from [<c018385c>] (irq_thread_fn+0x1c/0x58)
> > [<c018385c>] (irq_thread_fn) from [<c0183b8c>] (irq_thread+0x128/0x240)
> > [<c0183b8c>] (irq_thread) from [<c0146cfc>] (kthread+0x13c/0x154)
> > [<c0146cfc>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> > Exception stack(0xec643fb0 to 0xec643ff8)
> > 3fa0:                                     00000000 00000000 00000000 00000000
> > 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > Code: 1affffec eaffffe8 e5143004 e59d2014 (e5933090)
> > ---[ end trace 04eadc3009b8f507 ]---
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_mmu.c | 38 ++++++++++++++++---------
> >  1 file changed, 24 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > index 842bdd7cf6be..115925e7460a 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > @@ -392,9 +392,11 @@ void panfrost_mmu_pgtable_free(struct panfrost_file_priv *priv)
> >       free_io_pgtable_ops(mmu->pgtbl_ops);
> >  }
> >
> > -static struct drm_mm_node *addr_to_drm_mm_node(struct panfrost_device *pfdev, int as, u64 addr)
> > +static struct panfrost_gem_object *
> > +addr_to_drm_mm_node(struct panfrost_device *pfdev, int as, u64 addr)
> >  {
> > -     struct drm_mm_node *node = NULL;
> > +     struct panfrost_gem_object *bo = NULL;
> > +     struct drm_mm_node *node;
> >       u64 offset = addr >> PAGE_SHIFT;
> >       struct panfrost_mmu *mmu;
> >
> > @@ -406,14 +408,17 @@ static struct drm_mm_node *addr_to_drm_mm_node(struct panfrost_device *pfdev, in
> >
> >               priv = container_of(mmu, struct panfrost_file_priv, mmu);
> >               drm_mm_for_each_node(node, &priv->mm) {
> > -                     if (offset >= node->start && offset < (node->start + node->size))
> > +                     if (offset >= node->start &&
> > +                         offset < (node->start + node->size)) {
> > +                             bo = drm_mm_node_to_panfrost_bo(node);
> > +                             drm_gem_object_get(&bo->base.base);
> >                               goto out;
> > +                     }
> >               }
> >       }
> > -
> >  out:
> >       spin_unlock(&pfdev->as_lock);
> > -     return node;
> > +     return bo;
> >  }
> >
> >  #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
> > @@ -421,29 +426,28 @@ static struct drm_mm_node *addr_to_drm_mm_node(struct panfrost_device *pfdev, in
> >  int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
> >  {
> >       int ret, i;
> > -     struct drm_mm_node *node;
> >       struct panfrost_gem_object *bo;
> >       struct address_space *mapping;
> >       pgoff_t page_offset;
> >       struct sg_table *sgt;
> >       struct page **pages;
> >
> > -     node = addr_to_drm_mm_node(pfdev, as, addr);
> > -     if (!node)
> > +     bo = addr_to_drm_mm_node(pfdev, as, addr);
> > +     if (!bo)
> >               return -ENOENT;
> >
> > -     bo = drm_mm_node_to_panfrost_bo(node);
> >       if (!bo->is_heap) {
> >               dev_WARN(pfdev->dev, "matching BO is not heap type (GPU VA = %llx)",
> > -                      node->start << PAGE_SHIFT);
> > -             return -EINVAL;
> > +                      bo->node.start << PAGE_SHIFT);
> > +             ret = -EINVAL;
> > +             goto err_bo;
> >       }
> >       WARN_ON(bo->mmu->as != as);
> >
> >       /* Assume 2MB alignment and size multiple */
> >       addr &= ~((u64)SZ_2M - 1);
> >       page_offset = addr >> PAGE_SHIFT;
> > -     page_offset -= node->start;
> > +     page_offset -= bo->node.start;
> >
> >       mutex_lock(&bo->base.pages_lock);
> >
> > @@ -452,7 +456,8 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
> >                                    sizeof(struct sg_table), GFP_KERNEL | __GFP_ZERO);
> >               if (!bo->sgts) {
> >                       mutex_unlock(&bo->base.pages_lock);
> > -                     return -ENOMEM;
> > +                     ret = -ENOMEM;
> > +                     goto err_bo;
> >               }
> >
> >               pages = kvmalloc_array(bo->base.base.size >> PAGE_SHIFT,
> > @@ -461,7 +466,8 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
> >                       kfree(bo->sgts);
> >                       bo->sgts = NULL;
> >                       mutex_unlock(&bo->base.pages_lock);
> > -                     return -ENOMEM;
> > +                     ret = -ENOMEM;
> > +                     goto err_bo;
> >               }
> >               bo->base.pages = pages;
> >               bo->base.pages_use_count = 1;
> > @@ -499,12 +505,16 @@ int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
> >
> >       dev_dbg(pfdev->dev, "mapped page fault @ AS%d %llx", as, addr);
> >
> > +     drm_gem_object_put_unlocked(&bo->base.base);
> > +
> >       return 0;
> >
> >  err_map:
> >       sg_free_table(sgt);
> >  err_pages:
> >       drm_gem_shmem_put_pages(&bo->base);
> > +err_bo:
> > +     drm_gem_object_put_unlocked(&bo->base.base);
> >       return ret;
> >  }
> >
> > --
> > 2.20.1
> >
