Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE50C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C1C206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA7hJ9sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbfHOOQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:16:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52760 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731822AbfHOOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:16:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id o4so1411538wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g7r3/G3ET2/s3rUh/zhKhhzy8l5R1Xj1DL/jrTHw2D8=;
        b=eA7hJ9sDeYIj8eCjfYma1li7OuWBTEj1rPCrp3WU1bfdjdlYy2YDvsLmD+sgXR4zIn
         LlPtHxA+2++PfNGL7jr7J812GjDEj1INXFoyo9hi/dAEEJbdiz16ndBhIqfa2ahganYT
         7HflBnEg4XvDdbLvp8oLTLSyMbUe8tlw8iwRY1NvxSwe5zEtMZaqf3scgOOaWc/LHIrb
         XHhWaXanfrlmB/H/WqxEFfgKFdUSew15GE6Nosq0BQrEVaOpEqs9rsnH3XH9wi6eI+kz
         gn+RIowAucOdpxQMr5hiRLruV+17NS4oa/t3Tiy0G/yhAWyo96Acw7svodHxF7BXgzCO
         cbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g7r3/G3ET2/s3rUh/zhKhhzy8l5R1Xj1DL/jrTHw2D8=;
        b=KH4zafj+ki+PYytBadEc4rRDCY/sTGKVSAwXAT4X9F7UdPHYrat1kRXmipgW0vFmPV
         i+6zLccQ3sJ6Nqmt8Lfrl5qdHE//O9EbUTUUhOcvgA/3dQIaVZajc+MHOHTJG4KVbDs9
         9HMOBu5PAg0cU+uU3Wa964M6JpyuGFvFjnpaZOzyHVBvaoqbshtiTZfC321ciI2dh8b9
         JkFj1jRFmtAo015WHDZLqaIAEAZRuhrhos1JQB2wr444OnBhsWmedJwFUBgIqXedEYti
         B+pDhQXBHIsDv8mHS08HoTYgXI34lzSuC8tOf0uxvMbqgBmmB3wxp/RSG1qlM6FBlQSV
         c5cw==
X-Gm-Message-State: APjAAAUD/0NFaAkeL3RLgvxrqnWXp/a0vizoogz5Tits4KK8R0q9VI8n
        gmWj0YiBtUU7NKzw/+uiUI1RB8G3wLG/RsnsPfUNmg==
X-Google-Smtp-Source: APXvYqxYxFj+8NEpeA7ypMOLQ2R5uOz8SubNVIZRpXl6vL9+7e6xt+mvxG7avqJChc9JI6kuxTtGKXMqMR1Ng+IfWJA=
X-Received: by 2002:a05:600c:352:: with SMTP id u18mr2986702wmd.141.1565878560094;
 Thu, 15 Aug 2019 07:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190815072703.7010-1-hch@lst.de> <20190815072703.7010-2-hch@lst.de>
 <d1cf1435-92e3-edb5-c239-18c71f2d27c7@amd.com>
In-Reply-To: <d1cf1435-92e3-edb5-c239-18c71f2d27c7@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Aug 2019 10:15:48 -0400
Message-ID: <CADnq5_NghUyn1K7ed6E_vk-8SgLXKj3QpriGRxbNDChdb0hU5Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/radeon: handle PCIe root ports with addressing limitations
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 4:34 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 15.08.19 um 09:27 schrieb Christoph Hellwig:
> > radeon uses a need_dma32 flag to indicate to the drm core that some
> > allocations need to be done using GFP_DMA32, but it only checks the
> > device addressing capabilities to make that decision.  Unfortunately
> > PCIe root ports that have limited addressing exist as well.  Use the
> > dma_addressing_limited instead to also take those into account.
> >
> > Reported-by: Atish Patra <Atish.Patra@wdc.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Looks sane to me. Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd=
.com>.

Is this for the full series or just this patch?

Alex

>
> Should we merge this through our normal amdgpu/radeon branches or do you
> want to send this upstream somehow else?
>
> Thanks,
> Christian.
>
> > ---
> >   drivers/gpu/drm/radeon/radeon.h        |  1 -
> >   drivers/gpu/drm/radeon/radeon_device.c | 12 +++++-------
> >   drivers/gpu/drm/radeon/radeon_ttm.c    |  2 +-
> >   3 files changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/r=
adeon.h
> > index 32808e50be12..1a0b22526a75 100644
> > --- a/drivers/gpu/drm/radeon/radeon.h
> > +++ b/drivers/gpu/drm/radeon/radeon.h
> > @@ -2387,7 +2387,6 @@ struct radeon_device {
> >       struct radeon_wb                wb;
> >       struct radeon_dummy_page        dummy_page;
> >       bool                            shutdown;
> > -     bool                            need_dma32;
> >       bool                            need_swiotlb;
> >       bool                            accel_working;
> >       bool                            fastfb_working; /* IGP feature*/
> > diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/r=
adeon/radeon_device.c
> > index dceb554e5674..b8cc05826667 100644
> > --- a/drivers/gpu/drm/radeon/radeon_device.c
> > +++ b/drivers/gpu/drm/radeon/radeon_device.c
> > @@ -1365,27 +1365,25 @@ int radeon_device_init(struct radeon_device *rd=
ev,
> >       else
> >               rdev->mc.mc_mask =3D 0xffffffffULL; /* 32 bit MC */
> >
> > -     /* set DMA mask + need_dma32 flags.
> > +     /* set DMA mask.
> >        * PCIE - can handle 40-bits.
> >        * IGP - can handle 40-bits
> >        * AGP - generally dma32 is safest
> >        * PCI - dma32 for legacy pci gart, 40 bits on newer asics
> >        */
> > -     rdev->need_dma32 =3D false;
> > +     dma_bits =3D 40;
> >       if (rdev->flags & RADEON_IS_AGP)
> > -             rdev->need_dma32 =3D true;
> > +             dma_bits =3D 32;
> >       if ((rdev->flags & RADEON_IS_PCI) &&
> >           (rdev->family <=3D CHIP_RS740))
> > -             rdev->need_dma32 =3D true;
> > +             dma_bits =3D 32;
> >   #ifdef CONFIG_PPC64
> >       if (rdev->family =3D=3D CHIP_CEDAR)
> > -             rdev->need_dma32 =3D true;
> > +             dma_bits =3D 32;
> >   #endif
> >
> > -     dma_bits =3D rdev->need_dma32 ? 32 : 40;
> >       r =3D pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
> >       if (r) {
> > -             rdev->need_dma32 =3D true;
> >               dma_bits =3D 32;
> >               pr_warn("radeon: No suitable DMA available\n");
> >       }
> > diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/rade=
on/radeon_ttm.c
> > index fb3696bc616d..116a27b25dc4 100644
> > --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > @@ -794,7 +794,7 @@ int radeon_ttm_init(struct radeon_device *rdev)
> >       r =3D ttm_bo_device_init(&rdev->mman.bdev,
> >                              &radeon_bo_driver,
> >                              rdev->ddev->anon_inode->i_mapping,
> > -                            rdev->need_dma32);
> > +                            dma_addressing_limited(&rdev->pdev->dev));
> >       if (r) {
> >               DRM_ERROR("failed initializing buffer object driver(%d).\=
n", r);
> >               return r;
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
