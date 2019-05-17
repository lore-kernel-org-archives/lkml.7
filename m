Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D41AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16342082E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfEQWyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 18:54:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38467 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfEQWyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 18:54:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so3955851pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 15:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=Ahm5be5NUrtm3hWZIve+b7Dd18MEVe3dLCxTom5Yo+E=;
        b=TNn2u/JOBt5dDQL04Nhf0CFKVv6CcmvbRhPMd0g7ONHndYR/rUWnG2d4nlSfqTTnby
         E+2IQmH+0bSAJ+Zi/ECZqulstqHNkzTiTtgmY3DuXcE5otvZAprK1koX8UrZ7yOrIfsN
         E9UbgjkuHj8SyknGn+CT2S3cTwrVMqL2Q8XyopfKKAUMpd8aDadLFwMRGck2HkDQ5sfx
         bJ1HmUqz5bI3jQd4Rm2aq3xWSMLv5aBZtF+ao+jZWBLK27hTdXJ6uqGfrIKIk+e+nRP3
         EZ1CNp5czk1nbBhN23bsR4QJOYOCqb3r7E07imFC0I54gWCbVstz7zkkIMsHVf8maT7D
         T6HQ==
X-Gm-Message-State: APjAAAWlVK+nyqsPGHn8wvAAV6EPgf1Xo3ST9wm3yhxr9mckeqEcNO9U
        6r10LmJQYzMyWtffzxZaGwgttiCAaCs=
X-Google-Smtp-Source: APXvYqyGA5aGu7mD7Gr+WhJw0g/JgPlJbonC43rGpNdAHAc/eMs5YcBYA2c6YaxOMxMuVTYwMlbWfA==
X-Received: by 2002:a63:7989:: with SMTP id u131mr51047071pgc.180.1558133674240;
        Fri, 17 May 2019 15:54:34 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b16sm17757544pfd.12.2019.05.17.15.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 15:54:33 -0700 (PDT)
Date:   Fri, 17 May 2019 15:54:33 -0700 (PDT)
X-Google-Original-Date: Fri, 17 May 2019 15:53:24 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.2 Merge Window, Part 1 v3
CC:      linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-2cfcab49-74d1-4656-9913-36853a5be29d@palmer-si-x1e>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.2-mw2

for you to fetch changes up to 8fef9900d43feb9d5017c72840966733085e3e82:

  riscv: fix locking violation in page fault handler (2019-05-16 20:42:13 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.2 Merge Window, Part 1 v3

This patch set contains an assortment of RISC-V related patches that I'd
like to target for the 5.2 merge window.  Most of the patches are
cleanups, but there are a handful of user-visible changes:

* The nosmp and nr_cpus command-line arguments are now supported, which
  work like normal.
* The SBI console no longer installs itself as a preferred console, we
  rely on standard mechanisms (/chosen, command-line, hueristics)
  instead.
* sfence_remove_sfence_vma{,_asid} now pass their arguments along to the
  SBI call.
* Modules now support BUG().
* A missing sfence.vma during boot has been added.  This bug only
  manifests during boot.
* The arch/riscv support for SiFive's L2 cache controller has been
  merged, which should un-block the EDAC framework work.

I've only tested this on QEMU again, as I didn't have time to get things
running on the Unleashed.  The latest master from this morning merges in
cleanly and passes the tests as well.

This patch set rebased my "5.2 MW, Part 1" patch set which includes an
erronous empty file.  It's also a rebase of my "5.2 MW, Part 2" patch
set, in which I managed to create another file while attempting to
remove the empty file.

Sorry for all the noise!

----------------------------------------------------------------
Andreas Schwab (1):
      riscv: fix locking violation in page fault handler

Anup Patel (4):
      RISC-V: Use tabs to align macro values in asm/csr.h
      RISC-V: Add interrupt related SCAUSE defines in asm/csr.h
      RISC-V: Access CSRs using CSR numbers
      tty: Don't force RISCV SBI console as preferred console

Atish Patra (4):
      RISC-V: Add RISC-V specific arch_match_cpu_phys_id
      RISC-V: Implement nosmp commandline option.
      RISC-V: Support nr_cpus command line option.
      RISC-V: Fix minor checkpatch issues.

Christoph Hellwig (11):
      riscv: use asm-generic/extable.h
      riscv: turn mm_segment_t into a struct
      riscv: remove unreachable big endian code
      riscv: remove CONFIG_RISCV_ISA_A
      riscv: clear all pending interrupts when booting
      riscv: simplify the stack pointer setup in head.S
      riscv: cleanup the parse_dtb calling conventions
      riscv: remove unreachable !HAVE_FUNCTION_GRAPH_RET_ADDR_PTR code
      riscv: remove duplicate macros from ptrace.h
      riscv: print the unexpected interrupt cause
      riscv: call pm_power_off from machine_halt / machine_power_off

Gary Guo (3):
      riscv: move flush_icache_{all,mm} to cacheflush.c
      riscv: move switch_mm to its own file
      riscv: fix sbi_remote_sfence_vma{,_asid}.

Guo Ren (1):
      riscv/signal: Fixup additional syscall restarting

Nick Desaulniers (1):
      riscv: vdso: drop unnecessary cc-ldoption

Palmer Dabbelt (1):
      RISC-V: Avoid using invalid intermediate translations

Vincent Chen (3):
      riscv: support trap-based WARN()
      riscv: Add the support for c.ebreak check in is_valid_bugaddr()
      riscv: Support BUG() in kernel module

Yash Shah (2):
      RISC-V: Add DT documentation for SiFive L2 Cache Controller
      RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs

 .../devicetree/bindings/riscv/sifive-l2-cache.txt  |  51 ++++++
 arch/riscv/Kconfig                                 |   6 +-
 arch/riscv/Makefile                                |   5 +-
 arch/riscv/include/asm/Kbuild                      |   1 +
 arch/riscv/include/asm/bug.h                       |  35 +++--
 arch/riscv/include/asm/cacheflush.h                |   2 +-
 arch/riscv/include/asm/csr.h                       | 123 +++++++++------
 arch/riscv/include/asm/elf.h                       |   6 -
 arch/riscv/include/asm/futex.h                     |  13 --
 arch/riscv/include/asm/irqflags.h                  |  10 +-
 arch/riscv/include/asm/mmu_context.h               |  59 +------
 arch/riscv/include/asm/ptrace.h                    |  21 +--
 arch/riscv/include/asm/sbi.h                       |  19 ++-
 arch/riscv/include/asm/sifive_l2_cache.h           |  16 ++
 arch/riscv/include/asm/thread_info.h               |   4 +-
 arch/riscv/include/asm/uaccess.h                   |  28 ++--
 arch/riscv/kernel/asm-offsets.c                    |   3 -
 arch/riscv/kernel/cpu.c                            |   3 +-
 arch/riscv/kernel/entry.S                          |  22 +--
 arch/riscv/kernel/head.S                           |  33 ++--
 arch/riscv/kernel/irq.c                            |  19 +--
 arch/riscv/kernel/perf_event.c                     |   4 +-
 arch/riscv/kernel/reset.c                          |  15 +-
 arch/riscv/kernel/setup.c                          |   6 +-
 arch/riscv/kernel/signal.c                         |   6 +
 arch/riscv/kernel/smp.c                            |  61 ++-----
 arch/riscv/kernel/smpboot.c                        |  22 ++-
 arch/riscv/kernel/stacktrace.c                     |  14 +-
 arch/riscv/kernel/traps.c                          |  30 +++-
 arch/riscv/kernel/vdso/Makefile                    |   2 +-
 arch/riscv/mm/Makefile                             |   2 +
 arch/riscv/mm/cacheflush.c                         |  61 +++++++
 arch/riscv/mm/context.c                            |  69 ++++++++
 arch/riscv/mm/fault.c                              |   9 +-
 arch/riscv/mm/sifive_l2_cache.c                    | 175 +++++++++++++++++++++
 drivers/tty/hvc/hvc_riscv_sbi.c                    |   1 -
 36 files changed, 635 insertions(+), 321 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
 create mode 100644 arch/riscv/include/asm/sifive_l2_cache.h
 create mode 100644 arch/riscv/mm/context.c
 create mode 100644 arch/riscv/mm/sifive_l2_cache.c
