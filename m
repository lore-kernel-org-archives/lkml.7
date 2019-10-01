Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAD5C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3812168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389891AbfJAQO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:14:56 -0400
Received: from foss.arm.com ([217.140.110.172]:53242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbfJAQO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:14:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB1E4337;
        Tue,  1 Oct 2019 09:14:55 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32F2F3F71A;
        Tue,  1 Oct 2019 09:14:55 -0700 (PDT)
Date:   Tue, 1 Oct 2019 17:14:53 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] Partially revert "compiler: enable
 CONFIG_OPTIMIZE_INLINING forcibly"
Message-ID: <20191001161453.GO42880@e119886-lin.cambridge.arm.com>
References: <20190930114540.27498-1-will@kernel.org>
 <CAK7LNARWkQ-z02RYv3XQ69KkWdmEVaZge07qiYC8_kyMrFzCTg@mail.gmail.com>
 <20191001104253.fci7s3sn5ov3h56d@willie-the-truck>
 <20191001114129.GL42880@e119886-lin.cambridge.arm.com>
 <20191001143626.GI25745@shell.armlinux.org.uk>
 <20191001152826.GM42880@e119886-lin.cambridge.arm.com>
 <20191001154814.GJ25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001154814.GJ25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 04:48:14PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Oct 01, 2019 at 04:28:27PM +0100, Andrew Murray wrote:
> > I hadn't noticed the use of __OPTIMIZE__ - indeed if __compiletime_assert
> > is no-op'd and you reach it then you won't have a build error - but you
> > may get uninitialised values instead.
> > 
> > Presumably the purpose of __OPTIMIZE__ in this case is to prevent getting
> > an undefined function error for the __compiletime_assert line, even though
> > it doesn't get called (when using a compiler that doesn't optimize out the
> > call to the unused function).
> > 
> > Why is the call to __get_user_bad not guarded in this way for when
> > __OPTIMIZE__ isn't set, i.e. why doesn't it suffer from the issue
> > that the following fixes?
> 
> Officially, the kernel does not support building with -O0.  To start
> with, the top level makefile has:
> 
> ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> KBUILD_CFLAGS   += -Os
> else
> KBUILD_CFLAGS   += -O2
> endif
> 
> and we've said for years that the kernel relies upon the compiler
> optimiser to build correctly.  You may be lucky if you pass it via
> some method to 'make' but that's going to rely on the argument order
> to the compiler, and the order in which the compiler processes its
> arguments, and whether it (for example) correctly disables all
> optimisations if it encounters -O0 somewhere.

So in practice, __OPTIMIZE__ will likely always be set, as far as I
can tell it's supported in GCC, Clang and Intel compilers.  Though
the exception to this is for crypto/jitterentropy.c where the -O0 flag
is unconditionally set.

Are there other exceptions to this in terms of compilers?

Perhaps it may be possible to use BUILD_BUG after all.

Thanks,

Andrew Murray

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
