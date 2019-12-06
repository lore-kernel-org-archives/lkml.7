Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B736C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EDE2064B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfLFPqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:46:08 -0500
Received: from foss.arm.com ([217.140.110.172]:48494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfLFPqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:46:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95C531B;
        Fri,  6 Dec 2019 07:46:06 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25AB03F718;
        Fri,  6 Dec 2019 07:46:06 -0800 (PST)
Date:   Fri, 6 Dec 2019 15:46:04 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.5-rc1
Message-ID: <20191206154602.GA53116@arrakis.emea.arm.com>
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

The following changes since commit d8e85e144bbe12e8d82c6b05d690a34da62cc991:

  arm64: Kconfig: add a choice for endianness (2019-11-14 14:39:03 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to de858040ee80e6f41bf0b40090f1c71f966a61b3:

  arm64: entry: refine comment of stack overflow check (2019-12-06 14:11:31 +0000)

----------------------------------------------------------------
arm64 updates for 5.5:

- ZONE_DMA32 initialisation fix when memblocks fall entirely within the
  first GB (used by ZONE_DMA in 5.5 for Raspberry Pi 4).

- Couple of ftrace fixes following the FTRACE_WITH_REGS patchset.

- access_ok() fix for the Tagged Address ABI when called from from a
  kernel thread (asynchronous I/O): the kthread does not have the TIF
  flags of the mm owner, so untag the user address unconditionally.

- KVM compute_layout() called before the alternatives code patching.

- Minor clean-ups.

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Validate tagged addresses in access_ok() called from kernel threads

Heyi Guo (1):
      arm64: entry: refine comment of stack overflow check

Mark Brown (1):
      arm64: mm: Fix column alignment for UXN in kernel_page_tables

Mark Rutland (2):
      arm64: insn: consistently handle exit text
      arm64: ftrace: fix ifdeffery

Sebastian Andrzej Siewior (1):
      arm64: KVM: Invoke compute_layout() before alternatives are applied

Will Deacon (1):
      arm64: mm: Fix initialisation of DMA zones on non-NUMA systems

 arch/arm64/include/asm/kvm_mmu.h  |  1 +
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/include/asm/uaccess.h  |  7 ++++++-
 arch/arm64/kernel/entry-ftrace.S  |  3 +--
 arch/arm64/kernel/entry.S         |  3 ++-
 arch/arm64/kernel/insn.c          | 22 ++++++++++++++++++----
 arch/arm64/kernel/smp.c           |  4 ++++
 arch/arm64/kernel/vmlinux.lds.S   |  3 +++
 arch/arm64/kvm/va_layout.c        |  8 +-------
 arch/arm64/mm/dump.c              |  1 +
 arch/arm64/mm/init.c              | 25 +++++++++++--------------
 11 files changed, 49 insertions(+), 29 deletions(-)

-- 
Catalin
