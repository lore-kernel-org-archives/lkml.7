Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D817DC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9985C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ui/NihjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfEWInS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:43:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46915 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWInS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:43:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so5245830wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+LCxAheRB5qj77eljS/M2DLhUcgp+C7BPN+J7IFDhdI=;
        b=Ui/NihjZ0pUjUW2sMbKku3wVCIrB8aJgyCELcpQNnt/LzhlDqPTjENf7NL7GRsisW5
         RBvgc7sdX00PJos/YG8V1Uaj2zzu3+z1trLNdbQ7G5L4WucXjFbf9tbMHfF6ycNlZ8CN
         ceuHElvJWD2CfdgUCvqatSXfi6Onvd5tMNhnht9+EydUN6cesGkrFUZEtpH07nBArc9m
         98HnR0hy255/Mb2J8A9TdSX4ARB+zzHzNU2F5n+xGj7PCLEpz7Q+VSob44ebkjuZnNEs
         cj8qN9AHrrjs1dDX1mSik0E1DGInk2eNLaQdN95AkjeYhtt/r8tXq55fu0OsaX/ff8wL
         3XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+LCxAheRB5qj77eljS/M2DLhUcgp+C7BPN+J7IFDhdI=;
        b=d4YKMAjK8fVUYKNeqvom5+OCYV2cdPvpWFWWxfYUSChcEBQSH9a33k5LLRkM499sa+
         kzjHAf+zaSdvGPyqdAxe7vYJU80OV714lx7dToZaAwQekTaU516zQxMFg6PBJDtQALSH
         PTMH8d3lYAv2qjt55akw8pBgHWUul8S4hOUMS1nPDWptBNNwEOPUu5Vbv0QFs77lU+17
         mU8FNgJkRzhacw/J/AWhwi7DfDy2BeGpWgiRWgjOaHYBZ6/8rJFDjTVfx1GffCaLZIwe
         TZLrBNPU/Bkj4gvNz8gnyDRMTiiXU76k8x+IQVlQsKnZKpwL/cKwmnRlKdNcPuO7CDgr
         MI0w==
X-Gm-Message-State: APjAAAXB0kDnL0Tnm8lXPFHBvaXVJwva/DZNjY97j0Z+T8ALMSyKdPIE
        iGeTsl98WThdNQhqOPOZkbDdi8dXQ9VPIw==
X-Google-Smtp-Source: APXvYqxyi4aASx0zjHHgh92IIp9xuwbeTDlL4GfAU8mgGRhZ9PmpEAyuP80j1M/++Do9dCrCOJXkpQ==
X-Received: by 2002:a5d:4ec6:: with SMTP id s6mr51133938wrv.184.1558600996450;
        Thu, 23 May 2019 01:43:16 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id g2sm28814885wru.37.2019.05.23.01.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 01:43:15 -0700 (PDT)
Subject: Re: [PATCH] soundwire: stream: fix bad unlock balance
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
 <4744834c-36b1-dd8d-45fa-76c75eb3d5cb@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2dc66f9d-e508-d457-a7d6-c06c4336e7b8@linaro.org>
Date:   Thu, 23 May 2019 09:43:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4744834c-36b1-dd8d-45fa-76c75eb3d5cb@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2019 17:41, Pierre-Louis Bossart wrote:
> 
> 
> On 5/22/19 11:25 AM, Srinivas Kandagatla wrote:
>> This patch fixes below warning due to unlocking without locking.
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
>> index 544925ff0b40..d16268f30e4f 100644
>> --- a/drivers/soundwire/stream.c
>> +++ b/drivers/soundwire/stream.c
>> @@ -814,7 +814,8 @@ static int do_bank_switch(struct 
>> sdw_stream_runtime *stream)
>>               goto error;
>>           }
>> -        mutex_unlock(&bus->msg_lock);
>> +        if (mutex_is_locked(&bus->msg_lock))
>> +            utex_unlock(&bus->msg_lock);
> 
> Does this even compile? should be mutex_unlock, no?
> 
> We also may want to identify the issue in more details without pushing 
> it under the rug. The locking mechanism is far from simple and it's 
> likely there are a number of problems with it.
> 
msg_lock is taken conditionally during multi link bank switch cases, 
however the unlock is done unconditionally leading to this warning.

Having a closer look show that there could be a dead lock in this path 
while executing sdw_transfer(). And infact there is no need to take 
msg_lock in  multi link switch cases as sdw_transfer should take care of 
this.

Vinod/Sanyog any reason why msg_lock is really required in this path?

--srini

>>       }
>>       return ret;
>>
