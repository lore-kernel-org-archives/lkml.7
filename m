Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F068C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EE0214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TqErks0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfFCGXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:23:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41649 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfFCGXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:23:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so10650323wrm.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 23:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sNivcIC8Igrk6BfZHQq6nCs83U3as9vRIij/ngzJA8M=;
        b=TqErks0QqKz6hugNUsZQVVqvZGFkrJn392XjeNVWSuWy87fyl3f97/VIt2SrOEgsf5
         V3L3nD2PGQ89EQhQAMYqYlJnEH4uwBsDBsfuw+2pGgW8y8EJu3lQKHvKQ69n2CWjvFVX
         2purp7zr/XCbraWaDL3OOLsRleCHUekjsTgh++ctm3q4Grr0PZ2NNKZZWJaVjX9uX2BG
         8qN2kjdjxxbmNjzc5VclVtp4mvem9Mfkbm67dntk1lGqqYVcDFF9f4WvC9RdNqrMvhvP
         qRai7RgTMRWgg1L+sWNdd46A6ivmZ2nAaHzT0R45e0NnWiTklWDCDm8A7S4vHWdfXRjt
         +Htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sNivcIC8Igrk6BfZHQq6nCs83U3as9vRIij/ngzJA8M=;
        b=mxwDJNX1Rn6NO1Em1QOKiuwM12A2ukF33fNL+pURb8mKaEh9pGTP8PDgZGWA0Y+7OA
         eqYDmFrcuNiy0dnlLJ+bO30XIh7bHnCerf2nJjPJ8jYBE/IJHXz1UGMwVYum/W4pzCgd
         lwEG75tUwKyFye5HxWUWRfKpN7RzaAN9ucgZVvN0yi9KFSPcvMQanzHVTh36RXWcHRT/
         zxjMfvaMhTRZi0/8CELpJQtIvJVaRLeeRMpyIx1Fx8zsRftjssN7XMiiJjApk5Nw/aoJ
         gjBnVvmXw+jVCWGjfqAXl9sXHKLtvXz0/9DPqaZw1v5RyopF8Nzy7qFIaTLIECevk/Hi
         pKlw==
X-Gm-Message-State: APjAAAXQKzHC0YhP0r7KL/ECNF76K4AtQtp0cY3csmGnPffgAF3yGG5/
        xewjhOFVAjd/omBHFVTYt3EJjA==
X-Google-Smtp-Source: APXvYqwyJhSvEoQDL8Z2YEUR2WX9LHyvIg6PoBKNuD69ZAMWAd7pb0BVlCSGtLdIXdNRtpvDhNrr8w==
X-Received: by 2002:a5d:694c:: with SMTP id r12mr1237454wrw.214.1559542980301;
        Sun, 02 Jun 2019 23:23:00 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id y12sm5704748wrr.3.2019.06.02.23.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Jun 2019 23:22:58 -0700 (PDT)
Date:   Mon, 3 Jun 2019 07:22:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     andy.shevchenko@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v5] mfd: cros_ec_dev: Register cros_ec_accel_legacy
 driver as a subdevice
Message-ID: <20190603062257.GA4797@dell>
References: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
 <20190228013541.76792-1-gwendal@chromium.org>
 <20190402034610.GG4187@dell>
 <CAPUE2usfB3i4J7P4e_XdsMLV+VK7s+nS-mrD=D_WMpOHiouG2w@mail.gmail.com>
 <20190529114454.GJ4574@dell>
 <CAPUE2usYa3z3mcxo6fGsBL-FXLcNy1-Pr+WoQsKmTjhNZCZwSA@mail.gmail.com>
 <20190530074819.GM4574@dell>
 <CAPUE2usBh5r22Ak3LxLK-hS7wOObAdW4v1r8TDFUWPz=05FGMw@mail.gmail.com>
 <20190531081353.GQ4574@dell>
 <CAPUE2uuzVGexaWxy4zLjCZT9=rRfciQB44Fj-7bXhsJQY6uMhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUE2uuzVGexaWxy4zLjCZT9=rRfciQB44Fj-7bXhsJQY6uMhA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019, Gwendal Grignou wrote:

> On Fri, May 31, 2019 at 1:13 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 30 May 2019, Gwendal Grignou wrote:
> >
> > > On Thu, May 30, 2019 at 12:48 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Wed, 29 May 2019, Gwendal Grignou wrote:
> > > >
> > > > > On Wed, May 29, 2019 at 4:44 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, 28 May 2019, Gwendal Grignou wrote:
> > > > > >
> > > > > > > On Mon, Apr 1, 2019 at 8:46 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, 27 Feb 2019, Gwendal Grignou wrote:
> > > > > > > >
> > > > > > > > > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > > > > > >
> > > > > > > > > With this patch, the cros_ec_ctl driver will register the legacy
> > > > > > > > > accelerometer driver (named cros_ec_accel_legacy) if it fails to
> > > > > > > > > register sensors through the usual path cros_ec_sensors_register().
> > > > > > > > > This legacy device is present on Chromebook devices with older EC
> > > > > > > > > firmware only supporting deprecated EC commands (Glimmer based devices).
> > > > > > > > >
> > > > > > > > > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > > > > > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > > > ---
> > > > > > > > > Changes in v5:
> > > > > > > > > - Remove unnecessary white lines.
> > > > > > > > >
> > > > > > > > > Changes in v4:
> > > > > > > > > - [5/8] Nit: EC -> ECs (Lee Jones)
> > > > > > > > > - [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)
> > > > > > > > >
> > > > > > > > > Changes in v3:
> > > > > > > > > - [5/8] Add the Reviewed-by Andy Shevchenko.
> > > > > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > > - [5/8] Add the Reviewed-by Gwendal.
> > > > > > > > >
> > > > > > > > >  drivers/mfd/cros_ec_dev.c | 66 +++++++++++++++++++++++++++++++++++++++
> > > > > > > > >  1 file changed, 66 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > > > > > > > > index d275deaecb12..64567bd0a081 100644
> > > > > > > > > --- a/drivers/mfd/cros_ec_dev.c
> > > > > > > > > +++ b/drivers/mfd/cros_ec_dev.c
> > > > > > > > > @@ -376,6 +376,69 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> > > > > > > > >       kfree(msg);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static struct cros_ec_sensor_platform sensor_platforms[] = {
> > > > > > > > > +     { .sensor_num = 0 },
> > > > > > > > > +     { .sensor_num = 1 }
> > > > > > > > > +};
> > > > > > > >
> > > > > > > > I'm still very uncomfortable with this struct.
> > > > > > > >
> > > > > > > > Other than these indices, the sensors have no other distinguishing
> > > > > > > > features, thus there should be no need to identify or distinguish
> > > > > > > > between them in this way.
> > > > > > > When initializing the sensors, the IIO driver expect to find in the
> > > > > > > data  structure pointed by dev_get_platdata(dev), in field sensor_num
> > > > > > > is stored the index assigned by the embedded controller to talk to a
> > > > > > > given sensor.
> > > > > > > cros_ec_sensors_register() use the same mechanism; in that function,
> > > > > > > the sensor_num field is populated from the output of an EC command
> > > > > > > MOTIONSENSE_CMD_INFO. In case of legacy mode, that command may not be
> > > > > > > available and in any case we know the EC has only either 2
> > > > > > > accelerometers present or nothing.
> > > > > > >
> > > > > > > For instance, let's compare a legacy device with a more recent one:
> > > > > > >
> > > > > > > legacy:
> > > > > > > type                  |   id          | sensor_num   | device name
> > > > > > > accelerometer  |   0           |   0                  | cros-ec-accel.0
> > > > > > > accelerometer  |   1           |   1                  | cros-ec-accel.1
> > > > > > >
> > > > > > > Modern:
> > > > > > > type                  |   id          | sensor_num   | device name
> > > > > > > accelerometer  |   0           |   0                  | cros-ec-accel.0
> > > > > > > accelerometer  |   1           |   1                  | cros-ec-accel.1
> > > > > > > gyroscope        |    0          |    2                 | cros-ec-gyro.0
> > > > > > > magnetometer |    0          |   3                  | cros-ec-mag.0
> > > > > > > light                  |    0          |   4                  | cros-ec-light.0
> > > > > > > ...
> > > > > >
> > > > > > Why can't these numbers be assigned at runtime?
> > > > > I assume you want to know why IIO drivers need to know "sensor_num"
> > > > > ahead of time. It is because each IIO driver is independent from the
> > > > > other.
> > > > > Let assume there was 2 light sensors in the device:
> > > > > type                  |   id          | sensor_num   | device name
> > > > >  light                  |    0          |   4                  | cros-ec-light.0
> > > > >  light                  |    1          |   5                  | cros-ec-light.1
> > > > >
> > > > > In case of sensors of the same type without sensor_num, cros-ec-light
> > > > > driver has no information at probe time if it should bind to sensors
> > > > > named by the EC 4 or 5.
> > > > >
> > > > > We could get away with cros-ec-accel, as EC always presents
> > > > > accelerometers with sensor_num  0 and 1, but I don't want to rely on
> > > > > this property in the general case.
> > > > > Only cros_ec_dev MFD driver has the global view of all sensors available.
> > > >
> > > > Well seeing as this implementation has already been accepted and you're
> > > > only *using* it, rather than creating it, I think this conversation is
> > > > moot.  It looks like the original implementation patch was not
> > > > reviewed by me, which is frustrating since I would have NACKed it.
> > > >
> > > > Just so you know, pointlessly enumerating identical devices manually
> > > > is not a good practice.  It is one we reject all the time.  This
> > > > imp. should too have been rejected on submission.
> >
> > > I wrote the original code, Enric submitted it, so I am not just using it.
> >
> > My point was, *this* patch is just using it.  The implementation has
> > already been applied to the mainline kernel.  Who wrote the initial
> > commit is not important at this point.
> >
> > > We can work on implementing the right way. Which model should I follow?
> > > The code function is similar to HID sensor hub code which is done in
> > > driver/hid/hid-sensor-hub.c [sensor_hub_probe()] which calls
> > > mfd_add_hotplug_devices() with an array of mfd_cell,
> > > hid_sensor_hub_client_devs. Each cell platfom_data contains  a hsdev
> > > structure that is shared between the iio driver and the hid sensor hub
> > > driver. hsdev->usage information is sent back and forth between
> > > specialized hid IIO device driver and the HID sensor hub driver, for
> > > example when sensor_hub_input_attr_get_raw_value() is called.
> > > hsdev->usage has the same usage a sensor_num I am using.
> >
> > It looks like the HID Usage implementation is using a set of
> > pre-defined values to identify sensor *types*:
> >
> >   include/linux/hid-sensor-ids.h
> Yes, hsdev->usage, aka usage_id define the types between 0x00 and 0xFF.
> For accessing a paritcualre fileds, we use attr_usage_id, between
> 0x100 and 0x7FF.
> AFAIK, a sensorhub/collection can not contain to sensor of the same type.
> >
> > Where as your implementation is confusing me.  In some instances you
> > are using it as what looks like an *index* into a register set:
> >
> >   ec_cmd_read_u16(st->ec,
> >                 EC_MEMMAP_ACC_DATA +
> >                 sizeof(s16) *
> >                 (1 + i + st->sensor_num * MAX_AXIS),
> >                 data);
> >
> > And at other times it is used for sensor *types*, but in a very
> > limited way:
> >
> >   enum motionsensor_location {
> >           MOTIONSENSE_LOC_BASE = 0,
> >           MOTIONSENSE_LOC_LID = 1,
> >           MOTIONSENSE_LOC_MAX,
> >   };
> >
> >   static char *cros_ec_accel_legacy_loc_strings[] = {
> >           [MOTIONSENSE_LOC_BASE] = "base",
> >           [MOTIONSENSE_LOC_LID] = "lid",
> >           [MOTIONSENSE_LOC_MAX] = "unknown",
> >   };
> >
> >   return sprintf(buf, "%s\n",
> >                  cros_ec_accel_legacy_loc_strings[st->sensor_num +
> >                                                 MOTIONSENSE_LOC_BASE]);
> In the legacy case, the location is hard-coded from sensor_num, the
> index used by the EC: sensor 0 is in base, 1 is in the lid.
> This limitation is removed from newer EC implementation, the EC
> subcommand MOTIONSENSE_CMD_INFO provide that information.
> >
> > > I am not enumerating identical devices twice: the embedded controller
> > > manages a list of sensors:
> > >
> > > For instance on pixelbook, it look like:
> > >        +--------+
> > >         | EC    |
> > >        +--------+
> > >    ( via several i2c/spi buses)
> > > +--------------------+--------------+-------- ...
> > > |                         |                  |
> > > IMU (base)     light/prox    Accelrometer (lid)
> > > |
> > > Magnetometer
> > >
> > > A given hardware sensor may be composed of multiple logical sensors
> > > (IMU is a accelerometer and a gyroscope into one package).
> > >
> > > The EC firmware list all the (logical) sensors in array, and that
> > > unique index - sensor_num - points to a single logical sensor.
> >
> > What what is 'sensor_num'; is it a channel address/number similar to
> > what I2C HIDs use to communicate over a specific I2C line, or is it a
> > type, similar to what HID devices provide on request for
> > identification purposes?
> >
> > > Is it more acceptable if I use PLATFORM_DEVID_AUTO instead of
> > > assigning .id myself?
> >
> > Is this a separate question, or can 'sensor_num' be any unique
> > arbitrary number?
> No, it is assigned by the EC.

Is it assigned *by* the EC or *to* the EC.

If it is assigned *by* the EC, can't you ask the EC for it?

I asked this before, but was not given the answer I wanted:

> > Why can't these numbers be assigned at runtime?
> I assume you want to know why IIO drivers need to know "sensor_num"
> ahead of time. It is because each IIO driver is independent from the
> other.

Is there a way to call into the EC and request the number?

int cros_ec_allocate_sensor_id(enum cros_sensor_type);

Which allocates the next available ID of the requested type.

OR

If this is not possible AND the sensors of the same type are identical
AND the sensors are always numbered sequentially from the same base
(i.e. 0, 1, 2 OR 1, 2, 3, etc) then you use the ida_ API
(include/linux/idr.h) to provide you with a unique ID for your
sensor(s).

###

The flip side is a situation where the devices of a same type are not
identical and are provided different platform data (by the parent MFD
in this case).  If this true then you may actually need to identify
the specific sensor ahead of time, in which case it's the chosen
nomenclature that is misleading.  What you might really be looking for
is a sensor_id and proper commenting/documentation. 

###

However, looking at this patch, I suspect the former situation to be
the case here, thus there is no requirement for the parent to
pre-allocate 'sensor_num's.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
