Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E74DC00319
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CC42086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551553923;
	bh=Hw3OqUKayNoPIzVg5dZ2y8zTO9GbokI2vWGUft2B8H0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wbwuUIUQI5gNcMh1jxb3XvYrquD3Ae4RC33Lzqybb6ZLNNN4J1Yzy/oQFqxs1OSC2
	 Sd06zn+ZYhoqJ/9+W8o8Nlr+/IUeAqgLaeg65XFz6qzhRQMsvcqtqAqtkfwPgeVkDl
	 roPqqbUGvwu/cDHLM5AJrcboTXXwdo9SUWGZg4bI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfCBTMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 14:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfCBTMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 14:12:01 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B2A20863;
        Sat,  2 Mar 2019 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551553920;
        bh=Hw3OqUKayNoPIzVg5dZ2y8zTO9GbokI2vWGUft2B8H0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r/tXZxj4dvoRUQm+ANTQGeCbCuayT9ekypwYsQ0yDfaZPXC0F47QpUuHUmihuMraI
         ymDxsWSOSNu2gH5dYCTf9i2p13TtFnt2cZ8985oHwUYpn6GLeM6AVEXp4sUfKlTYA4
         37dyh7Hm6h2IYN5QNld4j2sHdLi/LFn19mPhBFF8=
Date:   Sat, 2 Mar 2019 19:11:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <Alex.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 5/9] staging: iio: ad7780: move regulator to after
 GPIO init
Message-ID: <20190302191153.5d57a86b@archlinux>
In-Reply-To: <28d78cfc00bc5414c7539879df46200d61e52ee1.camel@analog.com>
References: <cover.1551358569.git.renatogeh@gmail.com>
        <93cabb081605ac356f2f0d9a9a41d5bc5e63820d.1551358569.git.renatogeh@gmail.com>
        <28d78cfc00bc5414c7539879df46200d61e52ee1.camel@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 07:38:45 +0000
"Ardelean, Alexandru" <Alex.Ardelean@analog.com> wrote:

> On Thu, 2019-02-28 at 11:25 -0300, Renato Lui Geh wrote:
> > 
> > 
> > To maintain consistency between ad7780_probe and ad7780_remove orders,
> > regulator initialization has been moved to after GPIO initializations.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7780.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index ad7617a3a141..12aef0f101bc 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -255,16 +255,6 @@ static int ad7780_probe(struct spi_device *spi)
> > 
> >         ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
> > 
> > -       st->reg = devm_regulator_get(&spi->dev, "avdd");
> > -       if (IS_ERR(st->reg))
> > -               return PTR_ERR(st->reg);
> > -
> > -       ret = regulator_enable(st->reg);
> > -       if (ret) {
> > -               dev_err(&spi->dev, "Failed to enable specified AVdd
> > supply\n");
> > -               return ret;
> > -       }
> > -
> >         st->chip_info =
> >                 &ad7780_chip_info_tbl[spi_get_device_id(spi)-  
> > >driver_data];  
> > 
> > @@ -284,7 +274,7 @@ static int ad7780_probe(struct spi_device *spi)
> >                 ret = PTR_ERR(st->powerdown_gpio);
> >                 dev_err(&spi->dev, "Failed to request powerdown GPIO:
> > %d\n",
> >                         ret);
> > -               goto error_disable_reg;
> > +               return ret;
> >         }
> > 
> >         if (st->chip_info->is_ad778x) {
> > @@ -295,7 +285,7 @@ static int ad7780_probe(struct spi_device *spi)
> >                         ret = PTR_ERR(st->gain_gpio);
> >                         dev_err(&spi->dev, "Failed to request gain GPIO:
> > %d\n",
> >                                 ret);
> > -                       goto error_disable_reg;
> > +                       return ret;
> >                 }
> > 
> >                 st->filter_gpio = devm_gpiod_get_optional(&spi->dev,
> > @@ -306,10 +296,20 @@ static int ad7780_probe(struct spi_device *spi)
> >                         dev_err(&spi->dev,
> >                                 "Failed to request filter GPIO: %d\n",
> >                                 ret);
> > -                       goto error_disable_reg;
> > +                       return ret;
> >                 }
> >         }
> > 
> > +       st->reg = devm_regulator_get(&spi->dev, "avdd");
> > +       if (IS_ERR(st->reg))
> > +               return PTR_ERR(st->reg);
> > +
> > +       ret = regulator_enable(st->reg);
> > +       if (ret) {
> > +               dev_err(&spi->dev, "Failed to enable specified AVdd
> > supply\n");
> > +               return ret;
> > +       }
> > +  
> 
> I'm probably missing something, but other than the fact that this moves the
> regulator init after the GPIOs init, it doesn't change much.
> The order of the probe & remove is more-or-less the same.
> The GPIOs will be free'd via devm_ API/stuff.

This is another one from me.  I'm a fanatic at times when it comes
to probe and remove orders being precise reverses.  It just makes
review easier.  Nice to not actually have to think.

So I agree there is no 'actual' effect but it is in my view
still worth doing.

Jonathan

> 
> 
> >         ret = ad_sd_setup_buffer_and_trigger(indio_dev);
> >         if (ret)
> >                 goto error_disable_reg;
> > --
> > 2.21.0
> >   

