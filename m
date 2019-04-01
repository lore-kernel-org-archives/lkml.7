Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE71C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8606220645
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JkA9MNoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfDAVIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:08:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36754 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDAVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:08:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16so9679071edr.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TNGGYJ/zTFG35+oKL/qR+EOxRJJsjUK19YHRbFMQxu8=;
        b=JkA9MNoZI7NkozMs7R9p2tDnQGJD5ilyxESmikBcH0ljHUU1oKoX5q91iS0GohJwvY
         /28uPm3f/7AaneK31Dl0EfaDmsY28JrYGBhTrRYdXn7UfGkrjVlSQfM0Yg9/FaeFLvLC
         KtmJDsSppdjDv/klYwF0b2PkZFWMQPItfZrEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TNGGYJ/zTFG35+oKL/qR+EOxRJJsjUK19YHRbFMQxu8=;
        b=F0jK9BhQP62usTMaDH7I10NYLgZZghFR3hFqkT+zigYUvyqMem6H+wcBcGWyqicoza
         xaeWSpMwkx4u4meMAwC0UfBIqhAHiChnYOjm9R1U3xj7ztxtlfJd3l1v0iuoBJyIDX+u
         6OBZHq6PZ+/nBgKaNPpKWEmBl8/jg5/rWOwx6xpCMd5zQujqLXk8rcxyMzcFmAICk2tS
         PAGhGhCTjWhrZ8LVOxqjKBfftaqIxjd5MRbmMTWd5vPj9XmmRNvaxvR0KbYxp11Jo+aB
         7TRZ3WdxUUZS1SgIwOgAXk45ft5pVp3kASliXsYv3kMYtse01FbCGmchiL8PXvXK+WO3
         ChWA==
X-Gm-Message-State: APjAAAXiKbRzdR5vVdW+LtWtJMW0Gbl+uLfFnrWRyNVCzXntQl6I0FH7
        PWUHyJYTKdNo8zWD5AKJen9Y0d9yCcPbcwKi
X-Google-Smtp-Source: APXvYqzny9ILoovWtkQ9LXAjTRQ4Q2qz2skXlKAjLDrQkpKnILWuU03faL0TaelFvyqq/vS6fXsRTQ==
X-Received: by 2002:a50:910c:: with SMTP id e12mr43476556eda.130.1554152894302;
        Mon, 01 Apr 2019 14:08:14 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id q3sm3399037edr.31.2019.04.01.14.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:08:13 -0700 (PDT)
Subject: Re: [PATCH 0/5] simple sort swap function usage improvements
To:     George Spelvin <lkml@sdf.org>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
 <201903301716.x2UHG23t020732@sdf.org>
Cc:     Andrey Abramov <st5pub@yandex.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c06d9d37-bb63-c953-d390-e46cdccc1378@rasmusvillemoes.dk>
Date:   Mon, 1 Apr 2019 23:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201903301716.x2UHG23t020732@sdf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[trimming cc list]

On 30/03/2019 18.16, George Spelvin wrote:
> Great work; that is indeed a logical follow-on.
> 
> Reviewed by: George Spelvin <lkml@sdf.org>
> 
> I you feel even more ambitious, you could try impementing Rasmus
> Villemoes' idea of having generic *compare* functions.  (It's on
> my to-do list, but I haven't made meaningful progress yet, and I'm
> happy to pawn it off.)
> 
> A significant fraction of the time, the sort key is a 4- or 8-byte
> integer field in a structure at a small offset from the base or
> list_head.
> 
> A function pointer < 4096 could be interpreted as encoding:
> - Key size (1 bit)
> - Key signedness (1 bit)
> - Sort direction (1 bit)
> - Offset (9 bits; +/-256 words = +/-1024 bytes, or 0..511 words from start)
> 
> With the correct level of preprocessor hackery,
> SIMPLE_CMP_ASCENDING(struct type, key_field)
> SIMPLE_LIST_CMP_ASCENDING(struct type, list_field, key_field)
> SIMPLE_CMP_DESCENDING(struct type, key_field)
> SIMPLE_LIST_CMP_DESCENDING(struct type, list_field, key_field)

So, first of all, I don't think there's any reason to do the descending
thing, at least until there's a (or better, a handful) of potential users.

Second, I don't think the user should be concerned with the encoding,
and I'd avoid the shouting, even if it happens to be implemented as
macros because of the need to do type inspection. So I'd do

  sort_by_key(base, count, key)

where base must be of type "struct foo *" and key must be the name of a
member of struct foo. [I think most would be just fine with the default
swap - if not, that could be added, or we could add another macro also
taking a swap argument.] So this would expand to

  sort(base, count, sizeof(*base), the-encoding-stuff, NULL)

Similarly, for list_sort, I'd do

  list_sort_by_key(head, type, list-member, key-member)

which would expand to

  list_sort((long)offset_diff, head, encode typeof(type->key));

The latter is the easier one to do because we have the context argument
that goes unused in the case of a trivial comparison function. The
former would be just as easy if we decide that we only care about the
majority which are happy with the default swap function, because in that
case the offsetof(type, key) could go in the swap argument, and the cmp
argument would just be the same as for list_sort. Having the two share
the logic for "key is one of the types we support, or build bug" would
be good. Perhaps the two tiny list_sort.h and sort.h headers should be
squashed.

Rasmus
