Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B1DCA9EC8
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 23:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BBF21D80
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 23:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571355835;
	bh=0EcaWaedR8Ckg+AhTfjvMemxm+9X5GNiQRm9Lmclzcw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=yOFhCpwwR6aZ2cxxkybVz5P5UsUWGiNTCXG5HacKge99pAt2OAGZWzVQt/cL48U7f
	 z4Jg/Gm+2PQOFOr77WR1fUgKya2iBBA2+atuvTxDlI8veSaOhRIMylKrKNw9mM0Y0g
	 RcmV6AjHtDmZHtGqa2vWAFuA5iuSr3wUbJ17L0vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441803AbfJQXny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 19:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732678AbfJQXnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 19:43:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A94C21D7A;
        Thu, 17 Oct 2019 23:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571355833;
        bh=0EcaWaedR8Ckg+AhTfjvMemxm+9X5GNiQRm9Lmclzcw=;
        h=Date:From:To:Cc:Subject:From;
        b=oslJZmmo5xyVYMHQM/H+3KnxSZ2knfk1fGOUYQ2WjOPbi92IpUtaKxPApI0o8OjgJ
         TneDFARiK9K6jQfpHAnsGUvEdLOlIe9zNf/9cxYIq+nM67FXpKlsvvpgwc0Re0290h
         IeqwsyMj5gf4A79SIBcafOUpyk7sM9nM2n1p2Kxs=
Date:   Fri, 18 Oct 2019 00:43:49 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>
Subject: [GIT PULL] arm64: Fixes for -rc4
Message-ID: <20191017234348.wcbbo2njexn7ixpk@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc4. The main thing here is a
long-awaited workaround for a CPU erratum on ThunderX2 which we have
developed in conjunction with engineers from Cavium/Marvell. At the moment,
the workaround is unconditionally enabled for affected CPUs at runtime
but we may add a command-line option to disable it in future if performance
numbers show up indicating a significant cost for real workloads.

The other fixes are summarised in the tag.

Note that the workaround code ended up being based on -rc2, so I had a
bit of a faff trying to generate the right diffstat for this pull request
after merging that branch into our fixes branch based on -rc1. In the end
I had to emulate the pull locally because I couldn't figure out how to
drive request-pull correctly despite the shortlog being correct. I'd love
to know what I should've done instead.

Thanks,

Will

--->8

The following changes since commit 3e7c93bd04edfb0cae7dad1215544c9350254b8f:

  arm64: armv8_deprecated: Checking return value for memory allocation (2019-10-08 13:34:04 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 777d062e5bee0e3c0751cdcbce116a76ee2310ec:

  Merge branch 'errata/tx2-219' into for-next/fixes (2019-10-17 13:42:42 -0700)

----------------------------------------------------------------
arm64 fixes for -rc4

- Work around Cavium/Marvell ThunderX2 erratum #219

- Fix regression in mlock() ABI caused by sign-extension of TTBR1 addresses

- More fixes to the spurious kernel fault detection logic

- Fix pathological preemption race when enabling some CPU features at boot

- Drop broken kcore macros in favour of generic implementations

- Fix userspace view of ID_AA64ZFR0_EL1 when SVE is disabled

- Avoid NULL dereference on allocation failure during hibernation

----------------------------------------------------------------
Chris von Recklinghausen (1):
      arm64: Fix kcore macros after 52-bit virtual addressing fallout

Julien Grall (1):
      arm64: cpufeature: Treat ID_AA64ZFR0_EL1 as RAZ when SVE is not enabled

Julien Thierry (1):
      arm64: entry.S: Do not preempt from IRQ before all cpufeatures are enabled

Marc Zyngier (4):
      arm64: KVM: Trap VM ops when ARM64_WORKAROUND_CAVIUM_TX2_219_TVM is set
      arm64: Enable workaround for Cavium TX2 erratum 219 when running SMT
      arm64: Avoid Cavium TX2 erratum 219 when switching TTBR
      arm64: Allow CAVIUM_TX2_ERRATUM_219 to be selected

Mark Rutland (1):
      arm64: mm: fix inverted PAR_EL1.F check

Pavel Tatashin (1):
      arm64: hibernate: check pgd table allocation

Will Deacon (2):
      arm64: tags: Preserve tags for addresses translated via TTBR1
      Merge branch 'errata/tx2-219' into for-next/fixes

Yang Yingliang (1):
      arm64: sysreg: fix incorrect definition of SYS_PAR_EL1_F

 Documentation/arm64/silicon-errata.rst |  2 +
 arch/arm64/Kconfig                     | 17 +++++++++
 arch/arm64/include/asm/asm-uaccess.h   |  7 ++--
 arch/arm64/include/asm/cpucaps.h       |  4 +-
 arch/arm64/include/asm/memory.h        | 10 ++++-
 arch/arm64/include/asm/pgtable.h       |  3 --
 arch/arm64/include/asm/sysreg.h        |  2 +-
 arch/arm64/kernel/cpu_errata.c         | 38 +++++++++++++++++++
 arch/arm64/kernel/cpufeature.c         | 15 +++++---
 arch/arm64/kernel/entry.S              |  8 ++--
 arch/arm64/kernel/hibernate.c          |  9 ++++-
 arch/arm64/kernel/process.c            | 18 +++++++++
 arch/arm64/kvm/hyp/switch.c            | 69 +++++++++++++++++++++++++++++++++-
 arch/arm64/mm/fault.c                  |  6 ++-
 include/linux/sched.h                  |  1 +
 15 files changed, 186 insertions(+), 23 deletions(-)
