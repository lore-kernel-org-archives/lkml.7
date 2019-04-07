Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF6BC282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB78218D0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554635744;
	bh=tqpeUwFHMVBdZL3BC043LJa6N0pT7/rxw8h6Ut2cOBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pZ2DsUUC2n3mt5rtpkA7qn3LBKusfhkKlnQ87n7sMdjUzFoa0Cf5lz6umLnFwEOJF
	 T+JsGiBFIwgkcSYmn7Ng6BY9npM7/c0yEiCkdZwGQi/pxgVxAIw+WvBVk8YC8VUAA+
	 LsCGcISVXV5ej84aMXak2d8Ky3SdckLHPUtFgflk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDGLPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGLPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 07:15:43 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EC2220879;
        Sun,  7 Apr 2019 11:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554635742;
        bh=tqpeUwFHMVBdZL3BC043LJa6N0pT7/rxw8h6Ut2cOBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nKSL4a5YNaCU7kAKt8SQzLeY7RVwqGRhJHlbQdJiCDSaWJuQOP6KMrd0wmgaC2GwQ
         4bR5xS5S0Be3XuN93derIXMB5voQGXd3mZIcuZt7uv/tS6/hWLdlD9s8gfop9s/knW
         rRgVxWzVTxuB2qtFgWBjDSFz1qBNVbplqu6aPV+o=
Date:   Sun, 7 Apr 2019 12:15:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        Haibo Chen <haibo.chen@freescale.com>
Subject: Re: [PATCH 5/6] iio: imx7d_adc: Use imx7d_adc_resume() in
 imx7d_adc_probe()
Message-ID: <20190407121522.1d0fb39d@archlinux>
In-Reply-To: <20190403070325.1077-6-andrew.smirnov@gmail.com>
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
        <20190403070325.1077-6-andrew.smirnov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Apr 2019 00:03:24 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Initialization sequence performed in imx7d_adc_resume() is exactley
> the same as what's being done in imx7d_adc_probe(). Make use of the
> former in the latter to avoid code duplication.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
I'm not to going to apply this now, due to the ordering issue with the earlier
and later patches.  However, it is fine in of itself.

I do wonder if we want to rename resume to something else to reflect
it's new usage?  imx7d_adc_enable perhaps?
Similar question for suspend in the next patch.

Thanks,

Jonathan



> ---
>  drivers/iio/adc/imx7d_adc.c | 86 +++++++++++++++----------------------
>  1 file changed, 35 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 8bba92611d54..c2fa0ab923ee 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -434,6 +434,33 @@ static void imx7d_adc_power_down(struct imx7d_adc *info)
>  	writel(adc_cfg, info->regs + IMX7D_REG_ADC_ADC_CFG);
>  }
>  
> +static int imx7d_adc_resume(struct device *dev)
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
> +	ret = imx7d_adc_resume(&indio_dev->dev);
> +	if (ret)
> +		return ret;
>  
>  	ret = devm_iio_device_register(dev, indio_dev);
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
> @@ -558,33 +569,6 @@ static int __maybe_unused imx7d_adc_suspend(struct device *dev)
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
>  static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_suspend, imx7d_adc_resume);
>  
>  static struct platform_driver imx7d_adc_driver = {

