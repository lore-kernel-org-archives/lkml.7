Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55881C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D3120717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfDYOAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:00:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfDYOAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:00:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D360A78;
        Thu, 25 Apr 2019 07:00:45 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42D263F246;
        Thu, 25 Apr 2019 07:00:43 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:00:40 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Matveev <alxmtvv@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] arm64: sysreg: Make mrs_s and msr_s macros work with
 Clang and LTO
Message-ID: <20190425140040.GC23796@fuggles.cambridge.arm.com>
References: <20190424165537.GA48378@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424165537.GA48378@beast>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:55:37AM -0700, Kees Cook wrote:
> Clang's integrated assembler does not allow assembly macros defined
> in one inline asm block using the .macro directive to be used across
> separate asm blocks. LLVM developers consider this a feature and not a
> bug, recommending code refactoring:
> 
>   https://bugs.llvm.org/show_bug.cgi?id=19749
> 
> As binutils doesn't allow macros to be redefined, this change uses
> UNDEFINE_MRS_S and UNDEFINE_MSR_S to define corresponding macros
> in-place and workaround gcc and clang limitations on redefining macros
> across different assembler blocks.
> 
> Specifically, the current state after preprocessing looks like this:
> 
> asm volatile(".macro mXX_s ... .endm");
> void f()
> {
> 	asm volatile("mXX_s a, b");
> }
> 
> With GCC, it gives macro redefinition error because sysreg.h is included
> in multiple source files, and assembler code for all of them is later
> combined for LTO (I've seen an intermediate file with hundreds of
> identical definitions).
> 
> With clang, it gives macro undefined error because clang doesn't allow
> sharing macros between inline asm statements.
> 
> I also seem to remember catching another sort of undefined error with
> GCC due to reordering of macro definition asm statement and generated
> asm code for function that uses the macro.
> 
> The solution with defining and undefining for each use, while certainly
> not elegant, satisfies both GCC and clang, LTO and non-LTO.
> 
> Co-developed-by: Alex Matveev <alxmtvv@gmail.com>
> Co-developed-by: Yury Norov <ynorov@caviumnetworks.com>
> Co-developed-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v5: include register declaration in macro (rutland)

Cheers all, I've picked this up for 5.2 with the two Reviewed-by tags.

Will
