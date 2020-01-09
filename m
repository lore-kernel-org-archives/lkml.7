Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBE2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F51820661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahrSL2tC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbgAIQHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:07:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39684 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733111AbgAIQHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y8iVqwlPqx8D0v6wn+sNinncmvzZmA9bOrVw84GrFXg=;
        b=ahrSL2tCBD59ZtH991n0E40VoyxroaxQ0r7wtMA8p64cB+P5EbiKejXlXsQbLMb4rq2vK2
        3qjSZUlIJ+BKwtQcdZvV1lPSA0X4AOm3P7YrkSclzJsDS9xPe0MgFKNWGiiPM+SO+qcPHf
        xZe0LsJN5OeOv8b96eyTkXa4rBb2DRQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-PI_0MAUtP9ClNROskyqSHA-1; Thu, 09 Jan 2020 11:07:03 -0500
X-MC-Unique: PI_0MAUtP9ClNROskyqSHA-1
Received: by mail-wm1-f69.google.com with SMTP id s25so621397wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8iVqwlPqx8D0v6wn+sNinncmvzZmA9bOrVw84GrFXg=;
        b=VjUjx7MYA0q8lOfGIOWVskO3mic6LD207BxEu11/Dr43UYfJLiKDEqDWMKHTGuffIX
         yXNjRWbbiTeAPnIhTPDAP46BdevJsHlPMCcjkl3qZBsh813PbV4cZ/2b7L/b7Vj6o7HJ
         u/1nZ3Y4odpqm75BnFmbSNEtujus84s1cuqQLL9jN/E4faa/wLDeW5GaJ2tceAXs9f6Q
         fcbh1sni4YoxZ+uFuveWdNbZjCb7NqbeeI1WrABFi9Lie4oq4CCeKtKCLGyb803gU55o
         N2j97OPoph5AgcSlhitr26rfDp+GElPmbFJHATpk3yUaa1Mc/cZUjt2Gx3asRvJpQC8t
         gR9Q==
X-Gm-Message-State: APjAAAVMHDUitMElR8n55Yr2xOQkYuF4r/2brPSwcOwn6QC2/F3YDIay
        PX9C+046n7umGKJmMd/R2M2q6KyargjqLHGfraYu/Ed2lYXN+QY4Ju3ncNECMd2/yq1ybecpgHx
        yRxqW2x8g+aNm0PYXFJ4yLZ9W
X-Received: by 2002:adf:fd43:: with SMTP id h3mr11468140wrs.169.1578586022089;
        Thu, 09 Jan 2020 08:07:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUxQHjrf4FRdDbNfOTNXug87kNQAURNGlHTw3u5DPgWcuL7CdH67/0NDbY/vvhci1xsXh2QA==
X-Received: by 2002:adf:fd43:: with SMTP id h3mr11468101wrs.169.1578586021736;
        Thu, 09 Jan 2020 08:07:01 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id q3sm9123252wrn.33.2020.01.09.08.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:07:01 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 32/57] objtool: arm64: Decode load/store register pair instructions
Date:   Thu,  9 Jan 2020 16:02:35 +0000
Message-Id: <20200109160300.26150-33-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode load/store instruction to a pair of registers. Split the
instruction into two stack operations, one for each register.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 220 ++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  12 +
 2 files changed, 232 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index 00d5d627af08..2aaac4e3786c 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -810,6 +810,26 @@ int arm_decode_br_uncond_reg(u32 instr, enum insn_type *type,
 #undef INSN_DRPS_MASK
 
 static struct aarch64_insn_decoder ld_st_decoder[] = {
+	{
+		.mask = 0b001101100000000,
+		.value = 0b001000000000000,
+		.decode_func = arm_decode_ld_st_noalloc_pair_off,
+	},
+	{
+		.mask = 0b001101100000000,
+		.value = 0b001000100000000,
+		.decode_func = arm_decode_ld_st_regs_pair_post,
+	},
+	{
+		.mask = 0b001101100000000,
+		.value = 0b001001000000000,
+		.decode_func = arm_decode_ld_st_regs_pair_off,
+	},
+	{
+		.mask = 0b001101100000000,
+		.value = 0b001001100000000,
+		.decode_func = arm_decode_ld_st_regs_pair_pre,
+	},
 	{
 		.mask = 0b001101010000011,
 		.value = 0b001100000000000,
@@ -1234,3 +1254,203 @@ int arm_decode_ld_st_regs_off(u32 instr, enum insn_type *type,
 
 	return 0;
 }
+
+int arm_decode_ld_st_noalloc_pair_off(u32 instr, enum insn_type *type,
+				      unsigned long *immediate,
+				      struct list_head *ops_list)
+{
+	unsigned char opc = 0, V = 0, L = 0;
+	unsigned char decode_field = 0;
+
+	opc = (instr >> 30) & ONES(2);
+	V = EXTRACT_BIT(instr, 26);
+	L = EXTRACT_BIT(instr, 22);
+
+	decode_field = (opc << 2) | (V << 1) | L;
+
+	if (decode_field == 0x4 ||
+	    decode_field == 0x5 ||
+	    decode_field >= 12) {
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+	}
+	return arm_decode_ld_st_regs_pair_off(instr, type, immediate, ops_list);
+}
+
+int arm_decode_ld_st_regs_pair_off(u32 instr, enum insn_type *type,
+				   unsigned long *immediate,
+				   struct list_head *ops_list)
+{
+	unsigned char opc = 0, V = 0, L = 0, bit = 0;
+	unsigned char imm7 = 0, rt2 = 0, rt = 0, rn = 0;
+	unsigned char decode_field = 0;
+	struct stack_op *op;
+	int scale = 0;
+
+	opc = (instr >> 30) & ONES(2);
+	V = EXTRACT_BIT(instr, 26);
+	L = EXTRACT_BIT(instr, 22);
+	imm7 = (instr >> 15) & ONES(7);
+	rt2 = (instr >> 10) & ONES(5);
+	rn = (instr >> 5) & ONES(5);
+	rt = instr & ONES(5);
+	bit = EXTRACT_BIT(opc, 1);
+	scale = 2 + bit;
+
+	decode_field = (opc << 2) | (V << 1) | L;
+
+	if (decode_field >= 0xC)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	*immediate = (SIGN_EXTEND(imm7, 7)) << scale;
+
+	if (!stack_related_reg(rn)) {
+		*type = INSN_OTHER;
+		return 0;
+	}
+
+	*type = INSN_STACK;
+
+	op = calloc(1, sizeof(*op));
+	list_add_tail(&op->list, ops_list);
+	switch (decode_field) {
+	case 1:
+	case 3:
+	case 5:
+	case 7:
+	case 9:
+	case 11:
+		/* load */
+		op->src.type = OP_SRC_REG_INDIRECT;
+		op->src.reg = rn;
+		op->src.offset = *immediate;
+		op->dest.type = OP_DEST_REG;
+		op->dest.reg = rt;
+		op->dest.offset = 0;
+		{
+			struct stack_op *extra;
+
+			extra = malloc(sizeof(*extra));
+			extra->src.type = OP_SRC_REG_INDIRECT;
+			extra->src.reg = rn;
+			extra->src.offset = (int)*immediate + 8;
+			extra->dest.type = OP_DEST_REG;
+			extra->dest.reg = rt2;
+			extra->dest.offset = 0;
+
+			list_add_tail(&extra->list, ops_list);
+		}
+		break;
+	default:
+		op->dest.type = OP_DEST_REG_INDIRECT;
+		op->dest.reg = rn;
+		op->dest.offset = (int)*immediate + 8;
+		op->src.type = OP_SRC_REG;
+		op->src.reg = rt2;
+		op->src.offset = 0;
+		{
+			struct stack_op *extra;
+
+			extra = malloc(sizeof(*extra));
+			extra->dest.type = OP_DEST_REG_INDIRECT;
+			extra->dest.reg = rn;
+			extra->dest.offset = *immediate;
+			extra->src.type = OP_SRC_REG;
+			extra->src.reg = rt;
+			extra->src.offset = 0;
+
+			list_add_tail(&extra->list, ops_list);
+		}
+		/* store */
+	}
+	return 0;
+}
+
+int arm_decode_ld_st_regs_pair_post(u32 instr, enum insn_type *type,
+				    unsigned long *immediate,
+				    struct list_head *ops_list)
+{
+	int ret = 0;
+	unsigned int base_reg;
+	bool base_is_src;
+	struct stack_op *op;
+	struct stack_op *post_inc;
+
+	ret = arm_decode_ld_st_regs_pair_off(instr, type, immediate, ops_list);
+	if (ret < 0 || *type == INSN_OTHER)
+		return ret;
+
+	op = list_first_entry(ops_list, typeof(*op), list);
+	if (op->dest.type == OP_DEST_REG_INDIRECT) {
+		base_reg = op->dest.reg;
+		base_is_src = false;
+	} else if (op->src.type == OP_SRC_REG_INDIRECT) {
+		base_reg = op->src.reg;
+		base_is_src = true;
+	} else {
+		WARN("Unexpected base type");
+		return -1;
+	}
+
+	post_inc = malloc(sizeof(*post_inc));
+	post_inc->dest.type = OP_DEST_REG;
+	post_inc->dest.reg = base_reg;
+	post_inc->src.reg = base_reg;
+	post_inc->src.type = OP_SRC_ADD;
+	post_inc->src.offset = (int)*immediate;
+
+	/* Adapt offsets */
+	list_for_each_entry(op, ops_list, list) {
+		if (!base_is_src)
+			op->dest.offset -= post_inc->src.offset;
+		else
+			op->src.offset -= post_inc->src.offset;
+	}
+	list_add_tail(&post_inc->list, ops_list);
+
+	return ret;
+}
+
+int arm_decode_ld_st_regs_pair_pre(u32 instr, enum insn_type *type,
+				   unsigned long *immediate,
+				   struct list_head *ops_list)
+{
+	int ret = 0;
+	unsigned int base_reg;
+	bool base_is_src;
+	struct stack_op *op;
+	struct stack_op *pre_inc;
+
+	ret = arm_decode_ld_st_regs_pair_off(instr, type, immediate, ops_list);
+	if (ret < 0 || *type == INSN_OTHER)
+		return ret;
+
+	op = list_first_entry(ops_list, typeof(*op), list);
+	if (op->dest.type == OP_DEST_REG_INDIRECT) {
+		base_reg = op->dest.reg;
+		base_is_src = false;
+	} else if (op->src.type == OP_SRC_REG_INDIRECT) {
+		base_reg = op->src.reg;
+		base_is_src = true;
+	} else {
+		WARN("Unexpected base type");
+		return -1;
+	}
+
+	pre_inc = malloc(sizeof(*pre_inc));
+	pre_inc->dest.type = OP_DEST_REG;
+	pre_inc->dest.reg = base_reg;
+	pre_inc->src.type = OP_SRC_ADD;
+	pre_inc->src.reg = base_reg;
+	pre_inc->src.offset = (int)*immediate;
+
+	/* Adapt offsets */
+	list_for_each_entry(op, ops_list, list) {
+		if (!base_is_src)
+			op->dest.offset -= pre_inc->src.offset;
+		else
+			op->src.offset -= pre_inc->src.offset;
+	}
+	list_add(&pre_inc->list, ops_list);
+
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 9043ca6f6708..caeb40942b18 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -94,6 +94,18 @@ int arm_decode_br_uncond_reg(u32 instr, enum insn_type *type,
 			     struct list_head *ops_list);
 
 /* arm64 load/store instructions */
+int arm_decode_ld_st_noalloc_pair_off(u32 instr, enum insn_type *type,
+				      unsigned long *immediate,
+				      struct list_head *ops_list);
+int arm_decode_ld_st_regs_pair_post(u32 instr, enum insn_type *type,
+				    unsigned long *immediate,
+				    struct list_head *ops_list);
+int arm_decode_ld_st_regs_pair_off(u32 instr, enum insn_type *type,
+				   unsigned long *immediate,
+				   struct list_head *ops_list);
+int arm_decode_ld_st_regs_pair_pre(u32 instr, enum insn_type *type,
+				   unsigned long *immediate,
+				   struct list_head *ops_list);
 int arm_decode_ld_st_regs_unsc_imm(u32 instr, enum insn_type *type,
 				   unsigned long *immediate,
 				   struct list_head *ops_list);
-- 
2.21.0

