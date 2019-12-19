Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A82EC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEB5227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xk3y9Uvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLSR2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:28:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54428 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfLSR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:28:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so6273162wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KM9qiMDfWKFWWdCAAPZQUcLR4rcoEPUjfLdlA5II0go=;
        b=Xk3y9UvfTT0+Ov2hyWIqLRGjMtYrhB1HcKktCLIY0h/JLmVYGwjuV1P6zpdiJh8qNR
         TmcZB+0dGj0Ko3YCsB5487mevpccX9VqujsdaaNeoIbRIPcvy+J99YXACmc1m25VD2A7
         iDPWOs6laaTvmsHw+2v027T3QnXfBukqPbs2fuaxKJaX3o1acyRS0+qG5C+fpC8cvg+1
         78LrhSHW5jUUSCN4QsQMGkQ/4wB7aT1m9qMe2lTBVhHnmT3k5z4zpBhg9A1tRkeSuU8e
         UnuM4Va7wx0yd+kY6cgbyjh7Ha/FSiT/CTkLVrOx349EcPEat7shDxLuOkLv9fpX6B48
         n0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KM9qiMDfWKFWWdCAAPZQUcLR4rcoEPUjfLdlA5II0go=;
        b=Drz9wWflXlpMW+mS9MzajzFRDBhrQG11Qajf0QewyJSYaLF0tREvyxEAiRFoKbVp/S
         wJ3lotKjvgnlA5acGeJMdqTaOLhnAEmP5YLIDUyVzLOz5sF347pAA2M4lh3lVjNLbGHu
         kdjIexvtGQQq24+XMv093Vb8xORWe/u3N+qXIffyXoN7vQABZL/48v+o69oVkz5ON4My
         7JHH4gvmdO+SaKnt93Sivad29TmtGveG/ZMRDrEm2AbYz4QGweKlgma5cvxHEZJ7ODmo
         kjJS+VIhooA23bfPjP5/cjX8MqSPih9jzOfmjwPjIr3zYpStIv/LtSOySOi11iQ8+WRn
         t1cw==
X-Gm-Message-State: APjAAAVg7bGPySjePWC6WC2v7Kw+8Six1HIX3w3yO1/SSyl7CglUfBPt
        bXuvQYEnzBVWUapj2xM5hgwg3A==
X-Google-Smtp-Source: APXvYqxEChvbzvXz1AWKw3LjAHZoXrlun6tgfrVy7bOQosew+hDZAwYPv96u+0LKl9otucSH4hTVGg==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr11102986wml.83.1576776520153;
        Thu, 19 Dec 2019 09:28:40 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n67sm6887821wmf.46.2019.12.19.09.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 09:28:39 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH v6 02/11] mfd: wcd934x: add support to
 wcd9340/wcd9341 codec
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, lee.jones@linaro.org, linus.walleij@linaro.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        devicetree@vger.kernel.org, spapothi@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20191219103153.14875-1-srinivas.kandagatla@linaro.org>
 <20191219103153.14875-3-srinivas.kandagatla@linaro.org>
 <af48cd71-fa1a-dbc5-0e88-e315ea13c28c@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <db36d6d7-40a2-bbd2-f299-838abf4d92cc@linaro.org>
Date:   Thu, 19 Dec 2019 17:28:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <af48cd71-fa1a-dbc5-0e88-e315ea13c28c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/2019 16:36, Pierre-Louis Bossart wrote:
> 
>> +static int wcd934x_slim_status(struct slim_device *sdev,
>> +                   enum slim_device_status status)
>> +{
>> +    switch (status) {
>> +    case SLIM_DEVICE_STATUS_UP:
>> +        return wcd934x_slim_status_up(sdev);
>> +    case SLIM_DEVICE_STATUS_DOWN:
>> +        mfd_remove_devices(&sdev->dev);
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
> 
> this is interesting/surprising - I just noticed what looks like a 
> significant change in how probe/initialization are handled.
> 
> It was my understanding that in SLIMbus the Linux devices are created at 
> probe time, and when the device reports present this 'device_status' 
> callback is used to notify the codec driver of a change. The rationale 
> for this was that the codec driver may control power switches/gpios that 
> are necessary for the device to appear on the bus.

We use same rational here to power switch and flip reset pins in device 
probe to power up the actual SLIMBus device in device probe.

Only difference here is that the actual SLIMBus device itself is 
represented as many child devices based on there functionality.

SLIMBus parent device in this case is MFD device which is created at 
probe time. However child devices for that device like gpio controller, 
codec, clock controller and soundwire controller are created only after 
the device is enumerated on the bus. Before that none of these devices 
will be in a position to talk on the bus.


> 
> This argument was used to require an change in the SoundWire 
> implementation, so we followed this model of creating devices at probe 
> time based on information reported by ACPI/DT, and used the 
> 'update_status' callback when the device is present on the bus (which 
> may happen after a delay or controlled by an external power switch). 
> This approach can lead to 'ghost devices' described in firmware but not 
> populated in hardware, and power management opens on how long a bus 
> needs to remain active if no devices report present.
> 
> What I understand from the code above is that the devices are actually 
> created when the SLIMbus device reports PRESENT, which seems a 180 
> degree change in directions?
> 
Note these are the child devices of the MFD SLIMBus device.


> I actually prefer it this way, and all current discussions in MIPI 
> circles point to the fact that when the bus starts all devices on that 
> bus should already be powered and have the ability to report present 
> immediately (if the bus starts in a 'safe' mode and then later programs 
> different PHY parameters, a device can no longer join the bus)

In our case we need to switch on few regulators and flip the reset pio 
to be able to bring the device to enumerate.

> 
> I would however not remove the devices when the status is down but only 
> on an explicit .remove.

Am open for suggestions but I would not like the child devices to talk 
on the bus once the SLIMbus device is down! Only way to ensure or make 
it silent is to remove.

Thanks,
srini
> 
> Feedback welcome.
> -Pierre
> 
