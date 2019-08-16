Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F052BC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45DD21721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565996285;
	bh=+65u83ifW8MMKMWtKo0sGRREB1j9gHwK0hwJqUnpohY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hLe7zRVXsrWv3UmMQZB8Zyq7S8UZ44js7QbAUfZVMNOal+xqEKMGKI8J66KRdt6W+
	 9RlQqha4NLPRtZ/QtznLUGPh4asP5Bfmx90d/7pzsk5KYhtZCZ8GYH4yDPzReQj4+i
	 5yIJawM82riu1gSd9xdPAvBt+1dIATsA57Y+LyZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfHPW6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 18:58:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38862 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfHPW6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:58:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id x3so2582241lji.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXC2TYTHBsAB3+kPvfrJSItAbPEqUrRbxHTav3VEYko=;
        b=YoxkvQLkdxHAfQfk6Wv5S2kGFRHMWtFNVzVzORuqspgsh/3BtyoMjXUGDnB+4QPp8T
         Z7RLeD2snvq9cCNTZ1T+3yPJhs1TeM3pKtp8hiF/186uBpPOlVciHuW+LolywUqTgOEz
         Mbgc8lS5PihrbqH8uPe0iW+cZ5iwtB3qptwwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXC2TYTHBsAB3+kPvfrJSItAbPEqUrRbxHTav3VEYko=;
        b=evOEmHs6532aKmfgdQJsf+5InmFm7q4UWCrZ7zteaGN1hHp8yuONsZi1ANPLhnCxwy
         Wo4Zzx/TfGkJjIobdEbh9349DCUdBgo0REp7rETHCq2Msw1CzSo35Ytu/C05HHy7QHSq
         dVyHUJjJgxsX3U5yFn38/8tm6izkMuWdmZZA31k/UINBhjDJ9TCa7gik+vDJihQ0fZhQ
         /4UP8cvUnnm5q7n419Ai+rx5n8rPPE3gPP1rmu6ZeYryrRLPzS51S/ydaoLNzgmpnnq8
         ZoKqoAKK7EDjMQadw1N4nUxda6mvaGZfNwcDmmh2Hkq0cV8FdVbEl1mqYU3Z8b2XL0It
         S3rw==
X-Gm-Message-State: APjAAAXO7JxnLaB+AkGhJ99hdNkz9qGBM4UXNfaFvOhzJzJMw8wsY3ty
        SvK0/q6I7dmZsV05d37XcS6vMSAl6B0=
X-Google-Smtp-Source: APXvYqzC+8S2oOP01qCg01ap5IlaWpLEBx1IExmGzAcCZ2u6cWCMcLS0HyVr/IPz25NF6URoXrJ8gw==
X-Received: by 2002:a2e:8510:: with SMTP id j16mr6834576lji.174.1565996281028;
        Fri, 16 Aug 2019 15:58:01 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id l25sm1106921lfc.20.2019.08.16.15.57.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 15:57:59 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id t14so6648610lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 15:57:59 -0700 (PDT)
X-Received: by 2002:a2e:8ed5:: with SMTP id e21mr6846931ljl.156.1565996278945;
 Fri, 16 Aug 2019 15:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com> <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
In-Reply-To: <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Aug 2019 15:57:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
Message-ID: <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 3:27 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> How would you differentiate optimizations you want from those you don't with
> just a flag? There's a reason we use volatile casts instead of declaring
> everything volatile: we actually *want* those optimizations. It just so
> happens that we don't want them *in some places*, and we have tools to tag
> them as such.

We actually disable lots of "valid" (read: the standard allows them,
but they are completely wrong for the kernel) optimizations because
they are wrong.

The whole type-based alias thing is just wrong. The C standards body
was incompetent to allow that garbage. So we disable it.

If you can *prove* that no aliasing exists, go ahead and re-order
accesses. But no guesses based on random types.

Similarly, if some compiler decides that it's ok to make speculative
writes (knowing it will over-write it with the right data later) to
data that is possibly visible to other threads, then such an
"optimization" needs to just be disabled. It might help some
benchmark, and if you read the standard just the right way it might be
allowed - but that doesn't make it valid.

We already had situations like that, where compiler people thought it
would be ok (for example) to turns a narrow write into a wider
read-modify-write because it had already done the wider read for other
reasons.

Again, the original C standard "allows" that in theory, because the
original C standard doesn't take threading into account. In fact, the
alpha architecture made actively bad design decisions based on that
(incorrect) assumption.

It turns out that in that case, even non-kernel people rebelled, and
it's apparently thankfully not allowed in newer versions of the
standard, exactly because threading has become a thing. You can't
magically write back unrelated variables just because they might be
next-door neighbors and share a word.

So no, we do *not* in general just say that we want any random
optimizations. A compiler that turns a single write into something
else is almost certainly something that shouldn't be allowed near the
kernel.

We add READ_ONCE and WRITE_ONCE annotations when they make sense. Not
because of some theoretical "compiler is free to do garbage"
arguments. If such garbage happens, we need to fix the compiler, the
same way we already do with

  -fno-strict-aliasing
  -fno-delete-null-pointer-checks
  -fno-strict-overflow

because all those "optimizations" are just fundamentally unsafe and wrong.

I really wish the compiler would never take advantage of "I can prove
this is undefined behavior" kind of things when it comes to the kernel
(or any other projects I am involved with, for that matter). If you
can prove that, then you shouldn't decide to generate random code
without a big warning. But that's what those optimizations that we
disable effectively all do.

I'd love to have a flag that says "all undefined behavior is treated
as implementation-defined". There's a somewhat subtle - but very
important - difference there.

And that's what some hypothetical speculative write optimizations do
too. I do not believe they are valid for the kernel. If the code says

   if (a)
      global_var = 1
   else
      global_var = 0

then the compiler had better not turn that into

     global_var = 0
     if (a)
         global_var = 1

even if there isn't a volatile there. But yes, we've had compiler
writers that say "if you read the specs, that's ok".

No, it's not ok. Because reality trumps any weasel-spec-reading.

And happily, I don't think we've ever really seen a compiler that we
use that actually does the above kind of speculative write thing (but
doing it for your own local variables that can't be seen by other
threads of execution - go wild).

So in general, we very much expect the compiler to do sane code
generation, and not (for example) do store tearing on normal
word-sized things or add writes that weren't there originally etc.

And yes, reads are different from writes. Reads don't have the same
kind of "other threads of execution can see them" effects, so a
compiler turning a single read into multiple reads is much more
realistic and not the same kind of "we need to expect a certain kind
of sanity from the compiler" issue.

              Linus
