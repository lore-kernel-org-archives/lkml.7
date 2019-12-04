Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51B7C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30792081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iDEL9iS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLDHIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:08:02 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:46294 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfLDHIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:08:02 -0500
Received: by mail-vk1-f194.google.com with SMTP id u6so1820709vkn.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 23:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OnkkDqzzWZ7ko76SaJQtORbCXdve+uF2P+mzM2G6HOo=;
        b=iDEL9iS/EMPOok9afqUeURuVVBWQu2rgnp9u7NRyLxffysoGn/smQASezgGuQEGqmS
         /8UwFv7Nr9TwsZ3c+Sn4sdNe7BBdCIPTqOLBjutkMNnhAGUPakhlGvUiWDPiYgFthnlk
         GbkAPob+qPjb9GKbnKSLQUxix4i9d0ZTJrduo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OnkkDqzzWZ7ko76SaJQtORbCXdve+uF2P+mzM2G6HOo=;
        b=H2hOXqI7ycDDRxc6v9i0idPpmMmZv9fGAUXIEGv3zUeN3SNoGdl9PYktCcsWzEFcAe
         qXzAMQQHGBMEQ9nuJ6RLb9CUCZGfuZLtJlZ04m+MKwlF4peKLfXgJo9qBNVbqwH5Zun3
         uaih3RBTRrDx6e0pfEL85qEYm5z28dFi4pqQMtKA99MhTCmiIeg+Px5XwuqShw3vvaRE
         Z7hgTZ00gZrt/zlwjIGv/WN/Zo5/FfubnYOGNtDgyPIuhOmJRJ93i/E8992t9iaPbny0
         q4heh/oNP747tI0+Qg5TXHOy0vn6Sjh44rjWu8criO4IQipGD1Pd6u9+/Tdab2NClLXC
         QeAw==
X-Gm-Message-State: APjAAAVarC7tCH68S9HLB24Z7hZKlby9wFrcmbDyVjrBvS1D4hIzOl0G
        /TskELRIgptYWR8PBxgXeCieIlb5S/y/HnyqJPLopQ==
X-Google-Smtp-Source: APXvYqxMtDuWHWsIKqXE8KLvKaAuALmnb1dIz8TyrC1W4+0VCyLzJebseWTY1hSp0YU4qqoU9TqZ/pluQh0JsQvhQPU=
X-Received: by 2002:a1f:d904:: with SMTP id q4mr317337vkg.13.1575443281606;
 Tue, 03 Dec 2019 23:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20191203101552.199339-1-ikjn@chromium.org> <Pine.LNX.4.44L0.1912031021120.1505-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1912031021120.1505-100000@iolanthe.rowland.org>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 4 Dec 2019 15:07:50 +0800
Message-ID: <CAATdQgCNEyBjaFijBpWHnqtk90_17WbY2PhVoYSKKccPY3SxZQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] usb: overridable hub bInterval by device node
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        JohanHovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 11:23 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 3 Dec 2019, Ikjoon Jang wrote:
>
> > This patch enables hub device to override its own endpoint descriptor's
> > bInterval when the hub has a device node with "hub,interval" property.
> >
> > When we know reducing autosuspend delay for built-in HIDs is better for
> > power saving, we can reduce it to the optimal value. But if a parent hub
> > has a long bInterval, mouse lags a lot from more frequent autosuspend.
> > So this enables overriding bInterval for a hard wired hub device only
> > when we know that reduces the power consumption.
> >
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
> > +             u32 interval = 0;
>
> Coding style: there should be a blank line here.  Also, you don't need
> the "= 0" initializer.
>
> Otherwise okay.

Okay, I will fix that.
Thank you!

>
> Alan Stern
>
> > +             if (!of_property_read_u32(ddev->of_node, "hub,interval",
> > +                                 &interval))
> > +                     d->bInterval = min_t(u8, interval, 255);
> > +     }
> > +
> >       /*
> >        * Fix up bInterval values outside the legal range.
> >        * Use 10 or 8 ms if no proper value can be guessed.
>
