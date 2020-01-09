Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB34C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E7B2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JK7RsOVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbgAIQHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:07:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22523 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733208AbgAIQHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xG6sElk1TWaSPfOVhfzeE5hLeD/94IftIcvZ9UXhm3w=;
        b=JK7RsOVOmclRUxZlQhhSJJSCDhP1Tj+e+rNHYQTgI1WvUQehnIbxZmpX+DwyYuPQm6o0d8
        tA8kYG8hkhxLm4ADCTwVQ5FDLGuCsaTu6+4bGyLBf/QLOvjnwHCuX1aZeQmM3LTAHm3M+g
        M8k0UjzazgoX9KGYzUwyC4oFj0BUtq8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-ebENgCx6MTWLfpZqNMzA1g-1; Thu, 09 Jan 2020 11:07:44 -0500
X-MC-Unique: ebENgCx6MTWLfpZqNMzA1g-1
Received: by mail-wm1-f72.google.com with SMTP id b131so1093807wmd.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xG6sElk1TWaSPfOVhfzeE5hLeD/94IftIcvZ9UXhm3w=;
        b=gFN/Uwb8PVF/rdWf8UyTm4Hg+hqhI+pgOqgjCHr0InyjxVd5qbHdqqjMqvvW7kP0Z8
         QXF0lnCoT6kwBDGRpbGNJoZYGL/SkWe145hlWIQ6G3V61U89aqe3Vzb8wisPHq0OUEFg
         N9Rvtwy0vhOF+l3vN/mDlSDt5ZTfZeUGiJwkWRMGk1Snt1qeqjOB8/9SwdqlOrSQTEpW
         3ssWSxWLCZS/puCC+kRkaM/IyM3leDqujSxmY3LmfK9HofbxCgvYySH7FiyLbNBqgjH9
         BCGirkIQkJGVtuSZyBiS9qobrGoKfnqB47AiT5ERqhPFvijvB/+pl9+zVQJ9cjOa2DEW
         m0oQ==
X-Gm-Message-State: APjAAAXBO0dnYLivgTjbITTpEnuGngqQHMRtIpuct1iwUI4mPi8Nh+PV
        8mDnZFzglhfNdPzDt+O+6OfWwFgGhyNY94Yzd32WMWe3Lx4o1bSNGR3+Ko2C21iGylx7FtE+QC8
        yaboA+q2JoRD43uzX7l4ne6/n
X-Received: by 2002:a7b:c750:: with SMTP id w16mr6085420wmk.46.1578586063348;
        Thu, 09 Jan 2020 08:07:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwWrOqLS9+8+0m7ijSmLbqAeygM5PyihSPgaHJWkEuiZnRqKxhbclKLJ2IbV39zii6sYZGEFQ==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr6085384wmk.46.1578586063095;
        Thu, 09 Jan 2020 08:07:43 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id h2sm8591413wrv.66.2020.01.09.08.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:07:42 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 39/57] objtool: arm64: Decode load literal
Date:   Thu,  9 Jan 2020 16:02:42 +0000
Message-Id: <20200109160300.26150-40-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode load literal instruction.

Aarch64 load literal is a pseudo-instruction (part of the instruction
set) that allows to load literal values may cannot be encoded within
a single instruction. The GNU assembler implementation of the pseudo
instruction generates constant data within the same section as the
pseudo-instruction itself.

That data could very well be a valid opcode (e.g. jump, return,
stack operation, etc) which confuses objtool.

Mark the "instructions" corresponding to load literal offsets as
invalid as they should never be reach by the execution flow.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch.h                          |  3 +
 tools/objtool/arch/arm64/decode.c             | 88 +++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  3 +
 tools/objtool/arch/x86/decode.c               |  5 ++
 tools/objtool/check.c                         |  3 +
 5 files changed, 102 insertions(+)

diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index 0336efecb9d9..829d6d73aec6 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -68,6 +68,7 @@ struct stack_op {
 	struct list_head list;
 };
 
+struct objtool_file;
 struct instruction;
 
 void arch_initial_func_cfi_state(struct cfi_state *state);
@@ -78,6 +79,8 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 			    unsigned long *immediate,
 			    struct list_head *ops_list);
 
+int arch_post_process_file(struct objtool_file *file);
+
 bool arch_callee_saved_reg(unsigned char reg);
 
 unsigned long arch_jump_destination(struct instruction *insn);
diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index bc4c62401012..aed8ba0f812e 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -18,6 +18,47 @@ static bool stack_related_reg(int reg)
 	return reg == CFI_SP || reg == CFI_BP;
 }
 
+struct insn_loc {
+	struct section *sec;
+	unsigned long offset;
+	struct hlist_node hnode;
+};
+
+DEFINE_HASHTABLE(text_constants, 16);
+
+int arch_post_process_file(struct objtool_file *file)
+{
+	struct hlist_node *tmp;
+	struct insn_loc *loc;
+	unsigned int bkt;
+	int res = 0;
+
+	/*
+	 * Data placed in code sections could turn out to be a valid aarch64
+	 * opcode.
+	 * If that is the case, change the insn type to invalid as it should
+	 * never be reached by the execution flow.
+	 */
+	hash_for_each_safe(text_constants, bkt, tmp, loc, hnode) {
+		struct instruction *insn;
+
+		insn = find_insn(file, loc->sec, loc->offset);
+		if (insn) {
+			insn->type = INSN_INVALID;
+		} else {
+			WARN("failed to find constant at %s+0x%lx",
+			     loc->sec->name, loc->offset);
+			res = -1;
+		}
+		hash_del(&loc->hnode);
+		free(loc);
+	}
+
+	return res;
+}
+
+static struct insn_loc current_location;
+
 bool arch_callee_saved_reg(unsigned char reg)
 {
 	switch (reg) {
@@ -127,6 +168,8 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 	//retrieve instruction (from sec->data->offset)
 	insn = *(u32 *)(sec->data->d_buf + offset);
 
+	current_location.sec = sec;
+	current_location.offset = offset;
 	//dispatch according to encoding classes
 	decode_fun = aarch64_insn_class_decode_table[INSN_CLASS(insn)];
 	if (decode_fun)
@@ -136,6 +179,9 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 	if (res)
 		WARN_FUNC("Unsupported instruction", sec, offset);
+
+	memset(&current_location, 0, sizeof(current_location));
+
 	return res;
 }
 
@@ -845,6 +891,11 @@ static struct aarch64_insn_decoder ld_st_decoder[] = {
 		.value = 0b000101000000000,
 		.decode_func = arm_decode_ldapr_stlr_unsc_imm,
 	},
+	{
+		.mask = 0b001101000000000,
+		.value = 0b000100000000000,
+		.decode_func = arm_decode_ld_regs_literal,
+	},
 	{
 		.mask = 0b001101100000000,
 		.value = 0b001000000000000,
@@ -1350,6 +1401,43 @@ int arm_decode_ld_st_exclusive(u32 instr, enum insn_type *type,
 #undef LDLAR_64
 #undef LDAR_64
 
+int arm_decode_ld_regs_literal(u32 instr, enum insn_type *type,
+			       unsigned long *immediate,
+			       struct list_head *ops_list)
+{
+	unsigned char opc = 0, V = 0;
+	long pc_offset;
+	struct insn_loc *loc;
+
+	opc = (instr >> 30) & ONES(2);
+	V = EXTRACT_BIT(instr, 26);
+
+	if (((opc << 1) | V) == 0x7)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	pc_offset = instr & GENMASK(23, 5);
+
+	/* Sign extend and multiply by 4 */
+	pc_offset = (pc_offset << (64 - 23));
+	pc_offset = ((pc_offset >> (64 - 23)) >> 5) << 2;
+
+	loc = malloc(sizeof(*loc));
+	loc->sec = current_location.sec;
+	loc->offset = current_location.offset + pc_offset;
+	hash_add(text_constants, &loc->hnode, loc->offset);
+
+	/* 64-bit literal */
+	if (opc & 1) {
+		loc = malloc(sizeof(*loc));
+		loc->sec = current_location.sec;
+		loc->offset = current_location.offset + pc_offset + 4;
+		hash_add(text_constants, &loc->hnode, loc->offset);
+	}
+
+	*type = INSN_OTHER;
+	return 0;
+}
+
 int arm_decode_ld_st_regs_unsc_imm(u32 instr, enum insn_type *type,
 				   unsigned long *immediate,
 				   struct list_head *ops_list)
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index e6a62691b487..3ec4c69547ac 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -112,6 +112,9 @@ int arm_decode_ld_st_mem_tags(u32 instr, enum insn_type *type,
 int arm_decode_ldapr_stlr_unsc_imm(u32 instr, enum insn_type *type,
 				   unsigned long *immediate,
 				   struct list_head *ops_list);
+int arm_decode_ld_regs_literal(u32 instr, enum insn_type *type,
+			       unsigned long *immediate,
+			       struct list_head *ops_list);
 int arm_decode_ld_st_noalloc_pair_off(u32 instr, enum insn_type *type,
 				      unsigned long *immediate,
 				      struct list_head *ops_list);
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 650e5d021486..57a5f817a63c 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -497,6 +497,11 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 	return 0;
 }
 
+int arch_post_process_file(struct objtool_file *file)
+{
+	return 0;
+}
+
 void arch_initial_func_cfi_state(struct cfi_state *state)
 {
 	int i;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 52a8e64e15ca..e0c6bda261c8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -279,6 +279,9 @@ static int decode_instructions(struct objtool_file *file)
 		}
 	}
 
+	if (arch_post_process_file(file))
+		return -1;
+
 	return 0;
 
 err:
-- 
2.21.0

