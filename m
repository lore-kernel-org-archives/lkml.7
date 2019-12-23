Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FB7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0945320709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jf6MM9zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLWUaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 15:30:13 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35138 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLWUaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 15:30:12 -0500
Received: by mail-qt1-f194.google.com with SMTP id e12so16383549qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 12:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=co5KhQ977eCC6PUYj9c8NZCajqUFhxNywpk98AxfIDc=;
        b=jf6MM9zRJJMu7L53ECQByr3Ut5N4kmVCXx9vPA/2tdx4FWfDKqSrDI+FJNgvM2Pd1E
         cIFVB3mWdgjPzIdJC8qLsfFiuk2lrs8kZh/LfpGKqqWP+R5ao1Km3r3k0drx5S8cUSJR
         EVofGEylzJTdhKxYHLQfD7xbSxfHlbBa4i7KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=co5KhQ977eCC6PUYj9c8NZCajqUFhxNywpk98AxfIDc=;
        b=SWgYpeUoptnn3pHGD57/TO/4V32/Og2lt+mggC+ACwyymyriww1qW/CvYDTAyUh/xB
         dXXpFovKKD6PQIWiQE7mZdUAKJlL8RRHOr/T+qxIo2xlpHfmV9aEDo3AWWa4ZmJ2oFOQ
         p7/qKVsO23GL3SZvtndA1Md3Vj5gOOFyNTgdtr0ZhN2duxeH4Ed2K1fDfxqbc/7lqTF5
         PHeoTpi36jGu6vu7cGmkItOsBZsRmAQkr6WbhpAK/VmBY3w2a7DjLVlyCsW3W1+XjDrq
         YuvnXbRYUxof7PnADfWUy3BOvuRH/15Z52tKNtSPxP9/uysqiiMSVlfKH1jDXKgcC6/8
         Hnwg==
X-Gm-Message-State: APjAAAWIoDIvxB4r+gQsOA2vNLRtvC7jGcD1Ia4TLAC5oQbSvb/rjgbR
        W4PCdLfM11PRsLIzAJy1ucaWye+ENXPXsODgN6jVKd8l
X-Google-Smtp-Source: APXvYqygOJV0364tnt6qXgJFq4GT59e1VPJqNnK+l8JnaN7J7esoCwbHohwkWsOTmWeTngCmUZygvAn0t6oq5piYgYU=
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr23800266qtu.141.1577133011811;
 Mon, 23 Dec 2019 12:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20191220193843.47182-1-pmalani@chromium.org> <20191220193843.47182-2-pmalani@chromium.org>
 <7eecafb2-4686-b448-2837-4181188365b1@collabora.com>
In-Reply-To: <7eecafb2-4686-b448-2837-4181188365b1@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 23 Dec 2019 12:29:59 -0800
Message-ID: <CACeCKadFKWUNHHT-vs686Sz2-CcD0kNeUgqkJT5Q2ATji4L58w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mfd: cros_ec: Add cros-usbpd-notify subdevice
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Sun, Dec 22, 2019 at 11:25 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 20/12/19 20:38, Prashant Malani wrote:
> > Add the cros-usbpd-notify driver as a subdevice on non-ACPI platforms
> > that support the EC_FEATURE_USB_PD EC feature flag.
> >
> > This driver allows other cros-ec devices to receive PD event
> > notifications from the Chrome OS Embedded Controller (EC) via a
> > notification chain.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Removed #ifndef usage; instead, moved cros-usbpd-notify to a separate
> >   mfd_cell and used an IS_ENABLED() check.
> > - Changed commit title and description slightly to reflect change in
> >   code.
> >
> >  drivers/mfd/cros_ec_dev.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index c4b977a5dd966..da198abe2b0a6 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -5,6 +5,7 @@
> >   * Copyright (C) 2014 Google, Inc.
> >   */
> >
> > +#include <linux/kconfig.h>
> >  #include <linux/mfd/core.h>
> >  #include <linux/mfd/cros_ec.h>
> >  #include <linux/module.h>
> > @@ -87,6 +88,10 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
> >       { .name = "cros-usbpd-logger", },
> >  };
> >
> > +static const struct mfd_cell cros_usbpd_notify_cells[] = {
> > +     { .name = "cros-usbpd-notify", },
> > +};
> > +
> >  static const struct cros_feature_to_cells cros_subdevices[] = {
> >       {
> >               .id             = EC_FEATURE_CEC,
> > @@ -202,6 +207,22 @@ static int ec_device_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > +     /*
> > +      * The PD notifier driver cell is separate since it only needs to be
> > +      * explicitly added on non-ACPI platforms.
>
>
> Sorry to not catch this before, but a worry arose. Is non-ACPI platforms or
> non-X86 platforms or on OF platforms?
>
> ARM64 for example has the CONFIG_ACPI symbol set to yes, with the below
> condition condition will not work on Kevin for example and IIUC this is not what
> we want, I think we want IS_ENABLED(CONFIG_OF)?
Thanks for noting this. I will check with a kevin, and with the
internal build flags to verify whether there are ARM64 which have the
GOOG0003 PD notification device.
I'll update this thread with my findings.

Best,

>
> Thanks,
>  Enric
>
> > +      */
> > +     if (!IS_ENABLED(CONFIG_ACPI)) {
> > +             if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
> > +                     retval = mfd_add_hotplug_devices(ec->dev,
> > +                                     cros_usbpd_notify_cells,
> > +                                     ARRAY_SIZE(cros_usbpd_notify_cells));
> > +                     if (retval)
> > +                             dev_err(ec->dev,
> > +                                     "failed to add PD notify devices: %d\n",
> > +                                     retval);
> > +             }
> > +     }
> > +
> >       /*
> >        * The following subdevices cannot be detected by sending the
> >        * EC_FEATURE_GET_CMD to the Embedded Controller device.
> >
