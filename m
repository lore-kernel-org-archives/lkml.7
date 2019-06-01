Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BA6C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD08265CF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmB0ttk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfFANBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:01:38 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53413 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfFANBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:01:37 -0400
Received: by mail-it1-f196.google.com with SMTP id m141so20316375ita.3;
        Sat, 01 Jun 2019 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EL5TH2hMWoiZtVZYy6bsOd3s/PXyVs5Seh9sogDRgo8=;
        b=HmB0ttk1MhgqW/0cXl3XPzMzL4CI9dP8Jcb8mL4XyLDHx3wrdnlYirDqCIWMORY2Mz
         5CrrJ1HciCx/37BAlpXy4BkcZoHVFM9XcYL9sn9cvyTLWLSnpqyDWxUkQX4VXUG+BR3S
         hCBhf+9kjFAzwqmNwb/eI7Ab1kO9ACrkTlCCt8sxcXxonHfbgeip7U5DizmFb8lgC2kP
         vn9IkDKfBZxFnE5SGO3Tc5M6s/BNaK0DEGb8/VbVMzYLPva8q9lk1eg0IpBB7J5dRPUw
         T8ZS3Lsuwq6va+DztgPnbR1dCjrWRgruVaSTtH0b8nMHz+ah+ll+FcmA5vUWyg6dmIZI
         Ddew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EL5TH2hMWoiZtVZYy6bsOd3s/PXyVs5Seh9sogDRgo8=;
        b=EZEwZlD7ltEbMrBOBmGjXCCDcaM1Ohxr7ADy2PjcYDqlMXg8cpSeWUqFLv6BMfJyMs
         qPyT1APuiRYBVxP4VsFW5ry3Aa8Puebpmd8FclHAczqx5hUu+jSNIPyAZW4pmfBAW2t5
         vFNwIUIo56TUcDpwVayEa+tyh4WK+dIWGzFTA6FpKaI45MSqDfj2xFpwsOAuxgKwVCYv
         dzJIK/3+UR2ePeJfpi2QJqD5rCbEl9Ad6DNUlqMrHHsWiFvKnGOsPfIYiVwIKHyYQjuU
         Nd3G7jYLXXhSCedePKrqe92QCEVjy85ezqebiEwH9AwXkI7zHNSDLq+GVI3D23sN4GvJ
         MDyQ==
X-Gm-Message-State: APjAAAXylPM4GgMBUFMnyqbwfkcEqts/SSHA/uYfdAR9gylWOuJIsfFt
        n4Wi7rMkoP5Mr3BN7YO2A2c=
X-Google-Smtp-Source: APXvYqz7lBkSUf/T6lvzRFN+Eo5IERMTYy2MiQMbZ8bARPCNx5RSpa6Uvjdh2+rSC9CZyha9y2z+Fg==
X-Received: by 2002:a24:d945:: with SMTP id p66mr11171733itg.38.1559394096673;
        Sat, 01 Jun 2019 06:01:36 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id e188sm3003250ioa.3.2019.06.01.06.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 06:01:35 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] NVIDIA Tegra clocksource driver improvements
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
References: <20190524153253.28564-1-digetx@gmail.com>
 <20190531082634.GA6070@pdeschrijver-desktop.Nvidia.com>
 <c686aae8-3be0-805e-265b-a7f16f2a6c02@gmail.com>
 <26aeb9f0-5eb1-005a-02c1-4d785fe70331@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6909cb87-8583-4ec8-74b7-a6153aec0246@gmail.com>
Date:   Sat, 1 Jun 2019 16:00:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <26aeb9f0-5eb1-005a-02c1-4d785fe70331@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.05.2019 23:31, Daniel Lezcano пишет:
> On 31/05/2019 14:33, Dmitry Osipenko wrote:
>> 31.05.2019 11:26, Peter De Schrijver пишет:
>>> On Fri, May 24, 2019 at 06:32:45PM +0300, Dmitry Osipenko wrote:
>>>> Hello,
>>>>
>>>> This series primarily unifies the driver code across all Tegra SoC
>>>> generations. In a result the clocksources are allocated per-CPU on
>>>> older Tegra's and have a higher rating than the arch-timer, the newer
>>>> Tegra210 is getting support for microsecond clocksource and the driver's
>>>> code is getting much cleaner. Note that arch-timer usage is discouraged on
>>>> all Tegra's due to the time jitter caused by the CPU frequency scaling.
>>>
>>> I think the limitations are more as follows:
>>>
>>> Chip	timer		suffers cpu dvfs jitter		can wakeup from cc7
>>> T20	us-timer	No				Yes
>>> T20	twd timer	Yes				No?
>>> T30	us-timer	No				Yes
>>> T30	twd timer	Yes				No?
>>> T114	us-timer	No				Yes
>>> T114	arch timer	No				Yes
>>> T124	us-timer	No				Yes
>>> T124	arch timer	No				Yes
>>> T210	us-timer	No				Yes
>>> T210	arch timer	No				No
>>> T210	clk_m timer	No				Yes
>>>
>>> right?
>>
>> Doesn't arch timer run off the CPU clock? If yes (that's what I
>> assumed), then it should be affected by the DVFS. Otherwise I'll lower
>> the clocksource's rating for T114/124/132.
>>
>> TWD can't wake CPU from the power-down state, so it's a solid "No" for
>> TWD in the "can wakeup from cc7" column.
> 
> Wouldn't make sense to rename the timer-tegra20.c to timer-tegra.c now ?

Wouldn't hurt, given the refreshment that driver is getting lately. I'll
include a patch for that in the next revision, thanks.
