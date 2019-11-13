Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33986C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFD1222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfKMLl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:41:29 -0500
Received: from foss.arm.com ([217.140.110.172]:51090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfKMLl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:41:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40B347A7;
        Wed, 13 Nov 2019 03:41:28 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFA603F534;
        Wed, 13 Nov 2019 03:41:26 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH v2 0/2] arm64: Workaround for Cortex-A55 erratum 1530923
Date:   Wed, 13 Nov 2019 11:41:16 +0000
Message-Id: <20191113114118.2427-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables a workaround for Cortex-A55 erratum 1530923. The
erratum potentially allows TLB entries to be allocated as a result of a
speculative AT instruction. This may happen in the middle of a guest
world switch while the relevant VMSA configuration is in an inconsistent
state, leading to erroneous content being allocated into TLBs.

There are existing workarounds for similar issues, 1165522 is
effectively the same, and 1319367/1319537 is similar but without VHE
support.  Rather than add to the selection of errata, the first patch
combines the existing errata into one workaround.

The second patch then adds the detection for the Cortex-A55 erratum
1530923.

Changes since v1:
 * Combine 1319367/1319537 into the same 'SPECULATIVE_AT' workaround.

Steven Price (2):
  arm64: Combine workarounds for speculative AT errata
  arm64: Workaround for Cortex-A55 erratum 1530923

 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 18 ++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h       |  5 ++---
 arch/arm64/include/asm/kvm_host.h      |  4 ----
 arch/arm64/include/asm/kvm_hyp.h       |  7 ++++---
 arch/arm64/kernel/cpu_errata.c         | 25 +++++++++++++++++++------
 arch/arm64/kvm/hyp/switch.c            | 10 +++++-----
 arch/arm64/kvm/hyp/sysreg-sr.c         |  6 ++++--
 arch/arm64/kvm/hyp/tlb.c               | 12 ++++++------
 9 files changed, 60 insertions(+), 29 deletions(-)

-- 
2.20.1

