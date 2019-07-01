Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32829C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04710206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="op+BjVzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGAVzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:55:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52526 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:55:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so954524wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ejh504flrxv4/rJu7N/OK131VCazBveh9yTiENAmwg=;
        b=op+BjVzAkj4zZ7hkg/HTQgruGXXGSMJTDo6hpwdct0IVDfelNGJZS34uG7SbrhTZ98
         ZLNlFJaY+g0HQW7QfIeLZcrvNX4rLwfkOB2pbnZuxtkCSIBl5mYM+/iss5bUsuLX37Ly
         K0MLnHdGGGelTLzh49inafNaJctB7gk5A7d9LYryLKK/vA05u70s0k6QUCWUwEgZnID0
         H1gW5GaPfWLASaB/KCmB+9qtIUmdQl4r0L/W/CxPpEUKz/zVaxNB2QNVMwZv0b9VLZ6x
         vdaHUFIFyzsMMfFBnRStzfp/pdqCNJZ7LoSzGAAYVbpR6eYNUkAitpiNxoNmVvhVRLNA
         vsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ejh504flrxv4/rJu7N/OK131VCazBveh9yTiENAmwg=;
        b=Il/KhAMT1D+tP3of8i2hpg/VVR5DAzTA8RZNvB2H46tMgFI2OimyLi6fkgEcdiT5e4
         7M4QppBVrdD9Vxn82/r2BTPOXbmBXvzQr6jQerHG4SJK0rC9WXppeI+hGaVHpShUdRNy
         j53v3zCerjt6V2Q/8vDHUmk5Sm7YtIQGaJ0I53MW9HNv+GZow2S1Bb5YmVDKBlsUrGdz
         xqMccsmt+Eujo1Q1zlZBHZ2TMnN9b4B/7ky1mL7l6BxlCM6cAetxDpX74UV/+Rr/g531
         QsrKIWZeJGtD1IIy4TSeZ0kZ+3hsso+mABPGtAvMkUyTmCbr414GLST1trPWIEYvKers
         1J2Q==
X-Gm-Message-State: APjAAAVSIrd5FCqFULo+L0jdL2taFoahSp6+OcBplOVoynq9ZXrdK+/J
        90JvYWyTDT3uXYet84nA0dFrmafNR+Kg3a92rQCuHQ==
X-Google-Smtp-Source: APXvYqxrG5r0hxp5gNLuJsV9257JSZbGdgYzmk745sPYuXn1hyAQglK9dzaLJNCZrpRCqB7WvQOAJ+nbJvuxoGc/ZJQ=
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr787138wmg.164.1562018138931;
 Mon, 01 Jul 2019 14:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190624194908.121273-1-john.stultz@linaro.org> <8e19047d-b0b0-506f-7c3d-cd09075b9da7@redhat.com>
In-Reply-To: <8e19047d-b0b0-506f-7c3d-cd09075b9da7@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 1 Jul 2019 14:55:25 -0700
Message-ID: <CALAqxLUBfEOyMBtx0xzs8th-Xsi15mXqFmPOcLTihV_jfO=BjA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] DMA-BUF Heaps (destaging ION)
To:     Laura Abbott <labbott@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
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
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 2:45 PM Laura Abbott <labbott@redhat.com> wrote:
>
> On 6/24/19 3:49 PM, John Stultz wrote:
> > Here is another pass at the dma-buf heaps patchset Andrew and I
> > have been working on which tries to destage a fair chunk of ION
> > functionality.
> >
>
> I've gotten bogged down with both work and personal tasks
> so I haven't had a chance to look too closely but, once again,
> I'm happy to see this continue to move forward.
>
> > The patchset implements per-heap devices which can be opened
> > directly and then an ioctl is used to allocate a dmabuf from the
> > heap.
> >
> > The interface is similar, but much simpler then IONs, only
> > providing an ALLOC ioctl.
> >
> > Also, I've provided relatively simple system and cma heaps.
> >
> > I've booted and tested these patches with AOSP on the HiKey960
> > using the kernel tree here:
> >    https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
> >
> > And the userspace changes here:
> >    https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
> >
> > Compared to ION, this patchset is missing the system-contig,
> > carveout and chunk heaps, as I don't have a device that uses
> > those, so I'm unable to do much useful validation there.
> > Additionally we have no upstream users of chunk or carveout,
> > and the system-contig has been deprecated in the common/andoid-*
> > kernels, so this should be ok.
> >
> > I've also removed the stats accounting for now, since any such
> > accounting should be implemented by dma-buf core or the heaps
> > themselves.
> >
> >
> > New in v6:
> > * Number of cleanups and error path fixes suggested by Brian Starkey,
> >    many thanks for his close review and suggestions!
> >
> >
> > Outstanding concerns:
> > * Need to better understand various secure heap implementations.
> >    Some concern that heap private flags will be needed, but its
> >    also possible that dma-buf heaps can't solve everyone's needs,
> >    in which case, a vendor's secure buffer driver can implement
> >    their own dma-buf exporter. So I'm not too worried here.
> >
>
> syzbot found a DoS with Ion which I ACKed a fix for.
> https://lore.kernel.org/lkml/03763360-a7de-de87-eb90-ba7838143930@I-love.SAKURA.ne.jp/
> This series doesn't have the page pooling so that particular bug may
> not be applicable but given this is not the first time I've
> seen Ion used as a DoS mechanism, it would be good to think about
> putting in some basic checks.

Yea, there's no shrinker right now (and my WIP page pool
implementation steals the network core's pagepool, which is statically
sized).

But the check in the alloc code seems reasonable so I can add it to
what I have. Appreciate the suggestion!

thanks
-john
