Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2E6C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FE42082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfGIRsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 13:48:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfGIRsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 13:48:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA25788E59;
        Tue,  9 Jul 2019 17:47:56 +0000 (UTC)
Received: from treble (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D927C9D4C;
        Tue,  9 Jul 2019 17:47:46 +0000 (UTC)
Date:   Tue, 9 Jul 2019 12:47:44 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kairui Song <kasong@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] bpf: Fix ORC unwinding in non-JIT BPF code
Message-ID: <20190709174744.dtbjm72cbu5fepar@treble>
References: <tip-b22cf36c189f31883ad0238a69ccf82aa1f3b16b@git.kernel.org>
 <20190706202942.GA123403@gmail.com>
 <20190707013206.don22x3tfldec4zm@treble>
 <20190707055209.xqyopsnxfurhrkxw@treble>
 <CAADnVQJqT8o=_6P6xHjwxrXqX9ToSb0cTfoOcm2Xcha3KRNNSw@mail.gmail.com>
 <20190708223834.zx7u45a4uuu2yyol@treble>
 <CAADnVQKWDvzsvyjGoFvSQV7VGr2hF2zzCsC9vnpncWMxOJWYdw@mail.gmail.com>
 <20190708225359.ewk44pvrv6a4oao7@treble>
 <20190708230201.mol27wzansuy3n2v@treble>
 <CAADnVQ+imsK-reGBiSzY02e+KdyGYZxm1su7T1bWvti=YmSV-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQ+imsK-reGBiSzY02e+KdyGYZxm1su7T1bWvti=YmSV-Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 09 Jul 2019 17:48:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 04:16:25PM -0700, Alexei Starovoitov wrote:
> total time is hard to compare.
> Could you compare few tests?
> like two that are called "tcpdump *"
> 
> I think small regression is ok.
> Folks that care about performance should be using JIT.

I did each test 20 times and computed the averages:

"tcpdump port 22":
 default:	0.00743175s
 -fno-gcse:	0.00709920s (~4.5% speedup)

"tcpdump complex":
 default:	0.00876715s
 -fno-gcse:	0.00854895s (~2.5% speedup)

So there does seem to be a small performance gain by disabling this
optimization.

We could change it for the whole file, by adjusting CFLAGS_core.o in the
BPF makefile, or we could change it for the function only with something
like the below patch.

Thoughts?

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
