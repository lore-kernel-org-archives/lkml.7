Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8249C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967D42171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553447508;
	bh=2pwaLyhvq9Ly8OkQhK8zpNre3fTo78OavSTVfrY15b8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wTGim4uK0QmoKOxXLxpNYizZ5dYarK/ExCAoSod1yTXlN//22jZ5Bg2DkXVHHpgWY
	 lP63VLkbKslUcsdR921sTd/VZzRZx3H1ijbaeXg/j4u7ZCGKzuiYE16Taf8tOi/zdA
	 OZ27Hl0L3yLB3RP1dsaS6qV2bOT+nvTD6I7Hs20s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfCXRLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 13:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfCXRLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 13:11:47 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4990C2087F;
        Sun, 24 Mar 2019 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553447504;
        bh=2pwaLyhvq9Ly8OkQhK8zpNre3fTo78OavSTVfrY15b8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qCn61dNMYt39269U8dxvpwtGUp/r4GAx76wtzph4X/A5Vxy3pyWeb0UddoqM81hSC
         qc4hDMXi73M5GhgwmgR2NMd/RjjIFX09b86hnHo+lOXsWMkGP8GlsAJQYcfX9BWtbI
         B7QRHXOl0gmfCUcVXa6c2qHgdhMgI6BgPA7/ahYU=
Date:   Sun, 24 Mar 2019 17:11:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH v2 7/8] iio: adc: stm32-dfsdm: add support for buffer
 modes
Message-ID: <20190324171138.1c38f735@archlinux>
In-Reply-To: <1553186849-6261-8-git-send-email-fabrice.gasnier@st.com>
References: <1553186849-6261-1-git-send-email-fabrice.gasnier@st.com>
        <1553186849-6261-8-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 17:47:28 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> DFSDM conversions can be launched continuously, or using various
> triggers:
> - by software
> - hardware triggers (e.g. like in stm32-adc: TIM, LPTIM, EXTI)
> - synchronously with DFSDM filter 0. e.g. for filters 1, 2
> 
> Launching conversions can be done using two methods:
> a - injected:
>     - scan mode can be used to convert several channels each time a
>       trigger occurs.
>     - When not is scan mode, channels are converted in sequence, one upon
>       each trigger.
> b - regular:
>     - supports software triggers or synchronous with filter 0
>     - single or continuous conversions
> 
> This patch finalizes DFSDM operating modes using IIO buffer modes:
> - INDIO_BUFFER_SOFTWARE: regular continuous conversions (no trigger)
>   but limited to 1 channel. Users must set sampling frequency in this case.
>   For filters > 1, conversions can be started synchronously with filter 0.
> - INDIO_BUFFER_TRIGGERED: triggered conversions uses injected mode for
>   launching conversions. DFSDM can use hardware triggers (e.g. STM32 timer
>   or lptimer), so add INDIO_HARDWARE_TRIGGERED to supported modes.
> - INDIO_DIRECT_MODE: Only support DMA-based buffer modes. In case no DMA is
>   available, only support single conversions.
> 
> From userland perspective, to summarize various use cases:
> 1 - single conversion on any filter:
> $ cd iio:deviceX
> $ cat in_voltageY_raw
> This uses regular a conversion (not continuous)
> 
> 2 - Using sampling frequency without trigger (single channel, buffer)
> $ cd iio:deviceX
> $ echo 100 > sampling_frequency
> $ echo "" > trigger/current_trigger
> $ echo 1 > scan_elements/in_voltageY_en
> $ echo 1 > buffer/enable
> This uses regular conversion in continuous mode (Frequency is achieved
> by tuning filter parameters)
> 
> 3 - sync mode with filter 0: other filters can be converted when using
> "st,filter0-sync" dt property. The conversions will get started at the
> same time as filter 0. So for any filters > 1:
> $ cd iio:deviceX
> $ echo 100 > sampling_frequency
> $ echo "" > trigger/current_trigger
> $ echo 1 > scan_elements/in_voltageY_en
> $ echo 1 > buffer/enable
> Then start filter 0 as in 2 above.
> 
> 4 - Using a hardware trigger (with one channel):
> - check trigger, configure it:
> $ cat /sys/bus/iio/devices/trigger1/name
> tim6_trgo
> $ echo 100 > /sys/bus/iio/devices/trigger1/sampling_frequency
> - go to any filter:
> $ echo 1 > scan_elements/in_voltageY_en
> $ echo tim6_trgo > trigger/current_trigger
> $ echo 1 > buffer/enable
> This uses injected conversion as it uses a hardware trigger (without scan)
> 
> 5 - Using a hardware trigger (with 2+ channel):
> Same as in 4/ above, but enable two or more channels in scan_elements.
> This uses injected conversion as it uses a hardware trigger (with scan mode)

Great.  It may well be worth putting this doc somewhere else as well
(assuming it isn't!)  People don't always find the docs hidden in commit
messages ;)

> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied with a minor tweak for a 'false' build warning.  Check I didn't
mess that up!

Thanks,

Jonathan

> ---
> Changes in v2:
> - Update the patch description to better explain working modes and the way
>   to use them from user perspective
> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 218 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 194 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 4ead6bf..51688eb 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -12,6 +12,11 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/hw-consumer.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/timer/stm32-lptim-trigger.h>
> +#include <linux/iio/timer/stm32-timer-trigger.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> @@ -121,6 +126,61 @@ static int stm32_dfsdm_str2val(const char *str,
>  	return -EINVAL;
>  }
>  
> +/**
> + * struct stm32_dfsdm_trig_info - DFSDM trigger info
> + * @name:		name of the trigger, corresponding to its source
> + * @jextsel:		trigger signal selection
> + */
> +struct stm32_dfsdm_trig_info {
> +	const char *name;
> +	unsigned int jextsel;
> +};
> +
> +/* hardware injected trigger enable, edge selection */
> +enum stm32_dfsdm_jexten {
> +	STM32_DFSDM_JEXTEN_DISABLED,
> +	STM32_DFSDM_JEXTEN_RISING_EDGE,
> +	STM32_DFSDM_JEXTEN_FALLING_EDGE,
> +	STM32_DFSDM_EXTEN_BOTH_EDGES,
> +};
> +
> +static const struct stm32_dfsdm_trig_info stm32_dfsdm_trigs[] = {
> +	{ TIM1_TRGO, 0 },
> +	{ TIM1_TRGO2, 1 },
> +	{ TIM8_TRGO, 2 },
> +	{ TIM8_TRGO2, 3 },
> +	{ TIM3_TRGO, 4 },
> +	{ TIM4_TRGO, 5 },
> +	{ TIM16_OC1, 6 },
> +	{ TIM6_TRGO, 7 },
> +	{ TIM7_TRGO, 8 },
> +	{ LPTIM1_OUT, 26 },
> +	{ LPTIM2_OUT, 27 },
> +	{ LPTIM3_OUT, 28 },
> +	{},
> +};
> +
> +static int stm32_dfsdm_get_jextsel(struct iio_dev *indio_dev,
> +				   struct iio_trigger *trig)
> +{
> +	int i;
> +
> +	/* lookup triggers registered by stm32 timer trigger driver */
> +	for (i = 0; stm32_dfsdm_trigs[i].name; i++) {
> +		/**
> +		 * Checking both stm32 timer trigger type and trig name
> +		 * should be safe against arbitrary trigger names.
> +		 */
> +		if ((is_stm32_timer_trigger(trig) ||
> +		     is_stm32_lptim_trigger(trig)) &&
> +		    !strcmp(stm32_dfsdm_trigs[i].name, trig->name)) {
> +			return stm32_dfsdm_trigs[i].jextsel;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int stm32_dfsdm_set_osrs(struct stm32_dfsdm_filter *fl,
>  				unsigned int fast, unsigned int oversamp)
>  {
> @@ -265,7 +325,8 @@ static int stm32_dfsdm_chan_configure(struct stm32_dfsdm *dfsdm,
>  }
>  
>  static int stm32_dfsdm_start_filter(struct stm32_dfsdm_adc *adc,
> -				    unsigned int fl_id)
> +				    unsigned int fl_id,
> +				    struct iio_trigger *trig)
>  {
>  	struct stm32_dfsdm *dfsdm = adc->dfsdm;
>  	int ret;
> @@ -277,7 +338,7 @@ static int stm32_dfsdm_start_filter(struct stm32_dfsdm_adc *adc,
>  		return ret;
>  
>  	/* Nothing more to do for injected (scan mode/triggered) conversions */
> -	if (adc->nconv > 1)
> +	if (adc->nconv > 1 || trig)
>  		return 0;
>  
>  	/* Software start (single or continuous) regular conversion */
> @@ -294,8 +355,38 @@ static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm,
>  			   DFSDM_CR1_DFEN_MASK, DFSDM_CR1_DFEN(0));
>  }
>  
> +static int stm32_dfsdm_filter_set_trig(struct stm32_dfsdm_adc *adc,
> +				       unsigned int fl_id,
> +				       struct iio_trigger *trig)
> +{
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct regmap *regmap = adc->dfsdm->regmap;
> +	u32 jextsel = 0, jexten = STM32_DFSDM_JEXTEN_DISABLED;
> +	int ret;
> +
> +	if (trig) {
> +		ret = stm32_dfsdm_get_jextsel(indio_dev, trig);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* set trigger source and polarity (default to rising edge) */
> +		jextsel = ret;
> +		jexten = STM32_DFSDM_JEXTEN_RISING_EDGE;
> +	}
> +
> +	ret = regmap_update_bits(regmap, DFSDM_CR1(fl_id),
> +				 DFSDM_CR1_JEXTSEL_MASK | DFSDM_CR1_JEXTEN_MASK,
> +				 DFSDM_CR1_JEXTSEL(jextsel) |
> +				 DFSDM_CR1_JEXTEN(jexten));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
> -					unsigned int fl_id)
> +					unsigned int fl_id,
> +					struct iio_trigger *trig)
>  {
>  	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
>  	struct regmap *regmap = adc->dfsdm->regmap;
> @@ -322,6 +413,10 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
>  	if (ret)
>  		return ret;
>  
> +	ret = stm32_dfsdm_filter_set_trig(adc, fl_id, trig);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * DFSDM modes configuration W.R.T audio/iio type modes
>  	 * ----------------------------------------------------------------
> @@ -341,7 +436,7 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
>  	 *               |         |              |          | sync_mode  |
>  	 * ----------------------------------------------------------------
>  	 */
> -	if (adc->nconv == 1) {
> +	if (adc->nconv == 1 && !trig) {
>  		bit = __ffs(adc->smask);
>  		chan = indio_dev->channels + bit;
>  
> @@ -365,13 +460,15 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
>  			return ret;
>  
>  		/* Use scan mode for multiple channels */
> -		cr1 = DFSDM_CR1_JSCAN(1);
> +		cr1 = DFSDM_CR1_JSCAN(!!(adc->nconv > 1));
This is tripping a (false as far as I can see) build warning.
drivers/iio/adc/stm32-dfsdm-adc.c:463:23: warning: dubious: x & !y

I've modified it to a ternary operator rather than the !!

Jonathan
>  
>  		/*
> -		 * Continuous conversions not supported in injected mode:
> -		 * - use conversions in sync with filter 0
> +		 * Continuous conversions not supported in injected mode,
> +		 * either use:
> +		 * - conversions in sync with filter 0
> +		 * - triggered conversions
>  		 */
> -		if (!fl->sync_mode)
> +		if (!fl->sync_mode && !trig)
>  			return -EINVAL;
>  		cr1 |= DFSDM_CR1_JSYNC(fl->sync_mode);
>  	}
> @@ -503,7 +600,8 @@ static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
>  	return len;
>  }
>  
> -static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc)
> +static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
> +				  struct iio_trigger *trig)
>  {
>  	struct regmap *regmap = adc->dfsdm->regmap;
>  	int ret;
> @@ -512,11 +610,11 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = stm32_dfsdm_filter_configure(adc, adc->fl_id);
> +	ret = stm32_dfsdm_filter_configure(adc, adc->fl_id, trig);
>  	if (ret < 0)
>  		goto stop_channels;
>  
> -	ret = stm32_dfsdm_start_filter(adc, adc->fl_id);
> +	ret = stm32_dfsdm_start_filter(adc, adc->fl_id, trig);
>  	if (ret < 0)
>  		goto filter_unconfigure;
>  
> @@ -548,6 +646,7 @@ static int stm32_dfsdm_set_watermark(struct iio_dev *indio_dev,
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>  	unsigned int watermark = DFSDM_DMA_BUFFER_SIZE / 2;
> +	unsigned int rx_buf_sz = DFSDM_DMA_BUFFER_SIZE;
>  
>  	/*
>  	 * DMA cyclic transfers are used, buffer is split into two periods.
> @@ -556,7 +655,7 @@ static int stm32_dfsdm_set_watermark(struct iio_dev *indio_dev,
>  	 * - one buffer (period) driver pushed to ASoC side.
>  	 */
>  	watermark = min(watermark, val * (unsigned int)(sizeof(u32)));
> -	adc->buf_sz = watermark * 2;
> +	adc->buf_sz = min(rx_buf_sz, watermark * 2 * adc->nconv);
>  
>  	return 0;
>  }
> @@ -586,13 +685,41 @@ static unsigned int stm32_dfsdm_adc_dma_residue(struct stm32_dfsdm_adc *adc)
>  	return 0;
>  }
>  
> -static void stm32_dfsdm_audio_dma_buffer_done(void *data)
> +static irqreturn_t stm32_dfsdm_adc_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +	int available = stm32_dfsdm_adc_dma_residue(adc);
> +
> +	while (available >= indio_dev->scan_bytes) {
> +		u32 *buffer = (u32 *)&adc->rx_buf[adc->bufi];
> +
> +		iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +						   pf->timestamp);
> +		available -= indio_dev->scan_bytes;
> +		adc->bufi += indio_dev->scan_bytes;
> +		if (adc->bufi >= adc->buf_sz)
> +			adc->bufi = 0;
> +	}
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void stm32_dfsdm_dma_buffer_done(void *data)
>  {
>  	struct iio_dev *indio_dev = data;
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>  	int available = stm32_dfsdm_adc_dma_residue(adc);
>  	size_t old_pos;
>  
> +	if (indio_dev->currentmode & INDIO_BUFFER_TRIGGERED) {
> +		iio_trigger_poll_chained(indio_dev->trig);
> +		return;
> +	}
> +
>  	/*
>  	 * FIXME: In Kernel interface does not support cyclic DMA buffer,and
>  	 * offers only an interface to push data samples per samples.
> @@ -620,6 +747,9 @@ static void stm32_dfsdm_audio_dma_buffer_done(void *data)
>  			adc->bufi = 0;
>  			old_pos = 0;
>  		}
> +		/* regular iio buffer without trigger */
> +		if (adc->dev_data->type == DFSDM_IIO)
> +			iio_push_to_buffers(indio_dev, buffer);
>  	}
>  	if (adc->cb)
>  		adc->cb(&adc->rx_buf[old_pos], adc->bufi - old_pos,
> @@ -643,7 +773,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>  	dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__,
>  		adc->buf_sz, adc->buf_sz / 2);
>  
> -	if (adc->nconv == 1)
> +	if (adc->nconv == 1 && !indio_dev->trig)
>  		config.src_addr += DFSDM_RDATAR(adc->fl_id);
>  	else
>  		config.src_addr += DFSDM_JDATAR(adc->fl_id);
> @@ -660,7 +790,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>  	if (!desc)
>  		return -EBUSY;
>  
> -	desc->callback = stm32_dfsdm_audio_dma_buffer_done;
> +	desc->callback = stm32_dfsdm_dma_buffer_done;
>  	desc->callback_param = indio_dev;
>  
>  	cookie = dmaengine_submit(desc);
> @@ -671,7 +801,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>  	/* Issue pending DMA requests */
>  	dma_async_issue_pending(adc->dma_chan);
>  
> -	if (adc->nconv == 1) {
> +	if (adc->nconv == 1 && !indio_dev->trig) {
>  		/* Enable regular DMA transfer*/
>  		ret = regmap_update_bits(adc->dfsdm->regmap,
>  					 DFSDM_CR1(adc->fl_id),
> @@ -726,13 +856,19 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>  	int ret;
>  
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +		ret = iio_triggered_buffer_postenable(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	/* Reset adc buffer index */
>  	adc->bufi = 0;
>  
>  	if (adc->hwc) {
>  		ret = iio_hw_consumer_enable(adc->hwc);
>  		if (ret < 0)
> -			return ret;
> +			goto err_predisable;
>  	}
>  
>  	ret = stm32_dfsdm_start_dfsdm(adc->dfsdm);
> @@ -745,7 +881,7 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  		goto stop_dfsdm;
>  	}
>  
> -	ret = stm32_dfsdm_start_conv(adc);
> +	ret = stm32_dfsdm_start_conv(adc, indio_dev->trig);
>  	if (ret) {
>  		dev_err(&indio_dev->dev, "Can't start conversion\n");
>  		goto err_stop_dma;
> @@ -760,6 +896,9 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>  err_stop_hwc:
>  	if (adc->hwc)
>  		iio_hw_consumer_disable(adc->hwc);
> +err_predisable:
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> +		iio_triggered_buffer_predisable(indio_dev);
>  
>  	return ret;
>  }
> @@ -777,6 +916,9 @@ static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
>  	if (adc->hwc)
>  		iio_hw_consumer_disable(adc->hwc);
>  
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> +		iio_triggered_buffer_predisable(indio_dev);
> +
>  	return 0;
>  }
>  
> @@ -856,7 +998,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
>  
>  	adc->nconv = 1;
>  	adc->smask = BIT(chan->scan_index);
> -	ret = stm32_dfsdm_start_conv(adc);
> +	ret = stm32_dfsdm_start_conv(adc, NULL);
>  	if (ret < 0) {
>  		regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
>  				   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));
> @@ -978,6 +1120,12 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int stm32_dfsdm_validate_trigger(struct iio_dev *indio_dev,
> +					struct iio_trigger *trig)
> +{
> +	return stm32_dfsdm_get_jextsel(indio_dev, trig) < 0 ? -EINVAL : 0;
> +}
> +
>  static const struct iio_info stm32_dfsdm_info_audio = {
>  	.hwfifo_set_watermark = stm32_dfsdm_set_watermark,
>  	.read_raw = stm32_dfsdm_read_raw,
> @@ -986,9 +1134,11 @@ static const struct iio_info stm32_dfsdm_info_audio = {
>  };
>  
>  static const struct iio_info stm32_dfsdm_info_adc = {
> +	.hwfifo_set_watermark = stm32_dfsdm_set_watermark,
>  	.read_raw = stm32_dfsdm_read_raw,
>  	.write_raw = stm32_dfsdm_write_raw,
>  	.update_scan_mode = stm32_dfsdm_update_scan_mode,
> +	.validate_trigger = stm32_dfsdm_validate_trigger,
>  };
>  
>  static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
> @@ -1061,6 +1211,9 @@ static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
>  		return -ENOMEM;
>  	}
>  
> +	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
> +	indio_dev->setup_ops = &stm32_dfsdm_buffer_setup_ops;
> +
>  	return 0;
>  }
>  
> @@ -1082,7 +1235,8 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
>  	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
>  	 */
>  	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> -	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> +	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
> +					BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  
>  	if (adc->dev_data->type == DFSDM_AUDIO) {
>  		ch->scan_type.sign = 's';
> @@ -1104,9 +1258,6 @@ static int stm32_dfsdm_audio_init(struct iio_dev *indio_dev)
>  	struct stm32_dfsdm_channel *d_ch;
>  	int ret;
>  
> -	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
> -	indio_dev->setup_ops = &stm32_dfsdm_buffer_setup_ops;
> -
>  	ch = devm_kzalloc(&indio_dev->dev, sizeof(*ch), GFP_KERNEL);
>  	if (!ch)
>  		return -ENOMEM;
> @@ -1174,6 +1325,25 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>  
>  	init_completion(&adc->completion);
>  
> +	/* Optionally request DMA */
> +	if (stm32_dfsdm_dma_request(indio_dev)) {
> +		dev_dbg(&indio_dev->dev, "No DMA support\n");
> +		return 0;
> +	}
> +
> +	ret = iio_triggered_buffer_setup(indio_dev,
> +					 &iio_pollfunc_store_time,
> +					 &stm32_dfsdm_adc_trigger_handler,
> +					 &stm32_dfsdm_buffer_setup_ops);
> +	if (ret) {
> +		stm32_dfsdm_dma_release(indio_dev);
> +		dev_err(&indio_dev->dev, "buffer setup failed\n");
> +		return ret;
> +	}
> +
> +	/* lptimer/timer hardware triggers */
> +	indio_dev->modes |= INDIO_HARDWARE_TRIGGERED;
> +
>  	return 0;
>  }
>  
> @@ -1221,7 +1391,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>  
>  	iio->dev.parent = dev;
>  	iio->dev.of_node = np;
> -	iio->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	iio->modes = INDIO_DIRECT_MODE;
>  
>  	platform_set_drvdata(pdev, adc);
>  

