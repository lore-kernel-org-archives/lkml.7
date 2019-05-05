Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5049C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AAD208C2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 15:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557071112;
	bh=aKwSsB4VIQvPHjNpyepX94dwCojn4YcW4pPdu085lpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iHmjKTS2z9J7xvAUXspGN0t/UWaXMq0rh8jtGhfVnCWn5JeKNKOO6l9g+7bUp3zOY
	 l8JdQXawP551Kj0sen5vpfZWqUrDOTxlJQEABZW6PEI1khRbfA7Vq0C1IbtGz45q2R
	 QoMgn3Aqw51urlmhcdPS1P8hvks/J08fe56zW5zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfEEPpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 11:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfEEPpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 11:45:10 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B11FA206DF;
        Sun,  5 May 2019 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557071109;
        bh=aKwSsB4VIQvPHjNpyepX94dwCojn4YcW4pPdu085lpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0LZ8f5LyLX20WKafPP0af88glvklQ1x0J0Jve8bY4nJCqS9IyvDajjpokrGH3LdVt
         +h1+08XmvOD2KobcKuiqSatQjSlPfOdnfVwZWlZnyukPLprLaQkxFC8O1M/49pfaFZ
         5suhRhYTipcXVWcq6OvfsC/8fdhP0DI17yQOKFFs=
Date:   Sun, 5 May 2019 16:45:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     linux-iio@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] iio: stmpe-adc: Enable all stmpe-adc interrupts
 just once
Message-ID: <20190505164503.030d6687@archlinux>
In-Reply-To: <20190503135725.9959-3-dev@pschenker.ch>
References: <20190503135725.9959-1-dev@pschenker.ch>
        <20190503135725.9959-3-dev@pschenker.ch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 May 2019 15:57:25 +0200
Philippe Schenker <dev@pschenker.ch> wrote:

> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> This commit will enable the interrupts of all channels handled by this
> driver only once in the probe function.
> 
> This will improve performance because one byte less has to be written over
> i2c on each read out of the adc. On the fastest ADC mode this will improve
> read out speed by 15%.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Makes sense. I'll pick this up once patch 2 discussion is sorted.

Jonathan

> 
> ---
> 
>  drivers/iio/adc/stmpe-adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index baa41ffc0d76..427c890c6e7d 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -72,9 +72,6 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
>  		return -EINVAL;
>  	}
>  
> -	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
> -			STMPE_ADC_CH(info->channel));
> -
>  	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
>  			STMPE_ADC_CH(info->channel));
>  
> @@ -328,6 +325,9 @@ static int stmpe_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
> +			~(norequest_mask & 0xFF));
> +
>  	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  

