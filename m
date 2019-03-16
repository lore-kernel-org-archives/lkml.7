Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A26CC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071B1218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552759366;
	bh=V2m3M1NDs50M1BPZw8KfDf4p8UdI9RgPKias2dXe1ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iIJD0kgX2NE5otx/OCf3dOc/fjJn2rkzVuL7GIAhyhnKZOsi+U/IP3+hZ0cgPW9z0
	 FQuA1kMnrbeli9tqojCK3LsAJvKWKNbco4PIByZZ2BzFB61nUyf/KsXGXo2OIXy4eb
	 OX4D9cn0O50LYHmYgCqnfEFCgMWo2jc1/k01ttj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfCPSCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbfCPSCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:02:44 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D80F218D0;
        Sat, 16 Mar 2019 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552759363;
        bh=V2m3M1NDs50M1BPZw8KfDf4p8UdI9RgPKias2dXe1ow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UfbBR3Y9FOlbDvd9o3QOVoOCCY2joGL7Lik69FMCcZKyxle8tN6IVyE5QPzrQoh/z
         L6cCvP0Fv6+p5attjea1LFAhPVezKqXKB6NmxoY2h5lfNo0Ucl+WWErZ00cXQODHwl
         seN+KIeCdWFj5rWrDvGASwgkmdpZC4p2JlqDg0ss=
Date:   Sat, 16 Mar 2019 18:02:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 07/11] staging: iio: ad7780: move regulator to after
 GPIO init
Message-ID: <20190316180236.22a907b2@archlinux>
In-Reply-To: <c018f41a8f21c0b2b25fe264cb58ba4bd2239505.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
        <c018f41a8f21c0b2b25fe264cb58ba4bd2239505.1552700652.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 23:14:59 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> To maintain consistency between ad7780_probe and ad7780_remove orders,
> regulator initialization has been moved to after GPIO initializations.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7780.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 977b381c1260..568c5b4472ff 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -295,16 +295,6 @@ static int ad7780_probe(struct spi_device *spi)
>  
>  	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
>  
> -	st->reg = devm_regulator_get(&spi->dev, "avdd");
> -	if (IS_ERR(st->reg))
> -		return PTR_ERR(st->reg);
> -
> -	ret = regulator_enable(st->reg);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
> -		return ret;
> -	}
> -
>  	st->chip_info =
>  		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
>  
> @@ -321,6 +311,16 @@ static int ad7780_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_cleanup_buffer_and_trigger;
>  
> +	st->reg = devm_regulator_get(&spi->dev, "avdd");
> +	if (IS_ERR(st->reg))
> +		return PTR_ERR(st->reg);
> +
> +	ret = regulator_enable(st->reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
> +		return ret;
> +	}
> +
>  	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
>  	if (ret)
>  		goto error_disable_reg;

