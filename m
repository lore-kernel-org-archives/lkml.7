Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FECCC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 13:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE8321835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 13:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406723AbfIGNLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 09:11:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:53617 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406704AbfIGNLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 09:11:47 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x87DBShZ025586;
        Sat, 7 Sep 2019 08:11:29 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x87DBR20025585;
        Sat, 7 Sep 2019 08:11:27 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 7 Sep 2019 08:11:27 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
Message-ID: <20190907131127.GH9749@gate.crashing.org>
References: <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com> <20190906163028.GC9749@gate.crashing.org> <20190906163918.GJ2120@tucnak> <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com> <20190906220347.GD9749@gate.crashing.org> <CAKwvOdnWBV35SCRHwMwXf+nrFc+D1E7BfRddb20zoyVJSdecCA@mail.gmail.com> <20190906225606.GF9749@gate.crashing.org> <CAKwvOdk-AQVJnD6-=Z0eUQ6KPvDp2eS2zUV=-oL2K2JBCYaOeQ@mail.gmail.com> <20190907001411.GG9749@gate.crashing.org> <CAKwvOdnaBD3Dg3pmZqX2-=Cd0n30ByMT7KUNZKhq0bsDdFeXpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnaBD3Dg3pmZqX2-=Cd0n30ByMT7KUNZKhq0bsDdFeXpg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 06:04:54PM -0700, Nick Desaulniers wrote:
> On Fri, Sep 6, 2019 at 5:14 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > On Fri, Sep 06, 2019 at 04:42:58PM -0700, Nick Desaulniers via gcc-patches wrote:
> > > Just to prove my point about version checks being brittle, it looks
> > > like Rasmus' version check isn't even right.  GCC supported `asm
> > > inline` back in the 8.3 release, not 9.1 as in this patch:
> >
> > Yes, I backported it so that it is available in 7.5, 8.3, and 9.1, so
> > that more users will have this available sooner.  (7.5 has not been
> > released yet, but asm inline has been supported in GCC 7 since Jan 2
> > this year).
> 
> Ah, ok that makes sense.
> 
> How would you even write a version check for that?

I wouldn't.  Please stop using that straw man.  I'm not saying version
checks are good, or useful for most things.  I am saying they are not.

Predefined compiler symbols to do version checking (of a feature) is
just a lesser instance of the same problem though.  (And it causes its
own more or less obvious problems as well).

> > > Or was it "broken" until 9.1?  Lord knows, as `asm inline` wasn't in
> > > any release notes or bug reports I can find:
> >
> > https://gcc.gnu.org/ml/gcc-patches/2019-02/msg01143.html
> >
> > It never was accepted, and I dropped the ball.
> 
> Ah, ok, that's fine, so documentation was at least written.  Tracking
> when and where patches land (or don't) is difficult when patch files
> are emailed around.  I try to keep track of when and where our kernel
> patches land, but I frequently drop the ball there.

I keep track of most things just fine...  But the release notes are part
of our web content, which is in a separate CVS repository (still nicer
than SVN :-) ), and since I don't use it very often it falls outside of
all my normal procedures.

> your preference).  I'm already subscribed to more mailing lists than I
> have time to read.
> 
> > But I'll try to remember, sure.
> > Not that I am involved in all such discussions myself, mind.
> 
> But you _did_ implement `asm inline`. ;)

That started as just

+       /* If this asm is asm inline, count anything as minimum size.  */
+       if (gimple_asm_inline_p (as_a <gasm *> (stmt)))
+         count = MIN (1, count);

(in estimate_num_insns) but then things ballooned.  Like such things do.


Segher
