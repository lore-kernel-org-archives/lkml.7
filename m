Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D94C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934A821852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L35R/ge5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfGCA4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:56:38 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:39655 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCA4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:56:38 -0400
Received: by mail-pf1-f171.google.com with SMTP id j2so302965pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sEx63LvR4BWkxhu/+3MOIZIo4BncDbL9NJkv7plBdd0=;
        b=L35R/ge5Q13Hy2heBrAKxF7fJYBq3s1m7YjXYwWp1d6H4/AzYv6rGG3cf0WKDCW31d
         dFcMorKZSEXe7aACw7vb4YebkzqOUYXHXJpxT32x5FXdckI3P/TOX3+G3ceNCJkYx6Q4
         gzcp2blyYp8B6LlpsyIdkQpb1oCXoSYq8CSfOiiJt/xx3BSO5tn9oA+fY7HFwAEjzmky
         YD5lAV7sk7zNZT20IDCxntI/QJOL6G3FTWz/CPLrXK/8xDR6nWCLEi21sBzN0dQn0MtJ
         uEmV4stlcFtHBSTwvrQQUZSennQXfHR+vv7yMltzqImRqImJPVqCQpt08rn3uiTHAwGw
         y1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sEx63LvR4BWkxhu/+3MOIZIo4BncDbL9NJkv7plBdd0=;
        b=Fem75n4hfKJ6uPpH5Re0gv4H0UvAFuC+DOrjQY5RuGPAB6cryDIs8CDM2wfzhc2k4K
         vmx4B2WrltvpvsEUdHbMLDE3gGVcMCHpJILGJa5HqLapYP08uiVsjDf2Uz1qbQeCULGM
         MMzmWC/baxkwQODUfZqnyscY0pn6E9VAkIp2LsAfHPmHX3lMr/IVIOYPjyZ7ktiq7Sbq
         pV9ns0Jl21HZwdqGGRkqEwm+S7Kd2AT7iKzslmek3oLbNjhFByBj4Wgvy+Zi5bTK+8ah
         LZpdenb5akWF8ED6JZiNfhnw+HpJjIIDKtdsknX49bI4M4prJIA9ftleiT1+gneekdHX
         nDew==
X-Gm-Message-State: APjAAAWL6aQSwAzv6TdkHrthpKBcJP2CO7uXVxkJBMWNoLdccvKWsbun
        6OC41wge1dnmVItdnR+2rTTSxsTADqDDt4mQPxUz5NqZeP5Eew==
X-Google-Smtp-Source: APXvYqwAM84/AUv/sKtAKB6tbhh6WV4xxpbE1U0ENIOo7ULNCAO8KbUD827+UrxjaY5041tMLI5hnNfru/Ayz4uLyho=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr7843834pjs.73.1562100842616;
 Tue, 02 Jul 2019 13:54:02 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Jul 2019 13:53:51 -0700
Message-ID: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
Subject: objtool warnings in prerelease clang-9
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Bill Wendling <morbo@google.com>,
        Stephen Hines <srhines@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TL;DR
LLVM currently has a bug when unrolling loops containing asm goto and
we have a fix in hand.

Following up from our thread last week (https://lkml.org/lkml/2019/6/29/14).

With an x86 defconfig (6fbc7275c7a9) +clang 9 (e1006259d84d), I see
the following 4 warnings from objtool:
arch/x86/events/intel/core.o: warning: objtool:
intel_pmu_nhm_workaround()+0xa8: unreachable instruction
arch/x86/kernel/cpu/mtrr/generic.o: warning: objtool:
get_fixed_ranges()+0x9b: unreachable instruction
arch/x86/kernel/platform-quirks.o: warning: objtool:
x86_early_init_platform_quirks()+0x84: unreachable instruction
drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool:
.altinstr_replacement+0x88: redundant UACCESS disable

Peter mentioned seeing 6 cases:
https://lkml.org/lkml/2019/6/27/118

We have 21 open reports (mostly unverified, I think someone was
testing -O3 -march=native):
https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aissue+is%3Aopen+label%3Aobjtool

Taking a look specifically at arch/x86/kernel/cpu/mtrr/generic.o (as
tglx and Peter did in https://lkml.org/lkml/2019/6/27/118:

Disassembly and jump table:
https://gist.github.com/nickdesaulniers/395129e75d9f7afe028db832145594d8
More concise snippet:
https://gist.github.com/nickdesaulniers/a3159782908cb6e50e26ea9563b14c20

Of interest are the disassembled __jump_table entries; in groups of
three, there is a group for which the second element is duplicated
with a previous group.  This is bad because (as explained by Peter in
https://lkml.org/lkml/2019/6/27/118) the triples are in the form (code
location, jump target, pointer to key).  Duplicate or repeated jump
targets are unexpected, and will lead to incorrect control flow after
patching such code locations.  Also, the jump target should be 0x7
bytes ahead of the location, IIUC.

I've annotated the concise snippet:
https://gist.github.com/nickdesaulniers/c0cb8fc67720a5abbadf42fde5440a8e
we can see that two groups in the __jump_table share a similar jump
target, unexpectedly.

Now that we can identify what's bad (duplicate __jump_table entries),
we can try to creduce the input.
(https://nickdesaulniers.github.io/blog/2019/01/18/finding-compiler-bugs-with-c-reduce/)

The preprocessed input is 37497 lines long.  We want to reduce it
down, but I haven't been able to write a correct "interestingness
test" for creduce where I was then able to make sense of the output.
Instead, I'm looking into program slicing:
https://en.wikipedia.org/wiki/Program_slicing.  We'd want to do this
for C code, and it should be possible to implement with libclang, but
since it doesn't exist yet AFAICT and llvm-extract does, we can do the
program slicing on the LLVM IR level.  This will also give us a test
case to add to the compiler's test suite.

$ clang <same c flags kernel uses via `make V=`> \
  -emit-llvm -S -Xclang -disable-llvm- passes -o get_fixed_ranges generic.ll
$ llvm-extract -func get_fixed_ranges generic.ll -o
generic.get_fixed_ranges.ll -S --recursive

is a more manageable 541 lines of LLVM IR.
https://gist.github.com/nickdesaulniers/73aef95e9735a50765f654ebdcbb99dd

`callbr` is the LLVM IR instruction representing `asm goto`.
https://llvm.org/docs/LangRef.html#callbr-instruction
The gist of the instruction is:
callbr ... <list of block addresses from the label list> to
<fallthrough basic block [<list of block addresses from the label
list>].  IIUC, the repeated list of addresses better match.

We can then observe the middle end work its optimizations:
$ opt -O2 -print-before-all -print-after-all
generic.get_fixed_ranges.ll -S -o - 2>&1 | less
(27199 lines of output, omitted)
Here's the relevant snippet of the 27199 lines:
https://gist.github.com/nickdesaulniers/089bf56165675065bca830cd7da767d8

grepping through the output and looking for the first pass which
contains non-matching list of block addresses in the label list, we
come upon:

```
callbr void asm sideeffect "1:.byte
0x0f,0x1f,0x44,0x00,0\0A\09.pushsection __jump_table,  \22aw\22 \0A\09
.balign 8 \0A\09.long 1b - ., ${2:l} - . \0A\09 .quad ${0:c} + ${1:c}
- .\0A\09.popsection \0A\09",
"i,i,X,~{dirflag},~{fpsr},~{flags}"(%struct.static_key* getelementptr
inbounds (%struct.tracepoint, %struct.tracepoint*
@__tracepoint_read_msr, i64 0, i32 1), i1 false, i8*
blockaddress(@get_fixed_ranges, %20)) #6
          to label %native_read_msr.exit31.1 [label %49], !srcloc !4
```

(particularly I would have expected the `%20` and `%49` to match.)

which occurs before "MergedLoadStoreMotion," but due to what looks
like a bug in the pass printer
(https://lists.llvm.org/pipermail/cfe-dev/2019-July/062795.html)
doesn't print the results of loop unrolling, which runs just before
"MergedLoadStoreMotion."

I see that `get_fixed_ranges` is a loop that gets unrolled to have a
trip count of two.
$ opt -O2 -debug-only=loop-unroll generic.get_fixed_ranges.ll -S -o /dev/null
...
Loop Unroll: F[get_fixed_ranges] Loop %
  Loop Size = 27
  Trip Count = 2
  Trip Multiple = 2
COMPLETELY UNROLLING loop % with trip count 2!

If I manually add some print statements to loop unrolling, I can see
that before we unroll the loop, things look good. After unrolling the
loop, things look bad.  Indeed, if I kneecap loop unrolling the
problem goes away:

$ opt -O2 -debug-only=loop-unroll -unroll-full-max-count=0
generic.get_fixed_ranges.ll -S -o -

So this is a bug in our loop unroller when unrolling IR
representations of asm goto.  Peter's guess that this was a bug in
inlining was very close!  Function inlining and loop unrolling are
closely related and probably share a lot of machinery related to
cloning of basic blocks and instructions.  In this case, if we have a
loop with asm goto and we unroll the loop, the referenced labels from
the asm goto statement need to reflect the newly duplicated labels.
In this case, the new duplicated asm goto is referencing the initial
asm goto's label, which would result in non-sensical control flow at
runtime.

In the loop unroller, I can see that we skip loop unrolling in the
event of "indirectbr" instructions.
https://github.com/llvm/llvm-project/blob/97316fff5d6a7c3d2c072301a118ac0cb5094ad8/llvm/lib/Transforms/Utils/LoopUnroll.cpp#L294
https://github.com/llvm/llvm-project/blob/97316fff5d6a7c3d2c072301a118ac0cb5094ad8/llvm/lib/Analysis/LoopInfo.cpp#L432

Conservatively, we can block loop unrolling when we see asm goto in a loop:
diff --git a/llvm/lib/Analysis/LoopInfo.cpp b/llvm/lib/Analysis/LoopInfo.cpp
index 00dbe30c2b3d..f800c890d1db 100644
--- a/llvm/lib/Analysis/LoopInfo.cpp
+++ b/llvm/lib/Analysis/LoopInfo.cpp
@@ -433,7 +433,8 @@ bool Loop::isSafeToClone() const {
   // Return false if any loop blocks contain indirectbrs, or there
are any calls
   // to noduplicate functions.
   for (BasicBlock *BB : this->blocks()) {
-    if (isa<IndirectBrInst>(BB->getTerminator()))
+    if (isa<IndirectBrInst>(BB->getTerminator()) ||
+        isa<CallBrInst>(BB->getTerminator()))
       return false;

     for (Instruction &I : *BB)

This causes objtool to not find any issues in
arch/x86/kernel/cpu/mtrr/generic.o.  I don't observe any duplication
in the __jump_table section of the resulting .o file.  It also cuts
down the objtool warnings I observe in a defconfig (listed at the
beginning of the email) from 4 to 2. (platform-quirks.o predates asm
goto, i915_gem_execbuffer.o is likely a separate bug).

Coincidentally, Alexander and Bill just found what I think is the same bug:
https://bugs.llvm.org/show_bug.cgi?id=42489

So for now we'll be conservative/correct and disable unrolling of
loops that contain asm goto; then we can use the same test case to
permit unrolling with the correct code transformations added.
-- 
Thanks,
~Nick Desaulniers
