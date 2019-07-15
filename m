Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3D6C73C66
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9052420868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfGOAh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfGOAh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1045F30820C9;
        Mon, 15 Jul 2019 00:37:26 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF5765D9D2;
        Mon, 15 Jul 2019 00:37:24 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 00/22] x86, objtool: several fixes/improvements
Date:   Sun, 14 Jul 2019 19:36:55 -0500
Message-Id: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 15 Jul 2019 00:37:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been a lot of objtool bug reports lately, mainly related to
Clang and BPF.  As part of fixing those bugs, I added some improvements
to objtool which uncovered yet more bugs (some kernel, some objtool).

I've given these patches a lot of testing with both GCC and Clang.  More
compile testing of objtool would be appreciated, as the kbuild test
robot doesn't seem to be paying much attention to my branches lately.

There are still at least three outstanding issues:

1) With clang I see:

     drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x88: redundant UACCESS disable

   I haven't dug into it yet.

2) There's also an issue in clang where a large switch table had a bunch
   of unused (bad) entries.  It's not a code correctness issue, but
   hopefully it can get fixed in clang anyway.  See patch 20/22 for more
   details.

3) CONFIG_LIVEPATCH is causing some objtool "unreachable instruction"
   warnings due to the new -flive-patching flag.  I have some fixes
   pending, but this patch set is already long enough.


Jann Horn (1):
  objtool: Support repeated uses of the same C jump table

Josh Poimboeuf (21):
  x86/paravirt: Fix callee-saved function ELF sizes
  x86/kvm: Fix fastop function ELF metadata
  x86/kvm: Fix frame pointer usage in vmx_vmenter()
  x86/kvm: Don't call kvm_spurious_fault() from .fixup
  x86/entry: Fix thunk function ELF sizes
  x86/head/64: Annotate start_cpu0() as non-callable
  x86/uaccess: Remove ELF function annotation from
    copy_user_handle_tail()
  x86/uaccess: Don't leak AC flag into fentry from mcsafe_handle_tail()
  x86/uaccess: Remove redundant CLACs in getuser/putuser error paths
  bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
  objtool: Add mcsafe_handle_tail() to the uaccess safe list
  objtool: Track original function across branches
  objtool: Refactor function alias logic
  objtool: Warn on zero-length functions
  objtool: Change dead_end_function() to return boolean
  objtool: Do frame pointer check before dead end check
  objtool: Refactor sibling call detection logic
  objtool: Refactor jump table code
  objtool: Fix seg fault on bad switch table entry
  objtool: convert insn type to enum
  objtool: Support conditional retpolines

 arch/x86/entry/thunk_64.S       |   5 +-
 arch/x86/include/asm/kvm_host.h |  33 ++--
 arch/x86/include/asm/paravirt.h |   1 +
 arch/x86/kernel/head_64.S       |   4 +-
 arch/x86/kernel/kvm.c           |   1 +
 arch/x86/kvm/emulate.c          |  44 +++--
 arch/x86/kvm/vmx/vmenter.S      |  10 +-
 arch/x86/lib/copy_user_64.S     |   2 +-
 arch/x86/lib/getuser.S          |  20 +--
 arch/x86/lib/putuser.S          |  29 +--
 arch/x86/lib/usercopy_64.c      |   2 +-
 include/linux/compiler-gcc.h    |   2 +
 include/linux/compiler_types.h  |   4 +
 kernel/bpf/core.c               |   2 +-
 tools/objtool/arch.h            |  36 ++--
 tools/objtool/arch/x86/decode.c |   2 +-
 tools/objtool/check.c           | 308 ++++++++++++++++----------------
 tools/objtool/check.h           |   3 +-
 tools/objtool/elf.c             |   4 +-
 tools/objtool/elf.h             |   3 +-
 20 files changed, 281 insertions(+), 234 deletions(-)

-- 
2.20.1

