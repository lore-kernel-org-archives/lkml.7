Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94214CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EBD217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfJUQe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:34:57 -0400
Received: from [217.140.110.172] ([217.140.110.172]:57502 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUQe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:34:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6A8E46A;
        Mon, 21 Oct 2019 09:34:33 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 99E3E3F71F;
        Mon, 21 Oct 2019 09:34:31 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     amit.kachhap@arm.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, mark.rutland@arm.com, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: [PATCH 0/8] arm64: ftrace cleanup + FTRACE_WITH_REGS
Date:   Mon, 21 Oct 2019 17:34:18 +0100
Message-Id: <20191021163426.9408-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is a reworked version of Torsten's v8 FTRACE_WITH_REGS
series [1]. I've tried to rework the existing code in preparatory
patches so that the patchable-function-entry bits slot in with fewer
surprises. This version is based on v5.4-rc3, and can be found in my
arm64/ftrace-with-regs branch [2].

I've added an (optional) ftrace_init_nop(), which the core code uses to
initialize callsites. This allows us to avoid a synthetic MCOUNT_ADDR
symbol, and more cleanly separates the one-time initialization of the
callsite from dynamic NOP<->CALL modification. Architectures which don't
implement this get the existing ftrace_make_nop() with MCOUNT_ADDR.

I've moved the module PLT initialization to module load time, which
simplifies runtime callsite modification. This also means that we don't
transitently mark the module text RW, and will allow for the removal of
module_disable_ro().

Since the last posting, parisc gained ftrace support using
patchable-function-entry. I've made the handling of module callsite
locations common in kernel/module.c with a new FTRACE_CALLSITE_SECTION
definition, and removed the newly redundant bits from arch/parisc.

Thanks,
Mark.

[1] https://lore.kernel.org/r/20190208150826.44EBC68DD2@newverein.lst.de
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace-with-regs

Mark Rutland (7):
  ftrace: add ftrace_init_nop()
  module/ftrace: handle patchable-function-entry
  arm64: module: rework special section handling
  arm64: module/ftrace: intialize PLT at load time
  arm64: insn: add encoder for MOV (register)
  arm64: asm-offsets: add S_FP
  arm64: ftrace: minimize ifdeffery

Torsten Duwe (1):
  arm64: implement ftrace with regs

 arch/arm64/Kconfig               |   2 +
 arch/arm64/Makefile              |   5 ++
 arch/arm64/include/asm/ftrace.h  |  23 +++++++
 arch/arm64/include/asm/insn.h    |   3 +
 arch/arm64/include/asm/module.h  |   2 +-
 arch/arm64/kernel/asm-offsets.c  |   1 +
 arch/arm64/kernel/entry-ftrace.S | 140 +++++++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/ftrace.c       | 123 ++++++++++++++++++++--------------
 arch/arm64/kernel/insn.c         |  13 ++++
 arch/arm64/kernel/module-plts.c  |   3 +-
 arch/arm64/kernel/module.c       |  57 +++++++++++++---
 arch/parisc/Makefile             |   1 -
 arch/parisc/kernel/module.c      |  10 ++-
 arch/parisc/kernel/module.lds    |   7 --
 include/linux/ftrace.h           |   5 ++
 kernel/module.c                  |   2 +-
 kernel/trace/ftrace.c            |  13 +++-
 17 files changed, 330 insertions(+), 80 deletions(-)
 delete mode 100644 arch/parisc/kernel/module.lds

-- 
2.11.0

