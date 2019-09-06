Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24857C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0052120842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392738AbfIFW40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:56:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:48209 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390953AbfIFW40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:56:26 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x86Mu8lf026379;
        Fri, 6 Sep 2019 17:56:08 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x86Mu6LQ026376;
        Fri, 6 Sep 2019 17:56:06 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 6 Sep 2019 17:56:06 -0500
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
Message-ID: <20190906225606.GF9749@gate.crashing.org>
References: <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk> <20190905134535.GP9749@gate.crashing.org> <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com> <20190906122349.GZ9749@gate.crashing.org> <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com> <20190906163028.GC9749@gate.crashing.org> <20190906163918.GJ2120@tucnak> <CAKwvOd=MT_=U250tR+t0jTtj7SxKJjnEZ1FmR3ir_PHjcXFLVw@mail.gmail.com> <20190906220347.GD9749@gate.crashing.org> <CAKwvOdnWBV35SCRHwMwXf+nrFc+D1E7BfRddb20zoyVJSdecCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnWBV35SCRHwMwXf+nrFc+D1E7BfRddb20zoyVJSdecCA@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 03:35:02PM -0700, Nick Desaulniers wrote:
> On Fri, Sep 6, 2019 at 3:03 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > And if instead you tested whether the actual feature you need works as
> > you need it to, it would even work fine if there was a bug we fixed that
> > breaks things for the kernel.  Without needing a new compiler.
> 
> That assumes a feature is broken out of the gate and is putting the
> cart before the horse.  If a feature is available, it should work.

GCC currently has 91696 bug reports.

> > Or as another example, if we added support for some other flags. (x86
> > has only a few flags; many other archs have many more, and in some cases
> > newer hardware actually has more flags than older).
> 
> I think compiler flags are orthogonal to GNU C extensions we're discussing here.

No, I am talking exactly about what you brought up.  The flags output
for inline assembler, using the =@ syntax.  If I had implemented that
for Power when it first came up, I would by now have had to add support
for another flag (the CA32 flag).  Oh, and I would not have implemented
support for OV or SO at all originally, but perhaps they are useful, so
let's add that as well.  And there is OV32 now as well.

> > With the "macro" scheme we would need to add new macros in all these
> > cases.  And since those are target-specific macros, that quickly expands
> > beyond reasonable bounds.
> 
> I don't think so.  Can you show me an example codebase that proves me wrong?

No, of course not, because we aren't silly enough to implement something
like that.

> > If you want to know if you can do X in some environment, just try to do X.
> 
> That's a very autoconf centric viewpoint.  Why doesn't the kernel take
> that approach for __GCC_ASM_FLAG_OUTPUTS__?

Ask them, not me.


Segher
