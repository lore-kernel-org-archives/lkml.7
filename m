Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549FAC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F203206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKNO76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:59:58 -0500
Received: from foss.arm.com ([217.140.110.172]:44606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKNO76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:59:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFA3A328;
        Thu, 14 Nov 2019 06:59:57 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B07C33F52E;
        Thu, 14 Nov 2019 06:59:56 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com
Subject: [PATCH 0/5] arm64: Add workaround for Cortex-A77 erratum 1542418
Date:   Thu, 14 Nov 2019 14:59:13 +0000
Message-Id: <20191114145918.235339-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds workaround for Arm erratum 1542418 which affects
Cortex-A77 cores (r0p0 - r1p0). Affected cores may execute stale
instructions from the L0 macro-op cache violating the
prefetch-speculation-protection guaranteed by the architecture.
This happens when the when the branch predictor bases its predictions
on a branch at this address on the stale history due to ASID or VMID
reuse.

The workaround is to invalidate the branch history before reusing
any ASID for a new address space. This is done by ensuring 60 ASIDs
are selected before any ASID is reused.


James Morse (5):
  arm64: Add MIDR encoding for Arm Cortex-A77
  arm64: mm: Workaround Cortex-A77 erratum 1542418 on ASID rollover
  arm64: Workaround Cortex-A77 erratum 1542418 on boot due to kexec
  KVM: arm64: Workaround Cortex-A77 erratum 1542418 on VMID rollover
  KVM: arm/arm64: Don't invoke defacto-CnP on first run

 Documentation/arm64/silicon-errata.rst |  2 +
 arch/arm/include/asm/kvm_mmu.h         |  5 ++
 arch/arm64/Kconfig                     | 16 ++++++
 arch/arm64/include/asm/cpucaps.h       |  3 +-
 arch/arm64/include/asm/cputype.h       |  2 +
 arch/arm64/include/asm/kvm_mmu.h       | 15 ++++++
 arch/arm64/include/asm/mmu_context.h   |  1 +
 arch/arm64/kernel/cpu_errata.c         | 21 ++++++++
 arch/arm64/mm/context.c                | 73 +++++++++++++++++++++++++-
 virt/kvm/arm/arm.c                     | 23 +++++---
 10 files changed, 151 insertions(+), 10 deletions(-)

-- 
2.23.0

