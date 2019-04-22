Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20EAC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B428720874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555927737;
	bh=ncFCqdQsJXWwilPKVO+Ag6UzKreilIlBurh1+GiVtek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Jwspqh+tM9Ec3FjS8hhKgq9JXjWyBtlsqDUJeStyEAyyO27YFqavIDHhy5UR++F//
	 Zg9+05kJKG3c+0dM27XHcFjyIOupcUYFJqukbAgN7wkj67STucv6fNQpwplLEBu1Fr
	 oZ1APvWS1o/dXaLBZ3L5JrY4c1HLRpq6Px3NuL2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfDVKI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVKI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:08:56 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7516720811;
        Mon, 22 Apr 2019 10:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555927734;
        bh=ncFCqdQsJXWwilPKVO+Ag6UzKreilIlBurh1+GiVtek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FAOqbMxTiR1J1eqTe1IgEpKjI8AT+GSavJGbwK7ZFw6jGXlAb9qE3VdtRObtG9uZH
         28HiKtdKPFcxvtFOS0gIBNOQqqBaKEGIvRilqxF77Zgn/eJ+l+hBYYyCsKWm1ap9Fe
         jEySRM1PijJLxyd+gyw2yh8k4i+viaFUUt7Lt11Y=
Date:   Mon, 22 Apr 2019 11:08:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: imx7d_adc: Simplify imx7d_adc_remove() with
 imx7d_adc_suspend()
Message-ID: <20190422110850.0c710e47@archlinux>
In-Reply-To: <20190414183504.23286-6-andrew.smirnov@gmail.com>
References: <20190414183504.23286-1-andrew.smirnov@gmail.com>
        <20190414183504.23286-6-andrew.smirnov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2019 11:35:03 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Since imx7d_adc_remove() does exactly the same thing as
> imx7d_adc_suspend() we can use the latter together with
> devm_add_action_or_reset() to simplify the former. Rename
> imx7d_adc_suspend() to imx7d_adc_disable() for clarity while at it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to see if they can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 46 +++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 0922ee08546b..c5b0dc7d0e49 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -461,6 +461,24 @@ static int imx7d_adc_enable(struct device *dev)
>  	return 0;
>  }
>  
> +static int imx7d_adc_disable(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct imx7d_adc *info = iio_priv(indio_dev);
> +
> +	imx7d_adc_power_down(info);
> +
> +	clk_disable_unprepare(info->clk);
> +	regulator_disable(info->vref);
> +
> +	return 0;
> +}
> +
> +static void __imx7d_adc_disable(void *data)
> +{
> +	imx7d_adc_disable(data);
> +}
> +
>  static int imx7d_adc_probe(struct platform_device *pdev)
>  {
>  	struct imx7d_adc *info;
> @@ -531,11 +549,13 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(dev, __imx7d_adc_disable,
> +				       &indio_dev->dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
> -		imx7d_adc_power_down(info);
> -		clk_disable_unprepare(info->clk);
> -		regulator_disable(info->vref);
>  		dev_err(&pdev->dev, "Couldn't register the device.\n");
>  		return ret;
>  	}
> @@ -546,32 +566,14 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  static int imx7d_adc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct imx7d_adc *info = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
>  
> -	imx7d_adc_power_down(info);
> -
> -	clk_disable_unprepare(info->clk);
> -	regulator_disable(info->vref);
> -
>  	return 0;
>  }
>  
> -static int __maybe_unused imx7d_adc_suspend(struct device *dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct imx7d_adc *info = iio_priv(indio_dev);
> -
> -	imx7d_adc_power_down(info);
> -
> -	clk_disable_unprepare(info->clk);
> -	regulator_disable(info->vref);
> -
> -	return 0;
> -}
>  
> -static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_suspend, imx7d_adc_enable);
> +static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_disable, imx7d_adc_enable);
>  
>  static struct platform_driver imx7d_adc_driver = {
>  	.probe		= imx7d_adc_probe,

