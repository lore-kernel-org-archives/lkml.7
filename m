Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8774EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548612081C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYCl4p6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfE2Lo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:44:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53135 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfE2Lo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:44:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so1457356wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vOYxrsUIUSoP7Y+ENnCbLglQ1sy//0LmbmH3hv/U97g=;
        b=xYCl4p6zSWJBz4+FQ4b2mZo88LjOoSZzjOg94PGpQx5SUTLGzSnhfUZb/hN0Ur165l
         F3CGXUkiGa0mC/w5mmjShjDY7kIg04gkF4YrWnfIjcAqkqTZZ8mIfG+KauaaDz2lfZrR
         PiARvKqvx9ZPTk/R1XFhMcnT6zO450FXlcVHYm12wSrvfa9TJ/LQ76e5TdajP7HfygE6
         lwcrs6x6Mc6mursv+eB4KP5FEfUg4QzzhYrkTU3SdSuCWl4GNr9KwzxHbiP0AP1RghyJ
         D5qLl5CzglkfnCz0kfWA50uE94M+uRZl+dyJDJl0Ep1x1WyfKhEG4ZtxiKXS5FJUUefu
         0eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vOYxrsUIUSoP7Y+ENnCbLglQ1sy//0LmbmH3hv/U97g=;
        b=Rb6OsHq0O1blDQSDMOJQb0IXj3wbKabAJZcc7zA3L5LhUNmpTDqzMJ4hJbG4psJPak
         lr3T+cjqA2hJ2bKIfHDMZ7SYULyiXOKockOI4ge7IsNn9U8UVzabm/Jc0ltqJXqB/UqE
         LMsnP6/hWAXTZ2Cfh2GsZE5Ktg/Mr9miV9w0EAis0qe/Cc8rkszMRnleakcTbMdb82tm
         Thnkg4OWfmMHX1ER2Bk9gSFAo4L5MTY4HxoOeLVf2bMTElIJruFw4DwgCwpVoGYTROpI
         pMyu+LKVtMWSCiiuORUb3Ja0vr0OlslnjF8DR1z1z5gfQyhuOt5G+kGbfYsynv6P0ClP
         nA6A==
X-Gm-Message-State: APjAAAWaflgFjFFFBRCrv6xh8PYI3zpBS/wVuC7oA/pI9R06rViBtf7L
        8P00BqIVLNW6qsMYNHkLGtHlXg==
X-Google-Smtp-Source: APXvYqyihUIJ+blE414ToWc5cD257jWRdTiXQa+UKJcF5nfktFLcwkHIjYbt6IshNWU/O+/orT2PMw==
X-Received: by 2002:a7b:c001:: with SMTP id c1mr6643728wmb.49.1559130296085;
        Wed, 29 May 2019 04:44:56 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id v13sm4748348wmj.46.2019.05.29.04.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 04:44:55 -0700 (PDT)
Date:   Wed, 29 May 2019 12:44:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     andy.shevchenko@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v5] mfd: cros_ec_dev: Register cros_ec_accel_legacy
 driver as a subdevice
Message-ID: <20190529114454.GJ4574@dell>
References: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
 <20190228013541.76792-1-gwendal@chromium.org>
 <20190402034610.GG4187@dell>
 <CAPUE2usfB3i4J7P4e_XdsMLV+VK7s+nS-mrD=D_WMpOHiouG2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUE2usfB3i4J7P4e_XdsMLV+VK7s+nS-mrD=D_WMpOHiouG2w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019, Gwendal Grignou wrote:

> On Mon, Apr 1, 2019 at 8:46 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 27 Feb 2019, Gwendal Grignou wrote:
> >
> > > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > >
> > > With this patch, the cros_ec_ctl driver will register the legacy
> > > accelerometer driver (named cros_ec_accel_legacy) if it fails to
> > > register sensors through the usual path cros_ec_sensors_register().
> > > This legacy device is present on Chromebook devices with older EC
> > > firmware only supporting deprecated EC commands (Glimmer based devices).
> > >
> > > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > ---
> > > Changes in v5:
> > > - Remove unnecessary white lines.
> > >
> > > Changes in v4:
> > > - [5/8] Nit: EC -> ECs (Lee Jones)
> > > - [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)
> > >
> > > Changes in v3:
> > > - [5/8] Add the Reviewed-by Andy Shevchenko.
> > >
> > > Changes in v2:
> > > - [5/8] Add the Reviewed-by Gwendal.
> > >
> > >  drivers/mfd/cros_ec_dev.c | 66 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 66 insertions(+)
> > >
> > > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > > index d275deaecb12..64567bd0a081 100644
> > > --- a/drivers/mfd/cros_ec_dev.c
> > > +++ b/drivers/mfd/cros_ec_dev.c
> > > @@ -376,6 +376,69 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> > >       kfree(msg);
> > >  }
> > >
> > > +static struct cros_ec_sensor_platform sensor_platforms[] = {
> > > +     { .sensor_num = 0 },
> > > +     { .sensor_num = 1 }
> > > +};
> >
> > I'm still very uncomfortable with this struct.
> >
> > Other than these indices, the sensors have no other distinguishing
> > features, thus there should be no need to identify or distinguish
> > between them in this way.
> When initializing the sensors, the IIO driver expect to find in the
> data  structure pointed by dev_get_platdata(dev), in field sensor_num
> is stored the index assigned by the embedded controller to talk to a
> given sensor.
> cros_ec_sensors_register() use the same mechanism; in that function,
> the sensor_num field is populated from the output of an EC command
> MOTIONSENSE_CMD_INFO. In case of legacy mode, that command may not be
> available and in any case we know the EC has only either 2
> accelerometers present or nothing.
> 
> For instance, let's compare a legacy device with a more recent one:
> 
> legacy:
> type                  |   id          | sensor_num   | device name
> accelerometer  |   0           |   0                  | cros-ec-accel.0
> accelerometer  |   1           |   1                  | cros-ec-accel.1
> 
> Modern:
> type                  |   id          | sensor_num   | device name
> accelerometer  |   0           |   0                  | cros-ec-accel.0
> accelerometer  |   1           |   1                  | cros-ec-accel.1
> gyroscope        |    0          |    2                 | cros-ec-gyro.0
> magnetometer |    0          |   3                  | cros-ec-mag.0
> light                  |    0          |   4                  | cros-ec-light.0
> ...

Why can't these numbers be assigned at runtime?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
