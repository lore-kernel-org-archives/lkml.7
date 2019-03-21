Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC84F21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfCURiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:38:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60616 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728057AbfCURiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:38:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45215374;
        Thu, 21 Mar 2019 10:38:22 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59B143F614;
        Thu, 21 Mar 2019 10:38:21 -0700 (PDT)
Date:   Thu, 21 Mar 2019 17:38:18 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 5.1-rc2
Message-ID: <20190321173817.GA62913@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 changes below. It's mostly fixes apart from the
kprobe blacklist checking which was deferred because of conflicting with
a fix merged after I pinned the arm64 for-next/core branch (f2b3d8566d81
"arm64: kprobe: Always blacklist the KVM world-switch code").

Thanks.

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to e5a5af7718610c819c4d368bb62655ee43a38011:

  arm64: remove obsolete selection of MULTI_IRQ_HANDLER (2019-03-20 17:34:16 +0000)

----------------------------------------------------------------
- Update the kprobe blacklist checking for arm64. This was supposed to
  be queued during the merging window but, due to conflicts, it was
  deferred post -rc1

- Extend the Fujitsu erratum 010001 workaround to A64FX v1r0

- Whitelist HiSilicon Taishan v110 CPUs as not susceptible to Meltdown

- Export save_stack_trace_regs()

- Remove obsolete selection of MULTI_IRQ_HANDLER

----------------------------------------------------------------
Hanjun Guo (2):
      arm64: Add MIDR encoding for HiSilicon Taishan CPUs
      arm64: kpti: Whitelist HiSilicon Taishan v110 CPUs

Mark Rutland (1):
      arm64: apply workaround on A64FX v1r0

Masami Hiramatsu (4):
      arm64: kprobes: Move extable address check into arch_prepare_kprobe()
      arm64: kprobes: Remove unneeded RODATA check
      arm64: kprobes: Move exception_text check in blacklist
      arm64: kprobes: Use arch_populate_kprobe_blacklist()

Matthias Kaehlcke (1):
      arm64: remove obsolete selection of MULTI_IRQ_HANDLER

William Cohen (1):
      arm64/stacktrace: Export save_stack_trace_regs()

 arch/arm64/Kconfig                 |  1 -
 arch/arm64/include/asm/cputype.h   |  6 +++-
 arch/arm64/kernel/cpufeature.c     |  1 +
 arch/arm64/kernel/probes/kprobes.c | 56 +++++++++++++++++++++-----------------
 arch/arm64/kernel/stacktrace.c     |  1 +
 5 files changed, 38 insertions(+), 27 deletions(-)

-- 
Catalin
