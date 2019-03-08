Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9700EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5938B2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLqXmIvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCHUaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:30:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40777 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHUaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:30:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id w6so18478573ljd.7;
        Fri, 08 Mar 2019 12:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ILppw8B17auBovfnrLiK4Y+7A5hqaoSpHSBaAu9NRyA=;
        b=GLqXmIvmcXlUPV93W6Z3+mssk4NraSLHY0iKn2jxtfIEkpPWMrCCZC7eAJfQ98pHe5
         an6Dm5KM2HzJIxNQQA8334+FA75S2BvWCTEbKedeOF77my8YJlYD9xDjmfeu+gk5VRan
         3Kbmu3YrzTa/MdGsqQLojmXtq24AatHxTK74qw7bN4Wm7VMjc//5qXvp/hJ6XUFHWWCi
         F8DICD7EAEiN1JLideqDU54HSQpNDQZVTY7ssEAymVLmKXtMvwUipzlUJRm6/WqNXscO
         RU9172HkZLRCaCHHhA7B6Vk5yruAGxZ4lEgaMIC74Ii8qcgkEOV9vgWE+W7UqDKfso1n
         jTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ILppw8B17auBovfnrLiK4Y+7A5hqaoSpHSBaAu9NRyA=;
        b=kRAfT2QWOAbEpeWjReOjas/ycUnURLHgRvN6ODmU3IKSqb2PC6Ll3MqW+tEJ1bYSXg
         8mSRooOWMwwrbQXXnOAWfzOhw1nr6KkxoLZZBTAgYtaIBY13AK9huaOfVTYoHZaIPW4z
         hfKdmptSh86qow0gUTvAWRn0ngMKUUc606bOohW5+7xjdJonMJut8P34Q3DgNF7A0awm
         BYajNQZ15943JCqeNSXCOD/MW0yOsGP89HUU7nbsM5zEIBB11/Q6SFAdrbWbralmD7w9
         /UKjpTR7ge+XJTmut+ZE6v+psamuE04+74ZlmqULeN8liras7ll6vWG+DeO8+t2mqhHa
         HSTA==
X-Gm-Message-State: APjAAAWYrOjuZmTwdmhg9hq46dSlqO4GpMkSyAyZVNolIspJfwiUdGjd
        RIEmJTcu2UDz7CA9RWXPcrQ=
X-Google-Smtp-Source: APXvYqwNqy981b/ZIDiBgPEm6//CiyfWc8KeXKOixC2ED97ax06PUjaIz0KN1l3nQD0VedpPMtEBWg==
X-Received: by 2002:a2e:4d7:: with SMTP id a84mr9885747ljf.86.1552077003124;
        Fri, 08 Mar 2019 12:30:03 -0800 (PST)
Received: from localhost (89-64-60-178.dynamic.chello.pl. [89.64.60.178])
        by smtp.gmail.com with ESMTPSA id y5sm1677959lfe.61.2019.03.08.12.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 12:30:02 -0800 (PST)
Date:   Fri, 8 Mar 2019 21:29:37 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2] iio: proximity: as3935: fix use-after-free on device
 remove
Message-ID: <20190308202936.GA32641@arch>
References: <20190308175935.21904-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190308175935.21904-1-TheSven73@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 12:59:35PM -0500, Sven Van Asbroeck wrote:
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
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  drivers/iio/proximity/as3935.c | 49 ++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index f130388a16a0..6e366e772164 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
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

Any specific reason for moving this elsewhere?

>
>  	ret = of_property_read_u32(np,
>  			"ams,tuning-capacitor-pf", &st->tune_cap);
> @@ -414,22 +421,27 @@ static int as3935_probe(struct spi_device *spi)
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

You can fix arguments alignment while you are at it.

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
>  				&as3935_interrupt_handler,
>  				IRQF_TRIGGER_RISING,
> @@ -438,35 +450,15 @@ static int as3935_probe(struct spi_device *spi)
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
> --
> 2.17.1
>
