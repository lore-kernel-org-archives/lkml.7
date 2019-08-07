Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFD4C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA73621E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbfHGNRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:17:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49701 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388013AbfHGNRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:17:33 -0400
Received: from p200300ddd742df588d2c07822b9f4274.dip0.t-ipconnect.de ([2003:dd:d742:df58:8d2c:782:2b9f:4274])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvLol-0001Tv-Oi; Wed, 07 Aug 2019 15:17:27 +0200
Date:   Wed, 7 Aug 2019 15:17:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     mingo@redhat.com, bp@alien8.de, peterz@infradead.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v4 2/2] x86/purgatory: use CFLAGS_REMOVE rather than
 reset KBUILD_CFLAGS
In-Reply-To: <alpine.DEB.2.21.1907261012140.1791@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1908071517120.24014@nanos.tec.linutronix.de>
References: <20190725200625.174838-1-ndesaulniers@google.com> <20190725200625.174838-2-ndesaulniers@google.com> <alpine.DEB.2.21.1907261012140.1791@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019, Thomas Gleixner wrote:

Ping...

> On Thu, 25 Jul 2019, Nick Desaulniers wrote:
> 
> > KBUILD_CFLAGS is very carefully built up in the top level Makefile,
> > particularly when cross compiling or using different build tools.
> > Resetting KBUILD_CFLAGS via := assignment is an antipattern.
> > 
> > The comment above the reset mentions that -pg is problematic.  Other
> > Makefiles use `CFLAGS_REMOVE_file.o = $(CC_FLAGS_FTRACE)` when
> > CONFIG_FUNCTION_TRACER is set. Prefer that pattern to wiping out all of
> > the important KBUILD_CFLAGS then manually having to re-add them. Seems
> > also that __stack_chk_fail references are generated when using
> > CONFIG_STACKPROTECTOR or CONFIG_STACKPROTECTOR_STRONG.
> 
> Looking at the resulting build flags. Most stuff looks correct but there
> are a few which need to be looked at twice.
> 
> removes:
> 
>  -ffreestanding
>  -fno-builtin
>  -fno-zero-initialized-in-bss
> 
> changes:
> 
>  -mcmodel=large to -mcmodel=kernel
> 
> adds:
> 
>   -mindirect-branch-register
>   -mindirect-branch=thunk-extern
> 
> The latter makes me nervous. That probably wants to have retpoline disabled
> as well. It's not having an instance right now, but ...
> 
> Thanks,
> 
> 	tglx
> 
