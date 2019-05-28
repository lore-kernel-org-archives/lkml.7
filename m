Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52CDC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7FE20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IC4V3D9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfE1VxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:53:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45546 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfE1VxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:53:21 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so6034ioc.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BgrX+JWXCR9/o5rXpnXZnXxVTnSAg7R5kIlLdqlWPoo=;
        b=IC4V3D9fTbFhDqSPSOSrr+Hp1ZBLE7KJpdtVEtBH+qm28enQPpWdvGScZPdxSS5KoA
         zUvUtCD5SSl5Ikt/+AryD9sxHxAsbPR42Fql9yLbNXY26l5+nzAvh7N1L6tbM1gk6+0m
         MXOQGUDXBsndb0WOP5AlTv9O05xP67OK1YUvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BgrX+JWXCR9/o5rXpnXZnXxVTnSAg7R5kIlLdqlWPoo=;
        b=blxKbW2f4pMoiGY6m8PKUOeOowxwNMqDxLFGZtv+6rW/P/D4+l2p/3E5BMepcAQbo5
         Ss9e9mwjKA2XTQ85tHfMvJYEzGp0nKZ4lAaDh/ktm4VtSlIeapmWMgSyWgrUsGjsH509
         sC+uUvzeNMe0ORVxmDQVX6QJgCJ1aDp4W4L/rqeI1Anx0BaEfUv1LLWEkrgyMOY6k3Ua
         PWYZd7uFEpkM//MB+/fQBs30W/na7PH2otHvWzq/IAYLBXcUiWYpoASzuBvxJK0Y7bhO
         kVQYUqI8sL28r6t5rFX+P01hcnObQkWLdp9TzafFgxmgSfov+l7OccH1qTb0ViDAGxlH
         Wi0w==
X-Gm-Message-State: APjAAAWEZZIMgtGE4mC98Gi3RfGD11QM05q4916FtbbBEUXy6v9O41n/
        xqvcjRFU0aQmWn3XWqnqfFYwro2eq6VVmO7JCbmSQA==
X-Google-Smtp-Source: APXvYqwsSJb5dE3m83QME/qY1V2aBAUmlAPWEE5/bHJZIS4KaxV2JvMD2xoTDfEVwCIpXkqLUrkQhx0kT1obglscRkU=
X-Received: by 2002:a5d:9b06:: with SMTP id y6mr17810444ion.149.1559080400099;
 Tue, 28 May 2019 14:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
 <20190228013541.76792-1-gwendal@chromium.org> <20190402034610.GG4187@dell>
In-Reply-To: <20190402034610.GG4187@dell>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 28 May 2019 14:53:08 -0700
Message-ID: <CAPUE2usfB3i4J7P4e_XdsMLV+VK7s+nS-mrD=D_WMpOHiouG2w@mail.gmail.com>
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

On Mon, Apr 1, 2019 at 8:46 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 27 Feb 2019, Gwendal Grignou wrote:
>
> > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >
> > With this patch, the cros_ec_ctl driver will register the legacy
> > accelerometer driver (named cros_ec_accel_legacy) if it fails to
> > register sensors through the usual path cros_ec_sensors_register().
> > This legacy device is present on Chromebook devices with older EC
> > firmware only supporting deprecated EC commands (Glimmer based devices)=
.
> >
> > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> > Changes in v5:
> > - Remove unnecessary white lines.
> >
> > Changes in v4:
> > - [5/8] Nit: EC -> ECs (Lee Jones)
> > - [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)
> >
> > Changes in v3:
> > - [5/8] Add the Reviewed-by Andy Shevchenko.
> >
> > Changes in v2:
> > - [5/8] Add the Reviewed-by Gwendal.
> >
> >  drivers/mfd/cros_ec_dev.c | 66 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > index d275deaecb12..64567bd0a081 100644
> > --- a/drivers/mfd/cros_ec_dev.c
> > +++ b/drivers/mfd/cros_ec_dev.c
> > @@ -376,6 +376,69 @@ static void cros_ec_sensors_register(struct cros_e=
c_dev *ec)
> >       kfree(msg);
> >  }
> >
> > +static struct cros_ec_sensor_platform sensor_platforms[] =3D {
> > +     { .sensor_num =3D 0 },
> > +     { .sensor_num =3D 1 }
> > +};
>
> I'm still very uncomfortable with this struct.
>
> Other than these indices, the sensors have no other distinguishing
> features, thus there should be no need to identify or distinguish
> between them in this way.
When initializing the sensors, the IIO driver expect to find in the
data  structure pointed by dev_get_platdata(dev), in field sensor_num
is stored the index assigned by the embedded controller to talk to a
given sensor.
cros_ec_sensors_register() use the same mechanism; in that function,
the sensor_num field is populated from the output of an EC command
MOTIONSENSE_CMD_INFO. In case of legacy mode, that command may not be
available and in any case we know the EC has only either 2
accelerometers present or nothing.

For instance, let's compare a legacy device with a more recent one:

legacy:
type                  |   id          | sensor_num   | device name
accelerometer  |   0           |   0                  | cros-ec-accel.0
accelerometer  |   1           |   1                  | cros-ec-accel.1

Modern:
type                  |   id          | sensor_num   | device name
accelerometer  |   0           |   0                  | cros-ec-accel.0
accelerometer  |   1           |   1                  | cros-ec-accel.1
gyroscope        |    0          |    2                 | cros-ec-gyro.0
magnetometer |    0          |   3                  | cros-ec-mag.0
light                  |    0          |   4                  | cros-ec-lig=
ht.0
...

Gwendal.

>
> > +static const struct mfd_cell cros_ec_accel_legacy_cells[] =3D {
> > +     {
> > +             .name =3D "cros-ec-accel-legacy",
> > +             .id =3D 0,
> > +             .platform_data =3D &sensor_platforms[0],
> > +             .pdata_size =3D sizeof(struct cros_ec_sensor_platform),
> > +     },
> > +     {
> > +             .name =3D "cros-ec-accel-legacy",
> > +             .id =3D 1,
> > +             .platform_data =3D &sensor_platforms[1],
> > +             .pdata_size =3D sizeof(struct cros_ec_sensor_platform),
> > +     }
> > +};
> > +
> > +static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
> > +{
> > +     struct cros_ec_device *ec_dev =3D ec->ec_dev;
> > +     u8 status;
> > +     int ret;
> > +
> > +     /*
> > +      * ECs that need legacy support are the main EC, directly connect=
ed to
> > +      * the AP.
> > +      */
> > +     if (ec->cmd_offset !=3D 0)
> > +             return;
> > +
> > +     /*
> > +      * Check if EC supports direct memory reads and if EC has
> > +      * accelerometers.
> > +      */
> > +     if (!ec_dev->cmd_readmem)
> > +             return;
> > +
> > +     ret =3D ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS, 1, &sta=
tus);
> > +     if (ret < 0) {
> > +             dev_warn(ec->dev, "EC does not support direct reads.\n");
> > +             return;
> > +     }
> > +
> > +     /* Check if EC has accelerometers. */
> > +     if (!(status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
> > +             dev_info(ec->dev, "EC does not have accelerometers.\n");
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * Register 2 accelerometers
> > +      */
> > +     ret =3D mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
>
> Using PLATFORM_DEVID_AUTO whilst providing the MFD cells with IDs
> doesn't make any sense.  Please remove the IDs from the cells.
Removed in V6.
>
> > +                           cros_ec_accel_legacy_cells,
> > +                           ARRAY_SIZE(cros_ec_accel_legacy_cells),
> > +                           NULL, 0, NULL);
> > +     if (ret)
> > +             dev_err(ec_dev->dev, "failed to add EC sensors\n");
> > +}
> > +
> >  static const struct mfd_cell cros_ec_cec_cells[] =3D {
> >       { .name =3D "cros-ec-cec" }
> >  };
> > @@ -437,6 +500,9 @@ static int ec_device_probe(struct platform_device *=
pdev)
> >       /* check whether this EC is a sensor hub. */
> >       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
> >               cros_ec_sensors_register(ec);
> > +     else
> > +             /* Workaroud for older EC firmware */
> > +             cros_ec_accel_legacy_register(ec);
> >
> >       /* Check whether this EC instance has CEC host command support */
> >       if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
