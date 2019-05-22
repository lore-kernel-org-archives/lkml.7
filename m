Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EE6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B7B2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XcyY4WXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfEVQls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:41:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44741 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbfEVQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:41:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id w13so3044568wru.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sbhOGAbtcKTzipHe+6ukR9cpuuf9VG40HYXxIntAhB0=;
        b=XcyY4WXXFw70B9fdO+rkpFJ0hwLYh0XJOkRtNcSIfeld6DIqXrNxovSmn8Q9tnmkF3
         RNiHDgSrUlvgyI9ZSGm+eLQWlKCGbfA8WC3cVFXmwJ76xqua3sWViYTJcQYR1dKJEkXe
         XCxtkSwMcGm9sWtCqMYbtaHnl+0dosnu9DNTl3QAKAe70N4vUq6uyHLog76qvyHWo4Yx
         7Gi917ue1ON4dIctHcyvcnQTrxjgl8tHLALSm0d6pQeec/kv41D2cnzNOtJvGPZAaxdv
         z4D3Cn1BwzaMohN88kEQx01Pl/82Bn4O+FDnS9oKLtxrV472EkHZzq6J75DcjsAGi8Kw
         FlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sbhOGAbtcKTzipHe+6ukR9cpuuf9VG40HYXxIntAhB0=;
        b=qlG12Mj7CF8oC6HVmCSBUiqlOEfx5UM1DD7TQSqh2pOkrPqOaRkmEKsRKpCSLgRb4B
         R8bKYI+qgXdlMlaG7f58sj6PAhv2pLVYaJ7n9r+IbvtaJsfUQI/35cW2Cujr0Qekossr
         d3cIhJF0vPyrwZ2N3X2g9fzNhslpR1l+fuL7IJ4MRQ/vXpxqylf9JKwcbK00AcZ+Vc8m
         EJog/FmDA/YPV2tU9AqON2+bVKALXtESX7DERWClhvgEjHVMyDhETp4r4VD36XGKwbZm
         nWx5nA2m8bVay/Y4y6EcCT8pyRdtzNyVSYmTOJi+VBQD7u67n1nPIJiNBE8R6zAntTrN
         FcYA==
X-Gm-Message-State: APjAAAViwjHLF50S0ZdrQ/6iuiEbkA3CUWRPomQaxtUq8MguTX1JCZ3m
        eZyfUkZE4+AjQojZ6ndLmEXLAU6br+usqg==
X-Google-Smtp-Source: APXvYqyabt9t6mvb2Rbgd5JPZXUcoQm3HtZAru2XT9jUT1pGAQfCl/23vVC7beDnUJgJQcEXJy0ucA==
X-Received: by 2002:adf:8307:: with SMTP id 7mr44588183wrd.86.1558543305870;
        Wed, 22 May 2019 09:41:45 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id z4sm26594740wru.69.2019.05.22.09.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 09:41:45 -0700 (PDT)
Subject: Re: [PATCH] soundwire: stream: fix bad unlock balance
To:     vkoul@kernel.org
Cc:     sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dd34d1ba-b8b6-7882-3e71-d036a97f41df@linaro.org>
Date:   Wed, 22 May 2019 17:41:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522162528.5892-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2019 17:25, Srinivas Kandagatla wrote:
> This patch fixes below warning due to unlocking without locking.
> 
>   =====================================
>   WARNING: bad unlock balance detected!
>   5.1.0-16506-gc1c383a6f0a2-dirty #1523 Tainted: G        W
>   -------------------------------------
>   aplay/2954 is trying to release lock (&bus->msg_lock) at:
>   do_bank_switch+0x21c/0x480
>   but there are no more locks to release!
> 
> Signed-off-by: Srinivas Kandagatla<srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/stream.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 544925ff0b40..d16268f30e4f 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -814,7 +814,8 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>   			goto error;
>   		}
>   
> -		mutex_unlock(&bus->msg_lock);
> +		if (mutex_is_locked(&bus->msg_lock))
> +			utex_unlock(&bus->msg_lock);
Looks like I messed this up!

I will resend this one!

--srini
>   	}
