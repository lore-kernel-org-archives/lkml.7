Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2CBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C292053B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InvwlPug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbfJVP4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:56:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38026 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbfJVP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:56:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id e11so14622729otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5H56XdOux4SKyU8Ke1qZlotEUEu1Ct1El6M2VfKXQrI=;
        b=InvwlPuggw69FQ+wNV9b2DwABdDRrRxnQhNV+lvNJZxDm1O9d3EwMNJk3NcYkz+Zzu
         Xu4pfeAN/BpJeuW0jb+tvWQyIITLENhCjkoEEn1Gu1rZIh1pXRjbKwWVqb7sksaPYRJ1
         dLNSv1858/je85K4xejswBfzelyWsj0LDazReY9y/KMLz1L5bkjDWXqLdVm5nMvg/vfr
         5ThlE4qYsdk8MSy4T6e9+u9qdXIL0dnJpF+rVsDNGLBuMZ5sxWAA6q4vUQnAIB+1X6kB
         zFIbA2VLwgVdhrEj9qK4FaBSw9rxMdGuDJbGjET3Aw3htlmjbvjoGmqiQ4nB01i/WPLZ
         loVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5H56XdOux4SKyU8Ke1qZlotEUEu1Ct1El6M2VfKXQrI=;
        b=D442vdallXEvLQvYTN788CuPwk0QoGmkW6EghFZvhdGhFBzOLI87t5pxo9VLBfeloF
         9+3aq3A3HtO4XOuFvJRKXfP+8ozJo7ul9Tp8Phkr4tIJ9U53qFiTL65FlAx9e7/816ZH
         FLVSdy+EDp2KC6Kq34lqBq4qVIj6VsiwdxLyWKUQ5RnhOxm5yg7td6NT8hZRC/i99GqS
         GammWZKGl6yTPIafQrV43tMPQfEMF8LpRZOYsMXOJwhVP9wVIOim1VysvGrKoX7X5rPr
         cFenzWdDOqHDnqQ4Pp5UQ8/8ZZcwRkSgWxkWb5+OK00tFMVWPwRYaC1tDlxnjTZcJ6A3
         pDPg==
X-Gm-Message-State: APjAAAVPUNhy9GXQIzTjRn4JeAgJ35ll8pXuwTZEW2Jk3+rqt9uRL7B3
        +WaaxReLNkfqF3kmFnGaLLo50T6xN66xpK5/jCtSZQ==
X-Google-Smtp-Source: APXvYqz6gKDeTzzKXSy/uJQ/zq2wkX0+TEyXaw/1KWZiG/0F6OBcC1VMO1MNc2keyK1MQSzS0eQRFVCwmykBbgpFWyA=
X-Received: by 2002:a9d:630c:: with SMTP id q12mr3270558otk.332.1571759778722;
 Tue, 22 Oct 2019 08:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191021190310.85221-1-john.stultz@linaro.org> <be7286c7-3e67-4ffb-73b1-2622391d7c15@baylibre.com>
In-Reply-To: <be7286c7-3e67-4ffb-73b1-2622391d7c15@baylibre.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 22 Oct 2019 08:56:06 -0700
Message-ID: <CALAqxLVjp-qNyy8wjG+fJYQqafK5Fsf8rpb3bNe3_p0X9VLjRg@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] DMA-BUF Heaps (destaging ION)
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 1:21 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi John,
>
> On 21/10/2019 21:03, John Stultz wrote:
> > Lucky number 13! :)
> >
> > Last week in v12 I had re-added some symbol exports to support
> > later patches I have pending to enable loading heaps from
> > modules. He reminded me that back around v3 (its been awhile!) I
> > had removed those exports due to concerns about the fact that we
> > don't support module removal.
> >
> > So I'm respinning the patches, removing the exports again. I'll
> > submit a patch to re-add them in a later series enabling moduels
> > which can be reviewed indepently.
> >
> > With that done, lets get on to the boilerplate!
> >
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
> >   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
>
> Do you have a 4.19 tree with the changes ? I tried but the xarray idr replacement
> is missing... so I can't test with our android-amlogic-bmeson-4.19 tree.
>
> If you can provide, I'll be happy to test the serie and the gralloc changes.

Unfortunately I don't have a 4.19 version of dmabuf heaps (all the
work has been done this year, post 4.19). I'm planning to backport to
5.4 for AOSP, but I've not really thought about 4.19. Most likely I
won't have time to look at it until after the changes are upstream and
the 5.4 backport is done.

Is the bmeson tree likely to only stay at 4.19? Or will it move forward?

thanks
-john
