Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF0DC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68292238C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACZjWTcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfHGImm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:42:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45950 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387598AbfHGIml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:42:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id a30so357936lfk.12;
        Wed, 07 Aug 2019 01:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZCIYFLU/QqxvJmD6N25k1ThK9yzqr9P+sXe/g+qVhA=;
        b=ACZjWTcVyedqsssPi76pNEQDIYaPvTlg9+gkDz+lnA4jxT3vG30o2aA2GCnnbp4QVb
         2BWtv+KBfZO++n7V2dBBrGrj/jHjsuLpdhncdV7Iqx7ly0LL5SxZveoLLlAbY6OPHpqu
         wdPMPk9HlFIhLvnBiU9d4gNo64u/FNWcUsNxMw9ym7FTklxaZxWynyaBjSxFSad6vxIh
         eZlxPdXziYgcJ6SVgw88xlKkBcG15deL90G10TgkWFbDrA3xMWAgTB2WzpGDzWaye+yI
         kweaHIfeBxeFOjN/JDKWZvsFxptQTQje3OAWafwLrKcZGSJFhzkHvfe33C6TQFFo4vKU
         1KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZCIYFLU/QqxvJmD6N25k1ThK9yzqr9P+sXe/g+qVhA=;
        b=oPNSeJGHPLWnvdWzjmCh0hjrF2CiuLXLi4cpeXWVjMa6ZNmqrJKacFTC54fJQv7l6l
         fkIK1LJMAJ9bt/Q9HDmmvEADXvLUlP/rWafdI1GhiDEUdq3dQXFTbWyqY9c2xtMIJM/F
         zWo7mqJOfNL3ApiM+Io9UdW7OmYurj+Nm74KvIU1jjlGL2lkGeK0y7beKOBZgUcSYzwd
         hcDUn1K2EO4ygdH654KFV7c2sOrimKwXLu8/lUb0SUQEaHUdMQ3YfO83mhHiqk/R5hSY
         IzGVscf42qQBmEygzDr/t16J78J7vjwsAJQh6Yu39M+Uk8SNx4zOJUJrxNryd+vgUIpN
         l1oA==
X-Gm-Message-State: APjAAAW7Jy9BTw212Z4nQY6lUiAatbnhD7OaZz7dQrZS2k2GByE5dpP/
        NsXmW+uM69GiHk79nDwiAu8UqUUxhYfd4YhJFBFYUw==
X-Google-Smtp-Source: APXvYqwhPtDjlUXlpKJvnWBqdk0P2MeWQMwQAhD9reZJocWrrVsCJMCsrb1uRbHOFyGPgHo41OuEgapC6i7+/GIL4sk=
X-Received: by 2002:ac2:484e:: with SMTP id 14mr5156386lfy.50.1565167359193;
 Wed, 07 Aug 2019 01:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <1564514053-4571-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1564514053-4571-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 7 Aug 2019 14:12:27 +0530
Message-ID: <CAFqt6zZMgowAd-UvdEjydF=9HPY7bvXpWuzCqBLS7+3j_Dkgig@mail.gmail.com>
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

On Wed, Jul 31, 2019 at 12:38 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> This is dead code since 3.15. If there is no plan to use it
> further, this can be removed forever.

Any comment on this patch ?

>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/video/fbdev/aty/aty128fb.c   | 18 ------------------
>  drivers/video/fbdev/aty/atyfb_base.c | 29 -----------------------------
>  2 files changed, 47 deletions(-)
>
> diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
> index 8504e19..fc1e45d 100644
> --- a/drivers/video/fbdev/aty/aty128fb.c
> +++ b/drivers/video/fbdev/aty/aty128fb.c
> @@ -487,11 +487,6 @@ static int aty128_encode_var(struct fb_var_screeninfo *var,
>                               const struct aty128fb_par *par);
>  static int aty128_decode_var(struct fb_var_screeninfo *var,
>                               struct aty128fb_par *par);
> -#if 0
> -static void aty128_get_pllinfo(struct aty128fb_par *par, void __iomem *bios);
> -static void __iomem *aty128_map_ROM(struct pci_dev *pdev,
> -                                   const struct aty128fb_par *par);
> -#endif
>  static void aty128_timings(struct aty128fb_par *par);
>  static void aty128_init_engine(struct aty128fb_par *par);
>  static void aty128_reset_engine(const struct aty128fb_par *par);
> @@ -1665,19 +1660,6 @@ static void aty128_st_pal(u_int regno, u_int red, u_int green, u_int blue,
>                           struct aty128fb_par *par)
>  {
>         if (par->chip_gen == rage_M3) {
> -#if 0
> -               /* Note: For now, on M3, we set palette on both heads, which may
> -                * be useless. Can someone with a M3 check this ?
> -                *
> -                * This code would still be useful if using the second CRTC to
> -                * do mirroring
> -                */
> -
> -               aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) |
> -                           DAC_PALETTE_ACCESS_CNTL);
> -               aty_st_8(PALETTE_INDEX, regno);
> -               aty_st_le32(PALETTE_DATA, (red<<16)|(green<<8)|blue);
> -#endif
>                 aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) &
>                             ~DAC_PALETTE_ACCESS_CNTL);
>         }
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
> index 72bcfbe..6dda5d8 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -1188,19 +1188,6 @@ static int aty_crtc_to_var(const struct crtc *crtc,
>                 (c_sync ? FB_SYNC_COMP_HIGH_ACT : 0);
>
>         switch (pix_width) {
> -#if 0
> -       case CRTC_PIX_WIDTH_4BPP:
> -               bpp = 4;
> -               var->red.offset = 0;
> -               var->red.length = 8;
> -               var->green.offset = 0;
> -               var->green.length = 8;
> -               var->blue.offset = 0;
> -               var->blue.length = 8;
> -               var->transp.offset = 0;
> -               var->transp.length = 0;
> -               break;
> -#endif
>         case CRTC_PIX_WIDTH_8BPP:
>                 bpp = 8;
>                 var->red.offset = 0;
> @@ -1466,11 +1453,6 @@ static int atyfb_set_par(struct fb_info *info)
>                 var->bits_per_pixel,
>                 par->crtc.vxres * var->bits_per_pixel / 8);
>  #endif /* CONFIG_BOOTX_TEXT */
> -#if 0
> -       /* switch to accelerator mode */
> -       if (!(par->crtc.gen_cntl & CRTC_EXT_DISP_EN))
> -               aty_st_le32(CRTC_GEN_CNTL, par->crtc.gen_cntl | CRTC_EXT_DISP_EN, par);
> -#endif
>  #ifdef DEBUG
>  {
>         /* dump non shadow CRTC, pll, LCD registers */
> @@ -2396,17 +2378,6 @@ static int aty_init(struct fb_info *info)
>                         par->pll_ops = &aty_pll_ibm514;
>                         break;
>  #endif
> -#if 0 /* dead code */
> -               case CLK_STG1703:
> -                       par->pll_ops = &aty_pll_stg1703;
> -                       break;
> -               case CLK_CH8398:
> -                       par->pll_ops = &aty_pll_ch8398;
> -                       break;
> -               case CLK_ATT20C408:
> -                       par->pll_ops = &aty_pll_att20c408;
> -                       break;
> -#endif
>                 default:
>                         PRINTKI("aty_init: CLK type not implemented yet!");
>                         par->pll_ops = &aty_pll_unsupported;
> --
> 1.9.1
>
