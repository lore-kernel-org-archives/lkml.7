Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACAAC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D74C22ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564146742;
	bh=lS7VU+fYLf9p8y4UAb/u0BkVPuztI5yiv146UfxCQDM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ni2x6X1c466YS9WAg12/iQtAv5KF41xsNz8KKh0fXyq/j/8Z+7ER4PwkMkMfBkyKh
	 LF9LHgTrKWkSDbGDG2yzbYPdb6ZIBZVJ1aIdcpKVqoMCJMQfJl9tvuatydGytb2eNB
	 nMRNHdOtIv5Ou/JPeR8A/kiVnpB8A9w5eixFMQ9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfGZNMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfGZNMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:12:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AA5F218D4;
        Fri, 26 Jul 2019 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564146740;
        bh=lS7VU+fYLf9p8y4UAb/u0BkVPuztI5yiv146UfxCQDM=;
        h=Date:From:To:Cc:Subject:From;
        b=HeI8QMV5ptqPEjWImZK/G7ljfbzJwNqBuLFsieHmWMcqdpaYdl2UtrBms5Lh5GX8C
         3X+EuxET8Bu0ofRypSvw5Ag9692Un3I0nSMkS/9nfNLKduqv5rGCu6F7a6VdMxx8i7
         yqIeRc3KFTvVuU3p3DRZQ4yMz+SaUS9WbCopSzhk=
Date:   Fri, 26 Jul 2019 14:12:16 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] arm64: fixes for -rc2
Message-ID: <20190726131215.2dqryzjvxfyqefuw@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc2. There's more here than we usually
have at this stage, but that's mainly down to the stacktrace changes which
came in slightly too late for the merge window.

Summary is in the tag.

Thanks,

Will

--->8

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 5a46d3f71d5e5a9f82eabc682f996f1281705ac7:

  ACPI/IORT: Fix off-by-one check in iort_dev_find_its_id() (2019-07-23 15:45:46 +0100)

----------------------------------------------------------------
arm64 fixes for -rc2

- Big bad batch of MAINTAINERS updates

- Fix handling of SP alignment fault exceptions

- Fix PSTATE.SSBS handling on heterogeneous systems

- Fix fallout from moving to the generic vDSO implementation

- Fix stack unwinding in the face of frame corruption

- Fix off-by-one in IORT code

- Minor SVE cleanups

----------------------------------------------------------------
Anshuman Khandual (1):
      arm64: mm: Drop pte_huge()

Dave Martin (4):
      arm64: stacktrace: Constify stacktrace.h functions
      arm64: stacktrace: Factor out backtrace initialisation
      arm64/sve: Factor out FPSIMD to SVE state conversion
      arm64/sve: Fix a couple of magic numbers for the Z-reg count

James Morse (1):
      arm64: entry: SP Alignment Fault doesn't write to FAR_EL1

Jean-Philippe Brucker (1):
      MAINTAINERS: Update my email address

Julien Thierry (1):
      MAINTAINERS: Update my email address

Lorenzo Pieralisi (1):
      ACPI/IORT: Fix off-by-one check in iort_dev_find_its_id()

Marc Zyngier (2):
      MAINTAINERS: Update my email address to @kernel.org
      arm64: Force SSBS on context switch

Mark Rutland (1):
      arm64: stacktrace: Better handle corrupted stacks

Naohiro Aota (1):
      arm64: vdso: fix flip/flop vdso build bug

Suzuki K Poulose (1):
      MAINTAINERS: Fix spelling mistake in my name

Vincenzo Frascino (2):
      arm64: vdso: Fix population of AT_SYSINFO_EHDR for compat vdso
      arm64: vdso: Cleanup Makefiles

 .mailmap                            |  3 ++
 MAINTAINERS                         | 14 +++----
 arch/arm64/include/asm/elf.h        |  2 +-
 arch/arm64/include/asm/pgtable.h    |  1 -
 arch/arm64/include/asm/processor.h  | 14 ++++++-
 arch/arm64/include/asm/stacktrace.h | 78 ++++++++++++++++++++++++++++++-------
 arch/arm64/kernel/entry.S           | 22 ++++++-----
 arch/arm64/kernel/fpsimd.c          | 29 +++++++-------
 arch/arm64/kernel/perf_callchain.c  |  7 +---
 arch/arm64/kernel/process.c         | 36 ++++++++++++++---
 arch/arm64/kernel/return_address.c  |  9 ++---
 arch/arm64/kernel/stacktrace.c      | 59 +++++++++++++++++++++-------
 arch/arm64/kernel/time.c            |  7 +---
 arch/arm64/kernel/traps.c           | 13 +++----
 arch/arm64/kernel/vdso/Makefile     | 13 +++----
 arch/arm64/kernel/vdso32/Makefile   | 14 ++++---
 drivers/acpi/arm64/iort.c           |  4 +-
 17 files changed, 219 insertions(+), 106 deletions(-)
