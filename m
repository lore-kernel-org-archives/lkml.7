Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30169ECE58D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D0B21479
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570355772;
	bh=OlLbTNQQT6sQHSPUYCODU/aXvmg291AXhhGM3phCz5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Pcd0cAIcvVw92YwSRIMiVXGQBk2lIDDuRShbsA/gk5TWne4uLP/3PYdhwaX1bC3Pk
	 xdPUuz3VbZzBYnpFrM6k1E+WdofQqEGaAJGg0P8y8IWl9gsiAgf+MXK4JZztvga1VA
	 8FJ7VqOrGHC4GUSfz2Os1fuJ1gnvZ2WYMKS0RtDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfJFJ4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 05:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFJ4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 05:56:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E5420867;
        Sun,  6 Oct 2019 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570355770;
        bh=OlLbTNQQT6sQHSPUYCODU/aXvmg291AXhhGM3phCz5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ynXCBTqU0yStOXJ7ziHE9Tefu1+HwQnJSYJlL3O0yB1h2PoKZzsrxT+Ds2QxmsiAT
         ksldfZYXiwgEVqwkH4PN6HVlqZaFuIYHrXEO5i8hxMen//7xT+aBknASKMf4CYS52x
         WFlM/BSksMVx3Pjn3wQs0F5SiO2MX3nln1wd9oWM=
Date:   Sun, 6 Oct 2019 10:56:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 2/4] iio: pressure: bmp280: use
 devm_iio_device_register()
Message-ID: <20191006105605.74387e30@archlinux>
In-Reply-To: <20191002085759.13337-3-brgl@bgdev.pl>
References: <20191002085759.13337-1-brgl@bgdev.pl>
        <20191002085759.13337-3-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Oct 2019 10:57:57 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We can use the managed variant of iio_device_register() and remove
> the corresponding unregister operation from the remove callback.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This results in a race where the regulators are powered down before
we remove the userspace interfaces.  All sorts of fun can therefore
occur...

If we fix that with some devm_add_action_or_reset fun then there
is still the fact that we loose the 'obviously correct' property
of the remove being a mirror of the probe because the ordering
wrt to runtime_pm is different.  

So I'd leave this one alone.

Thanks,

Jonathan


> ---
>  drivers/iio/pressure/bmp280-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index c21f8ce7b09c..f22400e1e98f 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1127,7 +1127,7 @@ int bmp280_common_probe(struct device *dev,
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_put(dev);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
>  		goto out_runtime_pm_disable;
>  
> @@ -1149,7 +1149,6 @@ int bmp280_common_remove(struct device *dev)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmp280_data *data = iio_priv(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
>  	pm_runtime_get_sync(data->dev);
>  	pm_runtime_put_noidle(data->dev);
>  	pm_runtime_disable(data->dev);

