Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71901C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3086B20700
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554026650;
	bh=v1rlFX1bD8p6R7krMflQEWhK3ImKzZkOt7GbuWsGxEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IX7kjLhs/jxTfKsASwqSzfHTFKfsVtu2oB+sgS3hvN4y6nS1IzIZqZOKESnDixGFK
	 otGNOuTI78+zmX5KK/yd0fC8zRjl3TjxJqMGRZLrsz5XkE01DwGYoybuJoguINZcPM
	 MNm0BVY/hECVqfI6HL8aCxksnnziTZdeKFbHLPT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfCaKEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfCaKEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:04:06 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA0D206BA;
        Sun, 31 Mar 2019 10:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554026644;
        bh=v1rlFX1bD8p6R7krMflQEWhK3ImKzZkOt7GbuWsGxEQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mE0aMILM8dGf/+/nSGdVicPYADjYkcGDKasAszUh7k3dzTJSOcGd+byDrytChJ2NF
         k1m19XMEeFT+XNdG5NCIybHwpr9aR2Ie9XnffCEEhkvFaYVdTWr9aASWiaYCOQb8rf
         TFm9vEHbrYZjcZ5OBz00XUkx4M2Cvaw5MnvaaPVs=
Date:   Sun, 31 Mar 2019 11:03:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: add PM support
Message-ID: <20190331110358.04b59b09@archlinux>
In-Reply-To: <1553525368-23419-1-git-send-email-fabrice.gasnier@st.com>
References: <1553525368-23419-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 15:49:28 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add PM and runtime PM support to STM32 DFSDM drivers:
> - stm32-dfsdm-core: manage clocks.
> - stm32-dfsdm-adc: restore channels configuration upon resume. Also stop
>   restart everything in case of buffer mode.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
I'll confess that power management code always gives me a headache, but
I 'think' this looks right.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c  |  75 +++++++++++++++--
>  drivers/iio/adc/stm32-dfsdm-core.c | 163 +++++++++++++++++++++++++++++++------
>  2 files changed, 206 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 531ca7e..a599097 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -851,24 +851,18 @@ static int stm32_dfsdm_update_scan_mode(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
> +static int __stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>  	int ret;
>  
> -	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> -		ret = iio_triggered_buffer_postenable(indio_dev);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
>  	/* Reset adc buffer index */
>  	adc->bufi = 0;
>  
>  	if (adc->hwc) {
>  		ret = iio_hw_consumer_enable(adc->hwc);
>  		if (ret < 0)
> -			goto err_predisable;
> +			return ret;
>  	}
>  
>  	ret = stm32_dfsdm_start_dfsdm(adc->dfsdm);
> @@ -896,6 +890,26 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  err_stop_hwc:
>  	if (adc->hwc)
>  		iio_hw_consumer_disable(adc->hwc);
> +
> +	return ret;
> +}
> +
> +static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +		ret = iio_triggered_buffer_postenable(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = __stm32_dfsdm_postenable(indio_dev);
> +	if (ret < 0)
> +		goto err_predisable;
> +
> +	return 0;
> +
>  err_predisable:
>  	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
>  		iio_triggered_buffer_predisable(indio_dev);
> @@ -903,7 +917,7 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> -static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
> +static void __stm32_dfsdm_predisable(struct iio_dev *indio_dev)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>  
> @@ -915,6 +929,11 @@ static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
>  
>  	if (adc->hwc)
>  		iio_hw_consumer_disable(adc->hwc);
> +}
> +
> +static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
> +{
> +	__stm32_dfsdm_predisable(indio_dev);
>  
>  	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
>  		iio_triggered_buffer_predisable(indio_dev);
> @@ -1492,10 +1511,48 @@ static int stm32_dfsdm_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused stm32_dfsdm_adc_suspend(struct device *dev)
> +{
> +	struct stm32_dfsdm_adc *adc = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		__stm32_dfsdm_predisable(indio_dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused stm32_dfsdm_adc_resume(struct device *dev)
> +{
> +	struct stm32_dfsdm_adc *adc = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	const struct iio_chan_spec *chan;
> +	struct stm32_dfsdm_channel *ch;
> +	int i, ret;
> +
> +	/* restore channels configuration */
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		chan = indio_dev->channels + i;
> +		ch = &adc->dfsdm->ch_list[chan->channel];
> +		ret = stm32_dfsdm_chan_configure(adc->dfsdm, ch);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		__stm32_dfsdm_postenable(indio_dev);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(stm32_dfsdm_adc_pm_ops,
> +			 stm32_dfsdm_adc_suspend, stm32_dfsdm_adc_resume);
> +
>  static struct platform_driver stm32_dfsdm_adc_driver = {
>  	.driver = {
>  		.name = "stm32-dfsdm-adc",
>  		.of_match_table = stm32_dfsdm_adc_match,
> +		.pm = &stm32_dfsdm_adc_pm_ops,
>  	},
>  	.probe = stm32_dfsdm_adc_probe,
>  	.remove = stm32_dfsdm_adc_remove,
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 472b809..0a4d374 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -12,6 +12,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> @@ -90,6 +92,36 @@ struct dfsdm_priv {
>  	struct clk *aclk; /* audio clock */
>  };
>  
> +static inline struct dfsdm_priv *to_stm32_dfsdm_priv(struct stm32_dfsdm *dfsdm)
> +{
> +	return container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +}
> +
> +static int stm32_dfsdm_clk_prepare_enable(struct stm32_dfsdm *dfsdm)
> +{
> +	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret || !priv->aclk)
> +		return ret;
> +
> +	ret = clk_prepare_enable(priv->aclk);
> +	if (ret)
> +		clk_disable_unprepare(priv->clk);
> +
> +	return ret;
> +}
> +
> +static void stm32_dfsdm_clk_disable_unprepare(struct stm32_dfsdm *dfsdm)
> +{
> +	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
> +
> +	if (priv->aclk)
> +		clk_disable_unprepare(priv->aclk);
> +	clk_disable_unprepare(priv->clk);
> +}
> +
>  /**
>   * stm32_dfsdm_start_dfsdm - start global dfsdm interface.
>   *
> @@ -98,24 +130,17 @@ struct dfsdm_priv {
>   */
>  int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
>  {
> -	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
>  	struct device *dev = &priv->pdev->dev;
>  	unsigned int clk_div = priv->spi_clk_out_div, clk_src;
>  	int ret;
>  
>  	if (atomic_inc_return(&priv->n_active_ch) == 1) {
> -		ret = clk_prepare_enable(priv->clk);
> +		ret = pm_runtime_get_sync(dev);
>  		if (ret < 0) {
> -			dev_err(dev, "Failed to start clock\n");
> +			pm_runtime_put_noidle(dev);
>  			goto error_ret;
>  		}
> -		if (priv->aclk) {
> -			ret = clk_prepare_enable(priv->aclk);
> -			if (ret < 0) {
> -				dev_err(dev, "Failed to start audio clock\n");
> -				goto disable_clk;
> -			}
> -		}
>  
>  		/* select clock source, e.g. 0 for "dfsdm" or 1 for "audio" */
>  		clk_src = priv->aclk ? 1 : 0;
> @@ -123,21 +148,21 @@ int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
>  					 DFSDM_CHCFGR1_CKOUTSRC_MASK,
>  					 DFSDM_CHCFGR1_CKOUTSRC(clk_src));
>  		if (ret < 0)
> -			goto disable_aclk;
> +			goto pm_put;
>  
>  		/* Output the SPI CLKOUT (if clk_div == 0 clock if OFF) */
>  		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
>  					 DFSDM_CHCFGR1_CKOUTDIV_MASK,
>  					 DFSDM_CHCFGR1_CKOUTDIV(clk_div));
>  		if (ret < 0)
> -			goto disable_aclk;
> +			goto pm_put;
>  
>  		/* Global enable of DFSDM interface */
>  		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
>  					 DFSDM_CHCFGR1_DFSDMEN_MASK,
>  					 DFSDM_CHCFGR1_DFSDMEN(1));
>  		if (ret < 0)
> -			goto disable_aclk;
> +			goto pm_put;
>  	}
>  
>  	dev_dbg(dev, "%s: n_active_ch %d\n", __func__,
> @@ -145,11 +170,8 @@ int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
>  
>  	return 0;
>  
> -disable_aclk:
> -	clk_disable_unprepare(priv->aclk);
> -disable_clk:
> -	clk_disable_unprepare(priv->clk);
> -
> +pm_put:
> +	pm_runtime_put_sync(dev);
>  error_ret:
>  	atomic_dec(&priv->n_active_ch);
>  
> @@ -165,7 +187,7 @@ EXPORT_SYMBOL_GPL(stm32_dfsdm_start_dfsdm);
>   */
>  int stm32_dfsdm_stop_dfsdm(struct stm32_dfsdm *dfsdm)
>  {
> -	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
> +	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
>  	int ret;
>  
>  	if (atomic_dec_and_test(&priv->n_active_ch)) {
> @@ -183,9 +205,7 @@ int stm32_dfsdm_stop_dfsdm(struct stm32_dfsdm *dfsdm)
>  		if (ret < 0)
>  			return ret;
>  
> -		clk_disable_unprepare(priv->clk);
> -		if (priv->aclk)
> -			clk_disable_unprepare(priv->aclk);
> +		pm_runtime_put_sync(&priv->pdev->dev);
>  	}
>  	dev_dbg(&priv->pdev->dev, "%s: n_active_ch %d\n", __func__,
>  		atomic_read(&priv->n_active_ch));
> @@ -325,14 +345,111 @@ static int stm32_dfsdm_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, dfsdm);
>  
> -	return devm_of_platform_populate(&pdev->dev);
> +	ret = stm32_dfsdm_clk_prepare_enable(dfsdm);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to start clock\n");
> +		return ret;
> +	}
> +
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> +	if (ret)
> +		goto pm_put;
> +
> +	pm_runtime_put(&pdev->dev);
> +
> +	return 0;
> +
> +pm_put:
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +	stm32_dfsdm_clk_disable_unprepare(dfsdm);
> +
> +	return ret;
> +}
> +
> +static int stm32_dfsdm_core_remove(struct platform_device *pdev)
> +{
> +	struct stm32_dfsdm *dfsdm = platform_get_drvdata(pdev);
> +
> +	pm_runtime_get_sync(&pdev->dev);
> +	of_platform_depopulate(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +	stm32_dfsdm_clk_disable_unprepare(dfsdm);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused stm32_dfsdm_core_suspend(struct device *dev)
> +{
> +	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
> +	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
> +	int ret;
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Balance devm_regmap_init_mmio_clk() clk_prepare() */
> +	clk_unprepare(priv->clk);
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int __maybe_unused stm32_dfsdm_core_resume(struct device *dev)
> +{
> +	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
> +	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
> +	int ret;
> +
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare(priv->clk);
> +	if (ret)
> +		return ret;
> +
> +	return pm_runtime_force_resume(dev);
>  }
>  
> +static int __maybe_unused stm32_dfsdm_core_runtime_suspend(struct device *dev)
> +{
> +	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
> +
> +	stm32_dfsdm_clk_disable_unprepare(dfsdm);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused stm32_dfsdm_core_runtime_resume(struct device *dev)
> +{
> +	struct stm32_dfsdm *dfsdm = dev_get_drvdata(dev);
> +
> +	return stm32_dfsdm_clk_prepare_enable(dfsdm);
> +}
> +
> +static const struct dev_pm_ops stm32_dfsdm_core_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(stm32_dfsdm_core_suspend,
> +				stm32_dfsdm_core_resume)
> +	SET_RUNTIME_PM_OPS(stm32_dfsdm_core_runtime_suspend,
> +			   stm32_dfsdm_core_runtime_resume,
> +			   NULL)
> +};
> +
>  static struct platform_driver stm32_dfsdm_driver = {
>  	.probe = stm32_dfsdm_probe,
> +	.remove = stm32_dfsdm_core_remove,
>  	.driver = {
>  		.name = "stm32-dfsdm",
>  		.of_match_table = stm32_dfsdm_of_match,
> +		.pm = &stm32_dfsdm_core_pm_ops,
>  	},
>  };
>  

