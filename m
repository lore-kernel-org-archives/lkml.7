Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A77C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C445220866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551624039;
	bh=I5dE3gRoqLf4rVNydVf7iFmqqU7MECXQzNmVTa2jtFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UpXqVdChH0FiRKkPqLT3yAZpIv5HxyDCIh8JS0Unhm2SjLZ1VWSzVbN44XTs4dTwe
	 LSmkcUZSPFeRHbXCSADKCT6nL18wavAxzTXqpjEaCXPyDfhCv61TnClTC/zYYO5yu+
	 xvl3ix+cIIPm1pIgJKpAxiHatMpl7Y7Ozk3YYOcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfCCOkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 09:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfCCOki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 09:40:38 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8EE620836;
        Sun,  3 Mar 2019 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551624037;
        bh=I5dE3gRoqLf4rVNydVf7iFmqqU7MECXQzNmVTa2jtFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qofhbKL2TLdoMj5xb52j9tfi+0ZPtX/qX1iknni3Ico5H+oek7Tir0zoJX92lCtj3
         +dHlm1BmREKfZlZFBYOPNsnq2rIitdWMw4xCSUIKK68wvgfhgJC7b9BqX5ioDK4VIX
         Q+nKUW+dg6+XlY9i6UkZERjJTgClMVmHJvPNCG/U=
Date:   Sun, 3 Mar 2019 14:40:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 2/2] iio: counter: stm32-lptimer: Add power management
 support
Message-ID: <20190303144031.520421cf@archlinux>
In-Reply-To: <1551091367-21718-3-git-send-email-fabrice.gasnier@st.com>
References: <1551091367-21718-1-git-send-email-fabrice.gasnier@st.com>
        <1551091367-21718-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 11:42:47 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add suspend/resume PM sleep ops. When going to low power, disable
> active counter. Only active counter should be resumed: don't touch
> disabled counter, as it may be used by other LPTimer MFD child driver.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied. Thanks,

Jonathan

> ---
>  drivers/iio/counter/stm32-lptimer-cnt.c | 55 +++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/iio/counter/stm32-lptimer-cnt.c
> index 42fb8ba..2a49cce 100644
> --- a/drivers/iio/counter/stm32-lptimer-cnt.c
> +++ b/drivers/iio/counter/stm32-lptimer-cnt.c
> @@ -14,6 +14,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/mfd/stm32-lptimer.h>
>  #include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  
>  struct stm32_lptim_cnt {
> @@ -23,6 +24,7 @@ struct stm32_lptim_cnt {
>  	u32 preset;
>  	u32 polarity;
>  	u32 quadrature_mode;
> +	bool enabled;
>  };
>  
>  static int stm32_lptim_is_enabled(struct stm32_lptim_cnt *priv)
> @@ -50,6 +52,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
>  
>  	if (!enable) {
>  		clk_disable(priv->clk);
> +		priv->enabled = false;
>  		return 0;
>  	}
>  
> @@ -79,6 +82,7 @@ static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
>  		regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
>  		return ret;
>  	}
> +	priv->enabled = true;
>  
>  	/* Start LP timer in continuous mode */
>  	return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
> @@ -361,6 +365,56 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
>  	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int stm32_lptim_cnt_suspend(struct device *dev)
> +{
> +	struct stm32_lptim_cnt *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Only take care of enabled counter: don't disturb other MFD child */
> +	if (priv->enabled) {
> +		ret = stm32_lptim_setup(priv, 0);
> +		if (ret)
> +			return ret;
> +
> +		ret = stm32_lptim_set_enable_state(priv, 0);
> +		if (ret)
> +			return ret;
> +
> +		/* Force enable state for later resume */
> +		priv->enabled = true;
> +	}
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int stm32_lptim_cnt_resume(struct device *dev)
> +{
> +	struct stm32_lptim_cnt *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (priv->enabled) {
> +		priv->enabled = false;
> +		ret = stm32_lptim_setup(priv, 1);
> +		if (ret)
> +			return ret;
> +
> +		ret = stm32_lptim_set_enable_state(priv, 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(stm32_lptim_cnt_pm_ops, stm32_lptim_cnt_suspend,
> +			 stm32_lptim_cnt_resume);
> +
>  static const struct of_device_id stm32_lptim_cnt_of_match[] = {
>  	{ .compatible = "st,stm32-lptimer-counter", },
>  	{},
> @@ -372,6 +426,7 @@ static struct platform_driver stm32_lptim_cnt_driver = {
>  	.driver = {
>  		.name = "stm32-lptimer-counter",
>  		.of_match_table = stm32_lptim_cnt_of_match,
> +		.pm = &stm32_lptim_cnt_pm_ops,
>  	},
>  };
>  module_platform_driver(stm32_lptim_cnt_driver);

