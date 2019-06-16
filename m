Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF9C31E53
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80FF2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 14:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNj2fKD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfFPOaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 10:30:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38770 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfFPOaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 10:30:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id r9so6843441ljg.5;
        Sun, 16 Jun 2019 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fp42PDzNGtXF8Hqf1tedNQKMRKxQhiV+kXzOcadV3Ew=;
        b=KNj2fKD4N9b3u/UrZ8Gqp2+0mdjdbspVqIrjfcum52RTFdSsybJQ/ciBjbYJJsEIUM
         +43c8sFLBhyLiVxjKWiCm4Er00tCGfQjLwoi1IyepiDQpeD9269MnsdCdBYW90dtidi5
         WCQ/jwDBIsIeZOk1fGygBytl6qw9Kuhivbm4YbAgBtFTrMM8wbPTAdEh6FaWcA0eJQag
         ijcVbHoyGTpIDxULGanf/DbwGrlvo0zTS3KtnL60VEHUizUnJDRVgGLtAbD9rY5Wy0VO
         NhOrAzeAj2itWTrsvuRehMq2lETct2by7V7gEIhDSK7m+Fxi8u+qdATvu5R3x60bRenF
         kNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fp42PDzNGtXF8Hqf1tedNQKMRKxQhiV+kXzOcadV3Ew=;
        b=r7JzsmWeSuVAiNsTjg+Ay+ylAYdUdSFyxjX2DTfgFharmo3qXdkfJvZv6RtaQl2p94
         /vtjMFv1wudCqUiRuLvvGpws3uNNMFnVat/W6JLNRPwQFzQEy1znAlzoEgnRqSFmhFLR
         /OUCp9FXbX+XfTTFULZ6vrgqkV4dq+ZMUYfhOBT1+glborEq/FCO9ekYCagqnV2wzGau
         uV0wmgmqHe0sTM6E0Sk16VcLSy6k4YqBUbJubKmFDKik2PXrPnbsMxbqtZyIFo9wj4wW
         W4MgmSY9k2HAa37EznbjeiCFeOyWWuEpTVuduJogH2hy0lmtP5W8zODlgXnKTLnza8pH
         WcMA==
X-Gm-Message-State: APjAAAXOI0AwfkgJbw89DuKPKxtSYIctcrFqPwkn3pJXZvaB82ZyHhgh
        pvVkANrP1mAbMPEhALxZHLEQUeXX
X-Google-Smtp-Source: APXvYqwYhDRpA7HUG8+7O8ZksPUpouWQeHBtxto441XSlMJ/kZ4QrbMN40FYfC6V1A4sYs2jmx5zfQ==
X-Received: by 2002:a2e:8155:: with SMTP id t21mr4825800ljg.80.1560695420985;
        Sun, 16 Jun 2019 07:30:20 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id u21sm1639935lju.2.2019.06.16.07.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 07:30:20 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the clockevents tree
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190613090700.04badfc3@canb.auug.org.au>
 <1b6c715b-5aa9-b0c1-d228-c99d2adc57b4@linaro.org>
 <20190616232408.7ca0ec1c@canb.auug.org.au>
 <daa92c0a-9c29-39cb-8612-1103bf09cf13@gmail.com>
 <d15056ee-1433-26dd-09de-66a93282705a@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2c6f1b0c-f531-1d5f-e730-761defbcb61d@gmail.com>
Date:   Sun, 16 Jun 2019 17:30:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <d15056ee-1433-26dd-09de-66a93282705a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2019 17:18, Daniel Lezcano пишет:
> On 16/06/2019 16:08, Dmitry Osipenko wrote:
>> 16.06.2019 16:24, Stephen Rothwell пишет:
>>> Hi Daniel,
>>>
>>> [Sorry for the slow response.]
>>>
>>> On Thu, 13 Jun 2019 08:52:21 +0200 Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> actually it returns:
>>>>
>>>> git log -1 --format='Fixes: %h ("%s")' 3be2a85a0b61
>>>>
>>>> Fixes: 3be2a85a0b61 ("clocksource/drivers/tegra: Support per-CPU timers on all Tegra's")
>>>
>>> Indeed.
>>>
>>>> Is it ok to shorten the subject?
>>>
>>> I figure it is easier to just use the "git log" result and to give
>>> anyone (or any script) the wants to use the Fixes tag as much
>>> information as possible.
>>>
>>
>> Daniel, I'd also recommend to shorten the common subsys prefix in general to something
>> like "clocksource: tegra:".
> 
> Actually I can't, I have been asked by the tip team to follow this format.

Oh well.

Also please feel free to fixup the offending commit's tag if you think that it's
necessary. I'll keep a full subject line in the future patches to a void that situation.
