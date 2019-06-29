Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366BFC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 05:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B230214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 05:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WWwuF7jX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfF2F7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 01:59:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43549 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfF2F7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 01:59:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5T5wrHe1132821
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 28 Jun 2019 22:58:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5T5wrHe1132821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561787933;
        bh=n/jl/lg3RsR62/lWcEwZzBbjKpy63I3koboZMjz5JkA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WWwuF7jXfO1HDr4Bh6ld51aEvT0TX5o17X7L98jpv+4VOLrOvT9oGdwB+iS+ntMdd
         +tbWBVsnN2cN/QoZ/b6yODBs0HsPClYL3kUwEbJC8XbVWpUBugHAh9LwXLfsASEzH8
         nQQ5Gr2FkrfQBrdgvfXFYVdP1LmujKfqvnQATY32CPQtpoExdoy80+7JMhP/35Ophx
         y6op3lC+DzOMA79NrgddH3ZIS9MnSU9y6Q57w2/l3T5NMPfJEKSx/CGJbxofkvRCnt
         Ajblt205DpPncHNguyCEWHb+Kg3NQeJES4iXaZcyevewTNKklOJ68hMT9y5djRxrqr
         kMNfqCdxv6w2A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5T5wrZ11132816;
        Fri, 28 Jun 2019 22:58:53 -0700
Date:   Fri, 28 Jun 2019 22:58:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
Cc:     tglx@linutronix.de, rostedt@goodmis.org, bp@alien8.de,
        jpoimboe@redhat.com, hpa@zytor.com, songliubraving@fb.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, kasong@redhat.com,
        ast@kernel.org, daniel@iogearbox.net, peterz@infradead.org
Reply-To: bp@alien8.de, hpa@zytor.com, jpoimboe@redhat.com,
          songliubraving@fb.com, tglx@linutronix.de, rostedt@goodmis.org,
          kasong@redhat.com, daniel@iogearbox.net, ast@kernel.org,
          peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
References: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
Git-Commit-ID: b22cf36c189f31883ad0238a69ccf82aa1f3b16b
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

Commit-ID:  b22cf36c189f31883ad0238a69ccf82aa1f3b16b
Gitweb:     https://git.kernel.org/tip/b22cf36c189f31883ad0238a69ccf82aa1f3b16b
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 27 Jun 2019 20:50:47 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 29 Jun 2019 07:55:14 +0200

bpf: Fix ORC unwinding in non-JIT BPF code

Objtool previously ignored ___bpf_prog_run() because it didn't understand
the jump table.  This resulted in the ORC unwinder not being able to unwind
through non-JIT BPF code.

Now that objtool knows how to read jump tables, remove the whitelist and
annotate the jump table so objtool can recognize it.

Also add an additional "const" to the jump table definition to clarify that
the text pointers are constant.  Otherwise GCC sets the section writable
flag and the assembler spits out warnings.

Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
Reported-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kairui Song <kasong@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lkml.kernel.org/r/881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com

---
 kernel/bpf/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7c473f208a10..45456a796d7f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1299,7 +1299,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 {
 #define BPF_INSN_2_LBL(x, y)    [BPF_##x | BPF_##y] = &&x##_##y
 #define BPF_INSN_3_LBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = &&x##_##y##_##z
-	static const void *jumptable[256] = {
+	static const void * const jumptable[256] __annotate_jump_table = {
 		[0 ... 255] = &&default_label,
 		/* Now overwrite non-defaults ... */
 		BPF_INSN_MAP(BPF_INSN_2_LBL, BPF_INSN_3_LBL),
@@ -1558,7 +1558,6 @@ out:
 		BUG_ON(1);
 		return 0;
 }
-STACK_FRAME_NON_STANDARD(___bpf_prog_run); /* jump table */
 
 #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
 #define DEFINE_BPF_PROG_RUN(stack_size) \
