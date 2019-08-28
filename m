Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFF8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F294D2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfH1NOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:14:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34216 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1NOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:14:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so6277edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 06:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KHeRGL4aqlYuS+QGDNpxxJ5B0TcroXeJiWbbnAbYbdk=;
        b=lpFYCVjeh2P/Q4Vwrbf5hpMuniRWNxn2KpcwMblN/43yWZWFS9dG2Ytipj/lUyajGz
         BWuzRbI1TKbqp8qOyB4lXp7WkA5/iPazQJRpxVsxDkMu/acUX83R61GIaeJS+2wV3QH0
         u6Q34zETHThomTIEMA6n1Wx3txsH77Dp/de2IqKUdtbcgOBcmUq57e6PXaoPWjEiupNJ
         xgF4WhlFfEki2A2O5yCRLKiKyJDIINehkx719qzdPDQlp9sJd5ole4ZmpYjdgyubopJM
         NkMxxZ08fNVN7GYiRVDfpMop2CKasTAdji4ELFUi17GSp8A+zaf2WcCpyr8QXXk8rL5m
         Ke3w==
X-Gm-Message-State: APjAAAWVj/YRJePLHQyFiMjDABmyi4eoHqZ7N7O+gOI3WGHLvDcjkpOJ
        izEolu4r+G0Az1X/kaw6J+VKBGCkVT4=
X-Google-Smtp-Source: APXvYqxbn/sKxGYSWrREShM/LTA0onX3ygJknBIUAs5sGw4bIdelExi5i5FXcyQMNDSp1GeI+DFmSA==
X-Received: by 2002:a50:f4b6:: with SMTP id s51mr3985246edm.204.1566998073884;
        Wed, 28 Aug 2019 06:14:33 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id f22sm455742edr.15.2019.08.28.06.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 06:14:33 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
 <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
 <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
 <16053035-655a-7d53-29d1-ea914e3a21dd@linux.com>
 <75f5210f-43a3-ab0d-912a-6dff6163fd9a@rasmusvillemoes.dk>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <40010cac-8a49-9d82-4cde-e14a0216c340@linux.com>
Date:   Wed, 28 Aug 2019 16:14:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <75f5210f-43a3-ab0d-912a-6dff6163fd9a@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 4:05 PM, Rasmus Villemoes wrote:
> On 28/08/2019 14.33, Denis Efremov wrote:
>> On 8/28/19 2:33 PM, Rasmus Villemoes wrote:
>>> On 25/08/2019 21.19, Julia Lawall wrote:
>>>>
>>>>
>>>>> On 26 Aug 2019, at 02:59, Denis Efremov <efremov@linux.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>>> On 25.08.2019 19:37, Joe Perches wrote:
>>>>>>> On Sun, 2019-08-25 at 16:05 +0300, Denis Efremov wrote:
>>>>>>> This patch adds coccinelle script for detecting !likely and !unlikely
>>>>>>> usage. It's better to use unlikely instead of !likely and vice versa.
>>>>>>
>>>>>> Please explain _why_ is it better in the changelog.
>>>>>>
>>>>>
>>>>> In my naive understanding the negation (!) before the likely/unlikely
>>>>> could confuse the compiler
>>>>
>>>> As a human I am confused. Is !likely(x) equivalent to x or !x?
>>>
>>> #undef likely
>>> #undef unlikely
>>> #define likely(x) (x)
>>> #define unlikely(x) (x)
>>>
>>> should be a semantic no-op. So changing !likely(x) to unlikely(x) is
>>> completely wrong. If anything, !likely(x) can be transformed to
>>> unlikely(!x).
>>
>> As far as I could understand it:
>>
>> # define likely(x)	__builtin_expect(!!(x), 1)
>> # define unlikely(x)	__builtin_expect(!!(x), 0)
>>
>> From GCC doc:
>> __builtin_expect compares the values. The semantics of the built-in are that it is expected that exp == c.
> 
> When I said "semantic" I meant from the C language point of view. Yes,
> of course, the whole reason for having these is that we can give hints
> to gcc as to which branch is more likely. Replace the dummy defines by
> #define likely(x) (!!(x)) if you like - it amounts to the same thing
> when it's only ever used in a boolean context.
> 
>> if (!likely(cond))
>> if (!__builtin_expect(!!(cond), 1))
>> if (!((!!(cond)) == 1))
> 
> You're inventing this comparison to 1. It should be "if (!(!!(cond)))",
> but it ends up being equivalent in C.
> 
>> if ((!!(cond)) != 1) and since !! could result in 0 or 1
>> if ((!!(cond)) == 0)
> 
> which in turn is equivalent to !(cond).
> 
>>
>> if (unlikely(cond))
>> if (__builtin_expect(!!(cond), 0))
>> if ((!!(cond)) == 0))
> 
> No, that last transformation is wrong. Yes, the _expectation_ is that
> !!(cond) has the value 0, but that does not mean that the whole
> condition turns into "does !!(cond) compare equal to 0?" - we _expect_
> that it does, meaning that we expect not to enter the if block. Read the
> docs, the value of __builtin_expect(whatever, foobar) is whatever, so a
> correct third line above would be
> 
>   "if (!!(cond))"
> 
> which is of course not at all the same as
> 
>   "if (!!(cond) == 0)" aka "if (!(cond))"

I get it, you are right. Thank you for the explanation.

Denis
