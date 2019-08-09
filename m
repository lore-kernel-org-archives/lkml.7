Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D9C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F4420C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfHIV4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:56:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:48105 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfHIV4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:56:19 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x79LtXlt029610;
        Fri, 9 Aug 2019 16:55:33 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x79LtWbT029609;
        Fri, 9 Aug 2019 16:55:32 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 9 Aug 2019 16:55:32 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] powerpc: fix inline asm constraints for dcbz
Message-ID: <20190809215531.GN31406@gate.crashing.org>
References: <87h873zs88.fsf@concordia.ellerman.id.au> <20190809182106.62130-1-ndesaulniers@google.com> <CAK8P3a3LynWTbpV8=VPm2TqgNM2MnoEyCPJd0PL2D+tcZqJgHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3LynWTbpV8=VPm2TqgNM2MnoEyCPJd0PL2D+tcZqJgHg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 08:28:19PM +0200, Arnd Bergmann wrote:
> On Fri, Aug 9, 2019 at 8:21 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> 
> >  static inline void dcbz(void *addr)
> >  {
> > -       __asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
> > +       __asm__ __volatile__ ("dcbz %y0" : "=Z"(*(u8 *)addr) :: "memory");
> >  }
> >
> >  static inline void dcbi(void *addr)
> >  {
> > -       __asm__ __volatile__ ("dcbi %y0" : : "Z"(*(u8 *)addr) : "memory");
> > +       __asm__ __volatile__ ("dcbi %y0" : "=Z"(*(u8 *)addr) :: "memory");
> >  }
> 
> I think the result of the discussion was that an output argument only kind-of
> makes sense for dcbz, but for the others it's really an input, and clang is
> wrong in the way it handles the "Z" constraint by making a copy, which it
> doesn't do for "m".

Yes.  And clang has probably miscompiled this in all kernels since we
have used "Z" for the first time, in 2008 (0f3d6bcd391b).

It is not necessarily fatal or at least not easily visible for the I/O
accessors: it "just" gets memory ordering wrong slightly (it looks like
it does the sync;tw;isync thing around an extra stack access, after it
has performed the actual I/O as any other memory load, without any
synchronisation).

> I'm not sure whether it's correct to use "m" instead of "Z" here, which
> would be a better workaround if that works. More importantly though,
> clang really needs to be fixed to handle "Z" correctly.

"m" allows offset addressing, which these insns do not.  That is the
same reason you need the "y" output modifier.  "m" is wrong here.

We have other memory constraints, but do those work with LLVM?


Segher
