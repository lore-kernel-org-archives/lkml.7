Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8000BC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA5A24278
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ASOtyE+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfEaVCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:02:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36003 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfEaVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:02:40 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so9395406ioh.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s2cT9kRTlwEwPIOiuEi6w6BM8g2kzG1KzhhOLhNEGTI=;
        b=ASOtyE+SAhvZ6cqyCNBckHHyR6jA/7DPZ0m9ERB1LowG/4/zaBeVg5p6Fdn+4VgmST
         lSWluaJR9U/+elezaJCIsdD6J1ogbC417sfq8+I12a6FOvPvRKktlF+KXFjgLstZJ7oT
         h4rrnwpq1dkc1v6iob/55DDARyijXlRqY0bas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s2cT9kRTlwEwPIOiuEi6w6BM8g2kzG1KzhhOLhNEGTI=;
        b=U2/ar5JTEESllOoB/YeqOBxJLOBXnk1jSXVrtgz4ZC5n03LxpwkMlBcML5FlOVAM4K
         SExjyRfLW77mrcICxJ2go17oXETx1A26bSD1AmAdkapw7La14Y2es7pD+bcw4NSCiVSU
         yjbN/H4aQ0rc6/bMp+pweUOsY5RrGY2oMvNONWayA6ytRzVoxY5+c+sW/JV3+QYGG37Y
         uULssvOft+3LL4GsQv7TU1zIrGr1vpMnFcuYwGf9v4h5QBrFZVRPVGfAFTNUFR3WMcre
         zhfISBK7m6b5mSI7P/MTRlUYfq1tcorqQfNa4deQ0R7bQkmrBtUpmRmKJHuwyWluMAsG
         2uNg==
X-Gm-Message-State: APjAAAWSxvGtswSkp4frYmFIj7TUBCkaAI6BhSZ0iJvmU12btbuD6ctq
        ygBIV4j8vkygM9OP0oNq4PWNjV1CTUZaHZ6EZsyc5Q==
X-Google-Smtp-Source: APXvYqx1fqceeDYo10HUGqBPvrA+8Bo3oWVboRhE4iOfo0kRpt1izdWK/F6896RHMB1wbOuq1vnGshXLwbh8/4XfSfw=
X-Received: by 2002:a6b:8f93:: with SMTP id r141mr8226701iod.145.1559336559643;
 Fri, 31 May 2019 14:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
 <20190228013541.76792-1-gwendal@chromium.org> <20190402034610.GG4187@dell>
 <CAPUE2usfB3i4J7P4e_XdsMLV+VK7s+nS-mrD=D_WMpOHiouG2w@mail.gmail.com>
 <20190529114454.GJ4574@dell> <CAPUE2usYa3z3mcxo6fGsBL-FXLcNy1-Pr+WoQsKmTjhNZCZwSA@mail.gmail.com>
 <20190530074819.GM4574@dell> <CAPUE2usBh5r22Ak3LxLK-hS7wOObAdW4v1r8TDFUWPz=05FGMw@mail.gmail.com>
 <20190531081353.GQ4574@dell>
In-Reply-To: <20190531081353.GQ4574@dell>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 31 May 2019 14:02:28 -0700
Message-ID: <CAPUE2uuzVGexaWxy4zLjCZT9=rRfciQB44Fj-7bXhsJQY6uMhA@mail.gmail.com>
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

On Fri, May 31, 2019 at 1:13 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 30 May 2019, Gwendal Grignou wrote:
>
> > On Thu, May 30, 2019 at 12:48 AM Lee Jones <lee.jones@linaro.org> wrote=
:
> > >
> > > On Wed, 29 May 2019, Gwendal Grignou wrote:
> > >
> > > > On Wed, May 29, 2019 at 4:44 AM Lee Jones <lee.jones@linaro.org> wr=
ote:
> > > > >
> > > > > On Tue, 28 May 2019, Gwendal Grignou wrote:
> > > > >
> > > > > > On Mon, Apr 1, 2019 at 8:46 PM Lee Jones <lee.jones@linaro.org>=
 wrote:
> > > > > > >
> > > > > > > On Wed, 27 Feb 2019, Gwendal Grignou wrote:
> > > > > > >
> > > > > > > > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > > > > >
> > > > > > > > With this patch, the cros_ec_ctl driver will register the l=
egacy
> > > > > > > > accelerometer driver (named cros_ec_accel_legacy) if it fai=
ls to
> > > > > > > > register sensors through the usual path cros_ec_sensors_reg=
ister().
> > > > > > > > This legacy device is present on Chromebook devices with ol=
der EC
> > > > > > > > firmware only supporting deprecated EC commands (Glimmer ba=
sed devices).
> > > > > > > >
> > > > > > > > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@colla=
bora.com>
> > > > > > > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > > ---
> > > > > > > > Changes in v5:
> > > > > > > > - Remove unnecessary white lines.
> > > > > > > >
> > > > > > > > Changes in v4:
> > > > > > > > - [5/8] Nit: EC -> ECs (Lee Jones)
> > > > > > > > - [5/8] Statically define cros_ec_accel_legacy_cells (Lee J=
ones)
> > > > > > > >
> > > > > > > > Changes in v3:
> > > > > > > > - [5/8] Add the Reviewed-by Andy Shevchenko.
> > > > > > > >
> > > > > > > > Changes in v2:
> > > > > > > > - [5/8] Add the Reviewed-by Gwendal.
> > > > > > > >
> > > > > > > >  drivers/mfd/cros_ec_dev.c | 66 +++++++++++++++++++++++++++=
++++++++++++
> > > > > > > >  1 file changed, 66 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_e=
c_dev.c
> > > > > > > > index d275deaecb12..64567bd0a081 100644
> > > > > > > > --- a/drivers/mfd/cros_ec_dev.c
> > > > > > > > +++ b/drivers/mfd/cros_ec_dev.c
> > > > > > > > @@ -376,6 +376,69 @@ static void cros_ec_sensors_register(s=
truct cros_ec_dev *ec)
> > > > > > > >       kfree(msg);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static struct cros_ec_sensor_platform sensor_platforms[] =
=3D {
> > > > > > > > +     { .sensor_num =3D 0 },
> > > > > > > > +     { .sensor_num =3D 1 }
> > > > > > > > +};
> > > > > > >
> > > > > > > I'm still very uncomfortable with this struct.
> > > > > > >
> > > > > > > Other than these indices, the sensors have no other distingui=
shing
> > > > > > > features, thus there should be no need to identify or disting=
uish
> > > > > > > between them in this way.
> > > > > > When initializing the sensors, the IIO driver expect to find in=
 the
> > > > > > data  structure pointed by dev_get_platdata(dev), in field sens=
or_num
> > > > > > is stored the index assigned by the embedded controller to talk=
 to a
> > > > > > given sensor.
> > > > > > cros_ec_sensors_register() use the same mechanism; in that func=
tion,
> > > > > > the sensor_num field is populated from the output of an EC comm=
and
> > > > > > MOTIONSENSE_CMD_INFO. In case of legacy mode, that command may =
not be
> > > > > > available and in any case we know the EC has only either 2
> > > > > > accelerometers present or nothing.
> > > > > >
> > > > > > For instance, let's compare a legacy device with a more recent =
one:
> > > > > >
> > > > > > legacy:
> > > > > > type                  |   id          | sensor_num   | device n=
ame
> > > > > > accelerometer  |   0           |   0                  | cros-ec=
-accel.0
> > > > > > accelerometer  |   1           |   1                  | cros-ec=
-accel.1
> > > > > >
> > > > > > Modern:
> > > > > > type                  |   id          | sensor_num   | device n=
ame
> > > > > > accelerometer  |   0           |   0                  | cros-ec=
-accel.0
> > > > > > accelerometer  |   1           |   1                  | cros-ec=
-accel.1
> > > > > > gyroscope        |    0          |    2                 | cros-=
ec-gyro.0
> > > > > > magnetometer |    0          |   3                  | cros-ec-m=
ag.0
> > > > > > light                  |    0          |   4                  |=
 cros-ec-light.0
> > > > > > ...
> > > > >
> > > > > Why can't these numbers be assigned at runtime?
> > > > I assume you want to know why IIO drivers need to know "sensor_num"
> > > > ahead of time. It is because each IIO driver is independent from th=
e
> > > > other.
> > > > Let assume there was 2 light sensors in the device:
> > > > type                  |   id          | sensor_num   | device name
> > > >  light                  |    0          |   4                  | cr=
os-ec-light.0
> > > >  light                  |    1          |   5                  | cr=
os-ec-light.1
> > > >
> > > > In case of sensors of the same type without sensor_num, cros-ec-lig=
ht
> > > > driver has no information at probe time if it should bind to sensor=
s
> > > > named by the EC 4 or 5.
> > > >
> > > > We could get away with cros-ec-accel, as EC always presents
> > > > accelerometers with sensor_num  0 and 1, but I don't want to rely o=
n
> > > > this property in the general case.
> > > > Only cros_ec_dev MFD driver has the global view of all sensors avai=
lable.
> > >
> > > Well seeing as this implementation has already been accepted and you'=
re
> > > only *using* it, rather than creating it, I think this conversation i=
s
> > > moot.  It looks like the original implementation patch was not
> > > reviewed by me, which is frustrating since I would have NACKed it.
> > >
> > > Just so you know, pointlessly enumerating identical devices manually
> > > is not a good practice.  It is one we reject all the time.  This
> > > imp. should too have been rejected on submission.
>
> > I wrote the original code, Enric submitted it, so I am not just using i=
t.
>
> My point was, *this* patch is just using it.  The implementation has
> already been applied to the mainline kernel.  Who wrote the initial
> commit is not important at this point.
>
> > We can work on implementing the right way. Which model should I follow?
> > The code function is similar to HID sensor hub code which is done in
> > driver/hid/hid-sensor-hub.c [sensor_hub_probe()] which calls
> > mfd_add_hotplug_devices() with an array of mfd_cell,
> > hid_sensor_hub_client_devs. Each cell platfom_data contains  a hsdev
> > structure that is shared between the iio driver and the hid sensor hub
> > driver. hsdev->usage information is sent back and forth between
> > specialized hid IIO device driver and the HID sensor hub driver, for
> > example when sensor_hub_input_attr_get_raw_value() is called.
> > hsdev->usage has the same usage a sensor_num I am using.
>
> It looks like the HID Usage implementation is using a set of
> pre-defined values to identify sensor *types*:
>
>   include/linux/hid-sensor-ids.h
Yes, hsdev->usage, aka usage_id define the types between 0x00 and 0xFF.
For accessing a paritcualre fileds, we use attr_usage_id, between
0x100 and 0x7FF.
AFAIK, a sensorhub/collection can not contain to sensor of the same type.
>
> Where as your implementation is confusing me.  In some instances you
> are using it as what looks like an *index* into a register set:
>
>   ec_cmd_read_u16(st->ec,
>                 EC_MEMMAP_ACC_DATA +
>                 sizeof(s16) *
>                 (1 + i + st->sensor_num * MAX_AXIS),
>                 data);
>
> And at other times it is used for sensor *types*, but in a very
> limited way:
>
>   enum motionsensor_location {
>           MOTIONSENSE_LOC_BASE =3D 0,
>           MOTIONSENSE_LOC_LID =3D 1,
>           MOTIONSENSE_LOC_MAX,
>   };
>
>   static char *cros_ec_accel_legacy_loc_strings[] =3D {
>           [MOTIONSENSE_LOC_BASE] =3D "base",
>           [MOTIONSENSE_LOC_LID] =3D "lid",
>           [MOTIONSENSE_LOC_MAX] =3D "unknown",
>   };
>
>   return sprintf(buf, "%s\n",
>                  cros_ec_accel_legacy_loc_strings[st->sensor_num +
>                                                 MOTIONSENSE_LOC_BASE]);
In the legacy case, the location is hard-coded from sensor_num, the
index used by the EC: sensor 0 is in base, 1 is in the lid.
This limitation is removed from newer EC implementation, the EC
subcommand MOTIONSENSE_CMD_INFO provide that information.
>
> > I am not enumerating identical devices twice: the embedded controller
> > manages a list of sensors:
> >
> > For instance on pixelbook, it look like:
> >        +--------+
> >         | EC    |
> >        +--------+
> >    ( via several i2c/spi buses)
> > +--------------------+--------------+-------- ...
> > |                         |                  |
> > IMU (base)     light/prox    Accelrometer (lid)
> > |
> > Magnetometer
> >
> > A given hardware sensor may be composed of multiple logical sensors
> > (IMU is a accelerometer and a gyroscope into one package).
> >
> > The EC firmware list all the (logical) sensors in array, and that
> > unique index - sensor_num - points to a single logical sensor.
>
> What what is 'sensor_num'; is it a channel address/number similar to
> what I2C HIDs use to communicate over a specific I2C line, or is it a
> type, similar to what HID devices provide on request for
> identification purposes?
>
> > Is it more acceptable if I use PLATFORM_DEVID_AUTO instead of
> > assigning .id myself?
>
> Is this a separate question, or can 'sensor_num' be any unique
> arbitrary number?
No, it is assigned by the EC.

Thanks for your time,

Gwendal.
>
> > The topology will look like:
> > find . -type d -name \*auto
> > ./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.=
auto
> > ./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.=
auto/cros-usbpd-logger.8.auto
> > ./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.=
auto/cros-ec-accel.2.auto
> > ./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.=
auto/cros-ec-gyro.4.auto
> > ./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.=
auto/cros-usbpd-charger.7.auto
> > ./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.=
auto/cros-ec-gyro.3.auto
> > ./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.=
auto/cros-ec-mag.5.auto
> > ./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.=
auto/cros-ec-ring.6.auto
> > ./devices/pci0000:00/0000:00:15.2/i2c_designware.2/i2c-8/i2c-GOOG0008:0=
0/cros-ec-dev.0.auto
> >
> > Thank you for your support,
>
> No problem.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
