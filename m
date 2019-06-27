Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E9BC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2730120989
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfF0Dox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:44:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfF0Dox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:44:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74609C04BD4A;
        Thu, 27 Jun 2019 03:44:52 +0000 (UTC)
Received: from treble (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB56B19C5B;
        Thu, 27 Jun 2019 03:44:49 +0000 (UTC)
Date:   Wed, 26 Jun 2019 22:44:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 2/4] objtool: Add support for C jump tables
Message-ID: <20190627034447.gl5tusbhkbr6dadc@treble>
References: <cover.1561595111.git.jpoimboe@redhat.com>
 <426541f62dad525078ee732c09bc206289e994aa.1561595111.git.jpoimboe@redhat.com>
 <CAADnVQ+veayfD70Xsu8UnNrLdRW6rh9jxPb=OGoiYT-O=_zW=A@mail.gmail.com>
 <20190627024700.q4rkcbhmrna6ev4y@treble>
 <CAADnVQJRs9NdHgGiAZfzCLb=eWAPD03-+uf3fisLZrKZUSSoyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQJRs9NdHgGiAZfzCLb=eWAPD03-+uf3fisLZrKZUSSoyg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 27 Jun 2019 03:44:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 07:54:08PM -0700, Alexei Starovoitov wrote:
> On Wed, Jun 26, 2019 at 7:47 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Wed, Jun 26, 2019 at 06:42:40PM -0700, Alexei Starovoitov wrote:
> > > > @@ -1035,9 +1038,18 @@ static struct rela *find_switch_table(struct objtool_file *file,
> > > >
> > > >                 /*
> > > >                  * Make sure the .rodata address isn't associated with a
> > > > -                * symbol.  gcc jump tables are anonymous data.
> > > > +                * symbol.  GCC jump tables are anonymous data.
> > > > +                *
> > > > +                * Also support C jump tables which are in the same format as
> > > > +                * switch jump tables.  Each jump table should be a static
> > > > +                * local const array named "jump_table" for objtool to
> > > > +                * recognize it.
> > >
> > > Nacked-by: Alexei Starovoitov <ast@kernel.org>
> > >
> > > It's not acceptable for objtool to dictate kernel naming convention.
> >
> > Abrasive nack notwithstanding, I agree it's not ideal.
> >
> > How about the following approach instead?  This is the only other way I
> > can think of to annotate a jump table so that objtool can distinguish
> > it:
> >
> > #define __annotate_jump_table __section(".jump_table.rodata")
> >
> > Then bpf would just need the following:
> >
> > -       static const void *jumptable[256] = {
> > +       static const void __annotate_jump_table *jumptable[256] = {
> >
> > This would be less magical and fragile than my original approach.
> >
> > I think the jump table would still be placed with all the other rodata,
> > like before, because the vmlinux linker script recognizes the section
> > ".rodata" suffix and bundles them all together.
> 
> I like it if that works :)
> Definitely cleaner.
> May be a bit more linker script magic would be necessary,
> but hopefully not.
> And no need to rely on gcc style of mangling static vars.

Completely untested swag:

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 8aaf7cd026b0..84212bcb5015 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -116,9 +116,14 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	".pushsection .discard.unreachable\n\t"				\
 	".long 999b - .\n\t"						\
 	".popsection\n\t"
+
+/* Annotate a C jump table to enable objtool to follow the code flow */
+#define __annotate_jump_table __section(".jump_table.rodata")
+
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
+#define __annotate_jump_table
 #endif
 
 #ifndef ASM_UNREACHABLE
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 080e2bb644cc..e67977e22967 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1299,7 +1299,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 {
 #define BPF_INSN_2_LBL(x, y)    [BPF_##x | BPF_##y] = &&x##_##y
 #define BPF_INSN_3_LBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = &&x##_##y##_##z
-	static const void *jumptable[256] = {
+	static const void __annotate_jump_table *jumptable[256] = {
 		[0 ... 255] = &&default_label,
 		/* Now overwrite non-defaults ... */
 		BPF_INSN_MAP(BPF_INSN_2_LBL, BPF_INSN_3_LBL),
@@ -1558,7 +1558,6 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 		BUG_ON(1);
 		return 0;
 }
-STACK_FRAME_NON_STANDARD(___bpf_prog_run); /* jump table */
 
 #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
 #define DEFINE_BPF_PROG_RUN(stack_size) \
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8341c2fff14f..d6d7dd65a195 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -18,7 +18,7 @@
 
 #define FAKE_JUMP_OFFSET -1
 
-#define JUMP_TABLE_SYM_PREFIX "jump_table."
+#define C_JUMP_TABLE_SECTION ".jump_table.rodata"
 
 struct alternative {
 	struct list_head list;
@@ -999,7 +999,6 @@ static struct rela *find_switch_table(struct objtool_file *file,
 	struct instruction *orig_insn = insn;
 	struct section *rodata_sec;
 	unsigned long table_offset;
-	struct symbol *sym;
 
 	/*
 	 * Backward search using the @first_jump_src links, these help avoid
@@ -1041,15 +1040,12 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		 * symbol.  GCC jump tables are anonymous data.
 		 *
 		 * Also support C jump tables which are in the same format as
-		 * switch jump tables.  Each jump table should be a static
-		 * local const array named "jump_table" for objtool to
-		 * recognize it.  Note: GCC will add a numbered suffix to the
-		 * ELF symbol name, like "jump_table.12345", which it does for
-		 * all static local variables.
+		 * switch jump tables.  For objtool to recognize them, they
+		 * need to be placed in the C_JUMP_TABLE_SECTION section.  They
+		 * have symbols associated with them.
 		 */
-		sym = find_symbol_containing(rodata_sec, table_offset);
-		if (sym && strncmp(sym->name, JUMP_TABLE_SYM_PREFIX,
-				   strlen(JUMP_TABLE_SYM_PREFIX)))
+		if (find_symbol_containing(rodata_sec, table_offset) &&
+		    strcmp(rodata_sec->name, C_JUMP_TABLE_SECTION))
 			continue;
 
 		rodata_rela = find_rela_by_dest(rodata_sec, table_offset);
@@ -1289,13 +1285,19 @@ static void mark_rodata(struct objtool_file *file)
 	bool found = false;
 
 	/*
-	 * This searches for the .rodata section or multiple .rodata.func_name
-	 * sections if -fdata-sections is being used. The .str.1.1 and .str.1.8
-	 * rodata sections are ignored as they don't contain jump tables.
+	 * This searches for the following rodata sections, each of which can
+	 * potentially contain jump tables:
+	 *
+	 * - .rodata - can contain GCC switch tables
+	 * - .rodata.func_name - if -fdata-sections * is being used
+	 * - .jump_table.rodata - contains C annotated jump tables
+	 *
+	 * The .rodata.str.* sections are ignored because they don't contain
+	 * jump tables.
 	 */
 	for_each_sec(file, sec) {
-		if (!strncmp(sec->name, ".rodata", 7) &&
-		    !strstr(sec->name, ".str1.")) {
+		if ((!strncmp(sec->name, ".rodata", 7) && !strstr(sec->name, ".str1.")) ||
+		    !strcmp(sec->name, C_JUMP_TABLE_SECTION)) {
 			sec->rodata = true;
 			found = true;
 		}
