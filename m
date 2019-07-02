Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEAEC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1532089C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfGCBAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:00:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49758 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfGCBAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:00:33 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hiQnE-0008F2-DZ; Tue, 02 Jul 2019 23:58:28 +0200
Date:   Tue, 2 Jul 2019 23:58:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Bill Wendling <morbo@google.com>,
        Stephen Hines <srhines@google.com>
Subject: Re: objtool warnings in prerelease clang-9
In-Reply-To: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907022332000.1802@nanos.tec.linutronix.de>
References: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
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

Nick,

On Tue, 2 Jul 2019, Nick Desaulniers wrote:

> TL;DR
> LLVM currently has a bug when unrolling loops containing asm goto and
> we have a fix in hand.

<snip>

> 
> Conservatively, we can block loop unrolling when we see asm goto in a loop:

Makes sense in order to make progress.

> This causes objtool to not find any issues in
> arch/x86/kernel/cpu/mtrr/generic.o.  I don't observe any duplication
> in the __jump_table section of the resulting .o file.  It also cuts
> down the objtool warnings I observe in a defconfig (listed at the
> beginning of the email) from 4 to 2. (platform-quirks.o predates asm
> goto,

It does not have asm goto inside :)

> i915_gem_execbuffer.o is likely a separate bug).

platform-quirks.o:

        if (x86_platform.set_legacy_features)
  74:   4c 8b 1d 00 00 00 00    mov    0x0(%rip),%r11        # 7b <x86_early_init_platform_quirks+0x7b>
  7b:   4d 85 db                test   %r11,%r11
  7e:   0f 85 00 00 00 00       jne    84 <x86_early_init_platform_quirks+0x84>
                x86_platform.set_legacy_features();
}
  84:   c3                      retq   

That jne jumps to __x86_indirect_thunk_r11, aka. ratpoutine.

No idea why objtool thinks that the instruction at 0x84 is not
reachable. Josh?

Thanks,

	tglx



