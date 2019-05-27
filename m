Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4A4C46470
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211FE2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RQVILT43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfE0Hxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:53:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45127 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0Hxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:53:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id r76so3039956lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 00:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u/jG7PRHQvQ/gJu4mWkgic1YFhICzQ7oYnhDTYgh/+A=;
        b=RQVILT43qONfsxpQOQEQsUoX7Zku4pvkoHN7Vng5hM09sRKV87QSs0JRpHBdlpprBe
         UkGMd+fEQJlvhhZ6OtbZHb9Ar1EAWn9mxSrnIoAqRkqlQtLAj/tgjjBdWtEyxv+6xdR3
         s9kC4Hm3+NrcuGFU450aVm6xCpDsoUvA9zv0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/jG7PRHQvQ/gJu4mWkgic1YFhICzQ7oYnhDTYgh/+A=;
        b=fs5s04XV4SGv8Caqz/dNbyvVucn01r90tw589TWCd1+Y90fyJe6dzYik7a3F4vM4wg
         783bxk//3jgLwE6sKP+e+SMI6QFGAqkP4YOYevsv9AQ9V8A9ri8667FlepufyUlSgkBh
         orqzMUv2yWFOrNZtoV4T9l1dk74W+TfDhRAe5T18uM8ioxGWvZn878Ltw6v1B1730bdw
         K91VF2sQclkGu05vaXWLwGDuL1q/h0oGehsF5xLxOqmH+owBOCl1aBc3TRz4qwwtXK9+
         69ymu1y9nNdDU6XpT0SObGeFGt7BJHdU3Aw6vleyyIogWDChVzt7ijuDIENK1BarxC5a
         sHsA==
X-Gm-Message-State: APjAAAUtUkWVLHtUufPxq+7McFkXInkd+QA9ULH+yk1k9pUBmElJO5Ze
        +Ut/ewtCunOxSg8FzQRwfXs/Tw==
X-Google-Smtp-Source: APXvYqw+Ija1yj1WbZ5QX3cIC+EjlZ9jBXxlLm1pyF3XxZqbylvz/66EsA4BJLkcl+dOysbZnAJljQ==
X-Received: by 2002:a2e:80d5:: with SMTP id r21mr7934450ljg.43.1558943616590;
        Mon, 27 May 2019 00:53:36 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p5sm2124466ljg.55.2019.05.27.00.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 00:53:35 -0700 (PDT)
Subject: Re: lib/test_overflow.c causes WARNING and tainted kernel
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <9fa84db9-084b-cf7f-6c13-06131efb0cfa@infradead.org>
 <CAGXu5j+yRt_yf2CwvaZDUiEUMwTRRiWab6aeStxqodx9i+BR4g@mail.gmail.com>
 <e2646ac0-c194-4397-c021-a64fa2935388@infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <97c4b023-06fe-2ec3-86c4-bfdb5505bf6d@rasmusvillemoes.dk>
Date:   Mon, 27 May 2019 09:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e2646ac0-c194-4397-c021-a64fa2935388@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2019 17.33, Randy Dunlap wrote:
> On 3/13/19 7:53 PM, Kees Cook wrote:
>> Hi!
>>
>> On Wed, Mar 13, 2019 at 2:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> This is v5.0-11053-gebc551f2b8f9, MAR-12 around 4:00pm PT.
>>>
>>> In the first test_kmalloc() in test_overflow_allocation():
>>>
>>> [54375.073895] test_overflow: ok: (s64)(0 << 63) == 0
>>> [54375.074228] WARNING: CPU: 2 PID: 5462 at ../mm/page_alloc.c:4584 __alloc_pages_nodemask+0x33f/0x540
>>> [...]
>>> [54375.079236] ---[ end trace 754acb68d8d1a1cb ]---
>>> [54375.079313] test_overflow: kmalloc detected saturation
>>
>> Yup! This is expected and operating as intended: it is exercising the
>> allocator's detection of insane allocation sizes. :)
>>
>> If we want to make it less noisy, perhaps we could add a global flag
>> the allocators could check before doing their WARNs?
>>
>> -Kees
> 
> I didn't like that global flag idea.  I also don't like the kernel becoming
> tainted by this test.

Me neither. Can't we pass __GFP_NOWARN from the testcases, perhaps with
a module parameter to opt-in to not pass that flag? That way one can
make the overflow module built-in (and thus run at boot) without
automatically tainting the kernel.

The vmalloc cases do not take gfp_t, would they still cause a warning?

BTW, I noticed that the 'wrap to 8K' depends on 64 bit and
pagesize==4096; for 32 bit the result is 20K, while if the pagesize is
64K one gets 128K and 512K for 32/64 bit size_t, respectively. Don't
know if that's a problem, but it's easy enough to make it independent of
pagesize (just make it 9*4096 explicitly), and if we use 5 instead of 9
it also becomes independent of sizeof(size_t) (wrapping to 16K).

Rasmus
