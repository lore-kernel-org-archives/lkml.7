Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AE1C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4032085B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565513417;
	bh=8QkGLXsHmalSfIJDYq/28ePsz7HcQzi4xVINDfBLAhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wS5CnxdWFxavqnvx7xTYKTqHiEwt9u4nSZvVKa9D3bjuo3pj7sM9aBmbs0FCm00ma
	 Az/8e/Y7ThKXG1rZrBJuoB0ShOVhN7uAxXqnOeMH/JlaFtnLGZuD6YBZKHvKEGvraT
	 +jDGwH8gPxzJml8mhBg6HmG4CzNCllphgEbi5aWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfHKIuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 04:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfHKIuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 04:50:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 131752085B;
        Sun, 11 Aug 2019 08:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565513414;
        bh=8QkGLXsHmalSfIJDYq/28ePsz7HcQzi4xVINDfBLAhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GRBd0U3i732Pi48XKi8Yxb5p8coBKYwy1VNf3p/enjPbo3nMyEfi+NXpsajuwRs9X
         9FCDIe8bJbNXddIuV7YteTQkeIAQjKXNRM6glCkHuzhOzl+eeOazaAzifM+Cuky6bY
         tV85LRzPAd07wI/rd8XMC9K9k7e4iLZu6R8Uww3c=
Date:   Sun, 11 Aug 2019 09:50:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH] iio: hi8435: Use gpiod_set_value_cansleep()
Message-ID: <20190811094924.42d49ce2@archlinux>
In-Reply-To: <20190811054511.6430-1-andrew.smirnov@gmail.com>
References: <20190811054511.6430-1-andrew.smirnov@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Nikita, Valdimir.

On Sat, 10 Aug 2019 22:45:11 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Use gpiod_set_value_cansleep() instead of gpiod_set_value() to support
> the case when reset pin is connected to a GPIO expander. See ZII VF610
> SCU4 AIB for one such example.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>

Seems sensible to me so I've applied it to the togreg branch of iio.git and
pushed out as testing for the autobuilder to play with it.

Still time for last minute comments if anyone has them though.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/hi8435.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index 35951c47004e..c15f0e154e4d 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -477,7 +477,7 @@ static int hi8435_probe(struct spi_device *spi)
>  		hi8435_writeb(priv, HI8435_CTRL_REG, 0);
>  	} else {
>  		udelay(5);
> -		gpiod_set_value(reset_gpio, 1);
> +		gpiod_set_value_cansleep(reset_gpio, 1);
>  	}
>  
>  	spi_set_drvdata(spi, idev);

