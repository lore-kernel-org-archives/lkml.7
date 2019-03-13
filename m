Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB7AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709C120693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YUFpQRHk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jaeyClFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCMUSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:18:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfCMUSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:18:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7116C60907; Wed, 13 Mar 2019 20:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552508290;
        bh=Z3VTv3Aacd6sBCpLsU9mAvSdgRtO03bZ5BTMVQudUv4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YUFpQRHkRFAK+BUlFLZBqWlqEbplo6ThWpd6qQ76YAZD2Qis78UukPrnWJDjVrChN
         LqiAkU4IqQtcLCUGZt0n+zM0JscCJpQbxr+gEQAW3vHQdpcklw0wtOTCI99qfBZ4b+
         tXT9r6PrkbMFxsmP5UYDQpWfUUJ2X109j5XTucTE=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BAD096013C;
        Wed, 13 Mar 2019 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552508287;
        bh=Z3VTv3Aacd6sBCpLsU9mAvSdgRtO03bZ5BTMVQudUv4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jaeyClFxxs0CTNsIHSaKd1cmJrEUm6OdQ9ZyfQ8z8xsxavZa90qkPD3fQuN/4sMSx
         M3qSJp/42Z9NI2wya7yaIb6FSdJx7wE2u1UJdJiXZVFpCYXeR3f6wBP5wuZVRpUDtY
         2Gh4ERmAu2+85+/N/lCm/wL/6naiKh2te2M4aoSo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAD096013C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Wed, 13 Mar 2019 13:18:06 -0700 (PDT)
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
Subject: Re: [RFC][PATCH 2/5 v2] dma-buf: heaps: Add heap helpers
In-Reply-To: <1551819273-640-3-git-send-email-john.stultz@linaro.org>
Message-ID: <alpine.DEB.2.10.1903131312270.5023@lmark-linux.qualcomm.com>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org> <1551819273-640-3-git-send-email-john.stultz@linaro.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019, John Stultz wrote:

> Add generic helper dmabuf ops for dma heaps, so we can reduce
> the amount of duplicative code for the exported dmabufs.
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
> * Removed cache management performance hack that I had
>   accidentally folded in.
> * Removed stats code that was in helpers
> * Lots of checkpatch cleanups
> ---
>  drivers/dma-buf/Makefile             |   1 +
>  drivers/dma-buf/heaps/Makefile       |   2 +
>  drivers/dma-buf/heaps/heap-helpers.c | 335 +++++++++++++++++++++++++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.h |  48 +++++
>  4 files changed, 386 insertions(+)
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
> index 0000000..ae5e9d0
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/heap-helpers.c
> @@ -0,0 +1,335 @@
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
> +
> +static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
> +{
> +	struct scatterlist *sg;
> +	int i, j;
> +	void *vaddr;
> +	pgprot_t pgprot;
> +	struct sg_table *table = buffer->sg_table;
> +	int npages = PAGE_ALIGN(buffer->heap_buffer.size) / PAGE_SIZE;
> +	struct page **pages = vmalloc(array_size(npages,
> +						 sizeof(struct page *)));
> +	struct page **tmp = pages;
> +
> +	if (!pages)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pgprot = PAGE_KERNEL;
> +
> +	for_each_sg(table->sgl, sg, table->nents, i) {
> +		int npages_this_entry = PAGE_ALIGN(sg->length) / PAGE_SIZE;
> +		struct page *page = sg_page(sg);
> +
> +		WARN_ON(i >= npages);
> +		for (j = 0; j < npages_this_entry; j++)
> +			*(tmp++) = page++;
> +	}
> +	vaddr = vmap(pages, npages, VM_MAP, pgprot);
> +	vfree(pages);
> +
> +	if (!vaddr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return vaddr;
> +}
> +
> +static int dma_heap_map_user(struct heap_helper_buffer *buffer,
> +			 struct vm_area_struct *vma)
> +{
> +	struct sg_table *table = buffer->sg_table;
> +	unsigned long addr = vma->vm_start;
> +	unsigned long offset = vma->vm_pgoff * PAGE_SIZE;
> +	struct scatterlist *sg;
> +	int i;
> +	int ret;
> +
> +	for_each_sg(table->sgl, sg, table->nents, i) {
> +		struct page *page = sg_page(sg);
> +		unsigned long remainder = vma->vm_end - addr;
> +		unsigned long len = sg->length;
> +
> +		if (offset >= sg->length) {
> +			offset -= sg->length;
> +			continue;
> +		} else if (offset) {
> +			page += offset / PAGE_SIZE;
> +			len = sg->length - offset;
> +			offset = 0;
> +		}
> +		len = min(len, remainder);
> +		ret = remap_pfn_range(vma, addr, page_to_pfn(page), len,
> +				      vma->vm_page_prot);
> +		if (ret)
> +			return ret;
> +		addr += len;
> +		if (addr >= vma->vm_end)
> +			return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +void dma_heap_buffer_destroy(struct dma_heap_buffer *heap_buffer)
> +{
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +
> +	if (buffer->kmap_cnt > 0) {
> +		pr_warn_once("%s: buffer still mapped in the kernel\n",
> +			     __func__);
> +		vunmap(buffer->vaddr);
> +	}
> +
> +	buffer->free(buffer);
> +}
> +
> +static void *dma_heap_buffer_kmap_get(struct dma_heap_buffer *heap_buffer)
> +{
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +	void *vaddr;
> +
> +	if (buffer->kmap_cnt) {
> +		buffer->kmap_cnt++;
> +		return buffer->vaddr;
> +	}
> +	vaddr = dma_heap_map_kernel(buffer);
> +	if (WARN_ONCE(!vaddr,
> +		      "heap->ops->map_kernel should return ERR_PTR on error"))
> +		return ERR_PTR(-EINVAL);
> +	if (IS_ERR(vaddr))
> +		return vaddr;
> +	buffer->vaddr = vaddr;
> +	buffer->kmap_cnt++;
> +	return vaddr;
> +}
> +
> +static void dma_heap_buffer_kmap_put(struct dma_heap_buffer *heap_buffer)
> +{
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +
> +	buffer->kmap_cnt--;
> +	if (!buffer->kmap_cnt) {
> +		vunmap(buffer->vaddr);
> +		buffer->vaddr = NULL;
> +	}
> +}
> +
> +static struct sg_table *dup_sg_table(struct sg_table *table)
> +{
> +	struct sg_table *new_table;
> +	int ret, i;
> +	struct scatterlist *sg, *new_sg;
> +
> +	new_table = kzalloc(sizeof(*new_table), GFP_KERNEL);
> +	if (!new_table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = sg_alloc_table(new_table, table->nents, GFP_KERNEL);
> +	if (ret) {
> +		kfree(new_table);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	new_sg = new_table->sgl;
> +	for_each_sg(table->sgl, sg, table->nents, i) {
> +		memcpy(new_sg, sg, sizeof(*sg));
> +		new_sg->dma_address = 0;
> +		new_sg = sg_next(new_sg);
> +	}
> +
> +	return new_table;
> +}
> +
> +static void free_duped_table(struct sg_table *table)
> +{
> +	sg_free_table(table);
> +	kfree(table);
> +}
> +
> +struct dma_heaps_attachment {
> +	struct device *dev;
> +	struct sg_table *table;
> +	struct list_head list;
> +};
> +
> +static int dma_heap_attach(struct dma_buf *dmabuf,
> +			      struct dma_buf_attachment *attachment)
> +{
> +	struct dma_heaps_attachment *a;
> +	struct sg_table *table;
> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +
> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
> +	if (!a)
> +		return -ENOMEM;
> +
> +	table = dup_sg_table(buffer->sg_table);
> +	if (IS_ERR(table)) {
> +		kfree(a);
> +		return -ENOMEM;
> +	}
> +
> +	a->table = table;
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
> +	free_duped_table(a->table);
> +
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
> +	table = a->table;
> +
> +	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
> +			direction))

Since this code is used for system heap and and as the reference.
In multimedia uses cases very large buffers can be allocated from system 
heap, and since system heap allocations have a cached kernel mapping it 
has been difficult to support uncached allocations so clients will likely 
allocate them as cached allocations.
Most access to these buffers will occur from non IO-coherent devices, 
however in frameworks such as Android these buffers will be dma mapped and 
dma unmapped frequently, for every frame and for each device in the 
"buffer pipeline", which leads to a lot of unnecessary cache maintenance 
in the dma map and dma unmap calls.
From previous discussions it doesn't seem like this could be optimized by 
only making changes to dma-buf heaps framework.

So I think it would be helpful to try and agree on what types of changes 
would be required to the Android framework and possibly the dma-buf heaps 
framework to resolve this.
Example

- Have Android framework keep buffers dma mapped for the whole use case

- Or perhaps have Android keep required devices attached to the buffer as 
they are "pipelined" so that cache maintenance can be skipped in dma map 
and dma umnap but reliably applied in begin/end_cpu_access.

> +	 table = ERR_PTR(-ENOMEM); 
> +	 return table; 
> +} 
> +
> +static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
> +			      struct sg_table *table,
> +			      enum dma_data_direction direction)
> +{
> +	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
> +}
> +
> +static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> +{
> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +	int ret = 0;
> +
> +	mutex_lock(&buffer->lock);
> +	/* now map it to userspace */
> +	ret = dma_heap_map_user(buffer, vma);

Since this code is used for system heap and and as the reference.
Currently in Android when a system heap buffer is moving down the 
"pipeline" CPU access may occur and there may be no device attached.
In the past people have raised concerns that this should perhaps not be 
supported and that at least one device should be attached when CPU access 
occurs.

Can we decide, from a dma-buf contract perspective, on whether CPU access 
without a device attached should allowed and make it clear in the dma-buf 
documentation either way?

If it should not be allowed we can try to work with Android to see how 
they can change their framework to align with the dma-buf spec.

> +	mutex_unlock(&buffer->lock);
> +
> +	if (ret)
> +		pr_err("%s: failure mapping buffer to userspace\n",
> +		       __func__);
> +
> +	return ret;
> +}
> +
> +static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
> +{
> +	struct dma_heap_buffer *buffer = dmabuf->priv;
> +
> +	dma_heap_buffer_destroy(buffer);
> +}
> +
> +static void *dma_heap_dma_buf_kmap(struct dma_buf *dmabuf,
> +					unsigned long offset)
> +{
> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +
> +	return buffer->vaddr + offset * PAGE_SIZE;
> +}
> +
> +static void dma_heap_dma_buf_kunmap(struct dma_buf *dmabuf,
> +					unsigned long offset,
> +					void *ptr)
> +{
> +}
> +
> +static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
> +					enum dma_data_direction direction)
> +{
> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
> +	void *vaddr;
> +	struct dma_heaps_attachment *a;
> +	int ret = 0;
> +
> +	mutex_lock(&buffer->lock);
> +	vaddr = dma_heap_buffer_kmap_get(heap_buffer);

Since this code is used for system heap and and as the reference.
As has been discussed in the past there are several disadvantages to 
creating a kernel mapping on each call to begin_cpu_access.

The resulting call to alloc_vmap_area is expensive and can hurt client 
KPIs

Allowing userspace clients to create and destroy kernel mappings can 
provide opportunities to crash the kernel.

Can we look at removing the creation of a kernel mapping in 
begin_cpu_access and either introduce support for dma_buf_vmap and have 
clients use that instead or perahps change 
the contract for dma_buf_kmap so that it doesn't always need to succeed?

> +	if (IS_ERR(vaddr)) {
> +		ret = PTR_ERR(vaddr);
> +		goto unlock;
> +	}
> +	mutex_unlock(&buffer->lock);
> +
> +	mutex_lock(&buffer->lock);
> +	list_for_each_entry(a, &buffer->attachments, list) {
> +		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
> +				    direction);

Since this code is used for system heap and and as the reference.
Not a major issue for newer kernels but I still don't think it makes sense 
to apply cache maintenance when the buffer is not dma mapped, it doesn't 
makes sense to me from a logical perspective and from a performance 
perspective.


> +	}
> +
> +unlock:
> +	mutex_unlock(&buffer->lock);
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
> +	dma_heap_buffer_kmap_put(heap_buffer);
> +	mutex_unlock(&buffer->lock);
> +
> +	mutex_lock(&buffer->lock);
> +	list_for_each_entry(a, &buffer->attachments, list) {
> +		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
> +				       direction);

There are use cases in Android which result in only small parts of a large 
buffer are written do during of CPU access.

Applying cache maintenance to the complete buffer results in a lot of 
unnecessary cache maintenance that can affect KPIs.

I believe the Android team is wondering if there could be a way to support 
partial maintenance in  where userspace could describe the buffer changes 
they have made.

I think it would be useful to make sure that there is a least a path 
forward with the current dma-buf heaps framework to solve this for system 
heap allocations.

I can get more details on the specific use cases if required.

> +	}
> +	mutex_unlock(&buffer->lock);
> +
> +	return 0;
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
> +	.map = dma_heap_dma_buf_kmap,
> +	.unmap = dma_heap_dma_buf_kunmap,
> +};
> diff --git a/drivers/dma-buf/heaps/heap-helpers.h b/drivers/dma-buf/heaps/heap-helpers.h
> new file mode 100644
> index 0000000..0bd8643
> --- /dev/null
> +++ b/drivers/dma-buf/heaps/heap-helpers.h
> @@ -0,0 +1,48 @@
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
> +struct heap_helper_buffer {
> +	struct dma_heap_buffer heap_buffer;
> +
> +	unsigned long private_flags;
> +	void *priv_virt;
> +	struct mutex lock;
> +	int kmap_cnt;
> +	void *vaddr;
> +	struct sg_table *sg_table;
> +	struct list_head attachments;
> +
> +	void (*free)(struct heap_helper_buffer *buffer);
> +
> +};
> +
> +#define to_helper_buffer(x) \
> +	container_of(x, struct heap_helper_buffer, heap_buffer)
> +
> +static inline void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
> +				 void (*free)(struct heap_helper_buffer *))
> +{
> +	buffer->private_flags = 0;
> +	buffer->priv_virt = NULL;
> +	mutex_init(&buffer->lock);
> +	buffer->kmap_cnt = 0;
> +	buffer->vaddr = NULL;
> +	buffer->sg_table = NULL;
> +	INIT_LIST_HEAD(&buffer->attachments);
> +	buffer->free = free;
> +}
> +
> +extern const struct dma_buf_ops heap_helper_ops;
> +
> +#endif /* _HEAP_HELPERS_H */
> -- 
> 2.7.4
> 
> 

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
