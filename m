Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7402C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FFD21871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgbfYDAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfDELxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:53:42 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45333 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDELxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:53:42 -0400
Received: by mail-vs1-f66.google.com with SMTP id o10so710542vsp.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9u9Fu4LfYkIEsmgAmArLp0TPaKFcct1JYuONU35iZzs=;
        b=SgbfYDAYF1CHLhWRdBSBXUFTKQr3/4Gi5OzrNNSRzkVP0z2sM9W5GnXKWQMuEdmebY
         w+3xkWzSpUS0bmQQZloUdmm2bkmuRjU9RMpAogh5E0+m+CkQp2678rGNCxwKkHwlb77f
         5jVYWDer8Lv4sXZpcOJ1v8yJIdt9//gBFU2iiC/QjPz929n3trHmlS9StfTOvHRgDx0p
         SSlP0d8xuwFbvDa9e+68ycHsMnyoRxvsTYEjRM/4szCf3RHMAu4vp86fzGdpHYXv5AnD
         7EUfl6d9ncNlU8/hbFV2xVqX9Io/HQ6nHcFyjxORucpUwQxP6M2xDcP653b8pWYRNALB
         q43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9u9Fu4LfYkIEsmgAmArLp0TPaKFcct1JYuONU35iZzs=;
        b=FjG2TjCGMlQn4aF2b4SpYeaYqgr63IuPWWv7tYqDqr6Kp2ZPRrRUUPwc026P5prMyf
         ZxRPHq8p0qLRcG9RkIuQZnH09hVJudMxNgfHd+a0W+RAUMyng8yEBOR+egw9OWzDWdIk
         gyca3NnQFvPhTY94cU6bpsL+sYgui2xBBS9xAFcerpcz1i4AOTs4Wg6LIRaEuopSVmka
         faidlBkZ40fD4bB9NcA2Tv1fl9A4w6E+dZySD99+E83JZ/Bpcy8o6v0J+Lg+CWLpWtVX
         hP0BgAnvXx6LE+anNfk05Nk96L3cACvKYhMzE2tNPyR5ZjGg39uE5XhmtGlUBRkDtdqj
         +rNg==
X-Gm-Message-State: APjAAAWJy1g1RDXN8A/+dU8rXBmngB+1SR/nLUWpq5NdNt6G/fjGfmS1
        vJ7cazYFJP/MkFw5qy65d14eIs0slPnRGaatm+D+ng==
X-Google-Smtp-Source: APXvYqwqHAwZWvsPV9nbON8/zebGteqnuSwwrGPUbTzSU89l8Lh+ech3GPt15EFajPvZjoBh/IvvJoMBY9OsirPD75A=
X-Received: by 2002:a67:870a:: with SMTP id j10mr7369756vsd.161.1554465220986;
 Fri, 05 Apr 2019 04:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190402112813.193378-1-glider@google.com> <20190405093931.GA28890@gmail.com>
In-Reply-To: <20190405093931.GA28890@gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 5 Apr 2019 13:53:29 +0200
Message-ID: <CAG_fn=VxwY4KmY5_X3RTdNw9DhSSbozHh5jRGs4YnkkYh6iiFw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/asm: fix assembly constraints in bitops
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Paul McKenney <paulmck@linux.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 11:39 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Alexander Potapenko <glider@google.com> wrote:
>
> > 1. Use memory clobber in bitops that touch arbitrary memory
> >
> > Certain bit operations that read/write bits take a base pointer and an
> > arbitrarily large offset to address the bit relative to that base.
> > Inline assembly constraints aren't expressive enough to tell the
> > compiler that the assembly directive is going to touch a specific memor=
y
> > location of unknown size, therefore we have to use the "memory" clobber
> > to indicate that the assembly is going to access memory locations other
> > than those listed in the inputs/outputs.
> > To indicate that BTR/BTS instructions don't necessarily touch the first
> > sizeof(long) bytes of the argument, we also move the address to assembl=
y
> > inputs.
> >
> > This particular change leads to size increase of 124 kernel functions i=
n
> > a defconfig build. For some of them the diff is in NOP operations, othe=
r
> > end up re-reading values from memory and may potentially slow down the
> > execution. But without these clobbers the compiler is free to cache
> > the contents of the bitmaps and use them as if they weren't changed by
> > the inline assembly.
> >
> > 2. Use byte-sized arguments for operations touching single bytes.
> >
> > Passing a long value to ANDB/ORB/XORB instructions makes the compiler
> > treat sizeof(long) bytes as being clobbered, which isn't the case. This
> > may theoretically lead to worse code in the case of heavy optimization.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Paul E. McKenney <paulmck@linux.ibm.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: James Y Knight <jyknight@google.com>
> > ---
> >  v2:
> >   -- renamed the patch
> >   -- addressed comment by Peter Zijlstra: don't use "+m" for functions
> >   returning void
> >   -- fixed input types for operations touching single bytes
> > ---
> >  arch/x86/include/asm/bitops.h | 41 +++++++++++++++--------------------
> >  1 file changed, 18 insertions(+), 23 deletions(-)
>
> I'm wondering what the primary motivation for the patch is:
>
>  - Does it fix an actual miscompilation, or only a theoretical miscompila=
tion?
Depends on what we name an actual miscompilation.
I've built a defconfig kernel and looked through some of the functions
generated by GCC 7.3.0 with and without this clobber, and didn't spot
any miscompilations.
However there is a (trivial) theoretical case where this code leads to
miscompilation: https://lkml.org/lkml/2019/3/28/393 using just GCC
8.3.0 with -O2.
It isn't hard to imagine someone writes such a function in the kernel somed=
ay.

So the primary motivation is to fix an existing misuse of the asm
directive, which happens to work in certain configurations now, but
isn't guaranteed to work under different circumstances.

>  - If it fixes an existing miscompilation:
>
>    - Does it fix a miscompilation triggered by current/future versions of=
 GCC?
>    - Does it fix a miscompilation triggered by current/future versions of=
 Clang?
>
>  - Also, is the miscompilation triggered by 'usual' kernel configs, or
>    does it require exotics such as weird debug options or GCC plugins,
>    etc?
>
> I.e. a bit more context would be useful.
>
> Thanks,
>
>         Ingo



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
