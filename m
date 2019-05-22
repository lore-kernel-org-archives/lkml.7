Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA30C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F2C2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfEVNLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:11:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50208 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbfEVNLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:11:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1DB580D;
        Wed, 22 May 2019 06:11:05 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C55F33F575;
        Wed, 22 May 2019 06:11:04 -0700 (PDT)
Date:   Wed, 22 May 2019 14:11:02 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: First round of fixes for -rc2
Message-ID: <20190522131102.GC7876@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc2. The summary is in the tag.

I was actually planning to send these in during the merge window, which
is why the branch is based on top of the previous arm64 pull rather than
-rc1. Unfortunately, due to various goings on, my ability to send
external email has been patchy (no pun intended) but here we are anyway.

I'll probably send some more fixes in later this week, but based on -rc1
to avoid conflicts.

Cheers,

Will

--->8

The following changes since commit b33f908811b7627015238e0dee9baf2b4c9d720d:

  Merge branch 'for-next/perf' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into for-next/core (2019-05-03 10:18:08 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 7a0a93c51799edc45ee57c6cc1679aa94f1e03d5:

  arm64: vdso: Explicitly add build-id option (2019-05-16 11:45:36 +0100)

----------------------------------------------------------------
First round of arm64 fixes for -rc2

- Fix SPE probe failure when backing auxbuf with high-order pages

- Fix handling of DMA allocations from outside of the vmalloc area

- Fix generation of build-id ELF section for vDSO object

- Disable huge I/O mappings if kernel page table dumping is enabled

- A few other minor fixes (comments, kconfig etc)

----------------------------------------------------------------
Christoph Hellwig (1):
      arm64/iommu: handle non-remapped addresses in ->mmap and ->get_sgtable

Hillf Danton (1):
      arm64: assembler: Update comment above cond_yield_neon() macro

Laura Abbott (1):
      arm64: vdso: Explicitly add build-id option

Mark Rutland (1):
      arm64/mm: Inhibit huge-vmap with ptdump

Will Deacon (2):
      drivers/perf: arm_spe: Don't error on high-order pages for aux buf
      arm64: Print physical address of page table base in show_pte()

Yury Norov (1):
      arm64: don't trash config with compat symbol if COMPAT is disabled

 arch/arm64/Kconfig                 |  2 +-
 arch/arm64/include/asm/assembler.h | 11 +++++------
 arch/arm64/kernel/vdso/Makefile    |  4 ++--
 arch/arm64/mm/dma-mapping.c        | 10 ++++++++++
 arch/arm64/mm/fault.c              |  5 +++--
 arch/arm64/mm/mmu.c                | 11 ++++++++---
 drivers/perf/arm_spe_pmu.c         | 10 +---------
 7 files changed, 30 insertions(+), 23 deletions(-)
