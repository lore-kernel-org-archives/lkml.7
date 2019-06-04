Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C3DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F4324D40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfFDGkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:40:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18077 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbfFDGkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:40:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3D65BD28044AB47A947E;
        Tue,  4 Jun 2019 14:40:43 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.180) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Jun 2019
 14:40:38 +0800
Subject: Re: [PATCH] driver core: show the error number when
 driver_sysfs_add() fails
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190604041546.54380-1-wangkefeng.wang@huawei.com>
 <20190604053330.GA1588@kroah.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <de4622b3-73ad-2963-1943-4ef270956e6b@huawei.com>
Date:   Tue, 4 Jun 2019 14:37:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190604053330.GA1588@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.177.19.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/6/4 13:33, Greg Kroah-Hartman wrote:
> On Tue, Jun 04, 2019 at 12:15:46PM +0800, Kefeng Wang wrote:
>> If driver_sysfs_add() fails, kernel shows following message,
>>
>>   really_probe: driver_sysfs_add(portman.0) failed
>>   ppdev: probe of portman.0 failed with error 0
>>
>> It's better to show the error number like other probe_failed path.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  drivers/base/dd.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 0df9b4461766..04ee4e196530 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -493,7 +493,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>>  			goto probe_failed;
>>  	}
>>  
>> -	if (driver_sysfs_add(dev)) {
>> +	ret = driver_sysfs_add(dev);
>> +	if (ret) {
>>  		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
>>  			__func__, dev_name(dev));
> Shouldn't this be where the error number is shown?  No need for all
> callers to also show the same thing.

Like the message shown as above,  there is a common path to show all the probe error info,

"ppdev: probe of portman.0 failed with error 0"

but the driver_sysfs_add() error handling won't fill with ret, so error '0' is shown.
after this patch,

 really_probe: driver_sysfs_add(portman.0) failed
 ppdev: probe of portman.0 failed with error -12

>
> thanks,
>
> greg k-h
>
> .
>

