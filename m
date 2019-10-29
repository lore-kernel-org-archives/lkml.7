Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F581CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC7020679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 16:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390602AbfJ2Q6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 12:58:40 -0400
Received: from foss.arm.com ([217.140.110.172]:54534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbfJ2Q6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 12:58:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69F571F1;
        Tue, 29 Oct 2019 09:58:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15EBE3F71F;
        Tue, 29 Oct 2019 09:58:36 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        James.Bottomley@HansenPartnership.com, james.morse@arm.com,
        jeyu@kernel.org, jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: [PATCHv2 0/8] arm64: ftrace cleanup + FTRACE_WITH_REGS
Date:   Tue, 29 Oct 2019 16:58:24 +0000
Message-Id: <20191029165832.33606-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series is a reworked version of Torsten's FTRACE_WITH_REGS series
[1]. I've tried to rework the existing code in preparatory patches so
that the patchable-function-entry bits slot in with fewer surprises.
This version is based on v5.4-rc3, and can be found in my
arm64/ftrace-with-regs branch [2].

Patch 1 adds an (optional) ftrace_init_nop(), which the core code uses
to initialize callsites. This allows us to avoid a synthetic MCOUNT_ADDR
symbol, and more cleanly separates the one-time initialization of the
callsite from dynamic NOP<->CALL modification. Architectures which don't
implement this get the existing ftrace_make_nop() with MCOUNT_ADDR.

Recently parisc gained ftrace support using patchable-function-entry.
Patch 2 makes the handling of module callsite locations common in
kernel/module.c with a new FTRACE_CALLSITE_SECTION definition, and
removed the newly redundant bits from arch/parisc.

Patches 3 and 4 move the module PLT initialization to module load time,
which simplifies runtime callsite modification. This also means that we
don't transitently mark the module text RW, and will allow for the
removal of module_disable_ro().

Patches 5 and 6 add some trivial infrastructure, with patch 7 finally
adding FTRACE_WITH_REGS support. Additional work will be required for
livepatching (e.g. implementing reliable stack trace), which is
commented as part of patch 7.

Patch 8 is a trivial cleanup atop of the rest of the series, making the
code easier to read and less susceptible to config-specific breakage.

Since v1 [3]:
* Add a couple of people to Cc
* Fold in Ard's Reviewed-by tag
* Rename ftrace_code_init_disabled() to ftrace_nop_initialize()
* Move ftrace_init_nop() to <linux/ftrace.h>, with kerneldoc
* Update kerneldoc for rec parameters

Thanks,
Mark.

[1] https://lore.kernel.org/r/20190208150826.44EBC68DD2@newverein.lst.de
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace-with-regs
[3] https://lore.kernel.org/r/20191021163426.9408-1-mark.rutland@arm.com

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
 include/linux/ftrace.h           |  40 ++++++++++-
 kernel/module.c                  |   2 +-
 kernel/trace/ftrace.c            |   6 +-
 17 files changed, 355 insertions(+), 83 deletions(-)
 delete mode 100644 arch/parisc/kernel/module.lds

-- 
2.11.0

