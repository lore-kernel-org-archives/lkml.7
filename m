Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA0DC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C4520836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 16:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKxReUwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfCIQaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 11:30:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40430 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfCIQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 11:30:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id u68so501097lff.7;
        Sat, 09 Mar 2019 08:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=twice60yMWFlD1k7/REA4lgd8Jp312s+vCTW7daibBY=;
        b=kKxReUwqEJ6N+WpDvKtKQhL4P9c5Mq9JY1fMOkerbVJpbFJAVb/dHawU+l+VDWjUju
         qf4GLkymrzZQkSV+6fKqFI+RSD7YhRXxSpHqJ/oUAe/PsnnBCekhk77jTOWaiQUMnzsS
         T6XlkyVck4KuaPXMDt+k63VSCDyWjURAtjHFlhlDW1Ut3cMKonSk1moE2awiCiLdZcqZ
         6bRPXMz1gmxNIouOK5729451m5PpTfzDfcaxkafmRGRP0sfB7wXSmnUa/jLItz3wMeQk
         sn5nycPVh51tHeZkLq8oAiYXgBzr5JnaRnLkH0q7EE9yfBbghd5z4cVQQGKs4TWMoaqv
         YHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=twice60yMWFlD1k7/REA4lgd8Jp312s+vCTW7daibBY=;
        b=NkCyAiakbjPhVDk3csDlEl35eSpreYVdTrVSFFT33lCOb3lqlPQq0iG0QTAUEVBr4T
         TAuc/3z5lw/I0hhHjgWVaFwOGvjPHBHnSwm+6kQk3xhL52lPwL8QWUK3+zdrcYw56USx
         w/FO+FghhOKEas84UM1FOC0NZaS/FWBxcSKDhoyMzXzktY0nG4DA+nV5Sc5m2gKY0lPz
         vdZZ4/uQjpxF1EOvt6yjUJw/i/NefDikSHNybx3RVxX1eEW+RCDLctSwyz7fwEDvSfYY
         6nAPHTAdAMzYRwWEJr1deaAyeRxsY5toWC7voeyjaTMnTDmcGRBS6p1a/Dx98JTgvtTi
         L4+Q==
X-Gm-Message-State: APjAAAWG0finuBYoz9MOK6Epqi5cYTiLnfnIg2vBDJYWKZQlDhg9i6MN
        zhtePhIRJB3NTdZq6iwl2fQ=
X-Google-Smtp-Source: APXvYqymA0Kw6CaoxcAbnj4xhW6UhrmtO24JULfBGYimp/rOHEic+t+XirpPVUVkwexcRexlc9CrCQ==
X-Received: by 2002:a19:198d:: with SMTP id 135mr4383429lfz.92.1552149001729;
        Sat, 09 Mar 2019 08:30:01 -0800 (PST)
Received: from localhost (89-64-59-159.dynamic.chello.pl. [89.64.59.159])
        by smtp.gmail.com with ESMTPSA id a23sm152212ljd.20.2019.03.09.08.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 08:30:00 -0800 (PST)
Date:   Sat, 9 Mar 2019 17:29:36 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     justinpopo6@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iio: adc: ti-ads7950: Fix improper use of mlock
Message-ID: <20190309162935.GC7820@arch>
References: <1552082608-42603-1-git-send-email-justinpopo6@gmail.com>
 <1552082608-42603-2-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1552082608-42603-2-git-send-email-justinpopo6@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 02:03:27PM -0800, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
>
> Indio->mlock is used for protecting the different iio device modes.
> It is currently not being used in this way. Replace the lock with
> an internal lock specifically used for protecting the SPI transfer
> buffer.
>
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
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

If your intention was to do resources cleanup then this is not
what this api was designed for. This is actually for debugging unwanted
subsequent mutex usage.

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
> --
> 2.7.4
>
