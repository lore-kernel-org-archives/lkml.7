Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7312422DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WSsKwCPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfH1NFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:05:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40167 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1NFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:05:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id e27so2479367ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aBa6809B/gHmmp4EpJcSDmUhGHIHI4rcokmH6bw1gyQ=;
        b=WSsKwCPevwM8s1mITSowZLAEJU5REzl86rGVN24r6SjtlDX0IQWaB8QQ9VXCwOn8Zp
         K/PmXTjuOr3CcPL0LngY392mz4Rd21YRpIMz/a8ENgEDXRn1XoVnWHghXUKcY5mfmpvu
         3g9v8QhtedgvwVoVeXfzZKPJbXj8f48RM4Qgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aBa6809B/gHmmp4EpJcSDmUhGHIHI4rcokmH6bw1gyQ=;
        b=jtURRpUwvrg8uW1EaQt4dYHYlu6RaGBQEISRdKYoLDjvjeXFubzRXsKIu6/J5Jx9ZM
         d448A3aPbwQ/cr+EJkPo61+PwK8aB4PWEDbJQB4byFEL7nBCncOCynJgfVcVY7xjGl/+
         VfmU2zx/aKgk2zTgCOFHWR2hdl679nDTpQ1ZRm4oRfVuFrbv5KjdW2G5iQRLqAWVY3uG
         Dpooo+jBBEQpQPTSxO2V+rCiYnupdfakxf5r6h+Toy7TtFk3uuLqiXMNINPZK0d8xQb0
         qmeAkzYw/g1yhjuUd+ggGfbhQYmeepd6TMtPh6iz0T7BhEMAPn7RWG19Yst+/9JdxnGk
         QrLg==
X-Gm-Message-State: APjAAAUySVYB8/uxBXHFsQy6swdvcbde5GLR+GIWJFyLjJ9v07zUKBbt
        TscWhwuQnEGOAGUVeoIADFVh6FVIrziGdrpi
X-Google-Smtp-Source: APXvYqz4yGLr4MGxBo5VJWyaqo6TFhaeYqH/ywXBE+2q3Vp56Fd9pHlJnOjWCrtiu1mWL7N9i1fAXQ==
X-Received: by 2002:a2e:2a05:: with SMTP id q5mr1876171ljq.132.1566997509964;
        Wed, 28 Aug 2019 06:05:09 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o5sm851790lfn.42.2019.08.28.06.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 06:05:09 -0700 (PDT)
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
To:     efremov@linux.com, Julia Lawall <julia.lawall@lip6.fr>
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
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <75f5210f-43a3-ab0d-912a-6dff6163fd9a@rasmusvillemoes.dk>
Date:   Wed, 28 Aug 2019 15:05:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <16053035-655a-7d53-29d1-ea914e3a21dd@linux.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2019 14.33, Denis Efremov wrote:
> On 8/28/19 2:33 PM, Rasmus Villemoes wrote:
>> On 25/08/2019 21.19, Julia Lawall wrote:
>>>
>>>
>>>> On 26 Aug 2019, at 02:59, Denis Efremov <efremov@linux.com> wrote:
>>>>
>>>>
>>>>
>>>>> On 25.08.2019 19:37, Joe Perches wrote:
>>>>>> On Sun, 2019-08-25 at 16:05 +0300, Denis Efremov wrote:
>>>>>> This patch adds coccinelle script for detecting !likely and !unlikely
>>>>>> usage. It's better to use unlikely instead of !likely and vice versa.
>>>>>
>>>>> Please explain _why_ is it better in the changelog.
>>>>>
>>>>
>>>> In my naive understanding the negation (!) before the likely/unlikely
>>>> could confuse the compiler
>>>
>>> As a human I am confused. Is !likely(x) equivalent to x or !x?
>>
>> #undef likely
>> #undef unlikely
>> #define likely(x) (x)
>> #define unlikely(x) (x)
>>
>> should be a semantic no-op. So changing !likely(x) to unlikely(x) is
>> completely wrong. If anything, !likely(x) can be transformed to
>> unlikely(!x).
> 
> As far as I could understand it:
> 
> # define likely(x)	__builtin_expect(!!(x), 1)
> # define unlikely(x)	__builtin_expect(!!(x), 0)
> 
> From GCC doc:
> __builtin_expect compares the values. The semantics of the built-in are that it is expected that exp == c.

When I said "semantic" I meant from the C language point of view. Yes,
of course, the whole reason for having these is that we can give hints
to gcc as to which branch is more likely. Replace the dummy defines by
#define likely(x) (!!(x)) if you like - it amounts to the same thing
when it's only ever used in a boolean context.

> if (!likely(cond))
> if (!__builtin_expect(!!(cond), 1))
> if (!((!!(cond)) == 1))

You're inventing this comparison to 1. It should be "if (!(!!(cond)))",
but it ends up being equivalent in C.

> if ((!!(cond)) != 1) and since !! could result in 0 or 1
> if ((!!(cond)) == 0)

which in turn is equivalent to !(cond).

> 
> if (unlikely(cond))
> if (__builtin_expect(!!(cond), 0))
> if ((!!(cond)) == 0))

No, that last transformation is wrong. Yes, the _expectation_ is that
!!(cond) has the value 0, but that does not mean that the whole
condition turns into "does !!(cond) compare equal to 0?" - we _expect_
that it does, meaning that we expect not to enter the if block. Read the
docs, the value of __builtin_expect(whatever, foobar) is whatever, so a
correct third line above would be

  "if (!!(cond))"

which is of course not at all the same as

  "if (!!(cond) == 0)" aka "if (!(cond))"

Rasmus
