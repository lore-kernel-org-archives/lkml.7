Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD9DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B0D206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbfIEOrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:47:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:48300 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbfIEOri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:47:38 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x85ElRDl031452;
        Thu, 5 Sep 2019 09:47:27 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x85ElQoY031451;
        Thu, 5 Sep 2019 09:47:26 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 5 Sep 2019 09:47:25 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
Message-ID: <20190905144725.GQ9749@gate.crashing.org>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk> <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-5-linux@rasmusvillemoes.dk> <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com> <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk> <20190905134535.GP9749@gate.crashing.org> <ceb01e88-b172-d6e7-98d4-c14ddeae87d9@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb01e88-b172-d6e7-98d4-c14ddeae87d9@rasmusvillemoes.dk>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 04:23:11PM +0200, Rasmus Villemoes wrote:
> On 05/09/2019 15.45, Segher Boessenkool wrote:
> > On Thu, Sep 05, 2019 at 01:07:11PM +0200, Rasmus Villemoes wrote:
> >> Perhaps something like below, though that
> >> won't affect the already released gcc 9.1 and 9.2, of course.
> > 
> > That is one reason to not want such a predefined macro.  Another reason
> > is that you usually need to compile some test programs *anyway*, to see if
> > some bug is present for example, or to see if the exact implementation of
> > the feature is beneficial (or harmful) to your program in some way.
> 
> OK, I think I'll just use a version check for now, and then switch to a
> Kconfig test if and when clang grows support.
> 
> >> gcc maintainers, WDYT? Can we add a feature test macro for asm inline()?
> > 
> > Why would GCC want to have macros for all features it has? 
> 
> Well, gcc has implemented __has_attribute() which is similar - one could
> detect support by compiling a trivial test program.

It is not a macro, it doesn't spill over the place, and it is for
detecting things that are already fixed strings, much easier to do :-)

> Or the same could be
> said for many of the predefined macros that are conditionally defined,
> e.g. __HAVE_SPECULATION_SAFE_VALUE.

That one happened because of the Great Security Scare of 2017/2018, it's
not a good precedent.  And, how it is set is target-specific, it can
depend on CPU model selected, target code generation options, or whatnot.

> But I was just throwing the question into the air, I won't pursue this
> further.

Maybe GCC should have a has_feature thing, it might fit in well there.
As preprocessor macros, not so much, IMO.


Segher
