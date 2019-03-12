Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61DA20883
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBmsDmz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfCLKoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:44:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34622 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfCLKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:44:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id o10so1812308wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BDcnt6Z8vAm+YEVlU50WtVQsVbYh13yvvXg+KJktTUY=;
        b=UBmsDmz8Jw7cGLZrCAzjGsQ8C/QHuf6HkfTIahq0DsCx+un/UkS86W9jGPqTMEMKuJ
         fuWnZ15Y56KVA0upFJMrN8f9EllxT2TzPzIKqAgK9O5C7bSgPrRiUBGjFFmTAeJ+ukiG
         zmE5YmTw9BZG9hN8LOlPWHD/30P60VuSH9zIbC3yNLuUG8IaNq2qcv6NGhjEsfXpw+hZ
         2Ix+0s9WwFR8aJEhqN/xGGz+n6CLzpLXSzian4LuEg7fUF//AtMY0BPVzzRBk/gzAFlw
         1yUsJWJz2h+CT01DctYRa5TXf/PlOsuHwYv6dlrIqUvzkMQwuMdWL2rzoLhI0M7+5BP9
         t+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BDcnt6Z8vAm+YEVlU50WtVQsVbYh13yvvXg+KJktTUY=;
        b=QHtkHeoZuDvK9v6pgmxqZmBLBiiOM33tHYpDff5ytyiVxw6tFofdMs3cm3C0rWIY/O
         9wzjbV9TWs/o0oM9HFF8pyC7o3Jvzr3IBAJJSZphTOWsxS5MhZOBErcEnjjUuWruGOlx
         GOMCVsDXxcHcnmS6x9yPAAlaRfAHGr1PmUBxejjMn8yIJqonoaE5iNHFCO6uhrxKU1Rh
         PFfuuGtZsHZYPVDgAdCVMSfm1iFvVf/5ouSSCuPgB9rqpvs+4jjBqvCIAHf134p3Q9hR
         FruHSgbuensypQ1rksosdF3znc0x5sTxslZ8s5j8vOinlbdd6MJV0GabZM2kH8Dwf9nL
         9SKA==
X-Gm-Message-State: APjAAAWDi8GjfK8/3fXzOW5hpamzl+l/5NQda+y64AsqCzeui1ZjSPHa
        EvKk3+59OivIf+1BLdKPxIPGTg==
X-Google-Smtp-Source: APXvYqx68ftyZOPrF8PFC0mS2BtjeMwr7P6KXQ6yxi6qbJgk4R5U1k6JeM7a0MmO3n2kPcvhr99a/g==
X-Received: by 2002:a1c:96ce:: with SMTP id y197mr1954766wmd.126.1552387449114;
        Tue, 12 Mar 2019 03:44:09 -0700 (PDT)
Received: from [192.168.0.41] (211.250.95.92.rev.sfr.net. [92.95.250.211])
        by smtp.googlemail.com with ESMTPSA id c10sm9375450wrr.1.2019.03.12.03.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 03:44:08 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/oxnas: Fix OX820 compatible
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-oxnas@groups.io, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
References: <20190312103256.13565-1-narmstrong@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e7c6cbe1-f3c8-bd94-b266-e3068f9b4776@linaro.org>
Date:   Tue, 12 Mar 2019 11:44:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312103256.13565-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2019 11:32, Neil Armstrong wrote:
> The OX820 compatible is wrong is the driver, fix it.
> 
> Fixes: 2ea3401e2a84 ("clocksource/drivers/oxnas: Add OX820 compatible")
> Reported-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clocksource/timer-oxnas-rps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
> index eed6feff8b5f..30c6f4ce672b 100644
> --- a/drivers/clocksource/timer-oxnas-rps.c
> +++ b/drivers/clocksource/timer-oxnas-rps.c
> @@ -296,4 +296,4 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
>  TIMER_OF_DECLARE(ox810se_rps,
>  		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
>  TIMER_OF_DECLARE(ox820_rps,
> -		       "oxsemi,ox820se-rps-timer", oxnas_rps_timer_init);
> +		       "oxsemi,ox820-rps-timer", oxnas_rps_timer_init);
> 

Applied, thanks!

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

