Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BCBC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3A72064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGJHbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:31:31 -0400
Received: from foss.arm.com ([217.140.110.172]:56798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfGJHbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:31:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44192344;
        Wed, 10 Jul 2019 00:31:30 -0700 (PDT)
Received: from [10.1.196.120] (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCE8E3F246;
        Wed, 10 Jul 2019 00:33:25 -0700 (PDT)
Subject: Re: [RFC V3 00/18] objtool: Add support for arm64
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com
References: <20190624095548.8578-1-raphael.gault@arm.com>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <e4ce2867-1d9c-54f4-73a5-668057e423a7@arm.com>
Date:   Wed, 10 Jul 2019 08:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190624095548.8578-1-raphael.gault@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Just a gentle ping to see if anyone has comments to make about this 
version :)

On 6/24/19 10:55 AM, Raphael Gault wrote:
> As of now, objtool only supports the x86_64 architecture but the
> groundwork has already been done in order to add support for other
> architectures without too much effort.
> 
> This series of patches adds support for the arm64 architecture
> based on the Armv8.5 Architecture Reference Manual.
> 
> Objtool will be a valuable tool to progress and provide more guarentees
> on live patching which is a work in progress for arm64.
> 
> Once we have the base of objtool working the next steps will be to
> port Peter Z's uaccess validation for arm64.
> 
> Changes since previous version:
> * Rebased on tip/master: Note that I had to re-expose the
> `struct alternative` using check.h because it is now used outside of
> check.c.
> * Reorder commits for a more coherent progression
> * Introduce GCC plugin to help detect switch-tables for arm64
> This plugins could be improve: It plugs in after the RTL control flow
> graph passes but only extract information about the switch tables. I
> originally intended for it to introduce new code_label/note within the
> RTL representation in order to reference them and thus get the address
> of the branch instruction. However I did not manage to do it properly
> using gen_rtx_CODE_LABEL/emit_label_before/after. If anyone has some
> experience with RTL plugins I am all ears for advices.
> 
> Raphael Gault (18):
>    objtool: Add abstraction for computation of symbols offsets
>    objtool: orc: Refactor ORC API for other architectures to implement.
>    objtool: Move registers and control flow to arch-dependent code
>    objtool: arm64: Add required implementation for supporting the aarch64
>      architecture in objtool.
>    objtool: special: Adapt special section handling
>    objtool: arm64: Adapt the stack frame checks for arm architecture
>    objtool: Introduce INSN_UNKNOWN type
>    objtool: Refactor switch-tables code to support other architectures
>    gcc-plugins: objtool: Add plugin to detect switch table on arm64
>    objtool: arm64: Implement functions to add switch tables alternatives
>    arm64: alternative: Mark .altinstr_replacement as containing
>      executable instructions
>    arm64: assembler: Add macro to annotate asm function having non
>      standard stack-frame.
>    arm64: sleep: Prevent stack frame warnings from objtool
>    arm64: kvm: Annotate non-standard stack frame functions
>    arm64: kernel: Add exception on kuser32 to prevent stack analysis
>    arm64: crypto: Add exceptions for crypto object to prevent stack
>      analysis
>    arm64: kernel: Annotate non-standard stack frame functions
>    objtool: arm64: Enable stack validation for arm64
> 
>   arch/arm64/Kconfig                            |    1 +
>   arch/arm64/crypto/Makefile                    |    3 +
>   arch/arm64/include/asm/alternative.h          |    2 +-
>   arch/arm64/include/asm/assembler.h            |   13 +
>   arch/arm64/kernel/Makefile                    |    3 +
>   arch/arm64/kernel/hyp-stub.S                  |    2 +
>   arch/arm64/kernel/sleep.S                     |    4 +
>   arch/arm64/kvm/hyp-init.S                     |    2 +
>   arch/arm64/kvm/hyp/entry.S                    |    2 +
>   scripts/Makefile.gcc-plugins                  |    2 +
>   scripts/gcc-plugins/Kconfig                   |    9 +
>   .../arm64_switch_table_detection_plugin.c     |   58 +
>   tools/objtool/Build                           |    2 -
>   tools/objtool/arch.h                          |   21 +-
>   tools/objtool/arch/arm64/Build                |    8 +
>   tools/objtool/arch/arm64/arch_special.c       |  173 +
>   tools/objtool/arch/arm64/bit_operations.c     |   67 +
>   tools/objtool/arch/arm64/decode.c             | 2809 +++++++++++++++++
>   .../objtool/arch/arm64/include/arch_special.h |   52 +
>   .../arch/arm64/include/asm/orc_types.h        |   96 +
>   .../arch/arm64/include/bit_operations.h       |   24 +
>   tools/objtool/arch/arm64/include/cfi.h        |   74 +
>   .../objtool/arch/arm64/include/insn_decode.h  |  210 ++
>   tools/objtool/arch/arm64/orc_dump.c           |   26 +
>   tools/objtool/arch/arm64/orc_gen.c            |   40 +
>   tools/objtool/arch/x86/Build                  |    3 +
>   tools/objtool/arch/x86/arch_special.c         |  101 +
>   tools/objtool/arch/x86/decode.c               |   16 +
>   tools/objtool/arch/x86/include/arch_special.h |   45 +
>   tools/objtool/{ => arch/x86/include}/cfi.h    |    0
>   tools/objtool/{ => arch/x86}/orc_dump.c       |    4 +-
>   tools/objtool/{ => arch/x86}/orc_gen.c        |  104 +-
>   tools/objtool/check.c                         |  309 +-
>   tools/objtool/check.h                         |   10 +
>   tools/objtool/elf.c                           |    3 +-
>   tools/objtool/orc.h                           |    4 +-
>   tools/objtool/special.c                       |   28 +-
>   tools/objtool/special.h                       |   13 +-
>   38 files changed, 4119 insertions(+), 224 deletions(-)
>   create mode 100644 scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
>   create mode 100644 tools/objtool/arch/arm64/Build
>   create mode 100644 tools/objtool/arch/arm64/arch_special.c
>   create mode 100644 tools/objtool/arch/arm64/bit_operations.c
>   create mode 100644 tools/objtool/arch/arm64/decode.c
>   create mode 100644 tools/objtool/arch/arm64/include/arch_special.h
>   create mode 100644 tools/objtool/arch/arm64/include/asm/orc_types.h
>   create mode 100644 tools/objtool/arch/arm64/include/bit_operations.h
>   create mode 100644 tools/objtool/arch/arm64/include/cfi.h
>   create mode 100644 tools/objtool/arch/arm64/include/insn_decode.h
>   create mode 100644 tools/objtool/arch/arm64/orc_dump.c
>   create mode 100644 tools/objtool/arch/arm64/orc_gen.c
>   create mode 100644 tools/objtool/arch/x86/arch_special.c
>   create mode 100644 tools/objtool/arch/x86/include/arch_special.h
>   rename tools/objtool/{ => arch/x86/include}/cfi.h (100%)
>   rename tools/objtool/{ => arch/x86}/orc_dump.c (98%)
>   rename tools/objtool/{ => arch/x86}/orc_gen.c (66%)
> 

Cheers,

-- 
Raphael Gault
