Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B5EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8647A205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KXpn15c1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfF1S4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:56:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44125 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfF1S4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:56:09 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so14598245iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/HiXefy4UCK+iIL42XxVKE60Fm+qy4QgSjL2gOdSRI=;
        b=KXpn15c1iVMT+RJj3i5mj2KjjhuX7v7ZTGHZHmCy1Bo7+Xe70q31uHoGRO1T8TDU79
         O682eWWlZVZgP3oTUbD1GGBx9fTTCDqmpdYTccsIa8xrTYIkXJDxEn31VZch9g91Pxd7
         4D11zUYpQwEXj2qFX+1obgUDYC2QmP8MC2Ewc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/HiXefy4UCK+iIL42XxVKE60Fm+qy4QgSjL2gOdSRI=;
        b=gvjMxXRQBALoGn1/c94Hy2QwHJeNY9K4aCZd2/8bqxM6nErwEns9tK4EPjAV0XjNqc
         +Luli0rh+NJwWH8vFJ8mWRVSq3CxTrJStJDvrBnL7unLTxUK/Yiaq8jZRXHVEb74bVX3
         kkSh2qAgWLT7CbvljoAT61y0KF5SwIGZbxIAtyyIbqpNjOD97rNoFP2xXD1QXS6vHeuN
         2UyNDKfcfXf4a8lX329nwiiC/g9z9SMOI5GCBAuEpoeuSl2ScGi23ALno3bGKwK7gKOc
         igRdZ9mk7Ju+a2Dlf8oQV2f8gYqWgzrdQWY83gRW12NyaskKUf4EcGrsbMyFDPR1LERD
         w7Lg==
X-Gm-Message-State: APjAAAWao6Q0ev1A3RSic82GaISrsVeWRcWqGcmop+U50Yi9D01eX59x
        lm+GYCWrLo9Qw+8faLMgOVPDVqtitTmimAZ0Vx1AuA==
X-Google-Smtp-Source: APXvYqx4NSClEBnWejaWWQQTLSf2lvG1qwp/CnDKFJN38iAIvwKQpaS96n/OVahHXdpx3LwAiYy2SUFD5TrtwTqbrvQ=
X-Received: by 2002:a02:9f84:: with SMTP id a4mr7542700jam.20.1561748168912;
 Fri, 28 Jun 2019 11:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190621024106.158589-1-gwendal@chromium.org> <20190621024106.158589-3-gwendal@chromium.org>
 <20190622100308.7d29c324@archlinux>
In-Reply-To: <20190622100308.7d29c324@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 28 Jun 2019 11:55:57 -0700
Message-ID: <CAPUE2us4t3_mzbkLUGd+_pz0u1ZGrXmagxVL-MkT4vVZDWV-Nw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: cros_ec : Extend legacy support to ARM device
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2019 at 2:03 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 20 Jun 2019 19:41:06 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Add support to ARM based devices, that lack LPC access code.
> > Allow cros-ec-accel-legacy to use cros-ec-sensors-core, add specific
> > command to capture sensor data.
> >
> > On veyron minnie, check chrome detect tablet mode and rotate
> > screen in tablet mode.
> > Check only a subset of the attributes are presented.
>
> Superficially this looks like 2 changes to me.  One moves
> over to using the shared code. The other sounds like it's introducing
> the new device support?
That's correct.
> 2 patches perhaps?
Will do.
>
> However, looking at the code, am I interpreting the description
> correctly?  Looks to me like we are really just reducing duplicated
> code by using the cros_ec_sensors_core code to replace
> existing code in the cros-ec-accel-legacy driver?  If that's
> the main focus, then make that clear in the patch title.
The second part introduce a command to retrieve sensor data that is
applicable for veyron-minnie only, cros_ec_accel_legacy_read_cmd.
>
> One passing comment inline.
>
> Thanks,
>
> Jonathan
>
>
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/accel/Kconfig                |   4 +-
> >  drivers/iio/accel/cros_ec_accel_legacy.c | 350 +++++------------------
> >  2 files changed, 79 insertions(+), 275 deletions(-)
> >
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 62a970a20219..7d0848f9ea45 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -201,9 +201,7 @@ config HID_SENSOR_ACCEL_3D
> >
> >  config IIO_CROS_EC_ACCEL_LEGACY
> >       tristate "ChromeOS EC Legacy Accelerometer Sensor"
> > -     select IIO_BUFFER
> > -     select IIO_TRIGGERED_BUFFER
> > -     select CROS_EC_LPC_REGISTER_DEVICE
> > +     depends on IIO_CROS_EC_SENSORS_CORE
> >       help
> >         Say yes here to get support for accelerometers on Chromebook using
> >         legacy EC firmware.
> > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > index 46bb2e421bb9..575d7e4c685c 100644
> > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > @@ -5,13 +5,14 @@
> >   * Copyright 2017 Google, Inc
> >   *
> >   * This driver uses the memory mapper cros-ec interface to communicate
> > - * with the Chrome OS EC about accelerometer data.
> > + * with the Chrome OS EC about accelerometer data or older commands.
...
> >  #define CROS_EC_ACCEL_LEGACY_CHAN(_axis)                             \
> >       {                                                               \
> > @@ -319,31 +140,30 @@ static const struct iio_chan_spec_ext_info cros_ec_accel_legacy_ext_info[] = {
> >               .modified = 1,                                          \
> >               .info_mask_separate =                                   \
> >                       BIT(IIO_CHAN_INFO_RAW) |                        \
> > -                     BIT(IIO_CHAN_INFO_SCALE) |                      \
>
> My first thought was you were changing the ABI, but looking closer this
> was broken anyway as we shouldn't have had both separate and shared by all
> for the same thing on the same channel.  Still presumably an ABI change
> but one fixing a broken interface so fingers crossed no one notices.
Yes, it was an error that was not documented in the ABI. I will fix
that separately.
>
> >                       BIT(IIO_CHAN_INFO_CALIBBIAS),                   \
> >               .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),    \
> > -             .ext_info = cros_ec_accel_legacy_ext_info,              \
> > +             .ext_info = cros_ec_sensors_ext_info,                   \
> >               .scan_type = {                                          \
