Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A8BC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892B120644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfHPMYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:24:42 -0400
Received: from foss.arm.com ([217.140.110.172]:55744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfHPMYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:24:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5F4A360;
        Fri, 16 Aug 2019 05:24:40 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C3BE3F706;
        Fri, 16 Aug 2019 05:24:39 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Cc:     peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC v4 01/18] objtool: Add abstraction for computation of symbols offsets
Date:   Fri, 16 Aug 2019 13:23:46 +0100
Message-Id: <20190816122403.14994-2-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816122403.14994-1-raphael.gault@arm.com>
References: <20190816122403.14994-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jump destination and relocation offset used previously are only
reliable on x86_64 architecture. We abstract these computations by calling
arch-dependent implementations.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 tools/objtool/arch.h            |  6 ++++++
 tools/objtool/arch/x86/decode.c | 11 +++++++++++
 tools/objtool/check.c           | 15 ++++++++++-----
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index ced3765c4f44..a9a50a25ca66 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -66,6 +66,8 @@ struct stack_op {
 	struct op_src src;
 };
 
+struct instruction;
+
 void arch_initial_func_cfi_state(struct cfi_state *state);
 
 int arch_decode_instruction(struct elf *elf, struct section *sec,
@@ -75,4 +77,8 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 bool arch_callee_saved_reg(unsigned char reg);
 
+unsigned long arch_jump_destination(struct instruction *insn);
+
+unsigned long arch_dest_rela_offset(int addend);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 0567c47a91b1..fa33b3465722 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -11,6 +11,7 @@
 #include "lib/inat.c"
 #include "lib/insn.c"
 
+#include "../../check.h"
 #include "../../elf.h"
 #include "../../arch.h"
 #include "../../warn.h"
@@ -66,6 +67,11 @@ bool arch_callee_saved_reg(unsigned char reg)
 	}
 }
 
+unsigned long arch_dest_rela_offset(int addend)
+{
+	return addend + 4;
+}
+
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -497,3 +503,8 @@ void arch_initial_func_cfi_state(struct cfi_state *state)
 	state->regs[16].base = CFI_CFA;
 	state->regs[16].offset = -8;
 }
+
+unsigned long arch_jump_destination(struct instruction *insn)
+{
+	return insn->offset + insn->len + insn->immediate;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 176f2f084060..479fab46b656 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -563,7 +563,7 @@ static int add_jump_destinations(struct objtool_file *file)
 					       insn->len);
 		if (!rela) {
 			dest_sec = insn->sec;
-			dest_off = insn->offset + insn->len + insn->immediate;
+			dest_off = arch_jump_destination(insn);
 		} else if (rela->sym->type == STT_SECTION) {
 			dest_sec = rela->sym->sec;
 			dest_off = rela->addend + 4;
@@ -659,7 +659,7 @@ static int add_call_destinations(struct objtool_file *file)
 		rela = find_rela_by_dest_range(insn->sec, insn->offset,
 					       insn->len);
 		if (!rela) {
-			dest_off = insn->offset + insn->len + insn->immediate;
+			dest_off = arch_jump_destination(insn);
 			insn->call_dest = find_symbol_by_offset(insn->sec,
 								dest_off);
 
@@ -672,14 +672,19 @@ static int add_call_destinations(struct objtool_file *file)
 			}
 
 		} else if (rela->sym->type == STT_SECTION) {
+			/*
+			 * the original x86_64 code adds 4 to the rela->addend
+			 * which is not needed on arm64 architecture.
+			 */
+			dest_off = arch_dest_rela_offset(rela->addend);
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
-- 
2.17.1

