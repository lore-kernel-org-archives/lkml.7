Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBC4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626CB21872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 19:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZxF6Hwkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbfJVTL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 15:11:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36493 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732810AbfJVTL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 15:11:58 -0400
Received: by mail-io1-f65.google.com with SMTP id c16so1967787ioc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1NHtPh4u0L8QVXYys5QROgY5jF0c09zMbCARC3Eso3Y=;
        b=ZxF6HwklCzy9IWAEyEpcK31IiIW6ew5mvQR46lHXZl5+csTZjLiTRtVlziCz68Y3My
         ASQi7smv8mNDZ/01nwtl5Jr6uo+Y2izVrKFK+coneLuSe7RdYdtn3iWGdYmoj321XytJ
         t/MafQxNk0M045HZU4DO2BQwtTgPq+7Ki5l/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1NHtPh4u0L8QVXYys5QROgY5jF0c09zMbCARC3Eso3Y=;
        b=NNkVN5w9Ed8kp4UCUeg6ZXxj5wjTRuhOEyxaAfdSkBUk5oRdWQ/MK3PdCY555W90Qa
         Jfzs3Un7hEEbvXwQUq0JGeHgb3bvf9c3s5ZaWTkXBK6s/9AyWJqrTYIZGTug4IBNHo6C
         JARQbV3ILuXyTORFR80uXtckCfdLvaCfD7OQx9FilKSCGhkSunxK5v4DJWNBnYMXQbi2
         joMoRxxbWFU7zfN7NYmugsi/gANtZ2uzkVnD1/vovHFQA036Xh7ZvElOcZgFAKlgtjGT
         hUHxfAyDezoAqBaQqaKYiv8mXabNnbQ5HHjzYHNcIBlEVcNNfq+iSsfTclqS6gp6OYLa
         Nc5Q==
X-Gm-Message-State: APjAAAUbC0C4Z3VXjEEiEjEn8hlISWyMKxvjIhfCqR814kNRIwQ47BOm
        5X6FWVhsr3o+fyJ7GYx0xuGV5klnLajGFmanwJGmAg==
X-Google-Smtp-Source: APXvYqwRBcd0pRoD8yN66nc1o46MyDYhVpP6e0fSUX5xk6wMsfjP23Qk/Aar4DEoVIVJHMlVzIQEx056IQU5moVVkNI=
X-Received: by 2002:a02:334e:: with SMTP id k14mr5245939jak.19.1571771516684;
 Tue, 22 Oct 2019 12:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191021055403.67849-1-gwendal@chromium.org> <20191021055403.67849-19-gwendal@chromium.org>
 <20191021174507.72f2b777@archlinux>
In-Reply-To: <20191021174507.72f2b777@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 22 Oct 2019 12:11:45 -0700
Message-ID: <CAPUE2uvu6jMPkF=oX4hyaiLHti9_YjOJ=Nq+GWQp9cgqUNjs9Q@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] iio: cros_ec: Use Hertz as unit for sampling frequency
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 9:45 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 20 Oct 2019 22:54:03 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > To be compliant with other sensors, set and get sensor sampling
> > frequency in Hz, not mHz.
> >
> > Fixes: ae7b02ad2f32 ("iio: common: cros_ec_sensors: Expose
> > cros_ec_sensors frequency range via iio sysfs")
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> Do we need to look at back porting this?
>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Not sure which path this set will take in, hence I've given
> acks for various patches incase it's not via me.
>
> Whole set is in general good to have, but I do worry a bit about
> people noticing ABI breakage. *crosses fingers*
I am planning to backport the sysfs change to older kernel.
I am adding some code to the clients that use the sysfs interface: if
frequency is absent, assume sample_frequency is the new frequency.
Clients should be able to handle both ABI, the code has been around
since 3.14.

>
> Jonathan
>
> > ---
> > No changes in v2.
> >
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 32 +++++++++++--------
> >  .../linux/iio/common/cros_ec_sensors_core.h   |  6 ++--
> >  2 files changed, 22 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index f50e239f9a1e9..76dc8cad1b4b5 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -256,6 +256,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >       struct cros_ec_dev *ec = sensor_hub->ec;
> >       struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> >       u32 ver_mask;
> > +     int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
> >       int ret, i;
> >
> >       platform_set_drvdata(pdev, indio_dev);
> > @@ -304,20 +305,22 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                       state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
> >
> >               /* 0 is a correct value used to stop the device */
> > -             state->frequencies[0] = 0;
> >               if (state->msg->version < 3) {
> >                       get_default_min_max_freq(state->resp->info.type,
> > -                                              &state->frequencies[1],
> > -                                              &state->frequencies[2],
> > +                                              &frequencies[1],
> > +                                              &frequencies[2],
> >                                                &state->fifo_max_event_count);
> >               } else {
> > -                     state->frequencies[1] =
> > -                         state->resp->info_3.min_frequency;
> > -                     state->frequencies[2] =
> > -                         state->resp->info_3.max_frequency;
> > +                     frequencies[1] = state->resp->info_3.min_frequency;
> > +                     frequencies[2] = state->resp->info_3.max_frequency;
> >                       state->fifo_max_event_count =
> >                           state->resp->info_3.fifo_max_event_count;
> >               }
> > +             for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
> > +                     state->frequencies[2 * i] = frequencies[i] / 1000;
> > +                     state->frequencies[2 * i + 1] =
> > +                             (frequencies[i] % 1000) * 1000;
> > +             }
> >
> >               ret = devm_iio_triggered_buffer_setup(
> >                               dev, indio_dev, NULL,
> > @@ -707,7 +710,7 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
> >                         struct iio_chan_spec const *chan,
> >                         int *val, int *val2, long mask)
> >  {
> > -     int ret;
> > +     int ret, frequency;
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_SAMP_FREQ:
> > @@ -719,8 +722,10 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
> >               if (ret)
> >                       break;
> >
> > -             *val = st->resp->sensor_odr.ret;
> > -             ret = IIO_VAL_INT;
> > +             frequency = st->resp->sensor_odr.ret;
> > +             *val = frequency / 1000;
> > +             *val2 = (frequency % 1000) * 1000;
> > +             ret = IIO_VAL_INT_PLUS_MICRO;
> >               break;
> >       default:
> >               ret = -EINVAL;
> > @@ -755,7 +760,7 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
> >       case IIO_CHAN_INFO_SAMP_FREQ:
> >               *length = ARRAY_SIZE(state->frequencies);
> >               *vals = (const int *)&state->frequencies;
> > -             *type = IIO_VAL_INT;
> > +             *type = IIO_VAL_INT_PLUS_MICRO;
> >               return IIO_AVAIL_LIST;
> >       }
> >
> > @@ -777,12 +782,13 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
> >                              struct iio_chan_spec const *chan,
> >                              int val, int val2, long mask)
> >  {
> > -     int ret;
> > +     int ret, frequency;
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_SAMP_FREQ:
> > +             frequency = val * 1000 + val2 / 1000;
> >               st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
> > -             st->param.sensor_odr.data = val;
> > +             st->param.sensor_odr.data = frequency;
> >
> >               /* Always roundup, so caller gets at least what it asks for. */
> >               st->param.sensor_odr.roundup = 1;
> > diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> > index 4df3abd151fbf..256447b136296 100644
> > --- a/include/linux/iio/common/cros_ec_sensors_core.h
> > +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> > @@ -52,6 +52,8 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
> >   *                           is always 8-byte aligned.
> >   * @read_ec_sensors_data:    function used for accessing sensors values
> >   * @fifo_max_event_count:    Size of the EC sensor FIFO
> > + * @frequencies:             Table of known available frequencies:
> > + *                           0, Min and Max in mHz.
> >   */
> >  struct cros_ec_sensors_core_state {
> >       struct cros_ec_device *ec;
> > @@ -75,9 +77,7 @@ struct cros_ec_sensors_core_state {
> >                                   unsigned long scan_mask, s16 *data);
> >
> >       u32 fifo_max_event_count;
> > -
> > -     /* Table of known available frequencies : 0, Min and Max in mHz */
> > -     int frequencies[3];
> > +     int frequencies[6];
> >  };
> >
> >  int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev, unsigned long scan_mask,
>
