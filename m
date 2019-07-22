Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36539C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B22218BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbfGVR6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:58:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:36871 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfGVR6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:58:47 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6MHwIwq002804;
        Mon, 22 Jul 2019 12:58:18 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x6MHwH9G002785;
        Mon, 22 Jul 2019 12:58:17 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 22 Jul 2019 12:58:17 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
Message-ID: <20190722175817.GE20882@gate.crashing.org>
References: <a5864549-40c3-badd-8c41-d5b7bf3c4f3c@c-s.fr> <20190709064952.GA40851@archlinux-threadripper> <20190719032456.GA14108@archlinux-threadripper> <20190719152303.GA20882@gate.crashing.org> <20190719160455.GA12420@archlinux-threadripper> <20190721075846.GA97701@archlinux-threadripper> <20190721180150.GN20882@gate.crashing.org> <20190722024140.GA55142@archlinux-threadripper> <20190722061940.GZ20882@gate.crashing.org> <CAKwvOd=KRVsFkT8dLFoitky9OF8tKmbn00-OPi6kBygyx4QwHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=KRVsFkT8dLFoitky9OF8tKmbn00-OPi6kBygyx4QwHg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 10:21:07AM -0700, Nick Desaulniers wrote:
> On Sun, Jul 21, 2019 at 11:19 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > On Sun, Jul 21, 2019 at 07:41:40PM -0700, Nathan Chancellor wrote:
> > > On Sun, Jul 21, 2019 at 01:01:50PM -0500, Segher Boessenkool wrote:
> > > > On Sun, Jul 21, 2019 at 12:58:46AM -0700, Nathan Chancellor wrote:
> > > > > 0000017c clear_user_page:
> > > > >      17c: 94 21 ff f0                     stwu 1, -16(1)
> > > > >      180: 38 80 00 80                     li 4, 128
> > > > >      184: 38 63 ff e0                     addi 3, 3, -32
> > > > >      188: 7c 89 03 a6                     mtctr 4
> > > > >      18c: 38 81 00 0f                     addi 4, 1, 15
> > > > >      190: 8c c3 00 20                     lbzu 6, 32(3)
> > > > >      194: 98 c1 00 0f                     stb 6, 15(1)
> > > > >      198: 7c 00 27 ec                     dcbz 0, 4
> > > > >      19c: 42 00 ff f4                     bdnz .+65524
> > > >
> > > > Uh, yeah, well, I have no idea what clang tried here, but that won't
> > > > work.  It's copying a byte from each target cache line to the stack,
> > > > and then does clears the cache line containing that byte on the stack.
> > > >
> > > > I *guess* this is about "Z" and not about "%y", but you'll have to ask
> > > > the clang people.
> > > >
> > > > Or it may be that they do not treat inline asm operands as lvalues
> > > > properly?  That rings some bells.  Yeah that looks like it.
> >
> > The code is
> >   __asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
> >
> > so yeah it looks like clang took that  *(u8 *)addr  as rvalue, and
> > stored that in stack, and then used *that* as memory.
> 
> What's the %y modifier supposed to mean here?

It prints a memory address for an indexed operand.

If you write just "%0" it prints addresses that are a single register
as "0(r3)" instead of "0,r3".  Some instructions do not allow offset
form.

> addr is in the list of
> inputs, so what's wrong with using it as an rvalue?

It seems to use *(u8 *)addr as rvalue.  Asm operands are lvalues.  It
matters a lot for memory operands.

> > Maybe clang simply does not not to treat "Z" the same as "m"?  (And "Y"
> > and "Q" and "es" and a whole bunch of "w*", what about those?)


Segher
