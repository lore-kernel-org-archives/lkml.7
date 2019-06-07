Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD372089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfFGPNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:13:20 -0400
Received: from foss.arm.com ([217.140.110.172]:42346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfFGPNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:13:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE6E0C15;
        Fri,  7 Jun 2019 08:13:19 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 081593F718;
        Fri,  7 Jun 2019 08:13:18 -0700 (PDT)
Date:   Fri, 7 Jun 2019 16:13:16 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: [GIT PULL] arm64: fixes for -rc4
Message-ID: <20190607151316.GB19862@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another round of mostly-benign fixes, the exception being a boot crash on
SVE2-capable CPUs (although I don't know where you'd find such a thing, so
maybe it's benign too). We're in the process of resolving some big-endian
ptrace breakage, so I'll probably have some more for you next week.

Please pull.

Cheers,

Will

--->8

The following changes since commit 1e29ab3186e33c77dbb2d7566172a205b59fa390:

  arm64: use the correct function type for __arm64_sys_ni_syscall (2019-05-29 13:46:00 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to ebcc5928c5d925b1c8d968d9c89cdb0d0186db17:

  arm64: Silence gcc warnings about arch ABI drift (2019-06-06 13:28:45 +0100)

----------------------------------------------------------------
arm64 fixes for -rc4

- Fix boot crash on platforms with SVE2 due to missing register encoding

- Fix architected timer accessors when CONFIG_OPTIMIZE_INLINING=y

- Move cpu_logical_map into smp.h for use by upcoming irqchip drivers

- Trivial typo fix in comment

- Disable some useless, noisy warnings from GCC 9

----------------------------------------------------------------
Anders Roxell (1):
      arm64: arch_timer: mark functions as __always_inline

Dave Martin (2):
      arm64: cpufeature: Fix missing ZFR0 in __read_sysreg_by_encoding()
      arm64: Silence gcc warnings about arch ABI drift

Florian Fainelli (1):
      arm64: smp: Moved cpu_logical_map[] to smp.h

George G. Davis (1):
      ARM64: trivial: s/TIF_SECOMP/TIF_SECCOMP/ comment typo fix

 arch/arm64/Makefile                  | 1 +
 arch/arm64/include/asm/arch_timer.h  | 8 ++++----
 arch/arm64/include/asm/smp.h         | 6 ++++++
 arch/arm64/include/asm/smp_plat.h    | 5 -----
 arch/arm64/include/asm/thread_info.h | 2 +-
 arch/arm64/kernel/cpufeature.c       | 1 +
 6 files changed, 13 insertions(+), 10 deletions(-)
