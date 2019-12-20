Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09ACC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52B5206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JDeoIkN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfLTOfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:35:04 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42554 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfLTOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:34:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so7196859lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 06:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BeVvZ5ULmCKhMB2XUpJLoUDx0KaU5Mu7ZvT0f+qPzPo=;
        b=JDeoIkN5MW8F+U+eT5tHXIDU+Lz3jf5NgsiY79uZl+d2YxHx9HPcIfA9CXw6XLTWgf
         7+XYngBiTWUlVuFjgWNWgZEvoTbaZA94tPQbPrhkCQmojoGh+njifHbE39b0QMhWyTd5
         Q6LxXTFxKHD+i9HGTLqp8CCkZsICiDe2DejfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BeVvZ5ULmCKhMB2XUpJLoUDx0KaU5Mu7ZvT0f+qPzPo=;
        b=kO4kfLuYeTGYR9mzLNoVnBgHFad59Pkh60h7yKGhJZRV5pNtKUhmu0YfBpHD+kG1qc
         rp4zrKSqrzPBRiBWIUM6BhoAMq5vTJsiip+EHNjx8LcTkXi0V+d232VrAbuGk1PlfZ/A
         7QvpGMzW7uptvm2Wzf1zN4gLgzrgK9pLLU6G7D24qYSIOqtqWE8LHLU+0kTLOU8PxgbU
         JzoEwvKw9K4EoagtCEUIWAabbztq+KyoPMDi1fgB4Oyg+lZmIQP8Hda+pJzo8EAtDf40
         Faw6EnjROayQsqpuNVaM1kTNGa2i2cOjw0H3iXmWDdjkGeEqYVuEG0XpWq2egaURdvdp
         hpLA==
X-Gm-Message-State: APjAAAVGF0uNi/MxojNGV+3FUZTq8H7FVC+RUZ2C+ISx4F1gjv3mTwej
        qdEoCjg0QyboZo2iqSfUOmbwtQ==
X-Google-Smtp-Source: APXvYqxWeNP+cIbOsSlJ/ZU7OWJA1Do1iV+COZxyRZIyaE2ULfeq+9Zro/Yx8jsraijlk5DiQWP0nA==
X-Received: by 2002:ac2:44d9:: with SMTP id d25mr9491550lfm.15.1576852491701;
        Fri, 20 Dec 2019 06:34:51 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q10sm4349387ljj.60.2019.12.20.06.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 06:34:50 -0800 (PST)
Subject: Re: [RFC][PATCH 1/4] sched: Force the address order of each sched
 class descriptor
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Kirill Tkhai <tkhai@yandex.ru>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191219214451.340746474@goodmis.org>
 <20191219214558.510271353@goodmis.org>
 <0a957e8d-7af8-613c-11ae-f51b9b241eb7@rasmusvillemoes.dk>
 <20191220100033.GE2844@hirez.programming.kicks-ass.net>
 <1ac359e8-fa7f-7ded-e2f2-9f7d0b23a4e1@rasmusvillemoes.dk>
 <20191220121947.GH2844@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f580513e-b6a1-db1f-4df8-924adb438179@rasmusvillemoes.dk>
Date:   Fri, 20 Dec 2019 15:34:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191220121947.GH2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2019 13.19, Peter Zijlstra wrote:
> On Fri, Dec 20, 2019 at 11:12:37AM +0100, Rasmus Villemoes wrote:
>> On 20/12/2019 11.00, Peter Zijlstra wrote:
> 
>>>>> +/*
>>>>> + * The order of the sched class addresses are important, as they are
>>>>> + * used to determine the order of the priority of each sched class in
>>>>> + * relation to each other.
>>>>> + */
>>>>> +#define SCHED_DATA				\
>>>>> +	*(__idle_sched_class)			\
>>>>> +	*(__fair_sched_class)			\
>>>>> +	*(__rt_sched_class)			\
>>>>> +	*(__dl_sched_class)			\
>>>>> +	STOP_SCHED_CLASS
>>>
>>> I'm confused, why does that STOP_SCHED_CLASS need magic here at all?
>>> Doesn't the linker deal with empty sections already by making them 0
>>> sized?
>>
>> Yes, but dropping the STOP_SCHED_CLASS define doesn't prevent one from
>> needing some ifdeffery to define highest_sched_class if they are laid
>> out in (higher sched class <-> higher address) order.
> 
> Would not something like:
> 
> 	__begin_sched_classes = .;
> 	*(__idle_sched_class)
> 	*(__fair_sched_class)
> 	*(__rt_sched_class)
> 	*(__dl_sched_class)
> 	*(__stop_sched_class)
> 	__end_sched_classes = .;
> 
> combined with something like:
> 
> extern struct sched_class *__begin_sched_classes;
> extern struct sched_class *__end_sched_classes;

extern const struct sched_class __begin_sched_classes[];

but yes, I get the idea.

> #define sched_class_highest (__end_sched_classes - 1)
> #define sched_class_lowest  (__begin_sched_classes - 1)
> 
> #define for_class_range(class, _from, _to) \
> 	for (class = (_from); class != (_to), class--)
> 
> #define for_each_class(class) \
> 	for_class_range(class, sched_class_highest, sched_class_lowest)
> 
> just work?

Yes, I think so - I was only thinking of the case where all the symbols
would be defined in the linker script, and for this to work you need the
C compiler to subtract the sizeof().

I'd probably not include the -1 in the definition of sched_class_lowest,
but instead put it in the for_each_class definition (i.e. use
sched_class_lowest-1 as _to parameter).

A whole other option is of course to make the whole thing a bona fide C
array defined in sched/core.c, with fair_sched_class being defined as
&sched_classes[1] etc. But that requires giving all the methods extern
linkage. The advantage might be that the compiler can see how much we
iterate over, though I wouldn't expect it to actually unroll the
for_each_class loops five times. So yes, the above is probably the best
way to go.

Rasmus
