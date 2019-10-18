Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71342CA9EA2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4422521D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQ3ny8Ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504370AbfJRGWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:22:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43835 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392981AbfJRGWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:22:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id o44so4023247ota.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 23:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UkjADtH3OoY5PrcZf8XHmujRh7ZLWGmK8dpbgj0S1eU=;
        b=TQ3ny8Ae1igp5m/vKmUDvMb4mX4I6kYGW4WLCXlpHo5hjFym6sUlALfnk9H0K0xuZw
         vxntYIkvzjqSKTwAXiTzTZnIEyP4s30APVsVmNv2qbF+6NVR4v+/w3djWQdk1IjXooOj
         byLtBC067wmsJzz2JSOUEIYd73PRAERcbELduLBIHJXs0RVC1OJSejk8tIMkmtMeeY3J
         flFsZmb0hzwMKhSqc1Y2S1qkpyohRMMFbrKyeBMeyfdeegC5eLwi+qffuYiEuZaWE/iY
         nxYCxGqa/zScFUKxexHNhjf0pr4Whqqwj1CL70BNoBVs7T+B0FyIigYwib10DOPIWdpu
         6p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkjADtH3OoY5PrcZf8XHmujRh7ZLWGmK8dpbgj0S1eU=;
        b=kpIWgqM1V9IrwvytIQWzSmEvLrV/EZKvOpX7Xn9nz3F9mtNtPMZ+3dMmDf6ao6zui0
         x9DgZktXa4CcrbA0iWynZJVxovXk0OPv3unYPH4dvG1dPE31W3OqPvlCjPuBdyDu7j5j
         vHxloclYLkY+1VLHYflUMYtsqRzWJyakTH7Grn8WCxXtqLUoKGDr1vrU1JJEHhPyVhjs
         OVSk1UB+NSLhTN9b5rwhPVFeuAg3cPzlhTLJb97n6gLk/U1M6QjW+R2J8lc6lEuHcLgl
         2p0+Q2HOCAgfbDBB9NlZb7IookaVMWrxNrIz0VG4MRqwD2i+uk3903/dkWm+7YwuX28h
         wezw==
X-Gm-Message-State: APjAAAU/I4+2MtLDfz63DeRt9qQaNFdZujpt5IqpuPv+dOolhF7EU0EC
        Jv7gD7P/TtL5e0JwpBdeicsQS6yoWUy8ZIZY3jFT3Q==
X-Google-Smtp-Source: APXvYqwR7wbX4kwVFy183PKeDVFgPtoHxkXUCA+0LYtY5cckYxlTVfALoIDf9uoz66/ikzHu7GzRuAckqDtoyy0C35M=
X-Received: by 2002:a9d:3e17:: with SMTP id a23mr6485132otd.105.1571379723521;
 Thu, 17 Oct 2019 23:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191018052323.21659-1-john.stultz@linaro.org>
In-Reply-To: <20191018052323.21659-1-john.stultz@linaro.org>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Fri, 18 Oct 2019 11:51:51 +0530
Message-ID: <CAO_48GGCgtA4U1CU6KV7N2m=RrwAiKgAPYghmYwirM9RJU4YTA@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] DMA-BUF Heaps (destaging ION)
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John, Andrews,

On Fri, 18 Oct 2019 at 10:53, John Stultz <john.stultz@linaro.org> wrote:
>
> Andrew brought up a reasonable concern with the CMA heap
> enumeration in the previous patch set, and I had a few other
> minor cleanups to add, so here is yet another pass at the
> dma-buf heaps patchset Andrew and I have been working on which
> tries to destage a fair chunk of ION functionality.

Thanks much for all your hardwork in getting these patches ready. It
looks like a sane approach to me to first just add the default cma
heap and work out the selection of other heaps later on.

I will wait out this weekend for any objections from others, and if I
hear none, will merge this series on Monday.
Hope that sounds reasonable?

>
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
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
>
> And the userspace changes here:
>   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
>
> Compared to ION, this patchset is missing the system-contig,
> carveout and chunk heaps, as I don't have a device that uses
> those, so I'm unable to do much useful validation there.
> Additionally we have no upstream users of chunk or carveout,
> and the system-contig has been deprecated in the common/andoid-*
> kernels, so this should be ok.
>
> I've also removed the stats accounting, since any such
> accounting should be implemented by dma-buf core or the heaps
> themselves.
>
> New in v12:
> * To address Andrew's concern about adding all CMA areas, the
>   CMA heap only adds the default CMA region for now.
> * Minor cleanups and prep for loading heaps from modules
> * I have patches to add other specified CMA regions, as well as
>   loading heaps from modules in my WIP tree, which I will submit
>   once this set is queued, here:
>     https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap-WIP
>
> thanks
> -john

<snip>

Best,
Sumit.
