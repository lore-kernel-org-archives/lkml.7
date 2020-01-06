Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB39C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476272075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fpqRVBvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgAFO5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:57:53 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2018 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgAFO5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:57:53 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006EvXuO013821;
        Mon, 6 Jan 2020 15:57:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=mfTsSgC+nbIx5Cwy5kJoaiPuWHFCOTKUnbs7cW5AUkw=;
 b=fpqRVBvcgs6v2HPWaKCD0HnmaTPKFQaAR49Xi9p4ikiVRzM+TJZIPBmVMqajp1VR7zLr
 uWJhrtcsgXMK4bRA4eLWvqlxdyGY+s6LEaYtxxJfxmxPWrahJkQT3LHNlu3VIyGI1xmy
 Nu9NcaCp/AvIt6D2KMHvUdn6L1pJDSOz7u7ZZ7hziKrjdwL+EIE8JMkbhrsw0QVrfbtF
 TGx4AHSiexBSsusmHSuYd+WiADHYizL5EBtNf5Q3me6TTuozZZ0NN6bIopZn2DOETG8h
 d1l5D6eLe1sUbYqOq2FV548VRIfZS9/6K5lSVVJZ6NKZ/bREGUkEpgJmC7nXQZscOtap wQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakm58j2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 15:57:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D0EEA100034;
        Mon,  6 Jan 2020 15:57:35 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C37672D3786;
        Mon,  6 Jan 2020 15:57:35 +0100 (CET)
Received: from [10.48.0.71] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jan
 2020 15:57:33 +0100
Subject: Re: [PATCH] mfd: stm32-timers: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <lee.jones@linaro.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <vkoul@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
References: <20191217105240.25648-1-peter.ujfalusi@ti.com>
 <a9184949-94e0-97fb-5fa8-77693e71e99a@st.com>
 <bdfba9d1-d22b-fd55-2dce-1262017f1110@ti.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <f1aeb0de-5a1f-b162-e2f5-493551d12432@st.com>
Date:   Mon, 6 Jan 2020 15:57:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bdfba9d1-d22b-fd55-2dce-1262017f1110@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_04:2020-01-06,2020-01-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/19 12:36 PM, Peter Ujfalusi wrote:
> Hi Fabrice,
> 
> On 20/12/2019 10.54, Fabrice Gasnier wrote:
>> On 12/17/19 11:52 AM, Peter Ujfalusi wrote:
>>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>>> eating up the error code.
>>>
>>> By using dma_request_chan() directly the driver can support deferred
>>> probing against DMA.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>>  drivers/mfd/stm32-timers.c | 31 ++++++++++++++++++++++---------
>>>  1 file changed, 22 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
>>> index efcd4b980c94..34747e8a4a40 100644
>>> --- a/drivers/mfd/stm32-timers.c
>>> +++ b/drivers/mfd/stm32-timers.c
>>> @@ -167,10 +167,11 @@ static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
>>>  	regmap_write(ddata->regmap, TIM_ARR, 0x0);
>>>  }
>>>  
>>> -static void stm32_timers_dma_probe(struct device *dev,
>>> +static int stm32_timers_dma_probe(struct device *dev,
>>>  				   struct stm32_timers *ddata)
>>>  {
>>>  	int i;
>>> +	int ret = 0;
>>>  	char name[4];
>>>  
>>>  	init_completion(&ddata->dma.completion);
>>> @@ -179,14 +180,22 @@ static void stm32_timers_dma_probe(struct device *dev,
>>>  	/* Optional DMA support: get valid DMA channel(s) or NULL */
>>>  	for (i = STM32_TIMERS_DMA_CH1; i <= STM32_TIMERS_DMA_CH4; i++) {
>>>  		snprintf(name, ARRAY_SIZE(name), "ch%1d", i + 1);
>>> -		ddata->dma.chans[i] = dma_request_slave_channel(dev, name);
>>> +		ddata->dma.chans[i] = dma_request_chan(dev, name);
>>>  	}
>>> -	ddata->dma.chans[STM32_TIMERS_DMA_UP] =
>>> -		dma_request_slave_channel(dev, "up");
>>> -	ddata->dma.chans[STM32_TIMERS_DMA_TRIG] =
>>> -		dma_request_slave_channel(dev, "trig");
>>> -	ddata->dma.chans[STM32_TIMERS_DMA_COM] =
>>> -		dma_request_slave_channel(dev, "com");
>>> +	ddata->dma.chans[STM32_TIMERS_DMA_UP] = dma_request_chan(dev, "up");
>>> +	ddata->dma.chans[STM32_TIMERS_DMA_TRIG] = dma_request_chan(dev, "trig");
>>> +	ddata->dma.chans[STM32_TIMERS_DMA_COM] = dma_request_chan(dev, "com");
>>> +
>>> +	for (i = STM32_TIMERS_DMA_CH1; i < STM32_TIMERS_MAX_DMAS; i++) {
>>> +		if (IS_ERR(ddata->dma.chans[i])) {
>>> +			if (PTR_ERR(ddata->dma.chans[i]) == -EPROBE_DEFER)> +				ret = -EPROBE_DEFER;
>>
>> Hi Peter,
>>
>> Thanks for the patch,
>>
>> As the DMA is optional, I'd rather prefer to check explicitly there's no
>> device, and return any other error case, basically:
>>
>> 			if (PTR_ERR(ddata->dma.chans[i]) != -ENODEV)
>> 				return PTR_ERR(ddata->dma.chans[i]);
> 
> My intention was to specifically pick and handle EPROBE_DEFER while not
> changing how the driver handles other errors, whether it because there
> is no DMA channel specified or there is a failure to get the channel.
> 
> But if you prefer to ignore only ENODEV and report other errors then I
> can send v2.

Hi Peter,

Sorry for the late answer.

Yes, I'd prefer this please, not to hide other error case (as detailed
in other thread: https://lkml.org/lkml/2020/1/6/209). The only expected
"normal" error here is -ENODEV, as the DMA is optional.

> It could expose otherwise ignored configuration error (from DT?) and the
> change in the driver will be blamed for the regression.

I can do some testing at my end if needed, but I don't expect regression
here.

Thanks,
Fabrice

> 
> Would it make sense to add the change you suggested as an iteration on
> top of this patch?
> 
>>
>>> +
>>> +			ddata->dma.chans[i] = NULL;
>>> +		}
>>> +	}
>>> +
>>> +	return ret;
>>
>> With that, return 0 here.
>>
>>>  }
>>>  
>>>  static void stm32_timers_dma_remove(struct device *dev,
>>> @@ -230,7 +239,11 @@ static int stm32_timers_probe(struct platform_device *pdev)
>>>  
>>>  	stm32_timers_get_arr_size(ddata);
>>>  
>>> -	stm32_timers_dma_probe(dev, ddata);
>>> +	ret = stm32_timers_dma_probe(dev, ddata);
>>> +	if (ret) {
>>> +		stm32_timers_dma_remove(dev, ddata);
>>
>> With that, stm32_timers_dma_remove() likely need to be updated:
>>
>> -		if (ddata->dma.chans[i])
>> +		if (!IS_ERR_OR_NULL(ddata->dma.chans[i]))
>> 			dma_release_channel(ddata->dma.chans[i]);
>>
>> Best regards,
>> Fabrice
>>
>>> +		return ret;
>>> +	}
>>>  
>>>  	platform_set_drvdata(pdev, ddata);
>>>  
>>>
> 
> Kind regards,
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
