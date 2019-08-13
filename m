Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143E3C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D7F2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJTCnEYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfHMQ7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:59:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51573 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfHMQ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:59:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so2166340wma.1;
        Tue, 13 Aug 2019 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jvn+xJgfLUWg0oXwDG1/WgGeCa0KABLkFtSVh2iBO0E=;
        b=pJTCnEYvaONkSFviyZYN6oKWB+sO8j/jPcyI+oPfke2MSfXLq08BNqapVJ0Fa2LppR
         /3wdo/n9fQo3RB0SBbTYjYYTRjBnXvBRbvIvfRk5vmcejF1PuJ8Sv5iri22KQ/YzIj3j
         BrQaRha37iIUw32ZJLlXgTYdgKzyKc94WRkHF+9d1R+/UxJb+QKaNVit3cOh8px3RNlN
         6qIIMZiJNMyOI2mvApeoSMGXpta6BIa/I238l24v4wHH6GQsJQV7nnkqxkLvjO/cQtiM
         vO+1krbH7IWE2ozIkh9kfvFL3e+7bjTeWp0BFaqGUp7O3LZxUnk2ytF8kHkAL3pZNd5A
         Gidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jvn+xJgfLUWg0oXwDG1/WgGeCa0KABLkFtSVh2iBO0E=;
        b=oDP5yI/4vhue0Wv9pVAqvMHNw3Bea/BXn44rdYUn/2nULkwdsnFSTLX26uZUWhgCSd
         Gfnaaf53+hVNoiIFJny1JnXW3pzv+choB8toq6BPdG88c+mR9OtUbr7oE4Z9Yd+EncPn
         bjokg65TxWlXRTqbF8Z9e/DU7IjwaCB8JBic1deiM0tgiZMR5LRRVwdg6A3Hscz9w8Q3
         b30VY0KB7Xgx5zX9Xpa5tcAL5xZAKpyyTTf14bWGoiPBiFjLDOXl+fSqPAsqjb3rb9Zr
         NndNNpBzoIKtlifIV3RQ12DabxSJd9y+L4dE9c9eR2S1H0vTnR51I8pJDLAZzi8dW/BY
         C4pg==
X-Gm-Message-State: APjAAAUtpW21WOXysJ33+6ADR6QuaQDV9J23PEG1fc8yWJxa/phq3l7Q
        h569schzJXostJD56HSTjofs0Hv4
X-Google-Smtp-Source: APXvYqxC+zEaAniG5VsaaNRjK3kHb4PttUpcJj2Fx0ezq3QBmPb2Z0KTrvDiz2rc9a2ulGgETpUoVQ==
X-Received: by 2002:a1c:7dc8:: with SMTP id y191mr4263236wmc.78.1565715546399;
        Tue, 13 Aug 2019 09:59:06 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id r16sm35040989wrc.81.2019.08.13.09.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 09:59:04 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] irqchip/tegra: Clean up coding style
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190811183044.13925-1-digetx@gmail.com>
 <20190811183044.13925-2-digetx@gmail.com> <86a7cdnmpx.wl-maz@kernel.org>
 <4fbc5a90-e110-b020-15d3-c4bbe81b15cc@gmail.com>
 <867e7hnin7.wl-maz@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <19845d1b-d140-a765-d548-77644923f4f0@gmail.com>
Date:   Tue, 13 Aug 2019 19:59:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <867e7hnin7.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.08.2019 19:18, Marc Zyngier пишет:
> On Tue, 13 Aug 2019 16:40:27 +0100,
> Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 13.08.2019 17:50, Marc Zyngier пишет:
>>> On Sun, 11 Aug 2019 19:30:44 +0100,
>>> Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> Make coding style to conform to the kernel's standard by fixing checkpatch
>>>> warnings about "line over 80 characters".
>>>
>>> The last time I used a VT100 was about 30 years ago. I still think
>>> this was one of the most brilliant piece of equipment DEC ever
>>> produced, but I replaced it at the time with a Wyse 50 that had a 132
>>> column mode. But even then, I could make my XTerm as wide as I wanted,
>>> and things haven't regressed much since.
>>>
>>> More seriously, I don't consider the 80 column limit a hard one, and
>>> I'm pretty happy with code that spans more that 80 columns if that
>>> allows to read an expression without messing with the flow.
>>
>> Usually I have multiple source files opened side-by-side and the
>> view sizes are tuned for 80 chars, it messes at least my flow when
>> something goes over 80 chars.
>>
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/irqchip/irq-tegra.c | 15 +++++----------
>>>>  1 file changed, 5 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
>>>> index 14dcacc2ad38..f829a5990dae 100644
>>>> --- a/drivers/irqchip/irq-tegra.c
>>>> +++ b/drivers/irqchip/irq-tegra.c
>>>> @@ -74,7 +74,7 @@ static struct tegra_ictlr_info *lic;
>>>>  
>>>>  static inline void tegra_ictlr_write_mask(struct irq_data *d, unsigned long reg)
>>>>  {
>>>> -	void __iomem *base = (void __iomem __force *)d->chip_data;
>>>> +	void __iomem *base = lic->base[d->hwirq / 32];
>>>
>>> (1) This is an undocumented change
>>
>> In my opinion this is a very trivial change and then the end result
>> is absolutely the same, hence nothing to document here. Just read
>> the code, I'd say.
> 
> And that is the very reason why I won't take any of your patches any
> time soon.

Sorry, the last part probably sounds a bit offending, but that's not
what I meant (please note that english isn't my native language). I was
just trying to say that the code is self-explanatory in my opinion.
Anyway, it's not a bad excuse for me to get a break from it all. Sorry
again.
