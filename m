Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA70C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF302147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njeEaVjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfENLzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:55:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36333 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENLzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:55:24 -0400
Received: by mail-qk1-f196.google.com with SMTP id c14so10084484qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 04:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=94i9moI9aAbX79rtWjpIvzJ0KFEcyOyw4lumuTSlrtk=;
        b=njeEaVjVsuPpDrj4DnX1BoMZVHRIvg5rvZrR1k4dXWKMXfOPOfYXJJmMuf9ocxTdBO
         Sul8oJOHPGA9ucaDu5NQj9HNbVLbPgEj2g58aScK4m/i8UmCMS2rbrzpXauvWaL9e2Y6
         5ZOES+8jRckWen7NfneXM6jXTG1chpsQ/eA7fBTF8EjecAHHP3b+VKLrJZRQ9VIJOpSb
         Zzoul9AphxCiBYED1cKia1ZaM6YjcxvDdx9jx+Cj6/knFDQbu0RmQN/z1zwGpRjWganm
         e9o3S4yMTuwxNwl6IisxpLXNQV9vABebfKH9RA2WBljJtz1sf/bhOEq8j/iIVXLChLD5
         g8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=94i9moI9aAbX79rtWjpIvzJ0KFEcyOyw4lumuTSlrtk=;
        b=kfvLY631F3sG5cU3DskXa/ZIGB734nlw5yfjDucnJWJWaeRiM6yeZgaG/u0dnl0ZG4
         Mv7ULRxLtMjIJ4zepbwyPW4ybChfvUkJl9K8GT93f6nbXomemFYMrz2qb9vK8+Z1vyYi
         x69I/zlCT/zM07pwRETcvTOQt4ObNjvYgtJ8UHfwSB23maqTLYC739LqOwDbPwcWzhCS
         eq+qZ+kJWsXLwruD4IFzsuslhkhuavmBaBjSzjpA9WVYHAa/U6YsBxS+1hWlZoimK4Ek
         93k8xkIbdBYk2F39k+CTqvQInszI5l/hUJus6P02xqtEs87PjOeSFAB36EHeUBJNs+cp
         TCLQ==
X-Gm-Message-State: APjAAAUc2/ZcHVnWDAxW0cbNHKVpHjQKBv6vRe+Klw1clBP53Rsf8vtj
        3R29clOMg5xiU8KU5kpwjNJf3v+vTgtlJDoOr34tGg==
X-Google-Smtp-Source: APXvYqyFF17HsOszywGmF6KjHUPe9oJPkm6zQ4rDzy+424HwfzAhi+CCI8+aH+toJuBKvd4DozAfNJP88hj/7yQesY8=
X-Received: by 2002:a05:620a:1084:: with SMTP id g4mr27155596qkk.228.1557834922886;
 Tue, 14 May 2019 04:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190513183727.15755-1-john.stultz@linaro.org>
 <20190513183727.15755-5-john.stultz@linaro.org> <0333e2b3-0e3d-360e-c8ac-62f3235d24be@hisilicon.com>
In-Reply-To: <0333e2b3-0e3d-360e-c8ac-62f3235d24be@hisilicon.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 14 May 2019 13:55:12 +0200
Message-ID: <CA+M3ks5W7ad7ckFop7Stw4NU+fc-vfS=dX85hCuro0iER0OCNg@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/5 v4] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>, Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Liuyi (Daniel)" <daniel.liuyi@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 14 mai 2019 =C3=A0 12:40, Xiaqing (A) <saberlily.xia@hisilicon.com>=
 a =C3=A9crit :
>
>
>
> On 2019/5/14 2:37, John Stultz wrote:
> > This adds a CMA heap, which allows userspace to allocate
> > a dma-buf of contiguous memory out of a CMA region.
> >
> > This code is an evolution of the Android ION implementation, so
> > thanks to its original author and maintainters:
> >    Benjamin Gaignard, Laura Abbott, and others!
> >
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Liam Mark <lmark@codeaurora.org>
> > Cc: Pratik Patel <pratikp@codeaurora.org>
> > Cc: Brian Starkey <Brian.Starkey@arm.com>
> > Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> > Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> > Cc: Andrew F. Davis <afd@ti.com>
> > Cc: Xu YiPing <xuyiping@hisilicon.com>
> > Cc: "Chenfeng (puck)" <puck.chen@hisilicon.com>
> > Cc: butao <butao@hisilicon.com>
> > Cc: "Xiaqing (A)" <saberlily.xia@hisilicon.com>
> > Cc: Yudongbin <yudongbin@hisilicon.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Chenbo Feng <fengc@google.com>
> > Cc: Alistair Strachan <astrachan@google.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> > v2:
> > * Switch allocate to return dmabuf fd
> > * Simplify init code
> > * Checkpatch fixups
> > v3:
> > * Switch to inline function for to_cma_heap()
> > * Minor cleanups suggested by Brian
> > * Fold in new registration style from Andrew
> > * Folded in changes from Andrew to use simplified page list
> >    from the heap helpers
> > * Use the fd_flags when creating dmabuf fd (Suggested by
> >    Benjamin)
> > * Use precalculated pagecount (Suggested by Andrew)
> > ---
> >   drivers/dma-buf/heaps/Kconfig    |   8 ++
> >   drivers/dma-buf/heaps/Makefile   |   1 +
> >   drivers/dma-buf/heaps/cma_heap.c | 169 ++++++++++++++++++++++++++++++=
+
> >   3 files changed, 178 insertions(+)
> >   create mode 100644 drivers/dma-buf/heaps/cma_heap.c
> >
> > diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kcon=
fig
> > index 205052744169..a5eef06c4226 100644
> > --- a/drivers/dma-buf/heaps/Kconfig
> > +++ b/drivers/dma-buf/heaps/Kconfig
> > @@ -4,3 +4,11 @@ config DMABUF_HEAPS_SYSTEM
> >       help
> >         Choose this option to enable the system dmabuf heap. The system=
 heap
> >         is backed by pages from the buddy allocator. If in doubt, say Y=
.
> > +
> > +config DMABUF_HEAPS_CMA
> > +     bool "DMA-BUF CMA Heap"
> > +     depends on DMABUF_HEAPS && DMA_CMA
> > +     help
> > +       Choose this option to enable dma-buf CMA heap. This heap is bac=
ked
> > +       by the Contiguous Memory Allocator (CMA). If your system has th=
ese
> > +       regions, you should say Y here.
> > diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Mak=
efile
> > index d1808eca2581..6e54cdec3da0 100644
> > --- a/drivers/dma-buf/heaps/Makefile
> > +++ b/drivers/dma-buf/heaps/Makefile
> > @@ -1,3 +1,4 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   obj-y                                       +=3D heap-helpers.o
> >   obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)   +=3D system_heap.o
> > +obj-$(CONFIG_DMABUF_HEAPS_CMA)               +=3D cma_heap.o
> > diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/c=
ma_heap.c
> > new file mode 100644
> > index 000000000000..3d0ffbbd0a34
> > --- /dev/null
> > +++ b/drivers/dma-buf/heaps/cma_heap.c
> > @@ -0,0 +1,169 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DMABUF CMA heap exporter
> > + *
> > + * Copyright (C) 2012, 2019 Linaro Ltd.
> > + * Author: <benjamin.gaignard@linaro.org> for ST-Ericsson.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/dma-buf.h>
> > +#include <linux/dma-heap.h>
> > +#include <linux/slab.h>
> > +#include <linux/errno.h>
> > +#include <linux/err.h>
> > +#include <linux/cma.h>
> > +#include <linux/scatterlist.h>
> > +#include <linux/highmem.h>
> > +
> > +#include "heap-helpers.h"
> > +
> > +struct cma_heap {
> > +     struct dma_heap *heap;
> > +     struct cma *cma;
> > +};
> > +
> > +static void cma_heap_free(struct heap_helper_buffer *buffer)
> > +{
> > +     struct cma_heap *cma_heap =3D dma_heap_get_data(buffer->heap_buff=
er.heap);
> > +     unsigned long nr_pages =3D buffer->pagecount;
> > +     struct page *pages =3D buffer->priv_virt;
> > +
> > +     /* free page list */
> > +     kfree(buffer->pages);
> > +     /* release memory */
> > +     cma_release(cma_heap->cma, pages, nr_pages);
> > +     kfree(buffer);
> > +}
> > +
> > +/* dmabuf heap CMA operations functions */
> > +static int cma_heap_allocate(struct dma_heap *heap,
> > +                             unsigned long len,
> > +                             unsigned long fd_flags,
> > +                             unsigned long heap_flags)
> > +{
> > +     struct cma_heap *cma_heap =3D dma_heap_get_data(heap);
> > +     struct heap_helper_buffer *helper_buffer;
> > +     struct page *pages;
> > +     size_t size =3D PAGE_ALIGN(len);
> > +     unsigned long nr_pages =3D size >> PAGE_SHIFT;
> > +     unsigned long align =3D get_order(size);
> > +     DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> > +     struct dma_buf *dmabuf;
> > +     int ret =3D -ENOMEM;
> > +     pgoff_t pg;
> > +
> > +     if (align > CONFIG_CMA_ALIGNMENT)
> > +             align =3D CONFIG_CMA_ALIGNMENT;
> > +
> > +     helper_buffer =3D kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
> > +     if (!helper_buffer)
> > +             return -ENOMEM;
> > +
> > +     INIT_HEAP_HELPER_BUFFER(helper_buffer, cma_heap_free);
> > +     helper_buffer->heap_buffer.flags =3D heap_flags;
> > +     helper_buffer->heap_buffer.heap =3D heap;
> > +     helper_buffer->heap_buffer.size =3D len;
> > +
> > +     pages =3D cma_alloc(cma_heap->cma, nr_pages, align, false);
> > +     if (!pages)
> > +             goto free_buf;
> > +
> > +     if (PageHighMem(pages)) {
> > +             unsigned long nr_clear_pages =3D nr_pages;
> > +             struct page *page =3D pages;
> > +
> > +             while (nr_clear_pages > 0) {
> > +                     void *vaddr =3D kmap_atomic(page);
> > +
> > +                     memset(vaddr, 0, PAGE_SIZE);
> > +                     kunmap_atomic(vaddr);
> > +                     page++;
> > +                     nr_clear_pages--;
> > +             }
> > +     } else {
> > +             memset(page_address(pages), 0, size);
> > +     }
> > +
> > +     helper_buffer->pagecount =3D nr_pages;
> > +     helper_buffer->pages =3D kmalloc_array(helper_buffer->pagecount,
> > +                                          sizeof(*helper_buffer->pages=
),
> > +                                          GFP_KERNEL);
> > +     if (!helper_buffer->pages) {
> > +             ret =3D -ENOMEM;
> > +             goto free_cma;
> > +     }
> > +
> > +     for (pg =3D 0; pg < helper_buffer->pagecount; pg++) {
> > +             helper_buffer->pages[pg] =3D &pages[pg];
> > +             if (!helper_buffer->pages[pg])
> > +                     goto free_pages;
> > +     }
> > +
> > +     /* create the dmabuf */
> > +     exp_info.ops =3D &heap_helper_ops;
> > +     exp_info.size =3D len;
> > +     exp_info.flags =3D fd_flags;
> > +     exp_info.priv =3D &helper_buffer->heap_buffer;
> > +     dmabuf =3D dma_buf_export(&exp_info);
> > +     if (IS_ERR(dmabuf)) {
> > +             ret =3D PTR_ERR(dmabuf);
> > +             goto free_pages;
> > +     }
> Can the dmabuf be created in the framework layer?
> each heap needs to add the same code here, which is not very good.

No that would make errors cases more difficult to handle because
you will need to call a new heap's function to clean everything.

>
> > +
> > +     helper_buffer->heap_buffer.dmabuf =3D dmabuf;
> > +     helper_buffer->priv_virt =3D pages;
> > +
> > +     ret =3D dma_buf_fd(dmabuf, fd_flags);
> > +     if (ret < 0) {
> > +             dma_buf_put(dmabuf);
> > +             /* just return, as put will call release and that will fr=
ee */
> > +             return ret;
> > +     }
> > +
> > +     return ret;
> > +
> > +free_pages:
> > +     kfree(helper_buffer->pages);
> > +free_cma:
> > +     cma_release(cma_heap->cma, pages, nr_pages);
> > +free_buf:
> > +     kfree(helper_buffer);
> > +     return ret;
> > +}
> > +
> > +static struct dma_heap_ops cma_heap_ops =3D {
> > +     .allocate =3D cma_heap_allocate,
> > +};
> > +
> > +static int __add_cma_heap(struct cma *cma, void *data)
> > +{
> > +     struct cma_heap *cma_heap;
> > +     struct dma_heap_export_info exp_info;
> > +
> > +     cma_heap =3D kzalloc(sizeof(*cma_heap), GFP_KERNEL);
> > +     if (!cma_heap)
> > +             return -ENOMEM;
> > +     cma_heap->cma =3D cma;
> > +
> > +     exp_info.name =3D cma_get_name(cma);
> > +     exp_info.ops =3D &cma_heap_ops;
> > +     exp_info.priv =3D cma_heap;
> > +
> > +     cma_heap->heap =3D dma_heap_add(&exp_info);
> > +     if (IS_ERR(cma_heap->heap)) {
> > +             int ret =3D PTR_ERR(cma_heap->heap);
> > +
> > +             kfree(cma_heap);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int add_cma_heaps(void)
> > +{
> > +     cma_for_each_area(__add_cma_heap, NULL);
> > +     return 0;
> > +}
> > +device_initcall(add_cma_heaps);
> >
>
