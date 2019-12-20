Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5389C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D3E2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="L1ZlN/vT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLTKMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:12:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41091 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfLTKMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:12:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so9414378ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 02:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5M+97VbPVz5fx10oR8PMt5OPdUW758AjR3+Ji1vzz5M=;
        b=L1ZlN/vTOi3FuOhcVzlqz11rikUE109c0s2Si9hpwWNPLIKRQ/qB7kVRUO5Ak/dmSd
         bT5nZME+i87t5vsXEhQazURlMkxIXy/krhexuF1BqmfAPw7fMSe/hRk8wdqn430egyv8
         aIhAE4cOu1xPOxmBuNxyA/rygFdbDQuEfno2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5M+97VbPVz5fx10oR8PMt5OPdUW758AjR3+Ji1vzz5M=;
        b=s1keIMQzPhEFyWk40prgXqN9fzD28PaEWhGsKd7vV0Jva51Jhdul1I1r2vPp66sYu7
         jC1huKiUc3Q0IWGXcocCRE0367iziVivAsyWdaBctpvsjrg9vFMicpy1krrOgdZPZPHb
         0SC76ucPhms+pfZDNLTH5SR3kW6QebhscxXo2OLo182kxStB1fgtWdTfCUgunR8Q4eR8
         CSKdhpUrrWqdzXejmywWMCHpfXKRJ/IiIsCuyP8RcCvHrN0yV4CqpLhqYHoGnsqFBLgV
         dBXo45B31inHt/es/aYYQW2n5BAv5AlV2yqgLRXEF/EYifa7hO7PDUDtUINioXxeOPo8
         Gurw==
X-Gm-Message-State: APjAAAWMui2FWTKlmtfBVcNenF3GtaCquYLSB4v/+HcddIDNpdTgpQ99
        3mcv/zknO6cOxTXHR6YB3MrUUg==
X-Google-Smtp-Source: APXvYqz6J8xgcSHMRi83jJqJdmTY+U/Gz3RT9kImbqgEYi/DZzUvoSGgWa5Ogm82BJx+FJsV1hgVwA==
X-Received: by 2002:a2e:5304:: with SMTP id h4mr9433917ljb.75.1576836759355;
        Fri, 20 Dec 2019 02:12:39 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i19sm3843910lfj.17.2019.12.20.02.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 02:12:38 -0800 (PST)
Subject: Re: [RFC][PATCH 1/4] sched: Force the address order of each sched
 class descriptor
To:     Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1ac359e8-fa7f-7ded-e2f2-9f7d0b23a4e1@rasmusvillemoes.dk>
Date:   Fri, 20 Dec 2019 11:12:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191220100033.GE2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2019 11.00, Peter Zijlstra wrote:
> On Fri, Dec 20, 2019 at 09:52:37AM +0100, Rasmus Villemoes wrote:
>> On 19/12/2019 22.44, Steven Rostedt wrote:
>>> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>>>
>>> In order to make a micro optimization in pick_next_task(), the order of the
>>> sched class descriptor address must be in the same order as their priority
>>> to each other. That is:
>>>
>>>  &idle_sched_class < &fair_sched_class < &rt_sched_class <
>>>  &dl_sched_class < &stop_sched_class
>>>
>>> In order to guarantee this order of the sched class descriptors, add each
>>> one into their own data section and force the order in the linker script.
>>
>> I think it would make the code simpler if one reverses these, see other
>> reply.
> 
> I started out agreeing, because of that mess around STOP_SCHED_CLASS and
> that horrid BEFORE_CRUD thing.
> 
> Then, when I fixed it all up, I saw what it did to Kyrill's patch (#4)
> and that ends up looking like:
> 
> -       if (likely((prev->sched_class == &idle_sched_class ||
> -                   prev->sched_class == &fair_sched_class) &&
> +       if (likely(prev->sched_class >= &fair_sched_class &&
> 
> And that's just weird.

I kind of agree, but if one can come up with good enough macro names, I
think all that comparison logic should be in helpers either way the
array is laid out. Something like

#define sched_class_lower_eq [something] /* perhaps comment on the array
order */
sched_class_lower_eq(prev->sched_class, &fair_sched_class)

> Then I had a better look and now...
> 
>>> +/*
>>> + * The order of the sched class addresses are important, as they are
>>> + * used to determine the order of the priority of each sched class in
>>> + * relation to each other.
>>> + */
>>> +#define SCHED_DATA				\
>>> +	*(__idle_sched_class)			\
>>> +	*(__fair_sched_class)			\
>>> +	*(__rt_sched_class)			\
>>> +	*(__dl_sched_class)			\
>>> +	STOP_SCHED_CLASS
> 
> I'm confused, why does that STOP_SCHED_CLASS need magic here at all?
> Doesn't the linker deal with empty sections already by making them 0
> sized?

Yes, but dropping the STOP_SCHED_CLASS define doesn't prevent one from
needing some ifdeffery to define highest_sched_class if they are laid
out in (higher sched class <-> higher address) order.

Rasmus
