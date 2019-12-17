Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5EAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE9620733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLQSeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:34:17 -0500
Received: from foss.arm.com ([217.140.110.172]:44744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfLQSeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:34:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0E3730E;
        Tue, 17 Dec 2019 10:34:16 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6115B3F67D;
        Tue, 17 Dec 2019 10:34:15 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, dave.martin@arm.com, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, christoffer.dall@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 0/7] arm64: Fix support for no FP/SIMD
Date:   Tue, 17 Dec 2019 18:33:55 +0000
Message-Id: <20191217183402.2259904-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the support for systems without FP/SIMD unit.

We detect the absence of FP/SIMD after the SMP cpus are brought
online (i.e, SYSTEM scope). This means, we allow a hotplugged
CPU to boot successfully even if it doesn't have the FP/SIMD
when we have decided otherwise at boot and have now advertised
the ELF HWCAP for the userspace. Fix this by turning this to a
BOOT_RESTRICTED_CPU_LOCAL feature to allow the detection of the
feature the very moment a CPU turns up without FP/SIMD and also
prevent a conflict after SMP boot.

The COMPAT ELF_HWCAPs were statically set to indicate the
availability of VFP. Make it dynamic to set the appropriate
bits.

Also, some of the early kernel threads (including init) could run
with their TIF_FOREIGN_FPSTATE flag set which might be inherited
by applications forked by them (e.g, modprobe from initramfs).
Now, if we detect the absence of FP/SIMD we stop clearing the
TIF flag in fpsimd_restore_current_state(). This could cause
the applications stuck in do_notify_resume() looping forever
to clear the flag. Fix this by clearing the TIF flag in
fpsimd_restore_current_state() for the tasks that may
have it set.

This series also categorises the functions dealing with fpsimd
into two :

 - Call permitted with missing FP/SIMD support. But we bail
   out early in the function. This is for functions exposed
   to the generic kernel code.

 - Calls not permitted with missing FP/SIMD support. These
   are functions which deal with the CPU/Task FP/SIMD registers
   and/or meta-data. The callers must check for the support
   before invoking them.

See the last patch in the series for details. 

Also make sure that the SVE is initialised where supported,
before the FP/SIMD is used by the kernel.

Tested with debian armel initramfs and rootfs. The arm64 doesn't
have a soft-float ABI, thus haven't tested it with 64bit userspace.

Applies on v5.5-rc2.

Suzuki K Poulose (7):
  arm64: Introduce system_capabilities_finalized() marker
  arm64: fpsimd: Make sure SVE setup is complete before SIMD is used
  arm64: cpufeature: Fix the type of no FP/SIMD capability
  arm64: cpufeature: Set the FP/SIMD compat HWCAP bits properly
  arm64: ptrace: nofpsimd: Fail FP/SIMD regset operations
  arm64: signal: nofpsimd: Handle fp/simd context for signal frames
  arm64: nofpsmid: Handle TIF_FOREIGN_FPSTATE flag cleanly

 arch/arm64/include/asm/cpufeature.h |  5 +++
 arch/arm64/include/asm/kvm_host.h   |  2 +-
 arch/arm64/include/asm/mmu.h        |  2 +-
 arch/arm64/include/asm/simd.h       |  8 +++-
 arch/arm64/kernel/cpufeature.c      | 65 +++++++++++++++++++----------
 arch/arm64/kernel/fpsimd.c          | 32 ++++++++++++--
 arch/arm64/kernel/process.c         |  2 +-
 arch/arm64/kernel/ptrace.c          | 12 ++++++
 arch/arm64/kernel/signal.c          | 17 +++++++-
 arch/arm64/kernel/signal32.c        | 12 +++++-
 arch/arm64/kvm/hyp/switch.c         |  9 ++++
 11 files changed, 132 insertions(+), 34 deletions(-)

-- 
2.23.0

