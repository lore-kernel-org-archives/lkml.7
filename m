Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DADDC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F7F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Br0tDkCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391149AbfGRTOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:14:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59931 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRTOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:14:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJE97g2124771
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:14:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJE97g2124771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477250;
        bh=gBM28iYCQQmkklSdgNlgLOhSGT9HVMPyoFM82SFJtbE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Br0tDkCo9L9m8mEv2cQs38kYF732fqwVaGTsFzGLwfMXWrAQUTDfLuL/eWN7mZfNZ
         VII2pg3IMwEuL2PZnhloOCACTKjvAh4GmkPd64djX5skPQ/GiIn7aykBkiIT4kslb3
         xPVij5PlS1eJS5kcI37pC38e4j9+KXX5DPeepnYW+1IT3JXfSt2qXP/DobFMLpE/yt
         gkjuB2V0YpYPs+Ule1sP08Es13yepN6sPet8b4Fkimid4xwHDVLF+VbKDp6Lfm2e/p
         YLmYR2F43QptducyOhY1xeh4pYJ+g3n8dcVFWM1vAvRLccUgSFwOkeogy2IvjOkhRK
         mRBAVF1qV6drA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJE8392124768;
        Thu, 18 Jul 2019 12:14:08 -0700
Date:   Thu, 18 Jul 2019 12:14:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-3193c0836f203a91bef96d88c64cccf0be090d9c@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        hpa@zytor.com, ast@kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, rdunlap@infradead.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, ast@kernel.org,
          peterz@infradead.org, jpoimboe@redhat.com, rdunlap@infradead.org
In-Reply-To: <30c3ca29ba037afcbd860a8672eef0021addf9fe.1563413318.git.jpoimboe@redhat.com>
References: <30c3ca29ba037afcbd860a8672eef0021addf9fe.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] bpf: Disable GCC -fgcse optimization for
 ___bpf_prog_run()
Git-Commit-ID: 3193c0836f203a91bef96d88c64cccf0be090d9c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3193c0836f203a91bef96d88c64cccf0be090d9c
Gitweb:     https://git.kernel.org/tip/3193c0836f203a91bef96d88c64cccf0be090d9c
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:45 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:06 +0200

bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/30c3ca29ba037afcbd860a8672eef0021addf9fe.1563413318.git.jpoimboe@redhat.com

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
