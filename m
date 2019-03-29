Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9222DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5278F218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNbiGeIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfC2Pak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:30:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41451 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbfC2Paj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:30:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id w30so2762789qta.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+1vy7FRNax9Mejlbg0Wcfl6MRtToNodOlbr7bX1WZnU=;
        b=pNbiGeIrA07vMjc6dDWrUALhxo1sZUUeujsfytJBwk4cWWCrl/ncucj6LiI5JHBey0
         oPOMKGw3E7bnLm6Z/4SzjCr7IWwz8brYQsGv3vifBjV4ApUz8VjleRYsI7/qN/yt1kBp
         +JuYyyTeT/ohAPXAbS1SHwyN4eM2DoH8WMNx/Dp5Xf03mttX2SW81PxLE8b+1l2OIoRY
         tg1r/zTJiOFZQ5ands7y+hNBgHjR6CSwHb1J2h9Gb7IG+NS3TdlT5j0TjdtT+vd0sgph
         +sQmD4zyYizMvH6lpVlOpvLRVj84zKPj4VrsAXVxpPVNoVm6+iOwO+7iTjBy/NqrqaqP
         ypyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+1vy7FRNax9Mejlbg0Wcfl6MRtToNodOlbr7bX1WZnU=;
        b=ZX/U5UDIEwtZCC24DCd4eDsiXQLBzAJLoPbUOQuHJ2zLv2oiga1tz530PhvSa6lMEo
         /Lapscf1TNj8qtQxvTAfhr8nU1UDLT3xeTMmmNlQgiE/K7fhtI56d0AZvO0DJMJFrtW3
         B5bkr8Ii5GVMgsCrQkGhHgbTICfGQnaaSJ/Y14W/zZKlsD6yM2mvP3XsrqJdGjtmFKmG
         4oKihyI/otUbbCZQQTAVp6YJgcYI6tB5xwNEMxbnt52PrsL3lrmXsK5sydkdxLXRcyml
         tl4SL8Se3csvJd2Ms4OOAgKiIt9YJTA+OBXp8g3hAj9PvsqVjeBOGnvSCxCtlIZ1AXCX
         Fz+g==
X-Gm-Message-State: APjAAAVlUpsJtBcoPEuMqUqvEhuEE/W5/h/rEmWLzHoMQogjIJtiHSQH
        ePWX8bGBfX9BgR6z4DKiqVn9sU6lC+sgfPOxYgashQ==
X-Google-Smtp-Source: APXvYqxyIkOBhu0gU0M0Pq4U47RYvFMiTmXWLkJm8jmahI8eYmDLwt7jcr4pk4vt5FuWdeAQ9LMD69oZAy7dhYhnNwo=
X-Received: by 2002:a0c:b0a5:: with SMTP id o34mr37481297qvc.42.1553873438481;
 Fri, 29 Mar 2019 08:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <1553818562-2516-1-git-send-email-john.stultz@linaro.org>
 <1553818562-2516-5-git-send-email-john.stultz@linaro.org> <CA+M3ks6kWmhHv9GFCSkNPLJKU-_cctpA9d20UXzrLfudBrrHjA@mail.gmail.com>
 <c35bef87-df92-148c-cd83-aaf2ee61e644@ti.com>
In-Reply-To: <c35bef87-df92-148c-cd83-aaf2ee61e644@ti.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 29 Mar 2019 16:30:27 +0100
Message-ID: <CA+M3ks4+REvR=0mLFt-hS4dSfRpx9HLrryb1rfSbYiRSLT2OZQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/6 v3] dma-buf: heaps: Add CMA heap to dmabuf heapss
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 29 mars 2019 =C3=A0 16:19, Andrew F. Davis <afd@ti.com> a =C3=A9cri=
t :
>
> On 3/29/19 9:44 AM, Benjamin Gaignard wrote:
> > Le ven. 29 mars 2019 =C3=A0 01:16, John Stultz <john.stultz@linaro.org>=
 a =C3=A9crit :
> >>
> >> This adds a CMA heap, which allows userspace to allocate
> >> a dma-buf of contiguous memory out of a CMA region.
> >>
> >> This code is an evolution of the Android ION implementation, so
> >> thanks to its original author and maintainters:
> >>   Benjamin Gaignard, Laura Abbott, and others!
> >>
> >> Cc: Laura Abbott <labbott@redhat.com>
> >> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> >> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> >> Cc: Liam Mark <lmark@codeaurora.org>
> >> Cc: Pratik Patel <pratikp@codeaurora.org>
> >> Cc: Brian Starkey <Brian.Starkey@arm.com>
> >> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> >> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> >> Cc: Andrew F. Davis <afd@ti.com>
> >> Cc: Xu YiPing <xuyiping@hisilicon.com>
> >> Cc: "Chenfeng (puck)" <puck.chen@hisilicon.com>
> >> Cc: butao <butao@hisilicon.com>
> >> Cc: "Xiaqing (A)" <saberlily.xia@hisilicon.com>
> >> Cc: Yudongbin <yudongbin@hisilicon.com>
> >> Cc: Christoph Hellwig <hch@infradead.org>
> >> Cc: Chenbo Feng <fengc@google.com>
> >> Cc: Alistair Strachan <astrachan@google.com>
> >> Cc: dri-devel@lists.freedesktop.org
> >> Signed-off-by: John Stultz <john.stultz@linaro.org>
> >> ---
> >> v2:
> >> * Switch allocate to return dmabuf fd
> >> * Simplify init code
> >> * Checkpatch fixups
> >> v3:
> >> * Switch to inline function for to_cma_heap()
> >> * Minor cleanups suggested by Brian
> >> * Fold in new registration style from Andrew
> >> * Folded in changes from Andrew to use simplified page list
> >>   from the heap helpers
> >> ---
> >>  drivers/dma-buf/heaps/Kconfig    |   8 ++
> >>  drivers/dma-buf/heaps/Makefile   |   1 +
> >>  drivers/dma-buf/heaps/cma_heap.c | 170 ++++++++++++++++++++++++++++++=
+++++++++
> >>  3 files changed, 179 insertions(+)
> >>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
> >>
> >> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kco=
nfig
> >> index 2050527..a5eef06 100644
> >> --- a/drivers/dma-buf/heaps/Kconfig
> >> +++ b/drivers/dma-buf/heaps/Kconfig
> >> @@ -4,3 +4,11 @@ config DMABUF_HEAPS_SYSTEM
> >>         help
> >>           Choose this option to enable the system dmabuf heap. The sys=
tem heap
> >>           is backed by pages from the buddy allocator. If in doubt, sa=
y Y.
> >> +
> >> +config DMABUF_HEAPS_CMA
> >> +       bool "DMA-BUF CMA Heap"
> >> +       depends on DMABUF_HEAPS && DMA_CMA
> >> +       help
> >> +         Choose this option to enable dma-buf CMA heap. This heap is =
backed
> >> +         by the Contiguous Memory Allocator (CMA). If your system has=
 these
> >> +         regions, you should say Y here.
> >> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Ma=
kefile
> >> index d1808ec..6e54cde 100644
> >> --- a/drivers/dma-buf/heaps/Makefile
> >> +++ b/drivers/dma-buf/heaps/Makefile
> >> @@ -1,3 +1,4 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  obj-y                                  +=3D heap-helpers.o
> >>  obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)      +=3D system_heap.o
> >> +obj-$(CONFIG_DMABUF_HEAPS_CMA)         +=3D cma_heap.o
> >> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/=
cma_heap.c
> >> new file mode 100644
> >> index 0000000..f4485c60
> >> --- /dev/null
> >> +++ b/drivers/dma-buf/heaps/cma_heap.c
> >> @@ -0,0 +1,170 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * DMABUF CMA heap exporter
> >> + *
> >> + * Copyright (C) 2012, 2019 Linaro Ltd.
> >> + * Author: <benjamin.gaignard@linaro.org> for ST-Ericsson.
> >> + */
> >> +
> >> +#include <linux/device.h>
> >> +#include <linux/dma-buf.h>
> >> +#include <linux/dma-heap.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/errno.h>
> >> +#include <linux/err.h>
> >> +#include <linux/cma.h>
> >> +#include <linux/scatterlist.h>
> >> +#include <linux/highmem.h>
> >> +
> >> +#include "heap-helpers.h"
> >> +
> >> +struct cma_heap {
> >> +       struct dma_heap *heap;
> >> +       struct cma *cma;
> >> +};
> >> +
> >> +static void cma_heap_free(struct heap_helper_buffer *buffer)
> >> +{
> >> +       struct cma_heap *cma_heap =3D dma_heap_get_data(buffer->heap_b=
uffer.heap);
> >> +       struct page *pages =3D buffer->priv_virt;
> >> +       unsigned long nr_pages;
> >> +
> >> +       nr_pages =3D buffer->heap_buffer.size >> PAGE_SHIFT;
> >> +
> >> +       /* free page list */
> >> +       kfree(buffer->pages);
> >> +       /* release memory */
> >> +       cma_release(cma_heap->cma, pages, nr_pages);
> >> +       kfree(buffer);
> >> +}
> >> +
> >> +/* dmabuf heap CMA operations functions */
> >> +static int cma_heap_allocate(struct dma_heap *heap,
> >> +                               unsigned long len,
> >> +                               unsigned long flags)
> >> +{
> >> +       struct cma_heap *cma_heap =3D dma_heap_get_data(heap);
> >> +       struct heap_helper_buffer *helper_buffer;
> >> +       struct page *pages;
> >> +       size_t size =3D PAGE_ALIGN(len);
> >> +       unsigned long nr_pages =3D size >> PAGE_SHIFT;
> >> +       unsigned long align =3D get_order(size);
> >> +       DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> >> +       struct dma_buf *dmabuf;
> >> +       int ret =3D -ENOMEM;
> >> +       pgoff_t pg;
> >> +
> >> +       if (align > CONFIG_CMA_ALIGNMENT)
> >> +               align =3D CONFIG_CMA_ALIGNMENT;
> >> +
> >> +       helper_buffer =3D kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
> >> +       if (!helper_buffer)
> >> +               return -ENOMEM;
> >> +
> >> +       INIT_HEAP_HELPER_BUFFER(helper_buffer, cma_heap_free);
> >> +       helper_buffer->heap_buffer.flags =3D flags;
> >> +       helper_buffer->heap_buffer.heap =3D heap;
> >> +       helper_buffer->heap_buffer.size =3D len;
> >> +
> >> +       pages =3D cma_alloc(cma_heap->cma, nr_pages, align, false);
> >> +       if (!pages)
> >> +               goto free_buf;
> >> +
> >> +       if (PageHighMem(pages)) {
> >> +               unsigned long nr_clear_pages =3D nr_pages;
> >> +               struct page *page =3D pages;
> >> +
> >> +               while (nr_clear_pages > 0) {
> >> +                       void *vaddr =3D kmap_atomic(page);
> >> +
> >> +                       memset(vaddr, 0, PAGE_SIZE);
> >> +                       kunmap_atomic(vaddr);
> >> +                       page++;
> >> +                       nr_clear_pages--;
> >> +               }
> >> +       } else {
> >> +               memset(page_address(pages), 0, size);
> >> +       }
> >> +
> >> +       helper_buffer->pagecount =3D nr_pages;
> >> +       helper_buffer->pages =3D kmalloc_array(helper_buffer->pagecoun=
t,
> >> +                                            sizeof(*helper_buffer->pa=
ges),
> >> +                                            GFP_KERNEL);
> >> +       if (!helper_buffer->pages) {
> >> +               ret =3D -ENOMEM;
> >> +               goto free_cma;
> >> +       }
> >> +
> >> +       for (pg =3D 0; pg < helper_buffer->pagecount; pg++) {
> >> +               helper_buffer->pages[pg] =3D &pages[pg];
> >> +               if (!helper_buffer->pages[pg])
> >> +                       goto free_pages;
> >> +       }
> >> +
> >> +       /* create the dmabuf */
> >> +       exp_info.ops =3D &heap_helper_ops;
> >> +       exp_info.size =3D len;
> >> +       exp_info.flags =3D O_RDWR;
> >
> > I think that the flags should be provided when requesting the allocatio=
n
> > like it is done in DRM or V4L2.
> > For me DMA_HEAP_VALID_FLAGS =3D (O_CLOEXEC | O_ACCMODE).
> >
>
>
> So something like done in udmabuf?
>
> https://elixir.bootlin.com/linux/v5.1-rc1/source/include/uapi/linux/udmab=
uf.h#L8
>
> I think that can be arranged.

I have in mind what is done by DRM:
https://elixir.bootlin.com/linux/v5.1-rc1/source/include/uapi/drm/drm.h#L70=
7

V4L2 does the same but without redefine the flags (which is better)

Benjamin

>
> John,
>
> This might be a good reason to move the dma_buf_fd() call below out of
> the heap and back into the core. That way the file exporting flags can
> be common and core handled. I don't think it would complicate the error
> handling any as we only need to dma_buf_put(dmabuf) in the core on
> failure and the heap specific cleanup will happen for us.
>
> Andrew
>
>
> > Benjamin
> >
> > Benjamin
> >
> >> +       exp_info.priv =3D &helper_buffer->heap_buffer;
> >> +       dmabuf =3D dma_buf_export(&exp_info);
> >> +       if (IS_ERR(dmabuf)) {
> >> +               ret =3D PTR_ERR(dmabuf);
> >> +               goto free_pages;
> >> +       }
> >> +
> >> +       helper_buffer->heap_buffer.dmabuf =3D dmabuf;
> >> +       helper_buffer->priv_virt =3D pages;
> >> +
> >> +       ret =3D dma_buf_fd(dmabuf, O_CLOEXEC);
> >> +       if (ret < 0) {
> >> +               dma_buf_put(dmabuf);
> >> +               /* just return, as put will call release and that will=
 free */
> >> +               return ret;
> >> +       }
> >> +
> >> +       return ret;
> >> +
> >> +free_pages:
> >> +       kfree(helper_buffer->pages);
> >> +free_cma:
> >> +       cma_release(cma_heap->cma, pages, nr_pages);
> >> +free_buf:
> >> +       kfree(helper_buffer);
> >> +       return ret;
> >> +}
> >> +
> >> +static struct dma_heap_ops cma_heap_ops =3D {
> >> +       .allocate =3D cma_heap_allocate,
> >> +};
> >> +
> >> +static int __add_cma_heap(struct cma *cma, void *data)
> >> +{
> >> +       struct cma_heap *cma_heap;
> >> +       struct dma_heap_export_info exp_info;
> >> +
> >> +       cma_heap =3D kzalloc(sizeof(*cma_heap), GFP_KERNEL);
> >> +       if (!cma_heap)
> >> +               return -ENOMEM;
> >> +       cma_heap->cma =3D cma;
> >> +
> >> +       exp_info.name =3D cma_get_name(cma);
> >> +       exp_info.ops =3D &cma_heap_ops;
> >> +       exp_info.priv =3D cma_heap;
> >> +
> >> +       cma_heap->heap =3D dma_heap_add(&exp_info);
> >> +       if (IS_ERR(cma_heap->heap)) {
> >> +               int ret =3D PTR_ERR(cma_heap->heap);
> >> +
> >> +               kfree(cma_heap);
> >> +               return ret;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int add_cma_heaps(void)
> >> +{
> >> +       cma_for_each_area(__add_cma_heap, NULL);
> >> +       return 0;
> >> +}
> >> +device_initcall(add_cma_heaps);
> >> --
> >> 2.7.4
> >>
