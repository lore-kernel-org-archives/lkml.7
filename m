Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097A5CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A832190F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X72pCBme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfJaQqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:46:48 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50720 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbfJaQqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:46:46 -0400
Received: by mail-pf1-f202.google.com with SMTP id x15so2199045pfi.17
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VJW4EixJ7eoVvGoW8WXB816KDrFUl4nwPba/L9J0fDM=;
        b=X72pCBmeu6KNeTcEZs/HbzCF3sDrWvAyivdNVRvS3VrtS/eW+94zqgHgR+xACKsx2l
         IC7BZebQB1kM8OaIdthHJvaTnXpdESiVK51g2vca/ejvSau2zKoF6zHNEj6ayclvX8Q1
         0E8O8U2gqyQKM+wO+LwOK1nrC8kXR39u0eY6bPjpl46S90zRR0EYGAxExeEZqELG0bTT
         2JMXQ0B5DcxiiehhQNhDYgQxy+Az2OiSw/2+1zKsmA+lkXmRmb5uSYLgrJnsxGNK0vuV
         MRtztHQTOSEh9H4fwBMfwZyJMgn8dUDLwcVKd45EdzK3pl/rwxqb7rGV7DeDmqeSm7Em
         OVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VJW4EixJ7eoVvGoW8WXB816KDrFUl4nwPba/L9J0fDM=;
        b=Qdpk05bV7hw/z1w0D8EhEiCsc/9OOQjh666wrOTP/gLvPbXJJ4riSWZK0n/RGO3M1l
         bo78+yDkwpWCTlUuCDhw0X8EeArTrd9vOStaw/qJzCDYF63LcCYZJWm8Jftcm3xdhd17
         4hQcqsOTjcpbOhpekNKGKKL9Dzi1H26dzC7uAssC3daEq7MNvz1nv1gx+j5hgVSurcir
         Z+I6TOtoFhilFjEThmYqC4VXt5qAehxOtslcYnH6dstBgS552/flP4/fKDHMfgeIdWU1
         7a37UU00qn9cVEaVNpXfel5JWeq1UfV77tOjS5fsdIyqLRpBzl5yaxTzHS7bu4WWfU19
         3hhQ==
X-Gm-Message-State: APjAAAXRJ0TuVTG+x/0yJZ1qpHqgmGX3ER1uZvfQZpy8ARuiuJBCpXNI
        Tuq6zFD5ib8y85Pe6EUZi6dT8trx44NkG7CLEyI=
X-Google-Smtp-Source: APXvYqwNtkBpFip8q81bGhg0CvAnPTQnrqxcNvMaBe34ClJ/Yd2hlu2ZC+yn6qs00bEmTkl5AXHyjpx+Oa61GiD4Q6Q=
X-Received: by 2002:a63:b95e:: with SMTP id v30mr7752425pgo.206.1572540403625;
 Thu, 31 Oct 2019 09:46:43 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:20 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-1-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 00/17] add support for Clang's Shadow Call Stack
From:   samitolvanen@google.com
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Clang's Shadow Call Stack
(SCS) mitigation, which uses a separately allocated shadow stack
to protect against return address overwrites. More information
can be found here:

  https://clang.llvm.org/docs/ShadowCallStack.html

SCS provides better protection against traditional buffer
overflows than CONFIG_STACKPROTECTOR_*, but it should be noted
that SCS security guarantees in the kernel differ from the ones
documented for user space. The kernel must store addresses of
shadow stacks used by other tasks and interrupt handlers in
memory, which means an attacker capable reading and writing
arbitrary memory may be able to locate them and hijack control
flow by modifying shadow stacks that are not currently in use.

SCS is currently supported only on arm64, where the compiler
requires the x18 register to be reserved for holding the current
task's shadow stack pointer. Because of this, the series includes
patches from Ard to remove x18 usage from assembly code.

With -fsanitize=shadow-call-stack, the compiler injects
instructions to all non-leaf C functions to store the return
address to the shadow stack, and unconditionally load it again
before returning. As a result, SCS is currently incompatible
with features that rely on modifying function return addresses
to alter control flow, such as function graph tracing and
kretprobes, although it may be possible to later change these
features to modify the shadow stack instead. A copy of the return
address is still kept in the kernel stack for compatibility with
stack unwinding, for example.

SCS has a minimal performance overhead, but allocating
shadow stacks increases kernel memory usage. The feature is
therefore mostly useful on hardware that lacks support for PAC
instructions.

Changes in v3:
 - Switched to filter-out for removing SCS flags in Makefiles
 - Changed the __noscs attribute to use __no_sanitize__("...")
   instead of no_sanitize("...")
 - Cleaned up inline function definitions and moved task_scs()
   into a macro
 - Cleaned up scs_free() and scs_magic()
 - Moved SCS initialization into dup_task_struct() and removed
   the now unused scs_task_init()
 - Added comments to __scs_base() and scs_task_reset() to better
   document design choices
 - Changed copy_page to make the offset and bias explicit

Changes in v2:
 - Changed Ard's KVM patch to use x29 instead of x18 for the
   guest context, which makes restore_callee_saved_regs cleaner
 - Updated help text (and commit messages) to point out
   differences in security properties compared to user space SCS
 - Cleaned up config options: removed the ROP protection choice,
   replaced the CC_IS_CLANG dependency with an arch-specific
   cc-option test, and moved disabling of incompatible config
   options to an arch-specific Kconfig
 - Added CC_FLAGS_SCS, which are filtered out where needed
   instead of using DISABLE_SCS
 - Added a __has_feature guard around __noscs for older clang
   versions

Ard Biesheuvel (1):
  arm64: kernel: avoid x18 __cpu_soft_restart

Sami Tolvanen (16):
  arm64: mm: avoid x18 in idmap_kpti_install_ng_mappings
  arm64/lib: copy_page: avoid x18 register in assembler code
  arm64: kvm: stop treating register x18 as caller save
  add support for Clang's Shadow Call Stack (SCS)
  scs: add accounting
  scs: add support for stack usage debugging
  kprobes: fix compilation without CONFIG_KRETPROBES
  arm64: kprobes: fix kprobes without CONFIG_KRETPROBES
  arm64: disable kretprobes with SCS
  arm64: disable function graph tracing with SCS
  arm64: reserve x18 from general allocation with SCS
  arm64: preserve x18 when CPU is suspended
  arm64: efi: restore x18 if it was corrupted
  arm64: vdso: disable Shadow Call Stack
  arm64: disable SCS for hypervisor code
  arm64: implement Shadow Call Stack

 Makefile                             |   6 +
 arch/Kconfig                         |  33 ++++
 arch/arm64/Kconfig                   |   9 +-
 arch/arm64/Makefile                  |   4 +
 arch/arm64/include/asm/scs.h         |  37 +++++
 arch/arm64/include/asm/stacktrace.h  |   4 +
 arch/arm64/include/asm/suspend.h     |   2 +-
 arch/arm64/include/asm/thread_info.h |   3 +
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/asm-offsets.c      |   3 +
 arch/arm64/kernel/cpu-reset.S        |   4 +-
 arch/arm64/kernel/efi-rt-wrapper.S   |   7 +-
 arch/arm64/kernel/entry.S            |  28 ++++
 arch/arm64/kernel/head.S             |   9 ++
 arch/arm64/kernel/irq.c              |   2 +
 arch/arm64/kernel/probes/kprobes.c   |   2 +
 arch/arm64/kernel/process.c          |   2 +
 arch/arm64/kernel/scs.c              |  39 +++++
 arch/arm64/kernel/smp.c              |   4 +
 arch/arm64/kernel/vdso/Makefile      |   2 +-
 arch/arm64/kvm/hyp/Makefile          |   3 +
 arch/arm64/kvm/hyp/entry.S           |  41 +++--
 arch/arm64/lib/copy_page.S           |  38 ++---
 arch/arm64/mm/proc.S                 |  72 +++++----
 drivers/base/node.c                  |   6 +
 fs/proc/meminfo.c                    |   4 +
 include/linux/compiler-clang.h       |   6 +
 include/linux/compiler_types.h       |   4 +
 include/linux/mmzone.h               |   3 +
 include/linux/scs.h                  |  54 +++++++
 init/init_task.c                     |   8 +
 kernel/Makefile                      |   1 +
 kernel/fork.c                        |   9 ++
 kernel/kprobes.c                     |  38 ++---
 kernel/sched/core.c                  |   2 +
 kernel/sched/sched.h                 |   1 +
 kernel/scs.c                         | 227 +++++++++++++++++++++++++++
 mm/page_alloc.c                      |   6 +
 mm/vmstat.c                          |   3 +
 39 files changed, 630 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm64/include/asm/scs.h
 create mode 100644 arch/arm64/kernel/scs.c
 create mode 100644 include/linux/scs.h
 create mode 100644 kernel/scs.c

-- 
2.24.0.rc0.303.g954a862665-goog

