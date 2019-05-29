Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DEEC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E594218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LVkf3MAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfE2Si0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:38:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43261 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2SiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:38:25 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so2732078ios.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VToC0WE9Dh7JrQD0pBq5SyQVnx7ZcQeb3eSMqn+9dN0=;
        b=LVkf3MAEUlO6rx5UMKazGHhK3z7LKymiNiPP+vsFfhul6Sv375QcSJAKdyfDX9myki
         8154NOEiQ4nHYf7+8mHxfyEwoBWYuZe1POSVA7Yk8dYpLWZd0gDBKa1PNtJMPr4ah2AP
         y8SBlwNyQiqVqKdY2Wbed3qaf/rAL1xXYLy7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VToC0WE9Dh7JrQD0pBq5SyQVnx7ZcQeb3eSMqn+9dN0=;
        b=A8CvO8tciNsjXGcxT8Rw7Dg4sZNZ5/KI/S2kocl6A3Gn86uA4ShPzU30uBWoY2mN5x
         wEA7sV6Yzz+MiLCgfeFGHcMgXe30cWzAbOPQFam+Fe/bd2vXUICEdRn//N1XENN6Yn/N
         exAYiYtT3vJYAmdu2O2CAT7ufX8l7bRmv7zRuLVGWy16sELxem7Jh/vP/lZG2Z6OryW5
         57fhVokox0V7dIh8gvM0cdjlkTnmjH1C3gdJBM5iScjPd4qshQbjCrNmU/zNFLfO0+zT
         f6WOq1Hn7pCqYo5xxO3m6WczYeLTKOm37/vCQO/OH/w0MRssAiFCrIal2Lz2fW4cyyqr
         tfnw==
X-Gm-Message-State: APjAAAU4baQ8yQo9gFvhxgOYJ0ADhqIudo2NIQ3fd1wTq3G+5obRh45G
        TuC8YqYqM8622kRvglI6N8yVJUZuhEZNZlWfOds0dQ==
X-Google-Smtp-Source: APXvYqwRJ9GbWYAJjV4yTvXa0R9z0uuGCAUEMG2wDwhksLV5HcIA2AOf8UOenRtaWNfe1I95F29XRVobAk3trbMCRts=
X-Received: by 2002:a5d:9dc7:: with SMTP id 7mr3521803ioo.237.1559155104410;
 Wed, 29 May 2019 11:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
 <20190228013541.76792-1-gwendal@chromium.org> <20190402034610.GG4187@dell>
 <CAPUE2usfB3i4J7P4e_XdsMLV+VK7s+nS-mrD=D_WMpOHiouG2w@mail.gmail.com> <20190529114454.GJ4574@dell>
In-Reply-To: <20190529114454.GJ4574@dell>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 29 May 2019 11:38:13 -0700
Message-ID: <CAPUE2usYa3z3mcxo6fGsBL-FXLcNy1-Pr+WoQsKmTjhNZCZwSA@mail.gmail.com>
Subject: Re: [PATCH v5] mfd: cros_ec_dev: Register cros_ec_accel_legacy driver
 as a subdevice
To:     Lee Jones <lee.jones@linaro.org>
Cc:     andy.shevchenko@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 4:44 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 28 May 2019, Gwendal Grignou wrote:
>
> > On Mon, Apr 1, 2019 at 8:46 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Wed, 27 Feb 2019, Gwendal Grignou wrote:
> > >
> > > > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > >
> > > > With this patch, the cros_ec_ctl driver will register the legacy
> > > > accelerometer driver (named cros_ec_accel_legacy) if it fails to
> > > > register sensors through the usual path cros_ec_sensors_register().
> > > > This legacy device is present on Chromebook devices with older EC
> > > > firmware only supporting deprecated EC commands (Glimmer based devi=
ces).
> > > >
> > > > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com=
>
> > > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > ---
> > > > Changes in v5:
> > > > - Remove unnecessary white lines.
> > > >
> > > > Changes in v4:
> > > > - [5/8] Nit: EC -> ECs (Lee Jones)
> > > > - [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)
> > > >
> > > > Changes in v3:
> > > > - [5/8] Add the Reviewed-by Andy Shevchenko.
> > > >
> > > > Changes in v2:
> > > > - [5/8] Add the Reviewed-by Gwendal.
> > > >
> > > >  drivers/mfd/cros_ec_dev.c | 66 +++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 66 insertions(+)
> > > >
> > > > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > > > index d275deaecb12..64567bd0a081 100644
> > > > --- a/drivers/mfd/cros_ec_dev.c
> > > > +++ b/drivers/mfd/cros_ec_dev.c
> > > > @@ -376,6 +376,69 @@ static void cros_ec_sensors_register(struct cr=
os_ec_dev *ec)
> > > >       kfree(msg);
> > > >  }
> > > >
> > > > +static struct cros_ec_sensor_platform sensor_platforms[] =3D {
> > > > +     { .sensor_num =3D 0 },
> > > > +     { .sensor_num =3D 1 }
> > > > +};
> > >
> > > I'm still very uncomfortable with this struct.
> > >
> > > Other than these indices, the sensors have no other distinguishing
> > > features, thus there should be no need to identify or distinguish
> > > between them in this way.
> > When initializing the sensors, the IIO driver expect to find in the
> > data  structure pointed by dev_get_platdata(dev), in field sensor_num
> > is stored the index assigned by the embedded controller to talk to a
> > given sensor.
> > cros_ec_sensors_register() use the same mechanism; in that function,
> > the sensor_num field is populated from the output of an EC command
> > MOTIONSENSE_CMD_INFO. In case of legacy mode, that command may not be
> > available and in any case we know the EC has only either 2
> > accelerometers present or nothing.
> >
> > For instance, let's compare a legacy device with a more recent one:
> >
> > legacy:
> > type                  |   id          | sensor_num   | device name
> > accelerometer  |   0           |   0                  | cros-ec-accel.0
> > accelerometer  |   1           |   1                  | cros-ec-accel.1
> >
> > Modern:
> > type                  |   id          | sensor_num   | device name
> > accelerometer  |   0           |   0                  | cros-ec-accel.0
> > accelerometer  |   1           |   1                  | cros-ec-accel.1
> > gyroscope        |    0          |    2                 | cros-ec-gyro.=
0
> > magnetometer |    0          |   3                  | cros-ec-mag.0
> > light                  |    0          |   4                  | cros-ec=
-light.0
> > ...
>
> Why can't these numbers be assigned at runtime?
I assume you want to know why IIO drivers need to know "sensor_num"
ahead of time. It is because each IIO driver is independent from the
other.
Let assume there was 2 light sensors in the device:
type                  |   id          | sensor_num   | device name
 light                  |    0          |   4                  | cros-ec-li=
ght.0
 light                  |    1          |   5                  | cros-ec-li=
ght.1

In case of sensors of the same type without sensor_num, cros-ec-light
driver has no information at probe time if it should bind to sensors
named by the EC 4 or 5.

We could get away with cros-ec-accel, as EC always presents
accelerometers with sensor_num  0 and 1, but I don't want to rely on
this property in the general case.
Only cros_ec_dev MFD driver has the global view of all sensors available.

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
