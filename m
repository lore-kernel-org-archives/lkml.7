Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC85C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF9220828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PayNj4Vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfCFQFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:05:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33209 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCFQFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:05:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id q24so11238670otk.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 08:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E6Fzw9IFx2Yr3UeQMrBLlHOD9uervQUaSXuoQ91uh/4=;
        b=PayNj4Vv2xdw7RsMjJq9XXx0SPTQ3q1IkyzRlk0ChotC4nzpGAEGypwBJrHqMjDkIW
         6DfL1ZTQuOnl69EyRxXgI+A9PXzuTe1nrHfDIMD5JMLhEzfLzLuojEaAMIF18OobtWuE
         Ok13oHkOuJaW6chywy8tFJXE+zpRjX4zlLvXIoQujqSumz+litKqwW5ckEyvnaYqz4RY
         DKFvfr+ZG8Sz4ZzKbmozPGEGydE/hBxsmCDd81dugS+USc1xDEd1mHzW3oFUqr3XFogw
         EJcvZqVHA/uVcsj5lXSIYU7DxMHs+YNxcfkjIkB3E32j2YymyZikIhL2su1axhhzlcfA
         1GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E6Fzw9IFx2Yr3UeQMrBLlHOD9uervQUaSXuoQ91uh/4=;
        b=SWs2eN/MP363bwKT58VOkOip86jVwxRA4twyhUe5sYe5JwvxBpUsUfq4qwdoNCzHIN
         Py8kI0hAAecLQ5R9NJaxMCpxTqcXOif7l/mr//aWeQBqdk6dm8iEVtpZA+F4iF4Cyaih
         dhP5SG+N0SQj4hlHoNs/R1hLc52unISbB41KBXciPTK/ZsGbpen/AaRm3CoKFVqCck8T
         yaosJ5GyOjLqW/FyE+0fIJrKKJUqbGLNHtsqMj8wBphX/JvGSdP07A22uGA5l9s0JM+r
         yikkpA0ZIRP78N1e3b4SlI8d4wxqdHrzZt90DUAkpDRLBowtdTEFa0RzmTjjQi8FqLqu
         7Tug==
X-Gm-Message-State: APjAAAW0NdMql4vsq6/rO2Db4tsAf37HHXwfYwNNJPHnIM/5yy8PJvlH
        1FIgaDowDMf+sgvUkotX7f9G7MAnBdoCU4BDx/JIxA==
X-Google-Smtp-Source: APXvYqwzhLSIdTjMeEvrXe9utWaOk2/EByr/H/I6ti5rvLYwJr8TfXvYX/aDW80AZajcXoTuzhD7qINBrxRFQ6hqlJc=
X-Received: by 2002:a9d:77c7:: with SMTP id w7mr5093744otl.207.1551888340889;
 Wed, 06 Mar 2019 08:05:40 -0800 (PST)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org> <1551819273-640-5-git-send-email-john.stultz@linaro.org>
In-Reply-To: <1551819273-640-5-git-send-email-john.stultz@linaro.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 6 Mar 2019 17:05:30 +0100
Message-ID: <CA+M3ks4ekiNc=BDYn=ZvRoaCCbY8d_NJx9jgPw-=U6xdK_o-HQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/5 v2] dma-buf: heaps: Add CMA heap to dmabuf heapss
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 5 mars 2019 =C3=A0 21:54, John Stultz <john.stultz@linaro.org> a =
=C3=A9crit :
>
> This adds a CMA heap, which allows userspace to allocate
> a dma-buf of contiguous memory out of a CMA region.
>
> This code is an evolution of the Android ION implementation, so
> thanks to its original author and maintainters:
>   Benjamin Gaignard, Laura Abbott, and others!
>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Switch allocate to return dmabuf fd
> * Simplify init code
> * Checkpatch fixups
> ---
>  drivers/dma-buf/heaps/Kconfig    |   8 ++
>  drivers/dma-buf/heaps/Makefile   |   1 +
>  drivers/dma-buf/heaps/cma_heap.c | 164 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 173 insertions(+)
>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfi=
g
> index 2050527..a5eef06 100644
> --- a/drivers/dma-buf/heaps/Kconfig
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -4,3 +4,11 @@ config DMABUF_HEAPS_SYSTEM
>         help
>           Choose this option to enable the system dmabuf heap. The system=
 heap
>           is backed by pages from the buddy allocator. If in doubt, say Y=
.
> +
> +config DMABUF_HEAPS_CMA
> +       bool "DMA-BUF CMA Heap"
> +       depends on DMABUF_HEAPS && DMA_CMA
> +       help
> +         Choose this option to enable dma-buf CMA heap. This heap is bac=
ked
> +         by the Contiguous Memory Allocator (CMA). If your system has th=
ese
> +         regions, you should say Y here.
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makef=
ile
> index d1808ec..6e54cde 100644
> --- a/drivers/dma-buf/heaps/Makefile
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y                                  +=3D heap-helpers.o
>  obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)      +=3D system_heap.o
> +obj-$(CONFIG_DMABUF_HEAPS_CMA)         +=3D cma_heap.o
> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma=
_heap.c
> new file mode 100644
> index 0000000..33c18ec
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMABUF CMA heap exporter
> + *
> + * Copyright (C) 2012, 2019 Linaro Ltd.
> + * Author: <benjamin.gaignard@linaro.org> for ST-Ericsson.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/dma-buf.h>
> +#include <linux/dma-heap.h>
> +#include <linux/slab.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/cma.h>
> +#include <linux/scatterlist.h>
> +#include <linux/highmem.h>
> +
> +#include "heap-helpers.h"
> +
> +struct cma_heap {
> +       struct dma_heap heap;
> +       struct cma *cma;
> +};
> +
> +
> +#define to_cma_heap(x) container_of(x, struct cma_heap, heap)

Even if I had write this macro years ago, now I would prefer to have a
static inline function
to be able to check the types.

with that:
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

> +
> +
> +static void cma_heap_free(struct heap_helper_buffer *buffer)
> +{
> +       struct cma_heap *cma_heap =3D to_cma_heap(buffer->heap_buffer.hea=
p);
> +       struct page *pages =3D buffer->priv_virt;
> +       unsigned long nr_pages;
> +
> +       nr_pages =3D PAGE_ALIGN(buffer->heap_buffer.size) >> PAGE_SHIFT;
> +
> +       /* release memory */
> +       cma_release(cma_heap->cma, pages, nr_pages);
> +       /* release sg table */
> +       sg_free_table(buffer->sg_table);
> +       kfree(buffer->sg_table);
> +       kfree(buffer);
> +}
> +
> +/* dmabuf heap CMA operations functions */
> +static int cma_heap_allocate(struct dma_heap *heap,
> +                               unsigned long len,
> +                               unsigned long flags)
> +{
> +       struct cma_heap *cma_heap =3D to_cma_heap(heap);
> +       struct heap_helper_buffer *helper_buffer;
> +       struct sg_table *table;
> +       struct page *pages;
> +       size_t size =3D PAGE_ALIGN(len);
> +       unsigned long nr_pages =3D size >> PAGE_SHIFT;
> +       unsigned long align =3D get_order(size);
> +       DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +       struct dma_buf *dmabuf;
> +       int ret =3D -ENOMEM;
> +
> +       if (align > CONFIG_CMA_ALIGNMENT)
> +               align =3D CONFIG_CMA_ALIGNMENT;
> +
> +       helper_buffer =3D kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
> +       if (!helper_buffer)
> +               return -ENOMEM;
> +
> +       INIT_HEAP_HELPER_BUFFER(helper_buffer, cma_heap_free);
> +       helper_buffer->heap_buffer.flags =3D flags;
> +       helper_buffer->heap_buffer.heap =3D heap;
> +       helper_buffer->heap_buffer.size =3D len;
> +
> +
> +       pages =3D cma_alloc(cma_heap->cma, nr_pages, align, false);
> +       if (!pages)
> +               goto free_buf;
> +
> +       if (PageHighMem(pages)) {
> +               unsigned long nr_clear_pages =3D nr_pages;
> +               struct page *page =3D pages;
> +
> +               while (nr_clear_pages > 0) {
> +                       void *vaddr =3D kmap_atomic(page);
> +
> +                       memset(vaddr, 0, PAGE_SIZE);
> +                       kunmap_atomic(vaddr);
> +                       page++;
> +                       nr_clear_pages--;
> +               }
> +       } else {
> +               memset(page_address(pages), 0, size);
> +       }
> +
> +       table =3D kmalloc(sizeof(*table), GFP_KERNEL);
> +       if (!table)
> +               goto free_cma;
> +
> +       ret =3D sg_alloc_table(table, 1, GFP_KERNEL);
> +       if (ret)
> +               goto free_table;
> +
> +       sg_set_page(table->sgl, pages, size, 0);
> +
> +       /* create the dmabuf */
> +       exp_info.ops =3D &heap_helper_ops;
> +       exp_info.size =3D len;
> +       exp_info.flags =3D O_RDWR;
> +       exp_info.priv =3D &helper_buffer->heap_buffer;
> +       dmabuf =3D dma_buf_export(&exp_info);
> +       if (IS_ERR(dmabuf)) {
> +               ret =3D PTR_ERR(dmabuf);
> +               goto free_table;
> +       }
> +
> +       helper_buffer->heap_buffer.dmabuf =3D dmabuf;
> +       helper_buffer->priv_virt =3D pages;
> +       helper_buffer->sg_table =3D table;
> +
> +       ret =3D dma_buf_fd(dmabuf, O_CLOEXEC);
> +       if (ret < 0) {
> +               dma_buf_put(dmabuf);
> +               /* just return, as put will call release and that will fr=
ee */
> +               return ret;
> +       }
> +
> +       return ret;
> +free_table:
> +       kfree(table);
> +free_cma:
> +       cma_release(cma_heap->cma, pages, nr_pages);
> +free_buf:
> +       kfree(helper_buffer);
> +       return ret;
> +}
> +
> +static struct dma_heap_ops cma_heap_ops =3D {
> +       .allocate =3D cma_heap_allocate,
> +};
> +
> +static int __add_cma_heaps(struct cma *cma, void *data)
> +{
> +       struct cma_heap *cma_heap;
> +
> +       cma_heap =3D kzalloc(sizeof(*cma_heap), GFP_KERNEL);
> +
> +       if (!cma_heap)
> +               return -ENOMEM;
> +
> +       cma_heap->heap.name =3D cma_get_name(cma);
> +       cma_heap->heap.ops =3D &cma_heap_ops;
> +       cma_heap->cma =3D cma;
> +
> +       dma_heap_add(&cma_heap->heap);
> +
> +       return 0;
> +}
> +
> +static int add_cma_heaps(void)
> +{
> +       cma_for_each_area(__add_cma_heaps, NULL);
> +       return 0;
> +}
> +device_initcall(add_cma_heaps);
> --
> 2.7.4
>


--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
