Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF268ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD18B2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfJII3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:29:23 -0400
Received: from foss.arm.com ([217.140.110.172]:56426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfJII3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:29:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB02B337;
        Wed,  9 Oct 2019 01:29:22 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EACF3F68E;
        Wed,  9 Oct 2019 01:29:22 -0700 (PDT)
Date:   Wed, 9 Oct 2019 09:29:20 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] arm64: lse: fix LSE atomics with LLVM's integrated
 assembler
Message-ID: <20191009082920.GM42880@e119886-lin.cambridge.arm.com>
References: <20191007201452.208067-1-samitolvanen@google.com>
 <20191008212730.185532-1-samitolvanen@google.com>
 <20191008233137.GL42880@e119886-lin.cambridge.arm.com>
 <CABCJKufHzQamE5+JtH0J4TyS05kutkty_7GwJ6w8T-szdCwHvg@mail.gmail.com>
 <20191009000159.GA531859@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009000159.GA531859@archlinux-threadripper>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 05:01:59PM -0700, Nathan Chancellor wrote:
> On Tue, Oct 08, 2019 at 04:59:25PM -0700, 'Sami Tolvanen' via Clang Built Linux wrote:
> > On Tue, Oct 8, 2019 at 4:31 PM Andrew Murray <andrew.murray@arm.com> wrote:
> > > This looks good to me. I can build and boot in a model with both Clang
> > > (9.0.6) and GCC (7.3.1) and boot a guest without anything going bang.
> > 
> > Great, thank you for testing this!
> > 
> > > Though when I build with AS=clang, e.g.
> > >
> > > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- CC=clang AS=clang Image
> > 
> > Note that this patch only fixes issues with inline assembly, which
> > should at some point allow us to drop -no-integrated-as from clang
> > builds. I believe there are still other fixes needed before AS=clang
> > works.
> > 
> > > I get errors like this:
> > >
> > >   CC      init/main.o
> > > In file included from init/main.c:17:
> > > In file included from ./include/linux/module.h:9:
> > > In file included from ./include/linux/list.h:9:
> > > In file included from ./include/linux/kernel.h:12:
> > > In file included from ./include/linux/bitops.h:26:
> > > In file included from ./arch/arm64/include/asm/bitops.h:26:
> > > In file included from ./include/asm-generic/bitops/atomic.h:5:
> > > In file included from ./include/linux/atomic.h:7:
> > > In file included from ./arch/arm64/include/asm/atomic.h:16:
> > > In file included from ./arch/arm64/include/asm/cmpxchg.h:14:
> > > In file included from ./arch/arm64/include/asm/lse.h:13:
> > > In file included from ./include/linux/jump_label.h:117:
> > > ./arch/arm64/include/asm/jump_label.h:24:20: error: expected a symbol reference in '.long' directive
> > >                  "      .align          3                       \n\t"
> > >                                                                   ^
> > > <inline asm>:4:21: note: instantiated into assembly here
> > >                 .long           1b - ., "" - .
> > >                                            ^
> > >
> > > I'm assuming that I'm doing something wrong?
> > 
> > No, this particular issue will be fixed in clang 10:
> > https://github.com/ClangBuiltLinux/linux/issues/500
> > 
> > Sami
> 
> I believe that it should be fixed with AOSP's Clang 9.0.8 or upstream
> Clang 9.0.0.

OK, understood. You can add:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Tested-by: Andrew Murray <andrew.murray@arm.com>

> 
> Cheers,
> Nathan
