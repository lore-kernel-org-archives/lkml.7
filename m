Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ADFC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0FD217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp6uWP7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389680AbfHHBxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 21:53:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39271 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbfHHBxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:53:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id f17so39136038pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 18:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eSroff2c0Z50xMTbjSIJsxHwFGhZA9roNAbhdW97Wco=;
        b=Cp6uWP7TF8lk/VcM9tp3VoC21MR5F6Avlu5tavzruPqtKxnvC473fqExQv5o6dtqP5
         2vsutQsAa7JOvPXK8BYGWwgkKMsU0GmcxvKEJU0uzk6MSanC+WF/nspKLr7douAzQKyj
         HnhinXADvU56T1/lU4bjguHTCWdUj5JHcGQyZxFgyblebHhC2ZZhfRVqNVmdCI24I9XU
         uFwxTrqhHO83qKQp3g/joCcv2JQ13pdTMYe6vO+DGqvV/HOKv4oYMXanq8mp2d3mHvFm
         UQV1Wu1sYwU52okxI4BAV5V3g5RXLed9uU94RV+7Nq7AOJeMEG/USh973Ix0JBB8knMh
         UZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eSroff2c0Z50xMTbjSIJsxHwFGhZA9roNAbhdW97Wco=;
        b=EOQM4RZPM8vqdpXHx3PTzKNBdirZFE1PXtBzMgEU7DymJwwTeqC03Zvyd+NvWpyJHW
         kgdULwxzb9r1XTQX1PXy8dnjVgmAh1+xYg+gWM0wxqTJXbiEII9yxq5q9Ftk0kdQ549j
         r0dPihElSQLm+ZHLnGga70aUEJM9ZdO1bcgi8TQxwBAwhSbOAjx4XslOZuK1wmxx9zXk
         JNUtMhV9/TH5oDNPf4Xqt35ubGVdPjzS1MHCHrnmVrvRPERZGpfD5SGE1NWborWSPqjZ
         EqSLtNU7111ylUFKy6ZVtxoeTdu7OJFERNQqCi5/2EJHLzXbWCqGIre331iSjF0jrBDy
         EFAQ==
X-Gm-Message-State: APjAAAVEO16LNEITxhr75LyuPLVmOM48YHtjJ7KiO092Um5eKJkCyMfj
        5+DJD9foIy07hHIrbycfl2puCkTp
X-Google-Smtp-Source: APXvYqykXZWZW7BwZYiblvIKe8JCC6OQVRqmrYStkPW2b+IDlPpzwxhFZtYQ+NwBO4PEBaNE4mYV6g==
X-Received: by 2002:a63:188:: with SMTP id 130mr10264107pgb.231.1565229201440;
        Wed, 07 Aug 2019 18:53:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 137sm118517844pfz.112.2019.08.07.18.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 18:53:20 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] linux/bits.h: Add compile time sanity check of
 GENMASK inputs
To:     Joe Perches <joe@perches.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190801230358.4193-2-rikard.falkeborn@gmail.com>
 <20190807142728.GA16360@roeck-us.net>
 <CAK7LNATGuO0D0a-sTvWw5Pzkn5C7jrLiS=rCwiRsEqaS86KbuQ@mail.gmail.com>
 <099e07d4b4ecca9798404b95dc78c89bc3dd9f7f.camel@perches.com>
 <c4157db4-dbda-5ab1-2092-83c4a3b0f19e@roeck-us.net>
 <f469bc5c8ae2386af57296df0a8a17b7c223a476.camel@perches.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <860ad052-a6b9-e803-67d3-dc388e506684@roeck-us.net>
Date:   Wed, 7 Aug 2019 18:53:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f469bc5c8ae2386af57296df0a8a17b7c223a476.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 6:08 PM, Joe Perches wrote:
> On Wed, 2019-08-07 at 17:58 -0700, Guenter Roeck wrote:
>> On 8/7/19 5:07 PM, Joe Perches wrote:
>>> On Wed, 2019-08-07 at 23:55 +0900, Masahiro Yamada wrote:
>>>> On Wed, Aug 7, 2019 at 11:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>> []
>>>>> Who is going to fix the fallout ? For example, arm64:defconfig no longer
>>>>> compiles with this patch applied.
>>>>>
>>>>> It seems to me that the benefit of catching misuses of GENMASK is much
>>>>> less than the fallout from no longer compiling kernels, since those
>>>>> kernels won't get any test coverage at all anymore.
>>>>
>>>> We cannot apply this until we fix all errors.
>>>> I do not understand why Andrew picked up this so soon.
>>>
>>> I think it makes complete sense to break -next (not mainline)
>>> and force people to fix defects.  Especially these types of
>>> defects that are trivial to fix.
>>>
>>
>> I don't think this (from next-20190807):
>>
>> Build results:
>> 	total: 158 pass: 137 fail: 21
>> Qemu test results:
>> 	total: 391 pass: 318 fail: 73
>>
>> is very useful. The situation is bad enough for newly introduced problems.
>> It is all but impossible to get fixes for all problems discovered (or introduced)
>> by adding checks like this one. In some cases, no one will care. In others,
>> no one will pick up patches. Sometimes people won't know or realize that
>> they are expected to fix something. Making the situation worse, the failures
>> introduced by the new checks will hide other accumulating problems.
>>
>> arch/sh has failed to build in mainline since 7/27 and in -next since
>> next-20190711, due to the added "fallthrough" warning. I don't think
>> that is too useful either. Ok, that situation may be a sign that the
>> architecture isn't maintained as well as it should, but I don't think
>> that this warrants breaking it on purpose in the hope to trigger
>> some kind of reaction.
>>
>> I don't mind if new checks are introduced, and I agree that it is useful
>> and makes sense. But the checks should only be introduced after a reasonable
>> attempt was made to fix _all_ associated problems. That doesn't mean that
>> the entire work has to be done by the person introducing the check, but I
>> do see that person responsible for making sure (or a reasonable definition
>> of "make sure") that all problems are fixed before actually introducing
>> the check. Yes, I understand, this is a lot of work, but adding checks
>> and letting all hell break loose can not be the answer.
> 
> No hell is unleashed.
> 
> It's -next, an integration build, not mainline.
> 

... and the breakages introduced in -next are making it into mainline
without being fixed, as I just pointed out above. That by itself is bad.
It is much worse if the breakage is introduced on purpose.

The criteria for -next _used_ to be "ready for mainline". If breaking -next
on purpose is the new normal, no one should be surprised if it will be tested
even less than it is today.

Guenter
