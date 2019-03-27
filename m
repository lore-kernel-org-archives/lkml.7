Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB85C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7B82146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfC0OUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:20:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50816 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbfC0OUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:20:20 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h99PV-0003dB-Us; Wed, 27 Mar 2019 15:20:10 +0100
Date:   Wed, 27 Mar 2019 15:20:08 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <andi@firstfloor.org>
cc:     Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 02/17] x86, lto: Mark all top level asm statements as
 .text
In-Reply-To: <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org>
Message-ID: <alpine.DEB.2.21.1903270820530.1789@nanos.tec.linutronix.de>
References: <20190321220009.29334-1-andi@firstfloor.org> <20190321220009.29334-3-andi@firstfloor.org> <alpine.DEB.2.21.1903261751490.1789@nanos.tec.linutronix.de> <20190326213803.GN18020@tassilo.jf.intel.com> <alpine.DEB.2.21.1903262321390.1789@nanos.tec.linutronix.de>
 <20190327005523.bbxxittqf4d5bdz5@two.firstfloor.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Tue, 26 Mar 2019, Andi Kleen wrote:
> > Well, we better should know the real reason for this wreckage. I mean, the
> > default section for text is suprisingly .text. I don't see a reason why
> > this would be any different for an assembly function implemented in a C
> > file.
> 
> What happens is that when the function before the asm changes
> the section, gcc only changes it back for the next function/variable
> with a different section. But it doesn't change it back for the asm.
> 
> 
> e.g. here
> 
> __attribute__((section("foo"))) void func(void)
> {
> }
> 
> asm("foo:\n");
> 
> gives with gcc -S (might be different with optimization):
> 
>  .section foo,"ax",@progbits <----------------- sets the section
>  .globl func
>  .type func, @function

SNIP

> .LFE0:
>  .size func, .-func
> <--------------------------- no section reset before the asm
> #APP
>  foo:
> 
>  .ident "GCC: (GNU) 8.3.1 20190223 (Red Hat 8.3.1-2)"
>  .section .note.GNU-stack,"",@progbits

Makes sense, but comes as a surprise when the thing is actually marked as a
function.

> But gcc reorders functions even without LTO inside files, so it could
> eventually happen.

Adding

+void __init foo(void)
+{
+       pr_info("foo\n");
+}

right before the kretprobe_trampoline and compiling it with GCC 6.

So one would assume that kretprobe_trampoline now ends up in
.init.text. But it ends up in the .text section because it's reordered and
ends up at the top of .text.

So clearly stuff gets reordered and those top level ASM constructs which
lack a section are just working by chance and we need the annotations and
backport them.

We also need a way to detect such wreckage automatically. This can happen
again and as the GCC behaviour is random there is no guarantee that it's
noticed right away. Josh, can objtool help here or do we need some other
form of checking that?

So independent of the LTO issue, this information needs to be in the
changelog.

For the patch itself. The kprobes/vide/error-inject parts are fine because
these are clearly functions: ".type $NAME, @function\n".

But this hunk not so much:

--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -372,7 +372,7 @@ extern struct paravirt_patch_template pv_ops;
 
>  #define DEF_NATIVE(ops, name, code)					\
> 	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
> -	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
> +	asm(".text\n\t" NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))

Because it is NOT text.

That 'code' is never executed in place. It's a patch table, which is used
by the alternative code to patch in the native instructions so the pv_ops
indirection can be avoided on bare metal. It's only copied into a buffer
nothing else. So blindly slapping '.text' on it is just wrong.

But that's not the only thing which is wrong here. DEF_NATIVE is only used
in paravirt_patch_32/64.c and the resulting labels are not used outside of
this either. So why are these labels global and the c declaration __visible
extern?

global was already in the original paravirt code and should have never been
there in the first place.

But __visible? That was added via:

  commit 9a55fdbe941e ("x86, asmlinkage, paravirt: Add __visible/asmlinkage to xen paravirt ops")

with a completely empty changelog. Really helpful.

And further down the road it was again LTO "improved":

commit 824a2870098fa536 ("x86, asmlinkage, paravirt: Don't rely on local assembler labels")

with the following changelog in 2013:

    "The paravirt patching code assumes that it can reference a
     local assembler label between two different top level assembler
     statements. This does not work with LTO
     where the assembler code may end up in different assembler files.
    
     Replace it with extern / global /asm linkage labels."
    
This clearly shows that it was never analyzed proper and even the current
patch lacks any form of proper root cause analysis as the "changelog"
clearly shows:

  "With gcc 8 toplevel assembler statements that do not mark themselves
   as .text may end up in other sections. I had boot crashes because
   various assembler statements ended up in the middle of the initcall
   section."

Admittedly it contains at least some information, which is progress over an
empty changelog. But it's clearly NOT a gcc8 problem and it has absolutely
nothing to do with LTO, which the subject suggests.

Is it really necessary, that I need to:

  - urge you to talk with GCC people?

  - ask about whether this needs to be backported?

  - ask whether this is an LTO only problem?

  - do your homework of analysing the root cause?

  - do your homework of analysing the patched code?

  - do your homework of fixing it proper?

And you ask why it takes ages to get your stuff merged? Yes, it takes ages
because patches based on 'works for me' engineering are simply not
acceptable. You have a proven track record of that and I'm trusting you and
your patches not at all. Done that, got burned often enough. Not going to
happen again. It's solely up to you to change that situation.

Proper fix below.

Thanks,

	tglx

8<-------------------

--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -367,11 +367,15 @@ extern struct paravirt_patch_template pv
 	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
 
 /* Simple instruction patching code. */
-#define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
+#define NATIVE_LABEL(a,x,b) "\n" a #x "_" #b ":\n\t"
 
 #define DEF_NATIVE(ops, name, code)					\
-	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
-	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
+	static const char start_##ops##_##name[], end_##ops##_##name[]; \
+	asm(".pushsection .rodata, \"a\"\n"				\
+	    NATIVE_LABEL("start_", ops, name)				\
+	    code							\
+	    NATIVE_LABEL("end_", ops, name)				\
+	    ".popsection\n")
 
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
 unsigned paravirt_patch_default(u8 type, void *insnbuf,



