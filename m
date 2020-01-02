Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C503FC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECB921655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jEu9P5kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgABXwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:52:37 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39025 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgABXwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:52:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so32605543qko.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 15:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EAjgcYRwwQLEHNJXsVZFmFh/vkYMti29PfuD05RdzD0=;
        b=jEu9P5kd46ah9fO74PUFMW8yKnRpnQKJTQZ3VjFdpjiEoLMpHo73b4PHD6WnotAdfw
         5nag/gjhyWUKjJm0dIqjMmuiZoywq4AvW2AiMzfoxP2I8FDZ+F8Jce+edDOdkqoUS4qD
         Iyxrk6J0A6UBLqpU4MvNGyqUaG72ZTXlgLYmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAjgcYRwwQLEHNJXsVZFmFh/vkYMti29PfuD05RdzD0=;
        b=nF6g0CTiyDN/PKciBi2oAaRELcr1V0kRcWoeqi6d1RwHSL21IUkvi7xB9L4mXqQFJk
         GxksktMPFOgIWCWDU0vNJ/no+IgPTGi0Nm8pbnL9Pj0IVlugHrw3i4hNR0D6aGUGrYQd
         994RZbrj/ye0nOGWW90i9Bl8tkPSc+ZfSnSVXbgrACp9SXFwyHyh6Wn1o8agwGayavwc
         wbI6KWWQ86m+OAKG/uHh6VCPl8eLYY0WAX+V2MHrtBsBpQY/n168QiPcPQgaPEZW9HFu
         TgiA7ZMhRAnW0NpImzVVWlLMPF7AuYlPqPcguvzt6CqTdg989T3RWB/Jkyyxd/6e2s13
         wWag==
X-Gm-Message-State: APjAAAVt58daNGGSVj0vHIxuQex/pSZSjcbcmMI39Cu7TJsTcqCG8I86
        XyPNfHp4PlUBfHfRwxdl6VRAHTAhVYOxW2DB9DICjkpNL9o=
X-Google-Smtp-Source: APXvYqzmoxfPDOATQiGGDO+Nk5VFiZR1k0KCuY1/IL+rXCfFjOLPPk/OZ4pFuQ0bfxCbzEFFxEyhr7+mez5cru10ECk=
X-Received: by 2002:a05:620a:1114:: with SMTP id o20mr67810505qkk.128.1578009155332;
 Thu, 02 Jan 2020 15:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20191220193843.47182-1-pmalani@chromium.org> <20191220193843.47182-2-pmalani@chromium.org>
 <7eecafb2-4686-b448-2837-4181188365b1@collabora.com> <CACeCKadFKWUNHHT-vs686Sz2-CcD0kNeUgqkJT5Q2ATji4L58w@mail.gmail.com>
In-Reply-To: <CACeCKadFKWUNHHT-vs686Sz2-CcD0kNeUgqkJT5Q2ATji4L58w@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 2 Jan 2020 15:52:24 -0800
Message-ID: <CACeCKadAJE-ayisXOib4ZV9_BDORp-dpoT_KSMnJj3Y30dF_6A@mail.gmail.com>
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


On Mon, Dec 23, 2019 at 12:29 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Enric,
>
> On Sun, Dec 22, 2019 at 11:25 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > Hi Prashant,
> >
> > On 20/12/19 20:38, Prashant Malani wrote:
> > > Add the cros-usbpd-notify driver as a subdevice on non-ACPI platforms
> > > that support the EC_FEATURE_USB_PD EC feature flag.
> > >
> > > This driver allows other cros-ec devices to receive PD event
> > > notifications from the Chrome OS Embedded Controller (EC) via a
> > > notification chain.
> > >
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >
> > > Changes in v4:
> > > - Removed #ifndef usage; instead, moved cros-usbpd-notify to a separate
> > >   mfd_cell and used an IS_ENABLED() check.
> > > - Changed commit title and description slightly to reflect change in
> > >   code.
> > >
> > >  drivers/mfd/cros_ec_dev.c | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > > index c4b977a5dd966..da198abe2b0a6 100644
> > > --- a/drivers/mfd/cros_ec_dev.c
> > > +++ b/drivers/mfd/cros_ec_dev.c
> > > @@ -5,6 +5,7 @@
> > >   * Copyright (C) 2014 Google, Inc.
> > >   */
> > >
> > > +#include <linux/kconfig.h>
> > >  #include <linux/mfd/core.h>
> > >  #include <linux/mfd/cros_ec.h>
> > >  #include <linux/module.h>
> > > @@ -87,6 +88,10 @@ static const struct mfd_cell cros_usbpd_charger_cells[] = {
> > >       { .name = "cros-usbpd-logger", },
> > >  };
> > >
> > > +static const struct mfd_cell cros_usbpd_notify_cells[] = {
> > > +     { .name = "cros-usbpd-notify", },
> > > +};
> > > +
> > >  static const struct cros_feature_to_cells cros_subdevices[] = {
> > >       {
> > >               .id             = EC_FEATURE_CEC,
> > > @@ -202,6 +207,22 @@ static int ec_device_probe(struct platform_device *pdev)
> > >               }
> > >       }
> > >
> > > +     /*
> > > +      * The PD notifier driver cell is separate since it only needs to be
> > > +      * explicitly added on non-ACPI platforms.
> >
> >
> > Sorry to not catch this before, but a worry arose. Is non-ACPI platforms or
> > non-X86 platforms or on OF platforms?
> >
> > ARM64 for example has the CONFIG_ACPI symbol set to yes, with the below
> > condition condition will not work on Kevin for example and IIUC this is not what
> > we want, I think we want IS_ENABLED(CONFIG_OF)?
> Thanks for noting this. I will check with a kevin, and with the
> internal build flags to verify whether there are ARM64 which have the
> GOOG0003 PD notification device.
> I'll update this thread with my findings.
AFAICT from the Chrome OS kernel build step .config output, kevin
doesn't have CONFIG_ACPI enabled (it is marked as "# CONFIG_ACPI is
not set"), and it doesn't look like there are Chrome OS ARM devices
that use ACPI (I believe it's only used on Chrome OS x86-based
devices). So perhaps it is not a concern?

>
> Best,
>
> >
> > Thanks,
> >  Enric
> >
> > > +      */
> > > +     if (!IS_ENABLED(CONFIG_ACPI)) {
> > > +             if (cros_ec_check_features(ec, EC_FEATURE_USB_PD)) {
> > > +                     retval = mfd_add_hotplug_devices(ec->dev,
> > > +                                     cros_usbpd_notify_cells,
> > > +                                     ARRAY_SIZE(cros_usbpd_notify_cells));
> > > +                     if (retval)
> > > +                             dev_err(ec->dev,
> > > +                                     "failed to add PD notify devices: %d\n",
> > > +                                     retval);
> > > +             }
> > > +     }
> > > +
> > >       /*
> > >        * The following subdevices cannot be detected by sending the
> > >        * EC_FEATURE_GET_CMD to the Embedded Controller device.
> > >
