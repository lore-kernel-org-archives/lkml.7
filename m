Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9A9C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8A32084D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfHIWLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:11:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:33074 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfHIWLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:11:25 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x79MAsUH030114;
        Fri, 9 Aug 2019 17:10:54 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x79MArRl030113;
        Fri, 9 Aug 2019 17:10:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 9 Aug 2019 17:10:52 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        kbuild test robot <lkp@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] powerpc: fix inline asm constraints for dcbz
Message-ID: <20190809221052.GP31406@gate.crashing.org>
References: <87h873zs88.fsf@concordia.ellerman.id.au> <20190809182106.62130-1-ndesaulniers@google.com> <CAK8P3a3LynWTbpV8=VPm2TqgNM2MnoEyCPJd0PL2D+tcZqJgHg@mail.gmail.com> <20190809220301.Horde.AR6y4Bx4WGIq58V9K0En9g4@messagerie.si.c-s.fr> <CAK8P3a1AwmAe+PpHTRmN153fhG4ZkF_pb+240rj1ZAg-S6SKeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1AwmAe+PpHTRmN153fhG4ZkF_pb+240rj1ZAg-S6SKeg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 10:12:56PM +0200, Arnd Bergmann wrote:
> @@ -106,7 +106,7 @@ static inline u##size name(const volatile u##size
> __iomem *addr)    \
>  {                                                                      \
>         u##size ret;                                                    \
>         __asm__ __volatile__("sync;"#insn" %0,%y1;twi 0,%0,0;isync"     \
> -               : "=r" (ret) : "Z" (*addr) : "memory");                 \
> +               : "=r" (ret) : "m" (*addr) : "memory");                 \
>         return ret;                                                     \
>  }

That will no longer compile something like
  u8 *p;
  u16 x = in_le16(p + 12);
(you'll get something like "invalid %y value, try using the 'Z' constraint").

So then you remove the %y, but that makes you get something like
  sync;lhbrx 3,12(3);twi 0,3,0;isync
which is completely wrong.


Segher
