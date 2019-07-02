Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82974C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3B520645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9B4oL9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfGBIWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:22:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39059 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfGBIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:22:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so16684962wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 01:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vYWQ+sDhyFlw91XFV9mAOBrhaIXwN0ArOngCGYdsiF0=;
        b=K9B4oL9Oqg9tS3O+ZwDqRZczqzQ8Dq4j9opnmwMvQHH8+EEQx4PfZmYQVm9j6NQHRQ
         E6xn52+0bQd8Mhy4KJjeVngvi7HJz1Xo3AEIgBbaT8L9ZyBWC9ZGZOU4LFrF3xrLvRVH
         Vt21OyshHLRtEvoql3xpZB0vUa4tDVbg/gB38a3YqTBDUps4GrdtQ64FFfZD0QEaoHms
         yMHMSYuNg/nuC6oOTdHJVh0UcweLbC3bVzRY7vH+xwQO7Mr91XvEi8RF8FZc1IKFW2De
         pF1GfXDE5qsi8EFM+WqqICGZDrqnphvgTbxxHU5AYrURUeh3i5Vd9PiUe3BzMqkZmEI5
         hGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vYWQ+sDhyFlw91XFV9mAOBrhaIXwN0ArOngCGYdsiF0=;
        b=dvC85/0t/JmpMMvcM9Z0oxLQ60HU3wnPRM6YRfEU9ap3EfNo6LVLzhAba3C6ZZERvl
         YLHAqjKi6Jy5yQFBQ/ew14Pnt+ZhznpA/k3jt4g/OyRQLKEIOYVPtXt5LxZl/Q3kInwP
         hTm9CaawA33EmC6PgvTkkPIDVed+c+eaMX6vY0fHf4EDnNJRGZopjy014OhIUC/VsYNv
         yVBPHVnFdgMX0lMHcjKf/qnufijFKYtIumAs4DABmeqrtIMyJuq+7j2Em6LPTHVUoaAW
         QV1t8VoVUdMZEKyETjehdqmGM2XQnZrF3NiB09I/xNIoMQ6Nf6Qn7LsjmzIUzzp9r0pK
         AcHQ==
X-Gm-Message-State: APjAAAVg0M2PWV9tRFHzzKp9/jASiZ0rB9A4JRiBwC6A3clE6OGPHlW8
        EljE/n4/KTNFr549CzksRdlsCQ==
X-Google-Smtp-Source: APXvYqxTrHwbXeG/opRoDSVdOC0GcAMdxzTCfEDJ7BTZaFAkzF5llutiJIwJgPjO6trI78e7j1/6AQ==
X-Received: by 2002:adf:e705:: with SMTP id c5mr23345395wrm.270.1562055730054;
        Tue, 02 Jul 2019 01:22:10 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id o185sm1582323wmo.45.2019.07.02.01.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 01:22:09 -0700 (PDT)
Subject: Re: [RFC PATCH 2/5] soundwire: core: add device tree support for
 slave devices
To:     Vinod Koul <vkoul@kernel.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
 <20190611104043.22181-3-srinivas.kandagatla@linaro.org>
 <20190701061745.GK2911@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c2b74c2c-0491-fdd1-3967-b3332645d8df@linaro.org>
Date:   Tue, 2 Jul 2019 09:22:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190701061745.GK2911@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review,

On 01/07/2019 07:17, Vinod Koul wrote:
> On 11-06-19, 11:40, Srinivas Kandagatla wrote:
>> This patch adds support to parsing device tree based
>> SoundWire slave devices.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/bus.c   |  2 +-
>>   drivers/soundwire/bus.h   |  1 +
>>   drivers/soundwire/slave.c | 54 ++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 55 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index fe745830a261..20f26cf4ba74 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -78,7 +78,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>>   	if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
>>   		ret = sdw_acpi_find_slaves(bus);
>>   	else
>> -		ret = -ENOTSUPP; /* No ACPI/DT so error out */
>> +		ret = sdw_of_find_slaves(bus);
>>   
>>   	if (ret) {
>>   		dev_err(bus->dev, "Finding slaves failed:%d\n", ret);
>> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
>> index 3048ca153f22..ee46befedbd1 100644
>> --- a/drivers/soundwire/bus.h
>> +++ b/drivers/soundwire/bus.h
>> @@ -15,6 +15,7 @@ static inline int sdw_acpi_find_slaves(struct sdw_bus *bus)
>>   }
>>   #endif
>>   
>> +int sdw_of_find_slaves(struct sdw_bus *bus);
>>   void sdw_extract_slave_id(struct sdw_bus *bus,
>>   			  u64 addr, struct sdw_slave_id *id);
>>   
>> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
>> index f39a5815e25d..6e7f5cfeb854 100644
>> --- a/drivers/soundwire/slave.c
>> +++ b/drivers/soundwire/slave.c
>> @@ -2,6 +2,7 @@
>>   // Copyright(c) 2015-17 Intel Corporation.
>>   
>>   #include <linux/acpi.h>
>> +#include <linux/of.h>
>>   #include <linux/soundwire/sdw.h>
>>   #include <linux/soundwire/sdw_type.h>
>>   #include "bus.h"
>> @@ -28,13 +29,14 @@ static int sdw_slave_add(struct sdw_bus *bus,
>>   	slave->dev.parent = bus->dev;
>>   	slave->dev.fwnode = fwnode;
>>   
>> -	/* name shall be sdw:link:mfg:part:class:unique */
>> +	/* name shall be sdw:link:mfg:part:class */
> 
> nope we are not changing dev_set_name below so this comment should not
> be modified

Am not sure why this change was here, I will remove this!
> 
>>   	dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
>>   		     bus->link_id, id->mfg_id, id->part_id,
>>   		     id->class_id, id->unique_id);
>>   
>>   	slave->dev.release = sdw_slave_release;
>>   	slave->dev.bus = &sdw_bus_type;
>> +	slave->dev.of_node = of_node_get(to_of_node(fwnode));
>>   	slave->bus = bus;
>>   	slave->status = SDW_SLAVE_UNATTACHED;
>>   	slave->dev_num = 0;
>> @@ -112,3 +114,53 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>>   }
>>   
>>   #endif
>> +
>> +#if IS_ENABLED(CONFIG_OF)
>> +/*
>> + * sdw_of_find_slaves() - Find Slave devices in master device tree node
>> + * @bus: SDW bus instance
>> + *
>> + * Scans Master DT node for SDW child Slave devices and registers it.
>> + */
>> +int sdw_of_find_slaves(struct sdw_bus *bus)
>> +{
>> +	struct device *dev = bus->dev;
>> +	struct device_node *node;
>> +
>> +	if (!bus->dev->of_node)
>> +		return 0;
> 
> this should be error, otherwise next condition of checking slaves wont
> be triggered..
> 
I agree! will fix this in next version.

