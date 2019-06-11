Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DF9C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7074206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7qmYfLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbfFKK36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:29:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37022 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFKK35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:29:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so12396565wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M85tDvSO1y/yeeXKIT4QQ+Mi/qHlL9lRNm7SAqISA7I=;
        b=y7qmYfLCKTDOn5agwlJpK0d/8R5GPbL3CHKyjAmTfPsU5SHzSZTRSeo9ltk0UBq7TS
         tca01mVkEJ6KgwzyaTcSGkcZZZ21tbYvjK1onqMspHJr2xvkp0875BvxvYkq0q4eo9Ew
         pvAmMlnVzbmx/yCj6O4J07Ubi9mRQwb5Fys/o4Y4RVNIuRyrDW4mRqwyVnGcJ8Em5j6x
         CmrDUvMVbyDSevWGOyKFJ6fErZMisHGvKsrz09zacpIAjomTQTDmaY5Gts1SnmyUKVa2
         7IMgEV77vtYBJnDMrH3AxZ7kvg2XNfvAvsVr6A8pZZqS/ms4y0odVPTeK3M2gq5SISbS
         /Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M85tDvSO1y/yeeXKIT4QQ+Mi/qHlL9lRNm7SAqISA7I=;
        b=Znlpfgqho6nY5yZ6y3S+BLmW7WPrOx35tqKULx1bgh6oCkP0QV/JTyfhQ9ekUPC/B7
         w/snPzfvHZZ74iaLt4whuJsZa5x8E2uDLmVy5fXuwbIbPTZyeSWHmzeu6T/daY0HXJ6Y
         7s9E7vtJ7gbb4w8Hcc53nv92j0RH5UOzybbKefQ/0GIt9YsiQyGLu2n4IdPStlJMpe/u
         OyERgpioCaHOswbCoeCq9Qm9MeUE6c10s2z49HtKHOnUh+NpjVtjSgLWRbIBttLf/agQ
         w9Kf0QRur8xRqbTKU+cqO409TuSxB8B6NpQPP8ybpi9sOPvLscRz2v5orASIm9BO1z2o
         RzgA==
X-Gm-Message-State: APjAAAUi4ZDEBP4QV9KWWyIOeNq68mWaJCG86/CDLpf4T8u9V8MbIDeo
        7T4DwheNv+enDplVrEsszwmWVA==
X-Google-Smtp-Source: APXvYqwxt7HB9+C3etBO06tZ96K8l6qG1G2Lj6oFtJDgC06knZVDdMfbFtxWP1l0oE2q0m0iUvSpNw==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr12045880wrx.63.1560248995982;
        Tue, 11 Jun 2019 03:29:55 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x11sm3017513wmg.23.2019.06.11.03.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 03:29:54 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 6/6] soundwire: qcom: add support for
 SoundWire controller
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-7-srinivas.kandagatla@linaro.org>
 <249f9647-94d0-41d7-3b95-64c36d90f8e8@linux.intel.com>
 <40ea774c-8aa8-295d-e91e-71423b03c88d@linaro.org>
 <7269521a-ac89-3856-c18c-ffaaf64c0806@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <462620fc-ac91-6a36-46c7-7af0080f06cb@linaro.org>
Date:   Tue, 11 Jun 2019 11:29:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7269521a-ac89-3856-c18c-ffaaf64c0806@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2019 15:12, Pierre-Louis Bossart wrote:
>>>> +
>>>> +    if (dev_addr == SDW_BROADCAST_DEV_NUM) {
>>>> +        ctrl->fifo_status = 0;
>>>> +        ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
>>>> +                          msecs_to_jiffies(TIMEOUT_MS));
>>>
>>> This is odd. The SoundWire spec does not handle writes to a single 
>>> device or broadcast writes differently. I don't see a clear reason 
>>> why you would only timeout for a broadcast write.
>>>
>>
>> There is danger of blocking here without timeout.
> 
> Right, and it's fine to add a timeout. The question is why add a timeout 
> *only* for a broadcast operation? It should be added for every 
> transaction IMO, unless you have a reason not to do so.
> 

I did try this before, the issue is when we read/write registers from 
interrupt handler, these can be deadlocked as we will be interrupt 
handler waiting for another completion interrupt, which will never 
happen unless we return from the first interrupt.

thanks,
srini

>>>
