Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A888C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E4F20657
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R1IPz9TU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZT4PiaWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfC2UPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:15:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729906AbfC2UPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:15:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B11C9608A5; Fri, 29 Mar 2019 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553890504;
        bh=3noPISy5le5KpfdCcs8oSLPJj0XKQ8++SLe1fp41unA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=R1IPz9TUO9nl/2q7AbLnnXY3xtetG0+wdHhDwZW9X7CugloVIo9iMdG1KB5KRWigh
         9ZwxMoKRhfeC8lDYcxj+oulXuJ6JfBDGaaRnACYsW6onV57VaWTl43SJyjCQIT2uvI
         xZoifzr2ipm0Pp6t5qVlHLUw8ebOKSqWEmd5EH/k=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 75E26605A2;
        Fri, 29 Mar 2019 20:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553890492;
        bh=3noPISy5le5KpfdCcs8oSLPJj0XKQ8++SLe1fp41unA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ZT4PiaWT6IEm1whhkT5uYxaienAuOM8p/XfdBC6UgCtiF6g8aPKJSLNvj5q6IF3Yh
         qI0a8Wsmoxp00H90bHUcAgFzD0V8BIPPU8Dy+mI1c6X+zIAPSI5FAPHmp8Cr+S8RlK
         MB9RNwnRJQTXUYahKHYC0VhmMkh66RQ2ms+HqpfE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75E26605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Fri, 29 Mar 2019 13:14:50 -0700 (PDT)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     "Andrew F. Davis" <afd@ti.com>
cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
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
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC][PATCH 0/6 v3] DMA-BUF Heaps (destaging ION)
In-Reply-To: <7670750b-0889-390e-2862-e0be9f220292@ti.com>
Message-ID: <alpine.DEB.2.10.1903291310360.5458@lmark-linux.qualcomm.com>
References: <1553818562-2516-1-git-send-email-john.stultz@linaro.org> <7670750b-0889-390e-2862-e0be9f220292@ti.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019, Andrew F. Davis wrote:

> On 3/28/19 7:15 PM, John Stultz wrote:
> > Here is another RFC of the dma-buf heaps patchset Andrew and I
> > have been working on which tries to destage a fair chunk of ION
> > functionality.
> > 
> > The patchset implements per-heap devices which can be opened
> > directly and then an ioctl is used to allocate a dmabuf from the
> > heap.
> > 
> > The interface is similar, but much simpler then IONs, only
> > providing an ALLOC ioctl.
> > 
> > Also, I've provided simple system and cma heaps. The system
> > heap in particular is missing the page-pool optimizations ION
> > had, but works well enough to validate the interface.
> > 
> > I've booted and tested these patches with AOSP on the HiKey960
> > using the kernel tree here:
> >   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
> > 
> > And the userspace changes here:
> >   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
> > 
> > 
> > Compared to ION, this patchset is missing the system-contig,
> > carveout and chunk heaps, as I don't have a device that uses
> > those, so I'm unable to do much useful validation there.
> > Additionally we have no upstream users of chunk or carveout,
> > and the system-contig has been deprecated in the common/andoid-*
> > kernels, so this should be ok.
> > 
> 
> 
> I'd like to go over my use-cases for a moment to see if we can get some
> agreement on what to do with the carveout/chunk heaps.
> 
> We used DRM (omapdrm) to get buffers for display, GPU, and multi-media.
> Our out-of-tree CMEM driver[0] for remote processing (OpenCL/CV/VX)
> buffers. And for secure heaps we use what are basically slightly
> modified ION carveout heaps.
> 
> Now with the DMA-Heap framework what we can do is for sub-systems with
> IOMMUs use 'system' heap (GPU). For those that need contiguous memory
> (display, MM) we have 'cma' heap (and maybe 'system-contig' at some
> point). For our SRAM areas used in remote processing I've posted an RFC
> for a heap[1] to provide allocations from those areas.
> 
> The above leaves one last gap for us, uncached/unmapped areas from
> regular memory. I propose this is where we use the 'carveout' heap.
> Right now to get some contiguous/cached memory with DT you can:
> 
> reserved-memory {
> 	[...]
> 	cma_memory {
> 		compatible = "shared-dma-pool";
> 		reg = <0x79000000 0x400000>;
> 		reusable;
> 	};
> 
> 	coherent_memory@78000000 {
> 		reg = <0x78000000 0x800000>;
> 		no-map;
> 	};
> };
> 
> 'cma_memory' will show up as a 'cma' heap, so all good there.
> 
> Looking at 'coherent_memory' it will not have valid backing 'struct
> page' and so cannot be given cached mappings as the standard dma memory
> ops would fail. This would give this area the right properties for both
> users who don't want to do all the cache maintenance ops (Liam?) and for
> secure heaps that have restrictions on access from Linux running CPU.
> 

So our main use case in which we use uncached memory to avoid cache 
maintenance is for multimedia memory (which is generally only accessed by 
devices), there can be both a lot of this memory allocated for these use 
cases and the amount varies so a carveout wouldn't work for us.
However I am still holding out hope that we will be able to drop this 
requirement for uncached memory through changes to both Android and 
ION/dma-buf heaps, such as the proposal where Android keeps devices 
attached and ION/dma-buf heaps track of which buffers are 'dirty'. 
Investigations still ongoing... 

We have a number of use cases which use uncached memory, the major reason 
that our clients use uncached is for the performance benefit above. I 
am currently doing a review of client use cases to determine all our 
uncached requirements, for example if CMA heaps will need to support 
uncached allocations, once that is done I will be able to better 
articulate our requirements.

One use case where I have seen carveouts uses which doesn't sound like it 
would be supported under the current proposals is when clients need to 
allocate a lot of cached memory quickly.
I have seen cases where a large carveout is used for camera use cases.
Basically they allocate cached memory from the carveout and any extra 
memory they need (after the carveout is full) is allocated from the system 
heap.

This allows for memory heavy performance sensitive apps, such as camera, 
to be launched quickly.

> The question then is how to mark these areas for export with DMA-Heaps?
> Maybe a cma_for_each_area() like function but for dma coherent areas?
> 

That sounds reasonable to me.

> Anyway for now this is not super important and I can post a patchset at
> some later point for this when I get it working and tested internally.
> 
> [0]
> http://software-dl.ti.com/processor-sdk-linux/esd/docs/latest/linux/Foundational_Components_CMEM.html
> [1] https://patchwork.kernel.org/patch/10863957/
> 
> Thanks,
> Andrew
> 
> 
> > I've also removed the stats accounting for now, since it should
> > be implemented by the heaps themselves.
> > 
> > 
> > New in v3:
> > * Proper /dev/heap/* names on both Android and classic Linux
> >   environments
> > * Major rework of the helper code from Andrew
> > * Dummy test device added to test importing
> > * *Lots* of cleanups suggested by many (thank you for all the
> >   input)!
> > 
> > 
> > Outstanding concerns:
> > * Potential need for private flags in interface for secure
> >   heaps. Need to better understand secure heap usage.
> > * Making sure the performance issues from potentially unnecessary
> >   cache-management operations can be resolved properly for system
> >   and cma heaps (outstanding issue from ION).
> > 
> > 
> > Eventual TODOS:
> > * Sanity filtering for heap names
> > * Reimplement performance optimizations for system heap
> > * Add stats accounting to system/cma heaps
> > * Make the kselftest more useful
> > * Add other heaps folks see as useful (would love to get
> >   some help from actual carveout/chunk users)!
> > 
> > That said, the main user-interface is shaping up and I wanted
> > to get some input on the device model (particularly from GreKH)
> > and any other API/ABI specific input. 
> > 
> > thanks
> > -john
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
> > 
> > Andrew F. Davis (2):
> >   dma-buf: Add dma-buf heaps framework
> >   dma-buf: Add Dummy Importer Test Device
> > 
> > John Stultz (4):
> >   dma-buf: heaps: Add heap helpers
> >   dma-buf: heaps: Add system heap to dmabuf heaps
> >   dma-buf: heaps: Add CMA heap to dmabuf heapss
> >   kselftests: Add dma-heap test
> > 
> >  MAINTAINERS                                        |  18 ++
> >  drivers/dma-buf/Kconfig                            |  16 ++
> >  drivers/dma-buf/Makefile                           |   3 +
> >  drivers/dma-buf/dma-buf-testdev.c                  | 239 +++++++++++++++++++
> >  drivers/dma-buf/dma-heap.c                         | 234 ++++++++++++++++++
> >  drivers/dma-buf/heaps/Kconfig                      |  14 ++
> >  drivers/dma-buf/heaps/Makefile                     |   4 +
> >  drivers/dma-buf/heaps/cma_heap.c                   | 170 ++++++++++++++
> >  drivers/dma-buf/heaps/heap-helpers.c               | 261 +++++++++++++++++++++
> >  drivers/dma-buf/heaps/heap-helpers.h               |  55 +++++
> >  drivers/dma-buf/heaps/system_heap.c                | 120 ++++++++++
> >  include/linux/dma-heap.h                           |  58 +++++
> >  include/uapi/linux/dma-buf-testdev.h               |  37 +++
> >  include/uapi/linux/dma-heap.h                      |  52 ++++
> >  tools/testing/selftests/dmabuf-heaps/Makefile      |  11 +
> >  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 169 +++++++++++++
> >  16 files changed, 1461 insertions(+)
> >  create mode 100644 drivers/dma-buf/dma-buf-testdev.c
> >  create mode 100644 drivers/dma-buf/dma-heap.c
> >  create mode 100644 drivers/dma-buf/heaps/Kconfig
> >  create mode 100644 drivers/dma-buf/heaps/Makefile
> >  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
> >  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
> >  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
> >  create mode 100644 drivers/dma-buf/heaps/system_heap.c
> >  create mode 100644 include/linux/dma-heap.h
> >  create mode 100644 include/uapi/linux/dma-buf-testdev.h
> >  create mode 100644 include/uapi/linux/dma-heap.h
> >  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
> >  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> > 
> 

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
