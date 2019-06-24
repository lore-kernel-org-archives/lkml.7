Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672B9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD4920679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfFXJ5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:57:12 -0400
Received: from foss.arm.com ([217.140.110.172]:44906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbfFXJ4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:56:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A898105A;
        Mon, 24 Jun 2019 02:56:19 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B59C3F71E;
        Mon, 24 Jun 2019 02:56:18 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC V3 06/18] objtool: arm64: Adapt the stack frame checks for arm architecture
Date:   Mon, 24 Jun 2019 10:55:36 +0100
Message-Id: <20190624095548.8578-7-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624095548.8578-1-raphael.gault@arm.com>
References: <20190624095548.8578-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the way the initial stack frame when entering a function is different
that what is done in the x86_64 architecture, we need to add some more
check to support the different cases.  As opposed as for x86_64, the return
address is not stored by the call instruction but is instead loaded in a
register. The initial stack frame is thus empty when entering a function
and 2 push operations are needed to set it up correctly. All the different
combinations need to be taken into account.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 tools/objtool/arch.h              |   2 +
 tools/objtool/arch/arm64/decode.c |  28 +++++++++
 tools/objtool/arch/x86/decode.c   |   5 ++
 tools/objtool/check.c             | 100 ++++++++++++++++++++++++++++--
 tools/objtool/elf.c               |   3 +-
 5 files changed, 131 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 53a72477c352..723600aae13f 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -89,4 +89,6 @@ unsigned long arch_jump_destination(struct instruction *insn);
 
 unsigned long arch_dest_rela_offset(int addend);
 
+bool arch_is_insn_sibling_call(struct instruction *insn);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 6c77ad1a08ec..5be1d87b1a1c 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -106,6 +106,34 @@ unsigned long arch_dest_rela_offset(int addend)
 	return addend;
 }
 
+/*
+ * In order to know if we are in presence of a sibling
+ * call and not in presence of a switch table we look
+ * back at the previous instructions and see if we are
+ * jumping inside the same function that we are already
+ * in.
+ */
+bool arch_is_insn_sibling_call(struct instruction *insn)
+{
+	struct instruction *prev;
+	struct list_head *l;
+	struct symbol *sym;
+	list_for_each_prev(l, &insn->list) {
+		prev = list_entry(l, struct instruction, list);
+		if (!prev->func ||
+		    prev->func->pfunc != insn->func->pfunc)
+			return false;
+		if (prev->stack_op.src.reg != ADR_SOURCE)
+			continue;
+		sym = find_symbol_containing(insn->sec, insn->immediate);
+		if (!sym || sym->type != STT_FUNC)
+			return false;
+		else if (sym->type == STT_FUNC)
+			return true;
+		break;
+	}
+	return false;
+}
 static int is_arm64(struct elf *elf)
 {
 	switch (elf->ehdr.e_machine) {
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 8767ee935c47..e2087ddced69 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -72,6 +72,11 @@ unsigned long arch_dest_rela_offset(int addend)
 	return addend + 4;
 }
 
+bool arch_is_insn_sibling_call(struct instruction *insn)
+{
+	return true;
+}
+
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, unsigned char *type,
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0fba7b70d73a..3172f49c3a58 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -568,10 +568,10 @@ static int add_jump_destinations(struct objtool_file *file)
 			dest_off = arch_jump_destination(insn);
 		} else if (rela->sym->type == STT_SECTION) {
 			dest_sec = rela->sym->sec;
-			dest_off = rela->addend + 4;
+			dest_off = arch_dest_rela_offset(rela->addend);
 		} else if (rela->sym->sec->idx) {
 			dest_sec = rela->sym->sec;
-			dest_off = rela->sym->sym.st_value + rela->addend + 4;
+			dest_off = rela->sym->sym.st_value + arch_dest_rela_offset(rela->addend);
 		} else if (strstr(rela->sym->name, "_indirect_thunk_")) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
@@ -1339,8 +1339,8 @@ static void save_reg(struct insn_state *state, unsigned char reg, int base,
 
 static void restore_reg(struct insn_state *state, unsigned char reg)
 {
-	state->regs[reg].base = CFI_UNDEFINED;
-	state->regs[reg].offset = 0;
+	state->regs[reg].base = initial_func_cfi.regs[reg].base;
+	state->regs[reg].offset = initial_func_cfi.regs[reg].offset;
 }
 
 /*
@@ -1496,8 +1496,32 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 
 				/* add imm, %rsp */
 				state->stack_size -= op->src.offset;
-				if (cfa->base == CFI_SP)
+				if (cfa->base == CFI_SP) {
 					cfa->offset -= op->src.offset;
+					if (state->stack_size == 0 &&
+					    initial_func_cfi.cfa.base == CFI_CFA) {
+						cfa->base = CFI_CFA;
+						cfa->offset = 0;
+					}
+				}
+				/*
+				 * on arm64 the save/restore of sp into fp is not automatic
+				 * and the first one can be done without the other so we
+				 * need to be careful not to invalidate the stack frame in such
+				 * cases.
+				 */
+				else if (cfa->base == CFI_BP) {
+					if (state->stack_size == 0 &&
+					    initial_func_cfi.cfa.base == CFI_CFA) {
+						cfa->base = CFI_CFA;
+						cfa->offset = 0;
+						restore_reg(state, CFI_BP);
+					}
+				} else if (cfa->base == CFI_CFA) {
+					cfa->base = CFI_SP;
+					if (state->stack_size >= 16)
+						cfa->offset = 16;
+				}
 				break;
 			}
 
@@ -1508,6 +1532,15 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 				break;
 			}
 
+			if (op->src.reg == CFI_SP && op->dest.reg == CFI_BP &&
+			    cfa->base == CFI_SP &&
+			    regs[CFI_BP].base == CFI_CFA &&
+			    regs[CFI_BP].offset == -cfa->offset) {
+				/* mov %rsp, %rbp */
+				cfa->base = op->dest.reg;
+				state->bp_scratch = false;
+				break;
+			}
 			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
 
 				/* drap: lea disp(%rsp), %drap */
@@ -1600,6 +1633,22 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 			state->stack_size -= 8;
 			if (cfa->base == CFI_SP)
 				cfa->offset -= 8;
+			if (cfa->base == CFI_SP &&
+			    cfa->offset == 0 &&
+			    initial_func_cfi.cfa.base == CFI_CFA)
+				cfa->base = CFI_CFA;
+
+			if (op->extra.used) {
+				if (regs[op->extra.reg].offset == -state->stack_size)
+					restore_reg(state, op->extra.reg);
+				state->stack_size -= 8;
+				if (cfa->base == CFI_SP)
+					cfa->offset -= 8;
+				if (cfa->base == CFI_SP &&
+				    cfa->offset == 0 &&
+				    initial_func_cfi.cfa.base == CFI_CFA)
+					cfa->base = CFI_CFA;
+			}
 
 			break;
 
@@ -1619,12 +1668,22 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 				/* drap: mov disp(%rbp), %reg */
 				restore_reg(state, op->dest.reg);
 
+				if (op->extra.used &&
+				    op->src.reg == CFI_BP &&
+				    op->extra.offset == regs[op->extra.reg].offset)
+					restore_reg(state, op->extra.reg);
+
 			} else if (op->src.reg == cfa->base &&
 			    op->src.offset == regs[op->dest.reg].offset + cfa->offset) {
 
 				/* mov disp(%rbp), %reg */
 				/* mov disp(%rsp), %reg */
 				restore_reg(state, op->dest.reg);
+
+				if (op->extra.used &&
+				    op->src.reg == cfa->base &&
+				    op->extra.offset == regs[op->extra.reg].offset + cfa->offset)
+					restore_reg(state, op->extra.reg);
 			}
 
 			break;
@@ -1640,6 +1699,8 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 	case OP_DEST_PUSH:
 	case OP_DEST_PUSHF:
 		state->stack_size += 8;
+		if (cfa->base == CFI_CFA)
+			cfa->base = CFI_SP;
 		if (cfa->base == CFI_SP)
 			cfa->offset += 8;
 
@@ -1673,6 +1734,21 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 			save_reg(state, op->src.reg, CFI_CFA, -state->stack_size);
 		}
 
+		if (op->extra.used) {
+			state->stack_size += 8;
+			if (cfa->base == CFI_CFA)
+				cfa->base = CFI_SP;
+			if (cfa->base == CFI_SP)
+				cfa->offset += 8;
+			if (!state->drap ||
+			    (!(op->extra.reg == cfa->base &&
+			       op->extra.reg == state->drap_reg) &&
+			     !(op->extra.reg == CFI_BP &&
+			       cfa->base == state->drap_reg) &&
+			     regs[op->extra.reg].base == CFI_UNDEFINED))
+			save_reg(state, op->extra.reg, CFI_CFA,
+				 -state->stack_size);
+		}
 		/* detect when asm code uses rbp as a scratch register */
 		if (!no_fp && insn->func && op->src.reg == CFI_BP &&
 		    cfa->base != CFI_BP)
@@ -1691,11 +1767,19 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 				/* save drap offset so we know when to restore it */
 				state->drap_offset = op->dest.offset;
 			}
+			if (op->extra.used && op->extra.reg == cfa->base &&
+			    op->extra.reg == state->drap_reg) {
+				cfa->base = CFI_BP_INDIRECT;
+				cfa->offset = op->extra.offset;
+			}
 
 			else if (regs[op->src.reg].base == CFI_UNDEFINED) {
 
 				/* drap: mov reg, disp(%rbp) */
 				save_reg(state, op->src.reg, CFI_BP, op->dest.offset);
+				if (op->extra.used)
+					save_reg(state, op->extra.reg, CFI_BP,
+						 op->extra.offset);
 			}
 
 		} else if (op->dest.reg == cfa->base) {
@@ -1704,8 +1788,12 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 			/* mov reg, disp(%rsp) */
 			save_reg(state, op->src.reg, CFI_CFA,
 				 op->dest.offset - state->cfa.offset);
+			if (op->extra.used)
+				save_reg(state, op->extra.reg, CFI_CFA,
+					 op->extra.offset - state->cfa.offset);
 		}
 
+
 		break;
 
 	case OP_DEST_LEAVE:
@@ -1828,7 +1916,7 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
 
 static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
 {
-	if (has_modified_stack_frame(state)) {
+	if (arch_is_insn_sibling_call(insn) && has_modified_stack_frame(state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
 				insn->sec, insn->offset);
 		return 1;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index e99e1be19ad9..b7033ec8ca20 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -62,7 +62,8 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 	struct symbol *sym;
 
 	list_for_each_entry(sym, &sec->symbol_list, list)
-		if (sym->type != STT_SECTION &&
+		if (sym->type != STT_NOTYPE &&
+		    sym->type != STT_SECTION &&
 		    sym->offset == offset)
 			return sym;
 
-- 
2.17.1

