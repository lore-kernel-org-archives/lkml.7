Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B564BC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75606218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553963937;
	bh=eIwMCkte6gzrexpzbDmGnJryf0Ol6UdikR4cKIE0MJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=egdfsEfzOBiqfPYysodeWr8y2forPct40Zh+wM8FLWa2FygHpRTY7tr8+cYzPakwx
	 DIT3RSu6BsIbdMAgHyhIwCvqTovyvN5y581FjAMpBWNo7RR/9X5hZ+CKQG8lDbwNzi
	 RpBsmBUPN6+qZU1gYoMRCqENmKUqemLr85VkQgz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfC3Qi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbfC3Qiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:38:55 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76168218CD;
        Sat, 30 Mar 2019 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553963934;
        bh=eIwMCkte6gzrexpzbDmGnJryf0Ol6UdikR4cKIE0MJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qciOQFvxrE9mrBf5PdGnIIzY4A6Rlzha2Zkwhk9gKCcYL+KNE5hvGDQIblrSowdK2
         vpFkspMnxosmM1fLqQr4wWtzsYrvgtlxOW2cOuX9elEalPlikVnstl0qzZqrmmKc5j
         sS/wiWKgEJlGfi0o1fHO3Jma2hz231lz1m5x3r7g=
Date:   Sat, 30 Mar 2019 16:38:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32: fix sleep inside atomic section when
 using DMA
Message-ID: <20190330163849.0b2db557@archlinux>
In-Reply-To: <1553604244-10922-1-git-send-email-fabrice.gasnier@st.com>
References: <1553604244-10922-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 13:44:04 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Enabling CONFIG_DEBUG_ATOMIC_SLEEP=y triggers this BUG message:
> BUG: sleeping function called from invalid context at kernel/irq/chip.c...
> 
> Call stack is as follows:
> - __might_sleep
> - handle_nested_irq          <-- Expects threaded irq
> - iio_trigger_poll_chained
> - stm32_adc_dma_buffer_done
> - vchan_complete
> - tasklet_action_common
> - tasklet_action
> - __do_softirq               <-- DMA completion raises a tasklet
> - irq_exit
> - __handle_domain_irq        <-- DMA IRQ
> - gic_handle_irq
> 
> IIO expects threaded interrupt context when calling:
> - iio_trigger_poll_chained()
> Or it expects interrupt context when calling:
> - iio_trigger_poll()
> 
> This patch triggers an IRQ upon stm32_adc_dma_buffer_done() DMA callback
> call, so the IIO trigger poll API gets called from IRQ context.
> 
> Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

An irq_work is a very heavy weight solution.

Perhaps we need a iio_trigger_poll* that can be called from a tasklet?
Or indeed a generic irq function that can be.

Hmm.  This isn't actually a 'real' trigger (I think) anyway as it's
only ever calling it's own irq thread.  In this case we could just
bypass and call that function directly.

Sometimes the trigger infrastructure of IIO is just not suited to
how a particular device works!

We need to maintain the trigger infrastructure for it's ability to
select the trigger, but not necessarily push the data through it.

So I think it would be safe to just call the block for dma_chan
being set in _adc_trigger_handler directly. 

If you take this approach, make sure there are comments saying why.
I don't want people to cut and paste it into new driver unless they
understand the reasoning!

We have had drivers do this in the past, though I can't find one
right now (am335x used to do this for example, but got reworked
to suport the touchscreen at the same time and this path went
away).

Jonathan

> ---
>  drivers/iio/adc/Kconfig     |  1 +
>  drivers/iio/adc/stm32-adc.c | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 76db6e5..059407a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -775,6 +775,7 @@ config STM32_ADC_CORE
>  	select MFD_STM32_TIMERS
>  	select IIO_STM32_TIMER_TRIGGER
>  	select IIO_TRIGGERED_BUFFER
> +	select IRQ_WORK
>  	help
>  	  Select this option to enable the core driver for STMicroelectronics
>  	  STM32 analog-to-digital converter (ADC).
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 205e169..1aa3189 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -20,6 +20,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> +#include <linux/irq_work.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> @@ -297,6 +298,7 @@ struct stm32_adc_cfg {
>   * @smpr_val:		sampling time settings (e.g. smpr1 / smpr2)
>   * @cal:		optional calibration data on some devices
>   * @chan_name:		channel name array
> + * @work:		irq work used to call trigger poll routine
>   */
>  struct stm32_adc {
>  	struct stm32_adc_common	*common;
> @@ -320,6 +322,7 @@ struct stm32_adc {
>  	u32			smpr_val[2];
>  	struct stm32_adc_calib	cal;
>  	char			chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
> +	struct irq_work		work;
>  };
>  
>  struct stm32_adc_diff_channel {
> @@ -1473,11 +1476,32 @@ static unsigned int stm32_adc_dma_residue(struct stm32_adc *adc)
>  	return 0;
>  }
>  
> +static void stm32_adc_dma_irq_work(struct irq_work *work)
> +{
> +	struct stm32_adc *adc = container_of(work, struct stm32_adc, work);
> +	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +
> +	/*
> +	 * iio_trigger_poll calls generic_handle_irq(). So, it requires hard
> +	 * irq context, and cannot be called directly from dma callback,
> +	 * dma cb has to schedule this work instead.
> +	 */
> +	iio_trigger_poll(indio_dev->trig);
> +}
> +
>  static void stm32_adc_dma_buffer_done(void *data)
>  {
>  	struct iio_dev *indio_dev = data;
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  
> -	iio_trigger_poll_chained(indio_dev->trig);
> +	/*
> +	 * Invoques iio_trigger_poll() from hard irq context: We can't
> +	 * call iio_trigger_poll() nor iio_trigger_poll_chained()
> +	 * directly from DMA callback (under tasklet e.g. softirq).
> +	 * They require respectively HW IRQ and threaded IRQ context
> +	 * as it might sleep.
> +	 */
> +	irq_work_queue(&adc->work);
>  }
>  
>  static int stm32_adc_dma_start(struct iio_dev *indio_dev)
> @@ -1585,8 +1609,10 @@ static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>  	if (!adc->dma_chan)
>  		stm32_adc_conv_irq_disable(adc);
>  
> -	if (adc->dma_chan)
> +	if (adc->dma_chan) {
>  		dmaengine_terminate_all(adc->dma_chan);
> +		irq_work_sync(&adc->work);
> +	}
>  
>  	if (stm32_adc_set_trig(indio_dev, NULL))
>  		dev_err(&indio_dev->dev, "Can't clear trigger\n");
> @@ -1872,6 +1898,8 @@ static int stm32_adc_dma_request(struct iio_dev *indio_dev)
>  	if (ret)
>  		goto err_free;
>  
> +	init_irq_work(&adc->work, stm32_adc_dma_irq_work);
> +
>  	return 0;
>  
>  err_free:

