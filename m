Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908F4C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FFF20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GhyDxWei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDII5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:57:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41350 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDII5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:57:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so13716496lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hz50zNjPM0KGYzgE4vnn6yr+6Sp846byASD0KGXRd74=;
        b=GhyDxWeiRZHMHtc3zMaGRZ74EEbex0chK25u9+LcWWT1qzf6tyjjsDwOqohGhV4v3c
         OMC3R3MXsKcCQ81ihrWSGU/UfsWQkhXfF2JnagpJilL56fl8lNJZ64ZZaCzCUQJRS9Pa
         3Ru4+g1VJ82qIChW+zxAQKdYhxzNVKdVv0LGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hz50zNjPM0KGYzgE4vnn6yr+6Sp846byASD0KGXRd74=;
        b=qm9i4zoce7OH9oFLVvvOz18C6OEXiyPnfQvg03hjEvK5pGEiYhBTGuEIUZzifv7Txh
         CHam3opmIwxUfpbGqyJ3qZ82WXIV711q4Kun6S8YGYdlHuAWnJIR7fRqEELzEXqkATr5
         fZrr74M/MHD/9jJGsin6CPmxBpWyu4vBcHidrlNHfPz0UydDYqwTuZ3eMWSkH9HK6Sf2
         jXHkWIMNPis3SyptufyLCUVuvz4CtZ0X6uXgYmIXtIMkIs25ZNo1+x2viDJ7SaK0jmDx
         LRqxf7Vjxjh0QmOiOhqBFwc0UK9KxWA+VIWs/0MEYI1PI9JhOgKbfXmoP0uPUR4nlRMT
         D+4A==
X-Gm-Message-State: APjAAAWcGxNPIjwubfuS9HX/gEY4gof4aDhFrQ5Q1y8iZ3N+OvqN6UyU
        fz8DmY8pWKpc56E5n0m0g0P/Wg==
X-Google-Smtp-Source: APXvYqzdGnU3vv6Gc/MdZHRWLeQwjdWvVGbEoTn/NBZwRsDds1/H+WATgRxG0dT6vn6/wvRzC0+tkA==
X-Received: by 2002:a2e:8ece:: with SMTP id e14mr2658963ljl.66.1554800253423;
        Tue, 09 Apr 2019 01:57:33 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id j9sm6693320lja.92.2019.04.09.01.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 01:57:32 -0700 (PDT)
Subject: Re: [PATCH v1 bitops] bitops: Fix UBSAN undefined behavior warning
 for rotation right
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        idosch@mellanox.com, Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <20190407125325.24440-1-vadimp@mellanox.com>
 <20190408155217.3f723554ae7fbcb34eeacb30@linux-foundation.org>
 <f38907e5-82a4-1e9f-a3a4-b4e366dbb90b@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <b631316b-74bc-7d19-c6a4-70b5459b44cc@rasmusvillemoes.dk>
Date:   Tue, 9 Apr 2019 10:57:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f38907e5-82a4-1e9f-a3a4-b4e366dbb90b@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2019 10.08, Rasmus Villemoes wrote:

> one could do
> 
> u32 ror32(u32 x, unsigned s)
> {
> 	return (x >> (s&31)) | (x << ((32-s)&31));
> }
> 
> to make the shifts always well-defined and also work as expected for s
> >= 32... if only gcc recognized that the masking is redundant, so that
> its "that's a ror" pattern detection could kick in. Unfortunately, it
> seems that the above generates
> 
>    0:   89 f1                   mov    %esi,%ecx
>    2:   89 f8                   mov    %edi,%eax
>    4:   f7 d9                   neg    %ecx
>    6:   d3 e0                   shl    %cl,%eax
>    8:   89 f1                   mov    %esi,%ecx
>    a:   d3 ef                   shr    %cl,%edi
>    c:   09 f8                   or     %edi,%eax
>    e:   c3                      retq
> 
> while without the masking one gets
> 
>   10:   89 f8                   mov    %edi,%eax
>   12:   89 f1                   mov    %esi,%ecx
>   14:   d3 c8                   ror    %cl,%eax
>   16:   c3                      retq

Ah, but that's with an ancient gcc 7. With gcc 8, the above pattern is
recognized and generates good code, while eliminating UB. I was about to
file a gcc bug, but found
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82498 .

Rasmus

