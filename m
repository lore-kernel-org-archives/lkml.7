Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACC3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A180D222CD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 11:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfCXLuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 07:50:20 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:36794 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfCXLuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 07:50:19 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 01C8D9E758A;
        Sun, 24 Mar 2019 11:50:17 +0000 (GMT)
Date:   Sun, 24 Mar 2019 11:50:15 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: hmc5843: fix potential NULL pointer
 dereferences
Message-ID: <20190324115015.5fe793ad@archlinux>
In-Reply-To: <20190324104856.3883150b@archlinux>
References: <20190316151912.4a7ea87d@archlinux>
        <20190316220836.25092-1-kjlu@umn.edu>
        <20190324104856.3883150b@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 10:48:56 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 16 Mar 2019 17:08:33 -0500
> Kangjie Lu <kjlu@umn.edu> wrote:
> 
> > devm_regmap_init_i2c may fail and return NULL. The fix returns
> > the error when it fails.
> > 
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>  
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
> Thanks.

Ah, how the eye jumps over the obvious...

Good thing this one was caught by build tests.

See below.

I've fixed up in the tree.

Jonathan

> 
> Jonathan
> 
> > ---
> > V2: fix the two together
> > ---
> >  drivers/iio/magnetometer/hmc5843_i2c.c | 7 ++++++-
> >  drivers/iio/magnetometer/hmc5843_spi.c | 7 ++++++-
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
> > index 3de7f4426ac4..86abba5827a2 100644
> > --- a/drivers/iio/magnetometer/hmc5843_i2c.c
> > +++ b/drivers/iio/magnetometer/hmc5843_i2c.c
> > @@ -58,8 +58,13 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
> >  static int hmc5843_i2c_probe(struct i2c_client *cli,
> >  			     const struct i2c_device_id *id)
> >  {
> > +	struct regmap *regmap = devm_regmap_init_i2c(cli,
> > +			&hmc5843_i2c_regmap_config);
> > +	if (IS_ERR(regmap))
> > +		return PTR_ERR(regmap);
> > +
> >  	return hmc5843_common_probe(&cli->dev,
> > -			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
> > +			regmap,
> >  			id->driver_data, id->name);
> >  }
> >  
> > diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
> > index 535f03a70d63..8355713651d4 100644
> > --- a/drivers/iio/magnetometer/hmc5843_spi.c
> > +++ b/drivers/iio/magnetometer/hmc5843_spi.c
> > @@ -58,6 +58,7 @@ static const struct regmap_config hmc5843_spi_regmap_config = {
> >  static int hmc5843_spi_probe(struct spi_device *spi)
> >  {
> >  	int ret;
> > +	struct regmap *regmap;
> >  	const struct spi_device_id *id = spi_get_device_id(spi);
> >  
> >  	spi->mode = SPI_MODE_3;
> > @@ -67,8 +68,12 @@ static int hmc5843_spi_probe(struct spi_device *spi)
> >  	if (ret)
> >  		return ret;
> >  
> > +	regmap = devm_regmap_init(spi, &hmc5843_spi_regmap_config);

devm_regmap_init_spi


> > +	if (IS_ERR(regmap))
> > +		return PTR_ERR(devm_regmap);

It's called regmap.

> > +
> >  	return hmc5843_common_probe(&spi->dev,
> > -			devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config),
> > +			regmap,
> >  			id->driver_data, id->name);
> >  }
> >    
> 

