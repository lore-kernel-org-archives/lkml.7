Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A93C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDA624515
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfFDIgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:36:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37670 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfFDIgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:36:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FB9DA78;
        Tue,  4 Jun 2019 01:36:10 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7D243F246;
        Tue,  4 Jun 2019 01:36:09 -0700 (PDT)
Subject: Re: [RFC PATCH 46/57] driver: Add variants of driver_find_device()
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-47-git-send-email-suzuki.poulose@arm.com>
 <20190603191133.GE6487@kroah.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <373d3620-fa60-8306-1119-22d197d6ba93@arm.com>
Date:   Tue, 4 Jun 2019 09:36:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603191133.GE6487@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2019 20:11, Greg KH wrote:
> On Mon, Jun 03, 2019 at 04:50:12PM +0100, Suzuki K Poulose wrote:
>> Add a wrappers to lookup a device by name for a given driver, by various
>> generic properties of a device. This can avoid the proliferation of custom
>> match functions throughout the drivers.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   include/linux/device.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 52d59d5..68d6e04 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -401,6 +401,50 @@ struct device *driver_find_device(struct device_driver *drv,
>>   				  struct device *start, void *data,
>>   				  int (*match)(struct device *dev, const void *data));
>>   
>> +/**
>> + * driver_find_device_by_name - device iterator for locating a particular device
>> + * of a specific name.
>> + * @driver: the driver we're iterating
>> + * @start: Device to begin with
>> + * @name: name of the device to match
>> + */
>> +static inline struct device *driver_find_device_by_name(struct device_driver *drv,
>> +							struct device *start,
>> +							const char *name)
>> +{
>> +	return driver_find_device(drv, start, (void *)name, device_match_name);
> 
> Why is the cast needed?
> 
>> +}
>> +
>> +/**
>> + * driver_find_device_by_of_node- device iterator for locating a particular device
>> + * by of_node pointer.
>> + * @driver: the driver we're iterating
>> + * @start: Device to begin with
>> + * @np: of_node pointer to match.
>> + */
>> +static inline struct device *
>> +driver_find_device_by_of_node(struct device_driver *drv,
>> +			      struct device *start,
>> +			      const struct device_node *np)
>> +{
>> +	return driver_find_device(drv, start, (void *)np, device_match_of_node);
> 
> Same here.
> 
>> +}
>> +
>> +/**
>> + * driver_find_device_by_fwnode- device iterator for locating a particular device
>> + * by fwnode pointer.
>> + * @driver: the driver we're iterating
>> + * @start: Device to begin with
>> + * @fwnode: fwnode pointer to match.
>> + */
>> +static inline struct device *
>> +driver_find_device_by_fwnode(struct device_driver *drv,
>> +			     struct device *start,
>> +			     const struct fwnode_handle *fwnode)
>> +{
>> +	return driver_find_device(drv, start, (void *)fwnode, device_match_fwnode);
> 
> And here

Because the driver_find_device() expects a "void *" and not a "const void *".
May be we could promote that to "const void *" in the core API too, since we
have converted the "match" to const void * already. Thoughts ?

Suzuki

