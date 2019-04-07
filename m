Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B7AC282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C5E218D0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554635803;
	bh=JC+2FIrX9yS2+fl6tD7zIck9O03o3Ta11AyNWOz1dIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cTQu+LH88df+PdFsJlo9P+2OqLe0YDVdQ9HzAtkXsaCEU8r5rp8JwXQa85LO+D84a
	 jaQb6AbBilXqmKZ6/CC/6D0YIlNkEVgJHpoa7g80ZIHC3A5JYEGCkLre5OYhpB6FNG
	 eVE3oguan1+FAWk2oyEgJzZz4p7U14vYgxES1d8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDGLQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGLQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 07:16:42 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB83D20879;
        Sun,  7 Apr 2019 11:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554635801;
        bh=JC+2FIrX9yS2+fl6tD7zIck9O03o3Ta11AyNWOz1dIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hQkKXOB9l1SxWquD4GyPJt08gZcBy8c4PfTmjBYi6Ch21ZLjivbE40T7QvhPtlh3J
         w4h9kinI3M0K9Nr+q8scwzd+vQr5zuxUrPdgJe7BtVYaFaOWVtGB/MUiKnJ8syB89M
         W7Ykq8oXxLL2bNC1lcGSfLXSoQb7WWRBOY4I29uc=
Date:   Sun, 7 Apr 2019 12:16:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        Haibo Chen <haibo.chen@freescale.com>
Subject: Re: [PATCH 6/6] iio: imx7d_adc: Drop imx7d_adc_remove()
Message-ID: <20190407121636.7a6abe25@archlinux>
In-Reply-To: <20190403070325.1077-7-andrew.smirnov@gmail.com>
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
        <20190403070325.1077-7-andrew.smirnov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Apr 2019 00:03:25 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Since imx7d_adc_remove() does exactly the same thing as
> imx7d_adc_suspend() we can use the latter together with
> devm_add_action_or_reset() to get rid of the former.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
Ah. OK, so you end up with one of the options I listed when rejecting
the earlier change for iio_device_register.

Please merge this patch with that one so we have a single change and don't
end up with a race condition prone state in between. Separate patches
are fine as well, but work your way down through probe rather than jumping
around like now.  Hence we'll have something valid at all stages.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/imx7d_adc.c | 55 ++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index c2fa0ab923ee..ed95909eada2 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -461,6 +461,24 @@ static int imx7d_adc_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int imx7d_adc_suspend(struct device *dev)
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
> +static void __imx7d_adc_suspend(void *data)
> +{
> +	imx7d_adc_suspend(data);
> +}
> +
>  static int imx7d_adc_probe(struct platform_device *pdev)
>  {
>  	struct imx7d_adc *info;
> @@ -506,8 +524,6 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	platform_set_drvdata(pdev, indio_dev);
> -
>  	init_completion(&info->completion);
>  
>  	indio_dev->name = dev_name(dev);
> @@ -531,11 +547,13 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(dev, __imx7d_adc_suspend,
> +				       &indio_dev->dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret) {
> -		imx7d_adc_power_down(info);
> -		clk_disable_unprepare(info->clk);
> -		regulator_disable(info->vref);
>  		dev_err(&pdev->dev, "Couldn't register the device.\n");
>  		return ret;
>  	}
> @@ -543,37 +561,10 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int imx7d_adc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct imx7d_adc *info = iio_priv(indio_dev);
> -
> -	imx7d_adc_power_down(info);
> -
> -	clk_disable_unprepare(info->clk);
> -	regulator_disable(info->vref);
> -
> -	return 0;
> -}
> -
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
> -
>  static SIMPLE_DEV_PM_OPS(imx7d_adc_pm_ops, imx7d_adc_suspend, imx7d_adc_resume);
>  
>  static struct platform_driver imx7d_adc_driver = {
>  	.probe		= imx7d_adc_probe,
> -	.remove		= imx7d_adc_remove,
>  	.driver		= {
>  		.name	= "imx7d_adc",
>  		.of_match_table = imx7d_adc_match,

