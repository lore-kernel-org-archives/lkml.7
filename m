Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61433C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230A223AA3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SF70NN8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfE3HsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:48:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39778 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfE3HsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:48:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so3150161wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nAwAx/liOGYAQLTsVb7XlFSKpMON54UDy15wdk0TQRw=;
        b=SF70NN8rfUIW4qUEvoyZmVl4wfdYcUwXuDarGLjTQBEP4/ABX6fkDlSQM/Zj4S1kWg
         B60j8gYxwsQ8ECQRmT0xgFDcL9L6j28aS8ULRu4rAuHGB1Zaj1mKVlhuiLGtERPQN4XV
         vJG0ymdVPLghl9w1uuL6dJiYJ/hBHydBWmTb6r0WKDGgX4A94Q5b/yiJQM2aUkOf4Rt4
         SNYcqM72tk7HOSkwZ0sBLo9HXPjJbNczybPX+Mqt7odSkkOMs1gDDaNWrqkeV83VsqvZ
         VbKKHnzN9EXKKB7Px7Hxk1X70GQR1gzUCgmwsnb3GDouQCRbx09B2n3/u8M5PrwFSjQ3
         9Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nAwAx/liOGYAQLTsVb7XlFSKpMON54UDy15wdk0TQRw=;
        b=DvXScoM5k9RohJzhwCpGN9kxlu5wTjU2YsuglQ85Pljis33E8MhG8jjVR8oA6GBu2J
         Gi493dFOVz1W5uIJ+DVzDAPbh6iLUbdg2OkRSDU0oAeASysEX4DSGoeMBrBbB1bZNILI
         Mz32qfCljM1Gf1pmt+Feyy1IDQIb/E9WThPYHQrkhaRtugCPfBhI7u1fEtZkQLX6Ce3A
         2dgkoAREgYdpvolV0lM7YRc9Ez3yPk9B7Mdu5P2NsVniN9QrmMm+8rWODheLnIZUNzKH
         0jbQcnIeWDiN05V4X5QSWIOZJ/kYSXxCq3h5V3TicLnfGIMAO4wzf7q7zeUJRNY4fE1i
         cvGw==
X-Gm-Message-State: APjAAAXR8zyMvO4bB+7miWrpANYXLNo7hciCvD2hruHfoYdcexvWkzc/
        Ik5B6K96vIm1h0J0eKbHuh0Bqg==
X-Google-Smtp-Source: APXvYqy8mBKNGmoJnuxHLttDrDyx8FXL0heHA3Cn4wXfHagGuEXthsgvniTVmC9uDZ19zIyPYZ6GfA==
X-Received: by 2002:a05:600c:230a:: with SMTP id 10mr1362037wmo.13.1559202501928;
        Thu, 30 May 2019 00:48:21 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id o20sm3801870wro.2.2019.05.30.00.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 00:48:21 -0700 (PDT)
Date:   Thu, 30 May 2019 08:48:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     andy.shevchenko@gmail.com, Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v5] mfd: cros_ec_dev: Register cros_ec_accel_legacy
 driver as a subdevice
Message-ID: <20190530074819.GM4574@dell>
References: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
 <20190228013541.76792-1-gwendal@chromium.org>
 <20190402034610.GG4187@dell>
 <CAPUE2usfB3i4J7P4e_XdsMLV+VK7s+nS-mrD=D_WMpOHiouG2w@mail.gmail.com>
 <20190529114454.GJ4574@dell>
 <CAPUE2usYa3z3mcxo6fGsBL-FXLcNy1-Pr+WoQsKmTjhNZCZwSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUE2usYa3z3mcxo6fGsBL-FXLcNy1-Pr+WoQsKmTjhNZCZwSA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019, Gwendal Grignou wrote:

> On Wed, May 29, 2019 at 4:44 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 28 May 2019, Gwendal Grignou wrote:
> >
> > > On Mon, Apr 1, 2019 at 8:46 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Wed, 27 Feb 2019, Gwendal Grignou wrote:
> > > >
> > > > > From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > >
> > > > > With this patch, the cros_ec_ctl driver will register the legacy
> > > > > accelerometer driver (named cros_ec_accel_legacy) if it fails to
> > > > > register sensors through the usual path cros_ec_sensors_register().
> > > > > This legacy device is present on Chromebook devices with older EC
> > > > > firmware only supporting deprecated EC commands (Glimmer based devices).
> > > > >
> > > > > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > ---
> > > > > Changes in v5:
> > > > > - Remove unnecessary white lines.
> > > > >
> > > > > Changes in v4:
> > > > > - [5/8] Nit: EC -> ECs (Lee Jones)
> > > > > - [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)
> > > > >
> > > > > Changes in v3:
> > > > > - [5/8] Add the Reviewed-by Andy Shevchenko.
> > > > >
> > > > > Changes in v2:
> > > > > - [5/8] Add the Reviewed-by Gwendal.
> > > > >
> > > > >  drivers/mfd/cros_ec_dev.c | 66 +++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 66 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> > > > > index d275deaecb12..64567bd0a081 100644
> > > > > --- a/drivers/mfd/cros_ec_dev.c
> > > > > +++ b/drivers/mfd/cros_ec_dev.c
> > > > > @@ -376,6 +376,69 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
> > > > >       kfree(msg);
> > > > >  }
> > > > >
> > > > > +static struct cros_ec_sensor_platform sensor_platforms[] = {
> > > > > +     { .sensor_num = 0 },
> > > > > +     { .sensor_num = 1 }
> > > > > +};
> > > >
> > > > I'm still very uncomfortable with this struct.
> > > >
> > > > Other than these indices, the sensors have no other distinguishing
> > > > features, thus there should be no need to identify or distinguish
> > > > between them in this way.
> > > When initializing the sensors, the IIO driver expect to find in the
> > > data  structure pointed by dev_get_platdata(dev), in field sensor_num
> > > is stored the index assigned by the embedded controller to talk to a
> > > given sensor.
> > > cros_ec_sensors_register() use the same mechanism; in that function,
> > > the sensor_num field is populated from the output of an EC command
> > > MOTIONSENSE_CMD_INFO. In case of legacy mode, that command may not be
> > > available and in any case we know the EC has only either 2
> > > accelerometers present or nothing.
> > >
> > > For instance, let's compare a legacy device with a more recent one:
> > >
> > > legacy:
> > > type                  |   id          | sensor_num   | device name
> > > accelerometer  |   0           |   0                  | cros-ec-accel.0
> > > accelerometer  |   1           |   1                  | cros-ec-accel.1
> > >
> > > Modern:
> > > type                  |   id          | sensor_num   | device name
> > > accelerometer  |   0           |   0                  | cros-ec-accel.0
> > > accelerometer  |   1           |   1                  | cros-ec-accel.1
> > > gyroscope        |    0          |    2                 | cros-ec-gyro.0
> > > magnetometer |    0          |   3                  | cros-ec-mag.0
> > > light                  |    0          |   4                  | cros-ec-light.0
> > > ...
> >
> > Why can't these numbers be assigned at runtime?
> I assume you want to know why IIO drivers need to know "sensor_num"
> ahead of time. It is because each IIO driver is independent from the
> other.
> Let assume there was 2 light sensors in the device:
> type                  |   id          | sensor_num   | device name
>  light                  |    0          |   4                  | cros-ec-light.0
>  light                  |    1          |   5                  | cros-ec-light.1
> 
> In case of sensors of the same type without sensor_num, cros-ec-light
> driver has no information at probe time if it should bind to sensors
> named by the EC 4 or 5.
> 
> We could get away with cros-ec-accel, as EC always presents
> accelerometers with sensor_num  0 and 1, but I don't want to rely on
> this property in the general case.
> Only cros_ec_dev MFD driver has the global view of all sensors available.

Well seeing as this implementation has already been accepted and you're
only *using* it, rather than creating it, I think this conversation is
moot.  It looks like the original implementation patch was not
reviewed by me, which is frustrating since I would have NACKed it.

Just so you know, pointlessly enumerating identical devices manually
is not a good practice.  It is one we reject all the time.  This
imp. should too have been rejected on submission.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
