Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D9FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31431222D7
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553424545;
	bh=/DFt5fU/vxRKsb8S7KrQ2hYgKHDtrEfUPgD2GgReHbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fSKd0ZklIyW/T5+HWI6l7mvYKAXGVr0ZTJ4GPmQgldhhpVfDkYYU6u1xt1i8CRC3G
	 ZA5HolnVknKhR6t40QjcNBojx6k53itHzTzVMcnP3p5cE8cKZtPlgx/Rc2uWV6gY15
	 SLS2VSQD/OY8RxDlaBjHt6xuncwfMfbgyFoYwTMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfCXKtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 06:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfCXKtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 06:49:01 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D9321B24;
        Sun, 24 Mar 2019 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553424541;
        bh=/DFt5fU/vxRKsb8S7KrQ2hYgKHDtrEfUPgD2GgReHbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FmSox5H3xDWqzQ1jOPaDK/A+f4VsSNzgPtqAEsKqCFTyEjoMVzoteAYDSptUkcYAQ
         trp1G/eRakBVTIjLswqs9/4252YAbqd8AKVXHN3c6ecBj1RlQ3JF4FRJ2ZG+fsVPNl
         F39VT03WprLKJuKHVPMC9dNQunl+og1vpT1pHKfQ=
Date:   Sun, 24 Mar 2019 10:48:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: hmc5843: fix potential NULL pointer
 dereferences
Message-ID: <20190324104856.3883150b@archlinux>
In-Reply-To: <20190316220836.25092-1-kjlu@umn.edu>
References: <20190316151912.4a7ea87d@archlinux>
        <20190316220836.25092-1-kjlu@umn.edu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 17:08:33 -0500
Kangjie Lu <kjlu@umn.edu> wrote:

> devm_regmap_init_i2c may fail and return NULL. The fix returns
> the error when it fails.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.
Thanks.

Jonathan

> ---
> V2: fix the two together
> ---
>  drivers/iio/magnetometer/hmc5843_i2c.c | 7 ++++++-
>  drivers/iio/magnetometer/hmc5843_spi.c | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
> index 3de7f4426ac4..86abba5827a2 100644
> --- a/drivers/iio/magnetometer/hmc5843_i2c.c
> +++ b/drivers/iio/magnetometer/hmc5843_i2c.c
> @@ -58,8 +58,13 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
>  static int hmc5843_i2c_probe(struct i2c_client *cli,
>  			     const struct i2c_device_id *id)
>  {
> +	struct regmap *regmap = devm_regmap_init_i2c(cli,
> +			&hmc5843_i2c_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
>  	return hmc5843_common_probe(&cli->dev,
> -			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
> +			regmap,
>  			id->driver_data, id->name);
>  }
>  
> diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
> index 535f03a70d63..8355713651d4 100644
> --- a/drivers/iio/magnetometer/hmc5843_spi.c
> +++ b/drivers/iio/magnetometer/hmc5843_spi.c
> @@ -58,6 +58,7 @@ static const struct regmap_config hmc5843_spi_regmap_config = {
>  static int hmc5843_spi_probe(struct spi_device *spi)
>  {
>  	int ret;
> +	struct regmap *regmap;
>  	const struct spi_device_id *id = spi_get_device_id(spi);
>  
>  	spi->mode = SPI_MODE_3;
> @@ -67,8 +68,12 @@ static int hmc5843_spi_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	regmap = devm_regmap_init(spi, &hmc5843_spi_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(devm_regmap);
> +
>  	return hmc5843_common_probe(&spi->dev,
> -			devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config),
> +			regmap,
>  			id->driver_data, id->name);
>  }
>  

