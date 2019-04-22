Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF03CC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD7B20874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555927645;
	bh=/AV+Mxje0oRJQeqThuiq5IDa8PyTLtiGs8z22ZaWdrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hTKwHK2C//DcLm64K18vXUHDCUnEk2pPRQl4i0WdkHVKw/A+Kf4rBCk+UcFvNHIqD
	 Mw7RG4J0DL2uda6MpV/CdKuUpnvXwuu6bWX7FF3k11ftAi2kdUFu93hCHHW2ZZmEU2
	 JTr1NIXImOJoDH9eZeqbBa+AoWOkdbVmIxWPos/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfDVKHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfDVKHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:07:24 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EE9020811;
        Mon, 22 Apr 2019 10:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555927642;
        bh=/AV+Mxje0oRJQeqThuiq5IDa8PyTLtiGs8z22ZaWdrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PKtq7dHs2vi1JC9hdNVHWIGZvrf/GyqM0TkWFS9cODf4isrd/Yi8N+0rlP3JTN7NJ
         bN5X++c1s6xxpxbVccrwdWSc5f9w2trxm6nX4EIS19YTEA3R0Li+eLmQOF9yJ59jaH
         loTqH81ULpvY3++ooZIcahExVunaZZvjfWOfPeYU=
Date:   Mon, 22 Apr 2019 11:07:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: imx7d_adc: Simplify imx7d_adc_probe() with
 imx7d_adc_resume()
Message-ID: <20190422110717.3f2247c3@archlinux>
In-Reply-To: <20190414183504.23286-5-andrew.smirnov@gmail.com>
References: <20190414183504.23286-1-andrew.smirnov@gmail.com>
        <20190414183504.23286-5-andrew.smirnov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2019 11:35:02 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Initialization sequence performed in imx7d_adc_resume() is exactly the
> same as the one being done in imx7d_adc_probe(). Make use of the
> former in the latter to avoid code duplication. Rename
> imx7d_adc_resume() to imx7d_adc_enable() for clarity while at it.
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
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 88 +++++++++++++++----------------------
>  1 file changed, 36 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 147ee8575ad0..0922ee08546b 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -434,6 +434,33 @@ static void imx7d_adc_power_down(struct imx7d_adc *info)
>  	writel(adc_cfg, info->regs + IMX7D_REG_ADC_ADC_CFG);
>  }
>  
> +static int imx7d_adc_enable(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct imx7d_adc *info = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regulator_enable(info->vref);
> +	if (ret) {
> +		dev_err(info->dev,
> +			"Can't enable adc reference top voltage, err = %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(info->clk);
> +	if (ret) {
> +		dev_err(info->dev,
> +			"Could not prepare or enable clock.\n");
> +		regulator_disable(info->vref);
> +		return ret;
> +	}
> +
> +	imx7d_adc_hw_init(info);
> +
> +	return 0;
> +}
> +
>  static int imx7d_adc_probe(struct platform_device *pdev)
>  {
>  	struct imx7d_adc *info;
> @@ -479,14 +506,6 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = regulator_enable(info->vref);
> -	if (ret) {
> -		dev_err(dev,
> -			"Can't enable adc reference top voltage, err = %d\n",
> -			ret);
> -		return ret;
> -	}
> -
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	init_completion(&info->completion);
> @@ -498,38 +517,30 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  	indio_dev->channels = imx7d_adc_iio_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(imx7d_adc_iio_channels);
>  
> -	ret = clk_prepare_enable(info->clk);
> -	if (ret) {
> -		dev_err(dev, "Could not prepare or enable the clock.\n");
> -		goto error_adc_clk_enable;
> -	}
> -
>  	ret = devm_request_irq(dev, irq,
>  			       imx7d_adc_isr, 0,
>  			       dev_name(dev), info);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed requesting irq, irq = %d\n", irq);
> -		goto error_iio_device_register;
> +		return ret;
>  	}
>  
>  	imx7d_adc_feature_config(info);
> -	imx7d_adc_hw_init(info);
> +
> +	ret = imx7d_adc_enable(&indio_dev->dev);
> +	if (ret)
> +		return ret;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
>  		imx7d_adc_power_down(info);
> +		clk_disable_unprepare(info->clk);
> +		regulator_disable(info->vref);
>  		dev_err(&pdev->dev, "Couldn't register the device.\n");
> -		goto error_iio_device_register;
> +		return ret;
>  	}
>  
>  	return 0;
> -
> -error_iio_device_register:
> -	clk_disable_unprepare(info->clk);
> -error_adc_clk_enable:
> -	regulator_disable(info->vref);
> -
> -	return ret;
>  }
>  
>  static int imx7d_adc_remove(struct platform_device *pdev)
> @@ -560,34 +571,7 @@ static int __maybe_unused imx7d_adc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused imx7d_adc_resume(struct device *dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct imx7d_adc *info = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = regulator_enable(info->vref);
> -	if (ret) {
> -		dev_err(info->dev,
> -			"Can't enable adc reference top voltage, err = %d\n",
> -			ret);
> -		return ret;
> -	}
> -
> -	ret = clk_prepare_enable(info->clk);
> -	if (ret) {
> -		dev_err(info->dev,
> -			"Could not prepare or enable clock.\n");
> -		regulator_disable(info->vref);
> -		return ret;
> -	}
> -
> -	imx7d_adc_hw_init(info);
> -
> -	return 0;
> -}
> -
> -static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_suspend, imx7d_adc_resume);
> +static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_suspend, imx7d_adc_enable);
>  
>  static struct platform_driver imx7d_adc_driver = {
>  	.probe		= imx7d_adc_probe,

