Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5151BC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331412146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392072AbfIYRIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:08:43 -0400
Received: from foss.arm.com ([217.140.110.172]:55072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388565AbfIYRIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:08:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6799C1570;
        Wed, 25 Sep 2019 10:08:42 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 646543F694;
        Wed, 25 Sep 2019 10:08:41 -0700 (PDT)
Date:   Wed, 25 Sep 2019 18:08:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] arm64: Allow disabling of the compat vDSO
Message-ID: <20190925170838.GK7042@arrakis.emea.arm.com>
References: <20190925130926.50674-1-catalin.marinas@arm.com>
 <CAKwvOdn2Sf7aAt0zqUUqGY6nXg-C3be7An9amy4tfiNr_8ERJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn2Sf7aAt0zqUUqGY6nXg-C3be7An9amy4tfiNr_8ERJw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 09:53:16AM -0700, Nick Desaulniers wrote:
> On Wed, Sep 25, 2019 at 6:09 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > The compat vDSO building requires a cross-compiler than produces AArch32
> > binaries, defined via CONFIG_CROSS_COMPILE_COMPAT_VDSO or the
> > CROSS_COMPILE_COMPAT environment variable. If none of these is defined,
> > building the kernel always prints a warning as there is no way to
> > deselect the compat vDSO.
> >
> > Add an arm64 Kconfig entry to allow the deselection of the compat vDSO.
> > In addition, make it an EXPERT option, default n, until other issues
> > with the compat vDSO are solved (64-bit only kernel headers included in
> > user-space vDSO code, CC_IS_CLANG irrelevant to CROSS_COMPILE_COMPAT).
> 
> CC_IS_CLANG might be because then CC can be reused with different
> flags, rather than providing a different cross compiler binary via
> config option.
> 
> >
> > Fixes: bfe801ebe84f ("arm64: vdso: Enable vDSO compat support")
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Thanks for the patch.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/595

This is just a temporary hiding of the issue, not a complete fix.
Vincenzo will do the fix later on.

> Overall, this work is important to Android; the ARMv8-A series of
> mobile SoCs we see today have to support 32b and 64b (A32+A64?) for at
> least a few more years; we would like gettimeofday() and friends to be
> fast for 32b and 64b applications.

I agree, it just needs some tweaking and hopefully we get most of it
fixed in 5.4.

> > Suggestions for future improvements of the compat vDSO handling:
> >
> > - replace the CROSS_COMPILE_COMPAT prefix with a full COMPATCC; maybe
> >   check that it indeed produces 32-bit code
> >
> > - check whether COMPATCC is clang or not rather than CC_IS_CLANG, which
> >   only checks the native compiler
> 
> When cross compiling, IIUC CC_IS_CLANG is referring to CC which is the
> cross compiler, which is different than HOSTCC which is the host
> compiler.  HOSTCC is used mostly for things in scripts/ while CC is
> used to compile a majority of the kernel in a cross compile.

We need the third compiler here for the compat vDSO (at least with gcc),
COMPATCC. I'm tempted to just drop the CONFIG_CROSS_COMPILE_COMPAT_VDSO
altogether and only rely on a COMPATCC. This way we can add
COMPATCC_IS_CLANG etc. in the Kconfig checks directly.

If clang can build both 32 and 64-bit with the same binary (just
different options), we could maybe have COMPATCC default to CC and add a
check on whether COMPATCC generates 32-bit binaries.

> > - clean up the headers includes; vDSO should not include kernel-only
> >   headers that may even contain code patched at run-time
> 
> This is a big one; Clang validates the inline asm constraints for
> extended inline assembly, GCC does not for dead code.  So Clang chokes
> on the inclusion of arm64 headers using extended inline assembly when
> being compiled for arm-linux-gnueabi.

Whether clang or gcc, I'd like this fixed anyway. At some point we may
inadvertently rely on some code which is patched at boot time for the
kernel code but not for the vDSO.

Thanks.

-- 
Catalin
