Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B43FC0044D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D21A2084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575446131;
	bh=Lb3nemcb9R7mljnWpkCKv1Yn0oxJJhwN6/4ioz1hZ5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aNanTvcG79dpEScc27HBEhsmuyEqBZDdEnsTfa7/6WhPaqM0aVTsqiqGltqhhfyiH
	 VhJLLhw3A2srWCoV5VhvvqVv39kb9FPfpNBmannDs7lO7YGIUXJSgqQCgOIaKT+e24
	 hSW1ziQ3LsFiIVAy4vfePZOfrXkeBU39Wva09+8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLDHza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:55:30 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45880 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLDHza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:55:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so5284457lfa.12;
        Tue, 03 Dec 2019 23:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HtkivZBfXW8xPuS5rhk5w6nuW6W4kAYRPy9pdM4dJ+E=;
        b=btrEjsK+1YjS66nqCBcUA8vnICeA+hjizys7/ZujzuHIiNl7HH3Bxik8h3axHHIxUW
         7QQ11YfImJLjWULvDmNj6po/N8Aq31lSCLU9Ky3OPqXoGnSUg7sbJ8U+7gZBBZftmFIc
         mNJn6dOHliFL6PIVwVbOitHy9PbA9HuKixRODy9u0ALsAsq0Wd3cSWrcIEzoQhI05K6y
         7K2m5xA5NEeHZHBLBVxD4LeoNOPFbHcCVvES8d4SO688FP8A5rqyLOrSn+vQPeuBmn4H
         5xGi5ZLLnlKrH/XJKHDArIfHE6/tR2UmHzoAry1M0BEzIUoCxZpP44aeTEJwbcaKKBls
         sLmQ==
X-Gm-Message-State: APjAAAW7u6976Yk/5q/Q/3RvWUvYNoWgPfWGCLJ4lj6Xam9rsdoeVVjW
        z+XEmQ86zhPzFdr1e+dkfiw=
X-Google-Smtp-Source: APXvYqxTYNz2ToQ6maz5hD/npVXS7ml7RLVheYsAoH5Vcd+r/fnc/M7OrTdKeax3pCn5eMxYCrglrQ==
X-Received: by 2002:ac2:48b6:: with SMTP id u22mr1281287lfg.164.1575446127352;
        Tue, 03 Dec 2019 23:55:27 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id u2sm2752309lfd.4.2019.12.03.23.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 23:55:26 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1icPVV-0003JY-2n; Wed, 04 Dec 2019 08:55:33 +0100
Date:   Wed, 4 Dec 2019 08:55:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v4 2/2] usb: overridable hub bInterval by device node
Message-ID: <20191204075533.GI10631@localhost>
References: <20191203101552.199339-1-ikjn@chromium.org>
 <20191203165301.GH10631@localhost>
 <CAATdQgCqYrd_aXN5GDsso+F3WadNx3DQKK3Efk3tgkrv2VXjyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAATdQgCqYrd_aXN5GDsso+F3WadNx3DQKK3Efk3tgkrv2VXjyw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 03:04:53PM +0800, Ikjoon Jang wrote:
> On Wed, Dec 4, 2019 at 12:52 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Tue, Dec 03, 2019 at 06:15:52PM +0800, Ikjoon Jang wrote:
> > > This patch enables hub device to override its own endpoint descriptor's
> > > bInterval when the hub has a device node with "hub,interval" property.
> > >
> > > When we know reducing autosuspend delay for built-in HIDs is better for
> > > power saving, we can reduce it to the optimal value. But if a parent hub
> > > has a long bInterval, mouse lags a lot from more frequent autosuspend.
> > > So this enables overriding bInterval for a hard wired hub device only
> > > when we know that reduces the power consumption.
> >
> > I think I saw you argue about why this shouldn't simply be configured at
> > runtime. Please include that here too, I can't seem to remember why...
> 
> Okay.
> 
> >
> > > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > > ---
> > >  drivers/usb/core/config.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
> > > index 5f40117e68e7..95ec5af42a1c 100644
> > > --- a/drivers/usb/core/config.c
> > > +++ b/drivers/usb/core/config.c
> > > @@ -6,6 +6,7 @@
> > >  #include <linux/usb.h>
> > >  #include <linux/usb/ch9.h>
> > >  #include <linux/usb/hcd.h>
> > > +#include <linux/usb/of.h>
> > >  #include <linux/usb/quirks.h>
> > >  #include <linux/module.h>
> > >  #include <linux/slab.h>
> > > @@ -257,6 +258,14 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno, int inum,
> > >       memcpy(&endpoint->desc, d, n);
> > >       INIT_LIST_HEAD(&endpoint->urb_list);
> > >
> > > +     /* device node property overrides bInterval */
> > > +     if (usb_of_has_combined_node(to_usb_device(ddev))) {
> >
> > Not only hubs have combined nodes so you probably need to check
> > bDeviceClass here instead.
> 
> yes, you're right, I didn't think of that case:
> if (to_usb_device(ddev)->descriptor.bDeviceClass == USB_CLASS_HUB &&
> ddev->of_node && !of_property_read_u32(...))
> 
> Or is it better to check bInterfaceClass, for composite devices with a
> hub interface inside?
> if (ifp->desc.bInterfaceClass == USB_CLASS_HUB && ddev->of_node &&
> !of_property_read_u32(...))
> 
> I think checking bInterfaceClass is better.

Yep, that seems better (but please use two conditionals for
readability).

But related to my question above, why do you need to do this during
enumeration? Why not just set the lower interval value in the hub
driver?

> > > +             u32 interval = 0;
> > > +             if (!of_property_read_u32(ddev->of_node, "hub,interval",
> > > +                                 &interval))
> > > +                     d->bInterval = min_t(u8, interval, 255);
> >
> > You want min_t(u32, ...) here to avoid surprises when someone specifies
> > a value > 255.
> 
> yes, thanks.

And I guess you should really be honouring bInterval as a maximum value,
right?

> > > +     }
> > > +
> > >       /*
> > >        * Fix up bInterval values outside the legal range.
> > >        * Use 10 or 8 ms if no proper value can be guessed.

Johan
