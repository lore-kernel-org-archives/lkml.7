Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BC0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4273F20868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfCHQm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:42:28 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32884 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfCHQm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:42:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2E0FA78;
        Fri,  8 Mar 2019 08:42:26 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D69E73F706;
        Fri,  8 Mar 2019 08:42:25 -0800 (PST)
Date:   Fri, 8 Mar 2019 16:42:23 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 5.1-rc1
Message-ID: <20190308164221.GA126180@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates for 5.1 below. There is a minor conflict
with mainline in arch/arm64/Kconfig.platforms (with the changes from the
arm-soc tree); you can find my merge resolution at the end of this
email. The pull request touches riscv for the inX() ordering w.r.t.
delay() and the acks are in place.

Thanks,
Catalin

The following changes since commit 6e4933a006616343f66c4702dc4fc56bb25e7b02:

  irqdesc: Add domain handler for NMIs (2019-02-05 14:37:05 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to b855b58ac1b7891b219e1d9ef60c45c774cadefe:

  arm64: mmu: drop paging_init comments (2019-03-01 16:40:07 +0000)

----------------------------------------------------------------
arm64 updates for 5.1:

- Pseudo NMI support for arm64 using GICv3 interrupt priorities

- uaccess macros clean-up (unsafe user accessors also merged but
  reverted, waiting for objtool support on arm64)

- ptrace regsets for Pointer Authentication (ARMv8.3) key management

- inX() ordering w.r.t. delay() on arm64 and riscv (acks in place by the
  riscv maintainers)

- arm64/perf updates: PMU bindings converted to json-schema, unused
  variable and misleading comment removed

- arm64/debug fixes to ensure checking of the triggering exception level
  and to avoid the propagation of the UNKNOWN FAR value into the si_code
  for debug signals

- Workaround for Fujitsu A64FX erratum 010001

- lib/raid6 ARM NEON optimisations

- NR_CPUS now defaults to 256 on arm64

- Minor clean-ups (documentation/comments, Kconfig warning, unused
  asm-offsets, clang warnings)

- MAINTAINERS update for list information to the ARM64 ACPI entry

----------------------------------------------------------------
Anders Roxell (1):
      arm64: Kconfig.platforms: fix warning unmet direct dependencies

Andrew Murray (2):
      arm64: perf: remove misleading comment
      arm64: asm-offsets: remove unused offsets

Ard Biesheuvel (1):
      lib/raid6: arm: optimize away a mask operation in NEON recovery routine

Arnd Bergmann (1):
      arm64: avoid clang warning about self-assignment

Catalin Marinas (3):
      Merge branch 'irq/generic-nmi' of git://git.kernel.org/.../maz/arm-platforms
      Merge branch 'for-next/perf' of git://git.kernel.org/.../will/linux
      Revert "arm64: uaccess: Implement unsafe accessors"

Daniel Thompson (1):
      arm64: alternative: Apply alternatives early in boot process

Greg Kroah-Hartman (1):
      arm64: dump: no need to check return value of debugfs_create functions

Julien Grall (1):
      arm64: Remove documentation about TIF_USEDFPU

Julien Thierry (28):
      arm64: uaccess: Cleanup get/put_user()
      arm64: uaccess: Implement unsafe accessors
      arm64: Fix HCR.TGE status for NMI contexts
      arm64: Remove unused daif related functions/macros
      arm64: cpufeature: Set SYSREG_GIC_CPUIF as a boot system feature
      arm64: cpufeature: Add cpufeature for IRQ priority masking
      arm/arm64: gic-v3: Add PMR and RPR accessors
      irqchip/gic-v3: Switch to PMR masking before calling IRQ handler
      arm64: ptrace: Provide definitions for PMR values
      arm64: Make PMR part of task context
      arm64: Unmask PMR before going idle
      arm64: kvm: Unmask PMR before entering guest
      efi: Let architectures decide the flags that should be saved/restored
      arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking
      arm64: daifflags: Include PMR in daifflags restore operations
      arm64: alternative: Allow alternative status checking per cpufeature
      irqchip/gic-v3: Factor group0 detection into functions
      arm64: Switch to PMR masking when starting CPUs
      arm64: gic-v3: Implement arch support for priority masking
      irqchip/gic-v3: Detect if GIC can support pseudo-NMIs
      irqchip/gic-v3: Handle pseudo-NMIs
      irqchip/gic-v3: Allow interrupts to be set as pseudo-NMI
      arm64: Handle serror in NMI context
      arm64: Skip preemption when exiting an NMI
      arm64: Skip irqflags tracing for NMI in IRQs disabled context
      arm64: Enable the support of pseudo-NMIs
      arm64: irqflags: Fix clang build warnings
      arm64: Rename get_thread_info()

Kristina Martsenko (1):
      arm64: add ptrace regsets for ptrauth key management

Logan Gunthorpe (1):
      arm64: mm: make use of new memblocks_present() helper

Lorenzo Pieralisi (1):
      MAINTAINERS: Add LAKML list to ACPI for ARM64 entry

Mark Rutland (1):
      arm64: default NR_CPUS to 256

Nathan Chancellor (1):
      efi/arm: Don't expect a return value of ptdump_debugfs_register

Peng Fan (1):
      arm64: mmu: drop paging_init comments

Rob Herring (1):
      dt-bindings: arm: Convert PMU binding to json-schema

Valentin Schneider (1):
      arm64: entry: Remove unneeded need_resched() loop

Will Deacon (6):
      arm64: Remove asm/memblock.h
      asm-generic/io: Pass result of I/O accessor to __io_[p]ar()
      riscv: io: Update __io_[p]ar() macros to take an argument
      arm64: io: Hook up __io_par() for inX() ordering
      arm64: debug: Don't propagate UNKNOWN FAR into si_code for debug signals
      arm64: debug: Ensure debug handlers check triggering exception level

YueHaibing (1):
      perf: xgene: Remove set but not used variable 'config'

Zhang Lei (1):
      arm64: Add workaround for Fujitsu A64FX erratum 010001

ndesaulniers@google.com (1):
      lib/raid6: use vdupq_n_u8 to avoid endianness warnings

 Documentation/admin-guide/kernel-parameters.txt |   5 +
 Documentation/arm64/booting.txt                 |   5 +
 Documentation/arm64/pointer-authentication.txt  |   5 +
 Documentation/arm64/silicon-errata.txt          |   1 +
 Documentation/devicetree/bindings/arm/pmu.txt   |  70 -------
 Documentation/devicetree/bindings/arm/pmu.yaml  |  87 ++++++++
 MAINTAINERS                                     |   3 +-
 arch/arm/include/asm/arch_gicv3.h               |  33 +++
 arch/arm64/Kconfig                              |  36 +++-
 arch/arm64/Kconfig.platforms                    |   2 +-
 arch/arm64/include/asm/alternative.h            |   4 +-
 arch/arm64/include/asm/arch_gicv3.h             |  32 +++
 arch/arm64/include/asm/asm-uaccess.h            |   2 +-
 arch/arm64/include/asm/assembler.h              |  36 ++--
 arch/arm64/include/asm/cpucaps.h                |   3 +-
 arch/arm64/include/asm/cpufeature.h             |  10 +
 arch/arm64/include/asm/cputype.h                |   9 +
 arch/arm64/include/asm/daifflags.h              |  60 ++++--
 arch/arm64/include/asm/efi.h                    |  11 +
 arch/arm64/include/asm/hardirq.h                |  31 +++
 arch/arm64/include/asm/io.h                     |   1 +
 arch/arm64/include/asm/irqflags.h               | 100 ++++++---
 arch/arm64/include/asm/kvm_host.h               |  16 ++
 arch/arm64/include/asm/memblock.h               |  21 --
 arch/arm64/include/asm/memory.h                 |   5 +-
 arch/arm64/include/asm/mmu.h                    |   1 +
 arch/arm64/include/asm/pgtable-hwdef.h          |   1 +
 arch/arm64/include/asm/processor.h              |   3 +
 arch/arm64/include/asm/ptdump.h                 |   9 +-
 arch/arm64/include/asm/ptrace.h                 |  26 ++-
 arch/arm64/include/asm/thread_info.h            |   1 -
 arch/arm64/include/asm/uaccess.h                |  36 ++--
 arch/arm64/include/uapi/asm/ptrace.h            |  13 ++
 arch/arm64/kernel/alternative.c                 |  60 +++++-
 arch/arm64/kernel/asm-offsets.c                 |  21 +-
 arch/arm64/kernel/cpufeature.c                  |  41 +++-
 arch/arm64/kernel/entry.S                       |  60 ++++--
 arch/arm64/kernel/irq.c                         |   3 +
 arch/arm64/kernel/kgdb.c                        |  14 +-
 arch/arm64/kernel/perf_event.c                  |   2 +-
 arch/arm64/kernel/probes/kprobes.c              |   6 +
 arch/arm64/kernel/process.c                     |  51 +++++
 arch/arm64/kernel/ptrace.c                      | 147 +++++++++++++
 arch/arm64/kernel/setup.c                       |   1 -
 arch/arm64/kernel/smp.c                         |  33 +++
 arch/arm64/kernel/traps.c                       |   8 +-
 arch/arm64/kvm/hyp/switch.c                     |  16 ++
 arch/arm64/mm/dump.c                            |   4 +-
 arch/arm64/mm/fault.c                           |   9 +-
 arch/arm64/mm/init.c                            |  20 +-
 arch/arm64/mm/mmu.c                             |   5 -
 arch/arm64/mm/proc.S                            |  12 +-
 arch/arm64/mm/ptdump_debugfs.c                  |   7 +-
 arch/riscv/include/asm/io.h                     |  36 ++--
 drivers/firmware/efi/arm-runtime.c              |   6 +-
 drivers/firmware/efi/runtime-wrappers.c         |  17 +-
 drivers/irqchip/irq-gic-v3.c                    | 265 +++++++++++++++++++++---
 drivers/perf/xgene_pmu.c                        |   2 -
 include/asm-generic/io.h                        |  20 +-
 include/linux/efi.h                             |   5 +-
 include/linux/hardirq.h                         |   7 +
 include/uapi/linux/elf.h                        |   2 +
 lib/raid6/neon.uc                               |   5 +-
 lib/raid6/recov_neon_inner.c                    |  19 +-
 64 files changed, 1214 insertions(+), 368 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml
 delete mode 100644 arch/arm64/include/asm/memblock.h

---------------------8<--------------------------------------------------
diff --cc arch/arm64/Kconfig.platforms
index c5f6a57f16b8,d4faca775d9c..70498a033cf5
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@@ -151,11 -145,7 +151,11 @@@ config ARCH_MVEB
  config ARCH_MXC
  	bool "ARMv8 based NXP i.MX SoC family"
  	select ARM64_ERRATUM_843419
- 	select ARM64_ERRATUM_845719
+ 	select ARM64_ERRATUM_845719 if COMPAT
 +	select IMX_GPCV2
 +	select IMX_GPCV2_PM_DOMAINS
 +	select PM
 +	select PM_GENERIC_DOMAINS
  	help
  	  This enables support for the ARMv8 based SoCs in the
  	  NXP i.MX family.
diff --cc arch/arm64/include/asm/daifflags.h
index fa90779fc752,1dd3d7a38d34..db452aa9e651
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@@ -18,9 -18,10 +18,11 @@@
  
  #include <linux/irqflags.h>
  
+ #include <asm/cpufeature.h>
+ 
  #define DAIF_PROCCTX		0
  #define DAIF_PROCCTX_NOIRQ	PSR_I_BIT
 +#define DAIF_ERRCTX		(PSR_I_BIT | PSR_A_BIT)
  
  /* mask/save/unmask/restore all exceptions, including interrupts. */
  static inline void local_daif_mask(void)
diff --cc arch/arm64/kvm/hyp/switch.c
index 421ebf6f7086,6a4c2d6c3287..3563fe655cd5
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@@ -22,8 -22,8 +22,9 @@@
  
  #include <kvm/arm_psci.h>
  
+ #include <asm/arch_gicv3.h>
  #include <asm/cpufeature.h>
 +#include <asm/kprobes.h>
  #include <asm/kvm_asm.h>
  #include <asm/kvm_emulate.h>
  #include <asm/kvm_host.h>
