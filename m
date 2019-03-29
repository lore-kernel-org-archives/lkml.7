Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC40C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035E62173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fw+dibfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfC2OZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:25:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37658 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfC2OZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:25:40 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TEOrkn103526;
        Fri, 29 Mar 2019 09:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553869493;
        bh=6Q1n7cbcfTfr3LJYlCSDD4CRPzEj7OEmzcyuQvKyugk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fw+dibfH28QRPfiavM8ybUI8LinISG70zWqWxfSkQki8ThJgJP/A8MsZn5o+rngnu
         GRRdsD8ExV4/amRbSgArhQucy2Jq01vUNkDdykcUOZpNd4WMc/MWGgII1aOyzbD7pl
         yVRo8MPBkanWiV2WMGOS78LM3B3p0JEEPsyZG2rA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TEOrJl120944
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 09:24:53 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 09:24:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 09:24:52 -0500
Received: from [10.250.67.168] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TEOpgn112073;
        Fri, 29 Mar 2019 09:24:51 -0500
Subject: Re: [RFC][PATCH 2/6 v3] dma-buf: heaps: Add heap helpers
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
CC:     Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
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
        <dri-devel@lists.freedesktop.org>
References: <1553818562-2516-1-git-send-email-john.stultz@linaro.org>
 <1553818562-2516-3-git-send-email-john.stultz@linaro.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <e362e9d5-e4a5-bd67-6d71-9f6b2b80b5bc@ti.com>
Date:   Fri, 29 Mar 2019 09:24:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553818562-2516-3-git-send-email-john.stultz@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 7:15 PM, John Stultz wrote:
> Add generic helper dmabuf ops for dma heaps, so we can reduce
> the amount of duplicative code for the exported dmabufs.
> 
> This code is an evolution of the Android ION implementation, so
> thanks to its original authors and maintainters:
>   Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!
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
> * Removed cache management performance hack that I had
>   accidentally folded in.
> * Removed stats code that was in helpers
> * Lots of checkpatch cleanups
> 
> v3:
> * Uninline INIT_HEAP_HELPER_BUFFER (suggested by Christoph)
> * Switch to WARN on buffer destroy failure (suggested by Brian)
> * buffer->kmap_cnt decrementing cleanup (suggested by Christoph)
> * Extra buffer->vaddr checking in dma_heap_dma_buf_kmap
>   (suggested by Brian)
> * Switch to_helper_buffer from macro to inline function
>   (suggested by Benjamin)
> * Rename kmap->vmap (folded in from Andrew)
> * Use vmap for vmapping - not begin_cpu_access (folded in from
>   Andrew)
> * Drop kmap for now, as its optional (folded in from Andrew)
> * Fold dma_heap_map_user into the single caller (foled in from
>   Andrew)
> * Folded in patch from Andrew to track page list per heap not
>   sglist, which simplifies the tracking logic
> ---
>  drivers/dma-buf/Makefile             |   1 +
>  drivers/dma-buf/heaps/Makefile       |   2 +
>  drivers/dma-buf/heaps/heap-helpers.c | 261 +++++++++++++++++++++++++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.h |  55 ++++++++
>  include/linux/dma-heap.h             |  14 +-
>  5 files changed, 320 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/dma-buf/heaps/Makefile
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
> 
> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
> index b0332f1..09c2f2d 100644
> --- a/drivers/dma-buf/Makefile
> +++ b/drivers/dma-buf/Makefile
> @@ -1,4 +1,5 @@
>  obj-y := dma-buf.o dma-fence.o dma-fence-array.o reservation.o seqno-fence.o
> +obj-$(CONFIG_DMABUF_HEAPS)	+= heaps/
>  obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
>  obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
>  obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
> new file mode 100644
> index 0000000..de49898
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y					+= heap-helpers.o
> diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
> new file mode 100644
> index 0000000..00cbdbb
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/heap-helpers.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/device.h>
> +#include <linux/dma-buf.h>
> +#include <linux/err.h>
> +#include <linux/idr.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <uapi/linux/dma-heap.h>
> +
> +#include "heap-helpers.h"
> +
> +void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
> +			     void (*free)(struct heap_helper_buffer *))
> +{
> +	buffer->private_flags = 0;
> +	buffer->priv_virt = NULL;
> +	mutex_init(&buffer->lock);
> +	buffer->vmap_cnt = 0;
> +	buffer->vaddr = NULL;
> +	INIT_LIST_HEAD(&buffer->attachments);
> +	buffer->free = free;
> +}
> +
> +
> +static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
> +{
> +	void *vaddr;
> +
> +	vaddr = vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KERNEL);
> +	if (!vaddr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return vaddr;
> +}
> +
> +void dma_heap_buffer_destroy(struct dma_heap_buffer *heap_buffer)
> +{
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +
> +	if (buffer->vmap_cnt > 0) {
> +		WARN("%s: buffer still mapped in the kernel\n",
> +			     __func__);
> +		vunmap(buffer->vaddr);
> +	}
> +
> +	buffer->free(buffer);
> +}
> +
> +static void *dma_heap_buffer_vmap_get(struct dma_heap_buffer *heap_buffer)
> +{
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +	void *vaddr;
> +
> +	if (buffer->vmap_cnt) {
> +		buffer->vmap_cnt++;
> +		return buffer->vaddr;
> +	}
> +	vaddr = dma_heap_map_kernel(buffer);
> +	if (WARN_ONCE(!vaddr,
> +		      "heap->ops->map_kernel should return ERR_PTR on error"))
> +		return ERR_PTR(-EINVAL);
> +	if (IS_ERR(vaddr))
> +		return vaddr;
> +	buffer->vaddr = vaddr;
> +	buffer->vmap_cnt++;
> +	return vaddr;
> +}
> +
> +static void dma_heap_buffer_vmap_put(struct dma_heap_buffer *heap_buffer)
> +{
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +
> +	if (!--buffer->vmap_cnt) {
> +		vunmap(buffer->vaddr);
> +		buffer->vaddr = NULL;
> +	}
> +}
> +
> +struct dma_heaps_attachment {
> +	struct device *dev;
> +	struct sg_table table;
> +	struct list_head list;
> +};
> +
> +static int dma_heap_attach(struct dma_buf *dmabuf,
> +			      struct dma_buf_attachment *attachment)
> +{
> +	struct dma_heaps_attachment *a;
> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +	int ret;
> +
> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
> +	if (!a)
> +		return -ENOMEM;
> +
> +	ret = sg_alloc_table_from_pages(&a->table, buffer->pages,
> +					buffer->pagecount, 0,
> +					buffer->pagecount << PAGE_SHIFT,
> +					GFP_KERNEL);
> +	if (ret) {
> +		kfree(a);
> +		return ret;
> +	}
> +
> +	a->dev = attachment->dev;
> +	INIT_LIST_HEAD(&a->list);
> +
> +	attachment->priv = a;
> +
> +	mutex_lock(&buffer->lock);
> +	list_add(&a->list, &buffer->attachments);
> +	mutex_unlock(&buffer->lock);
> +
> +	return 0;
> +}
> +
> +static void dma_heap_detatch(struct dma_buf *dmabuf,
> +				struct dma_buf_attachment *attachment)
> +{
> +	struct dma_heaps_attachment *a = attachment->priv;
> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +
> +	mutex_lock(&buffer->lock);
> +	list_del(&a->list);
> +	mutex_unlock(&buffer->lock);
> +
> +	sg_free_table(&a->table);
> +	kfree(a);
> +}
> +
> +static struct sg_table *dma_heap_map_dma_buf(
> +					struct dma_buf_attachment *attachment,
> +					enum dma_data_direction direction)
> +{
> +	struct dma_heaps_attachment *a = attachment->priv;
> +	struct sg_table *table;
> +
> +	table = &a->table;
> +
> +	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> +			direction))
> +		table = ERR_PTR(-ENOMEM);
> +	return table;
> +}
> +
> +static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
> +			      struct sg_table *table,
> +			      enum dma_data_direction direction)
> +{
> +	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> +}
> +
> +static vm_fault_t dma_heap_vm_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct heap_helper_buffer *buffer = vma->vm_private_data;
> +
> +	vmf->page = buffer->pages[vmf->pgoff];
> +	get_page(vmf->page);
> +
> +	return 0;
> +}
> +
> +static const struct vm_operations_struct dma_heap_vm_ops = {
> +	.fault = dma_heap_vm_fault,
> +};
> +
> +static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> +{
> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +
> +	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> +		return -EINVAL;
> +
> +	vma->vm_ops = &dma_heap_vm_ops;
> +	vma->vm_private_data = buffer;
> +
> +	return 0;
> +}
> +
> +static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
> +{
> +	struct dma_heap_buffer *buffer = dmabuf->priv;
> +
> +	dma_heap_buffer_destroy(buffer);
> +}
> +
> +static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
> +					enum dma_data_direction direction)
> +{
> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +	struct dma_heaps_attachment *a;
> +	int ret = 0;
> +
> +	mutex_lock(&buffer->lock);
> +	list_for_each_entry(a, &buffer->attachments, list) {
> +		dma_sync_sg_for_cpu(a->dev, a->table.sgl, a->table.nents,
> +				    direction);
> +	}
> +	mutex_unlock(&buffer->lock);
> +
> +	return ret;
> +}
> +
> +static int dma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
> +				      enum dma_data_direction direction)
> +{
> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +	struct dma_heaps_attachment *a;
> +
> +	mutex_lock(&buffer->lock);
> +	list_for_each_entry(a, &buffer->attachments, list) {
> +		dma_sync_sg_for_device(a->dev, a->table.sgl, a->table.nents,
> +				       direction);
> +	}
> +	mutex_unlock(&buffer->lock);
> +
> +	return 0;
> +}
> +
> +void *dma_heap_dma_buf_vmap(struct dma_buf *dmabuf)
> +{
> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +	void *vaddr;
> +
> +	mutex_lock(&buffer->lock);
> +	vaddr = dma_heap_buffer_vmap_get(heap_buffer);
> +	mutex_unlock(&buffer->lock);
> +
> +	return vaddr;
> +}
> +
> +void dma_heap_dma_buf_vunmap(struct dma_buf *dmabuf, void *vaddr)
> +{
> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +
> +	mutex_lock(&buffer->lock);
> +	dma_heap_buffer_vmap_put(heap_buffer);
> +	mutex_unlock(&buffer->lock);
> +}
> +
> +const struct dma_buf_ops heap_helper_ops = {
> +	.map_dma_buf = dma_heap_map_dma_buf,
> +	.unmap_dma_buf = dma_heap_unmap_dma_buf,
> +	.mmap = dma_heap_mmap,
> +	.release = dma_heap_dma_buf_release,
> +	.attach = dma_heap_attach,
> +	.detach = dma_heap_detatch,
> +	.begin_cpu_access = dma_heap_dma_buf_begin_cpu_access,
> +	.end_cpu_access = dma_heap_dma_buf_end_cpu_access,
> +	.vmap = dma_heap_dma_buf_vmap,
> +	.vunmap = dma_heap_dma_buf_vunmap,
> +};
> diff --git a/drivers/dma-buf/heaps/heap-helpers.h b/drivers/dma-buf/heaps/heap-helpers.h
> new file mode 100644
> index 0000000..a17502d
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/heap-helpers.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DMABUF Heaps helper code
> + *
> + * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#ifndef _HEAP_HELPERS_H
> +#define _HEAP_HELPERS_H
> +
> +#include <linux/dma-heap.h>
> +#include <linux/list.h>
> +
> +/**
> + * struct dma_heap_buffer - metadata for a particular buffer
> + * @heap:		back pointer to the heap the buffer came from
> + * @dmabuf:		backing dma-buf for this buffer
> + * @size:		size of the buffer
> + * @flags:		buffer specific flags
> + */
> +struct dma_heap_buffer {
> +	struct dma_heap *heap;
> +	struct dma_buf *dmabuf;
> +	size_t size;
> +	unsigned long flags;
> +};
> +
> +struct heap_helper_buffer {
> +	struct dma_heap_buffer heap_buffer;
> +
> +	unsigned long private_flags;
> +	void *priv_virt;
> +	struct mutex lock;
> +	int vmap_cnt;
> +	void *vaddr;
> +	pgoff_t pagecount;
> +	struct page **pages;
> +	struct list_head attachments;
> +
> +	void (*free)(struct heap_helper_buffer *buffer);
> +
> +};
> +
> +static inline struct heap_helper_buffer *to_helper_buffer(
> +						struct dma_heap_buffer *h)
> +{
> +	return container_of(h, struct heap_helper_buffer, heap_buffer);
> +}
> +
> +void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
> +				 void (*free)(struct heap_helper_buffer *));
> +extern const struct dma_buf_ops heap_helper_ops;
> +
> +#endif /* _HEAP_HELPERS_H */
> diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
> index d7bf624..d17b839 100644
> --- a/include/linux/dma-heap.h
> +++ b/include/linux/dma-heap.h
> @@ -12,19 +12,7 @@
>  #include <linux/cdev.h>
>  #include <linux/types.h>
>  
> -/**
> - * struct dma_heap_buffer - metadata for a particular buffer
> - * @heap:		back pointer to the heap the buffer came from
> - * @dmabuf:		backing dma-buf for this buffer
> - * @size:		size of the buffer
> - * @flags:		buffer specific flags
> - */
> -struct dma_heap_buffer {
> -	struct dma_heap *heap;
> -	struct dma_buf *dmabuf;
> -	size_t size;
> -	unsigned long flags;
> -};
> +struct dma_heap;
>  

This change can get squashed into the first patch.

Andrew

>  /**
>   * struct dma_heap_ops - ops to operate on a given heap
> 
