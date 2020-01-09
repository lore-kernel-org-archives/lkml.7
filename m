Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2772C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A63C20661
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0UYF3ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbgAIQI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:08:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37398 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731574AbgAIQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578586102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNAXbPtYol4IFhdKQN1YW+us8aGhYHcAVGnDfkl/GLg=;
        b=O0UYF3irk3kYI2LNDbueoKcYnK/gbohCSJlXR0pm72g6jtxKX2dBSnDJw39qkWB8yH3RiA
        GMDaCQw0LLzFm8QP+JBh/7OjsOLe6R8ZmOra3eOmj4PboXHZ1pD1ljFi553M7KTkRNTYO7
        cQRYNAU5ZsMZJrUipbpcXtlf983+xmw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-DYFj-dCDMxuASrjN03OkmQ-1; Thu, 09 Jan 2020 11:08:20 -0500
X-MC-Unique: DYFj-dCDMxuASrjN03OkmQ-1
Received: by mail-wm1-f72.google.com with SMTP id c4so1095736wmb.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNAXbPtYol4IFhdKQN1YW+us8aGhYHcAVGnDfkl/GLg=;
        b=M6lFUoNUZPIVPme68Q6C1BqSEvlLlMDXL5FgmTULWHxneYtw781ixRuNNNhifHhQv7
         iYbWLB5QvuMTNf+TdL3SueLZ4dak4mR41MkJ6JgDlmg4215kc9ApwExZp279OJO+E9P0
         IePK/QJyEhBqLqWWgvPPLNcfv3axouZFtsssRhTu9TOlbT0dSAP6z4j4qnpQZlXi8p9l
         CYxciHCtE0lyeDX28PFHSQAmgVF4VTc+4eJ1ZPSp2v2oOjWvRMOGVR0Ty+X3ekJbnF5k
         Q1O+kewM+Y4Qz2/2hIbKvU1D2+JqOQIny0IpmjOyeUvs7Bgg3iH5Ew43CMqe06n4HD2/
         cpjA==
X-Gm-Message-State: APjAAAX42yZgelqdGiowaY7Vrg+cYOg3kgE5ZPXrjIJ2RiYIjN3tqAJw
        QJvBM0vaOA7rmpNDqLoapMhwUMpY4SwTE7TbzyrSY4+mS4R6OvN8CKhrro6eKi3dQAx1kytxz9/
        EizfspAa0Na4p4P7kzHFOOpx1
X-Received: by 2002:a7b:c957:: with SMTP id i23mr5784654wml.49.1578586099469;
        Thu, 09 Jan 2020 08:08:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVETqaEKCmXpHz5yplDHZ/sfX5dJd+AzP3YinwYC57N0IL5r0ZPXWJGPR5IniwcSWePRIULw==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr5784636wml.49.1578586099286;
        Thu, 09 Jan 2020 08:08:19 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id m10sm8562605wrx.19.2020.01.09.08.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:08:18 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 42/57] objtool: arm64: Decode SVE instructions
Date:   Thu,  9 Jan 2020 16:02:45 +0000
Message-Id: <20200109160300.26150-43-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decode instructions from the SVE architecture extension.

These instructions do not modify the stack or frame pointer. Simply
acknowledge the corresponding opcodes are valid.

Suggested-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/arch/arm64/decode.c             | 109 ++++++++++++++++++
 .../objtool/arch/arm64/include/insn_decode.h  |   4 +
 2 files changed, 113 insertions(+)

diff --git a/tools/objtool/arch/arm64/decode.c b/tools/objtool/arch/arm64/decode.c
index d35c2b58d309..5a5f82b5cb81 100644
--- a/tools/objtool/arch/arm64/decode.c
+++ b/tools/objtool/arch/arm64/decode.c
@@ -126,6 +126,7 @@ static int is_arm64(struct elf *elf)
 static arm_decode_class aarch64_insn_class_decode_table[NR_INSN_CLASS] = {
 	[INSN_RESERVED]			= arm_decode_unknown,
 	[INSN_UNKNOWN]			= arm_decode_unknown,
+	[INSN_SVE_ENC]			= arm_decode_sve_encoding,
 	[INSN_UNALLOC]			= arm_decode_unknown,
 	[INSN_LD_ST_4]			= arm_decode_ld_st,
 	[INSN_DP_REG_5]			= arm_decode_dp_reg,
@@ -2755,3 +2756,111 @@ int arm_decode_dp_simd(u32 instr, enum insn_type *type,
 	*type = INSN_OTHER;
 	return 0;
 }
+
+static struct aarch64_insn_decoder sve_enc_decoder[] = {
+	{
+		.mask = 0b1111010000111000,
+		.value = 0b0000010000011000,
+	},
+	{
+		.mask = 0b1111110000111000,
+		.value = 0b0001110000000000,
+	},
+	{
+		.mask = 0b1111010000110000,
+		.value = 0b0011010000010000,
+	},
+	{
+		.mask = 0b1111011100111000,
+		.value = 0b0011010100101000,
+	},
+	{
+		.mask = 0b1111011000110000,
+		.value = 0b0011011000100000,
+	},
+	{
+		.mask = 0b1111010000100000,
+		.value = 0b0100000000100000,
+	},
+	{
+		.mask = 0b1111000000000000,
+		.value = 0b0101000000000000,
+	},
+	{
+		.mask = 0b1111011111111000,
+		.value = 0b0110000000101000,
+	},
+	{
+		.mask = 0b1111011111110000,
+		.value = 0b0110000000110000,
+	},
+	{
+		.mask = 0b1111011111100000,
+		.value = 0b0110000001100000,
+	},
+	{
+		.mask = 0b1111011110100000,
+		.value = 0b0110000010100000,
+	},
+	{
+		.mask = 0b1111011100100000,
+		.value = 0b0110000100100000,
+	},
+	{
+		.mask = 0b1111011000100000,
+		.value = 0b0110001000100000,
+	},
+	{
+		.mask = 0b1111010000110110,
+		.value = 0b0110010000000010,
+	},
+	{
+		.mask = 0b1111010000111111,
+		.value = 0b0110010000001001,
+	},
+	{
+		.mask = 0b1111010000111100,
+		.value = 0b0110010000001100,
+	},
+	{
+		.mask = 0b1111010000110000,
+		.value = 0b0110010000010000,
+	},
+	{
+		.mask = 0b1111010000100000,
+		.value = 0b0110010000100000,
+	},
+	{
+		.mask = 0b1111011100111100,
+		.value = 0b0111000100001000,
+	},
+};
+
+int arm_decode_sve_encoding(u32 instr, enum insn_type *type,
+			    unsigned long *immediate,
+			    struct list_head *ops_list)
+{
+	int i = 0;
+	unsigned char op0 = 0, op1 = 0, op2 = 0, op3 = 0;
+	u32 decode_field = 0;
+
+	op0 = (instr >> 29) & ONES(3);
+	op1 = (instr >> 23) & ONES(2);
+	op2 = (instr >> 17) & ONES(5);
+	op3 = (instr >> 10) & ONES(6);
+
+	decode_field = (op0 << 2) | op1;
+	decode_field = (decode_field << 5) | op2;
+	decode_field = (decode_field << 6) | op3;
+
+	for (i = 0; i < ARRAY_SIZE(sve_enc_decoder); i++) {
+		if ((decode_field & sve_enc_decoder[i].mask) ==
+		    sve_enc_decoder[i].value)
+			return arm_decode_unknown(instr, type, immediate,
+						  ops_list);
+	}
+
+	*type = INSN_OTHER;
+
+	return 0;
+}
diff --git a/tools/objtool/arch/arm64/include/insn_decode.h b/tools/objtool/arch/arm64/include/insn_decode.h
index 2bff4d7da007..89cff8791c0b 100644
--- a/tools/objtool/arch/arm64/include/insn_decode.h
+++ b/tools/objtool/arch/arm64/include/insn_decode.h
@@ -7,6 +7,7 @@
 
 #define INSN_RESERVED	0b0000
 #define INSN_UNKNOWN	0b0001
+#define INSN_SVE_ENC	0b0010
 #define INSN_UNALLOC	0b0011
 #define INSN_DP_IMM	0b1001	//0x100x
 #define INSN_SYS_BRANCH	0b1011	//0x101x
@@ -41,6 +42,9 @@ struct aarch64_insn_decoder {
 };
 
 /* arm64 instruction classes */
+int arm_decode_sve_encoding(u32 instr, enum insn_type *type,
+			    unsigned long *immediate,
+			    struct list_head *ops_list);
 int arm_decode_dp_imm(u32 instr, enum insn_type *type,
 		      unsigned long *immediate, struct list_head *ops_list);
 int arm_decode_dp_reg(u32 instr, enum insn_type *type,
-- 
2.21.0

