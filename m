Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB8AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F11920684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 07:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YZXmoyDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfCHH60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:58:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34718 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfCHH6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 02:58:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id l5so16621518lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 23:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bBqLGaE12gfH+FlS8stI3irtfAErFOMW/TH2t3YKaag=;
        b=YZXmoyDH1SjE4UqAcsy5kvMnU75jZscTZpcPn8AVVYYff+Z1knFzDs38SDKN5s03YN
         GsJDV9xbKDWrg71y+Ytc1NGFp5GUw2P9/T6efB/oEBxUEMN5Z28ZReDNim9+YI7OO25F
         yzaa4SHDzrPePft9HcmXdS9d5YXsi0f7grFDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bBqLGaE12gfH+FlS8stI3irtfAErFOMW/TH2t3YKaag=;
        b=pKMWekBQWEw/gMUuQO8FAMBApr25WaTNuLxEHYvw3X7qP5K9YJ8v529EUfXZ3Sz5tk
         9gUg9u9TNyeB+v5OAIuQ5BBMdxWOIku6/f+nD7lTdMmuHHBRjywIERgm4sEOqcSXUfI2
         X9WoCanP5etT55XO01ojK7HJRemiMl/DkAdgaAOeLBzTIrAl4Tm6bRvU/l+XFL+Ek3r9
         XHoq/Bsy5SN0BP6EcZI3I5WAmELUiPgQwLuN4QhUjI3UGKcrJHIykbgv2DiWVEQzLdRO
         3ItNe+KvOnHgy7VhXfhQoJRFioGStPE/Y4McdGnmyYxXlGmUrwK/hnbjkQry4RYj1kF+
         o4ew==
X-Gm-Message-State: APjAAAXfLrezxE6VJ2VUG92nzQOZna+xDkkaMwubl8ndlzjv9gC+Kxr9
        iPahNjx4/HlAkw8LROHvZvyh0Q==
X-Google-Smtp-Source: APXvYqwu/av5z6WOHVwyeT8vi2wViRXjmRxinY+CczoNQpMZdEvvrKDj8oTEJ4plBA2aHzCmww/gyg==
X-Received: by 2002:a2e:680e:: with SMTP id c14mr8298116lja.51.1552031903157;
        Thu, 07 Mar 2019 23:58:23 -0800 (PST)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l21sm1350484lfh.30.2019.03.07.23.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 23:58:22 -0800 (PST)
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
References: <20190307010153.81157-1-bvanassche@acm.org>
 <20190307012417.GU1758@mellanox.com>
 <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
 <2c122567-d14b-7867-9230-67f570c13d15@rasmusvillemoes.dk>
 <1552003703.45180.17.camel@acm.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2d60debb-2b64-1b1f-7e16-d20720c93e28@rasmusvillemoes.dk>
Date:   Fri, 8 Mar 2019 08:58:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1552003703.45180.17.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2019 01.08, Bart Van Assche wrote:
> On Thu, 2019-03-07 at 08:18 +0100, Rasmus Villemoes wrote:
>> On 07/03/2019 03.14, Bart Van Assche wrote:
>>> On 3/6/19 5:24 PM, Jason Gunthorpe wrote:
>>>>>
>>>>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>>>>> index 40b48e2133cb..8afe0c0ada6f 100644
>>>>> +++ b/include/linux/overflow.h
>>>>> @@ -202,6 +202,24 @@
>>>>>     #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
>>>>>   +/*
>>>>> + * Evaluate a >= 0 without triggering a compiler warning if the type
>>>>> of a
>>>>> + * is an unsigned type.
>>>>> + */
>>>>> +#define is_positive(a) ({                    \
>>
>> is_non_negative, please! positive means > 0. And perhaps it's better to
>> move these utility macros closer to the top of the file, together with
>> the other type/range helpers.
> 
> Hi Rasmus,
> 
> Thank you for the feedback. But according to what I found online opinions
> about whether or not zero is a positive number seem to vary. From
> https://en.wikipedia.org/wiki/Sign_(mathematics):

Yes, I'm a mathematician, I'm aware of that. You can also find people
who use "less than" in the "<=" sense, and then say "strictly less than"
when they mean "<".

> Terminology for signs
> 
> When 0 is said to be neither positive nor negative, the following phrases
> may be used to refer to the sign of a number:
> * A number is positive if it is greater than zero.
> * A number is negative if it is less than zero.
> * A number is non-negative if it is greater than or equal to zero.
> * A number is non-positive if it is less than or equal to zero.
> 
> When 0 is said to be both positive and negative, modified phrases are used
> to refer to the sign of a number:
> * A number is strictly positive if it is greater than zero.
> * A number is strictly negative if it is less than zero.
> * A number is positive if it is greater than or equal to zero.
> * A number is negative if it is less than or equal to zero.

Right, but in no way does it ever make sense to mix these conventions.
So the options for describing ">= 0, < 0" are "non_negative, negative"
or "positive, strictly_negative".

In the context of the C language, the first convention is used. While
not explicitly stated, it can be inferred from usage of the terms.
First, the word nonnegative is used (e.g. in defining argc). Second, "If
the value of the right operand [in a shift expression] is negative [...]
the behaviour is undefined.", so certainly negative cannot include 0.
Third, E* constants are required to be positive, and "[errno] is never
set to zero by any library function". Etc. etc.

The same goes for linux source itself. I'm sure you can find
documentation in the linux source along the lines of "0 for success,
negative for error", not "strictly negative for error".

Rasmus
