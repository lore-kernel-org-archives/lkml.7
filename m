Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA722C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8183720830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a8Gy6ADr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbfIMIcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:32:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36676 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbfIMIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:32:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id f2so19967435edw.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fg561yMuO77l6EwrcS5uC/U69LFnwV0/kL0h3hd/D/E=;
        b=a8Gy6ADr33Gj3JqkIIegVOtHPKD+OOa/m+0myEhAXBgNsIBpTIzVUtfN6xUaMcNpxn
         zxwD0bZMXgTaGi5jU6Z+1qqBylt3w7YSKKnPAP6QkEBMVlKpk5yUlAjdtFn3HqAqCYza
         wzH2+P6msHitgv4HDCVInAQffZpF0c4pji25g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fg561yMuO77l6EwrcS5uC/U69LFnwV0/kL0h3hd/D/E=;
        b=hdQQu8AdnvpRhoQVv0Ju1Ql6llDaBSghHDJko7Jfny+qS0oYUMUV06lKTvMLRLUzzp
         OEEhhk+ZUeSLVnOXeGoZdL4OVjCrYCkDssCMuI55f8uIZM93j7Ncz9uy4XosU0R5ttju
         eAgM348fmk14qDJBJF2xjWOyGMsrSuAZNpRaiGMvAG5XwC7sMQjPGkeqpc3iC/VqzIFg
         jZCBKsAnpaS2FYDETWw14glRXrTdJyupqfWyRh9e61aUmoLhhbqXihlCRiSNGZhIOynF
         gq8+QcbrYTH6l6tEF8U9djsxX5jcr7Erl2+tm69g29IqY0wieqlVJGPcXZgOETUhUgut
         MtqQ==
X-Gm-Message-State: APjAAAWAWHkfJ4p4yb7bWIhnmEfn1EL8n9kkWjGocAVaYQhWXwrOP1/p
        3DXp6DNzyzZrHJ24H2Xnvu5NanEkKJ+9QQ==
X-Google-Smtp-Source: APXvYqyPSQr8xUGAltFCVP9CrpGmqWnQb38+FvnDR4pxskPaJtO0w2Z+8zgJWS70AS0+GQambbZQPg==
X-Received: by 2002:a17:906:2458:: with SMTP id a24mr38249437ejb.69.1568363524444;
        Fri, 13 Sep 2019 01:32:04 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id e44sm1111635ede.34.2019.09.13.01.32.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 01:32:03 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id n10so1781670wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 01:32:03 -0700 (PDT)
X-Received: by 2002:a1c:f002:: with SMTP id a2mr2514627wmb.113.1568363523190;
 Fri, 13 Sep 2019 01:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190912094121.228435-1-tfiga@chromium.org> <20190912123821.rraib5entkcxt5p5@sirius.home.kraxel.org>
 <CAAFQd5AFXfu7ysFCi1XQS61DK8nbSk5-=UHkvpYWDtFae5YQ6Q@mail.gmail.com> <20190913080707.unhyoezesvfhx5np@sirius.home.kraxel.org>
In-Reply-To: <20190913080707.unhyoezesvfhx5np@sirius.home.kraxel.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 13 Sep 2019 17:31:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BUKdWkp7zvhLHyY+rjcwVLYXk1NKsrrfhoOHT_68T==Q@mail.gmail.com>
Message-ID: <CAAFQd5BUKdWkp7zvhLHyY+rjcwVLYXk1NKsrrfhoOHT_68T==Q@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stevensd@chromium.org,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Zach Reizner <zachr@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Pawel Osciak <posciak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 5:07 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > > To seamlessly enable buffer sharing with drivers using such frameworks,
> > > > make the virtio-gpu driver expose the resource handle as the DMA address
> > > > of the buffer returned from the DMA-buf mapping operation.  Arguably, the
> > > > resource handle is a kind of DMA address already, as it is the buffer
> > > > identifier that the device needs to access the backing memory, which is
> > > > exactly the same role a DMA address provides for native devices.
> >
> > First of all, thanks for taking a look at this.
> >
> > > No.  A scatter list has guest dma addresses, period.  Stuffing something
> > > else into a scatterlist is asking for trouble, things will go seriously
> > > wrong when someone tries to use such a fake scatterlist as real scatterlist.
> >
> > What is a "guest dma address"? The definition of a DMA address in the
> > Linux DMA API is an address internal to the DMA master address space.
> > For virtio, the resource handle namespace may be such an address
> > space.
>
> No.  DMA master address space in virtual machines is pretty much the
> same it is on physical machines.  So, on x86 without iommu, identical
> to (guest) physical address space.  You can't re-define it like that.
>

That's not true. Even on x86 without iommu the DMA address space can
be different from the physical address space. That could be still just
a simple addition/subtraction by constant, but still, the two are
explicitly defined without any guarantees about a simple mapping
between one or another existing.

See https://www.kernel.org/doc/Documentation/DMA-API.txt

"A CPU cannot reference a dma_addr_t directly because there may be
translation between its physical
address space and the DMA address space."

> > However, we could as well introduce a separate DMA address
> > space if resource handles are not the right way to refer to the memory
> > from other virtio devices.
>
> s/other virtio devices/other devices/
>
> dma-bufs are for buffer sharing between devices, not limited to virtio.
> You can't re-define that in some virtio-specific way.
>

We don't need to limit this to virtio devices only. In fact I actually
foresee this having a use case with the emulated USB host controller,
which isn't a virtio device.

That said, I deliberately referred to virtio to keep the scope of the
problem in control. If there is a solution that could work without
such assumption, I'm more than open to discuss it, of course.

> > > Also note that "the DMA address of the buffer" is bonkers in virtio-gpu
> > > context.  virtio-gpu resources are not required to be physically
> > > contigous in memory, so typically you actually need a scatter list to
> > > describe them.
> >
> > There is no such requirement even on a bare metal system, see any
> > system that has an IOMMU, which is typical on ARM/ARM64. The DMA
> > address space must be contiguous only from the DMA master point of
> > view.
>
> Yes, the iommu (if present) could remap your scatterlist that way.  You
> can't depend on that though.

The IOMMU doesn't need to exist physically, though. After all, guest
memory may not be physically contiguous in the host already, but with
your definition of DMA address we would refer to it as contiguous. As
per my understanding of the DMA address, anything that lets the DMA
master access the target memory would qualify and there would be no
need for an IOMMU in between.

>
> What is the plan here?  Host-side buffer sharing I guess?  So you are
> looking for some way to pass buffer handles from the guest to the host,
> even in case those buffers are not created by your driver but imported
> from somewhere else?

Exactly. The very specific first scenario that we want to start with
is allocating host memory through virtio-gpu and using that memory
both as output of a video decoder and as input (texture) to Virgil3D.
The memory needs to be specifically allocated by the host as only the
host can know the requirements for memory allocation of the video
decode accelerator hardware.

Best regards,
Tomasz
