Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93C5C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FFB212F5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556369745;
	bh=hVmyG+1AvKUQGM0TnO9YzO1iCH5meTQ6M6O8sm/zFp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PmriuwefY4b2eMvVd1khljqcRQL7J6X2qW4qJJKiI/Nsi1Wph+DAuzEjDWiPg2hI5
	 zzLS51lrb+FUGyU+5G2dOg66/n7g+YOS9SueKlLg8YAeS+1xUxADtUC+56NLnhrEoZ
	 0tXcNItCz6wGc8nnaT9gmMbJI+8Ckh0ebD6fs7VM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfD0Mzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbfD0Mzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:55:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5052F208C2;
        Sat, 27 Apr 2019 12:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556369741;
        bh=hVmyG+1AvKUQGM0TnO9YzO1iCH5meTQ6M6O8sm/zFp0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aTHD60nk6dMIesU+YQJFMIsdD2QRFFzm7y3c7Bj9pWeQz0Px/r4kwo0rMrMQhdHDR
         IO5rzgxNnqdybtmu01nqkf1BJzx9lg+uQ4F+M4uvViHWqYK00hMvdFORuQ5NBAwIVy
         0Xwpea7BY01DKmdQ3NwbAqEggNV9R/DIxevkCfiI=
Date:   Sat, 27 Apr 2019 13:55:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Daniel Gomez <dagmcr@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, javier@dowhile0.org
Subject: Re: [PATCH v2] iio: temperature: maxim_thermocouple: declare
 missing of table
Message-ID: <20190427135535.46b3f7e9@archlinux>
In-Reply-To: <CAJCx=gkykSjn7uf67s2_NqB+-FYWF_oA_PknB7LcX5QRD_mp9Q@mail.gmail.com>
References: <1556055738-14838-1-git-send-email-dagmcr@gmail.com>
        <CAJCx=gkykSjn7uf67s2_NqB+-FYWF_oA_PknB7LcX5QRD_mp9Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 09:35:07 +0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Wed, Apr 24, 2019 at 5:42 AM Daniel Gomez <dagmcr@gmail.com> wrote:
> >
> > Add missing <of_device_id> table for SPI driver relying on SPI
> > device match since compatible is in a DT binding or in a DTS.
> >
> > Before this patch:
> > modinfo drivers/iio/temperature/maxim_thermocouple.ko | grep alias
> > alias:          spi:max31855
> > alias:          spi:max6675
> >
> > After this patch:
> > modinfo drivers/iio/temperature/maxim_thermocouple.ko | grep alias
> > alias:          spi:max31855
> > alias:          spi:max6675
> > alias:          of:N*T*Cmaxim,max31855C*
> > alias:          of:N*T*Cmaxim,max31855
> > alias:          of:N*T*Cmaxim,max6675C*
> > alias:          of:N*T*Cmaxim,max6675  
> 
> Heh oops I missed that somehow in initial development.
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the togreg branch of iio.git.  Given timing this may have
to wait for the next cycle to go upstream.

Thanks.
Jonathan

> 
> >
> > Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> > Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> > ---
> >  drivers/iio/temperature/maxim_thermocouple.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> > index c31b963..c613a64 100644
> > --- a/drivers/iio/temperature/maxim_thermocouple.c
> > +++ b/drivers/iio/temperature/maxim_thermocouple.c
> > @@ -10,6 +10,8 @@
> >  #include <linux/init.h>
> >  #include <linux/mutex.h>
> >  #include <linux/err.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/spi/spi.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/trigger.h>
> > @@ -262,9 +264,17 @@ static const struct spi_device_id maxim_thermocouple_id[] = {
> >  };
> >  MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
> >
> > +static const struct of_device_id maxim_thermocouple_of_match[] = {
> > +        { .compatible = "maxim,max6675" },
> > +        { .compatible = "maxim,max31855" },
> > +        { },
> > +};
> > +MODULE_DEVICE_TABLE(of, maxim_thermocouple_of_match);
> > +
> >  static struct spi_driver maxim_thermocouple_driver = {
> >         .driver = {
> >                 .name   = MAXIM_THERMOCOUPLE_DRV_NAME,
> > +               .of_match_table = maxim_thermocouple_of_match,
> >         },
> >         .probe          = maxim_thermocouple_probe,
> >         .remove         = maxim_thermocouple_remove,
> > --
> > 2.7.4
> >  

