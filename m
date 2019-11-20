Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD9FC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B07A224D2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfKTNb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:31:56 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:42486 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727915AbfKTNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:31:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TieOpS3_1574256711;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TieOpS3_1574256711)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Nov 2019 21:31:51 +0800
Subject: Re: [PATCH] intel_th: avoid double free in error flow
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     zhiche.yy@alibaba-inc.com, xlpang@linux.alibaba.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20191119173447.2454-1-wenyang@linux.alibaba.com>
 <87y2wad7e5.fsf@ashishki-desk.ger.corp.intel.com>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <7e2a501f-955a-5bd1-f70d-ad69e7223981@linux.alibaba.com>
Date:   Wed, 20 Nov 2019 21:31:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87y2wad7e5.fsf@ashishki-desk.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/11/20 9:06 下午, Alexander Shishkin wrote:
> Wen Yang <wenyang@linux.alibaba.com> writes:
>
>> There is a possible double free issue in intel_th_subdevice_alloc:
>>
>> 651         err = intel_th_device_add_resources(thdev, res, subdev->nres);
>> 652         if (err) {
>> 653                 put_device(&thdev->dev);
>> 654                 goto fail_put_device;     ---> freed
>> 655         }
>> ...
>> 687 fail_put_device:
>> 688         put_device(&thdev->dev);          ---> double freed
>> 689
>>
>> This patch fix it by removing the unnecessary put_device().
> Unnecessary is a too generous term here.
>
>> Fixes: a753bfcfdb1f ("intel_th: Make the switch allocate its subdevices")
>> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-kernel@vger.kernel.org
> Cc: stable@ is missing.
>
>> ---
>>   drivers/hwtracing/intel_th/core.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
>> index d5c1821..98d195c 100644
>> --- a/drivers/hwtracing/intel_th/core.c
>> +++ b/drivers/hwtracing/intel_th/core.c
>> @@ -649,10 +649,8 @@ static inline void intel_th_request_hub_module_flush(struct intel_th *th)
>>   	}
>>   
>>   	err = intel_th_device_add_resources(thdev, res, subdev->nres);
>> -	if (err) {
>> -		put_device(&thdev->dev);
>> +	if (err)
>>   		goto fail_put_device;
>> -	}
> What about the second instance of the same problem a few lines lower?
> Thanks,
> --
> Alex

Hi Alex,

Thank you for your comments.

Another example after a few lines lower:

         err = device_add(&thdev->dev);

         if (err) {
                  put_device(&thdev->dev);
                  goto fail_free_res;

          }

device_add() has increased the reference count,

so when it returns an error, an additional call to put_device()

is needed here to reduce the reference count.

So the code in this place is correct.


--

Regards,

Wen



