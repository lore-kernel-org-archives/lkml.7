Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D440C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA6F20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYmlyXtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbgAIQHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:07:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36806 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728567AbgAIQHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Xq2TYaoyKIaoZWWIj0lFf3WygPVLaBw/8+8QDSMChc=;
        b=SYmlyXtrC820unBSdjKhKPqZax6bwgcugloFXD1jGNUz20NKWzDOQJVmU9ErnJo+GkOxQZ
        j6hN8OtE7IPCJ70/lgMys1qB8t0zmSkxvkbY8dCtQ1Lbxyke8eX3wrf+XlWIYZGqFUd/43
        GX6+nZlbHDm1hKkORgsj3ZeZMy0uNAc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-OTt2Ih69MC6bH2Ke8Hod4g-1; Thu, 09 Jan 2020 11:07:01 -0500
X-MC-Unique: OTt2Ih69MC6bH2Ke8Hod4g-1
Received: by mail-wr1-f71.google.com with SMTP id z14so3076282wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Xq2TYaoyKIaoZWWIj0lFf3WygPVLaBw/8+8QDSMChc=;
        b=LR5XJAeLrUQKA3s1tjjtTufT9z619XP63hFwxnMSagfy4QrAug4UVoe+UXcxTh+35X
         HZjivZNtBO6R8aSaxQfA7CpxdsTnDNiuKg8k9UDTBCTW7qZM8d7l8bfq8eD1qFGcDlQP
         bj3H6BxffL3Nolw1t+AExf3CZETI7Qp87Lh8JhyBdkITYW1M78bV7vXQfIKOLu1Yfvre
         yX/MCSf29dbMpph7K4ywXsKnpB8aCK8j3Y9anWmtXAfJct7aJIovBgNSmMS364ctrOye
         ZOvDPYZoGk5cugGiVzmKkv8i0I89syCG1m9tvmlev7pPgiB0UEV+e3WulSBHP4FicUaT
         UZRg==
X-Gm-Message-State: APjAAAXifzSVjV2MUoZgao3nzlAZZOQ9Gw0ovNgVtS8vhAVkJjywRD5u
        IYSPXZf0yC1JefhiNnk7vtR2rMJKvDWKp4KHYa17OJCQU/1jkuzl7h3t3+C7gWfWsfLpWT+wJRu
        S9isNSdj4aTjH0n+uYyB75cIB
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr5725791wmo.123.1578586019459;
        Thu, 09 Jan 2020 08:06:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLoKJ+701qFfHV+IuL6JMCP1wXVIvF4aCLPHBdRsPum7P4wPgdei+sohgHerHSdwvNMk0qxA==
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr5725754wmo.123.1578586019116;
        Thu, 09 Jan 2020 08:06:59 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id q3sm9123252wrn.33.2020.01.09.08.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:06:58 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 30/57] objtool: arm64: Decode basic load/stores
Date:   Thu,  9 Jan 2020 16:02:33 +0000
Message-Id: <20200109160300.26150-31-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode load/store instructions for single register, using an immediate
offset for the target address.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 396 ++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  23 +
 2 files changed, 419 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index bf9334451b40..7064302416f4 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -86,8 +86,12 @@ static arm_decode_class aarch64_insn_class_decode_table[NR_INSN_CLASS] = {
 	[INSN_RESERVED]			= arm_decode_unknown,
 	[INSN_UNKNOWN]			= arm_decode_unknown,
 	[INSN_UNALLOC]			= arm_decode_unknown,
+	[INSN_LD_ST_4]			= arm_decode_ld_st,
+	[INSN_LD_ST_6]			= arm_decode_ld_st,
 	[0b1000 ... INSN_DP_IMM]	= arm_decode_dp_imm,
 	[0b1010 ... INSN_SYS_BRANCH]	= arm_decode_br_sys,
+	[INSN_LD_ST_C]			= arm_decode_ld_st,
+	[INSN_LD_ST_E]			= arm_decode_ld_st,
 };
 
 /*
@@ -804,3 +808,395 @@ int arm_decode_br_uncond_reg(u32 instr, enum insn_type *type,
 
 #undef INSN_DRPS_FIELD
 #undef INSN_DRPS_MASK
+
+static struct aarch64_insn_decoder ld_st_decoder[] = {
+	{
+		.mask = 0b001101010000011,
+		.value = 0b001100000000000,
+		.decode_func = arm_decode_ld_st_regs_unsc_imm,
+	},
+	{
+		.mask = 0b001101010000011,
+		.value = 0b001100000000001,
+		.decode_func = arm_decode_ld_st_imm_post,
+	},
+	{
+		.mask = 0b001101010000011,
+		.value = 0b001100000000010,
+		.decode_func = arm_decode_ld_st_imm_unpriv,
+	},
+	{
+		.mask = 0b001101010000011,
+		.value = 0b001100000000011,
+		.decode_func = arm_decode_ld_st_imm_pre,
+	},
+	{
+		.mask = 0b001101000000000,
+		.value = 0b001101000000000,
+		.decode_func = arm_decode_ld_st_regs_unsigned,
+	},
+};
+
+int arm_decode_ld_st(u32 instr, enum insn_type *type,
+		     unsigned long *immediate, struct list_head *ops_list)
+{
+	u32 decode_field = 0;
+	int i = 0;
+	unsigned char op0 = 0, op1 = 0, op2 = 0, op3 = 0, op4 = 0;
+
+	op0 = (instr >> 28) & ONES(4);
+	op1 = EXTRACT_BIT(instr, 26);
+	op2 = (instr >> 23) & ONES(2);
+	op3 = (instr >> 16) & ONES(6);
+	op4 = (instr >> 10) & ONES(2);
+	decode_field = (op0 << 3) | (op1 << 2) | op2;
+	decode_field = (decode_field << 8) | (op3 << 2) | op4;
+
+	for (i = 0; i < ARRAY_SIZE(ld_st_decoder); i++) {
+		if ((decode_field & ld_st_decoder[i].mask) ==
+		    ld_st_decoder[i].value) {
+			return ld_st_decoder[i].decode_func(instr,
+							    type,
+							    immediate,
+							    ops_list);
+		}
+	}
+	return arm_decode_unknown(instr, type, immediate, ops_list);
+}
+
+int arm_decode_ld_st_regs_unsc_imm(u32 instr, enum insn_type *type,
+				   unsigned long *immediate,
+				   struct list_head *ops_list)
+{
+	u32 imm9 = 0;
+	unsigned char size = 0, V = 0, opc = 0, rn = 0, rt = 0;
+	unsigned char decode_field = 0;
+	struct stack_op *op;
+
+	size = (instr >> 30) & ONES(2);
+	V = EXTRACT_BIT(instr, 26);
+	opc = (instr >> 22) & ONES(2);
+
+	imm9 = (instr >> 12) & ONES(9);
+	rn = (instr >> 5) & ONES(5);
+	rt = instr & ONES(5);
+
+	decode_field = (size << 2) | (V << 2) | opc;
+
+	switch (decode_field) {
+	case 0b01110:
+	case 0b01111:
+	case 0b11110:
+	case 0b11111:
+	case 0b10011:
+	case 0b11011:
+	case 0b10110:
+	case 0b10111:
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+	case 26:
+		/* prefetch */
+		*type = INSN_OTHER;
+		return 0;
+	case 1:
+	case 2:
+	case 3:
+	case 5:
+	case 7:
+	case 9:
+	case 10:
+	case 11:
+	case 13:
+	case 17:
+	case 18:
+	case 21:
+	case 25:
+	case 29:
+		/* load */
+		if (!stack_related_reg(rn)) {
+			*type = INSN_OTHER;
+			return 0;
+		}
+
+		op = calloc(1, sizeof(*op));
+		list_add_tail(&op->list, ops_list);
+
+		op->src.type = OP_SRC_REG_INDIRECT;
+		op->src.reg = rn;
+		op->src.offset = SIGN_EXTEND(imm9, 9);
+		op->dest.type = OP_DEST_REG;
+		op->dest.reg = rt;
+		op->dest.offset = 0;
+		break;
+	default:
+		if (!stack_related_reg(rn)) {
+			*type = INSN_OTHER;
+			return 0;
+		}
+
+		op = calloc(1, sizeof(*op));
+		list_add_tail(&op->list, ops_list);
+
+		op->dest.type = OP_DEST_REG_INDIRECT;
+		op->dest.reg = rn;
+		op->dest.offset = SIGN_EXTEND(imm9, 9);
+		op->src.type = OP_DEST_REG;
+		op->src.reg = rt;
+		op->src.offset = 0;
+		break;
+	}
+
+	*type = INSN_STACK;
+	return 0;
+}
+
+static struct aarch64_insn_decoder ld_unsig_unalloc_decoder[] = {
+	{
+		.mask = 0b01110,
+		.value = 0b01110,
+	},
+	{
+		.mask = 0b10111,
+		.value = 0b10011,
+	},
+	{
+		.mask = 0b10110,
+		.value = 0b10110,
+	},
+};
+
+int arm_decode_ld_st_regs_unsigned(u32 instr, enum insn_type *type,
+				   unsigned long *immediate,
+				   struct list_head *ops_list)
+{
+	unsigned char size = 0, V = 0, opc = 0, rn = 0, rt = 0;
+	unsigned char decode_field = 0;
+	struct stack_op *op;
+	u32 imm12 = 0;
+	int i = 0;
+
+	size = (instr >> 30) & ONES(2);
+	V = EXTRACT_BIT(instr, 26);
+	opc = (instr >> 22) & ONES(2);
+
+	decode_field = (size << 3) | (V << 2) | opc;
+	for (i = 0; i < ARRAY_SIZE(ld_unsig_unalloc_decoder); i++) {
+		if ((decode_field & ld_unsig_unalloc_decoder[i].mask) ==
+		    ld_unsig_unalloc_decoder[i].value) {
+			return arm_decode_unknown(instr, type,
+						immediate, ops_list);
+		}
+	}
+
+	imm12 = (instr >> 10) & ONES(12);
+	rn = (instr >> 5) & ONES(5);
+	rt = instr & ONES(5);
+
+	if (!stack_related_reg(rn) || decode_field == 26) {
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
+	case 2:
+	case 3:
+	case 5:
+	case 7:
+	case 9:
+	case 10:
+	case 11:
+	case 13:
+	case 17:
+	case 18:
+	case 21:
+	case 25:
+		/* load */
+		op->src.type = OP_SRC_REG_INDIRECT;
+		op->src.reg = rn;
+		op->src.offset = imm12;
+		op->dest.type = OP_DEST_REG;
+		op->dest.reg = rt;
+		op->dest.offset = 0;
+		break;
+	default: /* store */
+		op->dest.type = OP_DEST_REG_INDIRECT;
+		op->dest.reg = rn;
+		op->dest.offset = imm12;
+		op->src.type = OP_DEST_REG;
+		op->src.reg = rt;
+		op->src.offset = 0;
+	}
+
+	return 0;
+}
+
+int arm_decode_ld_st_imm_post(u32 instr, enum insn_type *type,
+			      unsigned long *immediate,
+			      struct list_head *ops_list)
+{
+	unsigned char size = 0, V = 0, opc = 0;
+	unsigned char decode_field = 0;
+	struct stack_op *op;
+	struct stack_op *post_inc;
+	int base_reg;
+	u32 imm9 = 0;
+	int ret = 0;
+
+	size = (instr >> 30) & ONES(2);
+	V = EXTRACT_BIT(instr, 26);
+	opc = (instr >> 22) & ONES(2);
+
+	imm9 = (instr >> 12) & ONES(9);
+
+	decode_field = (size << 2) | (V << 2) | opc;
+
+	if (decode_field == 0b11010)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	ret = arm_decode_ld_st_regs_unsigned(instr, type, immediate, ops_list);
+	if (ret < 0 || *type == INSN_OTHER)
+		return ret;
+
+	op = list_first_entry(ops_list, typeof(*op), list);
+	if (op->dest.type == OP_DEST_REG_INDIRECT) {
+		base_reg = op->dest.reg;
+		op->dest.offset = 0;
+	} else if (op->src.type == OP_SRC_REG_INDIRECT) {
+		base_reg = op->src.reg;
+		op->src.offset = 0;
+	} else {
+		WARN("Cannot find stack op base");
+		return -1;
+	}
+
+	post_inc = malloc(sizeof(*post_inc));
+	post_inc->dest.type = OP_DEST_REG;
+	post_inc->dest.reg = base_reg;
+	post_inc->src.reg = base_reg;
+	post_inc->src.type = OP_SRC_ADD;
+	post_inc->src.offset = SIGN_EXTEND(imm9, 9);
+
+	list_add_tail(&post_inc->list, ops_list);
+
+	return 0;
+}
+
+int arm_decode_ld_st_imm_pre(u32 instr, enum insn_type *type,
+			     unsigned long *immediate,
+			     struct list_head *ops_list)
+{
+	unsigned char size = 0, V = 0, opc = 0;
+	unsigned char decode_field = 0;
+	struct stack_op *op;
+	struct stack_op *pre_inc;
+	int base_reg;
+	u32 imm9 = 0;
+	int ret = 0;
+
+	size = (instr >> 30) & ONES(2);
+	V = EXTRACT_BIT(instr, 26);
+	opc = (instr >> 22) & ONES(2);
+
+	imm9 = (instr >> 12) & ONES(9);
+
+	decode_field = (size << 2) | (V << 2) | opc;
+
+	if (decode_field == 0b11010)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	ret = arm_decode_ld_st_regs_unsigned(instr, type, immediate, ops_list);
+	if (ret < 0 || *type == INSN_OTHER)
+		return ret;
+
+	op = list_first_entry(ops_list, typeof(*op), list);
+	if (op->dest.type == OP_DEST_REG_INDIRECT) {
+		base_reg = op->dest.reg;
+		op->dest.offset = 0;
+	} else if (op->src.type == OP_SRC_REG_INDIRECT) {
+		base_reg = op->src.reg;
+		op->src.offset = 0;
+	} else {
+		WARN("Cannot find stack op base");
+		return -1;
+	}
+
+	pre_inc = malloc(sizeof(*pre_inc));
+	pre_inc->dest.type = OP_DEST_REG;
+	pre_inc->dest.reg = base_reg;
+	pre_inc->src.reg = base_reg;
+	pre_inc->src.type = OP_SRC_ADD;
+	pre_inc->src.offset = SIGN_EXTEND(imm9, 9);
+
+	list_add(&pre_inc->list, ops_list);
+
+	return 0;
+}
+
+#define LD_UNPR_UNALLOC_1 0b10011
+#define LD_UNPR_UNALLOC_2 0b11010
+int arm_decode_ld_st_imm_unpriv(u32 instr, enum insn_type *type,
+				unsigned long *immediate,
+				struct list_head *ops_list)
+{
+	unsigned char size = 0, V = 0, opc = 0, rn = 0, rt = 0;
+	unsigned char decode_field = 0;
+	struct stack_op *op;
+	u32 imm9 = 0;
+
+	size = (instr >> 30) & ONES(2);
+	V = EXTRACT_BIT(instr, 26);
+	opc = (instr >> 22) & ONES(2);
+
+	imm9 = (instr >> 12) & ONES(9);
+
+	decode_field = (size << 3) | (V << 2) | opc;
+	if (V == 1 ||
+	    (decode_field & 0b10111) == LD_UNPR_UNALLOC_1 ||
+	    (decode_field & 0b11111) == LD_UNPR_UNALLOC_2) {
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+	}
+#undef LD_UNPR_UNALLOC_1
+#undef LD_UNPR_UNALLOC_2
+
+	if (!stack_related_reg(rn)) {
+		*type = INSN_OTHER;
+		return 0;
+	}
+	*type = INSN_STACK;
+	op = calloc(1, sizeof(*op));
+	list_add_tail(&op->list, ops_list);
+
+	switch (decode_field) {
+	case 1:
+	case 2:
+	case 3:
+	case 9:
+	case 10:
+	case 11:
+	case 17:
+	case 18:
+	case 25:
+		/* load */
+		op->src.type = OP_SRC_REG_INDIRECT;
+		op->src.reg = rn;
+		op->src.offset = SIGN_EXTEND(imm9, 9);
+		op->dest.type = OP_DEST_REG;
+		op->dest.reg = rt;
+		op->dest.offset = 0;
+		break;
+	default:
+		/* store */
+		op->dest.type = OP_DEST_REG_INDIRECT;
+		op->dest.reg = rn;
+		op->dest.offset = SIGN_EXTEND(imm9, 9);
+		op->src.type = OP_DEST_REG;
+		op->src.reg = rt;
+		op->src.offset = 0;
+		break;
+	}
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 6e600f408bea..1e031b12cf69 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -10,6 +10,10 @@
 #define INSN_UNALLOC	0b0011
 #define INSN_DP_IMM	0b1001	//0x100x
 #define INSN_SYS_BRANCH	0b1011	//0x101x
+#define INSN_LD_ST_4	0b0100	//0bx1x0
+#define INSN_LD_ST_6	0b0110	//0bx1x0
+#define INSN_LD_ST_C	0b1100	//0bx1x0
+#define INSN_LD_ST_E	0b1110	//0bx1x0
 
 #define NR_INSN_CLASS	16
 #define INSN_CLASS(opcode)	(((opcode) >> 25) & (NR_INSN_CLASS - 1))
@@ -37,6 +41,8 @@ int arm_decode_dp_imm(u32 instr, enum insn_type *type,
 		      unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_br_sys(u32 instr, enum insn_type *type,
 		      unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_ld_st(u32 instr, enum insn_type *type,
+		     unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_unknown(u32 instr, enum insn_type *type,
 		       unsigned long *immediate, struct list_head *ops_list);
 
@@ -86,4 +92,21 @@ int arm_decode_br_cond_imm(u32 instr, enum insn_type *type,
 int arm_decode_br_uncond_reg(u32 instr, enum insn_type *type,
 			     unsigned long *immediate,
 			     struct list_head *ops_list);
+
+/* arm64 load/store instructions */
+int arm_decode_ld_st_regs_unsc_imm(u32 instr, enum insn_type *type,
+				   unsigned long *immediate,
+				   struct list_head *ops_list);
+int arm_decode_ld_st_imm_post(u32 instr, enum insn_type *type,
+			      unsigned long *immediate,
+			      struct list_head *ops_list);
+int arm_decode_ld_st_imm_unpriv(u32 instr, enum insn_type *type,
+				unsigned long *immediate,
+				struct list_head *ops_list);
+int arm_decode_ld_st_imm_pre(u32 instr, enum insn_type *type,
+			     unsigned long *immediate,
+			     struct list_head *ops_list);
+int arm_decode_ld_st_regs_unsigned(u32 instr, enum insn_type *type,
+				   unsigned long *immediate,
+				   struct list_head *ops_list);
 #endif /* _ARM_INSN_DECODE_H */
-- 
2.21.0

