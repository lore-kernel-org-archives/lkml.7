Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2918C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D62F21655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gJ8DRCtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLTTxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:53:36 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35433 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:53:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so9226169qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tevKiMGN3kPgvNa7lWgy9GqVG4G0WnUICAAv/nXBWh0=;
        b=gJ8DRCtAJHwZvA/vGknkDnB91CJ5INCyKPNGJbZDsbqYpqHScf7oNfB0Ww00lJ/0hZ
         wlfLalsFMe291/Ov79O2EcVASd+PnWapVjiFMoe4/RfwnGfAgzrbPeOrJwxBjhHpBMHH
         mQ4YIqfnMJ+wW6RRsLBJHk2a5nhrf3GMMI9VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tevKiMGN3kPgvNa7lWgy9GqVG4G0WnUICAAv/nXBWh0=;
        b=mE6vrYJaHjhEUUNqq2JFQHGalST7S4C72QBEHMVvrfJRv5EcLnGIQAaGGhZTnsUmyY
         mH5SYUg2KXbhvILZ/vMWcMmk4NyWMlYnOtnWaAieAsRsrJOO4vEZWMY6DwZnoMDjWTBb
         FjoutgrwAIwT0rO/GyQIvbhB/u7emEHcqi38BQeeYFvZ1WshGSWjfF5Cc/Jl+hSNT6Ck
         11Q2kt9sxtNjkr23frbXcpcZYB85UagppndRiNazqrfG2RZZ+b/17GuLaztfGTI1EEJB
         gnyytv3KfBqqE15v4K1VFtTKGE2QlGJN1ngQDE8FsdN2cJoaJ9DANuyOE7MW35ZjKMi3
         kULQ==
X-Gm-Message-State: APjAAAV3du0OWvWV5dXsu3C4o9JKfDQ29jgKbhouK5/E6Z2brHIXcd/f
        Kn8yiNpO8YOb/q8NBAMpNHnNcmAFitoCZuJEjLFIlw==
X-Google-Smtp-Source: APXvYqyTXDEqT9JcZAmXlZWUFDRCfZ0y41QWZU0a3aLCccTjAHohawinhWdVKA6wd95BqMIok1MfvKw7/j3bfiIL2DY=
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr12814034qtu.141.1576871614614;
 Fri, 20 Dec 2019 11:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20191220004946.113151-2-pmalani@chromium.org> <e64cc02a-ca4e-53e1-c0b6-4d38c7e95192@collabora.com>
In-Reply-To: <e64cc02a-ca4e-53e1-c0b6-4d38c7e95192@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 20 Dec 2019 11:53:23 -0800
Message-ID: <CACeCKadZfd_JAhXOgqPSzQ=hRamqvHF-cYoweR1poQcsowMnSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mfd: cros_ec: Add usbpd-notify to usbpd_charger
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

On Fri, Dec 20, 2019 at 12:52 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> Please try to maintain versions and changelog consistently. I.e I see v2 here
> but I guess you only send this patch not the full series, also I see that you
> send v3 before this?
>
> In general you should send the full series on every version and maintain a full
> changelog.
>
> I'd like to see v4 including all the series so it's clear from were we pick up
> the patches.
>
> On 20/12/19 1:49, Prashant Malani wrote:
> > Add the cros-usbpd-notify driver as a cell for the cros_usbpd_charger
> > subdevice on non-ACPI platforms.
> >
> > This driver allows other cros-ec devices to receive PD event
> > notifications from the Chrome OS Embedded Controller (EC) via a
> > notification chain.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
>
> For v4 you can include:
>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Since the v4 of this patch involves a substantial difference from the
previous version, I determined not to auto-add the Acked-by. My
apologies if you reckon I should've added it anyway.
>
> Thanks,
>  Enric
>
> > ---
> >
> > Changes in v2:
> > - Removed auto-generated Change-Id.
> >
> >  drivers/mfd/cros_ec_dev.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index c4b977a5dd966..1dde480f35b93 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -85,6 +85,9 @@ static const struct mfd_cell cros_ec_sensorhub_cells[] = {
> >  static const struct mfd_cell cros_usbpd_charger_cells[] = {
> >       { .name = "cros-usbpd-charger", },
> >       { .name = "cros-usbpd-logger", },
> > +#ifndef CONFIG_ACPI
> > +     { .name = "cros-usbpd-notify", },
> > +#endif
> >  };
> >
> >  static const struct cros_feature_to_cells cros_subdevices[] = {
> >
