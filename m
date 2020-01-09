Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA84C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD4B206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5eJCAJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbgAIQFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:05:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43172 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728333AbgAIQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XV84s1d1LXARfGRI5XvwgmL153zgl5bEcSpec4trBAU=;
        b=H5eJCAJMcHMjp0id9FJxOw0aGoNYuesFaYBa8YRGbKiCeeb8Qvhtcmg18TuiRfEjaYHQV0
        kfDpcFqXJAwH0A0dmOJr0jcR1VMB8Tu7psogEI+tDxxfHIrlQbsQW9Wkofna46LNdjLIAw
        rzVEPWwNF7YIMRH7Aw5vauSaVdxN0EM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-vaeMPZYVOdCFbn8M70PmAg-1; Thu, 09 Jan 2020 11:05:47 -0500
X-MC-Unique: vaeMPZYVOdCFbn8M70PmAg-1
Received: by mail-wm1-f72.google.com with SMTP id t17so617457wmi.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XV84s1d1LXARfGRI5XvwgmL153zgl5bEcSpec4trBAU=;
        b=njka2XIwnyLZ+nJey4eMvqoNeFMGAUpk/c5jKCUSqrZnkOXQV0hxrKOe6PTdflqbee
         JbpsVYmGLCFgEB/d2HqB+4S9cF1lOG60d4DclJZ3x26gQwMlv3gknO6TaPvGChKjZGfX
         H506IWW+noFJsXIHO7WKq3pqJs+NgXkHH+UkBv5EivthntbPiujCmh75nDbPWCJMhz6v
         BnELx+QdXz7/FnyW2OppDXm3xU5wfk6c5cxsAu1RgU3XafQsoTVIBV5W7n7kiVYARKS9
         b6gw8jafy+TAs7fUvA/7DpJJ9xvUeqRIAkA5A0ygbrh3IE4rpACc/62gWfkzGLfYNGfw
         ET2w==
X-Gm-Message-State: APjAAAWzVdkus10jBHbvhF91VnZyDyO0x08UJymJmhCHs3+8xbG1QD9y
        agJlyTXI5yniS9HPdEYfmY2mz9k+B6yiSHZVspUh/mqC9IIFLYsPda5QAhOgQOhq2RCoBNnw6Z2
        VPCByLjBy4bZ73WmsHNwO0woJ
X-Received: by 2002:adf:ef92:: with SMTP id d18mr11387509wro.234.1578585945686;
        Thu, 09 Jan 2020 08:05:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzfegkeI1UxER55TgVqDuAMftZI6GF0dVFGZz86ZmeW75YjI/CiYezeaVwYmkistCPIOFlkQ==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr11387478wro.234.1578585945448;
        Thu, 09 Jan 2020 08:05:45 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id a16sm8545544wrt.37.2020.01.09.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:05:44 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 22/57] objtool: arm64: Decode add/sub immediate instructions
Date:   Thu,  9 Jan 2020 16:02:25 +0000
Message-Id: <20200109160300.26150-23-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode instruction adding immediates to registers. Create stack
operation for instructions interacting with the stack pointer or the
frame pointer.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 84 +++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  7 ++
 2 files changed, 91 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 6c8db9335fc9..d240f29a2390 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -13,6 +13,11 @@
 #include "../../elf.h"
 #include "../../warn.h"
 
+static bool stack_related_reg(int reg)
+{
+	return reg == CFI_SP || reg == CFI_BP;
+}
+
 bool arch_callee_saved_reg(unsigned char reg)
 {
 	switch (reg) {
@@ -153,6 +158,8 @@ int arm_decode_unknown(u32 instr, enum insn_type *type,
 
 static arm_decode_class aarch64_insn_dp_imm_decode_table[NR_DP_IMM_SUBCLASS] = {
 	[0 ... INSN_PCREL]	= arm_decode_pcrel,
+	[INSN_ADD_SUB]		= arm_decode_add_sub,
+	[INSN_ADD_TAG]		= arm_decode_add_sub_tags,
 	[INSN_MOVE_WIDE]	= arm_decode_move_wide,
 	[INSN_BITFIELD]		= arm_decode_bitfield,
 	[INSN_EXTRACT]		= arm_decode_extract,
@@ -189,6 +196,83 @@ int arm_decode_pcrel(u32 instr, enum insn_type *type,
 	return 0;
 }
 
+int arm_decode_add_sub(u32 instr, enum insn_type *type,
+		       unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned long imm12 = 0, imm = 0;
+	unsigned char sf = 0, sh = 0, S = 0, op_bit = 0;
+	unsigned char rn = 0, rd = 0;
+
+	S = EXTRACT_BIT(instr, 29);
+	op_bit = EXTRACT_BIT(instr, 30);
+	sf = EXTRACT_BIT(instr, 31);
+	sh = EXTRACT_BIT(instr, 22);
+	rd = instr & ONES(5);
+	rn = (instr >> 5) & ONES(5);
+	imm12 = (instr >> 10) & ONES(12);
+	imm = ZERO_EXTEND(imm12 << (sh * 12), (sf + 1) * 32);
+
+	*type = INSN_OTHER;
+
+	if (rd == CFI_BP || (!S && rd == CFI_SP) || stack_related_reg(rn)) {
+		struct stack_op *op;
+
+		*type = INSN_STACK;
+
+		op = calloc(1, sizeof(*op));
+		list_add_tail(&op->list, ops_list);
+
+		op->dest.type = OP_DEST_REG;
+		op->dest.offset = 0;
+		op->dest.reg = rd;
+		op->src.type = OP_SRC_ADD;
+		op->src.offset = op_bit ? -1 * imm : imm;
+		op->src.reg = rn;
+	}
+	return 0;
+}
+
+int arm_decode_add_sub_tags(u32 instr, enum insn_type *type,
+			    unsigned long *immediate,
+			    struct list_head *ops_list)
+{
+	unsigned char decode_field = 0, rn = 0, rd = 0, uimm6 = 0;
+
+	decode_field = (instr >> 29) & ONES(3);
+	rd = instr & ONES(5);
+	rn = (instr >> 5) & ONES(5);
+	uimm6 = (instr >> 16) & ONES(6);
+
+	*immediate = uimm6;
+	*type = INSN_OTHER;
+
+#define ADDG_DECODE	4
+#define SUBG_DECODE	5
+	if (decode_field != ADDG_DECODE && decode_field != SUBG_DECODE)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+#undef ADDG_DECODE
+#undef SUBG_DECODE
+
+	if (stack_related_reg(rd)) {
+		struct stack_op *op;
+
+		*type = INSN_STACK;
+
+		op = calloc(1, sizeof(*op));
+		list_add_tail(&op->list, ops_list);
+
+		op->dest.type = OP_DEST_REG;
+		op->dest.offset = 0;
+		op->dest.reg = rd;
+		op->src.type = OP_SRC_ADD;
+		op->src.offset = 0;
+		op->src.reg = rn;
+	}
+
+	return 0;
+}
+
 int arm_decode_move_wide(u32 instr, enum insn_type *type,
 			 unsigned long *immediate, struct list_head *ops_list)
 {
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 06235d81300c..65e60b293a07 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -14,6 +14,8 @@
 #define INSN_CLASS(opcode)	(((opcode) >> 25) & (NR_INSN_CLASS - 1))
 
 #define INSN_PCREL	0b001	//0b00x
+#define INSN_ADD_SUB	0b010
+#define INSN_ADD_TAG	0b011
 #define INSN_MOVE_WIDE	0b101
 #define INSN_BITFIELD	0b110
 #define INSN_EXTRACT	0b111
@@ -31,6 +33,11 @@ int arm_decode_unknown(u32 instr, enum insn_type *type,
 /* arm64 data processing -- immediate subclasses */
 int arm_decode_pcrel(u32 instr, enum insn_type *type,
 		     unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_add_sub(u32 instr, enum insn_type *type,
+		       unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_add_sub_tags(u32 instr, enum insn_type *type,
+			    unsigned long *immediate,
+			    struct list_head *ops_list);
 int arm_decode_move_wide(u32 instr, enum insn_type *type,
 			 unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_bitfield(u32 instr, enum insn_type *type,
-- 
2.21.0

