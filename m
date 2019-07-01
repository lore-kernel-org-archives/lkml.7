Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE61FC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA0920B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfGAVpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:45:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37755 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:45:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so12315903qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 14:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1qBRMJRV8Yo1wnFWyu6TaXxSgsCcog45RWGTZOE20y8=;
        b=gZYBmH4fBds6gfRjY+VDo860xDB3uuGJyCjkVtjbY+Vk8ATr9J/X+95c1zryvFTCX3
         M0f8+EyZFpuX2mxv3ATefWzvHn6a+E3imwfUWrIJTIR6gXi54yio7xFv4bnmJD1luRpb
         Kk5lWXvjEwpXswsuUvtejOkrCLccdLa7UzKxF2R61azzYPtwbKiPFgLqSDLCAooK3Jnn
         tbYP5Ug4DhU/7N6jdlYLFq1bVGW/0Glx4ttTnyQiOxoTHF4u5v4m+ziRcagib6ZlGA36
         4000QmlXBRoMZ5x4dNL5i6cEV8mt+wMJsUwp3Xz6LBfFJqc2WNXRsT4Qc/e3jjoCDWxN
         dHIw==
X-Gm-Message-State: APjAAAX1T4sqacW8+Tfp/PucjB0DD8GjpAGeOinLW43m44Te+zRBghCu
        dHkVkgAfkkdSxGApQMi8KQMOJw==
X-Google-Smtp-Source: APXvYqxWeb2Amjv7FTKwjLmAisC7y6M5bySfO+cQ1FLIBpDRelRoUJZyO72G1BDW03KKh+aegnVJTw==
X-Received: by 2002:a37:505:: with SMTP id 5mr22571376qkf.277.1562017521083;
        Mon, 01 Jul 2019 14:45:21 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id l6sm5055233qkc.89.2019.07.01.14.45.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 14:45:20 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] DMA-BUF Heaps (destaging ION)
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
References: <20190624194908.121273-1-john.stultz@linaro.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <8e19047d-b0b0-506f-7c3d-cd09075b9da7@redhat.com>
Date:   Mon, 1 Jul 2019 17:45:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190624194908.121273-1-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/19 3:49 PM, John Stultz wrote:
> Here is another pass at the dma-buf heaps patchset Andrew and I
> have been working on which tries to destage a fair chunk of ION
> functionality.
> 

I've gotten bogged down with both work and personal tasks
so I haven't had a chance to look too closely but, once again,
I'm happy to see this continue to move forward.

> The patchset implements per-heap devices which can be opened
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
>    https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
> 
> And the userspace changes here:
>    https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
> 
> Compared to ION, this patchset is missing the system-contig,
> carveout and chunk heaps, as I don't have a device that uses
> those, so I'm unable to do much useful validation there.
> Additionally we have no upstream users of chunk or carveout,
> and the system-contig has been deprecated in the common/andoid-*
> kernels, so this should be ok.
> 
> I've also removed the stats accounting for now, since any such
> accounting should be implemented by dma-buf core or the heaps
> themselves.
> 
> 
> New in v6:
> * Number of cleanups and error path fixes suggested by Brian Starkey,
>    many thanks for his close review and suggestions!
> 
> 
> Outstanding concerns:
> * Need to better understand various secure heap implementations.
>    Some concern that heap private flags will be needed, but its
>    also possible that dma-buf heaps can't solve everyone's needs,
>    in which case, a vendor's secure buffer driver can implement
>    their own dma-buf exporter. So I'm not too worried here.
> 

syzbot found a DoS with Ion which I ACKed a fix for.
https://lore.kernel.org/lkml/03763360-a7de-de87-eb90-ba7838143930@I-love.SAKURA.ne.jp/
This series doesn't have the page pooling so that particular bug may
not be applicable but given this is not the first time I've
seen Ion used as a DoS mechanism, it would be good to think about
putting in some basic checks.

Thanks,
Laura

> Thoughts and feedback would be greatly appreciated!
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
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: dri-devel@lists.freedesktop.org
> 
> Andrew F. Davis (1):
>    dma-buf: Add dma-buf heaps framework
> 
> John Stultz (4):
>    dma-buf: heaps: Add heap helpers
>    dma-buf: heaps: Add system heap to dmabuf heaps
>    dma-buf: heaps: Add CMA heap to dmabuf heaps
>    kselftests: Add dma-heap test
> 
>   MAINTAINERS                                   |  18 ++
>   drivers/dma-buf/Kconfig                       |  10 +
>   drivers/dma-buf/Makefile                      |   2 +
>   drivers/dma-buf/dma-heap.c                    | 249 +++++++++++++++++
>   drivers/dma-buf/heaps/Kconfig                 |  14 +
>   drivers/dma-buf/heaps/Makefile                |   4 +
>   drivers/dma-buf/heaps/cma_heap.c              | 169 +++++++++++
>   drivers/dma-buf/heaps/heap-helpers.c          | 262 ++++++++++++++++++
>   drivers/dma-buf/heaps/heap-helpers.h          |  54 ++++
>   drivers/dma-buf/heaps/system_heap.c           | 121 ++++++++
>   include/linux/dma-heap.h                      |  59 ++++
>   include/uapi/linux/dma-heap.h                 |  55 ++++
>   tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
>   .../selftests/dmabuf-heaps/dmabuf-heap.c      | 234 ++++++++++++++++
>   14 files changed, 1260 insertions(+)
>   create mode 100644 drivers/dma-buf/dma-heap.c
>   create mode 100644 drivers/dma-buf/heaps/Kconfig
>   create mode 100644 drivers/dma-buf/heaps/Makefile
>   create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>   create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>   create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
>   create mode 100644 drivers/dma-buf/heaps/system_heap.c
>   create mode 100644 include/linux/dma-heap.h
>   create mode 100644 include/uapi/linux/dma-heap.h
>   create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>   create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> 

