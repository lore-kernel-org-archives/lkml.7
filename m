Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA5ACA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6076222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qgbEQaGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442629AbfJRQKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:10:47 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:53688 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405669AbfJRQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:10:47 -0400
Received: by mail-yw1-f73.google.com with SMTP id x198so4756329ywg.20
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=t+DRDqz67Twe6Iyofi8RQAeNodEvIc7fNPUNsIrBR+w=;
        b=qgbEQaGzHqaPH3cxTJE6CGTvZ+cRjHUHTkYr1B9DStapni7EFSvFnUDWSGPFTm7gwQ
         BQRlnzPOMPn4q93e238qrgFaMvCQf9Spzz7SINiIlVpuYks/Wu8Nwa1QmimiSJxpH3pA
         zXtHmrE7MTXaAB6BLpC8vL3pFXfn9A40pGj+qHFCNXTwD0ywpccoB55v3hYAWCkjkCgv
         t4a0qzeiaiVD3qeEEiRLETv6os7mi6JMjFcZQ7HZ3TsPYfuCCRN07OVVFEBv060hDwM0
         Oe2+l3QRysVBZMWOYZ/v2Sou4QvuVNVoxWjAknk7l6ulOzhXQHgz5ej8/LwC2yX3JfcO
         auvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=t+DRDqz67Twe6Iyofi8RQAeNodEvIc7fNPUNsIrBR+w=;
        b=dq4JxeITAHUK7z1F8381fbek767rLcpWcFZSk2TocAx2rcP0ZAil5O2+48Ks+CarRY
         IQrmOaNeXXMhZF9URy/1T2ZFioGlYNt8VTZRGRXfQeQOUEYNpb3xAmo9BXId0PxXqEUJ
         clvwczDPJ+uAQg68m9Fk9iQzqyLn1dLEqwbXCaygHU06grSGU9kSRH8OMjDuM//VN4rP
         cVQCofyqBEV+D16BFIyfOvbW7azpxH81XQJAhslBZDGs93ovq6fsFHvvxXBIGNGozGFV
         CyZu2Dco8rVyDcf5YCqm50blPkq2aUZ2y52iDP6q/+HGl4uso6ZExaoxaVah32xqIB1D
         GNWQ==
X-Gm-Message-State: APjAAAUk9trpb84/+n+4ABt82Y0uZsqxJRvc78/VlW2wLEQaZQXfVaMs
        Hyi+snPmikns2bd97+H/bJhiKi3S/YUhBukNt/s=
X-Google-Smtp-Source: APXvYqyvgW1/nPqoxtlaKdWfjDEG7KEXwdtGVI7DdMRD1tlwHR6z5N+W9oDyStEa7Ea2uqFWOqGCG100k3GuhoDibZE=
X-Received: by 2002:a25:a324:: with SMTP id d33mr6752834ybi.58.1571415044349;
 Fri, 18 Oct 2019 09:10:44 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:15 -0700
Message-Id: <20191018161033.261971-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 00/18] add support for Clang's Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Clang's Shadow Call Stack (SCS)
mitigation, which uses a separately allocated shadow stack to protect
against return address overwrites. More information can be found here:

  https://clang.llvm.org/docs/ShadowCallStack.html

SCS is currently supported only on arm64, where the compiler requires
the x18 register to be reserved for holding the current task's shadow
stack pointer. Because of this, the series includes four patches from
Ard to remove x18 usage from assembly code and to reserve the register
from general allocation.

With -fsanitize=shadow-call-stack, the compiler injects instructions
to all non-leaf C functions to store the return address to the shadow
stack and unconditionally load it again before returning. As a result,
SCS is incompatible with features that rely on modifying function
return addresses to alter control flow, such as function graph tracing
and kretprobes. A copy of the return address is still kept in the
kernel stack for compatibility with stack unwinding, for example.

SCS has a minimal performance overhead, but allocating shadow stacks
increases kernel memory usage. The feature is therefore mostly useful
on hardware that lacks support for PAC instructions. This series adds
a ROP protection choice to the kernel configuration, where other
return address protection options can be selected as they are added to
the kernel.


Ard Biesheuvel (4):
  arm64/lib: copy_page: avoid x18 register in assembler code
  arm64: kvm: stop treating register x18 as caller save
  arm64: kernel: avoid x18 as an arbitrary temp register
  arm64: kbuild: reserve reg x18 from general allocation by the compiler

Sami Tolvanen (14):
  arm64: mm: don't use x18 in idmap_kpti_install_ng_mappings
  add support for Clang's Shadow Call Stack (SCS)
  scs: add accounting
  scs: add support for stack usage debugging
  trace: disable function graph tracing with SCS
  kprobes: fix compilation without CONFIG_KRETPROBES
  kprobes: disable kretprobes with SCS
  arm64: reserve x18 only with Shadow Call Stack
  arm64: preserve x18 when CPU is suspended
  arm64: efi: restore x18 if it was corrupted
  arm64: vdso: disable Shadow Call Stack
  arm64: kprobes: fix kprobes without CONFIG_KRETPROBES
  arm64: disable SCS for hypervisor code
  arm64: implement Shadow Call Stack

 Makefile                             |   6 +
 arch/Kconfig                         |  41 ++++-
 arch/arm64/Kconfig                   |   1 +
 arch/arm64/Makefile                  |   4 +
 arch/arm64/include/asm/scs.h         |  60 ++++++++
 arch/arm64/include/asm/stacktrace.h  |   4 +
 arch/arm64/include/asm/thread_info.h |   3 +
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/asm-offsets.c      |   3 +
 arch/arm64/kernel/cpu-reset.S        |   4 +-
 arch/arm64/kernel/efi-rt-wrapper.S   |   7 +-
 arch/arm64/kernel/entry.S            |  23 +++
 arch/arm64/kernel/head.S             |   9 ++
 arch/arm64/kernel/irq.c              |   2 +
 arch/arm64/kernel/probes/kprobes.c   |   2 +
 arch/arm64/kernel/process.c          |   3 +
 arch/arm64/kernel/scs.c              |  39 +++++
 arch/arm64/kernel/smp.c              |   4 +
 arch/arm64/kernel/vdso/Makefile      |   2 +-
 arch/arm64/kvm/hyp/Makefile          |   3 +-
 arch/arm64/kvm/hyp/entry.S           |  12 +-
 arch/arm64/lib/copy_page.S           |  38 ++---
 arch/arm64/mm/proc.S                 |  69 +++++----
 drivers/base/node.c                  |   6 +
 fs/proc/meminfo.c                    |   4 +
 include/linux/compiler-clang.h       |   2 +
 include/linux/compiler_types.h       |   4 +
 include/linux/mmzone.h               |   3 +
 include/linux/scs.h                  |  88 +++++++++++
 init/init_task.c                     |   6 +
 init/main.c                          |   3 +
 kernel/Makefile                      |   1 +
 kernel/fork.c                        |   9 ++
 kernel/kprobes.c                     |  38 ++---
 kernel/sched/core.c                  |   2 +
 kernel/sched/sched.h                 |   1 +
 kernel/scs.c                         | 221 +++++++++++++++++++++++++++
 kernel/trace/Kconfig                 |   1 +
 mm/page_alloc.c                      |   6 +
 mm/vmstat.c                          |   3 +
 40 files changed, 656 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm64/include/asm/scs.h
 create mode 100644 arch/arm64/kernel/scs.c
 create mode 100644 include/linux/scs.h
 create mode 100644 kernel/scs.c

-- 
2.23.0.866.gb869b98d4c-goog

