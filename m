Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE51C73C42
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE87721537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jM4R7WXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGIMDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:03:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54571 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfGIMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:03:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69C268W1901887
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 05:02:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69C268W1901887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562673727;
        bh=8Vbxk8QdqLEFV6UvNTwaY5xser5lGsQ19iYB/COOvr0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=jM4R7WXrOv1gkqXDq6s6AuTjqv+k5eyB+TyU+Qvl0qC6sJxoKQlLB/T+qYg5N9ldb
         femitzxQ0dY47ESWsCVBAsoGW/mQ0C2WZzpIWYZfa/ejpSHWLFqP0spM35T6KBFvPk
         Tv1bL6xTcNPzH0HXmf78h2RbBoG8qdnpnKm9uNhxI+FHAtv2MbarirGuAUE1ZzuMCU
         iooMXmv9KtLBl3s+7jUbhy1quZKAMOFZRt0NPjDpdoxUTLMR9e3DCbfofWAhpvWBRG
         BEP4BtaQJHl0TTcuD3zlmKob7RX2I+hFwMhNnHQA9hr8JrHOcx4ChibjNSgz4UOJRE
         S04oNd/X/7l5Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69C25ug1901884;
        Tue, 9 Jul 2019 05:02:05 -0700
Date:   Tue, 9 Jul 2019 05:02:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-e55a73251da335873a6e87d68fb17e5aabb8978e@git.kernel.org>
Cc:     ast@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        jpoimboe@redhat.com, kasong@redhat.com, mingo@kernel.org,
        peterz@infradead.org, bp@alien8.de, songliubraving@fb.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        daniel@iogearbox.net
Reply-To: daniel@iogearbox.net, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, songliubraving@fb.com, bp@alien8.de,
          kasong@redhat.com, jpoimboe@redhat.com, rostedt@goodmis.org,
          hpa@zytor.com, ast@kernel.org
In-Reply-To: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
References: <881939122b88f32be4c374d248c09d7527a87e35.1561685471.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/debug] bpf: Fix ORC unwinding in non-JIT BPF code
Git-Commit-ID: e55a73251da335873a6e87d68fb17e5aabb8978e
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

Commit-ID:  e55a73251da335873a6e87d68fb17e5aabb8978e
Gitweb:     https://git.kernel.org/tip/e55a73251da335873a6e87d68fb17e5aabb8978e
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 27 Jun 2019 20:50:47 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 9 Jul 2019 13:55:57 +0200

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/bpf/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 080e2bb644cc..1e12ac382a90 100644
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
