Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F95C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE352067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfDYRMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:12:39 -0400
Received: from foss.arm.com ([217.140.101.70]:48758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDYRMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:12:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E57B80D;
        Thu, 25 Apr 2019 10:12:37 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4BF73F246;
        Thu, 25 Apr 2019 10:12:35 -0700 (PDT)
Subject: Re: [PATCH v2 25/36] coresight: Rearrange platform data probing
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, mike.leach@linaro.org,
        rjw@rjwysocki.net, robert.walker@arm.com
References: <1555344260-12375-1-git-send-email-suzuki.poulose@arm.com>
 <1555344260-12375-26-git-send-email-suzuki.poulose@arm.com>
 <20190422171608.GB6402@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3cee6641-a376-6caf-6b32-297fb2cb32df@arm.com>
Date:   Thu, 25 Apr 2019 18:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422171608.GB6402@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/04/2019 18:16, Mathieu Poirier wrote:
> On Mon, Apr 15, 2019 at 05:04:08PM +0100, Suzuki K Poulose wrote:
>> We are about to introduce methods to clean up the platform data
>> as we switch to tracking the device reference from "name" to "fwnode
>> handles" for device connections. This requires us to drop the fwnode
>> handle references when the data is no longer required - i.e, when
>> the device probe fails or the device gets unregistered.
>>
>> In order to consolidate the invocation of the cleanup, we delay the
>> platform probing to the very last minute, possibly before invoking
>> the coresight_register. Then, we leave the coresight core code to
>> do the clean up. i.e, if the coresight_register fails, it takes
>> care of freeing the data. Otherwise, coresight_unregister will
>> do the necessary operations.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

...

>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index 7ff0989..7c53fb2 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -981,11 +981,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>>   	if (!drvdata)
>>   		return -ENOMEM;
>>   
>> -	pdata = coresight_get_platform_data(dev);
>> -	if (IS_ERR(pdata))
>> -		return PTR_ERR(pdata);
>> -	adev->dev.platform_data = pdata;
>> -
>>   	dev_set_drvdata(dev, drvdata);
>>   
>>   	/* Validity for the resource is already checked by the AMBA core */
>> @@ -1028,6 +1023,11 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>>   	etm4_init_trace_id(drvdata);
>>   	etm4_set_default(&drvdata->config);
>>   
>> +	pdata = coresight_get_platform_data(dev);
>> +	if (IS_ERR(pdata))
>> +		return PTR_ERR(pdata);
> 
> Here you need to "goto err_arch_supported" instead of returning.

Thanks for catching that ! Fixed.

Suzuki

