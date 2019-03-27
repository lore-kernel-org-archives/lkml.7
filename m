Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7405C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0E62146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h8wUwU5Z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KWC/k5gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfC0NXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:23:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52320 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfC0NXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:23:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC09861B34; Wed, 27 Mar 2019 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553692998;
        bh=rCR6+s8SzqgeHSc//2hpy+c1xn1v/3RjGQRvp9xWv64=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=h8wUwU5ZjCPPGTNlPbdaGZEsZO/2/EnkU3px10ntzclnJJcXKFr/D7FzAuPSNCMpm
         JGdsNFQ7PeW1wVn6x4SZZrAMbTfsgjDGzgsdsL3I0ucpHMLcm7Zp5bVqpOwUBYAQGj
         UuogjBiTS2UQGaUucW20Jpuzgc+FnI/qoMej3qqk=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8105661B15;
        Wed, 27 Mar 2019 13:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553692983;
        bh=rCR6+s8SzqgeHSc//2hpy+c1xn1v/3RjGQRvp9xWv64=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=KWC/k5gtP8jmaJKWRThICB1DzNytYrag9w6fp8I36fL+HLsYN2Nik0iqwFVJwBsgX
         CXLRBD/kl1SnCLNht3iLgLR9uumcaVLSaDDUV/BL3DDiYGlbQVJxlwviqEh9q6Iyzw
         2qd3E3seopy3lU8DpYsVIFV5IMFLgP5nWykZecRY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8105661B15
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] iio: adc: stm32: fix sleep inside atomic section when
 using DMA
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, jic23@kernel.org
Cc:     lars@metafoo.de, alexandre.torgue@st.com,
        linux-iio@vger.kernel.org, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
        knaack.h@gmx.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <1553604244-10922-1-git-send-email-fabrice.gasnier@st.com>
 <647777da-8077-6390-9778-08bef3d13074@codeaurora.org>
Message-ID: <a78b1bde-cd1b-0deb-9470-47a980787d2b@codeaurora.org>
Date:   Wed, 27 Mar 2019 18:52:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <647777da-8077-6390-9778-08bef3d13074@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/27/2019 6:21 PM, Mukesh Ojha wrote:
>
> On 3/26/2019 6:14 PM, Fabrice Gasnier wrote:
>> Enabling CONFIG_DEBUG_ATOMIC_SLEEP=y triggers this BUG message:
>> BUG: sleeping function called from invalid context at 
>> kernel/irq/chip.c...
>>
>> Call stack is as follows:
>> - __might_sleep
>> - handle_nested_irq          <-- Expects threaded irq
>> - iio_trigger_poll_chained
>> - stm32_adc_dma_buffer_done
>> - vchan_complete
>> - tasklet_action_common
>> - tasklet_action
>> - __do_softirq               <-- DMA completion raises a tasklet
>> - irq_exit
>> - __handle_domain_irq        <-- DMA IRQ
>> - gic_handle_irq
>>
>> IIO expects threaded interrupt context when calling:
>> - iio_trigger_poll_chained()
>> Or it expects interrupt context when calling:
>> - iio_trigger_poll()
>>
>> This patch triggers an IRQ upon stm32_adc_dma_buffer_done() DMA callback
>> call, so the IIO trigger poll API gets called from IRQ context.
>>
>> Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>
> -Mukesh
>
>
>> ---
>>   drivers/iio/adc/Kconfig     |  1 +
>>   drivers/iio/adc/stm32-adc.c | 32 ++++++++++++++++++++++++++++++--
>>   2 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 76db6e5..059407a 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -775,6 +775,7 @@ config STM32_ADC_CORE
>>       select MFD_STM32_TIMERS
>>       select IIO_STM32_TIMER_TRIGGER
>>       select IIO_TRIGGERED_BUFFER
>> +    select IRQ_WORK
>>       help
>>         Select this option to enable the core driver for 
>> STMicroelectronics
>>         STM32 analog-to-digital converter (ADC).
>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
>> index 205e169..1aa3189 100644
>> --- a/drivers/iio/adc/stm32-adc.c
>> +++ b/drivers/iio/adc/stm32-adc.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>>   #include <linux/iopoll.h>
>> +#include <linux/irq_work.h>
>>   #include <linux/module.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_runtime.h>
>> @@ -297,6 +298,7 @@ struct stm32_adc_cfg {
>>    * @smpr_val:        sampling time settings (e.g. smpr1 / smpr2)
>>    * @cal:        optional calibration data on some devices
>>    * @chan_name:        channel name array
>> + * @work:        irq work used to call trigger poll routine
>>    */
>>   struct stm32_adc {
>>       struct stm32_adc_common    *common;
>> @@ -320,6 +322,7 @@ struct stm32_adc {
>>       u32            smpr_val[2];
>>       struct stm32_adc_calib    cal;
>>       char chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
>> +    struct irq_work        work;
>>   };
>>     struct stm32_adc_diff_channel {
>> @@ -1473,11 +1476,32 @@ static unsigned int 
>> stm32_adc_dma_residue(struct stm32_adc *adc)
>>       return 0;
>>   }
>>   +static void stm32_adc_dma_irq_work(struct irq_work *work)
>> +{
>> +    struct stm32_adc *adc = container_of(work, struct stm32_adc, work);
>> +    struct iio_dev *indio_dev = iio_priv_to_dev(adc);
>> +
>> +    /*
>> +     * iio_trigger_poll calls generic_handle_irq(). So, it requires 
>> hard
>> +     * irq context, and cannot be called directly from dma callback,
>> +     * dma cb has to schedule this work instead.
>> +     */
>> +    iio_trigger_poll(indio_dev->trig);
>> +}
>> +
>>   static void stm32_adc_dma_buffer_done(void *data)
>>   {
>>       struct iio_dev *indio_dev = data;
>> +    struct stm32_adc *adc = iio_priv(indio_dev);
>>   -    iio_trigger_poll_chained(indio_dev->trig);
>> +    /*
>> +     * Invoques iio_trigger_poll() from hard irq context: We can't


s/Invoques/invoke


overlooked this last time.
Take mine Review tag if you make above change.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh


>> +     * call iio_trigger_poll() nor iio_trigger_poll_chained()
>> +     * directly from DMA callback (under tasklet e.g. softirq).
>> +     * They require respectively HW IRQ and threaded IRQ context
>> +     * as it might sleep.
>> +     */
>> +    irq_work_queue(&adc->work);
>>   }
>>     static int stm32_adc_dma_start(struct iio_dev *indio_dev)
>> @@ -1585,8 +1609,10 @@ static void 
>> __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>>       if (!adc->dma_chan)
>>           stm32_adc_conv_irq_disable(adc);
>>   -    if (adc->dma_chan)
>> +    if (adc->dma_chan) {
>>           dmaengine_terminate_all(adc->dma_chan);
>> +        irq_work_sync(&adc->work);
>> +    }
>>         if (stm32_adc_set_trig(indio_dev, NULL))
>>           dev_err(&indio_dev->dev, "Can't clear trigger\n");
>> @@ -1872,6 +1898,8 @@ static int stm32_adc_dma_request(struct iio_dev 
>> *indio_dev)
>>       if (ret)
>>           goto err_free;
>>   +    init_irq_work(&adc->work, stm32_adc_dma_irq_work);
>> +
>>       return 0;
>>     err_free:
