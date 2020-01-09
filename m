Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C2EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321742072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZsXooKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgAIQIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:08:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41935 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733237AbgAIQIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZBv8vu7vm5b/St4SQhnQrbm+mPlTxzkdMK/VqAAC9ps=;
        b=CZsXooKQTQypAJeW7JRoWTbb/9XzSX72FWp7tk9L0+VjTC0OT8dL4zmPQ8oQPKeP+bll7j
        /Fpliey2bAt8gtJR+UVZaYzeIyXUO6/mjN4gczsFiKRa3tG5O0oRUljfxwd/uKuEEdH3rD
        VCaOvsb+bukj023ROsDWgl7/KY/5jPM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-f1rzRKLoNeqCq3sffp4KIg-1; Thu, 09 Jan 2020 11:08:17 -0500
X-MC-Unique: f1rzRKLoNeqCq3sffp4KIg-1
Received: by mail-wm1-f69.google.com with SMTP id c4so1095663wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZBv8vu7vm5b/St4SQhnQrbm+mPlTxzkdMK/VqAAC9ps=;
        b=VVqe1LRjvm/ZeTkMcPhfD9iFmuyzK58SlmqyfJZG4ARHH9EQbYe8KQrrUx7mltW14i
         4GcpK+9O83S9sqyluOfxyi9dSWy1v5Sb5oIgEK8sn1fs7Gbt4ZQQTLdcJ+rZBAQ23fCA
         5xqfuJDZO5GdE9zm7Xk1dRcox0PhtaRtdJq1pwcqFGOp5Yea4FL1XxhXAvZ19X7mf5Px
         TH7bImO67HL6wvDJXU94oN78WabI7Kzs8gDN4YdTQarzqiF+95+E5NgLokv/qmmDBgwR
         2VDliG4TSgaCh8sZFeE4mrKVV2rkl2vIL3qx5PJcc+Xp9zNQzqEKu/57UZ77bGGFoxfF
         fSNg==
X-Gm-Message-State: APjAAAXo+yWPaJplKh/bHZ1ZD2XfYJjE9yh7Pw2iU7n7Sl+jLbRdJIzv
        GWhRfSz/sI9N14rtCpkVTrxI8Kf9dSeCSSL/9tX0q8jqK+gAHowRGGa9L/7O6qVC5dBej8H5OYF
        1HDeJxx9sjMnuMmDyA4VgNjdO
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr5553861wmc.165.1578586096235;
        Thu, 09 Jan 2020 08:08:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEpPRHZehtfPC+YY7nOMjooKnEIZisD06WTX2HlS6iQAPTRamE7Xul8iV+xsBwYHmGFnVQRw==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr5553822wmc.165.1578586095790;
        Thu, 09 Jan 2020 08:08:15 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id m10sm8562605wrx.19.2020.01.09.08.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:08:15 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 40/57] objtool: arm64: Decode register data processing instructions
Date:   Thu,  9 Jan 2020 16:02:43 +0000
Message-Id: <20200109160300.26150-41-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode data processing instructions with more than one register as
input operand.
Due to these multiple register inputs, objtool cannot rely on those
instructions to track the CFA state. Luckily, the compiler does not tend
to generate these instructions to modify the stack or frame pointer.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 471 ++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |  42 ++
 2 files changed, 513 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index aed8ba0f812e..bb1ba3b0997f 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -128,10 +128,12 @@ static arm_decode_class aarch64_insn_class_decode_table[NR_INSN_CLASS] = {
 	[INSN_UNKNOWN]			= arm_decode_unknown,
 	[INSN_UNALLOC]			= arm_decode_unknown,
 	[INSN_LD_ST_4]			= arm_decode_ld_st,
+	[INSN_DP_REG_5]			= arm_decode_dp_reg,
 	[INSN_LD_ST_6]			= arm_decode_ld_st,
 	[0b1000 ... INSN_DP_IMM]	= arm_decode_dp_imm,
 	[0b1010 ... INSN_SYS_BRANCH]	= arm_decode_br_sys,
 	[INSN_LD_ST_C]			= arm_decode_ld_st,
+	[INSN_DP_REG_D]			= arm_decode_dp_reg,
 	[INSN_LD_ST_E]			= arm_decode_ld_st,
 };
 
@@ -2275,3 +2277,472 @@ int arm_decode_ld_st_mem_tags(u32 instr, enum insn_type *type,
 
 	return -1;
 }
+
+static struct aarch64_insn_decoder dp_reg_decoder[] = {
+	{
+		.mask = 0b111111000000,
+		.value = 0b010110000000,
+		.decode_func = arm_decode_dp_reg_2src,
+	},
+	{
+		.mask = 0b111111000000,
+		.value = 0b110110000000,
+		.decode_func = arm_decode_dp_reg_1src,
+	},
+	{
+		.mask = 0b011000000000,
+		.value = 0b000000000000,
+		.decode_func = arm_decode_dp_reg_logi,
+	},
+	{
+		.mask = 0b011001000000,
+		.value = 0b001000000000,
+		.decode_func = arm_decode_dp_reg_adds,
+	},
+	{
+		.mask = 0b011001000000,
+		.value = 0b001001000000,
+		.decode_func = arm_decode_dp_reg_adde,
+	},
+	{
+		.mask = 0b011111111111,
+		.value = 0b010000000000,
+		.decode_func = arm_decode_dp_reg_addc,
+	},
+	{
+		.mask = 0b011111011111,
+		.value = 0b010000000001,
+		.decode_func = arm_decode_dp_reg_rota,
+	},
+	{
+		.mask = 0b011111001111,
+		.value = 0b010000000010,
+		.decode_func = arm_decode_dp_reg_eval,
+	},
+	{
+		.mask = 0b011111000010,
+		.value = 0b010010000000,
+		.decode_func = arm_decode_dp_reg_cmpr,
+	},
+	{
+		.mask = 0b011111000010,
+		.value = 0b010010000010,
+		.decode_func = arm_decode_dp_reg_cmpi,
+	},
+	{
+		.mask = 0b011111000000,
+		.value = 0b010100000000,
+		.decode_func = arm_decode_dp_reg_csel,
+	},
+	{
+		.mask = 0b011000000000,
+		.value = 0b011000000000,
+		.decode_func = arm_decode_dp_reg_3src,
+	},
+};
+
+int arm_decode_dp_reg(u32 instr, enum insn_type *type,
+		      unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char op0 = 0, op1 = 0, op2 = 0, op3 = 0;
+	u32 decode_field = 0;
+	int i = 0;
+
+	op0 = EXTRACT_BIT(instr, 30);
+	op1 = EXTRACT_BIT(instr, 28);
+	op2 = (instr >> 21) & ONES(4);
+	op3 = (instr >> 10) & ONES(6);
+	decode_field = (op0 << 5) | (op1 << 4) | op2;
+	decode_field = (decode_field << 6) | op3;
+
+	for (i = 0; i < ARRAY_SIZE(dp_reg_decoder); i++) {
+		if ((decode_field & dp_reg_decoder[i].mask) ==
+		    dp_reg_decoder[i].value) {
+			return dp_reg_decoder[i].decode_func(instr, type,
+							immediate, ops_list);
+		}
+	}
+	return arm_decode_unknown(instr, type, immediate, ops_list);
+}
+
+static struct aarch64_insn_decoder dp_reg_2src_decoder[] = {
+	{
+		.mask = 0b00111111,
+		.value = 0b00000001,
+	},
+	{
+		.mask = 0b00111000,
+		.value = 0b00011000,
+	},
+	{
+		.mask = 0b00100000,
+		.value = 0b00100000,
+	},
+	{
+		.mask = 0b01111111,
+		.value = 0b00000101,
+	},
+	{
+		.mask = 0b01111100,
+		.value = 0b00001100,
+	},
+	{
+		.mask = 0b01111110,
+		.value = 0b01000010,
+	},
+	{
+		.mask = 0b01111100,
+		.value = 0b01000100,
+	},
+	{
+		.mask = 0b01111000,
+		.value = 0b01001000,
+	},
+	{
+		.mask = 0b01110000,
+		.value = 0b01010000,
+	},
+	{
+		.mask = 0b10111111,
+		.value = 0b00000000,
+	},
+	{
+		.mask = 0b11111111,
+		.value = 0b00000100,
+	},
+	{
+		.mask = 0b11111110,
+		.value = 0b00000110,
+	},
+	{
+		.mask = 0b11111011,
+		.value = 0b00010011,
+	},
+	{
+		.mask = 0b11111001,
+		.value = 0b10010000,
+	},
+	{
+		.mask = 0b11111010,
+		.value = 0b10010000,
+	},
+};
+
+int arm_decode_dp_reg_2src(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char sf = 0, S = 0, opcode = 0;
+	unsigned char decode_field = 0;
+	int i = 0;
+
+	sf = EXTRACT_BIT(instr, 31);
+	S = EXTRACT_BIT(instr, 29);
+	opcode = (instr >> 10) & ONES(6);
+
+	decode_field = (sf << 7) | (S << 6) | opcode;
+
+	for (i = 0; i < ARRAY_SIZE(dp_reg_2src_decoder); i++) {
+		if ((decode_field & dp_reg_2src_decoder[i].mask) ==
+		    dp_reg_2src_decoder[i].value) {
+			return arm_decode_unknown(instr, type, immediate,
+						  ops_list);
+		}
+	}
+
+	*type = INSN_OTHER;
+	return 0;
+}
+
+static struct aarch64_insn_decoder dp_reg_1src_decoder[] = {
+	{
+		.mask = 0b0000000001000,
+		.value = 0b0000000001000,
+	},
+	{
+		.mask = 0b0000000010000,
+		.value = 0b0000000010000,
+	},
+	{
+		.mask = 0b0000000100000,
+		.value = 0b0000000100000,
+	},
+	{
+		.mask = 0b0000001000000,
+		.value = 0b0000001000000,
+	},
+	{
+		.mask = 0b0000010000000,
+		.value = 0b0000010000000,
+	},
+	{
+		.mask = 0b0000100000000,
+		.value = 0b0000100000000,
+	},
+	{
+		.mask = 0b0001000000000,
+		.value = 0b0001000000000,
+	},
+	{
+		.mask = 0b0010000000000,
+		.value = 0b0010000000000,
+	},
+	{
+		.mask = 0b0111111111110,
+		.value = 0b0000000000110,
+	},
+	{
+		.mask = 0b0100000000000,
+		.value = 0b0100000000000,
+	},
+};
+
+int arm_decode_dp_reg_1src(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char sf = 0, S = 0, opcode2 = 0, opcode = 0;
+	u32 decode_field = 0;
+	int i = 0;
+
+	sf = EXTRACT_BIT(instr, 31);
+	S = EXTRACT_BIT(instr, 29);
+	opcode2 = (instr >> 16) & ONES(5);
+	opcode = (instr >> 10) & ONES(6);
+
+	decode_field = (sf << 6) | (S << 5) | opcode2;
+	decode_field = (decode_field << 6) | opcode;
+
+	for (i = 0; i < ARRAY_SIZE(dp_reg_1src_decoder); i++) {
+		if ((decode_field & dp_reg_1src_decoder[i].mask) ==
+		    dp_reg_1src_decoder[i].value) {
+			return arm_decode_unknown(instr, type, immediate,
+						  ops_list);
+		}
+	}
+	*type = INSN_OTHER;
+	return 0;
+}
+
+int arm_decode_dp_reg_logi(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char sf = 0, imm6 = 0;
+
+	sf = EXTRACT_BIT(instr, 31);
+	imm6 = (instr >> 10) & ONES(6);
+
+	if (imm6 >= 0b100000 && !sf)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	*type = INSN_OTHER;
+	return 0;
+}
+
+int arm_decode_dp_reg_adds(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char sf = 0, shift = 0, imm6 = 0;
+
+	sf = EXTRACT_BIT(instr, 31);
+	shift = (instr >> 22) & ONES(2);
+	imm6 = (instr >> 10) & ONES(6);
+
+	if ((imm6 >= 0b100000 && !sf) || shift == 0b11)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	*type = INSN_OTHER;
+	return 0;
+}
+
+int arm_decode_dp_reg_adde(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char opt = 0, imm3 = 0;
+
+	opt = (instr >> 22) & ONES(2);
+	imm3 = (instr >> 10) & ONES(3);
+
+	if (opt != 0 || imm3 >= 0b101)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	*type = INSN_OTHER;
+	return 0;
+}
+
+int arm_decode_dp_reg_addc(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	*type = INSN_OTHER;
+	return 0;
+}
+
+int arm_decode_dp_reg_rota(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char sf = 0, S = 0, op_bit = 0, o2 = 0;
+	unsigned char decode_field = 0;
+
+	sf = EXTRACT_BIT(instr, 31);
+	op_bit = EXTRACT_BIT(instr, 30);
+	S = EXTRACT_BIT(instr, 29);
+	o2 = EXTRACT_BIT(instr, 4);
+
+	decode_field = (sf << 3) | (op_bit << 2) | (S << 1) | o2;
+
+	if (decode_field != 0b1010)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	*type = INSN_OTHER;
+	return 0;
+}
+
+int arm_decode_dp_reg_eval(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char sf = 0, S = 0, op_bit = 0, o3 = 0, sz = 0;
+	unsigned char opcode2 = 0, mask = 0;
+	u32 decode_field = 0;
+
+	sf = EXTRACT_BIT(instr, 31);
+	op_bit = EXTRACT_BIT(instr, 30);
+	S = EXTRACT_BIT(instr, 29);
+	sz = EXTRACT_BIT(instr, 14);
+	o3 = EXTRACT_BIT(instr, 4);
+
+	opcode2 = (instr >> 15) & ONES(6);
+	mask = instr & ONES(4);
+
+	decode_field = (sf << 2) | (op_bit << 1) | S;
+	decode_field = (decode_field << 12) | (opcode2 << 6) | (sz << 5);
+	decode_field |= (o3 << 4) | mask;
+
+#define DP_EVAL_SETF_1	0b001000000001101
+#define DP_EVAL_SETF_2	0b001000000101101
+
+	if (decode_field != DP_EVAL_SETF_1 &&
+	    decode_field != DP_EVAL_SETF_2) {
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+	}
+
+	*type = INSN_OTHER;
+	return 0;
+#undef DP_EVAL_SETF_1
+#undef DP_EVAL_SETF_2
+}
+
+int arm_decode_dp_reg_cmpr(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char S = 0, o2 = 0, o3 = 0;
+
+	S = EXTRACT_BIT(instr, 29);
+	o2 = EXTRACT_BIT(instr, 10);
+	o3 = EXTRACT_BIT(instr, 4);
+
+	if (!S || o2 || o3)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	*type = INSN_OTHER;
+	return 0;
+}
+
+int arm_decode_dp_reg_csel(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char S = 0, op2 = 0;
+
+	S = EXTRACT_BIT(instr, 29);
+	op2 = (instr >> 10) & ONES(2);
+
+	if (S || op2 >= 0b10)
+		return arm_decode_unknown(instr, type, immediate, ops_list);
+
+	*type = INSN_OTHER;
+	return 0;
+}
+
+int arm_decode_dp_reg_cmpi(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	return arm_decode_dp_reg_cmpr(instr, type, immediate, ops_list);
+}
+
+static struct aarch64_insn_decoder dp_reg_3src_decoder[] = {
+	{
+		.mask = 0b0111111,
+		.value = 0b0000101,
+	},
+	{
+		.mask = 0b0111110,
+		.value = 0b0000110,
+	},
+	{
+		.mask = 0b0111110,
+		.value = 0b0001000,
+	},
+	{
+		.mask = 0b0111111,
+		.value = 0b0001101,
+	},
+	{
+		.mask = 0b0111110,
+		.value = 0b0001110,
+	},
+	{
+		.mask = 0b0110000,
+		.value = 0b0010000,
+	},
+	{
+		.mask = 0b0100000,
+		.value = 0b0100000,
+	},
+	{
+		.mask = 0b1111111,
+		.value = 0b0000010,
+	},
+	{
+		.mask = 0b1111111,
+		.value = 0b0000011,
+	},
+	{
+		.mask = 0b1111111,
+		.value = 0b0000100,
+	},
+	{
+		.mask = 0b1111111,
+		.value = 0b0001010,
+	},
+	{
+		.mask = 0b1111111,
+		.value = 0b0001011,
+	},
+	{
+		.mask = 0b1111111,
+		.value = 0b0001100,
+	},
+};
+
+int arm_decode_dp_reg_3src(u32 instr, enum insn_type *type,
+			   unsigned long *immediate, struct list_head *ops_list)
+{
+	unsigned char sf = 0, op54 = 0, op31 = 0, o0 = 0;
+	unsigned char decode_field = 0;
+	int i = 0;
+
+	sf = EXTRACT_BIT(instr, 31);
+	op54 = (instr >> 29) & ONES(2);
+	op31 = (instr >> 21) & ONES(3);
+	o0 = EXTRACT_BIT(instr, 15);
+
+	decode_field = (sf << 6) | (op54 << 4) | (op31 << 1) | o0;
+
+	for (i = 0; i < ARRAY_SIZE(dp_reg_3src_decoder); i++) {
+		if ((decode_field & dp_reg_3src_decoder[i].mask) ==
+		    dp_reg_3src_decoder[i].value) {
+			return arm_decode_unknown(instr, type, immediate,
+						  ops_list);
+		}
+	}
+
+	*type = INSN_OTHER;
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 3ec4c69547ac..8fb2f2b7564f 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -14,6 +14,8 @@
 #define INSN_LD_ST_6	0b0110	//0bx1x0
 #define INSN_LD_ST_C	0b1100	//0bx1x0
 #define INSN_LD_ST_E	0b1110	//0bx1x0
+#define INSN_DP_REG_5	0b0101	//0bx101
+#define INSN_DP_REG_D	0b1101	//0bx101
 
 #define NR_INSN_CLASS	16
 #define INSN_CLASS(opcode)	(((opcode) >> 25) & (NR_INSN_CLASS - 1))
@@ -39,6 +41,8 @@ struct aarch64_insn_decoder {
 /* arm64 instruction classes */
 int arm_decode_dp_imm(u32 instr, enum insn_type *type,
 		      unsigned long *immediate, struct list_head *ops_list);
+int arm_decode_dp_reg(u32 instr, enum insn_type *type,
+		      unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_br_sys(u32 instr, enum insn_type *type,
 		      unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_ld_st(u32 instr, enum insn_type *type,
@@ -153,4 +157,42 @@ int arm_decode_ld_st_regs_unsigned(u32 instr, enum insn_type *type,
 int arm_decode_ld_st_exclusive(u32 instr, enum insn_type *type,
 			       unsigned long *immediate,
 			       struct list_head *ops_list);
+
+/* arm64 data processing -- registers instructions */
+int arm_decode_dp_reg_1src(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_dp_reg_2src(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_dp_reg_3src(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_dp_reg_adde(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_dp_reg_cmpi(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_dp_reg_eval(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_dp_reg_cmpr(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_dp_reg_rota(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_dp_reg_csel(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_dp_reg_addc(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_dp_reg_adds(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
+int arm_decode_dp_reg_logi(u32 instr, enum insn_type *type,
+			   unsigned long *immediate,
+			   struct list_head *ops_list);
 #endif /* _ARM_INSN_DECODE_H */
-- 
2.21.0

