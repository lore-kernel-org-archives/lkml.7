Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9730BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6371420640
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GVFJS0g6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLDHFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:05:06 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38107 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfLDHFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:05:05 -0500
Received: by mail-vs1-f65.google.com with SMTP id y195so4179307vsy.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 23:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZctKunwgyLMVHuNRAeQfQcDadwdKlFmTmC1zk4+eNo=;
        b=GVFJS0g6vusTIy7E8yDWR6wEBrqyHeA/dvrCjpzmFkRp6jwsN7tfaDhypIWgm+48GS
         ajWWcNcJDaP2rqZnhxN0+YUkHQ3gIRQPwRr/haAfv4I3YFxFfrDZKdSoy38RzQzG2bZl
         Q7CT8OHqOU2HIL1zI4nORvbwbSgfYgOvxu1nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZctKunwgyLMVHuNRAeQfQcDadwdKlFmTmC1zk4+eNo=;
        b=XkoAsi8Dcb6eT7spSri4dSYGY7sF23pcQhCSc861NH1koaORTftCZBNPy3iBUvre5C
         byR4HJum3ONvqqL1Yxxhb4wizOpb89M3ivUp4GZRnE1keuJzhwtHpPDTqRS4aGbHF/m3
         pZrgnRJWUNGUXfUhOdeMjnz1FuHGhAqMlJ5WWxzlEJ0HqK6p824OgPfbXGaSedinTYHH
         RQ4OA3PIzZ9u23J66TaWh5b7Qho6t+kfF7humLtkYo7d3hdu+dBmZTJFFF2zW1U1uVTc
         C3MWeh9pvLtwQhnGBQo8J/2+Aqc+nXldYvVTNm7hp8VKb4Fs5pulLIArbAymDqQLU80x
         VeWg==
X-Gm-Message-State: APjAAAWqiVOPzRBXGM/RZ7PlJy3vNMTDTLOE82yxG7LZ/416p8Sqr+f1
        59pwNj7oHIeIqMVm6pbnhPl/I5TBKTPaY8ShW2fu4g==
X-Google-Smtp-Source: APXvYqzRIFh1Vqlh+f07DqevfXqmOnXcLt0SM9csZ9fHfTfxYcneQ3lUouZNlG811MLLPfogJCwYgjOBmbJwJU6T5OE=
X-Received: by 2002:a67:f541:: with SMTP id z1mr674820vsn.70.1575443104903;
 Tue, 03 Dec 2019 23:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20191203101552.199339-1-ikjn@chromium.org> <20191203165301.GH10631@localhost>
In-Reply-To: <20191203165301.GH10631@localhost>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 4 Dec 2019 15:04:53 +0800
Message-ID: <CAATdQgCqYrd_aXN5GDsso+F3WadNx3DQKK3Efk3tgkrv2VXjyw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] usb: overridable hub bInterval by device node
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 12:52 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Dec 03, 2019 at 06:15:52PM +0800, Ikjoon Jang wrote:
> > This patch enables hub device to override its own endpoint descriptor's
> > bInterval when the hub has a device node with "hub,interval" property.
> >
> > When we know reducing autosuspend delay for built-in HIDs is better for
> > power saving, we can reduce it to the optimal value. But if a parent hub
> > has a long bInterval, mouse lags a lot from more frequent autosuspend.
> > So this enables overriding bInterval for a hard wired hub device only
> > when we know that reduces the power consumption.
>
> I think I saw you argue about why this shouldn't simply be configured at
> runtime. Please include that here too, I can't seem to remember why...

Okay.

>
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > ---
> >  drivers/usb/core/config.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> > index 5f40117e68e7..95ec5af42a1c 100644
> > --- a/drivers/usb/core/config.c
> > +++ b/drivers/usb/core/config.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/usb.h>
> >  #include <linux/usb/ch9.h>
> >  #include <linux/usb/hcd.h>
> > +#include <linux/usb/of.h>
> >  #include <linux/usb/quirks.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> > @@ -257,6 +258,14 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno, int inum,
> >       memcpy(&endpoint->desc, d, n);
> >       INIT_LIST_HEAD(&endpoint->urb_list);
> >
> > +     /* device node property overrides bInterval */
> > +     if (usb_of_has_combined_node(to_usb_device(ddev))) {
>
> Not only hubs have combined nodes so you probably need to check
> bDeviceClass here instead.

yes, you're right, I didn't think of that case:
if (to_usb_device(ddev)->descriptor.bDeviceClass == USB_CLASS_HUB &&
ddev->of_node && !of_property_read_u32(...))

Or is it better to check bInterfaceClass, for composite devices with a
hub interface inside?
if (ifp->desc.bInterfaceClass == USB_CLASS_HUB && ddev->of_node &&
!of_property_read_u32(...))

I think checking bInterfaceClass is better.

>
> > +             u32 interval = 0;
> > +             if (!of_property_read_u32(ddev->of_node, "hub,interval",
> > +                                 &interval))
> > +                     d->bInterval = min_t(u8, interval, 255);
>
> You want min_t(u32, ...) here to avoid surprises when someone specifies
> a value > 255.

yes, thanks.

>
> > +     }
> > +
> >       /*
> >        * Fix up bInterval values outside the legal range.
> >        * Use 10 or 8 ms if no proper value can be guessed.
>
> Johan

I will send v5 soon, thank you.
