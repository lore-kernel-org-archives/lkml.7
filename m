Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74704C742D2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFE6214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfGOAhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:37:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbfGOAhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C15DA85A03;
        Mon, 15 Jul 2019 00:37:39 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51A9B5D9D2;
        Mon, 15 Jul 2019 00:37:38 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 10/22] bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
Date:   Sun, 14 Jul 2019 19:37:05 -0500
Message-Id: <1044b4ced755cc3d1d32030cfcf2064f06a9e639.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 15 Jul 2019 00:37:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86-64, with CONFIG_RETPOLINE=n, GCC's "global common subexpression
elimination" optimization results in ___bpf_prog_run()'s jumptable code
changing from this:

	select_insn:
		jmp *jumptable(, %rax, 8)
		...
	ALU64_ADD_X:
		...
		jmp *jumptable(, %rax, 8)
	ALU_ADD_X:
		...
		jmp *jumptable(, %rax, 8)

to this:

	select_insn:
		mov jumptable, %r12
		jmp *(%r12, %rax, 8)
		...
	ALU64_ADD_X:
		...
		jmp *(%r12, %rax, 8)
	ALU_ADD_X:
		...
		jmp *(%r12, %rax, 8)

The jumptable address is placed in a register once, at the beginning of
the function.  The function execution can then go through multiple
indirect jumps which rely on that same register value.  This has a few
issues:

1) Objtool isn't smart enough to be able to track such a register value
   across multiple recursive indirect jumps through the jump table.

2) With CONFIG_RETPOLINE enabled, this optimization actually results in
   a small slowdown.  I measured a ~4.7% slowdown in the test_bpf
   "tcpdump port 22" selftest.

   This slowdown is actually predicted by the GCC manual:

     Note: When compiling a program using computed gotos, a GCC
     extension, you may get better run-time performance if you
     disable the global common subexpression elimination pass by
     adding -fno-gcse to the command line.

So just disable the optimization for this function.

Fixes: e55a73251da3 ("bpf: Fix ORC unwinding in non-JIT BPF code")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
---
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/compiler-gcc.h   | 2 ++
 include/linux/compiler_types.h | 4 ++++
 kernel/bpf/core.c              | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e8579412ad21..d7ee4c6bad48 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -170,3 +170,5 @@
 #else
 #define __diag_GCC_8(s)
 #endif
+
+#define __no_fgcse __attribute__((optimize("-fno-gcse")))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 095d55c3834d..599c27b56c29 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -189,6 +189,10 @@ struct ftrace_likely_data {
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
 
+#ifndef __no_fgcse
+# define __no_fgcse
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7e98f36a14e2..8191a7db2777 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1295,7 +1295,7 @@ bool bpf_opcode_in_insntable(u8 code)
  *
  * Decode and execute eBPF instructions.
  */
-static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
+static u64 __no_fgcse ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 {
 #define BPF_INSN_2_LBL(x, y)    [BPF_##x | BPF_##y] = &&x##_##y
 #define BPF_INSN_3_LBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = &&x##_##y##_##z
-- 
2.20.1

