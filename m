Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5B8C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB34620725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLPL4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:56:43 -0500
Received: from foss.arm.com ([217.140.110.172]:51920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbfLPL4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:56:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E680F1FB;
        Mon, 16 Dec 2019 03:56:42 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E41E13F719;
        Mon, 16 Dec 2019 03:56:41 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, Steven Price <steven.price@arm.com>
Subject: [PATCH v5 0/3] arm64: Workaround for Cortex-A55 erratum 1530923
Date:   Mon, 16 Dec 2019 11:56:28 +0000
Message-Id: <20191216115631.17804-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 5 is a rebasing of version 4 (no changes).

This series enables a workaround for Cortex-A55 erratum 1530923. The
erratum potentially allows TLB entries to be allocated as a result of a
speculative AT instruction. This may happen in the middle of a guest
world switch while the relevant VMSA configuration is in an inconsistent
state, leading to erroneous content being allocated into TLBs.

There are existing workarounds for similar issues, 1165522 is
effectively the same, and 1319367/1319537 is similar but without VHE
support.  Rather than add to the selection of errata, the first patch
renames 1165522 to WORKAROUND_SPECULATIVE_AT which can be reused (in the
final patch) for 1530923.

The workaround for errata 1319367 and 1319537 although similar cannot
use VHE (not available on those CPUs) so cannot share the workaround.
However, to keep some sense of symmetry the workaround is renamed to
SPECULATIVE_AT_NVHE.

Changes since v4:
 * Rebased to v5.5-rc1

Changes since v3:
 * Added Suzuki's reviewed-bys - thanks!
 * Corrected ARM64_WORKAROUND_SPECULATIVE_AT to
   ARM64_WORKAROUND_SPECULATIVE_AT_VHE in the final patch

Changes since v2:
 * Split 1319367/1319537 back into their own workaround, but rename it
   for symmetry with the VHE workaround.

Changes since v1:
 * Combine 1319367/1319537 into the same 'SPECULATIVE_AT' workaround.

Steven Price (3):
  arm64: Rename WORKAROUND_1165522 to SPECULATIVE_AT_VHE
  arm64: Rename WORKAROUND_1319367 to SPECULATIVE_AT_NVHE
  arm64: Workaround for Cortex-A55 erratum 1530923

 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 21 +++++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h       |  4 ++--
 arch/arm64/include/asm/kvm_host.h      |  2 +-
 arch/arm64/include/asm/kvm_hyp.h       |  6 +++---
 arch/arm64/kernel/cpu_errata.c         | 25 +++++++++++++++++++------
 arch/arm64/kvm/hyp/switch.c            | 10 +++++-----
 arch/arm64/kvm/hyp/sysreg-sr.c         |  4 ++--
 arch/arm64/kvm/hyp/tlb.c               | 12 ++++++------
 9 files changed, 61 insertions(+), 25 deletions(-)

-- 
2.20.1

