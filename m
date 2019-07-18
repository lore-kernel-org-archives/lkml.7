Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B172C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9E221019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 01:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbfGRBhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 21:37:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbfGRBhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 21:37:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4548E30917A8;
        Thu, 18 Jul 2019 01:37:08 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-211.rdu2.redhat.com [10.10.122.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE46F5D9CC;
        Thu, 18 Jul 2019 01:37:04 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 00/22] x86, objtool: several fixes/improvements
Date:   Wed, 17 Jul 2019 20:36:35 -0500
Message-Id: <cover.1563413318.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 18 Jul 2019 01:37:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Use ud2 instead of calling kvm_spurious_fault() in vmx_vmenter() [Paolo]
- Fix ____kvm_handle_fault_on_reboot() comment [Paolo]
- Tweak "switch jump table" comment [Peter]
- Add review tags

Patches also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-many-fixes-v2

v1 was posted here:
https://lkml.kernel.org/r/cover.1563150885.git.jpoimboe@redhat.com

-------------------

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
  x86/kvm: Replace vmx_vmenter()'s call to kvm_spurious_fault() with UD2
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
 arch/x86/include/asm/kvm_host.h |  34 ++--
 arch/x86/include/asm/paravirt.h |   1 +
 arch/x86/kernel/head_64.S       |   4 +-
 arch/x86/kernel/kvm.c           |   1 +
 arch/x86/kvm/emulate.c          |  44 +++--
 arch/x86/kvm/vmx/vmenter.S      |   6 +-
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
 20 files changed, 278 insertions(+), 234 deletions(-)

-- 
2.20.1

