Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF75C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04565206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="B0liChI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389038AbfIPPUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:20:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36365 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388609AbfIPPUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:20:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id t3so251865wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=awtTXhQYInDaRNLRQOmqRN3PH/3AaVOJdo9EGYwStAM=;
        b=B0liChI3Ql+DmGCvZBfzmpDJj+Qihyzh98bjutCItonoa5oqLJw23XygfkfTsCx7JL
         sp89s6HevKYMWlSHSNemK+JIyDUP/nIcv31iVttcpHvyyrh+95UMwE2gXaK3mJKKoOlz
         otKxb0u/IkaDekX548JJe7ifokxY//baXBn7VBb6s8eFuKsY9BTfqH84D1NU6nJrK+r0
         4IkjTJU0N0mmtkXRnE5IvC42fI5sqhFNq5J0J8l7VjQFsJi+Nz/8M7RpziWZmclvhWWS
         zRz6FWnSbUgdketzRUIk9Bsw4P4O8aAJdqXVJ17AUVtuwmc+QmdeiSioNYIBXfvyC/HS
         PaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=awtTXhQYInDaRNLRQOmqRN3PH/3AaVOJdo9EGYwStAM=;
        b=oJJimULmTq82NI0Mhkyi6h9/79qWjcTHYLvtMTleMEGT4sKPvLTaMbNCNjPMu/VUzr
         IzbNWQpqOl6u9ghxtimt2qnU9nSXEbRX+oLCggDrvp5ppVkOevJX/14/VeUY/1SN8BUi
         VigtsDwKhmJ7s1D2lo/1ed+IdsDsodA5rAL3WSJ4Q9+trSTrq/oSsFA+1u3hdK2mbVSX
         XOqcGZzSvEqjKoam4Q/A/Z3aysMpW38UbNsJqVthwwx4sIksC2/gBo4OutAsbxLnYCsM
         fbIgPZNN5s8Kvj5nxPz2zlJvIDxmewLvUszSLHH6A7gmvxC6J6rxRWWKZLYU5yUlYnsw
         fcXg==
X-Gm-Message-State: APjAAAW7leoZ+rT/gp2iFdp2XFEpZjaa9eB9N68N8dPWS2rTTrYNUNGL
        AuWDkDZy8BU6kXOHxLrFWWSXOixRVOs=
X-Google-Smtp-Source: APXvYqzv55te+vVQ6/L27I0bUkIIAv1ZlIHl8FtByVqPk+kpTCmGndZf6Ga2ciCjww9DelwyTmxImA==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr50330wmj.127.1568647234465;
        Mon, 16 Sep 2019 08:20:34 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id b194sm122836wmg.46.2019.09.16.08.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 08:20:33 -0700 (PDT)
Date:   Mon, 16 Sep 2019 08:20:33 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     torvalds@linux-foundation.org
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v5.4-rc1
Message-ID: <alpine.DEB.2.21.9999.1909160819190.11980@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit a256f2e329df0773022d28df2c3d206b9aaf1e61:

  RISC-V: Fix FIXMAP area corruption on RV32 systems (2019-08-28 15:30:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.4-rc1

for you to fetch changes up to 9ce06497c2722a0f9109e4cc3ce35b7a69617886:

  irqchip/sifive-plic: set max threshold for ignored handlers (2019-09-05 01:59:55 -0700)

----------------------------------------------------------------
RISC-V updates for v5.4-rc1

Add the following new features:

- Generic CPU topology description support for DT-based platforms,
  including ARM64, ARM and RISC-V.

- Sparsemem support

- Perf callchain support

- SiFive PLIC irqchip modifications, in preparation for M-mode Linux

and clean up the code base:

- Clean up chip-specific register (CSR) manipulation code, IPIs, TLB
  flushing, and the RISC-V CPU-local timer code

- Kbuild cleanup from one of the Kbuild maintainers

----------------------------------------------------------------
Atish Patra (4):
      dt-binding: cpu-topology: Move cpu-map to a common binding.
      cpu-topology: Move cpu topology code to common code.
      arm: Use common cpu_topology structure and functions.
      RISC-V: Parse cpu topology during boot.

Bin Meng (1):
      riscv: Using CSR numbers to access CSRs

Christoph Hellwig (7):
      riscv: refactor the IPI code
      riscv: cleanup send_ipi_mask
      riscv: optimize send_ipi_single
      riscv: cleanup riscv_cpuid_to_hartid_mask
      riscv: don't use the rdtime(h) pseudo-instructions
      riscv: move the TLB flush logic out of line
      irqchip/sifive-plic: set max threshold for ignored handlers

Logan Gunthorpe (1):
      RISC-V: Implement sparsemem

Mao Han (3):
      riscv: Add perf callchain support
      riscv: Add support for perf registers sampling
      riscv: Add support for libdw

Masahiro Yamada (1):
      riscv: add arch/riscv/Kbuild

Paul Walmsley (1):
      Merge tag 'common/for-v5.4-rc1/cpu-topology' into for-v5.4-rc1-branch

Sudeep Holla (3):
      Documentation: DT: arm: add support for sockets defining package boundaries
      base: arch_topology: update Kconfig help description
      MAINTAINERS: Add an entry for generic architecture topology

 .../{arm/topology.txt => cpu/cpu-topology.txt}     | 256 +++++++++++------
 MAINTAINERS                                        |   7 +
 arch/arm/include/asm/topology.h                    |  20 --
 arch/arm/kernel/topology.c                         |  60 +---
 arch/arm64/include/asm/topology.h                  |  23 --
 arch/arm64/kernel/topology.c                       | 303 +--------------------
 arch/riscv/Kbuild                                  |   3 +
 arch/riscv/Kconfig                                 |  24 ++
 arch/riscv/Makefile                                |   5 +-
 arch/riscv/include/asm/page.h                      |   2 +
 arch/riscv/include/asm/pgtable.h                   |  13 +
 arch/riscv/include/asm/smp.h                       |   6 -
 arch/riscv/include/asm/sparsemem.h                 |  11 +
 arch/riscv/include/asm/timex.h                     |  44 ++-
 arch/riscv/include/asm/tlbflush.h                  |  38 +--
 arch/riscv/include/uapi/asm/perf_regs.h            |  42 +++
 arch/riscv/kernel/Makefile                         |   4 +-
 arch/riscv/kernel/entry.S                          |   6 +-
 arch/riscv/kernel/fpu.S                            |   8 +-
 arch/riscv/kernel/head.S                           |   2 +-
 arch/riscv/kernel/perf_callchain.c                 |  94 +++++++
 arch/riscv/kernel/perf_regs.c                      |  44 +++
 arch/riscv/kernel/smp.c                            |  60 ++--
 arch/riscv/kernel/smpboot.c                        |   3 +
 arch/riscv/kernel/stacktrace.c                     |   4 +-
 arch/riscv/lib/uaccess.S                           |  12 +-
 arch/riscv/mm/Makefile                             |   3 +
 arch/riscv/mm/cacheflush.c                         |   1 -
 arch/riscv/mm/context.c                            |   7 +-
 arch/riscv/mm/init.c                               |  12 +-
 arch/riscv/mm/tlbflush.c                           |  35 +++
 drivers/base/Kconfig                               |   2 +-
 drivers/base/arch_topology.c                       | 298 ++++++++++++++++++++
 drivers/clocksource/timer-riscv.c                  |  17 +-
 drivers/irqchip/irq-sifive-plic.c                  |  12 +-
 include/linux/arch_topology.h                      |  26 ++
 include/linux/topology.h                           |   1 +
 tools/arch/riscv/include/uapi/asm/perf_regs.h      |  42 +++
 tools/perf/Makefile.config                         |   6 +-
 tools/perf/arch/riscv/Build                        |   1 +
 tools/perf/arch/riscv/Makefile                     |   4 +
 tools/perf/arch/riscv/include/perf_regs.h          |  96 +++++++
 tools/perf/arch/riscv/util/Build                   |   2 +
 tools/perf/arch/riscv/util/dwarf-regs.c            |  72 +++++
 tools/perf/arch/riscv/util/unwind-libdw.c          |  57 ++++
 45 files changed, 1176 insertions(+), 612 deletions(-)
 rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)
 create mode 100644 arch/riscv/Kbuild
 create mode 100644 arch/riscv/include/asm/sparsemem.h
 create mode 100644 arch/riscv/include/uapi/asm/perf_regs.h
 create mode 100644 arch/riscv/kernel/perf_callchain.c
 create mode 100644 arch/riscv/kernel/perf_regs.c
 create mode 100644 arch/riscv/mm/tlbflush.c
 create mode 100644 tools/arch/riscv/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/riscv/Build
 create mode 100644 tools/perf/arch/riscv/Makefile
 create mode 100644 tools/perf/arch/riscv/include/perf_regs.h
 create mode 100644 tools/perf/arch/riscv/util/Build
 create mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/riscv/util/unwind-libdw.c
