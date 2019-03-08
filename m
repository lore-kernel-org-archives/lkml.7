Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA194C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EFA2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOblogg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfCHUmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:42:17 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39711 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfCHUmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:42:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id b4so16898578oif.6;
        Fri, 08 Mar 2019 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8lGUjPbEQu9teMV5ANl/o9Y/y98QBUqlnzMraiGkKY=;
        b=jOblogg6CbTKYY5Nv0RFNqyTUXdiwZJoHog18g8fW6tvjt1+mTX4BoHWP+g9jL8qK8
         X2W5C2Pygzq7iF4Ot4OXxPwbcnMi5O74064pFpcRh+nw/hM11SFQ61zITr7rzdQmd9+I
         y1+Rf8Zg1008v9ZtvCs4JmKtehwj6857zWtHZrW1Eq+UT0gYH4f0X9qlBXaAoQwsAm6B
         /L002wT9h+/V6zVBrQIZ38CJTYYUZN5Y8VixBNCR5Pi8QKV1PZcAVVoepWSJR0j4GeDw
         /mnS6c/I0B1kT8gnA0+XOwq71pYsQ/x9gzfqHPm2+Mju4m9VgB13AySp+xs/yilSS+ZH
         xhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8lGUjPbEQu9teMV5ANl/o9Y/y98QBUqlnzMraiGkKY=;
        b=gFWE8W29cAa3xdJvADAeGytiqMeEGkfrQBSCgOupudOJH5epIb6Dy3WBcx5ssUSAAT
         Dacfd8Wde75uDdTrzh88thdGyxU89iHD4Or9e0DCQQQ+MhLMCKjCT8fkItvhm4kn21vQ
         5At2T4Yjp4c7YSSM38TqFWIo2pcWdfHEYRHAygGLF6pxY1jtdaZQ3Qo66Zhm3nE9OVFe
         qgZmjpzySAsbst2IQGzsLid6QmghVRziVTriPg0k+0Gg9JxFLZcI8/jjqVBzRDAXJaGo
         20eAdUv+SuVNVVAUbJlqKJehB+tkpCl1Jv3xL29Pymzdnl0ra+gjcJpqvPfENMdygWyP
         Tv+Q==
X-Gm-Message-State: APjAAAU3vaGHgKZevGsl3B64GeHQYCh2jdoSDnXbqqG2GbOXwMtq2Edi
        8vjIKEBEpAqy/Bo+ILF8O4tkmNAHmwhQ2igkxRQ=
X-Google-Smtp-Source: APXvYqz22jKsVpuve01XVKK11wwcdiURB2wrAyRsazHD87rJhpy4/fORZUCdpt79NNbydK06PyuIZZ/i1J73eGWSv7U=
X-Received: by 2002:aca:5d0a:: with SMTP id r10mr9030356oib.92.1552077735703;
 Fri, 08 Mar 2019 12:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20190308175935.21904-1-TheSven73@gmail.com> <20190308202936.GA32641@arch>
In-Reply-To: <20190308202936.GA32641@arch>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 8 Mar 2019 15:42:04 -0500
Message-ID: <CAGngYiVgEDTQxynjPDMO_ZApAX6uyvUL+iqyK-QHnhDz=E4eCw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: proximity: as3935: fix use-after-free on device remove
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 3:30 PM Tomasz Duszynski <tduszyns@gmail.com> wrote:
>
> > @@ -368,7 +376,6 @@ static int as3935_probe(struct spi_device *spi)
> >
> >       spi_set_drvdata(spi, indio_dev);
> >       mutex_init(&st->lock);
> > -     INIT_DELAYED_WORK(&st->work, as3935_event_work);
>
> Any specific reason for moving this elsewhere?

Yes. On the remove path, cancel_delayed_work_sync() should execute after
free_irq(), but before triggered_buffer_cleanup(). So the devm_add_action()
must run right before devm_request_irq(). I figured it would make sense to
group the devm_add_action() and INIT_WORK() together, as they are
related. This also makes it easier to understand the probe/remove order
when reading the code.

> >
> >       ret = of_property_read_u32(np,
> >                       "ams,tuning-capacitor-pf", &st->tune_cap);
> > @@ -414,22 +421,27 @@ static int as3935_probe(struct spi_device *spi)
> >       iio_trigger_set_drvdata(trig, indio_dev);
> >       trig->ops = &iio_interrupt_trigger_ops;
> >
> > -     ret = iio_trigger_register(trig);
> > +     ret = devm_iio_trigger_register(&spi->dev, trig);
> >       if (ret) {
> >               dev_err(&spi->dev, "failed to register trigger\n");
> >               return ret;
> >       }
> >
> > -     ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
> > -             &as3935_trigger_handler, NULL);
> > +     ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> > +             iio_pollfunc_store_time, as3935_trigger_handler, NULL);
>
> You can fix arguments alignment while you are at it.
>

What type of alignment would you prefer? This?

        ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
                                              iio_pollfunc_store_time,
                                              as3935_trigger_handler, NULL);
