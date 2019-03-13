Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23DCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C78921019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LyfS7Ife"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfCMXmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:42:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37536 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfCMXmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:42:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2DNg0Zh013966;
        Wed, 13 Mar 2019 18:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552520520;
        bh=wHQr9yRKgQ+y6VdcXJbHwETI5EWoa+ytqJhrrR2lL1k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=LyfS7IfeEMdlzVCdt47FA/KyFTO0mBvIYatYKvxsGAtALNKLVZwXFwNnfkF0s2gtk
         in+06sct+dooNXwlveArVHFCUuGh2ywBleh+hq/zggYhXVhWEVErB6z8YH4NglPprU
         yTyNwtpW6FdrzaFKCgG3W0/nBJKl495xPtoqXG60=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2DNg032049768
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Mar 2019 18:42:00 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 13
 Mar 2019 18:42:00 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Mar 2019 18:42:00 -0500
Received: from [128.247.58.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2DNg0Iw003808;
        Wed, 13 Mar 2019 18:42:00 -0500
Subject: Re: [RFC][PATCH 2/5 v2] dma-buf: heaps: Add heap helpers
To:     Liam Mark <lmark@codeaurora.org>
CC:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        <dri-devel@lists.freedesktop.org>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-3-git-send-email-john.stultz@linaro.org>
 <alpine.DEB.2.10.1903131312270.5023@lmark-linux.qualcomm.com>
 <f0575850-39a2-ce26-e5f5-0f183be3b347@ti.com>
 <alpine.DEB.2.10.1903131540190.32572@lmark-linux.qualcomm.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <e45f150f-bb0f-48d6-b4bb-0cf28062abe6@ti.com>
Date:   Wed, 13 Mar 2019 18:42:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1903131540190.32572@lmark-linux.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/19 5:57 PM, Liam Mark wrote:
> On Wed, 13 Mar 2019, Andrew F. Davis wrote:
> 
>> On 3/13/19 3:18 PM, Liam Mark wrote:
>>> On Tue, 5 Mar 2019, John Stultz wrote:
>>>
>>>> Add generic helper dmabuf ops for dma heaps, so we can reduce
>>>> the amount of duplicative code for the exported dmabufs.
>>>>
>>>> This code is an evolution of the Android ION implementation, so
>>>> thanks to its original authors and maintainters:
>>>>   Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!
>>>>
>>>> Cc: Laura Abbott <labbott@redhat.com>
>>>> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>>> Cc: Greg KH <gregkh@linuxfoundation.org>
>>>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
>>>> Cc: Liam Mark <lmark@codeaurora.org>
>>>> Cc: Brian Starkey <Brian.Starkey@arm.com>
>>>> Cc: Andrew F. Davis <afd@ti.com>
>>>> Cc: Chenbo Feng <fengc@google.com>
>>>> Cc: Alistair Strachan <astrachan@google.com>
>>>> Cc: dri-devel@lists.freedesktop.org
>>>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>>>> ---
>>>> v2:
>>>> * Removed cache management performance hack that I had
>>>>   accidentally folded in.
>>>> * Removed stats code that was in helpers
>>>> * Lots of checkpatch cleanups
>>>> ---
>>>>  drivers/dma-buf/Makefile             |   1 +
>>>>  drivers/dma-buf/heaps/Makefile       |   2 +
>>>>  drivers/dma-buf/heaps/heap-helpers.c | 335 +++++++++++++++++++++++++++++++++++
>>>>  drivers/dma-buf/heaps/heap-helpers.h |  48 +++++
>>>>  4 files changed, 386 insertions(+)
>>>>  create mode 100644 drivers/dma-buf/heaps/Makefile
>>>>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>>>>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
>>>>
>>>> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
>>>> index b0332f1..09c2f2d 100644
>>>> --- a/drivers/dma-buf/Makefile
>>>> +++ b/drivers/dma-buf/Makefile
>>>> @@ -1,4 +1,5 @@
>>>>  obj-y := dma-buf.o dma-fence.o dma-fence-array.o reservation.o seqno-fence.o
>>>> +obj-$(CONFIG_DMABUF_HEAPS)	+= heaps/
>>>>  obj-$(CONFIG_DMABUF_HEAPS)	+= dma-heap.o
>>>>  obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
>>>>  obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
>>>> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
>>>> new file mode 100644
>>>> index 0000000..de49898
>>>> --- /dev/null
>>>> +++ b/drivers/dma-buf/heaps/Makefile
>>>> @@ -0,0 +1,2 @@
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +obj-y					+= heap-helpers.o
>>>> diff --git a/drivers/dma-buf/heaps/heap-helpers.c b/drivers/dma-buf/heaps/heap-helpers.c
>>>> new file mode 100644
>>>> index 0000000..ae5e9d0
>>>> --- /dev/null
>>>> +++ b/drivers/dma-buf/heaps/heap-helpers.c
>>>> @@ -0,0 +1,335 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +#include <linux/device.h>
>>>> +#include <linux/dma-buf.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/idr.h>
>>>> +#include <linux/list.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/uaccess.h>
>>>> +#include <uapi/linux/dma-heap.h>
>>>> +
>>>> +#include "heap-helpers.h"
>>>> +
>>>> +
>>>> +static void *dma_heap_map_kernel(struct heap_helper_buffer *buffer)
>>>> +{
>>>> +	struct scatterlist *sg;
>>>> +	int i, j;
>>>> +	void *vaddr;
>>>> +	pgprot_t pgprot;
>>>> +	struct sg_table *table = buffer->sg_table;
>>>> +	int npages = PAGE_ALIGN(buffer->heap_buffer.size) / PAGE_SIZE;
>>>> +	struct page **pages = vmalloc(array_size(npages,
>>>> +						 sizeof(struct page *)));
>>>> +	struct page **tmp = pages;
>>>> +
>>>> +	if (!pages)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	pgprot = PAGE_KERNEL;
>>>> +
>>>> +	for_each_sg(table->sgl, sg, table->nents, i) {
>>>> +		int npages_this_entry = PAGE_ALIGN(sg->length) / PAGE_SIZE;
>>>> +		struct page *page = sg_page(sg);
>>>> +
>>>> +		WARN_ON(i >= npages);
>>>> +		for (j = 0; j < npages_this_entry; j++)
>>>> +			*(tmp++) = page++;
>>>> +	}
>>>> +	vaddr = vmap(pages, npages, VM_MAP, pgprot);
>>>> +	vfree(pages);
>>>> +
>>>> +	if (!vaddr)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	return vaddr;
>>>> +}
>>>> +
>>>> +static int dma_heap_map_user(struct heap_helper_buffer *buffer,
>>>> +			 struct vm_area_struct *vma)
>>>> +{
>>>> +	struct sg_table *table = buffer->sg_table;
>>>> +	unsigned long addr = vma->vm_start;
>>>> +	unsigned long offset = vma->vm_pgoff * PAGE_SIZE;
>>>> +	struct scatterlist *sg;
>>>> +	int i;
>>>> +	int ret;
>>>> +
>>>> +	for_each_sg(table->sgl, sg, table->nents, i) {
>>>> +		struct page *page = sg_page(sg);
>>>> +		unsigned long remainder = vma->vm_end - addr;
>>>> +		unsigned long len = sg->length;
>>>> +
>>>> +		if (offset >= sg->length) {
>>>> +			offset -= sg->length;
>>>> +			continue;
>>>> +		} else if (offset) {
>>>> +			page += offset / PAGE_SIZE;
>>>> +			len = sg->length - offset;
>>>> +			offset = 0;
>>>> +		}
>>>> +		len = min(len, remainder);
>>>> +		ret = remap_pfn_range(vma, addr, page_to_pfn(page), len,
>>>> +				      vma->vm_page_prot);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +		addr += len;
>>>> +		if (addr >= vma->vm_end)
>>>> +			return 0;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +
>>>> +void dma_heap_buffer_destroy(struct dma_heap_buffer *heap_buffer)
>>>> +{
>>>> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
>>>> +
>>>> +	if (buffer->kmap_cnt > 0) {
>>>> +		pr_warn_once("%s: buffer still mapped in the kernel\n",
>>>> +			     __func__);
>>>> +		vunmap(buffer->vaddr);
>>>> +	}
>>>> +
>>>> +	buffer->free(buffer);
>>>> +}
>>>> +
>>>> +static void *dma_heap_buffer_kmap_get(struct dma_heap_buffer *heap_buffer)
>>>> +{
>>>> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
>>>> +	void *vaddr;
>>>> +
>>>> +	if (buffer->kmap_cnt) {
>>>> +		buffer->kmap_cnt++;
>>>> +		return buffer->vaddr;
>>>> +	}
>>>> +	vaddr = dma_heap_map_kernel(buffer);
>>>> +	if (WARN_ONCE(!vaddr,
>>>> +		      "heap->ops->map_kernel should return ERR_PTR on error"))
>>>> +		return ERR_PTR(-EINVAL);
>>>> +	if (IS_ERR(vaddr))
>>>> +		return vaddr;
>>>> +	buffer->vaddr = vaddr;
>>>> +	buffer->kmap_cnt++;
>>>> +	return vaddr;
>>>> +}
>>>> +
>>>> +static void dma_heap_buffer_kmap_put(struct dma_heap_buffer *heap_buffer)
>>>> +{
>>>> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
>>>> +
>>>> +	buffer->kmap_cnt--;
>>>> +	if (!buffer->kmap_cnt) {
>>>> +		vunmap(buffer->vaddr);
>>>> +		buffer->vaddr = NULL;
>>>> +	}
>>>> +}
>>>> +
>>>> +static struct sg_table *dup_sg_table(struct sg_table *table)
>>>> +{
>>>> +	struct sg_table *new_table;
>>>> +	int ret, i;
>>>> +	struct scatterlist *sg, *new_sg;
>>>> +
>>>> +	new_table = kzalloc(sizeof(*new_table), GFP_KERNEL);
>>>> +	if (!new_table)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	ret = sg_alloc_table(new_table, table->nents, GFP_KERNEL);
>>>> +	if (ret) {
>>>> +		kfree(new_table);
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +	}
>>>> +
>>>> +	new_sg = new_table->sgl;
>>>> +	for_each_sg(table->sgl, sg, table->nents, i) {
>>>> +		memcpy(new_sg, sg, sizeof(*sg));
>>>> +		new_sg->dma_address = 0;
>>>> +		new_sg = sg_next(new_sg);
>>>> +	}
>>>> +
>>>> +	return new_table;
>>>> +}
>>>> +
>>>> +static void free_duped_table(struct sg_table *table)
>>>> +{
>>>> +	sg_free_table(table);
>>>> +	kfree(table);
>>>> +}
>>>> +
>>>> +struct dma_heaps_attachment {
>>>> +	struct device *dev;
>>>> +	struct sg_table *table;
>>>> +	struct list_head list;
>>>> +};
>>>> +
>>>> +static int dma_heap_attach(struct dma_buf *dmabuf,
>>>> +			      struct dma_buf_attachment *attachment)
>>>> +{
>>>> +	struct dma_heaps_attachment *a;
>>>> +	struct sg_table *table;
>>>> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
>>>> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
>>>> +
>>>> +	a = kzalloc(sizeof(*a), GFP_KERNEL);
>>>> +	if (!a)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	table = dup_sg_table(buffer->sg_table);
>>>> +	if (IS_ERR(table)) {
>>>> +		kfree(a);
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	a->table = table;
>>>> +	a->dev = attachment->dev;
>>>> +	INIT_LIST_HEAD(&a->list);
>>>> +
>>>> +	attachment->priv = a;
>>>> +
>>>> +	mutex_lock(&buffer->lock);
>>>> +	list_add(&a->list, &buffer->attachments);
>>>> +	mutex_unlock(&buffer->lock);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void dma_heap_detatch(struct dma_buf *dmabuf,
>>>> +				struct dma_buf_attachment *attachment)
>>>> +{
>>>> +	struct dma_heaps_attachment *a = attachment->priv;
>>>> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
>>>> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
>>>> +
>>>> +	mutex_lock(&buffer->lock);
>>>> +	list_del(&a->list);
>>>> +	mutex_unlock(&buffer->lock);
>>>> +	free_duped_table(a->table);
>>>> +
>>>> +	kfree(a);
>>>> +}
>>>> +
>>>> +static struct sg_table *dma_heap_map_dma_buf(
>>>> +					struct dma_buf_attachment *attachment,
>>>> +					enum dma_data_direction direction)
>>>> +{
>>>> +	struct dma_heaps_attachment *a = attachment->priv;
>>>> +	struct sg_table *table;
>>>> +
>>>> +	table = a->table;
>>>> +
>>>> +	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
>>>> +			direction))
>>>
>>> Since this code is used for system heap and and as the reference.
>>> In multimedia uses cases very large buffers can be allocated from system 
>>> heap, and since system heap allocations have a cached kernel mapping it 
>>> has been difficult to support uncached allocations so clients will likely 
>>> allocate them as cached allocations.
>>> Most access to these buffers will occur from non IO-coherent devices, 
>>> however in frameworks such as Android these buffers will be dma mapped and 
>>> dma unmapped frequently, for every frame and for each device in the 
>>> "buffer pipeline", which leads to a lot of unnecessary cache maintenance 
>>> in the dma map and dma unmap calls.
>>> From previous discussions it doesn't seem like this could be optimized by 
>>> only making changes to dma-buf heaps framework.
>>>
>>> So I think it would be helpful to try and agree on what types of changes 
>>> would be required to the Android framework and possibly the dma-buf heaps 
>>> framework to resolve this.
>>> Example
>>>
>>> - Have Android framework keep buffers dma mapped for the whole use case
>>>
>>> - Or perhaps have Android keep required devices attached to the buffer as 
>>> they are "pipelined" so that cache maintenance can be skipped in dma map 
>>> and dma umnap but reliably applied in begin/end_cpu_access.
>>>
>>
>> I don't have a strong opinion on the solution here for Android, but from
>> kernel/hardware side I can see we don't have a good ownership model for
>> dma-buf and that looks to be causing your unneeded cache ops.
>>
>> Let my give my vision for the model you request below.
>>
>>
>>>> +	 table = ERR_PTR(-ENOMEM); 
>>>> +	 return table; 
>>>> +} 
>>>> +
>>>> +static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
>>>> +			      struct sg_table *table,
>>>> +			      enum dma_data_direction direction)
>>>> +{
>>>> +	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
>>>> +}
>>>> +
>>>> +static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
>>>> +{
>>>> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
>>>> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
>>>> +	int ret = 0;
>>>> +
>>>> +	mutex_lock(&buffer->lock);
>>>> +	/* now map it to userspace */
>>>> +	ret = dma_heap_map_user(buffer, vma);
>>>
>>> Since this code is used for system heap and and as the reference.
>>> Currently in Android when a system heap buffer is moving down the 
>>> "pipeline" CPU access may occur and there may be no device attached.
>>> In the past people have raised concerns that this should perhaps not be 
>>> supported and that at least one device should be attached when CPU access 
>>> occurs.
>>>
>>> Can we decide, from a dma-buf contract perspective, on whether CPU access 
>>> without a device attached should allowed and make it clear in the dma-buf 
>>> documentation either way?
>>>
>>> If it should not be allowed we can try to work with Android to see how 
>>> they can change their framework to align with the dma-buf spec.
>>>
>>
>> As you say, right now DMA-BUF does not really provide guidelines for
>> "well behaved" heaps, and as such we all end up making different
>> assumptions. Although I don't think they below should be enforced for
>> all DMA-BUFs it should be used for our first set of reference heaps.
>>
>> So from the start, lets looks at DMA-BUF buffer lifetimes. A buffer
>> begins by being allocated, at this point the backing resources (usually
>> some pages in physical CPU addressable RAM) have *not* been allocated
>> this is a core feature of DMA-BUF allowing smart allocations at map
>> time. At this point we should consider the buffer in a state "non-owned
>> non-backed".
>>
>> Next we have three valid actions:
>>  * CPU use
>>  * device attachments
>>  * free
>>
>> CPU use starts with a call to begin_cpu_access(), the buffer will now
>> both become CPU owned and will pin it's backing buffer. This last part
>> can cause begin_cpu_access() to fail for some types of buffers that only
>> pick their backing resource based on the set of attached devices, which
>> at this point we have none. For heaps like "system" heap this should not
>> be a problem as the backing storage is already selected at allocation time.
>>
>> Device attachments and mapping should behave as they do now. After
>> mapping, the buffer is now owned by the attached devices and backed. The
>> ownership can be transfered to the CPU and back as usual with
>> {begin,end}_cpu_access().
>>
>> Free right after allocation without anyone taking ownership is trivial.
>>
>> Now here is where things may get interesting, we can now be in the
>> following states:
>>
>> CPU owned backed
>> Device owned backed
>>
>> What should we do when CPU owned and end_cpu_access() is called or when
>> Device owned and all devices detach. What state do we go into? My
>> opinion would be to return to "non-owned non-backed" which means the
>> backing resource can be freed. The other option is to leave it backed. I
>> beleave this is what Android expects right now as it returns buffers to
>> a "BufferQueue" to later be dequeued and used again in the same way
>> without time consuming reallocations.
>>
> 
> I think the issue may be more serious with Android than allow improving 
> the performance of buffer re-allocation.
> 
> In cases such as video playback:
> #1 video device reads and transforms the video data 
> #2 optionally there may be some software video post processing 
> #3 surface flinger 
> #4 HAL 
> #5 display device eventually gets the buffer
> 
> My understanding is the last device attached to the buffer (the video 
> device) can be detached before Android sends the buffer down the 
> "pipeline" where some software module may do CPU access and where 
> eventually a new device is attached when the buffer is going to be acceded 
> by a device. 
> 
> So Android is counting on the contents of the buffer being retained while 
> it is "non-owned".
> 

It would not be owned, but still "backed", after it has been once
attached/mapped it should it always keep the same data, even if that
data has to be migrated to different backing resources based on new
attachments. For instance if the video device and the display device
have some memory that the other cannot access, after the video device
maps it the heap may put the backing memory in a spot that cannot be
reached by the display device.

This is why a core part of DMA-BUF is that all users should be attached
before the first map so smart decisions can be made about the backing
memory. What Android does here is to assume DMA-BUF is always like
regular memory, it gets no use from the late-allocate features and so
may suffer some performance penalties in some cases for some heaps.

>> For "system" heaps the result is the same outside of the cache ops, if
>> we maintain a buffer state like the above we can always know when a
>> cache op or similar is needed (only when transitioning owners, not on
>> every map/unmap). 
> 
> Assuming I understood your comments correctly, I agree that we will know 
> "when" to optimally apply the cache maintenance but the problem with 
> allowing CPU access to buffers that are now "non-owned" is that we can't 
> apply the cache maintenance when it is required (because there is no 
> longer a device available).
> 

And without knowing what device was last attached we really cannot
always do the right thing. For example, if our above video device was IO
coherent the written data may have landed in L3 cache. So the standard
cache maintenance (cache invalidate) we would normally do would actually
wipe out the data we are looking for, but if it was not IO coherent it
would be needed. This is why the DMA framework doesn't like doing
maintenance without targeted device.

What you could do if you really want those savings (I'm still not sure
they are worth anything, but it's your platform) you could track the set
of last attached devices, then only when needed perform the ops. I don't
think that will scale very well, to me the last valid time to do the
maintenance is on device unmap, and so unless we can prove the CPU will
not access the data between then and the next map (and that the next
mapping device isn't IO coherent), then I really cant see a generic way
to avoid those ops.

Andrew

> 
>> For more complex heaps we can do something similar
>> when transitioning from backed to non-backed (and vice-versa) such as
>> migrating the backing data to a more appropriate resource given the new
>> set of attaching/mapping devices.
>>
>> A more complete state transition map will probably be needed to fill out
>> what should be allowed and what to do when, and I agree it will be good
>> to have that for this first set of reference heaps. But all of this can
>> be done now with DMA-heaps, so I don't want to tie up the core
>> de-staging too much on getting every possible heap to behave just right
>> either..
>>
>>>> +	mutex_unlock(&buffer->lock);
>>>> +
>>>> +	if (ret)
>>>> +		pr_err("%s: failure mapping buffer to userspace\n",
>>>> +		       __func__);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
>>>> +{
>>>> +	struct dma_heap_buffer *buffer = dmabuf->priv;
>>>> +
>>>> +	dma_heap_buffer_destroy(buffer);
>>>> +}
>>>> +
>>>> +static void *dma_heap_dma_buf_kmap(struct dma_buf *dmabuf,
>>>> +					unsigned long offset)
>>>> +{
>>>> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
>>>> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
>>>> +
>>>> +	return buffer->vaddr + offset * PAGE_SIZE;
>>>> +}
>>>> +
>>>> +static void dma_heap_dma_buf_kunmap(struct dma_buf *dmabuf,
>>>> +					unsigned long offset,
>>>> +					void *ptr)
>>>> +{
>>>> +}
>>>> +
>>>> +static int dma_heap_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
>>>> +					enum dma_data_direction direction)
>>>> +{
>>>> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
>>>> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
>>>> +	void *vaddr;
>>>> +	struct dma_heaps_attachment *a;
>>>> +	int ret = 0;
>>>> +
>>>> +	mutex_lock(&buffer->lock);
>>>> +	vaddr = dma_heap_buffer_kmap_get(heap_buffer);
>>>
>>> Since this code is used for system heap and and as the reference.
>>> As has been discussed in the past there are several disadvantages to 
>>> creating a kernel mapping on each call to begin_cpu_access.
>>>
>>> The resulting call to alloc_vmap_area is expensive and can hurt client 
>>> KPIs
>>>
>>> Allowing userspace clients to create and destroy kernel mappings can 
>>> provide opportunities to crash the kernel.
>>>
>>> Can we look at removing the creation of a kernel mapping in 
>>> begin_cpu_access and either introduce support for dma_buf_vmap and have 
>>> clients use that instead or perahps change 
>>> the contract for dma_buf_kmap so that it doesn't always need to succeed?
>>>
>>
>> Agree, for this we should just fail (or succeed but perform no action?)
>> if there are no active mappings (neither in kernel (kmap, vmap) nor in
>> userspace (mmap)), forcing a new mapping just to keep
>> dma_sync_sg_for_cpu() happy is not the correct thing to do here.
>>
>>>> +	if (IS_ERR(vaddr)) {
>>>> +		ret = PTR_ERR(vaddr);
>>>> +		goto unlock;
>>>> +	}
>>>> +	mutex_unlock(&buffer->lock);
>>>> +
>>>> +	mutex_lock(&buffer->lock);
>>>> +	list_for_each_entry(a, &buffer->attachments, list) {
>>>> +		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
>>>> +				    direction);
>>>
>>> Since this code is used for system heap and and as the reference.
>>> Not a major issue for newer kernels but I still don't think it makes sense 
>>> to apply cache maintenance when the buffer is not dma mapped, it doesn't 
>>> makes sense to me from a logical perspective and from a performance 
>>> perspective.
>>>
>>
>> Agree again, this is only needed when we are transitioning out of state
>> "device owned" which we will not be in if we have no active
>> attached/mapped devices.
>>
>>>
>>>> +	}
>>>> +
>>>> +unlock:
>>>> +	mutex_unlock(&buffer->lock);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int dma_heap_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
>>>> +				      enum dma_data_direction direction)
>>>> +{
>>>> +	struct dma_heap_buffer *heap_buffer = dmabuf->priv;
>>>> +	struct heap_helper_buffer *buffer = to_helper_buffer(heap_buffer);
>>>> +	struct dma_heaps_attachment *a;
>>>> +
>>>> +	mutex_lock(&buffer->lock);
>>>> +	dma_heap_buffer_kmap_put(heap_buffer);
>>>> +	mutex_unlock(&buffer->lock);
>>>> +
>>>> +	mutex_lock(&buffer->lock);
>>>> +	list_for_each_entry(a, &buffer->attachments, list) {
>>>> +		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
>>>> +				       direction);
>>>
>>> There are use cases in Android which result in only small parts of a large 
>>> buffer are written do during of CPU access.
>>>
>>
>> We have the same requirements for some OpenCL use-cases
>> (clCreateSubBuffer), which allows for chunks of a larger buffer to have
>> different properties and therefor cache operations different from the
>> larger parrent buffer.
>>
>>> Applying cache maintenance to the complete buffer results in a lot of 
>>> unnecessary cache maintenance that can affect KPIs.
>>>
>>> I believe the Android team is wondering if there could be a way to support 
>>> partial maintenance in  where userspace could describe the buffer changes 
>>> they have made.
>>>
>>
>> The issue I have with that is it would require userspace to know about
>> the cache line size of all involved devices, otherwise you would have
>> users writing to the first 64B and invalidate to read the second 64B
>> written from a DMA device outside the cache, in a system with 128B
>> cache-lines you will always lose some data here.
>>
> 
> Good point.
> 
>>> I think it would be useful to make sure that there is a least a path 
>>> forward with the current dma-buf heaps framework to solve this for system 
>>> heap allocations.
>>>
>>
>> DMA-BUF sync operations always act on the full buffer, changing this
>> would require changes to the core DMA-BUF framework (so outside the
>> scope of this set) :)
>>
>> Andrew
>>
>>> I can get more details on the specific use cases if required.
>>>
>>>> +	}
>>>> +	mutex_unlock(&buffer->lock);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +const struct dma_buf_ops heap_helper_ops = {
>>>> +	.map_dma_buf = dma_heap_map_dma_buf,
>>>> +	.unmap_dma_buf = dma_heap_unmap_dma_buf,
>>>> +	.mmap = dma_heap_mmap,
>>>> +	.release = dma_heap_dma_buf_release,
>>>> +	.attach = dma_heap_attach,
>>>> +	.detach = dma_heap_detatch,
>>>> +	.begin_cpu_access = dma_heap_dma_buf_begin_cpu_access,
>>>> +	.end_cpu_access = dma_heap_dma_buf_end_cpu_access,
>>>> +	.map = dma_heap_dma_buf_kmap,
>>>> +	.unmap = dma_heap_dma_buf_kunmap,
>>>> +};
>>>> diff --git a/drivers/dma-buf/heaps/heap-helpers.h b/drivers/dma-buf/heaps/heap-helpers.h
>>>> new file mode 100644
>>>> index 0000000..0bd8643
>>>> --- /dev/null
>>>> +++ b/drivers/dma-buf/heaps/heap-helpers.h
>>>> @@ -0,0 +1,48 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * DMABUF Heaps helper code
>>>> + *
>>>> + * Copyright (C) 2011 Google, Inc.
>>>> + * Copyright (C) 2019 Linaro Ltd.
>>>> + */
>>>> +
>>>> +#ifndef _HEAP_HELPERS_H
>>>> +#define _HEAP_HELPERS_H
>>>> +
>>>> +#include <linux/dma-heap.h>
>>>> +#include <linux/list.h>
>>>> +
>>>> +struct heap_helper_buffer {
>>>> +	struct dma_heap_buffer heap_buffer;
>>>> +
>>>> +	unsigned long private_flags;
>>>> +	void *priv_virt;
>>>> +	struct mutex lock;
>>>> +	int kmap_cnt;
>>>> +	void *vaddr;
>>>> +	struct sg_table *sg_table;
>>>> +	struct list_head attachments;
>>>> +
>>>> +	void (*free)(struct heap_helper_buffer *buffer);
>>>> +
>>>> +};
>>>> +
>>>> +#define to_helper_buffer(x) \
>>>> +	container_of(x, struct heap_helper_buffer, heap_buffer)
>>>> +
>>>> +static inline void INIT_HEAP_HELPER_BUFFER(struct heap_helper_buffer *buffer,
>>>> +				 void (*free)(struct heap_helper_buffer *))
>>>> +{
>>>> +	buffer->private_flags = 0;
>>>> +	buffer->priv_virt = NULL;
>>>> +	mutex_init(&buffer->lock);
>>>> +	buffer->kmap_cnt = 0;
>>>> +	buffer->vaddr = NULL;
>>>> +	buffer->sg_table = NULL;
>>>> +	INIT_LIST_HEAD(&buffer->attachments);
>>>> +	buffer->free = free;
>>>> +}
>>>> +
>>>> +extern const struct dma_buf_ops heap_helper_ops;
>>>> +
>>>> +#endif /* _HEAP_HELPERS_H */
>>>> -- 
>>>> 2.7.4
>>>>
>>>>
>>>
>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>>> a Linux Foundation Collaborative Project
>>>
>>
> 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
