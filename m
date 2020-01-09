Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF8CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561F620721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCDV3Lul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbgAIQDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:03:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52359 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728956AbgAIQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VW/zL9Nc1p9kCjmjcb93gdQ3b+gJDL7b5TfNv3zZBqw=;
        b=hCDV3Lul5dIwWZZ/VMahK7T2fkSpGtNlNtoT3OtgNbA5WOhdAwWf0Bg/cZ9RYFokkdP/4k
        S/1eeKRs1h0Fo8M2SDJrjnu+5duxtgYvi4Ziw8j85EBvf80gqYiu07BtHAKldSmesl+pXZ
        PUMS0e0L3InCXUTA/ZwqsSONzUFOyfk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-hk9t0HGnNJOQCLMEyhfbHg-1; Thu, 09 Jan 2020 11:03:12 -0500
X-MC-Unique: hk9t0HGnNJOQCLMEyhfbHg-1
Received: by mail-wr1-f70.google.com with SMTP id h30so3048034wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VW/zL9Nc1p9kCjmjcb93gdQ3b+gJDL7b5TfNv3zZBqw=;
        b=NHo7iIVrzfhh05c43m0CsyLAXg83GYJNK/gulysfnbQw29l+xVlHQEBm/8a5tXnCeb
         w6iirIo/xIhFBMKfZapOAzZOZcKkYG+A6e0hEsLxmC+yUWeiUMFS6BguJKNgfStaYAzm
         q/3Jjp3JR95GQIAfeix2xPfyxWzcns5bF6ZIbwCsQnBvXUJ6/hvVtRzu4aV2lrXmOE1S
         CiOzCfqGntPFzpQDZmvQ4x2Qo2UpnmPENK87CdbzV7UZjfrVCVymjM/GNTRgdA9gg2bz
         KHyljOqK/tv+yZiI5yKYzURa3bnbdpRIb/aPlhP1LB//AXaiPnKa7ULS02e4KReIcLJY
         LxBA==
X-Gm-Message-State: APjAAAWw3N9HWDNzqXI/7EtSbrn5Hmr6RYwCNVzm+cQ0+fNiToBFgYZc
        AtM6l6T3nAFA/D+6ByshJZUl/Wi19m26Pz42T/mK42/YoTukyoYTgVuEvfW+w+FqtPKA/rbDk7T
        1119dfdEZWTOKwEAhfzH7uwBu
X-Received: by 2002:a05:600c:2c50:: with SMTP id r16mr5523492wmg.74.1578585791227;
        Thu, 09 Jan 2020 08:03:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDo5C7S2iXtSifPg13KPtjAokYoAFL8RjToMQ4VVqowx6Q06TLwOttaZpaMHLM6vYc8zrTFQ==
X-Received: by 2002:a05:600c:2c50:: with SMTP id r16mr5523438wmg.74.1578585790789;
        Thu, 09 Jan 2020 08:03:10 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id z21sm3258969wml.5.2020.01.09.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:03:10 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 00/57] objtool: Add support for arm64
Date:   Thu,  9 Jan 2020 16:02:03 +0000
Message-Id: <20200109160300.26150-1-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series is the continuation of Raphael's work [1]. All the
patches can be retrieved from:
git clone -b arm64-objtool-v5 https://github.com/julien-thierry/linux.git

There still are some outstanding issues but the series is starting to
get pretty big so it is probably good to start having some discussions
on the current state of things.

It felt necessary to split some of the patches (especially the arm64
decoder). In order to give Raphael credit for his work I used the
"Suggested-by" tag. If this is not the right way to give credit or if
it should be present on more patches do let me know.

There still are some shortcomings. On defconfig here are the remaining
warnings:
* arch/arm64/crypto/crct10dif-ce-core.o: warning: objtool: crc_t10dif_pmull_p8()+0xf0: unsupported intra-function call
* arch/arm64/kernel/cpu_errata.o: warning: objtool: qcom_link_stack_sanitization()+0x4: unsupported intra-function call
Objtool currently does not support bl from a procedure to itself. This
is also an issue with retpolines. I need to investigate more to figure
out whether something can be done for this or if this file should not be
validated by objtool.

* arch/arm64/kernel/efi-entry.o: warning: objtool: entry()+0xb0: sibling call from callable instruction with modified stack frame
The EFI entry jumps to code mapped by EFI. Objtool cannot know statically where the code flow is going.

* arch/arm64/kernel/entry.o: warning: objtool: .entry.tramp.text+0x404: unsupported intra-function call
Need to figure out what is needed to handle aarch64 trampolines. x86
explicitly annotates theirs with ANNOTATE_NOSPEC_ALTERNATIVE and
patching them as alternatives.

* arch/arm64/kernel/head.o: warning: objtool: .head.text+0x58: can't find jump dest instruction at .head.text+0x80884
This is actually a constant that turns out to be a valid branch opcode.
A possible solution could be to introduce a marco that explicitly
annotates constants placed in code sections.

* arch/arm64/kernel/hibernate-asm.o: warning: objtool: el1_sync()+0x4: unsupported instruction in callable function
Symbols el<x>_* shouldn't be considered as callable functions. Should we
use SYM_CODE_END instead of PROC_END?

* arch/arm64/kvm/hyp/hyp-entry.o: warning: objtool: .hyp.text: empty alternative at end of section
This is due to the arm64 alternative_cb. Currently, the feature
corresponding to the alternative_cb is defined as the current number of
features supported by the kernel, meaning the identifier is not fixed
accross kernel versions. This makes it a bit hard to detect these
alternative_cb for external tools.

Would it be acceptable to set a fixed identifier for alternative_cb?
(probably 0xFF so it is always higher than the number of real features)

* drivers/ata/libata-scsi.o: warning: objtool: ata_sas_queuecmd() falls through to next function ata_scsi_scan_host()
This is due to a limitation in the switch table metadata interpretation.
The compiler might create a table of unsigned offsets and then
compute the final offset as follows:

	ldrb    offset_reg, [<offset_table>, <offset_idx>, uxtw]
	adr     base_reg, <base_addr>
	add     res_addr, base_reg, offset_reg, sxtb #2

Effectively using the loaded offset as a signed value.
I don't have a simple way to solve this at the moment, I'd like to
avoid decoding the instructions to check which ones might sign extend
the loaded offset.

* kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x44: sibling call from callable instruction with modified stack frame
This is because the function uses a C jump table which differ from
basic jump tables. Also, the code generated for C jump tables on arm64
does not follow the same form as the one for x86. So the existing x86 objtool
code handling C jump tables can't be used.

I'll focus on understanding the arm64 pattern so objtool can handle them.


In the mean time, any feedback on the current state is appreciated.

* Patches 1 to 18 adapts the current objtool code to make it easier to
  support new architectures.
* Patches 19 to 45 add the support for arm64 architecture to objtool.
* Patches 46 to 57 fix warnings reported by objtool on the existing
  arm64 code.

Changes since RFCv4[1]:
* Rebase on v5.5-rc5
* Misc cleanup/bug fixes
* Fix some new objtool warnings reported on arm64 objects
* Make ORC subcommand optional since arm64 does not currently support it
* Support branch instructions in alternative sections when they jump
  within the same set of alternative instructions
* Replace the "extra" stack_op with a list of stack_op
* Split the decoder into multiple patches to ease review
* Mark constants generated by load literal instructions as bytes that
  should not be reached by execution flow
* Rework the switch table handling

[1] https://lkml.org/lkml/2019/8/16/400

Thanks,

Julien

-->

Julien Thierry (43):
  objtool: check: Remove redundant checks on operand type
  objtool: check: Clean instruction state before each function
    validation
  objtool: check: Use arch specific values in restore_reg()
  objtool: check: Ignore empty alternative groups
  objtool: Give ORC functions consistent name
  objtool: Make ORC support optional
  objtool: Split generic and arch specific CFI definitions
  objtool: Abstract alternative special case handling
  objtool: check: Allow jumps from an alternative group to itself
  objtool: Do not look for STT_NOTYPE symbols
  objtool: Support addition to set frame pointer
  objtool: Support restoring BP from the stack without POP
  objtool: Make stack validation more generic
  objtool: Support multiple stack_op per instruction
  objtool: arm64: Decode unknown instructions
  objtool: arm64: Decode simple data processing instructions
  objtool: arm64: Decode add/sub immediate instructions
  objtool: arm64: Decode logical data processing instructions
  objtool: arm64: Decode system instructions not affecting the flow
  objtool: arm64: Decode calls to higher EL
  objtool: arm64: Decode brk instruction
  objtool: arm64: Decode instruction triggering context switch
  objtool: arm64: Decode branch instructions with PC relative immediates
  objtool: arm64: Decode branch to register instruction
  objtool: arm64: Decode basic load/stores
  objtool: arm64: Decode load/store with register offset
  objtool: arm64: Decode load/store register pair instructions
  objtool: arm64: Decode FP/SIMD load/store instructions
  objtool: arm64: Decode load/store exclusive
  objtool: arm64: Decode atomic load/store
  objtool: arm64: Decode pointer auth load instructions
  objtool: arm64: Decode load acquire/store release
  objtool: arm64: Decode load/store with memory tag
  objtool: arm64: Decode load literal
  objtool: arm64: Decode register data processing instructions
  objtool: arm64: Decode FP/SIMD data processing instructions
  objtool: arm64: Decode SVE instructions
  objtool: arm64: Implement functions to add switch tables alternatives
  arm64: Generate no-ops to pad executable section
  arm64: Move constant to rodata
  arm64: Mark sigreturn32.o as containing non standard code
  arm64: entry: Avoid empty alternatives entries
  arm64: crypto: Remove redundant branch

Raphael Gault (14):
  objtool: Add abstraction for computation of symbols offsets
  objtool: orc: Refactor ORC API for other architectures to implement.
  objtool: Move registers and control flow to arch-dependent code
  objtool: Refactor switch-tables code to support other architectures
  objtool: arm64: Add required implementation for supporting the aarch64
    architecture in objtool.
  gcc-plugins: objtool: Add plugin to detect switch table on arm64
  objtool: arm64: Enable stack validation for arm64
  arm64: alternative: Mark .altinstr_replacement as containing
    executable instructions
  arm64: assembler: Add macro to annotate asm function having non
    standard stack-frame.
  arm64: sleep: Prevent stack frame warnings from objtool
  arm64: kvm: Annotate non-standard stack frame functions
  arm64: kernel: Add exception on kuser32 to prevent stack analysis
  arm64: crypto: Add exceptions for crypto object to prevent stack
    analysis
  arm64: kernel: Annotate non-standard stack frame functions

 arch/arm64/Kconfig                            |    2 +
 arch/arm64/crypto/Makefile                    |    3 +
 arch/arm64/crypto/sha1-ce-core.S              |    3 +-
 arch/arm64/crypto/sha2-ce-core.S              |    3 +-
 arch/arm64/crypto/sha3-ce-core.S              |    3 +-
 arch/arm64/crypto/sha512-ce-core.S            |    3 +-
 arch/arm64/include/asm/alternative.h          |    2 +-
 arch/arm64/kernel/Makefile                    |    4 +
 arch/arm64/kernel/entry.S                     |    4 +-
 arch/arm64/kernel/hyp-stub.S                  |    3 +
 arch/arm64/kernel/relocate_kernel.S           |    5 +
 arch/arm64/kernel/sleep.S                     |    5 +
 arch/arm64/kvm/hyp-init.S                     |    3 +
 arch/arm64/kvm/hyp/entry.S                    |    3 +
 include/linux/frame.h                         |   19 +-
 scripts/Makefile.gcc-plugins                  |    2 +
 scripts/gcc-plugins/Kconfig                   |    4 +
 .../arm64_switch_table_detection_plugin.c     |   94 +
 tools/objtool/Build                           |    4 +-
 tools/objtool/Makefile                        |   13 +-
 tools/objtool/arch.h                          |   14 +-
 tools/objtool/arch/arm64/Build                |    5 +
 tools/objtool/arch/arm64/arch_special.c       |  262 ++
 tools/objtool/arch/arm64/bit_operations.c     |   69 +
 tools/objtool/arch/arm64/decode.c             | 2866 +++++++++++++++++
 .../objtool/arch/arm64/include/arch_special.h |   23 +
 .../arch/arm64/include/bit_operations.h       |   31 +
 tools/objtool/arch/arm64/include/cfi_regs.h   |   44 +
 .../objtool/arch/arm64/include/insn_decode.h  |  206 ++
 tools/objtool/arch/x86/Build                  |    3 +
 tools/objtool/arch/x86/arch_special.c         |  182 ++
 tools/objtool/arch/x86/decode.c               |   29 +-
 tools/objtool/arch/x86/include/arch_special.h |   28 +
 tools/objtool/arch/x86/include/cfi_regs.h     |   25 +
 tools/objtool/{ => arch/x86}/orc_dump.c       |    4 +-
 tools/objtool/{ => arch/x86}/orc_gen.c        |  114 +-
 tools/objtool/cfi.h                           |   21 +-
 tools/objtool/check.c                         |  461 +--
 tools/objtool/check.h                         |   13 +-
 tools/objtool/elf.c                           |    3 +-
 tools/objtool/objtool.c                       |    2 +
 tools/objtool/orc.h                           |   38 +-
 tools/objtool/special.c                       |   44 +-
 tools/objtool/special.h                       |   13 +
 44 files changed, 4282 insertions(+), 400 deletions(-)
 create mode 100644 scripts/gcc-plugins/arm64_switch_table_detection_plugin.c
 create mode 100644 tools/objtool/arch/arm64/Build
 create mode 100644 tools/objtool/arch/arm64/arch_special.c
 create mode 100644 tools/objtool/arch/arm64/bit_operations.c
 create mode 100644 tools/objtool/arch/arm64/decode.c
 create mode 100644 tools/objtool/arch/arm64/include/arch_special.h
 create mode 100644 tools/objtool/arch/arm64/include/bit_operations.h
 create mode 100644 tools/objtool/arch/arm64/include/cfi_regs.h
 create mode 100644 tools/objtool/arch/arm64/include/insn_decode.h
 create mode 100644 tools/objtool/arch/x86/arch_special.c
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h
 create mode 100644 tools/objtool/arch/x86/include/cfi_regs.h
 rename tools/objtool/{ => arch/x86}/orc_dump.c (98%)
 rename tools/objtool/{ => arch/x86}/orc_gen.c (62%)

--
2.21.0

