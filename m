Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C27AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C403F21773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YSpTPlMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfG2WEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:04:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36310 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfG2WEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:04:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id q4so17262799oij.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWkU2/nir7ZQfvW4i66MunEPrc2ksPHZ+kI417Vwor0=;
        b=YSpTPlMeCYYov7BuvMIOVP4Mbjnyr+tyM3byOHdUesUddEkSMTdk3VN0J5EVFcO5AA
         60elu2KlvLQ7lbDIJNkKFyLm/z9m97CbYD/J723A4PhsO4MTQiDYTKtSefUUNGurPUOQ
         Ol+MGNxjX5/jPtRV8JWa3rmBQ9b9icxpWWGsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWkU2/nir7ZQfvW4i66MunEPrc2ksPHZ+kI417Vwor0=;
        b=LozsS2q6u83LfNUozO9ZIdEbQkoE70pwBJvFcpg/sGNt3nC8/F/pZle44XnbEeeGrM
         b8ANQrFnTfoufGm91sHj+jHVi0qQj/tsKgK5gAi/DSr83mgMXbpkOcIFKpxvVXgYg9PP
         74jOGNu9+Nck1vJi/f3hIW4OhVvQ1Gfnxt/6eYpS5n2ko+AlYqycbYlZMujLCfzuhyMh
         ZXKd0B9wZjaIGy3plMKeYWEBYW2V4PrfUlyJ30GGLmPPWe5YNnjMQufyUFyUyFVQVg5D
         qnddr54zNM46op2Hs65LfSNq9QkX1ovqHrpUi5vVhfeqQftxWHfenh27hoPh5nyVLRE3
         g3NQ==
X-Gm-Message-State: APjAAAW2FJJezSdRNZKGwn4lSXVNoTJ/e1oF1OX9yR+7O3zsB8/LdZLo
        LttIa95nClWN81OBJEo+Es1+QozstS5lCcIPUmU=
X-Google-Smtp-Source: APXvYqzxoYmsrKa+/w4iZlFyZ+r721up9sOSNNUO05B9bQZK5PB1hT9YRKjmerl1KT4H08nbG3IA1hv+pMyhSISgMfg=
X-Received: by 2002:a05:6808:118:: with SMTP id b24mr56856483oie.128.1564437844733;
 Mon, 29 Jul 2019 15:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190725110520.26848-1-oleksandr.suvorov@toradex.com>
 <20190725113237.d2dwxzientte4j3n@flea> <CAGgjyvEA54kR3U8Lyz-1-vPS74raT6SpoM0e8YYcm12T=0r50A@mail.gmail.com>
In-Reply-To: <CAGgjyvEA54kR3U8Lyz-1-vPS74raT6SpoM0e8YYcm12T=0r50A@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 30 Jul 2019 00:03:53 +0200
Message-ID: <CAKMK7uHNyP0XAkPZ4dSfdAzcrvzNSHc8J02rwh0nLCSnPu_d2Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] This patch fixes connection detection for monitors
 w/o DDC.
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Suvorov Alexander <cryosay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:58 PM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
> On Thu, Jul 25, 2019 at 5:41 PM maxime.ripard@free-electrons.com
> <maxime.ripard@free-electrons.com> wrote:
> >
> > On Thu, Jul 25, 2019 at 11:05:23AM +0000, Oleksandr Suvorov wrote:
> > >
> > > Even in source code of this driver there is an author's description:
> > >     /*
> > >      * Even if we have an I2C bus, we can't assume that the cable
> > >      * is disconnected if drm_probe_ddc fails. Some cables don't
> > >      * wire the DDC pins, or the I2C bus might not be working at
> > >      * all.
> > >      */
> > >
> > > That's true. DDC and VGA channels are independent, and therefore
> > > we cannot decide whether the monitor is connected or not,
> > > depending on the information from the DDC.
> > >
> > > So the monitor should always be considered connected.
> >
> > Well, no. Like you said, we cannot decided whether is connected or
> > not.
>
> Maxime, thanks, I agree that's a bad solution.
> But I still think we should be able to define the DT node of a device for
> this driver to claim the connector is always connected.
> Please see my following thoughts.
>
> > > Thus there is no reason to use connector detect callback for this
> > > driver: DRM sub-system considers monitor always connected if there
> > > is no detect() callback registered with drm_connector_init().
> > >
> > > How to reproduce the bug:
> > > * setup: i.MX8QXP, LCDIF video module + gpu/drm/mxsfb driver,
> > >   adv712x VGA DAC + dumb-vga-dac driver, VGA-connector w/o DDC;
> > > * try to use drivers chain mxsfb-drm + dumb-vga-dac;
> > > * any DRM applications consider the monitor is not connected:
> > >   ===========
> > >   $ weston-start
> > >   $ cat /var/log/weston.log
> > >       ...
> > >       DRM: head 'VGA-1' found, connector 32 is disconnected.
> > >       ...
> > >   $ cat /sys/devices/platform/5a180000.lcdif/drm/card0/card0-VGA-1/status
> > >   unknown
> >
> > And that's exactly what's being reported here: we cannot decide if it
> > is connected or not, so it's unknown.
> >
> > If weston chooses to ignore connectors that are in an unknown state,
> > I'd say it's weston's problem, since it's much broader than this
> > particular device.
>
> If we look at the code of drm_probe_helper.c, we can see, the
> drm_helper_probe_detect_ctx() assume the cable is connected if there is no
> detect() callback registered.
> ...
>                 if (funcs->detect_ctx)
>                          ret = funcs->detect_ctx(connector, &ctx, force);
>                  else if (connector->funcs->detect)
>                          ret = connector->funcs->detect(connector, force);
>                  else
>                          ret = connector_status_connected;
> ...
>
> The driver dumb-vga-dac supports both DT configurations:
> - with DDC channel, that allows us to detect if the cable is connected;
> - without DDC channel. In this case, IMHO, the driver should behave
> the same way as a
>   connector driver without registered detect() callback.
>
> So what about the patch like?

Still no. The "always connected" case is for outputs which are
physically always connected and typing a dummy function which would
unconditionally return connected would be silly. Like built-in panels.
This is _not_ for external screens.
-Daniel

>
> @@ -81,6 +81,13 @@ dumb_vga_connector_detect(struct drm_connector
> *connector, bool force)
>  {
>         struct dumb_vga *vga = drm_connector_to_dumb_vga(connector);
>
> +       /*
> +        * If I2C bus for DDC is not defined, asume that the cable
> +        * is always connected.
> +        */
> +       if (PTR_ERR(vga->ddc) == -ENODEV)
> +               return connector_status_connected;
> +
>         /*
>          * Even if we have an I2C bus, we can't assume that the cable
>          * is disconnected if drm_probe_ddc fails. Some cables don't
>
> --
> Best regards
> Oleksandr Suvorov
>
> Toradex AG
> Altsagenstrasse 5 | 6048 Horw/Luzern | Switzerland | T: +41 41 500
> 4800 (main line)



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
