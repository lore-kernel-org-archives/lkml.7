Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF5AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B4120B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570627860;
	bh=/HdBuM/fHpfcdCZ+FTKsq5rOtzOpsqFW2HoiNYpZgOo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Esb2k4o3VfB0ZzXqS/FvvWtxZn1wnKx6TnCaiFKvJm8Xm4hDGCKCOrXdvG9Zgz1Qe
	 j5OKxn9vga1tktUUhWhN4TrSlSFi8RgymX/G4hBlZ/fyjZpWA7fLQpQkhmpOUa2l0k
	 r3gGKcXFxKYFkRIy23d481XJuIfyVmz3wns7p7uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfJINa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731130AbfJINa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:30:58 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12AC2206B6;
        Wed,  9 Oct 2019 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570627857;
        bh=/HdBuM/fHpfcdCZ+FTKsq5rOtzOpsqFW2HoiNYpZgOo=;
        h=Date:From:To:Cc:Subject:From;
        b=QT9XQx3/NbySoKkK61wy4Vocs1BkRfFOuaynRTwnnzGigHm+XSN8OW6KYDfca/RS5
         sOkaSO6Ul6vvwgnwdu+7hpYCCxfTVwDE9pddjBVOlZSWPSj72KT87CVl6YNc28R51V
         xvCFMoD/OhzjSnT5ddBu8sZWYY8BmI6RzxpyULCA=
Date:   Wed, 9 Oct 2019 14:30:54 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] arm64: Fixes for -rc3
Message-ID: <20191009133053.p7bxzkub32x3mclb@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a larger-than-usual batch of arm64 fixes for -rc3. The bulk of
the fixes are dealing with a bunch of issues with the build system from
the compat vDSO, which unfortunately led to some significant Makefile
rework to manage the horrible combinations of toolchains that we can end
up needing to drive simultaneously. We came close to disabling the thing
entirely, but Vincenzo was quick to spin up some patches and I ended up
picking up most of the bits that were left. Future work will look at
disentangling the header files properly.

My subsequent vDSO fixes were:

	Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
	Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

but they were already in linux-next by then and I didn't want to rebase,
so hopefully you can just include those in the merge commit.

Other than that, we have some important fixes all over, including one
papering over the miscompilation fallout from forcing
CONFIG_OPTIMIZE_INLINING=y, which I'm still unhappy about. Harumph.

We've still got a couple of open issues, so I'm expecting to have some
more fixes later this cycle.

Thanks, and please pull.

Will

--->8

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 3e7c93bd04edfb0cae7dad1215544c9350254b8f:

  arm64: armv8_deprecated: Checking return value for memory allocation (2019-10-08 13:34:04 +0100)

----------------------------------------------------------------
arm64 fixes for -rc3

- Numerous fixes to the compat vDSO build system, especially when
  combining gcc and clang

- Fix parsing of PAR_EL1 in spurious kernel fault detection

- Partial workaround for Neoverse-N1 erratum #1542419

- Fix IRQ priority masking on entry from compat syscalls

- Fix advertisment of FRINT HWCAP to userspace

- Attempt to workaround inlining breakage with '__always_inline'

- Fix accidental freeing of parent SVE state on fork() error path

- Add some missing NULL pointer checks in instruction emulation init

- Some formatting and comment fixes

----------------------------------------------------------------
Adam Zerella (1):
      docs: arm64: Fix indentation and doc formatting

James Morse (2):
      arm64: Fix incorrect irqflag restore for priority masking for compat
      arm64: ftrace: Ensure synchronisation in PLT setup for Neoverse-N1 #1542419

Julien Grall (1):
      arm64: cpufeature: Effectively expose FRINT capability to userspace

Mark Rutland (2):
      arm64: mm: avoid virt_to_phys(init_mm.pgd)
      arm64: mm: fix spurious fault detection

Masayoshi Mizuma (1):
      arm64/sve: Fix wrong free for task->thread.sve_state

Thierry Reding (1):
      arm64: errata: Update stale comment

Vincenzo Frascino (5):
      arm64: vdso32: Fix broken compat vDSO build warnings
      arm64: vdso: Remove stale files from old assembly implementation
      arm64: vdso32: Detect binutils support for dmb ishld
      arm64: vdso32: Remove jump label config option in Makefile
      lib: vdso: Remove CROSS_COMPILE_COMPAT_VDSO

Will Deacon (7):
      arm64: Mark functions using explicit register variables as '__always_inline'
      arm64: Default to building compat vDSO with clang when CONFIG_CC_IS_CLANG
      arm64: vdso32: Move definition of COMPATCC into vdso32/Makefile
      arm64: vdso32: Don't use KBUILD_CPPFLAGS unconditionally
      arm64: vdso32: Pass '--target' option to clang via VDSO_CAFLAGS
      arm64: vdso32: Rename COMPATCC to CC_COMPAT
      arm64: Kconfig: Make CONFIG_COMPAT_VDSO a proper Kconfig option

Yunfeng Ye (1):
      arm64: armv8_deprecated: Checking return value for memory allocation

 Documentation/arm64/memory.rst               |  9 +++++-
 arch/arm64/Kconfig                           | 15 ++++++++--
 arch/arm64/Makefile                          | 16 ----------
 arch/arm64/include/asm/atomic_lse.h          |  6 ++--
 arch/arm64/include/asm/vdso/compat_barrier.h |  2 +-
 arch/arm64/include/asm/vdso_datapage.h       | 33 ---------------------
 arch/arm64/kernel/armv8_deprecated.c         |  5 ++++
 arch/arm64/kernel/cpu_errata.c               |  4 +--
 arch/arm64/kernel/cpufeature.c               |  1 +
 arch/arm64/kernel/entry.S                    |  1 +
 arch/arm64/kernel/ftrace.c                   | 12 ++++++--
 arch/arm64/kernel/process.c                  | 32 ++++++++++----------
 arch/arm64/kernel/vdso/gettimeofday.S        |  0
 arch/arm64/kernel/vdso32/Makefile            | 44 ++++++++++++++++++----------
 arch/arm64/mm/fault.c                        | 13 ++++++--
 lib/vdso/Kconfig                             |  9 ------
 16 files changed, 98 insertions(+), 104 deletions(-)
 delete mode 100644 arch/arm64/include/asm/vdso_datapage.h
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S
