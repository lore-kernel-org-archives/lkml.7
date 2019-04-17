Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC27C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FCA21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfDQDBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:01:25 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:59878 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfDQDBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:01:25 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hGap7-0004ih-VG from Jiada_Wang@mentor.com ; Tue, 16 Apr 2019 20:01:21 -0700
Received: from [134.86.193.85] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
 (147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 16 Apr
 2019 20:01:18 -0700
Subject: Re: [PATCH v1 1/1] thermal: rcar_gen3_thermal: request IRQ after
 device initialization
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190411100352.15977-1-jiada_wang@mentor.com>
 <92504666-9e17-4c6d-fc74-6cf68b9f017b@linaro.org>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <9a4de8ca-fa49-2050-e40b-b54d03484213@mentor.com>
Date:   Wed, 17 Apr 2019 12:01:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <92504666-9e17-4c6d-fc74-6cf68b9f017b@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: svr-orw-mbx-08.mgc.mentorg.com (147.34.90.208) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

On 2019/04/17 4:22, Daniel Lezcano wrote:
> On 11/04/2019 12:03, Jiada Wang wrote:
>> Currently IRQ is remain enabled after .remove, later if device is probed,
>> IRQ is requested before .thermal_init, this may cause IRQ function be
>> triggered but not able to clear IRQ status, thus cause system to hang.
>>
>> this patch by moving request of IRQ after device initialization to
>> avoid this issue.
> 
> Why not disable the interrupt and clear the irq status in the .remove
> callback, so the place is clean when probing again?
> 
> 
>          struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
> 
>          rcar_thermal_irq_set(priv, false);
> 
> should do the trick no ?
> 
yes, this issue also can be addressed by disable the interrupt in .remove.

But there is race condition between .remove and irq thread function,
(which enables IRQ)
so driver need to ensure threaded irq has been disabled before call 
rcar_thermal_irq_set(priv, false) in .remove.
this adds additional complexity.

I am fine with both solutions,
what is your opinion?

Thanks,
Jiada

>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   drivers/thermal/rcar_gen3_thermal.c | 48 ++++++++++++++++-------------
>>   1 file changed, 26 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
>> index 88fa41cf16e8..4d095d7f9763 100644
>> --- a/drivers/thermal/rcar_gen3_thermal.c
>> +++ b/drivers/thermal/rcar_gen3_thermal.c
>> @@ -375,28 +375,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, priv);
>>   
>> -	/*
>> -	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
>> -	 * to trigger on the low and high trip points of the current
>> -	 * temp window at this point.
>> -	 */
>> -	for (i = 0; i < 2; i++) {
>> -		irq = platform_get_irq(pdev, i);
>> -		if (irq < 0)
>> -			return irq;
>> -
>> -		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
>> -					 dev_name(dev), i);
>> -		if (!irqname)
>> -			return -ENOMEM;
>> -
>> -		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
>> -						rcar_gen3_thermal_irq_thread,
>> -						IRQF_SHARED, irqname, priv);
>> -		if (ret)
>> -			return ret;
>> -	}
>> -
>>   	pm_runtime_enable(dev);
>>   	pm_runtime_get_sync(dev);
>>   
>> @@ -458,6 +436,32 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>>   		goto error_unregister;
>>   	}
>>   
>> +	/*
>> +	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
>> +	 * to trigger on the low and high trip points of the current
>> +	 * temp window at this point.
>> +	 */
>> +	for (i = 0; i < 2; i++) {
>> +		irq = platform_get_irq(pdev, i);
>> +		if (irq < 0) {
>> +			ret = irq;
>> +			goto error_unregister;
>> +		}
>> +
>> +		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
>> +					 dev_name(dev), i);
>> +		if (!irqname) {
>> +			ret = -ENOMEM;
>> +			goto error_unregister;
>> +		}
>> +
>> +		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
>> +						rcar_gen3_thermal_irq_thread,
>> +						IRQF_SHARED, irqname, priv);
>> +		if (ret)
>> +			goto error_unregister;
>> +	}
>> +
>>   	rcar_thermal_irq_set(priv, true);
>>   
>>   	return 0;
>>
> 
> 
