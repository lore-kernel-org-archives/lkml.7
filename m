Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAFDC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665942084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyoQZE1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfHNMX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:23:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41065 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfHNMX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:23:57 -0400
Received: by mail-lj1-f195.google.com with SMTP id m24so2153977ljg.8;
        Wed, 14 Aug 2019 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AolNVl1SiyR512yaUNd2gmXbn0Nylbkvufqr+Z0gL08=;
        b=EyoQZE1uJLpHHbghs66h89Na5MI6s00n49ipob2glBEKKgu1o9ouM1JfjIV7fF4LGO
         B+cBX1uwcuVafrdcVWA8XlP91dhuxGHFPyKWq4iM2rjiqxcmuNKkLJYOJ8XBox6Jdspp
         oWcoer4i9gNYMovhzfcfN7tFP4qtSuFVotcFDKBq+QNPesLJHNfS/HC7288A5AqMW+k+
         xh33EjcWXro//v9oiJe6pa810HIbJ+tP7uxfSlI2eSSJul0FlciI58/8FY0wMROLICHy
         4a1qajwDugtYFeabsqj4NYB6gLmELnWFY+yEfb07X0S38SoC+AkYUp7g6hYkvsBucbMO
         an7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AolNVl1SiyR512yaUNd2gmXbn0Nylbkvufqr+Z0gL08=;
        b=oAu+Apr0cvjCNLIJAR+C/GKTzmpI+bBNPeSv+xim1ntzrjVkx1+qzyqjDJnxJwBXQo
         LiiF7gWe7EBjQ8qspoNgLx7cZjM5fJezdKRL8BQnOiHU3o1GtobF/CboWLYRubKg2Ao6
         hY5EvRPOg6Km9AhchByvfzqXBuTeC/KJCJRqScJ5S/eRlA6GhYg8FQZ6nsd0we9V0/Jq
         c1BEgA17AHrHdpnF4C/4TUUwkfhFhECpdvBxIcVLIaJOY++DhuqeiaVG3tQvvX43GlYA
         hrOokJH/UbHBe55u0tHQkR7+HLrGTDvVRs9eSeyMBeS+S7qXdbwyXAiYMO0uFqvheYzY
         AfeA==
X-Gm-Message-State: APjAAAXvp9hkuWBCMdrQyscaaxoP2eKwfdLF67peOPtvNxbz6VERasSq
        6PqnL9t4rI8jQ+BUkwmJgXU8v3lKSt6igpYeuNM=
X-Google-Smtp-Source: APXvYqxkyCp7vFsrjJSIDpKqXAn9uDLjPT0VbzMFs9lf3GyT0bRhmvBGiTElQpr+TV3SPbhWua2msp9bOqyXGMiTPaI=
X-Received: by 2002:a05:651c:153:: with SMTP id c19mr16325169ljd.152.1565785434927;
 Wed, 14 Aug 2019 05:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <1564514053-4571-1-git-send-email-jrdr.linux@gmail.com> <CAFqt6zZMgowAd-UvdEjydF=9HPY7bvXpWuzCqBLS7+3j_Dkgig@mail.gmail.com>
In-Reply-To: <CAFqt6zZMgowAd-UvdEjydF=9HPY7bvXpWuzCqBLS7+3j_Dkgig@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 14 Aug 2019 17:53:43 +0530
Message-ID: <CAFqt6zaQEX60_KL-m+K7VYQU=z144u=yfeVjPtGVaiAj5NbBaQ@mail.gmail.com>
Subject: Re: [PATCH] video/fbdev/aty128fb: Remove dead code
To:     Paul Mackerras <paulus@samba.org>, b.zolnierkie@samsung.com,
        "David S. Miller" <davem@davemloft.net>, mpatocka@redhat.com,
        syrjala@sci.fi, sam@ravnborg.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 2:12 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Wed, Jul 31, 2019 at 12:38 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > This is dead code since 3.15. If there is no plan to use it
> > further, this can be removed forever.
>
> Any comment on this patch ?

Any comment on this patch ?

>
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/video/fbdev/aty/aty128fb.c   | 18 ------------------
> >  drivers/video/fbdev/aty/atyfb_base.c | 29 -----------------------------
> >  2 files changed, 47 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
> > index 8504e19..fc1e45d 100644
> > --- a/drivers/video/fbdev/aty/aty128fb.c
> > +++ b/drivers/video/fbdev/aty/aty128fb.c
> > @@ -487,11 +487,6 @@ static int aty128_encode_var(struct fb_var_screeninfo *var,
> >                               const struct aty128fb_par *par);
> >  static int aty128_decode_var(struct fb_var_screeninfo *var,
> >                               struct aty128fb_par *par);
> > -#if 0
> > -static void aty128_get_pllinfo(struct aty128fb_par *par, void __iomem *bios);
> > -static void __iomem *aty128_map_ROM(struct pci_dev *pdev,
> > -                                   const struct aty128fb_par *par);
> > -#endif
> >  static void aty128_timings(struct aty128fb_par *par);
> >  static void aty128_init_engine(struct aty128fb_par *par);
> >  static void aty128_reset_engine(const struct aty128fb_par *par);
> > @@ -1665,19 +1660,6 @@ static void aty128_st_pal(u_int regno, u_int red, u_int green, u_int blue,
> >                           struct aty128fb_par *par)
> >  {
> >         if (par->chip_gen == rage_M3) {
> > -#if 0
> > -               /* Note: For now, on M3, we set palette on both heads, which may
> > -                * be useless. Can someone with a M3 check this ?
> > -                *
> > -                * This code would still be useful if using the second CRTC to
> > -                * do mirroring
> > -                */
> > -
> > -               aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) |
> > -                           DAC_PALETTE_ACCESS_CNTL);
> > -               aty_st_8(PALETTE_INDEX, regno);
> > -               aty_st_le32(PALETTE_DATA, (red<<16)|(green<<8)|blue);
> > -#endif
> >                 aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) &
> >                             ~DAC_PALETTE_ACCESS_CNTL);
> >         }
> > diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
> > index 72bcfbe..6dda5d8 100644
> > --- a/drivers/video/fbdev/aty/atyfb_base.c
> > +++ b/drivers/video/fbdev/aty/atyfb_base.c
> > @@ -1188,19 +1188,6 @@ static int aty_crtc_to_var(const struct crtc *crtc,
> >                 (c_sync ? FB_SYNC_COMP_HIGH_ACT : 0);
> >
> >         switch (pix_width) {
> > -#if 0
> > -       case CRTC_PIX_WIDTH_4BPP:
> > -               bpp = 4;
> > -               var->red.offset = 0;
> > -               var->red.length = 8;
> > -               var->green.offset = 0;
> > -               var->green.length = 8;
> > -               var->blue.offset = 0;
> > -               var->blue.length = 8;
> > -               var->transp.offset = 0;
> > -               var->transp.length = 0;
> > -               break;
> > -#endif
> >         case CRTC_PIX_WIDTH_8BPP:
> >                 bpp = 8;
> >                 var->red.offset = 0;
> > @@ -1466,11 +1453,6 @@ static int atyfb_set_par(struct fb_info *info)
> >                 var->bits_per_pixel,
> >                 par->crtc.vxres * var->bits_per_pixel / 8);
> >  #endif /* CONFIG_BOOTX_TEXT */
> > -#if 0
> > -       /* switch to accelerator mode */
> > -       if (!(par->crtc.gen_cntl & CRTC_EXT_DISP_EN))
> > -               aty_st_le32(CRTC_GEN_CNTL, par->crtc.gen_cntl | CRTC_EXT_DISP_EN, par);
> > -#endif
> >  #ifdef DEBUG
> >  {
> >         /* dump non shadow CRTC, pll, LCD registers */
> > @@ -2396,17 +2378,6 @@ static int aty_init(struct fb_info *info)
> >                         par->pll_ops = &aty_pll_ibm514;
> >                         break;
> >  #endif
> > -#if 0 /* dead code */
> > -               case CLK_STG1703:
> > -                       par->pll_ops = &aty_pll_stg1703;
> > -                       break;
> > -               case CLK_CH8398:
> > -                       par->pll_ops = &aty_pll_ch8398;
> > -                       break;
> > -               case CLK_ATT20C408:
> > -                       par->pll_ops = &aty_pll_att20c408;
> > -                       break;
> > -#endif
> >                 default:
> >                         PRINTKI("aty_init: CLK type not implemented yet!");
> >                         par->pll_ops = &aty_pll_unsupported;
> > --
> > 1.9.1
> >
