Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21466C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 14:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED06020719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574518982;
	bh=CZvS75BTOSHfse9UoNY85eRZLojSKzzLceJhQNi3lU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XvhZlZOIYm1QIhjxUOO67lVhIx6vIZ7hISDgrFjtmX09BJMu84nlP6mRIx/K50LS2
	 zuD07Zr8W9SenQPifO/F26JX4ZRfEFZrcas7ZkvgGC473arB4iBfG5w4omLfCw1Z4W
	 L0ryWs8Ug2GSrIoTkybXroBemDsceEsJ2T9Cb1dU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKWOXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 09:23:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfKWOXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 09:23:00 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A7B20714;
        Sat, 23 Nov 2019 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574518979;
        bh=CZvS75BTOSHfse9UoNY85eRZLojSKzzLceJhQNi3lU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A6Ippmz2d3E68AOQsSoys5lqbZlioeIlRhuxapgKiNq1Q74irynbSQScrCqmePs1O
         TIVOzB5v/3RjP5Rx6PtQY9uv4B5XICzhE5EHPfV1PTUVy1NX2pDGuUqw4j9ykJ3b8A
         EePqyTFHI5PmN7YPY/uaBLzjkmdxX9pY13NMFrIY=
Date:   Sat, 23 Nov 2019 14:22:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: dac: ad7303: use regulator get optional to
 check for ext supply
Message-ID: <20191123142256.7bdcee03@archlinux>
In-Reply-To: <20191118105807.6842-1-alexandru.tachici@analog.com>
References: <20191113083303.2229-1-alexandru.tachici@analog.com>
        <20191118105807.6842-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 12:58:07 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Previously, the code was using the of_read_property_bool() to check if
> an external regulator was provided. However, this is redundant, as it's
> more simple/direct to just ask the regulator is provided, via a
> `devm_regulator_get_optional()` call.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we missed anything.

Thanks,

Jonathan

> ---
> Changelog v1 -> v2:
> 
> - check for -ENODEV error for devm_regulator_get_optional() call
> 
>  drivers/iio/dac/ad7303.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
> index 14bbac6bee98..15af8a1cce3e 100644
> --- a/drivers/iio/dac/ad7303.c
> +++ b/drivers/iio/dac/ad7303.c
> @@ -12,7 +12,6 @@
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -202,7 +201,6 @@ static int ad7303_probe(struct spi_device *spi)
>  	const struct spi_device_id *id = spi_get_device_id(spi);
>  	struct iio_dev *indio_dev;
>  	struct ad7303_state *st;
> -	bool ext_ref;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -224,24 +222,15 @@ static int ad7303_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	if (spi->dev.of_node) {
> -		ext_ref = of_property_read_bool(spi->dev.of_node,
> -				"REF-supply");
> -	} else {
> -		struct ad7303_platform_data *pdata = spi->dev.platform_data;
> -		if (pdata && pdata->use_external_ref)
> -			ext_ref = true;
> -		else
> -		    ext_ref = false;
> -	}
> -
> -	if (ext_ref) {
> -		st->vref_reg = devm_regulator_get(&spi->dev, "REF");
> -		if (IS_ERR(st->vref_reg)) {
> -			ret = PTR_ERR(st->vref_reg);
> +	st->vref_reg = devm_regulator_get_optional(&spi->dev, "REF");
> +	if (IS_ERR(st->vref_reg)) {
> +		ret = PTR_ERR(st->vref_reg);
> +		if (ret != -ENODEV)
>  			goto err_disable_vdd_reg;
> -		}
> +		st->vref_reg = NULL;
> +	}
>  
> +	if (st->vref_reg) {
>  		ret = regulator_enable(st->vref_reg);
>  		if (ret)
>  			goto err_disable_vdd_reg;

