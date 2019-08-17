Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E76C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D262077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566029305;
	bh=31G2fZvblQwduGVTpGb4MFnBbceID6jx0Drcm+ncMDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Blf5eEjOkNPvgYw5SkuvxwjIt7DzmLc+iLiwhK/uLILMETj+P6XfQL4EFW+cUwKDx
	 R3iQtZGnunlHifkxyRizFBRRSjCc7uTAPg4g7Eg/gnlkqL/iO+h1QCYlmpejt0b8kZ
	 J7OchBRTVlOvG/W1IpznkNNEoxn7aR5jyKkc4R7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfHQIIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 04:08:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46159 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfHQIIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 04:08:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id f9so7236113ljc.13
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 01:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vp+MGTABPU/puudI66VKq7mS0MIIOOVXXSvOEmbq4Vc=;
        b=XnXHa9lOHjOFvPMmo8A8mnN5Zy8EDYnLSw8sZsPPtKuv7Bh7u/15iBwKR/WjCmHXcn
         Yk56GYQUBunYG0pnq61rRscJeJ3JCbUHjtLp8xJhXdP0Jrc4dWN17Uw/8YK2ImuCjx8i
         g6bnklRqS4rVL3SLNkQwZO9zW+9JgoLLdy0OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vp+MGTABPU/puudI66VKq7mS0MIIOOVXXSvOEmbq4Vc=;
        b=Ru/cVllH+3ai0CqBVQgwO5CIkMexT3TBQZUbsNZy6tj6CQyA1iWAwpAgx/T7gPjyqm
         i3RHT8MAqZoOR94OlXHIF0o+3kDAz2ElFxY2lurDRwdpPji10sUnmhrchmlXvYnOyPow
         oOejiXVRvam7TFNRPmC15ibRyZJNd6i+498AsS0DrCIewPEP80lNVV4w4WUV88HptlaP
         h0tqpmUu5Vvxc5GtRFfj29TNm/lDLs408VyoKqLtNUyZR/otokoyWwouXDoxBInsZsjS
         xNRZMsZdv/0xC1PbTy5feK/kJVY68UX+Ep5qBxIhV/+JI1MmdH2Lhb2kugBLiyoEUVDb
         E63A==
X-Gm-Message-State: APjAAAVSBiaoxJ00xhspBiRg9o6PI40k/EVEzptn8lPuWlKhZWvM1EyQ
        r4FVAWruiHBTHGSO36aBJX0C+qchPu0=
X-Google-Smtp-Source: APXvYqw6GitEmcwBA2LNh5gHbaiiSE0/eBsyCFvTG4TITNCe3YlI5Zwi2EGMxDoM+sgyGXvoel/HAQ==
X-Received: by 2002:a2e:63cd:: with SMTP id s74mr3866199lje.3.1566029300348;
        Sat, 17 Aug 2019 01:08:20 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id s20sm1337116ljg.88.2019.08.17.01.08.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2019 01:08:19 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id j17so5623111lfp.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 01:08:18 -0700 (PDT)
X-Received: by 2002:ac2:48b8:: with SMTP id u24mr7116353lfg.170.1566029298663;
 Sat, 17 Aug 2019 01:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com> <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
In-Reply-To: <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Aug 2019 01:08:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com>
Message-ID: <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
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

On Fri, Aug 16, 2019, 18:36 Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> If WRITE_ONCE has any use at all (protecting against store tearing and
> invented stores), it should be used even with a lock held in this
> scenario, because the lock does not prevent READ_ONCE() from observing
> transient states caused by lack of WRITE_ONCE() for the update.

The thing is, we really haven't requred WRITE_ONCE() to protect
against store tearing.

We have lots of traditional code that does stuff along the lines of

   .. set of data structure ..
   smp_wmb();
   *ptr = newdata;

and we simply *depend* on the compiler doing the "*ptr" as a single
write. We've simply always done that.  Even on UP we've had the
"interrupts will see old value or new value but not some random
half-way value", going all the way back to the original kernel
sources.

The data tearing issue is almost a non-issue. We're not going to add
WRITE_ONCE() to these kinds of places for no good reason.

> So why does WRITE_ONCE exist in the first place ? Is it for documentation
> purposes only or are there actual situations where omitting it can cause
> bugs with real-life compilers ?

WRITE_ONCE should be seen mainly as (a) documentation and (b) for new code.

Although I suspect often you'd be better off using smb_load_acquire()
and smp_store_release() when you have code sequences where you have
unlocked READ_ONCE/WRITE_ONCE and memory ordering.

WRITE_ONCE() doesn't even protect against data tearing. If you do a
"WRITE_ONCE()" on a type larger than 8 bytes, it will fall back to
__builtin_memcpy().

So honestly, WRITE_ONCE() is often more documentation than protecting
against something, but overdoing it doesn't help document anything, it
just obscures the point.

Yeah, yeah, it will use a "volatile" access for the proper normal
types, but even then that won't protect against data tearing on 64-bit
writes on a 32-bit machine, for example. It doesn't even give ordering
guarantees for the sub-words.

So you still end up with the almost the same basic rule: a natural
byte/word write will be atomic. But really, it's going to be so even
without the WRITE_ONCE(), so...

It does ostensibly protect against the compiler re-ordering the write
against other writes (note: *compiler*, not CPU), and it does make
sure the write only happens once. But it's really hard to see a valid
compiler optimization that wouldn't do that anyway.

Because of the compiler ordering of WRITE_ONCE against other
WRITE_ONCE cases, it could be used for irq-safe ordering on the local
cpu, for example. If that matters. Although I suspect any such case is
practically going to use per-cpu variables anyway.

End result: it's *mostly* about documentation.

Just do a grep for WRITE_ONCE() vs READ_ONCE(). You'll find a lot more
users of the latter. And quite frankly, I looked at some of the
WRITE_ONCE() users and a lot of them were kind of pointless.

Somebody tell me just exactly how they expect the WRITE_ONCE() cases
in net/tls/tls_sw.c to matter, for example (and that was literally a
random case I happened to look at). It's not clear what they do, since
they certainly don't imply any memory ordering. They do imply a
certain amount of compiler re-ordering due to the volatile, but that's
pretty limited too. Only wrt _other_ things with side effects, not the
normal code around them anyway.

In contrast, READ_ONCE() has very practical examples of mattering,
because unlike writes, compilers really can reasonably split reads.
For example, if you're testing multiple bits in the same word, and you
want to make sure they are coherent, you should very much do

   val = READ_ONCE(mem);
   .. test different bits in val ..

because without the READ_ONCE(), the compiler could end up just doing
the read multiple times.

Similarly, even if you only use a value once, this is actually
something a compiler can do:

    if (a) {
         lock();
         B()
         unlock();
   } else
         B();

and a compiler might end up generating that as

   if (a) lock();
   B();
   if (a) unlock();

instead. So doing "if (READ_ONCE(a))" actually makes a difference - it
guarantees that 'a' is only read once, even if that value was
_literally_ only used on a source level, the compiler really could
have decided "let's read it twice".

See how duplicating a read is fundamentally different from duplicating
a write? Duplicating or splitting a read is not visible to other
threads. Notice how nothiing like the above is reasonable for a write.

That said, the most common case really is none of the above half-way
subtle cases. It's literally the whole "write pointer once". Making
existing code that does that use WRITE_ONCE() is completely pointless.
It's not going to really change or fix anything at all.

                 Linus
