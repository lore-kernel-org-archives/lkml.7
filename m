Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321DAC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BDD20830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8n5v4gJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfILVzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 17:55:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37688 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfILVzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:55:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so14054347pfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snhh3ykH84aIZLs5Gz+CeA40AYib79sbAfk5ZyhaI70=;
        b=s8n5v4gJnfb7gt/kaKEpRP+YB+hRh94I7X3HmOAoNxFgb22Ulanx24Q1RSyuqKv9TR
         lgPlC+LNGIoMs0WuOTFs5E1+2wSbuveVOboVpr4qdQjpdIocseUzri82x2rHJDOEDGgX
         6kOpIE7BW+Qa+lTvd0cu69T4usZCY6UoIK4coHmhRFvdH7ro+pLjN0vGFqrlPPuAWXpF
         AHg55QqKcZ14xZG4lhKShYKVTE8QRGUFmq/wCB+xwFnMlKu/BuHHYkziXkVGvkrO5y3Q
         kX7r7KNkwXdhOz37Z+zN5+PJ3HR89CE4yg8OAqj1gymFh9d0SaezBypUBe4c0ekVVnej
         xwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snhh3ykH84aIZLs5Gz+CeA40AYib79sbAfk5ZyhaI70=;
        b=A4KD0TbSJL7XPLGhtl/mWZO1YOhjPzM2tOA+ykPaw2L7/9o9CqxbGzVcC7CnTqKbKF
         iYsHxp9fiwUXhY3bZQYeS/EfcRgkRN0zH3lULA/8RTXsSCjAdayDo2HZaehn2ihqaAv/
         DRG7mBNP6HOyLHO/002TxIP66cVnaWqa/RelUKKH54M7/FS3O2+b6LAg+bWZw9hIp9Kj
         7OXGK1ddVeKV+56EZxL3rz10CFMMDm6MIfAZAmTF4oxxa4T5WJrrselHeJg5oRdypM4W
         Kc2wssLmiPyhbaECq4cqX61FBztqNW76ObUu4F5TA7jxs870rbyOnFg5n0ExYhSnWvi9
         cgBA==
X-Gm-Message-State: APjAAAXB7eO5nx+6ndHvOqeaFZdFK7gkixd23RNsWfIKwwW53+XKnqP3
        alFW2rum7qYxqC5BTmKA7ZEuqSAq8OQmqhuJaQ0b2A==
X-Google-Smtp-Source: APXvYqwQFXIEMuHiXgOr326U6pTaX1ruUP12TvkT2yu8gwAhcIpZACiTxoeeWjfnpxMh4QgNl2TDrc7bxKRo7c3mhIo=
X-Received: by 2002:a17:90a:ac13:: with SMTP id o19mr990839pjq.134.1568325303149;
 Thu, 12 Sep 2019 14:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
 <20190906163028.GC9749@gate.crashing.org> <20190906163918.GJ2120@tucnak>
 <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com>
 <20190906220347.GD9749@gate.crashing.org> <CAKwvOdnWBV35SCRHwMwXf+nrFc+D1E7BfRddb20zoyVJSdecCA@mail.gmail.com>
 <20190906225606.GF9749@gate.crashing.org> <CAKwvOdk-AQVJnD6-=Z0eUQ6KPvDp2eS2zUV=-oL2K2JBCYaOeQ@mail.gmail.com>
 <20190907001411.GG9749@gate.crashing.org> <CAKwvOdnaBD3Dg3pmZqX2-=Cd0n30ByMT7KUNZKhq0bsDdFeXpg@mail.gmail.com>
 <20190907131127.GH9749@gate.crashing.org>
In-Reply-To: <20190907131127.GH9749@gate.crashing.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Sep 2019 14:54:50 -0700
Message-ID: <CAKwvOdmhcaHpnqhMwzpYdjjwfAhgzq7fqA0Hu8b19E5w3AHz4w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 6:11 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Fri, Sep 06, 2019 at 06:04:54PM -0700, Nick Desaulniers wrote:
> > On Fri, Sep 6, 2019 at 5:14 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > > On Fri, Sep 06, 2019 at 04:42:58PM -0700, Nick Desaulniers via gcc-patches wrote:
> > > > Just to prove my point about version checks being brittle, it looks
> > > > like Rasmus' version check isn't even right.  GCC supported `asm
> > > > inline` back in the 8.3 release, not 9.1 as in this patch:
> > >
> > > Yes, I backported it so that it is available in 7.5, 8.3, and 9.1, so
> > > that more users will have this available sooner.  (7.5 has not been
> > > released yet, but asm inline has been supported in GCC 7 since Jan 2
> > > this year).
> >
> > Ah, ok that makes sense.
> >
> > How would you even write a version check for that?
>
> I wouldn't.  Please stop using that straw man.  I'm not saying version
> checks are good, or useful for most things.  I am saying they are not.

Then please help Rasmus with a suggestion on how best to detect and
safely make use of the feature you implemented.  As is, the patch in
question is using version checks.

>
> Predefined compiler symbols to do version checking (of a feature) is
> just a lesser instance of the same problem though.  (And it causes its
> own more or less obvious problems as well).
>
> > > > Or was it "broken" until 9.1?  Lord knows, as `asm inline` wasn't in
> > > > any release notes or bug reports I can find:
> > >
> > > https://gcc.gnu.org/ml/gcc-patches/2019-02/msg01143.html
> > >
> > > It never was accepted, and I dropped the ball.
> >
> > Ah, ok, that's fine, so documentation was at least written.  Tracking
> > when and where patches land (or don't) is difficult when patch files
> > are emailed around.  I try to keep track of when and where our kernel
> > patches land, but I frequently drop the ball there.
>
> I keep track of most things just fine...  But the release notes are part
> of our web content, which is in a separate CVS repository (still nicer
> than SVN :-) ), and since I don't use it very often it falls outside of
> all my normal procedures.
>
> > your preference).  I'm already subscribed to more mailing lists than I
> > have time to read.
> >
> > > But I'll try to remember, sure.
> > > Not that I am involved in all such discussions myself, mind.
> >
> > But you _did_ implement `asm inline`. ;)
>
> That started as just
>
> +       /* If this asm is asm inline, count anything as minimum size.  */
> +       if (gimple_asm_inline_p (as_a <gasm *> (stmt)))
> +         count = MIN (1, count);
>
> (in estimate_num_insns) but then things ballooned.  Like such things do.

So I'm not convinced this GNU C extension solves the problem it's
described to be used for.  I agree that current implementations in
multiple compilers is imprecise, and leads to developer headaches.  I
think `asm inline` will help in cases where vanilla `asm`
overestimates the size of inline assembly, but I also think it will be
just as bad as vanilla `asm` in cases where the size is
underestimated.

I have seen instances where instruction selection fails to select the
appropriate way to branch when inline asm size is misjudged, resulting
in un-encodeable jumps (as in the branch target is too far to be
encoded in the number of bits of a single jump/branch instruction).
And the use of .pushsection/.popsection assembler directives and
__attribute__((section())) attributes complicates the accounting
further, as you can then place code from the inline assembly in a
different section than the function itself (so that inline assembly
doesn't affect the function's size, and the implications on inlining
the function).  That would cause vanilla `asm` to overestimate size.
(I suspect variable length encoded instruction sets also suffer from
misaccounting).

Short of invoking the assembler itself, and then matching the byte
size of generated code section that matches the function's section,
can you accurately describe the size of inline assembly.  .macro and
.rept assembler directives really complicate estimates and can cause
vanilla `asm` to underestimate size.

I agree that current implementations in multiple compilers is
imprecise, and leads to developer headaches.  Rather than give
developers the ability to choose between 2 different heuristics that
are both imprecise, why not make the existing heuristic (ie. vanilla
`asm`) more precise in its measure?
-- 
Thanks,
~Nick Desaulniers
