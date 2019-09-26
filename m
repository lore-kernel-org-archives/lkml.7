Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFDDC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A89E21A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfIZHr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:47:26 -0400
Received: from foss.arm.com ([217.140.110.172]:41236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfIZHr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:47:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C81B1000;
        Thu, 26 Sep 2019 00:47:25 -0700 (PDT)
Received: from iMac.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B8F3F836;
        Thu, 26 Sep 2019 00:47:24 -0700 (PDT)
Date:   Thu, 26 Sep 2019 08:47:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] arm64: Allow disabling of the compat vDSO
Message-ID: <20190926074717.GA26802@iMac.local>
References: <20190925130926.50674-1-catalin.marinas@arm.com>
 <CAKwvOdn2Sf7aAt0zqUUqGY6nXg-C3be7An9amy4tfiNr_8ERJw@mail.gmail.com>
 <20190925170838.GK7042@arrakis.emea.arm.com>
 <a7e06b86-facd-21de-c47c-246d0da8d80d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e06b86-facd-21de-c47c-246d0da8d80d@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 01:06:50AM +0100, Vincenzo Frascino wrote:
> On 9/25/19 6:08 PM, Catalin Marinas wrote:
> > On Wed, Sep 25, 2019 at 09:53:16AM -0700, Nick Desaulniers wrote:
> >> On Wed, Sep 25, 2019 at 6:09 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>> Suggestions for future improvements of the compat vDSO handling:
> >>>
> >>> - replace the CROSS_COMPILE_COMPAT prefix with a full COMPATCC; maybe
> >>>   check that it indeed produces 32-bit code
> 
> CROSS_COMPILE_COMPAT is called like this for symmetry with CROSS_COMPILE.

Actually, what gets in the way is the CONFIG_CROSS_COMPILE_COMPAT_VDSO.
We can keep CROSS_COMPILE_COMPAT together with COMPATCC initialised to
$(CROSS_COMPILE_COMPAT)gcc. When we will be able to build the compat
vDSO with clang, we just pass COMPATCC=clang on the make line and the
kernel Makefile will figure out the --target option from
CROSS_COMPILE_COMPAT (see how CLANG_FLAGS is handled).

If we stick only to env variables or make cmd line (without Kconfig) for
the compiler name, we can add a COMPATCC_IS_CLANG in the Kconfig
directly and simply not allow the enabling the COMPAT_VDSO if we don't
have the right compiler. This saves us warnings during build.

> >>> - check whether COMPATCC is clang or not rather than CC_IS_CLANG, which
> >>>   only checks the native compiler
> >>
> >> When cross compiling, IIUC CC_IS_CLANG is referring to CC which is the
> >> cross compiler, which is different than HOSTCC which is the host
> >> compiler.  HOSTCC is used mostly for things in scripts/ while CC is
> >> used to compile a majority of the kernel in a cross compile.
> > 
> > We need the third compiler here for the compat vDSO (at least with gcc),
> > COMPATCC. I'm tempted to just drop the CONFIG_CROSS_COMPILE_COMPAT_VDSO
> > altogether and only rely on a COMPATCC. This way we can add
> > COMPATCC_IS_CLANG etc. in the Kconfig checks directly.
> > 
> > If clang can build both 32 and 64-bit with the same binary (just
> > different options), we could maybe have COMPATCC default to CC and add a
> > check on whether COMPATCC generates 32-bit binaries.
> 
> clang requires the --target option for specifying the 32bit triple.
> Basically $(TRIPLE)-gcc is equivalent to gcc --target $(TRIPLE).
> We need a configuration option to encode this.

Since we don't have a CONFIG_* option for the cross-compiler prefix, we
shouldn't have one for the compat compiler either. If you want to build
the compat vDSO with clang, just pass COMPATCC=clang together with
CROSS_COMPILE_COMPAT. We can add Kconfig checks to actually verify that
COMPATCC generates 32-bit binaries (e.g. COMPATCC_CAN_LINK32).

> >>> - clean up the headers includes; vDSO should not include kernel-only
> >>>   headers that may even contain code patched at run-time
> >>
> >> This is a big one; Clang validates the inline asm constraints for
> >> extended inline assembly, GCC does not for dead code.  So Clang chokes
> >> on the inclusion of arm64 headers using extended inline assembly when
> >> being compiled for arm-linux-gnueabi.
> > 
> > Whether clang or gcc, I'd like this fixed anyway. At some point we may
> > inadvertently rely on some code which is patched at boot time for the
> > kernel code but not for the vDSO.
> 
> Do we have any code of this kind in header files?
> 
> The vDSO library uses only a subset of the headers (mainly Macros) hence all the
> unused symbols should be compiled out. Is your concern only theoretical or do
> you have an example on where this could be happening?

At the moment it's rather theoretical.

-- 
Catalin
