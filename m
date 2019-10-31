Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D58C47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32E921906
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfJaJCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:02:43 -0400
Received: from foss.arm.com ([217.140.110.172]:45954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJaJCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:02:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE80531F;
        Thu, 31 Oct 2019 02:02:41 -0700 (PDT)
Received: from blommer (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 627483F71E;
        Thu, 31 Oct 2019 02:02:37 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:02:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Torsten Duwe <duwe@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, Jessica Yu <jeyu@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 2/8] module/ftrace: handle patchable-function-entry
Message-ID: <20191031090231.GA3340@blommer>
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <20191029165832.33606-3-mark.rutland@arm.com>
 <20191030150302.GA965@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030150302.GA965@suse.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 04:03:02PM +0100, Torsten Duwe wrote:
> On Tue, Oct 29, 2019 at 04:58:26PM +0000, Mark Rutland wrote:
> > When using patchable-function-entry, the compiler will record the
> > callsites into a section named "__patchable_function_entries" rather
> > than "__mcount_loc". Let's abstract this difference behind a new
> > FTRACE_CALLSITE_SECTION, so that architectures don't have to handle this
> > explicitly (e.g. with custom module linker scripts).
> > 
> > As parisc currently handles this explicitly, it is fixed up accordingly,
> > with its custom linker script removed. Since FTRACE_CALLSITE_SECTION is
> > only defined when DYNAMIC_FTRACE is selected, the parisc module loading
> > code is updated to only use the definition in that case. When
> > DYNAMIC_FTRACE is not selected, modules shouldn't have this section, so
> > this removes some redundant work in that case.
> > 
> > I built parisc generic-{32,64}bit_defconfig with DYNAMIC_FTRACE enabled,
> > and verified that the section made it into the .ko files for modules.
> 
> This is because of remaining #ifdeffery in include/asm-generic/vmlinux.lds.h:
> 
> #ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
> #define MCOUNT_REC()    . = ALIGN(8);                           \
>                         __start_mcount_loc = .;                 \
>                         KEEP(*(__patchable_function_entries))   \
>                         __stop_mcount_loc = .;
> #else
> #define MCOUNT_REC()    . = ALIGN(8);                           \
>                         __start_mcount_loc = .;                 \
>                         KEEP(*(__mcount_loc))                   \
>                         __stop_mcount_loc = .;
> #endif

For modules we use a combination of scripts/module-common.lds and an
architecture's own module.lds, not vmlinux.lds.h. So I don't think the above is
relevant for modules.

For modules the kernel's ELF loader looks for the ELF ection, not the
__{start,stop}_mcount_loc symbols that we use for the main kernel image.

FWIW, when building a module, I see the following linker operations:

| [mark@blommer:~/src/linux]% toolchain korg gcc-8.1.0-nolibc make V=1 ARCH=arm64 CROSS_COMPILE=aarch64-linux- arch/arm64/crypto/sha512-ce.ko | grep aarch64-linux-ld
|   aarch64-linux-ld  -EL  -maarch64elf    -r -o arch/arm64/crypto/sha512-ce.o arch/arm64/crypto/sha512-ce-glue.o arch/arm64/crypto/sha512-ce-core.o
|   aarch64-linux-ld -r  -EL  -maarch64elf  --build-id  -T ./scripts/module-common.lds -T ./arch/arm64/kernel/module.lds -o arch/arm64/crypto/sha512-ce.ko arch/arm64/crypto/sha512-ce.o arch/arm64/crypto/sha512-ce.mod.o;  true

> Maybe you want to tackle that as well? I suggest to have at least one
> FTRACE_CALLSITE_SECTION definition without double quotes. Alternatively, my
> earlier solution just kept both sections, in case either one or both are
> present.
> 
>                         KEEP(*(__patchable_function_entries))   \
>                         KEEP(*(__mcount_loc))                   \

I agree that the CC_USING_PATCHABLE_FUNCTION_ENTRY ifdeffery could be
simplified, and that it would be nice to consistently use
FTRACE_CALLSITE_SECTION if we can. However, the generic linker script doesn't
include anything, and I don't see a good location for that to live.

What I could do is add an explicit comment:

/*
 * The ftrace call sites are logged to a section whose name depends on the
 * compiler option used. A given kernel image will only use one, AKA
 * FTRACE_CALLSITE_SECTION. We capture all of them here to avoid header
 * dependencies.
 */
#define MCOUNT_REC()						\
			. = ALIGN(8);				\
			__start_mcount_loc = .;			\
			KEEP(*(__patchable_function_entries))   \
			KEEP(*(__mcount_loc))                   \
			__stop_mcount_loc = .;			

... which should make the dependency clear. Does that sound good to you?

Thanks,
Mark.
