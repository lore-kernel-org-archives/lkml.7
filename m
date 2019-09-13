Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B101C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFF5208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 10:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568370023;
	bh=cem2fXwbh+2JntGJlXlvOyotW84Hf0kOtBJbQKdyhFQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=My/VIu3LQsX8FKoefA8iINJo8D9jCYuAfj7EaEhkOwZrZgZbegtlX1oyNLNHi8P8Z
	 q3jmvJwf0wa7Tazmz4Hvy6/ya/dbMV37V8gnxRNsKZ1mbiRtmBNZWyyoGKi+GJW46B
	 osdhMaesglc6yE7QSoM0effKD01RwGZHofnQN3kY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbfIMKUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 06:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIMKUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 06:20:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6FA120830;
        Fri, 13 Sep 2019 10:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568370019;
        bh=cem2fXwbh+2JntGJlXlvOyotW84Hf0kOtBJbQKdyhFQ=;
        h=Date:From:To:Cc:Subject:From;
        b=bu2f28VSS4VO5DmGM/vsMdMz+MZ+MEXYDJriq/FUNvL4P/Bv162J1t5pflgoNtQfP
         4gGxMDhq9q2zeZaUtrxrKnfOukbA7GIoWd7kITMZPUwkB5feNbZU1t9+S+UVJFcaHq
         Lvy9YhfSJk7o5M3SemezhBB1Rls8xnASFfa+We+U=
Date:   Fri, 13 Sep 2019 11:20:15 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 5.4
Message-ID: <20190913102014.vi4cwe6mifbsmrri@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the arm64 pull for 5.4 in anticipation of the merge window opening
next week. Although there isn't tonnes of code in terms of line count,
there are a fair few headline features which I've noted both in the tag
and also in the merge commits when I pulled everything together.

The part I'm most pleased with is that we had 35 contributors this time
around, which feels like a big jump from the usual small group of core
arm64 arch developers. Hopefully they all enjoyed it so much that they'll
continue to contribute, but we'll see.

The pull should be straightforward, but it's probably worth highlighting
the following:

  * We've pulled in a branch from the risc-v folks which moves our CPU
    topology code out to where it can be shared with others.

  * There are a few small changes outside of the files we usually touch
    (e.g. char/random.c) but these have all been reviewed/acked by the
    relevant maintainers.

  * There are a couple of very trivial conflicts in linux-next; one is in
    arch/Kconfig with the Power tree where you can take both hunks, and the
    other is the removal of our asm/dma-mapping.h file by Christoph where
    you can just remove the file/ignore our change.

  * I've renewed the expiry date on my pgp key, so you may need to refetch
    from the kernel.org keys repository.

Cheers,

Will

--->8

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to e376897f424a1c807779a2635f62eb02d7e382f9:

  arm64: remove __iounmap (2019-09-04 13:12:26 +0100)

----------------------------------------------------------------
arm64 updates for 5.4:

- 52-bit virtual addressing in the kernel

- New ABI to allow tagged user pointers to be dereferenced by syscalls

- Early RNG seeding by the bootloader

- Improve robustness of SMP boot

- Fix TLB invalidation in light of recent architectural clarifications

- Support for i.MX8 DDR PMU

- Remove direct LSE instruction patching in favour of static keys

- Function error injection using kprobes

- Support for the PPTT "thread" flag introduced by ACPI 6.3

- Move PSCI idle code into proper cpuidle driver

- Relaxation of implicit I/O memory barriers

- Build with RELR relocations when toolchain supports them

- Numerous cleanups and non-critical fixes

----------------------------------------------------------------
Andrew Murray (5):
      jump_label: Don't warn on __exit jump entries
      arm64: Use correct ll/sc atomic constraints
      arm64: atomics: avoid out-of-line ll/sc atomics
      arm64: avoid using hard-coded registers for LSE atomics
      arm64: atomics: Remove atomic_ll_sc compilation unit

Andrey Konovalov (3):
      arm64: untag user pointers in access_ok and __uaccess_mask_ptr
      selftests, arm64: add a selftest for passing tagged pointers to kernel
      selftests, arm64: fix uninitialized symbol in tags_test.c

Atish Patra (4):
      dt-binding: cpu-topology: Move cpu-map to a common binding.
      cpu-topology: Move cpu topology code to common code.
      arm: Use common cpu_topology structure and functions.
      RISC-V: Parse cpu topology during boot.

Bhupesh Sharma (1):
      arm64/kexec: Use consistent convention of initializing 'kxec_buf.mem' with KEXEC_BUF_MEM_UNKNOWN

Catalin Marinas (3):
      arm64: Introduce prctl() options to control the tagged user addresses ABI
      arm64: Tighten the PR_{SET, GET}_TAGGED_ADDR_CTRL prctl() unused arguments
      arm64: Change the tagged_addr sysctl control semantics to only prevent the opt-in

Christoph Hellwig (2):
      arm64: unexport set_memory_x and set_memory_nx
      arm64: remove __iounmap

Chuhong Yuan (1):
      arm64: Replace strncmp with str_has_prefix

Geert Uytterhoeven (1):
      arm64: Move TIF_* documentation to individual definitions

Hsin-Yi Wang (4):
      arm64: map FDT as RW for early_init_dt_scan()
      fdt: add support for rng-seed
      arm64: kexec_file: add rng-seed support
      fdt: Update CRC check for rng-seed

James Morse (1):
      arm64: entry: Move ct_user_exit before any other exception

Jeremy Linton (2):
      ACPI/PPTT: Add support for ACPI 6.3 thread flag
      arm64: topology: Use PPTT to determine if PE is a thread

Joakim Zhang (2):
      perf/imx_ddr: Add support for AXI ID filtering
      docs/perf: Add documentation for the i.MX8 DDR PMU

Julien Grall (1):
      arm64/ptrace: Fix typoes in sve_set() comment

Julien Thierry (1):
      arm64: Remove unused assembly macro

Junhua Huang (1):
      arm64: mm: free the initrd reserved memblock in a aligned manner

Kees Cook (1):
      arm64/efi: Move variable assignments after SECTIONS

Leo Yan (2):
      error-injection: Consolidate override function definition
      arm64: Add support for function error injection

Leonard Crestez (1):
      perf/imx_ddr: Add MODULE_DEVICE_TABLE

Lorenzo Pieralisi (7):
      ACPI/IORT: Rename arm_smmu_v3_set_proximity() 'node' local variable
      ARM: cpuidle: Remove useless header include
      ARM: cpuidle: Remove overzealous error logging
      drivers: firmware: psci: Decouple checker from generic ARM CPUidle
      ARM: psci: cpuidle: Introduce PSCI CPUidle driver
      ARM: psci: cpuidle: Enable PSCI CPUidle driver
      PSCI: cpuidle: Refactor CPU suspend power_state parameter handling

Mark Brown (2):
      arm64: Remove unused cpucap_multi_entry_cap_cpu_enable()
      arm64: Clarify when cpu_enable() is called

Mark Rutland (9):
      arm64: remove pointless __KERNEL__ guards
      arm64: constify icache_policy_str[]
      arm64: constify aarch64_insn_encoding_class[]
      arm64: constify sys64_hook instances
      arm64: memory: fix flipped VA space fallout
      arm64: memory: rename VA_START to PAGE_END
      kasan/arm64: fix CONFIG_KASAN_SW_TAGS && KASAN_INLINE
      arm64: fix fixmap copy for 16K pages and 48-bit VA
      arm64: kpti: ensure patched kernel text is fetched from PoU

Masahiro Yamada (2):
      arm64: remove unneeded uapi/asm/stat.h
      arm64: add arch/arm64/Kbuild

Michael Ellerman (1):
      powerpc/Makefile: Always pass --synthetic to nm if supported

Miles Chen (1):
      arm64: mm: print hexadecimal EC value in mem_abort_decode()

Nick Desaulniers (1):
      arm64: prefer __section from compiler_attributes.h

Peter Collingbourne (1):
      arm64: Add support for relocating the kernel with RELR relocations

Qian Cai (1):
      arm64/prefetch: fix a -Wtype-limits warning

Raphael Gault (1):
      arm64: perf_event: Add missing header needed for smp_processor_id()

Robin Murphy (2):
      perf/smmuv3: Validate group size
      perf/smmuv3: Validate groups for global filtering

Shaokun Zhang (1):
      arm64: perf: Remove unused macro

Stephen Boyd (1):
      perf: Remove dev_err() usage after platform_get_irq()

Steve Capper (12):
      arm64: mm: Remove bit-masking optimisations for PAGE_OFFSET and VMEMMAP_START
      arm64: mm: Flip kernel VA space
      arm64: kasan: Switch to using KASAN_SHADOW_OFFSET
      arm64: dump: De-constify VA_START and KASAN_SHADOW_START
      arm64: mm: Introduce VA_BITS_MIN
      arm64: mm: Introduce vabits_actual
      arm64: mm: Logic to make offset_ttbr1 conditional
      arm64: mm: Separate out vmemmap
      arm64: mm: Modify calculation of VMEMMAP_SIZE
      arm64: mm: Introduce 52-bit Kernel VAs
      arm64: mm: Remove vabits_user
      docs: arm64: Add layout and 52-bit info to memory document

Sudeep Holla (4):
      Documentation: DT: arm: add support for sockets defining package boundaries
      base: arch_topology: update Kconfig help description
      MAINTAINERS: Add an entry for generic architecture topology
      arm64: smp: disable hotplug on trusted OS resident CPU

Vincenzo Frascino (3):
      arm64: Define Documentation/arm64/tagged-address-abi.rst
      arm64: Add tagged-address-abi.rst to index.rst
      arm64: Relax Documentation/arm64/tagged-pointers.rst

Will Deacon (32):
      arm64: esr: Add ESR exception class encoding for trapped ERET
      arm64: sysreg: Remove unused and rotting SCTLR_ELx field definitions
      arm64: io: Relax implicit barriers in default I/O accessors
      init/Kconfig: Fix infinite Kconfig recursion on PPC
      arm64: mm: Simplify definition of virt_addr_valid()
      arm64: mm: Really fix sparse warning in untagged_addr()
      Merge tag 'common/for-v5.4-rc1/cpu-topology' of git://git.kernel.org/.../riscv/linux into for-next/cpu-topology
      arm64: memory: Fix virt_addr_valid() using __is_lm_address()
      arm64: memory: Ensure address tag is masked in conversion macros
      arm64: memory: Rewrite default page_to_virt()/virt_to_page()
      arm64: memory: Simplify virt_to_page() implementation
      arm64: memory: Simplify _VA_START and _PAGE_OFFSET definitions
      arm64: memory: Implement __tag_set() as common function
      arm64: memory: Add comments to end of non-trivial #ifdef blocks
      arm64: memory: Cosmetic cleanups
      Revert "init/Kconfig: Fix infinite Kconfig recursion on PPC"
      arm64: smp: Increase secondary CPU boot timeout value
      arm64: smp: Don't enter kernel with NULL stack pointer or task struct
      arm64: smp: Treat unknown boot failures as being 'stuck in kernel'
      Revert "arm64: Remove unnecessary ISBs from set_{pte,pmd,pud}"
      arm64: tlb: Ensure we execute an ISB following walk cache invalidation
      arm64: mm: Add ISB instruction to set_pgd()
      arm64: sysreg: Add some field definitions for PAR_EL1
      arm64: mm: Ignore spurious translation faults taken from the kernel
      arm64: kvm: Replace hardcoded '1' with SYS_PAR_EL1_F
      arm64: lse: Remove unused 'alt_lse' assembly macro
      arm64: asm: Kill 'asm/atomic_arch.h'
      arm64: lse: Make ARM64_LSE_ATOMICS depend on JUMP_LABEL
      arm64: atomics: Undefine internal macros after use
      arm64: atomics: Use K constraint when toolchain appears to support it
      Merge branches 'for-next/52-bit-kva', 'for-next/cpu-topology', 'for-next/error-injection', 'for-next/perf', 'for-next/psci-cpuidle', 'for-next/rng', 'for-next/smpboot', 'for-next/tbi' and 'for-next/tlbi' into for-next/core
      Merge branch 'for-next/atomics' into for-next/core

 Documentation/admin-guide/perf/imx-ddr.rst         |  52 +++
 Documentation/arm64/index.rst                      |   1 +
 Documentation/arm64/kasan-offsets.sh               |  27 ++
 Documentation/arm64/memory.rst                     | 123 +++++--
 Documentation/arm64/tagged-address-abi.rst         | 156 ++++++++
 Documentation/arm64/tagged-pointers.rst            |  21 +-
 .../{arm/topology.txt => cpu/cpu-topology.txt}     | 256 ++++++++-----
 MAINTAINERS                                        |  16 +
 Makefile                                           |   4 +
 arch/Kconfig                                       |  14 +
 arch/arm/include/asm/topology.h                    |  20 --
 arch/arm/kernel/topology.c                         |  60 +---
 arch/arm64/Kbuild                                  |   6 +
 arch/arm64/Kconfig                                 |  43 ++-
 arch/arm64/Makefile                                |  23 +-
 arch/arm64/include/asm/assembler.h                 |  28 +-
 arch/arm64/include/asm/atomic.h                    |  99 +++++-
 arch/arm64/include/asm/atomic_ll_sc.h              | 217 ++++++-----
 arch/arm64/include/asm/atomic_lse.h                | 395 +++++++--------------
 arch/arm64/include/asm/cache.h                     |   2 +-
 arch/arm64/include/asm/cmpxchg.h                   |  45 ++-
 arch/arm64/include/asm/compat.h                    |   2 -
 arch/arm64/include/asm/cpu_ops.h                   |   3 +
 arch/arm64/include/asm/cpufeature.h                |  28 +-
 arch/arm64/include/asm/cputype.h                   |  21 +-
 arch/arm64/include/asm/debug-monitors.h            |   3 -
 arch/arm64/include/asm/dma-mapping.h               |   3 -
 arch/arm64/include/asm/efi.h                       |   4 +-
 arch/arm64/include/asm/esr.h                       |   3 +-
 arch/arm64/include/asm/exception.h                 |   2 +
 arch/arm64/include/asm/fpsimd.h                    |   2 +-
 arch/arm64/include/asm/futex.h                     |   3 -
 arch/arm64/include/asm/hw_breakpoint.h             |   3 -
 arch/arm64/include/asm/io.h                        |  10 +-
 arch/arm64/include/asm/irqflags.h                  |   5 +-
 arch/arm64/include/asm/kasan.h                     |  11 +-
 arch/arm64/include/asm/lse.h                       |  49 ++-
 arch/arm64/include/asm/memory.h                    | 141 ++++----
 arch/arm64/include/asm/mmu.h                       |   2 +-
 arch/arm64/include/asm/mmu_context.h               |   4 +-
 arch/arm64/include/asm/pci.h                       |   2 -
 arch/arm64/include/asm/pgtable-hwdef.h             |   2 +-
 arch/arm64/include/asm/pgtable.h                   |  23 +-
 arch/arm64/include/asm/pointer_auth.h              |   2 +-
 arch/arm64/include/asm/proc-fns.h                  |   2 -
 arch/arm64/include/asm/processor.h                 |  15 +-
 arch/arm64/include/asm/ptrace.h                    |   5 +
 arch/arm64/include/asm/signal32.h                  |   2 -
 arch/arm64/include/asm/sysreg.h                    |  32 +-
 arch/arm64/include/asm/thread_info.h               |  29 +-
 arch/arm64/include/asm/tlbflush.h                  |   1 +
 arch/arm64/include/asm/topology.h                  |  23 --
 arch/arm64/include/asm/uaccess.h                   |  12 +-
 arch/arm64/include/asm/vdso.h                      |   4 -
 arch/arm64/include/asm/vdso_datapage.h             |   4 -
 arch/arm64/include/uapi/asm/stat.h                 |  17 -
 arch/arm64/kernel/cpufeature.c                     |   2 +-
 arch/arm64/kernel/cpuidle.c                        |  50 ++-
 arch/arm64/kernel/cpuinfo.c                        |   2 +-
 arch/arm64/kernel/entry.S                          |  36 +-
 arch/arm64/kernel/head.S                           | 116 +++++-
 arch/arm64/kernel/hibernate-asm.S                  |   8 +-
 arch/arm64/kernel/hibernate.c                      |   2 +-
 arch/arm64/kernel/image-vars.h                     |  51 +++
 arch/arm64/kernel/image.h                          |  42 ---
 arch/arm64/kernel/insn.c                           |   2 +-
 arch/arm64/kernel/kaslr.c                          |  11 +-
 arch/arm64/kernel/kexec_image.c                    |   2 +-
 arch/arm64/kernel/machine_kexec_file.c             |  22 +-
 arch/arm64/kernel/module-plts.c                    |   2 +-
 arch/arm64/kernel/perf_event.c                     |   2 +-
 arch/arm64/kernel/process.c                        |  76 ++++
 arch/arm64/kernel/psci.c                           |  10 +-
 arch/arm64/kernel/ptrace.c                         |   2 +-
 arch/arm64/kernel/setup.c                          |  20 +-
 arch/arm64/kernel/smp.c                            |   4 +-
 arch/arm64/kernel/smp_spin_table.c                 |   2 +-
 arch/arm64/kernel/topology.c                       | 312 +---------------
 arch/arm64/kernel/traps.c                          |  20 +-
 arch/arm64/kernel/vmlinux.lds.S                    |  11 +
 arch/arm64/kvm/hyp/switch.c                        |   2 +-
 arch/arm64/kvm/va_layout.c                         |  14 +-
 arch/arm64/lib/Makefile                            |  21 +-
 arch/arm64/lib/atomic_ll_sc.c                      |   3 -
 arch/arm64/lib/error-inject.c                      |  18 +
 arch/arm64/mm/dump.c                               |  24 +-
 arch/arm64/mm/fault.c                              |  44 ++-
 arch/arm64/mm/init.c                               |  35 +-
 arch/arm64/mm/ioremap.c                            |   4 +-
 arch/arm64/mm/kasan_init.c                         |   9 +-
 arch/arm64/mm/mmu.c                                |  32 +-
 arch/arm64/mm/numa.c                               |   2 +-
 arch/arm64/mm/pageattr.c                           |   2 -
 arch/arm64/mm/proc.S                               |  20 +-
 arch/powerpc/Makefile                              |   2 -
 arch/powerpc/include/asm/error-injection.h         |  13 -
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/kernel/smpboot.c                        |   3 +
 arch/x86/include/asm/error-injection.h             |  13 -
 drivers/acpi/arm64/iort.c                          |   6 +-
 drivers/acpi/pptt.c                                |  53 ++-
 drivers/base/Kconfig                               |   2 +-
 drivers/base/arch_topology.c                       | 298 ++++++++++++++++
 drivers/char/Kconfig                               |   9 +
 drivers/char/random.c                              |  14 +
 drivers/cpuidle/Kconfig.arm                        |  10 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-arm.c                      |  13 +-
 drivers/cpuidle/cpuidle-psci.c                     | 236 ++++++++++++
 drivers/firmware/psci/psci.c                       | 167 +--------
 drivers/firmware/psci/psci_checker.c               |  16 +-
 drivers/of/fdt.c                                   |  14 +
 drivers/perf/arm_smmuv3_pmu.c                      |  65 +++-
 drivers/perf/fsl_imx8_ddr_perf.c                   |  75 +++-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |   4 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c       |   4 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       |   4 +-
 drivers/perf/qcom_l2_pmu.c                         |   6 +-
 drivers/perf/xgene_pmu.c                           |   4 +-
 include/asm-generic/error-injection.h              |   6 +
 include/linux/acpi.h                               |   5 +
 include/linux/arch_topology.h                      |  26 ++
 include/linux/cpuidle.h                            |  17 +-
 include/linux/error-injection.h                    |   6 +-
 include/linux/psci.h                               |   4 +-
 include/linux/random.h                             |   1 +
 include/linux/topology.h                           |   1 +
 include/uapi/linux/prctl.h                         |   5 +
 init/Kconfig                                       |   3 +
 kernel/jump_label.c                                |   4 +-
 kernel/sys.c                                       |  16 +
 scripts/Makefile.kasan                             |  11 +-
 scripts/tools-support-relr.sh                      |  16 +
 tools/testing/selftests/arm64/.gitignore           |   1 +
 tools/testing/selftests/arm64/Makefile             |  11 +
 tools/testing/selftests/arm64/run_tags_test.sh     |  12 +
 tools/testing/selftests/arm64/tags_test.c          |  31 ++
 137 files changed, 2687 insertions(+), 1641 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/imx-ddr.rst
 create mode 100644 Documentation/arm64/kasan-offsets.sh
 create mode 100644 Documentation/arm64/tagged-address-abi.rst
 rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (66%)
 create mode 100644 arch/arm64/Kbuild
 delete mode 100644 arch/arm64/include/uapi/asm/stat.h
 create mode 100644 arch/arm64/kernel/image-vars.h
 delete mode 100644 arch/arm64/lib/atomic_ll_sc.c
 create mode 100644 arch/arm64/lib/error-inject.c
 delete mode 100644 arch/powerpc/include/asm/error-injection.h
 delete mode 100644 arch/x86/include/asm/error-injection.h
 create mode 100644 drivers/cpuidle/cpuidle-psci.c
 create mode 100755 scripts/tools-support-relr.sh
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_test.c
