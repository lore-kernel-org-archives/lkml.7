Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FC2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D5221835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="gtbQJaic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLQRBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:01:33 -0500
Received: from vern.gendns.com ([98.142.107.122]:35790 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfLQRBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y7ZEAcmZPxFwg+aGOU54UCujclnLtD57QbAxYvqOMRQ=; b=gtbQJaictnRaTNkCxdck5VVg2H
        LGqleXJD3bKMyrPr2ARsd9cPSVspytbXmTApXBo063i9jieYAXn426jEWKo6Zi1c1H+kiuoqmTLT4
        yab2SEEa/7iruaUEfF8slxX3lUJEvX16T330+qjVUEQLDTZpYCNCkxcSVs+zcUtxj0q7JU1jbeiiO
        7LYlVP8962lr+Kec4YHd4TF7MvEvOWFjfH1kSRHIw/GLB2j/M76CSczf+kT1yJw2rjDbM5qmZXdBJ
        so5oaj3ZmDD6fxreuqGJ3reCn47VUo9t/EIXS3MxhaTl7PQMr4muVJl2PK2z8hIF/EWHjfWOAF2+o
        SQuOrvxg==;
Received: from [2600:1700:4830:165f::fb2] (port=57660)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1ihGDx-0002LF-EA; Tue, 17 Dec 2019 12:01:29 -0500
Subject: Re: [PATCH 1/3] clocksource: davinci: work around a clocksource
 problem on dm365 SoC
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20191213162453.15691-1-brgl@bgdev.pl>
 <20191213162453.15691-2-brgl@bgdev.pl>
 <b9a28314-4fce-ebbd-be20-b0ffa2f1f15f@lechnology.com>
 <CAMRc=McRKwYkUcY9J8cEkwoMnGYxs7SkTnOnFsVMDZD2DkJ1Zw@mail.gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <a68ca8a5-77c6-4aac-f3b6-67edbf42a9bf@lechnology.com>
Date:   Tue, 17 Dec 2019 11:01:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAMRc=McRKwYkUcY9J8cEkwoMnGYxs7SkTnOnFsVMDZD2DkJ1Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 2:00 AM, Bartosz Golaszewski wrote:
> pon., 16 gru 2019 o 18:58 David Lechner <david@lechnology.com> napisał(a):
>>
>>>
>>> +static unsigned int davinci_clocksource_tim32_mode;
>>
>> static unsigned bool davinci_clocksource_initialized;
>>
>>> +
>>>    static struct davinci_clockevent *
>>>    to_davinci_clockevent(struct clock_event_device *clockevent)
>>>    {
>>> @@ -94,7 +96,7 @@ static void davinci_tim12_shutdown(void __iomem *base)
>>>         * halves. In this case TIM34 runs in periodic mode and we must
>>>         * not modify it.
>>>         */
>>> -     tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
>>> +     tcr |= davinci_clocksource_tim32_mode <<
>>>                DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
>>
>>          if (davinci_clocksource_initialized)
>>                  tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
>>                          DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
> 
> I thought about doing this initially, but then figured this code would
> be called a lot, so why not avoid branching and just store the right
> value? Alternatively we can do:
> 
>      if (likely(davinci_clocksource_initialized)
>          ....
> 

Unless there is a measurable performance difference, I think it
would be better with if/likely.

