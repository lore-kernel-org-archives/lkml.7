Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B069C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5AB24963
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfFDIT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:19:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37410 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfFDIT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:19:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07D8FA78;
        Tue,  4 Jun 2019 01:19:57 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E89B3F246;
        Tue,  4 Jun 2019 01:19:56 -0700 (PDT)
Subject: Re: [RFC PATCH 03/57] drivers: coresight: Drop device references
 found via bus_find_device
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        mathieu.poirier@linaro.org
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-4-git-send-email-suzuki.poulose@arm.com>
 <20190603190821.GB6487@kroah.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e009a16e-a1bd-a8c3-34da-cc532a40be41@arm.com>
Date:   Tue, 4 Jun 2019 09:19:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603190821.GB6487@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2019 20:08, Greg KH wrote:
> On Mon, Jun 03, 2019 at 04:49:29PM +0100, Suzuki K Poulose wrote:
>> We must drop references to the device found via bus_find_device().
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
>> index 4b13028..37ccd67 100644
>> --- a/drivers/hwtracing/coresight/coresight.c
>> +++ b/drivers/hwtracing/coresight/coresight.c
>> @@ -540,7 +540,7 @@ struct coresight_device *coresight_get_enabled_sink(bool deactivate)
>>   
>>   	dev = bus_find_device(&coresight_bustype, NULL, &deactivate,
>>   			      coresight_enabled_sink);
>> -
>> +	put_device(dev);
>>   	return dev ? to_coresight_device(dev) : NULL;
> 
> You drop the reference and then use the pointer?
> 
> Not good :(
> 
>>   }
>>   
>> @@ -581,7 +581,7 @@ struct coresight_device *coresight_get_sink_by_id(u32 id)
>>   
>>   	dev = bus_find_device(&coresight_bustype, NULL, &id,
>>   			      coresight_sink_by_id);
>> -
>> +	put_device(dev);
>>   	return dev ? to_coresight_device(dev) : NULL;
> 
> Same here, not good :(
> 
> Please fix this up and it can go in as a bugfix like any other normal
> patch, outside of this huge series.
> 
> thanks,
> 

Sure, will do. I think there are much more of such instances lying around. :-(
I will take it out of this series.

Thanks
Suzuki
