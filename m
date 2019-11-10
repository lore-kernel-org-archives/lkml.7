Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53689C17442
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 19:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229672077C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 19:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573413159;
	bh=HiTT3lm6njbhq/qDkIGL92WryXdvyuiFpNrUPrOafUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hYShruYszsZ28qOwqhbZi2/LkAMb1G3Ys1/eteZLDim2yPIoEWw6/3qyuN+JtK0l9
	 ezZp8x7LZLT+T1ptVdfvTx4//uZ41XYHdC5zJO6c7dL4s0Bm69dtSlZraBWgY9ohDg
	 YcjOK+B1TjjwlYY2HTGCK9G7SjITdxfeWz0jMzrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKJTMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 14:12:37 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37120 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfKJTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 14:12:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so8164739lfp.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 11:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LG4elcZvz/D3PgEr5WJYiguqfP8QnLPSApEBMqrYePs=;
        b=Yub5xGHdrT1qArWanymk6p8C7eRTNiutBvkJ8n8gS2pqAHqLNkGXTzXPi2nkKAR0DN
         4dzDW7hvrvmaUFN5LWgZ/Ap9OBT10+dkoUrnOVYSkGNJtmOFQ7eXOoAoWMeexZNIPGOO
         8ORoW2S0TRCiHKrjEpDUorVrm1lSxN3vlyqzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LG4elcZvz/D3PgEr5WJYiguqfP8QnLPSApEBMqrYePs=;
        b=KCNvv07JDA4sh0ngvZ4ygu23eU8FKkdtnX42ruH/ZJaqwqcRNwn5+ngHhA2LuyIfQ8
         lwC2uFJdKii1HxIe8mx9CbFhHTmnt4LMMnA480DvoUFGwNOFXGRb5hW8FPYQjS2wzKSP
         hpagFJY/xXx+CmJ8iNtaCFRKlfOtfPWh1WGKUrCmgiKXZc6dqBeSjVSGV7PCg8rUJs1i
         EW/yGFn5jpzruyKqb89VzhLG1WrawCbfENHKnahAg+f//AQifpF+xuuv4X1LcmanzB52
         JmfsP3WvioZIXv+6BPlEVtx8sI6vCqH3lfdDhT0rdBSi/mmWrT84ZMIqnTnU3VZIRVsR
         trew==
X-Gm-Message-State: APjAAAWKbVXDQZJOUQHoZi6K5S9irB+GOGXgbA7c0bei22dNtzokQ5mg
        i0ipRjx/u3YfOTJdWo25LcniUxLFgJo=
X-Google-Smtp-Source: APXvYqxBr8HzrGX5Qjo5LuKqGho+Ylb3mhcEt0CEWptWhbXQwtotJdhuechf2JnFMl68GfHwweCsCA==
X-Received: by 2002:ac2:51dd:: with SMTP id u29mr13232371lfm.135.1573413152997;
        Sun, 10 Nov 2019 11:12:32 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id t71sm2260679lff.91.2019.11.10.11.12.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 11:12:32 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id n21so11392879ljg.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 11:12:31 -0800 (PST)
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr13840664lji.1.1573413151382;
 Sun, 10 Nov 2019 11:12:31 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjB61GNmqpX0BLA5tpL4tsjWV7akaTc2Roth7uGgax+mw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1911101034180.29192-100000@netrider.rowland.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Nov 2019 11:12:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
Message-ID: <CAHk-=wjErHCwkcgO-=NReU0KR4TFozrFktbhh2rzJ=mPgRO0-g@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 8:09 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Agreed.  My point was that you were using the word in a way which did
> not match this definition.

Whatever. I claim that my use was *exactly* that "certain writes are idempotent"

> Never mind that.  You did not respond to the question at the end of my
> previous email: Should the LKMM be changed so that two writes are not
> considered to race with each other if they store the same value?

No.

The whole point is that only *certain* writes are idempotent - the
ones where we stickily set a flag or clear a flag. So the field has
exactly two possible values: the initial state, and the "something did
a write to it" state.

This is why I suggested that WRITE_IDEMPOTENT() - which is us telling
the system that "I'm now doing that sticky write of a flag, and
ordering with other threads (or within this thread) on this field
doesn't matter".

One side effect of that "ordering doesn't matter" is that we could -
if it were to be shown to be worthwhile - turn it into a "did somebody
else already do this, then I won't bother".

But that's not necessarily true in _general_. We might write the same
value back without it being a true idempotent write. Some other write
_could_ race with it and be a data race.

For example, two threads doing

   variable++;

could race, and end up writing the same value _because_ of the race.
That would obviously be a data race, and neither of the two writes are
in any way idempotent.

Similarly, a "I added new data to a linked list, you should wake up
and handle it" write would always write the same value in that
particular location, but another location would obviously clear the
flag, so now that write that sets the "new data available" flag is
_not_ idempotent, and you could _not_ replace it with a "did somebody
else already set this flag" sequence. It might look on a local scope
like a "always write the same value", and yes, it might race with
others that also write the same value, but there are also threads that
write a different value, so now it's not ok to say "did it already
have that value, in which case I can skip the write".

See why I think idempotent writes are something somewhat special -
they aren't just about writing the same value. They are about only
_ever_ writing the same value (with the caveat obviously being "over
the lifetime of that data structure, and with the initial value being
different", of course).

> That change would take care of the original issue of this email thread,
> wouldn't it?  And it would render WRITE_IDEMPOTENT unnecessary.

So I do think LKMM should say "writes of the same value must obviously
result in the same value in memory afterwards", if it doesn't already.
That's a somewhat trivial case, it's just a special case of the
single-value atomicity issue. I thought the LKMM had that already: if
you have writes of 'x' and 'y' to a variable from two CPU's, all CPU's
are supposed to see _either_ 'x' or 'y', they can't ever see a mix of
the two.

And yes, we've depended on that single-value atomicity historically.

The 'x' and 'y' have the same value is just a special case of that
general issue - if two threads write the same value, no CPU can ever
see anything but that value (or the original one). So in that sense,
fundamentally the same value write cannot race with itself.

But that LKMM rule is separate from a rule about a statistical tool like KCSAN.

Should KCSAN then ignore writes of the same value?

Maybe.

Because while that "variable++" data race with the same value is real,
the likelihood of hitting it is small, so a statistical tool like
KCSAN might as well ignore it - the tool would show the data race when
the race _doesn't_ happen, which would be the normal case anyway, and
would be the reason why the race hadn't been noticed by a normal human
being.

So practically speaking, we might say "concurrent writes of the same
value aren't data races" for KCSAN, even though they _could_ be data
races.

And this is where WRITE_IDEMPOTENT would make a possible difference.
In particular, if we make the optimization to do the "read and only
write if changed", two CPU's doing this concurrently would do

   READ 0
   WRITE 1

(for a "flag goes from 0->1" transition) and from a tool perspective,
it would be very hard to know whether this is a race (two threads
doing "variable++") or not (two threads setting a sticky flag).

So WRITE_IDEMPOTENT would then disambiguate that choice. See what I'm saying?

At the same time, I suspect that it's just simpler to say "if all the
writes we see to this field have the same value, then we will assume
it has idempotent behavior".

Even then the "all writes" would have to know the difference between
initial values and subsequent updates, which apparently isn't obvious
in KCSAN, but I don't know how hacky that kind of logic would be.

> Making that change would amount to formalizing your requirement that
> the compiler should not invent stores to shared variables.  In C11 such
> invented stores are allowed.

I don't care one whit about C11. Made-up stores to shared data are not
acceptable. Ever. We will turn that off with a compiler switch if the
compiler thinks it can do them, the same way we turn off other
incorrect optimizations like the type-based aliasing or the insane
"signed integer arithmetic can have undefined behavior" stupidity that
the standards people allowed.

I thought that has always been clear. I have not exactly been
ambiguous about my dislike of silly pointless "the standard allows me
to do stupid things".

                 Linus
