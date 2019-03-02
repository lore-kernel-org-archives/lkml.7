Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A937AC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC1520675
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551552838;
	bh=Fitcxw94RzbZAVYEPd3Ilv+6poC1g3EvnpR3LUQVnTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=u5CFb4yPKW3QwIo0MMum9w7ilDXsyRuvrtjIUNPnk4CnP0zRAYYIrYFR0ftcRVz0Z
	 LgxmDyMGrrMj/akrVV/0m/A+4NvrA2sMfwSnuhGYMo/XWLORAmv9mt7l4E0i2yStf6
	 sxiWcz5cLBV2gy4hnI+e3CiNs2Q+F1YbPRQ/0Df8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfCBSx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:53:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfCBSx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 13:53:57 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 653EB20449;
        Sat,  2 Mar 2019 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551552835;
        bh=Fitcxw94RzbZAVYEPd3Ilv+6poC1g3EvnpR3LUQVnTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QEv3gzGSI2yBjqLAQEv3upTTU33AgzroQlYEQY7XpGQdtXm/w9+X6z5KsetCoG/zy
         tiboBYGJkVOI5irSG7OOmWvLTVL4xXBwozXp8JxQULRNPX4s9Gh5ailYcNsDt2EMte
         l3hjuXEHuTn+b6WyRDVTWKSVltBOHDeVdWfwQzHM=
Date:   Sat, 2 Mar 2019 18:53:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     justinpopo6@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: adc: ti-ads7950: Fix improper use of mlock
Message-ID: <20190302185349.7c46488f@archlinux>
In-Reply-To: <1551392209-20004-2-git-send-email-justinpopo6@gmail.com>
References: <1551392209-20004-1-git-send-email-justinpopo6@gmail.com>
        <1551392209-20004-2-git-send-email-justinpopo6@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 14:16:48 -0800
justinpopo6@gmail.com wrote:

> From: Justin Chen <justinpopo6@gmail.com>
> 
> Indio->mlock is used for protecting the different iio device modes.
> It is currently not being used in this way. Replace the lock with
> an internal lock specifically used for protecting the SPI transfer
> buffer.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Great, thanks for doing this.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads7950.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 0ad6359..1e47bef 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -56,6 +56,9 @@ struct ti_ads7950_state {
>  	struct spi_message	ring_msg;
>  	struct spi_message	scan_single_msg;
>  
> +	/* Lock to protect the spi xfer buffers */
> +	struct mutex		slock;
> +
>  	struct regulator	*reg;
>  	unsigned int		vref_mv;
>  
> @@ -268,6 +271,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
>  	struct ti_ads7950_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> +	mutex_lock(&st->slock);
>  	ret = spi_sync(st->spi, &st->ring_msg);
>  	if (ret < 0)
>  		goto out;
> @@ -276,6 +280,7 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
>  					   iio_get_time_ns(indio_dev));
>  
>  out:
> +	mutex_unlock(&st->slock);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> @@ -286,7 +291,7 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  	struct ti_ads7950_state *st = iio_priv(indio_dev);
>  	int ret, cmd;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->slock);
>  
>  	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
>  	st->single_tx = cmd;
> @@ -298,7 +303,7 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  	ret = st->single_rx;
>  
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->slock);
>  
>  	return ret;
>  }
> @@ -432,16 +437,19 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	if (ACPI_COMPANION(&spi->dev))
>  		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
>  
> +	mutex_init(&st->slock);
> +
>  	st->reg = devm_regulator_get(&spi->dev, "vref");
>  	if (IS_ERR(st->reg)) {
>  		dev_err(&spi->dev, "Failed get get regulator \"vref\"\n");
> -		return PTR_ERR(st->reg);
> +		ret = PTR_ERR(st->reg);
> +		goto error_destroy_mutex;
>  	}
>  
>  	ret = regulator_enable(st->reg);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to enable regulator \"vref\"\n");
> -		return ret;
> +		goto error_destroy_mutex;
>  	}
>  
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> @@ -463,6 +471,8 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	iio_triggered_buffer_cleanup(indio_dev);
>  error_disable_reg:
>  	regulator_disable(st->reg);
> +error_destroy_mutex:
> +	mutex_destroy(&st->slock);
>  
>  	return ret;
>  }
> @@ -475,6 +485,7 @@ static int ti_ads7950_remove(struct spi_device *spi)
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	regulator_disable(st->reg);
> +	mutex_destroy(&st->slock);
>  
>  	return 0;
>  }

