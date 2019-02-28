Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61088C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE5720842
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WXMJHsuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfB1BDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:03:16 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34187 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbfB1BDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:03:16 -0500
Received: by mail-yw1-f67.google.com with SMTP id u205so9780071ywe.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 17:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AWS2Z9bQIrIeXEIl/MP1nHUt5UUNwEzDmN6BMcSjReA=;
        b=WXMJHsuDmOmQum0OZmg/DwNPdJcvnOKqi7AIiy6JryIAwoFJBYvxNQsaQB+1ClcQ6O
         b/RUC3VS3tEmcPQJ6UVMVKgK5mRy29f89hnVHOJkrM2UXswXivjeq//d4bUliqzu7hJy
         2n/9VFRvvYrweHKlpn/OI12k71LEklApZs+cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AWS2Z9bQIrIeXEIl/MP1nHUt5UUNwEzDmN6BMcSjReA=;
        b=dCweiSVWKCI7Bk7ZY4DiJceS3yyKAUe9SE3ZMPcOFEOvlmrXVVx2Dc31rTV/s2Ic5T
         8m1BcnWT/KvRQbcfUhyZquzFZ74eW1KNoAlHcurjeDt3zdCgwf140P7FZdaGO/c9oPnq
         XUDUaZ6YpooledLrWH3ktHyeLHd/NVjMcymgaixpGqVDEU//sXOtRHRVuL0axbGjK5gj
         fxaQdGS+4W2uAk1IZaEnPM8XfasrdAbmLgvvjRHGGApxlMhwtu2cV/Uhc0kY0GScsSKj
         GYcTjPxsJNNAj/1lj/xj00gHY9eA/UESRh/lCAJBoqt8rjK0TpVo0PMymjLFfbtaAaoi
         q9bA==
X-Gm-Message-State: AHQUAuYe0+BOHv5Kkn3qqSnm4hRYypgRBkgq9qHhZZailKo6gZbDFvRV
        Om9NsonLH2gEyrvUCVlbSbEFo6g+aCFKkIPvhjy1YQ==
X-Google-Smtp-Source: AHgI3IZmB/Ts2o/ZRGAV/gBuyDPdudljccbrrWKWZ5MqrgmauM6nhW6BfsaVhBRus7Tm4I6MlOuexKkjLdGzR7Qp9vo=
X-Received: by 2002:a25:c184:: with SMTP id r126mr4402792ybf.441.1551315794499;
 Wed, 27 Feb 2019 17:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20180320122751.14019-1-enric.balletbo@collabora.com>
 <20180320122751.14019-6-enric.balletbo@collabora.com> <20180328110330.y4pq5mhm73jfq6j6@dell>
 <CAFqH_53j2CwxmLwvaK8mrroEtKz7ZBEmRdr3Db6-dunWyqYw8A@mail.gmail.com>
 <CAFqH_50f-NZCd8up8U1djMBO-8znxGK7rcEuWh6ahyvypF8D+A@mail.gmail.com> <20180416132055.udgkpge6poaqix3z@dell>
In-Reply-To: <20180416132055.udgkpge6poaqix3z@dell>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 27 Feb 2019 17:03:03 -0800
Message-ID: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] mfd: cros_ec_dev: Register cros_ec_accel_legacy
 driver as a subdevice.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel@collabora.com, Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 6:21 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 04 Apr 2018, Enric Balletbo Serra wrote:
>
> > Hi again,
> >
> > 2018-04-04 10:03 GMT+02:00 Enric Balletbo Serra <eballetbo@gmail.com>:
> > > Hi Lee,
> > >
> > > 2018-03-28 13:03 GMT+02:00 Lee Jones <lee.jones@linaro.org>:
> > >> On Tue, 20 Mar 2018, Enric Balletbo i Serra wrote:
> > >>
> > >>> With this patch, the cros_ec_ctl driver will register the legacy
> > >>> accelerometer driver (named cros_ec_accel_legacy) if it fails to
> > >>> register sensors through the usual path cros_ec_sensors_register().
> > >>> This legacy device is present on Chromebook devices with older EC
> > >>> firmware only supporting deprecated EC commands (Glimmer based devi=
ces).
> > >>>
> > >>> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > >>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com=
>
> > >>> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > >>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >>> ---
> > >>>
> > >>> Changes in v4:
> > >>> - [5/8] Nit: EC -> ECs (Lee Jones)
> > >>> - [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)
> > >>>
> > >>> Changes in v3:
> > >>> - [5/8] Add the Reviewed-by Andy Shevchenko.
> > >>>
> > >>> Changes in v2:
> > >>> - [5/8] Add the Reviewed-by Gwendal.
> > >>>
> > >>>  drivers/mfd/cros_ec_dev.c | 70 +++++++++++++++++++++++++++++++++++=
++++++++++++
> > >>>  1 file changed, 70 insertions(+)
> > >>>
> > >>> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > >>> index f60a53f11942..0d541d59d6f5 100644
> > >>> --- a/drivers/mfd/cros_ec_dev.c
> > >>> +++ b/drivers/mfd/cros_ec_dev.c
> > >>> @@ -389,6 +389,73 @@ static void cros_ec_sensors_register(struct cr=
os_ec_dev *ec)
> > >>>       kfree(msg);
> > >>>  }
> > >>>
> > >>> +static struct cros_ec_sensor_platform sensor_platforms[] =3D {
> > >>> +     {
> > >>> +             .sensor_num =3D 0,
> > >>> +     },
> > >>> +     {
> > >>> +             .sensor_num =3D 1,
> > >>> +     }
> > >>> +};
> > >>
> > >> Also no need to be so many  lines.
> > >>
> > >> Each one of these entries can be placed on a single line.
> > >>
> > >> And there's no need for a comma if there is nothing to separate.
> > >>
> > >>         { .sensor_num =3D 0 },
> > >>         { .sensor_num =3D 1 }
> > >>
> > >> Also, this seems like a pretty pointless struct.
> > >>
> > >> What is the sensor_num property used for?
> > >>
> > >> Why does it care what sensor number it is?
This patch add support for device with older embedded controller
firmware that do not support the command MOTIONSENSE_CMD_DUMP.
Contrary to cros_ec_sensors_register(), we need to guess what
MOTIONSENSE_CMD_DUMP would have returned when only 2 accelerometers
are present.

The IIO CrosEC sensors driver needs these id created by the EC to
reference a particular sensor: this is sensor_num in
cros_ec_sensor_platform.
It happens to be the same as .id in mfd_cell.
> > >>
> > >
> > > I thought that was used but after look again I didn't see where, so
> > > seems that you have reason and this struct is pointless. I'll remove
> > > this and the .id in the cells, we can always send a patch later
> > > introducing this if I am missing something. I'll send another version=
.
> > >
> >
> > Ok, forget what I said.
> >
> > Actually, sensor_num is used by the cros_ec_legacy driver to get the
> > right sensor properties from the EC and to get the sensor data from
> > the EC, sensor_num is the offset passed to the EC read command.
>
> I'm sure that it is being used, but my question is, why?
>
> Passing a 0 and a 1 to a child driver seems like a pointless exercise
> to me.  We do not usually enumerate devices like this with platform
> data.  Do these values ever change, or are they simply used to
> enumerate 2 devices which are always called 0 and 1?
The later. The IIO driver needs to use the EC assigned names 0 and 1.
>
> > .id is not used but as there are two accelerometers that use the same
> > driver, shouldn't we set the id (or I am missing something)?
It is just a coincidence that .id and .sensor_num are identical.
> >
> > +static const struct mfd_cell cros_ec_accel_legacy_cells[] =3D {
> > +     { .name =3D "cros-ec-accel-legacy", .id =3D 0 },
> > +     { .name =3D "cros-ec-accel-legacy", .id =3D 1 },
> > + };
I repost a more concise patch.

Thanks,

Gwendal.
>
> I think you need to understand what MFD/Platform code does with these
> IDs.  Take a look at the MFD/Platform core code to enlighten
> yourself.  If there's anything you then do not understand, please
> ask and I'll try to fill in the gaps.
>
> > >>> +static const struct mfd_cell cros_ec_accel_legacy_cells[] =3D {
> > >>> +     {
> > >>> +             .name =3D "cros-ec-accel-legacy",
> > >>> +             .id =3D 0,
> > >>
> > >> What are you using this for?
> > >>
> > >>> +             .platform_data =3D &sensor_platforms[0],
> > >>> +             .pdata_size =3D sizeof(struct cros_ec_sensor_platform=
),
> > >>> +     },
> > >>> +     {
> > >>> +             .name =3D "cros-ec-accel-legacy",
> > >>> +             .id =3D 1,
> > >>
> > >> And this?
> > >>
> > >>> +             .platform_data =3D &sensor_platforms[1],
> > >>> +             .pdata_size =3D sizeof(struct cros_ec_sensor_platform=
),
> > >>> +     }
> > >>> +};
> > >>> +
> > >>> +static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
> > >>> +{
> > >>> +     struct cros_ec_device *ec_dev =3D ec->ec_dev;
> > >>> +     u8 status;
> > >>> +     int ret;
> > >>> +
> > >>> +     /*
> > >>> +      * ECs that need legacy support are the main EC, directly con=
nected to
> > >>> +      * the AP.
> > >>> +      */
> > >>> +     if (ec->cmd_offset !=3D 0)
> > >>> +             return;
> > >>> +
> > >>> +     /*
> > >>> +      * Check if EC supports direct memory reads and if EC has
> > >>> +      * accelerometers.
> > >>> +      */
> > >>> +     if (!ec_dev->cmd_readmem)
> > >>> +             return;
> > >>> +
> > >>> +     ret =3D ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS, 1, =
&status);
> > >>> +     if (ret < 0) {
> > >>> +             dev_warn(ec->dev, "EC does not support direct reads.\=
n");
> > >>> +             return;
> > >>> +     }
> > >>> +
> > >>> +     /* Check if EC has accelerometers. */
> > >>> +     if (!(status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
> > >>> +             dev_info(ec->dev, "EC does not have accelerometers.\n=
");
> > >>> +             return;
> > >>> +     }
> > >>> +
> > >>> +     /*
> > >>> +      * Register 2 accelerometers
> > >>> +      */
> > >>> +     ret =3D mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
> > >>> +                           cros_ec_accel_legacy_cells,
> > >>> +                           ARRAY_SIZE(cros_ec_accel_legacy_cells),
> > >>> +                           NULL, 0, NULL);
> > >>> +     if (ret)
> > >>> +             dev_err(ec_dev->dev, "failed to add EC sensors\n");
> > >>> +}
> > >>> +
> > >>>  static const struct mfd_cell cros_ec_rtc_cells[] =3D {
> > >>>       {
> > >>>               .name =3D "cros-ec-rtc",
> > >>> @@ -442,6 +509,9 @@ static int ec_device_probe(struct platform_devi=
ce *pdev)
> > >>>       /* check whether this EC is a sensor hub. */
> > >>>       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
> > >>>               cros_ec_sensors_register(ec);
> > >>> +     else
> > >>> +             /* Workaroud for older EC firmware */
> > >>> +             cros_ec_accel_legacy_register(ec);
> > >>>
> > >>>       /* Check whether this EC instance has RTC host command suppor=
t */
> > >>>       if (cros_ec_check_features(ec, EC_FEATURE_RTC)) {
> > >>
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
