Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D89ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2D4206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570471892;
	bh=W8k1TFpjsbgvJTr+e1s2Lzc+haTPEP9MMkDcc8VjFCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u6cITsH7JspRSttitM3IhgxN2fKD+n3932we0ATuRZFd7co6HG7d3/lr97bIKCL2u
	 zm7ql1+UnoxWYpRvUxdiIiaqFaN0p9EEULpqjgTjs9B5bcj5lEmC8fI3RaPMQFc+KB
	 JU0kFZiFHOAAxJIsqoPJ/QqRxDPkITWmpm3xISpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfJGSLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:11:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39078 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfJGSLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:11:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id y3so14722414ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSXG+xP1mD1UZGXg2TTq5r4dUsztpjrAAtm+apLCkB0=;
        b=T9+n4Uy8+vBXnVgYXqxACSICel9I1qrO3WM1rG9o1zxB4y8+nglyP7so9RqnUS9cQ8
         DPynUXscIFi1WYKoG9zr1emFzkpLyTp2BRuohwDJ1ouK6+mq/bC+2eV4h1P0P5G2vHiB
         f45dnjMv5AzSxoSBKOdXSpYYKUfiyQB6mH0fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSXG+xP1mD1UZGXg2TTq5r4dUsztpjrAAtm+apLCkB0=;
        b=BbJ8saDVl2gqL3PkjDFyEa0pU8SB3In/flEXC/HdqZ7QEtRbm+jRi6G/gs2YIywG7x
         daGZw4cqWgANp8lshJQTBZutXK6vpPjcUbda3X1TWa+r8PrpzCl8ad8h40nA+ebvH8ds
         LAasM3X3w4X52bfan/IIYDeW/M7YjhrIp3jZdOyzr+OSyDlhKVKzvH1aHW14IZM5pFXI
         4yQbe5SR/40NEeht4sLO2CUN7gcKc8tVFtOAo+qNcWtSiHnQxnXAFRLJTVYbqTiEmkMQ
         QeTUXBMzetH8pVqpvSTsvWdAVb7FQFU/UDIuau7IEfspTBaSu1RTNUN27rovkSf4ycTq
         5SWw==
X-Gm-Message-State: APjAAAWn15EmBT/MNjoKg3B3loxQ9fMw6OYXZdsO0p262/9iOyTdapWi
        EXLk8Vhh1FJv7N5XSorNSCily344IBg=
X-Google-Smtp-Source: APXvYqwFwAbsnEOtj0mHzdvJNQkD25rycLvVvvRpUAWnHynzwfWa9M6ePJPhvAsZ6Rf5t/h3oto44A==
X-Received: by 2002:a2e:3806:: with SMTP id f6mr19787879lja.143.1570471886405;
        Mon, 07 Oct 2019 11:11:26 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id i21sm2802539lfl.44.2019.10.07.11.11.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:11:25 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id d1so14684795ljl.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:11:25 -0700 (PDT)
X-Received: by 2002:a2e:9556:: with SMTP id t22mr19099733ljh.97.1570471885049;
 Mon, 07 Oct 2019 11:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <c58c2a8a5366409abd4169d10a58196a@AcuMS.aculab.com>
In-Reply-To: <c58c2a8a5366409abd4169d10a58196a@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 11:11:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjF2fkhuN8N-MnTwvzNig83XdQK50nir8oieF7jV6Om=A@mail.gmail.com>
Message-ID: <CAHk-=wjF2fkhuN8N-MnTwvzNig83XdQK50nir8oieF7jV6Om=A@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     David Laight <David.Laight@aculab.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 8:40 AM David Laight <David.Laight@aculab.com> wrote:
>
> You don't really want an extra access_ok() for every 'word' of a copy.

Yes you do.

> Some copies have to be done a word at a time.

Completely immaterial. If you can't see the access_ok() close to the
__get/put_user(), you have a bug.

Plus the access_ok() is cheap. The real cost is the STAC/CLAC.

So stop with the access_ok() "optimizations". They are broken garbage.

Really.

I've been very close to just removing __get_user/__put_user several
times, exactly because people do completely the wrong thing with them
- not speeding code up, but making it unsafe and buggy.

The new "user_access_begin/end()" model is much better, but it also
has actual STATIC checking that there are no function calls etc inside
th4e region, so it forces you to do the loop properly and tightly, and
not the incorrect "I checked the range somewhere else, now I'm doing
an unsafe copy".

And it actually speeds things up, unlike the access_ok() games.

               Linus
