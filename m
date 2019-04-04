Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62947C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2823820882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7Z4if8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfDDKVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:21:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38538 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfDDKVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:21:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so1143916pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rkJOt1RN0QTbcsQKoY/n8mPh1lUPyoQR0HE26224PvM=;
        b=Y7Z4if8sBTFRUJp2VmdFCP2z1GsyxdOUmYthhir4QqjyWBlPl4HwBYw1BnHpaeHRKa
         2V8mKDo+duY7cZTI/1O2SdWNp4pvATB7pf+x+OnlrbzvphB1wFabh/UzxlrW3q9iz6Ot
         /hfNBIRvIuKLvAFBOjQJaucYcgfZv5STrcWp3liAVZbeMQzQBPQiqKSVETq7CYVNwo3Q
         dVaNAntsWC08KIAkTXMnwIwNDhvqafTvVtKnKbPVZghSWE6Zy1ee62RByiZwItxSJwjj
         0la8cXyydi/qrX+1XXxBxKawQ/IWF3KD7qAgEfC8ya/fmaRoc6L7k/gyAD1J53Vur9Pe
         9HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rkJOt1RN0QTbcsQKoY/n8mPh1lUPyoQR0HE26224PvM=;
        b=Lvd4Gi3Go6wyQKU08DDN5LAYp+DwrWUNVESQryiz4ZsyLszOI5hSrRKdrO1brsZu83
         UTBv/WXBxfQHWlU65hJZGVqyKsMV49mONl8RsiXstZtMJYjW1VhMXzZ0aLXEIZfMde7Q
         RQECf9IG5mLGH4KIEx9oafo/769+7r7pWd6TwX2sYxWq6YacaALGTavj6fWnjRoI6N+3
         TVR/W9s2n42LiVE+b8x1dFS6gqdBm7/Y0ZrPmKJ7HuGmJuXOV98aZZvzuJTXsA1kwimX
         ZAVtGgEaLz1A9HxMUz9oGVfrN/3KsnEU7yCQ9q61Kz5iUL3ugvgeoc5VG19Z7pGIYaYG
         yKUA==
X-Gm-Message-State: APjAAAW2iUXw1ZJHgSsgBQHYJeUzAMKTTds70sONbMqN1Ne5Q2k2yq4j
        uJZZ1pdy0AQdrKds2BdtfCW7TQ==
X-Google-Smtp-Source: APXvYqy7iktDC+hyNWdXabASJpXCqyQZSD/NbSQGGET0Q7iKkhZyzt6PZn4ewSoDP8SyvH21oJ6ugQ==
X-Received: by 2002:a65:414a:: with SMTP id x10mr5039636pgp.237.1554373300974;
        Thu, 04 Apr 2019 03:21:40 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id z6sm36816853pgo.31.2019.04.04.03.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 03:21:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
To:     Abhishek <huntbag@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
 <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
 <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org>
 <50f62972-dfce-52bf-d26b-32e6d2a367e2@linux.vnet.ibm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9e542011-df6d-9b84-823b-2af6a6ef9e94@linaro.org>
Date:   Thu, 4 Apr 2019 12:21:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <50f62972-dfce-52bf-d26b-32e6d2a367e2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Abhishek,

thanks for taking the time to test the different scenario and give us
the numbers.

On 01/04/2019 07:11, Abhishek wrote:
> 
> 
> On 03/22/2019 06:56 PM, Daniel Lezcano wrote:
>> On 22/03/2019 10:45, Rafael J. Wysocki wrote:
>>> On Fri, Mar 22, 2019 at 8:31 AM Abhishek Goel
>>> <huntbag@linux.vnet.ibm.com> wrote:
>>>> Currently, the cpuidle governors (menu /ladder) determine what idle
>>>> state
>>>> an idling CPU should enter into based on heuristics that depend on the
>>>> idle history on that CPU. Given that no predictive heuristic is
>>>> perfect,
>>>> there are cases where the governor predicts a shallow idle state,
>>>> hoping
>>>> that the CPU will be busy soon. However, if no new workload is
>>>> scheduled
>>>> on that CPU in the near future, the CPU will end up in the shallow
>>>> state.
>>>>
>>>> In case of POWER, this is problematic, when the predicted state in the
>>>> aforementioned scenario is a lite stop state, as such lite states will
>>>> inhibit SMT folding, thereby depriving the other threads in the core
>>>> from
>>>> using the core resources.

I can understand an idle state can prevent other threads to use the core
resources. But why a deeper idle state does not prevent this also?


>>>> To address this, such lite states need to be autopromoted. The cpuidle-
>>>> core can queue timer to correspond with the residency value of the next
>>>> available state. Thus leading to auto-promotion to a deeper idle
>>>> state as
>>>> soon as possible.
>>> Isn't the tick stopping avoidance sufficient for that?
>> I was about to ask the same :)
>>
>>
>>
>>
> Thanks for the review.
> I performed experiments for three scenarios to collect some data.
> 
> case 1 :
> Without this patch and without tick retained, i.e. in a upstream kernel,
> It would spend more than even a second to get out of stop0_lite.
> 
> case 2 : With tick retained(as suggested) -
> 
> Generally, we have a sched tick at 4ms(CONF_HZ = 250). Ideally I expected
> it to take 8 sched tick to get out of stop0_lite. Experimentally,
> observation was
> 
> ===================================
> min            max            99percentile
> 4ms            12ms          4ms
> ===================================
> *ms = milliseconds
> 
> It would take atleast one sched tick to get out of stop0_lite.
> 
> case 2 :  With this patch (not stopping tick, but explicitly queuing a
> timer)
> 
> min            max              99.5percentile
> ===============================
> 144us       192us              144us
> ===============================
> *us = microseconds
> 
> In this patch, we queue a timer just before entering into a stop0_lite
> state. The timer fires at (residency of next available state + exit
> latency of next available state * 2).

So for the context, we have a similar issue but from the power
management point of view where a CPU can stay in a shallow state for a
long period, thus consuming a lot of energy.

The window was reduced by preventing stopping the tick when a shallow
state is selected. Unfortunately, if the tick is stopped and we
exit/enter again and we select a shallow state, the situation is the same.

A solution was previously proposed with a timer some years ago, like
this patch does, and merged but there were complains about bad
performance impact, so it has been reverted.

> Let's say if next state(stop0) is available which has residency of 20us, it
> should get out in as low as (20+2*2)*8 [Based on the forumla (residency +
> 2xlatency)*history length] microseconds = 192us. Ideally we would expect 8
> iterations, it was observed to get out in 6-7 iterations.

Can you explain the formula? I don't get the rational. Why using the
exit latency and why multiply it by 2?

Why the timer is not set to the next state's target residency value ?

> Even if let's say stop2 is next available state(stop0 and stop1 both are
> unavailable), it would take (100+2*10)*8 = 960us to get into stop2.
> 
> So, We are able to get out of stop0_lite generally in 150us(with this
> patch) as
> compared to 4ms(with tick retained). As stated earlier, we do not want
> to get
> stuck into stop0_lite as it inhibits SMT folding for other sibling
> threads, depriving
> them of core resources. Current patch is using auto-promotion only for
> stop0_lite,
> as it gives performance benefit(primary reason) along with lowering down
> power
> consumption. We may extend this model for other states in future.
> 
> --Abhishek
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

