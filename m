Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F9DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4225207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390302AbfIFQao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:30:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:56683 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfIFQan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:30:43 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x86GUT4l007488;
        Fri, 6 Sep 2019 11:30:29 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x86GUSDf007487;
        Fri, 6 Sep 2019 11:30:28 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 6 Sep 2019 11:30:28 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
Message-ID: <20190906163028.GC9749@gate.crashing.org>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk> <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-5-linux@rasmusvillemoes.dk> <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com> <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk> <20190905134535.GP9749@gate.crashing.org> <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com> <20190906122349.GZ9749@gate.crashing.org> <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 05:13:54PM +0200, Miguel Ojeda wrote:
> On Fri, Sep 6, 2019 at 2:23 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > I can't find anything with "feature" and "macros" in the C++ standard,
> > it's "predefined macros" there I guess?  In C, it is also "predefined
> > macros" in general, and there is "conditional feature macros".
> 
> They are introduced in C++20,

(Which isn't the C++ standard yet, okay).

> but they have been added for a lot of
> older features in both the language (see [cpp.predefined]p1, around 50
> of them) and the library (see [support.limits.general]p3, ~100):
> 
>     http://eel.is/c++draft/cpp.predefined#tab:cpp.predefined.ft
>     http://eel.is/c++draft/support.limits#tab:support.ft

And they spell it "feature-test" there.  Lovely :-/

> > Sure.  But the name is traditional, many decades old, it predates glibc.
> > Using an established name to mean pretty much the opposite of what it
> > normally does is a bit confusing, never mind if that usage makes much
> > sense ;-)
> 
> Agreed on principle :-) However, I wouldn't say it is the opposite. I
> would say they are the same, but from different perspectives: one says
> "I want to test if the user enabled the feature", the other says "I
> want to test if the vendor implemented the feature".

No, that is not what it does.  A user defines such a macro, and that
makes the library change behaviour.

As the GNU C Library manual explains:

     This system exists to allow the library to conform to multiple
  standards.  Although the different standards are often described as
  supersets of each other, they are usually incompatible because larger
  standards require functions with names that smaller ones reserve to the
  user program.  This is not mere pedantry -- it has been a problem in
  practice.  For instance, some non-GNU programs define functions named
  'getline' that have nothing to do with this library's 'getline'.  They
  would not be compilable if all features were enabled indiscriminately.

https://www.gnu.org/software/libc/manual/html_node/Feature-Test-Macros.html


Segher
