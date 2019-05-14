Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F60C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CC120879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 10:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfENKkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 06:40:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42768 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfENKkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 06:40:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A749EA890B1BACCFAA64;
        Tue, 14 May 2019 18:40:08 +0800 (CST)
Received: from [127.0.0.1] (10.151.21.212) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 May 2019
 18:39:58 +0800
Subject: Re: [RFC][PATCH 4/5 v4] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Liam Mark" <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        "Brian Starkey" <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>, Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        <dri-devel@lists.freedesktop.org>,
        "Liuyi (Daniel)" <daniel.liuyi@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>
References: <20190513183727.15755-1-john.stultz@linaro.org>
 <20190513183727.15755-5-john.stultz@linaro.org>
From:   "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Message-ID: <0333e2b3-0e3d-360e-c8ac-62f3235d24be@hisilicon.com>
Date:   Tue, 14 May 2019 18:39:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190513183727.15755-5-john.stultz@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.21.212]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/5/14 2:37, John Stultz wrote:
> This adds a CMA heap, which allows userspace to allocate
> a dma-buf of contiguous memory out of a CMA region.
> 
> This code is an evolution of the Android ION implementation, so
> thanks to its original author and maintainters:
>    Benjamin Gaignard, Laura Abbott, and others!
> 
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Xu YiPing <xuyiping@hisilicon.com>
> Cc: "Chenfeng (puck)" <puck.chen@hisilicon.com>
> Cc: butao <butao@hisilicon.com>
> Cc: "Xiaqing (A)" <saberlily.xia@hisilicon.com>
> Cc: Yudongbin <yudongbin@hisilicon.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Switch allocate to return dmabuf fd
> * Simplify init code
> * Checkpatch fixups
> v3:
> * Switch to inline function for to_cma_heap()
> * Minor cleanups suggested by Brian
> * Fold in new registration style from Andrew
> * Folded in changes from Andrew to use simplified page list
>    from the heap helpers
> * Use the fd_flags when creating dmabuf fd (Suggested by
>    Benjamin)
> * Use precalculated pagecount (Suggested by Andrew)
> ---
>   drivers/dma-buf/heaps/Kconfig    |   8 ++
>   drivers/dma-buf/heaps/Makefile   |   1 +
>   drivers/dma-buf/heaps/cma_heap.c | 169 +++++++++++++++++++++++++++++++
>   3 files changed, 178 insertions(+)
>   create mode 100644 drivers/dma-buf/heaps/cma_heap.c
> 
> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
> index 205052744169..a5eef06c4226 100644
> --- a/drivers/dma-buf/heaps/Kconfig
> +++ b/drivers/dma-buf/heaps/Kconfig
> @@ -4,3 +4,11 @@ config DMABUF_HEAPS_SYSTEM
>   	help
>   	  Choose this option to enable the system dmabuf heap. The system heap
>   	  is backed by pages from the buddy allocator. If in doubt, say Y.
> +
> +config DMABUF_HEAPS_CMA
> +	bool "DMA-BUF CMA Heap"
> +	depends on DMABUF_HEAPS && DMA_CMA
> +	help
> +	  Choose this option to enable dma-buf CMA heap. This heap is backed
> +	  by the Contiguous Memory Allocator (CMA). If your system has these
> +	  regions, you should say Y here.
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
> index d1808eca2581..6e54cdec3da0 100644
> --- a/drivers/dma-buf/heaps/Makefile
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-y					+= heap-helpers.o
>   obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
> +obj-$(CONFIG_DMABUF_HEAPS_CMA)		+= cma_heap.o
> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
> new file mode 100644
> index 000000000000..3d0ffbbd0a34
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -0,0 +1,169 @@
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
> +	struct dma_heap *heap;
> +	struct cma *cma;
> +};
> +
> +static void cma_heap_free(struct heap_helper_buffer *buffer)
> +{
> +	struct cma_heap *cma_heap = dma_heap_get_data(buffer->heap_buffer.heap);
> +	unsigned long nr_pages = buffer->pagecount;
> +	struct page *pages = buffer->priv_virt;
> +
> +	/* free page list */
> +	kfree(buffer->pages);
> +	/* release memory */
> +	cma_release(cma_heap->cma, pages, nr_pages);
> +	kfree(buffer);
> +}
> +
> +/* dmabuf heap CMA operations functions */
> +static int cma_heap_allocate(struct dma_heap *heap,
> +				unsigned long len,
> +				unsigned long fd_flags,
> +				unsigned long heap_flags)
> +{
> +	struct cma_heap *cma_heap = dma_heap_get_data(heap);
> +	struct heap_helper_buffer *helper_buffer;
> +	struct page *pages;
> +	size_t size = PAGE_ALIGN(len);
> +	unsigned long nr_pages = size >> PAGE_SHIFT;
> +	unsigned long align = get_order(size);
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct dma_buf *dmabuf;
> +	int ret = -ENOMEM;
> +	pgoff_t pg;
> +
> +	if (align > CONFIG_CMA_ALIGNMENT)
> +		align = CONFIG_CMA_ALIGNMENT;
> +
> +	helper_buffer = kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
> +	if (!helper_buffer)
> +		return -ENOMEM;
> +
> +	INIT_HEAP_HELPER_BUFFER(helper_buffer, cma_heap_free);
> +	helper_buffer->heap_buffer.flags = heap_flags;
> +	helper_buffer->heap_buffer.heap = heap;
> +	helper_buffer->heap_buffer.size = len;
> +
> +	pages = cma_alloc(cma_heap->cma, nr_pages, align, false);
> +	if (!pages)
> +		goto free_buf;
> +
> +	if (PageHighMem(pages)) {
> +		unsigned long nr_clear_pages = nr_pages;
> +		struct page *page = pages;
> +
> +		while (nr_clear_pages > 0) {
> +			void *vaddr = kmap_atomic(page);
> +
> +			memset(vaddr, 0, PAGE_SIZE);
> +			kunmap_atomic(vaddr);
> +			page++;
> +			nr_clear_pages--;
> +		}
> +	} else {
> +		memset(page_address(pages), 0, size);
> +	}
> +
> +	helper_buffer->pagecount = nr_pages;
> +	helper_buffer->pages = kmalloc_array(helper_buffer->pagecount,
> +					     sizeof(*helper_buffer->pages),
> +					     GFP_KERNEL);
> +	if (!helper_buffer->pages) {
> +		ret = -ENOMEM;
> +		goto free_cma;
> +	}
> +
> +	for (pg = 0; pg < helper_buffer->pagecount; pg++) {
> +		helper_buffer->pages[pg] = &pages[pg];
> +		if (!helper_buffer->pages[pg])
> +			goto free_pages;
> +	}
> +
> +	/* create the dmabuf */
> +	exp_info.ops = &heap_helper_ops;
> +	exp_info.size = len;
> +	exp_info.flags = fd_flags;
> +	exp_info.priv = &helper_buffer->heap_buffer;
> +	dmabuf = dma_buf_export(&exp_info);
> +	if (IS_ERR(dmabuf)) {
> +		ret = PTR_ERR(dmabuf);
> +		goto free_pages;
> +	}
Can the dmabuf be created in the framework layer?
each heap needs to add the same code here, which is not very good.

> +
> +	helper_buffer->heap_buffer.dmabuf = dmabuf;
> +	helper_buffer->priv_virt = pages;
> +
> +	ret = dma_buf_fd(dmabuf, fd_flags);
> +	if (ret < 0) {
> +		dma_buf_put(dmabuf);
> +		/* just return, as put will call release and that will free */
> +		return ret;
> +	}
> +
> +	return ret;
> +
> +free_pages:
> +	kfree(helper_buffer->pages);
> +free_cma:
> +	cma_release(cma_heap->cma, pages, nr_pages);
> +free_buf:
> +	kfree(helper_buffer);
> +	return ret;
> +}
> +
> +static struct dma_heap_ops cma_heap_ops = {
> +	.allocate = cma_heap_allocate,
> +};
> +
> +static int __add_cma_heap(struct cma *cma, void *data)
> +{
> +	struct cma_heap *cma_heap;
> +	struct dma_heap_export_info exp_info;
> +
> +	cma_heap = kzalloc(sizeof(*cma_heap), GFP_KERNEL);
> +	if (!cma_heap)
> +		return -ENOMEM;
> +	cma_heap->cma = cma;
> +
> +	exp_info.name = cma_get_name(cma);
> +	exp_info.ops = &cma_heap_ops;
> +	exp_info.priv = cma_heap;
> +
> +	cma_heap->heap = dma_heap_add(&exp_info);
> +	if (IS_ERR(cma_heap->heap)) {
> +		int ret = PTR_ERR(cma_heap->heap);
> +
> +		kfree(cma_heap);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int add_cma_heaps(void)
> +{
> +	cma_for_each_area(__add_cma_heap, NULL);
> +	return 0;
> +}
> +device_initcall(add_cma_heaps);
> 

