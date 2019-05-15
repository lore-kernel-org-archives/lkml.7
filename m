Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D6EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F612084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfEORjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:39:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44525 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEORjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:39:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so199640pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 10:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=OyqkAInMJ4afJyiF2nb2YB2wdpcRhAB6c/71WOYyPas=;
        b=h2TiBIUd9T8geImxIN/sm5NZfWgzAsl4xr9UBeUV1OMK5YHWPb5SGj1tTIRSxv0fp0
         6xACpgnG2TaC07XJnwh8SBvDJOfupVXaVOWwWe+2IqVEwcxG86VP2YKNji1p3MqsovpN
         0095UdkuSRAuCeO0yXNYHAs56Xb1C/nA+IZEU/E9hmfegIWDoLnAiE76bfafzGKfz4QM
         jMDeA4tXs5Nun1RQs/+PySPnp/UQ8+blyFXGPaVFpXJcCj5eDy3uDgbtyxJR7EMsN3U+
         YOfZ7XOlXH1PGchds37VeMLIkUxJBCk5L4OyOLVoKOPp4PWA0TAylndUUPpdJEvEWM6R
         0mPQ==
X-Gm-Message-State: APjAAAVoVTSRRHE2fZpgeoFK8l1iTs7gP/bii1Z8EpzGoQt8XWMozeL8
        4PvPLR4sKWoSLSZPPa5wK0M7ZEaA+uA=
X-Google-Smtp-Source: APXvYqxw3U/LSU65RQOQnp/SYsPweUz6pC7uNamYkvPZJkQpsNN8ZvCjzx14hDJGNFqN+j/m23GEhg==
X-Received: by 2002:a17:902:bd95:: with SMTP id q21mr8947972pls.159.1557941990986;
        Wed, 15 May 2019 10:39:50 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m123sm5011080pfm.39.2019.05.15.10.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 10:39:50 -0700 (PDT)
Date:   Wed, 15 May 2019 10:39:50 -0700 (PDT)
X-Google-Original-Date: Wed, 15 May 2019 10:39:46 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.2 Merge Window, Part 1
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-d6bbd5f4-7409-4d3e-94a0-7ff0c6a71c9e@palmer-si-x1e>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.2-mw0

for you to fetch changes up to e23fc917f04ffac8c156fdb4ee8b56f3867fa50b:

  RISC-V: Avoid using invalid intermediate translations (2019-05-08 15:06:18 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.2 Merge Window, Part 1

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

I've only tested this on QEMU again, as I didn't have time to get things
running on the Unleashed.  The latest master from this morning merges in
cleanly and passes the tests as well.

----------------------------------------------------------------
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

 arch/riscv/Kconfig                   |   6 +-
 arch/riscv/Makefile                  |   5 +-
 arch/riscv/include/asm/Kbuild        |   1 +
 arch/riscv/include/asm/bug.h         |  35 ++++++----
 arch/riscv/include/asm/cacheflush.h  |   2 +-
 arch/riscv/include/asm/csr.h         | 123 ++++++++++++++++++++++-------------
 arch/riscv/include/asm/elf.h         |   6 --
 arch/riscv/include/asm/futex.h       |  13 ----
 arch/riscv/include/asm/irqflags.h    |  10 +--
 arch/riscv/include/asm/mmu_context.h |  59 +----------------
 arch/riscv/include/asm/ptrace.h      |  21 ++----
 arch/riscv/include/asm/sbi.h         |  19 ++++--
 arch/riscv/include/asm/thread_info.h |   4 +-
 arch/riscv/include/asm/uaccess.h     |  28 +++-----
 arch/riscv/kernel/asm-offsets.c      |   3 -
 arch/riscv/kernel/cpu.c              |   3 +-
 arch/riscv/kernel/entry.S            |  22 +++----
 arch/riscv/kernel/head.S             |  33 ++++++----
 arch/riscv/kernel/irq.c              |  19 ++----
 arch/riscv/kernel/perf_event.c       |   4 +-
 arch/riscv/kernel/reset.c            |  15 +++--
 arch/riscv/kernel/setup.c            |   6 +-
 arch/riscv/kernel/signal.c           |   6 ++
 arch/riscv/kernel/smp.c              |  61 +++--------------
 arch/riscv/kernel/smpboot.           |   0
 arch/riscv/kernel/smpboot.c          |  22 ++++++-
 arch/riscv/kernel/stacktrace.c       |  14 ++--
 arch/riscv/kernel/traps.c            |  30 ++++++---
 arch/riscv/kernel/vdso/Makefile      |   2 +-
 arch/riscv/mm/Makefile               |   1 +
 arch/riscv/mm/cacheflush.c           |  61 +++++++++++++++++
 arch/riscv/mm/context.c              |  69 ++++++++++++++++++++
 arch/riscv/mm/fault.c                |   6 +-
 drivers/tty/hvc/hvc_riscv_sbi.c      |   1 -
 34 files changed, 390 insertions(+), 320 deletions(-)
 create mode 100644 arch/riscv/kernel/smpboot.
 create mode 100644 arch/riscv/mm/context.c
