Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D44C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1F420833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qK6Q5tOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfFQOle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:41:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43562 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQOld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:41:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so10227105wru.10;
        Mon, 17 Jun 2019 07:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DgQ2aFFaMuedqeg/T0B3p6R/q8u5IJuWcTl2OYiCMQc=;
        b=qK6Q5tOJo2T7nE3BnfMo+6u/ZmMmySiXhG2FxO6ZignoMh9qdTDr+JXVhj7eVi3tBu
         hCi78EtTMc6FP3f7anV6ixE6xd9d3f1JCgmzb6TGs8Lt6ypn6JBaXwxS2pLWghuo3Bi4
         1Nkjqjh/g8wkzuNhrk8mGF7C/mMxFaxqrfkitpTB9ytJ6TNHxm83BWj7fXDX4Zx/NQPM
         FzVwdkF4sJPn5D/ADkXYMupEqy0oe1wC1TbNwYIpgZWYTvS6vWNAxEERx6Dxxc2IeeKG
         Zgu5fMwnOLBxaLnsTgFe4nvUBPbDtyXBXBoTbQmOJTSc/io5PhttO9pIokmYkO95JGoD
         cEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DgQ2aFFaMuedqeg/T0B3p6R/q8u5IJuWcTl2OYiCMQc=;
        b=BNokqjWXZLBleRg+88ChPY7ucw2zle0VefcJ3S0zuA9J0bFz9FhSUkGRP6K1g3pLTu
         IxpTj7ejWeIOaBd+YXNkTQDm84fCtSRCLlMN38NfIRz2EbmPf0RvQtKbVKSD+ZFiYVKM
         wfkN75/2Urk+QAYx2EuOLzhipCJLPa6d2tMV8mSHAITd8dwK42B4O2GZFqtQryXbZSKa
         tXJMIlIx2k4zZpJJZAmil6O5vrqN0q/yWaezk4VBWdraowiGvbiO9MqjMsT/QQzNSeqR
         iHtyQzKr0wn1sTkd/IX7uW0F5Mc27+a3Agegywbg0L8E2bPg834rzpMXw4J5tkb5MyUw
         zyMA==
X-Gm-Message-State: APjAAAVwgbBHyUdoJt41ldyPAOexpe4eOSKcH8HDTCBg7CAEDctjNhER
        Bns8pMZanRUKPSZ5BW9MxVtXWz7T
X-Google-Smtp-Source: APXvYqyFm3o8vzEpLQ65QaBfSKkGFQTqNgY+iTXKJNW0PWaxO4y4NZWgq1unJBbTQHszYaOSXwNS5Q==
X-Received: by 2002:a5d:4001:: with SMTP id n1mr61003712wrp.293.1560782491226;
        Mon, 17 Jun 2019 07:41:31 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id f2sm17360696wrq.48.2019.06.17.07.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 07:41:30 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] clocksource/drivers/tegra: Cycles can't be 0
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190616234744.8975-1-digetx@gmail.com>
 <20190617092148.GA508@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6a0b098a-c040-88aa-f8de-b1a56f13af26@gmail.com>
Date:   Mon, 17 Jun 2019 17:41:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617092148.GA508@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2019 12:21, Thierry Reding пишет:
> On Mon, Jun 17, 2019 at 02:47:43AM +0300, Dmitry Osipenko wrote:
>> The minimum number of "cycles" is limited to 1 by
>> clockevents_config_and_register().
> 
> Looks to me like cycles also depends on the multiplier and shift that
> are computed for the clock source. It looks like the multiplier will
> never be zero and the shift will always be such that it won't result in
> a zero cycles either. But might be worth mentioning this in the commit
> message. And it might be nice to also repeate that in a comment close to
> the code, just to document this.
> 
> It took me a couple of minutes to track this all down, so I think we
> should take the same amount of time to document it so that we don't have
> to go through it again once we've forgotten why we made this change.

It's explicitly stated in the comment [1] what's the intent of the min_delta. But it's
also good that you verified the clocksource code itself :)

[1] https://elixir.bootlin.com/linux/v5.2-rc5/source/kernel/time/clockevents.c#L500

>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/clocksource/timer-tegra.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
>> index f6a8eb0d7322..090c85358fe8 100644
>> --- a/drivers/clocksource/timer-tegra.c
>> +++ b/drivers/clocksource/timer-tegra.c
>> @@ -54,9 +54,7 @@ static int tegra_timer_set_next_event(unsigned long cycles,
>>  {
>>  	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
>>  
>> -	writel_relaxed(TIMER_PTV_EN |
>> -		       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
>> -		       reg_base + TIMER_PTV);
>> +	writel_relaxed(TIMER_PTV_EN | (cycles - 1), reg_base + TIMER_PTV);
> 
> Maybe keep the n+1 scheme comment and explain why we don't need to
> handle the case where cycles < 1. That way it becomes crystal clear that
> we don't need it, so we decrease the chances of somebody coming around
> and trying to "fix" this.

Okay, I'll extend the commit message and add a clarifying comment to the code in v2.
