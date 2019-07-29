Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCFCC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13682054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGQgdkYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfG2NHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:07:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40232 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfG2NHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:07:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id b17so42024889lff.7;
        Mon, 29 Jul 2019 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eoMT2dpyP9IY/q7iujM3nNX4ww4VR3BnT2d2E1EdtLo=;
        b=EGQgdkYHd4BF7G65N6oDvoQGz0CsAIyxCxk4eaRWs6grmIInzkTXlnhd/phGwI8BqI
         L2K1nlcG1QgIf6GRndLEMypGwuHfJoKhM35/ItCDn8B3Xc6k1JPcBeo2o4O+coQ9yu7L
         SXOu+6FY4PhV7QcsFh2rxyNXehFgdrmIK02iaPOLSkzYzG9F35mzpl6N8PirllOUakfy
         vkyK6ahyVOTxZI6fGT0q2W+ftjx8IzZ2nroaaaxkwcxHoqrat0NnW6xp0Se1gpp8YUIg
         Mh+YuumovmJjzXyDIwfaF1mjIXMub0HUYQbI5fx7X0lQUeIn1FKkbT3bPBI5DGjaZnTW
         LQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eoMT2dpyP9IY/q7iujM3nNX4ww4VR3BnT2d2E1EdtLo=;
        b=UyeRqdvQ4qAZehIS1zVaK3hANJvaKvJudOWfBZXjAAX+H/GSbXEYYJ3bYyY4gGBVqo
         es5Yvt71XMUXjkdhXb9LL5faD3ut3RlvrrN6/zPJfUupJOvgaxcpebnamZSvLqMeSLwa
         +V98MBRZGgaCQ4AmLwGRH18d1Jd6zWaPJp4n2+PoinLrxPQMpqz9necmyOMoDaW7Snf8
         eaQ+EkAVgRMl8sqXB7Pn9HW0KJftINnzQoKBqf7qKUfA1UqtZxIz2rTATBQm8Obuwi7U
         yQnIJkoZpzPuI0tVBOHLKZhK3SyXmKNOCiFKcUJR7/fsysUeiCR8OXWxiFDL2ysG7K3u
         3HTw==
X-Gm-Message-State: APjAAAWtAkr/WZRz4MRZQWQFJQ3qRWouFduOaGG+Gy5ZSI0coFtOhH6T
        GR2x6uuJx2EUgp1bj6AauxgsxFzO
X-Google-Smtp-Source: APXvYqwYTzxkf84AcC/AmafeFhhlpqmN0jysTO8hPpdI33dwkR9fKppePRJMuNvyKp5RdAJL6LSNlA==
X-Received: by 2002:a19:7509:: with SMTP id y9mr51562440lfe.117.1564405659085;
        Mon, 29 Jul 2019 06:07:39 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id l22sm12745670ljc.4.2019.07.29.06.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 06:07:38 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] soc/tegra: pmc: Query PCLK clock rate at probe
 time
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190723023511.24542-1-digetx@gmail.com>
 <20190725093644.GJ12715@pdeschrijver-desktop.Nvidia.com>
 <f7879942-0875-1f27-5870-3f8414c2148d@gmail.com>
Message-ID: <7e76b679-1a65-fa14-2cc6-2b27ece8131c@gmail.com>
Date:   Mon, 29 Jul 2019 16:07:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f7879942-0875-1f27-5870-3f8414c2148d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.07.2019 14:15, Dmitry Osipenko пишет:
> 25.07.2019 12:36, Peter De Schrijver пишет:
>> On Tue, Jul 23, 2019 at 05:35:10AM +0300, Dmitry Osipenko wrote:
>>> The PCLK clock is running off SCLK, which is a critical clock that is
>>> very unlikely to randomly change its rate. It's also a bit clumsy (and
>>> apparently incorrect) to query the clock's rate with interrupts being
>>> disabled because clk_get_rate() takes a mutex and that's the case during
>>> suspend/cpuidle entering.
>>>
>>
>> SCLK and PCLK certainly can change rate at runtime, although the code to
>> handle this hasn't reached upstream yet.
> 
> Okay, maybe this patch is indeed not very worthwhile then. I'm leaving
> it up to you, guys, to decide.
> 

I now recalled what was the initial reason for this patch because
happened to bump into the problem once again.. it's really problematic
to call clk_get_rate() with the disabled preemption because some clk
notifier handler may block (EMC) and cause reschedule, hence the CCF
'prepare' mutex is kept locked during of CPUIDLE driver entering LP2
state and thus causing system lockup, since scheduling with the disabled
interrupts obviously won't work well.

So this patch actually is needed to be applied or some other solution
have to be provided. Since PCLK rate currently isn't altering anywhere
in the kernel, I'd suggest to imply apply this series. Please let me
know if you have any objections. I may re-iterate this patch with an
extended commit message, describing the resolved problem in a more
details, if necessary.
