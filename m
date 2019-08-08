Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6216C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAE4218B8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPKemEq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733049AbfHHPRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:17:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55145 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbfHHPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:17:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so2788063wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JH79KLt/cUnUFrKqTtYF5L+pOS2C3hiTwjXkizwU6G0=;
        b=RPKemEq/ngZ4XjkAzy5p6s0pFtRFtPfOVsD/+Z5n0ckPkUjKaDVfcUKCJ6xU31lahb
         dXbkMwZ95S1PMkjcpZ2UobVQneuuBSFUepU8Rp973z7umkq9ItwCOxA/6VIZBos0hZTE
         JKSG7rIvsM+ceVU4YtEcfqSC9mIrKLhhLhQC6cBP6CLrjbcSC6MaXTJD3An8duBbRPgz
         PUv0ohwddDt3Yp7z5E8VjLbPZTzMzycd/B/lhdU7/smHV3qswv6W7LjBXIZMQzJ1pmiu
         aeOV4/Fx6DvkZTOqR+stPYzRw4YvqArNDGJZInzd6i6fAYf1Ntp2h06vXV9XtBcF2iQl
         BviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JH79KLt/cUnUFrKqTtYF5L+pOS2C3hiTwjXkizwU6G0=;
        b=MoPMfioy5/9828jJ/M4JLQjfDdWUO+IO8ys3e8wET7QjCoiP52eBTKIW54132o0GVQ
         fJ2TFl3+kz1Go23pJ/ghE874qiyX3wucWxxGV51D6MkhBvkxjiBBGb58L8sImVEcLX2B
         ydaEOKLywvtr5b+PLeNCRAVUsPUag9W9MQk+66iBqZ/hn4WdIqQlgO8q903SxmtDbhVj
         iMjU05eIEVH76pGOejiYNcS2laDt8/EBfKnTtwkgImax8D6JytsH3szyFlkC1xSrHLzX
         fhkKJi15/syW2gDCIfVgGHnZgkshobTScT72w8qeu9sLC/zcB8cifUVimnp0k4IwcKZ0
         17Zw==
X-Gm-Message-State: APjAAAUovGKEFef0c/Q2oY1IM0QXBQ1tMleY37vzxDHRRkjgLCXMhS30
        8pNrELgLmzJAeRfDZqeQbgrlvWH/TaM=
X-Google-Smtp-Source: APXvYqyrp7wFg8Mu3fozGa9Vv2k13JVkluOFUNFjwI6aSKz9AEJVqZgF8MJw6L5ZWJ419QegEd1mNQ==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr5268987wmm.81.1565277453643;
        Thu, 08 Aug 2019 08:17:33 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t19sm2992693wmi.29.2019.08.08.08.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 08:17:32 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] soundwire: core: add device tree support for slave
 devices
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-3-srinivas.kandagatla@linaro.org>
 <42ca4170-0fa0-6951-f568-89a05c095d5a@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <564f5fa4-59ec-b4e5-a7a5-29dee99039b3@linaro.org>
Date:   Thu, 8 Aug 2019 16:17:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <42ca4170-0fa0-6951-f568-89a05c095d5a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review.

On 08/08/2019 16:00, Pierre-Louis Bossart wrote:
> 
>> @@ -35,6 +36,7 @@ static int sdw_slave_add(struct sdw_bus *bus,
>>       slave->dev.release = sdw_slave_release;
>>       slave->dev.bus = &sdw_bus_type;
>> +    slave->dev.of_node = of_node_get(to_of_node(fwnode));
> 
> shouldn't this protected by
> #if IS_ENABLED(CONFIG_OF) ?
> 
These macros and functions have dummy entries, so it should not be an issue.
I did build soundwire with i386_defconfig with no issues.

>>       slave->bus = bus;
>>       slave->status = SDW_SLAVE_UNATTACHED;
>>       slave->dev_num = 0;
>> @@ -112,3 +114,48 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
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
>> +        struct sdw_slave_id id;
>> +        const char *compat = NULL;
>> +        int unique_id, ret;
>> +        int ver, mfg_id, part_id, class_id;
>> +
>> +        compat = of_get_property(node, "compatible", NULL);
>> +        if (!compat)
>> +            continue;
>> +
>> +        ret = sscanf(compat, "sdw%x,%x,%x,%x",
>> +                 &ver, &mfg_id, &part_id, &class_id);
>> +        if (ret != 4) {
>> +            dev_err(dev, "Manf ID & Product code not found %s\n",
>> +                compat);
>> +            continue;
>> +        }
>> +
>> +        ret = of_property_read_u32(node, "sdw-instance-id", &unique_id);
>> +        if (ret) {
>> +            dev_err(dev, "Instance id not found:%d\n", ret);
>> +            continue;
> 
> I am confused here.
> If you have two identical devices on the same link, isn't this property 
> required and that should be a real error instead of a continue?

Yes, I agree it will be mandatory in such cases.

Am okay either way, I dont mind changing it to returning EINVAL in all 
the cases.

> 
>> +        }
>> +
>> +        id.sdw_version = ver - 0xF;
> 
> maybe a comment in the code would help to make the encoding 
> self-explanatory, as you did in the DT bindings
> 
>    Version number '0x10' represents SoundWire 1.0
>    Version number '0x11' represents SoundWire 1.1

Makes sense, will fix this in next version.
This info is also available in bindings.


--srini
> 
>> +        id.unique_id = unique_id;
>> +        id.mfg_id = mfg_id;
>> +        id.part_id = part_id;
>> +        id.class_id = class_id;
>> +        sdw_slave_add(bus, &id, of_fwnode_handle(node));
>> +    }
>> +    return 0;
>> +}
>>
