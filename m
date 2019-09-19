Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8D8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE42721A49
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oHt8OtQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390029AbfISLle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 07:41:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41973 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388688AbfISLld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:41:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so2106019lfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nNrjxPSC8AHGfxG0lMrAaidSoqV4q9cpl9+1k/YpvU=;
        b=oHt8OtQPw7YIpcs+ggmuVlkDt5+ZHLP8pU62ps1F50yP2Mq99GOi7YIZWzUdP1vvTN
         3DNxGJbcAw+DAifYune3ghEWa0axHDSn0fDsEI+7C31jWgj8gMYO/8B48ryPJgfN5o98
         Lw3GJaFDIpvqVccDmowemr73vOQ9WBLpPfXDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nNrjxPSC8AHGfxG0lMrAaidSoqV4q9cpl9+1k/YpvU=;
        b=nOCN1H7jg2M1FDJUvgf5STUfOR5uM9Jl+x8T94u3sOesf4c+z632tJRaEPtGjo/f8C
         /whpOhVYwbjBUtqcoR1mXhKN2d9vx7Z+r6HqKszrNVvmJwoQ+3C0sOWgCzPMB3Ku708+
         e+VVVkF9c7mVIWkdk/KWtLjslb/uXfmfpW2zYcvKmlSuIUaETvYq0RDO4ZW6ZdPTHC3V
         rPhr4sMbizzMJ/9Ji91y4mopHxg9UHDQ8uKoKl7BAnYrC4cIcl8RhVyeMLKusjeZiASq
         m74MlDTrTtFdupZdJk5ReZ6CV7JdXrgLFcAinp/Aw9HEH3nQ8MBG4pz6/spWKezurLZW
         wX5Q==
X-Gm-Message-State: APjAAAUnKelBUHm1q+9mwuebWU2Pdy3+T5CS+lx16muU/iXUljNH5hAx
        jjFVFJBKuZG17eMIYLJVJsl5q5vXX1wvUJLDLcvs1Gb5fyA=
X-Google-Smtp-Source: APXvYqyKGXjzFhUnEwziug1SJbHE7sSdOCKixCmdPBoz1XKH6YbWhH6JmK0vS/eTih6UwjwouMb1f+PsVdfYBRyMSyc=
X-Received: by 2002:a19:6504:: with SMTP id z4mr4686680lfb.123.1568893290799;
 Thu, 19 Sep 2019 04:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190912094121.228435-1-tfiga@chromium.org> <20190912123821.rraib5entkcxt5p5@sirius.home.kraxel.org>
 <CAAFQd5AFXfu7ysFCi1XQS61DK8nbSk5-=UHkvpYWDtFae5YQ6Q@mail.gmail.com>
 <20190913080707.unhyoezesvfhx5np@sirius.home.kraxel.org> <CAAFQd5BUKdWkp7zvhLHyY+rjcwVLYXk1NKsrrfhoOHT_68T==Q@mail.gmail.com>
 <20190913110544.htmslqt4yzejugs4@sirius.home.kraxel.org>
In-Reply-To: <20190913110544.htmslqt4yzejugs4@sirius.home.kraxel.org>
From:   Keiichi Watanabe <keiichiw@chromium.org>
Date:   Thu, 19 Sep 2019 20:41:19 +0900
Message-ID: <CAD90VcZYXZDHMOfRUzbOFcauxrJC98OP6zxk_WS0aFKnXboTdg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Tomasz Figa <tfiga@chromium.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Stevens <stevensd@chromium.org>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Zach Reizner <zachr@chromium.org>,
        Pawel Osciak <posciak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 8:05 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > No.  DMA master address space in virtual machines is pretty much the
> > > same it is on physical machines.  So, on x86 without iommu, identical
> > > to (guest) physical address space.  You can't re-define it like that.
> >
> > That's not true. Even on x86 without iommu the DMA address space can
> > be different from the physical address space.
>
> On a standard pc (like the ones emulated by qemu) that is the case.
> It's different on !x86, it also changes with a iommu being present.
>
> But that is not the main point here.  The point is the dma master
> address already has a definition and you can't simply change that.
>
> > That could be still just
> > a simple addition/subtraction by constant, but still, the two are
> > explicitly defined without any guarantees about a simple mapping
> > between one or another existing.
>
> Sure.
>
> > "A CPU cannot reference a dma_addr_t directly because there may be
> > translation between its physical
> > address space and the DMA address space."
>
> Also note that dma address space is device-specific.  In case a iommu
> is present in the system you can have *multiple* dma address spaces,
> separating (groups of) devices from each other.  So passing a dma
> address from one device to another isn't going to work.
>
> > > > However, we could as well introduce a separate DMA address
> > > > space if resource handles are not the right way to refer to the memory
> > > > from other virtio devices.
> > >
> > > s/other virtio devices/other devices/
> > >
> > > dma-bufs are for buffer sharing between devices, not limited to virtio.
> > > You can't re-define that in some virtio-specific way.
> > >
> >
> > We don't need to limit this to virtio devices only. In fact I actually
> > foresee this having a use case with the emulated USB host controller,
> > which isn't a virtio device.
>
> What exactly?
>
> > That said, I deliberately referred to virtio to keep the scope of the
> > problem in control. If there is a solution that could work without
> > such assumption, I'm more than open to discuss it, of course.
>
> But it might lead to taking virtio-specific (or virtualization-specific)
> shortcuts which will hurt in the long run ...
>
> > As per my understanding of the DMA address, anything that lets the DMA
> > master access the target memory would qualify and there would be no
> > need for an IOMMU in between.
>
> Yes.  But that DMA address is already defined by the platform, you can't
> freely re-define it.  Well, you sort-of can when you design your own
> virtual iommu for qemu.  But even then you can't just pass around magic
> cookies masqueraded as dma address.  You have to make sure they actually
> form an address space, without buffers overlapping, ...
>
> > Exactly. The very specific first scenario that we want to start with
> > is allocating host memory through virtio-gpu and using that memory
> > both as output of a video decoder and as input (texture) to Virgil3D.
> > The memory needs to be specifically allocated by the host as only the
> > host can know the requirements for memory allocation of the video
> > decode accelerator hardware.
>
> So you probably have some virtio-video-decoder.  You allocate a gpu
> buffer, export it as dma-buf, import it into the decoder, then let the
> video decoder render to it.  Right?

Right. I sent an RFC about virtio-vdec (video decoder) to virtio-dev ML today.
https://lists.oasis-open.org/archives/virtio-dev/201909/msg00111.html

In the current design, the driver and the device uses an integer to identify a
DMA-buf. We call this integer a "resource handle" in the RFC. Our prototype
driver uses exposed virtio-gpu's resource handles for this purpose.

Regards,
Keiichi

>
> Using dmabufs makes sense for sure.  But we need an separate field in
> struct dma_buf for an (optional) host dmabuf identifier, we can't just
> hijack the dma address.
>
> cheers,
>   Gerd
>
