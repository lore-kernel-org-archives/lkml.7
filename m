Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3164C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633FF27433
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dTrmNJd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfFCRCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:02:09 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36251 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFCRCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:02:09 -0400
Received: by mail-it1-f193.google.com with SMTP id e184so27759350ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=04thPVhmVKsDKw/HrRNXNx0ggqXDshFXEU85TFPmwvU=;
        b=dTrmNJd2SMJe1apmqDxaQSIwOzO8uhE4L0beiWy8cry5TRcFhv5aGgkDcExJF+7qo7
         y4IOwM+mVyCL33E3PqHneAAzQjcnIr/mGtB7D+Rk8V2/P0Ytoo7jkQWQNzIX4XZPhZDU
         xurfSSWoP2oGTxZPzPCWDv0iHF+Sr6JRMInBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=04thPVhmVKsDKw/HrRNXNx0ggqXDshFXEU85TFPmwvU=;
        b=PMvQtkxilO+msg+VYY2QsWnr3gNCRVAxvK3el7+et3hIGkDQpdWY30cB+xRTEEBArM
         24kK4rw3MbMc0jtcalr947Tn2HQQfdRuig0IfitY83d5FtFrhr8kxPB3O+7+eZmn+61d
         XjnZJf1jWh4mBvuDOE4kYHeafN9JuNLR8OHiAtFLgindimybLwk1Kpmtk3XC5F7M9o3s
         9be2MTQsJq3iR6DPaP7tRosh1EM2YsLiHJg83cORH1IKomBL8qZsJ+pzdOZ/u9D50k7u
         Mz33nt+PSpEzqxmg0d8kDSHS7NWlw/RxIvNSd3GjmvuQ2QFDOrGCQSK+2nqDza4r93nt
         2KYQ==
X-Gm-Message-State: APjAAAXEQWilzPc4+5mMyvEInkgsemhDZaP5hZeWrKRlemwoHn2/JrBm
        uNBSzxudqsOlFRoYCJYd8xN3+hnMXMRLo/wc/GzD3A==
X-Google-Smtp-Source: APXvYqxPyyVgk6uwnXwWJMOve6BJ8IVdROTTKbKuTsjgwz7np0nHUMaQDLjT7KU+2CwrjWnAmv7c5YuX9pkU60pi0mg=
X-Received: by 2002:a02:2a0f:: with SMTP id w15mr8729022jaw.52.1559581327745;
 Mon, 03 Jun 2019 10:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
 <20190228013541.76792-1-gwendal@chromium.org> <20190402034610.GG4187@dell>
 <CAPUE2usfB3i4J7P4e_XdsMLV+VK7s+nS-mrD=D_WMpOHiouG2w@mail.gmail.com>
 <20190529114454.GJ4574@dell> <CAPUE2usYa3z3mcxo6fGsBL-FXLcNy1-Pr+WoQsKmTjhNZCZwSA@mail.gmail.com>
 <20190530074819.GM4574@dell> <CAPUE2usBh5r22Ak3LxLK-hS7wOObAdW4v1r8TDFUWPz=05FGMw@mail.gmail.com>
 <20190531081353.GQ4574@dell> <CAPUE2uuzVGexaWxy4zLjCZT9=rRfciQB44Fj-7bXhsJQY6uMhA@mail.gmail.com>
 <20190603062257.GA4797@dell>
In-Reply-To: <20190603062257.GA4797@dell>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 3 Jun 2019 10:01:57 -0700
Message-ID: <CAPUE2uvR3ch4Nv6vz8o9ggLXSVZfT5as8x_HoP5ddvFoS3kwxw@mail.gmail.com>
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

On Sun, Jun 2, 2019 at 11:23 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 31 May 2019, Gwendal Grignou wrote:
>
> > On Fri, May 31, 2019 at 1:13 AM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Thu, 30 May 2019, Gwendal Grignou wrote:
> > >
> > > > On Thu, May 30, 2019 at 12:48 AM Lee Jones <lee.jones@linaro.org> w=
rote:
> > > > >
> > > > > On Wed, 29 May 2019, Gwendal Grignou wrote:
> > > > >
> > > > > > On Wed, May 29, 2019 at 4:44 AM Lee Jones <lee.jones@linaro.org=
> wrote:
> > > > > > >
> > > > > > > On Tue, 28 May 2019, Gwendal Grignou wrote:
> > > > > > >
> > > > > > > > On Mon, Apr 1, 2019 at 8:46 PM Lee Jones <lee.jones@linaro.=
org> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 27 Feb 2019, Gwendal Grignou wrote:
> > > > > > > > >
> > > > > > > > > > From: Enric Balletbo i Serra <enric.balletbo@collabora.=
com>
> > > > > > > > > >
> > > > > > > > > > With this patch, the cros_ec_ctl driver will register t=
he legacy
> > > > > > > > > > accelerometer driver (named cros_ec_accel_legacy) if it=
 fails to
> > > > > > > > > > register sensors through the usual path cros_ec_sensors=
_register().
> > > > > > > > > > This legacy device is present on Chromebook devices wit=
h older EC
> > > > > > > > > > firmware only supporting deprecated EC commands (Glimme=
r based devices).
> > > > > > > > > >
> > > > > > > > > > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > > > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@c=
ollabora.com>
> > > > > > > > > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com=
>
> > > > > > > > > > ---
> > > > > > > > > > Changes in v5:
> > > > > > > > > > - Remove unnecessary white lines.
> > > > > > > > > >
> > > > > > > > > > Changes in v4:
> > > > > > > > > > - [5/8] Nit: EC -> ECs (Lee Jones)
> > > > > > > > > > - [5/8] Statically define cros_ec_accel_legacy_cells (L=
ee Jones)
> > > > > > > > > >
> > > > > > > > > > Changes in v3:
> > > > > > > > > > - [5/8] Add the Reviewed-by Andy Shevchenko.
> > > > > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - [5/8] Add the Reviewed-by Gwendal.
> > > > > > > > > >
> > > > > > > > > >  drivers/mfd/cros_ec_dev.c | 66 +++++++++++++++++++++++=
++++++++++++++++
> > > > > > > > > >  1 file changed, 66 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cr=
os_ec_dev.c
> > > > > > > > > > index d275deaecb12..64567bd0a081 100644
> > > > > > > > > > --- a/drivers/mfd/cros_ec_dev.c
> > > > > > > > > > +++ b/drivers/mfd/cros_ec_dev.c
> > > > > > > > > > @@ -376,6 +376,69 @@ static void cros_ec_sensors_regist=
er(struct cros_ec_dev *ec)
> > > > > > > > > >       kfree(msg);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static struct cros_ec_sensor_platform sensor_platforms=
[] =3D {
> > > > > > > > > > +     { .sensor_num =3D 0 },
> > > > > > > > > > +     { .sensor_num =3D 1 }
> > > > > > > > > > +};
> > > > > > > > >
> > > > > > > > > I'm still very uncomfortable with this struct.
> > > > > > > > >
> > > > > > > > > Other than these indices, the sensors have no other disti=
nguishing
> > > > > > > > > features, thus there should be no need to identify or dis=
tinguish
> > > > > > > > > between them in this way.
> > > > > > > > When initializing the sensors, the IIO driver expect to fin=
d in the
> > > > > > > > data  structure pointed by dev_get_platdata(dev), in field =
sensor_num
> > > > > > > > is stored the index assigned by the embedded controller to =
talk to a
> > > > > > > > given sensor.
> > > > > > > > cros_ec_sensors_register() use the same mechanism; in that =
function,
> > > > > > > > the sensor_num field is populated from the output of an EC =
command
> > > > > > > > MOTIONSENSE_CMD_INFO. In case of legacy mode, that command =
may not be
> > > > > > > > available and in any case we know the EC has only either 2
> > > > > > > > accelerometers present or nothing.
> > > > > > > >
> > > > > > > > For instance, let's compare a legacy device with a more rec=
ent one:
> > > > > > > >
> > > > > > > > legacy:
> > > > > > > > type                  |   id          | sensor_num   | devi=
ce name
> > > > > > > > accelerometer  |   0           |   0                  | cro=
s-ec-accel.0
> > > > > > > > accelerometer  |   1           |   1                  | cro=
s-ec-accel.1
> > > > > > > >
> > > > > > > > Modern:
> > > > > > > > type                  |   id          | sensor_num   | devi=
ce name
> > > > > > > > accelerometer  |   0           |   0                  | cro=
s-ec-accel.0
> > > > > > > > accelerometer  |   1           |   1                  | cro=
s-ec-accel.1
> > > > > > > > gyroscope        |    0          |    2                 | c=
ros-ec-gyro.0
> > > > > > > > magnetometer |    0          |   3                  | cros-=
ec-mag.0
> > > > > > > > light                  |    0          |   4               =
   | cros-ec-light.0
> > > > > > > > ...
> > > > > > >
> > > > > > > Why can't these numbers be assigned at runtime?
> > > > > > I assume you want to know why IIO drivers need to know "sensor_=
num"
> > > > > > ahead of time. It is because each IIO driver is independent fro=
m the
> > > > > > other.
> > > > > > Let assume there was 2 light sensors in the device:
> > > > > > type                  |   id          | sensor_num   | device n=
ame
> > > > > >  light                  |    0          |   4                  =
| cros-ec-light.0
> > > > > >  light                  |    1          |   5                  =
| cros-ec-light.1
> > > > > >
> > > > > > In case of sensors of the same type without sensor_num, cros-ec=
-light
> > > > > > driver has no information at probe time if it should bind to se=
nsors
> > > > > > named by the EC 4 or 5.
> > > > > >
> > > > > > We could get away with cros-ec-accel, as EC always presents
> > > > > > accelerometers with sensor_num  0 and 1, but I don't want to re=
ly on
> > > > > > this property in the general case.
> > > > > > Only cros_ec_dev MFD driver has the global view of all sensors =
available.
> > > > >
> > > > > Well seeing as this implementation has already been accepted and =
you're
> > > > > only *using* it, rather than creating it, I think this conversati=
on is
> > > > > moot.  It looks like the original implementation patch was not
> > > > > reviewed by me, which is frustrating since I would have NACKed it=
.
> > > > >
> > > > > Just so you know, pointlessly enumerating identical devices manua=
lly
> > > > > is not a good practice.  It is one we reject all the time.  This
> > > > > imp. should too have been rejected on submission.
> > >
> > > > I wrote the original code, Enric submitted it, so I am not just usi=
ng it.
> > >
> > > My point was, *this* patch is just using it.  The implementation has
> > > already been applied to the mainline kernel.  Who wrote the initial
> > > commit is not important at this point.
> > >
> > > > We can work on implementing the right way. Which model should I fol=
low?
> > > > The code function is similar to HID sensor hub code which is done i=
n
> > > > driver/hid/hid-sensor-hub.c [sensor_hub_probe()] which calls
> > > > mfd_add_hotplug_devices() with an array of mfd_cell,
> > > > hid_sensor_hub_client_devs. Each cell platfom_data contains  a hsde=
v
> > > > structure that is shared between the iio driver and the hid sensor =
hub
> > > > driver. hsdev->usage information is sent back and forth between
> > > > specialized hid IIO device driver and the HID sensor hub driver, fo=
r
> > > > example when sensor_hub_input_attr_get_raw_value() is called.
> > > > hsdev->usage has the same usage a sensor_num I am using.
> > >
> > > It looks like the HID Usage implementation is using a set of
> > > pre-defined values to identify sensor *types*:
> > >
> > >   include/linux/hid-sensor-ids.h
> > Yes, hsdev->usage, aka usage_id define the types between 0x00 and 0xFF.
> > For accessing a paritcualre fileds, we use attr_usage_id, between
> > 0x100 and 0x7FF.
> > AFAIK, a sensorhub/collection can not contain to sensor of the same typ=
e.
> > >
> > > Where as your implementation is confusing me.  In some instances you
> > > are using it as what looks like an *index* into a register set:
> > >
> > >   ec_cmd_read_u16(st->ec,
> > >                 EC_MEMMAP_ACC_DATA +
> > >                 sizeof(s16) *
> > >                 (1 + i + st->sensor_num * MAX_AXIS),
> > >                 data);
> > >
> > > And at other times it is used for sensor *types*, but in a very
> > > limited way:
> > >
> > >   enum motionsensor_location {
> > >           MOTIONSENSE_LOC_BASE =3D 0,
> > >           MOTIONSENSE_LOC_LID =3D 1,
> > >           MOTIONSENSE_LOC_MAX,
> > >   };
> > >
> > >   static char *cros_ec_accel_legacy_loc_strings[] =3D {
> > >           [MOTIONSENSE_LOC_BASE] =3D "base",
> > >           [MOTIONSENSE_LOC_LID] =3D "lid",
> > >           [MOTIONSENSE_LOC_MAX] =3D "unknown",
> > >   };
> > >
> > >   return sprintf(buf, "%s\n",
> > >                  cros_ec_accel_legacy_loc_strings[st->sensor_num +
> > >                                                 MOTIONSENSE_LOC_BASE]=
);
> > In the legacy case, the location is hard-coded from sensor_num, the
> > index used by the EC: sensor 0 is in base, 1 is in the lid.
> > This limitation is removed from newer EC implementation, the EC
> > subcommand MOTIONSENSE_CMD_INFO provide that information.
I will send a patch to remove that remove that code and use _INFO_
even in legacy mode, it is one of a few command that haven't changed
since inception.
> > >
> > > > I am not enumerating identical devices twice: the embedded controll=
er
> > > > manages a list of sensors:
> > > >
> > > > For instance on pixelbook, it look like:
> > > >        +--------+
> > > >         | EC    |
> > > >        +--------+
> > > >    ( via several i2c/spi buses)
> > > > +--------------------+--------------+-------- ...
> > > > |                         |                  |
> > > > IMU (base)     light/prox    Accelrometer (lid)
> > > > |
> > > > Magnetometer
> > > >
> > > > A given hardware sensor may be composed of multiple logical sensors
> > > > (IMU is a accelerometer and a gyroscope into one package).
> > > >
> > > > The EC firmware list all the (logical) sensors in array, and that
> > > > unique index - sensor_num - points to a single logical sensor.
> > >
> > > What what is 'sensor_num'; is it a channel address/number similar to
> > > what I2C HIDs use to communicate over a specific I2C line, or is it a
> > > type, similar to what HID devices provide on request for
> > > identification purposes?
> > >
> > > > Is it more acceptable if I use PLATFORM_DEVID_AUTO instead of
> > > > assigning .id myself?
> > >
> > > Is this a separate question, or can 'sensor_num' be any unique
> > > arbitrary number?
> > No, it is assigned by the EC.
>
> Is it assigned *by* the EC or *to* the EC.
The sensor_num filed is set the EC.
>
> If it is assigned *by* the EC, can't you ask the EC for it?
If the IIO driver knows the cros_sensor_type type, it could retrieve
the sensor_num[s] for all the sensors of that type.
However, the IIO driver itself, does not know which one to use,
another piece of code (cros_ec_dev) must keep track of which sensors
are already take care of.
>
> I asked this before, but was not given the answer I wanted:
>
> > > Why can't these numbers be assigned at runtime?
> > I assume you want to know why IIO drivers need to know "sensor_num"
> > ahead of time. It is because each IIO driver is independent from the
> > other.
>
> Is there a way to call into the EC and request the number?
No, there is not.
>
> int cros_ec_allocate_sensor_id(enum cros_sensor_type);
>
> Which allocates the next available ID of the requested type.
That code would not be in the EC, but in cros_ec_dev, based on the
result from _DUMP_ and _INFO_ command, if supported by the EC, as you
suggest below.
>
> OR
>
> If this is not possible AND the sensors of the same type are identical
> AND the sensors are always numbered sequentially from the same base
> (i.e. 0, 1, 2 OR 1, 2, 3, etc) then you use the ida_ API
> (include/linux/idr.h) to provide you with a unique ID for your
> sensor(s).
That would work if we add the requirement on the EC that sensors of
the same type are next to each other in the EC sensor array:
cros_ec_dev would build an array of struct idr, one per type.
IIO driver will recompute the type for a given device based on the
name in the mfd_cell (for instance cros-ec-sensor.c driver handles
accel, gyro and compass), and call back cros_ec_dev for an unused
index.
The EC requirement above is true today, but I see case ti will not
always be true, when some sensors are removed from a BOM while using
the same EC firmware: we will put the optional sensors at the end of
the EC sensors array.
>
> ###
>
> The flip side is a situation where the devices of a same type are not
> identical and are provided different platform data (by the parent MFD
> in this case).  If this true then you may actually need to identify
> the specific sensor ahead of time, in which case it's the chosen
> nomenclature that is misleading.  What you might really be looking for
> is a sensor_id and proper commenting/documentation.
Indeed, I would prefer to keep cros_ec sensor_hub code functionally
equivalent to the hid sensor_hub code with the difference we can not
infer the sensor type from sensor_num (contrary to hid
sensor_id/usageusage_id) and the map {sensor_type, sensor_num] varies
from chromebook to chromebook.
>
> ###
>
> However, looking at this patch, I suspect the former situation to be
> the case here, thus there is no requirement for the parent to
> pre-allocate 'sensor_num's.
>
Thank you,
Gwndal.
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
