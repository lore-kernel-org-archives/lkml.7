Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC48C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19F22083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCo7O2C8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfFFO6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:58:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43628 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfFFO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:58:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id r18so2758199wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QujUueqFUx2/VSrL+HZmRN292Qq0Dhoh8CSUM41nf2A=;
        b=ZCo7O2C8yP4nwdUG6GBa7j3UmhQfPthiEWab3oypsGCItJN5tuZZ11EJ9UiZiiFdnG
         x96ys34BGhcW3sNOsQ+lWZMOb12EMkuf3pSGBDJYQbwmNyfKoGfI80RFTli7u2DGBg/9
         XJ80NBhRd+O0no3dkGRaqslAStOx+NFMDbunqpAnSqal3hJj2KsoYOlp91q6PmT2NqvE
         3/JXvNTUENLYhCoaZasLzE6P99EByMOe86MhrtudILbtxuWaXYU0By8UwXKHDuZaXg3X
         HXny8/I/wPSsTthKpSupdSaz4scGB6yuXsSsiAeQepzVx1uf+XTkuUlOcYAqE1NOimjJ
         BXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QujUueqFUx2/VSrL+HZmRN292Qq0Dhoh8CSUM41nf2A=;
        b=RLTVJl8HDQDw4EOdknNpmkhySNh10jQDAcpn7/JaCU32mistdGtnweoEuT1fQRanRA
         ebg4+N8B+qc/AoVcpfj4psgAyqPprbVuTIRKqYfxRzM3FGJNj3T11vZUHr6etAhF+b77
         XrJsqJYkGCjTxOlKoz9TxOlfC3WC+bcexBgdkx+tBIOUxeHbj5yHkyV7sSIHK8Hegalm
         FAIMQbBoCGbuYPMdlSUijEJ+KZVGuFQXF7qTRBjHUeI01fmAWU0Bbig0rOxylGqY3a/m
         i5PTdV+yo04rCpDFG7lS/6CfQjGNcy8wTs8iXgX9aDmy/McrlnyiVZnYIxzNh7yQ0Wct
         XLxQ==
X-Gm-Message-State: APjAAAVcVpaRtPhD1IB3AuoHeLUvp2BkAwZzTV/NcbeNBs3FlTpsyZZe
        yPV1Swso0XMXnORkSO+g9GYnD5vziFB4ww==
X-Google-Smtp-Source: APXvYqzZxEOJPWQeIL+UsyHAq9cz1Yc6pAWJ9MgF/JfNneHwBH0kgD+JhRh8xYlf8ptsNnwIVBVw6Q==
X-Received: by 2002:a5d:518c:: with SMTP id k12mr30386901wrv.322.1559833114696;
        Thu, 06 Jun 2019 07:58:34 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id z17sm1983993wru.21.2019.06.06.07.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:58:34 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2] soundwire: stream: fix bad unlock balance
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190606112222.16502-1-srinivas.kandagatla@linaro.org>
 <9427a73a-e09a-4a9c-7690-271d2e2e1024@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f13c82d2-94a4-9517-bcf6-95aa40c6a42f@linaro.org>
Date:   Thu, 6 Jun 2019 15:58:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9427a73a-e09a-4a9c-7690-271d2e2e1024@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/2019 15:28, Pierre-Louis Bossart wrote:
> On 6/6/19 6:22 AM, Srinivas Kandagatla wrote:
>> multi bank switching code takes lock on condition but releases without
>> any check resulting in below warning.
>> This patch fixes this.
> 
> 
> Question to make sure we are talking about the same thing: multi-link 
> bank switching is a capability beyond the scope of the SoundWire spec 
> which requires hardware support to synchronize links and as Sanyog 
> hinted at in a previous email follow a different flow for bank switches.
> 
> You would not use the multi-link mode if you have different links that 
> can operate independently and have no synchronization requirement. You 
> would conversely use the multi-link mode if you have two devices on the 
> same type on different links and want audio to be rendered at the same 
> time.
> 
> Can you clarify if indeed you were using the full-blown multi-link mode 
> with hardware synchronization or a regular single-link operation? I am 
> not asking for details of your test hardware, just trying to reconstruct 
> the program flow leading to this problem.
> 

Am testing on a regular single link, which hits this path.

> It could also be that your commit message was meant to say:
> "the msg lock is taken for multi-link cases only but released 
> unconditionally, leading to an unlock balance warning for single-link 
> usages"?
Yes.
Vinod can update comment while applying this patch?
If not I can respin with correct log.

thanks,
srini

> 
> Thanks!
> 
>>
>>   =====================================
>>   WARNING: bad unlock balance detected!
>>   5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G        W
>>   -------------------------------------
>>   aplay/2954 is trying to release lock (&bus->msg_lock) at:
>>   do_bank_switch+0x21c/0x480
>>   but there are no more locks to release!
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/stream.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
>> index ce9cb7fa4724..73c52cd4fec8 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -814,7 +814,8 @@ static int do_bank_switch(struct 
>> sdw_stream_runtime *stream)
>>               goto error;
>>           }
>> -        mutex_unlock(&bus->msg_lock);
>> +        if (bus->multi_link)
>> +            mutex_unlock(&bus->msg_lock);
>>       }
>>       return ret;
>>
> 
