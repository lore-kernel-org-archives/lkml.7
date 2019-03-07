Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D172820854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="K+llDEhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfCGQDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:03:54 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38364 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:03:51 -0500
Received: by mail-it1-f193.google.com with SMTP id l66so16543174itg.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 08:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2y0GVYz6AnYKHYEicTiFYJndOjdiTojvKaDqk2VR/BE=;
        b=K+llDEhWjn7SUUloQXC0cwNwaQbjhhDycir/ZfQ7DPPTDPhMUqCUlrsvgP4YNK1eaY
         8iDnZ6oBYHjSKT5/Q4emdD+SredTEQ2oBqWFJ3X5UtgH09FR0X0cGG7wb8et9VHwMa8H
         HQNYym0ECYWzC7Lh5XW4u2yDC0KWML+GGCgyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2y0GVYz6AnYKHYEicTiFYJndOjdiTojvKaDqk2VR/BE=;
        b=eny6WorQTfmkZ4iQyFV87DeEOvsoeHFXly86XeW9xKCArHW+1U+FNcfgbJQyy4eodt
         etDMO/9HAZ7a5k4B/MCnUZIsAje4vbxZoHCjJ0i1VhN/1aofhj8OANdA7qIs7JUcjZ32
         DmR6GcAmmGNYqMAN9foXaZr4MmsXo+3oY/0EeEPaSp1V3VT5wf1naLQcFWPUUEmz/eym
         BcjtgusZsAjnBjgph8W9ws7xVnhhdM/Yz0hAbjM2RF3wLRhcxfPNXNETD8uADuES7gAp
         jIdDb6eTCGQPCcUZ3F2JmWqaqfN/OnTW732YxWDXikuVmdnMCPHtgoIuCKY4KpIGQTQo
         /3Nw==
X-Gm-Message-State: APjAAAW7UC9eXg2lgCUlZjU/sHtSwqFIFdnGYLu62hvexdFL4M4jUrBN
        IhLlHaqSAq1TEC9lBB0Ejuzt5JTlKl/mLXWidOrANA==
X-Google-Smtp-Source: APXvYqxZQ167GoVOieRKHTbrX1jDTAEo/1tcamP4AiUbQpDaIbJWjyuf8c0Qs6ZNjSHm+eDpD65nRdqzk2lJcu/d6/o=
X-Received: by 2002:a05:660c:252:: with SMTP id t18mr5856060itk.173.1551974630117;
 Thu, 07 Mar 2019 08:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-4-jagan@amarulasolutions.com> <20190304154911.s6rcx6bzal5slcjk@flea>
In-Reply-To: <20190304154911.s6rcx6bzal5slcjk@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 7 Mar 2019 21:33:38 +0530
Message-ID: <CAMty3ZBVh_PTYB-HmLCUuRsH+4NU=CaeXdKtNYqEDHHZuRGCvw@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] drm/sun4i: sun6i_mipi_dsi: Support vblk timing for
 4-lane devices
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 9:19 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sun, Mar 03, 2019 at 11:05:25PM +0530, Jagan Teki wrote:
> > Like other dsi setup timings, or hblk for that matter vblk would
> > also require compute the timings based payload equation along with
> > packet overhead.
> >
> > But, on the other hand vblk computation is also depends on device
> > lane number.
> > - for 4 lane devices, it is computed based on vtotal, packet overhead
> >   along with hblk value.
> > - for others devices, it is simply 0
> >
> > BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
> > (from linux-sunxi
> > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> >
> > tmp = (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
> > dsi_vblk = (lane-tmp%lane);
> >
> > So, update the vblk timing calculation to support all type of
> > devices.
> >
> > Tested on 2-lane, 4-lane MIPI-DSI LCD panels.
>
> You should be explaining which issue you faced, in which setup, what
> were its symptoms and how that solution is fixing it.

No, it is not a fix, didn't specify either. it is vblk timings support
like others dsi timings.

>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 27 +++++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 140e55f5ed2e..b38358465d87 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -527,6 +527,24 @@ static void sun6i_dsi_setup_format(struct sun6i_dsi *dsi,
> >                    SUN6I_DSI_PIXEL_CTL0_FORMAT(fmt));
> >  }
> >
> > +static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
> > +                                   struct drm_display_mode *mode, u16 hblk)
> > +{
> > +     struct mipi_dsi_device *device = dsi->device;
> > +     unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> > +     int tmp;
> > +
> > +     /*
> > +      * The vertical blank is set using a blanking packet (4 bytes +
> > +      * payload + 2 bytes). Its minimal size is therefore 6 bytes
> > +      */
> > +#define VBLK_PACKET_OVERHEAD 6
> > +     tmp = (mode->htotal * Bpp) * mode->vtotal -
> > +           (hblk + VBLK_PACKET_OVERHEAD);
> > +
> > +     return (device->lanes - tmp % device->lanes);
>
> This should have a comment explaining why it's needed

Grabbed from BSP as I mentioned in the commit message, to satisfy the
proper dsi timing initialization.

>
> > +}
> > +
> >  static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
> >                                   struct drm_display_mode *mode)
> >  {
> > @@ -586,13 +604,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
> >                          (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
> >                          HBLK_PACKET_OVERHEAD);
> >
> > -             /*
> > -              * And I'm not entirely sure what vblk is about. The driver in
> > -              * Allwinner BSP is using a rather convoluted calculation
> > -              * there only for 4 lanes. However, using 0 (the !4 lanes
> > -              * case) even with a 4 lanes screen seems to work...
> > -              */
> > -             vblk = 0;
> > +             if (device->lanes == 4)
>
> And that can be done in the function itself.

Since vblk is initialized to 0 starting of the function, I'm calling
directly this for 4-lane, because for rest it's 0 on non-burst mode.
