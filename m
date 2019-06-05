Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB40C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E96220870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gSP05FFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfFENYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:24:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfFENXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JIsIzwj48fphsMcXPNEG+UUg23CGsIsDLsOawv9r2fg=; b=gSP05FFZXwDr+r9wlS2LIcq1eI
        Csygbg5EEZB02DUfzutK29NB4VEJPzqKVfS9qaOyLwwYlFmqP/3UVnXevypaD13AR5OXOEZ9GpsTv
        3BEfJkRCXfG8mGcPyxgW62ubyhlbJAC68mSWxgjOmfZKrtRJcHt2occP/PjVB9/is3IAMYv+diJ4n
        GQLq+3jXp6dHlaDB33DTEEmOzjt0sAptQSn5aF6eNuELaLv5ksVR7oaMTTdyqtJK9ND1DH5TGEZNp
        g0zPgNXWMcgJE865V8FYdAm8lk8HU7xqL1xXDxk9Yrwc3spBusU+Ops29zbIxPIGXODacbe09x6kY
        zytyw5vQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsL-0004qd-2N; Wed, 05 Jun 2019 13:22:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9FE7C20757B46; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131945.313688119@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:08:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 13/15] x86/static_call: Add inline static call implementation for x86-64
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Add the inline static call implementation for x86-64.  For each key, a
temporary trampoline is created, named __static_call_tramp_<key>.  The
trampoline has an indirect jump to the destination function.

Objtool uses the trampoline naming convention to detect all the call
sites.  It then annotates those call sites in the .static_call_sites
section.

During boot (and module init), the call sites are patched to call
directly into the destination function.  The temporary trampoline is
then no longer used.

Cc: x86@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Julia Cartwright <julia@ni.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/62188c62f6dda49ca2e20629ee8e5a62a6c0b500.1543200841.git.jpoimboe@redhat.com
---
 arch/x86/Kconfig                                |    3 
 arch/x86/include/asm/static_call.h              |   28 ++++-
 arch/x86/kernel/asm-offsets.c                   |    6 +
 arch/x86/kernel/static_call.c                   |   12 +-
 include/linux/static_call.h                     |    2 
 tools/objtool/Makefile                          |    3 
 tools/objtool/check.c                           |  125 +++++++++++++++++++++++-
 tools/objtool/check.h                           |    2 
 tools/objtool/elf.h                             |    1 
 tools/objtool/include/linux/static_call_types.h |   19 +++
 tools/objtool/sync-check.sh                     |    1 
 11 files changed, 193 insertions(+), 9 deletions(-)
 create mode 100644 tools/objtool/include/linux/static_call_types.h

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -199,6 +199,7 @@ config X86
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
+	select HAVE_STATIC_CALL_INLINE		if HAVE_STACK_VALIDATION
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
@@ -213,6 +214,7 @@ config X86
 	select RTC_MC146818_LIB
 	select SPARSE_IRQ
 	select SRCU
+	select STACK_VALIDATION			if HAVE_STACK_VALIDATION && (HAVE_STATIC_CALL_INLINE || RETPOLINE)
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select USER_STACKTRACE_SUPPORT
@@ -439,7 +441,6 @@ config GOLDFISH
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	default y
-	select STACK_VALIDATION if HAVE_STACK_VALIDATION
 	help
 	  Compile kernel with the retpoline compiler options to guard against
 	  kernel-to-user data leaks by avoiding speculative indirect
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -2,6 +2,20 @@
 #ifndef _ASM_STATIC_CALL_H
 #define _ASM_STATIC_CALL_H
 
+#include <asm/asm-offsets.h>
+
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
+/*
+ * This trampoline is only used during boot / module init, so it's safe to use
+ * the indirect branch without a retpoline.
+ */
+#define __ARCH_STATIC_CALL_TRAMP_JMP(key, func)				\
+	ANNOTATE_RETPOLINE_SAFE						\
+	"jmpq *" __stringify(key) "+" __stringify(SC_KEY_func) "(%rip) \n"
+
+#else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
+
 /*
  * Manually construct a 5-byte direct JMP to prevent the assembler from
  * optimizing it into a 2-byte JMP.
@@ -12,9 +26,19 @@
 	".long " #func " - " __ARCH_STATIC_CALL_JMP_LABEL(key) "\n"	\
 	__ARCH_STATIC_CALL_JMP_LABEL(key) ":"
 
+#endif /* !CONFIG_HAVE_STATIC_CALL_INLINE */
+
 /*
- * This is a permanent trampoline which does a direct jump to the function.
- * The direct jump get patched by static_call_update().
+ * For CONFIG_HAVE_STATIC_CALL_INLINE, this is a temporary trampoline which
+ * uses the current value of the key->func pointer to do an indirect jump to
+ * the function.  This trampoline is only used during boot, before the call
+ * sites get patched by static_call_update().  The name of this trampoline has
+ * a magical aspect: objtool uses it to find static call sites so it can create
+ * the .static_call_sites section.
+ *
+ * For CONFIG_HAVE_STATIC_CALL, this is a permanent trampoline which
+ * does a direct jump to the function.  The direct jump gets patched by
+ * static_call_update().
  */
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(key, func)			\
 	asm(".pushsection .text, \"ax\"				\n"	\
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -12,6 +12,7 @@
 #include <linux/hardirq.h>
 #include <linux/suspend.h>
 #include <linux/kbuild.h>
+#include <linux/static_call.h>
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 #include <asm/sigframe.h>
@@ -104,4 +105,9 @@ static void __used common(void)
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
 	OFFSET(TSS_sp1, tss_struct, x86_tss.sp1);
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
+
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+	BLANK();
+	OFFSET(SC_KEY_func, static_call_key, func);
+#endif
 }
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -10,16 +10,22 @@
 void arch_static_call_transform(void *site, void *tramp, void *func)
 {
 	unsigned char opcodes[CALL_INSN_SIZE];
-	unsigned char insn_opcode;
+	unsigned char insn_opcode, expected;
 	unsigned long insn;
 	s32 dest_relative;
 
 	mutex_lock(&text_mutex);
 
-	insn = (unsigned long)tramp;
+	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE)) {
+		insn = (unsigned long)site;
+		expected = 0xE8; /* CALL */
+	} else {
+		insn = (unsigned long)tramp;
+		expected = 0xE9; /* JMP */
+	}
 
 	insn_opcode = *(unsigned char *)insn;
-	if (insn_opcode != 0xE9) {
+	if (insn_opcode != expected) {
 		WARN_ONCE(1, "unexpected static call insn opcode 0x%x at %pS",
 			  insn_opcode, (void *)insn);
 		goto unlock;
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -59,7 +59,7 @@
 #include <linux/cpu.h>
 #include <linux/static_call_types.h>
 
-#ifdef CONFIG_HAVE_STATIC_CALL
+#if defined(CONFIG_HAVE_STATIC_CALL) && !defined(COMPILE_OFFSETS)
 #include <asm/static_call.h>
 extern void arch_static_call_transform(void *site, void *tramp, void *func);
 #endif
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -33,7 +33,8 @@ all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
-	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
+	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include \
+	    -I$(srctree)/tools/objtool/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
 CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -15,6 +15,7 @@
 
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
+#include <linux/static_call_types.h>
 
 #define FAKE_JUMP_OFFSET -1
 
@@ -584,6 +585,10 @@ static int add_jump_destinations(struct
 			/* sibling call */
 			insn->call_dest = rela->sym;
 			insn->jump_dest = NULL;
+			if (rela->sym->static_call_tramp) {
+				list_add_tail(&insn->static_call_node,
+					      &file->static_call_list);
+			}
 			continue;
 		}
 
@@ -1271,6 +1276,24 @@ static int read_retpoline_hints(struct o
 	return 0;
 }
 
+static int read_static_call_tramps(struct objtool_file *file)
+{
+	struct section *sec;
+	struct symbol *func;
+
+	for_each_sec(file, sec) {
+		list_for_each_entry(func, &sec->symbol_list, list) {
+			if (func->bind == STB_GLOBAL &&
+			    !strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
+				     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
+				func->static_call_tramp = true;
+		}
+
+	}
+
+	return 0;
+}
+
 static void mark_rodata(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1337,6 +1360,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_static_call_tramps(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -2071,6 +2098,11 @@ static int validate_branch(struct objtoo
 				if (is_fentry_call(insn))
 					break;
 
+				if (insn->call_dest->static_call_tramp) {
+					list_add_tail(&insn->static_call_node,
+						      &file->static_call_list);
+				}
+
 				ret = dead_end_function(file, insn->call_dest);
 				if (ret == 1)
 					return 0;
@@ -2382,6 +2414,89 @@ static int validate_reachable_instructio
 	return 0;
 }
 
+static int create_static_call_sections(struct objtool_file *file)
+{
+	struct section *sec, *rela_sec;
+	struct rela *rela;
+	struct static_call_site *site;
+	struct instruction *insn;
+	char *key_name;
+	struct symbol *key_sym;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".static_call_sites");
+	if (sec) {
+		WARN("file already has .static_call_sites section, skipping");
+		return 0;
+	}
+
+	if (list_empty(&file->static_call_list))
+		return 0;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->static_call_list, static_call_node)
+		idx++;
+
+	sec = elf_create_section(file->elf, ".static_call_sites",
+				 sizeof(struct static_call_site), idx);
+	if (!sec)
+		return -1;
+
+	rela_sec = elf_create_rela_section(file->elf, sec);
+	if (!rela_sec)
+		return -1;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->static_call_list, static_call_node) {
+
+		site = (struct static_call_site *)sec->data->d_buf + idx;
+		memset(site, 0, sizeof(struct static_call_site));
+
+		/* populate rela for 'addr' */
+		rela = malloc(sizeof(*rela));
+		if (!rela) {
+			perror("malloc");
+			return -1;
+		}
+		memset(rela, 0, sizeof(*rela));
+		rela->sym = insn->sec->sym;
+		rela->addend = insn->offset;
+		rela->type = R_X86_64_PC32;
+		rela->offset = idx * sizeof(struct static_call_site);
+		list_add_tail(&rela->list, &rela_sec->rela_list);
+		hash_add(rela_sec->rela_hash, &rela->hash, rela->offset);
+
+		/* find key symbol */
+		key_name = insn->call_dest->name + strlen(STATIC_CALL_TRAMP_PREFIX_STR);
+		key_sym = find_symbol_by_name(file->elf, key_name);
+		if (!key_sym) {
+			WARN("can't find static call key symbol: %s", key_name);
+			return -1;
+		}
+
+		/* populate rela for 'key' */
+		rela = malloc(sizeof(*rela));
+		if (!rela) {
+			perror("malloc");
+			return -1;
+		}
+		memset(rela, 0, sizeof(*rela));
+		rela->sym = key_sym;
+		rela->addend = 0;
+		rela->type = R_X86_64_PC32;
+		rela->offset = idx * sizeof(struct static_call_site) + 4;
+		list_add_tail(&rela->list, &rela_sec->rela_list);
+		hash_add(rela_sec->rela_hash, &rela->hash, rela->offset);
+
+		idx++;
+	}
+
+	if (elf_rebuild_rela_section(rela_sec))
+		return -1;
+
+	return 0;
+}
+
 static void cleanup(struct objtool_file *file)
 {
 	struct instruction *insn, *tmpinsn;
@@ -2407,12 +2522,13 @@ int check(const char *_objname, bool orc
 
 	objname = _objname;
 
-	file.elf = elf_open(objname, orc ? O_RDWR : O_RDONLY);
+	file.elf = elf_open(objname, O_RDWR);
 	if (!file.elf)
 		return 1;
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
+	INIT_LIST_HEAD(&file.static_call_list);
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
@@ -2451,6 +2567,11 @@ int check(const char *_objname, bool orc
 		warnings += ret;
 	}
 
+	ret = create_static_call_sections(&file);
+	if (ret < 0)
+		goto out;
+	warnings += ret;
+
 	if (orc) {
 		ret = create_orc(&file);
 		if (ret < 0)
@@ -2459,7 +2580,9 @@ int check(const char *_objname, bool orc
 		ret = create_orc_sections(&file);
 		if (ret < 0)
 			goto out;
+	}
 
+	if (orc || !list_empty(&file.static_call_list)) {
 		ret = elf_write(file.elf);
 		if (ret < 0)
 			goto out;
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -28,6 +28,7 @@ struct insn_state {
 struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
+	struct list_head static_call_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;
@@ -49,6 +50,7 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 16);
+	struct list_head static_call_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -51,6 +51,7 @@ struct symbol {
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
 	bool uaccess_safe;
+	bool static_call_tramp;
 };
 
 struct rela {
--- /dev/null
+++ b/tools/objtool/include/linux/static_call_types.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATIC_CALL_TYPES_H
+#define _STATIC_CALL_TYPES_H
+
+#include <linux/stringify.h>
+
+#define STATIC_CALL_TRAMP_PREFIX ____static_call_tramp_
+#define STATIC_CALL_TRAMP_PREFIX_STR __stringify(STATIC_CALL_TRAMP_PREFIX)
+
+#define STATIC_CALL_TRAMP(key) __PASTE(STATIC_CALL_TRAMP_PREFIX, key)
+#define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
+
+/* The static call site table is created by objtool. */
+struct static_call_site {
+	s32 addr;
+	s32 key;
+};
+
+#endif /* _STATIC_CALL_TYPES_H */
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -10,6 +10,7 @@ arch/x86/include/asm/insn.h
 arch/x86/include/asm/inat.h
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
+include/linux/static_call_types.h
 '
 
 check()


