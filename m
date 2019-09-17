Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636FAC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5012053B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfIQNnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:43:08 -0400
Received: from foss.arm.com ([217.140.110.172]:56152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIQNnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:43:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA8C828;
        Tue, 17 Sep 2019 06:43:07 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B9913F575;
        Tue, 17 Sep 2019 06:43:06 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [PATCH 0/4] arm64: ARMv8.4 Activity Monitors support
Date:   Tue, 17 Sep 2019 14:42:24 +0100
Message-Id: <20190917134228.5369-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches introduce support for the Activity Monitors Unit (AMU)
CPU extension, an optional extension in ARMv8.4 CPUs. This provides
performance counters intended for system management use.

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

The current series is based on linux-next 20190916.

Testing:
 - Build tested for multiple architectures and defconfigs.
 - AMU feature detection, EL0 and KVM guest access to AMU registers,
   feature support in firmware (version 1.5 and later of the ARM 
   Trusted Firmware) was tested on an Armv8-A Base Platform FVP:
   Architecture Envelope Model [1] (supports version 8.0 to 8.5),
   with the following configurations:

   cluster0.has_arm_v8-4=1
   cluster1.has_arm_v8-4=1
   cluster0.has_amu=1
   cluster1.has_amu=1

[1] https://developer.arm.com/tools-and-software/simulation-models/fixed-virtual-platforms

Ionela Voinescu (4):
  arm64: add support for the AMU extension v1
  arm64: trap to EL1 accesses to AMU counters from EL0
  arm64/kvm: disable access to AMU registers from kvm guests
  Documentation: arm64: document support for the AMU extension

 Documentation/arm64/amu.rst                   | 107 ++++++++++++++++++
 Documentation/arm64/booting.rst               |  14 +++
 Documentation/arm64/cpu-feature-registers.rst |   2 +
 Documentation/arm64/index.rst                 |   1 +
 arch/arm64/Kconfig                            |  27 +++++
 arch/arm64/include/asm/assembler.h            |  10 ++
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/kvm_arm.h              |   7 +-
 arch/arm64/include/asm/sysreg.h               |  44 +++++++
 arch/arm64/kernel/cpufeature.c                |  71 +++++++++++-
 arch/arm64/kvm/hyp/switch.c                   |  13 ++-
 arch/arm64/kvm/sys_regs.c                     |  95 +++++++++++++++-
 arch/arm64/mm/proc.S                          |   3 +
 13 files changed, 386 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/arm64/amu.rst

-- 
2.17.1

