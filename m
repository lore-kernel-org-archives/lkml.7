Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A726C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFDD20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iln5eGpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfCGHTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:19:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35155 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:19:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id t13so13292171lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 23:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aXEPtehafOQAoT6IzvlsOLdo1yhIM6njM87eXHftNaM=;
        b=iln5eGpgDU2mEKQQxmCR+j29jHlUL3QWCFj2Lc9MNkqEi9gibyJqXLcfMNn00Ap7o1
         oC1hxf4VCXdGvF5G583luAwv5RHN3eHGPzEcLbuI7lKVzn23+LrqlUT924/Zf9w9h7S5
         iZLjL28ProsEJ2nSdezZ1AkGrvIGTNciX1HhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aXEPtehafOQAoT6IzvlsOLdo1yhIM6njM87eXHftNaM=;
        b=iXNWyTYE7yy+L2jrhYZfR/FkAXJi8JU/u8ThWprc4l5XHN7XkafEurNrxHQYqyj1zZ
         8bKb705MRUr8LgkhhrLEf+zUGUMY1klenIj7+k95f7pIkixlnFBZOnejgPzTJxf+mfLc
         P3Y9/ZvYmBrCrYFutOcNSOMwYB8Xc/3I2QSv3zbZDKjB3Tj3pBAEhAd8COSiMl/f/jGH
         X3ItUUc7hpocvOj1YBH5Qe7q5F1DxLV+k4HNiLLnYU83OWx9rvGAe7C0vtK6ParEXOuI
         vn+nDYkAJYjgZLNoIKenHe7kFTS9h+LRh32272pbWln75UEH0xBvobSFt4fY7X+K6d8D
         10UA==
X-Gm-Message-State: APjAAAX41vjHXMDleTM59Um+ytAyNT7+AkIMJSqMZIzjPrOfYnJ9xSUB
        HiYSZi0xbiT+2twUYaosTclBJw==
X-Google-Smtp-Source: APXvYqwcKtKX9y466K+dMhsP5vZsWWSerkPjzucWcKA8jj5XFi6V8LN9cfnHLtfZZpjtTMnMqeXHMA==
X-Received: by 2002:a2e:9004:: with SMTP id h4mr5206930ljg.76.1551943139313;
        Wed, 06 Mar 2019 23:18:59 -0800 (PST)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2sm698277ljh.41.2019.03.06.23.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 23:18:58 -0800 (PST)
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
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2c122567-d14b-7867-9230-67f570c13d15@rasmusvillemoes.dk>
Date:   Thu, 7 Mar 2019 08:18:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2019 03.14, Bart Van Assche wrote:
> On 3/6/19 5:24 PM, Jason Gunthorpe wrote:
>>>
>>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>>> index 40b48e2133cb..8afe0c0ada6f 100644
>>> +++ b/include/linux/overflow.h
>>> @@ -202,6 +202,24 @@
>>>     #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
>>>   +/*
>>> + * Evaluate a >= 0 without triggering a compiler warning if the type
>>> of a
>>> + * is an unsigned type.
>>> + */
>>> +#define is_positive(a) ({                    \

is_non_negative, please! positive means > 0. And perhaps it's better to
move these utility macros closer to the top of the file, together with
the other type/range helpers.

>>> +    typeof(a) _minus_one = -1LL;                \
>>> +    typeof((a) + 0U) _sign_mask = _minus_one > 0 ? 0 :    \
>>>> This is probably just is_signed_type(a)
> 
> Hi Jason,
> 
> I don't think that gcc accepts something like is_signed_type(typeof(a))
> so I'm not sure that the is_signed_type() macro is useful in this context.

Of course it does, it is even already used exactly that way in overflow.h.

Nice hack, I can't come up with anything better ATM. So if you fix the
name and reuse is_signed_type instead of opencoding it you can add my ack.

>>> +                1ULL << (8 * sizeof(a) - 1);    \
>>> +                                \
>>> +    ((a) & _sign_mask) == 0;                \
>>  
>> This is the same sort of obfuscation that Leon was building, do you
>> think the & is better than his ==, >  version?
>>
>> Will gcc shortcircuit the warning if we write it as
>>
>> (is_signed_type(a) && a < 0)
>>
>> ?

Unlikely, the Wtype-limits warning trigger at a very early stage of
parsing, so it's the mere presence of the a < 0 subexpression that
tickles it. So no amount of hiding it behind short-circuiting logic or
if() statements will help. See also the comment above
__signed_mul_overflow, where even code in the the untaken branch of a
__builtin_choose_expr() can trigger Wtype-limit.

> I have tested this patch. With this patch applied no warnings are
> reported while building the mlx5 driver and the tests in
> lib/test_overflow.c pass.

In cases like this it's good to be more explicit, i.e. "I've tested this
patch with gcc 6.5.4 and...", and even better of course if one does it
with several compiler versions. Please include the above paragraph +
compiler version info in the commit log.

Rasmus
