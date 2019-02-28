Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B579C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C612218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbfB1Sc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:32:29 -0500
Received: from foss.arm.com ([217.140.101.70]:52828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732645AbfB1Sc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:32:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6BBBEBD;
        Thu, 28 Feb 2019 10:32:28 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5A523F5C1;
        Thu, 28 Feb 2019 10:32:25 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>
Subject: [PATCH 0/6] ptrace: consolidate PTRACE_SYSEMU handling and add support for arm64
Date:   Thu, 28 Feb 2019 18:32:14 +0000
Message-Id: <20190228183220.15626-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset evolved from the discussion in the thread[0][1]. When we
wanted to add PTRACE_SYSEMU support to ARM64, we thought instead of
duplicating what other architectures like x86 and powerpc have done,
let consolidate the existing support and move it to the core as there's
nothing arch specific in it.

So this is the first attempt to the same.

Regards,
Sudeep

[0] https://patchwork.kernel.org/patch/10585505/
[1] https://patchwork.kernel.org/patch/10675237/

Sudeep Holla (6):
  ptrace: move clearing of TIF_SYSCALL_EMU flag to core
  ptrace: introduce ptrace_syscall_enter to consolidate PTRACE_SYSEMU handling
  x86: clean up _TIF_SYSCALL_EMU handling using ptrace_syscall_enter hook
  powerpc: use common ptrace_syscall_enter hook to handle _TIF_SYSCALL_EMU
  arm64: add PTRACE_SYSEMU{,SINGLESTEP} definations to uapi headers
  arm64: ptrace: add support for syscall emulation

 arch/arm64/include/asm/thread_info.h |  5 ++-
 arch/arm64/include/uapi/asm/ptrace.h |  3 ++
 arch/arm64/kernel/ptrace.c           |  3 ++
 arch/powerpc/kernel/ptrace.c         | 51 ++++++++++++----------------
 arch/x86/entry/common.c              | 22 +++---------
 arch/x86/kernel/ptrace.c             |  3 --
 include/linux/ptrace.h               |  1 +
 kernel/ptrace.c                      | 20 +++++++++++
 8 files changed, 57 insertions(+), 51 deletions(-)

--
2.17.1

