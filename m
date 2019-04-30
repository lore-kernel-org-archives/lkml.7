Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D638C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EF221670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfD3RF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:05:29 -0400
Received: from foss.arm.com ([217.140.101.70]:50392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfD3RF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:05:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4319374;
        Tue, 30 Apr 2019 10:05:28 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8655C3F5C1;
        Tue, 30 Apr 2019 10:05:26 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard@nod.at>, jdike@addtoit.com,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 0/4] ptrace: cleanup PTRACE_SYSEMU handling and add support for arm64
Date:   Tue, 30 Apr 2019 18:05:16 +0100
Message-Id: <20190430170520.29470-1-sudeep.holla@arm.com>
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

v2->v3:
	- moved clearing of TIF_SYSCALL_EMU to __ptrace_unlink as Oleg
	  suggested
	- x86 cleanup as per Oleg's suggestion and dropped adding new
	  ptrace_syscall_enter for SYSEMU handling
	  (tested using tools/testing/selftests/x86/ptrace_syscall.c)
	- Updated arm64 handling accordingly

v1->v2:
	- added comment for empty statement after tracehook_report_syscall_entry
	- dropped x86 change in syscall_slow_exit_work as I had ended
	  up changing logic unintentionally
	- removed spurious change in powerpc moving user_exit()

Regards,
Sudeep

[0] https://patchwork.kernel.org/patch/10585505/
[1] https://patchwork.kernel.org/patch/10675237/

Sudeep Holla (4):
  ptrace: move clearing of TIF_SYSCALL_EMU flag to core
  x86: simplify _TIF_SYSCALL_EMU handling
  arm64: add PTRACE_SYSEMU{,SINGLESTEP} definations to uapi headers
  arm64: ptrace: add support for syscall emulation

 arch/arm64/include/asm/thread_info.h |  5 ++++-
 arch/arm64/include/uapi/asm/ptrace.h |  3 +++
 arch/arm64/kernel/ptrace.c           |  6 +++++-
 arch/powerpc/kernel/ptrace.c         |  1 -
 arch/x86/entry/common.c              | 17 ++++++-----------
 arch/x86/kernel/ptrace.c             |  3 ---
 kernel/ptrace.c                      |  3 +++
 7 files changed, 21 insertions(+), 17 deletions(-)

--
2.17.1

