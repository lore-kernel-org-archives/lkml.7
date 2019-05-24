Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777D7C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC6D20879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfEXRoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:44:02 -0400
Received: from foss.arm.com ([217.140.101.70]:47798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfEXRoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:44:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49D1EA78;
        Fri, 24 May 2019 10:44:01 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 389A73F703;
        Fri, 24 May 2019 10:44:00 -0700 (PDT)
Date:   Fri, 24 May 2019 18:43:57 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, lorenzo.pieralisi@arm.com
Subject: [GIT PULL] arm64: Second round of fixes for -rc2
Message-ID: <20190524174357.GC9120@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As promised, here's the second round of arm64 fixes for -rc2, based on
-rc1. Details in the tag. The ACPI/IORT build fix is pretty big in the
diffstat, but it's really just the result of code movement to ensure
that the functions are guarded correctly when !CONFIG_IOMMU_SUPPORT.

Please pull.

Cheers,

Will

--->8

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to edbcf50eb8aea5f81ae6d83bb969cb0bc02805a1:

  arm64: insn: Add BUILD_BUG_ON() for invalid masks (2019-05-24 14:58:30 +0100)

----------------------------------------------------------------
Second round of arm64 fixes for -rc2

- Fix incorrect LDADD instruction encoding in our disassembly macros

- Disable the broken ARM64_PSEUDO_NMI support for now

- Add workaround for Cortex-A76 CPU erratum #1463225

- Handle Cortex-A76/Neoverse-N1 erratum #1418040 w/ existing workaround

- Fix IORT build failure if IOMMU_SUPPORT=n

- Fix place-relative module relocation range checking and its
  interaction with KASLR

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64/kernel: kaslr: reduce module randomization range to 2 GB
      arm64/module: deal with ambiguity in PRELxx relocation ranges

Jean-Philippe Brucker (2):
      arm64: insn: Fix ldadd instruction encoding
      arm64: insn: Add BUILD_BUG_ON() for invalid masks

Lorenzo Pieralisi (1):
      ACPI/IORT: Fix build error when IOMMU_SUPPORT is disabled

Marc Zyngier (1):
      arm64: Handle erratum 1418040 as a superset of erratum 1188873

Will Deacon (3):
      arm64: Remove useless message during oops
      arm64: errata: Add workaround for Cortex-A76 erratum #1463225
      arm64: Kconfig: Make ARM64_PSEUDO_NMI depend on BROKEN for now

 Documentation/arm64/silicon-errata.txt |   9 +-
 arch/arm64/Kconfig                     |  26 +++-
 arch/arm64/include/asm/cpucaps.h       |   5 +-
 arch/arm64/include/asm/insn.h          |  18 ++-
 arch/arm64/kernel/cpu_errata.c         |  48 +++++--
 arch/arm64/kernel/entry.S              |   4 +-
 arch/arm64/kernel/kaslr.c              |   6 +-
 arch/arm64/kernel/module.c             |  18 ++-
 arch/arm64/kernel/syscall.c            |  31 +++++
 arch/arm64/kernel/traps.c              |   4 -
 arch/arm64/mm/fault.c                  |  33 +++++
 drivers/acpi/arm64/iort.c              | 238 +++++++++++++++++----------------
 12 files changed, 284 insertions(+), 156 deletions(-)
