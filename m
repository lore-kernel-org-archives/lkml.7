Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F45C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DF1206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tIoL7oVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfC2OSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:18:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36658 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfC2OSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:18:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TEHoxr101309;
        Fri, 29 Mar 2019 09:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553869070;
        bh=N6h3VzTAWvuedTPmQhD9kI7Q4RP5rM5ZZ4elHfV4EpE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tIoL7oVc+8WBGKNtGCwiRfnX8r6m/IToUaismX2MsRbItudPwuk4CYtMyx7xcNVIY
         r/16KzPirxqVzcWrwZ7rhmA4fvqJBb0REOA+TBXcT9pGIc2NNX2I7I5YPE9qs44CJm
         KeQST/JKpECY7bVgPtLzCWII618J2pFxFg3TTN/c=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TEHogx057551
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 09:17:50 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 09:17:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 09:17:49 -0500
Received: from [10.250.67.168] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TEHm1Y088853;
        Fri, 29 Mar 2019 09:17:49 -0500
Subject: Re: [RFC][PATCH 0/6 v3] DMA-BUF Heaps (destaging ION)
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
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <7670750b-0889-390e-2862-e0be9f220292@ti.com>
Date:   Fri, 29 Mar 2019 09:17:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553818562-2516-1-git-send-email-john.stultz@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 7:15 PM, John Stultz wrote:
> Here is another RFC of the dma-buf heaps patchset Andrew and I
> have been working on which tries to destage a fair chunk of ION
> functionality.
> 
> The patchset implements per-heap devices which can be opened
> directly and then an ioctl is used to allocate a dmabuf from the
> heap.
> 
> The interface is similar, but much simpler then IONs, only
> providing an ALLOC ioctl.
> 
> Also, I've provided simple system and cma heaps. The system
> heap in particular is missing the page-pool optimizations ION
> had, but works well enough to validate the interface.
> 
> I've booted and tested these patches with AOSP on the HiKey960
> using the kernel tree here:
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
> 
> And the userspace changes here:
>   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
> 
> 
> Compared to ION, this patchset is missing the system-contig,
> carveout and chunk heaps, as I don't have a device that uses
> those, so I'm unable to do much useful validation there.
> Additionally we have no upstream users of chunk or carveout,
> and the system-contig has been deprecated in the common/andoid-*
> kernels, so this should be ok.
> 


I'd like to go over my use-cases for a moment to see if we can get some
agreement on what to do with the carveout/chunk heaps.

We used DRM (omapdrm) to get buffers for display, GPU, and multi-media.
Our out-of-tree CMEM driver[0] for remote processing (OpenCL/CV/VX)
buffers. And for secure heaps we use what are basically slightly
modified ION carveout heaps.

Now with the DMA-Heap framework what we can do is for sub-systems with
IOMMUs use 'system' heap (GPU). For those that need contiguous memory
(display, MM) we have 'cma' heap (and maybe 'system-contig' at some
point). For our SRAM areas used in remote processing I've posted an RFC
for a heap[1] to provide allocations from those areas.

The above leaves one last gap for us, uncached/unmapped areas from
regular memory. I propose this is where we use the 'carveout' heap.
Right now to get some contiguous/cached memory with DT you can:

reserved-memory {
	[...]
	cma_memory {
		compatible = "shared-dma-pool";
		reg = <0x79000000 0x400000>;
		reusable;
	};

	coherent_memory@78000000 {
		reg = <0x78000000 0x800000>;
		no-map;
	};
};

'cma_memory' will show up as a 'cma' heap, so all good there.

Looking at 'coherent_memory' it will not have valid backing 'struct
page' and so cannot be given cached mappings as the standard dma memory
ops would fail. This would give this area the right properties for both
users who don't want to do all the cache maintenance ops (Liam?) and for
secure heaps that have restrictions on access from Linux running CPU.

The question then is how to mark these areas for export with DMA-Heaps?
Maybe a cma_for_each_area() like function but for dma coherent areas?

Anyway for now this is not super important and I can post a patchset at
some later point for this when I get it working and tested internally.

[0]
http://software-dl.ti.com/processor-sdk-linux/esd/docs/latest/linux/Foundational_Components_CMEM.html
[1] https://patchwork.kernel.org/patch/10863957/

Thanks,
Andrew


> I've also removed the stats accounting for now, since it should
> be implemented by the heaps themselves.
> 
> 
> New in v3:
> * Proper /dev/heap/* names on both Android and classic Linux
>   environments
> * Major rework of the helper code from Andrew
> * Dummy test device added to test importing
> * *Lots* of cleanups suggested by many (thank you for all the
>   input)!
> 
> 
> Outstanding concerns:
> * Potential need for private flags in interface for secure
>   heaps. Need to better understand secure heap usage.
> * Making sure the performance issues from potentially unnecessary
>   cache-management operations can be resolved properly for system
>   and cma heaps (outstanding issue from ION).
> 
> 
> Eventual TODOS:
> * Sanity filtering for heap names
> * Reimplement performance optimizations for system heap
> * Add stats accounting to system/cma heaps
> * Make the kselftest more useful
> * Add other heaps folks see as useful (would love to get
>   some help from actual carveout/chunk users)!
> 
> That said, the main user-interface is shaping up and I wanted
> to get some input on the device model (particularly from GreKH)
> and any other API/ABI specific input. 
> 
> thanks
> -john
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
> 
> Andrew F. Davis (2):
>   dma-buf: Add dma-buf heaps framework
>   dma-buf: Add Dummy Importer Test Device
> 
> John Stultz (4):
>   dma-buf: heaps: Add heap helpers
>   dma-buf: heaps: Add system heap to dmabuf heaps
>   dma-buf: heaps: Add CMA heap to dmabuf heapss
>   kselftests: Add dma-heap test
> 
>  MAINTAINERS                                        |  18 ++
>  drivers/dma-buf/Kconfig                            |  16 ++
>  drivers/dma-buf/Makefile                           |   3 +
>  drivers/dma-buf/dma-buf-testdev.c                  | 239 +++++++++++++++++++
>  drivers/dma-buf/dma-heap.c                         | 234 ++++++++++++++++++
>  drivers/dma-buf/heaps/Kconfig                      |  14 ++
>  drivers/dma-buf/heaps/Makefile                     |   4 +
>  drivers/dma-buf/heaps/cma_heap.c                   | 170 ++++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.c               | 261 +++++++++++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.h               |  55 +++++
>  drivers/dma-buf/heaps/system_heap.c                | 120 ++++++++++
>  include/linux/dma-heap.h                           |  58 +++++
>  include/uapi/linux/dma-buf-testdev.h               |  37 +++
>  include/uapi/linux/dma-heap.h                      |  52 ++++
>  tools/testing/selftests/dmabuf-heaps/Makefile      |  11 +
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 169 +++++++++++++
>  16 files changed, 1461 insertions(+)
>  create mode 100644 drivers/dma-buf/dma-buf-testdev.c
>  create mode 100644 drivers/dma-buf/dma-heap.c
>  create mode 100644 drivers/dma-buf/heaps/Kconfig
>  create mode 100644 drivers/dma-buf/heaps/Makefile
>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
>  create mode 100644 drivers/dma-buf/heaps/system_heap.c
>  create mode 100644 include/linux/dma-heap.h
>  create mode 100644 include/uapi/linux/dma-buf-testdev.h
>  create mode 100644 include/uapi/linux/dma-heap.h
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> 
