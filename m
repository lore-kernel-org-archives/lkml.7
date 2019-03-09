Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B02CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF7A2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552156198;
	bh=RbmhHhdlK8/OIHbMqIAx7cAYULR/XTZGFJ2zrzfBTWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sXQbgQHSbdhK20Y1a03qSIt/Z0MoFlCbLs8ErrkZtEE+i8h4qWSak93sIho2TdE5P
	 +BCKuxuynNv/dDWQSToloAEB+p6A0wwVnCXyD9UQ89niDvvUO8U/lFA5jEV/qazEzr
	 nCkS1Er7/qZgWb1jifdM1Dwa8GBIx4i623uNDKiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCIS34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:29:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfCIS34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:29:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1C99207E0;
        Sat,  9 Mar 2019 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552156195;
        bh=RbmhHhdlK8/OIHbMqIAx7cAYULR/XTZGFJ2zrzfBTWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b0qrFU807pCQY0XooX7Fa9eAaAgkx8gtX95vRPrrdJOd2Kt31nepZKMsvRVEVC+O5
         GXCBPnYrUsz6KQ7THqnhfZp12ACufiAgir34sQ4BmvzZj8x5fSgJUDt8MrgZXuKxvE
         n2Fuq61Wc4Bkn+NL1WeZguO89se0kkJvXM1hLmXQ=
Date:   Sat, 9 Mar 2019 18:29:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: hmc: fix a potential NULL pointer dereference
Message-ID: <20190309182950.67a7dd9d@archlinux>
In-Reply-To: <20190309134208.GA7820@arch>
References: <20190309051533.14309-1-kjlu@umn.edu>
        <20190309134208.GA7820@arch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Mar 2019 14:42:09 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> On Fri, Mar 08, 2019 at 11:15:32PM -0600, Kangjie Lu wrote:
> > devm_regmap_init_i2c may fail and return NULL. The fix returns
> > the error when it fails.
> >
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> >  drivers/iio/magnetometer/hmc5843_i2c.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
> > index 3de7f4426ac4..c0cd0823f8d5 100644
> > --- a/drivers/iio/magnetometer/hmc5843_i2c.c
> > +++ b/drivers/iio/magnetometer/hmc5843_i2c.c
> > @@ -58,8 +58,13 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
> >  static int hmc5843_i2c_probe(struct i2c_client *cli,
> >  			     const struct i2c_device_id *id)
> >  {
> > +	struct regmap *devm_regmap = devm_regmap_init_i2c(cli,
> > +			&hmc5843_i2c_regmap_config);
> > +	if (IS_ERR(devm_regmap))
> > +		return PTR_ERR(devm_regmap);  
> 
> This fixes only one part of the problem leaving identical spi issue
> behind. I guess this check should be part of *common_probe().
It could be, but that somewhat hides the error checking.

I'd prefer to see it fixed like this, but in both here and the spi
file.  Both this and spi in one patch would be great!

Thanks,

Jonathan

> 
> > +
> >  	return hmc5843_common_probe(&cli->dev,
> > -			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
> > +			devm_regmap,
> >  			id->driver_data, id->name);
> >  }
> >
> > --
> > 2.17.1
> >  

