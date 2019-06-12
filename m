Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60184C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8132173C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 16:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E63OiXss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440195AbfFLQCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 12:02:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36630 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440183AbfFLQCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 12:02:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so12596238lfc.3;
        Wed, 12 Jun 2019 09:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SjJp7DDkiTkAIzDEQcNIlyJ4kV4kLIt3hJDkNsAGJWo=;
        b=E63OiXsstjGjJSAKzxJKHdTInL9TZi7AUCpOB2bBLTZEdXZFZ4EmPK26sKgqhIrVpP
         baTjbh2F7jwLuaHTsQek7q4HL8MbtDQtfmCbPDVUv/+PPH+dI/nOxjNTX9qpblAA4Epu
         GUGBpSRNJXZY3ALCL1tEOs1Qp9ZCDkokJM1NTmSnxpVuI8qNf63uSp4aUZPKnG8ru4WF
         osS9JkhK/OaztKMIzuRjnSDXRcYU5qyqdZ9ROXLzmJ94dnOQEJcFuqgLiLZ2dKkD8UM4
         Be91oNusy9jWas6U3t81ZVXN7EzLXOYcn7ojXpHDYbM8mlTZanPbsXfCiBSrLBUuUG5/
         asSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SjJp7DDkiTkAIzDEQcNIlyJ4kV4kLIt3hJDkNsAGJWo=;
        b=LlcFir+Dz0OtlQzrba+eZjOdjBsW5AkEkR4QrbcHp7FudZ1QMTwUHGpZ7NDAdH/Ztp
         nW2OiItBdkg61EHWotDajLmrr19uyroAwiGgD6+QmjcjrcLiPXJP4vqNt+CZiWAQXe5u
         +UhMdTaFALqWp5W25tCIFLJoRl0OPhzN9iIzmMvIg6QrGn5t2VmbxPwsErE0YUR/mLF2
         VUd5rUEO5M3iCj74ukJVq6/dGJXmTYo6vzYtkD1/anStpgPCqtddsAtPLkdEfgW6Mhf3
         NhQYsuOfih4smUQHkCTI3W594SEQbNCw+ugGAEyLdWYlzdapmP8RibW76sKtj9RfG2C4
         fqLA==
X-Gm-Message-State: APjAAAV59e7xZFHF4c78mQkiKZrVRgIopZvEwlkSj9IYzqKR8K8gqB5e
        7rl3JdhtLAHF5k7dWdqNnkeTcxIF
X-Google-Smtp-Source: APXvYqwX7GJ/BDXweSMZpvDrziPK1p6zuUVVXQuDWZM6aAmkaZDMQw0Gu4p+TaRml6JSHsGK/HZQRg==
X-Received: by 2002:a19:4f50:: with SMTP id a16mr41032680lfk.24.1560355341462;
        Wed, 12 Jun 2019 09:02:21 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id u128sm44485lja.23.2019.06.12.09.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 09:02:20 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] clocksource/drivers/tegra: Restore timer rate on
 Tegra210
To:     Jon Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190610164400.11830-1-digetx@gmail.com>
 <20190610164400.11830-2-digetx@gmail.com>
 <17eac2c4-41fa-a616-83e9-fa18a9e1483d@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9ca69eec-c4c0-d798-9946-ed7f0bb3050d@gmail.com>
Date:   Wed, 12 Jun 2019 19:02:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <17eac2c4-41fa-a616-83e9-fa18a9e1483d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.06.2019 11:30, Jon Hunter пишет:
> 
> On 10/06/2019 17:43, Dmitry Osipenko wrote:
>> The clocksource rate is initialized only for the first per-CPU clocksource
>> and then that rate shall be replicated for the rest of clocksource's
>> because they are initialized manually in the code.
>>
>> Fixes: 3be2a85a0b61 ("Support per-CPU timers on all Tegra's")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/clocksource/timer-tegra.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
>> index 9406855781ff..830c66e2d927 100644
>> --- a/drivers/clocksource/timer-tegra.c
>> +++ b/drivers/clocksource/timer-tegra.c
>> @@ -277,6 +277,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
>>  		 */
>>  		if (tegra20)
>>  			cpu_to->of_clk.rate = 1000000;
>> +		else
>> +			cpu_to->of_clk.rate = timer_of_rate(to);
>>  
>>  		cpu_to = per_cpu_ptr(&tegra_to, cpu);
>>  		cpu_to->of_base.base = timer_reg_base + base;
> 
> Thanks. This fixes a boot regression we are seeing on -next with
> Tegra210 (introduced by the commit referenced above). So ...
> 
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks for the testing :)
