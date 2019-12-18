Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A05C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D441620716
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfLRS02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:26:28 -0500
Received: from foss.arm.com ([217.140.110.172]:56488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfLRS01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:26:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F12EE1FB;
        Wed, 18 Dec 2019 10:26:26 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C9F53F67D;
        Wed, 18 Dec 2019 10:26:25 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] arm64: ARMv8.4 Activity Monitors support
Date:   Wed, 18 Dec 2019 18:26:01 +0000
Message-Id: <20191218182607.21607-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches introduce support for the Activity Monitors Unit (AMU)
CPU extension, an optional extension in ARMv8.4 CPUs. This provides
performance counters intended for system management use. Two of these
counters are then used to compute the frequency scale correction
factor needed to achieve frequency invariance.

With the CONFIG_ARM64_AMU_EXTN enabled the kernel is able to safely
run a mix of CPUs with and without support for the AMU extension.
The AMU capability is unconditionally enabled in the kernel as to
allow any late CPU to use the feature: the cpu_enable function will
be called for all CPUs that match the criteria, including secondary
and hotplugged CPUs, marking this feature as present on that
respective CPU (through a per-cpu variable).

To be noted that firmware must implement AMU support when running on
CPUs that present the activity monitors extension: allow access to
the registers from lower exception levels, enable the counters,
implement save and restore functionality. More details can be found
in the documentation.

Given that the activity counters inform on activity on the CPUs, and 
that not all CPUs might implement the extension, for functional and 
security reasons, it's best to disable access to the AMU registers
from userspace (EL0) and KVM guests.

In the last patch of the series, two of the AMU counters are used to
compute the frequency scale factor needed to achieve frequency
invariance of signals in the scheduler, based on an interface added
to support counter-based frequency invariance - arch_scale_freq_tick.
The interface and update point for the counter-based frequency scale
factor is based on the similar approach in the patch that introduces
frequency invariance for x86 [1]. 

The current series is based on linux-next 20191217.

Testing:
 - Build tested for multiple architectures and defconfigs.
 - AMU feature detection, EL0 and KVM guest access to AMU registers,
   feature support in firmware (version 1.5 and later of the ARM 
   Trusted Firmware) was tested on an Armv8-A Base Platform FVP:
   Architecture Envelope Model [2] (supports version 8.0 to 8.5),
   with the following configurations:

   cluster0.has_arm_v8-4=1
   cluster1.has_arm_v8-4=1
   cluster0.has_amu=1
   cluster1.has_amu=1

v1 -> v2:
 - v1 can be found at [3]
 - Added patches that use the counters for the scheduler's frequency
   invariance engine
 - In patch arm64: add support for the AMU extension v1 - 
    - Defined an accessor function cpu_has_amu_feat to allow a read
      of amu_feat only from the current CPU, to ensure the safe use
      of the per-cpu variable for the current user (arm64 topology
      driver) and future users.
    - Modified type of amu_feat from bool to u8 to satisfy sparse
      checker's warning 'expression using sizeof _Bool [sparse]',
      as the size of bool is compiler dependent.

[1] https://lore.kernel.org/lkml/20191113124654.18122-1-ggherdovich@suse.cz/
[2] https://developer.arm.com/tools-and-software/simulation-models/fixed-virtual-platforms
[3] https://lore.kernel.org/lkml/20190917134228.5369-1-ionela.voinescu@arm.com/

Ionela Voinescu (6):
  arm64: add support for the AMU extension v1
  arm64: trap to EL1 accesses to AMU counters from EL0
  arm64/kvm: disable access to AMU registers from kvm guests
  Documentation: arm64: document support for the AMU extension
  TEMP: sched: add interface for counter-based frequency invariance
  arm64: use activity monitors for frequency invariance

 Documentation/arm64/amu.rst                   | 107 ++++++++
 Documentation/arm64/booting.rst               |  14 ++
 Documentation/arm64/cpu-feature-registers.rst |   2 +
 Documentation/arm64/index.rst                 |   1 +
 arch/arm64/Kconfig                            |  27 ++
 arch/arm64/include/asm/assembler.h            |  10 +
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   4 +
 arch/arm64/include/asm/kvm_arm.h              |   7 +-
 arch/arm64/include/asm/sysreg.h               |  44 ++++
 arch/arm64/include/asm/topology.h             |   9 +
 arch/arm64/kernel/cpufeature.c                |  81 +++++-
 arch/arm64/kernel/topology.c                  | 233 ++++++++++++++++++
 arch/arm64/kvm/hyp/switch.c                   |  13 +-
 arch/arm64/kvm/sys_regs.c                     |  95 ++++++-
 arch/arm64/mm/proc.S                          |   3 +
 drivers/base/arch_topology.c                  |  16 ++
 kernel/sched/core.c                           |   1 +
 kernel/sched/sched.h                          |   7 +
 19 files changed, 666 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/arm64/amu.rst

-- 
2.17.1

