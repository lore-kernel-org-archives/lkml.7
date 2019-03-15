Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D8A2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCOUeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:34:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43479 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfCOUeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:34:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id c20so1559414qkc.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a81qls6bJh24LQhM0wIk0kx+M01dPo44WFCFvWenQTo=;
        b=CgdM081Geoe34HLUbwpYQoz0wP+sn02/vbJ7Wo4tGpvyX3XBu4EoGDXzwPxxAYjGTL
         2CTVix7kfVCDVIBxPU4bg+FCKxRtLUw/nprlFs7XcUOCnh/lBdu8iwSCILReyOJc+1wR
         jU5UXq2ORFijOWMcGWpV91e890yZjiUXYDOHh0pHoPchm7DPbqeP/ApvK4ACB4dlOtCA
         x0iUYe1C/2I89hOKSMmYD1HGUl1LHp4JneVLdV9bGIeZnQWfn+1tCBRuzGjqz04/7hA5
         Yl3vPE5HL2z1eoHDnOp0cwyIcvdN74gWB0Ws7XHqWRAZfn4+WHkWef1dEmjO9Q+c3L0D
         Q7SA==
X-Gm-Message-State: APjAAAVpAt5otOhaxPBjU0EhOSolXpYCxKLdg9l+Aa35OIEjwEg54yw5
        cMB9fUo+bGOoQn4pF0TUjxaymg==
X-Google-Smtp-Source: APXvYqxBSLciSsCqqwRb0XKq5B51OFXuspuW4MmJ35on4vKPryCarUY/BMDxg5QFXEMcoyEI5I5Tuw==
X-Received: by 2002:a05:620a:159b:: with SMTP id d27mr4397424qkk.163.1552682074949;
        Fri, 15 Mar 2019 13:34:34 -0700 (PDT)
Received: from ?IPv6:2601:602:9800:dae6::362? ([2601:602:9800:dae6::362])
        by smtp.gmail.com with ESMTPSA id g123sm4750826qkg.0.2019.03.15.13.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 13:34:34 -0700 (PDT)
Subject: Re: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <6c164c47-885f-b856-9d5d-74df9459d862@redhat.com>
Date:   Fri, 15 Mar 2019 13:34:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 12:54 PM, John Stultz wrote:
> Here is a initial RFC of the dma-buf heaps patchset Andrew and I
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
>    https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
> 
> And the userspace changes here:
>    https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
> 
> 
> Compared to ION, this patchset is missing the system-contig,
> carveout and chunk heaps, as I don't have a device that uses
> those, so I'm unable to do much useful validation there.
> Additionally we have no upstream users of chunk or carveout,
> and the system-contig has been deprecated in the common/andoid-*
> kernels, so this should be ok.
> 
> I've also removed the stats accounting for now, since it should
> be implemented by the heaps themselves.
> 
> Eventual TODOS:
> * Reimplement page-pool for system heap (working on this)
> * Add stats accounting to system/cma heaps
> * Make the kselftest actually useful
> * Add other heaps folks see as useful (would love to get
>    some help from actual carveout/chunk users)!
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
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
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
>    dma-buf: heaps: Add CMA heap to dmabuf heapss
>    kselftests: Add dma-heap test
> 
>   MAINTAINERS                                        |  16 +
>   drivers/dma-buf/Kconfig                            |  10 +
>   drivers/dma-buf/Makefile                           |   2 +
>   drivers/dma-buf/dma-heap.c                         | 191 ++++++++++++
>   drivers/dma-buf/heaps/Kconfig                      |  14 +
>   drivers/dma-buf/heaps/Makefile                     |   4 +
>   drivers/dma-buf/heaps/cma_heap.c                   | 164 ++++++++++
>   drivers/dma-buf/heaps/heap-helpers.c               | 335 +++++++++++++++++++++
>   drivers/dma-buf/heaps/heap-helpers.h               |  48 +++
>   drivers/dma-buf/heaps/system_heap.c                | 132 ++++++++
>   include/linux/dma-heap.h                           |  65 ++++
>   include/uapi/linux/dma-heap.h                      |  52 ++++
>   tools/testing/selftests/dmabuf-heaps/Makefile      |  11 +
>   tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c |  96 ++++++
>   14 files changed, 1140 insertions(+)
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

This is looking really great. Thanks for doing the work to
push this forward. It seems like we're in general agreement
about much of this. Which of the issues that have come up
do you think are a "hard no" to keeping this from going in?

Thanks,
Laura
