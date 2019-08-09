Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2C9C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560052166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpCkRRnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfHIIYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:24:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50601 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfHIIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:24:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so4828813wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8CRcuLlZBVUoudDmKIo2V95xe+m342E7hqInXMzRQt8=;
        b=hpCkRRnRSXdDdd+u+TyuDO6eNse5HxqOgqPvragd7b+RDtJkx9YLO2C4uiJbN14bJA
         9tayvMQ3/TW7TeIbSLVrxmffwymAR0mpib3vKHYh8/xACPg4fAo6aVaM/0Zn2y1D5/Jp
         PFXcwCIjwCZ3/+rKuCpZZ2TOHmEKA72vKoL9OurIyQUNlVK6CUspyygJ933U03FmP85A
         vKEDVcozT0bJsYUS1CRjuaC9wA3a+7kU0KWYpTMKFqS1cbJtI5kANEty4VAXgcXh4uBu
         RgaIGgV7T9I0drXfpAntSNjFN+nVodqv+AZE6KjtF+bBCPCOdDx3vQileD9dmA2NR0XL
         MidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8CRcuLlZBVUoudDmKIo2V95xe+m342E7hqInXMzRQt8=;
        b=CKi9+lqseWzwlqUiiZkCXN4gSa/N/rlD1WHmFAhrR5D8ojnMH1kXKTL5pkpNcltSFK
         mr8F29OvF5mq1Fst2X/tvm1STLrI0xT1Dp5Wj+QwnSisy7CILS1wm7KpV4iYZV//kpCD
         /4pSdivG8yF0CZYuWUgnFWzafSuPQdqfIgDH8FYKrQM4+V3vUA5OixQdYWRtFfDBhAZ3
         +TAp5SmQHuirIngIw/R3MGkHAXlOb3t7xMlZEcIO/lDgfkqCEbpAcKGBJK7WTgs7N4US
         b0cUkNWtGc9aAUIKWmhmeZC+egZRgaAvG/69iXCmu8FvCKe2Jr7iua8uJ3zrMcUrFdyv
         qs+g==
X-Gm-Message-State: APjAAAVRBZIAALLVssNThz1Os8MLnpbPFshGV0es+08YBE9Sj84aYBt3
        JzYwbqyWV01LRAZ/IxnwVB6lOLfI49U=
X-Google-Smtp-Source: APXvYqyVzJUw2M7RRl4NadS2ltOeMpoO+u8ylbDe75BC7y7RRzAQad3Qs+baCXwnoNQwkk2wXSyA3g==
X-Received: by 2002:a1c:c742:: with SMTP id x63mr9871453wmf.0.1565339087435;
        Fri, 09 Aug 2019 01:24:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id w23sm4730828wmi.45.2019.08.09.01.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 01:24:46 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] soundwire: core: add device tree support for slave
 devices
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-3-srinivas.kandagatla@linaro.org>
 <42ca4170-0fa0-6951-f568-89a05c095d5a@linux.intel.com>
 <564f5fa4-59ec-b4e5-a7a5-29dee99039b3@linaro.org>
 <20190809054602.GK12733@vkoul-mobl.Dlink>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ff9144ce-a4d1-a3fd-ab49-256367413b11@linaro.org>
Date:   Fri, 9 Aug 2019 09:24:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190809054602.GK12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/08/2019 06:46, Vinod Koul wrote:
>>>> +int sdw_of_find_slaves(struct sdw_bus *bus)
>>>> +{
>>>> +    struct device *dev = bus->dev;
>>>> +    struct device_node *node;
>>>> +
>>>> +    for_each_child_of_node(bus->dev->of_node, node) {
>>>> +        struct sdw_slave_id id;
>>>> +        const char *compat = NULL;
>>>> +        int unique_id, ret;
>>>> +        int ver, mfg_id, part_id, class_id;
>>>> +
>>>> +        compat = of_get_property(node, "compatible", NULL);
>>>> +        if (!compat)
>>>> +            continue;
>>>> +
>>>> +        ret = sscanf(compat, "sdw%x,%x,%x,%x",
>>>> +                 &ver, &mfg_id, &part_id, &class_id);
>>>> +        if (ret != 4) {
>>>> +            dev_err(dev, "Manf ID & Product code not found %s\n",
>>>> +                compat);
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        ret = of_property_read_u32(node, "sdw-instance-id", &unique_id);
>>>> +        if (ret) {
>>>> +            dev_err(dev, "Instance id not found:%d\n", ret);
>>>> +            continue;
>>> I am confused here.
>>> If you have two identical devices on the same link, isn't this property
>>> required and that should be a real error instead of a continue?
>> Yes, I agree it will be mandatory in such cases.
>>
>> Am okay either way, I dont mind changing it to returning EINVAL in all the
>> cases.
> Do we want to abort? We are in loop scanning for devices so makes sense
> if we do not do that and continue to check next one..

That was my inital plan.
Pierre suggested a better compatible to include instance ID and LinkID 
so this check would be part of the check one before this line.

--srini
