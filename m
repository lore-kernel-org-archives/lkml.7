Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0624DC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979AF2178F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="scmM5jNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfKEX4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:56:16 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:38205 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbfKEX4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:56:16 -0500
Received: by mail-pf1-f201.google.com with SMTP id m1so4990228pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 15:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K/shn7Sj8cjIAOcXeYGvWEwPxEjEzE6xK48ExW4epXg=;
        b=scmM5jNfsbmI1H0pQPntZXD8LPbBpqRfakltnLei5h9YsMHeXjM/EGk00HpoE6cYTg
         VQf6iXzdwyf+Oy0UVVLceLsds613nQiGW62kKoYvVLXYPW0EksJkPcLWO+XeSxg5b73K
         wo22X8XBXCZFQwLrzrk4tv+wA42+R9fGmYrMvAVb/MRA1841Vf+6qkVw8JXWCpJ11d+k
         yxjNM092v8ZX8aWDYuLn8/I5lfvwBu10uXojn1YEIutgnHZ8/y1ipn7RvJ1xnFuUQGkX
         RVtc4ltq2u0sK97Y6a6qoISgZPreVnLNCQRBhIw6tI/SGtXIIiKZb4OR48PON9w0i386
         p8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K/shn7Sj8cjIAOcXeYGvWEwPxEjEzE6xK48ExW4epXg=;
        b=tHHcJq21py8hV3+XytQX5JGosuR8/sBmQkNMk9VPC7rZ18D3357fbGhgdTH8iPLz5q
         +SShc3QoXofmL+XWXW5KTpZbYyUIMNw8nkn32dfqk3eNh/xqkaM8LVHQfRYl016c8fru
         YagftsccSCJSgMS8QYbsPHG5xjOUqAkZLmbGmBAWMNeqF8r8uyv4SRNC++jA3SFbjVaD
         /N5VyV8bQ/TdnfjbVCvTsxXdD384ngE2cCY3OVxHZBj9WxvfmDx8BIfpO5dUwpGWK/ZK
         gNqKFFnU1TpX8YHV8KxNGuc5mO598t8K6mD101B4P05NII5RTy+18rI57hPzlY3HjIoX
         d9+A==
X-Gm-Message-State: APjAAAUUY9vFEJMHSOp9hDhZiZhCl2Q/Py+8FUuxgSu1i4BDcsuckXLy
        mDQsQZ/aOYqhXv7dlnNZtAulkEEB5uJTX4O7YPQ=
X-Google-Smtp-Source: APXvYqzDvL9Cb+QocxQ8O+qyvISrwwwXj191VtLuOK+ABTmwCtckO5qR2k4WDa2FsTgm/ty6HatvhV0O82L9xTyWK8c=
X-Received: by 2002:a63:5960:: with SMTP id j32mr39727761pgm.281.1572998174570;
 Tue, 05 Nov 2019 15:56:14 -0800 (PST)
Date:   Tue,  5 Nov 2019 15:55:54 -0800
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191105235608.107702-1-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 00/14] add support for Clang's Shadow Call Stack
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
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
shadow stacks used by inactive tasks and interrupt handlers in
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
in the kernel stack to alter control flow, such as function
graph tracing, although it may be possible to later change these
features to modify the shadow stack instead. A copy of the return
address is still kept in the kernel stack for compatibility with
stack unwinding, for example.

SCS has a minimal performance overhead, but allocating
shadow stacks increases kernel memory usage. The feature is
therefore mostly useful on hardware that lacks support for PAC
instructions.

Changes in v5:
 - Updated the comment in __scs_base() to Mark's suggestion
 - Changed all instances of uintptr_t to unsigned long
 - Added allocation poisoning for KASAN to catch unintentional
   shadow stack accesses; moved set_set_magic before poisoning
   and switched scs_used() and scs_corrupted() to access the
   buffer using READ_ONCE_NOCHECK() instead
 - Changed scs_free() to check for NULL instead of zero
 - Renamed SCS_CACHE_SIZE to NR_CACHED_SCS
 - Added a warning if cpuhp_setup_state fails in scs_init()
 - Dropped patches disabling kretprobes after confirming there's
   no functional conflict with SCS instrumentation
 - Added an explanation to the commit message why function graph
   tracing and SCS are incompatible
 - Removed the ifdefs from arch/arm64/mm/proc.S and added
   comments explaining why we are saving and restoring x18
 - Updated scs_check_usage format to include process information

Changes in v4:
 - Fixed authorship for Ard's patches
 - Added missing commit messages
 - Commented code that clears SCS from thread_info
 - Added a comment about SCS_END_MAGIC being non-canonical

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


Ard Biesheuvel (3):
  arm64/lib: copy_page: avoid x18 register in assembler code
  arm64: kvm: stop treating register x18 as caller save
  arm64: kernel: avoid x18 in __cpu_soft_restart

Sami Tolvanen (11):
  arm64: mm: avoid x18 in idmap_kpti_install_ng_mappings
  add support for Clang's Shadow Call Stack (SCS)
  scs: add accounting
  scs: add support for stack usage debugging
  arm64: disable function graph tracing with SCS
  arm64: reserve x18 from general allocation with SCS
  arm64: preserve x18 when CPU is suspended
  arm64: efi: restore x18 if it was corrupted
  arm64: vdso: disable Shadow Call Stack
  arm64: disable SCS for hypervisor code
  arm64: implement Shadow Call Stack

 Makefile                             |   6 +
 arch/Kconfig                         |  33 ++++
 arch/arm64/Kconfig                   |   7 +-
 arch/arm64/Makefile                  |   4 +
 arch/arm64/include/asm/scs.h         |  37 ++++
 arch/arm64/include/asm/stacktrace.h  |   4 +
 arch/arm64/include/asm/suspend.h     |   2 +-
 arch/arm64/include/asm/thread_info.h |   3 +
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/asm-offsets.c      |   3 +
 arch/arm64/kernel/cpu-reset.S        |   4 +-
 arch/arm64/kernel/efi-rt-wrapper.S   |   7 +-
 arch/arm64/kernel/entry.S            |  28 +++
 arch/arm64/kernel/head.S             |   9 +
 arch/arm64/kernel/irq.c              |   2 +
 arch/arm64/kernel/process.c          |   2 +
 arch/arm64/kernel/scs.c              |  39 +++++
 arch/arm64/kernel/smp.c              |   4 +
 arch/arm64/kernel/vdso/Makefile      |   2 +-
 arch/arm64/kvm/hyp/Makefile          |   3 +
 arch/arm64/kvm/hyp/entry.S           |  45 ++---
 arch/arm64/lib/copy_page.S           |  38 ++---
 arch/arm64/mm/proc.S                 |  77 +++++----
 drivers/base/node.c                  |   6 +
 fs/proc/meminfo.c                    |   4 +
 include/linux/compiler-clang.h       |   6 +
 include/linux/compiler_types.h       |   4 +
 include/linux/mmzone.h               |   3 +
 include/linux/scs.h                  |  57 +++++++
 init/init_task.c                     |   8 +
 kernel/Makefile                      |   1 +
 kernel/fork.c                        |   9 +
 kernel/sched/core.c                  |   2 +
 kernel/scs.c                         | 246 +++++++++++++++++++++++++++
 mm/page_alloc.c                      |   6 +
 mm/vmstat.c                          |   3 +
 36 files changed, 638 insertions(+), 77 deletions(-)
 create mode 100644 arch/arm64/include/asm/scs.h
 create mode 100644 arch/arm64/kernel/scs.c
 create mode 100644 include/linux/scs.h
 create mode 100644 kernel/scs.c


base-commit: 26bc672134241a080a83b2ab9aa8abede8d30e1c
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

