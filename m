Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E63C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6389320880
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404557AbfHBRR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:17:59 -0400
Received: from foss.arm.com ([217.140.110.172]:55390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391083AbfHBRR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:17:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18322344;
        Fri,  2 Aug 2019 10:17:58 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B6AB3F575;
        Fri,  2 Aug 2019 10:17:57 -0700 (PDT)
Date:   Fri, 2 Aug 2019 18:17:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.3-rc3
Message-ID: <20190802171753.GA56033@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to d8bb6718c4db9bcd075dde7ff55d46091ccfae15:

  arm64: Make debug exception handlers visible from RCU (2019-08-02 11:56:01 +0100)

----------------------------------------------------------------
arm64 fixes:

- Update the compat layer to allow single-byte watchpoints on all
  addresses (similar to the native support)

- arm_pmu: fix the restoration of the counters on the
  CPU_PM_ENTER_FAILED path

- Fix build regression with vDSO and Makefile not stripping
  CROSS_COMPILE_COMPAT

- Fix the CTR_EL0 (cache type register) sanitisation on heterogeneous
  machines (e.g. big.LITTLE)

- Fix the interrupt controller priority mask value when pseudo-NMIs are
  enabled

- arm64 kprobes fixes: recovering of the PSTATE.D flag in the
  single-step exception handler, NOKPROBE annotations for unwind_frame()
  and walk_stackframe(), remove unneeded rcu_read_lock/unlock from debug
  handlers

- Several gcc fall-through warnings

- Unused variable warnings

----------------------------------------------------------------
Anders Roxell (2):
      arm64: smp: Mark expected switch fall-through
      arm64: module: Mark expected switch fall-through

Julien Thierry (1):
      arm64: Lower priority mask for GIC_PRIO_IRQON

Masami Hiramatsu (4):
      arm64: unwind: Prohibit probing on return_address()
      arm64: Remove unneeded rcu_read_lock from debug handlers
      arm64: kprobes: Recover pstate.D in single-step exception handler
      arm64: Make debug exception handlers visible from RCU

Qian Cai (3):
      arm64/efi: fix variable 'si' set but not used
      arm64/mm: fix variable 'pud' set but not used
      arm64/mm: fix variable 'tag' set but not used

Vincenzo Frascino (1):
      arm64: vdso: Fix Makefile regression

Will Deacon (4):
      arm64: compat: Allow single-byte watchpoints on all addresses
      drivers/perf: arm_pmu: Fix failure path in PM notifier
      arm64: hw_breakpoint: Fix warnings about implicit fallthrough
      arm64: cpufeature: Fix feature comparison for CTR_EL0.{CWG,ERG}

 arch/arm64/Makefile                 |  2 +-
 arch/arm64/include/asm/arch_gicv3.h |  6 ++++
 arch/arm64/include/asm/cpufeature.h |  7 +++--
 arch/arm64/include/asm/daifflags.h  |  2 ++
 arch/arm64/include/asm/efi.h        |  6 +++-
 arch/arm64/include/asm/memory.h     | 10 +++++--
 arch/arm64/include/asm/pgtable.h    |  4 +--
 arch/arm64/include/asm/ptrace.h     |  2 +-
 arch/arm64/kernel/cpufeature.c      |  8 ++++--
 arch/arm64/kernel/debug-monitors.c  | 14 +++++----
 arch/arm64/kernel/hw_breakpoint.c   | 11 +++++--
 arch/arm64/kernel/module.c          |  4 +++
 arch/arm64/kernel/probes/kprobes.c  | 40 ++++----------------------
 arch/arm64/kernel/return_address.c  |  3 ++
 arch/arm64/kernel/smp.c             |  2 +-
 arch/arm64/kernel/stacktrace.c      |  3 ++
 arch/arm64/mm/fault.c               | 57 +++++++++++++++++++++++++++++++------
 drivers/perf/arm_pmu.c              |  2 +-
 18 files changed, 117 insertions(+), 66 deletions(-)

-- 
Catalin
