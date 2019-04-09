Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1392EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D4F2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfDINxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:53:36 -0400
Received: from foss.arm.com ([217.140.101.70]:38466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfDINxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:53:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18114A78;
        Tue,  9 Apr 2019 06:53:33 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E6943F68F;
        Tue,  9 Apr 2019 06:53:31 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC 1/6] objtool: Refactor code to make it more suitable for multiple architecture support
Date:   Tue,  9 Apr 2019 14:52:38 +0100
Message-Id: <20190409135243.12424-2-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190409135243.12424-1-raphael.gault@arm.com>
References: <20190409135243.12424-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jump destination and relocation offset used previously are only reliable
on x86_64 architecture. We abstract these computations by calling arch-dependant
implementation.

The control flow information and register macro definitions were based on
the x86_64 architecture but should be abstract so that each architecture
can define the correct values for the registers, especially the registers
related to the stack frame (Frame Pointer, Stack Pointer and possibly
Return Address).

The ORC unwinder is only supported on x86 at the moment and should thus be
in the x86 architecture code. In order not to break the whole structure in
case another architecture decides to support the ORC unwinder via objtool
we choose to let the implementation be done in the architecture dependant
code.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 tools/objtool/Build                           |   1 -
 tools/objtool/arch.h                          |   9 ++
 tools/objtool/arch/x86/Build                  |   1 +
 tools/objtool/arch/x86/decode.c               | 106 ++++++++++++++++
 tools/objtool/arch/x86/include/arch_special.h |  35 ++++++
 tools/objtool/{ => arch/x86/include}/cfi.h    |   0
 tools/objtool/{ => arch/x86}/orc_gen.c        |  10 +-
 tools/objtool/check.c                         | 114 ++----------------
 tools/objtool/check.h                         |   1 +
 tools/objtool/orc.h                           |   4 +-
 tools/objtool/special.c                       |  18 +--
 11 files changed, 173 insertions(+), 126 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h
 rename tools/objtool/{ => arch/x86/include}/cfi.h (100%)
 rename tools/objtool/{ => arch/x86}/orc_gen.c (96%)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 749becdf5b90..ec925d49565a 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -2,7 +2,6 @@ objtool-y += arch/$(SRCARCH)/
 objtool-y += builtin-check.o
 objtool-y += builtin-orc.o
 objtool-y += check.o
-objtool-y += orc_gen.o
 objtool-y += orc_dump.o
 objtool-y += elf.o
 objtool-y += special.o
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index b0d7dc3d71b5..0eff166ca613 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include "elf.h"
 #include "cfi.h"
+#include "orc.h"
 
 #define INSN_JUMP_CONDITIONAL	1
 #define INSN_JUMP_UNCONDITIONAL	2
@@ -70,6 +71,8 @@ struct stack_op {
 	struct op_src src;
 };
 
+struct instruction;
+
 void arch_initial_func_cfi_state(struct cfi_state *state);
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
@@ -79,4 +82,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 bool arch_callee_saved_reg(unsigned char reg);
 
+int arch_orc_read_unwind_hints(struct objtool_file *file);
+
+unsigned long arch_compute_jump_destination(struct instruction *insn);
+
+unsigned long arch_compute_rela_sym_offset(int addend);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index b998412c017d..74015be53ef0 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,4 +1,5 @@
 objtool-y += decode.o
+objtool-y += orc_gen.o
 
 inat_tables_script = arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = arch/x86/lib/x86-opcode-map.txt
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 540a209b78ab..1af7b4996307 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -23,6 +23,8 @@
 #include "lib/inat.c"
 #include "lib/insn.c"
 
+
+#include "../../check.h"
 #include "../../elf.h"
 #include "../../arch.h"
 #include "../../warn.h"
@@ -78,6 +80,105 @@ bool arch_callee_saved_reg(unsigned char reg)
 	}
 }
 
+unsigned long arch_compute_rela_sym_offset(int addend)
+{
+	return addend + 4;
+}
+
+int arch_orc_read_unwind_hints(struct objtool_file *file)
+{
+	struct section *sec, *relasec;
+	struct rela *rela;
+	struct unwind_hint *hint;
+	struct instruction *insn;
+	struct cfi_reg *cfa;
+	int i;
+
+	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
+	if (!sec)
+		return 0;
+
+	relasec = sec->rela;
+	if (!relasec) {
+		WARN("missing .rela.discard.unwind_hints section");
+		return -1;
+	}
+
+	if (sec->len % sizeof(struct unwind_hint)) {
+		WARN("struct unwind_hint size mismatch");
+		return -1;
+	}
+
+	file->hints = true;
+
+	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
+		hint = (struct unwind_hint *)sec->data->d_buf + i;
+
+		rela = find_rela_by_dest(sec, i * sizeof(*hint));
+		if (!rela) {
+			WARN("can't find rela for unwind_hints[%d]", i);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("can't find insn for unwind_hints[%d]", i);
+			return -1;
+		}
+
+		cfa = &insn->state.cfa;
+
+		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
+			insn->save = true;
+			continue;
+
+		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
+			insn->restore = true;
+			insn->hint = true;
+			continue;
+		}
+
+		insn->hint = true;
+
+		switch (hint->sp_reg) {
+		case ORC_REG_UNDEFINED:
+			cfa->base = CFI_UNDEFINED;
+			break;
+		case ORC_REG_SP:
+			cfa->base = CFI_SP;
+			break;
+		case ORC_REG_BP:
+			cfa->base = CFI_BP;
+			break;
+		case ORC_REG_SP_INDIRECT:
+			cfa->base = CFI_SP_INDIRECT;
+			break;
+		case ORC_REG_R10:
+			cfa->base = CFI_R10;
+			break;
+		case ORC_REG_R13:
+			cfa->base = CFI_R13;
+			break;
+		case ORC_REG_DI:
+			cfa->base = CFI_DI;
+			break;
+		case ORC_REG_DX:
+			cfa->base = CFI_DX;
+			break;
+		default:
+			WARN_FUNC("unsupported unwind_hint sp base reg %d",
+				  insn->sec, insn->offset, hint->sp_reg);
+			return -1;
+		}
+
+		cfa->offset = hint->sp_offset;
+		insn->state.type = hint->type;
+		insn->state.end = hint->end;
+	}
+
+	return 0;
+}
+
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, unsigned char *type,
@@ -494,3 +595,8 @@ void arch_initial_func_cfi_state(struct cfi_state *state)
 	state->regs[16].base = CFI_CFA;
 	state->regs[16].offset = -8;
 }
+
+unsigned long arch_compute_jump_destination(struct instruction *insn)
+{
+	return insn->offset + insn->len + insn->immediate;
+}
diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
new file mode 100644
index 000000000000..bd91b1096359
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch_special.h
@@ -0,0 +1,35 @@
+/*
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define EX_ENTRY_SIZE		12
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+
+#define ALT_ENTRY_SIZE		13
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#define IGNORE_SHF_EXEC_FLAG	0
+
+#define JUMP_DYNAMIC_IS_SWITCH_TABLE	0
+
+#define X86_FEATURE_POPCNT (4*32+23)
diff --git a/tools/objtool/cfi.h b/tools/objtool/arch/x86/include/cfi.h
similarity index 100%
rename from tools/objtool/cfi.h
rename to tools/objtool/arch/x86/include/cfi.h
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/arch/x86/orc_gen.c
similarity index 96%
rename from tools/objtool/orc_gen.c
rename to tools/objtool/arch/x86/orc_gen.c
index 3f98dcfbc177..aaa5ca31a8f4 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/arch/x86/orc_gen.c
@@ -18,11 +18,11 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include "orc.h"
-#include "check.h"
-#include "warn.h"
+#include "../../orc.h"
+#include "../../check.h"
+#include "../../warn.h"
 
-int create_orc(struct objtool_file *file)
+int arch_create_orc(struct objtool_file *file)
 {
 	struct instruction *insn;
 
@@ -128,7 +128,7 @@ static int create_orc_entry(struct section *u_sec, struct section *ip_relasec,
 	return 0;
 }
 
-int create_orc_sections(struct objtool_file *file)
+int arch_create_orc_sections(struct objtool_file *file)
 {
 	struct instruction *insn, *prev_insn;
 	struct section *sec, *u_sec, *ip_relasec;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0414a0d52262..17fcd8c8f9c1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -507,7 +507,7 @@ static int add_jump_destinations(struct objtool_file *file)
 					       insn->len);
 		if (!rela) {
 			dest_sec = insn->sec;
-			dest_off = insn->offset + insn->len + insn->immediate;
+			dest_off = arch_compute_jump_destination(insn);
 		} else if (rela->sym->type == STT_SECTION) {
 			dest_sec = rela->sym->sec;
 			dest_off = rela->addend + 4;
@@ -587,7 +587,7 @@ static int add_call_destinations(struct objtool_file *file)
 		rela = find_rela_by_dest_range(insn->sec, insn->offset,
 					       insn->len);
 		if (!rela) {
-			dest_off = insn->offset + insn->len + insn->immediate;
+			dest_off = arch_compute_jump_destination(insn);
 			insn->call_dest = find_symbol_by_offset(insn->sec,
 								dest_off);
 
@@ -600,14 +600,19 @@ static int add_call_destinations(struct objtool_file *file)
 			}
 
 		} else if (rela->sym->type == STT_SECTION) {
+			/*
+			 * the original x86_64 code adds 4 to the rela->addend
+			 * which is not needed on arm64 architecture.
+			 */
+			dest_off = arch_compute_rela_sym_offset(rela->addend);
 			insn->call_dest = find_symbol_by_offset(rela->sym->sec,
-								rela->addend+4);
+								dest_off);
 			if (!insn->call_dest ||
 			    insn->call_dest->type != STT_FUNC) {
-				WARN_FUNC("can't find call dest symbol at %s+0x%x",
+				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
 					  rela->sym->sec->name,
-					  rela->addend + 4);
+					  dest_off);
 				return -1;
 			}
 		} else
@@ -1073,99 +1078,6 @@ static int add_switch_table_alts(struct objtool_file *file)
 	return 0;
 }
 
-static int read_unwind_hints(struct objtool_file *file)
-{
-	struct section *sec, *relasec;
-	struct rela *rela;
-	struct unwind_hint *hint;
-	struct instruction *insn;
-	struct cfi_reg *cfa;
-	int i;
-
-	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
-	if (!sec)
-		return 0;
-
-	relasec = sec->rela;
-	if (!relasec) {
-		WARN("missing .rela.discard.unwind_hints section");
-		return -1;
-	}
-
-	if (sec->len % sizeof(struct unwind_hint)) {
-		WARN("struct unwind_hint size mismatch");
-		return -1;
-	}
-
-	file->hints = true;
-
-	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
-		hint = (struct unwind_hint *)sec->data->d_buf + i;
-
-		rela = find_rela_by_dest(sec, i * sizeof(*hint));
-		if (!rela) {
-			WARN("can't find rela for unwind_hints[%d]", i);
-			return -1;
-		}
-
-		insn = find_insn(file, rela->sym->sec, rela->addend);
-		if (!insn) {
-			WARN("can't find insn for unwind_hints[%d]", i);
-			return -1;
-		}
-
-		cfa = &insn->state.cfa;
-
-		if (hint->type == UNWIND_HINT_TYPE_SAVE) {
-			insn->save = true;
-			continue;
-
-		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
-			insn->restore = true;
-			insn->hint = true;
-			continue;
-		}
-
-		insn->hint = true;
-
-		switch (hint->sp_reg) {
-		case ORC_REG_UNDEFINED:
-			cfa->base = CFI_UNDEFINED;
-			break;
-		case ORC_REG_SP:
-			cfa->base = CFI_SP;
-			break;
-		case ORC_REG_BP:
-			cfa->base = CFI_BP;
-			break;
-		case ORC_REG_SP_INDIRECT:
-			cfa->base = CFI_SP_INDIRECT;
-			break;
-		case ORC_REG_R10:
-			cfa->base = CFI_R10;
-			break;
-		case ORC_REG_R13:
-			cfa->base = CFI_R13;
-			break;
-		case ORC_REG_DI:
-			cfa->base = CFI_DI;
-			break;
-		case ORC_REG_DX:
-			cfa->base = CFI_DX;
-			break;
-		default:
-			WARN_FUNC("unsupported unwind_hint sp base reg %d",
-				  insn->sec, insn->offset, hint->sp_reg);
-			return -1;
-		}
-
-		cfa->offset = hint->sp_offset;
-		insn->state.type = hint->type;
-		insn->state.end = hint->end;
-	}
-
-	return 0;
-}
 
 static int read_retpoline_hints(struct objtool_file *file)
 {
@@ -1259,7 +1171,7 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
-	ret = read_unwind_hints(file);
+	ret = arch_orc_read_unwind_hints(file);
 	if (ret)
 		return ret;
 
@@ -2237,11 +2149,11 @@ int check(const char *_objname, bool orc)
 	}
 
 	if (orc) {
-		ret = create_orc(&file);
+		ret = arch_create_orc(&file);
 		if (ret < 0)
 			goto out;
 
-		ret = create_orc_sections(&file);
+		ret = arch_create_orc_sections(&file);
 		if (ret < 0)
 			goto out;
 
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index e6e8a655b556..f8bad59575e5 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -23,6 +23,7 @@
 #include "cfi.h"
 #include "arch.h"
 #include "orc.h"
+#include "arch_special.h"
 #include <linux/hashtable.h>
 
 struct insn_state {
diff --git a/tools/objtool/orc.h b/tools/objtool/orc.h
index b0e92a6d0903..1aa02dce3bca 100644
--- a/tools/objtool/orc.h
+++ b/tools/objtool/orc.h
@@ -22,8 +22,8 @@
 
 struct objtool_file;
 
-int create_orc(struct objtool_file *file);
-int create_orc_sections(struct objtool_file *file);
+int arch_create_orc(struct objtool_file *file);
+int arch_create_orc_sections(struct objtool_file *file);
 
 int orc_dump(const char *objname);
 
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 50af4e1274b3..787a123391ec 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -25,23 +25,7 @@
 
 #include "special.h"
 #include "warn.h"
-
-#define EX_ENTRY_SIZE		12
-#define EX_ORIG_OFFSET		0
-#define EX_NEW_OFFSET		4
-
-#define JUMP_ENTRY_SIZE		16
-#define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		4
-
-#define ALT_ENTRY_SIZE		13
-#define ALT_ORIG_OFFSET		0
-#define ALT_NEW_OFFSET		4
-#define ALT_FEATURE_OFFSET	8
-#define ALT_ORIG_LEN_OFFSET	10
-#define ALT_NEW_LEN_OFFSET	11
-
-#define X86_FEATURE_POPCNT (4*32+23)
+#include "arch_special.h"
 
 struct special_entry {
 	const char *sec;
-- 
2.17.1

