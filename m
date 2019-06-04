Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C58C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2B223E3B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfFDI1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:27:52 -0400
Received: from foss.arm.com ([217.140.101.70]:37506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfFDI1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:27:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03126A78;
        Tue,  4 Jun 2019 01:27:51 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC7673F246;
        Tue,  4 Jun 2019 01:27:49 -0700 (PDT)
Subject: Re: [RFC PATCH 36/57] drivers: mei: Use class_find_device_by_devt
 match helper
To:     tomas.winkler@intel.com, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, arnd@arndb.de
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-37-git-send-email-suzuki.poulose@arm.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DC23236@hasmsx108.ger.corp.intel.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3a8bf057-1c43-fc44-e314-51f831a2a242@arm.com>
Date:   Tue, 4 Jun 2019 09:27:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DC23236@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

On 03/06/2019 19:00, Winkler, Tomas wrote:
> 
> 
>> -----Original Message-----
>> From: Suzuki K Poulose [mailto:suzuki.poulose@arm.com]
>> Sent: Monday, June 03, 2019 18:50
>> To: linux-kernel@vger.kernel.org
>> Cc: gregkh@linuxfoundation.org; rafael@kernel.org; suzuki.poulose@arm.com;
>> Winkler, Tomas <tomas.winkler@intel.com>; Arnd Bergmann
>> <arnd@arndb.de>
>> Subject: [RFC PATCH 36/57] drivers: mei: Use class_find_device_by_devt match
>> helper
>>
>> Switch to the generic helper class_find_device_by_devt.
> 
> Looks okay, but  you could add me at least to cover later mail, there is very little context.

You were on the Cc list. I am not sure if the cover-letter was kind of blocked
due to the large Cc set. Please find it below. I can see that you are copied
on the cover letter in my inbox. The subject of is :

"[RFC PATCH 00/57] drivers: Consolidate device lookup helpers"

--- cover ---

We have helper routines to lookup devices matching a criteria defined
by a "match" helper for bus/class/driver. Often the search is based on a
generic property of a device, such as of_node, fwnode, device type or
device name. In the absense of a common set of match functions, we have
drivers writing their own match functions, spilled all over the driver
subsystems. This series is an attempt to consolidate the and cleanup
the device match functions by providing generic match helpers by device
properties listed above. In this attempt, we unify the prototype for
the match functions for {bus/driver}_find_device() with that of the
class_find_device() and thus further reducing the duplicate functions.
The series also adds wrapper functions to lookup the devices by generic
attributes, so that people don't miss the generic match functions and
continue to write their own.

Also, there are a couple of instances where the drivers use "platform_bus_type"
directly reusing the "match" function of the bus. This is cleaned by providing
a new helper "platform_find_device_by_driver()" to abstract the details away
from the callers.

Applies on 5.2-rc3

Cc: Alan Tull <atull@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
...
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thor Thayer <thor.thayer@linux.intel.com>
*Cc: Tomas Winkler <tomas.winkler@intel.com>*
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
...

----

Cheers
Suzuki

> 
> 
> Thanks
> Tomas
> 
> 
>>
>> Cc: Tomas Winkler <tomas.winkler@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/misc/mei/main.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c index
>> ad02097..243b481 100644
>> --- a/drivers/misc/mei/main.c
>> +++ b/drivers/misc/mei/main.c
>> @@ -858,13 +858,6 @@ static ssize_t dev_state_show(struct device *device,  }
>> static DEVICE_ATTR_RO(dev_state);
>>
>> -static int match_devt(struct device *dev, const void *data) -{
>> -	const dev_t *devt = data;
>> -
>> -	return dev->devt == *devt;
>> -}
>> -
>>   /**
>>    * dev_set_devstate: set to new device state and notify sysfs file.
>>    *
>> @@ -880,7 +873,7 @@ void mei_set_devstate(struct mei_device *dev, enum
>> mei_dev_state state)
>>
>>   	dev->dev_state = state;
>>
>> -	clsdev = class_find_device(mei_class, NULL, &dev->cdev.dev,
>> match_devt);
>> +	clsdev = class_find_device_by_devt(mei_class, NULL, dev->cdev.dev);
>>   	if (clsdev) {
>>   		sysfs_notify(&clsdev->kobj, NULL, "dev_state");
>>   		put_device(clsdev);
>> --
>> 2.7.4
> 
