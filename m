Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C582C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1C8208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556181411;
	bh=sKO69SKwoIX73gzrqqW0AXegBsRggmurdoCBfs0YuSQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=u2e0nqEXH8EzWpk7JvXsqTiA/rDjgCRf2M8FXsylKhQjQMZkjJSuqK05yxt2sR8hP
	 ygXAFTqdbom4aBjn/0Tg7WRYO5FLudCzjhRU7U9S72nPUlgx+9DEdXBLbAQRU9faJt
	 EC1LOiqPDddwfXdfIP9Ia6WbJkJVvMXDUGLZvUHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfDYIgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfDYIgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:36:48 -0400
Received: from localhost.localdomain (unknown [115.205.64.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78402208E4;
        Thu, 25 Apr 2019 08:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556181407;
        bh=sKO69SKwoIX73gzrqqW0AXegBsRggmurdoCBfs0YuSQ=;
        h=From:To:Cc:Subject:Date:From;
        b=zYtt/XjHJz+NnUm6TooTOGJsYUCeX5zSfCcMETXFrQl0AIsDR/0BrYuRIyftoWiHs
         aPtwKZYZ4pMCzWlv10eXlMrf3NL9yReEKHBPSAswqrvziB8PcMvStb2aaPzD7QB/sp
         pys4F4iz+YuA/sER4Exzu92SfOgnefr6PKuG7lvc=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, ren_guo@c-sky.com
Subject: [GIT PULL] csky fixes for v5.1-rc7
Date:   Thu, 25 Apr 2019 16:36:43 +0800
Message-Id: <1556181403-3881-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:

  Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.1-rc7

for you to fetch changes up to a691f3334d58b833e41d56de1b9820e687edcd78:

  csky/syscall_trace: Fixup return processing flow (2019-04-22 15:55:28 +0800)

----------------------------------------------------------------
arch/csky patches for 5.1-rc7

Here are the patches which made on 5.1-rc6 and all are tested in our
buildroot gitlab CI:
https://gitlab.com/c-sky/buildroot/pipelines/57892579

 - Fixup vdsp&fpu issues in kernel
 - Add dynamic function tracer
 - Use in_syscall & forget_syscall instead of r11_sig
 - Reconstruct signal processing
 - Support dynamic start physical address
 - Fixup wrong update_mmu_cache implementation
 - Support vmlinux bootup with MMU off
 - Use va_pa_offset instead of phys_offset
 - Fixup syscall_trace return processing flow
 - Add perf callchain support
 - Add perf_arch_fetch_caller_regs support
 - Add page fault perf event support
 - Add support for perf registers sampling

----------------------------------------------------------------
Guo Ren (12):
      csky: Fixup vdsp&fpu issues in kernel
      csky/ftrace: Add dynamic function tracer (include graph tracer)
      csky: Update syscall_trace_enter/exit implementation
      csky: Add non-uapi asm/ptrace.h namespace
      csky: Use in_syscall & forget_syscall instead of r11_sig
      csky: Reconstruct signal processing
      csky: Support dynamic start physical address
      csky: Fixup wrong update_mmu_cache implementation
      csky: Support vmlinux bootup with MMU off
      csky: Use va_pa_offset instead of phys_offset
      csky: Fixup compile warning
      csky/syscall_trace: Fixup return processing flow

Jagadeesh Pagadala (1):
      csky: mm/fault.c: Remove duplicate header

Mao Han (4):
      csky: Add perf callchain support
      csky: Add perf_arch_fetch_caller_regs support
      csky: add page fault perf event support
      csky: Add support for perf registers sampling

Masahiro Yamada (1):
      csky: remove redundant generic-y

 arch/csky/Kconfig                      |   7 +-
 arch/csky/Makefile                     |   2 +-
 arch/csky/abiv1/inc/abi/ckmmu.h        |  24 ++-
 arch/csky/abiv1/inc/abi/entry.h        |  41 ++--
 arch/csky/abiv1/inc/abi/regdef.h       |   5 +-
 arch/csky/abiv2/cacheflush.c           |  13 +-
 arch/csky/abiv2/inc/abi/ckmmu.h        |  34 +++-
 arch/csky/abiv2/inc/abi/entry.h        |  87 +++++++--
 arch/csky/abiv2/inc/abi/regdef.h       |   5 +-
 arch/csky/abiv2/mcount.S               |  39 +++-
 arch/csky/abiv2/memmove.S              |   6 +-
 arch/csky/include/asm/Kbuild           |   1 -
 arch/csky/include/asm/ftrace.h         |  18 +-
 arch/csky/include/asm/mmu_context.h    |  17 +-
 arch/csky/include/asm/page.h           |  39 ++--
 arch/csky/include/asm/perf_event.h     |   8 +
 arch/csky/include/asm/ptrace.h         |  41 ++++
 arch/csky/include/asm/syscall.h        |   9 +
 arch/csky/include/asm/thread_info.h    |  27 ++-
 arch/csky/include/asm/unistd.h         |   2 +
 arch/csky/include/uapi/asm/perf_regs.h |  51 +++++
 arch/csky/include/uapi/asm/ptrace.h    |  15 --
 arch/csky/kernel/Makefile              |   2 +
 arch/csky/kernel/atomic.S              |  26 +--
 arch/csky/kernel/entry.S               |  77 +++-----
 arch/csky/kernel/ftrace.c              | 148 +++++++++++++-
 arch/csky/kernel/head.S                |  60 +-----
 arch/csky/kernel/perf_callchain.c      | 119 +++++++++++
 arch/csky/kernel/perf_regs.c           |  40 ++++
 arch/csky/kernel/ptrace.c              |  51 +++--
 arch/csky/kernel/setup.c               |  12 +-
 arch/csky/kernel/signal.c              | 348 +++++++++++++--------------------
 arch/csky/mm/fault.c                   |  15 +-
 scripts/recordmcount.pl                |   3 +
 34 files changed, 890 insertions(+), 502 deletions(-)
 create mode 100644 arch/csky/include/asm/ptrace.h
 create mode 100644 arch/csky/include/uapi/asm/perf_regs.h
 create mode 100644 arch/csky/kernel/perf_callchain.c
 create mode 100644 arch/csky/kernel/perf_regs.c
