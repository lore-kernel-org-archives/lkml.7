Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BA0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5967B206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nxI9dKn2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NOGPotbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfCMUUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:20:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44182 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfCMUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:20:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F01DE60F3E; Wed, 13 Mar 2019 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552508437;
        bh=n/WH1Rw8wqoj+tLmiB3QKfQ7Ha5hclg3rlsk3cCnVrs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nxI9dKn2yKps2iqjIuCrzr+3Fnf1LR7iJLxyLCXZZTaGtc+C0lQe8eD11JGQAUpx4
         4By5zn4KYXR33/WflQMb7ylVeL4rNaW4lhqqdj8Jo/M6dTn8+WR/hO32rH5cpovt/d
         oobyfpfFrRE3yV4NcaRox9GMBgIwU1dSfToRjSI0=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C533360E7A;
        Wed, 13 Mar 2019 20:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552508436;
        bh=n/WH1Rw8wqoj+tLmiB3QKfQ7Ha5hclg3rlsk3cCnVrs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=NOGPotbjuj35gfyCGTUfKnBSkLjZgQSYDJxUch8UQIaa1yuo6F1+D7XTKpQtF8HS1
         uupEQbcphyGeKInS+A8ZhLF8ET4B/Ma1qwWCDuwTqESoL4/nfFONtiEC7zexy/U4O8
         1vv1nnWJ3MZKvbmzcUyK+honWBpIOe6Mc6ARRBvU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C533360E7A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Wed, 13 Mar 2019 13:20:35 -0700 (PDT)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     John Stultz <john.stultz@linaro.org>
cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC][PATCH 3/5 v2] dma-buf: heaps: Add system heap to dmabuf
 heaps
In-Reply-To: <1551819273-640-4-git-send-email-john.stultz@linaro.org>
Message-ID: <alpine.DEB.2.10.1903131318300.5023@lmark-linux.qualcomm.com>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org> <1551819273-640-4-git-send-email-john.stultz@linaro.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019, John Stultz wrote:

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
> ---
>  drivers/dma-buf/Kconfig             |   2 +
>  drivers/dma-buf/heaps/Kconfig       |   6 ++
>  drivers/dma-buf/heaps/Makefile      |   1 +
>  drivers/dma-buf/heaps/system_heap.c | 132 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 141 insertions(+)
>  create mode 100644 drivers/dma-buf/heaps/Kconfig
>  create mode 100644 drivers/dma-buf/heaps/system_heap.c
> 
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index 09c61db..63c139d 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -47,4 +47,6 @@ menuconfig DMABUF_HEAPS
>  	  this allows userspace to allocate dma-bufs that can be shared between
>  	  drivers.
>  
> +source "drivers/dma-buf/heaps/Kconfig"
> +
>  endmenu
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
> new file mode 100644
> index 0000000..2050527
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -0,0 +1,6 @@
> +config DMABUF_HEAPS_SYSTEM
> +	bool "DMA-BUF System Heap"
> +	depends on DMABUF_HEAPS
> +	help
> +	  Choose this option to enable the system dmabuf heap. The system heap
> +	  is backed by pages from the buddy allocator. If in doubt, say Y.
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
> index de49898..d1808ec 100644
> --- a/drivers/dma-buf/heaps/Makefile
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y					+= heap-helpers.o
> +obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
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
> +struct system_heap {
> +	struct dma_heap heap;
> +};
> +
> +
> +static void system_heap_free(struct heap_helper_buffer *buffer)
> +{
> +	int i;
> +	struct scatterlist *sg;
> +	struct sg_table *table = buffer->sg_table;
> +
> +	for_each_sg(table->sgl, sg, table->nents, i)
> +		__free_page(sg_page(sg));
> +
> +	sg_free_table(table);
> +	kfree(table);
> +	kfree(buffer);
> +}
> +
> +static int system_heap_allocate(struct dma_heap *heap,
> +				unsigned long len,
> +				unsigned long flags)
> +{
> +	struct heap_helper_buffer *helper_buffer;
> +	struct sg_table *table;
> +	struct scatterlist *sg;
> +	int i, j;
> +	int npages = PAGE_ALIGN(len) / PAGE_SIZE;
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct dma_buf *dmabuf;
> +	int ret = -ENOMEM;
> +
> +	helper_buffer = kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
> +	if (!helper_buffer)
> +		return -ENOMEM;
> +
> +	INIT_HEAP_HELPER_BUFFER(helper_buffer, system_heap_free);
> +	helper_buffer->heap_buffer.flags = flags;
> +	helper_buffer->heap_buffer.heap = heap;
> +	helper_buffer->heap_buffer.size = len;
> +
> +	table = kmalloc(sizeof(struct sg_table), GFP_KERNEL);
> +	if (!table)
> +		goto err0;
> +
> +	i = sg_alloc_table(table, npages, GFP_KERNEL);
> +	if (i)
> +		goto err1;
> +	for_each_sg(table->sgl, sg, table->nents, i) {
> +		struct page *page;
> +
> +		page = alloc_page(GFP_KERNEL);

Need to zero the allocation (add __GFP_ZERO)

> +		if (!page)
> +			goto err2;
> +		sg_set_page(sg, page, PAGE_SIZE, 0);
> +	}
> +

Can always be done later, but it may be helpful to also move this common 
code from here (and from the cma heap) to the heap helpers file as it 
reduces code but will also make it easier to introduce future debug 
features such as making the dma buf names unique
to help make it easier to track down the source of memory leaks.

> +	 /* create the dmabuf */ 
> +	 exp_info.ops = &heap_helper_ops; 
> +	exp_info.size = len;
> +	exp_info.flags = O_RDWR;
> +	exp_info.priv = &helper_buffer->heap_buffer;
> +	dmabuf = dma_buf_export(&exp_info);
> +	if (IS_ERR(dmabuf)) {
> +		ret = PTR_ERR(dmabuf);
> +		goto err2;
> +	}
> +
> +	helper_buffer->heap_buffer.dmabuf = dmabuf;
> +	helper_buffer->sg_table = table;
> +
> +	ret = dma_buf_fd(dmabuf, O_CLOEXEC);
> +	if (ret < 0) {
> +		dma_buf_put(dmabuf);
> +		/* just return, as put will call release and that will free */
> +		return ret;
> +	}
> +
> +	return ret;
> +
> +err2:
> +	for_each_sg(table->sgl, sg, i, j)
> +		__free_page(sg_page(sg));
> +	sg_free_table(table);
> +err1:
> +	kfree(table);
> +err0:
> +	kfree(helper_buffer);
> +	return -ENOMEM;
> +}
> +
> +
> +static struct dma_heap_ops system_heap_ops = {
> +	.allocate = system_heap_allocate,
> +};
> +
> +static int system_heap_create(void)
> +{
> +	struct system_heap *sys_heap;
> +
> +	sys_heap = kzalloc(sizeof(*sys_heap), GFP_KERNEL);
> +	if (!sys_heap)
> +		return -ENOMEM;
> +	sys_heap->heap.name = "system_heap";
> +	sys_heap->heap.ops = &system_heap_ops;
> +
> +	dma_heap_add(&sys_heap->heap);
> +
> +	return 0;
> +}
> +device_initcall(system_heap_create);
> -- 
> 2.7.4
> 
> 

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
