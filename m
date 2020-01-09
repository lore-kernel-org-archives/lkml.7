Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF1C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE8F2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F03wF70x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbgAIQFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:05:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46250 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732954AbgAIQFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUZyYTZTlt6xExXoiyGlyEW363t3TFsZHEPKNeEJgoc=;
        b=F03wF70xW/8+flOmgMQn3PNHVXJ4ldXpE0qRoehlduTkNQwL0vCSnfsziE7mxrem/Tz6Zs
        JkF5QhBxnNHaQgunJas6fsOVNJ8bsb/nL7lmz4LnPHquAJSnIyNsUh/BwWIerB8uuYaJeS
        DYkAZQ1PYC8fvIrO/TMkeyLgQhhQtBY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-96aYfS9xNf-JQSxQGwJ4Vw-1; Thu, 09 Jan 2020 11:05:11 -0500
X-MC-Unique: 96aYfS9xNf-JQSxQGwJ4Vw-1
Received: by mail-wm1-f69.google.com with SMTP id c4so1091851wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUZyYTZTlt6xExXoiyGlyEW363t3TFsZHEPKNeEJgoc=;
        b=p609QhfliOYQKpSQokkfX8JsAwyE81FqEtIo8kBHNEaXY7Ih51hMRsd3Hc627rM0qd
         Cpe+TRTQgRFCpVJ4BjnQRkPEHV7DQiey0OgTrtC6RUXS+A9GIdpfm3NyRrcQr4gLemHc
         w6wKpmJ66Mrh+WA9HDbA7eCKU0kWXrg2i2ypxO0LyeL+i8LOGrwyI1aQ06w9Ix+npuKD
         bjq9KhkwEDqE0/kvCDsA6iogt4gwnK0AnRlELsaMAQ4hwBGZWnOcb0ffLtPSGEzSMpuG
         7JjfD3WzTQeMaAUSGe4QcMyYV5YkJ7XtFAhFwYLtngD7e8xOYw5E9hDqRTlwza1dtPBi
         366Q==
X-Gm-Message-State: APjAAAXaAk3/yPz5Uz8zYsSAkEL61tj3aFdYFA+LNY99r2ENxD2pHvwB
        NJrzGUEbNz3UhyORgnV7Mi0uqe4eKBF+pHFGmAiIdnAb3BwXayCAy6HE2RRiJ8dx9gf7pKqxzCL
        xWxXgYqE4H4pUICJ+YmL47Rl9
X-Received: by 2002:a1c:8086:: with SMTP id b128mr5785194wmd.80.1578585909224;
        Thu, 09 Jan 2020 08:05:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4QksIyxHYuyEaR7ATKTXxSgLBn8h9jbGh1vFZzsTsxowKxTbQnjsGE4vrFPLbQBd2CXwocg==
X-Received: by 2002:a1c:8086:: with SMTP id b128mr5785151wmd.80.1578585908897;
        Thu, 09 Jan 2020 08:05:08 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id d16sm9285303wrg.27.2020.01.09.08.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:05:08 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 18/57] objtool: Support multiple stack_op per instruction
Date:   Thu,  9 Jan 2020 16:02:21 +0000
Message-Id: <20200109160300.26150-19-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instruction sets can include more or less complex operations which might
not fit the currently defined set of stack_ops.

Combining more than one stack_op provides more flexibility to describe
the behaviour of an instruction. This also reduces the need to define
new stack_ops specific to a single instruction set.

Allow instruction decoders to generate multiple stack_op per
instruction.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch.h            |  4 +-
 tools/objtool/arch/x86/decode.c | 13 +++++-
 tools/objtool/check.c           | 79 +++++++++++++++++++++------------
 tools/objtool/check.h           |  2 +-
 4 files changed, 67 insertions(+), 31 deletions(-)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index a9a50a25ca66..f9883c431949 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -64,6 +64,7 @@ struct op_src {
 struct stack_op {
 	struct op_dest dest;
 	struct op_src src;
+	struct list_head list;
 };
 
 struct instruction;
@@ -73,7 +74,8 @@ void arch_initial_func_cfi_state(struct cfi_state *state);
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate, struct stack_op *op);
+			    unsigned long *immediate,
+			    struct list_head *ops_list);
 
 bool arch_callee_saved_reg(unsigned char reg);
 
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 79ff33ffa6e0..650e5d021486 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -75,13 +75,15 @@ unsigned long arch_dest_rela_offset(int addend)
 int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate, struct stack_op *op)
+			    unsigned long *immediate,
+			    struct list_head *ops_list)
 {
 	struct insn insn;
 	int x86_64, sign;
 	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
+	struct stack_op *op;
 
 	x86_64 = is_x86_64(elf);
 	if (x86_64 == -1)
@@ -122,6 +124,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 	if (insn.sib.nbytes)
 		sib = insn.sib.bytes[0];
 
+	op = calloc(1, sizeof(*op));
+	if (!op)
+		return -1;
+
 	switch (op1) {
 
 	case 0x1:
@@ -483,6 +489,11 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
 
+	if (*type == INSN_STACK)
+		list_add_tail(&op->list, ops_list);
+	else
+		free(op);
+
 	return 0;
 }
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 04434cdbdab6..48aec56a7760 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -246,6 +246,7 @@ static int decode_instructions(struct objtool_file *file)
 			}
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
+			INIT_LIST_HEAD(&insn->stack_ops);
 			clear_insn_state(&insn->state);
 
 			insn->sec = sec;
@@ -255,7 +256,7 @@ static int decode_instructions(struct objtool_file *file)
 						      sec->len - offset,
 						      &insn->len, &insn->type,
 						      &insn->immediate,
-						      &insn->stack_op);
+						      &insn->stack_ops);
 			if (ret)
 				goto err;
 
@@ -735,6 +736,7 @@ static int handle_group_alt(struct objtool_file *file,
 		}
 		memset(fake_jump, 0, sizeof(*fake_jump));
 		INIT_LIST_HEAD(&fake_jump->alts);
+		INIT_LIST_HEAD(&fake_jump->stack_ops);
 		clear_insn_state(&fake_jump->state);
 
 		fake_jump->sec = special_alt->new_sec;
@@ -1186,10 +1188,11 @@ static bool has_valid_stack_frame(struct insn_state *state)
 }
 
 #ifdef OBJTOOL_ORC
-static int update_insn_state_regs(struct instruction *insn, struct insn_state *state)
+static int update_insn_state_regs(struct instruction *insn,
+				  struct insn_state *state,
+				  struct stack_op *op)
 {
 	struct cfi_reg *cfa = &state->cfa;
-	struct stack_op *op = &insn->stack_op;
 
 	if (cfa->base != CFI_SP)
 		return 0;
@@ -1280,9 +1283,9 @@ static void restore_reg(struct insn_state *state, unsigned char reg)
  *   41 5d			pop    %r13
  *   c3				retq
  */
-static int update_insn_state(struct instruction *insn, struct insn_state *state)
+static int update_insn_state(struct instruction *insn, struct insn_state *state,
+			     struct stack_op *op)
 {
-	struct stack_op *op = &insn->stack_op;
 	struct cfi_reg *cfa = &state->cfa;
 	struct cfi_reg *regs = state->regs;
 
@@ -1297,7 +1300,7 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 
 #ifdef OBJTOOL_ORC
 	if (state->type == ORC_TYPE_REGS || state->type == ORC_TYPE_REGS_IRET)
-		return update_insn_state_regs(insn, state);
+		return update_insn_state_regs(insn, state, op);
 #endif
 
 	switch (op->dest.type) {
@@ -1653,6 +1656,42 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 	return 0;
 }
 
+static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
+{
+	struct stack_op *op;
+
+	list_for_each_entry(op, &insn->stack_ops, list) {
+		int res;
+
+		res = update_insn_state(insn, state, op);
+		if (res)
+			return res;
+
+		if (op->dest.type == OP_DEST_PUSHF) {
+			if (!state->uaccess_stack) {
+				state->uaccess_stack = 1;
+			} else if (state->uaccess_stack >> 31) {
+				WARN_FUNC("PUSHF stack exhausted",
+					  insn->sec, insn->offset);
+				return 1;
+			}
+			state->uaccess_stack <<= 1;
+			state->uaccess_stack  |= state->uaccess;
+		}
+
+		if (op->src.type == OP_SRC_POPF) {
+			if (state->uaccess_stack) {
+				state->uaccess = state->uaccess_stack & 1;
+				state->uaccess_stack >>= 1;
+				if (state->uaccess_stack == 1)
+					state->uaccess_stack = 0;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static bool insn_state_match(struct instruction *insn, struct insn_state *state)
 {
 	struct insn_state *state1 = &insn->state, *state2 = state;
@@ -1965,29 +2004,8 @@ static int validate_branch_alt_safe(struct objtool_file *file,
 			return 0;
 
 		case INSN_STACK:
-			if (update_insn_state(insn, &state))
+			if (handle_insn_ops(insn, &state))
 				return 1;
-
-			if (insn->stack_op.dest.type == OP_DEST_PUSHF) {
-				if (!state.uaccess_stack) {
-					state.uaccess_stack = 1;
-				} else if (state.uaccess_stack >> 31) {
-					WARN_FUNC("PUSHF stack exhausted", sec, insn->offset);
-					return 1;
-				}
-				state.uaccess_stack <<= 1;
-				state.uaccess_stack  |= state.uaccess;
-			}
-
-			if (insn->stack_op.src.type == OP_SRC_POPF) {
-				if (state.uaccess_stack) {
-					state.uaccess = state.uaccess_stack & 1;
-					state.uaccess_stack >>= 1;
-					if (state.uaccess_stack == 1)
-						state.uaccess_stack = 0;
-				}
-			}
-
 			break;
 
 		case INSN_STAC:
@@ -2232,12 +2250,17 @@ static void cleanup(struct objtool_file *file)
 {
 	struct instruction *insn, *tmpinsn;
 	struct alternative *alt, *tmpalt;
+	struct stack_op *op, *tmpop;
 
 	list_for_each_entry_safe(insn, tmpinsn, &file->insn_list, list) {
 		list_for_each_entry_safe(alt, tmpalt, &insn->alts, list) {
 			list_del(&alt->list);
 			free(alt);
 		}
+		list_for_each_entry_safe(op, tmpop, &insn->stack_ops, list) {
+			list_del(&op->list);
+			free(op);
+		}
 		list_del(&insn->list);
 		hash_del(&insn->hash);
 		free(insn);
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 843094cbae87..91adec42782c 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -43,7 +43,7 @@ struct instruction {
 	struct rela *jump_table;
 	struct list_head alts;
 	struct symbol *func;
-	struct stack_op stack_op;
+	struct list_head stack_ops;
 	struct insn_state state;
 	struct orc_entry orc;
 	bool intra_group_jump;
-- 
2.21.0

