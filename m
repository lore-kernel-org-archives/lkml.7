Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86E9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883E72075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rMt+kFo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfC2Pmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:42:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49280 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfC2Pmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:42:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TFfrDA129732;
        Fri, 29 Mar 2019 10:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553874113;
        bh=FRKM8j2L6/l6ow0vZkYygwujfL1sXfa+Oni0VYN9/w8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rMt+kFo+iEdK5AsyXUkYIKKAzvwMkDR5YOTfw2OOAap7j4/i1SAbAVVR9XWcdE2yh
         faReB1vMHBm+DMzM8g/J9rGqGgnvpvme2pV8HsRfy9ojVMY9PArT33zm1TwbzxJwik
         g2k2NoR2nT9AdGhMpV7x8EFQOxGFfa0f8s6B43uU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TFfr48033065
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 10:41:53 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 10:41:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 10:41:52 -0500
Received: from [10.250.67.168] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TFfpL0082234;
        Fri, 29 Mar 2019 10:41:52 -0500
Subject: Re: [RFC][PATCH 4/6 v3] dma-buf: heaps: Add CMA heap to dmabuf heapss
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC:     John Stultz <john.stultz@linaro.org>,
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
References: <1553818562-2516-1-git-send-email-john.stultz@linaro.org>
 <1553818562-2516-5-git-send-email-john.stultz@linaro.org>
 <CA+M3ks6kWmhHv9GFCSkNPLJKU-_cctpA9d20UXzrLfudBrrHjA@mail.gmail.com>
 <c35bef87-df92-148c-cd83-aaf2ee61e644@ti.com>
 <CA+M3ks4+REvR=0mLFt-hS4dSfRpx9HLrryb1rfSbYiRSLT2OZQ@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <42c5e635-bec9-6ba1-18c6-50d6a69e9d9d@ti.com>
Date:   Fri, 29 Mar 2019 10:41:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CA+M3ks4+REvR=0mLFt-hS4dSfRpx9HLrryb1rfSbYiRSLT2OZQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 10:30 AM, Benjamin Gaignard wrote:
> Le ven. 29 mars 2019 à 16:19, Andrew F. Davis <afd@ti.com> a écrit :
>>
>> On 3/29/19 9:44 AM, Benjamin Gaignard wrote:
>>> Le ven. 29 mars 2019 à 01:16, John Stultz <john.stultz@linaro.org> a écrit :
>>>>
>>>> This adds a CMA heap, which allows userspace to allocate
>>>> a dma-buf of contiguous memory out of a CMA region.
>>>>
>>>> This code is an evolution of the Android ION implementation, so
>>>> thanks to its original author and maintainters:
>>>>   Benjamin Gaignard, Laura Abbott, and others!
>>>>
>>>> Cc: Laura Abbott <labbott@redhat.com>
>>>> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>>> Cc: Sumit Semwal <sumit.semwal@linaro.org>
>>>> Cc: Liam Mark <lmark@codeaurora.org>
>>>> Cc: Pratik Patel <pratikp@codeaurora.org>
>>>> Cc: Brian Starkey <Brian.Starkey@arm.com>
>>>> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
>>>> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
>>>> Cc: Andrew F. Davis <afd@ti.com>
>>>> Cc: Xu YiPing <xuyiping@hisilicon.com>
>>>> Cc: "Chenfeng (puck)" <puck.chen@hisilicon.com>
>>>> Cc: butao <butao@hisilicon.com>
>>>> Cc: "Xiaqing (A)" <saberlily.xia@hisilicon.com>
>>>> Cc: Yudongbin <yudongbin@hisilicon.com>
>>>> Cc: Christoph Hellwig <hch@infradead.org>
>>>> Cc: Chenbo Feng <fengc@google.com>
>>>> Cc: Alistair Strachan <astrachan@google.com>
>>>> Cc: dri-devel@lists.freedesktop.org
>>>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>>>> ---
>>>> v2:
>>>> * Switch allocate to return dmabuf fd
>>>> * Simplify init code
>>>> * Checkpatch fixups
>>>> v3:
>>>> * Switch to inline function for to_cma_heap()
>>>> * Minor cleanups suggested by Brian
>>>> * Fold in new registration style from Andrew
>>>> * Folded in changes from Andrew to use simplified page list
>>>>   from the heap helpers
>>>> ---
>>>>  drivers/dma-buf/heaps/Kconfig    |   8 ++
>>>>  drivers/dma-buf/heaps/Makefile   |   1 +
>>>>  drivers/dma-buf/heaps/cma_heap.c | 170 +++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 179 insertions(+)
>>>>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>>>>
>>>> diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
>>>> index 2050527..a5eef06 100644
>>>> --- a/drivers/dma-buf/heaps/Kconfig
>>>> +++ b/drivers/dma-buf/heaps/Kconfig
>>>> @@ -4,3 +4,11 @@ config DMABUF_HEAPS_SYSTEM
>>>>         help
>>>>           Choose this option to enable the system dmabuf heap. The system heap
>>>>           is backed by pages from the buddy allocator. If in doubt, say Y.
>>>> +
>>>> +config DMABUF_HEAPS_CMA
>>>> +       bool "DMA-BUF CMA Heap"
>>>> +       depends on DMABUF_HEAPS && DMA_CMA
>>>> +       help
>>>> +         Choose this option to enable dma-buf CMA heap. This heap is backed
>>>> +         by the Contiguous Memory Allocator (CMA). If your system has these
>>>> +         regions, you should say Y here.
>>>> diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
>>>> index d1808ec..6e54cde 100644
>>>> --- a/drivers/dma-buf/heaps/Makefile
>>>> +++ b/drivers/dma-buf/heaps/Makefile
>>>> @@ -1,3 +1,4 @@
>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>  obj-y                                  += heap-helpers.o
>>>>  obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)      += system_heap.o
>>>> +obj-$(CONFIG_DMABUF_HEAPS_CMA)         += cma_heap.o
>>>> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
>>>> new file mode 100644
>>>> index 0000000..f4485c60
>>>> --- /dev/null
>>>> +++ b/drivers/dma-buf/heaps/cma_heap.c
>>>> @@ -0,0 +1,170 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * DMABUF CMA heap exporter
>>>> + *
>>>> + * Copyright (C) 2012, 2019 Linaro Ltd.
>>>> + * Author: <benjamin.gaignard@linaro.org> for ST-Ericsson.
>>>> + */
>>>> +
>>>> +#include <linux/device.h>
>>>> +#include <linux/dma-buf.h>
>>>> +#include <linux/dma-heap.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/errno.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/cma.h>
>>>> +#include <linux/scatterlist.h>
>>>> +#include <linux/highmem.h>
>>>> +
>>>> +#include "heap-helpers.h"
>>>> +
>>>> +struct cma_heap {
>>>> +       struct dma_heap *heap;
>>>> +       struct cma *cma;
>>>> +};
>>>> +
>>>> +static void cma_heap_free(struct heap_helper_buffer *buffer)
>>>> +{
>>>> +       struct cma_heap *cma_heap = dma_heap_get_data(buffer->heap_buffer.heap);
>>>> +       struct page *pages = buffer->priv_virt;
>>>> +       unsigned long nr_pages;
>>>> +
>>>> +       nr_pages = buffer->heap_buffer.size >> PAGE_SHIFT;
>>>> +
>>>> +       /* free page list */
>>>> +       kfree(buffer->pages);
>>>> +       /* release memory */
>>>> +       cma_release(cma_heap->cma, pages, nr_pages);
>>>> +       kfree(buffer);
>>>> +}
>>>> +
>>>> +/* dmabuf heap CMA operations functions */
>>>> +static int cma_heap_allocate(struct dma_heap *heap,
>>>> +                               unsigned long len,
>>>> +                               unsigned long flags)
>>>> +{
>>>> +       struct cma_heap *cma_heap = dma_heap_get_data(heap);
>>>> +       struct heap_helper_buffer *helper_buffer;
>>>> +       struct page *pages;
>>>> +       size_t size = PAGE_ALIGN(len);
>>>> +       unsigned long nr_pages = size >> PAGE_SHIFT;
>>>> +       unsigned long align = get_order(size);
>>>> +       DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>>>> +       struct dma_buf *dmabuf;
>>>> +       int ret = -ENOMEM;
>>>> +       pgoff_t pg;
>>>> +
>>>> +       if (align > CONFIG_CMA_ALIGNMENT)
>>>> +               align = CONFIG_CMA_ALIGNMENT;
>>>> +
>>>> +       helper_buffer = kzalloc(sizeof(*helper_buffer), GFP_KERNEL);
>>>> +       if (!helper_buffer)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       INIT_HEAP_HELPER_BUFFER(helper_buffer, cma_heap_free);
>>>> +       helper_buffer->heap_buffer.flags = flags;
>>>> +       helper_buffer->heap_buffer.heap = heap;
>>>> +       helper_buffer->heap_buffer.size = len;
>>>> +
>>>> +       pages = cma_alloc(cma_heap->cma, nr_pages, align, false);
>>>> +       if (!pages)
>>>> +               goto free_buf;
>>>> +
>>>> +       if (PageHighMem(pages)) {
>>>> +               unsigned long nr_clear_pages = nr_pages;
>>>> +               struct page *page = pages;
>>>> +
>>>> +               while (nr_clear_pages > 0) {
>>>> +                       void *vaddr = kmap_atomic(page);
>>>> +
>>>> +                       memset(vaddr, 0, PAGE_SIZE);
>>>> +                       kunmap_atomic(vaddr);
>>>> +                       page++;
>>>> +                       nr_clear_pages--;
>>>> +               }
>>>> +       } else {
>>>> +               memset(page_address(pages), 0, size);
>>>> +       }
>>>> +
>>>> +       helper_buffer->pagecount = nr_pages;
>>>> +       helper_buffer->pages = kmalloc_array(helper_buffer->pagecount,
>>>> +                                            sizeof(*helper_buffer->pages),
>>>> +                                            GFP_KERNEL);
>>>> +       if (!helper_buffer->pages) {
>>>> +               ret = -ENOMEM;
>>>> +               goto free_cma;
>>>> +       }
>>>> +
>>>> +       for (pg = 0; pg < helper_buffer->pagecount; pg++) {
>>>> +               helper_buffer->pages[pg] = &pages[pg];
>>>> +               if (!helper_buffer->pages[pg])
>>>> +                       goto free_pages;
>>>> +       }
>>>> +
>>>> +       /* create the dmabuf */
>>>> +       exp_info.ops = &heap_helper_ops;
>>>> +       exp_info.size = len;
>>>> +       exp_info.flags = O_RDWR;
>>>
>>> I think that the flags should be provided when requesting the allocation
>>> like it is done in DRM or V4L2.
>>> For me DMA_HEAP_VALID_FLAGS = (O_CLOEXEC | O_ACCMODE).
>>>
>>
>>
>> So something like done in udmabuf?
>>
>> https://elixir.bootlin.com/linux/v5.1-rc1/source/include/uapi/linux/udmabuf.h#L8
>>
>> I think that can be arranged.
> 
> I have in mind what is done by DRM:
> https://elixir.bootlin.com/linux/v5.1-rc1/source/include/uapi/drm/drm.h#L707
> 
> V4L2 does the same but without redefine the flags (which is better)
> 

That would mean we would need a whole flag word passed in just for file
flags when I only ever see one bit being useful(O_CLOEXEC or not). Do
you see any situation where we need more than default O_RDWR and
optional O_CLOEXEC for a dma-buf file?

Andrew

> Benjamin
> 
>>
>> John,
>>
>> This might be a good reason to move the dma_buf_fd() call below out of
>> the heap and back into the core. That way the file exporting flags can
>> be common and core handled. I don't think it would complicate the error
>> handling any as we only need to dma_buf_put(dmabuf) in the core on
>> failure and the heap specific cleanup will happen for us.
>>
>> Andrew
>>
>>
>>> Benjamin
>>>
>>> Benjamin
>>>
>>>> +       exp_info.priv = &helper_buffer->heap_buffer;
>>>> +       dmabuf = dma_buf_export(&exp_info);
>>>> +       if (IS_ERR(dmabuf)) {
>>>> +               ret = PTR_ERR(dmabuf);
>>>> +               goto free_pages;
>>>> +       }
>>>> +
>>>> +       helper_buffer->heap_buffer.dmabuf = dmabuf;
>>>> +       helper_buffer->priv_virt = pages;
>>>> +
>>>> +       ret = dma_buf_fd(dmabuf, O_CLOEXEC);
>>>> +       if (ret < 0) {
>>>> +               dma_buf_put(dmabuf);
>>>> +               /* just return, as put will call release and that will free */
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       return ret;
>>>> +
>>>> +free_pages:
>>>> +       kfree(helper_buffer->pages);
>>>> +free_cma:
>>>> +       cma_release(cma_heap->cma, pages, nr_pages);
>>>> +free_buf:
>>>> +       kfree(helper_buffer);
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +static struct dma_heap_ops cma_heap_ops = {
>>>> +       .allocate = cma_heap_allocate,
>>>> +};
>>>> +
>>>> +static int __add_cma_heap(struct cma *cma, void *data)
>>>> +{
>>>> +       struct cma_heap *cma_heap;
>>>> +       struct dma_heap_export_info exp_info;
>>>> +
>>>> +       cma_heap = kzalloc(sizeof(*cma_heap), GFP_KERNEL);
>>>> +       if (!cma_heap)
>>>> +               return -ENOMEM;
>>>> +       cma_heap->cma = cma;
>>>> +
>>>> +       exp_info.name = cma_get_name(cma);
>>>> +       exp_info.ops = &cma_heap_ops;
>>>> +       exp_info.priv = cma_heap;
>>>> +
>>>> +       cma_heap->heap = dma_heap_add(&exp_info);
>>>> +       if (IS_ERR(cma_heap->heap)) {
>>>> +               int ret = PTR_ERR(cma_heap->heap);
>>>> +
>>>> +               kfree(cma_heap);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int add_cma_heaps(void)
>>>> +{
>>>> +       cma_for_each_area(__add_cma_heap, NULL);
>>>> +       return 0;
>>>> +}
>>>> +device_initcall(add_cma_heaps);
>>>> --
>>>> 2.7.4
>>>>
