Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18386C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB3C820675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eaerwNbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfCFQBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:01:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39263 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCFQBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:01:20 -0500
Received: by mail-oi1-f195.google.com with SMTP id b4so10237194oif.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 08:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f1j1oMGIOtummhVkE+4fyp9ngTzpx73LD7VGOEK3InE=;
        b=eaerwNbhrY1+HfOPr/20fZeuZuqulsQdpnOFAg9fIK6MRIJrOk9EPKZ8aOUuV6guk6
         9LoXcpDDs5EOHAq0asnEpONYNSYe9j4bzj55doYqeSHo015UA7BqDIZH/Hwu0qhH6kMj
         gXvKyYJvuMA4NP2dfyQejp/MxnzTGPlUdd9mEIuUZx22pvcb16jr+wRGZxXoiurazOA7
         t34yS/501X/PL8CszTUoygb3S+dk24f9d0Z3YjwaDVLvRnWdgQUaog9rGOsRSv6l3jzb
         upJ6uTuYyUuyXYMLGcIqNB1lQ7nQ2KN1m+YkPxk5mbnIqJ8AlteFIAi5FZIXzPVhMtYO
         dg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f1j1oMGIOtummhVkE+4fyp9ngTzpx73LD7VGOEK3InE=;
        b=SutzrSfnDwLapyonGtSQKmQXCiui8+g9ASnY6EnchDfQK5i2L3l2yAXP1nZnA3qiQJ
         YNJSJ1nBc4V6dy5UQDPEHtzqFxrGmLWiQ1N9zavxkNpH3w2Lu4qtCxXu+DBFhn6hhWSJ
         35WbpdqTzZOK8jdXLeV3V3as9RHDu1m9/lzJSP/X389gkjvw3DPCkK2jyKfl0KQ5ruGC
         FWz//+mmXje0d13XmSwgKJc+ZXf0LEEO5cOFtBQIdzY7em7dbaShfkdzwmvXAe2fCuM4
         MiwSZVIGLhrKAXKyLjhrz9J0WZppWpONj0kbjGBImyWMoY66lVMVfOmbi317wEvKA3xP
         QM9w==
X-Gm-Message-State: APjAAAUrpj8Vx2EjPUYheBCxCACgx9guUHnD4g+pgjDXlSahQ9syQGgG
        XQpAopX5BGwcbkMZCb3uHlYv7E/57R7ctNBR4z3QeA==
X-Google-Smtp-Source: APXvYqxeZGBbnTvB87m1347N8JCoN2bzc11d5VFKn2LSBDQDlg3AysljLFQ5VjdJNK8RKaTZQAGthVB3r2MJjD2uJuk=
X-Received: by 2002:aca:5d0a:: with SMTP id r10mr1976923oib.92.1551888079457;
 Wed, 06 Mar 2019 08:01:19 -0800 (PST)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org> <1551819273-640-4-git-send-email-john.stultz@linaro.org>
In-Reply-To: <1551819273-640-4-git-send-email-john.stultz@linaro.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 6 Mar 2019 17:01:08 +0100
Message-ID: <CA+M3ks6ga2-c2GRWDMdDnPDEFQ+0+QdxAUbSc--fKVHJNR6R6Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/5 v2] dma-buf: heaps: Add system heap to dmabuf heaps
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
> This patch adds system heap to the dma-buf heaps framework.
>
> This allows applications to get a page-allocator backed dma-buf
> for non-contiguous memory.
>
> This code is an evolution of the Android ION implementation, so
> thanks to its original authors and maintainters:
>   Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!
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
> * Droped dead system-contig code

just few blank lines to remove.

Reveiwed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>  drivers/dma-buf/Kconfig             |   2 +
>  drivers/dma-buf/heaps/Kconfig       |   6 ++
>  drivers/dma-buf/heaps/Makefile      |   1 +
>  drivers/dma-buf/heaps/system_heap.c | 132 ++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 141 insertions(+)
>  create mode 100644 drivers/dma-buf/heaps/Kconfig
>  create mode 100644 drivers/dma-buf/heaps/system_heap.c
>
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index 09c61db..63c139d 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -47,4 +47,6 @@ menuconfig DMABUF_HEAPS
>           this allows userspace to allocate dma-bufs that can be shared b=
etween
>           drivers.
>
> +source "drivers/dma-buf/heaps/Kconfig"
> +
>  endmenu
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfi=
g
> new file mode 100644
> index 0000000..2050527
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -0,0 +1,6 @@
> +config DMABUF_HEAPS_SYSTEM
> +       bool "DMA-BUF System Heap"
> +       depends on DMABUF_HEAPS
> +       help
> +         Choose this option to enable the system dmabuf heap. The system=
 heap
> +         is backed by pages from the buddy allocator. If in doubt, say Y=
.
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makef=
ile
> index de49898..d1808ec 100644
> --- a/drivers/dma-buf/heaps/Makefile
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y                                  +=3D heap-helpers.o
> +obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)      +=3D system_heap.o
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> new file mode 100644
> index 0000000..e001661
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DMABUF System heap exporter
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#include <asm/page.h>
> +#include <linux/dma-buf.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-heap.h>
> +#include <linux/err.h>
> +#include <linux/highmem.h>
> +#include <linux/mm.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +
> +#include "heap-helpers.h"
> +
> +
remove blank line
> +struct system_heap {
> +       struct dma_heap heap;
> +};
> +
> +
remove blank line
> +static void system_heap_free(struct heap_helper_buffer *buffer)
> +{
> +       int i;
> +       struct scatterlist *sg;
> +       struct sg_table *table =3D buffer->sg_table;
> +
> +       for_each_sg(table->sgl, sg, table->nents, i)
> +               __free_page(sg_page(sg));
> +
> +       sg_free_table(table);
> +       kfree(table);
> +       kfree(buffer);
> +}
> +
> +static int system_heap_allocate(struct dma_heap *heap,
> +                               unsigned long len,
> +                               unsigned long flags)
> +{
> +       struct heap_helper_buffer *helper_buffer;
> +       struct sg_table *table;
> +       struct scatterlist *sg;
> +       int i, j;
> +       int npages =3D PAGE_ALIGN(len) / PAGE_SIZE;
> +       DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +       struct dma_buf *dmabuf;
> +       int ret =3D -ENOMEM;
> +
> +       helper_buffer =3D kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
> +       if (!helper_buffer)
> +               return -ENOMEM;
> +
> +       INIT_HEAP_HELPER_BUFFER(helper_buffer, system_heap_free);
> +       helper_buffer->heap_buffer.flags =3D flags;
> +       helper_buffer->heap_buffer.heap =3D heap;
> +       helper_buffer->heap_buffer.size =3D len;
> +
> +       table =3D kmalloc(sizeof(struct sg_table), GFP_KERNEL);
> +       if (!table)
> +               goto err0;
> +
> +       i =3D sg_alloc_table(table, npages, GFP_KERNEL);
> +       if (i)
> +               goto err1;
> +       for_each_sg(table->sgl, sg, table->nents, i) {
> +               struct page *page;
> +
> +               page =3D alloc_page(GFP_KERNEL);
> +               if (!page)
> +                       goto err2;
> +               sg_set_page(sg, page, PAGE_SIZE, 0);
> +       }
> +
> +       /* create the dmabuf */
> +       exp_info.ops =3D &heap_helper_ops;
> +       exp_info.size =3D len;
> +       exp_info.flags =3D O_RDWR;
> +       exp_info.priv =3D &helper_buffer->heap_buffer;
> +       dmabuf =3D dma_buf_export(&exp_info);
> +       if (IS_ERR(dmabuf)) {
> +               ret =3D PTR_ERR(dmabuf);
> +               goto err2;
> +       }
> +
> +       helper_buffer->heap_buffer.dmabuf =3D dmabuf;
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
> +
> +err2:
> +       for_each_sg(table->sgl, sg, i, j)
> +               __free_page(sg_page(sg));
> +       sg_free_table(table);
> +err1:
> +       kfree(table);
> +err0:
> +       kfree(helper_buffer);
> +       return -ENOMEM;
> +}
> +
> +
remove blank line
> +static struct dma_heap_ops system_heap_ops =3D {
> +       .allocate =3D system_heap_allocate,
> +};
> +
> +static int system_heap_create(void)
> +{
> +       struct system_heap *sys_heap;
> +
> +       sys_heap =3D kzalloc(sizeof(*sys_heap), GFP_KERNEL);
> +       if (!sys_heap)
> +               return -ENOMEM;
> +       sys_heap->heap.name =3D "system_heap";
> +       sys_heap->heap.ops =3D &system_heap_ops;
> +
> +       dma_heap_add(&sys_heap->heap);
> +
> +       return 0;
> +}
> +device_initcall(system_heap_create);
> --
> 2.7.4
>


--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
