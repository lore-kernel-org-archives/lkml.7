Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BE1C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD0E239EB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XJiVT0UR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfFCUC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 16:02:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36081 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfFCUCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:02:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so28549349edx.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=06mX7DZj6K5oJW8VbpxeNXsQxMH44Hoi5GZ+vc9+3NU=;
        b=XJiVT0URG98q8ll/RZfM8w8XIeepi8T+vKHfUMBB8AjYOpsLbSxEAQd3SeIR0f5Uzi
         6i/MK28pOh1yhBVv6t7QpezDUwTK7rSJ33HZ6bYMzRfiW1/2hYWUxJWnQY4GWfVWHuyo
         gx8tXxBYgCPlaMNFG3KqwCJr+X1a5Di6EnGPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=06mX7DZj6K5oJW8VbpxeNXsQxMH44Hoi5GZ+vc9+3NU=;
        b=JHaj4zucAC16AGBxU0ipMxFWM2hkfC4uvoIRDfzDffd1z0qxLt60amwBL9yVyjFksY
         XnfhzFSeQd6dfe9xcE8ou5psVUH7eWUZhLFiNd/qeCwDhUJ7NZXEbWpVi2IaWppwm/Wf
         L49HL4Mr9Vp3bf2vDqMW1fQJC4yyqlszID8Wd9YdVWz8F//8mLAekNNOPqJwytsYNvaK
         LjT++n8zQEA2wLyN4GF5ywX0wF68LdyI8AEyzW1QnjYStueoSv3ElywuAm85w6z4Mh4P
         QbS2hICt7ApYKXL6fjpyHmC2l59wzrdbAJVd1X5cLG2YQ+52JjPMAbLc04U2tdjsrpv6
         +qQw==
X-Gm-Message-State: APjAAAXAB5ZuPIKfgGo2jbHTqkUDB3tph5iS0mB2b2XWvaqCqh/EjFep
        NovUmXsVH56Ed+TxZWMLolhhDFAVvNfPX+u1
X-Google-Smtp-Source: APXvYqzYYELpm5TEhVNJOw5fhHjs2QJBBfdKH5bpit0zIOS3GFcVZn1EQEEl79k5OejkBy8RCFQRUA==
X-Received: by 2002:a17:906:ce21:: with SMTP id sd1mr7186359ejb.189.1559592143343;
        Mon, 03 Jun 2019 13:02:23 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id e45sm4149864edb.12.2019.06.03.13.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:02:22 -0700 (PDT)
Subject: Re: arm64 patch
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAKwvOd=r3x7Z-4M-xY-+G9HhHeMFbizsSWvNLGK+DSfoaY_wjQ@mail.gmail.com>
 <20190515033158.GA31802@archlinux-i9>
 <20190521224209.d33c11d59eaabcbb44d28b2a@linux-foundation.org>
 <245ffcf0-6e0f-18ed-9c5f-1362a77c4097@rasmusvillemoes.dk>
Message-ID: <9eddb8d2-da20-3dd5-ccbc-e8d0824eb715@rasmusvillemoes.dk>
Date:   Mon, 3 Jun 2019 22:02:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <245ffcf0-6e0f-18ed-9c5f-1362a77c4097@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2019 08.21, Rasmus Villemoes wrote:
> On 22/05/2019 07.42, Andrew Morton wrote:
> 
> Andrew, please drop the following five patches from your tree (sha1s as
> per next-20190522):
> 
> f418571688c5 powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for PPC64
> 0dd95e972ef8 arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
> 1a086a6f12ca x86_64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
> a6e9afb84c99 lib/dynamic_debug.c: add asm-generic implementation for
> DYNAMIC_DEBUG_RELATIVE_POINTERS
> e301d47f9756 lib/dynamic_debug.c: introduce
> CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS

And, since the cover letter was folded into 1/10 and almost everything
in there doesn't apply anymore, please also drop the rest, i.e.

2485c16b7714 lib/dynamic_debug.c: drop use of bitfields in struct _ddebug
4c3e1594c3cc lib/dynamic_debug.c: introduce accessors for string members
of struct _ddebug
e44665d77b55 linux/printk.h: use unique identifier for each struct _ddebug
a7a47cbde940 linux/net.h: use unique identifier for each struct _ddebug
2ab6736a2041 linux/device.h: use unique identifier for each struct _ddebug

Thanks,
Rasmus
