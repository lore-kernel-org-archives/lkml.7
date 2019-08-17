Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71D5C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E74D2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566030549;
	bh=pkJsPVtp5/B7U6gPLEVEGWrgn7e8aRafWlfSKHgj/Zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dUH4xE/fN1UJ14HAE/3DEwIuRFBPRIulqtx4yTsaJvM0y5UhfkhmHWf5C/RRQrGps
	 jImpJy7hWOnE0YfNL38jTpJ30WgA9d9oNhsSkFi2/8I0mVP5cNSnPgBqJd89hUwT1n
	 IFtPZSraR0jImLjhT2qitWNcyc1VJjkBbaVR4140=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfHQI3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 04:29:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33755 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfHQI3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 04:29:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so5660397lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XlKyh9+sAT5G8xYZnD/MbJfqU5oH3306V+QSOf7HE5Q=;
        b=Dnmoym7YUYJQ1wGlX051HD2wM0ytNSunxqOj+teyHwLMGb5ME+5utfTxUo1n7F1qwn
         5V8dilzCiJ/kQgv+Y0qZEOINx+uM9Zz1UhdCUzBHEII1soTuTmwsNgrKw/34CXstT/ee
         HjDHWyVuJmgTZRnehZ+wp1t1u1l25WThvTpYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlKyh9+sAT5G8xYZnD/MbJfqU5oH3306V+QSOf7HE5Q=;
        b=O7eYpS+ffiizJOnvk4Hz2BGCH2eOLE7KwZ9ExUN9zBF/SmKZuGpJuF/kxFswW4XEe5
         /dMCBqhzrgtkf6pvj5Wm9wJsQaV6sQcK0cHhyhe75aIIiZIXgiDU00C/T26/3vmhxIZL
         LBH0sid+8DSjYhm8zJfqjx2TTxHQLaQNxRGDFLnWj8rugFl5tctBAxpTx+GOg/HUmE4Y
         5XgVqnbnFUPQEe9c9iAPPZnsdeShVeWgxW3XWi5jFaBZl8dyqQQaR4aiQhT8+9+V6ZD/
         z0kib/N5m/RJB+/MQmlNglbgLh9P+X5kA7uLty/D3hwoMu2U3/a9oep0N2c9qJ2nhzNs
         l3QA==
X-Gm-Message-State: APjAAAVsOdgFySurYIwfKvlnyba+Y3dE/smzS4C1lt/BUXESNBcBAOqq
        xXK989lBmiErWvXd4sgLyAdgMh+Be50=
X-Google-Smtp-Source: APXvYqxJKdX7+UKF+RNwJNmugA1XFoEPxm9ZxdYQlEPLGYNYS2vja+nIEXHTZwJy8OyISapT8iRRdQ==
X-Received: by 2002:a05:6512:146:: with SMTP id m6mr7249784lfo.90.1566030545060;
        Sat, 17 Aug 2019 01:29:05 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j4sm1302830lfm.19.2019.08.17.01.29.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2019 01:29:04 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h28so5625190lfj.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 01:29:04 -0700 (PDT)
X-Received: by 2002:a19:c20b:: with SMTP id l11mr7275170lfc.106.1566030543835;
 Sat, 17 Aug 2019 01:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com> <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
 <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com> <20190817045217.GZ28441@linux.ibm.com>
In-Reply-To: <20190817045217.GZ28441@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Aug 2019 01:28:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOhiAJVU71968tAND6rrEJSaYPg7DXK6Y6iiz7_RJACw@mail.gmail.com>
Message-ID: <CAHk-=wiOhiAJVU71968tAND6rrEJSaYPg7DXK6Y6iiz7_RJACw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 9:52 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> > I'd love to have a flag that says "all undefined behavior is treated
> > as implementation-defined". There's a somewhat subtle - but very
> > important - difference there.
>
> It would also be nice to downgrade some of the undefined behavior in
> the standard itself.  Compiler writers usually hate this because it
> would require them to document what their compiler does in each case.
> So they would prefer "unspecified" if the could not have "undefined".

That certainly would sound very good to me.

It's not the "documented behavior" that is important to me (since it
is still going to be potentially different across different
platforms), it's the "at least it's *some* consistent behavior for
that platform".

That's just _so_ much better than "undefined behavior" which basically
says the compiler writer can do absolutely anything, whether it makes
sense or not, and whether it might open a small bug up to absolutely
catastrophic end results.

> >    if (a)
> >       global_var = 1
> >    else
> >       global_var = 0
>
> Me, I would still want to use WRITE_ONCE() in this case.

I actually suspect that if we had this kind of code, and a real reason
why readers would see it locklessly, then yes, WRITE_ONCE() makes
sense.

But most of the cases where people add WRITE_ONCE() aren't even the
above kind of half-questionable cases. They are just literally

        WRITE_ONCE(flag, value);

and since there is no real memory ordering implied by this, what's the
actual value of that statement? What problem does it really solve wrt
just writing it as

        flag = value;

which is generally a lot easier to read.

If the flag has semantic behavior wrt other things, and the write can
race with a read (whether it's the read or the write that is unlocked
is irrelevant), is still doesn't tend to make a lot of real
difference.

In the end, the most common reason for a WRITE_ONCE() is mostly just
"to visually pair up with the non-synchronized read that uses
READ_ONCE()"

Put another way: a WRITE_ONCE() without a paired READ_ONCE() is almost
certainly pointless.

But the reverse is not really true. All a READ_ONCE() says is "I want
either the old or the new value", and it can get that _without_ being
paired with a WRITE_ONCE().

See? They just aren't equally important.

> > And yes, reads are different from writes. Reads don't have the same
> > kind of "other threads of execution can see them" effects, so a
> > compiler turning a single read into multiple reads is much more
> > realistic and not the same kind of "we need to expect a certain kind
> > of sanity from the compiler" issue.
>
> Though each of those compiler-generated multiple reads might return a
> different value, right?

Right. See the examples I have in the email to Mathieu:

   unsigned int bits = some_global_value;
   ...test different bits in in 'bits' ...

can easily cause multiple reads (particularly on a CPU that has a
"test bits in memory" instruction and a lack of registers.

So then doing it as

   unsigned int bits = READ_ONCE(some_global_value);
   .. test different bits in 'bits'...

makes a real and obvious semantic difference. In ways that changing a one-time

   ptr->flag = true;

to

   WRITE_ONCE(ptr->flag, true);

does _not_ make any obvious semantic difference what-so-ever.

Caching reads is also something that makes sense and is common, in
ways that caching writes does not. So doing

    while (in_progress_global) /* twiddle your thumbs */;

obviously trivially translates to an infinite loop with a single
conditional in front of it, in ways that

   while (READ_ONCE(in_progress_global)) /* twiddle */;

does not.

So there are often _obvious_ reasons to use READ_ONCE().

I really do not find the same to be true of WRITE_ONCE(). There are
valid uses, but they are definitely much less common, and much less
obvious.

                Linus
