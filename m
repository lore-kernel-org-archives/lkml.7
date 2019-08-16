Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F464C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D852E20644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfHPMY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:24:57 -0400
Received: from foss.arm.com ([217.140.110.172]:55842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfHPMYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:24:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 575081596;
        Fri, 16 Aug 2019 05:24:54 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D8CA3F706;
        Fri, 16 Aug 2019 05:24:53 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Cc:     peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC v4 10/18] objtool: arm64: Implement functions to add switch tables alternatives
Date:   Fri, 16 Aug 2019 13:23:55 +0100
Message-Id: <20190816122403.14994-11-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816122403.14994-1-raphael.gault@arm.com>
References: <20190816122403.14994-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the functions required to identify and add as
alternatives all the possible destinations of the switch table.
This implementation relies on the new plugin introduced previously which
records information about the switch-table in a .objtool_data section.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 tools/objtool/arch/arm64/arch_special.c       | 132 +++++++++++++++++-
 .../objtool/arch/arm64/include/arch_special.h |  10 ++
 .../objtool/arch/arm64/include/insn_decode.h  |   3 +-
 tools/objtool/check.c                         |   6 +-
 tools/objtool/check.h                         |   2 +
 5 files changed, 146 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/arch/arm64/arch_special.c b/tools/objtool/arch/arm64/arch_special.c
index 17a8a06aac2a..11284066157c 100644
--- a/tools/objtool/arch/arm64/arch_special.c
+++ b/tools/objtool/arch/arm64/arch_special.c
@@ -12,8 +12,13 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+#include <stdlib.h>
+#include <string.h>
+
 #include "../../special.h"
 #include "arch_special.h"
+#include "bit_operations.h"
 
 void arch_force_alt_path(unsigned short feature,
 			 bool uaccess,
@@ -21,9 +26,133 @@ void arch_force_alt_path(unsigned short feature,
 {
 }
 
+static u32 next_offset(u8 *table, u8 entry_size)
+{
+	switch (entry_size) {
+	case 1:
+		return table[0];
+	case 2:
+		return *(u16 *)(table);
+	default:
+		return *(u32 *)(table);
+	}
+}
+
+static u32 get_table_entry_size(u32 insn)
+{
+	unsigned char size = (insn >> 30) & ONES(2);
+	switch (size) {
+	case 0:
+		return 1;
+	case 1:
+		return 2;
+	default:
+		return 4;
+	}
+}
+
+static int add_possible_branch(struct objtool_file *file,
+			       struct instruction *insn,
+			       u32 base, u32 offset)
+{
+	struct instruction *dest_insn;
+	struct alternative *alt;
+	offset = base + 4 * offset;
+
+	alt = calloc(1, sizeof(*alt));
+	if (alt == NULL) {
+		WARN("allocation failure, can't add jump alternative");
+		return -1;
+	}
+
+	dest_insn = find_insn(file, insn->sec, offset);
+	if (dest_insn == NULL) {
+		free(alt);
+		return 0;
+	}
+	alt->insn = dest_insn;
+	alt->skip_orig = true;
+	list_add_tail(&alt->list, &insn->alts);
+	return 0;
+}
+
 int arch_add_jump_table(struct objtool_file *file, struct instruction *insn,
 			struct rela *table, struct rela *next_table)
 {
+	struct rela *objtool_data_rela = NULL;
+	struct switch_table_info *swt_info = NULL;
+	struct section *objtool_data = find_section_by_name(file->elf, ".objtool_data");
+	struct section *rodata_sec = find_section_by_name(file->elf, ".rodata");
+	struct section *branch_sec = NULL;
+	u8 *switch_table = NULL;
+	u64 base_offset = 0;
+	struct instruction *pre_jump_insn;
+	u32 sec_size = 0;
+	u32 entry_size = 0;
+	u32 offset = 0;
+	u32 i, j;
+
+	if (objtool_data == NULL)
+		return 0;
+
+	/*
+	 * 1. Using rela, Identify entry for the switch table
+	 * 2. Retrieve base offset
+	 * 3. Retrieve branch instruction
+	 * 3. For all entries in switch table:
+	 * 	3.1. Compute new offset
+	 * 	3.2. Create alternative instruction
+	 * 	3.3. Add alt_instr to insn->alts list
+	 */
+	sec_size = objtool_data->sh.sh_size;
+	for (i = 0, swt_info = (void *)objtool_data->data->d_buf;
+	     i < sec_size / sizeof(struct switch_table_info);
+	     i++, swt_info++) {
+		offset = i * sizeof(struct switch_table_info);
+		objtool_data_rela = find_rela_by_dest_range(objtool_data, offset,
+							    sizeof(u64));
+		/* retrieving the objtool data of the switch table we need */
+		if (objtool_data_rela == NULL ||
+		    table->sym->sec != objtool_data_rela->sym->sec ||
+		    table->addend != objtool_data_rela->addend)
+			continue;
+
+		/* retrieving switch table content */
+		switch_table = (u8 *)(rodata_sec->data->d_buf + table->addend);
+
+		/* retrieving pre jump instruction (ldr) */
+		branch_sec = insn->sec;
+		pre_jump_insn = find_insn(file, branch_sec,
+					  insn->offset - 3 * sizeof(u32));
+		entry_size = get_table_entry_size(*(u32 *)(branch_sec->data->d_buf + pre_jump_insn->offset));
+
+		/*
+		 * iterating over the pre-jumps instruction in order to
+		 * retrieve switch base offset.
+		 */
+		while (pre_jump_insn != NULL &&
+		       pre_jump_insn->offset <= insn->offset) {
+			if (pre_jump_insn->stack_op.src.reg == ADR_SOURCE) {
+				base_offset = pre_jump_insn->offset +
+					      pre_jump_insn->immediate;
+				/*
+				 * Once we have the switch table entry size
+				 * we add every possible destination using
+				 * alternatives of the original branch
+				 * instruction
+				 */
+				for (j = 0; j < swt_info->nb_entries; j++) {
+					if (add_possible_branch(file, insn,
+								base_offset,
+								next_offset(switch_table, entry_size))) {
+						return -1;
+					}
+					switch_table += entry_size;
+				}
+			}
+			pre_jump_insn = next_insn_same_sec(file, pre_jump_insn);
+		}
+	}
 	return 0;
 }
 
@@ -32,6 +161,5 @@ struct rela *arch_find_switch_table(struct objtool_file *file,
 				  struct section *rodata_sec,
 				  unsigned long table_offset)
 {
-	file->ignore_unreachables = true;
-	return NULL;
+	return text_rela;
 }
diff --git a/tools/objtool/arch/arm64/include/arch_special.h b/tools/objtool/arch/arm64/include/arch_special.h
index 185103be8a51..cba432fed80f 100644
--- a/tools/objtool/arch/arm64/include/arch_special.h
+++ b/tools/objtool/arch/arm64/include/arch_special.h
@@ -15,6 +15,8 @@
 #ifndef _ARM64_ARCH_SPECIAL_H
 #define _ARM64_ARCH_SPECIAL_H
 
+#include <linux/types.h>
+
 #define EX_ENTRY_SIZE		8
 #define EX_ORIG_OFFSET		0
 #define EX_NEW_OFFSET		4
@@ -30,6 +32,14 @@
 #define ALT_ORIG_LEN_OFFSET	10
 #define ALT_NEW_LEN_OFFSET	11
 
+#define ADR_SOURCE	255
+
+struct switch_table_info {
+	u64 switch_table_label;
+	u64 nb_entries;
+	u64 offset_unsigned;
+} __attribute__((__packed__));
+
 static inline bool arch_should_ignore_feature(unsigned short feature)
 {
 	return false;
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index a01d76306749..65b6efecd68f 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -18,6 +18,7 @@
 #define _ARM_INSN_DECODE_H
 
 #include "../../../arch.h"
+#include "arch_special.h"
 
 #define INSN_RESERVED	0b0000
 #define INSN_UNALLOC_1	0b0001
@@ -58,8 +59,6 @@
 #define COMPOSED_INSN_REGS_NUM	2
 #define INSN_COMPOSED	1
 
-#define ADR_SOURCE	-1
-
 typedef int (*arm_decode_class)(u32 instr, unsigned char *type,
 				unsigned long *immediate, struct stack_op *op);
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 18f7fb47392a..2c4ea51041e1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -35,8 +35,8 @@ struct instruction *find_insn(struct objtool_file *file,
 	return NULL;
 }
 
-static struct instruction *next_insn_same_sec(struct objtool_file *file,
-					      struct instruction *insn)
+struct instruction *next_insn_same_sec(struct objtool_file *file,
+				       struct instruction *insn)
 {
 	struct instruction *next = list_next_entry(insn, list);
 
@@ -1856,7 +1856,7 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
 {
 	if (arch_is_insn_sibling_call(insn) && has_modified_stack_frame(state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
-				insn->sec, insn->offset);
+			  insn->sec, insn->offset);
 		return 1;
 	}
 
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 267759760a3d..5833f85f71c3 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -66,6 +66,8 @@ int check(const char *objname, bool orc);
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
+struct instruction *next_insn_same_sec(struct objtool_file *file,
+				       struct instruction *insn);
 
 #define for_each_insn(file, insn)					\
 	list_for_each_entry(insn, &file->insn_list, list)
-- 
2.17.1

