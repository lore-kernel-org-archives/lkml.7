Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70197C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF6F208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393621AbfIGAOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 20:14:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:60775 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393514AbfIGAOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:14:35 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x870ECjk029556;
        Fri, 6 Sep 2019 19:14:13 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x870EBLS029555;
        Fri, 6 Sep 2019 19:14:11 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 6 Sep 2019 19:14:11 -0500
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
Message-ID: <20190907001411.GG9749@gate.crashing.org>
References: <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com> <20190906122349.GZ9749@gate.crashing.org> <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com> <20190906163028.GC9749@gate.crashing.org> <20190906163918.GJ2120@tucnak> <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com> <20190906220347.GD9749@gate.crashing.org> <CAKwvOdnWBV35SCRHwMwXf+nrFc+D1E7BfRddb20zoyVJSdecCA@mail.gmail.com> <20190906225606.GF9749@gate.crashing.org> <CAKwvOdk-AQVJnD6-=Z0eUQ6KPvDp2eS2zUV=-oL2K2JBCYaOeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk-AQVJnD6-=Z0eUQ6KPvDp2eS2zUV=-oL2K2JBCYaOeQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 04:42:58PM -0700, Nick Desaulniers via gcc-patches wrote:
> On Fri, Sep 6, 2019 at 3:56 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> Oh, I misunderstood.  I see your point.  Define the symbol as a number
> for what level of output flags you support (ie. the __cplusplus
> macro).

That works if history is linear.  I guess with enough effort we can make
that work in most cases (for backports it is a problem, if you want to
support a new feature -- or bugfix! -- you need to support all previous
ones as well...  Distros are going to hate us, too ;-) )

> > > I don't think so.  Can you show me an example codebase that proves me wrong?
> >
> > No, of course not, because we aren't silly enough to implement something
> > like that.
> 
> I still don't think feature detection is worse than version detection
> (until you find your feature broken in a way that forces the use of
> version detection).

*You* bring up version detection.  I don't.  You want some halfway thing,
with some macros that say what version some part of your compiler is.

I say to just detect the feature you want, and if it actually works the
way you want it, etc.

> Just to prove my point about version checks being brittle, it looks
> like Rasmus' version check isn't even right.  GCC supported `asm
> inline` back in the 8.3 release, not 9.1 as in this patch:

Yes, I backported it so that it is available in 7.5, 8.3, and 9.1, so
that more users will have this available sooner.  (7.5 has not been
released yet, but asm inline has been supported in GCC 7 since Jan 2
this year).

> Or was it "broken" until 9.1?  Lord knows, as `asm inline` wasn't in
> any release notes or bug reports I can find:

https://gcc.gnu.org/ml/gcc-patches/2019-02/msg01143.html

It never was accepted, and I dropped the ball.

> Ah, here it is:
> https://github.com/gcc-mirror/gcc/commit/6de46ad5326fc5e6b730a2feb8c62d09c1561f92
> Which looks like the qualifier was added to this page:
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html

Sure, it is part of the documentation just fine.  And it works just fine
too, it is a *very* simple feature.  By design.

> I like many of the GNU C extensions, and I want to help support them
> in Clang so that they can be used in more places, but the current
> process (and questions I have when I implement some of them) leaves me
> with the sense that there's probably room for improvement on some of
> these things before they go out the door.
> 
> Segher, next time there's discussion about new C extensions for the
> kernel, can you please include me in the discussions?

You can lurk on gcc-patches@ and/or gcc@?  But I'll try to remember, sure.
Not that I am involved in all such discussions myself, mind.


Segher
