Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4515C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C5722311
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NCwSgh+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKRUbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:31:12 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60796 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKRUbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:31:11 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAIKUemM042962;
        Mon, 18 Nov 2019 14:30:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574109040;
        bh=1HeOOZNyIamu59+iWhM46Oa1+PcUf2PobgeWjYTCvkY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NCwSgh+zeYhqxG0WR45QaYJgg86n2DlKgc+twgdF5kJMP7Iiluw4ldxlc4ed/D1gW
         sSJkREwhKimFyZe+kRocT+nO4J4RfEmHIYLmPlkFmjtOvJl7VjoeymIkdBG99v3ZpL
         NZPAyDBvPlZpf8IlFnxGxS/vVnEAXkkZljCNMaks=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAIKUeiO059253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Nov 2019 14:30:40 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 18
 Nov 2019 14:30:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 18 Nov 2019 14:30:40 -0600
Received: from [10.250.45.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAIKUdtt074954;
        Mon, 18 Nov 2019 14:30:39 -0600
Subject: Re: [PATCH v16 0/5] DMA-BUF Heaps (destaging ION)
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
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        <dri-devel@lists.freedesktop.org>
References: <20191118202332.109172-1-john.stultz@linaro.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <5a9ea98d-3486-8167-d2d5-aa055da65198@ti.com>
Date:   Mon, 18 Nov 2019 15:30:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118202332.109172-1-john.stultz@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 3:23 PM, John Stultz wrote:
> Just wanted to resend v16 with a few minor changes.
> 
> This patchset implements per-heap devices which can be opened
> directly and then an ioctl is used to allocate a dmabuf from the
> heap.
> 
> The interface is similar, but much simpler then IONs, only
> providing an ALLOC ioctl.
> 
> Also, I've provided relatively simple system and cma heaps.
> 
> I've booted and tested these patches with AOSP on the HiKey960
> using the kernel tree here:
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
> 
> And the reviewed (+2'ed) userspace changes here:
>   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
> 
> Compared to ION, this patchset is missing the system-contig,
> carveout and chunk heaps, as I don't have a device that uses


ION's Carveout and Chunk heaps got dropped from upstream, so no gap
there. :)

Andrew


> those, so I'm unable to do much useful validation there.
> Additionally we have no upstream users of chunk or carveout,
> and the system-contig has been deprecated in the common/andoid-*
> kernels, so this should be ok.
> 
> I've also removed the stats accounting, since any such
> accounting should be implemented by dma-buf core or the heaps
> themselves.
> 
> New in v16:
> * Typo fix suggested by Hridya Valsaraju <hridya@google.com>
> * Add extra error and ioctl compatibility testing suggested by
>   Daniel Vetter to the kselftest test
> 
> Thanks again for all the reviews and feedback!
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
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> 
> Andrew F. Davis (1):
>   dma-buf: Add dma-buf heaps framework
> 
> John Stultz (4):
>   dma-buf: heaps: Add heap helpers
>   dma-buf: heaps: Add system heap to dmabuf heaps
>   dma-buf: heaps: Add CMA heap to dmabuf heaps
>   kselftests: Add dma-heap test
> 
>  MAINTAINERS                                   |  18 +
>  drivers/dma-buf/Kconfig                       |  11 +
>  drivers/dma-buf/Makefile                      |   2 +
>  drivers/dma-buf/dma-heap.c                    | 297 +++++++++++++
>  drivers/dma-buf/heaps/Kconfig                 |  14 +
>  drivers/dma-buf/heaps/Makefile                |   4 +
>  drivers/dma-buf/heaps/cma_heap.c              | 177 ++++++++
>  drivers/dma-buf/heaps/heap-helpers.c          | 271 ++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.h          |  53 +++
>  drivers/dma-buf/heaps/system_heap.c           | 123 ++++++
>  include/linux/dma-heap.h                      |  59 +++
>  include/uapi/linux/dma-heap.h                 |  53 +++
>  tools/testing/selftests/dmabuf-heaps/Makefile |   6 +
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 396 ++++++++++++++++++
>  14 files changed, 1484 insertions(+)
>  create mode 100644 drivers/dma-buf/dma-heap.c
>  create mode 100644 drivers/dma-buf/heaps/Kconfig
>  create mode 100644 drivers/dma-buf/heaps/Makefile
>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
>  create mode 100644 drivers/dma-buf/heaps/system_heap.c
>  create mode 100644 include/linux/dma-heap.h
>  create mode 100644 include/uapi/linux/dma-heap.h
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> 
