Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868AEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1B721726
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RL/KWuNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405955AbfHWPrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:47:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34075 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405929AbfHWPrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:47:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id s18so9087051wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nbqUXx9/m3WXheTKytTj56obmJu7LH7aMaefn0f5f54=;
        b=RL/KWuNX1l7JP9hh2eGOxiO3sJPzpPyw3XRXef767G1TNCE/Ra58e8d4bvyzixfwG0
         UGpKWuBGrATOJ5uN3i6nVe7dc33uEt6csPnLaWXltTFjX6WFngqhykDw3KosJwrEQYPt
         pBzwhqrgH3njj7i3q+e2ACZjr5SeVRNntUvYQyPAKrKr9VRz7Q2b1oBfvuIq3qjSJW7e
         EaQu3jIyJzhqfKe7IfG2+QCpM90vLBfMBMWzjN00ERlXSP1DW7idHqLzFYjV9dzOuAvj
         MZmZpYzMhkIfHO8IK4UyVjFo5qIz17HZNPWZ65ksGGWld0hZNEl4HNemCyL7o/aPlrwU
         PHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nbqUXx9/m3WXheTKytTj56obmJu7LH7aMaefn0f5f54=;
        b=cSwunUK6BPJpNQF6L8Yn9oCutcaWv0O7LRg0J77StZEQ+S+LINRL02bHDvbRLIA90M
         tLYH2FePoax/U52oCoWgJVmTb3g8baNp6MFZWsuKDcrn4PTTN3rREcOTsbw5tKfYmSQK
         syqGgHTSbA7tWVDHx7VJxyP+2HjATcB1uStuiel4tYTmESjwPx+O4Uu8Ra5en5OktRUA
         lmd7TUyVQeK9gVw6BxwObek7vClesyuG6ngK75PSYFCipWqcE3Mcs9EZ1qVqYn7NsnJz
         Kp0W/TmzTYzDCaMYJ0rwhz8q2byF+Sm/J5g+FNKo8Xi04XhCdiQd59NvyKBmEgT64Z4c
         dudg==
X-Gm-Message-State: APjAAAUEd+7zGUWfTRSaAYH1xnL4KZJOjJvWfFtmHemovfTzIgVJ/0OS
        9KkgrOtA2zOMfF8D8UtUJKGYKXgqEo4=
X-Google-Smtp-Source: APXvYqzjo6E35pjgKTgPRAP5MP9+Ux5v6TxkXFDx/A/Hjfxqz7m838j/G1SxZsO7zwsJFmyDbCHpUw==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr6157158wre.114.1566575226769;
        Fri, 23 Aug 2019 08:47:06 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id p69sm5047650wme.36.2019.08.23.08.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 08:47:06 -0700 (PDT)
Subject: Re: [alsa-devel] [RESEND PATCH v4 2/4] soundwire: core: add device
 tree support for slave devices
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, spapothi@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-3-srinivas.kandagatla@linaro.org>
 <2f1b5e2e-4699-1d06-e28e-708d5ed99b6a@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <06fb60b4-72e1-5898-8eb9-d9a46efd3b3a@linaro.org>
Date:   Fri, 23 Aug 2019 16:47:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2f1b5e2e-4699-1d06-e28e-708d5ed99b6a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2019 16:44, Pierre-Louis Bossart wrote:
> 
> 
> On 8/22/19 6:37 PM, Srinivas Kandagatla wrote:
>> This patch adds support to parsing device tree based
>> SoundWire slave devices.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/bus.c   |  2 ++
>>   drivers/soundwire/bus.h   |  1 +
>>   drivers/soundwire/slave.c | 52 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
>> index 49f64b2115b9..c2eaeb5c38ed 100644
>> --- a/drivers/soundwire/bus.c
>> +++ b/drivers/soundwire/bus.c
>> @@ -77,6 +77,8 @@ int sdw_add_bus_master(struct sdw_bus *bus)
>>        */
>>       if (IS_ENABLED(CONFIG_ACPI) && ACPI_HANDLE(bus->dev))
>>           ret = sdw_acpi_find_slaves(bus);
>> +    else if (IS_ENABLED(CONFIG_OF) && bus->dev->of_node)
>> +        ret = sdw_of_find_slaves(bus);
>>       else
>>           ret = -ENOTSUPP; /* No ACPI/DT so error out */
>> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
>> index 3048ca153f22..ee46befedbd1 100644
>> --- a/drivers/soundwire/bus.h
>> +++ b/drivers/soundwire/bus.h
>> @@ -15,6 +15,7 @@ static inline int sdw_acpi_find_slaves(struct 
>> sdw_bus *bus)
>>   }
>>   #endif
>> +int sdw_of_find_slaves(struct sdw_bus *bus);
>>   void sdw_extract_slave_id(struct sdw_bus *bus,
>>                 u64 addr, struct sdw_slave_id *id);
>> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
>> index f39a5815e25d..3ef265d2ee89 100644
>> --- a/drivers/soundwire/slave.c
>> +++ b/drivers/soundwire/slave.c
>> @@ -2,6 +2,7 @@
>>   // Copyright(c) 2015-17 Intel Corporation.
>>   #include <linux/acpi.h>
>> +#include <linux/of.h>
>>   #include <linux/soundwire/sdw.h>
>>   #include <linux/soundwire/sdw_type.h>
>>   #include "bus.h"
>> @@ -35,6 +36,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
>>       slave->dev.release = sdw_slave_release;
>>       slave->dev.bus = &sdw_bus_type;
>> +    slave->dev.of_node = of_node_get(to_of_node(fwnode));
>>       slave->bus = bus;
>>       slave->status = SDW_SLAVE_UNATTACHED;
>>       slave->dev_num = 0;
>> @@ -112,3 +114,53 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
>>   }
>>   #endif
>> +
>> +/*
>> + * sdw_of_find_slaves() - Find Slave devices in master device tree node
>> + * @bus: SDW bus instance
>> + *
>> + * Scans Master DT node for SDW child Slave devices and registers it.
>> + */
>> +int sdw_of_find_slaves(struct sdw_bus *bus)
>> +{
>> +    struct device *dev = bus->dev;
>> +    struct device_node *node;
>> +
>> +    for_each_child_of_node(bus->dev->of_node, node) {
>> +        int link_id, sdw_version, ret, len;
>> +        const char *compat = NULL;
>> +        struct sdw_slave_id id;
>> +        const __be32 *addr;
>> +
>> +        compat = of_get_property(node, "compatible", NULL);
>> +        if (!compat)
>> +            continue;
>> +
>> +        ret = sscanf(compat, "sdw%01x%04hx%04hx%02hhx", &sdw_version,
>> +                 &id.mfg_id, &id.part_id, &id.class_id);
>> +
>> +        if (ret != 4) {
>> +            dev_err(dev, "Invalid compatible string found %s\n",
>> +                compat);
>> +            continue;
>> +        }
>> +
>> +        addr = of_get_property(node, "reg", &len);
>> +        if (!addr || (len < 2 * sizeof(u32))) {
>> +            dev_err(dev, "Invalid Instance and Link ID\n");
>> +            continue;
>> +        }
>> +
>> +        id.unique_id = be32_to_cpup(addr++);
>> +        link_id = be32_to_cpup(addr);
> 
> So here the link ID is obviously not in the address, so you are not 
> using the MIPI spec as we discussed initially?

No, Rob rejected that approach (https://lkml.org/lkml/2019/8/22/490) 
with the fact that compatible string should be constant for each instance.

--srini
> 
>> +        id.sdw_version = sdw_version;
>> +
>> +        /* Check for link_id match */
>> +        if (link_id != bus->link_id)
>> +            continue;
>> +
>> +        sdw_slave_add(bus, &id, of_fwnode_handle(node));
>> +    }
>> +
>> +    return 0;
>> +}
>>
