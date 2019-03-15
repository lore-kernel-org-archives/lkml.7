Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF546C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A64218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfCOSC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:02:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9275 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbfCOSC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:02:28 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2FHq8Up029110;
        Fri, 15 Mar 2019 19:01:51 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2r8dmn92xx-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 15 Mar 2019 19:01:51 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F8EF31;
        Fri, 15 Mar 2019 18:01:49 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2DC895859;
        Fri, 15 Mar 2019 18:01:49 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Mar
 2019 19:01:48 +0100
Subject: Re: [PATCH 7/8] iio: adc: stm32-dfsdm: add support for buffer modes
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
References: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
 <1551862524-25098-8-git-send-email-fabrice.gasnier@st.com>
 <20190310102114.0c1e7bd8@archlinux>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <d2463873-fd8c-7c74-80d5-b7685772d84c@st.com>
Date:   Fri, 15 Mar 2019 19:01:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190310102114.0c1e7bd8@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-15_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/19 11:21 AM, Jonathan Cameron wrote:
> On Wed, 6 Mar 2019 09:55:23 +0100
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
>> DFSDM can operate using these buffer modes:
>> - INDIO_BUFFER_SOFTWARE: regular continuous conversions (no trigger)
>>   but limited to 1 channel. User can set sampling frequency in this case.
>> - INDIO_BUFFER_TRIGGERED: triggered conversions (injected with or without
>>   scan mode, resp for one or more channels).
>>
>> DFSDM can use hardware triggers (e.g. STM32 timer/lptimer), add
>> INDIO_HARDWARE_TRIGGERED to supported modes.
>>
>> Only support DMA-based buffer modes. In case no DMA is available, only
>> support INDIO_DIRECT_MODE.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> Hi Fabrice,
> 
> I'll confess to being thoroughly confused by the many options this hardware
> supports!  If you wouldn't mind, could you enumerate all the possible trigger
> and mode combinations.  Even better if it includes the userspace
> configuration that would be needed to get into a given mode.
> 

Hi Jonathan,

Many thanks for reviewing.
I understand... I hope I can clarify it, and give an overview.
Basically, conversions can be launched continuously, or using various
triggers:
- by software
- hardware triggers (e.g. like in stm32-adc: TIM, LPTIM, EXTI)
- synchronously with DFSDM filter 0. e.g. for filters 1, 2... (Maybe
DFSDM filter 0 should be represented as trigger as well ?) I think it's
been originally added as dt property for the audio needs.

Launching conversions can be done using two methods:
a - injected
  - scan mode can be used to convert several channels each time a
    trigger occurs.
    When not is scan mode, channels are converted in sequence, one upon
    each trigger.
  - supports all triggers (software, hardware or synchronously...)
  - no continuous conversions

b - regular
  - supports: software triggers or synchronous with filter 0
  - single or continuous conversions

If you like to go further in details on theses modes, there are details
in several STM32 Ref manual (like RM0433 or RM0436 resp for STM32H743 or
STM32MP157). This is documented under DFSDM section "Launching conversions".

> There is some info in the previous patch, but I'm looking for more detail,
> particularly around available triggers.

From userland perspective, I'll try to summarize the various
possibilities, that matches the array documented in previous patch:

1 - single conversion:
$ cd iio:deviceX # go to any filter
$ cat in_voltageY_raw
This uses regular conversion (not continuous)

2 - Using sampling frequency (single channel, buffer)
$ echo 100 > sampling_frequency
$ echo 1 > scan_elements/in_voltageY_en
$ echo 1 > buffer/enable
This uses regular conversion in continuous mode (Frequency is achieved
by tuning filter parameters)

3 - sync mode with filter 0 (for filter 1..5):
Basically, filter 0 is configured as in 2 above.
Then other filters (e.g. 1 to 5 on stm32mp157) can be converted
synchronously. This currently uses st,filter0-sync dt property.
$ cd iio:deviceX # go to any filter 1..5
$ echo 1 > scan_elements/in_voltageY_en
$ echo 1 > buffer/enable
This uses regular conversion, in sync with filter 0.

4 - Using a hardware trigger (with one channel):
# check trigger, configure it
$ cat /sys/bus/iio/devices/trigger1/name
tim6_trgo
$ echo 100 > /sys/bus/iio/devices/trigger1/sampling_frequency
$ cd iio:deviceX                         # go to any filter
$ echo 1 > scan_elements/in_voltageY_en
$ echo tim6_trgo > trigger/current_trigger
$ echo 1 > buffer/enable
This basically uses injected conversion as it uses a hardware trigger
(without scan)

5 - Using a hardware trigger (with 2+ channel):
Same as in 4/ above, but enable two or more channels in scan_elements.
This basically uses injected conversion as it uses a hardware trigger
(with scan mode)

6 - In use case 4/ and 5/ above, it could be conversions on filter 1..5
in sync with filter 0. In this case, dt property must be set currently.
No need to set trigger.

I hope it answers some of your questions,
Please let me know if/how I should improve the documented modes in
previous patch ?

Best regards,
Fabrice

> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/adc/stm32-dfsdm-adc.c | 218 +++++++++++++++++++++++++++++++++-----
>>  1 file changed, 194 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
>> index 4ead6bf..51688eb 100644
>> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
>> @@ -12,6 +12,11 @@
>>  #include <linux/iio/buffer.h>
>>  #include <linux/iio/hw-consumer.h>
>>  #include <linux/iio/sysfs.h>
>> +#include <linux/iio/timer/stm32-lptim-trigger.h>
>> +#include <linux/iio/timer/stm32-timer-trigger.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>> @@ -121,6 +126,61 @@ static int stm32_dfsdm_str2val(const char *str,
>>  	return -EINVAL;
>>  }
>>  
>> +/**
>> + * struct stm32_dfsdm_trig_info - DFSDM trigger info
>> + * @name:		name of the trigger, corresponding to its source
>> + * @jextsel:		trigger signal selection
>> + */
>> +struct stm32_dfsdm_trig_info {
>> +	const char *name;
>> +	unsigned int jextsel;
>> +};
>> +
>> +/* hardware injected trigger enable, edge selection */
>> +enum stm32_dfsdm_jexten {
>> +	STM32_DFSDM_JEXTEN_DISABLED,
>> +	STM32_DFSDM_JEXTEN_RISING_EDGE,
>> +	STM32_DFSDM_JEXTEN_FALLING_EDGE,
>> +	STM32_DFSDM_EXTEN_BOTH_EDGES,
>> +};
>> +
>> +static const struct stm32_dfsdm_trig_info stm32_dfsdm_trigs[] = {
>> +	{ TIM1_TRGO, 0 },
>> +	{ TIM1_TRGO2, 1 },
>> +	{ TIM8_TRGO, 2 },
>> +	{ TIM8_TRGO2, 3 },
>> +	{ TIM3_TRGO, 4 },
>> +	{ TIM4_TRGO, 5 },
>> +	{ TIM16_OC1, 6 },
>> +	{ TIM6_TRGO, 7 },
>> +	{ TIM7_TRGO, 8 },
>> +	{ LPTIM1_OUT, 26 },
>> +	{ LPTIM2_OUT, 27 },
>> +	{ LPTIM3_OUT, 28 },
>> +	{},
>> +};
>> +
>> +static int stm32_dfsdm_get_jextsel(struct iio_dev *indio_dev,
>> +				   struct iio_trigger *trig)
>> +{
>> +	int i;
>> +
>> +	/* lookup triggers registered by stm32 timer trigger driver */
>> +	for (i = 0; stm32_dfsdm_trigs[i].name; i++) {
>> +		/**
>> +		 * Checking both stm32 timer trigger type and trig name
>> +		 * should be safe against arbitrary trigger names.
>> +		 */
>> +		if ((is_stm32_timer_trigger(trig) ||
>> +		     is_stm32_lptim_trigger(trig)) &&
>> +		    !strcmp(stm32_dfsdm_trigs[i].name, trig->name)) {
>> +			return stm32_dfsdm_trigs[i].jextsel;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>>  static int stm32_dfsdm_set_osrs(struct stm32_dfsdm_filter *fl,
>>  				unsigned int fast, unsigned int oversamp)
>>  {
>> @@ -265,7 +325,8 @@ static int stm32_dfsdm_chan_configure(struct stm32_dfsdm *dfsdm,
>>  }
>>  
>>  static int stm32_dfsdm_start_filter(struct stm32_dfsdm_adc *adc,
>> -				    unsigned int fl_id)
>> +				    unsigned int fl_id,
>> +				    struct iio_trigger *trig)
>>  {
>>  	struct stm32_dfsdm *dfsdm = adc->dfsdm;
>>  	int ret;
>> @@ -277,7 +338,7 @@ static int stm32_dfsdm_start_filter(struct stm32_dfsdm_adc *adc,
>>  		return ret;
>>  
>>  	/* Nothing more to do for injected (scan mode/triggered) conversions */
>> -	if (adc->nconv > 1)
>> +	if (adc->nconv > 1 || trig)
>>  		return 0;
>>  
>>  	/* Software start (single or continuous) regular conversion */
>> @@ -294,8 +355,38 @@ static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm,
>>  			   DFSDM_CR1_DFEN_MASK, DFSDM_CR1_DFEN(0));
>>  }
>>  
>> +static int stm32_dfsdm_filter_set_trig(struct stm32_dfsdm_adc *adc,
>> +				       unsigned int fl_id,
>> +				       struct iio_trigger *trig)
>> +{
>> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
>> +	struct regmap *regmap = adc->dfsdm->regmap;
>> +	u32 jextsel = 0, jexten = STM32_DFSDM_JEXTEN_DISABLED;
>> +	int ret;
>> +
>> +	if (trig) {
>> +		ret = stm32_dfsdm_get_jextsel(indio_dev, trig);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		/* set trigger source and polarity (default to rising edge) */
>> +		jextsel = ret;
>> +		jexten = STM32_DFSDM_JEXTEN_RISING_EDGE;
>> +	}
>> +
>> +	ret = regmap_update_bits(regmap, DFSDM_CR1(fl_id),
>> +				 DFSDM_CR1_JEXTSEL_MASK | DFSDM_CR1_JEXTEN_MASK,
>> +				 DFSDM_CR1_JEXTSEL(jextsel) |
>> +				 DFSDM_CR1_JEXTEN(jexten));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>>  static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
>> -					unsigned int fl_id)
>> +					unsigned int fl_id,
>> +					struct iio_trigger *trig)
>>  {
>>  	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
>>  	struct regmap *regmap = adc->dfsdm->regmap;
>> @@ -322,6 +413,10 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
>>  	if (ret)
>>  		return ret;
>>  
>> +	ret = stm32_dfsdm_filter_set_trig(adc, fl_id, trig);
>> +	if (ret)
>> +		return ret;
>> +
>>  	/*
>>  	 * DFSDM modes configuration W.R.T audio/iio type modes
>>  	 * ----------------------------------------------------------------
>> @@ -341,7 +436,7 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
>>  	 *               |         |              |          | sync_mode  |
>>  	 * ----------------------------------------------------------------
>>  	 */
>> -	if (adc->nconv == 1) {
>> +	if (adc->nconv == 1 && !trig) {
>>  		bit = __ffs(adc->smask);
>>  		chan = indio_dev->channels + bit;
>>  
>> @@ -365,13 +460,15 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm_adc *adc,
>>  			return ret;
>>  
>>  		/* Use scan mode for multiple channels */
>> -		cr1 = DFSDM_CR1_JSCAN(1);
>> +		cr1 = DFSDM_CR1_JSCAN(!!(adc->nconv > 1));
>>  
>>  		/*
>> -		 * Continuous conversions not supported in injected mode:
>> -		 * - use conversions in sync with filter 0
>> +		 * Continuous conversions not supported in injected mode,
>> +		 * either use:
>> +		 * - conversions in sync with filter 0
>> +		 * - triggered conversions
>>  		 */
>> -		if (!fl->sync_mode)
>> +		if (!fl->sync_mode && !trig)
>>  			return -EINVAL;
>>  		cr1 |= DFSDM_CR1_JSYNC(fl->sync_mode);
>>  	}
>> @@ -503,7 +600,8 @@ static ssize_t dfsdm_adc_audio_set_spiclk(struct iio_dev *indio_dev,
>>  	return len;
>>  }
>>  
>> -static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc)
>> +static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc,
>> +				  struct iio_trigger *trig)
>>  {
>>  	struct regmap *regmap = adc->dfsdm->regmap;
>>  	int ret;
>> @@ -512,11 +610,11 @@ static int stm32_dfsdm_start_conv(struct stm32_dfsdm_adc *adc)
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	ret = stm32_dfsdm_filter_configure(adc, adc->fl_id);
>> +	ret = stm32_dfsdm_filter_configure(adc, adc->fl_id, trig);
>>  	if (ret < 0)
>>  		goto stop_channels;
>>  
>> -	ret = stm32_dfsdm_start_filter(adc, adc->fl_id);
>> +	ret = stm32_dfsdm_start_filter(adc, adc->fl_id, trig);
>>  	if (ret < 0)
>>  		goto filter_unconfigure;
>>  
>> @@ -548,6 +646,7 @@ static int stm32_dfsdm_set_watermark(struct iio_dev *indio_dev,
>>  {
>>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>  	unsigned int watermark = DFSDM_DMA_BUFFER_SIZE / 2;
>> +	unsigned int rx_buf_sz = DFSDM_DMA_BUFFER_SIZE;
>>  
>>  	/*
>>  	 * DMA cyclic transfers are used, buffer is split into two periods.
>> @@ -556,7 +655,7 @@ static int stm32_dfsdm_set_watermark(struct iio_dev *indio_dev,
>>  	 * - one buffer (period) driver pushed to ASoC side.
>>  	 */
>>  	watermark = min(watermark, val * (unsigned int)(sizeof(u32)));
>> -	adc->buf_sz = watermark * 2;
>> +	adc->buf_sz = min(rx_buf_sz, watermark * 2 * adc->nconv);
>>  
>>  	return 0;
>>  }
>> @@ -586,13 +685,41 @@ static unsigned int stm32_dfsdm_adc_dma_residue(struct stm32_dfsdm_adc *adc)
>>  	return 0;
>>  }
>>  
>> -static void stm32_dfsdm_audio_dma_buffer_done(void *data)
>> +static irqreturn_t stm32_dfsdm_adc_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>> +	int available = stm32_dfsdm_adc_dma_residue(adc);
>> +
>> +	while (available >= indio_dev->scan_bytes) {
>> +		u32 *buffer = (u32 *)&adc->rx_buf[adc->bufi];
>> +
>> +		iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>> +						   pf->timestamp);
>> +		available -= indio_dev->scan_bytes;
>> +		adc->bufi += indio_dev->scan_bytes;
>> +		if (adc->bufi >= adc->buf_sz)
>> +			adc->bufi = 0;
>> +	}
>> +
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void stm32_dfsdm_dma_buffer_done(void *data)
>>  {
>>  	struct iio_dev *indio_dev = data;
>>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>  	int available = stm32_dfsdm_adc_dma_residue(adc);
>>  	size_t old_pos;
>>  
>> +	if (indio_dev->currentmode & INDIO_BUFFER_TRIGGERED) {
>> +		iio_trigger_poll_chained(indio_dev->trig);
>> +		return;
>> +	}
>> +
>>  	/*
>>  	 * FIXME: In Kernel interface does not support cyclic DMA buffer,and
>>  	 * offers only an interface to push data samples per samples.
>> @@ -620,6 +747,9 @@ static void stm32_dfsdm_audio_dma_buffer_done(void *data)
>>  			adc->bufi = 0;
>>  			old_pos = 0;
>>  		}
>> +		/* regular iio buffer without trigger */
>> +		if (adc->dev_data->type == DFSDM_IIO)
>> +			iio_push_to_buffers(indio_dev, buffer);
>>  	}
>>  	if (adc->cb)
>>  		adc->cb(&adc->rx_buf[old_pos], adc->bufi - old_pos,
>> @@ -643,7 +773,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>>  	dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__,
>>  		adc->buf_sz, adc->buf_sz / 2);
>>  
>> -	if (adc->nconv == 1)
>> +	if (adc->nconv == 1 && !indio_dev->trig)
>>  		config.src_addr += DFSDM_RDATAR(adc->fl_id);
>>  	else
>>  		config.src_addr += DFSDM_JDATAR(adc->fl_id);
>> @@ -660,7 +790,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>>  	if (!desc)
>>  		return -EBUSY;
>>  
>> -	desc->callback = stm32_dfsdm_audio_dma_buffer_done;
>> +	desc->callback = stm32_dfsdm_dma_buffer_done;
>>  	desc->callback_param = indio_dev;
>>  
>>  	cookie = dmaengine_submit(desc);
>> @@ -671,7 +801,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>>  	/* Issue pending DMA requests */
>>  	dma_async_issue_pending(adc->dma_chan);
>>  
>> -	if (adc->nconv == 1) {
>> +	if (adc->nconv == 1 && !indio_dev->trig) {
>>  		/* Enable regular DMA transfer*/
>>  		ret = regmap_update_bits(adc->dfsdm->regmap,
>>  					 DFSDM_CR1(adc->fl_id),
>> @@ -726,13 +856,19 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>  	int ret;
>>  
>> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
>> +		ret = iio_triggered_buffer_postenable(indio_dev);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>>  	/* Reset adc buffer index */
>>  	adc->bufi = 0;
>>  
>>  	if (adc->hwc) {
>>  		ret = iio_hw_consumer_enable(adc->hwc);
>>  		if (ret < 0)
>> -			return ret;
>> +			goto err_predisable;
>>  	}
>>  
>>  	ret = stm32_dfsdm_start_dfsdm(adc->dfsdm);
>> @@ -745,7 +881,7 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>>  		goto stop_dfsdm;
>>  	}
>>  
>> -	ret = stm32_dfsdm_start_conv(adc);
>> +	ret = stm32_dfsdm_start_conv(adc, indio_dev->trig);
>>  	if (ret) {
>>  		dev_err(&indio_dev->dev, "Can't start conversion\n");
>>  		goto err_stop_dma;
>> @@ -760,6 +896,9 @@ static int stm32_dfsdm_postenable(struct iio_dev *indio_dev)
>>  err_stop_hwc:
>>  	if (adc->hwc)
>>  		iio_hw_consumer_disable(adc->hwc);
>> +err_predisable:
>> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
>> +		iio_triggered_buffer_predisable(indio_dev);
>>  
>>  	return ret;
>>  }
>> @@ -777,6 +916,9 @@ static int stm32_dfsdm_predisable(struct iio_dev *indio_dev)
>>  	if (adc->hwc)
>>  		iio_hw_consumer_disable(adc->hwc);
>>  
>> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
>> +		iio_triggered_buffer_predisable(indio_dev);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -856,7 +998,7 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
>>  
>>  	adc->nconv = 1;
>>  	adc->smask = BIT(chan->scan_index);
>> -	ret = stm32_dfsdm_start_conv(adc);
>> +	ret = stm32_dfsdm_start_conv(adc, NULL);
>>  	if (ret < 0) {
>>  		regmap_update_bits(adc->dfsdm->regmap, DFSDM_CR2(adc->fl_id),
>>  				   DFSDM_CR2_REOCIE_MASK, DFSDM_CR2_REOCIE(0));
>> @@ -978,6 +1120,12 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>>  	return -EINVAL;
>>  }
>>  
>> +static int stm32_dfsdm_validate_trigger(struct iio_dev *indio_dev,
>> +					struct iio_trigger *trig)
>> +{
>> +	return stm32_dfsdm_get_jextsel(indio_dev, trig) < 0 ? -EINVAL : 0;
>> +}
>> +
>>  static const struct iio_info stm32_dfsdm_info_audio = {
>>  	.hwfifo_set_watermark = stm32_dfsdm_set_watermark,
>>  	.read_raw = stm32_dfsdm_read_raw,
>> @@ -986,9 +1134,11 @@ static const struct iio_info stm32_dfsdm_info_audio = {
>>  };
>>  
>>  static const struct iio_info stm32_dfsdm_info_adc = {
>> +	.hwfifo_set_watermark = stm32_dfsdm_set_watermark,
>>  	.read_raw = stm32_dfsdm_read_raw,
>>  	.write_raw = stm32_dfsdm_write_raw,
>>  	.update_scan_mode = stm32_dfsdm_update_scan_mode,
>> +	.validate_trigger = stm32_dfsdm_validate_trigger,
>>  };
>>  
>>  static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
>> @@ -1061,6 +1211,9 @@ static int stm32_dfsdm_dma_request(struct iio_dev *indio_dev)
>>  		return -ENOMEM;
>>  	}
>>  
>> +	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
>> +	indio_dev->setup_ops = &stm32_dfsdm_buffer_setup_ops;
>> +
>>  	return 0;
>>  }
>>  
>> @@ -1082,7 +1235,8 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
>>  	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
>>  	 */
>>  	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>> -	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
>> +	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
>> +					BIT(IIO_CHAN_INFO_SAMP_FREQ);
>>  
>>  	if (adc->dev_data->type == DFSDM_AUDIO) {
>>  		ch->scan_type.sign = 's';
>> @@ -1104,9 +1258,6 @@ static int stm32_dfsdm_audio_init(struct iio_dev *indio_dev)
>>  	struct stm32_dfsdm_channel *d_ch;
>>  	int ret;
>>  
>> -	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
>> -	indio_dev->setup_ops = &stm32_dfsdm_buffer_setup_ops;
>> -
>>  	ch = devm_kzalloc(&indio_dev->dev, sizeof(*ch), GFP_KERNEL);
>>  	if (!ch)
>>  		return -ENOMEM;
>> @@ -1174,6 +1325,25 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>>  
>>  	init_completion(&adc->completion);
>>  
>> +	/* Optionally request DMA */
>> +	if (stm32_dfsdm_dma_request(indio_dev)) {
>> +		dev_dbg(&indio_dev->dev, "No DMA support\n");
>> +		return 0;
>> +	}
>> +
>> +	ret = iio_triggered_buffer_setup(indio_dev,
>> +					 &iio_pollfunc_store_time,
>> +					 &stm32_dfsdm_adc_trigger_handler,
>> +					 &stm32_dfsdm_buffer_setup_ops);
>> +	if (ret) {
>> +		stm32_dfsdm_dma_release(indio_dev);
>> +		dev_err(&indio_dev->dev, "buffer setup failed\n");
>> +		return ret;
>> +	}
>> +
>> +	/* lptimer/timer hardware triggers */
>> +	indio_dev->modes |= INDIO_HARDWARE_TRIGGERED;
>> +
>>  	return 0;
>>  }
>>  
>> @@ -1221,7 +1391,7 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>>  
>>  	iio->dev.parent = dev;
>>  	iio->dev.of_node = np;
>> -	iio->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
>> +	iio->modes = INDIO_DIRECT_MODE;
>>  
>>  	platform_set_drvdata(pdev, adc);
>>  
> 
