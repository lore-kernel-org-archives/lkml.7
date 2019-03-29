Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D12FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74C3218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxT8PF6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfC2PzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:55:07 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41152 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbfC2PzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:55:06 -0400
Received: by mail-vs1-f68.google.com with SMTP id g187so1570934vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tjkcfhc0Ep9NbQLojkG4D6Rr/nOzsyp4ydQaHH2U3DU=;
        b=AxT8PF6TSmbJrui3ZUYKiCa5lh7j+ALt73j4h4c3hxg8++RgtqBv7M3lPxLcSQGNqa
         AWdx7bkTCP1H8hBLv3k2VzlHH7pasmL1Us478tQtENDYVXfWYKsdhBlq6LJmedAZA0kj
         YP/HK+oRnMIknrQmxDTVx3iIwouygxcSbZjRyw4neqsg03RRNNJE4Y2sVYK13w/f8bOX
         OB5F6KZrqWBQiQb9yXQWU/QCGZa+w57AQELD2QlD8WsQ6+7YV23bQiB1pVKfdLL1FuDr
         0zDcuDoQJadtvnjj8cH8LMTGZUC0y2DhfqW2BzEWrJgWSO8tHx3yjzCJsbsuMka7itep
         MZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tjkcfhc0Ep9NbQLojkG4D6Rr/nOzsyp4ydQaHH2U3DU=;
        b=eFtre40zNa6xmCTvqOeBpIZEb+jVu51H2HL4eIi25lYpBHoukH90KG/mdsA+ZE91Ji
         fPvh2ExTKval/08eGPtj5Pb3ZrfRwMwoZU7GcL8HVxeMZWWEF94cyh4OwHS4l+HqigGL
         KbzAgWnhhLmsoQD5gEi2L881NI45xV2PDlcwbfXmwO2/NMeeyJh9/lZiX75sN3LsqKNP
         PoFAfjpqykkctO5EwykxGqIUVfkW0Q+SV9cexqXNP8SJJxrV9jQ7tHb1TJt7Bz8HJEI1
         7E2Nk5qOkMFNAJsUnfXHHsjETWTsptK4uFyW65oK0j4fnf784x73lz1fTOv3rDVQq2S1
         P0dg==
X-Gm-Message-State: APjAAAVBZMKZZYhjZAEvWCQ7dpQ98HWkyNRtW6dntnfZhinHuQZzZoo7
        W+bPam/hadBJdMkeNrcZqORR+32HtF3ePeuwg5BjPw==
X-Google-Smtp-Source: APXvYqzELWOpgAuoqakTuV5C0tYv6ymmdEQyIEzbiidLl1sFRxIWMxQLggaldTdiMajvSO44OBZwx2s744HEZObORtg=
X-Received: by 2002:a67:eb57:: with SMTP id x23mr10794031vso.39.1553874904397;
 Fri, 29 Mar 2019 08:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAG_fn=X9tpSW6jvJd_COk_RU8zvcr-cxSWuJ05qcV0LotTxEEQ@mail.gmail.com>
 <20190328162222.GO4102@linux.ibm.com>
In-Reply-To: <20190328162222.GO4102@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 29 Mar 2019 16:54:52 +0100
Message-ID: <CAG_fn=WKA_4Vzsh6yH+=5TFv-EMrX87pr+2c_ANoH_MOVpbe1w@mail.gmail.com>
Subject: Re: Potentially missing "memory" clobbers in bitops.h for x86
To:     Paul McKenney <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 5:22 PM Paul E. McKenney <paulmck@linux.ibm.com> wr=
ote:
>
> On Thu, Mar 28, 2019 at 03:14:12PM +0100, Alexander Potapenko wrote:
> > Hello,
> >
> > arch/x86/include/asm/bitops.h defines clear_bit(nr, addr) for
> > non-constant |nr| values as follows:
> >
> > void clear_bit(long nr, volatile unsigned long *addr) {
> >   asm volatile("lock; btr %1,%0"
> >     : "+m"(*(volatile long *)addr)
> >     : "Ir" (nr));
> >   }
> > (https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/bi=
tops.h#L111)
> >
> > According to the comments in the file, |nr| may be arbitrarily large.
> > However the assembly constraints only imply that the first unsigned
> > long value at |addr| is written to.
> > This may result in the compiler ignoring the effect of the asm directiv=
e.
> >
> > Consider the following example (https://godbolt.org/z/naTmjn):
> >
> >   #include <stdio.h>
> >   void clear_bit(long nr, volatile unsigned long *addr) {
> >     asm volatile("lock; btr %1,%0"
> >       : "+m"(*(volatile long *)addr)
> >       : "Ir" (nr));
> >   }
> >
> >   unsigned long foo() {
> >     unsigned long addr[2] =3D {1, 2};
> >     clear_bit(65, addr);
> >     return addr[0] + addr[1];
> >   }
> >
> >   int main() {
> >     printf("foo: %lu\n", foo());
> >   }
> >
> > Depending on the optimization level, the program may print either 1
> > (for -O0 and -O1) or 3 (for -O2 and -O3).
> > This is because on higher optimization levels GCC assumes that addr[1]
> > is unchanged and directly propagates the constant to the result.
> >
> > I suspect the definitions of clear_bit() and similar functions are
> > lacking the "memory" clobber.
> > But the whole file tends to be very picky about whether this clobber
> > needs to be applied in each case, so in the case of a performance
> > penalty we may need to consider alternative approaches to fixing this
> > code.
>
> Is there a way of indicating a clobber only on the specific location
> affected?
We're unaware of such a way.
> I suppose that one approach would be to calculate in C code
> a pointer to the specific element of the addr[] array, which would
> put the specific clobbered memory location onto the outputs list.
> Or keep the current calculation, but also add "addr[nr / sizeof(long)]"
> to the output list, thus telling the compiler exactly what is being
> clobbered.  Assuming that actually works...
That works, but sometimes GCC emits the code calculating addr[nr/64]
before the BTR instruction for no reason.
Adding this output for clear_bit() makes around 120 kernel functions
change their sizes. I only checked a handful, but some contained code
like:
  cmovns %rdi, %rax
  sarq $6, %rax
  leaq (%rsi,%rax,8), %rax

Another idea we've come up with is to cast the pointer in BITOP_ADDR()
to a very big array: https://godbolt.org/z/apHvDc
Making so prevents the compiler from caching the assembly inputs, but
has its own drawbacks.
First, it may potentially yield incorrect assumptions about the size
of an object passed into the assembly (which may lead to e.g. dropping
some size checks)
Second, for smaller arrays these casts may result in excessive
clobbers (this happens in misc_register(), where GCC decides that the
input parameter |misc| may alias with the global |misc_minors|
bitmap).
Applying the cast to clear_bit() only changes the size of 3 kernel
functions: hub_port_reset(), misc_register(),
tick_broadcast_setup_oneshot().
None of them have visible semantic changes.

> Of course, this would force the compiler to actually compute the
> offset, which would slow things down.  I have no idea whether this
> would be better or worse than just using the "memory" clobber.
Just adding the "memory" clobber to clear_bit() changes sizes of 5
kernel functions (the three mentioned above, plus hub_activate() and
native_send_call_func_ipi()) by a small margin.
This probably means the performance impact of this clobber is
negligible in this case.
>                                                         Thanx, Paul
>
--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
