Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBF8C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E03220851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfCHRNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:13:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbfCHRND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:13:03 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 68B67B304371D293F130;
        Sat,  9 Mar 2019 01:12:56 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Sat, 9 Mar 2019
 01:12:54 +0800
Date:   Fri, 8 Mar 2019 17:12:44 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: proximity: as3935: fix use-after-free on device
 remove
Message-ID: <20190308171244.00001ec8@huawei.com>
In-Reply-To: <20190306174559.17362-1-TheSven73@gmail.com>
References: <20190306174559.17362-1-TheSven73@gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019 12:45:59 -0500
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> This driver's probe() uses a mix of devm_ and non-devm_ functions. This
> means that the remove order will not be the exact opposite of the probe
> order.
> 
> Remove order:
> 1. remove() executes:
> 	iio_device_unregister
> 	iio_triggered_buffer_cleanup
> 	iio_trigger_unregister
> 	(A)
> 2. core frees devm resources in reverse order:
> 	free_irq
> 	iio_trigger_free
> 	iio_device_free
> 
> In (A) the trigger has been unregistered, but the irq handler is still
> registered and active, so the trigger may still be touched via
> interrupt -> as3935_event_work. This is a potential use-after-unregister.
> 
> Given that the delayed work is never canceled explicitly, it may run even
> after iio_device_free. This is a potential use-after-free.
> 
> Solution: convert all probe functions to their devm_ equivalents.
> Add a devm callback, called by the core on remove right after irq_free,
> which explicitly cancels the delayed work. This will guarantee that all
> resources are freed in the correct order.
> 
> As an added bonus, some boilerplate code can be removed.
> 
> While we're here, remove redundant &'s in front of function names when
> passing a pointer-to-function.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
Hi Sven

Your description makes it clear that there are multiple things in the patch.
Don't do a 'while we were here' in a patch doing something else please.
Separate patches.

Content looks good.

Jonathan

> ---
>  drivers/iio/proximity/as3935.c | 53 ++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index f130388a16a0..e33334ea2830 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -213,7 +213,7 @@ static int as3935_read_raw(struct iio_dev *indio_dev,
>  
>  static const struct iio_info as3935_info = {
>  	.attrs = &as3935_attribute_group,
> -	.read_raw = &as3935_read_raw,
> +	.read_raw = as3935_read_raw,
>  };
>  
>  static irqreturn_t as3935_trigger_handler(int irq, void *private)
> @@ -345,6 +345,14 @@ static SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
>  #define AS3935_PM_OPS NULL
>  #endif
>  
> +static void as3935_stop_work(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct as3935_state *st = iio_priv(indio_dev);
> +
> +	cancel_delayed_work_sync(&st->work);
> +}
> +
>  static int as3935_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -368,7 +376,6 @@ static int as3935_probe(struct spi_device *spi)
>  
>  	spi_set_drvdata(spi, indio_dev);
>  	mutex_init(&st->lock);
> -	INIT_DELAYED_WORK(&st->work, as3935_event_work);
>  
>  	ret = of_property_read_u32(np,
>  			"ams,tuning-capacitor-pf", &st->tune_cap);
> @@ -414,59 +421,44 @@ static int as3935_probe(struct spi_device *spi)
>  	iio_trigger_set_drvdata(trig, indio_dev);
>  	trig->ops = &iio_interrupt_trigger_ops;
>  
> -	ret = iio_trigger_register(trig);
> +	ret = devm_iio_trigger_register(&spi->dev, trig);
>  	if (ret) {
>  		dev_err(&spi->dev, "failed to register trigger\n");
>  		return ret;
>  	}
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
> -		&as3935_trigger_handler, NULL);
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +		iio_pollfunc_store_time, as3935_trigger_handler, NULL);
>  
>  	if (ret) {
>  		dev_err(&spi->dev, "cannot setup iio trigger\n");
> -		goto unregister_trigger;
> +		return ret;
>  	}
>  
>  	calibrate_as3935(st);
>  
> +	INIT_DELAYED_WORK(&st->work, as3935_event_work);
> +	ret = devm_add_action(&spi->dev, as3935_stop_work, indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = devm_request_irq(&spi->dev, spi->irq,
> -				&as3935_interrupt_handler,
> +				as3935_interrupt_handler,
>  				IRQF_TRIGGER_RISING,
>  				dev_name(&spi->dev),
>  				indio_dev);
>  
>  	if (ret) {
>  		dev_err(&spi->dev, "unable to request irq\n");
> -		goto unregister_buffer;
> +		return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "unable to register device\n");
> -		goto unregister_buffer;
> +		return ret;
>  	}
>  	return 0;
> -
> -unregister_buffer:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -unregister_trigger:
> -	iio_trigger_unregister(st->trig);
> -
> -	return ret;
> -}
> -
> -static int as3935_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct as3935_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	iio_trigger_unregister(st->trig);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id as3935_of_match[] = {
> @@ -488,7 +480,6 @@ static struct spi_driver as3935_driver = {
>  		.pm	= AS3935_PM_OPS,
>  	},
>  	.probe		= as3935_probe,
> -	.remove		= as3935_remove,
>  	.id_table	= as3935_id,
>  };
>  module_spi_driver(as3935_driver);


