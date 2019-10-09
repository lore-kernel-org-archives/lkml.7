Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115B7C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D513A206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYnKIC6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfJIQiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:38:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37583 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfJIQiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:38:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id p1so1754302pgi.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 09:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cm6xEVsGwYj1bOXieZbPy4ZDP5MnNDK2qjTeg6wz+bE=;
        b=AYnKIC6JYHYX+sRMiD66kmxh0HDrEQyjtJreNsMiRGvD5zRNXvpo0NYn/dYwGvpqjx
         BLXXdFyvPUmR3WONaA4zuEKsF3MNz8ISYlA4MtwRPTP9i48G/xBxottH/Qb1q9M63bjv
         GVSrWArmpiaw4n/jK+3QxEXi9cm222bVlI2E7jd3oqkSQTXpbH817Kp37H8ZSnrsDv7z
         SMDCBEOc+uf8CMCGFcNlPeZGdQ1g8Q5Xw3jqXbrIR1/tC6rJCfF9rAWHn95PMmOqg2fN
         avrZkSVfygy5NZ8Xh9D4emZhrqZYmNx3oecZaY4YlhkazYMqam+WU2Q33JHO2JTzJwv1
         USyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cm6xEVsGwYj1bOXieZbPy4ZDP5MnNDK2qjTeg6wz+bE=;
        b=qESMvCyUJRcDn6xm7DizF9uh6YvUbe3v8z+8oahvlxnt9e0odL+YCgGh6lb5GsFKlU
         wJWKrRKVLrPBhomBFrWi5T+BQlr8axZwKmwaZfgoIe/AQm5sKQTi1lnjDu4YBBgmdVdl
         wAw/EHxB5lMQjdZJGYOVvUMt4ZmzrDiktDopWmBmtFF+oDqfx2Qf4IIfQDklG/mPA+yp
         16VD2yMzNA7SQDik/zajtMhF+qCarVamRcsUvUoJCJ4PF4/P77UtzxJEedD32vWbJO8R
         LsVg4sxnGgbSk5Sa/rabYV/L2HAokh3RXdlPecRxTdPdY8Aut29GsTPJaphnlL3OZTKP
         z1KQ==
X-Gm-Message-State: APjAAAXGR3bLduj3LM6+m2N0uuTKOpnVfYHyGmpgPEayg1ErB48eODVD
        knFrrzKfLKrkf5noYoIBw8V7D51dqmKgSwkNggVK9w==
X-Google-Smtp-Source: APXvYqy9jmbib5q9+OgtD8RKDzUQtFD3Y8lqoqffqsCvclsctxjTw5AKZGiJUAAsaeB2F9ac4ltyDo+thzV44VziO8k=
X-Received: by 2002:aa7:8210:: with SMTP id k16mr4787726pfi.84.1570639079561;
 Wed, 09 Oct 2019 09:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de> <954c5d70-742f-7b0e-57ad-ea967e93be89@rasmusvillemoes.dk>
In-Reply-To: <954c5d70-742f-7b0e-57ad-ea967e93be89@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Oct 2019 09:37:48 -0700
Message-ID: <CAKwvOdnvqj+w5hMYYe0SmcKNAJooKbMd9ULcG+mGzKd9ZRjW7g@mail.gmail.com>
Subject: Re: [PATCH] string.h: Mark 34 functions with __must_check
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 6:26 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 09/10/2019 14.14, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 9 Oct 2019 13:53:59 +0200
> >
> > Several functions return values with which useful data processing
> > should be performed. These values must not be ignored then.
> > Thus use the annotation =E2=80=9C__must_check=E2=80=9D in the shown fun=
ction declarations.
>
> This _might_ make sense for those that are basically kmalloc() wrappers
> in one way or another [1]. But what's the point of annotating pure
> functions such as strchr, strstr, memchr etc? Nobody is calling those
> for their side effects (they don't have any...), so obviously the return
> value is used. If somebody does a strcmp() without using the result, so
> what? OK, it's odd code that might be worth flagging, but I don't think
> that's the kind of thing one accidentally adds. You're also not

Just seeing the amount of trivial errors that folks push that 0day bot
spots, I don't think this would hurt.  "No true Scotsman" writes C
code without properly checking their return types (today), but if
anything it would help cut down on silly trivial mistakes before they
reach code review (assuming the code was compile tested before sent,
which a lot of it is not, as per the many many many 0day bot emails I
ignore because it's obvious folks didn't even try compiling their
code).

> consistent - strlen() is not annotated. And, for the standard C
> functions, -Wall already seems to warn about an unused call:
>
>  #include <string.h>
> int f(const char *s)
> {
>         strlen(s);
>         return 3;
> }
> $ gcc -Wall -o a.o -c a.c
> a.c: In function =E2=80=98f=E2=80=99:
> a.c:5:2: warning: statement with no effect [-Wunused-value]
>   strlen(s);
>   ^~~~~~~~~
>
> [1] Just might. The problem is the __must_check does not mean that the
> return value must be followed by a comparison to NULL and bailing out
> (that can't really be checked), it simply ensures the return value is
> assigned somewhere or used in an if(). So foo->bar =3D kstrdup() not

Which is better than nothing, IMO.

> followed by a check of foo->bar won't warn. So one would essentially
> only catch instant-leaks. __must_check is much better suited for
> functions that mutate a passed-in or global object, e.g.
> start_engine(engine).
>
> Rasmus



--=20
Thanks,
~Nick Desaulniers
