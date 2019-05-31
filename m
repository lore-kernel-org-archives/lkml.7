Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FF1C28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3589F263C5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RFjBFNdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfEaEqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 00:46:33 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40597 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaEqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 00:46:33 -0400
Received: by mail-it1-f193.google.com with SMTP id h11so13173851itf.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 21:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hmiuc2efT/iCc4RguVQPMikRIgI7FyrenOV0swxj8PE=;
        b=RFjBFNdkG6jGD2ZatKNjn/1E3r4ZD3r+gT04M9Y6UK9ZnWb6MoIPX9EklmB0MPsPrE
         iOZ1cWxc3TxNrQAm+kLarCXaRcsdOG2qnrECnlAOdar34vPMc6fEKe9lNcQhVqN1gC0X
         9DZwsX4Vm3MQmVi6bpzBEYwRmC3IXu0v/7HKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hmiuc2efT/iCc4RguVQPMikRIgI7FyrenOV0swxj8PE=;
        b=fG7za1FVJPdYrZ17fty8/aSFDasQwzqRrdKoHL9J67g21g5X8JM2jGcqIYK8vQ3vdD
         hcfsJN5D6p3/hc/5gv7RraWryGaboC4EycbjCNNbvbkm4svFOEsu6jRHFXC6LcTCjBxt
         dyewUMkVrh67e4ObWkkNLtz+OP9DJsThBV+aALOK1o+j/cbNwVRfeZRCJvBqnAfQBFWD
         UCvm2YJZDzdWcIdGKSqIjQooTDRgvR8WD1Ez2CezKd3z9w0qiEwIuSlK5kXxOHkAN1xt
         MNjrCE1VTBgzp+WRAWB9Ni4a7lvQqCAL5xa6vcQoFU+H+9xcxWgre8T1D5U+IHEG2lVE
         aCKA==
X-Gm-Message-State: APjAAAVxXJPv+0x2+Ik5El8p1qCDohBwZKLoG2dv6YASO+b8UUafIUVF
        WDqkZ3HI2PSg3ou2X7R08iA3JQDjX62TH2RxGEna33gYiik=
X-Google-Smtp-Source: APXvYqzyVaVvCSp+zzPeny3B9KolWe06X5m3W5p4I+wYz2JLK2kvvah4cbNq9Sm6VHoOAgUo5sZWh8R87ohbpSFWQYY=
X-Received: by 2002:a24:80c4:: with SMTP id g187mr6256620itd.35.1559277992008;
 Thu, 30 May 2019 21:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
 <20190228013541.76792-1-gwendal@chromium.org> <20190402034610.GG4187@dell>
 <CAPUE2usfB3i4J7P4e_XdsMLV+VK7s+nS-mrD=D_WMpOHiouG2w@mail.gmail.com>
 <20190529114454.GJ4574@dell> <CAPUE2usYa3z3mcxo6fGsBL-FXLcNy1-Pr+WoQsKmTjhNZCZwSA@mail.gmail.com>
 <20190530074819.GM4574@dell>
In-Reply-To: <20190530074819.GM4574@dell>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 May 2019 21:46:20 -0700
Message-ID: <CAPUE2usBh5r22Ak3LxLK-hS7wOObAdW4v1r8TDFUWPz=05FGMw@mail.gmail.com>
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

On Thu, May 30, 2019 at 12:48 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 29 May 2019, Gwendal Grignou wrote:
>
> > On Wed, May 29, 2019 at 4:44 AM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Tue, 28 May 2019, Gwendal Grignou wrote:
> > >
> > > > On Mon, Apr 1, 2019 at 8:46 PM Lee Jones <lee.jones@linaro.org> wro=
te:
> > > > >
> > > > > On Wed, 27 Feb 2019, Gwendal Grignou wrote:
> > > > >
> > > > > > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > > >
> > > > > > With this patch, the cros_ec_ctl driver will register the legac=
y
> > > > > > accelerometer driver (named cros_ec_accel_legacy) if it fails t=
o
> > > > > > register sensors through the usual path cros_ec_sensors_registe=
r().
> > > > > > This legacy device is present on Chromebook devices with older =
EC
> > > > > > firmware only supporting deprecated EC commands (Glimmer based =
devices).
> > > > > >
> > > > > > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora=
.com>
> > > > > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > ---
> > > > > > Changes in v5:
> > > > > > - Remove unnecessary white lines.
> > > > > >
> > > > > > Changes in v4:
> > > > > > - [5/8] Nit: EC -> ECs (Lee Jones)
> > > > > > - [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones=
)
> > > > > >
> > > > > > Changes in v3:
> > > > > > - [5/8] Add the Reviewed-by Andy Shevchenko.
> > > > > >
> > > > > > Changes in v2:
> > > > > > - [5/8] Add the Reviewed-by Gwendal.
> > > > > >
> > > > > >  drivers/mfd/cros_ec_dev.c | 66 +++++++++++++++++++++++++++++++=
++++++++
> > > > > >  1 file changed, 66 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_de=
v.c
> > > > > > index d275deaecb12..64567bd0a081 100644
> > > > > > --- a/drivers/mfd/cros_ec_dev.c
> > > > > > +++ b/drivers/mfd/cros_ec_dev.c
> > > > > > @@ -376,6 +376,69 @@ static void cros_ec_sensors_register(struc=
t cros_ec_dev *ec)
> > > > > >       kfree(msg);
> > > > > >  }
> > > > > >
> > > > > > +static struct cros_ec_sensor_platform sensor_platforms[] =3D {
> > > > > > +     { .sensor_num =3D 0 },
> > > > > > +     { .sensor_num =3D 1 }
> > > > > > +};
> > > > >
> > > > > I'm still very uncomfortable with this struct.
> > > > >
> > > > > Other than these indices, the sensors have no other distinguishin=
g
> > > > > features, thus there should be no need to identify or distinguish
> > > > > between them in this way.
> > > > When initializing the sensors, the IIO driver expect to find in the
> > > > data  structure pointed by dev_get_platdata(dev), in field sensor_n=
um
> > > > is stored the index assigned by the embedded controller to talk to =
a
> > > > given sensor.
> > > > cros_ec_sensors_register() use the same mechanism; in that function=
,
> > > > the sensor_num field is populated from the output of an EC command
> > > > MOTIONSENSE_CMD_INFO. In case of legacy mode, that command may not =
be
> > > > available and in any case we know the EC has only either 2
> > > > accelerometers present or nothing.
> > > >
> > > > For instance, let's compare a legacy device with a more recent one:
> > > >
> > > > legacy:
> > > > type                  |   id          | sensor_num   | device name
> > > > accelerometer  |   0           |   0                  | cros-ec-acc=
el.0
> > > > accelerometer  |   1           |   1                  | cros-ec-acc=
el.1
> > > >
> > > > Modern:
> > > > type                  |   id          | sensor_num   | device name
> > > > accelerometer  |   0           |   0                  | cros-ec-acc=
el.0
> > > > accelerometer  |   1           |   1                  | cros-ec-acc=
el.1
> > > > gyroscope        |    0          |    2                 | cros-ec-g=
yro.0
> > > > magnetometer |    0          |   3                  | cros-ec-mag.0
> > > > light                  |    0          |   4                  | cro=
s-ec-light.0
> > > > ...
> > >
> > > Why can't these numbers be assigned at runtime?
> > I assume you want to know why IIO drivers need to know "sensor_num"
> > ahead of time. It is because each IIO driver is independent from the
> > other.
> > Let assume there was 2 light sensors in the device:
> > type                  |   id          | sensor_num   | device name
> >  light                  |    0          |   4                  | cros-e=
c-light.0
> >  light                  |    1          |   5                  | cros-e=
c-light.1
> >
> > In case of sensors of the same type without sensor_num, cros-ec-light
> > driver has no information at probe time if it should bind to sensors
> > named by the EC 4 or 5.
> >
> > We could get away with cros-ec-accel, as EC always presents
> > accelerometers with sensor_num  0 and 1, but I don't want to rely on
> > this property in the general case.
> > Only cros_ec_dev MFD driver has the global view of all sensors availabl=
e.
>
> Well seeing as this implementation has already been accepted and you're
> only *using* it, rather than creating it, I think this conversation is
> moot.  It looks like the original implementation patch was not
> reviewed by me, which is frustrating since I would have NACKed it.
>
> Just so you know, pointlessly enumerating identical devices manually
> is not a good practice.  It is one we reject all the time.  This
> imp. should too have been rejected on submission.
I wrote the original code, Enric submitted it, so I am not just using it.
We can work on implementing the right way. Which model should I follow?
The code function is similar to HID sensor hub code which is done in
driver/hid/hid-sensor-hub.c [sensor_hub_probe()] which calls
mfd_add_hotplug_devices() with an array of mfd_cell,
hid_sensor_hub_client_devs. Each cell platfom_data contains  a hsdev
structure that is shared between the iio driver and the hid sensor hub
driver. hsdev->usage information is sent back and forth between
specialized hid IIO device driver and the HID sensor hub driver, for
example when sensor_hub_input_attr_get_raw_value() is called.
hsdev->usage has the same usage a sensor_num I am using.

I am not enumerating identical devices twice: the embedded controller
manages a list of sensors:

For instance on pixelbook, it look like:
       +--------+
        | EC    |
       +--------+
   ( via several i2c/spi buses)
+--------------------+--------------+-------- ...
|                         |                  |
IMU (base)     light/prox    Accelrometer (lid)
|
Magnetometer

A given hardware sensor may be composed of multiple logical sensors
(IMU is a accelerometer and a gyroscope into one package).

The EC firmware list all the (logical) sensors in array, and that
unique index - sensor_num - points to a single logical sensor.

Is it more acceptable if I use PLATFORM_DEVID_AUTO instead of
assigning .id myself?
The topology will look like:
find . -type d -name \*auto
./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.auto
./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.auto=
/cros-usbpd-logger.8.auto
./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.auto=
/cros-ec-accel.2.auto
./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.auto=
/cros-ec-gyro.4.auto
./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.auto=
/cros-usbpd-charger.7.auto
./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.auto=
/cros-ec-gyro.3.auto
./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.auto=
/cros-ec-mag.5.auto
./devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/cros-ec-dev.1.auto=
/cros-ec-ring.6.auto
./devices/pci0000:00/0000:00:15.2/i2c_designware.2/i2c-8/i2c-GOOG0008:00/cr=
os-ec-dev.0.auto

Thank you for your support,

Gwendal.





>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
