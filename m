Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF88C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B839C2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfDINx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:53:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38452 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfDINx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:53:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60954A78;
        Tue,  9 Apr 2019 06:53:25 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D91D43F68F;
        Tue,  9 Apr 2019 06:53:23 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH 0/6] objtool: Add support for Arm64 
Date:   Tue,  9 Apr 2019 14:52:37 +0100
Message-Id: <20190409135243.12424-1-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As of now, objtool only supports the x86_64 architecture but the
groundwork has already been done in order to add support for other
architecture without too much effort.

This series of patches adds support for the arm64 architecture
based on the Armv8.5 Architecture Reference Manual.

* Patch 1 adapts the existing code to be able to add support for other
  architecture.
* Patch 2 provide implementation of the required function for the arm64
  architecture.
* Patch 3 adapts the checking of the stack state for the arm64
  architecture.
* Patch 4 & 5 fix some warning objtool raised in some particular
  functions of ~/arch/arm64/kernel/sleep.S. Patch 4 add a macro to
  signal that some function should be ignored by objtool. 
* Patch 6 enables stack validation for arm64.

Theses patches should provide support for the main cases and behaviour.
However a few corner cases are not yet handled by objtool:

* In the `~/arch/arm64/crypto/` directory, I noticed that some plain
  data are sometimes stored in the `.text` section causing objtool to mistake
  this for instructions and trying (and failing) to interprete them.  If someone
  could explain to me why we store data directly in the .text section I would
  appreciate it.

* In the support for arm32 architecture such as in `~/arch/arm64/kernel/kuser32.S`
  some A32 instructions are used but such instructions are not understood by
  objtool causing a warning.

I also have a few unclear points I would like to bring to your
attention:

* For x86_64, when looking for a symbol relocation with explicit
  addend, objtool systematically adds a +4 offset to the addend.
  I don't understand why even if I have a feeling it is related
  to the type of relacation.

* I currently don't have a clear understanding about how switch-tables
  are generated on arm64 and how to retrieve them (based on relocations).

Please provide me with any feedback and comments as well on the content
than the style of these patches.

Thanks,

Raphael

->

Raphael Gault (6):
  objtool: Refactor code to make it more suitable for multiple
    architecture support
  objtool: arm64: Add required implementation for supporting the aarch64
    architecture in objtool.
  objtool: arm64: Adapt the stack frame checks and the section analysis
    for the arm architecture
  arm64: assembler: Add macro to annotate asm function having non
    standard stack-frame.
  arm64: sleep: Add stack frame setup for __cpu_supsend_enter
  objtool: arm64: Enable stack validation for arm64

 arch/arm64/Kconfig                            |    1 +
 arch/arm64/include/asm/assembler.h            |   18 +
 arch/arm64/kernel/sleep.S                     |    4 +
 tools/objtool/Build                           |    1 -
 tools/objtool/arch.h                          |   11 +
 tools/objtool/arch/arm64/Build                |    6 +
 tools/objtool/arch/arm64/bit_operations.c     |   65 +
 tools/objtool/arch/arm64/decode.c             | 2870 +++++++++++++++++
 .../objtool/arch/arm64/include/arch_special.h |   44 +
 .../arch/arm64/include/asm/orc_types.h        |  109 +
 .../arch/arm64/include/bit_operations.h       |   22 +
 tools/objtool/arch/arm64/include/cfi.h        |   76 +
 .../objtool/arch/arm64/include/insn_decode.h  |  219 ++
 tools/objtool/arch/arm64/orc_gen.c            |   40 +
 tools/objtool/arch/x86/Build                  |    1 +
 tools/objtool/arch/x86/decode.c               |  111 +
 tools/objtool/arch/x86/include/arch_special.h |   35 +
 tools/objtool/{ => arch/x86/include}/cfi.h    |    0
 tools/objtool/{ => arch/x86}/orc_gen.c        |   10 +-
 tools/objtool/check.c                         |  209 +-
 tools/objtool/check.h                         |    1 +
 tools/objtool/elf.c                           |    3 +-
 tools/objtool/orc.h                           |    4 +-
 tools/objtool/special.c                       |   18 +-
 24 files changed, 3740 insertions(+), 138 deletions(-)
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/bit_operations.c
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch_special.h
 create mode 100644 tools/objtool/arch/arm64/include/asm/orc_types.h
 create mode 100644 tools/objtool/arch/arm64/include/bit_operations.h
 create mode 100644 tools/objtool/arch/arm64/include/cfi.h
 create mode 100644 tools/objtool/arch/arm64/include/insn_decode.h
 create mode 100644 tools/objtool/arch/arm64/orc_gen.c
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h
 rename tools/objtool/{ => arch/x86/include}/cfi.h (100%)
 rename tools/objtool/{ => arch/x86}/orc_gen.c (96%)

-- 
2.17.1

