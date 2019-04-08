Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B57DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5676820880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDHIvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:51:22 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:28961 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfDHIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:51:22 -0400
X-IronPort-AV: E=Sophos;i="5.60,324,1549922400"; 
   d="scan'208";a="215973045"
Subject: Re: [PATCH 1/1] rtc: ds3232: get SRAM access using NVMEM Framework
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190405111348.28935-1-nandor.han@vaisala.com>
 <20190405214454.GJ22216@piout.net>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <ca262241-16f3-ab43-f63e-fb6293798d21@vaisala.com>
Date:   Mon, 8 Apr 2019 11:51:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190405214454.GJ22216@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2019 08:51:15.0384 (UTC) FILETIME=[39859B80:01D4EDE8]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/19 12:44 AM, Alexandre Belloni wrote:
> Hi,
> 
> On 05/04/2019 11:14:35+0000, Han Nandor wrote:

<snip>

>> `
>> # hexdump -n 10 -C /sys/bus/nvmem/devices/ds3232_sram0/nvmem
>> 00000000  74 65 73 74 69 6e 67 0a  00 00                    |testing...|
>> 0000000a
>> `
>>
> 
> Thanks for that nice description!
> 

Glad that you like it. :)


>>   drivers/rtc/rtc-ds3232.c | 41 ++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 39 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
>> index 7184e5145f12..fe615aedaa9a 100644
>> --- a/drivers/rtc/rtc-ds3232.c
>> +++ b/drivers/rtc/rtc-ds3232.c
>> @@ -24,6 +24,8 @@
>>   #include <linux/regmap.h>
>>   #include <linux/hwmon.h>
>>   
>> +#include "rtc-core.h"
>> +
> 
> The drivers should not have to include that header, see
> fd5cd21d995e67f87b3eb4adf938be85fe83ef4b (from 4.16).
> 

Ahh...right. I did the implementation on 4.14 and it was needed there.
I will change the implementation but I'll not be able to fully test it.

<snip>

>>   struct ds3232 {
>>   	struct device *dev;
>>   	struct regmap *regmap;
>>   	int irq;
>>   	struct rtc_device *rtc;
>> +	struct nvmem_config	nvmem_cfg;
>>   
> 
> You don't actually need to keep that structure for the whole life of the
> device as it is copied as soon as it is registered. I usually prefer to
> have it on the stack.
> 

Very true. Done

<snip>

>> +	ds3232->nvmem_cfg.stride = 1;
>> +	ds3232->nvmem_cfg.size = DS3232_REG_SRAM_SIZE;
>> +	ds3232->nvmem_cfg.word_size = 1;
>> +	ds3232->nvmem_cfg.reg_read = ds3232_nvmem_read;
>> +	ds3232->nvmem_cfg.reg_write = ds3232_nvmem_write;
>> +	ds3232->nvmem_cfg.priv = ds3232;
> 
> Please also set the type (battery backed).
> 

Done.

<snip>

>>   
>> +	ds3232->rtc->dev.of_node = dev->of_node;
> 
> Please don't mess with rtc->dev.
> 

In my use-case I do use the device tree to declare a nvmem cell in this 
RTC node, which is used by another driver. Without this change finding 
the cell (using `devm_nvmem_cell_get` function) was failing because of 
missing `of_node` (again this was on 4.14).

I can do a bit of digging to see if something was changed, but I will 
really appreciate your advice, because I'm not be able to test the fix 
on linux-next.

>> +	ds3232->rtc->nvmem_config = &ds3232->nvmem_cfg;
>> +	rtc_nvmem_register(ds3232->rtc);
> 
> This part will not compile on v5.1-rc1.
> 

Sorry. I will fix this, and I will at least see that it builds on 
linux-next.

Thanks for review,
Nandor
