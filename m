Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486D1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1986320643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rz/er/5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCRIEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:04:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52031 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfCRIEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:04:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id n19so11927259wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sd/n6PhtEcIqd1ieOCgMl6+9V/BIsDWpZqcQavR6+Rc=;
        b=rz/er/5s/DtqNOkZ3SSjZ+ZKps/d9guzdWh6B2SOStiHjUkIaozn6SYdsYF5suKHly
         5qadcW/uttcXbcGIflj1Jfmg8zlRDqcSfs4yb/RJwM7tQSmrXtwgmL2Q42vRcq03B+zt
         z03sHTpYxr8TEGpBqVcMchsmP7GPI6ywUsC8B8khGdMwEDRHY+XxL0+cMHsHMQ73cpFh
         jtjxE5ZJ1zUt8EPsoVfh2vZdoOs0sydWN45PfWAHrdWePG9bkk9t1zko+zc1KYRx5/J7
         WhmqkyIsiZ0bGG/dv5wQC4PlyH/74Uz284KvctBlxbmVW6tiBXHj6KW3uj5pVLkl68EB
         d+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sd/n6PhtEcIqd1ieOCgMl6+9V/BIsDWpZqcQavR6+Rc=;
        b=kpzlkiGR5p0meu8r/gzlneqkHnly/QL7D1M5f3S/DW5HemFRopJ/PGS07wEsB55vQw
         B+79QoE6j0rfikrNTRLYFHA0M8GefJFb4AXwz8c7+mjAnR5FWiCGufwu5Sl8TEYMJG+u
         U0qK/GsmOWVIdr3QnjaWlr9ZHguWfK+XrD8GQ92RiDxIQsYCrMUhNAt8ncaCJwu/SAoG
         NwJsSH7p/nzhmorpTb6VuxUjWZfWNK6i3vWLN2y6uccynpjbyiC03sImcP81+f/5yLba
         8hkydB2r1MLVRETPsejnUVxqgTwcBgzM8SFrWvlWSphqpSYwwTw5m3pO5mq9eA1gn1qq
         PkDg==
X-Gm-Message-State: APjAAAUEzKjlQAZYbbNV2pyGr0acmw1OumHSwqJcYz+zSkvjSS9Ye7jD
        XTkM4U/4tcIhMS7n1mOwrn0y8w==
X-Google-Smtp-Source: APXvYqxKMfJXrxJ128Ed8ooxfwbV6S4xHWXlB0PlouPAkQzU1Y2FUMkl+zDhbLNWXY5nowvADI3B7g==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr2945508wmi.20.1552896281545;
        Mon, 18 Mar 2019 01:04:41 -0700 (PDT)
Received: from [192.168.0.41] (48.208.130.77.rev.sfr.net. [77.130.208.48])
        by smtp.googlemail.com with ESMTPSA id 12sm24388715wme.25.2019.03.18.01.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:04:40 -0700 (PDT)
Subject: Re: [PATCH 0/7] Timer & SPI support for Allwinner suniv F1C100s
To:     Icenowy Zheng <icenowy@aosc.xyz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
 <2485e6c52810df376a0df6eb7f749f35b7b19044.camel@aosc.xyz>
 <177e2598-3491-03af-8638-c60e77cc4a34@linaro.org>
 <8e1cf9c7111a423ce7cc32a6759d16e4197b87d9.camel@aosc.xyz>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c741ed1a-ef02-c7c9-846b-c5240c8d07b6@linaro.org>
Date:   Mon, 18 Mar 2019 09:04:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8e1cf9c7111a423ce7cc32a6759d16e4197b87d9.camel@aosc.xyz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2019 08:18, Icenowy Zheng wrote:
> 在 2019-03-17日的 21:52 +0100，Daniel Lezcano写道：
>> On 17/03/2019 18:39, Icenowy Zheng wrote:
>>> 在 2019-02-11一的 12:21 +0300，Mesih Kilinc写道：
>>>> This is followup series for F1C100s initial support patchset. 
>>>> All patches merged except patch 1 ~ 2 which is related to timer.
>>>> I am resending those since they are already have Acked tags.
>>>
>>> Ping.
>>>
>>> Could you please merge these timer-related patches?
>>
>> Hi,
>>
>> I acked the timer-related patches. If you resend the patches with my
>> acked-by I will consider them to go through the allwinner tree.
>>
>> Do you want me to take 1 and 2 through my tree?
> 
> Please. They also have the ACK from Allwinner/sunXi maintainer.

Applied for 5.2. Thanks

By the way, I did not find any trace of the email in my mailer, was I
To'ed or CC'ed for those patches ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

